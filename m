Return-Path: <linux-kselftest+bounces-5041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456D585C09F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 17:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2971F245AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449FB763E0;
	Tue, 20 Feb 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHdsABFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD769E1C;
	Tue, 20 Feb 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445036; cv=none; b=Cis9i6huIz7kK0Qm9yoob4kmV9iscdFEp0ito4W2uXrNo/XSac3K/L8yCb2ZDXaGTpU10fE4ctaQjFVVicwq4PNjUZ4XP39Kbl8RjIn/u6dvYkCgRECPi6g+L3YbsQ/0orzpLUWqcPsS4cFzdJxf3WdZsTYv9t2sCytzKteqRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445036; c=relaxed/simple;
	bh=AhiaIIjBV0cH5PQyZ5c32LP80z8tJP7FX4K7m6lMZLU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=FlubF4deJeHE4gH9D3NcQhBdPtgg1/8I+m77ihXV8KTFHSvK96zZNI7aUcH5iJyF05ok2MPFpWz79TvkKayVT9qHI4oPUpxHlx4LMdS9n6ktdyx3Lg8gUJvVqetj5oFRmVLTL8LVlohuntQaxreBzxNzRyl9jkB7uwzftSBbxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHdsABFU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4126aee00b2so12136445e9.3;
        Tue, 20 Feb 2024 08:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708445032; x=1709049832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsEOewE8a9LUqZdGpQ0sg6Y8GWXfE7D0W1/CTdE5oVU=;
        b=MHdsABFUEsqqwCw9JuaNbMTaVeJwVhW+LZPXqxOGPLGJQ3Fp8aC58RaXrY7sWniMRV
         QD7yRCwJk6faIBTgZ2j4lC3faokHmGUtrRAYrQZK9LArvXCKXTsXQbphDUXqifDVJgDq
         ycBrnrmHTX5c0ARwaaLOdjsmdTHoODhvXqeh4zVNi1TZdohyiXlYeB8qnW5mA0KdB1C/
         bNa5pRDQjv6s8e0Z1l8odENVTFzNisl5jEumjIpTDZZz62USw7pRQ+KGtKku9mA97iml
         SUUZwEKeJdm11cybPS3yyga7+EqtATLYG5ElY9PTi6QDA1J68RJxDcDMcVnueuprDqsR
         RTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708445032; x=1709049832;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsEOewE8a9LUqZdGpQ0sg6Y8GWXfE7D0W1/CTdE5oVU=;
        b=OySj1WKJ1JZ3p1ykJyA/M6JB7lgz9NhuifkDocINetB/bpKuJ94ABeALRVQ1UPv3S2
         4fvzKxXEuyAMNA42MLRavbUiXXFn6d6NKyMBhYTmpo15yFRSFIARYC+ibc2hWMKauB5j
         Wz2gWtjfJNFKN7fvOk6vAC2HeGWHguPC7T9NPDpw2ZJjHDcMyuktGymXSNUman5XbShF
         n2VCYUSK0OxgEOpgMjmGxZZLFZ6dFmjUt3vUry5kDnK8DU0HrkINEkPwRDSk95G5l6y9
         5byHpe7cqAZJn3kPVKTFpcZPJkRaldiSqiH14TC4RAoXUHJmd7LjQ06P3+gJIy3JGJbb
         0HjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbLchUY3aVGCSVjcI/+rpTO2xdbvssaA+Bf7vxJ5sQI84sfkO6fZnQXG818uvj8cyGtaGDjG7MaDUHMkgAry+1DeIAt01csWe+fpNnhDHoFv958paurrEgBG6K2kQZ5cVqyBOKvM5WN7QP/KIBC+RG+Z8Qs7ScdrDKTIYTVQwpGBFvNWWM6QJLSnVWaDQcukq5krKMXOguGrlSmyaaJhvlrGcagsJSFf3JnJXl/QYuuRAbRy0Y8IfktQ==
X-Gm-Message-State: AOJu0YxvFd7TfJxVwEmwQybYq8x03FiUcJ/BWf59ZcyKnGJ6QOc6fczp
	vI5u2AYoi61ixV0/mSAUJW9RbMdNMDlJlfYtHhYmPMgJpYzj46JT
X-Google-Smtp-Source: AGHT+IFz1o8lFmhShbnKg9eJ+Z3iu+6mmlFKkdnH7xFYAQxzvTVtnL2B01la+pa7bfj5zUx3PQSB5w==
X-Received: by 2002:adf:ee8b:0:b0:33d:174b:6a3c with SMTP id b11-20020adfee8b000000b0033d174b6a3cmr7851507wro.59.1708445032347;
        Tue, 20 Feb 2024 08:03:52 -0800 (PST)
