Return-Path: <linux-kselftest+bounces-15576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC3955423
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373651C21B28
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 00:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90579CF;
	Sat, 17 Aug 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvVLBj4G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E24C96;
	Sat, 17 Aug 2024 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853933; cv=none; b=BGYeZcx5fpn9S47EEfRS9Rxt0HmRElkVHelC5yhgc0yrsbTPjv4Px6ZofqIEnP5Dd3OiwHYBCpCaR4san4PiG5GDSASxvvqVkQz9qvEgyQ0dZvNyuqlt6UmOSwBVZAiEzIBbTj39FtVHdihA3Zjah1+cOadj4t/ewn97WVfrIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853933; c=relaxed/simple;
	bh=5nC1RhLpgrxNbZe4uoGMsvaSLGktLHd7rzFicJCaFbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMM6P/mUGe97CnzeBJ+fCvCekSBHXv4OYcrJeWNnhG6gPziInEKaYkoVfVNy52+y/MTzxLLibXOeQBMOfzWpyQKCWD5Yc6YG9Qfhrh+gHf2RWhr+LpiPJw8bSjiM0AxaS61obxkgH8qO2bImUU9AK0EKarAmgh5zdejjaxI+t+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvVLBj4G; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37186c2278bso1402506f8f.1;
        Fri, 16 Aug 2024 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723853925; x=1724458725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrPcZ5dxXI2S7kFYpXooZU8/pyUJQvH2vRgq9oEXpMQ=;
        b=UvVLBj4GBnyqEd9SRT1MQ6z7uJ2P0a8QDZ786E+GA+8l1lhCKekuOLEv9PiJVuK03q
         91JTL1vzzOXjeIkpnTJrzTN5V2+5/k5BmRT5jDZJG+HhNR3tDBYx0op8ZK9X7aMcsgsX
         w2/z8PVtmmViJYh2Kyb8J1Kz7BGROTrHWS5eRTz5FNPsCz7dmNNqPk3325Wlj4DvFzBQ
         RWdZ5fgug70him1dhTbgVoeMlPCD0t3PqVK2mO543uJcg0UFWHB+2v8qIZDGB62AkPLI
         1aHe4dqEs6GXOx2ZPTOPsiTDHVTMf/lNVwagoE112gB6bRhVvr8ozcXBoqQfdDeJv7n4
         ZdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853925; x=1724458725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrPcZ5dxXI2S7kFYpXooZU8/pyUJQvH2vRgq9oEXpMQ=;
        b=IU3w6rVd2qT8DVLkHNao2GlsY0pFLJOYt/+WzrgnnIAg1kJZdIcBCXjLFYHJbFff1+
         P8eWdo2ebPpFvhgXsrUFhj8ZTIDErDJYbYTnEvWqhu3xiXj1/lumnlJRa17J3xdVvW7c
         bhbdpH0rBXWLjTnOSsoEdvZEuIYimFg5GjXIRRinX6nLK/6ikRE/CrUqUA8446emZvDl
         OAGYpyq1E1+qHba6gg96cIm1TSQz6trDdSCy3nj69clmeN5oCaDZOfjWjHsx3D8xcUxr
         KVbRwLfTM8X+5wSQIWMDevP1XDIhoMMcbMyLBe9lvyz6XXOQEZValiLhBp5HTds7uTfl
         0Z8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1cV/OGEmRRe0m7dduLozK/4nMwlu2e7agp74u/oVttnklS2pZaZT9m3voe8AAdTNxyFMHyeeVfPWSGWuQCdYr8cgSSkU1y3zKJaxBLnhITSoZB6C7CtsC7NA0pFbSLm8myzaFAcwvgtjkRuhB
X-Gm-Message-State: AOJu0YwHhPnw7rw1WSS2CWTejPFQrCmiOZ//TIOdmMsVh0Uc2O6+tqzh
	Simk24exRdvFt0cSr4jIrpGWVS1a7rAbNmkzSnbunWdqVg1qkFF2/ER16Jop
