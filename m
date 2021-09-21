Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E309B41379E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhIUQe4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 12:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhIUQe4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 12:34:56 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC671C061575
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:33:27 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h25-20020a0cab19000000b0037a49d15c93so228764233qvb.22
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eRBohQvfWYLfYtUzm95CYLT/7wrohS6aURHgvBsCQbc=;
        b=RT/CTVw0IjX1ywZHTy43dO2Ttl+CVT/8ZEQ8b9W9XXrTSLQo1C8YFjBrPAye30XWl5
         zE4QVhIbnPzr0qXErl8f9V32ji66+eUDjcX5TbsA8De5jJ3cyh7MZP8S9aQKL3+UND28
         uaINQRDjmYll7b9dcxHimpJV1b9bL7pZ6h8Du0csdbDQeXIew5Clh1ZWvbI7+2B9K6Ah
         JpCPF8hUcadLZYkHWRcA2TxEMdju0s5EiQ8l4dmpA5AZfkbZuzsJgyN/rOWCwI2w0enh
         zU6VTl8ljsElsP4FeC65akXy258w7hOpPQME3YxDvQ4IkYU0pgCcQ64NVC7fMQwDvk0Y
         OPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eRBohQvfWYLfYtUzm95CYLT/7wrohS6aURHgvBsCQbc=;
        b=470KHMyxjL3j64SKzGlPbOV5mM7uRzb3oaT40QqYMTTD6IQDISAQzOv62vCy3vk4s6
         fO4jeu1+4dB6Qqq8ENfgSwOexvK+j4cAKAjEBCMm8InAWB7+CAB3SiqAv//OLR20nm0w
         bYPnlUt2vTHuAyD/FkViS3BNlWu9PrdEC3wKMuQtZKoeGf3amGcvft2bhCEW041wwow0
         wT8oISqr8tGIOXJeSNKYIh0lnrrWJZxar1YanFrjSc6J+w0cmur57COX4egmWXle1CNQ
         PhhGYMccIQIBRN8Z6l9CKGpNnuCXi0oE3tDf4Qx83Ai02JJc4INAxat8SYfw6wnwBUT9
         9i1g==
X-Gm-Message-State: AOAM530TLulVWC4XNskX6dN5DfMTJBXT21EOwsxW4fFQSWH4lY1WJ+wx
        VWkCX3gMy7bZbPMKw+pZjprinT9MXZjyHkmZDbmU
X-Google-Smtp-Source: ABdhPJxYT3xrgOkjcmsxGwfgxs89od1eDDVy3/ncgM+iAfoUNxOGOowrVKVe2XEiFGiq+R3QREZKy2khRhYRG1ntWQ2V
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:ed57:a230:8c3d:64d8])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:122e:: with SMTP id
 p14mr32188853qvv.37.1632242006900; Tue, 21 Sep 2021 09:33:26 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:33:21 -0700
Message-Id: <20210921163323.944352-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
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

Currently, the test decides whether or not to test certain features
(e.g., writeprotect support) essentially by examining command-line
arguments. For example, if we're testing anonymous memory, then we
should test writeprotect support as well (since it generally is
supported for anonymous).

This is broken, however. Take writeprotect support as an example: sure
it's supported for anon, but it also requires that we have
CONFIG_HAVE_ARCH_USERFAULTFD_WP. I.e., it is not supported at all on
aarch64. So, running the test on such an arch fails: it tries to test
writeprotect for anon, but since it isn't *actually* supported, it
fails.

So, instead of checking command-line arguments to the test, check the
features the way the UFFD API intends: when we open a new userfaultfd,
pass in the feature(s) this test case would like to try to exercise. The
kernel reports back a subset of those features which are actually
supported: check these returned flags to see if the features are
*actually* supported.

(For a couple of cases, where *registration* would fail [with -EINVAL]
even though UFFDIO_API reports the feature as supported, we have to
check test_type as well as the feature flag.)

In some cases, we check immediately after opening the userfaultfd, and
if the features are missing, we skip the entire test. In some other
cases, we can proceed with "most" of the test, only skipping a few
pieces.

This lets us remove the global test_uffdio_wp and test_uffdio_minor
variables entirely.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 94 +++++++++++-------------
 1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 10ab56c2484a..2366caf90435 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -79,10 +79,6 @@ static int test_type;
 #define ALARM_INTERVAL_SECS 10
 static volatile bool test_uffdio_copy_eexist = true;
 static volatile bool test_uffdio_zeropage_eexist = true;
