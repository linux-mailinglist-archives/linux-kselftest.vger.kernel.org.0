Return-Path: <linux-kselftest+bounces-15573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB7E95541D
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C8D1C20906
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2434A2D;
	Sat, 17 Aug 2024 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBTecDV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E217256E;
	Sat, 17 Aug 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853927; cv=none; b=staHvULY4pI8ANXyQ6VLa0atwX3WYLYnr4ovwO1WpUTJXLCMLeU2hheIRw5X+5RJ8wvV0vTMUlufAVtkljHMD2KyMoXGfcZpSiH/p1/fmVV5+4Vjy8VrTHSsW3jNzQTzrYqEZCUtkKfom1sXblvyP2ds4tT0FVqvbM2UNmxQjiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853927; c=relaxed/simple;
	bh=TE42/IB2CccHSiCs8bJa52DZagIXGjgfR8xOnJQNc9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJhNDRgV2Jko3gaqZvecyp8FK+XQsv97a3FVIvCYII9DGFGDmfV+WMFKwEUIZ+bHl8Zd9U+s/m4b/dyIRGYG/Y3+eH6GNT4YmSAOmp6iobhvLu6VWaS3a8Q9UqwKLmHSBKAUw7cvAgE/bNRtOnAveIA1x1oCvodK0tCjO4ZUZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBTecDV/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so1268663f8f.1;
        Fri, 16 Aug 2024 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723853919; x=1724458719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE0tAujU+84Fl5Bml9LnGFFfJTwW8AbGe4iKDNDJLPI=;
        b=ZBTecDV/XPyqei/hvTJTjLs78EWWJMyAAGWFsF99p/Ix+iPfOrt5FHjfr+VIYPI2TI
         XjRcj746an2AUySyu1i977YCupFK8Eljlnezl7puw8Qi8cVGbgp/OiqcS6C8UMmXJyw7
         8wfm8ObUmWAk24ZjARTXd0EFf8C3qpjKbR1qA0Emoy+88VopHRNdcLh7pbs8i7TAqS8w
         CvWXZj6/StVDVBDYe/+4naJ/6PwhlRE7ADzDZRbDeMSmfe7DhM3LwGPiKEKvG/GeehrO
         cXntLAQycT0KQXnJzkebacjSURyzDMLnZh2+skIYyIjc5bd8+Y2XtluknNlPck21udnN
         S7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853919; x=1724458719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE0tAujU+84Fl5Bml9LnGFFfJTwW8AbGe4iKDNDJLPI=;
        b=Glw2A4N9/SotegNP4pICFJMyYqhxwfzBsd7k2O6YJVcFzibRqeQ42pfEeTrMhBNnl4
         ewlPVLns9opwYp1qIdAz3lDhY3/UB6L/aPgoQ3eysdTOkKy4YyDJQ1thDopISCoU3fLw
         +tYiqKbZFPNeK/qXTcWAeHPd+4sEnF1yY8kgsJz8YbJisBmBHyUs6xvyDXoaXL3iyE9u
         DubAL13IqzGHW3RZdHNRlE8aLGA9n2GAR5pf57EJ6AfwuKpCtrA7x+0iX0a5bzMDVw60
         4NZDrZx+O8WoeeU/mzTt8a1nfv2TXIff8TI5CdMBmwu4WKSQIVXSDtlwtrWt0lS04R4T
         7GGw==
X-Forwarded-Encrypted: i=1; AJvYcCUejgwSQE+uaWocqNMkWPijz3AIN+I2VWmoUmEEKaXk2Tqs+W2mFIzbmDfilK6wmeDdLBTDPClWO6+7tUGWQeClHfnvEfWP7wGOtfSPpFeSjk1UASwOWUbGK/Hd60/vQ2J5rdNE40UZispz942g
X-Gm-Message-State: AOJu0Yyh1F+Bw218lcffg7dxE6vSNmEdp2hnEWsGp074Ba+jfT34VU7q
	cKPpuJ0VZzRwmGpFJkbhYnGK1tKIf17LvYmiXOkuuvxzLHgL3hQgDinbK2h9
X-Google-Smtp-Source: AGHT+IH+rZczV1rucrOJegV86RCCzxDjSfxcW+VweSbEmrGCi5wWUt76859GZxn1s0ipCW3cR+tVCA==
X-Received: by 2002:a05:6000:a81:b0:368:5bb4:169b with SMTP id ffacd0b85a97d-371943159b6mr2775762f8f.4.1723853917768;
        Fri, 16 Aug 2024 17:18:37 -0700 (PDT)
Received: from [192.168.1.91] ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm104842055e9.0.2024.08.16.17.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:18:37 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sat, 17 Aug 2024 01:18:28 +0100
Subject: [PATCH v3 1/7] mm: Move can_modify_vma to mm/vma.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-mseal-depessimize-v3-1-d8d2e037df30@gmail.com>
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

Move can_modify_vma to vma.h so it can be inlined properly (with
the intent to remove can_modify_mm callsites).

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mseal.c | 17 -----------------
 mm/vma.h   | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 15bba28acc00..2170e2139ca0 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -16,28 +16,11 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-static inline bool vma_is_sealed(struct vm_area_struct *vma)
-{
-	return (vma->vm_flags & VM_SEALED);
-}
-
 static inline void set_vma_sealed(struct vm_area_struct *vma)
 {
 	vm_flags_set(vma, VM_SEALED);
 }
 
-/*
- * check if a vma is sealed for modification.
- * return true, if modification is allowed.
- */
-static bool can_modify_vma(struct vm_area_struct *vma)
-{
-	if (unlikely(vma_is_sealed(vma)))
-		return false;
-
-	return true;
-}
-
 static bool is_madv_discard(int behavior)
 {
 	switch (behavior) {
diff --git a/mm/vma.h b/mm/vma.h
index 6efdf1768a0a..e979015cc7fc 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -361,4 +361,32 @@ struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
 	return mas_prev_range(&vmi->mas, 0);
 }
 
+#ifdef CONFIG_64BIT
+
+static inline bool vma_is_sealed(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & VM_SEALED);
+}
+
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+static inline bool can_modify_vma(struct vm_area_struct *vma)
+{
+	if (unlikely(vma_is_sealed(vma)))
+		return false;
+
+	return true;
+}
+
+#else
+
+static inline bool can_modify_vma(struct vm_area_struct *vma)
+{
+	return true;
+}
+
+#endif
+
 #endif	/* __MM_VMA_H */

-- 
2.46.0


