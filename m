Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330696DDD83
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjDKORi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjDKORT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209FD44A5
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2z0ZWpIzSXqyEF2KVa3LzGMQGesZiayZZfA3zEW/CRA=;
        b=i7xA683QecK7GaRMRLYmiQ4SE5WOlUUnD+wPZqhqTqpyLVq0FPlATKFZepDeu8Pk+IZAXZ
        yvRh0BskVXSLtF3Ih/kRhezjXH2lwuygsJupKHAbnSshwUBCQlODvu3ed9oIjQxLIgyHqi
        7p7lHFvrx0DIFl974VNSIX/qvJxpb0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-KgYERSC9NFGw5yGLnWJkng-1; Tue, 11 Apr 2023 10:15:46 -0400
X-MC-Unique: KgYERSC9NFGw5yGLnWJkng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFDC888718F;
        Tue, 11 Apr 2023 14:15:37 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50396400F281;
        Tue, 11 Apr 2023 14:15:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 1/6] selftests/mm: reuse read_pmd_pagesize() in COW selftest
Date:   Tue, 11 Apr 2023 16:15:24 +0200
Message-Id: <20230411141529.428991-3-david@redhat.com>
In-Reply-To: <20230411141529.428991-1-david@redhat.com>
References: <20230411141529.428991-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The COW selftest can deal with THP not being configured. So move error
handling of read_pmd_pagesize() into the callers such that we can reuse
it in the COW selftest.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/cow.c              | 33 +++----------------
 tools/testing/selftests/mm/khugepaged.c       |  4 +++
 tools/testing/selftests/mm/soft-dirty.c       |  3 ++
 .../selftests/mm/split_huge_page_test.c       |  4 +++
 tools/testing/selftests/mm/vm_util.c          |  4 +--
 5 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 0eb2e8180aa5..dc9d6fe86028 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -45,34 +45,6 @@ static size_t hugetlbsizes[10];
 static int gup_fd;
 static bool has_huge_zeropage;
 
-static void detect_thpsize(void)
-{
-	int fd = open("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size",
-		      O_RDONLY);
-	size_t size = 0;
-	char buf[15];
-	int ret;
-
-	if (fd < 0)
-		return;
-
-	ret = pread(fd, buf, sizeof(buf), 0);
-	if (ret > 0 && ret < sizeof(buf)) {
-		buf[ret] = 0;
-
-		size = strtoul(buf, NULL, 10);
-		if (size < pagesize)
-			size = 0;
-		if (size > 0) {
-			thpsize = size;
-			ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
-				       thpsize / 1024);
-		}
-	}
-
-	close(fd);
-}
-
 static void detect_huge_zeropage(void)
 {
 	int fd = open("/sys/kernel/mm/transparent_hugepage/use_zero_page",
@@ -1741,7 +1713,10 @@ int main(int argc, char **argv)
 	int err;
 
 	pagesize = getpagesize();
-	detect_thpsize();
+	thpsize = read_pmd_pagesize();
+	if (thpsize)
+		ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
+			       thpsize / 1024);
 	detect_hugetlbsizes();
 	detect_huge_zeropage();
 
diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 64126c8cd561..97adc0f34f9c 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1476,6 +1476,10 @@ int main(int argc, const char **argv)
 
 	page_size = getpagesize();
 	hpage_pmd_size = read_pmd_pagesize();
+	if (!hpage_pmd_size) {
+		printf("Reading PMD pagesize failed");
+		exit(EXIT_FAILURE);
+	}
 	hpage_pmd_nr = hpage_pmd_size / page_size;
 
 	default_settings.khugepaged.max_ptes_none = hpage_pmd_nr - 1;
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 21d8830c5f24..cc5f144430d4 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -80,6 +80,9 @@ static void test_hugepage(int pagemap_fd, int pagesize)
 	int i, ret;
 	size_t hpage_len = read_pmd_pagesize();
 
+	if (!hpage_len)
+		ksft_exit_fail_msg("Reading PMD pagesize failed");
+
 	map = memalign(hpage_len, hpage_len);
 	if (!map)
 		ksft_exit_fail_msg("memalign failed\n");
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 76e1c36dd9e5..1dc5804b8b2b 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -300,6 +300,10 @@ int main(int argc, char **argv)
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
 	pmd_pagesize = read_pmd_pagesize();
+	if (!pmd_pagesize) {
+		printf("Reading PMD pagesize failed\n");
+		exit(EXIT_FAILURE);
+	}
 
 	split_pmd_thp();
 	split_pte_mapped_thp();
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 40e795624ff3..8dc74dd022c2 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -84,12 +84,12 @@ uint64_t read_pmd_pagesize(void)
 
 	fd = open(PMD_SIZE_FILE_PATH, O_RDONLY);
 	if (fd == -1)
-		ksft_exit_fail_msg("Open hpage_pmd_size failed\n");
+		return 0;
 
 	num_read = read(fd, buf, 19);
 	if (num_read < 1) {
 		close(fd);
-		ksft_exit_fail_msg("Read hpage_pmd_size failed\n");
+		return 0;
 	}
 	buf[num_read] = '\0';
 	close(fd);
-- 
2.39.2

