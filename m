Return-Path: <linux-kselftest+bounces-43494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC42BED4A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 19:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA2B5E762F
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B925BEF1;
	Sat, 18 Oct 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HtRAWs/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47325A357
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807886; cv=none; b=cz+PT5KYKmhN+3aeUbsZ86RuCjwidilDovoRrxCfK/Y8x4tJque0f+/0plMMbUSyvseuY8LyEAGubN0+KSkEKb277Ty89jP8Nltkm/veYI/6w5KE7GsmPUamhhxiZu/HwADWhFTcHqHW6tPG4TRNrHXiCpItpG6f+gNCWwtVkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807886; c=relaxed/simple;
	bh=UfAjUKOmtRahZzYSzroX9h10xJO3sdQqYWdEbTdGpjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENzsldxFeFmormtPJLiJWPxZedyoXtqxR2X2OnllU9ceP9gYsyxRb0Mh/mBDBdDoBojRlDfFY0xWY9s04OPuUcJ3MuoQNTS1P8HCNY9PLb6URvV0+llMImWFkohS0NIMtQBUqQGn6OpEKFw4A9DzQjL+oLEP16O6wCHLZMOfepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HtRAWs/Z; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c13813464so53831926d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807884; x=1761412684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5WHxfW3SzIizo02A/UzhAYaawAGGPcI6431h04qDCk=;
        b=HtRAWs/ZmlLfwWURKigzWitdugmxD0ORBrwivOZsE9pzooMmsm9WsQCzGZAbb4F5wR
         w7WzHYBrAzMqP4Yj5xPx4Ir/XLjGLKPanEiMQtLQBZYUUA6P1xtfOYYpKULu16LxEc2+
         uSUOqvtCqpyYR1MZ2LyuGDnl6kPoj+0IX8mDDlX9cqHMAO6utwXDJXHRdWVIJmeVWRUz
         spwcQ8tQloP0C4KCsMsr/gSVBaxMTlhJUl/v7Lqh7aeMQ/bNzME6rZXvoKId3CmmRedS
         DIJ0mIxj7bmzEqh5X9X1h3SwB1YXpeM8wCByIF1LqSIICBTpSc2f1hil2RKKU/NA4q5W
         FXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807884; x=1761412684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5WHxfW3SzIizo02A/UzhAYaawAGGPcI6431h04qDCk=;
        b=hwsuIznrK2ADOEgUL7epbVS2XaYB7slwgRKBsr+orIFgoAQ6XBmDY6KJ5IA9gFr4y+
         Ms4Cc5cf4vd/dalFjlfoe/7All2BYeoIbt1fSfw6c1POnXu0EBER7s278Jjis75j7Xbv
         5qr7ZAJg00w3wuDUe/xYKH6/W4ukzMcvfZZ6/WkoSxkCE4wIKc2j9S/UhCWWRjWkOQLH
         nrgHCt8cHAmMY2HH4qjdEeacrkKQdUvoFwyHXCGlX+bPRVf7x0lPSTohJuTX+ks3OVPG
         Z/AoT6/5EOOoS19S1T+jZ+XaR7pZALXmZBbVtdQVsah4/HINxDhsXfo4sN7PX88fttW/
         DraA==
X-Forwarded-Encrypted: i=1; AJvYcCVTzkFKqiS7yJ7TPIZ24AmFwuGaG9OuJ1iEYnosHFMO1lSHc6SdYd2pY8F81muhi3j1x846nphqe0Z4GFU9c3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8L2EEajhdivABhOV/hfnWGyEmELmYatkF3X0rQJDY02r5bRr
	X7g+DZ4KXx2JwajleiWBgLBF3QUroDSbohfyUWr59VQwla3bk6YVFkLg5xXNtHSu33M=
X-Gm-Gg: ASbGncv0ek7EzU4aYa8A0SXwdTWeJICOpu4YCPJJseJg3bqQtayYYi1IpXfFLtm2Pd9
	b78Uj6Z4DN5fZjLT+tzhGKLxto2NGU4DxkrDiQp+bkgZeCsv/XSAGRqLhotFCU/38TbSLDvkUqW
	s6oPz/qjwLtmmVWrAEoe/e94+2hxAOhW5d91xErzItL7o6BuetQylw/E1CetjAQInfF4eHocVW9
	SZk1Hbvf/1MzY/IeWfADHra15TyZqLVkLbsl1+YQdLxjjZ48Cn8lqXxa0yULpPnqTYx8vNnVoWY
	/cQSkmaduxVEWWmFA+yrAckaSds9u9hGspmmoD8ZGz52B75EOfLiOgnZ4cp5A8lLp3rRQLTk+g9
	R97uXLp1Zg6nZMYOMzJH5k3i5alKkJzvMRnmTgfaDeAxnFE/a6pa5hdi9AaGzeEqWJwoVLLbgWY
	ntoMicZ09bFfhfmSjcOhrfnHrktzW3B3SuC08hmiNKrmcqBhE521U781XtsMIzWWMIt5FDf1BOO
	mXUSFec3l8aZ4dgofLZ3A==
