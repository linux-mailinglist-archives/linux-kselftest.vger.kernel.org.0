Return-Path: <linux-kselftest+bounces-11802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A9E905E3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 00:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D241C213D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 22:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423412A16D;
	Wed, 12 Jun 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCbft5Ps"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CB43144
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230147; cv=none; b=eCYaGFuDotXQu3Oh26vsqe7DHCIzkSXLVrvwh21b3VutdRQp7W8H5owIZA+H/3/J5nIZKbmo6enj29FLsFtwUC1fsYnOG7vMOf4hxWEByDWFK+6PRjmS+UHmnYfHgUD89UAQ53lYDgJimQqK51EZzZjQbE9WlWB4qXv6Kj12C20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230147; c=relaxed/simple;
	bh=uf4QwjexCbqgBE5KgK6TjEHCqZfSMf9GM+zF7zleRX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i7VEx1JTnLKOKGdrCLiqTa1LbAiVUvspKIzT/lIlQ/4SpoDaxXClhMsdZ7FlEBw7Y6gUuSUNfbzIjjAFWdYRIQzYMT9pDEZjhFLrbaSbjgApn4uthLWjf542np/cQS7Q+WzdAcS0Ef0v2tUp6ZfLVePixAglb6ES9onLf14glD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCbft5Ps; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6fb22ecd976so188727b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718230144; x=1718834944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5uG0fPgVb1UTRgqxTYPdWxSr8OQ4pJ5csv1+LzNJtI=;
        b=WCbft5Psx+Rtd8O6uWItQynnGV0Z589CuDLIx149masc3T7X+yDJQCcAhTHs7lO1Zu
         AUxAnSzPoOXiq2cS1a3YSvmvuPjP1VA1itDcccPnulwNyurPywAxedBEx2nSgEAwtKDk
         /32bj91B19svsy7KO0pqKx+uv64kZm81MfNRzvt6E+Vn2QgZb8/O9/wMkHzepzAmlwgX
         4LP5t4kEHMeaBK55loWmOqE2dMVHXE7A33csXGUtmgw+G98xAdeqvekEodIN1gLfWd6a
         +lXW47dLoJvU+YuySCpRScl1/0eu9UcEB0h7gXtB0QxKVU7+KMW8ekU4tTd7uinP/ebR
         CpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718230144; x=1718834944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5uG0fPgVb1UTRgqxTYPdWxSr8OQ4pJ5csv1+LzNJtI=;
        b=ceKL7XOc9Z7HiQntu3jScoeuKMyqQjszDSgdYbkO3eMaZt5hvqlp+BXEyNFsz6xokR
         a1aP3UIZdCjFv5MswKTXJ3eBEfXFIPnwGvhJ/BOdCu4WdZauctwjigLHnpoFSOD0NnR6
         fDQGv62NDGZjcXyQjnI56jnteVxonFgvBcAnKt2UyDtzBp5h5l45OMzNtmmZMicu2CBa
         VSHSkm0RwirtF/jfeM+77wErlEiXLhW76anIw7uzrSvc+wsD1SkzpSYACIOLX0Dq7lfF
         +jzAHTeRCp0qzaIyhaEFjQ8re9hUGDSS12Z5TrEJFiioNwV+BsYqjjqOwKrc0BlfKLwZ
         GHNw==
X-Forwarded-Encrypted: i=1; AJvYcCVkRLXz4xSSM0dcMQr+W8/eRxY3nBFI+GDUC4F+x/bwI/iFzHPCQCI9WTQ5ooQx6RTjEoe9gU+QEw4jTACz8HSKNys3K4FuYKIGYezWKSbB
X-Gm-Message-State: AOJu0YwgFSdd4JnDrdjnWCkohdEWAaPsed9Wn5KPlZ7I3oTdwYGqYKlP
	cbIt6yvPItrMHc0bxXmrEKQ3s2V1bxIkPAbapaqvTTXY/bTNE1MHiy6sRxMRoU6MQGLCh32b5Es
	HkA==
