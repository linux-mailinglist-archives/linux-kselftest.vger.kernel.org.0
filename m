Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404BF7CABAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjJPOjG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjJPOjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 10:39:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A7ED
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:39:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c871a095ceso30574015ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697467142; x=1698071942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xej43+CxxYh9a3blA/g52Ig4N3aDI9kSsEpUlToUGyY=;
        b=LwyrXl3vTxEDzbakDcTvG61WdDGcXTTnloGXmbWRhKmUm3qPzWzDAYM16vBObq/pc5
         2oxGoOIBvqBsRWNfoJ12MqAPYo2DUq9eYoEFrVFogm5YiLsMajMzJdm5UHCMnCKQmzw6
         YK/8I3KFIKpiCJvPwMlTyO6aIQ6/2HuWpkTOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467142; x=1698071942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xej43+CxxYh9a3blA/g52Ig4N3aDI9kSsEpUlToUGyY=;
        b=AT4P+CNGyei0yoLmjBgGWoVJ4N/SfYlgnakQJ8A1ay21/JOEZ6lUi1w8TZ7HOwvdt2
         BY74KmoScvuWbrXs06DwmEKJPei7B+tc165fh0ypFMDBAaqk6aUurarCb+BJvqEwwc9z
         84sIgYrlmVSFcDPkEtCGizdDr/gmtnoIszJR8zQxoAWU/KFTnk1LFoJKIMPbW/H6FQwb
         eUGmib2hM+woWJ7ynngDoLKHCQI2f7B2Rfuhf5AGh8If3XgcWnSQQ6id4yPboJ0Cm5OM
         BrxbxIAQS9gUext7EsuV6ZmljjzzICCv9G4TestH+2iFhCsI3NqSJhnT306GcPoWWVcY
         iIxQ==
X-Gm-Message-State: AOJu0Ywcg/OzzWmzTAH6CpAPt88skob2+/PDxZQadv9DzSMnFkSqT9jV
        MO3KIaDJKYeL58BMn+4PrjPzbw==
X-Google-Smtp-Source: AGHT+IGUzUb5v0t/3MkBLk3yxGa4HPz1kX3xlLqN5hhkqcb5wVyzEHQXpSYW2jltVLkxXX+Emd4ILg==
X-Received: by 2002:a17:903:294b:b0:1c9:d143:e9e with SMTP id li11-20020a170903294b00b001c9d1430e9emr10728383plb.18.1697467141766;
        Mon, 16 Oct 2023 07:39:01 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id ju1-20020a170903428100b001b9d335223csm8556065plb.26.2023.10.16.07.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:39:01 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v1 3/8] mseal: add can_modify_mm and can_modify_vma
Date:   Mon, 16 Oct 2023 14:38:22 +0000
Message-ID: <20231016143828.647848-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
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
 include/linux/mm.h | 34 ++++++++++++++++++++++++++
 mm/mseal.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e790b91a0cd4..aafdb68950f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -257,6 +257,18 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+enum caller_origin {
+	ON_BEHALF_OF_KERNEL = 0,
+	ON_BEHALF_OF_USERSPACE,
+};
+
+enum mm_action {
+	MM_ACTION_MPROTECT,
+	MM_ACTION_MUNMAP,
+	MM_ACTION_MREMAP,
+	MM_ACTION_MMAP,
+};
+
 /*
  * vm_seals in vm_area_struct, see mm_types.h.
  */
@@ -3302,6 +3314,28 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
 static inline void mm_populate(unsigned long addr, unsigned long len) {}
 #endif
 
+#ifdef CONFIG_MSEAL
+extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+			  unsigned long end, enum mm_action action,
+			  enum caller_origin called);
+
+extern bool can_modify_vma(struct vm_area_struct *vma, enum mm_action action,
+		    enum caller_origin called);
+#else
+static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+			  unsigned long end, enum mm_action action,
+			  enum caller_origin called)
+{
+	return true;
+}
+
+static inline bool can_modify_vma(struct vm_area_struct *vma, enum mm_action action,
+		    enum caller_origin called)
+{
+	return true;
+}
+#endif
+
 /* These take the mm semaphore themselves */
 extern int __must_check vm_brk(unsigned long, unsigned long);
 extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
diff --git a/mm/mseal.c b/mm/mseal.c
index 615b6e06ab44..3285ef6b95a6 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -36,6 +36,66 @@ static bool can_do_mseal(unsigned int types, unsigned int flags)
 	return true;
 }
 
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+bool can_modify_vma(struct vm_area_struct *vma, enum mm_action action,
+		    enum caller_origin called)
+{
+	if (called == ON_BEHALF_OF_KERNEL)
+		return true;
+
+	switch (action) {
+	case MM_ACTION_MPROTECT:
+		if (vma->vm_seals & VM_SEAL_MPROTECT)
+			return false;
+		break;
+
+	case MM_ACTION_MUNMAP:
+		if (vma->vm_seals & VM_SEAL_MUNMAP)
+			return false;
+		break;
+
+	case MM_ACTION_MREMAP:
+		if (vma->vm_seals & VM_SEAL_MREMAP)
+			return false;
+		break;
+
+	case MM_ACTION_MMAP:
+		if (vma->vm_seals & VM_SEAL_MMAP)
+			return false;
+		break;
+	}
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
+		   enum mm_action action, enum caller_origin called)
+{
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, start);
+
+	if (called == ON_BEHALF_OF_KERNEL)
+		return true;
+
+	/* going through each vma to check */
+	for_each_vma_range(vmi, vma, end) {
+		if (!can_modify_vma(vma, action, called))
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
-- 
2.42.0.609.gbb76f46606-goog

