Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E02371F50
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhECSJT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhECSJC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 14:09:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93115C061358
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 11:08:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a3-20020a2580430000b02904f7a1a09012so4964054ybn.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OgpBn3KZ3jyoZwWP1rPcu0mUJ12jh2UTvDexIJWh8yU=;
        b=hZnbZpMsObpdwytHdhy+DFEXqL70zl8uGsd3CZ8jymimewvUOXkVI5J7lEvJfOw4sF
         SfT4DAx/79h+JvXLohVHhYbRwdCtEh1zFCgd1cr7v7zcAiEW4UypRX07yf0zz8C9e8QT
         UdHcyGu/8WiLWBLthvoY8BeAlP/wEVHiWAXpmGnXQFuP//BBhMwhOXaBPseEt5+NaG25
         6b53gvQwI3reFQyGEsVNjAjJ3SvhtGBnNM7Gz8qaV62BJLTQ1GoBxa/3p7/FYUvV+rff
         PcOoVUvxl+QRvJYZ0eyYThT7sDlTsY1uJl+by2xMWKg2rqgnoQH1VO3VrqXTx2GJBkWz
         4vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OgpBn3KZ3jyoZwWP1rPcu0mUJ12jh2UTvDexIJWh8yU=;
        b=APLjV1mPpUIvBPkMh30a/LKRq7OkLq3RlneHiF8BAhrtAM8LtsQMWNTT9a8Ixq4ENE
         e06+DPBbLPAFfkm6pQDkWvF/HrfMN+gN6mG8W6rrQkmGV8bCzw2u+bu6IBUYWWrwzwI2
         1Kato9c5fVNlTJ7UrGe7rSdfl6OlDUlFwFZ2ewD4BVOgwtgfzjmbGzYA85tV1Yv4/EHQ
         CMKd4kaB6Eg6OdIg3ZbFbpqOz2lZogVXKQiGOCXGTyUuVtRQtuH4YnO9JXkEAKYdslFh
         66GZN9ApkKY7U3c7Q6xhROEh2idSq8TcbTNeDZT3lvi5D8V62phIFkVlaRtbo741uTca
         mcrw==
X-Gm-Message-State: AOAM532qt08dzNRBMOGof+G7nvOaeBuIez73JYb2xFx0zo0DID6276hn
        k8ZqfAUUngIDBAsf0w4uK0eripnG64aT55KJNbgE
X-Google-Smtp-Source: ABdhPJyVr/aH/ZCMGx+83Zsm2MAUGx9W3uoUxe5pPXvl1twCNNqiw1KmiQhaT5GoTKZ+1tt037NtADXnyR1Nl2fMTCfR
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:4a:: with SMTP id
 e10mr3396454ybp.201.1620065279864; Mon, 03 May 2021 11:07:59 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:36 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-10-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 09/10] userfaultfd/selftests: reinitialize test context in
 each test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, the context (fds, mmap-ed areas, etc.) are global. Each test
mutates this state in some way, in some cases really "clobbering it"
(e.g., the events test mremap-ing area_dst over the top of area_src, or
the minor faults tests overwriting the count_verify values in the test
areas). We run the tests in a particular order, each test is careful to
make the right assumptions about its starting state, etc.

But, this is fragile. It's better for a test's success or failure to not
depend on what some other prior test case did to the global state.

To that end, clear and reinitialize the test context at the start of
each test case, so whatever prior test cases did doesn't affect future
tests.

This is particularly relevant to this series because the events test's
mremap of area_dst screws up assumptions the minor fault test was
relying on. This wasn't a problem for hugetlb, as we don't mremap in
that case.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 215 ++++++++++++-----------
 1 file changed, 116 insertions(+), 99 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 1f65c4ab7994..3fbc69f513dc 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -89,7 +89,8 @@ static int shm_fd;
 static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
-static int uffd, uffd_flags, finished, *pipefd;
+static int uffd = -1;
+static int uffd_flags, finished, *pipefd;
 static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
 static char *zeropage;
 pthread_attr_t attr;
@@ -342,6 +343,111 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
 
 static struct uffd_test_ops *uffd_test_ops;
 
