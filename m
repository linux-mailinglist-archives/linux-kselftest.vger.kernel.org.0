Return-Path: <linux-kselftest+bounces-17691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F249746DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3081F268B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F12E1C1AB0;
	Tue, 10 Sep 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJKoPEL5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857B1AED40
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011924; cv=none; b=OEhzh05uHTtZkh+3I8H+9BqoBWa+pVEGWXUWnylf7awHpsimORfcYMZ8LFVjHkX6dy8S0KSJqlY71Xu0mpfRdS4fFhAfLh4a/ZxjG2StWp66ygBXK6rpE3mYlOblJaTYeFZk0ajetVpUpZguj+Aibbvlnq1Djw0FB1xSMo3onbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011924; c=relaxed/simple;
	bh=ypXICWB7lHgzaCptTfWhJZz4InV12rYGuerAaDggmsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2KW1FWWyrIq7stH8JTcgEN7ztsEOFZ9wdEVgzRnYjtA8C3xM+EZmwKCAkiFkQWzPtJrgv1nXhuWbGl6eMLQZsJM2IDJc93k1lrql+wEbf31/MvPFwhv95FX0kS6gJXOnujLSPjfYKwzr8gYAVhZX6wmWX8l4ncIYYSRPyY5K/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJKoPEL5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d8b7c662ccso1538830a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011922; x=1726616722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSL2kMUQX0MYfWs91FUoGWuk2V9BSwbXfpTOfw5RJmI=;
        b=jJKoPEL5Pmb45B+8+RMGJFvQC93LQAVhjpNR/kyelVwfPPqFRre9/i0SdBLdj0UTAB
         nr2v33YeiY1URdOoTpIEYnz+/azVVtYvHt2agFroaKkE9v3BxrSVE3BmTpIKXSwnUNJ5
         dZai4o3wpezTskOwtSAwWgXXdXLeIiAn19bik6cyexknaV8OloCJgC95n1f6XR9chRJg
         JBQp0b+ea50PrOOA18fyqUx0fvWlnFOA1e5C+KHDXBhoiJFhk5aMGcjgc17HYN2LG7bf
         L4bg825BkuQjFPuFpUAw9CUYohp2qNqhTaArPek9nYagDCdt+NDpmSWo66GI2Q9wJyqV
         lwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011922; x=1726616722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSL2kMUQX0MYfWs91FUoGWuk2V9BSwbXfpTOfw5RJmI=;
        b=JhF6YBIZUPjeCVM28FdBtvW+7PYRQNihsGqq7uXB2eRlKXAod7ZZk3T/LtRIYMtsQf
         uzVtSgg11zDXmtZU2zTs7SE8sq0RstRYFQxh/QXuIlQsOVzwRnJZP1lU+9jPfo7o0gwk
         F6MhzSMG5MPI2D/Mu8Sn1vEL4CWNGdjBw7YEQM75byNoX0qOVLGu+ShXyOypzB4JohhY
         8U8h3J4J8RYUBhFNY3zsjdwIgoqhZLO5YJhIdlDb17Q+3qm4o7TTSH62tXUaMYeWskMJ
         lROFNyRWxDwCKYCzUhesM9t5bezLdyaqKqDT2l9snvmqpD7p68tUGHkH144dwNm96yhy
         Vdkg==
X-Forwarded-Encrypted: i=1; AJvYcCVBe7Q6Y+1ChHmo15Yfj0nWi3OLTr+OlAH9iL3H4WTHiPxFTN/Al1/47EEANE03IfP2C3oqXK5ZI4u6k5qhahc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACuSKK/Hyj+dCcbhVMweX5Og2eQAU57U6k+V0q8YG2uQ+vQIp
	aWmEaQYWC/O8LgdBjQ57KWFMKwNWf0K/X60/rwJwTUjfwlPHUrLd7A1+RcQ4nU3/hzMecRflJe7
	68rQ7HK9C0jR5pSU9gJL9Bg==
X-Google-Smtp-Source: AGHT+IHeEJa/t3gbMh3LQ6wjI0/JOXt73EyPzcfCUwf0I0tvYHeE0b/ouOGMNpZEECjGvQ2LqF2A810orFlmLkMS4Q==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:c2c5:b0:2d8:bf47:947c with
 SMTP id 98e67ed59e1d1-2db8304d552mr2449a91.3.1726011921647; Tue, 10 Sep 2024
 16:45:21 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:59 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <bf66353ee3338f11283a3f4b7ed1f06bd0b268a6.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 28/39] KVM: guest_memfd: Use vm_type to determine default faultability
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

Memory of a KVM_X86_SW_PROTECTED_VM defaults to faultable to align
with the default in kvm->mem_attr_array.

For this RFC, determine default faultability when associating a range
with a memslot.

Another option is to determine default faultability at guest_memfd
creation time. guest_memfd is created for a specific VM, hence we can
set default faultability based on the VM type.

In future, if different struct kvms are bound to the same guest_memfd
inode, all the struct kvms must be of the same vm_type.

TODO: Perhaps faultability should be based on kvm->mem_attr_array?

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 virt/kvm/guest_memfd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fc2483e35876..1d4dfe0660ad 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1256,6 +1256,23 @@ static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
 	return file;
 }
 
+static void kvm_gmem_set_default_faultability_by_vm_type(struct inode *inode,
+							 u8 vm_type,
+							 loff_t start, loff_t end)
+{
+	bool faultable;
+
+	switch (vm_type) {
+	case KVM_X86_SW_PROTECTED_VM:
+		faultable = true;
+		break;
+	default:
+		faultable = false;
+	}
+
+	WARN_ON(kvm_gmem_set_faultable(inode, start, end, faultable));
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	struct kvm_gmem *gmem;
@@ -1378,6 +1395,11 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	slot->gmem.pgoff = start;
 
 	xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL);
+
+	kvm_gmem_set_default_faultability_by_vm_type(file_inode(file),
+						     kvm->arch.vm_type,
+						     start, end);
+
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
-- 
2.46.0.598.g6f2099f65c-goog


