NAMESPACE = learn-helm-local

.PHONY: deploy
deploy:
	@scripts/deploy_local.sh $(NAMESPACE)
