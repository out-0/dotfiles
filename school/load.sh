cat <<EOF > ~/load.sh
#!/bin/bash
USB_VM="/media/aarid/ARCH_VM/ArchMe"
LOCAL_VM="\$HOME/goinfre/virtualbox/VMs/"

mkdir -p "\$LOCAL_VM"

if [ -d "\$USB_VM" ]; then
    echo "🚀 Loading VM from USB to Goinfre..."
    rsync -av --progress "\$USB_VM" "\$LOCAL_VM"
    echo "✅ Done! Open VirtualBox and 'Add' the .vbox file from Goinfre."
else
    echo "❌ Error: USB VM folder not found at \$USB_VM"
fi
EOF
chmod +x ~/load.sh
