Return-Path: <linux-kselftest+bounces-19663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F98199D43C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49D61F22DC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7F51AD9C3;
	Mon, 14 Oct 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rGJXj3A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890A1AB53A
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922012; cv=none; b=oTT3tVtKYHsV5jsDCK11TL5k+KW8REjKkmnNa/wdDagJqP85i2SdBMjq3j6+OwumAn+1TnTbWtOLbJSX9uRYFV35Kg2IhZ2KmtklASh2cGvE84Y1Hl2v+87jV/0IPrMGKeP7AXvyb8H1WuECBqsBF3iDMOJhxha8pomZMVVR8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922012; c=relaxed/simple;
	bh=iN8WovyFuRjSwZJv2FDucbCFOnu8NqKRhx7jU5eDsVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RQ5WBtdOUKy5AbdTJSrPUtj0YMIkieUrQT8xlXVQxtOthfbJNbvH1TZbww20FNBVAgniKHM/Mxh6+Fs5Kk+ahWx8ycUgaX8oqXyjP+lwC6V/vsiKPU6ULuwfxSAYXjRK3qI1KnXoDHtTB8FzfuUtzXC9hyCYUGQqaa5/gm25AlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rGJXj3A; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea8baba4d5so1459854a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728922010; x=1729526810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwSWZjQ27GxDWRHISycf7nMSxcYhNRFFhPOH/5On2AI=;
        b=0rGJXj3Ag4SgTRCsF6tb2TjcEwfmK9a8Ig0yUPHKiRFniqsvIfjWfSeDTfDAaDv/EW
         bLCejfmL0psrvhBXDY2xw/POPXGJZuEWjZ5cxBfvYML7BL3y28zOAN/vjMHwTdpExqAC
         HfmpJBXGCFxFsp4opSIOXthzeswr+B/YSGJAkuZ+AVuq/W6g7hZvzlNwcjsK5CPchfIs
         BD9SHbttegA7h4tEdMkFoUF5Lm9u810SqjyDde+xBE8qRUAZJpYTUcpJnvvFQ/PBt0gY
         +lybEbAHjNr51Ot4PeDRoawZSFH582/tYLquGOtHsoIdkuKbRa1AXc5zdgxO6l4bgBGZ
         C6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922010; x=1729526810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwSWZjQ27GxDWRHISycf7nMSxcYhNRFFhPOH/5On2AI=;
        b=tVDrwNAqvjqvkH+7R3NNwYcadhF9uXg7rPz/P91EZjBhOyv7G/gw31gXoX/KCbcMlk
         9h59WdyVoRXPPnpal6XX1rJEyUCKBuULruHAXLKSeaY0wZpvNqAfgymxMNJuhvfLYdC1
         z5CfFZfJt9bCSUUXdkIcm+AS8tnOWXG8N8+PtedqeZuS5n5uTYj/KEd95Q1vk55ckWA3
         vsdsM5Hc2HKkyEFO7pgN6MejRm1AMvXAQtvXxb/XlYxhPlyp/JXvOuL3TvPNqv8crvbs
         7joLtiQYFX7IG1ueUQLZDAb90YJlr0LsNuYk81lvU+EC6nOTRDGe0yTIFTkxLyhtnw3B
         VlIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsaJbVOUG6/PQ0VuSqPZpySZPFgI9p0KbXJQtT/AEYgjl3m2+v05oWirr/03+f1e5wGnnDMeW9p8YHTB/CbWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rhbExPViMeN55PBxd+WNV4KP124uoEo1T1CNd5HH6BNUrAOA
	XJUHGdCA9h5K9MmSJ5lp3jyUTRm/tdMX92LC+yMs9hs/Wr7NjB0N1PPLI+IDMFBWBPYeqY4iSAB
	QMw==
X-Google-Smtp-Source: AGHT+IEwjwfWJSyr0D7btX97mpAtj9F5UTed1EZBw/lMmbFEbnas4u3vHagJykzf8XQHofrX4lrNygFFlNk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5d0:b0:20b:861a:25d4 with SMTP id
 d9443c01a7336-20ca1460029mr661295ad.5.1728922010162; Mon, 14 Oct 2024
 09:06:50 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:06:48 -0700
In-Reply-To: <20241014105124.24473-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014105124.24473-1-adrian.hunter@intel.com> <20241014105124.24473-3-adrian.hunter@intel.com>
Message-ID: <Zw1BcYhTxZS4E2O5@google.com>
Subject: Re: [PATCH V13 02/14] KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
From: Sean Christopherson <seanjc@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, mizhang@google.com, 
	kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

"KVM: VMX:" for the scope.

And I would much prefer to actually state what is changing.  "Fix XYZ" isn't
helpful in understanding what's actually broken, fallout from the bug, etc.  It's
never easy to describe bugs where the logic is flat out busted, but I think we can
at least capture the basic gist, and allude to the badness being a wrongly disallowed
write.

On Mon, Oct 14, 2024, Adrian Hunter wrote:
> Fix KVM IA32_RTIT_CTL MSR validation logic so that if RTIT_CTL_TRACEEN
> bit is cleared, then other bits are allowed to change also. For example,
> writing 0 to IA32_RTIT_CTL in order to stop tracing, is valid.

There's a fair amount of extraneous and disctracting information in both the shortlog
and changelog.  E.g. "Intel PT IA32_RTIT_CTL MSR" can simply be MSR_IA32_RTIT_CTL.
And the 

I'll fix up to the below when applying; AFAICT, this fix is completely independent
of the rest of the series.

KVM: VMX: Allow toggling bits in MSR_IA32_RTIT_CTL when enable bit is cleared

  Allow toggling other bits in MSR_IA32_RTIT_CTL if the enable bit is being
  cleared, the existing logic simply ignores the enable bit.  E.g. KVM will
  incorrectly reject a write of '0' to stop tracing.
  
> Fixes: bf8c55d8dc09 ("KVM: x86: Implement Intel PT MSRs read/write emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1a4438358c5e..eaf4965ac6df 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1635,7 +1635,8 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
>  	 * result in a #GP unless the same write also clears TraceEn.
>  	 */
>  	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
> -		((vmx->pt_desc.guest.ctl ^ data) & ~RTIT_CTL_TRACEEN))
> +	    (data & RTIT_CTL_TRACEEN) &&
> +	    data != vmx->pt_desc.guest.ctl)
>  		return 1;
>  
>  	/*
> -- 
> 2.43.0
> 

