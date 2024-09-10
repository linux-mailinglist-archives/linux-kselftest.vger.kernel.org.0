Return-Path: <linux-kselftest+bounces-17672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 199839746A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A5D1F26C7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3761BB691;
	Tue, 10 Sep 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dw+mGHtC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE061BA882
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011890; cv=none; b=Q2cVjY8WPHyC8/DGHmnhffRukfaKWmB6iPV7zmQ8MwC3Y35yMkzVkFuoaor4thZTX3Mg3g0uTn/XsPv/FRAJjuDxZrcMRbvAjzjTav0LB44yT2nzF0hjaIKT8DmScnOV0c0TE4Gd3XV+2ePrMswZQc0fhO0DMHKb4BNy3Gch9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011890; c=relaxed/simple;
	bh=vKn6pjIRFyRt8Opg+2dj1UETcidGMMZpXY2Tm+1+Wnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ux7qo+YNPn/NxzPY1cbPaihI34Tv1H+9ghlCTqyDathissR4Qv3rtAk2IRpsyUOk9MYBLd03uA8HxWx+BBWVartkqlpDsg+juwxJiyRpbt0c/HzAay9jzfZnqKDnluUwUKf12h8CVZasPC3sw9N732op9R4HkmpshcqU63+iNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dw+mGHtC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1cfb9d655eso12469178276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011888; x=1726616688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wON4ebge/JtWXTatH36Oz8RnYdWXk0aZ0I0s+pE884Y=;
        b=dw+mGHtCedFwjPpV2akhGZwfEIzo4Q+I/jMx0YlaJ94gpmUFT4uSefXAEesPERKn2w
         yB1GdmTrvwkbEiReBiwyVjmWhWGmWJbn0RggjTfVJEczO95G/vBJF/EmZEp0OoKvwQeW
         J0NKem+YA19uMgUWNiz4AiekLupwvfGMVCNCj8ZMgP2+sfXteu5JofGJCGl3+eNA5cwz
         G6CByNX3QNzKBwsB0rcf11MW5eg4YGRBgcw2NRWFRn9VIqUDTo4aTraEGr8ySvrXUfsh
         amdnmlrpkoBhbwWVtZ7KU4ytNIAHJav0NY6+vzyGad+gO+/LiuD1znHVvZCTIfIwuX15
         esfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011888; x=1726616688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wON4ebge/JtWXTatH36Oz8RnYdWXk0aZ0I0s+pE884Y=;
        b=oWAVsUOPEyRV2celmqSWF8kpejwZ5QRf6QBGoZMhpRzjx5+czWmn1yU4PF43WCWukp
         SbYLqinWMXxiWsX7l8phPAZMN2tFBn22FhOCHW0qXB/b4TfBgHd5ms2oTvHoCBX7ZeP7
         MfI3egCFEk6b6stl++vpIrPVnlPTdkx6RggSWl0N093Nqe620052Sabkt7heeHt/sZGg
         ySFIe9RsyiOp/WgpNCxI/RKz6x9hu3+vYJ5fOWjPDAuAswxDPxRYgILc6pTyGRSh+70p
         eKrdQ4nk7vEeISTa1pc4gAUDcS1HjDQ3o8IYKeyGjzZiHrXqMGALt4Y6ptXFNuwjda0a
         XGVA==
X-Forwarded-Encrypted: i=1; AJvYcCWEcrrApJXeig2q0bl64eFYEbQfZ6vg2r9f3PkRw3uiPTt8S1z2WyArGPgA8N/0EcxsjshOMuEaLVOBy9dgGD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CT8EIc9TJrtRZzynmPtZX1K8JzVgYC8LpjktpmRQr0/C/VDt
	IUiSQZ8lck0rYj6yIKikHjKO6+ul2RNUjLELHMjeTLJGVY6U7hNR+dcqA82Ghqq6ragiqqE6ZKt
	BsBUcyRkFkGeCsRYRLb1DOQ==
X-Google-Smtp-Source: AGHT+IGifFJzomPV42kuvxwSOW6D8KRl1ZUZcLgu/9vMTp3RDdNsVY265K9HmTBfWg/leXDMNAyCn73aN71Ukp8ufA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:d347:0:b0:e16:51f9:59da with SMTP
 id 3f1490d57ef6-e1d349e2dd5mr43068276.6.1726011887733; Tue, 10 Sep 2024
 16:44:47 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:40 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <f8dd00f4bcc4328d440b77bc2ea2c1b75370dd58.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 09/39] mm: hugetlb: Expose hugetlb_subpool_{get,put}_pages()
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

This will allow hugetlb subpools to be used by guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h | 3 +++
 mm/hugetlb.c            | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e4a05a421623..907cfbbd9e24 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -119,6 +119,9 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 						long min_hpages);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
+long hugepage_subpool_get_pages(struct hugepage_subpool *spool, long delta);
+long hugepage_subpool_put_pages(struct hugepage_subpool *spool, long delta);
+
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int move_hugetlb_page_tables(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7e73ebcc0f26..808915108126 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -170,8 +170,7 @@ void hugepage_put_subpool(struct hugepage_subpool *spool)
  * only be different than the passed value (delta) in the case where
  * a subpool minimum size must be maintained.
  */
-static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
-				      long delta)
+long hugepage_subpool_get_pages(struct hugepage_subpool *spool, long delta)
 {
 	long ret = delta;
 
@@ -215,8 +214,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
  * The return value may only be different than the passed value (delta)
  * in the case where a subpool minimum size must be maintained.
  */
-static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
-				       long delta)
+long hugepage_subpool_put_pages(struct hugepage_subpool *spool, long delta)
 {
 	long ret = delta;
 	unsigned long flags;
-- 
2.46.0.598.g6f2099f65c-goog


