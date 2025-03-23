@REM @echo off
@REM echo 🚀 Cleaning previous build...
@REM flutter clean

@REM echo 📦 Fetching dependencies...
@REM flutter pub get

echo 🔨 Building Flutter web app...
flutter build web --release --base-href="/local-market/"

echo 🗑 Removing old deployment files...
rmdir /s /q docs

echo 📂 Moving new build to docs folder...
move build\web docs

echo 📤 Committing and pushing to GitHub...
git add docs
git commit -m "🚀 Deploy updated Flutter web app"
git push origin gh-pages --force

echo ✅ Deployment completed! Visit your site at:
echo 🌍 https://akash-adhikary.github.io/local-store/

pause
