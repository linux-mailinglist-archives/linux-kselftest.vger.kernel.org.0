Return-Path: <linux-kselftest+bounces-44022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13DEC07B59
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 20:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868881C816C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F9A34C144;
	Fri, 24 Oct 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bb7LhUYc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834F34BA2A
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329943; cv=none; b=ky43VkToq81eVgadaJCunNp5O8oBa6Gl4Bn3/yq3z4FkyOTf7SxwXUUYaz+OHa0iCsRFBSnGEe35VZqQgRO1uJnu74G0NzliKMyqlxGSYOCdaKT7Pv1ywF6ekmRqGmDUUVjQ/Mqw/2Pm5GtvVwRJRmw0Aj9hB9F2XTezElTsdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329943; c=relaxed/simple;
	bh=/MLpG4k/snGbFR7n6naVcLBN24KEMektQ9HLEgX83ME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bKaLi9RYInTHc0fltBIlg8J93hSapMsY4pU3O57w2LAbflL7m4w5vOKF6zgAXKF0drxtI24rIbhJIFDpNW4uf6wmK95LvZrsUyimglh88mZql6xiDFgGiU7PWitYGYtuiKYnqqsBlX+Vda0V7o+uGaVneNTTLC7uUWPQI0u+SW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bb7LhUYc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so1854177a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761329940; x=1761934740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdTxyUifw7MNQO0DnSkAJL4ChxKgMzzVSN+wxqVSJZ8=;
        b=bb7LhUYc7dE1MlJ3hn4vSFw/3f96FJuo+jNnG7WwO5ZUBaMZUJ0Tfy37suXo4rj8Hq
         GNJcqdfsLEWCouKJC/COnGEwC+7ohBE+e96qK40Fyy0hqKXmZsPkhtPuh7Xh1d+4J8gA
         ktXwT/awnjJ9z0amxoHUcCpnNGpnr5AQ7Fu/JrKglgSTumQvK8egcyg/Q2hYeCLx7nNY
         fomwoH72T/pflZECz6QDaBxf6LXwIJUi9qhGx+pf3ptByHW7qlBthw0T8HL4aYM2AQ2j
         aS5NETrxHRoAsc7+sWpsbVQRRbc+iLLk6lwLpgOnLnqv/vBRiJAq/89SbRThBaE4/Xog
         PkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329940; x=1761934740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdTxyUifw7MNQO0DnSkAJL4ChxKgMzzVSN+wxqVSJZ8=;
        b=XVNy7H62haLNBkzUlGW/Ckswt5yMRPkdP42ZQq8dfImiN51WY5fJnBG122XgpyoBgP
         4sd46q+TnGMaxC6Vr24Lfe3Uo3F5gwqStzChTElnTp/8+CGZq3lmRCHOhGZvPdBhetbr
         Wyo5Y0hfw34bLPQlnNQ9wW1hKzAOreFPUNVE/Lr5A2eNh14r9+1UpRx5/lkpR/agzgMQ
         h++C+E2s/LNk2+Poxl2WGYVdSrJKFAfu2iDNEfZtgAcNQj7AEkCMpOjYsn2EvbjX1aNx
         n/oZtX4x9jJw50txEOkx4a8RvCmvlTM+X/rFVGru7ci0f+A9BvGKnxE5IQBPaf2g7xCp
         vgjw==
X-Forwarded-Encrypted: i=1; AJvYcCUDoY31hg1xg1BflnXnicE4bWiqmzAYyO3GxMuKPxA/dT/BHROxOmgTElMDzzy2z81O3RpuAqY1cyn5OutOQ6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKT2GRf53Xj+G+tt4Sz5qlFBh3VFJLiITbzYBj/s3vgkkmxSI+
	BgZO64Zt2lSW007zvOQAgfGlWT3gxyic8ly8ewoDk+HYfI4QZ4tjGElMSMCEwVTJSjvVqBMv8tZ
	sUDzLbg==
