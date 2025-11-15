Return-Path: <linux-kselftest+bounces-45677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74722C5FC1B
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 01:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 826A14E3ACC
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 00:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBB145FE0;
	Sat, 15 Nov 2025 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQPKiKh1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D427707
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763167619; cv=none; b=pmo6Iyot2qhjS6BJFWF8Kder7hhlvpPXIX+q/5UQq9XapRas4XDFF7DD3fKMCsnAFD5fiWfaq9YrVss8Y8/U7xMuzKrtyWpqOiJIsXrMlZTRv7ls9zdik76kuI3b6pU+A89EU0Xrm4/pnz5EeL5obdChcWT2xvSqL/24osoIxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763167619; c=relaxed/simple;
	bh=1/rD70ZHFrBNjJjci45pfQlAUENF4SO4u3lc/h6C+Zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7olQUEeowKLbqvuDr1jaOFhORAL5+s3WdgpaFPZVmIYxlO2dzti76yLwcFSWh7M+azdeRSWc3I26v6ZoQGi3/+DCkkwFyAg9SJGllOCbvMXbzeadOYRq3f5qi5TV//YxTNcVhguLebKd3C3lqkFLabMIfXPHUPFpAANST0X2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQPKiKh1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-341aec498fdso4016714a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 16:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763167617; x=1763772417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr/52DwIA8Vew8AuO0L8R6bm0vR8dQ+5A9WA+WG6t/s=;
        b=BQPKiKh1yfHcIrDSW59IH51D2rhvPkgu8emslDNrXmC7gsCFmyIVKyaXPuUky4qISc
         +19Up0qR7WWgxb5rLlc/vAvyxEK+7xSgmw20NRkuvhsi2uNabtm3xwQFagWK4bxGDqS/
         7gYj1dgRY4Qz6cyLqfB+LbbJ8hPrpBmmNQPY/qOHjAjqEqdl2m5Gvwe2rcSO1iFrvHaC
         9swHyDubrt6x4xbkszwVPYZjC8xoJlQCUauEvdXnHkEai5Ya/mUGIPDi/aaxO3ZaLOIy
         FiDZnjit3RNrnR++7shFiwMTsNlkRDSDa1Av00GMtGH845Ycpd83v1N/4tK/TCeKiRf/
         xCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763167617; x=1763772417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr/52DwIA8Vew8AuO0L8R6bm0vR8dQ+5A9WA+WG6t/s=;
        b=SJsLTxMS0WUUxRFNGGSkyfIfxnuNOKcomMLWrXMCdzr3I1VJ2PKos83s1lJWKwNhDS
         WAMkchf/XYNQxcdSRYxUqqOaE5bk0Dvov2vV8fZ+3bEh7EmJz+IE2y6Dl7Db8uHxjogE
         RlT0ej/F4PDiC1cEiJhHXbVRKFMcPvAgcbJFmnXYda7P+GQIkgHd56uB1LM/D/S8dafG
         iXWO09Yhm0mT44C0YmnT8s1VaknHXMOJIHQoT0Bz4Roo9Ecx+5sWJuL1UiOvOtwVzOSW
         rvxAWIKYAb2SpiJsxlcL01DQcq3maWtPItL+jduV2XcbC2uh3MGrTHFzzHLdBI9AOTb5
         15hg==
X-Forwarded-Encrypted: i=1; AJvYcCWWWfiD4lBaR1SNw+gL9hfzTbgwWAJgGaZ7F2zm6HwHfEF8FJVNMTh2B7HZ68VsEqRhmNmzsrXbgNX/CPftxWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZST8jGTEICNp9/q9uj6nzRaiH0ruOdPCjc1YHP/VKnjs/EVdv
	Wox3PZt4EEhJEft/z7Nv6frb0oNJzPPPFrJH9igG1IvNeoh3OhXMVVDtRDNpu4JMVsO4OjytPcz
	0WlQzrDwjvRN8uKq750yC4SwUgQ==
X-Google-Smtp-Source: AGHT+IHPDsoGUhVWbmh0UerKKIaGr6kr4KuHT3qBmIvhj2MnXtnNCORQphwRQGqEcjJQnhvfFDaRm0g88w6S7pk3mw==
X-Received: from pjbdb8.prod.google.com ([2002:a17:90a:d648:b0:343:5c2:dd74])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dc9:b0:340:29a1:1b0c with SMTP id 98e67ed59e1d1-343f9e93781mr5917746a91.7.1763167617416;
 Fri, 14 Nov 2025 16:46:57 -0800 (PST)
