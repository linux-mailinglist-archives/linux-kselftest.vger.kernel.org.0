Return-Path: <linux-kselftest+bounces-17673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FE9746A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009D41C259BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E431BBBC3;
	Tue, 10 Sep 2024 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o57i4hOk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3A1BB687
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011891; cv=none; b=au3FFhayZdpDxCqwYDqBVcrh7Cs1PxynAw3ZKueUv9BAmqqCmbbU1E8MPJkNAvHgBL4Q0ntYHoRxRXnUp0NQbqNJvTHF/ABIBer/061knayM/P9nGvM0AvDGGJYW207U5oBeJGJW/tJOBtIHiQvIgW6ukejC05mARPuHJRmzv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011891; c=relaxed/simple;
	bh=oRugCpYHEXBZY4B6pgzgYsgouWvAgYzAOcCTQimGKYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ee0hih9VGSv/wEWCWq2CpreJNnBNn4ttXumaQwam3dlSQ1DI3l3YmBNH3fqbGhEqzLW9TEkmO9adD39IC4CvytbScn1t2Ygi5ZnoKhkQ6pa1+nYLCFChvHfJkgE1BN53ydWE1/wYiSYBeovJXNq4upQii5RTXdD+LlN9cvg8/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o57i4hOk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1cf5a262a1so729822276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011889; x=1726616689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iv7923HL7PnugAdoQNMJmA75my6sY7uB1Q3OZBVqww=;
        b=o57i4hOkTaHnE5A42sqVlbSJJe8GVY25gblcufXANZymi8gcSMBo5rVCkY2dTdl3/t
         dDvh99zGNo+84/y4OQsXbyGaQx0wDk5VsgieqZyYYc9DuEROR80zXeVrjsUMxE+4acrQ
         l6lsxAxQIauYzVRJ0+lNKgM1RK80GaBWD154IkxDxU1K4HCWSpkH2fOSt4UP445WqsYr
         VwT1Jit5HQ6+ttk77IB1UzRKdHlYqll7vCChT31b+qRfXHODedRObGUVFSpYda9ZX3H2
         QjU7091hGJrxFJbKTrxC34RJvXOhqWxC5GHqVvajrkjIme2Ofy7KKTJAOTZ6J5UC4XH4
         nMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011889; x=1726616689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iv7923HL7PnugAdoQNMJmA75my6sY7uB1Q3OZBVqww=;
        b=ZXhCUCk9S9qrhYVolrwAE+mRFI3ICUnxoNnMkWxw38Gq9MDwJSMi5ETjbo791YcuYi
         nNZS1Gels+PMtC1CM2VinZ2UP/cUl2omZirCiu0+vv3SZeuj3v9glcVOareM4Q0AA757
         +hzzpaJUlDtaz255/ggBKXJDHCwCrsM7jwWpj2sAj681LCwwrwynfgdteMDr07pfyeON
         n4LPt4bf8kc6TluPPgSlJrtr8yBr+atO3PKCI0/Y/iiGdSZDMOzrn+bTcTdEvFe16VE+
         EZ/V6SRGHvmoxy/h9qmguDC9dk6OSAnuFlrLPi9q9ETbdzrzo410ODmZ0r6/iTTYEh5b
         Kr9A==
X-Forwarded-Encrypted: i=1; AJvYcCW+HO/U0J9kwcqcQ9TfsD4o1wKO+OuEf7Kz80K1scKoBV7tv2pHsGMOaGyAJIQRPqRM3OGsfc1DiX6lsxQkTgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAw5hgNXle/KEFI5ID30rlT5Qzi2NH377/R8NJGDdRfmtpkjLN
	UlTeGbW1c2GifISsHb7B7wFoTXJ/JY0MTyNQaPcudjUbdisAvGmS6abtMb2Sx9dmbNdBmoPgMMK
	zg1iGg246lo5jfK7zM84AmA==
X-Google-Smtp-Source: AGHT+IExTdEexhbqpimHxd6gs3l7Pq2iWLuHahj/FFfLrEvqqV1hWUN+M4z6YvLC879N40fo1vT1sN3faPRrRHEZgw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:aaaf:0:b0:e1a:7eff:f66b with SMTP
 id 3f1490d57ef6-e1d7a0f3520mr31045276.5.1726011889166; Tue, 10 Sep 2024
 16:44:49 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:41 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <083829f3f633d6d24d64d4639f92d163355b24fd.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 10/39] mm: hugetlb: Add option to create new subpool
 without using surplus
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

