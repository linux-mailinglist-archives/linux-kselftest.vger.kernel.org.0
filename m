Return-Path: <linux-kselftest+bounces-11796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE45905D7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 23:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073B51F22640
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4C84FCC;
	Wed, 12 Jun 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXj1+zWA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C984E0A
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226736; cv=none; b=cBsh7bOzPqNzfP1Wj92QTOgYXOSPNVN3SoXXNVzKYQetebh2vuILV5lAS88WxQFkaezUdHvukt1aynNbdTdxbBGti6aHuSGm3lySn7uQk9PpBJ6ZWrC9xcx0xKggebUC7+/1f416hMQ1jYlSD1w/a0aKqpIsKR9IbvvDimSUiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226736; c=relaxed/simple;
	bh=mZ1gVsscLnoQrhu6DUaN86+gh4C4z0/alorNn55aWOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FREFLDbCGx1jfhYyhlthobPRLkDN7Td6uOrM7EbbzY54MaI/PUazFpXWGC1CGNAVke/wyUPEaEH+IoPOxjVhpTX1SMuTggl69a+pha5LAUc2bOmc/JuUeXJqHgwwDMBqZ/Jap+9RyuROQtGxUcv6EatjX7mD/kNH0Soucq6UZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXj1+zWA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7bdb0455bso444735276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718226734; x=1718831534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQnTUkcCD7nk2Vw7ExeAQaoK3gWIegL46mSfNzj2DMU=;
        b=KXj1+zWAF/3cHUvUtvrZxNbygxmzl80WhX2rgC4OTqdHqJxEzXMOwvRai0agp4baAJ
         GnG2+7oEt4mxhsCUVx40mKDeHRczaAwQgID+X/j9kDG59bD4Bn15hag58/YkSV37cES5
         4Gwirc8/dIifUYDtwzCeLA+ELcCMgkzS18PPaPa1oNFGsA5PW6Jkg4RaA/A1dBuBa1fP
         QOogVN53Y8J0KPz82U/reO8bj0xMV92B4dh1Ltv+Lt+cDCcxGZwsqm/vY8M+2Q9sh2w0
         jsbcq0r7NU8XxbZ61ubxGpVN4AAUQKmMOFKoddAUrzybn/GhSLtiFEKSHdplZKVS7F7l
         RHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226734; x=1718831534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQnTUkcCD7nk2Vw7ExeAQaoK3gWIegL46mSfNzj2DMU=;
        b=jOMpfP9c3QFGI581MMCKJvn+WUlzriCqOlo2hjnR4P340dkT/kTwojIpD6e1SLqXbU
         ZFkbMUkT9uQf+S5is2csbuefvllKWjdFRrZQxgfHUI4u13dLHStEqvBIWAfDmGAhkfc1
         UvSFVuWIEOIviqT+hU7c/06p6hC6E1T5G2Lc2QVUdDuQ6lFObWvCWPnVaeOBvAMMfF4d
         JqmVhOZQYVPh4dAuXoTniYD5F2884lfSppXbNz4kefOE+YPhZmNwpcSSIEnpxIuUHQlk
         sX/iAJvJI+mSX/yDnkJx1pG63GOkqlqQ7/ZqMzFqObzoJmktuSg+pLUHxd+I4EXhw1dQ
         sVNg==
X-Forwarded-Encrypted: i=1; AJvYcCWOTRfmplImkxTJ2YToF59nuwP58mdLTzju8hpvn3YBRV6FIpEw40A+r6BpFiIv/vzgj+V5lbBu2Im/EtJ8JA8QFZRcuXXU/IRjqpji95is
X-Gm-Message-State: AOJu0YwEGR8/GcdLdXlBZy5eJs0wsQBoz9QDCl+7Psz1RJAVWgIBdlI9
	/1O0vxjXSg7UI4j5VbLk5lKgOU2RpZDA39rVHR4WbyhDUP+3TV8l9ghcOo9PGCJUVMvnytgDKqB
	2lw==
X-Google-Smtp-Source: AGHT+IHsV28eaC2THrd7M7nGgltqa0kTEglruuHJgRHKPTTyPjjhrN5LKu8lrwbv6iFMvLbV9hefC3OsmFA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:120c:b0:df4:920f:3192 with SMTP id
 3f1490d57ef6-dfe68036303mr137279276.8.1718226733624; Wed, 12 Jun 2024
 14:12:13 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:12:12 -0700
In-Reply-To: <20240207172646.3981-5-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-5-xin3.li@intel.com>
Message-ID: <ZmoPLOx8sujVsGIS@google.com>
Subject: Re: [PATCH v2 04/25] KVM: x86: Mark CR4.FRED as not reserved
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when a guest
> enumerates FRED, otherwise it is still a reserved bit.

This isn't quite correct, as __cr4_reserved_bits() is used with kvm_cpu_caps too,
i.e. to compute CR4 bits that are reserved from the host's perspective.  And that
matters, because if this check was done _only_ on guest CPUID, then KVM would
allow CR4.FRED=1 before all of KVM support is in place.

> Signed-off-by: Xin Li <xin3.li@intel.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/x86.h              | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b5b2d0fde579..0d88873eba63 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -134,7 +134,7 @@
>  			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
>  			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
>  			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
> -			  | X86_CR4_LAM_SUP))
> +			  | X86_CR4_LAM_SUP | X86_CR4_FRED))
>  
>  #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
>  
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 2f7e19166658..9a52016ebf5a 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -532,6 +532,8 @@ bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type);
>  		__reserved_bits |= X86_CR4_PCIDE;       \
>  	if (!__cpu_has(__c, X86_FEATURE_LAM))           \
>  		__reserved_bits |= X86_CR4_LAM_SUP;     \
> +	if (!__cpu_has(__c, X86_FEATURE_FRED))          \
> +		__reserved_bits |= X86_CR4_FRED;        \
>  	__reserved_bits;                                \
>  })
>  
> -- 
> 2.43.0
> 

