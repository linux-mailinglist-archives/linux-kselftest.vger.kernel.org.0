Return-Path: <linux-kselftest+bounces-8458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD08AB2D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6511F2207C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD333130AEA;
	Fri, 19 Apr 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCVub2YF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8212F59E;
	Fri, 19 Apr 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542840; cv=none; b=ayu0BSjmNpyoWrwY9Ys/tV5AnBKbFnQBTTDWXq4/kcXZzb0XyE8gxeG6iWlEgFnouXRCbf06ZVi1EZbIlrVLpQeHcxuZgm1ahNP0Z51MZ7ZU+t88R5Pqg97xzhmdgbl+hoezUPw8CFtvqCL0uMjLZUl/6UmGdgNImrybdyDDWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542840; c=relaxed/simple;
	bh=Oq+kH3rsAMkyCUdxGA9Qxc/W3YsEaKeWvqdpns5eWeo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SrWCOU1B1bSjX+i/MM69pq1fFBpA2jE5qPaCXfUXf0Vs42FhpCVAGwp8Iw5afJL4X9KW+uMoNSkb1y44rzmLQ3iBlIyRPZ1Y1umLPmxk3Beh7uyO+4eF0bg2a3QWGf8e6VtPzdI6DluVoY25TeCJF3JL0zh3xDHS66R0wDoR3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCVub2YF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-349bf9d46acso1252173f8f.0;
        Fri, 19 Apr 2024 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713542837; x=1714147637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9HpYaBSLWlwQKwAi4O8ISOg7ZxmGCKm/tVCy7QD/uI=;
        b=hCVub2YFFq5DnDX7JZSyMFmx385jfwecHu5NQ52BbjStWgDPqyJWlcyRmubXjq7b+e
         6dBbm6gKGHQ5+QTuANsXNU/P69jASucXkYtZkJmHEHRUtc4IYAkYqT/juT6pc7nwH4lB
         W3PneL99z++bm9IiVB0ra6g+MiGa92eXpc154r0FpkBGfdHpBVZe8vRdKbFJFsIO7+DK
         oqzaqLgYJwKZUQxvEJFN21lPLChOhry+cmTreQC95lSXVro2R5cQWyoAsqpY8hMv9nNF
         ZA/nyXUEANxwg4KAvoa7cPIrYHQExIZdlJ/h22oeHmH3nr2WIL4dO5Vn2Ya4mlP7bpWp
         D+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713542837; x=1714147637;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9HpYaBSLWlwQKwAi4O8ISOg7ZxmGCKm/tVCy7QD/uI=;
        b=IISrSsQOixhayc3jLR+WznAyaQnSmE4DW4eLaKU7iZXi4gFQAMB0O0isDe9VVSN3wS
         dtJSNHPyHJQgybcWIz88qE3/hP3dP3IV7Su0aYfNa9cn+yhhkVRjot/RFU7EDRtWoV4H
         sfKAihJ6e79ySpahbWdlrI13OcbCNeUGQLdwhnPWYJtUAHfnVhIm4kCTAoB6f7q9rY6H
         GRm93S224S1J6P3+kzOTlTcbyl9hcjlUmF7d2EbHRBOLscxARpdtSrQU7Zf+6DYelxl3
         93XjGC8G1Wqlt87Xb5qXF6whylX7+NMblHlcB/yCEbofpvP+H9i3u3ucxZUgCbPWXNZF
         RhAA==
X-Forwarded-Encrypted: i=1; AJvYcCVHNGDxHCj7tzIj8xDxOQ3oFNK/kwfiJN8nz++jandmH108bhngDicQHX2iWZ7h9vVGWcVMBpoZwlUWMutU3Fw3/Xaf9YzlTSGk4WKNqi5mDsuW00uvL4tm6i1akU0GKoDu7xWZw4xmzyfB6i/RZ/QU+T1lJECD1nteg9zarlfrkrA5f23xwpnsw7e2NOuaDtIEJmPouaOl2Q5vEg3V
X-Gm-Message-State: AOJu0YwVOA97EawuQosapiDGQGvj40gvgCpMyTcOqof8ROmsBXsGyLxF
	Ci0nL172h+9u+hENXNhpCRcP8SXIrJa484Fgd1Uo8ycg7I507miA
X-Google-Smtp-Source: AGHT+IH8I9BUHyjbnZ1Fbsld6hhUhaxjdgb4IF2XTsH1z5ctVLubVlfaQRS04I0F5fuqHl+ikS3+JQ==
X-Received: by 2002:adf:e743:0:b0:346:afab:9702 with SMTP id c3-20020adfe743000000b00346afab9702mr1865801wrn.13.1713542837235;
        Fri, 19 Apr 2024 09:07:17 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003456c693fa4sm4733015wrz.93.2024.04.19.09.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 09:07:16 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d7f5f204-0895-44f6-a428-4afd058e8ea4@xen.org>
