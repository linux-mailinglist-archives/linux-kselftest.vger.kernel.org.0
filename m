Return-Path: <linux-kselftest+bounces-43731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4CBF98A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 02:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDA59354578
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D541F4CBC;
	Wed, 22 Oct 2025 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="X0sPomhC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DF1E8322
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094647; cv=none; b=hF276NaRxXkBncPjnWhjHRvWNjqMbyPEDqLf+8qJ13CzUpUt4PPWn3N+dEI4WKlFTSSlmTIGZN/Dohvr/oxYOp/Oa2mzs3Mw2/FjbgKQiB88AKffng0zKWXE3aElqO+8lQQRgpd6O808PsDUyVFJFY6O2J+hI6Qa9cbZg3bmwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094647; c=relaxed/simple;
	bh=ICrvdx6JwZ+a9++79jXeIGR5Tgq/AzAu/D2kWon/kzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8MjvfMu9NWjSPTC5tnDJjnYGZU6rCIQvVNhe2f53blVULuHZgv29wJeh3bvBRw99u2wC1ijZhWfvBPAxvj3x0gyMfeGHKqXC764s+1ZYMuwnPJW86AJkJK4SObXwxrqP7x6Z+WFZlUGprVN0bTi3v6t0FjMB/6f3Mltqyuzl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=X0sPomhC; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e896e91368so6089891cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 17:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094645; x=1761699445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+qadFBBotkNKd/oqO1HqvVbgecomYazxdkikuzLBKg=;
        b=X0sPomhCLY/za10BMUYzO3YCpBv6ifhfY5YBgblyYdNfZpp1rBTFv6KgMISA3PLC7n
         7wdjPzDyqJrdV/IleZW0OPDf1wvPxCJvWTbvOk508wBjbDbzBpQW4o4sZyFnevg/YoaW
         8Xr1aQVMKewz2KKzW/3w5ns7efMfeAR5xMKQ2cpFs/ZS+LcnzXJmcfbDY5W9TSGJ1rOJ
         XfG85lfKaoLqg6eeIoht5IF04oUbXOMH5ZoreFZhFqxVZnwNZl7Yn7QkRvCCP6HvjX5o
         Hxyh63ExI70DnHnv+vlqwa3HRt5wO06P/muW1aaI2Z6U4rnXfFKZAmQyjUZnKHSTuhvF
         qdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094645; x=1761699445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+qadFBBotkNKd/oqO1HqvVbgecomYazxdkikuzLBKg=;
        b=km/gLNSiiY3H7TFuG9zNUHFu0PuKBHkrDHjWbw5GmBF/7GE81io3JeMRVbxiOeQQbg
         qO6F+Ghn4WT5R1Z0Ai6hsVIdB0E8N2teBW7MNtJudv7S3DT1JompQzyaXYglXaVFme7f
         qQlUv31ivL7hjFTCQWkwg9o9IkIFVuo0T7vJAlxd+2IluBn7xJ0MVE6qWBRRSU8Up/BA
         kIdggJWjb2pr86dCYOIZvDuQGa+wj66o2T/FKx0KCncvff3VWnIQekpZ5E3GhlORf/6K
         5hULyVT+CytLMZGqi8LTX/CZ6mmKcA3yqE3ksZcJomu3sTU0Pz26UEQS0vbEuzPjrOsW
         dpdg==
X-Forwarded-Encrypted: i=1; AJvYcCVEt+CSzTu2Hl5twcGfLQc7/PQhZifhaWtGC7jr1u12z6/eYm7GqigP+NgMxIvbGckK6iNN8jOgcVADVUvXCK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwe4qa726VXTPYrDGzaZjceQcWkT91MwGIpiZU7K0q920VekCg
	WhPCdD5s02EbL3zuZfd3a88NQ2iyye2suzNAizTMQhz9Lu5PXDjP4L3ucJA7meBNHY0=
X-Gm-Gg: ASbGncv2Z0P6dJJYnKbyh6aVHhCjWwOsTDSG7pxYeDCZYED23K9jxZNC/HqMiBvl9aa
	TrP6YvHE1BGBXmkG2j6OXgEkkJG+DJReW4/eHt/1azx2tIximGc9QuFdVrsIO0CyGU8dxwO7g3o
	vYBFT8ZoqfD9Vk1iLb/q6ntiPqy5EFGF1S6gpakRVLQreUKun2KS1ngO+RG82U0p5fPB+1thAWs
	/28vOTRxNhsqqbwEPA/Jzh3qCwaNqn0HBNtidA9/+jLw4iY0iTXAiCi9phkNMDAimgWMAudY9HR
	U/fO8ywiJbfQz9s9uWQn9DYk8BKl+dD8tpSajZ4wxwHesDMVxf2Gx4fVn5EO5YpE+G1z8NlTPB6
	GkEpGG5L9T7fBIwiHotVSCSq0GA3/LvezUM9619x0x7hZam4f4BwD5tvKKZae7HXhdPChgGMN2D
	FgbCOMLkEFBkEMYDs3YQ4jz8ymPRyLhBxLjBR/YZQsMA6Wdm0j94KYeIqD1HOGNqnkixCxWc4Up
	BRhCZ/VnFG3hLf6YacDwjprFwEMA0Rt
X-Google-Smtp-Source: AGHT+IEbvWQwrifIahe6E5wZ3o39RE/3lexOa2z4QGwcdffIuvb1yOyb5Y/9vOdhLrPU2DTeJO1H3Q==
X-Received: by 2002:a05:622a:1206:b0:4e8:b23e:8558 with SMTP id d75a77b69052e-4ea0dea50e5mr93304831cf.77.1761094644824;
        Tue, 21 Oct 2025 17:57:24 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:24 -0700 (PDT)
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
	tj@kernel.org
Subject: [PATCHv7 4/7] kho: add interfaces to unpreserve folios and page ranges
Date: Tue, 21 Oct 2025 20:57:16 -0400
Message-ID: <20251022005719.3670224-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
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
index 0a4234269fe5..8412897385ad 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -157,26 +157,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	return no_free_ptr(elm);
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
@@ -749,6 +756,30 @@ int kho_preserve_folio(struct folio *folio)
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
@@ -793,6 +824,34 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
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


