Return-Path: <linux-kselftest+bounces-43164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0952CBDC9B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 07:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B4319A3343
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 05:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28A305953;
	Wed, 15 Oct 2025 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ixTTt9g0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD4303CAB
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506289; cv=none; b=YX4CR0tOwz/sRc2K97n4t8tCyFIYbL/legnkudYzTx4qK51+15bbOoc6EhQA8Ght5nim+t9MthlvSJU9ZZxnULs7qhhf6Ff0t8gIK5LKHOpL/n+n2jtihkxXAX1S3Y7Jw6A1eUb9UdBXvdHBJolsXOuQWspcN/q7ekruqSCl+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506289; c=relaxed/simple;
	bh=BdnosJBafIBbr/NCbnwo7SIL/Sjz77dLU/WcbJ2dFgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POzyMy66W+yrXHibs9tLdmgMB/dGhCbWBqJHCO+kdOvT5ZBkI9gvr3+Z6tmVFIEnuU9KsZAnhN79MgzmI5wU1v0H6+8DAa+MCHYascVZBkc2nSJzzG1GwPOyBnzqw0s5ztPUhYwU10bgS7B5ertWZOl6Lu27VZlFB+wbcsPxdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ixTTt9g0; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-795773ac2a2so75584426d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 22:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760506286; x=1761111086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FafVbqPqqghkiY9qF9XINT78tn3vhuL4HedTbB/bm7U=;
        b=ixTTt9g0G2y0V7I4orxzVgIMGtKfbvOk2ycqz/hTtAzU57YSxV1wZu0YhYKoEeUrcV
         8NfM8smgkwi3qSfiPd83Hc/hunooAhf0O1gLzbmb1ocN5apqoHL8L0ioEpVo67fXJ7QL
         4odGpNHYjMRrgvdltCN0QgqTWev18CRlaDRKcEn//GWF13gfvIhqzTl35Sib4qG5ZgBK
         SrmZeeb0o4v6epqSl/+C0OOz+5GcUotvIv+iROu6e1S/3GdaRhz9cIN0MFDzncDi7XJZ
         rTIGpLzi+B+iRG0xIkGFeT4Qp3WUlineyWfP00ytfcur+8gpxTvTaep2lV5tEiMV+9Gu
         0Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506286; x=1761111086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FafVbqPqqghkiY9qF9XINT78tn3vhuL4HedTbB/bm7U=;
        b=IKdGheHJlp6+0WzuDtEMDWlfOqo5lrj1kO8ENMdOspxhp2eVoOo37/wSAFLq0L+AvP
         J23tHyNmUyUNrwvpIIchjwGsBaNailVD386gtf478YLqyKpccIIbIkzRyqBeR7Vmyz26
         gCBMA9dEp5mPMxnrUMP9As6WbAVZ+Yx8LMQh2NN+fa3oTwN98aoQiKHEX61obVRyuDEi
         EaLnRNbAM8gUwDpBYSvxkHuZp8PtBCfsgCVxZFlbK/QSm8loXsKSiJkCvAAuJVH2yrqS
         7DVnbXP4M/V7/+I8LwtFSe0it9lZ1SdxggqSeMmAaAKkukifEDX1zgwbCC0R4BxQLFfg
         FfRw==
X-Forwarded-Encrypted: i=1; AJvYcCWXMU3aAom8H1PAJXsbKGxMzJsLKVvkYBgUURJo9RaxlB1N80H2r3TMwXYfi1Z8Fbn+TN8tXHcyQzsdpspCekQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9OajogTPETZsRU4MKOh/GLg8kKOaxyrPbGAwfwZheVUbBmI7
	9jYxNm/xVlNz497+qXvIcZo1iUHFCrpX/BNdsvlXusvjoLMvTWA3OYglQzC55h3Jewo=
