Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E375245F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjGMNzV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjGMNzL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:55:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B2F22721;
        Thu, 13 Jul 2023 06:55:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA4191596;
        Thu, 13 Jul 2023 06:55:48 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFCEC3F73F;
        Thu, 13 Jul 2023 06:55:04 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 9/9] selftests/mm: Run all tests from run_vmtests.sh
Date:   Thu, 13 Jul 2023 14:54:40 +0100
Message-Id: <20230713135440.3651409-10-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713135440.3651409-1-ryan.roberts@arm.com>
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is very unclear to me how one is supposed to run all the mm selftests
consistently and get clear results.

Most of the test programs are launched by both run_vmtests.sh and
run_kselftest.sh:

  hugepage-mmap
  hugepage-shm
  map_hugetlb
  hugepage-mremap
  hugepage-vmemmap
  hugetlb-madvise
  map_fixed_noreplace
  gup_test
  gup_longterm
  uffd-unit-tests
  uffd-stress
  compaction_test
  on-fault-limit
  map_populate
  mlock-random-test
  mlock2-tests
  mrelease_test
  mremap_test
  thuge-gen
  virtual_address_range
  va_high_addr_switch
  mremap_dontunmap
  hmm-tests
  madv_populate
  memfd_secret
  ksm_tests
  ksm_functional_tests
  soft-dirty
  cow

However, of this set, when launched by run_vmtests.sh, some of the
programs are invoked multiple times with different arguments. When
invoked by run_kselftest.sh, they are invoked without arguments (and as
a consequence, some fail immediately).

Some test programs are only launched by run_vmtests.sh:

  test_vmalloc.sh

And some test programs and only launched by run_kselftest.sh:

  khugepaged
  migration
  mkdirty
  transhuge-stress
  split_huge_page_test
  mdwe_test
  write_to_hugetlbfs

Furthermore, run_vmtests.sh is invoked by run_kselftest.sh, so in this
case all the test programs invoked by both scripts are run twice!

Needless to say, this is a bit of a mess. In the absence of fully
understanding the history here, it looks to me like the best solution is
to launch ALL test programs from run_vmtests.sh, and ONLY invoke
run_vmtests.sh from run_kselftest.sh. This way, we get full control over
the parameters, each program is only invoked the intended number of
times, and regardless of which script is used, the same tests get run in
the same way.

The only drawback is that if using run_kselftest.sh, it's top-level tap
result reporting reports only a single test and it fails if any of the
contained tests fail. I don't see this as a big deal though since we
still see all the nested reporting from multiple layers. The other issue
with this is that all of run_vmtests.sh must execute within a single
kselftest timeout period, so let's increase that to something more
suitable.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/Makefile       | 79 ++++++++++++-----------
 tools/testing/selftests/mm/run_vmtests.sh | 23 +++++++
 tools/testing/selftests/mm/settings       |  2 +-
 3 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 66d7c07dc177..881ed96d96fd 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -35,39 +35,39 @@ MAKEFLAGS += --no-builtin-rules
 CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
 
