Return-Path: <linux-kselftest+bounces-40680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F79B415C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 09:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855411B235D7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADDC2D97AC;
	Wed,  3 Sep 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF6+5Iuk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AB28489B
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Sep 2025 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882983; cv=none; b=Cjln90SQdiKhMCyJ03uSgFfQISJF2dl2JNA5ubbjn64RjdICzKpvNYQG4c+zMkFPxqGq7NtVJ8iBbYodOlFFTKy5sUd5vRl7QzJIOR7RahcOZbTmD7+R0NuLumtQ/0ihduyfdOsC1/BSlraThwNr041OKR0Zb08WrC7F/R8ghEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882983; c=relaxed/simple;
	bh=cGxYaP/TStMGS1V/VrFpkZixpeXkHuQjgoaPDRxiqhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMVF3V/N1R9Ehr9/oiI8atRBzKsAy6pB043zj7VJcy+PcBejB6D3IZHiQddDt0Iyo1s4tIfVBvoqalq/9e2zhslX5/uctJlWt3f2m/9osaxzK66+CseOXMST5PgofpX0xpab3zbPOwsk93q1XfsxjFC8bHeykKnyuU5oE3nSCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MF6+5Iuk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756882980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yhEzid0coX4qzN/T+DJZ37q8NluTxlwBeVgR6BscUg=;
	b=MF6+5IukKCZIuLyz69X3epLsAWCGqnmhAtDBpXRO+R3KtINO+Gwrh8CAyugSp5egzlIxWS
	kKEIhMXHXWzEoQWwiQxs2WJp4mTzWhlRIsbU+huPCyit33I6c7D36Dgov56Hky9PwK87pO
	1wMFo8tjkZrph1WacG5WncCFvS1uG4o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-SzNfbgi7NHyfFBfumn8BIw-1; Wed, 03 Sep 2025 03:02:59 -0400
X-MC-Unique: SzNfbgi7NHyfFBfumn8BIw-1
X-Mimecast-MFC-AGG-ID: SzNfbgi7NHyfFBfumn8BIw_1756882978
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df19a545c2so141597f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 00:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882978; x=1757487778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yhEzid0coX4qzN/T+DJZ37q8NluTxlwBeVgR6BscUg=;
        b=l17oHdHo4dwuGF15W3/nAd0+HJARdacaMZQSEC58+bohzm/A0MmBv4GNk+oPBiMNl9
         GHCO4Y5enz2HiyIilUci8i70EKSf/I+5PoyJB8b846rRsfgviXgaSTaqUpXga5YweHpV
         UVEs6diE2hNX05Ab2eHA2irq999nIytnUf5I3MuretcYSwLuCTely814L1eVg6X68xxu
         WbLSah6dkzIohve+ki7KZGKDeYWRa0Ep1v5/7r2YBX8TDRO1eCoO5UA6DEi9GejvZoac
         6KtGe2WN4rN3zfp6mfbJOm7G2U69v0ImqE6Pm7cVplSD/PIKZRuUR0t/RSHA+VWLl2ei
         vCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGmOMgMKjhnumFIzdIoIY/w3lC6Q7i5hqdMwHaNjtx9TAPZsCfiKzKVnKpgXTFm/xhku5I+A//uzsguTVyo4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9FGHQesC9XsP5CKKGfjJwrEvouRUoufgh1exmFmCvBrTMloOc
	wa6vQxLL20LbC6O8hYcMfiGMiLwDUYDXvGkLosmA7eEBx9bMf5m+Pup8wtsBmG31zXAVj0jM41l
	zOiJWuoTt5UfUq3e0IrA3JgOZmN90RAft/YRMyKnZB3cbS/XDUTcVsqMWCf4fLgF9YR5tNQ==
