Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C442752451
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjGMNy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGMNy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:54:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E71781BB;
        Thu, 13 Jul 2023 06:54:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B9D61570;
        Thu, 13 Jul 2023 06:55:38 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5A53F73F;
        Thu, 13 Jul 2023 06:54:54 -0700 (PDT)
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
Subject: [PATCH v1 3/9] selftests/mm: Skip soft-dirty tests on arm64
Date:   Thu, 13 Jul 2023 14:54:34 +0100
Message-Id: <20230713135440.3651409-4-ryan.roberts@arm.com>
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

arm64 does not support the soft-dirty PTE bit. However there are tests
in `madv_populate` and `soft-dirty` which assume it is supported and
cause spurious failures to be reported when preferred behaviour would be
to mark the tests as skipped.

Unfortunately, the only way to determine if the soft-dirty dirty bit is
supported is to write to a page, then see if the bit is set in
/proc/self/pagemap. But the tests that we want to conditionally execute
are testing precicesly this. So if we introduced this feature check, we
could accedentally turn a real failure (on a system that claims to
support soft-dirty) into a skip.

So instead, do the check based on architecture; for arm64, we report
that soft-dirty is not supported. This is wrapped up into a utility
function `system_has_softdirty()`, which is used to skip the whole
`soft-dirty` suite, and mark the soft-dirty tests in the `madv_populate`
suite as skipped.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/madv_populate.c | 18 +++++++++++++-----
 tools/testing/selftests/mm/soft-dirty.c    |  3 +++
 tools/testing/selftests/mm/vm_util.c       | 17 +++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index 60547245e479..5a8c176d7fec 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -232,6 +232,14 @@ static bool range_is_not_softdirty(char *start, ssize_t size)
 	return ret;
 }

+#define ksft_test_result_if_softdirty(cond, ...)	\
+do {							\
+	if (system_has_softdirty())			\
+		ksft_test_result(cond, __VA_ARGS__);	\
+	else						\
+		ksft_test_result_skip(__VA_ARGS__);	\
+} while (0)
+
 static void test_softdirty(void)
 {
 	char *addr;
@@ -246,19 +254,19 @@ static void test_softdirty(void)

 	/* Clear any softdirty bits. */
 	clear_softdirty();
-	ksft_test_result(range_is_not_softdirty(addr, SIZE),
+	ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
 			 "range is not softdirty\n");

 	/* Populating READ should set softdirty. */
 	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
-	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
-	ksft_test_result(range_is_not_softdirty(addr, SIZE),
+	ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_READ\n");
+	ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
 			 "range is not softdirty\n");

 	/* Populating WRITE should set softdirty. */
 	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
-	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
-	ksft_test_result(range_is_softdirty(addr, SIZE),
+	ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_WRITE\n");
+	ksft_test_result_if_softdirty(range_is_softdirty(addr, SIZE),
 			 "range is softdirty\n");

 	munmap(addr, SIZE);
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index cc5f144430d4..8a2cd161ec4d 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -192,6 +192,9 @@ int main(int argc, char **argv)
 	int pagemap_fd;
 	int pagesize;

+	if (!system_has_softdirty())
+		return KSFT_SKIP;
+
 	ksft_print_header();
 	ksft_set_plan(15);

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 558c9cd8901c..f014fafbd2d3 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -53,6 +53,23 @@ unsigned long pagemap_get_pfn(int fd, char *start)
 	return -1ul;
 }

+int system_has_softdirty(void)
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
 void clear_softdirty(void)
 {
 	int ret;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index c7fa61f0dff8..5a57314d428a 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -36,6 +36,7 @@ bool pagemap_is_softdirty(int fd, char *start);
 bool pagemap_is_swapped(int fd, char *start);
 bool pagemap_is_populated(int fd, char *start);
 unsigned long pagemap_get_pfn(int fd, char *start);
+int system_has_softdirty(void);
 void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t read_pmd_pagesize(void);
--
2.25.1

