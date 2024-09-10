Return-Path: <linux-kselftest+bounces-17669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4467A974697
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97E71F26F37
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AED51B78FF;
	Tue, 10 Sep 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lq4dO4Np"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B11B3F36
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011886; cv=none; b=Ci6ZaR2Le81dNwQls4yC2YqkMHgfr+1ZN/Y3/Xpj46gBZ2MKUBTlclKA+Dw1yy2r98qjP2Yx54FwLaeXxYt4lGkXzUYoAYNXdE57HV52XNmYDraeGisxYQiK2VrQOV96y2aMBoXdLkT18e/X1hYb3ZMaTySjASXzm73gV6sUT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011886; c=relaxed/simple;
	bh=vz+K542nyzdqJxLlExSXInUw0qLgTrnVa+HN27oSntk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MNceY+s1i4QfrPRao5LMtshHA9uKNwMkLXCCPAP/EiK9a8j/SU6JsCXd3pOfZhSvxSdGJCtmv2XrEtC/TwKyJB3/dS0B2vpaK6nBIIMBlaVLc4nJTfGBQLJUXcXpQ31PANVGt+R8SZCANxLW3kCOWTTRgHa8bVar1iOgZMu4uYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lq4dO4Np; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db7a8c6831so86816677b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011883; x=1726616683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2/Y6gthU1MbFrUehJ3S769Qii4LzOP83N9oJxSMzr4=;
        b=Lq4dO4Npjc/5Hrpv9HzszDeLE+r3nofpe8xRJi8bVhX6jv3TsMxLzG9+0F8CRGXFaU
         OCHuZRHOv8z3Mb4COu+ZLy6eC7GmwFl+aq/fHSOwZuRwcE/jJy4LXI8LqBRezt3+P3Du
         lmil/vVJXv22rT0s7CmJFGSQi6V+xHcWJ4gI0hsKPO9ekm2Om9r94TIvwFqE6ZoeLo8y
         1xVYXvcNwS/cieDTA3vqTGKogqFC90yEJoH9ZeFH3vMp5wp0UU2CZaLLEaeKKhMVrxXD
         TcNVn6BAzAKOlaftPO3OF98N2zHHLQFkayMAVIJceKBXPxsJWr+ABmOpZ87frV4+yQG7
         akwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011883; x=1726616683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2/Y6gthU1MbFrUehJ3S769Qii4LzOP83N9oJxSMzr4=;
        b=MTKsXYFhoexo4J1zdEBc0CwzEuqxxpu/s5LsdK3+a2wN+THVn9z/Wu/hNAEWWMTKNb
         e6bRg/kiRjBZmz04UXOt0psKFwK7D2BQkQawEHxjuOkNflmLe5oxhGG3vdPdMsA9d4zs
         6GuwTV0ZxQcUGtuP1lisvLN/3s91e++X7F3U65zX1/0bRgkpL2XpzAGoafBxmAklaLii
         x8LCYT/bIRgkSxaaiFeUj4HSPiHuOPC4rIw0Mjle7+sUlYL6O1IdWbUaSkC3a0ht3E6p
         DMZN2u5DUl//TZzrV8JgsLOm8uOBN+rGKsi+NnbV9lQpB//frBHad48nbrRAhEEtWLHC
         j5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAmOklxyuqert6Tq8pnevuuCf5+zO22pdnLoloUrWN8hDbmS0snSXhb2blUMPiqhBy7snQEdBWAv3UX8vqbFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKiGhwr8t1Amfsh5gFGAGPqNz+TqXZaLl08fibt/EgTWJDL7F
	une5sLEL8obHxb2DktVpXSJqAlYUNddRZWQv+JgdL4ON3g5aPyWa7W1jT6dBE9yqzsppEN8f4IL
	qpnNjgKRatp+AghON/YMU4w==
