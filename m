Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8EF2CF5B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Dec 2020 21:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgLDUgG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Dec 2020 15:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgLDUgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Dec 2020 15:36:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD2DC061A4F
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Dec 2020 12:35:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i184so8456733ybg.7
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Dec 2020 12:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=AnJeit01nF61jllgCw+jNN3EZnXYnoHf3OFvBuHNiIE=;
        b=Q865+I+npgDxO5mvNz7nE0FFszUKiT1oj8XqaBePvExuhcuxk5iaxLW10s5HU4Lrb9
         wu4fX/1igXukDWtsCu7dnMJkGlEroel7nceNG8FxOD/e666FSXT6UliuYkIM8jccC9e5
         CzEvqEuM6aS8yQthD1G02jZ3bKUftXa/Ld3QT8mm0VtUHla15h/qGaDCi3Agd3s22nVW
         zCamj1a1vSCOZTB+v7JZBu0M/5XfPMAQQ7wK5kuzx9nsJg8jDcIROEM4BfI5gpDwM3vv
         Z1RFR8zSQcrSlyqPTjVr9c/M7eb1FPD90an14IUK5Vj/AAvsa7TwO06plQGM6rpUvAlP
         GYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=AnJeit01nF61jllgCw+jNN3EZnXYnoHf3OFvBuHNiIE=;
        b=m8MudxczUpy7lqHOSw3sdsL/ytjv16yW3MaIHUgFpDM/FPfRfbVadOwSakoZ/HFd1F
         XCNs3LLj6LLtP5u3T4znQ6ZDV2dRn8HZijPAmkvcWQCpvDHp4rDiAHww+0Xrc6Vdsm87
         Pqk9YOBTvRFuvEJVtcj/AE9AcyMfCDP/OT+MZKUsSBqt1+Q+722nG06x2EHymJLtL0Ab
         5qZaFh4pYrdmestX4+1b65WuPYpzi8CD5x60P64xQ4eXhJxm/z3q55C8zI0lgYg2s51A
         ZgCHyIkj7WQs0wl+JmjsjmAxVsRekz6OaF9p5gzurYa2MqUsOA8jJl0rM59+biVrVtH7
         fHVA==
X-Gm-Message-State: AOAM530lreZDJElYFbe/fWmvSmgYfqYyGJjqUMhhGaPnLu+leQQJLdnD
        +IqIlOeJWrDLQ7weIreHawtQf6jc/hzcOPpGNYVK
X-Google-Smtp-Source: ABdhPJy6YTdTjZz5Hjir0b8leyA4lBtDy5pKId5K3dU4HmYu5w6p88bf0x2ctmEKd7bTpq8kTkFb8eq8fR2nNUn2x8R6
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:d895:: with SMTP id
 p143mr503872ybg.91.1607114125017; Fri, 04 Dec 2020 12:35:25 -0800 (PST)
Date:   Fri,  4 Dec 2020 12:34:43 -0800
Message-Id: <20201204203443.2714693-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] userfaultfd: selftests: fix SIGSEGV if huge mmap fails
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        David Alan Gilbert <dgilbert@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The error handling in hugetlb_allocate_area() was incorrect for the
hugetlb_shared test case.

Previously the behavior was:

- mmap a hugetlb area
  - If this fails, set the pointer to NULL, and carry on
- mmap an alias of the same hugetlb fd
  - If this fails, munmap the original area

If the original mmap failed, it's likely the second one did too. If
both failed, we'd blindly try to munmap a NULL pointer, causing a
SIGSEGV. Instead, "goto fail" so we return before trying to mmap the
alias.

This issue can be hit "in real life" by forgetting to set
/proc/sys/vm/nr_hugepages (leaving it at 0), and then trying to run the
hugetlb_shared test.

Another small improvement is, when the original mmap fails, don't just
print "it failed": perror(), so we can see *why*. :)

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 25 +++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 9b0912a01777..c4425597769a 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -206,19 +206,19 @@ static int hugetlb_release_pages(char *rel_area)
 	return ret;
 }
 
-
 static void hugetlb_allocate_area(void **alloc_area)
 {
 	void *area_alias = NULL;
 	char **alloc_area_alias;
+
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
 			   MAP_HUGETLB,
 			   huge_fd, *alloc_area == area_src ? 0 :
 			   nr_pages * page_size);
 	if (*alloc_area == MAP_FAILED) {
-		fprintf(stderr, "mmap of hugetlbfs file failed\n");
-		*alloc_area = NULL;
+		perror("mmap of hugetlbfs file failed");
+		goto fail;
 	}
 
 	if (map_shared) {
@@ -227,14 +227,11 @@ static void hugetlb_allocate_area(void **alloc_area)
 				  huge_fd, *alloc_area == area_src ? 0 :
 				  nr_pages * page_size);
 		if (area_alias == MAP_FAILED) {
-			if (munmap(*alloc_area, nr_pages * page_size) < 0) {
-				perror("hugetlb munmap");
-				exit(1);
-			}
-			*alloc_area = NULL;
-			return;
+			perror("mmap of hugetlb file alias failed");
+			goto fail_munmap;
 		}
 	}
+
 	if (*alloc_area == area_src) {
 		huge_fd_off0 = *alloc_area;
 		alloc_area_alias = &area_src_alias;
@@ -243,6 +240,16 @@ static void hugetlb_allocate_area(void **alloc_area)
 	}
 	if (area_alias)
 		*alloc_area_alias = area_alias;
+
+	return;
+
+fail_munmap:
+	if (munmap(*alloc_area, nr_pages * page_size) < 0) {
+		perror("hugetlb munmap");
+		exit(1);
+	}
+fail:
+	*alloc_area = NULL;
 }
 
 static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
-- 
2.29.2.576.ga3fc446d84-goog

