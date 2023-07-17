Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6F75606C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGQKcN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 06:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGQKcL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 06:32:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89357A6;
        Mon, 17 Jul 2023 03:32:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7CE2F4;
        Mon, 17 Jul 2023 03:32:53 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 930F33F67D;
        Mon, 17 Jul 2023 03:32:08 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mark Brown" <broonie@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Florent Revest" <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/8] selftests/mm: Skip soft-dirty tests on arm64
Date:   Mon, 17 Jul 2023 11:31:46 +0100
Message-Id: <20230717103152.202078-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717103152.202078-1-ryan.roberts@arm.com>
References: <20230717103152.202078-1-ryan.roberts@arm.com>
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

arm64 does not support the soft-dirty PTE bit. However, the `soft-dirty`
test suite is currently run unconditionally and therefore generates
spurious test failures on arm64. There are also some tests in
`madv_populate` which assume it is supported.

For `soft-dirty` lets disable the whole suite for arm64; it is no longer
built and run_vmtests.sh will skip it if its not present.

For `madv_populate`, we need a runtime mechanism so that the remaining
tests continue to be run. Unfortunately, the only way to determine if
the soft-dirty dirty bit is supported is to write to a page, then see if
the bit is set in /proc/self/pagemap. But the tests that we want to
conditionally execute are testing precicesly this. So if we introduced
this feature check, we could accedentally turn a real failure (on a
system that claims to support soft-dirty) into a skip. So instead, do
the check based on architecture; for arm64, we report that soft-dirty is
not supported.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/Makefile        |  5 ++++-
 tools/testing/selftests/mm/madv_populate.c | 26 ++++++++++++++++++++--
 tools/testing/selftests/mm/run_vmtests.sh  |  5 ++++-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 66d7c07dc177..3514697fc2db 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -63,12 +63,15 @@ TEST_GEN_PROGS += thuge-gen
 TEST_GEN_PROGS += transhuge-stress
 TEST_GEN_PROGS += uffd-stress
 TEST_GEN_PROGS += uffd-unit-tests
-TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_PROGS += ksm_tests
 TEST_GEN_PROGS += ksm_functional_tests
 TEST_GEN_PROGS += mdwe_test
 
+ifneq ($(ARCH),arm64)
+TEST_GEN_PROGS += soft-dirty
+endif
+
 ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index 60547245e479..17bcb07f19f3 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -264,14 +264,35 @@ static void test_softdirty(void)
 	munmap(addr, SIZE);
 }
 
+static int system_has_softdirty(void)
+{
+	/*
+	 * There is no way to check if the kernel supports soft-dirty, other
+	 * than by writing to a page and seeing if the bit was set. But the
+	 * tests are intended to check that the bit gets set when it should, so
+	 * doing that check would turn a potentially legitimate fail into a
+	 * skip. Fortunately, we know for sure that arm64 does not support
+	 * soft-dirty. So for now, let's just use the arch as a corse guide.
+	 */
+#if defined(__aarch64__)
+	return 0;
+#else
+	return 1;
+#endif
+}
+
 int main(int argc, char **argv)
 {
+	int nr_tests = 16;
 	int err;
 
 	pagesize = getpagesize();
 
+	if (system_has_softdirty())
+		nr_tests += 5;
+
 	ksft_print_header();
-	ksft_set_plan(21);
+	ksft_set_plan(nr_tests);
 
 	sense_support();
 	test_prot_read();
@@ -279,7 +300,8 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	test_softdirty();
+	if (system_has_softdirty())
+		test_softdirty();
 
 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 3f26f6e15b2a..9e4338aa5e09 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -290,7 +290,10 @@ then
 	CATEGORY="pkey" run_test ./protection_keys_64
 fi
 
-CATEGORY="soft_dirty" run_test ./soft-dirty
+if [ -x ./soft-dirty ]
+then
+	CATEGORY="soft_dirty" run_test ./soft-dirty
+fi
 
 # COW tests
 CATEGORY="cow" run_test ./cow
-- 
2.25.1

