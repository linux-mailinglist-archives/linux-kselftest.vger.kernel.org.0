Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C66E681A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjDRPah (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjDRPaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 11:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C6CC36
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Apr 2023 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681831747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+AIWczdbQmYcywSh4w8GvqvVINNbh2DvrncyfYADn8=;
        b=Tebp7ToXI5Y+FHze1qnRFu6atex+UfTwWLBWVAaqKcT0HKlJOCTnm0YdDn4M+YaJtmc3jE
        z+9Xqico39bS7QednKc0HtwOIMiExiRjQNIxwhcvPpLdPXacFcSWj3Ic3LSZVHHCHqxOVg
        /LSPNWWjvQF8FQR6rd4WWfEDqdosoFs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-Je6gkD7QPgStNU4pQnR1yQ-1; Tue, 18 Apr 2023 11:29:03 -0400
X-MC-Unique: Je6gkD7QPgStNU4pQnR1yQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3CDF8996F7;
        Tue, 18 Apr 2023 15:29:02 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F63F14171B8;
        Tue, 18 Apr 2023 15:29:00 +0000 (UTC)
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
Subject: [PATCH v1 3/3] mm/ksm: move disabling KSM from s390/gmap code to KSM code
Date:   Tue, 18 Apr 2023 17:28:49 +0200
Message-Id: <20230418152849.505124-4-david@redhat.com>
In-Reply-To: <20230418152849.505124-1-david@redhat.com>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's factor out actual disabling of KSM. The existing
"mm->def_flags &= ~VM_MERGEABLE;" was essentially a NOP and can be dropped,
because def_flags should never include VM_MERGEABLE. Note that we don't
currently prevent re-enabling KSM.

This should now be faster in case KSM was never enabled, because we only
conditionally iterate all VMAs. Further, it certainly looks cleaner.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 20 +-------------------
 include/linux/ksm.h |  6 ++++++
 mm/ksm.c            | 11 +++++++++++
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 0949811761e6..dfe905c7bd8e 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2585,30 +2585,12 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
 
 int gmap_mark_unmergeable(void)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long vm_flags;
-	int ret;
-	VMA_ITERATOR(vmi, mm, 0);
-
 	/*
 	 * Make sure to disable KSM (if enabled for the whole process or
 	 * individual VMAs). Note that nothing currently hinders user space
 	 * from re-enabling it.
 	 */
-	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
-
-	for_each_vma(vmi, vma) {
-		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
-		vm_flags = vma->vm_flags;
-		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				  MADV_UNMERGEABLE, &vm_flags);
-		if (ret)
-			return ret;
-		vm_flags_reset(vma, vm_flags);
-	}
-	mm->def_flags &= ~VM_MERGEABLE;
-	return 0;
+	return ksm_disable(current->mm);
 }
 EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
 
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 7108bc65dc2a..b3d8b7849e18 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -22,6 +22,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 void ksm_add_vma(struct vm_area_struct *vma);
 int ksm_enable_merge_any(struct mm_struct *mm);
 int ksm_disable_merge_any(struct mm_struct *mm);
+int ksm_disable(struct mm_struct *mm);
 
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
@@ -75,6 +76,11 @@ static inline void ksm_add_vma(struct vm_area_struct *vma)
 {
 }
 
+static inline int ksm_disable(struct mm_struct *mm)
+{
+	return 0;
+}
+
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	return 0;
diff --git a/mm/ksm.c b/mm/ksm.c
index 813f7fbc1832..208311cbb019 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2616,6 +2616,17 @@ int ksm_disable_merge_any(struct mm_struct *mm)
 	return 0;
 }
 
+int ksm_disable(struct mm_struct *mm)
+{
+	mmap_assert_write_locked(mm);
+
+	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
+		return 0;
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		return ksm_disable_merge_any(mm);
+	return ksm_del_vmas(mm);
+}
+
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags)
 {
-- 
2.39.2