-/* Whether to test uffd write-protection */
-static bool test_uffdio_wp = false;
-/* Whether to test uffd minor faults */
-static bool test_uffdio_minor = false;
 
 static bool map_shared;
 static int shm_fd;
@@ -90,6 +86,7 @@ static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
 static int uffd = -1;
+static uint64_t uffd_features;
 static int uffd_flags, finished, *pipefd;
 static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
 static char *zeropage;
@@ -345,7 +342,7 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
 
 static struct uffd_test_ops *uffd_test_ops;
 
-static void userfaultfd_open(uint64_t *features)
+static void userfaultfd_open(uint64_t features)
 {
 	struct uffdio_api uffdio_api;
 
@@ -355,14 +352,20 @@ static void userfaultfd_open(uint64_t *features)
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
 
 	uffdio_api.api = UFFD_API;
-	uffdio_api.features = *features;
+	uffdio_api.features = features;
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
 		err("UFFDIO_API failed.\nPlease make sure to "
 		    "run with either root or ptrace capability.");
 	if (uffdio_api.api != UFFD_API)
 		err("UFFDIO_API error: %" PRIu64, (uint64_t)uffdio_api.api);
 
-	*features = uffdio_api.features;
+	uffd_features = uffdio_api.features;
+}
+
+static inline bool uffd_wp_supported(void)
+{
+	return test_type == TEST_ANON &&
+		(uffd_features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 }
 
 static inline void munmap_area(void **area)
@@ -397,6 +400,7 @@ static void uffd_test_ctx_clear(void)
 			err("close uffd");
 		uffd = -1;
 	}
+	uffd_features = 0;
 
 	huge_fd_off0 = NULL;
 	munmap_area((void **)&area_src);
@@ -405,7 +409,7 @@ static void uffd_test_ctx_clear(void)
 	munmap_area((void **)&area_dst_alias);
 }
 
-static void uffd_test_ctx_init_ext(uint64_t *features)
+static void uffd_test_ctx_init(uint64_t features)
 {
 	unsigned long nr, cpu;
 
@@ -445,11 +449,6 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
 			err("pipe");
 }
 