X-Gm-Gg: ASbGncu+VE/HIuJgFyjsBh7L5IMUu4CeX4CHQlSCcmGlElzDpACNA8YgRBeCaHpeTvZ
	8EmPWeWtFO0v1Qs8Yr6stIj85mTV4j6NqcBcRhEmRk/bmNxWh1c2sWfx9bmVoNXZdtxWn22nfYt
	r7E1h8gMFn8yKtK8vh7wb5ct0wQzDQdRB9JFLVBdvCr0ut26jEt15tolcCJnMPf2vELIdA9yfgH
	A4618E1TzBBNV8FoZGu+sd/25QDOXb0R7Ay6OsfwOEIxDnth2nyIjWfq3sCSVJ59k7+7bG6Un4+
	BnV3LTJ+JY3Za/iyB+k8oHntoK6zxmmclyBto00cR2zLW96JdOLnWAOSTP0+g33GfNi338sPLv0
	MVdtLPchXA4sFk66Vo9GVPQEi
X-Received: by 2002:a05:6000:290f:b0:3c9:ad8:fec9 with SMTP id ffacd0b85a97d-3d1df539f94mr10808511f8f.58.1756882977764;
        Wed, 03 Sep 2025 00:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6G9T+n01gQot9IX0ds2bfSowvj6oYMtabhkeOUIoI2hiuiSDp08eAIEryVuwexq/s1b1Xkw==
X-Received: by 2002:a05:6000:290f:b0:3c9:ad8:fec9 with SMTP id ffacd0b85a97d-3d1df539f94mr10808480f8f.58.1756882977316;
        Wed, 03 Sep 2025 00:02:57 -0700 (PDT)
Received: from localhost (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm309420145e9.1.2025.09.03.00.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:02:56 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 1/2] selftests/mm: split_huge_page_test: fix occasional is_backed_by_folio() wrong results
Date: Wed,  3 Sep 2025 09:02:52 +0200
Message-ID: <20250903070253.34556-2-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903070253.34556-1-david@redhat.com>
References: <20250903070253.34556-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checking for actual tail or head pages of a folio, we must make
sure that the KPF_COMPOUND_HEAD/KPF_COMPOUND_TAIL flag is paired with
KPF_THP.

For example, if we have another large folio after our large folio in
physical memory, our "pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)" would
trigger even though it's actually a head page of the next folio.

If is_backed_by_folio() returns a wrong result, split_pte_mapped_thp()
can fail with "Some THPs are missing during mremap".

Fix it by checking for head/tail pages of folios properly. Add
folio_tail_flags/folio_head_flags to improve readability and use these
masks also when just testing for any compound page.

Fixes: 169b456b0162 ("selftests/mm: reimplement is_backed_by_thp() with more precise check")
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 10ae65ea032f6..72d6d8bb329ed 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -44,6 +44,8 @@ int kpageflags_fd;
 static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 		int kpageflags_fd)
 {
+	const uint64_t folio_head_flags = KPF_THP | KPF_COMPOUND_HEAD;
+	const uint64_t folio_tail_flags = KPF_THP | KPF_COMPOUND_TAIL;
 	const unsigned long nr_pages = 1UL << order;
 	unsigned long pfn_head;
 	uint64_t pfn_flags;
@@ -61,7 +63,7 @@ static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 
 	/* check for order-0 pages */
 	if (!order) {
-		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
+		if (pfn_flags & (folio_head_flags | folio_tail_flags))
 			return false;
 		return true;
 	}
@@ -76,14 +78,14 @@ static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 		goto fail;
 
 	/* head PFN has no compound_head flag set */
-	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
+	if ((pfn_flags & folio_head_flags) != folio_head_flags)
 		return false;
 
 	/* check all tail PFN flags */
 	for (i = 1; i < nr_pages; i++) {
 		if (pageflags_get(pfn_head + i, kpageflags_fd, &pfn_flags))
 			goto fail;
-		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
+		if ((pfn_flags & folio_tail_flags) != folio_tail_flags)
 			return false;
 	}
 
@@ -94,11 +96,8 @@ static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 	if (pageflags_get(pfn_head + nr_pages, kpageflags_fd, &pfn_flags))
 		return true;
 
-	/* this folio is bigger than the given order */
-	if (pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL))
-		return false;
-
-	return true;
+	/* If we find another tail page, then the folio is larger. */
+	return (pfn_flags & folio_tail_flags) != folio_tail_flags;
 fail:
 	ksft_exit_fail_msg("Failed to get folio info\n");
 	return false;
-- 
2.50.1


