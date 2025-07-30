Return-Path: <linux-kselftest+bounces-38071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB939B15689
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 02:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0925609A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537053365;
	Wed, 30 Jul 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZjT7dil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6118B0F
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Jul 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835496; cv=none; b=mdW7xQBQgJ3RswgUIAg7+6La42MkPfg5vwyK9MttzQioja9gnySAbMmKFuNPAEXsL+Ff9BUryqp8iwBzAl0yAkeEEIZhAJPH9pIw4EYbpsNRm0IOn6BC2qwNpMKwHR8zuA2ltMiL6/fNe2FHCmFqR5VkogBjtCnF5ArfLO0bbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835496; c=relaxed/simple;
	bh=xBqYcPOMq93xlyP7/znvTXGQJiBTxVO/kOVZXtDD+9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uyPCJ5qeltvzYijdRTruLc0wbUNz2ViFRivHD9XAq7P9cdx2cgIRoijAHnJjLxzeXnbxjsSfrT7Hz5HkUmd6j8a7mGMEE7qhx69cInAbnqrxNjmymgGwPkbd0XKrCFvFHX3zm5pxfu6WiWDYG6vVG4iMEX3QiTEtPG3ckuivgzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZjT7dil; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31366819969so338255a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753835494; x=1754440294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsvMJHxi0Jk9Ob0YWIw4MQPlATsEKQhQD2Gx/yz9Pks=;
        b=qZjT7dilcKyMf/lvgv27m7hyyBEdKOZnkBehHV4Mss+NyQ9odaIWC9lg0qEyfFPO7m
         pYlXPEIgzrYA67FazKBqBUKrawlEfD1ncIIpQYewKOF8J/2PA/UP/EhE0HnmuGITW8z3
         QjuD/GvaA7bpVN/J640iYJENKnqMRVztOx8KGpYYZ5iI8AqXWil4A1pCsTUpg6Q7AJHq
         2dQGOzsjQxXR45pIGMrVlH5gHNtv7CTwoI9BoOF8WFRdgD1HZRcozqR97Td4NLW91Emh
         fr3K32lr42r/hjszsPi5e4bs3Ab44FvJWENh581r7lheKE494WfqWv4RHLbAf6X0THIH
         6kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753835494; x=1754440294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsvMJHxi0Jk9Ob0YWIw4MQPlATsEKQhQD2Gx/yz9Pks=;
        b=jdRJ87z2u5AzfOdubK5KzOyE8iDlEKsrAtcTHn7CwQbgYZj6XzFpZCFsBg+LKiGxLF
         iddfMjyN3xMUBFjFjap7W033S6Wj2MYocqkBReaQ7gpAGbo2/3InDFH8wKu/InAVHk+e
         EXBjWXIndXiRysP2N3woIimuLJP6wbXWZ5jt3/GG1YUNI2z82G1+mIxqOkV6FmKofrh0
         ES0qRiEtJKeJN1czW/7ihJBiw47MoWtVGOmZ1ZY0uffv9IcbNDoTj0el1YEJ43/V7QPx
         0yTl7ZmW33t39rZKpHSANOBbqZE6+FjTUqoDYlBGe27UU8wDLGnvfgKr0fnhZEVWgpKG
         2BtA==
X-Forwarded-Encrypted: i=1; AJvYcCWJT7HTyFDhSTPVk9xO2VxmzsS8Li5V+NNBAg4nNwZp2DymexeFT/TFPaLG3I+D+4mADyia32b9gS/JS302g8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0agnWP5Cp66+eUGmVFo/dKrptzmpzwxV3C82nL2L7Qjl9LCH
	bRXTssK2pzNkLDqUZyqD48aPWASTb5/byMlnZ2j36p/zJh3jVwQDJWmoBmGY3LNhIf8Sz2WQSSf
	sO0LToQ==
X-Google-Smtp-Source: AGHT+IFCF3M3I1KqAW7n7dx3RKk9sCzbdlNYVQtyXACNkKIW9/xqHIXRzHtQZzgpVcJKkggbqyQ4NVMy3mQ=
X-Received: from pjg6.prod.google.com ([2002:a17:90b:3f46:b0:31c:bd1d:516])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2784:b0:312:e76f:5213
 with SMTP id 98e67ed59e1d1-31f5de6c813mr1791644a91.28.1753835494079; Tue, 29
 Jul 2025 17:31:34 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:31:32 -0700
