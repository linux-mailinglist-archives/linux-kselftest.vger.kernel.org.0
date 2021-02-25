Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92B63248CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Feb 2021 03:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbhBYCQG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Feb 2021 21:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbhBYCQE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Feb 2021 21:16:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D1C061797
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Feb 2021 18:14:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p136so4414937ybc.21
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Feb 2021 18:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Wsf3wQJ6PA4c9ETePQNJDQHCAHI/WWgAnlx+OWV4bpw=;
        b=CbQ2rMmAZMMcceblmx0O5IulyfBywI4yTEyAqBybQTjDK8thxsjxQ5f9jCCXbHHp97
         F87FNrywOznuMwvpzHJvInBxFS4+87ErdGxwpVsX2n8kiQ6r8Ul/Zc7qY4617hLjgDIY
         Hc4qsl5dqHqU6QurW4LsfHGtmDEzqSHM+No0BZ96Dz7beOC4NmXeZELFJx6QT2GhnoGC
         8JiC+pJ9M1Bc/vRShXszCtqO/FrSQaXKhkeFW6WIWO7sWQLuDmII7w/coUWpXl73awse
         AXk5aJvQqQqv2aGWwTiFn3aMLExVkkT8N/DYGn7e+g0e3dotdL555YZRpis8rEoizwZv
         JDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wsf3wQJ6PA4c9ETePQNJDQHCAHI/WWgAnlx+OWV4bpw=;
        b=MNUCjkX9VmiaqZFtC/fCWfcVHLuvEbzF5NqNdWiLl4kOWOE64D/zogwRLG129YtcAv
         OyR9l8OLK30tN7ZptsUTtZHEoxvWgzotUpN8XSo84Wgy9OTvo1VOIBQeTSznj199il/l
         x0W6FKLEEG66H3m05SavKhxyA0dz6s3rJf3ep7NfZuPmhriXwfa0DpcX6ouBahjQsagM
         kZf8jEc7igpT7u5/KjAnuVH5j7jcuzxL4Y+TTASqnSISTZ94sHSohrYwPHn9BmiZMDjU
         yiU7PO6UXkmejWaqINc5WIfaO7By+Szz/tzfJdio+blVp8Rga4S3dYNB419SrG1YmpIZ
         gwYA==
X-Gm-Message-State: AOAM531knJmSl+XLcARCa8klfW+Vzq2uI9tXlyCS8KqPvYV/IOWJTL9y
        7dAA5z/CD1HUqaIhH4vcJ26Fc+4kuJOLZAdZ8hCQ
X-Google-Smtp-Source: ABdhPJz3JdPTE0BJGsvdyAb36TJ8+FW6jBMfIj9Jl8R4YVT2VnFQtOBcFEEOddn1zrGANO2N71Ai6FGoDBaKecB3LQ3V
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:9d2:: with SMTP id
 y18mr825166ybq.173.1614219286113; Wed, 24 Feb 2021 18:14:46 -0800 (PST)
Date:   Wed, 24 Feb 2021 18:14:18 -0800
In-Reply-To: <20210225021420.2290912-1-axelrasmussen@google.com>
Message-Id: <20210225021420.2290912-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210225021420.2290912-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 3/5] userfaultfd/selftests: create alias mappings in the shmem test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, we just allocated two shm areas: area_src and area_dst. With
this commit, change this so we also allocate area_src_alias, and
area_dst_alias.

area_*_alias and area_* (respectively) point to the same underlying
physical pages, but are different VMAs. In a future commit in this
series, we'll leverage this setup to exercise minor fault handling
support for shmem, just like we do in the hugetlb_shared test.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 29 +++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 859398efb4fe..4a18590fe0f8 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -298,8 +298,9 @@ static int shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
-	unsigned long offset =
-		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+	void *area_alias = NULL;
+	bool is_src = alloc_area == (void **)&area_src;
+	unsigned long offset = is_src ? 0 : nr_pages * page_size;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_SHARED, shm_fd, offset);
@@ -308,12 +309,34 @@ static void shmem_allocate_area(void **alloc_area)
 		goto fail;
 	}
 
+	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+			  MAP_SHARED, shm_fd, offset);
+	if (area_alias == MAP_FAILED) {
+		perror("mmap of memfd alias failed");
+		goto fail_munmap;
+	}
+
+	if (is_src)
+		area_src_alias = area_alias;
+	else
+		area_dst_alias = area_alias;
+
 	return;
 
+fail_munmap:
+	if (munmap(*alloc_area, nr_pages * page_size) < 0) {
+		perror("munmap of memfd failed\n");
+		exit(1);
+	}
 fail:
 	*alloc_area = NULL;
 }
 
+static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	*start = (unsigned long)area_dst_alias + offset;
+}
+
 struct uffd_test_ops {
 	unsigned long expected_ioctls;
 	void (*allocate_area)(void **alloc_area);
@@ -341,7 +364,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
-	.alias_mapping = noop_alias_mapping,
+	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-- 
2.30.0.617.g56c4b15f3c-goog

