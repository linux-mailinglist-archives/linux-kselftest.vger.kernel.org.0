Return-Path: <linux-kselftest+bounces-49057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A849BD282F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 20:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF17C3083AB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395D31AA82;
	Thu, 15 Jan 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xDa2ZDe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246A31A549
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505992; cv=pass; b=BLx1mnE32yVK4pwe3IuOLp6G5VJW5JBPhiD1CSqndaLe++JWDX35cEfhYIZlrspKcdVVXcEbZXBVy8kx6QPO0NtUHMaPMZSaYh7IqkflD8r9+/RaKL7zkdk6vqhkx5u9/YRuw45Xe7cjROd0x66Gt/ihqr6hUsCLwhcT7lDYOno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505992; c=relaxed/simple;
	bh=8lDpvZLaR4z8lIctcEKx9lDd0Hg9OXd26QzQJA3m9FE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDZULJ817RA4nC66YI5WVfswhKyviF3cugUDi30JmsaR1ymwJlCFCMAZESYCjIdMGkcbrcT073mUTMk8LMDcLI2OBv60N4XYUMAwo5eedW0L/QquPdIPAt58ZMWki4C+gjd0XHOFFJHBVJV8RyiR1RcLzqlkYRTub26tjYky3BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2xDa2ZDe; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5eeaae0289bso851259137.2
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 11:39:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768505989; cv=none;
        d=google.com; s=arc-20240605;
        b=KltN8MNSMW8uDcdt/Ye11TJ0WBMpyu4kAgQ6eryE/0h5SfxUsmJWp9QAa9rzLY9hIv
         Wtwgm15hXoNtuLHHgyPWNfAiJefHkjeaR4ujUvGGik4a54F9WCA6sZM3Ucd0/xZyqY7o
         WJTrUdZcJpTTOa1fN8IKHM1anB70kbBa6cIPhFRKTMk2nq+o+CD/6gddopW6sB1XHpK6
         CEndTCQP1tn2k5vUXC0LY5CRHpAJjjyiru3Oz0fztqMLoSbG5E6Wb4Ee8lqiHOYPRGbz
         6Vym1QYZEJJdpZDqMhVK8ZV+vMDpCKmOBa0bOl3Ws1hgtLcXicZEW5ZnyEqf1NRb/3tM
         aPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        fh=IQtcglpvaD45vbLaPjQPyMHwn6JDR88dfuJMzSwFLcs=;
        b=WXMlcDic0bGxNGeb1/vMXCPBGwVOgzSExGSBwRgztyrG/PDWvB12B8LkTg5gumj2JV
         h3sIkiTYy24TDLsLhmXmf2URPHHNsU3/jWIteP+52MZeG1bsceJvTkdrR1rd/wB9ADpQ
         +ZOa561G0mZu0L9uE/p6fm4IGEvIrBHMs/ex4uCkADEtA+PpUPXlgUJAq7+Q6Ac5rn+6
         d/eEanJO96stBMq0jfjFGImhiR2OG6paofXYev60glAg3B+2M8ENbo4lVhJMd61HUiN9
         ZdSsHXBJHRoA+Oy/BloRzpqakmUUkUirdJmZP3/SQCtY1+kMpgdOJzmwlpqzgO59Um3G
         GCnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768505989; x=1769110789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        b=2xDa2ZDe6fWga3o9iQ/y68a2kotTMM+5GC5yibxJ1c8aadzFiQ3GNqo1zV6Sx9LEpr
         40WIBz8oKTx87gYkb47xR/rQhXQ0xVaRDugYxlBT2qdaU93joS46RiL1QMoIUrebP5+p
         zknWxMhKAlJ65pvxXJyhV+Y+RjxLsxDcOARl0NpNgG35pJa+VRpWAicnxFyk7cIpEvBm
         YKsParmFsYYWH3HI5gtB/V0vikHKCV/F10+uyO5qeDRcZMddXvxtKwl+/HvLV4CeY9db
         nNuRSUL6TuHpKcYngiOWmRKOu80+ttYncZZwb7oycm+yh9wH8lwNFhihElXn23+CHKFG
         0BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505989; x=1769110789;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        b=w/3ZaxSz5jPj1mMbTEvAoYeABeQ9cwpK4tUoUfdt1Qd5ZBdSaymxhxoYeIx7Ed1yle
         yZ/j6ruJDmYT+d6w9J36oKBj6D6tHaFw7lwTlnt7ZMkNYW9lc//SjgcSwPwHKbKvMlRb
         cSEPea8wdI35Fu7ve2ouAQbJGGsUiLJ527zyV0Xj0fe5sCfMGExgagwOGW8ZRuReeJwp
         nr2m6baRt/VeSAmEbrZYHvIxk2hT497A7eWmnvx3+IQhgh5uXB4AgA9sSnDxoLNzm+1o
         yVsaXNMVuTWB1muWYKLERs8AXrnC9DeiFl2OAqpvNCuL66NSZn/dvtlhRyR9aEkvkyea
         3GUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH3TqNFBagtYHhydrN9BoQq4Qz/NFXGAdfefhnPtDNa63WTsR4J+sIe2leBrl1ZR65jPEsh7lpz0YqoG4GS2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrViM2ZBdgIJg4dXzErpV1HcX95ObZGlIbXWJAypJ4jPFNUkEw
	qCGGrzoVo6YRQsk396g3iE1LPB+E64mLqy9taclrbwApGX2sGEylvqdEXpXoNhClLQvGFzF+Ygd
	2hMKT9RBl3mz97Tq6AOtNaqvJqQXWhssfCtnHnkOp
