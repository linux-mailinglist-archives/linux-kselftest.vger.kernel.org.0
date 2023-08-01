Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A05976B52B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHAMu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjHAMuT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 08:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2A72100
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi/J18RARw6/Qxc4oFoZIMtkW25pVX+KOdV/ft2I3Ss=;
        b=bmEXKHvgaEP3+jJCZSMqHGL4DK9+aKrGpJeU/jEnbzyzzN9hofiThqjnP053mbtSF20OY0
        Be8XKb/bQpT6LHJsHUCgyw6Cce1CL9aEtcDHeUpLX5w6sNAEM2ysz4MzALLWpfbu3+ZZVi
        1h0Kqn40nmNsUaS4MOGnI+2msZwfQ6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-oN0NdSRGOK6hQjSuybYWtw-1; Tue, 01 Aug 2023 08:49:27 -0400
X-MC-Unique: oN0NdSRGOK6hQjSuybYWtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73D17805C10;
        Tue,  1 Aug 2023 12:49:26 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75021C585A0;
        Tue,  1 Aug 2023 12:49:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 8/8] selftest/mm: ksm_functional_tests: Add PROT_NONE test
Date:   Tue,  1 Aug 2023 14:48:44 +0200
Message-ID: <20230801124844.278698-9-david@redhat.com>
In-Reply-To: <20230801124844.278698-1-david@redhat.com>
References: <20230801124844.278698-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's test whether merging and unmerging in PROT_NONE areas works as
expected.

Pass a page protection to mmap_and_merge_range(), which will trigger
an mprotect() after writing to the pages, but before enabling merging.

Make sure that unsharing works as expected, by performing a ptrace write
(using /proc/self/mem) and by setting MADV_UNMERGEABLE.

Note that this implicitly tests that ptrace writes in an inaccessible
(PROT_NONE) mapping work as expected.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 59 ++++++++++++++++---
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index cb63b600cb4f..8fa4889ab4f3 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -27,6 +27,7 @@
 #define KiB 1024u
 #define MiB (1024 * KiB)
 
+static int mem_fd;
 static int ksm_fd;
 static int ksm_full_scans_fd;
 static int proc_self_ksm_stat_fd;
@@ -144,7 +145,8 @@ static int ksm_unmerge(void)
 	return 0;
 }
 
-static char *mmap_and_merge_range(char val, unsigned long size, bool use_prctl)
+static char *mmap_and_merge_range(char val, unsigned long size, int prot,
+				  bool use_prctl)
 {
 	char *map;
 	int ret;
@@ -176,6 +178,11 @@ static char *mmap_and_merge_range(char val, unsigned long size, bool use_prctl)
 	/* Make sure each page contains the same values to merge them. */
 	memset(map, val, size);
 
+	if (mprotect(map, size, prot)) {
+		ksft_test_result_skip("mprotect() failed\n");
+		goto unmap;
+	}
+
 	if (use_prctl) {
 		ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
 		if (ret < 0 && errno == EINVAL) {
@@ -218,7 +225,7 @@ static void test_unmerge(void)
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
-	map = mmap_and_merge_range(0xcf, size, false);
+	map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, false);
 	if (map == MAP_FAILED)
 		return;
 
@@ -256,7 +263,7 @@ static void test_unmerge_zero_pages(void)
 	}
 
 	/* Let KSM deduplicate zero pages. */
-	map = mmap_and_merge_range(0x00, size, false);
+	map = mmap_and_merge_range(0x00, size, PROT_READ | PROT_WRITE, false);
 	if (map == MAP_FAILED)
 		return;
 
@@ -304,7 +311,7 @@ static void test_unmerge_discarded(void)
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
-	map = mmap_and_merge_range(0xcf, size, false);
+	map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, false);
 	if (map == MAP_FAILED)
 		return;
 
@@ -336,7 +343,7 @@ static void test_unmerge_uffd_wp(void)
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
-	map = mmap_and_merge_range(0xcf, size, false);
+	map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, false);
 	if (map == MAP_FAILED)
 		return;
 
@@ -479,7 +486,7 @@ static void test_prctl_unmerge(void)
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
-	map = mmap_and_merge_range(0xcf, size, true);
+	map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, true);
 	if (map == MAP_FAILED)
 		return;
 
@@ -494,9 +501,42 @@ static void test_prctl_unmerge(void)
 	munmap(map, size);
 }
 
+static void test_prot_none(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+	int i;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	map = mmap_and_merge_range(0x11, size, PROT_NONE, false);
+	if (map == MAP_FAILED)
+		goto unmap;
+
+	/* Store a unique value in each page on one half using ptrace */
+	for (i = 0; i < size / 2; i += pagesize) {
+		lseek(mem_fd, (uintptr_t) map + i, SEEK_SET);
+		if (write(mem_fd, &i, sizeof(size)) != sizeof(size)) {
+			ksft_test_result_fail("ptrace write failed\n");
+			goto unmap;
+		}
+	}
+
+	/* Trigger unsharing on the other half. */
+	if (madvise(map + size / 2, size / 2, MADV_UNMERGEABLE)) {
+		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
+		goto unmap;
+	}
+
+	ksft_test_result(!range_maps_duplicates(map, size),
+			 "Pages were unmerged\n");
+unmap:
+	munmap(map, size);
+}
+
 int main(int argc, char **argv)
 {
-	unsigned int tests = 6;
+	unsigned int tests = 7;
 	int err;
 
 #ifdef __NR_userfaultfd
@@ -508,6 +548,9 @@ int main(int argc, char **argv)
 
 	pagesize = getpagesize();
 
+	mem_fd = open("/proc/self/mem", O_RDWR);
+	if (mem_fd < 0)
+		ksft_exit_fail_msg("opening /proc/self/mem failed\n");
 	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
 	if (ksm_fd < 0)
 		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/run\") failed\n");
@@ -529,6 +572,8 @@ int main(int argc, char **argv)
 	test_unmerge_uffd_wp();
 #endif
 
+	test_prot_none();
+
 	test_prctl();
 	test_prctl_fork();
 	test_prctl_unmerge();
-- 
2.41.0

