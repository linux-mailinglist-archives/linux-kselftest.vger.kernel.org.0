Return-Path: <linux-kselftest+bounces-43983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782AC06BB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3C03A744D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEF231A800;
	Fri, 24 Oct 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4LruAbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C431352B
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316616; cv=none; b=avv/cDQbOVr4duB0cYjnYBBY2uQFlJ+kgMumnbdc5MKh3Z3qZkq3DBZJ0LKcb/fhJRqHFG8EofL+EzspUvrzt19a8OD7QI/G7/33cVL7T8qLUzDIdLiowYR6cR+jWiiEFXd7tVIOE90QsxqZZNzMQap6UXWCccq6SuKYz0yFzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316616; c=relaxed/simple;
	bh=7POTLgOQMSvDxIjq1wqPOOdPmObt8KgLrizCHzkYhn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFHEdMN9TUmyhQTib3f0GgsLNy8C2TRsspAwy9+krmaUgwD+RBdnLy52MYd2TY/6s2muqC3SfKjIQgEfgKFFlXRhZK7hwfHw3hwk0qj6X1/gxHcfPjymhG3QiGfIz39L+vhSeDkeqY4vlb9JLpkIzyzMp4m4XKiNPqZoAK0u6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4LruAbw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290cd61855eso19672865ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761316614; x=1761921414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gWpJOPikpazVbpXRSUPMCcvrbTBk5c7sNdJD5ZAL5c=;
        b=f4LruAbwGC7NvQfpfbN76Yj4wOdfUQMXmRa9yXRCYqVLCvpKM+DOcf8qKT+Cq5HmpF
         eFGQ3Zs08aupJi37oT0laKXktHx9Hi/4GTGLFUSOFQEoa+8RL3W+oi8rjz2N97b8SulF
         khZYHZdNmQHASNx7zXNnzE691sq0q9m1MBeN5oeldppylyeWbhR2ZjdULm8lPQBDMYTN
         LqhZ69mvKkaBI53bmuDMu0e0bdTXp4uy5WsJRMXvmTuRz2+DEcMjUKilqSyCN1ACboLD
         29ytfDZiogxJB0mhQ01wbrG89uPplqKmXe3BJUX/JxkMhigOzYgppF8cNvl2YODRER7r
         2+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316614; x=1761921414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gWpJOPikpazVbpXRSUPMCcvrbTBk5c7sNdJD5ZAL5c=;
        b=rJdi+BN2f5ZkdHYLowQRGw3n4EC1aSGBZYBaGziX7mW5mS+8pPoflNh1b6TjQIjhwM
         XIqDl2gqt/YMuMZlr7OOGU1iDaJnaCBfTeflRpq6TJQNt5M4/IkC/N7hOcsQXMaw2TpY
         wN/rXjrPKWe0CCb+TEvl1GydqFd4ervbjbC8HnFE5VCv2CcvaLbSUH1esvRTexWHqTji
         YF9hXJrIq4Fwo5sQFo3vHPMJoUu+xjjhW1zgYSLu90ighhEqDK18qin3nUbwlDnyhpz8
         H7yhGbcTbVUwDZUC6OC3o+GK27KW6UD0uMndk0MC8lewfCXU4Fh07syU8Wne1rg5kCL9
         f8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUh5GwpuvU9SdqkJbu4+Gjg0wNxevG3BOJITm2Qz6mYxlCLNBBNpMr7eblLBeoZYR+nbCEqetDbN837ATokId4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA2z7PGo2Lgknjtl94qSofG5jS1eEQSjkgKPeIvYwFUVU9Na4P
	zA2NIFCN33TQlNfXXyKBfWTg1R3XJakbonEiyKfiBIU5jshRH4cTWrnWYFf8MYon7xx6VSvkRaf
	Ua8H8GeFo9PJOSnZZ/V23W5l2Zw==
