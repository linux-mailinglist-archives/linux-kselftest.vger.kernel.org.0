Return-Path: <linux-kselftest+bounces-15575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46108955421
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03276284BAA
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 00:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CCB256E;
	Sat, 17 Aug 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWb2gbtv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E12B66C;
	Sat, 17 Aug 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853932; cv=none; b=bPoPUc1Ec0bo9bE8Ih8bsBd0VHMG6tmvfCUxSI5Nb+38RlJXEdQQyxeH4UvkeCuED3LHu4fA2hJIby99J61ec4X52nV1lfUomwCxoJLrOw7qFl+BVgoNswdJLojKeVXrDS3c83wHISIix6DC07V1KyurmPdO+2+hMNKgZRYw7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853932; c=relaxed/simple;
	bh=ZqblwcZQYik6vrCA28VHOhZDiHbXGTOLSFUeNURbjQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tl78/ZYxcsNFw/kegtBl00NLSJ34WzHtgRbvZ7pHBNC7jXYyh/6fvZt58sEmMRXpf3iJ3cEFD2+AE8U0mqP4zpOxxvEad2xjwcSIU+I1w2yd3/OkLwfQXeuMxEZJh6KCRyEJirBTm5uKtL0L12x65JYqTnhETGcdyWTz/oaSdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWb2gbtv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42808071810so18184245e9.1;
        Fri, 16 Aug 2024 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723853924; x=1724458724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAmgLDl1px7jqd76Q1p746SydraVXJ6Ud6jad/RgDJQ=;
        b=TWb2gbtvgRnlI02gklOwJjG7OL/w/Tme78YgisZFIdjpoEuljPnWoteDYgb6ltn0LO
         tSlLekgtjQ74ZrePrD1AMzC+BVx2sxLLdFvA/SM7IdSjagN1ZvfyVl3vFXPkjHxzIqGo
         dLPBA8tFyEgX0PrClKqtGv6HR2zlDMHbvd2dLSqA8b441SxFb6Qehjq8yMZYJzL/KT+o
         AISV2nolOSufKsE5DVCsrSBFRDT7EudIByrZIUCNEEy6anLktE49s4MnGeJ49NE1RuG7
         kGjvjjXBaooFKUJCft94WAlGU9pileay37TTxO5Z5mkf3XlX/OliQPvyGfEZ5FQQbqx+
         ft5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853924; x=1724458724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAmgLDl1px7jqd76Q1p746SydraVXJ6Ud6jad/RgDJQ=;
        b=ILZqVmL35bYsBYLv6gdat+RKvn6NlLokQsVy6oqobvvHWw1rhlttdu6v9U3isWpA7j
         uE3YvoU/4fB7FFkpvCF5GaWBrB19jzcaN/qiNtUsTGCItsnH/YHoFZQz1TbWMqEPdFRt
         dWYs1i8W1/uRJRD5tDsjzIEaIs5eU+7wKrsDI/VNRH1DQnaVmiL8GYYZEFM7dkF6iSFx
         zSKmPLibvwPhakP3SwvnEvA/CC+zfi0vCmJNWtI4SgpSCuAHBmvk5Zrn/mu/KEhFZOmW
         vAPPq4Yf8chpIZdqqMS9TRpM+QIY6+/2SNCbH4F9Xt942oEVwYjUwIbUujfouJmZVy3R
         LpCA==
X-Forwarded-Encrypted: i=1; AJvYcCXkEVJvzaSokYfG5ugYCAaZHw0PzuQ0E2viIvISUAD7k2Obwb8/W0zGnQ4B2a/GNVYIxkPZkTHQ9yd6485mT8geRRJw+Hwik6wzyJOLjIMNtR+l+el33kLGmOxcB+lE4l1dbCtn9ejP+XeRTpA1
X-Gm-Message-State: AOJu0YwAO42Jgh6Vg0l8JJod+2C7dlBAXU/O84vpOfZO7ElYNE57cA77
	OS2NqwJuOMdsexRruR0sHlHPPcYfg/NAcjIGt9pw+/5zIUtTw0kZAk6Iuyjt
X-Google-Smtp-Source: AGHT+IGM0TLfyEre+jfwvYu3EzVkhOnPhcS/imjEho/f+Tms2EZbTyomcs1S5bb2scgoXXDqQlsfmg==
X-Received: by 2002:a05:600c:4fc8:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-429ed7d1f39mr29141995e9.26.1723853923095;
        Fri, 16 Aug 2024 17:18:43 -0700 (PDT)
Received: from [192.168.1.91] ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm104842055e9.0.2024.08.16.17.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:18:42 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sat, 17 Aug 2024 01:18:31 +0100
Subject: [PATCH v3 4/7] mm/mremap: Replace can_modify_mm with
 can_modify_vma
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-mseal-depessimize-v3-4-d8d2e037df30@gmail.com>
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

Delegate all can_modify checks to the proper places. Unmap checks are
done in do_unmap (et al). The source VMA check is done purposefully
before unmapping, to keep the original mseal semantics.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mremap.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc640..24712f8dbb6b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -902,19 +902,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
-	/*
-	 * In mremap_to().
-	 * Move a VMA to another location, check if src addr is sealed.
-	 *
-	 * Place can_modify_mm here because mremap_to()
-	 * does its own checking for address range, and we only
-	 * check the sealing after passing those checks.
-	 *
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
-		return -EPERM;
-
 	if (flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1052,6 +1039,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	/* Don't allow remapping vmas when they have already been sealed */
+	if (!can_modify_vma(vma)) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	if (is_vm_hugetlb_page(vma)) {
 		struct hstate *h __maybe_unused = hstate_vma(vma);
 
@@ -1079,19 +1072,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
-	/*
-	 * Below is shrink/expand case (not mremap_to())
-	 * Check if src address is sealed, if so, reject.
-	 * In other words, prevent shrinking or expanding a sealed VMA.
-	 *
-	 * Place can_modify_mm here so we can keep the logic related to
-	 * shrink/expand together.
-	 */
-	if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
-		ret = -EPERM;
-		goto out;
-	}
-
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..

-- 
2.46.0


