#!/bin/bash
set -e

# =============================================================================
#  Phoenix - macOS Bootstrap Script
# =============================================================================

echo "========================================="
echo "  Phoenix - macOS Setup"
echo "========================================="

# -----------------------------------------------------------------------------
# 1. Homebrew
# -----------------------------------------------------------------------------
if command -v brew &>/dev/null; then
  echo "[✓] Homebrew déjà installé"
else
  echo "[+] Installation de Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Ajouter brew au PATH pour la session courante
  if [[ "$(uname -m)" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

brew update

# -----------------------------------------------------------------------------
# 2. Oh My Zsh
# -----------------------------------------------------------------------------
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "[✓] Oh My Zsh déjà installé"
else
  echo "[+] Installation de Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# -----------------------------------------------------------------------------
# 3. Brew Casks (applications GUI)
# -----------------------------------------------------------------------------
echo ""
echo "[+] Installation des Casks..."

casks=(
  brave-browser
  discord
  ghostty
  mullvad-vpn
  utm
  visual-studio-code
  wireshark
)

for cask in "${casks[@]}"; do
  if brew list --cask "$cask" &>/dev/null; then
    echo "  [✓] $cask déjà installé"
  else
    echo "  [+] $cask..."
    brew install --cask "$cask"
  fi
done

# -----------------------------------------------------------------------------
# 4. Brew Formulae (CLI tools)
# -----------------------------------------------------------------------------
echo ""
echo "[+] Installation des formulae..."

formulae=(
  bat
  bettercap
  doggo
  dust
  ffuf
  fzf
  htop
  iperf3
  jq
  mtr
  nmap
  rust
  socat
  uv
  wireshark   # CLI (tshark)
  yq
)

for formula in "${formulae[@]}"; do
  if brew list "$formula" &>/dev/null; then
    echo "  [✓] $formula déjà installé"
  else
    echo "  [+] $formula..."
    brew install "$formula"
  fi
done

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "========================================="
echo "  Installation terminée !"
echo "========================================="