X-Google-Smtp-Source: AGHT+IFPoUvOh1q0B66QYZI1YuXyVP47nvXVDhT/pcsOhAfzJk8Td8wo+BQHvkUkT8CnKxYbBRP+4EVLJOXxK7IwcA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:360c:b0:6db:7b3d:b414 with
 SMTP id 00721157ae682-6db7b3db573mr3408167b3.0.1726011882893; Tue, 10 Sep
 2024 16:44:42 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:37 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <2e9109761869029bf82555e60d98850ac7888ae5.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 06/39] mm: hugetlb: Refactor dequeue_hugetlb_folio_vma()
 to use mpol
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

Reduce dependence on vma since the use of huge_node() assumes
that the mempolicy is stored in a specific place in the inode,
accessed via the vma.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 55 ++++++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2f2bd2444ae2..e341bc0eb49a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1402,44 +1402,33 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
-static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
-				struct vm_area_struct *vma,
-				unsigned long address, bool use_hstate_resv)
+static struct folio *dequeue_hugetlb_folio(struct hstate *h,
+					   struct mempolicy *mpol, int nid,
+					   nodemask_t *nodemask,
+					   bool use_hstate_resv)
 {
 	struct folio *folio = NULL;
-	struct mempolicy *mpol;
 	gfp_t gfp_mask;
-	nodemask_t *nodemask;
-	int nid;
 
 	if (!use_hstate_resv && !available_huge_pages(h))
-		goto err;
+		return NULL;
 
 	gfp_mask = htlb_alloc_mask(h);
-	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
-	if (mpol_is_preferred_many(mpol)) {
-		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
-							nid, nodemask);
+	if (mpol_is_preferred_many(mpol))
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask, nid, nodemask);
 
-		/* Fallback to all nodes if page==NULL */
-		nodemask = NULL;
+	if (!folio) {
+		/* Fallback to all nodes if earlier allocation failed */
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask, nid, NULL);
 	}
 
-	if (!folio)
-		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
-							nid, nodemask);
-
 	if (folio && use_hstate_resv) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
 
-	mpol_cond_put(mpol);
 	return folio;
-
-err:
-	return NULL;
 }
 
 /*
@@ -3131,6 +3120,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	bool deferred_reserve;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
 	bool use_hstate_resv;
+	struct mempolicy *mpol;
+	nodemask_t *nodemask;
+	pgoff_t ilx;
+	int nid;
 
 	memcg = get_mem_cgroup_from_current();
 	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
@@ -3184,22 +3177,19 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	use_hstate_resv = should_use_hstate_resv(vma, gbl_chg, avoid_reserve);
 
 	spin_lock_irq(&hugetlb_lock);
-	folio = dequeue_hugetlb_folio_vma(h, vma, addr, use_hstate_resv);
-	if (!folio) {
-		struct mempolicy *mpol;
-		nodemask_t *nodemask;
-		pgoff_t ilx;
-		int nid;
 
+	mpol = get_vma_policy(vma, addr, hstate_vma(vma)->order, &ilx);
+	nid = policy_node_nodemask(mpol, htlb_alloc_mask(h), ilx, &nodemask);
+	folio = dequeue_hugetlb_folio(h, mpol, nid, nodemask, use_hstate_resv);
+	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
 
-		mpol = get_vma_policy(vma, addr, hstate_vma(vma)->order, &ilx);
-		nid = policy_node_nodemask(mpol, htlb_alloc_mask(h), ilx, &nodemask);
 		folio = alloc_buddy_hugetlb_folio_from_node(h, mpol, nid, nodemask);
-		mpol_cond_put(mpol);
-
-		if (!folio)
+		if (!folio) {
+			mpol_cond_put(mpol);
 			goto out_uncharge_cgroup;
+		}
+
 		spin_lock_irq(&hugetlb_lock);
 		if (use_hstate_resv) {
 			folio_set_hugetlb_restore_reserve(folio);
@@ -3209,6 +3199,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		folio_ref_unfreeze(folio, 1);
 		/* Fall through */
 	}
+	mpol_cond_put(mpol);
 
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
 	/* If allocation is not consuming a reservation, also store the
-- 
2.46.0.598.g6f2099f65c-goog


