import cv2
import numpy as np
import matplotlib.pyplot as plt
from math import log2
from mpl_toolkits.mplot3d import Axes3D

def plot_histogram(channel, title):
    plt.figure()
    plt.title(f"{title} - Histogram")
    plt.hist(channel.ravel(), bins=256, range=(0, 256), color='gray')
    plt.xlabel("Pixel Intensity")
    plt.ylabel("Frequency")
    plt.grid(True)
    plt.show()

def plot_3d_surface(channel, title):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    X = np.arange(channel.shape[1])
    Y = np.arange(channel.shape[0])
    X, Y = np.meshgrid(X, Y)
    ax.plot_surface(X, Y, channel, cmap='viridis')
    ax.set_title(f"{title} - 3D Surface")
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Intensity')
    plt.show()

def calculate_entropy(channel, title):
    hist, _ = np.histogram(channel.ravel(), bins=256, range=[0, 256], density=True)
    entropy = -np.sum([p * log2(p) for p in hist if p > 0])
    print(f"{title} - Entropy: {entropy:.4f}")
    return entropy

def calculate_correlation(channel, title):
    def correlation(pairs):
        if len(pairs) < 2:
            return 0
        x, y = zip(*pairs)
        return np.corrcoef(x, y)[0, 1]

    rows, cols = channel.shape
    img = channel.astype(np.float32)

    horizontal = [(img[i, j], img[i, j+1]) for i in range(rows) for j in range(cols - 1)]
    vertical = [(img[i, j], img[i+1, j]) for i in range(rows - 1) for j in range(cols)]
    diagonal = [(img[i, j], img[i+1, j+1]) for i in range(rows - 1) for j in range(cols - 1)]

    ch = correlation(horizontal)
    cv = correlation(vertical)
    cd = correlation(diagonal)

    print(f"{title} - Correlation Coefficients:")
    print(f"  Horizontal: {ch:.4f}")
    print(f"  Vertical:   {cv:.4f}")
    print(f"  Diagonal:   {cd:.4f}")

    def plot_corr(pairs, label):
        x, y = zip(*pairs)
        plt.figure()
        plt.title(f"{title} - {label} Correlation Scatter")
        plt.scatter(x, y, s=1, alpha=0.5)
        plt.xlabel("Pixel")
        plt.ylabel("Neighbor")
        plt.grid(True)
        plt.show()

    plot_corr(horizontal[::100], "Horizontal")
    plot_corr(vertical[::100], "Vertical")
    plot_corr(diagonal[::100], "Diagonal")

def npcr_uaci(original, cipher, title):
    if original.shape != cipher.shape:
        print("Image sizes do not match for NPCR/UACI.")
        return

    original = original.astype(np.uint8)
    cipher = cipher.astype(np.uint8)

    diff = original != cipher
    npcr = np.sum(diff) / diff.size * 100

    uaci = np.sum(np.abs(original - cipher) / 255.0) / diff.size * 100

    print(f"{title} - NPCR: {npcr:.2f}%, UACI: {uaci:.2f}%")

def analyze_channel(channel, label):
    plot_histogram(channel, label)
    plot_3d_surface(channel, label)
    calculate_entropy(channel, label)
    calculate_correlation(channel, label)

def analyze_image(cipher_path, original_path=None, enable_compare=False):
    cipher = cv2.imread(cipher_path)
    if cipher is None:
        print("❌ Failed to load cipher image.")
        return

    print(f"\n🔍 Analyzing Cipher Image: {cipher_path}")

    # Convert to grayscale or split channels
    if len(cipher.shape) == 2 or cipher.shape[2] == 1:
        gray = cipher if len(cipher.shape) == 2 else cipher[:, :, 0]
        analyze_channel(gray, "Grayscale")
        if enable_compare and original_path:
            orig = cv2.imread(original_path, cv2.IMREAD_GRAYSCALE)
            npcr_uaci(orig, gray, "Grayscale")
    else:
        b, g, r = cv2.split(cipher)
        if enable_compare and original_path:
            original = cv2.imread(original_path)
            if original is None:
                print("❌ Failed to load original image for comparison.")
                return
            bo, go, ro = cv2.split(original)
            channels = [("Red", r, ro), ("Green", g, go), ("Blue", b, bo)]
        else:
            channels = [("Red", r, None), ("Green", g, None), ("Blue", b, None)]

        for name, ch, orig_ch in channels:
            analyze_channel(ch, f"{name} Channel")
            if enable_compare and orig_ch is not None:
                npcr_uaci(orig_ch, ch, f"{name} Channel")

# Example usage:
# analyze_image("cipher.png")
# analyze_image("cipher.png", "original.png", enable_compare=True)
