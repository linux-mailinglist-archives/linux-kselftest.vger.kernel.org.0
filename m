Return-Path: <linux-kselftest+bounces-32985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488CCAB7962
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748FC4A69A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410A226177;
	Wed, 14 May 2025 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3DNf+WR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F6202983
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747264781; cv=none; b=CtofxKvPt/RTnicReuYzjOFLC/W5ImLXfIBOSC5bAhdbfGTZ9QnSIT2KMoWZ+Vc7ckuvsisbCR+Adh+7+b4vsNtltiy2igN61O1R/XgoSlS68+wsKy5lWRrIfCzxo9/xD73Oir9Lg2+4xH76aYcdZr+Ntk9wXUjAWD1fxSeTkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747264781; c=relaxed/simple;
	bh=cNlVPYYnsQtqPjb2poMyKHUJYGJOPlxbA0jgyo6XDX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SnKYu01KSfxwKZ/xQssNjxbh+KUc7F5eB3A34HCPoI9dWtHG1jUXSVH3jCI2+KfkxZOeKzOlNE3AK39WrfxiYiRhd4BXMmjanGHFPky3+7ECfD581CAE/3Hsglwnn6nvRHHT/PjIohjYDp2xB7qNp+CBKCNE7f8361F5Z/ULPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3DNf+WR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ab5d34fdbso346789a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747264778; x=1747869578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=inzL0y+cbDFsyp/vzuyCwIe54VBn5YH91v/9/7m3MOg=;
        b=T3DNf+WRt5TCmAdcQ2vjHChChL+rwFC4OyuabZZXH3xG2eihOqqE0q38YK5UjrXvfK
         g7hSKkygwQRYlIGAsjaZhpH+GYVdZWL/ZAwRBHy6pQmVlG3igiYuBe49tVZ2KkRCyW7+
         qMtGr+/PDlHcMVzt9pM1eBFCS01/nhzQ0oDKgB5JNKWrmLb+Pp1ASpGnBd7xjxZVVpos
         Vw/kSahbU+LOc5hM9k9OB3lJoNIfyl5uO+n1sys9BjncipwhV0SHKay2xB/zO/4froQ9
         2L6rWGMwqhhip/wuTW2gUrx+wlO1CxqFLgUTMFRsG9Jktw1I21fKx1IN1q99p7WjexN1
         aM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747264778; x=1747869578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inzL0y+cbDFsyp/vzuyCwIe54VBn5YH91v/9/7m3MOg=;
        b=kzb4hjuCE5VSovrHis1XHHD3NeAsqG/BTGsm7eQX0biT3VWmVZZWX4TYbJpinulzvz
         fUwPktXuqB4ewg37cZmf/2QO61Fb99gKtjZKo7AfLVTxGvvrCrEhSe5sQuhhlbnRMtI7
         AGTde3XYoX/8UjdvSWuOUtTNkucqIPvg3gensS65Q2HPbv3cAk94/ErnHzj8SXpxZYGK
         t8N63CcnfyYpu9vxIJmdQycRpjTxj2w1CNOuQqxDHgQsFYQJHXzQaCwazaB6xDJNmH/v
         JXmPXFS7my4Mlw3OPGGaBraft+ZtbxfkzYRktWbRabBC7IFAp1rNLtf8cjumRkf1ZEo1
         DskQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmWQ1o420HrRd9ui8rxLTmaxbM9maojiTkuJeMMaTPGzvEAgZK9lmT6sZz48nTmDLAgT6Av29CZhLmqy/TKH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lZvW1RfU85uB5FuofcohtkAdCiPyvjr46iBBa4NkR5g5B+Io
	EH6ceTZS765NeXgfW5Crdgk2FUqMV40Ip6ktNHdOGkse7CkU5TmhZP3M6pdj4g9CrtNJnjs7rDv
	h0Q==
