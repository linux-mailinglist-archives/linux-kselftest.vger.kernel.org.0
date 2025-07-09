Return-Path: <linux-kselftest+bounces-36832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3BAFEE1C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2261C426C5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97C2E8E10;
	Wed,  9 Jul 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQehQtzA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59E28EBFE
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076413; cv=none; b=HragmU0YA+Egceg9uw16gRxekd7bQQ7CXHYLrT2OZcjHY5ie/QXvQ4knSoIefPJe0OGFySCnbftn8PoGR//nobOYaiwaTIRBIlTzoOMMdMXjt1VMwFueY+U2B8bCbRBh+3GJaBa/b5PLKHJtjaYr7mNn5m3VK1xdyyhT+MG8b7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076413; c=relaxed/simple;
	bh=25FMe8x/OW3Lp3qeP0k9f4sApdVqQUoIa/qrXWF7ALg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=abcjnYDGkwe94dxsVRpmcc9hjYWPuntLpoygtn+8UmiaD4HhuelZVeGXpKuywO0P5d9khF9XpHqAkz15e8AG+QznlraLhoM5+Pk5a1n+RiDwSK1VbfJb49U9kpouFxFOh0MrQI9N6EiJKfouLVgvYolk9acpgncVJlNPnXkwNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQehQtzA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3122368d82bso160947a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Jul 2025 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752076411; x=1752681211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTbopsyjLwZagxO+PemAykhJLuXJRZ0JL1WGf/NIPOI=;
        b=sQehQtzA0nyaAE7SI/A6x44LYofxmv/20YzS47mUHxH2mucH37uewhRd5N9L8ycMK8
         eAwPzpPNnkXhUmcuEtZaFbcGZ4+HpI9xHgpfPQ7RBiaSrTq69M5jY53UBHnxUQTeHD8m
         vDPDI2ceDr5gxPcimlmj19mflLloJetLCYdufnn5reGGkPvK8TszT3g/823NR8mqwF2u
         CGS0Wo8KQ515IBVQ86XYIDWjneGrhK7vgDO2iF2yidQl96aNHRggyC4/JEiotFaAAnK0
         PRJN4Bcy/KkmRoWAe85xX8Cdeyubuu+PGVV4FaVDKmEyrD269nW7wyeSVYJfh6XfeqDx
         eoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076411; x=1752681211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTbopsyjLwZagxO+PemAykhJLuXJRZ0JL1WGf/NIPOI=;
        b=BrTSp3YeHnqzM8W0LwPCpesqBVErpEA4SRvr29MiCzBXKd2Ri03khN8O5Tgzyc63sA
         SE5xNW/8zFFdzu1PrvyHEDv8Sr6S7orTSoY3XONYM3OKO2KlovjA57J/YV3cXJ+5GlEq
         OV0fQ0FdViBhkH3dz2wQOuj5ktd0tAc/G8M/Nz17AdvZVNH4SnXSw88/Ctw/0KRMYGJN
         TAxhSJjF07OORX1v2vWSaB0BDOYyrBjXi0RhIvz97cAEAZ0M2HYHwBDkRxgRfmcS+Qvj
         k8OmeTszBXtPZ6umNE+cDxmi9z0lcCWvKxAu5nSP6zJGiFeCyYicqbONJCaAi3OawTs3
         ApVw==
X-Forwarded-Encrypted: i=1; AJvYcCW21d4IIY0lG6w1Ip2SNRVTu1hWWRM0+wIOz2ZL+FzlvLpasoGTcCD73ZE9xQmwrKR6IyTHnx/1VLt6p72lbhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpcp4fiOK/vMBC406CC9PXQ2GG37WeEin2pHWx8gbCNUEV314
	RO9faPbkdhVmNAoeeBvIfl0u5QBDw9omWyY+UYxpQvsWSUn1mdL4WliMA6vkpJH7i0QeMheVRcv
	Oz9XfgQ==
X-Google-Smtp-Source: AGHT+IGjePHxm4yhTC07WPmOQKWcW69yFAbNV3Ly82vKbgJPL+sCUOW7xQYxaSJ26UKg7Zgl6um4WrjHcrM=
X-Received: from pjbpq7.prod.google.com ([2002:a17:90b:3d87:b0:313:17cf:434f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e47:b0:311:ff18:b84b
 with SMTP id 98e67ed59e1d1-31c3c2f3c1amr536725a91.25.1752076411095; Wed, 09
 Jul 2025 08:53:31 -0700 (PDT)
Date: Wed, 9 Jul 2025 08:53:29 -0700
In-Reply-To: <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-21-mizhang@google.com>
 <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com>
Message-ID: <aG6QeTXrd7Can8PK@google.com>
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
From: Sean Christopherson <seanjc@google.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 26, 2025, Sandipan Das wrote:
> > @@ -212,6 +212,18 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
> >  	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
> >  }
> >  
> > +static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
> > +{
> > +	struct vcpu_svm *svm = to_svm(vcpu);
> > +
> > +	__amd_pmu_refresh(vcpu);
> > +
> > +	if (kvm_rdpmc_in_guest(vcpu))
> > +		svm_clr_intercept(svm, INTERCEPT_RDPMC);
> > +	else
> > +		svm_set_intercept(svm, INTERCEPT_RDPMC);
> > +}
> > +
> 
> After putting kprobes on kvm_pmu_rdpmc(), I noticed that RDPMC instructions were
> getting intercepted for the secondary vCPUs. This happens because when secondary
> vCPUs come up, kvm_vcpu_reset() gets called after guest CPUID has been updated.
> While RDPMC interception is initially disabled in the kvm_pmu_refresh() path, it
> gets re-enabled in the kvm_vcpu_reset() path as svm_vcpu_reset() calls init_vmcb().
> We should consider adding the following change to avoid that.

Revisiting this code after the MSR interception rework, I think we should go for
a more complete, big-hammer solution.  Rather than manipulate intercepts during
kvm_pmu_refresh(), do the updates as part of the "common" recalc intercepts flow.
And then to trigger recalc on PERF_CAPABILITIES writes, turn KVM_REQ_MSR_FILTER_CHANGED
into a generic KVM_REQ_RECALC_INTERCEPTS.

That way there's one path for calculating dynamic intercepts, which should make it
much more difficult for us to screw up things like reacting to MSR filter changes.
And providing a single path avoids needing to have a series of back-and-forth calls
between common x86 code, PMU code, and vendor code.