X-Google-Smtp-Source: AGHT+IHpZZ9f9FI2oIDKJuatT8tIt0u+E9sskkPVtdG8cewdd4WM+aJNDiUGBZhPHxdPQPN/WAuNAtpnF8qjPR3V7w==
X-Received: from plcq12.prod.google.com ([2002:a17:902:e30c:b0:290:28e2:ce4e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f68c:b0:290:91d2:9304 with SMTP id d9443c01a7336-290c9c8a770mr324316695ad.4.1761316613376;
 Fri, 24 Oct 2025 07:36:53 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:36:51 -0700
In-Reply-To: <aPpEPZ4YfrRHIkal@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
 <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com> <diqz4irqg9qy.fsf@google.com>
 <diqzy0p2eet3.fsf@google.com> <aPlpKbHGea90IebS@google.com>
 <diqzv7k5emza.fsf@google.com> <aPpEPZ4YfrRHIkal@google.com>
Message-ID: <diqzqzuse58c.fsf@google.com>
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Price <steven.price@arm.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, liam.merwick@oracle.com, 
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
	shakeel.butt@linux.dev, shuah@kernel.org, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Oct 23, 2025, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Wed, Oct 22, 2025, Ackerley Tng wrote:
>> >> Ackerley Tng <ackerleytng@google.com> writes:
>> >> 
>> >> Found another issue with KVM_CAP_MEMORY_ATTRIBUTES2.
>> >> 
>> >> KVM_CAP_MEMORY_ATTRIBUTES2 was defined to do the same thing as
>> >> KVM_CAP_MEMORY_ATTRIBUTES, but that's wrong since
>> >> KVM_CAP_MEMORY_ATTRIBUTES2 should indicate the presence of
>> >> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2.
>> >
>> > No?  If no attributes are supported, whether or not KVM_SET_MEMORY_ATTRIBUTES2
>> > exists is largely irrelevant.
>> 
>> That's true.
>> 
>> > We can even provide the same -ENOTTY errno by
>> > checking that _any_ attributes are supported, i.e. so that doing
>> > KVM_SET_MEMORY_ATTRIBUTES2 on KVM without any support whatsoever fails in the
>> > same way that KVM with code support but no attributes fails.
>> 
>> IIUC KVM_SET_MEMORY_ATTRIBUTES doesn't fail with -ENOTTY now when there
>> are no valid attributes.
>> 
>> Even if there's no valid attributes (as in
>> kvm_supported_mem_attributes() returns 0), it's possible to call
>> KVM_SET_MEMORY_ATTRIBUTES with .attributes set to 0, which will be a
>> no-op, but will return 0.
>> 
>> I think this is kind of correct behavior since .attributes = 0 is
>> actually a valid expression for "I want this range to be shared", and
>> for a VM that doesn't support private memory, it's a valid expression.
>> 
>> 
>> The other way that there are "no attributes" would be if there are no
>> /VM/ attributes, in which case KVM_SET_MEMORY_ATTRIBUTES, sent to as a
>> vm ioctl, will return -ENOTTY.
>
> Ya, this is what I was trying to say with "_any_ attributes are supported".  I.e.
> by "any" I meant "any attributes in KVM for VMs vs. gmems", not "any attributes
> for this specific VM/gmem instance".
>
>> 
>> [...snip...]
>> 

I've been thinking more about this:

  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
  	case KVM_CAP_MEMORY_ATTRIBUTES2:
  	case KVM_CAP_MEMORY_ATTRIBUTES:
  		if (!vm_memory_attributes)
  			return 0;
  
  		return kvm_supported_mem_attributes(kvm);
  #endif

And the purpose of adding KVM_CAP_MEMORY_ATTRIBUTES2 is that
KVM_CAP_MEMORY_ATTRIBUTES2 tells userspace that
KVM_SET_MEMORY_ATTRIBUTES2 is available iff there are valid
attributes.

(So there's still a purpose)

Without valid attributes, userspace can't tell if it should use
KVM_SET_MEMORY_ATTRIBUTES or the 2 version.

I also added KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES, which tells
userspace the valid attributes when calling KVM_SET_MEMORY_ATTRIBUTES2
on a guest_memfd:

  #ifdef CONFIG_KVM_GUEST_MEMFD
  	case KVM_CAP_GUEST_MEMFD:
  		return 1;
  	case KVM_CAP_GUEST_MEMFD_FLAGS:
  		return kvm_gmem_get_supported_flags(kvm);
  	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
  		if (vm_memory_attributes)
  			return 0;
  
  		return kvm_supported_mem_attributes(kvm);
  #endif
  
So to set memory attributes, userspace should

  if (kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0)
	use KVM_SET_MEMORY_ATTRIBUTES2 with guest_memfd
  else if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES2) > 0)
        use KVM_SET_MEMORY_ATTRIBUTES2 with VM fd
  else if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) > 0)
	use KVM_SET_MEMORY_ATTRIBUTES with VM fd
  else
	can't set memory attributes

Something like that?


In selftests there's this, when KVM_SET_USER_MEMORY_REGION2 was
introduced:

  #define TEST_REQUIRE_SET_USER_MEMORY_REGION2()			\
	__TEST_REQUIRE(kvm_has_cap(KVM_CAP_USER_MEMORY2),	\
		       "KVM selftests now require KVM_SET_USER_MEMORY_REGION2 (introduced in v6.8)")

But looks like there's no direct equivalent for the introduction of
KVM_SET_MEMORY_ATTRIBUTES2?

The closest would be to add a TEST_REQUIRE_VALID_ATTRIBUTES() which
checks KVM_CAP_MEMORY_ATTRIBUTES2 or
KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES before making the vm or
guest_memfd ioctl respsectively.

