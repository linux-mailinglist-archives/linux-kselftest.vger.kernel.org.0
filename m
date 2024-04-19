Return-Path: <linux-kselftest+bounces-8442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2708AB224
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B3BB21A10
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C62012FF73;
	Fri, 19 Apr 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOuv7DAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54D127B72;
	Fri, 19 Apr 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541228; cv=none; b=gTyCkhgNZyaaMKOuw3tetApnLUinXTSKrXX74TfTUjpMrKxwRsBGI0mGRHR2KOOaEh3rJ2qtqsGEqgd765CmWT/b0GCeipDCTSDCcVMBBB+Ee7s88Gw+EnbRYeeRcURqrjhg2PXsSVVL8VkFMUJRezvuOcildMldHKieMfJc5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541228; c=relaxed/simple;
	bh=AEa9Db21HYUQoGZhPwjxKDITrfhTcZ6zba7+bIZ3STk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xaq3/QkbQ001+Tb6I3f64n6758wkG+5WLIWwp7CPV3U5tWEpsB6BnaAZmkt6fr22lzcpzxs490oCxqrdmwwaFXaHgE8hcIZJ1NRFzBtALluPL2ejqAs7lm50+nftwFxv5sDk4sG7STQSmpuDUoPJ69YDm39ZSyz8kNv+kIlnfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOuv7DAV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-418c2bf2f55so16228585e9.2;
        Fri, 19 Apr 2024 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541225; x=1714146025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPOI4f3jBnuy6s0MKt8vEVdK8XbKNvqKvZPjyoowk0Q=;
        b=jOuv7DAVl9d7YLwN+rpwJiYvRwXkefZvseFxnxWt65EBdGtMfRkP8AsHKlkriYMSfx
         0vLd9OIbQd895aVDS8dNymkll/87QHQSKblt42pl617wh4+O+UPKd2rmC/W7Yc0IBOO1
         zNAEdT+FAsrKOmXGIyxE2RJjKZI5RnlajFWLVhE3y+835n98aPpTqcmAiAT/dWkCq5ib
         VQMiSVFupQjnl55WmNPoLLqOpzgSiaK+WoTZ0vDLARp9YB6roUqEA3PfVxGMzB9onSbh
         7/ojZe/CafKPNMJM4uWbSfpF5fGkfM97QwP5cYAOEowMh4q6x3HpiV8zaSvMoVdks4Ga
         kDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541225; x=1714146025;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPOI4f3jBnuy6s0MKt8vEVdK8XbKNvqKvZPjyoowk0Q=;
        b=c98H4e+qkfvLa7cuXI70A+bQggAKhk8fIs0/s4TlFYfSxqNt/ArTsKwTUusis/oSZp
         ak5+a+rLdCWKkUen/DHpmpI1CPNs7l2WOwVQuAvLv05OsB7K0NSZngIwllffeeApT5tJ
         fDndfamL1MhNRJvbg5TakhdZEZDQGz1FSPY3kZ7xWIZPzt/U67QXIXcvjFJdp6bUSmGq
         F/b20YPOROW72QaONMonl39dwXSkubWqAXWNfUXJAQqy7QIJf90C1rUigMWYXOTm+QM3
         YbjseoiumsZ4Kyf0YLF8Rq/kwf72HT2N34XPfRG6IwFv7Nqa6sQULD3GvjGlKj+m6xQl
         UgpA==
X-Forwarded-Encrypted: i=1; AJvYcCXSLAYvxpO079rmBQCB+nVSCtcJ0EZ5N11qohEZOa4tTGJg8gocyqT2WV3Epp84qB1cy4f+aRlyCQn9g0QRMVHa7EzDJ+b34G/4c5GHdtDXja5w8mHFF1iifCphdt3YRKbEUsStgJza73rxmGqoUDerRhGXFfn0Nxpm+1zIfcFGwfXQG7/VuHHVSPPW6xpQQivwy6psWUzFAOoDZOGR
X-Gm-Message-State: AOJu0YzBazFbHgZuwyLnoFgSNhE1GMhqavgG+iD9PC1H0hD7Lzmti4q3
	kWA281ewdYHow2ZyA95oHVa2xcy5ITCfzLckyXWlXkN0dppQZ24C
