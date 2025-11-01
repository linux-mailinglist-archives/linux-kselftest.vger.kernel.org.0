Return-Path: <linux-kselftest+bounces-44570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E10C280D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87751A21C10
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133F2F9DA0;
	Sat,  1 Nov 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="b+JMHsP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B682F5A03
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Nov 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007022; cv=none; b=MIHo+WLIgWjXB0jc4TXSBPjwMEgdskdAhOURlwId7GYJqc/aBsjfiHqeTdMtZUYHxm3/t1q7JQq49d4o6Od/Us/7CwbBKoy7mpIobdBCsYv11I/pOjs0GPyRhRV/LTWjH1WOyTueT3awzI4GmrRKizkPP7tVRf8p6lNLvJB6oDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007022; c=relaxed/simple;
	bh=jB2u78ATcqK9LLqZZ+Q3rTKqdWaeTrOa+pQpqVZpFJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+eyvBsCypbzA+/rzHm/KwnTjOj6bzHaZKHaLiNLLXu3S6mT30iBUfl7/uKz/S96aqNAvbbEER5dnQgNN1krxCJ0aAZBnjDt0U56fvNDzQaAhLaaEFEq8o3lPrK1+bmRYVDdvUMHBPDAaaldSV4HQ9h8CvyLZEt7XviWsldNC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=b+JMHsP1; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932cf836259so1441928241.3
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Nov 2025 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007019; x=1762611819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DCkHyYopvb0wF2qt5OuiBAkk+v7Kgo7WmWoUc1PDLE=;
        b=b+JMHsP1GZLHHDMivTmJN6GNkVuAnG9CRYQROZhNZqaryMcvcAobPVP9x11mJ3FPsm
         v2bjyOnroQUtxY5OXPbIMgEOsIPNP62TzinYe0uOhtVF3uHRWp6ZdoXV2e8H4A64YK/Y
         TEdH2py8+CeFXSrUM3mHD4xr6j/EAezkblxkCTf1Io9KS+0CiSRRl7HdrYNxerpAGDYC
         DEPiAYD2ZPTnaY2W0eCqxSvFyWMdrnojwUmw/WEdb+kK9BM9+npYdt28iRoySKi/x7se
         oSHrQq6rN0k1Q1EiIvf9icIZ8itvzoNRI93xhV7GCFE6ujPiv/bep7Vbp2/sq3MZGE7n
         8OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007019; x=1762611819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DCkHyYopvb0wF2qt5OuiBAkk+v7Kgo7WmWoUc1PDLE=;
        b=ImtPfB9ge6Rlv1EKKxhn+xtLMOrqKOLs/EWT7SWjLFLFOz1lcZ1Zf2WlgKvgpTuCAx
         NeqV0dG4W/gOoErkiaOIEgLvOrXiVhMfNfMvCzyooRDtympk4ZpUmIVfeMnjdH8pGnZ/
         162o25c+hcJ1QauZMlzkGKuy7pQtvQT6XHy8KNzkDSaAuHfKxe+LBLY6+otaT9hJoYUV
         GHpBX9GS1lGpy7NU78LXHoyOggOXfFSO8HTpv5cXU2oGNUiyBOGYJYS1JRyJwZAtdEWx
         NG21Ud7TDeEpbX77CCNo51BUzBmBVBYyZeZ1K2pCPw12OKfRRGy7+Jr5M5ugvCF33WL2
         qmgg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ09bQNTFFbF3ghGfU0ZU+2rIKQSi63cUKhUpcXB8AmrnKMIAsUQMCDAk9dARQTYka6hBCiKVTiU7efCBhO2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGnk5SgCHK/TZ1HpsIPyqAf2PxBBhndgMustUcdGUuV2x6ddg
	y9yn0ooFMVHjFith52taZWVHqlaYFOSw9LS3rc/AlAtLoWF58S9FlH2btd1sTGJzxsA=
X-Gm-Gg: ASbGncu48xOQI58rKiqSeKPeTt2NrwlhleHFDFtuLWepAli2K8itlCG08FnZpE3JXCq
	Q5sLt091M/8eZVO70OrGulxXFfTJxih6riaLw9qnRgiZArbOSNmgcPzIgvgypGe82SlQUu4E1Y1
	QFbsOIii69D4TsFyOyUI03Ftai7+Du6cyfc9f27NtVc9e7yV4vp2SBpMGUFn3g60ZWOXSPvbeTk
	4XRM0v5McSkLi6inwusobdGkiFCDK5AMoCtgYNaYHQnhzD2x1hSl0LM0m65LOpaDq4g/jdRRjnO
	TqN7Et6TxJI3edvoM61YKCEtwJtJdktqsF3WImQp3Qv5K2erITZQtlUrxIEajy68uFtoJ1k7fEx
	rQ3Jv263KA1fD9YJB7/lNY9doQBUgF9LyKH/csuekAKTSqxIPdu+pl74APwn5MZHpylkwPiXhLj
	w7WI/WtQu9rY6S8I/tguWvff+Gt+KcOA0wsubnGDsrc7kKaP181ZMWjU+fVIQMeMuuKrIznuo=
