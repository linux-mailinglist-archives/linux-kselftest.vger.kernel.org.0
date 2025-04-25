Return-Path: <linux-kselftest+bounces-31634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40845A9C6DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FFD7B7524
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 11:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC16245014;
	Fri, 25 Apr 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEewnWIQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DB183CC3;
	Fri, 25 Apr 2025 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579639; cv=none; b=tpNv/C7XYvX0DJ13etKk7vMt9ui1yFRNY72a/cavXsEgfpEA3z3/rObHFPCfIzQ+gZHbxsIUn7Jwdbm946T0oUVF6QIP18muadrx8fAj29E8FFDkmnH/j8TVPfj+PlMo6BFkBvOYZZNE05X2c//X1++bMGSf+JwKn3XWj1p4Zng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579639; c=relaxed/simple;
	bh=xiebXfja5+K7qkMOYojBV9ntgYUiISSmkVxnSIre/+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH6td+dR+NqiifwdGyQRptCR7Wq2FN1ikDLvunfTi6rFeEcPvFZVCvNojWz3ES5RVxNmGhK2fcP4IkfWeu5Tqfd6kIn3Lhfvzf2oaTSR7hTm612p7H7Xfh8g5KZTv0y0DhUubZ2a1mB2nw6ue2D14ztsyi7sBADjWU15UCTfP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PEewnWIQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Jd1PjnUqDX3f/DxkbkNrFg+6trySYhrjcgsIergWdw=; b=PEewnWIQCOgG8+ui0+F3RY/K6z
	Ul+tv8obP8WQdaPc4W4+QWuCJkbY+70vWYzh564YAtTU+OfEgU5cb0+X2hQVK0Yv9+jRw3l3nS+7w
	JHqZcrBlXgBzTgQYHbc3UR29mIH0yCA+eNolgbxV4wM42VgozxfEo/iqA2AwlgaVR7uG6qNqSC/8d
	i0rR2AnBoB1LdG76C/7XgTX6IGAKkc3vEyUfa2Op5SDJNJhKGqkuRGW5B/eyDEUzFlwsTNEJIywq+
	9lE2F2lTHDofcvVZcmbDTjLps3V8ubm1wpQMSDjLj6+k1W4UlfVm0GChCvdZxI0dHt2GxEzBIn5ba
	OE0HVbaw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0C-0000000ENc1-2La2;
	Fri, 25 Apr 2025 11:13:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3031C3003C4; Fri, 25 Apr 2025 13:13:52 +0200 (CEST)
Date: Fri, 25 Apr 2025 13:13:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mingwei Zhang <mizhang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Xiong Zhang <xiong.y.zhang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Zide Chen <zide.chen@intel.com>,
	Eranian Stephane <eranian@google.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Subject: Re: [PATCH v4 05/38] perf: Add generic exclude_guest support
Message-ID: <20250425111352.GF1166@noisy.programming.kicks-ass.net>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-6-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324173121.1275209-6-mizhang@google.com>

On Mon, Mar 24, 2025 at 05:30:45PM +0000, Mingwei Zhang wrote:

> @@ -6040,6 +6041,71 @@ void perf_put_mediated_pmu(void)
>  }
>  EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
>  
> +static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
> +{
> +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> +	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
> +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> +	if (cpuctx->task_ctx) {
> +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> +		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
> +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> +	}
> +}
> +
> +/* When entering a guest, schedule out all exclude_guest events. */
> +void perf_guest_enter(void)
> +{
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +
> +	if (WARN_ON_ONCE(__this_cpu_read(perf_in_guest)))
> +		goto unlock;
> +
> +	perf_host_exit(cpuctx);
> +
> +	__this_cpu_write(perf_in_guest, true);
> +
> +unlock:
> +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> +}
> +EXPORT_SYMBOL_GPL(perf_guest_enter);
> +
> +static inline void perf_host_enter(struct perf_cpu_context *cpuctx)
> +{
> +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> +	if (cpuctx->task_ctx)
> +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> +
> +	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
> +
> +	if (cpuctx->task_ctx)
> +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> +}
> +
> +void perf_guest_exit(void)
> +{
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +
> +	if (WARN_ON_ONCE(!__this_cpu_read(perf_in_guest)))
> +		goto unlock;
> +
> +	perf_host_enter(cpuctx);
> +
> +	__this_cpu_write(perf_in_guest, false);
> +unlock:
> +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> +}
> +EXPORT_SYMBOL_GPL(perf_guest_exit);

This naming is confusing on purpose? Pick either guest/host and stick
with it.

