Return-Path: <linux-kselftest+bounces-9229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C903B8B8F41
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04AD0B218CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F6146D60;
	Wed,  1 May 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCCD4AZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416C748D;
	Wed,  1 May 2024 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586159; cv=none; b=GQ5arNIIaO5/Zqtcogc1N4ru8WuPo5DIfrVVyqo1NjSLm1cUNOS7aLiZ/eBaY4FRXqpCqQe51tLu40CRqo5EU0fSijY4QJOmDTRBQ1Q5UxWKh9lwlwu+o4ANQo2WX8bt1QAVNlYaByuWGK3VfJQmFoCgyv5RtX0hEUZikp7u5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586159; c=relaxed/simple;
	bh=ImsoO37LmIyxcjfq9GfK3cKoACG+YHaB+w+naaUo6Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcdYb3w1ufVHzaz+XoW7JkksLHYkfADravCF0VITV15A0HCmtr6lB4pAENIOJinl4bFp7+fAGULnXEi/YDiWdBYCgPdFG7ZQ5rxBQ48hbJee+/ZH3oAU6rOHI/W5kU9nXrQDKli6KvzLGRRwpatRW3P92d6NhCDR3HDi08lhd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCCD4AZV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714586158; x=1746122158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ImsoO37LmIyxcjfq9GfK3cKoACG+YHaB+w+naaUo6Rc=;
  b=oCCD4AZVluDNgtK8Q06y6mGOUX82+UpJWc8Wls3ttzpAAQPz7LXqInbf
   wvh+cCuVBplvrZhH3ptZOYaNmn9aUh0g3uTY+ArXInmKv5PEBRT68kSFJ
   MiJrAkrXru0JiHxuYfdC3vW3XKp0ck0Ip64Is4nuwWWxHrMc0prY9AvDo
   2T7Oh30vCVLPr1WhMth9Z9YKLf7+fV3kcmgx0OTksEN8ZxAb+x1bo0XhZ
   NFzFped9EblFeyPlYZbZC/24M45FB4TY5BW8BCcymA95aFDwq4ETH4Ofb
   pkYMUUPJOmRt7ui2ux1a2UWNuBevyOFwaF+o02EoxivUKa+aIObcuMKTG
   w==;
X-CSE-ConnectionGUID: jA7c0FJbTJaUZLK8G5Y/0w==
X-CSE-MsgGUID: xnm3Mn8XRWe1GWyq1ggQ4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="35714918"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="35714918"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 10:55:45 -0700
X-CSE-ConnectionGUID: fA5cYtbySBK+URiVZ2UYqQ==
X-CSE-MsgGUID: sl7aHpoRT0mXP/c6i7u+8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31663564"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.57]) ([10.24.10.57])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 10:55:44 -0700
Message-ID: <d788bdab-91b9-4034-a241-ee253ee4fb3e@intel.com>
Date: Wed, 1 May 2024 10:55:46 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] KVM: x86: Factor out kvm_use_master_clock()
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Paul Durrant
 <paul@xen.org>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>, Marcelo Tosatti
 <mtosatti@redhat.com>, jalliste@amazon.co.uk, sveith@amazon.de,
 Dongli Zhang <dongli.zhang@oracle.com>
References: <20240427111929.9600-1-dwmw2@infradead.org>
 <20240427111929.9600-16-dwmw2@infradead.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240427111929.9600-16-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/27/2024 4:05 AM, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Both kvm_track_tsc_matching() and pvclock_update_vm_gtod_copy() make a
> decision about whether the KVM clock should be in master clock mode.
> 
> They use *different* criteria for the decision though. This isn't really
> a problem; it only has the potential to cause unnecessary invocations of
> KVM_REQ_MASTERCLOCK_UPDATE if the masterclock was disabled due to TSC
> going backwards, or the guest using the old MSR. But it isn't pretty.
> 
> Factor the decision out to a single function. And document the historical
> reason why it's disabled for guests that use the old MSR_KVM_SYSTEM_TIME.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/x86.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d6e4469f531a..680b39f17851 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2518,6 +2518,27 @@ static inline bool gtod_is_based_on_tsc(int mode)
>  }
>  #endif
>  
> +static bool kvm_use_master_clock(strut kvm *kvm)

typo: 'strut' -> 'struct'

> +{
> +	struct kvm_arch *ka = &kvm->arch;
> +
> +	/*
> +	 * The 'old kvmclock' check is a workaround (from 2015) for a
> +	 * SUSE 2.6.16 kernel that didn't boot if the system_time in
> +	 * its kvmclock was too far behind the current time. So the
> +	 * mode of just setting the reference point and allowing time
> +	 * to proceed linearly from there makes it fail to boot.
> +	 * Despite that being kind of the *point* of the way the clock
> +	 * is exposed to the guest. By coincidence, the offending
> +	 * kernels used the old MSR_KVM_SYSTEM_TIME, which was moved
> +	 * only because it resided in the wrong number range. So the
> +	 * workaround is activated for *all* guests using the old MSR.
> +	 */
> +	return ka->all_vcpus_matched_tsc &&
> +		!ka->backwards_tsc_observed &&
> +		!ka->boot_vcpu_runs_old_kvmclock;
> +}
> +
>  static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
>  {
>  #ifdef CONFIG_X86_64
> @@ -2550,7 +2571,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
>  	 * To use the masterclock, the host clocksource must be based on TSC
>  	 * and all vCPUs must have matching TSC frequencies.
>  	 */
> -	bool use_master_clock = ka->all_vcpus_matched_tsc &&
> +	bool use_master_clock = kvm_use_master_clock(kvm) &&

'kvm' should be `vcpu->kvm`

>  				gtod_is_based_on_tsc(gtod->clock.vclock_mode);

