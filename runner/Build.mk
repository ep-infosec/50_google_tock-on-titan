# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY: runner/build
runner/build: build/cargo-host/release/runner

.PHONY: runner/build-signed
runner/build-signed: runner/build

.PHONY: runner/check
runner/check: sandbox_setup
	cd runner && \
		CARGO_TARGET_DIR="../build/cargo-host" $(BWRAP) cargo check

.PHONY: runner/clean
runner/clean:
	rm -f runner/Cargo.lock

.PHONY: runner/devicetests
runner/devicetests:

.PHONY: runner/doc
runner/doc: sandbox_setup
	cd runner && \
		CARGO_TARGET_DIR="../build/cargo-host" $(BWRAP) cargo doc

.PHONY: runner/localtests
runner/localtests: sandbox_setup
	cd runner && \
		CARGO_TARGET_DIR="../build/cargo-host" $(BWRAP) cargo test


.PHONY: build/cargo-host/release/runner
build/cargo-host/release/runner: sandbox_setup
	cd runner && \
		CARGO_TARGET_DIR="../build/cargo-host" \
		$(BWRAP) cargo build --release