X-Google-Smtp-Source: AGHT+IG0KpOyqwiHpmU8fcJJ9o2guHulcSg9jALnJeFdUCRHHRENhNr850M5g3dIeP0VTEoRasLhkQ==
X-Received: by 2002:a05:6214:d04:b0:87d:cabd:d4a3 with SMTP id 6a1803df08f44-87dcabdd615mr25975966d6.49.1760807883659;
        Sat, 18 Oct 2025 10:18:03 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:03 -0700 (PDT)
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
Subject: [PATCH v6 04/10] kho: add interfaces to unpreserve folios and page ranes
Date: Sat, 18 Oct 2025 13:17:50 -0400
Message-ID: <20251018171756.1724191-5-pasha.tatashin@soleen.com>
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

Allow users of KHO to cancel the previous preservation by adding the
necessary interfaces to unpreserve folio and pages.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h | 12 +++++
 kernel/kexec_handover.c        | 85 ++++++++++++++++++++++++++++------
 2 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 2faf290803ce..4ba145713838 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -43,7 +43,9 @@ bool kho_is_enabled(void);
 bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned int nr_pages);
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
@@ -76,11 +78,21 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_folio(struct folio *folio)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e6890fe6a171..78acaa218c12 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -153,26 +153,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 	return elm;
 }
 
-static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
-			     unsigned long end_pfn)
+static void __kho_unpreserve_order(struct kho_mem_track *track, unsigned long pfn,
+				   unsigned int order)
 {
 	struct kho_mem_phys_bits *bits;
 	struct kho_mem_phys *physxa;
+	const unsigned long pfn_high = pfn >> order;
 
-	while (pfn < end_pfn) {
-		const unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		const unsigned long pfn_high = pfn >> order;
+	physxa = xa_load(&track->orders, order);
+	if (!physxa)
+		return;
+
+	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
+	if (!bits)
+		return;
 
-		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+}
+
+static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
+			     unsigned long end_pfn)
+{
+	unsigned int order;
 
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+	while (pfn < end_pfn) {
+		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
 
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+		__kho_unpreserve_order(track, pfn, order);
 
 		pfn += 1 << order;
 	}
@@ -734,6 +741,30 @@ int kho_preserve_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
+/**
+ * kho_unpreserve_folio - unpreserve a folio.
+ * @folio: folio to unpreserve.
+ *
+ * Instructs KHO to unpreserve a folio that was preserved by
+ * kho_preserve_folio() before. The provided @folio (pfn and order)
+ * must exactly match a previously preserved folio.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_folio(struct folio *folio)
+{
+	const unsigned long pfn = folio_pfn(folio);
+	const unsigned int order = folio_order(folio);
+	struct kho_mem_track *track = &kho_out.track;
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	__kho_unpreserve_order(track, pfn, order);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
+
 /**
  * kho_preserve_pages - preserve contiguous pages across kexec
  * @page: first page in the list.
@@ -773,6 +804,34 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_pages);
 
+/**
+ * kho_unpreserve_pages - unpreserve contiguous pages.
+ * @page: first page in the list.
+ * @nr_pages: number of pages.
+ *
+ * Instructs KHO to unpreserve @nr_pages contigious  pages starting from @page.
+ * This call must exactly match a granularity at which memory was originally
+ * preserved by kho_preserve_pages, call with the same @page and
+ * @nr_pages). Unpreserving arbitrary sub-ranges of larger preserved blocks is
+ * not supported.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+{
+	struct kho_mem_track *track = &kho_out.track;
+	const unsigned long start_pfn = page_to_pfn(page);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	__kho_unpreserve(track, start_pfn, end_pfn);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
+
 struct kho_vmalloc_hdr {
 	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
 };
-- 
2.51.0.915.g61a8936c21-goog


