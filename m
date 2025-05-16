Return-Path: <linux-kselftest+bounces-33195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDEAB9ED9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3815168F88
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2241A255C;
	Fri, 16 May 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uH3oPosz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FC1A23B9
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406705; cv=none; b=oiREgVV9C8jb+za2TP67ZejZZXZlf+VRtj4u6lT4AuZaBvWK6gQuL7TWIARtxZaHvnCPcuOQLPRSc1OLjfQaM5GjI2iy8FZSf2Kh8pTSvE87oNvuhJd1wKFCzniEBsfegUDTk++urOgefX+kKxEJXWrypIPdld0b0MXprJa9SGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406705; c=relaxed/simple;
	bh=ai4HsUXe8Hf6sgaIpmcQ3fB9qzjUu4+7671cWfxzTsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TvqrpnLBRP3P6fUstSDqAVS/QYtgulbGqUg7nUP4g/1CijfQQqnY+rmYGFk8TeK8N/XMfuIgVRMVzLyci+YxTfmLNRgdHJLTZjrZKsiKVg/PKmeOT/FNGMht/6v5ukgO7+tZL89K95u7Ltp/Dcx/BwoFan8X6AgPDsjC26MIKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uH3oPosz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7370e73f690so2515476b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747406703; x=1748011503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxpWO6d9RGjAdSroDlrJKpnDNm7YQaegewDBnMK2Spc=;
        b=uH3oPosztB48FWUBaOZobTU4C6fJCfrxU1ukw5ExcGD3P1MTmO/z9rK38yiwd3NAqE
         nQj3zIXF5RS9LpfGka2ur2ZMa7WsXFpm3s4x2kDjsxiR6xUmMcRACBbaRRqPajI4zRY6
         Bgl+y6NJAR/cXmCiqUlNTN+O/PEABZWf8yHOaIvW/EA7wJYyJoDMI+MSap1Urzj0CfmE
         n7g01DxrBstx+XiCDeNxWqSUPzM6iXoytAT2qFe8HhPcpa5dsLQleYQjqBqWyELYwVyQ
         mHBQa2rZh6cw1iUxF1zEJHw4euKXj1SGnQp15PCHS8uC66EjIp69sTdurH/5RFjJ3FR4
         5Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406703; x=1748011503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxpWO6d9RGjAdSroDlrJKpnDNm7YQaegewDBnMK2Spc=;
        b=Gc7rtq9vIBbSo4IUfKOQ+yJas3GmvFvM4zWRtI00wtBBW8wE8TgveGjCwVfmL/fnS8
         up4habRmrxXXRBQ4Hzn8/igw6kbmYLPFYIM7A+gCBh6px4MBTydt09WETLI5naB7t8tV
         if+2G+ZqjCtM2yrgiVimtEHaTa/jOx8Xuep8cFOqe1b3x12eqPAtru8Uq9Twc9UeDp+j
         9lEHbPsXOiDNyv6edyVfvMUFJ256oimJk6d93GRxw4dz6lWDhu+XYYaW2/tdnceR2xI+
         t/9KUcJUKkVat59bhu1wkhVT9I3kBx2b3ewyZm8HGDWX9Ho5FPOrgO1n2T+pmni9rCg1
         ilUA==
X-Forwarded-Encrypted: i=1; AJvYcCWbg8kclt+vAX90FByZznOfhHDuZziW1gyKOcAGCEvyBx33oxOWtt6E6W6j/jOowyxOMBhS/ghCgqY3JvvESl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQDWkc0jW5BtqlPhyJnhCGkz2SfTerQIf6Hkn/c1mZQCdZ6rF
	XsNNxJ+L6iSU8Y/9xeuxKxWWQN3Gf6xjV00ksgJDMeVKsygLN/bNElXKjjMh3lW+ly+abJfQd2l
	dK3netg==
X-Google-Smtp-Source: AGHT+IFUIIMoWvWfo/p1yEuFxXr/0VSd/5n+vRtdSY5Ojpq4Jm9/+IMOBJg1hmy8i1Fg/Wi7gFvmjRxoy+4=
X-Received: from pfbdf3.prod.google.com ([2002:a05:6a00:4703:b0:740:41eb:584c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e9b:b0:73e:1e21:b653
 with SMTP id d2e1a72fcca58-742a978e6a3mr5100316b3a.5.1747406702664; Fri, 16
 May 2025 07:45:02 -0700 (PDT)
Date: Fri, 16 May 2025 07:45:01 -0700
In-Reply-To: <aCc_LmORNibXBt8V@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-25-mizhang@google.com>
 <aCc_LmORNibXBt8V@google.com>
Message-ID: <aCdPbZiYmtni4Bjs@google.com>
Subject: Re: [PATCH v4 24/38] KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 16, 2025, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> > Reject PMU MSRs interception explicitly in
> > vmx_get_passthrough_msr_slot() since interception of PMU MSRs are
> > specially handled in intel_passthrough_pmu_msrs().
> > 
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 38ecf3c116bd..7bb16bed08da 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -165,7 +165,7 @@ module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
> >  
> >  /*
> >   * List of MSRs that can be directly passed to the guest.
> > - * In addition to these x2apic, PT and LBR MSRs are handled specially.
> > + * In addition to these x2apic, PMU, PT and LBR MSRs are handled specially.

Except y'all forgot to actually do the "special" handling, vmx_msr_filter_changed()
needs to refresh the PMU MSR filters.  Only the x2APIC MSRs are excluded from
userspace filtering (see kvm_msr_allowed()), everything else can be intercepted
by userespace.  E.g. if an MSR filter is set _before_ PMU refresh, KVM's behavior
will diverge from a filter that is set after PMU refresh.

> >   */
> >  static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
> >  	MSR_IA32_SPEC_CTRL,
> > @@ -691,6 +691,16 @@ static int vmx_get_passthrough_msr_slot(u32 msr)
> >  	case MSR_LBR_CORE_FROM ... MSR_LBR_CORE_FROM + 8:
> >  	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
> >  		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
> > +	case MSR_IA32_PMC0 ...
> > +		MSR_IA32_PMC0 + KVM_MAX_NR_GP_COUNTERS - 1:
> > +	case MSR_IA32_PERFCTR0 ...
> > +		MSR_IA32_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
> > +	case MSR_CORE_PERF_FIXED_CTR0 ...
> > +		MSR_CORE_PERF_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
> > +	case MSR_CORE_PERF_GLOBAL_STATUS:
> > +	case MSR_CORE_PERF_GLOBAL_CTRL:
> > +	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> > +		/* PMU MSRs. These are handled in intel_passthrough_pmu_msrs() */
> >  		return -ENOENT;
> >  	}
> 
> This belongs in the patch that configures interception.  A better split would be
> to have an Intel patch and an AMD patch, 

I take that back, splitting the Intel and AMD logic makes is just as messy,
because the control logic is very much shared between VMX and SVM.

