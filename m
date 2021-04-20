Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082A33661E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 00:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhDTWIn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 18:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbhDTWIm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 18:08:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68242C06174A
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 15:08:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s2-20020a5b07420000b02904eb842efc40so13330147ybq.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BHYviFd/YPB5fVcgCUB7J8bATrNglnMGKIuCG5hxWmE=;
        b=F0MCudZTC5xOkb1RbDntraZ92HIBRT2ez5Xhnsp+DXLuS8Ep5h2F99v8xIdO5zxY1b
         Ofcj74faZHlYP3e+3wnOZD5ZfzF2jLBMby2Jeiefq2bLIQsWDk7/JWsoMukk7UYrpSyV
         nKtYxWXQfTaV3Qb7U4U55Mf1pliJt3K1GW0Xy+qcsjJVyUQxYiAzbRCpwE5AzkhugM65
         dUWgT4kjntrfbW0RMCruU2f51LKy6LcZBAM2caerJaeA0zjRANie+zQxZlILDItwLDj1
         Lrk57AR8MByVdyJgsNEH6mrlEeMHKFgKXZ0fckx77ByEyHiS6pOa0GxHKc+5Bvhh+cqX
         388g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BHYviFd/YPB5fVcgCUB7J8bATrNglnMGKIuCG5hxWmE=;
        b=f0ETOuLxOW4pYj//0vqY7B+Qn6SWGOBp/nMHOzOiYdHtOTzwCysri+Juy+6hgD6rF7
         m/Ts4O/zaTpxAUdIPDHqWLZwH+1Ly7cbPmMlbisOlgCEjEPmbI0JwYBccVnC619Gsmgf
         PX16eMzSvD0uYhMiGJMk9dCouTx98cF70JJUQm4PP31tWJkuq0brs0x9jVJU1GjIswwF
         j0Ihsu7X0//aSAF9BYkdTR52GpIovq2sCznXmXeHVeLH8BbSvuUJVry40jzpuCDjwUAF
         iYMR9x5x4HiliDaV95iKQIhSG0ZKOgYhJVZ02dxdQF30NrigjYh4bDDIIoxeV7E3eA/u
         EglQ==
X-Gm-Message-State: AOAM533edOwybclPXW2CMg/IImeAPD7hy1RF6LdDW+Ek5kM8YoucnjDP
        SAUIdh8U3e27cRHPRpZYha1wid1eV7S0H8Koz1cr
X-Google-Smtp-Source: ABdhPJz8msn+LFt/WywuGSj91p/Qsj7QaNCaSl+USoDSKPtsRqeJe36wlMPHaxC+iC+8Fegj3k+3HwnxarEYbn2SCSQE
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:bd83:: with SMTP id
 f3mr27137266ybh.29.1618956489545; Tue, 20 Apr 2021 15:08:09 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:07:55 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 01/10] userfaultfd/hugetlbfs: avoid including
 userfaultfd_k.h in hugetlb.h
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

Minimizing header file inclusion is desirable. In this case, we can do
so just by forward declaring the enumeration our signature relies upon.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 4 +++-
 mm/hugetlb.c            | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 09f1fd12a6fa..ca8868cdac16 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,11 +11,11 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
-#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
 struct mmu_gather;
+enum mcopy_atomic_mode;
 
 #ifndef is_hugepd
 typedef struct { unsigned long pd; } hugepd_t;
@@ -135,6 +135,7 @@ void hugetlb_show_meminfo(void);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
+
 #ifdef CONFIG_USERFAULTFD
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
@@ -143,6 +144,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				enum mcopy_atomic_mode mode,
 				struct page **pagep);
 #endif /* CONFIG_USERFAULTFD */
+
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 54d81d5947ed..b1652e747318 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb_cgroup.h>
 #include <linux/node.h>
 #include <linux/page_owner.h>
+#include <linux/userfaultfd_k.h>
 #include "internal.h"
 
 int hugetlb_max_hstate __read_mostly;
-- 
2.31.1.368.gbe11c130af-goog