X-Gm-Gg: AY/fxX7hfSQI/dkQB4J+6a0fNRBZuswoBZo9IbS+BARmP5AwB/m2wgdxMAPv0rukRR4
	4LgQk3zreHJWQHJ0ma54JONZQLRCvfYEDHsiedRRkIS+W0fmrdWAeyFBwBdiEvzVruMBpqVUkAe
	5oRd8K6p5oAJ9mipaBkB/a/QvDn9QVBSSU03BuyK/o+75QKDY9ec2Q2QQPrqA7MkI32CoWsDajo
	gJbYQndcH3MmXIMWjSsa8h+6xkTvy4ZhvRh9ZWm8TCVjikCd3NkEil0GAowcvaqqNcCCKNia8cl
	kmeUL9QvhxNUImJ5gTCFu3iCjuh+FELSTT0c
X-Received: by 2002:a05:6102:3708:b0:5ef:ab71:cbcd with SMTP id
 ada2fe7eead31-5f1a4d8ce85mr377168137.7.1768505988665; Thu, 15 Jan 2026
 11:39:48 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 11:39:47 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 11:39:47 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-10-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-10-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 11:39:47 -0800
X-Gm-Features: AZwV_Qiu_D8foB8Z5ZjGyCrmwdkqsKcMaz5fdNTkl-JawXW8yxxzsPZp7V4tbiI
Message-ID: <CAEvNRgGz2gRu2i+OSxasuyZudqsRGXijbDES8uXVe_hH6QCK4g@mail.gmail.com>
Subject: Re: [PATCH v9 09/13] KVM: selftests: set KVM_MEM_GUEST_MEMFD in
 vm_mem_add() if guest_memfd != -1
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

"Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:

> From: Patrick Roy <patrick.roy@linux.dev>
>
> Have vm_mem_add() always set KVM_MEM_GUEST_MEMFD in the memslot flags if
> a guest_memfd is passed in as an argument. This eliminates the
> possibility where a guest_memfd instance is passed to vm_mem_add(), but
> it ends up being ignored because the flags argument does not specify
> KVM_MEM_GUEST_MEMFD at the same time.
>
> This makes it easy to support more scenarios in which no vm_mem_add() is
> not passed a guest_memfd instance, but is expected to allocate one.
> Currently, this only happens if guest_memfd == -1 but flags &
> KVM_MEM_GUEST_MEMFD != 0, but later vm_mem_add() will gain support for
> loading the test code itself into guest_memfd (via
> GUEST_MEMFD_FLAG_MMAP) if requested via a special
> vm_mem_backing_src_type, at which point having to make sure the src_type
> and flags are in-sync becomes cumbersome.
>
> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 24 +++++++++++++---------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8279b6ced8d2..56ddbca91850 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1057,21 +1057,25 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>
>  	region->backing_src_type = src_type;
>
> -	if (flags & KVM_MEM_GUEST_MEMFD) {
> -		if (guest_memfd < 0) {
> +	if (guest_memfd < 0) {
> +		if (flags & KVM_MEM_GUEST_MEMFD) {
>  			uint32_t guest_memfd_flags = 0;
>  			TEST_ASSERT(!guest_memfd_offset,
>  				    "Offset must be zero when creating new guest_memfd");
>  			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
> -		} else {
> -			/*
> -			 * Install a unique fd for each memslot so that the fd
> -			 * can be closed when the region is deleted without
> -			 * needing to track if the fd is owned by the framework
> -			 * or by the caller.
> -			 */
> -			guest_memfd = kvm_dup(guest_memfd);
>  		}
> +	} else {
> +		/*
> +		 * Install a unique fd for each memslot so that the fd
> +		 * can be closed when the region is deleted without
> +		 * needing to track if the fd is owned by the framework
> +		 * or by the caller.
> +		 */
> +		guest_memfd = kvm_dup(guest_memfd);
> +	}
> +
> +	if (guest_memfd > 0) {

Might 0 turn out to be a valid return from dup() for a guest_memfd?

> +		flags |= KVM_MEM_GUEST_MEMFD;
>
>  		region->region.guest_memfd = guest_memfd;
>  		region->region.guest_memfd_offset = guest_memfd_offset;

Refactoring vm_mem_add() (/* FIXME: This thing needs to be ripped apart
and rewritten. */) should probably be a separate patch series, but I'd
like to take this opportunity to ask: Sean, what do you have in mind for
the rewritten version?

Would it be something like struct vm_shape, where there are default
mem_shapes, and the shapes get validated and then passed to
vm_mem_add()?

> --
> 2.50.1

