
echo ""
echo " ---------------------------------------------- "
echo "                VERSION RELEASE                 "
echo " ---------------------------------------------- "
echo ""

CURRENT_VERSION=$(cat goscan/Makefile | grep "VERSION :=" | cut -d ' ' -f 3)
TO_UPDATE=(
    README.md
    goscan/Makefile
)

read -p "[?] Did you remember to update CHANGELOG.md? "
read -p "[?] Did you remember to update README.md with new features/changes? "

printf "\n[*] Current version is $CURRENT_VERSION. Enter new version: "
read NEW_VERSION
printf "[+] New version selected: $NEW_VERSION\n"

printf "[*] Patching files in 5 seconds...\n\n"
sleep 5
for file in "${TO_UPDATE[@]}"
do
  printf "[*] Patching $file ...\n"
  sed -i "" "s/$CURRENT_VERSION/$NEW_VERSION/g" $file
  git add $file
done

read -p "[?] Did you remember to run make cross? " 

printf "[*] Pushing and tagging version $NEW_VERSION in 5 seconds...\n\n"
sleep 5
git commit -m "[v$NEW_VERSION] Version release"
git push

git tag -a v$NEW_VERSION -m "v$NEW_VERSION"
git push origin v$NEW_VERSION

echo "[*] All done, v$NEW_VERSION released\n"