X-Google-Smtp-Source: AGHT+IEwU7cgqhi7yxcDGgJmntbDXrYh2S5Lt4c3VipRpyfkwWodcxupSfQzFuZEDCpb4LtVbKjpe2rZJEE=
X-Received: from pjob9.prod.google.com ([2002:a17:90a:8c89:b0:33b:8aa1:75ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2247:b0:32d:e780:e9d5
 with SMTP id 98e67ed59e1d1-33bcf8e5f10mr38003967a91.22.1761329940388; Fri, 24
 Oct 2025 11:19:00 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:18:58 -0700
In-Reply-To: <diqzldl0dz5f.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <727482ec42baa50cb1488ad89d02e732defda3db.1760731772.git.ackerleytng@google.com>
 <diqzldl0dz5f.fsf@google.com>
Message-ID: <aPvDEl0kGdZfcAD9@google.com>
Subject: Re: [RFC PATCH v1 16/37] KVM: selftests: Add support for mmap() on
 guest_memfd in core library
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
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
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 24, 2025, Ackerley Tng wrote:
> Ackerley Tng <ackerleytng@google.com> writes:
> 
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Accept gmem_flags in vm_mem_add() to be able to create a guest_memfd within
> > vm_mem_add().
> >
> > When vm_mem_add() is used to set up a guest_memfd for a memslot, set up the
> > provided (or created) gmem_fd as the fd for the user memory region. This
> > makes it available to be mmap()-ed from just like fds from other memory
> > sources. mmap() from guest_memfd using the provided gmem_flags and
> > gmem_offset.
> >
> > Add a kvm_slot_to_fd() helper to provide convenient access to the file
> > descriptor of a memslot.
> >
> > Update existing callers of vm_mem_add() to pass 0 for gmem_flags to
> > preserve existing behavior.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > [For guest_memfds, mmap() using gmem_offset instead of 0 all the time.]
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  tools/testing/selftests/kvm/include/kvm_util.h |  7 ++++++-
> >  tools/testing/selftests/kvm/lib/kvm_util.c     | 18 ++++++++++--------
> >  .../kvm/x86/private_mem_conversions_test.c     |  2 +-
> >  3 files changed, 17 insertions(+), 10 deletions(-)
> >
> > 
> > [...snip...]
> > 
> > @@ -1050,13 +1049,16 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
> >  	}
> >  
> >  	region->fd = -1;
> > -	if (backing_src_is_shared(src_type))
> > +	if (flags & KVM_MEM_GUEST_MEMFD && gmem_flags & GUEST_MEMFD_FLAG_MMAP)
> > +		region->fd = kvm_dup(gmem_fd);
> > +	else if (backing_src_is_shared(src_type))
> >  		region->fd = kvm_memfd_alloc(region->mmap_size,
> >  					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
> >  
> 
> Doing this makes it hard to test the legacy dual-backing case.
> 
> It actually broke x86/private_mem_conversions_test for the legacy
> dual-backing case because there's no way to mmap or provide a
> userspace_address from the memory provider that is not guest_memfd, as
> determined by src_type.

Yes there is.  This patch is a giant nop.  The only thing that the core library
doesn't support is mmap() on guest_memfd *and* the other src_type, and IMO that
is big "don't care", because KVM doesn't even support that combination:

	if (kvm_gmem_supports_mmap(inode))
		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;

I mean, we _could_ test that KVM ignores the hva for mapping, but that's a
different and unique test entirely.

I did break x86/private_mem_conversions_test (I could have sworn I tested, *sigh*),
but the bug is in:

  KVM: selftests: Provide function to look up guest_memfd details from gpa

not here.  And it's a trivial /facepalm-style fix:

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ee5b63f7cb50..23a8676fee6d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1680,7 +1680,7 @@ int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, vm_paddr_t gpa, off_t *fd_offset,
        gpa_offset = gpa - region->region.guest_phys_addr;
        *fd_offset = region->region.guest_memfd_offset + gpa_offset;
        *nr_bytes = region->region.memory_size - gpa_offset;
-       return region->fd;
+       return region->region.guest_memfd;
 }
 
 /* Create an interrupt controller chip for the specified VM. */

