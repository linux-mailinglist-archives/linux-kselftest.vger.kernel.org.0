Return-Path: <linux-kselftest+bounces-33477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16247ABFCF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E33BD86F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400828F514;
	Wed, 21 May 2025 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRYOmvSS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07F289E1F
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853009; cv=none; b=qSlIeLRF/Sthv6S4pZt/H3CCL5qZrCjgXezkU+COaaPaDGGka/aPkm6Q/8cdmwQAqqcCcU9GioBZXZ5nAbexj9S11GSgouCkFfSJ8koVSCPb2XE4CwFtz2DWOh+OzJnablMQFC5WAzKcXKAWYc59t7L899X+DeX2vBVXKq9JcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853009; c=relaxed/simple;
	bh=l9hm75yhfpKOgU+9IKCqQB1osT3ELi9nMlq987rTA8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJb562CnZJ1kqJqTarla2gw2sOqFBLuxOeJ6d7qOVAt9Dqdlj5nMRpqjxNgcDak4GyunLii6MuazeE644jCw86rNOoF2yD6oP2uckFsqLlBnN5SXIk+LA0Z7mG7/WBoPnojHNjEReZ+q/5uOYgCaq2yeeEYKbqucsaR6HFw/2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRYOmvSS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e895056f0so7295384a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 11:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747853007; x=1748457807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uvnzAtGqqihUzW/r4zpFQWHLi2txWfCNzgNR6sDzto=;
        b=NRYOmvSStwUW2BHH+mDk5SgLEjhPit5UPdgYXm3djeBThxgRPjxyJQQ+QnjYtKhTu1
         j2yjE4xkpjSYoUrL83vNn+p4l7givh5wjSt9dqkQXbJqq/BficW0Iof7nDtvUgp7kixP
         ZMjyj/EzuTlWbmAzq8yk3ut9V4SdB5tI/Zxb3vLzKGscRtrjA3HpyMjYDr9f2X2+xVc0
         eemrUYPX+eWmOF7fG4lxRe+q4uYelo35Bc7Xze/NOLrF0EUzpFtS8JL/Djm57vKKUXqL
         zMuySh+cUo6hmhjPKuuGJOqppRj4yR85H4ZUdtTi5d9F6wwY7bUBa7f2NlWCQVMlEung
         n9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747853007; x=1748457807;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1uvnzAtGqqihUzW/r4zpFQWHLi2txWfCNzgNR6sDzto=;
        b=CTGzN7lTcqyiqzkQudPr6m324VSbDvZy6pQBUp9HE+ivlrXFxZ7VNrIxbjXZh+1RTN
         iKEdovSFhtuELymO7lmPVs5t7UsEpdnxr18znLefE0ZiWA8l+I4rmIumF/S4QKhT6xzb
         AwGVZmhTAGC3nAp/zur94dqXIwY4WqhuM7o0Q0NN92NmeC7zSo/VPjDO2h4Pxmg/Iv2b
         01klRyfaz2d6CFMcoC0JfRV8j92nyFsvFFaCaOuYGEg9xQob7XV02FaVHRB/3S8sLtqb
         m5HFfq/97G+dWgTBpb3Bt0fThVOYJ4pRFZg+uLr0cj9UABiUMzcjp5WLd7GKvM7hkpaE
         c/YA==
X-Forwarded-Encrypted: i=1; AJvYcCVuk0BiQnstEs175xCdIHTrFLujSuj5aAcz442y7mPj/Vh+0dPnT5nFcYo0vDc+1ACoKhoEi8oqI31niRD8fl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MWGMS6eTFEJvw+ogmhbq2m6uVFfvDqHYtxDnvvC7nFePcasJ
	c3CjOn+CI/GP0V/hfUWVue7hwVzDLbyaxJgTOtapr1Uk5GsvbIG4HtmP8/aS+uUhAXOddHVxMsH
	WF9U5hQ==
X-Google-Smtp-Source: AGHT+IGncHV/5i3Y3ABZHLp8TXbERrxZ+ADd5PUtj9jxbItkw8Bb/dtD2z+ZUy9jx9X+TqnA9jiY57WslHY=
X-Received: from pjtu7.prod.google.com ([2002:a17:90a:c887:b0:2ea:29de:af10])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c09:b0:310:8d9a:95b6
 with SMTP id 98e67ed59e1d1-3108d9ae7eemr5602447a91.25.1747853007278; Wed, 21
 May 2025 11:43:27 -0700 (PDT)
