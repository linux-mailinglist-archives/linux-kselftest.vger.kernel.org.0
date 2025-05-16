Return-Path: <linux-kselftest+bounces-33228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58626ABA4DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D525A214D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C222D797;
	Fri, 16 May 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3B7bveB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2B22D4C8
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747428883; cv=none; b=a4g5xhFVLZfIDHhrRYeNB2qx9NHCxKooCkbj7N3zdvsAgE0aq5OWWebsYxm1dwAJei73XNHzPvAl8mOQtMifCVl3noVWS17blM1n3Us+y/eMah5LRYL4tv4PN5u6snyYmYWadv90CIP+0CrfK+v+Ajk39ShzeW4ZhfCoRX1Z7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747428883; c=relaxed/simple;
	bh=QWFG0Ylh5oGGQ0y5MXw7J0v9cLYgY8UG3wLXOKRNB6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ewMZK7C+0fYs7JxrFyY2x+Z060y9TXqwScUIpmywZRZD4fWYz8SnN2I+tGIOGGG961cfhx7/sa7uSUWBHy6ih8DILTtbtcJt3VRu/eQqemgQou7oCkYERiPg40Wv/M204GwFqKvgN59TVM8KndIMocxMLTGbe0vk1WXlc4s49JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3B7bveB; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b269789425bso2617310a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747428881; x=1748033681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUEdh5iBFBvuEiqTMp07Lu/KDXTezSp1m3vHIrINdEA=;
        b=P3B7bveBkhciad9rpRDaft6/0HMMZhqJpG1nEqbLj0xg7kYpV3HaLTu52g5UGJDvko
         Vqg9uYus3ZFT9vj40IHW7WeniOxJXjeaYh2lCNE0/RPGuEhvUQGCLBYORocESV9cwVf4
         aaBnXSbVwzu6dgn6zcucOKbaSTrPU1z2mVP6rLMuBJLXlXZZNqVlDx9Tn2krXkKBzmlk
         RvW96lbx5MmYIBF7mGAs53/j+gMcnBnM1U1FlkNKncDYQPr+2ervoCAa1veL2W2Ns79G
         izjRG+89orqrv9SIQT1954b5s3Yyw/bee2kWd2si3c+/uT8E86LPMOxg1mQ4lESPZwqE
         v4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747428881; x=1748033681;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pUEdh5iBFBvuEiqTMp07Lu/KDXTezSp1m3vHIrINdEA=;
        b=SA+3fJTzB1o8R62Md8N3b12lWsSkBn+J5C1uMQ9pq2ZjNk/2HOOn1sUVTkdmT8mayL
         qpIle0U7XfxXLqAjrxs5ACBUqQHIMEJ8ah9ucD5LjpfiGGJMVM27VDeshhxTNGTA8Dyz
         RI1ZNBlvJn43yTGFSoLRC96bYG4roqgWiL8W04f/9d6X6hGjMVdCo1Sbk38mMXVLbLe1
         krjPZNCoMSbrddsQ7WEHOLmMQ4UbJyR7RoRNP0AbA900T9A9wXW45X8aWmdHWVV0xH9S
         QT8sIlP9ii32/Y4AlJA0LgOHcP/xeHN2I+smssCaPnTjZUoJigkXvjKS7Ygw2ztan6h2
         wvqw==
X-Forwarded-Encrypted: i=1; AJvYcCUk2kn7LkCU7XtQ1TE7o7q0TbD6oL1V1tTbvy/ID28LwFPSG5dalKvdxSzDlrHJW10+PDZxue1PQKVm+Rj336Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRUOuAFKMVigJv0URF9atTKbD8eoKZSkJLroP6hkntVkzoQCI
	7kbu4YII/K4v+77c/tYoHJBZcoBNw5b3Ag7D6RugWLD5kNNeXZ/SzI7jSLoVnSbARaoqVSXhQ5R
	gpPpw3g==
X-Google-Smtp-Source: AGHT+IEKXMvi6p5AYfeWYVVxoOJp0+T+HCMSwZBivOJAwnUFY68sURx/OiAsfMQfNNX7Rux9VtkV5C8ZiFM=
X-Received: from pgid6.prod.google.com ([2002:a63:ed06:0:b0:b26:de99:6f81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f83:b0:1f5:619a:8f79
 with SMTP id adf61e73a8af0-21621876910mr7462694637.1.1747428880970; Fri, 16
 May 2025 13:54:40 -0700 (PDT)
Date: Fri, 16 May 2025 13:54:34 -0700
In-Reply-To: <2d0d274c-6bc0-43c7-a8a8-92aa11872675@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-28-mizhang@google.com>
 <2d0d274c-6bc0-43c7-a8a8-92aa11872675@linux.intel.com>
Message-ID: <aCemClX6rKnVFqLt@google.com>
Subject: Re: [PATCH v4 27/38] KVM: x86/pmu: Handle PMU MSRs interception and
 event filtering
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

On Fri, May 16, 2025, Dapeng Mi wrote:
> On 3/25/2025 1:31 AM, Mingwei Zhang wrote:
> > +	if (kvm_mediated_pmu_enabled(pmu_to_vcpu(pmu))) {
> > +		bool allowed =3D check_pmu_event_filter(pmc);
> > +
> > +		if (pmc_is_gp(pmc)) {
> > +			if (allowed)
> > +				pmc->eventsel_hw |=3D pmc->eventsel &
> > +						    ARCH_PERFMON_EVENTSEL_ENABLE;
> > +			else
> > +				pmc->eventsel_hw &=3D ~ARCH_PERFMON_EVENTSEL_ENABLE;
> > +		} else {
> > +			int idx =3D pmc->idx - KVM_FIXED_PMC_BASE_IDX;
> > +
> > +			if (allowed)
> > +				pmu->fixed_ctr_ctrl_hw =3D pmu->fixed_ctr_ctrl;
>=20
> Sean, just found there is a potential bug here.=C2=A0 The
> "pmu->fixed_ctr_ctrl_hw" should not be assigned to "pmu->fixed_ctr_ctrl"
> here, otherwise the other filtered fixed counter (not this allowed fixed
> counter) could be enabled accidentally.
>=20
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index ba9d336f1d1d..f32e5f66f73b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -473,7 +473,8 @@ static int reprogram_counter(struct kvm_pmc *pmc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int idx =
=3D pmc->idx - KVM_FIXED_PMC_BASE_IDX;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (allo=
wed)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmu->fixed_ctr_ctrl_hw =3D pmu->fixed_ctr=
_ctrl;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmu->fixed_ctr_ctrl_hw |=3D pmu->fixed_ct=
r_ctrl &
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> intel_fixed_bits_by_idx(idx, 0xf);

Hmm, I think that's fine, since pmu->fixed_ctr_ctrl should have changed?  B=
ut I'd
rather play it safe and do (completely untested):

	if (pmc_is_gp(pmc)) {
		pmc->eventsel_hw &=3D ~ARCH_PERFMON_EVENTSEL_ENABLE;
		if (allowed)
			pmc->eventsel_hw |=3D pmc->eventsel &
					    ARCH_PERFMON_EVENTSEL_ENABLE;
	} else {
		u64 mask =3D intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0=
xf);

		pmu->fixed_ctr_ctrl_hw &=3D ~mask;
		if (allowed)
			pmu->fixed_ctr_ctrl_hw |=3D pmu->fixed_ctr_ctrl & mask;
	}

