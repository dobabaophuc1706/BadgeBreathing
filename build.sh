echo
echo "Create rootless package..."
echo

make clean
make package ROOTLESS=1 #Tạo rootless deb

echo
echo "Make package successful!"
echo

echo
echo "Create rootful package..."
echo

make clean
make package ROOTLESS=0 #Tạo rootful deb

echo
echo "Make package successful!"
echo