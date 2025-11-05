Return-Path: <linux-kselftest+bounces-44802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC2C35F2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 15:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211FF3B6C3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6D322768;
	Wed,  5 Nov 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIAzYg3j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80123218CC;
	Wed,  5 Nov 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351163; cv=none; b=bJMXj0W1jwl3wACjV2/c+QjWjEVyp+8kkNDNIZ4/+dFayKZkYS+g+nv9NllNkJyyA3aKSpTUfLqf9YVkh1Nskzj6+84NdlqeIiRgiBOFO4M3yfZ2jDDXHLWpQZA2bjrDAy7rSU0YKIbjD9AlaPzt77dFg/oQjdlMyNOTxgZB8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351163; c=relaxed/simple;
	bh=4CtDK2GSeUy0RgDqv+RRMkHEDyyGY2oSwQX8ucr/TWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaJXqgYucf1fJ+X511AAC8OxPgaCRs/Sr11gKDk3PKmv1+WY6xkt66CxJvu+Ait1HaWhTmg0ZqcAkdfpJ/479yE4qMz4v6b7EI3GPDgUWQEm7dyz/RCt4qiyU2fdCmECvoRKQ73BIkH3VFbm8gM6g1KIIXYdSjZdIF6YQnmFJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tIAzYg3j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QIf1PFHO57g8NJW196xjDL754CNA1jwCNk78E0Xgit4=; b=tIAzYg3j9MRo2vX/cHCUXjs3WS
	R1eY0+MHV65GkSExyjC6kIFpwAozjzrVgt3ZlpkTuQr0dNR2fthHMF7cheSW+0zuxbrOZRNdkQCSg
	r9ZNfVONNZCPIVjmkt9BjzNd9NgtJ2JqESYpowsfxNVmKrLkly40NVJgquvjuW1mDdIiluLOmmgOK
	+hSmMAtp6ff5AvNVbjGLkJGHZy6H38QRGxpF5PGMIw1Fn9IORlbcwWWO+I93RbpSt51d+ZoHqlSOs
	x9g17Bmtbz94xFcpcWZx6WbNyZvzzpm0m/6o5egdnLx4HbkUgx/et1VXbYNiajz31khkqKJ8PRDjd
	t9WXR7UQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGe2Z-00000007vmn-38vC;
	Wed, 05 Nov 2025 13:59:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 637B7300230; Wed, 05 Nov 2025 14:59:11 +0100 (CET)
Date: Wed, 5 Nov 2025 14:59:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v10 sched_ext/for-6.19] Add a deadline server for
 sched_ext tasks
Message-ID: <20251105135911.GQ4067720@noisy.programming.kicks-ass.net>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <aQtVe9LKuQ_W3qwY@gpd4>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtVe9LKuQ_W3qwY@gpd4>

On Wed, Nov 05, 2025 at 02:47:39PM +0100, Andrea Righi wrote:
> On Wed, Oct 29, 2025 at 08:08:37PM +0100, Andrea Righi wrote:
> > sched_ext tasks can be starved by long-running RT tasks, especially since
> > RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
> > tasks.
> > 
> > Several users in the community have reported issues with RT stalling
> > sched_ext tasks. This is fairly common on distributions or environments
> > where applications like video compositors, audio services, etc. run as RT
> > tasks by default.
> > 
> > Example trace (showing a per-CPU kthread stalled due to the sway Wayland
> > compositor running as an RT task):
> > 
> >  runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
> >  ...
> >  CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
> >            curr=sway[994] class=rt_sched_class
> >    R kworker/0:0[106377] -5043ms
> >        scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
> >        sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
> >        cpus=01
> > 
> > This is often perceived as a bug in the BPF schedulers, but in reality
> > schedulers can't do much: RT tasks run outside their control and can
> > potentially consume 100% of the CPU bandwidth.
> > 
> > Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
> > also boosted and do not suffer starvation.
> > 
> > Two kselftests are also provided to verify the starvation fixes and
> > bandwidth allocation is correct.
> 
> Peter, Juri, this has now been tested quite extensively on our side and
> we're considering applying these patches to Tejun's sched_ext branch.
> 
> Do you have any objections or concerns?

Yeah, I want to finish this first:

  https://lkml.kernel.org/r/20251101000057.GA2184199@noisy.programming.kicks-ass.net

Because as is, the whole dl_server stuff isn't quite right.