X-Google-Smtp-Source: AGHT+IEJFRsh9CvoX43K871m/lDU7m2JK6yrjHyhdC7aUpB37ShRaAvsfj1b9O46sPDf2LBsXi82uw==
X-Received: by 2002:a05:600c:1e25:b0:419:cf15:f3af with SMTP id ay37-20020a05600c1e2500b00419cf15f3afmr361412wmb.25.1713541225326;
        Fri, 19 Apr 2024 08:40:25 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b0041884b79b81sm6868526wmq.1.2024.04.19.08.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:40:25 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <9985611d-1e0b-48f3-8eb5-fc3e1279b5a5@xen.org>
Date: Fri, 19 Apr 2024 16:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 03/10] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate
 KVM clock migration
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>, Marcelo Tosatti
 <mtosatti@redhat.com>, jalliste@amazon.co.uk, sveith@amazon.de
References: <20240418193528.41780-1-dwmw2@infradead.org>
 <20240418193528.41780-4-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: Jack Allister <jalliste@amazon.com>
> 
> In the common case (where kvm->arch.use_master_clock is true), the KVM
> clock is defined as a simple arithmetic function of the guest TSC, based on
> a reference point stored in kvm->arch.master_kernel_ns and
> kvm->arch.master_cycle_now.
> 
> The existing KVM_[GS]ET_CLOCK functionality does not allow for this
> relationship to be precisely saved and restored by userspace. All it can
> currently do is set the KVM clock at a given UTC reference time, which is
> necessarily imprecise.
> 
> So on live update, the guest TSC can remain cycle accurate at precisely the
> same offset from the host TSC, but there is no way for userspace to restore
> the KVM clock accurately.
> 
> Even on live migration to a new host, where the accuracy of the guest time-
> keeping is fundamentally limited by the accuracy of wallclock
> synchronization between the source and destination hosts, the clock jump
> experienced by the guest's TSC and its KVM clock should at least be
> *consistent*. Even when the guest TSC suffers a discontinuity, its KVM
> clock should still remain the *same* arithmetic function of the guest TSC,
> and not suffer an *additional* discontinuity.
> 
> To allow for accurate migration of the KVM clock, add per-vCPU ioctls which
> save and restore the actual PV clock info in pvclock_vcpu_time_info.
> 
> The restoration in KVM_SET_CLOCK_GUEST works by creating a new reference
> point in time just as kvm_update_masterclock() does, and calculating the
> corresponding guest TSC value. This guest TSC value is then passed through
> the user-provided pvclock structure to generate the *intended* KVM clock
> value at that point in time, and through the *actual* KVM clock calculation.
> Then kvm->arch.kvmclock_offset is adjusted to eliminate for the difference.
> 
> Where kvm->arch.use_master_clock is false (because the host TSC is
> unreliable, or the guest TSCs are configured strangely), the KVM clock
> is *not* defined as a function of the guest TSC so KVM_GET_CLOCK_GUEST
> returns an error. In this case, as documented, userspace shall use the
> legacy KVM_GET_CLOCK ioctl. The loss of precision is acceptable in this
> case since the clocks are imprecise in this mode anyway.
> 
> On *restoration*, if kvm->arch.use_master_clock is false, an error is
> returned for similar reasons and userspace shall fall back to using
> KVM_SET_CLOCK. This does mean that, as documented, userspace needs to use
> *both* KVM_GET_CLOCK_GUEST and KVM_GET_CLOCK and send both results with the
> migration data (unless the intent is to refuse to resume on a host with bad
> TSC).
> 
> (It may have been possible to make KVM_SET_CLOCK_GUEST "good enough" in the
> non-masterclock mode, as that mode is necessarily imprecise anyway. The
> explicit fallback allows userspace to deliberately fail migration to a host
> with misbehaving TSC where master clock mode wouldn't be active.)
> 
> Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> CC: Paul Durrant <paul@xen.org>
> CC: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   Documentation/virt/kvm/api.rst |  37 ++++++++
>   arch/x86/kvm/x86.c             | 156 +++++++++++++++++++++++++++++++++
>   include/uapi/linux/kvm.h       |   3 +
>   3 files changed, 196 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index f0b76ff5030d..758f6fc08fe5 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6352,6 +6352,43 @@ a single guest_memfd file, but the bound ranges must not overlap).
>   
>   See KVM_SET_USER_MEMORY_REGION2 for additional details.
>   
> +4.143 KVM_GET_CLOCK_GUEST
> +----------------------------
> +
> +:Capability: none
> +:Architectures: x86_64
> +:Type: vcpu ioctl
> +:Parameters: struct pvclock_vcpu_time_info (out)
> +:Returns: 0 on success, <0 on error
> +
> +Retrieves the current time information structure used for KVM/PV clocks,
> +in precisely the form advertised to the guest vCPU, which gives parameters
> +for a direct conversion from a guest TSC value to nanoseconds.
> +
> +When the KVM clock not is in "master clock" mode, for example because the
> +host TSC is unreliable or the guest TSCs are oddly configured, the KVM clock
> +is actually defined by the host CLOCK_MONOTONIC_RAW instead of the guest TSC.
> +In this case, the KVM_GET_CLOCK_GUEST ioctl returns -EINVAL.
> +
> +4.144 KVM_SET_CLOCK_GUEST
> +----------------------------
> +
> +:Capability: none
> +:Architectures: x86_64
> +:Type: vcpu ioctl
> +:Parameters: struct pvclock_vcpu_time_info (in)
> +:Returns: 0 on success, <0 on error
> +
> +Sets the KVM clock (for the whole VM) in terms of the vCPU TSC, using the
> +pvclock structure as returned by KVM_GET_CLOCK_GUEST. This allows the precise
> +arithmetic relationship between guest TSC and KVM clock to be preserved by
> +userspace across migration.
> +
> +When the KVM clock is not in "master clock" mode, and the KVM clock is actually
> +defined by the host CLOCK_MONOTONIC_RAW, this ioctl returns -EINVAL. Userspace
> +may choose to set the clock using the less precise KVM_SET_CLOCK ioctl, or may
> +choose to fail, denying migration to a host whose TSC is misbehaving.
> +
>   5. The kvm_run structure
>   ========================
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 23281c508c27..42abce7b4fc9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5868,6 +5868,154 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>   	}
>   }
>   
> +#ifdef CONFIG_X86_64
> +static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __user *argp)
> +{
> +	struct pvclock_vcpu_time_info *hv_clock = &v->arch.hv_clock;
> +
> +	/*
> +	 * If KVM_REQ_CLOCK_UPDATE is already pending, or if the hv_clock has
> +	 * never been generated at all, call kvm_guest_time_update() to do so.
> +	 * Might as well use the PVCLOCK_TSC_STABLE_BIT as the check for ever
> +	 * having been written.
> +	 */
> +	if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, v) ||
> +	    !(hv_clock->flags & PVCLOCK_TSC_STABLE_BIT)) {
> +		if (kvm_guest_time_update(v))
> +			return -EINVAL;

nit: simple nested if, so you could use &&

> +	}
> +
> +	/*
> +	 * PVCLOCK_TSC_STABLE_BIT is set in use_master_clock mode where the
> +	 * KVM clock is defined in terms of the guest TSC. Otherwise, it is
> +	 * is defined by the host CLOCK_MONOTONIC_RAW, and userspace should
> +	 * use the legacy KVM_[GS]ET_CLOCK to migrate it.
> +	 */
> +	if (!(hv_clock->flags & PVCLOCK_TSC_STABLE_BIT))
> +		return -EINVAL;
> +
> +	if (copy_to_user(argp, hv_clock, sizeof(*hv_clock)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +

Reviewed-by: Paul Durrant <paul@xen.org>


