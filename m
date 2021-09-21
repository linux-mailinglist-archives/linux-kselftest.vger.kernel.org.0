Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085184137A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhIUQe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 12:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIUQe6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 12:34:58 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A5C061575
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:33:29 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h10-20020a05620a284a00b003d30e8c8cb5so180943824qkp.11
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NgPoad1ME6wlZVXGi4jGZtPG1kpzd8MCngh0GNGmSTU=;
        b=OiBXpaE7L7Cg8Vn+IE64i4Bmc0+OP/WPBKzNQewvjrlr6POIZZk+Ky9xhXty8SZ8lP
         RKxJXIhHc5So/Kp1f68gaaPk7U39WA10s+ztBJQqJfPxLoF0mZBXA7tGzbDhd825rFfR
         OH+uArjVvTx1MmoJDVDAVESSeAa8gD35aUj6Sr7xwfWGttxUFmpNkbMIg3X/mugBdbu5
         aq0ToSOB8bOQFJE0lUjmNAhqmbDtq0DufSUQX6+e99zp5bZVrWrWRLKdKgrU7d1V0SD8
         Fme80gZSqKVTyHq2gQoPVM/Twl/7ePPdwGWN9p7x17VmTMfkNdj1lKr16+dl7pSk0FWO
         eKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NgPoad1ME6wlZVXGi4jGZtPG1kpzd8MCngh0GNGmSTU=;
        b=KIRLPgtwI6qE2fOckuLPXe1z6dqK2kcDLOQHI+JF7+03vwOCWDtl4ZDPYaTjtqXfPU
         Lc5Cz2VpwSycTvCagC+swhjkwLl4nHcT+UsRw0KK/r4LexBCBLKB5mKptnO6hXxDGhl+
         gad4AXywBoyVOXKasW5f5mT/YWDhIczSeR67yzu3rt/VpPUwBIAaw7/qttlmVeyPpuva
         Od4xQV5a9QVGFJeBbRAHw/dM9rTFFVWFM3p+NJsOyP0TFZDrdSvDL1p7JOqmp/tlHyek
         DsQSbP3YW3OJtxXACpySrUx0jXgZGDbhMHSFEgkAOU8IexKSd5kKJ7T2Lvg71n7hW4/h
         lLEA==
X-Gm-Message-State: AOAM530Q8Z2bmlViERIIwbl142sXNQrSTUow78NGJJzWi5lZUWK1EQhq
        0X1g4XlNYn8lmZEAEXGuqbGwIEQZeoiddZNJ9r/8
X-Google-Smtp-Source: ABdhPJzFUqv9WN4LgLUzjGZJ0PdywLcz6io6aPqJZC1htFwB2/tNqKY4+zhvKxW6rLMTqAezbaRHM8hF3wMx62GMdI3q
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:ed57:a230:8c3d:64d8])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4873:: with SMTP id
 u19mr32664806qvy.11.1632242008820; Tue, 21 Sep 2021 09:33:28 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:33:22 -0700
In-Reply-To: <20210921163323.944352-1-axelrasmussen@google.com>
Message-Id: <20210921163323.944352-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210921163323.944352-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 2/3] userfaultfd/selftests: fix calculation of expected ioctls
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, the list of expected ioctls is stored in uffd_test_ops. This
design comes with the implicit assumption that the set of expected ioctls
is a function of the memory type (anon, shmem, or hugetlb).

However, this is not the case. For example:

- UFFDIO_WRITEPROTECT is supported for anon in general, *but not on
  aarch64* (which lacks CONFIG_HAVE_ARCH_USERFAULTFD_WP).
- UFFDIO_WRITEPROTECT is supported for anon, but only if one registers
  the region with UFFD_REGISTER_MODE_WP.
- We want to test (and expect) UFFDIO_CONTINUE, but only for *shared*
  hugetlb, not private.

So, instead, remove the set of expected ioctls from this structure.
Define a new function which can compute the correct set by examining
the memory type, the userfaultfd registration mode(s), whether map_shared
is set, and what set of features the kernel reports as supported (from
UFFDIO_API).

In addition to being more correct, this improves code re-use - less
boilerplate in each test trying to perform this assertion.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 103 ++++++++++++-----------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 2366caf90435..aad5211f5012 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -304,37 +304,24 @@ static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 }
 
 struct uffd_test_ops {
-	unsigned long expected_ioctls;
 	void (*allocate_area)(void **alloc_area);
 	void (*release_pages)(char *rel_area);
 	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
 };
 
