Return-Path: <linux-kselftest+bounces-17674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F389746A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC6A1C25A2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C61BBBFC;
	Tue, 10 Sep 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD2ixa7T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E71BB6B6
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011893; cv=none; b=P4oJD5pTvBtDy1rBO0niwBxcINPsqPYMwIol1nJJ88cxmvoHPbYmal4owuR7ZuC1d9Cpl8uwaH06paejqEV+asGfzhq9R/CRFg9tzx+b436AnpHE95ENmCHgK8mra7OxuVo9CmOK8BbTycjPeKdZIK1KmNAqb3bWzI9pPAxS7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011893; c=relaxed/simple;
	bh=5iqTuQB0fj5V1jzzqaRJUquxydmdc8dIqTru11KkJIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HgXF84a7S+Ic2JGNYdviKX+3PG5wTCvZGOtWuwHS9g6ZENTmgFaAbIkQPYzumCOaM/SQ6c6gNYwANDtCJQ2hqXw4YPjeW6JHSSnP7/HXFlxiqyeD9uEOor963iURJAdi4NjnGBhaF20qpJx3Kqv6h8ZZZp5tprl/HZc/m3zNUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD2ixa7T; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d87b7618d3so1521372a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011891; x=1726616691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ar3js6y/uqSuZ8kEtPgJYc0vWuZF8j/b1JF25slk+c=;
        b=uD2ixa7TW6gUg899GkwZWVy9IuCOXKkt/uwlwU4r+x+CFqunpPNP3Rv+gbmz6FjgnJ
         HuD1NBITWm+znQzWHZoUylP0rPnuZIv+EpQ2y27vm5uyAjTAMpaU25UmiQ4KinVSoumm
         2APpgp3FXfYsmarEeoJX3oGvSPkwA3GlyXU6ee26c69K8qkAT1AeYhC19taRabegzXb1
         8h0QwaUM2QzXarzH0Vop18bbn4Zl3aHWNY9pUo4bRVTH+eN88CYcKfJAH48ytBV7z8bK
         e6ySzn8u2OW3MdEunjh0XSbKnyWrKyDuCkUaRgiBcXWRY/HXbSYfzvUpFqHHBsMj1/bm
         gZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011891; x=1726616691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ar3js6y/uqSuZ8kEtPgJYc0vWuZF8j/b1JF25slk+c=;
        b=nZlizPNCYv010Uxk6Xbep6YxOyPHWScGBV898d/arKT4Z5i+g7/ndTDWYNueuwmP4T
         DF+rYmE1x0pJX/1qx5WZyLbaAhKTJUOlTJrOn8eQnjxBQFrpVyF/n2xEUk7mXBcGIKAn
         8v+Aq1wQjlLfxJ0j1lfsGGu3XaY59D2ivWNE0+Z/RcAc/bGyAyBap/O5G0x4saq7LWVi
         Orvu3G13LKKRNuy8X0nZoSqlS0CnnIUEE2BK3UzJk4S3yoSfITtgi5Tw9q+cyI1x7mEO
         sw51MTTdmYzNa5RRfEZuzcV9SIXdUPcaEGGKjCl2+ng9asJaTpZUnzHuZx/th5kPOSHB
         P64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQj2P+L6wD/O6OUc3m1flg7lZQCc68L9jB62KkzHE3M6gBtIXcaLis9VoQWOVB3iWahlIDge+d56m9vC7iYrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqL9ETQdbWAnXPq2B6+O1gGdQn98XqKXr3kIQcaRVnV+gtYwKO
	+5znBDIghx7vKeu4Dl4a/jWLA9ObZ6k80obGw0QqRdR/1HfunFKBRKZCetcw9cF8INzdb12whMC
	QzszIJm/QIEBDQmjpzJqSng==
X-Google-Smtp-Source: AGHT+IFJTKDezjG0ZGixJJEKykOQcK4Q2RdFfnGKlypTv43g1OIUEWvOedTsxO4Flime3+ygfPrCyueBrEPlyPHzTg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90b:1e50:b0:2d2:453:1501 with SMTP
 id 98e67ed59e1d1-2db82e64986mr2443a91.2.1726011890733; Tue, 10 Sep 2024
 16:44:50 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:42 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <3b49aeaa7ec0a91f601cde00b9e183bc75dc37a6.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 11/39] mm: hugetlb: Expose hugetlb_acct_memory()
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

This will used by guest_memfd in a later patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h | 2 ++
 mm/hugetlb.c            | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9ef1adbd3207..4d47bf94c211 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -122,6 +122,8 @@ void hugepage_put_subpool(struct hugepage_subpool *spool);
 long hugepage_subpool_get_pages(struct hugepage_subpool *spool, long delta);
 long hugepage_subpool_put_pages(struct hugepage_subpool *spool, long delta);
 
+int hugetlb_acct_memory(struct hstate *h, long delta);
+
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int move_hugetlb_page_tables(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index efdb5772b367..5a37b03e1361 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -93,7 +93,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
 static int __hugetlb_acct_memory(struct hstate *h, long delta, bool use_surplus);
-static int hugetlb_acct_memory(struct hstate *h, long delta);
+int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
@@ -5170,7 +5170,7 @@ static int __hugetlb_acct_memory(struct hstate *h, long delta, bool use_surplus)
 	return ret;
 }
 
-static int hugetlb_acct_memory(struct hstate *h, long delta)
+int hugetlb_acct_memory(struct hstate *h, long delta)
 {
 	return __hugetlb_acct_memory(h, delta, true);
 }
-- 
2.46.0.598.g6f2099f65c-goog


