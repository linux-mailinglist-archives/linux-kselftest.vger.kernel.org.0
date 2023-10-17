Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAAD7CBE7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjJQJI1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjJQJIY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:08:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD6FE
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:22 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2b1ad7ee6so2376816b6e.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697533702; x=1698138502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUe9FJYX6yjMwKk8iWQD0cd7P0ayg/xoiIZR+/sHFb4=;
        b=Tar+f3TeP7mKeTE7YZjLuDA8zHEaPiuMtI8mk1nouw+64mQMSc31q91+7zUFDGKKF6
         sIYZ4OOvoQkrYOP1QyrZScHXiLQKHzaxJuTzTqGovO5vF5/Q1Dl/5syCz1YrGWmCK1Up
         tAmj7wbuo/AhFpMcGnQZQfTeBogSZknmBMc4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533702; x=1698138502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUe9FJYX6yjMwKk8iWQD0cd7P0ayg/xoiIZR+/sHFb4=;
        b=ts/JeqZNFJS3DaNZOkIq8Qu3uJzeZoRMYtKJB83ZJ+B6ooox1Uac+K+mKe0066uAtV
         iXkddSuNt1TUtttvBDrbjYs6vtxF3yzkulvvNpjOLbm56uU7wp6CWOvWrp9TuxuLkbIn
         MC8n2ATusYHmzNw3IkinlLeqLNCgeSKX1an/HT9UyQmSFERBT4XApanWYqMNmZ/7Y8k4
         K+GysY8Xhu0QTB5114bTLuDML0CvSgRFFRzaqeKPtjK2UyvFXDKxQiLdcKSf3qIY+tbv
         vNX/WMydlRLa5Un0xsu0sy/rEMTOHscvve4O+Y4ZCjGzptiRWGu6gDoGJBnxgDTWnvDb
         Uy3g==
X-Gm-Message-State: AOJu0Yx7xDRnikBdbyoJSJd4IcVlbtPhE7/VhdphRV92F5VZeOfU4+5/
        hZn7a+aGTL0LmUhhuBC3TjB9Cg==
X-Google-Smtp-Source: AGHT+IGfvPndwtubeysEkGBSe3P/I0KBNSmcl27k26RD2FLLQ+j3OqYWoI+9c2SEWjqylHIx2vUv/Q==
X-Received: by 2002:a05:6870:1391:b0:1ea:6a81:8c8a with SMTP id 17-20020a056870139100b001ea6a818c8amr1412779oas.29.1697533701742;
        Tue, 17 Oct 2023 02:08:21 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id s11-20020a632c0b000000b0058958ea2aaesm945519pgs.83.2023.10.17.02.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:21 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v2 3/8] mseal: add can_modify_mm and can_modify_vma
Date:   Tue, 17 Oct 2023 09:08:10 +0000
Message-ID: <20231017090815.1067790-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017090815.1067790-1-jeffxu@chromium.org>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

can_modify_mm:
 checks sealing flags for given memory range.

can_modify_vma:
  checks sealing flags for given vma.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 include/linux/mm.h | 26 ++++++++++++++++++++++++++
 mm/mseal.c         | 42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b511932df033..b09df8501987 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3299,6 +3299,32 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
 static inline void mm_populate(unsigned long addr, unsigned long len) {}
 #endif
 
+#ifdef CONFIG_MSEAL
+extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+			  unsigned long end, unsigned long checkSeals);
+
+extern bool can_modify_vma(struct vm_area_struct *vma,
+		    unsigned long checkSeals);
+
+static inline unsigned long vma_seals(struct vm_area_struct *vma)
+{
+	return (vma->vm_seals & MM_SEAL_ALL);
+}
+
+#else
+static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+			  unsigned long end, unsigned long checkSeals)
+{
+	return true;
+}
+
+static inline bool can_modify_vma(struct vm_area_struct *vma,
+		    unsigned long checkSeals)
+{
+	return true;
+}
+#endif
+
 /* These take the mm semaphore themselves */
 extern int __must_check vm_brk(unsigned long, unsigned long);
 extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
diff --git a/mm/mseal.c b/mm/mseal.c
index ffe4c4c3f1bc..3e9d1c732c38 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -26,6 +26,44 @@ static bool can_do_mseal(unsigned long types, unsigned long flags)
 	return true;
 }
 
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+bool can_modify_vma(struct vm_area_struct *vma,
+		    unsigned long checkSeals)
+{
+	if (checkSeals & vma_seals(vma))
+		return false;
+
+	return true;
+}
+
+/*
+ * Check if the vmas of a memory range are allowed to be modified.
+ * the memory ranger can have a gap (unallocated memory).
+ * return true, if it is allowed.
+ */
+bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end,
+		   unsigned long checkSeals)
+{
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, start);
+
+	if (!checkSeals)
+		return true;
+
+	/* going through each vma to check */
+	for_each_vma_range(vmi, vma, end) {
+		if (!can_modify_vma(vma, checkSeals))
+			return false;
+	}
+
+	/* Allow by default. */
+	return true;
+}
+
 /*
  * Check if a seal type can be added to VMA.
  */
@@ -33,7 +71,7 @@ static bool can_add_vma_seals(struct vm_area_struct *vma, unsigned long newSeals
 {
 	/* When SEAL_MSEAL is set, reject if a new type of seal is added */
 	if ((vma->vm_seals & MM_SEAL_MSEAL) &&
-	    (newSeals & ~(vma->vm_seals & MM_SEAL_ALL)))
+	    (newSeals & ~(vma_seals(vma))))
 		return false;
 
 	return true;
@@ -45,7 +83,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	int ret = 0;
 
-	if (addtypes & ~(vma->vm_seals & MM_SEAL_ALL)) {
+	if (addtypes & ~(vma_seals(vma))) {
 		/*
 		 * Handle split at start and end.
 		 * Note: sealed VMA doesn't merge with other VMAs.
-- 
2.42.0.655.g421f12c284-goog

