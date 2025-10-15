Return-Path: <linux-kselftest+bounces-43163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291CBDC9B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 07:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5363C8597
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 05:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758C9304976;
	Wed, 15 Oct 2025 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fNbMI6fA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8143009D5
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506288; cv=none; b=W/pA3L9UzsU7z6ZXN9nSiw/nXmSgy1a9YfhJOH66NtizH69gD+nkXyvR4BK410xElqpyabJ5wV/xWIdWEUQhSW5aG2hSK4zhMPydxfRmEmI8vLGbRZX65GlZeTYErb+PiX+Bgqt9JI26uU+6ZrS7U/ZgSkYcSb8eHgY48auG0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506288; c=relaxed/simple;
	bh=vzQCmM1nNTE0ov7uCe2kVKV3jUZEwP58A/VqI2SEtck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbKotKPc/PZdf1E+cq5y6chhfy/9spCV7ofL3WBxHWDtklbearPYqSCMq8NsydcSYvOKiUkr9l5hXNw3IBqXOGEVU39oLaqiMUEq5cklXnZpZpx6BfF7q0+FwLnrh9ExC8G/gs++uc9R7hg3dEe6i+QyxSOZUxc/yQPIX4u3fZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fNbMI6fA; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-862cbf9e0c0so777749785a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 22:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760506285; x=1761111085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX//HAu2ie94it+tD5SdOdZKlGHwRq6PauprKab6pa4=;
        b=fNbMI6fASX0jjWQzL0T4YgWrDNhf5xXo+h8fdNfKN6jc4gR0OKNkSjbpO4VBC9ZFQb
         sa2061VWeYl5Y+du11PLGhHsT+tjh9Zhyp/rfID0tGlckXu8lKVBrcdeov43fnfsoCUA
         WaqUcZNpxzS94w7WKo7sTBZFBE4gr2aoKzy56CvnnTlf65DqZeVS6pdM4Y3+IX288WCP
         0xmiNDwlZ1IvXyAoDQgw2XMQgQ4GwKC+hRm2w7/Se/BDfzunNvxEW1fzz8RTnzkMqpqX
         b9XA2QJHbWsRhJCkDpTohEtp/p4OP+DmX3mdVV+xj13yqd80xCW2vvLNym3BUHmGZ68f
         LqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506285; x=1761111085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX//HAu2ie94it+tD5SdOdZKlGHwRq6PauprKab6pa4=;
        b=BXP/Fq42JgHoZZGZ0VIqanr92sbAXeWmYqZvFeIGWsao7KBAYcSLIIq7Oyp7dSf6NR
         t5+MhT13wwQ29f/CGhW2Cw38cfmc12CF77DFDNdtQOXFYGq8vnLgZipmCUHJRg7mErM9
         kJFR8zXsUH/NT4vCJgRc1jft39xZoogN3QiBs2pZZcZB5yQtydJB92VXNOKDaXvl0SPz
         WrOTPGMw6fXhclG1Xwi1tDALhpEkrE04G/VJTS6GdVziYXqiwU4QWRrexpesM/gMpxp/
         ci/9nPa/YRfRNLvMDJCsx3zNAKLK4KBfmtqCMs1i+hilzswE6lkX7GQzgDyHo7Ff6C9T
         3ZxA==
X-Forwarded-Encrypted: i=1; AJvYcCVc0B4ufAuKePCEx/st8G6QO1eLVKc5RT9pD4tuf8U2o4kdoWdoaou+09l+2NjfijAgLHgg4FuAkXyQpG3SE0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUfAU036AyPS4PuKU42y5Kj+gKAvOAay0qQSbcvTzea7WwvnbM
	KcsfhVZBDD0fpGhETYA6wZGCOptKvSuqYC0wTBBGSUMChjC8zUj0NToPWbbZF349aUk=
X-Gm-Gg: ASbGncttRykkqZKBzs+SG4j/P+PHaQXYVzcyRWO0ZgkJ8Ybj36NrLeyssGU4CqEgpRR
	kgisFhNgh+ydVbnT0hMG6yEMlmwMkLJo7eA30Ra1UWencOsbYsWUf4mDEleHddgv2ukY8nJMVBh
	EErI7rjEh6nrc35HvH0t/0SjAOB7BQWpfy3vXQC3ikol5TU8sjK0nVVZPngMhqGbD1mKTXu009r
	hCWsuPnpJssYEHAW5RTEGLJg1loP1/tcVTtAjtaWgKVe5jzmlZqliNPAGjL1RPF+5cX8RzChP32
	VA8Mdu0XGKiJFGYP8T6jKmyD2wv2bmaEQkTzol+YnCiRnZpeYXlXNRqYAwluLNFF5eMwMwoenC4
	ibOBJUxK7ht/9mzCgW9jiZgqKBkt6GAz9tc9R0hDS8YSWKy9QLsF9w1m/KMLoJqcow6LB1RxFgb
	WEC5KNd9lMCGOzn8z1CD6btB8YJaxkSwc6Kr/p9oy4jkcjm5IrsQZEcaQGlzY=