+static void userfaultfd_open(uint64_t *features)
+{
+	struct uffdio_api uffdio_api;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
+	if (uffd < 0)
+		err("userfaultfd syscall not available in this kernel");
+	uffd_flags = fcntl(uffd, F_GETFD, NULL);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = *features;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
+		err("UFFDIO_API failed.\nPlease make sure to "
+		    "run with either root or ptrace capability.");
+	if (uffdio_api.api != UFFD_API)
+		err("UFFDIO_API error: %" PRIu64, (uint64_t)uffdio_api.api);
+
+	*features = uffdio_api.features;
+}
+
+static inline void munmap_area(void **area)
+{
+	if (*area)
+		if (munmap(*area, nr_pages * page_size))
+			err("munmap");
+
+	*area = NULL;
+}
+
+static void uffd_test_ctx_clear(void)
+{
+	size_t i;
+
+	if (pipefd) {
+		for (i = 0; i < nr_cpus * 2; ++i) {
+			if (close(pipefd[i]))
+				err("close pipefd");
+		}
+		free(pipefd);
+		pipefd = NULL;
+	}
+
+	if (count_verify) {
+		free(count_verify);
+		count_verify = NULL;
+	}
+
+	if (uffd != -1) {
+		if (close(uffd))
+			err("close uffd");
+		uffd = -1;
+	}
+
+	huge_fd_off0 = NULL;
+	munmap_area((void **)&area_src);
+	munmap_area((void **)&area_src_alias);
+	munmap_area((void **)&area_dst);
+	munmap_area((void **)&area_dst_alias);
+}
+
+static void uffd_test_ctx_init_ext(uint64_t *features)
+{
+	unsigned long nr, cpu;
+
+	uffd_test_ctx_clear();
+
+	uffd_test_ops->allocate_area((void **)&area_src);
+	uffd_test_ops->allocate_area((void **)&area_dst);
+
+	uffd_test_ops->release_pages(area_src);
+	uffd_test_ops->release_pages(area_dst);
+
+	userfaultfd_open(features);
+
+	count_verify = malloc(nr_pages * sizeof(unsigned long long));
+	if (!count_verify)
+		err("count_verify");
+
+	for (nr = 0; nr < nr_pages; nr++) {
+		*area_mutex(area_src, nr) =
+			(pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
+		count_verify[nr] = *area_count(area_src, nr) = 1;
+		/*
+		 * In the transition between 255 to 256, powerpc will
+		 * read out of order in my_bcmp and see both bytes as
+		 * zero, so leave a placeholder below always non-zero
+		 * after the count, to avoid my_bcmp to trigger false
+		 * positives.
+		 */
+		*(area_count(area_src, nr) + 1) = 1;
+	}
+
+	pipefd = malloc(sizeof(int) * nr_cpus * 2);
+	if (!pipefd)
+		err("pipefd");
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
+			err("pipe");
+}
+
+static inline void uffd_test_ctx_init(uint64_t features)
+{
+	uffd_test_ctx_init_ext(&features);
+}
+
 static int my_bcmp(char *str1, char *str2, size_t n)
 {
 	unsigned long i;
@@ -726,40 +832,6 @@ static int stress(struct uffd_stats *uffd_stats)
 	return 0;
 }
 
-static int userfaultfd_open_ext(uint64_t *features)
-{
-	struct uffdio_api uffdio_api;
-
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
-	if (uffd < 0) {
-		fprintf(stderr,
-			"userfaultfd syscall not available in this kernel\n");
-		return 1;
-	}
-	uffd_flags = fcntl(uffd, F_GETFD, NULL);
-
-	uffdio_api.api = UFFD_API;
-	uffdio_api.features = *features;
-	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
-		fprintf(stderr, "UFFDIO_API failed.\nPlease make sure to "
-			"run with either root or ptrace capability.\n");
-		return 1;
-	}
-	if (uffdio_api.api != UFFD_API) {
-		fprintf(stderr, "UFFDIO_API error: %" PRIu64 "\n",
-			(uint64_t)uffdio_api.api);
-		return 1;
-	}
-
-	*features = uffdio_api.features;
-	return 0;
-}
-
-static int userfaultfd_open(uint64_t features)
-{
-	return userfaultfd_open_ext(&features);
-}
-
 sigjmp_buf jbuf, *sigbuf;
 
 static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
