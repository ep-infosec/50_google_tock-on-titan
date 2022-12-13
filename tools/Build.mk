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

.PHONY: tools/build
tools/build: cargo_version_check sandbox_setup
	cd tools && $(BWRAP) cargo build --offline --release

.PHONY: tools/build-signed
tools/build-signed: tools/build

.PHONY: tools/check
tools/check: cargo_version_check sandbox_setup
	cd tools && $(BWRAP) cargo check --offline --release

.PHONY: tools/clean
tools/clean:
	rm -f tools/Cargo.lock

.PHONY: tools/devicetests
tools/devicetests:

.PHONY: tools/doc
tools/doc: cargo_version_check sandbox_setup
	cd tools && $(BWRAP) cargo doc --offline --release

.PHONY: tools/localtests
tools/localtests: cargo_version_check sandbox_setup
	cd tools && $(BWRAP) cargo test --offline --release
