cat <<EOF > ~/save.sh
#!/bin/bash
LOCAL_VM="\$HOME/goinfre/virtualbox/VMs/ArchMe"
USB_DEST="/media/aarid/ARCH_VM/"

if [ -d "\$LOCAL_VM" ]; then
    echo "🔄 Saving progress to USB... (Only copying changes)"
    rsync -av --delete --progress "\$LOCAL_VM" "\$USB_DEST"
    echo "💾 Finalizing write to stick..."
    sync
    echo "✅ Done! Safe to eject."
else
    echo "❌ Error: VM not found in Goinfre!"
fi
EOF
chmod +x ~/save.sh