X-Google-Smtp-Source: AGHT+IG4TVlyGj87gL4l3Cn5wFpTA6+9S0+DZSHD6GOiJNS/JWUuuuCXSPGMqGA/FDM8qzc6tZIhdg==
X-Received: by 2002:ac8:5a06:0:b0:4e8:85e8:8019 with SMTP id d75a77b69052e-4e885e8859amr10940541cf.78.1760506285490;
        Tue, 14 Oct 2025 22:31:25 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881d01f5asm12572661cf.27.2025.10.14.22.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:31:25 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or preserved memory in scratch area
Date: Wed, 15 Oct 2025 01:31:20 -0400
Message-ID: <20251015053121.3978358-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
In-Reply-To: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is invalid for KHO metadata or preserved memory regions to be located
within the KHO scratch area, as this area is overwritten when the next
kernel is loaded, and used early in boot by the next kernel. This can
lead to memory corruption.

Adds checks to kho_preserve_* and KHO's internal metadata allocators
(xa_load_or_alloc, new_chunk) to verify that the physical address of the
memory does not overlap with any defined scratch region. If an overlap
is detected, the operation will fail and a WARN_ON is triggered. To
avoid performance overhead in production kernels, these checks are
enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/Kconfig                   | 15 ++++++++++
 kernel/liveupdate/kexec_handover.c          | 32 ++++++++++++++++++---
 kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++++++
 kernel/liveupdate/kexec_handover_internal.h |  9 ++++++
 4 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 522b9f74d605..d119f4f3f4b1 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -27,4 +27,19 @@ config KEXEC_HANDOVER_DEBUGFS
 	  Also, enables inspecting the KHO fdt trees with the debugfs binary
 	  blobs.
 
+config KEXEC_HANDOVER_DEBUG
+	bool "Enable Kexec Handover debug checks"
+	depends on KEXEC_HANDOVER_DEBUGFS
+	help
+	  This option enables extra sanity checks for the Kexec Handover
+	  subsystem.
+
+	  These checks verify that neither preserved memory regions nor KHO's
+	  internal metadata are allocated from within a KHO scratch area.
+	  An overlap can lead to memory corruption during a subsequent kexec
+	  operation.
+
+	  If an overlap is detected, the kernel will print a warning and the
+	  offending operation will fail. This should only be enabled for
+	  debugging purposes due to runtime overhead.
 endmenu
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5da21f1510cc..ef1e6f7a234b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -141,6 +141,11 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
+		kfree(elm);
+		return ERR_PTR(-EINVAL);
+	}
+
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
 	if (xa_is_err(res))
 		res = ERR_PTR(xa_err(res));
@@ -354,7 +359,13 @@ static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 
 	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!chunk)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE))) {
+		kfree(chunk);
+		return ERR_PTR(-EINVAL);
+	}
+
 	chunk->hdr.order = order;
 	if (cur_chunk)
 		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
@@ -379,14 +390,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 	struct khoser_mem_chunk *chunk = NULL;
 	struct kho_mem_phys *physxa;
 	unsigned long order;
+	int ret = -ENOMEM;
 
 	xa_for_each(&kho_out->track.orders, order, physxa) {
 		struct kho_mem_phys_bits *bits;
 		unsigned long phys;
 
 		chunk = new_chunk(chunk, order);
-		if (!chunk)
+		if (IS_ERR(chunk)) {
+			ret = PTR_ERR(chunk);
 			goto err_free;
+		}
 
 		if (!first_chunk)
 			first_chunk = chunk;
@@ -396,8 +410,10 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 
 			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
 				chunk = new_chunk(chunk, order);
-				if (!chunk)
+				if (IS_ERR(chunk)) {
+					ret = PTR_ERR(chunk);
 					goto err_free;
+				}
 			}
 
 			elm = &chunk->bitmaps[chunk->hdr.num_elms];
@@ -414,7 +430,7 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 
 err_free:
 	kho_mem_ser_free(first_chunk);
-	return -ENOMEM;
+	return ret;
 }
 
 static void __init deserialize_bitmap(unsigned int order,
@@ -737,6 +753,9 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.track;
 
+	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+		return -EINVAL;
+
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -784,6 +803,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 	unsigned long failed_pfn = 0;
 	int err = 0;
 
+	if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
+					nr_pages << PAGE_SHIFT))) {
+		return -EINVAL;
+	}
+
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
index eb47f000887d..294d1d290142 100644
--- a/kernel/liveupdate/kexec_handover_debug.c
+++ b/kernel/liveupdate/kexec_handover_debug.c
@@ -214,3 +214,21 @@ __init int kho_debugfs_init(void)
 		return -ENOENT;
 	return 0;
 }
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	phys_addr_t scratch_start, scratch_end;
+	unsigned int i;
+
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		scratch_start = kho_scratch[i].addr;
+		scratch_end = kho_scratch[i].addr + kho_scratch[i].size - 1;
+
+		if (phys <= scratch_end && (phys + size) > scratch_start)
+			return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index b3fc1957affa..92798346fa5a 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -44,4 +44,13 @@ static inline void kho_debugfs_fdt_remove(struct kho_debugfs *dbg,
 					  void *fdt) { }
 #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
 
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+bool kho_scratch_overlap(phys_addr_t phys, size_t size);
+#else
+static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
+
 #endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
-- 
2.51.0.788.g6d19910ace-goog


