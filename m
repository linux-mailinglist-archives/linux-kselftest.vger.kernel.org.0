Return-Path: <linux-kselftest+bounces-17668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B4974694
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB84C287B08
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1B51B5ECC;
	Tue, 10 Sep 2024 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MOvzuO4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D51B2ED9
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011885; cv=none; b=QGWEX/NSseZHHLRxtyyoQXa15V0GlIt6ZiJG7RKFtR1V/TYPTOKpDGJTKmi4e6vftIMbPLO7mU4JUBncduwMnyAxsMCKmmnJev9FXGGKtpY9N5vyi4ZM1GPFLjah61UsGswMejLIWvf+LHbcZe4Q3Hq/Ut7l/11+DwDaMrw7tfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011885; c=relaxed/simple;
	bh=OQBUOF2Uq6jS4pRXGCaJ5/4GiCZ/0iOxc0vUCCmO+bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0ruVK9QTWWIoO4p2BBDZF0sxDryGw4cvSIiEL9CtRHJ1/4ALQMgrkqpc1rIKcQBPKANELtEEzlXwfLdSXV16CcWWIgEX1XVxqM1OOriYRsNwFV2zktjEEt4CcMgsj8UuXPXYTsZg9VHUGfQTTWjb+nE2ZGZM/pxXSK6CqQVUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1MOvzuO4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-718d6ad6105so6971348b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011881; x=1726616681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0FEJ4ZKBglbUpSmnWaSSUOycb+KTZhx2f+dpCTvB7Q=;
        b=1MOvzuO4D+tO/RpFPmleZfo8l7WxdQPP79UsyAYOG9+WcsIbXzUeMAW/aA/2awVfRf
         9gaxSeDuykpNIYxUAdK4B0YDDWD+qQZ8I7nZnW8MA3IzGlStt4QpCQQyDrBs/VQ78XUg
         DyIrYJOI9OXI2kyCpRYeXlARiDg7xeeznTLrcDgv8cz4U6V6H/AxmhdSAvaaNuOTrvt8
         +cLAKSTWnBESsoOdA0BzqKEBihhj5HqSCuNbdVLpyIhJRXUjC4AkZkJ8DpyIMKx8YqTQ
         2ZlayVvVesxKAbmL9bjVFG/sfpSdsH/WjeCgTTPBAUrSDKeR3MPqJJFPX/rgDtcs0+AQ
         BM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011881; x=1726616681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0FEJ4ZKBglbUpSmnWaSSUOycb+KTZhx2f+dpCTvB7Q=;
        b=N3Luedspb5WjPl2kctizeVcrWoGk71bAuPJnwW4gh79iXFcmnOXnn/RpRwHvLi4a3h
         E49jIBsgJgdnyXz18KfJw9gF6bR5oLVcFnMnSaBogknDHIubjkMrdPLcX0oEyt3OvP5H
         F/fULPadBSuj5fN8Il1kIc+RLk6E+yIXz1uP3OLdfTb9g7F9MiaBkRAKWK1GFN7cv82N
         Zbrkucw8BAM+Zn4m5/KlIxv4zcWWUrbxml45l0WZOKlxVsMR4LrPQvl/AytmAACedums
         KI9Qaz3n9oAHMqyxnDV6yDl5q6e5Ct9nmC3nLzZ08Ils8vLwgOkmW2IWE8R+laxYfgBp
         CidQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv+dUSkwWKIoPiJVWr4pYZK4PIC3IYhaHQhmMuvsARPb38BfEJBaX34qEMUaYuEySVhOOZ6BLgUCibpd94nVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9y/FGfUojYOXXxEYUTvey0OJ87pZb3Sh2A4VRWBngCPal6dnd
	GpoMdqen4E26B9mGPI+h4YA8FfTnsWI+uw7EC29wKATrqxnlRvM9qZoQ7pRGtLodKcKg/qA+doP
	78pTPbkGuGGTebmXQUO0dUQ==
X-Google-Smtp-Source: AGHT+IHx4+TfNxnFVDcFxBFG2SogMutruOf/RcFp6adNqekz63WzrINlsJVnsUCpFS0h+PHdTGU8HSxvhRc6JvhHRw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a62:ab02:0:b0:710:9d5e:4b9a with SMTP
 id d2e1a72fcca58-718d5e04dadmr37747b3a.2.1726011881266; Tue, 10 Sep 2024
 16:44:41 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:36 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <1778a7324a1242fa907981576ebd69716a94d778.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 05/39] mm: hugetlb: Refactor alloc_buddy_hugetlb_folio_with_mpol()
 to interpret mempolicy instead of vma
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

Reducing dependence on vma avoids the hugetlb-specific assumption of
where the mempolicy is stored. This will open up other ways of using
hugetlb.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5cf7fb117e9d..2f2bd2444ae2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2536,32 +2536,31 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
 }
 
 /*
- * Use the VMA's mpolicy to allocate a huge page from the buddy.
+ * Allocate a huge page from the buddy allocator, given memory policy, node id
+ * and nodemask.
  */
-static
-struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
-		struct vm_area_struct *vma, unsigned long addr)
+static struct folio *alloc_buddy_hugetlb_folio_from_node(struct hstate *h,
+							 struct mempolicy *mpol,
+							 int nid,
+							 nodemask_t *nodemask)
 {
-	struct folio *folio = NULL;
-	struct mempolicy *mpol;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
-	int nid;
-	nodemask_t *nodemask;
+	struct folio *folio = NULL;
 
-	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
 	if (mpol_is_preferred_many(mpol)) {
 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
+	}
 
-		/* Fallback to all nodes if page==NULL */
+	if (!folio) {
+		/* Fallback to all nodes if earlier allocation failed */
 		nodemask = NULL;
-	}
 
-	if (!folio)
 		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
-	mpol_cond_put(mpol);
+	}
+
 	return folio;
 }
 
@@ -3187,8 +3186,18 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	spin_lock_irq(&hugetlb_lock);
 	folio = dequeue_hugetlb_folio_vma(h, vma, addr, use_hstate_resv);
 	if (!folio) {
+		struct mempolicy *mpol;
+		nodemask_t *nodemask;
+		pgoff_t ilx;
+		int nid;
+
 		spin_unlock_irq(&hugetlb_lock);
-		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
+
+		mpol = get_vma_policy(vma, addr, hstate_vma(vma)->order, &ilx);
+		nid = policy_node_nodemask(mpol, htlb_alloc_mask(h), ilx, &nodemask);
+		folio = alloc_buddy_hugetlb_folio_from_node(h, mpol, nid, nodemask);
+		mpol_cond_put(mpol);
+
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-- 
2.46.0.598.g6f2099f65c-goog