X-Google-Smtp-Source: AGHT+IGR/VzDF7AB+sIC/+cJHCH4X5S7Mi8sJ3f5dCfpSYmCmX5nmYDVJr+NLnssvgjti7LClYe3OA==
X-Received: by 2002:a05:6122:21a8:b0:54a:23dd:5a9e with SMTP id 71dfb90a1353d-5593e270143mr2102007e0c.3.1762007019132;
        Sat, 01 Nov 2025 07:23:39 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:38 -0700 (PDT)
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
	yanjun.zhu@linux.dev
Subject: [PATCH v9 4/9] memblock: Unpreserve memory in case of error
Date: Sat,  1 Nov 2025 10:23:20 -0400
Message-ID: <20251101142325.1326536-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is an error half way through KHO memory preservation, we should
rollback and unpreserve everything that is partially preserved.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Suggested-by: Pratyush Yadav <pratyush@kernel.org>
---
 mm/memblock.c | 73 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index e3bef9b35d63..f527ad1ca682 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2445,29 +2445,60 @@ int reserve_mem_release_by_name(const char *name)
 #define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
 #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
 
+static int __init reserved_mem_preserve(void)
+{
+	unsigned int nr_preserved = 0;
+	int err;
+
+	for (unsigned int i = 0; i < reserved_mem_count; i++, nr_preserved++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+		struct page *page = phys_to_page(map->start);
+		unsigned int nr_pages = map->size >> PAGE_SHIFT;
+
+		err = kho_preserve_pages(page, nr_pages);
+		if (err)
+			goto err_unpreserve;
+	}
+
+	return 0;
+
+err_unpreserve:
+	for (unsigned int i = 0; i < nr_preserved; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+		struct page *page = phys_to_page(map->start);
+		unsigned int nr_pages = map->size >> PAGE_SHIFT;
+
+		kho_unpreserve_pages(page, nr_pages);
+	}
+
+	return err;
+}
+
 static int __init prepare_kho_fdt(void)
 {
-	int err = 0, i;
 	struct page *fdt_page;
 	void *fdt;
+	int err;
 
 	fdt_page = alloc_page(GFP_KERNEL);
-	if (!fdt_page)
-		return -ENOMEM;
+	if (!fdt_page) {
+		err = -ENOMEM;
+		goto err_no_fdt_page;
+	}
 
 	fdt = page_to_virt(fdt_page);
+	err = kho_preserve_pages(fdt_page, 1);
+	if (err)
+		goto err_free_fdt;
 
 	err |= fdt_create(fdt, PAGE_SIZE);
 	err |= fdt_finish_reservemap(fdt);
-
 	err |= fdt_begin_node(fdt, "");
 	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
-	for (i = 0; i < reserved_mem_count; i++) {
+
+	for (unsigned int i = 0; !err && i < reserved_mem_count; i++) {
 		struct reserve_mem_table *map = &reserved_mem_table[i];
-		struct page *page = phys_to_page(map->start);
-		unsigned int nr_pages = map->size >> PAGE_SHIFT;
 
-		err |= kho_preserve_pages(page, nr_pages);
 		err |= fdt_begin_node(fdt, map->name);
 		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
 		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
@@ -2477,15 +2508,27 @@ static int __init prepare_kho_fdt(void)
 	err |= fdt_end_node(fdt);
 	err |= fdt_finish(fdt);
 
-	err |= kho_preserve_folio(page_folio(fdt_page));
+	if (err)
+		goto err_unpreserve_fdt;
 
-	if (!err)
-		err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+	if (err)
+		goto err_unpreserve_fdt;
 
-	if (err) {
-		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
-		put_page(fdt_page);
-	}
+	err = reserved_mem_preserve();
+	if (err)
+		goto err_remove_subtree;
+
+	return 0;
+
+err_remove_subtree:
+	kho_remove_subtree(fdt);
+err_unpreserve_fdt:
+	kho_unpreserve_pages(fdt_page, 1);
+err_free_fdt:
+	put_page(fdt_page);
+err_no_fdt_page:
+	pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
 
 	return err;
 }
-- 
2.51.1.930.gacf6e81ea2-goog


