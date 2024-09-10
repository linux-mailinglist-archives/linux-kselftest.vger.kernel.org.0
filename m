Return-Path: <linux-kselftest+bounces-17679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762EC9746B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313D9286931
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631571BDAAF;
	Tue, 10 Sep 2024 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wl6OsPG2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A91BD4FC
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011903; cv=none; b=gJSQl4M7b0jpkQxeRkFk2v6zJbAzJpHpJPY8eNFl0NGDkPt4rZ1cUD/i+jBpvG9Oe7uoBz+Jva+LA1cbkFNC/XqH16uiH2+9IsgoY5Zc2XnGOo5tauCGgcOZrjkeySlw9U0JWsXQaZhK40FowVv58p2ReScZKmy1BBn7jMMuUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011903; c=relaxed/simple;
	bh=LrEdspsLCh8pfXrwGeKzyBwtTCfJskcHEhFW59Ake2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fi3FGLYhQLti8BT8g804q82ApbtlVi5H4Lr+WArlLiLWsObYXE1JPeV9vbnVDQfJc3YHlVhknapCvA61ejCK4ofimDWJIf9lXZa7wWFAN8j8UzWsAVQb2EF6228RNqcQ/lm3WJUHIZDfN3R0M6wT91c15OdBap8O5LsvAxycAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wl6OsPG2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7cd849a6077so1211356a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011900; x=1726616700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5QWCSGDqbjsS0n7qJVo2UbLIELWUXKqatSc9NHlgvU=;
        b=wl6OsPG2sF4zyriW6DFl0qO1oNl+O3xGGPUsVTH1OBPzBAb2fmrzYwY8Fkkd1zQKGS
         3c3QfFMmAglWrDVoiYRk/2MtXtwftj9sG4CzBFJiMev0Ck98FZ39/BzWRmY64d7RWIBE
         9DHOINxXuWmkpGDB1gj6nb4MyWVOxSVVrnB86PCegV91H8EqmU6Fqa49Ll1XD76a/IOw
         4xzKVTHivmLjhLvMKwVQpA6dVoNsIbRTDHQ7yJg+PEWnMtbmol2EVF+IgX1vuo4SJanv
         J2G9rUzgwGVCT7Okj4R/JsGcXrqLFASegt6YkUphTGyyHUN/fBoypB1tmmMN9m1CwMzE
         ojvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011900; x=1726616700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5QWCSGDqbjsS0n7qJVo2UbLIELWUXKqatSc9NHlgvU=;
        b=O+JGveEY94iCVV68lv3MQajGGEJ14/BEJYak0KFna7A1vYqfw20F8g9uIg+hEycqTr
         1UUPQvNyVoceWZ9H6TCorECzCE9Q6/ZJcXEL7QKuzfW1OpjkXnCftX4eRDNhIg3yCXfR
         DRaCZW6T7OS1msUXjRj8YiLhMriXk33TQ23yGpW/DK3n5b9XBwWFFdO2WjJvJEtHRnwu
         M+5FFVP4nx1JixMx0s4Dq7CW0aqdRH0eedsMybW/5Of3U91KZyL7pTRuN4+CWRrUAidd
         oAD4VSWEhL5+d3OVGzGptzklT5Z1mrRSyfeq//pPLdwE8unZZ3Q4Ml5Nj2iLGn+qOchx
         cutQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZzpJk1sFgn9/y6Ym6/3Y6oii/M6bLVC2aXI9oT4dd9s5FAehjrvGr9LStc1KIB4HqpZQuX1YFf1f+CLAxUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTAdkIETDsd25IjZQEK8myHfS8V9jWJN4nKMNnAnl2s1TauU3
	fruhDJRUa9ULGpe/f7mK6+v+o9GSrGU5CA3wR2PRldZP3h9fcVzQ36kRFgFEWH/ir6peUVxn66V
	LHUtaHaeGzs8N10mKquycaQ==
X-Google-Smtp-Source: AGHT+IHo9nrZMACTW1GYMiSHsHPpyJhtvpckq5UoyzEbjp2HiFKw7SxN6vYrJsaFr5HrF/PjOMK6efHCzGq+Tv7awg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:3dc6:0:b0:6e9:8a61:b8aa with SMTP
 id 41be03b00d2f7-7db0bb80899mr2016a12.0.1726011899568; Tue, 10 Sep 2024
 16:44:59 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:47 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <6f6b891d693ea0733f4b2737858af914bd70a8b6.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 16/39] KVM: guest_memfd: Add page alignment check for
 hugetlb guest_memfd
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

When a hugetlb guest_memfd is requested, the requested size should be
aligned to the size of the hugetlb page requested.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2e6f12e2bac8..eacbfdb950d1 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -909,6 +909,13 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	return err;
 }
 
+static inline bool kvm_gmem_hugetlb_page_aligned(u32 flags, u64 value)
+{
+	int page_size_log = (flags >> KVM_GUEST_MEMFD_HUGE_SHIFT) & KVM_GUEST_MEMFD_HUGE_MASK;
+	u64 page_size = 1ULL << page_size_log;
+	return IS_ALIGNED(value, page_size);
+}
+
 #define KVM_GUEST_MEMFD_ALL_FLAGS KVM_GUEST_MEMFD_HUGETLB
 
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
@@ -921,12 +928,18 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 		if (flags & ~(KVM_GUEST_MEMFD_ALL_FLAGS |
 			      (KVM_GUEST_MEMFD_HUGE_MASK << KVM_GUEST_MEMFD_HUGE_SHIFT)))
 			return -EINVAL;
+
+		if (!kvm_gmem_hugetlb_page_aligned(flags, size))
+			return -EINVAL;
 	} else {
 		if (flags & ~KVM_GUEST_MEMFD_ALL_FLAGS)
 			return -EINVAL;
+
+		if (!PAGE_ALIGNED(size))
+			return -EINVAL;
 	}
 
-	if (size <= 0 || !PAGE_ALIGNED(size))
+	if (size <= 0)
 		return -EINVAL;
 
 	return __kvm_gmem_create(kvm, size, flags);
-- 
2.46.0.598.g6f2099f65c-goog