X-Gm-Gg: ASbGncuz7fI+8HIHPBkfUMqqH6Nkv4CFHHTUnLpnDPjowB7MgE5ZuWV3rJM3LQL2u8X
	NRtVLmBGUCvC7NZ9ssbSYpXunncH8zxJBdnJvaa2pT8htgMgJbx8pVzqzzTsstbhhthOM1fx9XH
	hOPnJ7YosNL7j8kER/0CJAmuwMAN/tYr7LNru7QDZzicQFEQykpS+S35mknSyCzg+30eeDtKed0
	qpUMExnvg/bT8deLwmrKhEHHorSEO3AsKY/uG0G2rfueIiYzDIZIeLJ2fYnf7NpYqnjpPnowtz4
	QSN08bTPhqVdwmdJT5sIQAGDxEqgsEcaCMIaBGcmKIN2OHIcoA/Ae7RwGPLA/+9EFwwL7gFaAjO
	aAlWzTQeIBXBU7ciUbtzj9lB0EBARP5u7UhAEOO0Gr5Ejtu0FxQPp4Q4jhWodkB1dS7d6fKHjlq
	toaQmU7TPK622jYSuSGtLk1hkOyeQF7MrKAV2vOjGrOdWDatO3CF28+RppdWA2QOkLmwZA7Q==
X-Google-Smtp-Source: AGHT+IGvaOjtebHTY4xqeM9VAkjbOuxZRyjyvVAjhxRq1HVqYOgUVhQRKbC9OgNICKBqZLQgdl0h1Q==
X-Received: by 2002:ac8:578c:0:b0:4e7:20d3:ca6a with SMTP id d75a77b69052e-4e720d3ce13mr138489011cf.1.1760506286449;
        Tue, 14 Oct 2025 22:31:26 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881d01f5asm12572661cf.27.2025.10.14.22.31.25
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
Subject: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the buddy allocator
Date: Wed, 15 Oct 2025 01:31:21 -0400
Message-ID: <20251015053121.3978358-3-pasha.tatashin@soleen.com>
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

KHO allocates metadata for its preserved memory map using the SLUB
allocator via kzalloc(). This metadata is temporary and is used by the
next kernel during early boot to find preserved memory.

A problem arises when KFENCE is enabled. kzalloc() calls can be
randomly intercepted by kfence_alloc(), which services the allocation
from a dedicated KFENCE memory pool. This pool is allocated early in
boot via memblock.

When booting via KHO, the memblock allocator is restricted to a "scratch
area", forcing the KFENCE pool to be allocated within it. This creates a
conflict, as the scratch area is expected to be ephemeral and
overwriteable by a subsequent kexec. If KHO metadata is placed in this
KFENCE pool, it leads to memory corruption when the next kernel is
loaded.

To fix this, modify KHO to allocate its metadata directly from the buddy
allocator instead of SLUB.

As part of this change, the metadata bitmap size is increased from 512
bytes to PAGE_SIZE to align with the page-based allocations from the
buddy system.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ef1e6f7a234b..519de6d68b27 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -66,10 +66,10 @@ early_param("kho", kho_parse_enable);
  * Keep track of memory that is to be preserved across KHO.
  *
  * The serializing side uses two levels of xarrays to manage chunks of per-order
- * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
- * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
- * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
- * 512K of bitmap memory will be needed for order 0.
+ * PAGE_SIZE byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order
+ * of a 8TB system would fit inside a single 4096 byte bitmap. For order 0
+ * allocations each bitmap will cover 128M of address space. Thus, for 16G of
+ * memory at most 512K of bitmap memory will be needed for order 0.
  *
  * This approach is fully incremental, as the serialization progresses folios
  * can continue be aggregated to the tracker. The final step, immediately prior
@@ -77,7 +77,7 @@ early_param("kho", kho_parse_enable);
  * successor kernel to parse.
  */
 
-#define PRESERVE_BITS (512 * 8)
+#define PRESERVE_BITS (PAGE_SIZE * 8)
 
 struct kho_mem_phys_bits {
 	DECLARE_BITMAP(preserve, PRESERVE_BITS);
@@ -131,18 +131,21 @@ static struct kho_out kho_out = {
 
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 {
+	unsigned int order;
 	void *elm, *res;
 
 	elm = xa_load(xa, index);
 	if (elm)
 		return elm;
 
-	elm = kzalloc(sz, GFP_KERNEL);
+	order = get_order(sz);
+	elm = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
-	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
-		kfree(elm);
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm),
+					PAGE_SIZE << order))) {
+		free_pages((unsigned long)elm, order);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -151,7 +154,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 		res = ERR_PTR(xa_err(res));
 
 	if (res) {
-		kfree(elm);
+		free_pages((unsigned long)elm, order);
 		return res;
 	}
 
@@ -357,7 +360,7 @@ static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 {
 	struct khoser_mem_chunk *chunk;
 
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	chunk = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!chunk)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0.788.g6d19910ace-goog