In-Reply-To: <dacd4a8e-5104-4043-b647-63e2df6d6a94@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-11-mizhang@google.com>
 <20250425111531.GG1166@noisy.programming.kicks-ass.net> <e2f3b1d5-ed91-47a1-aead-28675bcca2c8@linux.intel.com>
 <20250425134323.GA35881@noisy.programming.kicks-ass.net> <dacd4a8e-5104-4043-b647-63e2df6d6a94@linux.intel.com>
Message-ID: <aIln5KlHYlIg3Ui-@google.com>
Subject: Re: [PATCH v4 10/38] perf/x86: Support switch_guest_ctx interface
From: Sean Christopherson <seanjc@google.com>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Mingwei Zhang <mizhang@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 25, 2025, Kan Liang wrote:
> On 2025-04-25 9:43 a.m., Peter Zijlstra wrote:
> > On Fri, Apr 25, 2025 at 09:06:26AM -0400, Liang, Kan wrote:
> >>
> >>
> >> On 2025-04-25 7:15 a.m., Peter Zijlstra wrote:
> >>> On Mon, Mar 24, 2025 at 05:30:50PM +0000, Mingwei Zhang wrote:
> >>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>
> >>>> Implement switch_guest_ctx interface for x86 PMU, switch PMI to dedicated
> >>>> KVM_GUEST_PMI_VECTOR at perf guest enter, and switch PMI back to
> >>>> NMI at perf guest exit.
> >>>>
> >>>> Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> >>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> >>>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> >>>> ---
> >>>>  arch/x86/events/core.c | 12 ++++++++++++
> >>>>  1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> >>>> index 8f218ac0d445..28161d6ff26d 100644
> >>>> --- a/arch/x86/events/core.c
> >>>> +++ b/arch/x86/events/core.c
> >>>> @@ -2677,6 +2677,16 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
> >>>>  	return ret;
> >>>>  }
> >>>>  
> >>>> +static void x86_pmu_switch_guest_ctx(bool enter, void *data)
> >>>> +{
> >>>> +	u32 guest_lvtpc = *(u32 *)data;
> >>>> +
> >>>> +	if (enter)
> >>>> +		apic_write(APIC_LVTPC, guest_lvtpc);
> >>>> +	else
> >>>> +		apic_write(APIC_LVTPC, APIC_DM_NMI);
> >>>> +}
> >>>
> >>> This, why can't it use x86_pmu.guest_lvtpc here and call it a day? Why
> >>> is that argument passed around through the generic code only to get back
> >>> here?
> >>
> >> The vector has to be from the KVM. However, the current interfaces only
> >> support KVM read perf variables, e.g., perf_get_x86_pmu_capability and
> >> perf_get_hw_event_config.
> >> We need to add an new interface to allow the KVM write a perf variable,
> >> e.g., perf_set_guest_lvtpc.
> > 
> > But all that should remain in x86, there is no reason what so ever to
> > leak this into generic code.

Finally prepping v5, and this is one of two <knock wood> comments that isn't fully
addressed.

The vector isn't a problem; that's *always* PERF_GUEST_MEDIATED_PMI_VECTOR and
so doesn't even require anything in x86_pmu.

But whether or not the entry should be masked comes from the guest's LVTPC entry,
and I don't see a cleaner way to get that information into x86, especially since
the switch between host and guest PMI needs to happen in the "perf context disabled"
section.

I think/hope I dressed up the code so that it's not _so_ ugly, and so that it's
fully extensible in the unlikely event a non-x86 arch were to ever support a
mediated vPMU, e.g. @data could be used to pass a pointer to a struct.

  void perf_load_guest_context(unsigned long data)
  {
	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);

	lockdep_assert_irqs_disabled();

	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);

	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
		return;

	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
	if (cpuctx->task_ctx) {
		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
	}

	arch_perf_load_guest_context(data);

	...
  }

  void arch_perf_load_guest_context(unsigned long data)
  {
	u32 masked = data & APIC_LVT_MASKED;

	apic_write(APIC_LVTPC,
		   APIC_DM_FIXED | PERF_GUEST_MEDIATED_PMI_VECTOR | masked);
	this_cpu_write(x86_guest_ctx_loaded, true);
  }

Holler if you have a better idea.  I'll plan on posting v5 in the next day or so
no matter what, so that it's not delayed for this one thing (it's already been
delayed more than I was hoping, and there are a lot of changes relative to v4).

