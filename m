Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA46E6811
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjDRP3s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 11:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjDRP3r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 11:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3BF9
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Apr 2023 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681831741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lecfMikStSmpt+Q0WpS+JI6gz8j1FT0LsSw/UhC5P0k=;
        b=OkkSEgXsTuDlz5DR+jTr9WAMUi26Q6+Wsxg7WDxo20kYqf/GUuvFDkG/hvS84gQ1XS9vD9
        OL6yMQqASWv4YnQ8ivGjqIZVdBQknYszlVY6qx/kqe0E12yNWXIYKUpYLmZQWNWXWhU1T6
        mk1rF6E9/SCfFe9eQEeO7sT5esUDXAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-58a_-S71MqC04QAAf1VC5A-1; Tue, 18 Apr 2023 11:28:58 -0400
X-MC-Unique: 58a_-S71MqC04QAAf1VC5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78A5588905A;
        Tue, 18 Apr 2023 15:28:57 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EE7914171B8;
        Tue, 18 Apr 2023 15:28:54 +0000 (UTC)
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
Subject: [PATCH v1 1/3] mm/ksm: unmerge and clear VM_MERGEABLE when setting PR_SET_MEMORY_MERGE=0
Date:   Tue, 18 Apr 2023 17:28:47 +0200
Message-Id: <20230418152849.505124-2-david@redhat.com>
In-Reply-To: <20230418152849.505124-1-david@redhat.com>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/ksm.h |  1 +
 kernel/sys.c        |  7 +------
 mm/ksm.c            | 47 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 590934bdddcf..7108bc65dc2a 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -21,6 +21,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 
 void ksm_add_vma(struct vm_area_struct *vma);
 int ksm_enable_merge_any(struct mm_struct *mm);
+int ksm_disable_merge_any(struct mm_struct *mm);
 
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
diff --git a/kernel/sys.c b/kernel/sys.c
index 72cdb16e2636..3436376667d7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2698,12 +2698,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (arg2) {
 			error = ksm_enable_merge_any(me->mm);
 		} else {
-			/*
-			 * TODO: we might want disable KSM on all VMAs and
-			 * trigger unsharing to completely disable KSM.
-			 */
-			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
-			error = 0;
+			error = ksm_disable_merge_any(me->mm);
 		}
 		mmap_write_unlock(me->mm);
 		break;
diff --git a/mm/ksm.c b/mm/ksm.c
index a959e8925413..813f7fbc1832 100644
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
@@ -2569,6 +2599,23 @@ int ksm_enable_merge_any(struct mm_struct *mm)
 	return 0;
 }
 
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
2.39.2

