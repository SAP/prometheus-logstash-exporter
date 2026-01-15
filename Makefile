release:
	goreleaser release --rm-dist

snapshot:
	goreleaser release --rm-dist --snapshot --skip-publish --skip-sign --skip-validate

.PHONY: release snapshot

# Set the year for SPDX header updates (default: current year)
YEAR ?= $(shell date +%Y)

.PHONY: update-header-year
update-header-year:
	# Go + TXT
	@find . -type f \( -name "*.go" -o -name "*.txt" \) -exec sed -i \
	's/^SPDX-FileCopyrightText: [0-9]\{4\}\( SAP SE or an SAP affiliate company and [^"]\+ contributors\)/SPDX-FileCopyrightText: $(YEAR)\1/' {} +

	# TOML
	@find . -type f -name "*.toml" -exec sed -i \
	's/^SPDX-FileCopyrightText = "[0-9]\{4\}\( SAP SE or an SAP affiliate company and [^"]\+ contributors\)"/SPDX-FileCopyrightText = "$(YEAR)\1"/' {} +
