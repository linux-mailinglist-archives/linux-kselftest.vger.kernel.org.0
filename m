Return-Path: <linux-kselftest+bounces-17685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8518F9746C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA10C1C209D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB61BF806;
	Tue, 10 Sep 2024 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRcikCRJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CC1BF7F3
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011912; cv=none; b=Zw0QL7/EA6Q7RTQWXOtqUbJ0Tgzw0kplO0GnN5/o55CXwkJlThvR0S7D01/fZx2ds987KaBE5wsWlb2vk2G86YSV2JuRMv8MvSpIDiRu+JvXhesYkBMzFIgsNqXiqZ33ZOU87+SfUf5q40z91lf+/mftqiKqUz4eaIQoR8/C2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011912; c=relaxed/simple;
	bh=Pzkef+0eT8GE/mhwdecw3ku8eLSzr5GfZsggHd/uWcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mt69WvgWmh9zR83cHb0EzLuVCN0DO9iBDBXx2ks65vRV7829/rT1/gkZqiDYQyJ1CSi2cK9XdlLZUdVDCM+1/U6GrsWf9au/ucQZoofM/Oq1fMFCIfhvmBaYzqSJ6kqdCbJlULcDcdV4HgupoOwGsv26J3XbtCoj+KfkrX8tPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRcikCRJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-205425b7e27so70566275ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011910; x=1726616710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2byeEE5glf1HSY5uEmaELERh+IVrgf4yY9vZeuIn10=;
        b=zRcikCRJtogCxcQWZPyaJK3KB8Tm0HA+f2CjsWHMP7hR75ftC+UlSdrlu0HUMi5Cx0
         hzaiOFpn0A0r1m0uD3W5Nr37390s1i1TL9XoK5bcU4/OLzEVqJRMLG5SptPrA29jcieR
         0sVjK45aGZj1uIOxWk0/6REW0c/vXiJCBygFK2pz8Pso0SM9421WMgKfMOIod2htn43I
         3gRukiTI9Gtw8i62nW5MAtvASRpF1DqirdeNnXEhnBWmvSRf5O7rnzJNCyku3Sh4KMaQ
         bvxCex2Q/UJ1/q/Zsd/GGAm/BZnJcueLadv+eTZwMBnMWimrgVT37fP75h/KqV5Gj9ci
         qhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011910; x=1726616710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2byeEE5glf1HSY5uEmaELERh+IVrgf4yY9vZeuIn10=;
        b=Sgy2nuWtNJtpJd6JTz6ZZNBxqDok8AL4U6rQoRuuICCbtkxCNDGoPuJY0d2Z+8slqD
         2UVSu87uYazspTs1rsYlWVmeewjRQ6Kllo55/C8aFS9CKGBSPzOrpUfOLZd2aQDN6O0K
         PDVuo+y70VRRjRKKgLOyvhd/uCkp99IydT5NXt1ARfcGoB5KrH8a+wrAh3PuPYEIRnsB
         +gpznek4comFElIMofys5fFQOlHYkeZjsImPMEg9TTixyj5c/fBhsr87tKnit+E82ulI
         UO8ncXpKuq+D2UcdHknXZxFlwu/Io6iAq1t5a9HrcY/ji4wLiXzkb51NJQ9XYgLMVfpK
         3gOA==
X-Forwarded-Encrypted: i=1; AJvYcCVhsAuHJ+lys13F0cztOGaFqjUAfMeuaCwYNeL6GVJsKUy4nGZyn2BJQEI9Sk/XbeFgGgWKGM2kZFxFbm3IwY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzthCEiSU8YrpJUztny3vsTq7lrCBj2uV8lP1NMbBfRUXOLj9QH
	YGvjwjhkrdIatI4CBLE1iw1Cx+Ecjyzw5fS492oGtO6BGPjYLhT3JTsQTqBIxn6LQ92cGWig0M1
	d25wtN7dd6tFlVHbb3XWTGA==
X-Google-Smtp-Source: AGHT+IHRNRhjiY3twcj3iiSAd6sK0DpsvR2293BDcZR4oPPmoZmD0jtdld7lS7ASmX+XqQWY6/tAjSk1hpoqvcGWvg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:eccb:b0:206:aa47:adb6 with
 SMTP id d9443c01a7336-2074c703af1mr2052395ad.6.1726011909816; Tue, 10 Sep
 2024 16:45:09 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:53 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <f1e643cd0201f5e2f98e59302e4a42cace3c058a.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 22/39] mm: hugetlb: Expose vmemmap optimization functions
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

These functions will need to be used by guest_memfd when
splitting/reconstructing HugeTLB pages.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 include/linux/hugetlb.h | 14 ++++++++++++++
 mm/hugetlb_vmemmap.h    | 11 -----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 752062044b0b..7ba4ed9e0001 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -284,6 +284,20 @@ bool is_hugetlb_entry_migration(pte_t pte);
 bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
+void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
+#else
+static inline int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
+{
+	return 0;
+}
+
+static inline void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
+{
+}
+#endif
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 2fcae92d3359..e702ace3b42f 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -18,11 +18,9 @@
 #define HUGETLB_VMEMMAP_RESERVE_PAGES	(HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page))
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
 long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
 					struct list_head *non_hvo_folios);
-void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
@@ -43,11 +41,6 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
 	return size > 0 ? size : 0;
 }
 #else
-static inline int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
-{
-	return 0;
-}
-
 static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
 					struct list_head *non_hvo_folios)
@@ -56,10 +49,6 @@ static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	return 0;
 }
 
-static inline void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
-{
-}
-
 static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 }
-- 
2.46.0.598.g6f2099f65c-goog


