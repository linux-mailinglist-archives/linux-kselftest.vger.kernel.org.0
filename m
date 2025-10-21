Return-Path: <linux-kselftest+bounces-43638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F6BF41B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 02:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB78B4228A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4C155C97;
	Tue, 21 Oct 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bWwFgpFH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15622A1C7
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005341; cv=none; b=ber3e7n6VmyKkS3uSxNdgM784H4txwgckeXJQ2JZPzER54nPqdip++XgBDOgu5PIRf9toZCUAnlZLIa1mvaNgKNAcZAUQUM/FRBTcRZ0SLLc4IMIZHuQln+p9HMIhm9OMTvyoq3HJ6DOmIqELIDaaX4Ha6uT8TSWnsE5MPmM+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005341; c=relaxed/simple;
	bh=WDnQ7yML0OCi7RtRqHYL6Y4X5Dr6aAb+8kQ+zx1g8z0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKbRMRqfYYwPzkVUP91wIEYQaU2AehL42qdbfiNgcVVU2iWpsKgIrX+5HWHwlFDzZAKDsUiNMrXjnNLDEdgUgj7QgPZTcYI5tZKb1uXAXzljg2CVUTVgC/xIT+l/TRWxOdaCO5vbbNzG3dl7DT9qpBWm/Ixu/3TTtFOeE7ZSY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bWwFgpFH; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so2202901e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 17:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761005338; x=1761610138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrUod6z9AaFkGeIJc9frhWccEivwV7gjE944YavE0C8=;
        b=bWwFgpFH1pI1SI+GzVHsrS5FPaSI5uSxIiy+lrX4pM3Pl5zPNf/rf4EKq9Zz3jOq0+
         /5NrgbtX5C9thIP6LgYKGIiQRIAdbrwwseNE1tmErB/LPyhA9pLtDwQgrPIancVCr9o6
         +cEf2X9WixQI1MUdSeai69IsWQznbYpA2V2gPF/R3AW9IBGPzZKKVtpbAMW2+iOXzTtY
         unDvKoqWpXGduuKljaMT1Yf55B4VSCpdSSZ0nSGnLK+H3K1iiHmpLGB4vpUvJinKd4IC
         34iGn3nwh2r8PpsYHUvY7NSx6LyZ4bnYQz5Nineot2T6J5dyT9fIIMiiXncLmi6/V+QS
         8aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005338; x=1761610138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrUod6z9AaFkGeIJc9frhWccEivwV7gjE944YavE0C8=;
        b=Kb0iMxek+YsDMKYnbyt7pHz2S6CIExciAe0tY/SEETYIHWAZMJf+G7oZRrR9dGubze
         nMSaGJJm474M/vbr+h/lljlonFVsnclUNNPp8WI+LjMVD+cH3wqaKTrIEjOx2hRRuO92
         T9K64RnuvC6ttHPux6CFzYVYhnt1E6sKCiQgJp1zArW/Xp/lhgJuoxy/kXILMoVppRNh
         NqQu1e/jxyWchp6w+78/NAYFK/qft/Ga2IPBJaikn2q0dNyGe2lWing3TVe1LrtyzUPw
         Kkte3id57HIj1Ghzh55xq72M1zz2ln7qM7F6ZbivIrTNATnnLNYhpfmXIBBAIUXNkKJW
         SXgg==
X-Forwarded-Encrypted: i=1; AJvYcCXjnU2Au9Nmozc1JGtg3wdN5ZY05R3sgYa3z0LXwp52J12bDG849N+AqbKumrJDXBVQKFc/6Yp8Mw9Wlp5p2Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjGAADfqlm24ZdiOLrsqBwcq4gWYwyTYwkpEZvgrEsgLWBGYE
	LeyZn4Iz71KeC5c8aBZ3DNMW0arnW08u5xpOYkzp0cxO2c/+q/dDekf3L94pWEvMKqE=
X-Gm-Gg: ASbGncvCGjxja5UhToWbAh5kcmrj1We82ed/BmZr3aIH3+vb9lAb8sXFoMKLxdapkOo
	rUTEt1L/T/pNxWEdNf7Q5YGw/KO3zn7+FbGr8LxFbFdiU/NMU7vZcRVeHPlA6i0k/jhwZ/EJ16x
	gYNPstD+QC1yWtafcNa04Tb3VcuMM+PFpbOPGPFUnMIlf4oUT0GuUKD+pVWfqab29u7C19VvWkR
	hn0HKu8dx5M5l+27UHHtV37EUNuXxpzqlqXREJ/YcMjJdZij7tCCp74xOse1rQ7du7ke7/FkNAu
	+BVgSXPnlQFz88r/WSyEoLz1xbFFp74LN3QYfQa9bI7vTBeCpgmhrJrsQgCCej+M29xDG/NYiPE
	NWG58l8KeIZwGfnwoZ5N72brQMfB6eEoYADDcjXe8KWwkhv2khIy8Avbo8u8GdRu2CU16wTTr7+
	96bg364Ycu1s5p1TeNm+wSuSAUNoj6YKziqTNUJONgxd2KS7+8iQX1mLMPwsS6jZ/iyGmsiihw2
	+9991Ml9xNhqBh9kwGWzWW6NCV2fVAv
