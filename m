Return-Path: <linux-kselftest+bounces-33123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE3AB8FEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05286A07A4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A792296D32;
	Thu, 15 May 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZZUbgmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7670291144
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336958; cv=none; b=SIBxxqA1DJql3dBz9MNJfaXk2itJwwNxm658A8MMrE71DHZX7PnFJQgaZ+7DhNy/9mv6dJhqhrZe9e9YNj2+Am3g8lYlCUfPVd3V6ROXsD02Tfox9hvHFbth/eE74qvr7DSGzD5h/cccgaC8yIb/9luonDjoVwj/VZmoFUdyIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336958; c=relaxed/simple;
	bh=n/zFpZcSE3pHysd3m2Fzk6M3YtGyO7I2EMnhWkGrCfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tqHa8ya74My2KhAujDE7/fUmAxR4H96eXq4ntf3AnNLUOedH55YKSabCodYa2HVdNuSvGtHKichY3cNKy81YFrGl3n5vH3u/k2zBahELRZJFkNr3wRdJNLQPEVs1F8MrKVhlwVvWqmUvTB8GloDCUiEW7tpnLBc3CvlsEEZs0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZZUbgmi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e6980471cso648907a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747336956; x=1747941756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsH88TGnmmzXVwjGCgEyBwwNTaWeRBTEOp0jZumImFs=;
        b=eZZUbgmiYW0vylFODHBMRmmPc6OUmE4FhZ/I38EbZoILEJ1AM5XO7Y35+xEvMWQu3S
         w/5pZ2PpLviL864sfGGpgXgYmRXMZZXNhjWHs/YvP/Uwd/7QIsDI0tSDGJKO4Cn05+5B
         BEUGERymdqUzqpoQhCRm/m2AQ693tU9diX+DPoxnjjHYTLPI0faLSxiQaPmaj1vy3/Aq
         C5D16hM8TBW44tH7lqRTbBXgam4hcU4iH8zsuGxxsS67AbYTpnGqvZ+IvGL1QNfRBTPt
         Omg1/pIiNM3syUSKmWHqrYr7rfLNTX67VolLt6TJi65fFHwVo6FWcuzAKvj80A+0A+/T
         djrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747336956; x=1747941756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsH88TGnmmzXVwjGCgEyBwwNTaWeRBTEOp0jZumImFs=;
        b=RYoAzxyXV9ELZCKWJR/3UoBTL/cm6u6qUldbcRiFd3+4mhKP3Vf5Hm6dTu7tHYub6w
         ss1Ncl3LI3H2gaR50j0+B23qYLqLdPPRWtlswMxtRZWRieeifjkDBF3TwEvydCAWS1ll
         aPi+xi7gt5+P7723W1rdrwcYDSfN3lXElyeHSuc1txSNQJgklq4BxKxPXefYfnDEibXl
         Hs9Eawj55P1iYc1/PCbJ84Nj0pR3HuGlisn6gq7V/Ab1eqO/hHDVKQIKhJrTV9iuzyYl
         tQbfCzRlm76m4X434xGHi3laxX0b1QU6aq/sXDEECrCUmnqwzdTG429CUG3WKQ2Zvs3q
         lRSg==
X-Forwarded-Encrypted: i=1; AJvYcCVnAn6pXO7O06GTUhfu2mSIPijXCvGN5tOHlnFyuiX8oPCh/S9c6IvRCGw89JrYFlh0uYis/oq89Gz8YvakM5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcM/zqNnwC2C2U/PwpV48ELdBLk26ey7nM77K8V+10Vjzoavs
	7mYJ9iaVksbDep+qAnSpW5uVIz8DSX5mMQmvPLl7KmDDCUFyfDb6LKJkir3FoDgUjXQJaKnXNJo
	eSStK9w==
X-Google-Smtp-Source: AGHT+IEkfeMKuOwaJhTC9ck1pxVfS9tzvvlzT27Kir8dDv5v2Oq1JjDHX75C4sK4dLAARhXjrxD8V6GQF+g=
X-Received: from pjbdj3.prod.google.com ([2002:a17:90a:d2c3:b0:30e:7783:edb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e42:b0:2f5:88bb:118
 with SMTP id 98e67ed59e1d1-30e7d5aca5cmr609980a91.22.1747336955985; Thu, 15
 May 2025 12:22:35 -0700 (PDT)
Date: Thu, 15 May 2025 12:22:32 -0700
In-Reply-To: <41821a66-8db1-42f1-85d6-fde67a8c072e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-23-mizhang@google.com>
 <aCU3Ri0iz0aDBDup@google.com> <41821a66-8db1-42f1-85d6-fde67a8c072e@linux.intel.com>
Message-ID: <aCY--A8SY7GQuq4F@google.com>
Subject: Re: [PATCH v4 22/38] KVM: x86/pmu: Optimize intel/amd_pmu_refresh() helpers
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 15, 2025, Dapeng Mi wrote:
> On 5/15/2025 8:37 AM, Sean Christopherson wrote:
> >> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> >> index 153972e944eb..eba086ef5eca 100644
> >> --- a/arch/x86/kvm/svm/pmu.c
> >> +++ b/arch/x86/kvm/svm/pmu.c
> >> @@ -198,12 +198,20 @@ static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
> >>  	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
> >>  					 kvm_pmu_cap.num_counters_gp);
> >>  
> >> -	if (pmu->version > 1) {
> >> -		pmu->global_ctrl_rsvd = ~((1ull << pmu->nr_arch_gp_counters) - 1);
> >> +	if (kvm_pmu_cap.version > 1) {

ARGH!!!!!  I saw the pmu->version => kvm_pmu_cap.version change when going through
this patch, but assumed it was simply a refactoring bug and ignored it.

Nope, 100% intentional, as I discovered after spending the better part of an hour
debugging.  Stuffing pmu->global_ctrl when it doesn't exist is necessary when the
mediated PMU is enabled, because pmu->global_ctrl will always be loaded in hardware.
And so loading '0' means the PMU is effectively disabled, because KVM disallows the
guest from writing the MSR.

_That_ is the type of thing that absolutely needs a comment and a lengthy explanation
in the changelog.

Intel also needs the same treatment for PMU v1.  And since there's no hackery that
I can see, that suggests PMU v1 guests haven't been tested with the mediated PMU
on Intel.

I guess congratulations are in order, because this patch just became my new goto
example of why I'm so strict about on the "one thing per patch" rule.

> > It's not just global_ctrl.  PEBS and the fixed counters also depend on v2+ (the
> > SDM contradicts itself; KVM's ABI is that they're v2+).
> >
> >> +		/*
> >> +		 * At RESET, AMD CPUs set all enable bits for general purpose counters in
> >> +		 * IA32_PERF_GLOBAL_CTRL (so that software that was written for v1 PMUs
> >> +		 * don't unknowingly leave GP counters disabled in the global controls).
> >> +		 * Emulate that behavior when refreshing the PMU so that userspace doesn't
> >> +		 * need to manually set PERF_GLOBAL_CTRL.
> >> +		 */
> >> +		pmu->global_ctrl = BIT_ULL(pmu->nr_arch_gp_counters) - 1;
> >> +		pmu->global_ctrl_rsvd = ~pmu->global_ctrl;
> >>  		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
> >>  	}