-#define SHMEM_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
-					 (1 << _UFFDIO_COPY) | \
-					 (1 << _UFFDIO_ZEROPAGE))
-
-#define ANON_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
-					 (1 << _UFFDIO_COPY) | \
-					 (1 << _UFFDIO_ZEROPAGE) | \
-					 (1 << _UFFDIO_WRITEPROTECT))
-
 static struct uffd_test_ops anon_uffd_test_ops = {
-	.expected_ioctls = ANON_EXPECTED_IOCTLS,
 	.allocate_area	= anon_allocate_area,
 	.release_pages	= anon_release_pages,
 	.alias_mapping = noop_alias_mapping,
 };
 
 static struct uffd_test_ops shmem_uffd_test_ops = {
-	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
 	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-	.expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC & ~(1 << _UFFDIO_CONTINUE),
 	.allocate_area	= hugetlb_allocate_area,
 	.release_pages	= hugetlb_release_pages,
 	.alias_mapping = hugetlb_alias_mapping,
@@ -368,6 +355,47 @@ static inline bool uffd_wp_supported(void)
 		(uffd_features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 }
 
+static inline uint64_t uffd_minor_feature(void)
+{
+	if (test_type == TEST_HUGETLB && map_shared)
+		return UFFD_FEATURE_MINOR_HUGETLBFS;
+	else if (test_type == TEST_SHMEM)
+		return UFFD_FEATURE_MINOR_SHMEM;
+	else
+		return 0;
+}
+
+static inline bool uffd_minor_supported(void)
+{
+	return uffd_features & uffd_minor_feature();
+}
+
+static unsigned long get_expected_ioctls(uint64_t mode)
+{
+	unsigned long ioctls = UFFD_API_RANGE_IOCTLS;
+
+	if (test_type == TEST_HUGETLB)
+		ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
+
+	if (!((mode & UFFDIO_REGISTER_MODE_WP) && uffd_wp_supported()))
+		ioctls &= ~(1 << _UFFDIO_WRITEPROTECT);
+
+	if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && uffd_minor_supported()))
+		ioctls &= ~(1 << _UFFDIO_CONTINUE);
+
+	return ioctls;
+}
+
+static inline void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
+{
+	uint64_t expected = get_expected_ioctls(mode);
+	uint64_t actual = ioctls & expected;
+
+	if (actual != expected)
+		err("missing ioctl(s); expected: %"PRIx64" actual: %"PRIx64,
+		    expected, actual);
+}
+
 static inline void munmap_area(void **area)
 {
 	if (*area)
@@ -1012,11 +1040,9 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 {
 	struct uffdio_zeropage uffdio_zeropage;
 	int ret;
-	unsigned long has_zeropage;
+	bool has_zeropage = get_expected_ioctls(0) & (1 << _UFFDIO_ZEROPAGE);
 	__s64 res;
 
-	has_zeropage = uffd_test_ops->expected_ioctls & (1 << _UFFDIO_ZEROPAGE);
-
 	if (offset >= nr_pages * page_size)
 		err("unexpected offset %lu", offset);
 	uffdio_zeropage.range.start = (unsigned long) area_dst + offset;
@@ -1056,7 +1082,6 @@ static int uffdio_zeropage(int ufd, unsigned long offset)
 static int userfaultfd_zeropage_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
@@ -1071,9 +1096,8 @@ static int userfaultfd_zeropage_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
-		err("unexpected missing ioctl for anon memory");
+	assert_expected_ioctls_present(
+		uffdio_register.mode, uffdio_register.ioctls);
 
 	if (uffdio_zeropage(uffd, 0))
 		if (my_bcmp(area_dst, zeropage, page_size))
@@ -1086,7 +1110,6 @@ static int userfaultfd_zeropage_test(void)
 static int userfaultfd_events_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	pthread_t uffd_mon;
 	int err;
 	pid_t pid;
@@ -1109,9 +1132,8 @@ static int userfaultfd_events_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
-		err("unexpected missing ioctl for anon memory");
+	assert_expected_ioctls_present(
+		uffdio_register.mode, uffdio_register.ioctls);
 
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
 		err("uffd_poll_thread create");
@@ -1139,7 +1161,6 @@ static int userfaultfd_events_test(void)
 static int userfaultfd_sig_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	unsigned long userfaults;
 	pthread_t uffd_mon;
 	int err;
@@ -1163,9 +1184,8 @@ static int userfaultfd_sig_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
-		err("unexpected missing ioctl for anon memory");
+	assert_expected_ioctls_present(
+		uffdio_register.mode, uffdio_register.ioctls);
 
 	if (faulting_process(1))
 		err("faulting process failed");
@@ -1200,30 +1220,25 @@ static int userfaultfd_sig_test(void)
 static int userfaultfd_minor_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	unsigned long p;
 	pthread_t uffd_mon;
 	uint8_t expected_byte;
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t features;
+	uint64_t features = uffd_minor_feature();
 
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	if (test_type == TEST_HUGETLB && map_shared)
-		features = UFFD_FEATURE_MINOR_HUGETLBFS;
-	else if (test_type == TEST_SHMEM)
-		features = UFFD_FEATURE_MINOR_SHMEM;
-	else {
+	if (!features) {
 		printf("skipping test due to unsupported memory type\n");
+		fflush(stdout);
 		return 0;
 	}
 
 	uffd_test_ctx_init(features);
-	/* If kernel reports required features aren't supported, skip test. */
-	if ((uffd_features & features) != features) {
+	if (!uffd_minor_supported()) {
 		printf("skipping test due to lack of feature support\n");
 		fflush(stdout);
 		return 0;
@@ -1235,10 +1250,8 @@ static int userfaultfd_minor_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	expected_ioctls |= 1 << _UFFDIO_CONTINUE;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
-		err("unexpected missing ioctl(s)");
+	assert_expected_ioctls_present(
+		uffdio_register.mode, uffdio_register.ioctls);
 
 	/*
 	 * After registering with UFFD, populate the non-UFFD-registered side of
@@ -1436,8 +1449,6 @@ static int userfaultfd_stress(void)
 	pthread_attr_setstacksize(&attr, 16*1024*1024);
 
 	while (bounces--) {
-		unsigned long expected_ioctls;
-
 		printf("bounces: %d, mode:", bounces);
 		if (bounces & BOUNCE_RANDOM)
 			printf(" rnd");
@@ -1465,10 +1476,8 @@ static int userfaultfd_stress(void)
 			uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 			err("register failure");
-		expected_ioctls = uffd_test_ops->expected_ioctls;
-		if ((uffdio_register.ioctls & expected_ioctls) !=
-		    expected_ioctls)
-			err("unexpected missing ioctl for anon memory");
+		assert_expected_ioctls_present(
+			uffdio_register.mode, uffdio_register.ioctls);
 
 		if (area_dst_alias) {
 			uffdio_register.range.start = (unsigned long)
-- 
2.33.0.464.g1972c5931b-goog