X-Google-Smtp-Source: AGHT+IEXSBVMEN9foAesWnzieDCrIXltrdCTVWZ8zY0V+zYO9XF7MLbCmqXOk7hAXlRHd/2MI6iEIA==
X-Received: by 2002:a05:6122:1d13:b0:54b:bea6:a226 with SMTP id 71dfb90a1353d-5564ee6bfe3mr3839907e0c.11.1761005337567;
        Mon, 20 Oct 2025 17:08:57 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6e351sm2822882e0c.4.2025.10.20.17.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:08:57 -0700 (PDT)
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
Subject: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or preserved memory in scratch area
Date: Mon, 20 Oct 2025 20:08:50 -0400
Message-ID: <20251021000852.2924827-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
In-Reply-To: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
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
 kernel/Kconfig.kexec             |  9 ++++++
 kernel/Makefile                  |  1 +
 kernel/kexec_handover.c          | 53 ++++++++++++++++++++++----------
 kernel/kexec_handover_debug.c    | 25 +++++++++++++++
 kernel/kexec_handover_internal.h | 16 ++++++++++
 5 files changed, 87 insertions(+), 17 deletions(-)
 create mode 100644 kernel/kexec_handover_debug.c
 create mode 100644 kernel/kexec_handover_internal.h

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 422270d64820..c94d36b5fcd9 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -109,6 +109,15 @@ config KEXEC_HANDOVER
 	  to keep data or state alive across the kexec. For this to work,
 	  both source and target kernels need to have this option enabled.
 
+config KEXEC_HANDOVER_DEBUG
+	bool "Enable Kexec Handover debug checks"
+	depends on KEXEC_HANDOVER_DEBUGFS
+	help
+	  This option enables extra sanity checks for the Kexec Handover
+	  subsystem. Since, KHO performance is crucial in live update
+	  scenarios and the extra code might be adding overhead it is
+	  only optionally enabled.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/Makefile b/kernel/Makefile
index df3dd8291bb6..9fe722305c9b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
 obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUG) += kexec_handover_debug.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76f0940fb485..7b460806ef4f 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "KHO: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cma.h>
 #include <linux/count_zeros.h>
 #include <linux/debugfs.h>
@@ -22,6 +23,7 @@
 
 #include <asm/early_ioremap.h>
 
+#include "kexec_handover_internal.h"
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
@@ -133,26 +135,26 @@ static struct kho_out kho_out = {
 
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
 
 static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
@@ -345,15 +347,19 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
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
@@ -374,14 +380,17 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 	struct khoser_mem_chunk *chunk = NULL;
 	struct kho_mem_phys *physxa;
 	unsigned long order;
+	int err = -ENOMEM;
 
 	xa_for_each(&ser->track.orders, order, physxa) {
 		struct kho_mem_phys_bits *bits;
 		unsigned long phys;
 
 		chunk = new_chunk(chunk, order);
-		if (!chunk)
+		if (IS_ERR(chunk)) {
+			err = PTR_ERR(chunk);
 			goto err_free;
+		}
 
 		if (!first_chunk)
 			first_chunk = chunk;
@@ -391,8 +400,10 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 
 			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
 				chunk = new_chunk(chunk, order);
-				if (!chunk)
+				if (IS_ERR(chunk)) {
+					err = PTR_ERR(chunk);
 					goto err_free;
+				}
 			}
 
 			elm = &chunk->bitmaps[chunk->hdr.num_elms];
@@ -409,7 +420,7 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 
 err_free:
 	kho_mem_ser_free(first_chunk);
-	return -ENOMEM;
+	return err;
 }
 
 static void __init deserialize_bitmap(unsigned int order,
@@ -752,6 +763,9 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.ser.track;
 
+	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+		return -EINVAL;
+
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -775,6 +789,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
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
diff --git a/kernel/kexec_handover_debug.c b/kernel/kexec_handover_debug.c
new file mode 100644
index 000000000000..6efb696f5426
--- /dev/null
+++ b/kernel/kexec_handover_debug.c
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
+		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
+
+		if (phys < scratch_end && (phys + size) > scratch_start)
+			return true;
+	}
+
+	return false;
+}
diff --git a/kernel/kexec_handover_internal.h b/kernel/kexec_handover_internal.h
new file mode 100644
index 000000000000..05e9720ba7b9
--- /dev/null
+++ b/kernel/kexec_handover_internal.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_INTERNAL_H
+#define LINUX_KEXEC_HANDOVER_INTERNAL_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+bool kho_scratch_overlap(phys_addr_t phys, size_t size);
+#else
+static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
+
+#endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
-- 
2.51.0.869.ge66316f041-goog


