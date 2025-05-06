.PHONY: clean_and_pub_get build_files

clean_and_pub_get:
	@echo Cleaning and getting dependencies...
	flutter clean
	@echo Running pub get...
	flutter pub get
	@powershell -Command "Write-Host 'done!' -ForegroundColor Green"
	@powershell -Command "Write-Host '_____________________________________________' -ForegroundColor Green" 

build_files:
	\ clean_and_pub_get
	@echo Build files started....
	flutter run build_runner build --delete-conflicting-outputs
	@powershell -Command "Write-Host 'Build finished!' -ForegroundColor Green" 
	@powershell -Command "Write-Host '_____________________________________________' -ForegroundColor Green"
git_push:
	@powershell -Command "if (-not '$(message)') { Write-Host 'Please provide a commit message using message=' -ForegroundColor Red; exit 1 }"
	@git add .
	@git commit -m "$(message)"
	@git push
	@powershell -Command "Write-Host 'Changes pushed to remote repository!' -ForegroundColor Green"

