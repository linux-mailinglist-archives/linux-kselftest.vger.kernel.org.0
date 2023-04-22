Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7D6EBB5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 22:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDVUzc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Apr 2023 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjDVUzb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Apr 2023 16:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360C10F5
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Apr 2023 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682196883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=On9gaPWUj2gDwc8v5O2MPdxyKHVxh4guNHZMK6fskK4=;
        b=XYcJQ+jJLtxfp0TxwbrxA/SrEWKc+YMsIbp6xofgzbjco6N+FOUDN/OUPeimJmAB+M/mqh
        3gnIjScVhomHoHv84ei5lNrb8DsIBMvIAfJpaSXPgl3dm4zRveHUmuQcyKgbKUIBkKpSdI
        UCZ/7d1ALvYc8i2K47ueCadMVpiJUw8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-5rH3yC36P-a5ZrO3rh9FCA-1; Sat, 22 Apr 2023 16:54:40 -0400
X-MC-Unique: 5rH3yC36P-a5ZrO3rh9FCA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C80E1C0514D;
        Sat, 22 Apr 2023 20:54:39 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22953492B03;
        Sat, 22 Apr 2023 20:54:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH mm-stable v2 1/3] mm/ksm: unmerge and clear VM_MERGEABLE when setting PR_SET_MEMORY_MERGE=0
Date:   Sat, 22 Apr 2023 22:54:18 +0200
Message-Id: <20230422205420.30372-2-david@redhat.com>
In-Reply-To: <20230422205420.30372-1-david@redhat.com>
References: <20230422205420.30372-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's unmerge any KSM pages when setting PR_SET_MEMORY_MERGE=0, and clear
the VM_MERGEABLE flag from all VMAs -- just like KSM would. Of course,
only do that if we previously set PR_SET_MEMORY_MERGE=1.

Acked-by: Stefan Roesch <shr@devkernel.io>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/ksm.h |  1 +
 kernel/sys.c        | 12 +++------
 mm/ksm.c            | 59 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 7a9b76fb6c3f..429efa6ff4ae 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -21,6 +21,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 
 void ksm_add_vma(struct vm_area_struct *vma);
 int ksm_enable_merge_any(struct mm_struct *mm);
+int ksm_disable_merge_any(struct mm_struct *mm);
 
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
diff --git a/kernel/sys.c b/kernel/sys.c
index 72cdb16e2636..339fee3eff6a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2695,16 +2695,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (mmap_write_lock_killable(me->mm))
 			return -EINTR;
 
-		if (arg2) {
+		if (arg2)
 			error = ksm_enable_merge_any(me->mm);
-		} else {
-			/*
-			 * TODO: we might want disable KSM on all VMAs and
-			 * trigger unsharing to completely disable KSM.
-			 */
-			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
-			error = 0;
-		}
+		else
+			error = ksm_disable_merge_any(me->mm);
 		mmap_write_unlock(me->mm);
 		break;
 	case PR_GET_MEMORY_MERGE:
diff --git a/mm/ksm.c b/mm/ksm.c
index 9e48258985d2..823bb3475a68 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2520,6 +2520,22 @@ static void __ksm_add_vma(struct vm_area_struct *vma)
 		vm_flags_set(vma, VM_MERGEABLE);
 }
 
+static int __ksm_del_vma(struct vm_area_struct *vma)
+{
+	int err;
+
+	if (!(vma->vm_flags & VM_MERGEABLE))
+		return 0;
+
+	if (vma->anon_vma) {
+		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end);
+		if (err)
+			return err;
+	}
+
+	vm_flags_clear(vma, VM_MERGEABLE);
+	return 0;
+}
 /**
  * ksm_add_vma - Mark vma as mergeable if compatible
  *
@@ -2542,6 +2558,20 @@ static void ksm_add_vmas(struct mm_struct *mm)
 		__ksm_add_vma(vma);
 }
 
+static int ksm_del_vmas(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	int err;
+
+	VMA_ITERATOR(vmi, mm, 0);
+	for_each_vma(vmi, vma) {
+		err = __ksm_del_vma(vma);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /**
  * ksm_enable_merge_any - Add mm to mm ksm list and enable merging on all
  *                        compatible VMA's
@@ -2569,6 +2599,35 @@ int ksm_enable_merge_any(struct mm_struct *mm)
 	return 0;
 }
 
+/**
+ * ksm_disable_merge_any - Disable merging on all compatible VMA's of the mm,
+ *			   previously enabled via ksm_enable_merge_any().
+ *
+ * Disabling merging implies unmerging any merged pages, like setting
+ * MADV_UNMERGEABLE would. If unmerging fails, the whole operation fails and
+ * merging on all compatible VMA's remains enabled.
+ *
+ * @mm: Pointer to mm
+ *
+ * Returns 0 on success, otherwise error code
+ */
+int ksm_disable_merge_any(struct mm_struct *mm)
+{
+	int err;
+
+	if (!test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		return 0;
+
+	err = ksm_del_vmas(mm);
+	if (err) {
+		ksm_add_vmas(mm);
+		return err;
+	}
+
+	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
+	return 0;
+}
+
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags)
 {
-- 
2.40.0