Received: from [192.168.10.18] (54-240-197-225.amazon.com. [54.240.197.225])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d420e000000b0033d282c7537sm11398333wrq.23.2024.02.20.08.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 08:03:52 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <05973da0-f68c-4c84-8806-bdba92f2ed6e@xen.org>
Date: Tue, 20 Feb 2024 16:03:49 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v13 00/21] KVM: xen: update shared_info and vcpu_info
 handling
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240215152916.1158-1-paul@xen.org>
 <170838297541.2281798.7838961694439257911.b4-ty@google.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <170838297541.2281798.7838961694439257911.b4-ty@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2024 15:55, Sean Christopherson wrote:
> On Thu, 15 Feb 2024 15:28:55 +0000, Paul Durrant wrote:
>> From: Paul Durrant <pdurrant@amazon.com>
>>
>> This series contains a new patch from Sean added since v12 [1]:
>>
>> * KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
>>
>> This frees up the function name kvm_is_error_gpa() such that it can then be
>> re-defined in:
>>
>> [...]
> 
> *sigh*
> 
> I forgot to hit "send" on this yesterday.  But lucky for me, that worked out in
> my favor as I needed to rebase on top of kvm/kvm-uapi to avoid pointless conflicts
> in the uapi headeres.
> 
> So....
> 
> Applied to kvm-x86 xen, minus 18 and 19 (trylock stuff) and 21 (locking cleanup
> that we're doing elsewhere).
> 

Looks like you meant 17 & 18?

> Paul and David, please take (another) look at the end result to make sure you don't
> object to any of my tweaks and that I didn't botch anything.
> 

What was the issue with 17? It was reasonable clean-up and I'd like to 
keep it even without 18 being applied (and I totally understand your 
reasons for that).

> s390 folks, I'm applying/pushing now to get it into -next asap, but I'll make
> sure to get acks/reviews on patch 08/21 before I do anything else with this
> branch/series.
> 
> Thanks!
> 
> [01/21] KVM: pfncache: Add a map helper function
>          https://github.com/kvm-x86/linux/commit/f39b80e3ff12
> [02/21] KVM: pfncache: remove unnecessary exports
>          https://github.com/kvm-x86/linux/commit/41496fffc0e1
> [03/21] KVM: x86/xen: mark guest pages dirty with the pfncache lock held
>          https://github.com/kvm-x86/linux/commit/4438355ec6e1
> [04/21] KVM: pfncache: add a mark-dirty helper
>          https://github.com/kvm-x86/linux/commit/78b74638eb6d
> [05/21] KVM: pfncache: remove KVM_GUEST_USES_PFN usage
>          https://github.com/kvm-x86/linux/commit/a4bff3df5147
> [06/21] KVM: pfncache: stop open-coding offset_in_page()
>          https://github.com/kvm-x86/linux/commit/53e63e953e14
> [07/21] KVM: pfncache: include page offset in uhva and use it consistently
>          https://github.com/kvm-x86/linux/commit/406c10962a4c
> [08/21] KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
>          https://github.com/kvm-x86/linux/commit/9e7325acb3dc
> [09/21] KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA
>          https://github.com/kvm-x86/linux/commit/721f5b0dda78
> [10/21] KVM: x86/xen: separate initialization of shared_info cache and content
>          https://github.com/kvm-x86/linux/commit/c01c55a34f28
> [11/21] KVM: x86/xen: re-initialize shared_info if guest (32/64-bit) mode is set
>          https://github.com/kvm-x86/linux/commit/21b99e4d6db6
> [12/21] KVM: x86/xen: allow shared_info to be mapped by fixed HVA
>          https://github.com/kvm-x86/linux/commit/10dcbfc46724
> [13/21] KVM: x86/xen: allow vcpu_info to be mapped by fixed HVA
>          https://github.com/kvm-x86/linux/commit/16877dd45f98
> [14/21] KVM: selftests: map Xen's shared_info page using HVA rather than GFN
>          https://github.com/kvm-x86/linux/commit/95c27ed8619b
> [15/21] KVM: selftests: re-map Xen's vcpu_info using HVA rather than GPA
>          https://github.com/kvm-x86/linux/commit/5359bf19a3f0
> [16/21] KVM: x86/xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA capability
>          https://github.com/kvm-x86/linux/commit/49668ce7e1ae
> [17/21] KVM: x86/xen: split up kvm_xen_set_evtchn_fast()
>          (not applied)
> [18/21] KVM: x86/xen: don't block on pfncache locks in kvm_xen_set_evtchn_fast()
>          (not applied)
> [19/21] KVM: pfncache: check the need for invalidation under read lock first
>          https://github.com/kvm-x86/linux/commit/21dadfcd665e
> [20/21] KVM: x86/xen: allow vcpu_info content to be 'safely' copied
>          https://github.com/kvm-x86/linux/commit/dadeabc3b6fa
> [21/21] KVM: pfncache: rework __kvm_gpc_refresh() to fix locking issues
>          (not applied)
> 
> --
> https://github.com/kvm-x86/linux/tree/next