X-Google-Smtp-Source: AGHT+IHob2iXeWVcLHrIvT5oHF+c90MvHS34UpZmw02JaWHR+F0oJhRdWeWAe0XuH/19P/AChePKAQ==
X-Received: by 2002:a05:6000:2a8:b0:368:377a:e8bb with SMTP id ffacd0b85a97d-37186dda493mr7610866f8f.28.1723853924555;
        Fri, 16 Aug 2024 17:18:44 -0700 (PDT)
Received: from [192.168.1.91] ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm104842055e9.0.2024.08.16.17.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:18:44 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sat, 17 Aug 2024 01:18:32 +0100
Subject: [PATCH v3 5/7] mseal: Replace can_modify_mm_madv with a vma
 variant
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-mseal-depessimize-v3-5-d8d2e037df30@gmail.com>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
In-Reply-To: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
 Kees Cook <kees@kernel.org>, Pedro Falcato <pedro.falcato@gmail.com>
X-Mailer: b4 0.14.1

Replace can_modify_mm_madv() with a single vma variant, and associated
checks in madvise.

While we're at it, also invert the order of checks in:
 if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma))

Checking if we can modify the vma itself (through vm_flags) is
certainly cheaper than is_ro_anon() due to arch_vma_access_permitted()
looking at e.g pkeys registers (with extra branches) in some
architectures.

This patch allows for partial madvise success when finding a sealed VMA,
which historically has been allowed in Linux.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/internal.h |  2 --
 mm/madvise.c  | 13 +++----------
 mm/mseal.c    | 17 ++++-------------
 mm/vma.h      |  7 +++++++
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ca422aede342..1db320650539 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1363,8 +1363,6 @@ static inline int can_do_mseal(unsigned long flags)
 
 bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end);
-bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
-		unsigned long end, int behavior);
 #else
 static inline int can_do_mseal(unsigned long flags)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index 89089d84f8df..4e64770be16c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1031,6 +1031,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	struct anon_vma_name *anon_name;
 	unsigned long new_flags = vma->vm_flags;
 
+	if (unlikely(!can_modify_vma_madv(vma, behavior)))
+		return -EPERM;
+
 	switch (behavior) {
 	case MADV_REMOVE:
 		return madvise_remove(vma, prev, start, end);
@@ -1448,15 +1451,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	start = untagged_addr_remote(mm, start);
 	end = start + len;
 
-	/*
-	 * Check if the address range is sealed for do_madvise().
-	 * can_modify_mm_madv assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm_madv(mm, start, end, behavior))) {
-		error = -EPERM;
-		goto out;
-	}
-
 	blk_start_plug(&plug);
 	switch (behavior) {
 	case MADV_POPULATE_READ:
@@ -1470,7 +1464,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	}
 	blk_finish_plug(&plug);
 
-out:
 	if (write)
 		mmap_write_unlock(mm);
 	else
diff --git a/mm/mseal.c b/mm/mseal.c
index 2170e2139ca0..fdd1666344fa 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -75,24 +75,15 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
 }
 
 /*
- * Check if the vmas of a memory range are allowed to be modified by madvise.
- * the memory ranger can have a gap (unallocated memory).
- * return true, if it is allowed.
+ * Check if a vma is allowed to be modified by madvise.
  */
-bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long end,
-		int behavior)
+bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
 {
-	struct vm_area_struct *vma;
-
-	VMA_ITERATOR(vmi, mm, start);
-
 	if (!is_madv_discard(behavior))
 		return true;
 
-	/* going through each vma to check. */
-	for_each_vma_range(vmi, vma, end)
-		if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma)))
-			return false;
+	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
+		return false;
 
 	/* Allow by default. */
 	return true;
diff --git a/mm/vma.h b/mm/vma.h
index e979015cc7fc..da31d0f62157 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -380,6 +380,8 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 	return true;
 }
 
+bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
+
 #else
 
 static inline bool can_modify_vma(struct vm_area_struct *vma)
@@ -387,6 +389,11 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 	return true;
 }
 
+static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
+{
+	return true;
+}
+
 #endif
 
 #endif	/* __MM_VMA_H */

-- 
2.46.0


