Return-Path: <linux-kselftest+bounces-43498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C40FBED4CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 19:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7715E8D30
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADDE26E6FF;
	Sat, 18 Oct 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JOSef1cE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC59260563
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807893; cv=none; b=ZjgpT39TPlTxbfEXnup5IHKamq8TrtSCNHMkoIZ3qiHm/gZoSG5a8K0RWdbtCHOE+Pxcf4ovq2EbJvACLnlUhpC90Fpoer/lSpYwi0GPQmT3uFknLwUeBD6UVGIDkdmHFxc0rgi8v6WZ4k+EOKvnK9frFjxmDP+xNdO0SGAxwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807893; c=relaxed/simple;
	bh=2jRwSZNaT85zOYi82myc+8ZAEywVWJKueEb4d5JJk74=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwWIrWoPvIq90Y7a8JUTZncrih9W8xSvWBeHkq4gVgx6RDRYPOAd624uH/ROihpBnkxZVfhH5Nech4yRnbPY3aGCoXVar2PpaAiEjUsSkF0Aly9HZ+pqiNYT8n/jsY3SshCUlnULdMK4pnPaYpMRK05dK1m7ZvZMez203v0rwg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JOSef1cE; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87d8fa51993so13141406d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807888; x=1761412688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7YtyqkoqKD6VWdGbdex27QCyhVfB5yWUVWWXB11RvY=;
        b=JOSef1cEnkLkOj3kp5bf2gq+Sr9c4et/S0rYGpXRdK8jK2E4dtzzHmyGlndPkEjKn2
         j7+HDzR0oOkSndeCF9dDobRepAoDMgOONfb82i364FW4tY2z8wyYyKgDS3WAX63dJVxF
         zTx8bx/rtJdpsWBSU8r5RCGTun7akWWOBnZolIaKw72AwC4DnYnhSt6Pf6TWkgRV9Bbq
         YV3TacyfUr1kOM/K4AuJKDYNXK3fcvhTw/Lt8Vtm1AqcRz8s9IAIclQ0ojO9smFLeNox
         V9oozrN/z6SXJSdgXeIlRnmtKgYWuX2CDeLtGYHVAoQEQe9I4YWNMA2HwB+4i0RPwNlC
         l/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807888; x=1761412688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7YtyqkoqKD6VWdGbdex27QCyhVfB5yWUVWWXB11RvY=;
        b=kzkJ9aOYOC8VxFmkv0jgVrPIokUrkVSFLFsp6jL7YRt9D6jSuIFY6sL+XihZnFjZYf
         omyTIl9l5+IDq2gkGuRfD5nkD57z/fx/RhaH2NFmGlZNqZP7EsViUHX+Jq2cYotgRiiD
         hbXFBDFkiXGA8rtGpnHphc8MRdqI2HXbna0ByS0AXyFCHK8SY7NTc43gvzx4E4S4WXd/
         XwqjB/rFWTUxxOWLAphseMGj/Hjm1dRgWOv2f1MvaPYR88iFFXDztApuOu6vWHMIZa9e
         iLJTiLtLe0N/eUUYEwJQbJO5d0ubDqObC863zrAHRj/iPbPbJAcvOwWwgrRMpPYincJY
         TtNw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQAVtbVSiK01k6u4oIDtt0uwmZL67EODOdT5tb3rb7SfzyYDXJgUSpBbjE8pDM9W2vzfWgQKeupbC5Ac9REA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHCgYCFnalDznpxIellkhXCn5FuoG5QoqOk0jsZjd4YKtUBfh
	dp1jJ7FhHkk0PQ9/BFzok89/VjYSqB2af/AjW7UikL0buycillDWiHwwtNcqBB8RC1Y=
X-Gm-Gg: ASbGnctfZoEPW8PQf1BPArOZheo+SzOQWo/bM5HG6AFII0YA3uDZcPEZRfq7aB6IloY
	5oHNGU4AyR1VYZh0q13sos6qMVPp+dWFigrAb9g4fUX0e5SBSIdlRnvro3g3n5lEghv1uHL+CRQ
	BOBW53a787IFIcitUkY0dPuvwFwpVY5BjLxzWv8r4TuC5MwWrHt9NvYJ+XRaw6oEnFB+JG27Ies
	GzI3wPPnWy5on5SIQIucYUzGbRNtOuzL9qOa8Ue+82VrjGrpCLjCoVAWMzQkO7UbNWqKPsQ3336
	1wYTxEyIa8VYudsdFeCN12f82WefLz0M+DvWtzh0em9kXR4gzfJn5tQleAYREuKnwaMWh0wZxWM
	1CeYVVA8IDJwnBk545A47uxYAtJX3eINHmJvloQWNoH4adq0amcsDerK5ha0TmdgxtKUvBwj4LZ
	4AdInw8z2CEx+C0qb7xx00Nz1KUlYuMMWUFeCpEdBL1nXVYsOBX56nvjdrd2CNUa7fbyxQu863c
	l5rVL3ozCLhw3a/HZyVWG0osetd1KHP