Date: Fri, 19 Apr 2024 17:07:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 10/10] KVM: x86: Fix KVM clock precision in
 __get_kvmclock()
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
 <20240418193528.41780-11-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-11-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When in 'master clock mode' (i.e. when host and guest TSCs are behaving
> sanely and in sync), the KVM clock is defined in terms of the guest TSC.
> 
> When TSC scaling is used, calculating the KVM clock directly from *host*
> TSC cycles leads to a systemic drift from the values calculated by the
> guest from its TSC.
> 
> Commit 451a707813ae ("KVM: x86/xen: improve accuracy of Xen timers")
> had a simple workaround for the specific case of Xen timers, as it had an
> actual vCPU to hand and could use its scaling information. That commit
> noted that it was broken for the general case of get_kvmclock_ns(), and
> said "I'll come back to that".
> 
> Since __get_kvmclock() is invoked without a specific CPU, it needs to
> be able to find or generate the scaling values required to perform the
> correct calculation.
> 
> Thankfully, TSC scaling can only happen with X86_FEATURE_CONSTANT_TSC,
> so it isn't as complex as it might have been.
> 
> In __kvm_synchronize_tsc(), note the current vCPU's scaling ratio in
> kvm->arch.last_tsc_scaling_ratio. That is only protected by the
> tsc_writE_lock, so in pvclock_update_vm_gtod_copy(), copy it into a

^ typo: capitalization of the 'E'

> separate kvm->arch.master_tsc_scaling_ratio so that it can be accessed
> using the kvm->arch.pvclock_sc seqcount lock. Also generate the mul and
> shift factors to convert to nanoseconds for the corresponding KVM clock,
> just as kvm_guest_time_update() would.
> 
> In __get_kvmclock(), which runs within a seqcount retry loop, use those
> values to convert host to guest TSC and then to nanoseconds. Only fall
> back to using get_kvmclock_base_ns() when not in master clock mode.
> 
> There was previously a code path in __get_kvmclock() which looked like
> it could set KVM_CLOCK_TSC_STABLE without KVM_CLOCK_REALTIME, perhaps
> even on 32-bit hosts. In practice that could never happen as the
> ka->use_master_clock flag couldn't be set on 32-bit, and even on 64-bit
> hosts it would never be set when the system clock isn't TSC-based. So
> that code path is now removed.
> 
> The kvm_get_wall_clock_epoch() function had the same problem; make it
> just call get_kvmclock() and subtract kvmclock from wallclock, with
> the same fallback as before.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/include/asm/kvm_host.h |   4 +
>   arch/x86/kvm/x86.c              | 150 ++++++++++++++++----------------
>   2 files changed, 78 insertions(+), 76 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index cfac72b4aa64..13f979dd14b9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1353,6 +1353,7 @@ struct kvm_arch {
>   	u64 last_tsc_write;
>   	u32 last_tsc_khz;
>   	u64 last_tsc_offset;
> +	u64 last_tsc_scaling_ratio;
>   	u64 cur_tsc_nsec;
>   	u64 cur_tsc_write;
>   	u64 cur_tsc_offset;
> @@ -1366,6 +1367,9 @@ struct kvm_arch {
>   	bool use_master_clock;
>   	u64 master_kernel_ns;
>   	u64 master_cycle_now;
> +	u64 master_tsc_scaling_ratio;
> +	u32 master_tsc_mul;
> +	s8 master_tsc_shift;
>   	struct delayed_work kvmclock_update_work;
>   	struct delayed_work kvmclock_sync_work;
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f870e29d2558..5cd92f4b4c97 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2671,6 +2671,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
>   	kvm->arch.last_tsc_nsec = ns;
>   	kvm->arch.last_tsc_write = tsc;
>   	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
> +	kvm->arch.last_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
>   	kvm->arch.last_tsc_offset = offset;
>   
>   	vcpu->arch.last_guest_tsc = tsc;
> @@ -3006,6 +3007,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
>   {
>   #ifdef CONFIG_X86_64
>   	struct kvm_arch *ka = &kvm->arch;
> +	uint64_t last_tsc_hz;
>   	int vclock_mode;
>   	bool host_tsc_clocksource, vcpus_matched;
>   
> @@ -3025,6 +3027,34 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
>   				&& !ka->backwards_tsc_observed
>   				&& !ka->boot_vcpu_runs_old_kvmclock;
>   
> +	/*
> +	 * When TSC scaling is in use (which can thankfully only happen
> +	 * with X86_FEATURE_CONSTANT_TSC), the host must calculate the
> +	 * KVM clock precisely as the guest would, by scaling through
> +	 * the guest TSC frequency. Otherwise, differences in arithmetic
> +	 * precision lead to systemic drift between the guest's and the
> +	 * host's idea of the time.
> +	 */
> +	if (kvm_caps.has_tsc_control) {
> +		/*
> +		 * Copy from the field protected solely by ka->tsc_write_lock,
> +		 * to the field protected by the ka->pvclock_sc seqlock.
> +		 */
> +		ka->master_tsc_scaling_ratio = ka->last_tsc_scaling_ratio;
> +
> +		/*
> +		 * Calculate the scaling factors precisely the same way
> +		 * that kvm_guest_time_update() does.
> +		 */
> +		last_tsc_hz = kvm_scale_tsc(tsc_khz * 1000,
> +					    ka->last_tsc_scaling_ratio);
> +		kvm_get_time_scale(NSEC_PER_SEC, last_tsc_hz,
> +				   &ka->master_tsc_shift, &ka->master_tsc_mul);
> +	} else if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
> +		kvm_get_time_scale(NSEC_PER_SEC, tsc_khz * 1009,

1009?

> +				   &ka->master_tsc_shift, &ka->master_tsc_mul);
> +	}
> +
>   	if (ka->use_master_clock)
>   		atomic_set(&kvm_guest_has_master_clock, 1);
>   