@@ -868,6 +940,8 @@ static int faulting_process(int signal_test)
 			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
 	if (area_dst == MAP_FAILED)
 		err("mremap");
+	/* Reset area_src since we just clobbered it */
+	area_src = NULL;
 
 	for (; nr < nr_pages; nr++) {
 		count = *area_count(area_dst, nr);
@@ -961,10 +1035,8 @@ static int userfaultfd_zeropage_test(void)
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ctx_init(0);
 
-	if (userfaultfd_open(0))
-		return 1;
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
@@ -981,7 +1053,6 @@ static int userfaultfd_zeropage_test(void)
 		if (my_bcmp(area_dst, zeropage, page_size))
 			err("zeropage is not zero");
 
-	close(uffd);
 	printf("done.\n");
 	return 0;
 }
@@ -999,12 +1070,10 @@ static int userfaultfd_events_test(void)
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
-
 	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
 		UFFD_FEATURE_EVENT_REMOVE;
-	if (userfaultfd_open(features))
-		return 1;
+	uffd_test_ctx_init(features);
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
@@ -1037,8 +1106,6 @@ static int userfaultfd_events_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	close(uffd);
-
 	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != nr_pages;
@@ -1058,11 +1125,9 @@ static int userfaultfd_sig_test(void)
 	printf("testing signal delivery: ");
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
-
 	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
-	if (userfaultfd_open(features))
-		return 1;
+	uffd_test_ctx_init(features);
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
@@ -1103,7 +1168,6 @@ static int userfaultfd_sig_test(void)
 	printf("done.\n");
 	if (userfaults)
 		err("Signal test failed, userfaults: %ld", userfaults);
-	close(uffd);
 
 	return userfaults != 0;
 }
@@ -1126,10 +1190,7 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
-
-	if (userfaultfd_open_ext(&features))
-		return 1;
+	uffd_test_ctx_init_ext(&features);
 	/* If kernel reports the feature isn't supported, skip the test. */
 	if (!(features & UFFD_FEATURE_MINOR_HUGETLBFS)) {
 		printf("skipping test due to lack of feature support\n");
@@ -1183,8 +1244,6 @@ static int userfaultfd_minor_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	close(uffd);
-
 	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
@@ -1196,50 +1255,9 @@ static int userfaultfd_stress(void)
 	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
-	unsigned long cpu;
 	struct uffd_stats uffd_stats[nr_cpus];
 
-	uffd_test_ops->allocate_area((void **)&area_src);
-	if (!area_src)
-		return 1;
-	uffd_test_ops->allocate_area((void **)&area_dst);
-	if (!area_dst)
-		return 1;
-
-	if (userfaultfd_open(0))
-		return 1;
-
-	count_verify = malloc(nr_pages * sizeof(unsigned long long));
-	if (!count_verify) {
-		perror("count_verify");
-		return 1;
-	}
-
-	for (nr = 0; nr < nr_pages; nr++) {
-		*area_mutex(area_src, nr) = (pthread_mutex_t)
-			PTHREAD_MUTEX_INITIALIZER;
-		count_verify[nr] = *area_count(area_src, nr) = 1;
-		/*
-		 * In the transition between 255 to 256, powerpc will
-		 * read out of order in my_bcmp and see both bytes as
-		 * zero, so leave a placeholder below always non-zero
-		 * after the count, to avoid my_bcmp to trigger false
-		 * positives.
-		 */
-		*(area_count(area_src, nr) + 1) = 1;
-	}
-
-	pipefd = malloc(sizeof(int) * nr_cpus * 2);
-	if (!pipefd) {
-		perror("pipefd");
-		return 1;
-	}
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
-		if (pipe2(&pipefd[cpu*2], O_CLOEXEC | O_NONBLOCK)) {
-			perror("pipe");
-			return 1;
-		}
-	}
+	uffd_test_ctx_init(0);
 
 	if (posix_memalign(&area, page_size, page_size))
 		err("out of memory");
@@ -1360,7 +1378,6 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
 
-	close(uffd);
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
-- 
2.31.1.527.g47e6f16901-goog