X-Google-Smtp-Source: AGHT+IGCQ/sRX+3EYNcQDJbTeqc67xnpDL/NXZuajHJEmLyvMC58UdBnQowu6qn5H0+QlUsXIshKg9Pma6c=
X-Received: from pjn12.prod.google.com ([2002:a17:90b:570c:b0:2ef:8055:93d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17d2:b0:30a:214c:24c9
 with SMTP id 98e67ed59e1d1-30e2e5d612dmr7495408a91.3.1747264778031; Wed, 14
 May 2025 16:19:38 -0700 (PDT)
Date: Wed, 14 May 2025 16:19:36 -0700
In-Reply-To: <20250425111352.GF1166@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-6-mizhang@google.com>
 <20250425111352.GF1166@noisy.programming.kicks-ass.net>
Message-ID: <aCUlCApeDM9Uy4a0@google.com>
Subject: Re: [PATCH v4 05/38] perf: Add generic exclude_guest support
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mingwei Zhang <mizhang@google.com>, Ingo Molnar <mingo@redhat.com>, 
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

On Fri, Apr 25, 2025, Peter Zijlstra wrote:
> On Mon, Mar 24, 2025 at 05:30:45PM +0000, Mingwei Zhang wrote:
> 
> > @@ -6040,6 +6041,71 @@ void perf_put_mediated_pmu(void)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
> >  
> > +static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
> > +{
> > +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> > +	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
> > +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> > +	if (cpuctx->task_ctx) {
> > +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> > +		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
> > +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> > +	}
> > +}
> > +
> > +/* When entering a guest, schedule out all exclude_guest events. */
> > +void perf_guest_enter(void)
> > +{
> > +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> > +
> > +	if (WARN_ON_ONCE(__this_cpu_read(perf_in_guest)))
> > +		goto unlock;
> > +
> > +	perf_host_exit(cpuctx);
> > +
> > +	__this_cpu_write(perf_in_guest, true);
> > +
> > +unlock:
> > +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> > +}
> > +EXPORT_SYMBOL_GPL(perf_guest_enter);
> > +
> > +static inline void perf_host_enter(struct perf_cpu_context *cpuctx)
> > +{
> > +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> > +	if (cpuctx->task_ctx)
> > +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> > +
> > +	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
> > +
> > +	if (cpuctx->task_ctx)
> > +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> > +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> > +}
> > +
> > +void perf_guest_exit(void)
> > +{
> > +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> > +
> > +	if (WARN_ON_ONCE(!__this_cpu_read(perf_in_guest)))
> > +		goto unlock;
> > +
> > +	perf_host_enter(cpuctx);
> > +
> > +	__this_cpu_write(perf_in_guest, false);
> > +unlock:
> > +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> > +}
> > +EXPORT_SYMBOL_GPL(perf_guest_exit);
> 
> This naming is confusing on purpose? Pick either guest/host and stick
> with it.

+1.  I also think the inner perf_host_{enter,exit}() helpers are superflous.
These flows

After a bit of hacking, and with a few spoilers, this is what I ended up with
(not anywhere near fully tested).  I like following KVM's kvm_xxx_{load,put}()
nomenclature to tie everything together, so I went with "guest" instead of "host"
even though the majority of work being down is to shedule out/in host context.

/* When loading a guest's mediated PMU, schedule out all exclude_guest events. */
void perf_load_guest_context(unsigned long data)
{
	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);

	lockdep_assert_irqs_disabled();

	perf_ctx_lock(cpuctx, cpuctx->task_ctx);

	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
		goto unlock;

	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
	if (cpuctx->task_ctx) {
		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
	}

	arch_perf_load_guest_context(data);

	__this_cpu_write(guest_ctx_loaded, true);

unlock:
	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
}
EXPORT_SYMBOL_GPL(perf_load_guest_context);

void perf_put_guest_context(void)
{
	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);

	lockdep_assert_irqs_disabled();

	perf_ctx_lock(cpuctx, cpuctx->task_ctx);

	if (WARN_ON_ONCE(!__this_cpu_read(guest_ctx_loaded)))
		goto unlock;

	arch_perf_put_guest_context();

	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
	if (cpuctx->task_ctx)
		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);

	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);

	if (cpuctx->task_ctx)
		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);

	__this_cpu_write(guest_ctx_loaded, false);
unlock:
	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
}
EXPORT_SYMBOL_GPL(perf_put_guest_context);

