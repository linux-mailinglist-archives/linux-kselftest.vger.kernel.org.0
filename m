Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE407094C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjESK2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjESK2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 06:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987ACE5D
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 03:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684492053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLvUTdqG6kUaomJpPJAHiks49sHH2kzed8PToxtufB8=;
        b=gv5vF6Ptj7/8B1R0r3gW7sJUT2xhLEgkZs5xKEwQZbgqqlVJnF4C4kWltrV95DzuA1yV15
        vs/bkbBdE8H1QPxt+vRcZYUj6rDioQ9pkDvn/QGXI+xdv6b5jZvAcJHb/wN1K4+23G5v8z
        gdNUOGtBxvzbyiO3LfZkzSB0fkG3Sck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-9sijunIrNxO-3wCpyPKkqg-1; Fri, 19 May 2023 06:27:30 -0400
X-MC-Unique: 9sijunIrNxO-3wCpyPKkqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 172C7185A792;
        Fri, 19 May 2023 10:27:30 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA9222166B25;
        Fri, 19 May 2023 10:27:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v1 1/3] selftests/mm: factor out detection of hugetlb page sizes into vm_util
Date:   Fri, 19 May 2023 12:27:21 +0200
Message-Id: <20230519102723.185721-2-david@redhat.com>
In-Reply-To: <20230519102723.185721-1-david@redhat.com>
References: <20230519102723.185721-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's factor detection out into vm_util, to be reused by a new test.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/cow.c     | 29 ++--------------------------
 tools/testing/selftests/mm/vm_util.c | 27 ++++++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h |  1 +
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index dc9d6fe86028..7f3b620d9cb7 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -14,7 +14,6 @@
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
-#include <dirent.h>
 #include <assert.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
@@ -70,31 +69,6 @@ static void detect_huge_zeropage(void)
 	close(fd);
 }
 
-static void detect_hugetlbsizes(void)
-{
-	DIR *dir = opendir("/sys/kernel/mm/hugepages/");
-
-	if (!dir)
-		return;
-
-	while (nr_hugetlbsizes < ARRAY_SIZE(hugetlbsizes)) {
-		struct dirent *entry = readdir(dir);
-		size_t kb;
-
-		if (!entry)
-			break;
-		if (entry->d_type != DT_DIR)
-			continue;
-		if (sscanf(entry->d_name, "hugepages-%zukB", &kb) != 1)
-			continue;
-		hugetlbsizes[nr_hugetlbsizes] = kb * 1024;
-		nr_hugetlbsizes++;
-		ksft_print_msg("[INFO] detected hugetlb size: %zu KiB\n",
-			       kb);
-	}
-	closedir(dir);
-}
-
 static bool range_is_swapped(void *addr, size_t size)
 {
 	for (; size; addr += pagesize, size -= pagesize)
@@ -1717,7 +1691,8 @@ int main(int argc, char **argv)
 	if (thpsize)
 		ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
 			       thpsize / 1024);
-	detect_hugetlbsizes();
+	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
+						    ARRAY_SIZE(hugetlbsizes));
 	detect_huge_zeropage();
 
 	ksft_print_header();
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 9b06a5034808..5cf84d860076 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 #include <fcntl.h>
+#include <dirent.h>
 #include <sys/ioctl.h>
 #include <linux/userfaultfd.h>
 #include <sys/syscall.h>
@@ -198,6 +199,32 @@ unsigned long default_huge_page_size(void)
 	return hps;
 }
 
+int detect_hugetlb_page_sizes(size_t sizes[], int max)
+{
+	DIR *dir = opendir("/sys/kernel/mm/hugepages/");
+	int count = 0;
+
+	if (!dir)
+		return 0;
+
+	while (count < max) {
+		struct dirent *entry = readdir(dir);
+		size_t kb;
+
+		if (!entry)
+			break;
+		if (entry->d_type != DT_DIR)
+			continue;
+		if (sscanf(entry->d_name, "hugepages-%zukB", &kb) != 1)
+			continue;
+		sizes[count++] = kb * 1024;
+		ksft_print_msg("[INFO] detected hugetlb page size: %zu KiB\n",
+			       kb);
+	}
+	closedir(dir);
+	return count;
+}
+
 /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls)
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b950bd16083a..99b795528716 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -44,6 +44,7 @@ bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
+int detect_hugetlb_page_sizes(size_t sizes[], int max);
 
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
-- 
2.40.1