X-Google-Smtp-Source: AGHT+IH7XsxsWv6Xxtc9WU3EA5gUAJyix8Gbpq//kNw7QeS8GpV4XLqP4J1OWQy1QXo5sNaSavBNy6s6yRI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:181c:b0:705:c24c:70e3 with SMTP id
 d2e1a72fcca58-705c9247ae9mr14937b3a.2.1718230144114; Wed, 12 Jun 2024
 15:09:04 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:09:02 -0700
In-Reply-To: <20240207172646.3981-11-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-11-xin3.li@intel.com>
Message-ID: <ZmocflXIH0UUsFzn@google.com>
Subject: Re: [PATCH v2 10/25] KVM: VMX: Add support for FRED context save/restore
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
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 264378c3b784..ee61d2c25cb0 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1420,6 +1420,24 @@ static void vmx_write_guest_kernel_gs_base(struct vcpu_vmx *vmx, u64 data)
>  	preempt_enable();
>  	vmx->msr_guest_kernel_gs_base = data;
>  }
> +
> +static u64 vmx_read_guest_fred_rsp0(struct vcpu_vmx *vmx)
> +{
> +	preempt_disable();
> +	if (vmx->guest_state_loaded)
> +		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
> +	preempt_enable();
> +	return vmx->msr_guest_fred_rsp0;
> +}
> +
> +static void vmx_write_guest_fred_rsp0(struct vcpu_vmx *vmx, u64 data)
> +{
> +	preempt_disable();
> +	if (vmx->guest_state_loaded)
> +		wrmsrl(MSR_IA32_FRED_RSP0, data);
> +	preempt_enable();
> +	vmx->msr_guest_fred_rsp0 = data;
> +}

This should be unnecessary when you switch to the user return framework.

KERNEL_GS_BASE is a bit special because it needs to be reloaded if the kernel
switches to a different task, i.e. before an exit to userspace.

> @@ -1892,6 +1895,30 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
>  			return 1;
>  
>  		data = (u32)data;
> +		break;
> +	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
> +		if (index != MSR_IA32_FRED_STKLVLS && is_noncanonical_address(data, vcpu))
> +			return 1;
> +		if ((index >= MSR_IA32_FRED_RSP0 && index <= MSR_IA32_FRED_RSP3) &&
> +		    (data & GENMASK_ULL(5, 0)))
> +			return 1;
> +		if ((index >= MSR_IA32_FRED_SSP1 && index <= MSR_IA32_FRED_SSP3) &&
> +		    (data & GENMASK_ULL(2, 0)))
> +			return 1;
> +
> +		if (host_initiated) {
> +			if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
> +				return 1;
> +		} else {
> +			/*
> +			 * Inject #GP upon FRED MSRs accesses from a non-FRED guest,
> +			 * which also ensures no malicious guest can write to FRED
> +			 * MSRs to corrupt host FRED MSRs.
> +			 */

Drop the comment, if someone reading KVM code doesn't grok that attempting to
access MSRs that shouldn't exist results in #GP, then a comment probably isn't
going to save them.

This should also be bumped to the top, i.e. do the "does this exist check" first.

Lastly, the direction we are taking is to NOT exempt host-initiated writes, i.e.
userspace has to set CPUID before MSRs.  If you base the next version on top of
this series, it should just work (and if it doesn't, I definitely want to know):

https://lore.kernel.org/all/20240425181422.3250947-1-seanjc@google.com


> +			if (!guest_can_use(vcpu, X86_FEATURE_FRED))
> +				return 1;
> +		}
> +

Uh, where does the value go?  Oh, this is common code.  Ah, and it's in common
code so that VMX can avoid having to make an extra function call for every MSR.
Neat.

>  		break;
>  	}
>  
> @@ -1936,6 +1963,22 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_RDPID))
>  			return 1;
>  		break;
> +	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
> +		if (host_initiated) {
> +			if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
> +				return 1;
> +		} else {
> +			/*
> +			 * Inject #GP upon FRED MSRs accesses from a non-FRED guest,
> +			 * which also ensures no malicious guest can write to FRED
> +			 * MSRs to corrupt host FRED MSRs.
> +			 */
> +			if (!guest_can_use(vcpu, X86_FEATURE_FRED))
> +				return 1;
> +		}

Same comments here.