Date: Wed, 21 May 2025 11:43:25 -0700
In-Reply-To: <1d024d71-0b02-4481-a0d4-f1786313c1e7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-15-mizhang@google.com>
 <aCUwvXPKD0ANKFb7@google.com> <1d024d71-0b02-4481-a0d4-f1786313c1e7@linux.intel.com>
Message-ID: <aC4ezRH8msD6yUhC@google.com>
Subject: Re: [PATCH v4 14/38] KVM: x86/pmu: Introduce enable_mediated_pmu
 global parameter
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025, Dapeng Mi wrote:
> On 5/15/2025 8:09 AM, Sean Christopherson wrote:
> > On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> >> +	return vcpu->kvm->arch.enable_pmu &&
> > This is superfluous, pmu->version should never be non-zero without the =
PMU being
> > enabled at the VM level.
>=20
> Strictly speaking, "arch.enable_pmu" and pmu->version doesn't indicates
> fully same thing.=C2=A0 "arch.enable_pmu" indicates whether PMU function =
is
> enabled in KVM, but the "pmu->version" comes from user space configuratio=
n.
> In theory user space could configure a "0"=C2=A0 PMU version just like
> pmu_counters_test does. Currently I'm not sure if the check for
> "pmu->version" can be removed, let me have a double check.

Gah, sorry, my comment was vague and confusing.  What I was trying to say i=
s that
the vcpu->kvm->arch.enable_pmu check is superfluous and can be dropped.

> >> +	kvm->arch.enable_pmu =3D enable_pmu && !enable_mediated_pmu;
> > So I tried to run a QEMU with this and it failed, because QEMU expected=
 the PMU
> > to be enabled and tried to write to PMU MSRs.  I haven't dug through th=
e QEMU
> > code, but I assume that QEMU rightly expects that passing in PMU in CPU=
ID when
> > KVM_GET_SUPPORTED_CPUID says its supported will result in the VM having=
 a PMU.
>=20
> As long as the module parameter "enable_mediated_pmu" is enabled, qemu
> needs below extra code to enable mediated vPMU, otherwise PMU is disabled
> in KVM.
>=20
> https://lore.kernel.org/all/20250324123712.34096-1-dapeng1.mi@linux.intel=
.com/
>=20
> > I.e. by trying to get cute with backwards compatibility, I think we bro=
ke backwards
> > compatiblity.  At this point, I'm leaning toward making the module para=
m off-by-default,
> > but otherwise not messing with the behavior of kvm->arch.enable_pmu.  N=
ot sure if
> > that has implications for KVM_PMU_CAP_DISABLE though.
>=20
> I'm not sure if it's a kind of break for backwards compatibility.=C2=A0 A=
s long
> as "enable_mediated_pmu" is not enabled, the qemu doesn't need any change=
s,
> the legacy vPMU can still be enabled by old qemu version. But if user wan=
t
> to enable mediated vPMU, so they should use the new version qemu which ha=
s
> the capability to enable mediated vPMU, it sounds reasonable for me.

I agree it's reasonable to require a userspace update to take advantage of =
new
features, what I don't like is what happens if userspace _hasn't_ been upda=
ted.
I also don't love that forcing a userspace update in this case is more than=
 a bit
contrived.  It's very doable to let existing userspace utilize the mediated=
 PMU,
forcing KVM_CAP_PMU_CAPABILITY is essentially KVM punting a problem to user=
space.

And the complications with the mediated PMU don't really have anything to d=
o with
the VMM, they're more about all the other tasks and daemons running on the =
system,
e.g. that might be using perf.

Thinking more about this, the problem isn't so much that enabling mediated =
PMUs
by default is undesirable, it's that giving userspace a binary choise doesn=
't
provide enough flexibility.  E.g. for single-user QEMU-based use cases (inc=
luding
my use of QEMU), requiring a new QEMU is painful and annoying, and so havin=
g an
on-by-default option would be nice.

But for use cases that already utilize KVM_CAP_PMU_CAPABILITY, e.g. to expl=
icitly
disable PMUs for a subset of VMs, on-by-default is very undesirable, e.g. w=
ould
require KVM to support KVM_PMU_CAP_DISABLE, and would generate unnecessary =
noise
and contention in perf.

So, what if we simply make enable_mediated_pmu a tri-state of sorts?

  0   =3D=3D disabled
  > 0 =3D=3D enabled for all VMs (no opt-in or opt-out supported)
  < 0 =3D=3D enabled, but off by default (requires opt-in)

Then use cases like my personal usage of QEMU can run with enable_mediated_=
pmu=3D1,
while use cases like Google Cloud can run with enable_mediated_pmu=3D-1, an=
d everyone
is happy (hopefully), without too much added complexity in KVM.

