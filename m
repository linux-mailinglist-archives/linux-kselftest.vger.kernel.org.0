Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE1349CBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Mar 2021 00:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCYXLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Mar 2021 19:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhCYXKv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Mar 2021 19:10:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC5C061760
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Mar 2021 16:10:51 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c7so4986124qka.6
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Mar 2021 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=T2/d6sZyO3fSLr0PvTyvQEiPcFUt7lX67rgAyw6h6Ns=;
        b=h1bf0BOjFAAjZ/OJMNbkTZfB+WyBmaMPewReLf9ogiiamNakB307KnJZ1bBBZ6jQx4
         RhvZ7FB1Zy5NiTFlsZRnFckjMVZE+oPiW/9bSdixYnWeikINQcxUDOLhXqTOAzfOL69g
         to40oavQvU4+P9dWA6DH+L2rLLSkjH6RFKUkWYMvv4tzPCiXSbasYU7KGMxlNJA2PazK
         7f5loxZFJ5lt3xvZHobDUz3iiK38332zizKGS9eGxDdIcYSNdDf3dEUFSBrdR9HUw9bj
         5vAmjPh6Iq8wy5yJFYDZbTtXaDuW8ZOJ32Tj0Mai5IQgkwT0X2ldZKLWZc4zBWLumNG0
         Ruzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=T2/d6sZyO3fSLr0PvTyvQEiPcFUt7lX67rgAyw6h6Ns=;
        b=qxfh61iBElHUDTEeetjFwqWhg5jFmvxdPipgz0wNTyPBLH1y2qjIF7pOiGHVXeZJUd
         ZbQYhQUWUwVw5kBhP64I8XQFljszvaehwPZah+9S3AmVjj3YqVB1sKTJ3r1u6CIdM9De
         F9Y9Ce6R5f2zTfD9Qxdy1V4xhtenj2gLWAGOJr43UqbiktdhIStPcofpTysNHyMYMzYg
         EogJlIWJBZYqzEJxYYSFKqUwJV7lKbDLb5FeZ881+eO/cIbtTdwjrNIzQaLC3XSvKaxC
         EEzoDI8brmQfgFKGFC44vbowV7Nj2cdTTdC4QD6y55RbYqAEdXFi1hCzfN47xclc5m6/
         A5Qg==
X-Gm-Message-State: AOAM530eECSEHHcLQ1IuPYnc0nNrnSRDNePrEmzngjEBNlkleBCQlOG1
        I8Fp1bdNa1uOlSWJUW4yy2z1Mv86ZWva1uhO5592
X-Google-Smtp-Source: ABdhPJw8sxtVyVhdnPIHQmvOxevJeP2dQ9vkgim0lT9MuGC04CoGm+vtIGdtJVY8Vo4Ddkm5VWU/0lUxFwlOWuSixZdF
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:74e9:775f:faff:48d0])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4e53:: with SMTP id
 eb19mr10977331qvb.8.1616713850395; Thu, 25 Mar 2021 16:10:50 -0700 (PDT)
Date:   Thu, 25 Mar 2021 16:10:27 -0700
Message-Id: <20210325231027.3402321-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTNUE error handling + accounting
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
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
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

Previously, in the error path, we unconditionally removed the page from
the page cache. But in the continue case, we didn't add it - it was
already there because the page is used by a second (non-UFFD-registered)
mapping. So, in that case, it's incorrect to remove it as the other
mapping may still use it normally.

For this error handling failure, trivially exercise it in the
userfaultfd selftest, to detect this kind of bug in the future.

Also, we previously were unconditionally calling shmem_inode_acct_block.
In the continue case, however, this is incorrect, because we would have
already accounted for the RAM usage when the page was originally
allocated (since at this point it's already in the page cache). So,
doing it in the continue case causes us to double-count.

Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/shmem.c                               | 15 ++++++++++-----
 tools/testing/selftests/vm/userfaultfd.c | 12 ++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d2e0e81b7d2e..5ac8ea737004 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2379,9 +2379,11 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	int ret;
 	pgoff_t offset, max_off;
 
-	ret = -ENOMEM;
-	if (!shmem_inode_acct_block(inode, 1))
-		goto out;
+	if (!is_continue) {
+		ret = -ENOMEM;
+		if (!shmem_inode_acct_block(inode, 1))
+			goto out;
+	}
 
 	if (is_continue) {
 		ret = -EFAULT;
@@ -2389,6 +2391,7 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 		if (!page)
 			goto out_unacct_blocks;
 	} else if (!*pagep) {
+		ret = -ENOMEM;
 		page = shmem_alloc_page(gfp, info, pgoff);
 		if (!page)
 			goto out_unacct_blocks;
@@ -2486,12 +2489,14 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 out_release_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
 	ClearPageDirty(page);
-	delete_from_page_cache(page);
+	if (!is_continue)
+		delete_from_page_cache(page);
 out_release:
 	unlock_page(page);
 	put_page(page);
 out_unacct_blocks:
-	shmem_inode_unacct_blocks(inode, 1);
+	if (!is_continue)
+		shmem_inode_unacct_blocks(inode, 1);
 	goto out;
 }
 #endif /* CONFIG_USERFAULTFD */
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index f6c86b036d0f..d8541a59dae5 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -485,6 +485,7 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 static void continue_range(int ufd, __u64 start, __u64 len)
 {
 	struct uffdio_continue req;
+	int ret;
 
 	req.range.start = start;
 	req.range.len = len;
@@ -493,6 +494,17 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
 		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
 		    (uint64_t)start);
+
+	/*
+	 * Error handling within the kernel for continue is subtly different
+	 * from copy or zeropage, so it may be a source of bugs. Trigger an
+	 * error (-EEXIST) on purpose, to verify doing so doesn't cause a BUG.
+	 */
+	req.mapped = 0;
+	ret = ioctl(ufd, UFFDIO_CONTINUE, &req);
+	if (ret >= 0 || req.mapped != -EEXIST)
+		err("failed to exercise UFFDIO_CONTINUE error handling, ret=%d, mapped=%" PRId64,
+		    ret, req.mapped);
 }
 
 static void *locking_thread(void *arg)
-- 
2.31.0.291.g576ba9dcdaf-goog

