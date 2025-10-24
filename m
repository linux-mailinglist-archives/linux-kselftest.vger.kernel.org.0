Return-Path: <linux-kselftest+bounces-44014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62317C075C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28981A615D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734131B829;
	Fri, 24 Oct 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsctTBNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBA283686
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324118; cv=none; b=A1fVGnDqWHwON1nEO0rho403rh2ujLMMBKUOHrjMdNQxpaJpb2NjwRPr+hLUsF7Lawv9u+zre02/lfK717ux4fivotrjJtB3mlcYlBrAXl4HRHNROWJRp+K4ScDKraNxcowiH3GXkBaI+8Ejz8cC/eLQMVnZDEKFH8h9olWj4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324118; c=relaxed/simple;
	bh=McfDafsoKZ0Qc/ftfxMbpecU+5qms1ggNuFPRrlly10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FxAohsowPqf26I3RGEa14M+3tr3v6qJXmKP0HhQIKyoWN8opzM/V8hNa7nxnzCTJgQL6Va67AYtU0iGHYkS8UrMAFsS1BaJOBn4hHkgLeodBguH6YdWGBYoiM0jIteWrOl/8rMXqT9CTM+DesNEWCkUsrfGtDLYjLhcNETgcWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsctTBNU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290da17197eso33393875ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761324115; x=1761928915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1RHFoPTdDvcwb/qkIe5JmQx1A2yObnl5+zva5BuXpw=;
        b=tsctTBNUSZLhJdLijABuCYbdLPgyibjJHwSemEN+RLADY9F8zDG3CtohhrbugCEnqr
         TwzkCU9u2J+GHaMYa+tqD4lvZWe6aB1dd5wTlWtA1ghCxpJclHAEon7ii+YbdJo78d1A
         Ww+U3RfxAGKk539AN8Ks0MR88xu2nTmpK7AfEjOlRxtrfZTRtmCSzRKVjGddiPUaxIJM
         qZgn5eqMIDTEjmTG9Ee12SlpR8ng8BfeDwndOaSBHwKMC4qETtX1Sx2MUN28tTQkz/T5
         NkKuk0pjiAJjaH5K1nsW8GNMzHAcfOD1eaj/6vw4+laSEZaFJH21swpVvBz+ub52AZJS
         gIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324115; x=1761928915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1RHFoPTdDvcwb/qkIe5JmQx1A2yObnl5+zva5BuXpw=;
        b=Ujir4xqRHVdIVDbtOYKkk8evyGadiJKk0r8LnMDtovnLp8ABNh4Zcfsd2RtF1jbYCl
         N4kdABoPVv+Rqkgdz/gXDIgrQTNOzu9A/lQreZMleBIYEX8b7otoDjv8hgmxre9VbeII
         OvI1wJ3zIah9Tl5Z74fjvp8qifjz6emoO7KjMLMCZ14hSyyRPd0lfSouzsZwriCTSMfc
         vl077ihVQN/ahVovGLuyk6QAvtSEd073JihO5rlTD86bn/Typ9L/92WqprzdeWU5A/jf
         huzQmBO0M6ea11LGBKFIZNKxRlZr3AHM7vvHNU8JcMrCsEUbu8SXjFflQCD2xmUaK34M
         KiHw==
X-Forwarded-Encrypted: i=1; AJvYcCWVDoU1+I7LURZASf60TcpmmElqBpOegS+MCOMoGpt9z/GbbahJNVkSuihdHA3jCTVtiRPHYM094ylF9geWA3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVEj+g1nTtQMQ/rT12SjxhEEx/cWVlseV8Ax6r7l5GoBuzS0v
	ymqmQ8aA5Ab39m3yQXRBvRXD10hd+KXVn2Kyz4JSE3OfnBeZ1Bnx8bvspGesEOyeHct9swmBrwn
	nnQ1d+2n+os3rFqzwqqW7CA12qQ==
X-Google-Smtp-Source: AGHT+IEPuBDuGNsrppGmcrNT5qFipxZMZW83jV/EN44QaRv4+wQ0X1ZUm0/OOFjwazq9d0SG+iIXrpEvGj5fqDDiKg==
X-Received: from pjn8.prod.google.com ([2002:a17:90b:5708:b0:31f:2a78:943])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ea01:b0:267:d2f9:2327 with SMTP id d9443c01a7336-290c9cf2d88mr421610105ad.27.1761324115016;
 Fri, 24 Oct 2025 09:41:55 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:41:53 -0700
In-Reply-To: <aPuXCV0Aof0zihW9@google.com>
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
 <diqzqzuse58c.fsf@google.com> <aPuXCV0Aof0zihW9@google.com>
Message-ID: <diqzo6pwdzfy.fsf@google.com>
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

