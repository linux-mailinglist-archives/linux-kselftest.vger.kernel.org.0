Return-Path: <linux-kselftest+bounces-36087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6CDAED4A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 08:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1AC3B1A87
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 06:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE21BD01F;
	Mon, 30 Jun 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLz1HTXQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C3199BC;
	Mon, 30 Jun 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751265171; cv=none; b=vBkpKZTpvk4kS4Wa1VD2M7Fk3/ggo+b3T0Ntj+ZXcNSgiOsYLiA3VcRNVSb4L0ELFQ/z9Y3E9iN3OVx5DTIV0z65BmkCagkye7k4znda/NZ5JM8wFXZWNlPwc0QuLPYBxhdwft3A3AdGyJRJ54TOtSz92yIa+ff1CpKeJAwrqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751265171; c=relaxed/simple;
	bh=oVz3AzjXDB8tx63q2FWoAV/IMnwv+4nVU/gA7S9FJV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUcvpo0//E9wyEJPeCNa3An9uuNk0cZDfCEcgLm/Z7V1kQ6rCKLGsny6WXs1avbuie1BnddT2pOYx73F2jpu/phJHE+TLCVRjhrL4X6RjVbyy3H1Z3T5vdBRqa52wZIyacVhgWGrAzepGVYWpCT+8jqxFmCNgO2xEebLD4SzMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLz1HTXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3B8C4CEE3;
	Mon, 30 Jun 2025 06:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751265171;
	bh=oVz3AzjXDB8tx63q2FWoAV/IMnwv+4nVU/gA7S9FJV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLz1HTXQud2+C4Hc8dNqU5HzhsH4f4F5U8M6c43VE9hhsG1JJgaEFw3dlM5HYekdC
	 Lh0ZvkXpQTh3+3L/ZDGT7jiyS60+Vzm9SiJaDyJqovJ7TECijpZWTJHFnFQTGy6gTk
	 e18hf5xwbMX6UOnQM3yTWcCQqnGq68Qwm1TH2XDPLDYCP21ypPcwPiKp1B/0iGIbBw
	 hAITNfBhdwIsji6aPVMDQW1r7YUVTPgogLpCT+uUplA0emaN0fFm2PKtSA/sznG3pR
	 v/IlwNjXEufz2RMsBK3c/kjcnnVNoHZ0AQoEqkkUicIKt6H6qTVQPtx0XvtzJ80mNd
	 EHcz0r6KJ+xYQ==
Date: Mon, 30 Jun 2025 06:32:46 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Daniel Latypov <dlatypov@google.com>
Cc: bleung@chromium.org, brendan.higgins@linux.dev, davidgow@google.com,
	rmoar@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	naveen@kernel.org, anil.s.keshavamurthy@intel.com,
	davem@davemloft.net, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] platform/chrome: Add Kunit tests for protocol
 device drivers
Message-ID: <aGIvjrrSRPJQpNy7@google.com>
References: <20250520082435.2255639-1-tzungbi@kernel.org>
 <CAGS_qxrcH0+mJTO4nJqXnk2Bh7oO_PEur=ytcxL8wxJNCu20Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGS_qxrcH0+mJTO4nJqXnk2Bh7oO_PEur=ytcxL8wxJNCu20Tw@mail.gmail.com>

On Tue, May 20, 2025 at 09:04:53AM -0700, Daniel Latypov wrote:
> On Tue, May 20, 2025 at 1:25 AM 'Tzung-Bi Shih' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> > [...]
> > Questions:
> > - Are we going to support ftrace stub so that tests can use it?
> >
> > - If ftrace stub isn't on the plate (e.g. due to too many dependencies), how
> >   about the kprobes stub?  Is it something we could pursue?
> 
> Quick comment,
> If I recall, the thought process was that we could consider it in the
> future if there was enough demand for it.

Sorry for the late reply. I was doing some more experiments and stuck by
some else.

> We have these drawbacks with the current ftrace stubs:
> * doesn't compile on all arches
> * silently doesn't work on inlined functions <== scariest one to me

I see. I did some experiments and realized that kprobe stubs also share
the same concern. Thus I'm wondering if there is a way that kprobe stub
detects the redirection may fail, at least it can skip the test case
(e.g. register_kprobe() returns -ENOENT when it can't find the symbol
via kprobe_lookup_name()). But it seems no way if the target function
is partially inlined.

> You mention you don't like how static stubs requires modifying the
> code-under-test.
> Since it gets eliminated by the preprocessor unless you're compiling
> for KUnit, is the concern more so about how it conceptually feels
> wrong to do so?
> For the Android GKI kernel, they have (or had) KUnit enabled so there
> is potentially concern about real runtime cost there, not sure if you
> have something similar in mind.

Not exactly. Ideally, I think we shouldn't modify the CUT. I'm wondering
if there is a way to not change the CUT but also break the external
dependencies.

> But stepping back, ftrace_stubs technically require modifying the code
> to make sure funcs are marked as `noinline`, which this patch series
> does not do.
> I've not looked at cros_ec_{un,}register() to check if they're at risk
> of inlining, but wanted to call that out, that ftrace stubs
> technically don't handle your usage pattern 100% properly.

True. They could be partially inlined even though they are exported symbols.