Date: Fri, 14 Nov 2025 16:46:56 -0800
In-Reply-To: <aQnGJ5agTohMijj8@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <5a4dfc265a46959953e6c24730d22584972b1179.1760731772.git.ackerleytng@google.com>
 <aQnGJ5agTohMijj8@yzhao56-desk.sh.intel.com>
Message-ID: <diqz346gcebj.fsf@google.com>
Subject: Re: [RFC PATCH v1 11/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Fri, Oct 17, 2025 at 01:11:52PM -0700, Ackerley Tng wrote:
>> For shared to private conversions, if refcounts on any of the folios
>> within the range are elevated, fail the conversion with -EAGAIN.
>> 
>> At the point of shared to private conversion, all folios in range are
>> also unmapped. The filemap_invalidate_lock() is held, so no faulting
>> can occur. Hence, from that point on, only transient refcounts can be
>> taken on the folios associated with that guest_memfd.
>> 
>> Hence, it is safe to do the conversion from shared to private.
>> 
>> After conversion is complete, refcounts may become elevated, but that
>> is fine since users of transient refcounts don't actually access
>> memory.
>> 
>> For private to shared conversions, there are no refcount checks. any
>> transient refcounts are expected to drop their refcounts soon. The
>> conversion process will spin waiting for these transient refcounts to
>> go away.
> Where's the code to spin?
>

Thanks, I will fix the commit message for the next revision.

>> +/*
>> + * Preallocate memory for attributes to be stored on a maple tree, pointed to
>> + * by mas.  Adjacent ranges with attributes identical to the new attributes
>> + * will be merged.  Also sets mas's bounds up for storing attributes.
>> + *
>> + * This maintains the invariant that ranges with the same attributes will
>> + * always be merged.
>> + */
>> +static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
>> +				    pgoff_t start, size_t nr_pages)
>> +{
>> +	pgoff_t end = start + nr_pages;
>> +	pgoff_t last = end - 1;
>> +	void *entry;
>> +
>> +	/* Try extending range. entry is NULL on overflow/wrap-around. */
>> +	mas_set_range(mas, end, end);
>> +	entry = mas_find(mas, end);
>> +	if (entry && xa_to_value(entry) == attributes)
>> +		last = mas->last;
>> +
>> +	mas_set_range(mas, start - 1, start - 1);
> Check start == 0 ?
>

Thanks!

>> +	entry = mas_find(mas, start - 1);
>> +	if (entry && xa_to_value(entry) == attributes)
>> +		start = mas->index;
>> +
>> +	mas_set_range(mas, start, last);
>> +	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
>> +}
> ...
>
>> +static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
>> +{
>> +	struct gmem_file *f = file->private_data;
>> +	struct inode *inode = file_inode(file);
>> +	struct kvm_memory_attributes2 attrs;
>> +	pgoff_t err_index;
>> +	size_t nr_pages;
>> +	pgoff_t index;
>> +	int r;
>> +
>> +	if (copy_from_user(&attrs, argp, sizeof(attrs)))
>> +		return -EFAULT;
>> +
>> +	if (attrs.flags)
>> +		return -EINVAL;
>> +	if (attrs.attributes & ~kvm_supported_mem_attributes(f->kvm))
>> +		return -EINVAL;
>> +	if (attrs.size == 0 || attrs.offset + attrs.size < attrs.offset)
>> +		return -EINVAL;
>> +	if (!PAGE_ALIGNED(attrs.offset) || !PAGE_ALIGNED(attrs.offset))
> Should be
> if (!PAGE_ALIGNED(attrs.offset) || !PAGE_ALIGNED(attrs.size))
> ?
>

Thanks!

>> +		return -EINVAL;
>> +
>> +	if (attrs.offset > inode->i_size ||
> Should be
> if (attrs.offset >= inode->i_size ||
> ?

Thanks!
>> +	    attrs.offset + attrs.size > inode->i_size)
>> +		return -EINVAL;
>> +
>> +	nr_pages = attrs.size >> PAGE_SHIFT;
>> +	index = attrs.offset >> PAGE_SHIFT;
>> +	r = __kvm_gmem_set_attributes(inode, index, nr_pages, attrs.attributes,
>> +				      &err_index);
>> +	if (r) {
>> +		attrs.error_offset = err_index << PAGE_SHIFT;
>> +
>> +		if (copy_to_user(argp, &attrs, sizeof(attrs)))
>> +			return -EFAULT;
>> +	}
>> +
>> +	return r;
>> +}

