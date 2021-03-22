Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF88934511D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCVUtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhCVUsz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 16:48:55 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7289C061574
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Mar 2021 13:48:54 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id x20so239664qvd.21
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Mar 2021 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qLtE7Q7O336Jr0xZrje9a6J8mVVfCsw4DlLIJJKkdv8=;
        b=qhnxD7UOUyW2EyGJrUhKII5iqbLDIC0i63t3PapQiA28sK5rBwE+j7RIaM2f0S1LXa
         0zzFB/if4Hn5zXCLfxYIwCMKqzTmjc+DR/Y99e/w6V56JM7+bL6XkIl3d4raLenafKKe
         XGlFYlfznWFJWE/zUzXuAAM8G+jU/tKjkNpuFb8XvMycK3+MlwuzOCK+LtXuAB2Ofs7d
         pvSYDfM4ApnwE+GTaX2th2gnll9nZYCPKPTyI3gnmqFwpcPoQr0zUWLGhuTF2Lq21FlC
         +f95/vtfOiCHQamP3P435yVYxIm/RKM9FlMZmNELc0hzVB34+10mMaq8uFvlJdyqTrbJ
         CVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qLtE7Q7O336Jr0xZrje9a6J8mVVfCsw4DlLIJJKkdv8=;
        b=ooor4k5MKU0vPeLRmCBW7u6fiw7duavUS2ulmkHqmbjsGcm8XcJUPeDLTQVsVWnvRj
         SQyTTuvfWE+FWmy/tjN6IQkBlYzoNNEHc/wginHYcLLqyc1ELz3HDgo34JM++vGtm6v6
         Z3NiCi9TYn+oY6XMaylBIglzeV6uqYa90kksVgHNbWgFTD2SdClz3ombFHKHrLzMotUO
         tqKX5WciOUBWFCRQN/6Pfc70XA0IXmbny356F8kE/F8F11foPgJEKi7aGrkbBd/+xBgg
         QDtmHhkk+027fvG2zbtdtyq1jGPVv6YNWcuqZaDxB/sZH786D4id5wNhSD/EO87TOB9x
         9zEA==
X-Gm-Message-State: AOAM532a1BMiRBEdBSZ3gWdHTscjNOBr7IuytXGvk31vh090QvuDH7KS
        gjupDfp9Hr7uvYlAGyrhnYtX9ylgc715IzBlbBGe
X-Google-Smtp-Source: ABdhPJwWMDOeA+n+91jwJi4YMPmlBexpd3rTePiPuanO5jlXlCFfbUZAzUxKXMfWUSyqODoOyan+18PMKUY4TmLpvV7U
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d23:3b75:1338:2e4e])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:59c6:: with SMTP id
 el6mr1615660qvb.15.1616446134063; Mon, 22 Mar 2021 13:48:54 -0700 (PDT)
Date:   Mon, 22 Mar 2021 13:48:35 -0700
Message-Id: <20210322204836.1650221-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] userfaultfd/shmem: fix minor fault page leak
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

This fix is analogous to Peter Xu's fix for hugetlb [0]. If we don't
put_page() after getting the page out of the page cache, we leak the
reference.

The fix can be verified by checking /proc/meminfo and running the
userfaultfd selftest in shmem mode. Without the fix, we see MemFree /
MemAvailable steadily decreasing with each run of the test. With the
fix, memory is correctly freed after the test program exits.

Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index ef8c9f5e92fc..d2e0e81b7d2e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1831,6 +1831,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	if (page && vma && userfaultfd_minor(vma)) {
 		unlock_page(page);
+		put_page(page);
 		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
 		return 0;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

