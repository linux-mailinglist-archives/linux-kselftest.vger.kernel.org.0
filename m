Return-Path: <linux-kselftest+bounces-17687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269159746CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D192B2845A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC01C0DD1;
	Tue, 10 Sep 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckY+7F+H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08B1AC427
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011917; cv=none; b=BEy3i5FuS/LLj0F2POAnX8f1/AX5zBJqq4lzx6PKksRVLOLHi3CBvnIfU1WHbz8hy3dyeTtQog470ijZCYtaY0Gyso7DhpPsb3EZ2GjRFO+cM4HOy4u2oObMW+xny8JhyM2s1EOGU/HJcT12NtCCZX5FuuVYhx6+ToDJv7r0cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011917; c=relaxed/simple;
	bh=YFlqwUDwGyInXdsNJdGve7rF6qfBl4eA7ZhQKm02v4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g2VwBZ6jSLTn3UPFUjaOccW7+V9JsEtQS9oPqBpbO2QxoobMwROo9ROMsuW+L8fAy/90+/OaDb8rcTw0mDDgEMgGRNUCfrGEqEJphc33PA7F1bcmaZpAe/LdtM1L2oDRpWTMM+AnOIN8Y/+c1EE4EJNBtOAGGtaizQCzklF9Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckY+7F+H; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d8dd20d0ddso308951a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011915; x=1726616715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBJef16ALyOYFlot9YzaY+1ElfdQQGF78ZnzsjyO0V0=;
        b=ckY+7F+HEpKKGVcmRr56+h88pZNcrxOzgCupbmKVr97yoBG/iY6WUwhMxxdLB1e3Ut
         EpEYwtRxkyqK5h1gqiYwVgDZ8Zm9dEdXHWM9XPQvRRqhafqh1A1HX+quZPM34EU9eAYa
         jJtJ+Bp/7x5TsvlJ9kRE1zqFGOxJPcOmXnFkGWaiX+JaZlOl4eLfgn3Dk8J5pjt8zKx4
         6X4o0If+05Jjf8L4/lo0pE1J4mmF54aLdS/ffx9kynx13WWeMNo3pSGlCbOdmdYuQhG2
         Mb5zhj9uFEB8kFgu7a2bn6LWh/X+5+jxsaMvkq4hGQptACPE0NYWCy7gxC10Cz9mGxbt
         C4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011915; x=1726616715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBJef16ALyOYFlot9YzaY+1ElfdQQGF78ZnzsjyO0V0=;
        b=wmIK3EHqNdMFn45zA/iNdhrhOxP9zLYBCXvDNXACGuXIA8OlwwYnDnSsMmchaaBwQb
         xgF/2IWVUgpCKBPhweyR0iJkL8olkSR1rDVD+ENIyg9FG09iAw438GElhBxdkZA+r5nU
         ap5brvLXpYKKQqpzGVtWIigP1Fafbl2cQwihueYIwjSqQnd42rsYrA77wBN0MHuorx/f
         puksRxyXZD3a5SoabOFCav/RsPHhomYmMPseFOKB8HXE0YAX7pOqz18yzKsG8+jX04yo
         w8v613yHP1QH7N8N9cB24oddbsMInCPlxpX8z2QiFcTFkblSx781unHoa1zXnflOABMb
         ZY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwts30SOd9iFIS/jZSNu0OXBlolxIH8Jg+/e81gDReWsrH1agzFB9PjUHe9ikOoes8+uIUMsw5upGQ4HeaKJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfgDIX1VVG5+4LumOm5gP4ifopm+wEjtdo/wrkyyOh31T5hf45
	jwBBS86wzGzw061vIHF2Twxq/YyM9cJh6wmm/hMsB2VPldcs8ZJx+OjYWY25c9CHqXSlp+fmwch
	zHFsGEiTWd+U9LY7a6BbR4A==
X-Google-Smtp-Source: AGHT+IE6UzsGakpseqVGpYmVeT4krDva7uEV1yzairw6T5Hn14xupYXurGRjEZiCuCr5K2NNFKPuVFRVzmSBBIl0nw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:d14d:b0:2da:6d50:e79c with
 SMTP id 98e67ed59e1d1-2db67176e9fmr38917a91.1.1726011914978; Tue, 10 Sep 2024
 16:45:14 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:55 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <55b2d15ddd03b4c7df195cace3dff83ffcbfa71c.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 24/39] mm: hugetlb: Add functions to add/move/remove from
 hugetlb lists
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

These functions are introduced in hugetlb.c so the private
hugetlb_lock can be accessed.

hugetlb_lock is reused for this PoC, but a separate lock should be
used in a future revision to avoid interference due to hash collisions
with HugeTLB's usage of this lock.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>

---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ac9d4ada52bd..0f3f920ad608 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -164,6 +164,9 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
+void hugetlb_folio_list_add(struct folio *folio, struct list_head *list);
+void hugetlb_folio_list_move(struct folio *folio, struct list_head *list);
+void hugetlb_folio_list_del(struct folio *folio);
 bool isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8f2b7b411b60..60e72214d5bf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7264,6 +7264,27 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	return 0;
 }
 
+void hugetlb_folio_list_add(struct folio *folio, struct list_head *list)
+{
+	spin_lock_irq(&hugetlb_lock);
+	list_add(&folio->lru, list);
+	spin_unlock_irq(&hugetlb_lock);
+}
+
+void hugetlb_folio_list_move(struct folio *folio, struct list_head *list)
+{
+	spin_lock_irq(&hugetlb_lock);
+	list_move_tail(&folio->lru, list);
+	spin_unlock_irq(&hugetlb_lock);
+}
+
+void hugetlb_folio_list_del(struct folio *folio)
+{
+	spin_lock_irq(&hugetlb_lock);
+	list_del(&folio->lru);
+	spin_unlock_irq(&hugetlb_lock);
+}
+
 #ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
 static unsigned long page_table_shareable(struct vm_area_struct *svma,
 				struct vm_area_struct *vma,
-- 
2.46.0.598.g6f2099f65c-goog


