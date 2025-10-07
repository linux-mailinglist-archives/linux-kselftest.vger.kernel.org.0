Return-Path: <linux-kselftest+bounces-42807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65468BC017D
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7923C2DC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE5820370B;
	Tue,  7 Oct 2025 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="P/xT3tRZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FA1D6DB6
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807874; cv=none; b=qXb2f7SkYDAzguq2WooRUaKW5bucVZodnytWVnn/WqdJswiqZOKfCwQBqP1c5xJEp7b5pumjZZvWzgyeYGoEuh3iNRiVnvn1LSt+2JYfGV45fwQmVO9MwY5zYv5u7Vk3JExxNQY7J+l6N+uSFTAzDILIBJ3qKnlbuE32YVUGDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807874; c=relaxed/simple;
	bh=7rwOb8p11Fksxm3ge+XkaEBcZqh7fpI8ewXvuhI4bgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAEYaL2DyejLbZjhhxNCeQ83eFVQWaTQTDfyQ1EjHRR4bolWATPl1sFEuDcIbCouebKUrt6qEmyRluvGokWzsGtjlJ4iePCJtwGeWO5JWmqy3ET6Qz19q7fA9xjq8ngaQXHkzJoXUuA8L3T+70gnGZPQyMedO3ZrhY8wHpntofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=P/xT3tRZ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54bc6f33513so3962957e0c.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807871; x=1760412671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d75MC7yX8fTJ3DXLRKGrsbPruNC6LGxufxG+WL9vn/A=;
        b=P/xT3tRZgLa9EwMvlLuS35/cGd2UZD/wyfTjmP9HG8VdLLXGxyBxKB/3ftfiWAFBKK
         qFe0ivJBTKxL34I/ehujZQA5DN8504P40lUrDFo5YvTrjGQxcaDf0c53t48E4I6AfefN
         XtVLA7KU5mEtvPpS69JLwhcM+ccnCGRzl28ytWuhkF82o7hhuUaKwNuqc2hlLmKvdiOn
         UJEIEmp/dnzHQvJXGsMJBP7MUR4Yeb+bU0sg6DGrx/HJy1ZpDQcCNg21bA0+1Y9oUfbe
         8yTILitv7lxyhSJ/Nl1c3I109Z52jodZfUMZ4IBZdPoLghJfGPUR0rM8B0HjucTpScAJ
         ljEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807871; x=1760412671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d75MC7yX8fTJ3DXLRKGrsbPruNC6LGxufxG+WL9vn/A=;
        b=qoU/oCYlFtqEcHfbcK/YTyTbc6tg85EWWyXC5M9tggmy/ID8FdVWAXItaMr3k2+nQ2
         Rg3x/w9u0k/GA8RNJzUEEa/lzOKdPr6NFVrdbvWo2mpuechnRH44iTVWHEysIQaId2w9
         Cvda6TAKEBrJlMGD9tdr7GJMosg+DoLgwxb8RKgrTxptSO66qh0oQBS581VYns9o9oiL
         B4yWvz86iejEm1LkFIDF2qIbv1IcwWD6CODYojaBz7RlA3N9ZALga3AYwQ3XQiwJjcZB
         RgOnK5v+PdWDtGmAf8EpRk/fdyBJWz6qlxkoGc5BliusEZhFb/lYkkGXmQMBzFOeuQut
         BuNw==
X-Forwarded-Encrypted: i=1; AJvYcCWxHXdtcZRwmyXT3bfVqMmy5mS89E8nUonwW/tvaQmTu1WMZDAZz2/cKAVfXpNkTNznPoaJ3qAQylRUV0vmb70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+WUzxH1kzVApeKRPECBxWJZ10VJ9qAEtLx1urWlHyFxxjaCn
	sAEetn50Tg5/SqemHgWHBfCPYkUxF2dgIUeFDhJb2N4QBlDLqfb9A6a7qlpL3nUtBW8=
X-Gm-Gg: ASbGnctyqJ4NtjeVJWIY13tFLizgqhOEXMu6/Tjb2a7u5VCqyCJBZ6UM4kWjIz8t1ZC
	WHo6+3IJPqMA03KunK9p1HoOGpzfnUI5xS2xGgplmI2St+Re2qCImcIA1lorYZRlLvHUyFsKq8d
	D8S+UThQHDP8/yDc7sgCFrkq1aGeogQt6bZ0JNeaPZ238UJRmAymWBDiQ70cwsCiZTi7gnQBDI/
	2SKGibG+clnrJqQfFKa6VNRm2gcWH7zupTKcrV9PfOYzk81pt7MsxXdBUGAtuLOGMYFeVqMnCsn
	eu8hblqmGiTztRIOxgJhNChc3y9Us818hwX6dmUieUe5dlixmq7jlsnusOHy4uOv72tDf5EELyQ
	aVXzCwowEA7IAZTpQ9jCZjBnKQG6wQweWXhOncSLsE7Isg6pcVJKT3rdDxNKml2w9oADvGmiAxv
	uo0wtQIuTHgk4IfuVe9XUPAN7QBzO+yDE=
X-Google-Smtp-Source: AGHT+IFIriag8/rRrhYuf3ipZRqogDe9fVyFCNEZ9cflZH8v8IsXkHoHC8oknMO6yF3MW6LcKWyWVA==
X-Received: by 2002:a05:6122:1823:b0:539:44bc:7904 with SMTP id 71dfb90a1353d-5524e8b6931mr5202328e0c.5.1759807871292;
        Mon, 06 Oct 2025 20:31:11 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:10 -0700 (PDT)
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
Subject: [PATCH v5 4/7] kho: add interfaces to unpreserve folios and page ranes
Date: Tue,  7 Oct 2025 03:30:57 +0000
Message-ID: <20251007033100.836886-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
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
index 846fb4aa6948..77fd7dd991d2 100644
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
2.51.0.618.g983fd99d29-goog