-TEST_GEN_PROGS = cow
-TEST_GEN_PROGS += compaction_test
-TEST_GEN_PROGS += gup_longterm
-TEST_GEN_PROGS += gup_test
-TEST_GEN_PROGS += hmm-tests
-TEST_GEN_PROGS += hugetlb-madvise
-TEST_GEN_PROGS += hugepage-mmap
-TEST_GEN_PROGS += hugepage-mremap
-TEST_GEN_PROGS += hugepage-shm
-TEST_GEN_PROGS += hugepage-vmemmap
-TEST_GEN_PROGS += khugepaged
-TEST_GEN_PROGS += madv_populate
-TEST_GEN_PROGS += map_fixed_noreplace
-TEST_GEN_PROGS += map_hugetlb
-TEST_GEN_PROGS += map_populate
-TEST_GEN_PROGS += memfd_secret
-TEST_GEN_PROGS += migration
-TEST_GEN_PROGS += mkdirty
-TEST_GEN_PROGS += mlock-random-test
-TEST_GEN_PROGS += mlock2-tests
-TEST_GEN_PROGS += mrelease_test
-TEST_GEN_PROGS += mremap_dontunmap
-TEST_GEN_PROGS += mremap_test
-TEST_GEN_PROGS += on-fault-limit
-TEST_GEN_PROGS += thuge-gen
-TEST_GEN_PROGS += transhuge-stress
-TEST_GEN_PROGS += uffd-stress
-TEST_GEN_PROGS += uffd-unit-tests
-TEST_GEN_PROGS += soft-dirty
-TEST_GEN_PROGS += split_huge_page_test
-TEST_GEN_PROGS += ksm_tests
-TEST_GEN_PROGS += ksm_functional_tests
-TEST_GEN_PROGS += mdwe_test
+TEST_GEN_FILES = cow
+TEST_GEN_FILES += compaction_test
+TEST_GEN_FILES += gup_longterm
+TEST_GEN_FILES += gup_test
+TEST_GEN_FILES += hmm-tests
+TEST_GEN_FILES += hugetlb-madvise
+TEST_GEN_FILES += hugepage-mmap
+TEST_GEN_FILES += hugepage-mremap
+TEST_GEN_FILES += hugepage-shm
+TEST_GEN_FILES += hugepage-vmemmap
+TEST_GEN_FILES += khugepaged
+TEST_GEN_FILES += madv_populate
+TEST_GEN_FILES += map_fixed_noreplace
+TEST_GEN_FILES += map_hugetlb
+TEST_GEN_FILES += map_populate
+TEST_GEN_FILES += memfd_secret
+TEST_GEN_FILES += migration
+TEST_GEN_FILES += mkdirty
+TEST_GEN_FILES += mlock-random-test
+TEST_GEN_FILES += mlock2-tests
+TEST_GEN_FILES += mrelease_test
+TEST_GEN_FILES += mremap_dontunmap
+TEST_GEN_FILES += mremap_test
+TEST_GEN_FILES += on-fault-limit
+TEST_GEN_FILES += thuge-gen
+TEST_GEN_FILES += transhuge-stress
+TEST_GEN_FILES += uffd-stress
+TEST_GEN_FILES += uffd-unit-tests
+TEST_GEN_FILES += soft-dirty
+TEST_GEN_FILES += split_huge_page_test
+TEST_GEN_FILES += ksm_tests
+TEST_GEN_FILES += ksm_functional_tests
+TEST_GEN_FILES += mdwe_test
 
 ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
@@ -83,24 +83,24 @@ CFLAGS += -no-pie
 endif
 
 ifeq ($(CAN_BUILD_I386),1)
-TEST_GEN_PROGS += $(BINARIES_32)
+TEST_GEN_FILES += $(BINARIES_32)
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
-TEST_GEN_PROGS += $(BINARIES_64)
+TEST_GEN_FILES += $(BINARIES_64)
 endif
 else
 
 ifneq (,$(findstring $(ARCH),ppc64))
-TEST_GEN_PROGS += protection_keys
+TEST_GEN_FILES += protection_keys
 endif
 
 endif
 
 ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sparc64 x86_64))
-TEST_GEN_PROGS += va_high_addr_switch
-TEST_GEN_PROGS += virtual_address_range
-TEST_GEN_PROGS += write_to_hugetlbfs
+TEST_GEN_FILES += va_high_addr_switch
+TEST_GEN_FILES += virtual_address_range
+TEST_GEN_FILES += write_to_hugetlbfs
 endif
 
 TEST_PROGS := run_vmtests.sh
@@ -112,6 +112,7 @@ TEST_FILES += va_high_addr_switch.sh
 include ../lib.mk
 
 $(TEST_GEN_PROGS): vm_util.c
+$(TEST_GEN_FILES): vm_util.c
 
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 3f26f6e15b2a..55fe1d309355 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -55,6 +55,17 @@ separated by spaces:
 	test soft dirty page bit semantics
 - cow
 	test copy-on-write semantics
+- thp
+	test transparent huge pages
+- migration
+	invoke move_pages(2) to exercise the migration entry code
+	paths in the kernel
+- mkdirty
+	test handling of code that might set PTE/PMD dirty in
+	read-only VMAs
+- mdwe
+	test prctl(PR_SET_MDWE, ...)
+
 example: ./run_vmtests.sh -t "hmm mmap ksm"
 EOF
 	exit 0
@@ -295,6 +306,18 @@ CATEGORY="soft_dirty" run_test ./soft-dirty
 # COW tests
 CATEGORY="cow" run_test ./cow
 
+CATEGORY="thp" run_test ./khugepaged
+
+CATEGORY="thp" run_test ./transhuge-stress -d 20
+
+CATEGORY="thp" run_test ./split_huge_page_test
+
+CATEGORY="migration" run_test ./migration
+
+CATEGORY="mkdirty" run_test ./mkdirty
+
+CATEGORY="mdwe" run_test ./mdwe_test
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}"
 
 exit $exitcode
diff --git a/tools/testing/selftests/mm/settings b/tools/testing/selftests/mm/settings
index ba4d85f74cd6..a953c96aa16e 100644
--- a/tools/testing/selftests/mm/settings
+++ b/tools/testing/selftests/mm/settings
@@ -1 +1 @@
-timeout=90
+timeout=180
-- 
2.25.1

