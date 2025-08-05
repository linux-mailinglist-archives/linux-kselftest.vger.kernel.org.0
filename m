Return-Path: <linux-kselftest+bounces-38260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC19B1ABD8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 02:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7DF7A1D23
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 00:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A0E189905;
	Tue,  5 Aug 2025 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1C8covj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31F15E5BB
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754355247; cv=none; b=R2Z8yPZGVer/c7qCVgKx4RYL7hQGeQ2Ok9SnZq86UKTy/oViBRu4+X+p81KBgPuKtHaJkeNySRxpRqLTJOjVRzDLznvfgnTVn5vbkr8WfQXlQyBsGlybh4/Feje7cWWmWBUWt8s6EOmb5jUVC2xtAyc3KLVPMInd6SNKonWb7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754355247; c=relaxed/simple;
	bh=FFdH34Y9HowedidO8AMmBlMiHCYieYF/CPEAxL3qGKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B94vz5IJvwfo0PAfG+TFcXcfxi2BLaYnFVQmIJ0gEt5yIJ/Aw3Ux/icO0NXPIh52RHyHOzC3KyI4DqYWUZxOjFDdc5jIy+yjVHWVhIE/muN5yrBjU3F8TNUZEX5NrAqOT69qBZfv2fgaMlqy3tBBuZJopFWkOJljy6rZo3rGdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1C8covj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so5013106a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Aug 2025 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754355245; x=1754960045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnYyO3awZ0p4a3WeYpLVM8RxiQLoBTvUlR+pcd54P0Y=;
        b=U1C8covjIxIcnnvapU/kR3HrlUM1tfgzTh6FjWT897GWCoMsKm7B3S8yZDuUjh+hza
         sbSGFbemaWE0djWBBHa7hFR/ARMW3XAOuBqrYBadvDhiXiNhXC1MAkTFvExha6tYLCRT
         98VgdBsebM0Gt3XcNMpuncPPUrhdwu6N3qI0TQH2lSkNckhKJm30YBkQxhq7VhxPj39i
         e2yUxB1ekwFRzfVrB2UVbMlJpBzv5wHh7y8WRUx4btrjwbefTLqYTjjXVrl/2rH2N7Xr
         NxNa9T9KRGi4xa2SGkJ09bwtQVwLd9urd5fmZiJ9C9lZhkqodsTn+RAhJI9+oTKB1XJ/
         KWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754355245; x=1754960045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnYyO3awZ0p4a3WeYpLVM8RxiQLoBTvUlR+pcd54P0Y=;
        b=aKtUYZn+lzzhcqTTj9Oc1uIlwkzEHDOrf7PvudDq4a4LpYvBj8VnwrOdj5MBy1Fz5V
         h4T5hUu5knF1zXr7C8qs2x5UmUAyukGn3SiZcgktc54+HxWCMnp35WERZ2Nvn1DX1wFV
         J6aJy6hpDkZubEFGlJGXtdR2WYK1mkRh4js+ScdNA5GSxugPkyK5Q2Ls7I0ldXfX1ZiJ
         73++9NEnBgpRkluLX0Bz/lCJNJwYJde353TWwPnuyStBEwVor1xHlHbKcWi+m/dVd5J8
         mXVy3bWc+QEMblY720EtC+fvqj6bzPKZsFUsXALfuABPRd8M9cLTnK0aDxsa4Y/o8yIa
         H7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU/+GMRq5pJOdtfxAIobBQvHAskwtL+DKvM1ohDxzLVepQB5k/2uEo06/j1Jac+WHoMnwzKwUYP2+evkyndpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEE85AMurm1y7OhBnMbcDdvIDbrxzjup/YffJhkXXI9nRd1sa
	Uq03zY7UEQdUAZc6pIgmtuwfaLHSULceYQudMgX495UEcIxgLnG9SDcG+hgXBrtC3PmG6OPtnKh
	9G1pwcg==
X-Google-Smtp-Source: AGHT+IHgN8sz9idD1zUFlU9yymn8l6XJp4oewuncjBPKVnSTsjJkkM6MeA40sbodBjsLi1AvBiuvLXTAy5w=
X-Received: from pjbsx15.prod.google.com ([2002:a17:90b:2ccf:b0:31f:37f:d381])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c88:b0:31c:3651:2d18
 with SMTP id 98e67ed59e1d1-321162b20bemr16301922a91.16.1754355244905; Mon, 04
 Aug 2025 17:54:04 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:54:03 -0700
In-Reply-To: <aI1OefS8b9vfHyu9@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-21-mizhang@google.com>
 <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com> <aG6QeTXrd7Can8PK@google.com>
 <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com> <aIlpaL-yEU_0kgrD@google.com>
 <7de2b6ed-af39-4434-9ead-5b06ed4761c5@linux.intel.com> <aI1OefS8b9vfHyu9@google.com>
Message-ID: <aJFWK-EiGgH5aiw1@google.com>
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>, Mingwei Zhang <mizhang@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 01, 2025, Sean Christopherson wrote:
> On Wed, Jul 30, 2025, Dapeng Mi wrote:
> > 
> > On 7/30/2025 8:38 AM, Sean Christopherson wrote:
> > > On Tue, Jul 29, 2025, Dapeng Mi wrote:
> > >> BTW, Sean, may I know your plan about the mediated vPMU v5 patch set? Thanks.
> > > I'll get it out this week (hopefully tomorrow).
> > 
> > Thumbs up! Thanks.
> 
> I lied, I'm not going to get it out until Monday.  Figuring out how to deal with
> instruction emulation in the fastpath VM-Exit handlers took me longer than I was
> hoping/expecting.
> 
> It's fully tested, and I have all but one changelog written, but I'm out of time
> for today (I made a stupid goof (inverted a !) that cost me an ~hour today, *sigh*).
> 
> Unless I get hit by a meteor, I'll get it out Monday.

*sigh*

Wrong again (fortunately, I didn't get hit by a meteor).  Long story short, I
revisited (yet again) how to deal with enabling the mediated PMU.  I had been
doing almost all of my testing with a hack to force-enable a mediated PMU, and
when it came time to rip that out, I just couldn't convince myself that requiring
userspace to enable KVM_CAP_PMU_CAPABILITY was the best behavior (I especially
hated that PMU support would silently disappear).

So, bad news is, v5 isn't happening today.  Good news is that I think I figured
out a not-awful solution for enabling the mediated PMU.  I'll post details (and
hopefully v5) tomorrow.

