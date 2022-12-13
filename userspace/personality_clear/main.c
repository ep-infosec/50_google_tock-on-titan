// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// This tests the personality driver by deleting the current personality
// (setting it to all 0x87). You can use this application in concert
// with personality_test to test that userspace can detect the need to
// generate personality data and store it persistently. E.g.:
//    - install personality_clear
//    - install personality_test (should store personality data)
//    - re-run personality_test (should detect data and not re-generate)
//    - install personality_clear
//    - install personality_test (should store personality data)


#include "common.h"
#include "storage.h"
#include "kl.h"
#include "fips.h"
#include "x509.h"

#include <stdio.h>
#include <string.h>
#include <timer.h>
#include <rng.h>


static void clear_personality(void);

static void clear_personality(void) {
  perso_st* person = get_personality();
  memset(person, 0x87, sizeof(perso_st));
  set_personality(person);
}


int main(void) {
  init_fips();
  if (kl_init()) {
    printf("kl_init() FAIL\n");
  }
  printf("= Clearing Personality =\n");
  clear_personality();
  return 0;
}