> On Fri, Oct 24, 2025, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> >> 
>> >> [...snip...]
>> >> 
>> 
>> I've been thinking more about this:
>> 
>>   #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>   	case KVM_CAP_MEMORY_ATTRIBUTES2:
>>   	case KVM_CAP_MEMORY_ATTRIBUTES:
>>   		if (!vm_memory_attributes)
>>   			return 0;
>>   
>>   		return kvm_supported_mem_attributes(kvm);
>>   #endif
>> 
>> And the purpose of adding KVM_CAP_MEMORY_ATTRIBUTES2 is that
>> KVM_CAP_MEMORY_ATTRIBUTES2 tells userspace that
>> KVM_SET_MEMORY_ATTRIBUTES2 is available iff there are valid
>> attributes.
>> 
>> (So there's still a purpose)
>> 
>> Without valid attributes, userspace can't tell if it should use
>> KVM_SET_MEMORY_ATTRIBUTES or the 2 version.
>
> To do what?  If there are no attributes, userspace can't do anything useful anyways.
>
>> I also added KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES, which tells
>> userspace the valid attributes when calling KVM_SET_MEMORY_ATTRIBUTES2
>> on a guest_memfd:
>
> Ya, and that KVM_SET_MEMORY_ATTRIBUTES2 is supported on guest_memfd.
>
>>   #ifdef CONFIG_KVM_GUEST_MEMFD
>>   	case KVM_CAP_GUEST_MEMFD:
>>   		return 1;
>>   	case KVM_CAP_GUEST_MEMFD_FLAGS:
>>   		return kvm_gmem_get_supported_flags(kvm);
>>   	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
>>   		if (vm_memory_attributes)
>>   			return 0;
>>   
>>   		return kvm_supported_mem_attributes(kvm);
>>   #endif
>>   
>> So to set memory attributes, userspace should
>
> Userspace *can*.  User could also decide it only wants to support guest_memfd
> attributes, e.g. because the platform admins controls the entire stack and built
> their entire operation around in-place conversion.
>
>>   if (kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0)
>> 	use KVM_SET_MEMORY_ATTRIBUTES2 with guest_memfd
>>   else if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES2) > 0)
>>         use KVM_SET_MEMORY_ATTRIBUTES2 with VM fd
>>   else if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) > 0)
>> 	use KVM_SET_MEMORY_ATTRIBUTES with VM fd
>>   else
>> 	can't set memory attributes
>> 
>> Something like that?
>
> More or else, ya.
>
>> In selftests there's this, when KVM_SET_USER_MEMORY_REGION2 was
>> introduced:
>> 
>>   #define TEST_REQUIRE_SET_USER_MEMORY_REGION2()			\
>> 	__TEST_REQUIRE(kvm_has_cap(KVM_CAP_USER_MEMORY2),	\
>> 		       "KVM selftests now require KVM_SET_USER_MEMORY_REGION2 (introduced in v6.8)")
>> 
>> But looks like there's no direct equivalent for the introduction of
>> KVM_SET_MEMORY_ATTRIBUTES2?
>
> KVM_CAP_USER_MEMORY2 is the equivalent.
>
> There's was no need to enumerate anything beyond yes/no, because
> SET_USER_MEMORY_REGION2 didn't introduce new flags, it expanded the size of the
> structure passed in from userspace so that KVM_CAP_GUEST_MEMFD could be introduced
> without breaking backwards compatibility.
>
>> The closest would be to add a TEST_REQUIRE_VALID_ATTRIBUTES() which
>> checks KVM_CAP_MEMORY_ATTRIBUTES2 or
>> KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES before making the vm or
>> guest_memfd ioctl respsectively.
>
> Yes.  This is what I did in my (never posted, but functional) version:
>
> @@ -486,6 +488,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
>         }
>         guest_rng = new_guest_random_state(guest_random_seed);
>         sync_global_to_guest(vm, guest_rng);
> +       sync_global_to_guest(vm, kvm_has_gmem_attributes);

I ported this [1] except for syncing this value to the guest, because I
think the guest shouldn't need to know this information, the host should
decide what to do. I think, if the guests really need to know this, the
test itself can do the syncing.

[1] https://lore.kernel.org/all/5656d432df1217c08da0cc2694fd79948bfd686f.1760731772.git.ackerleytng@google.com/

>  
>         kvm_arch_vm_post_create(vm, nr_runnable_vcpus);
>  
> @@ -2319,6 +2333,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
>         guest_random_seed = last_guest_seed = random();
>         pr_info("Random seed: 0x%x\n", guest_random_seed);
>  
> +       kvm_has_gmem_attributes = kvm_has_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
> +
>         kvm_selftest_arch_init();
>  }
>  
> That way the core library code can pivot on gmem vs. VM attributes without having
> to rely on tests to define anything.  E.g.
>
> static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
> 						uint64_t size, uint64_t attrs)
> {
> 	if (kvm_has_gmem_attributes) {
> 		off_t fd_offset;
> 		uint64_t len;
> 		int fd;
>
> 		fd = kvm_gpa_to_guest_memfd(vm, gpa, &fd_offset, &len);
> 		TEST_ASSERT(len >= size, "Setting attributes beyond the length of a guest_memfd");
> 		gmem_set_memory_attributes(fd, fd_offset, size, attrs);
> 	} else {
> 		vm_set_memory_attributes(vm, gpa, size, attrs);
> 	}
> }