__hugetlb_acct_memory() today does more than just memory
accounting. when there's insufficient HugeTLB pages,
__hugetlb_acct_memory() will attempt to get surplus pages.

This change adds a flag to disable getting surplus pages if there are
insufficient HugeTLB pages.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 43 ++++++++++++++++++++++++++++++-----------
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f6cff356796..300a6ef300c1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1488,7 +1488,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ctx->max_hpages != -1 || ctx->min_hpages != -1) {
 		sbinfo->spool = hugepage_new_subpool(ctx->hstate,
 						     ctx->max_hpages,
-						     ctx->min_hpages);
+						     ctx->min_hpages, true);
 		if (!sbinfo->spool)
 			goto out_free;
 	}
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 907cfbbd9e24..9ef1adbd3207 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -116,7 +116,7 @@ extern int hugetlb_max_hstate __read_mostly;
 	for ((h) = hstates; (h) < &hstates[hugetlb_max_hstate]; (h)++)
 
 struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
-						long min_hpages);
+					      long min_hpages, bool use_surplus);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
 long hugepage_subpool_get_pages(struct hugepage_subpool *spool, long delta);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 808915108126..efdb5772b367 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -92,6 +92,7 @@ static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
+static int __hugetlb_acct_memory(struct hstate *h, long delta, bool use_surplus);
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
@@ -129,7 +130,7 @@ static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
 }
 
 struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
-						long min_hpages)
+					      long min_hpages, bool use_surplus)
 {
 	struct hugepage_subpool *spool;
 
@@ -143,7 +144,8 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 	spool->hstate = h;
 	spool->min_hpages = min_hpages;
 
-	if (min_hpages != -1 && hugetlb_acct_memory(h, min_hpages)) {
+	if (min_hpages != -1 &&
+	    __hugetlb_acct_memory(h, min_hpages, use_surplus)) {
 		kfree(spool);
 		return NULL;
 	}
@@ -2592,6 +2594,21 @@ static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
 	return NULL;
 }
 
+static int hugetlb_hstate_reserve_pages(struct hstate *h,
+					long num_pages_to_reserve)
+	__must_hold(&hugetlb_lock)
+{
+	long needed;
+
+	needed = (h->resv_huge_pages + num_pages_to_reserve) - h->free_huge_pages;
+	if (needed <= 0) {
+		h->resv_huge_pages += num_pages_to_reserve;
+		return 0;
+	}
+
+	return needed;
+}
+
 /*
  * Increase the hugetlb pool such that it can accommodate a reservation
  * of size 'delta'.
@@ -2608,13 +2625,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	int node;
 	nodemask_t *mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
 
-	lockdep_assert_held(&hugetlb_lock);
-	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
-	if (needed <= 0) {
-		h->resv_huge_pages += delta;
-		return 0;
-	}
-
+	needed = delta;
 	allocated = 0;
 
 	ret = -ENOMEM;
@@ -5104,7 +5115,7 @@ unsigned long hugetlb_total_pages(void)
 	return nr_total_pages;
 }
 
-static int hugetlb_acct_memory(struct hstate *h, long delta)
+static int __hugetlb_acct_memory(struct hstate *h, long delta, bool use_surplus)
 {
 	int ret = -ENOMEM;
 
@@ -5136,7 +5147,12 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	 * above.
 	 */
 	if (delta > 0) {
-		if (gather_surplus_pages(h, delta) < 0)
+		long required_surplus = hugetlb_hstate_reserve_pages(h, delta);
+
+		if (!use_surplus && required_surplus > 0)
+			goto out;
+
+		if (gather_surplus_pages(h, required_surplus) < 0)
 			goto out;
 
 		if (delta > allowed_mems_nr(h)) {
@@ -5154,6 +5170,11 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	return ret;
 }
 
+static int hugetlb_acct_memory(struct hstate *h, long delta)
+{
+	return __hugetlb_acct_memory(h, delta, true);
+}
+
 static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 {
 	struct resv_map *resv = vma_resv_map(vma);
-- 
2.46.0.598.g6f2099f65c-goog