X-Google-Smtp-Source: AGHT+IGtzHn/6DD3dWiswCVgFR84KeOf4/Bt9Z7b+lVvn1HSzoZWElRRGyMVVN30USlthvsHs20ChA==
X-Received: by 2002:ad4:5e86:0:b0:87c:43f0:373d with SMTP id 6a1803df08f44-87c43f039damr68609776d6.39.1760807888207;
        Sat, 18 Oct 2025 10:18:08 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:07 -0700 (PDT)
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
Subject: [PATCH v6 08/10] liveupdate: kho: warn and fail on metadata or preserved memory in scratch area
Date: Sat, 18 Oct 2025 13:17:54 -0400
Message-ID: <20251018171756.1724191-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
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
 kernel/liveupdate/Kconfig                   |  8 ++++
 kernel/liveupdate/Makefile                  |  1 +
 kernel/liveupdate/kexec_handover.c          | 52 ++++++++++++++-------
 kernel/liveupdate/kexec_handover_debug.c    | 25 ++++++++++
 kernel/liveupdate/kexec_handover_internal.h |  9 ++++
 5 files changed, 78 insertions(+), 17 deletions(-)
 create mode 100644 kernel/liveupdate/kexec_handover_debug.c

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index cea287842475..851d1a22b4c5 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -27,4 +27,12 @@ config KEXEC_HANDOVER_DEBUGFS
 	  Also, enables inspecting the KHO fdt trees with the debugfs binary
 	  blobs.
 
+config KEXEC_HANDOVER_DEBUG
+	bool "Enable Kexec Handover debug checks"
+	depends on KEXEC_HANDOVER_DEBUGFS
+	help
+	  This option enables extra sanity checks for the Kexec Handover
+	  subsystem. Since, KHO performance is crucial in live update
+	  scenarios and the extra code might be adding overhead it is
+	  only optionally enabled.
 endmenu
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index fcdf163b4b0e..f52ce1ebcf86 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index c87d00c40c82..ebfc31814d16 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "KHO: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cma.h>
 #include <linux/count_zeros.h>
 #include <linux/kexec.h>
@@ -131,26 +132,26 @@ static struct kho_out kho_out = {
 
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 {
-	void *elm, *res;
+	void *res = xa_load(xa, index);
 
-	elm = xa_load(xa, index);
-	if (elm)
-		return elm;
+	if (res)
+		return res;
+
+	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
 
-	elm = kzalloc(sz, GFP_KERNEL);
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
+		return ERR_PTR(-EINVAL);
+
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
 	if (xa_is_err(res))
-		res = ERR_PTR(xa_err(res));
-
-	if (res) {
-		kfree(elm);
+		return ERR_PTR(xa_err(res));
+	else if (res)
 		return res;
-	}
 
-	return elm;
+	return no_free_ptr(elm);
 }
 
 static void __kho_unpreserve_order(struct kho_mem_track *track, unsigned long pfn,
@@ -350,15 +351,19 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk;
+	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
 
 	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!chunk)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE)))
+		return ERR_PTR(-EINVAL);
+
 	chunk->hdr.order = order;
 	if (cur_chunk)
 		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
-	return chunk;
+	return no_free_ptr(chunk);
 }
 
 static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
@@ -379,14 +384,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
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
@@ -396,8 +404,10 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 
 			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
 				chunk = new_chunk(chunk, order);
-				if (!chunk)
+				if (IS_ERR(chunk)) {
+					ret = PTR_ERR(chunk);
 					goto err_free;
+				}
 			}
 
 			elm = &chunk->bitmaps[chunk->hdr.num_elms];
@@ -414,7 +424,7 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 
 err_free:
 	kho_mem_ser_free(first_chunk);
-	return -ENOMEM;
+	return ret;
 }
 
 static void __init deserialize_bitmap(unsigned int order,
@@ -737,6 +747,9 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.track;
 
+	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+		return -EINVAL;
+
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -784,6 +797,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
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
new file mode 100644
index 000000000000..7986dcc63047
--- /dev/null
+++ b/kernel/liveupdate/kexec_handover_debug.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover_debug.c - kexec handover optional debug functionality
+ * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include "kexec_handover_internal.h"
+
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
2.51.0.915.g61a8936c21-goog


