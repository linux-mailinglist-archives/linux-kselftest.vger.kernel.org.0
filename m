Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963AF41E350
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 23:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349730AbhI3VZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349787AbhI3VZF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 17:25:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D300C06176A
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 14:23:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 207-20020a2503d8000000b005b6fc088578so5306876ybd.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O1Wk2DsZzjmvOi9GlXjWLcYlkQVsSE0/3HMwsEB5v90=;
        b=p5N9OfoJnRryV2eKQy7VJj+QvmddfN6dQLK1yKEYuT0+MEdaPYTk0F1gSb0XuI4m/C
         UOSfrWwVYnKcg9i4VTVBWBoyzlr5D/4tCJHL+keAjsGNCgUG4CkTUALdSFqGuL1rUIfW
         eJiSFq5kNK2QYiOhfHBTWkEVNQXnH5xkx3SF77V8LMdO+UwtxoCiJaacEOdGcUhQjaMX
         LiFJIX6epwBcRsVVwO6fsb777Dm9tQI3wml4GWagAl575ckhhUU4KI4NIuPEbxf2z0yy
         9KrwvWJ9b+hSfVCQwJjcfsfhMhG6YWBrH+TQJgm5EXPp85Q0LyoSYm9H6b9xm/wA2pgj
         OdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O1Wk2DsZzjmvOi9GlXjWLcYlkQVsSE0/3HMwsEB5v90=;
        b=4I37xgIshz4DcDOkqBG/DV/JY0bWsqlJOYfUpsCt4TYGm0V9ptqCOHmtOQU+wBr9kw
         IJ7rvwQEWSxgDhXszrj6PLwbtyH1xMQZ/kbqU5KbgbDYx/FwyRWtP3LDeyDdQ1A4Ne0m
         +1YM8SY4xjljL8MpeJw1m+yljE0603QSlMdhGrBtyyH0wIkRlyVDzbU5PxohJ+bO5xr/
         pqDYMZdAiadFUU6dHBJR3/wGp7s44sJHBKlzXstcabLm1uGSY/J+BAJAvW1cxuAlznws
         d7kcAB+GBYsKZQlEfRjoum1gHsTaTcb1y8JJPxJOaz47SbTYWXgWLpvwMxWln5djeqIS
         O6fA==
X-Gm-Message-State: AOAM531Ox4X3jBTMcjwnEUCpMzDCsfyRSg9ylsqep2+1WG5fQg1cxK0J
        GxigD8SVHHQU/VRToYw1iH79vAQMY8L1JWMYZPQm
X-Google-Smtp-Source: ABdhPJzQJP1Tci6sbmHJjYHkBqAym/flLRBcDla+uZ6luLw59DtIioxJBp4LVRUhA0wkrCyLNd6qTLK3ikD9/a+QM2T2
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:fa06:3b29:d3c:37e6])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:705:: with SMTP id
 k5mr1886040ybt.490.1633037001347; Thu, 30 Sep 2021 14:23:21 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:23:08 -0700
In-Reply-To: <20210930212309.4001967-1-axelrasmussen@google.com>
Message-Id: <20210930212309.4001967-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210930212309.4001967-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 2/3] userfaultfd/selftests: fix feature support detection
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

Before any tests are run, in set_test_type, we decide what feature(s) we
are going to be testing, based upon our command line arguments. However,
the supported features are not just a function of the memory type being
used, so this is broken.

For instance, consider writeprotect support. It is "normally" supported
for anonymous memory, but furthermore it requires that the kernel has
CONFIG_HAVE_ARCH_USERFAULTFD_WP. So, it is *not* supported at all on
aarch64, for example.

So, this commit fixes this by querying the kernel for the set of
features it supports in set_test_type, by opening a userfaultfd and
issuing a UFFDIO_API ioctl. Based upon the reported features, we toggle
what tests are enabled.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 54 ++++++++++++++----------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 2a71a91559a7..00d1b7555865 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -346,6 +346,16 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
 
 static struct uffd_test_ops *uffd_test_ops;
 
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
 static void userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
@@ -406,7 +416,7 @@ static void uffd_test_ctx_clear(void)
 	munmap_area((void **)&area_dst_alias);
 }
 
-static void uffd_test_ctx_init_ext(uint64_t *features)
+static void uffd_test_ctx_init(uint64_t features)
 {
 	unsigned long nr, cpu;
 
@@ -418,7 +428,7 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
 	uffd_test_ops->release_pages(area_src);
 	uffd_test_ops->release_pages(area_dst);
 
-	userfaultfd_open(features);
+	userfaultfd_open(&features);
 
 	count_verify = malloc(nr_pages * sizeof(unsigned long long));
 	if (!count_verify)
@@ -446,11 +456,6 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
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
@@ -1191,7 +1196,6 @@ static int userfaultfd_minor_test(void)
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t req_features, features_out;
 
 	if (!test_uffdio_minor)
 		return 0;
@@ -1199,21 +1203,7 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	if (test_type == TEST_HUGETLB)
-		req_features = UFFD_FEATURE_MINOR_HUGETLBFS;
-	else if (test_type == TEST_SHMEM)
-		req_features = UFFD_FEATURE_MINOR_SHMEM;
-	else
-		return 1;
-
-	features_out = req_features;
-	uffd_test_ctx_init_ext(&features_out);
-	/* If kernel reports required features aren't supported, skip test. */
-	if ((features_out & req_features) != req_features) {
-		printf("skipping test due to lack of feature support\n");
-		fflush(stdout);
-		return 0;
-	}
+	uffd_test_ctx_init(uffd_minor_feature());
 
 	uffdio_register.range.start = (unsigned long)area_dst_alias;
 	uffdio_register.range.len = nr_pages * page_size;
@@ -1574,6 +1564,8 @@ unsigned long default_huge_page_size(void)
 
 static void set_test_type(const char *type)
 {
+	uint64_t features = UFFD_API_FEATURES;
+
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
@@ -1607,6 +1599,22 @@ static void set_test_type(const char *type)
 	if ((unsigned long) area_count(NULL, 0) + sizeof(unsigned long long) * 2
 	    > page_size)
 		err("Impossible to run this test");
+
+	/*
+	 * Whether we can test certain features depends not just on test type,
+	 * but also on whether or not this particular kernel supports the
+	 * feature.
+	 */
+
+	userfaultfd_open(&features);
+
+	test_uffdio_wp = test_uffdio_wp &&
+		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
+	test_uffdio_minor = test_uffdio_minor &&
+		(features & uffd_minor_feature());
+
+	close(uffd);
+	uffd = -1;
 }
 
 static void sigalrm(int sig)
-- 
2.33.0.800.g4c38ced690-goog