-static inline void uffd_test_ctx_init(uint64_t features)
-{
-	uffd_test_ctx_init_ext(&features);
-}
-
 static int my_bcmp(char *str1, char *str2, size_t n)
 {
 	unsigned long i;
@@ -587,7 +586,7 @@ static int __copy_page(int ufd, unsigned long offset, bool retry)
 	uffdio_copy.dst = (unsigned long) area_dst + offset;
 	uffdio_copy.src = (unsigned long) area_src + offset;
 	uffdio_copy.len = page_size;
-	if (test_uffdio_wp)
+	if (uffd_wp_supported())
 		uffdio_copy.mode = UFFDIO_COPY_MODE_WP;
 	else
 		uffdio_copy.mode = 0;
@@ -778,7 +777,7 @@ static void *background_thread(void *arg)
 	 * at least the first half of the pages mapped already which
 	 * can be write-protected for testing
 	 */
-	if (test_uffdio_wp)
+	if (uffd_wp_supported())
 		wp_range(uffd, (unsigned long)area_dst + start_nr * page_size,
 			nr_pages_per_cpu * page_size, true);
 
@@ -1062,12 +1061,12 @@ static int userfaultfd_zeropage_test(void)
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
 
-	uffd_test_ctx_init(0);
+	uffd_test_ctx_init(UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (test_uffdio_wp)
+	if (uffd_wp_supported())
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
@@ -1089,7 +1088,7 @@ static int userfaultfd_events_test(void)
 	struct uffdio_register uffdio_register;
 	unsigned long expected_ioctls;
 	pthread_t uffd_mon;
-	int err, features;
+	int err;
 	pid_t pid;
 	char c;
 	struct uffd_stats stats = { 0 };
@@ -1097,16 +1096,15 @@ static int userfaultfd_events_test(void)
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
 
-	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
-		UFFD_FEATURE_EVENT_REMOVE;
-	uffd_test_ctx_init(features);
+	uffd_test_ctx_init(UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
+			   UFFD_FEATURE_EVENT_REMOVE | UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (test_uffdio_wp)
+	if (uffd_wp_supported())
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
@@ -1144,7 +1142,7 @@ static int userfaultfd_sig_test(void)
 	unsigned long expected_ioctls;
 	unsigned long userfaults;
 	pthread_t uffd_mon;
-	int err, features;
+	int err;
 	pid_t pid;
 	char c;
 	struct uffd_stats stats = { 0 };
@@ -1152,15 +1150,15 @@ static int userfaultfd_sig_test(void)
 	printf("testing signal delivery: ");
 	fflush(stdout);
 
-	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
-	uffd_test_ctx_init(features);
+	uffd_test_ctx_init(UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_SIGBUS |
+			   UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (test_uffdio_wp)
+	if (uffd_wp_supported())
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
@@ -1209,25 +1207,23 @@ static int userfaultfd_minor_test(void)
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t req_features, features_out;
-
-	if (!test_uffdio_minor)
-		return 0;
+	uint64_t features;
 
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	if (test_type == TEST_HUGETLB)
-		req_features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	if (test_type == TEST_HUGETLB && map_shared)
+		features = UFFD_FEATURE_MINOR_HUGETLBFS;
 	else if (test_type == TEST_SHMEM)
-		req_features = UFFD_FEATURE_MINOR_SHMEM;
-	else
-		return 1;
+		features = UFFD_FEATURE_MINOR_SHMEM;
+	else {
+		printf("skipping test due to unsupported memory type\n");
+		return 0;
+	}
 
-	features_out = req_features;
-	uffd_test_ctx_init_ext(&features_out);
+	uffd_test_ctx_init(features);
 	/* If kernel reports required features aren't supported, skip test. */
-	if ((features_out & req_features) != req_features) {
+	if ((uffd_features & features) != features) {
 		printf("skipping test due to lack of feature support\n");
 		fflush(stdout);
 		return 0;
@@ -1349,10 +1345,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	int pagemap_fd;
 	uint64_t value;
 
-	/* Pagemap tests uffd-wp only */
-	if (!test_uffdio_wp)
-		return;
-
 	/* Not enough memory to test this page size */
 	if (test_pgsize > nr_pages * page_size)
 		return;
@@ -1361,7 +1353,12 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	/* Flush so it doesn't flush twice in parent/child later */
 	fflush(stdout);
 
-	uffd_test_ctx_init(0);
+	uffd_test_ctx_init(UFFD_FEATURE_PAGEFAULT_FLAG_WP);
+	/* Pagemap tests uffd-wp only */
+	if (!uffd_wp_supported()) {
+		printf("skipping test due to lack of feature support\n");
+		return;
+	}
 
 	if (test_pgsize > page_size) {
 		/* This is a thp test */
@@ -1426,7 +1423,7 @@ static int userfaultfd_stress(void)
 	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
 
-	uffd_test_ctx_init(0);
+	uffd_test_ctx_init(UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 
 	if (posix_memalign(&area, page_size, page_size))
 		err("out of memory");
@@ -1464,7 +1461,7 @@ static int userfaultfd_stress(void)
 		uffdio_register.range.start = (unsigned long) area_dst;
 		uffdio_register.range.len = nr_pages * page_size;
 		uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-		if (test_uffdio_wp)
+		if (uffd_wp_supported())
 			uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 			err("register failure");
@@ -1513,7 +1510,7 @@ static int userfaultfd_stress(void)
 			return 1;
 
 		/* Clear all the write protections if there is any */
-		if (test_uffdio_wp)
+		if (uffd_wp_supported())
 			wp_range(uffd, (unsigned long)area_dst,
 				 nr_pages * page_size, false);
 
@@ -1595,8 +1592,6 @@ static void set_test_type(const char *type)
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
-		/* Only enable write-protect test for anonymous test */
-		test_uffdio_wp = true;
 	} else if (!strcmp(type, "hugetlb")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
@@ -1604,13 +1599,10 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-		/* Minor faults require shared hugetlb; only enable here. */
-		test_uffdio_minor = true;
 	} else if (!strcmp(type, "shmem")) {
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
-		test_uffdio_minor = true;
 	} else {
 		err("Unknown test type: %s", type);
 	}
-- 
2.33.0.464.g1972c5931b-goog

