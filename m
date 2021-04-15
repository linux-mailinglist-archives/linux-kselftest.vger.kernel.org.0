Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9632361253
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhDOSsD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhDOSsC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 14:48:02 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EDEC061756
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 1-20020aed31010000b029019d1c685840so4625950qtg.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BHYviFd/YPB5fVcgCUB7J8bATrNglnMGKIuCG5hxWmE=;
        b=nbZDAI2t1tEIDKCN/R/T2PG8dcUxRyJ5P2spKm+max9ERxY1ssfwywTbzRFe8loB+i
         lY2qDWkUELrFSOo8dzG3izekfJjHzMeICxuIBktECtcWRxF247KYabg8JgIvIaACDuBY
         IIzAwbxpc2vL85XLU2PWPys32uA3iJIc96CEOth4ouBL/d80aHAmad8eslMs4pkf4HRt
         y2VVAiTFxniPoFvHOdZ3izblDIRTZmCWMx6SXHGH66fvRs4R5zauAma9IzFKna2E7Nnu
         s41q6dO+C7dRMsZFcdddS9qpG8kXJJ3Y5+9UsZYX04m/rhxUIE4j884TycYq3faLnEl4
         fmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BHYviFd/YPB5fVcgCUB7J8bATrNglnMGKIuCG5hxWmE=;
        b=hqc9dZ+XOh8Jj0hFR+QLvN6pBTCAlSwVya+C81EJCMYMwwaTu6j4edYcNdAZkeZxAS
         GLNMlpZ4gLfP05sJa6OPg99c1U6oOvu5K2jfPMdmQE6vqHYzo8nNvnrH2808tD5Kz36B
         WmAdrOO91cVgXz8nTcrXZ6qiHm2+vVahoqpU8SFmNH+XCG7D9z1e5Vzh3vk1RnpPmtDx
         opvuxfupqj0COEH6qo8qE03vfex2tRul4RfE0BTjrSENRjVxG5V51yF7QifRc8VGM0bJ
         VZfTgPRZ0MR0rw/KglHuAKe5ee2XZCzOj3E2TSdUumJAnnZoh1Uc8tceBOodQP6ccvwR
         IAGA==
X-Gm-Message-State: AOAM5319zpBzV+OHQ3y3rOB4m6gMewJCNTDkicpRM+hUzjQsj/ulQFi0
        kRnjPkSlD1I6AFiYzBrJ1q9WTlpOYhm7Qz8DhPPl
X-Google-Smtp-Source: ABdhPJwhZ329hEZwzrn6JRkkNZum7Dd+mwZqJ2rsIfyQZ2kiGU/gbr5Dsvp4wsh28v/muOZE9K5zt/PgEl2S+s4DtBv6
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:21b1:6e5c:b371:7e3])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:fc12:: with SMTP id
 z18mr4779788qvo.38.1618512457568; Thu, 15 Apr 2021 11:47:37 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:23 -0700
In-Reply-To: <20210415184732.3410521-1-axelrasmussen@google.com>
Message-Id: <20210415184732.3410521-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210415184732.3410521-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 01/10] userfaultfd/hugetlbfs: avoid including
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

