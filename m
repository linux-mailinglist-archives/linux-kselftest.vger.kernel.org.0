Return-Path: <linux-kselftest+bounces-34622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98531AD43DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 22:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C910A3A5590
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B6265CC8;
	Tue, 10 Jun 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nztG3FBU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D5265CBA;
	Tue, 10 Jun 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587592; cv=none; b=Preq0fmT5bkq8RXgJfYZVPBq7FcWw1IyJ2p3Lc/pJ71FM2HkvpY+tWB5mD/9J+J7uqW7hMwvdZh5MfSbqZdxpjtsYoGrUjuvJ5hcQU0NRBkEL+oBdn/LwnvD/2LL1MdLZqbKRxZS+joG86F0KBPYcpklj3Qk/JsX4kSUKhdqCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587592; c=relaxed/simple;
	bh=YqAtRU+UI0vXzRiV4CZ1vJF79I1Ncsncog4Fc6hDRkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLnxFFamVn4pamC291uH5HE1Jf7SWEyM7XrfOR9BjaxaO7APacjptsX38CCK28D+mMPe0hzsVAoUmI/1drZ8O24P2KJgM5jY0EQLqQsSqrxvWMDxq13jAJ757uykKH3gr0hr1icTSjQyEBCy86aVEJox1ONP11bn8BV9QzT5Rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nztG3FBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C1C4CEED;
	Tue, 10 Jun 2025 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749587592;
	bh=YqAtRU+UI0vXzRiV4CZ1vJF79I1Ncsncog4Fc6hDRkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nztG3FBUb/dwPMNltE4uTNKS6+qtHQthGNxdk30oHQc+8V4GL6FBuDFRsKOH4ojYE
	 86oNZJTgxlaa8pE1CauiNCy3E9PEbjEautOmloD/LiGyfC50l8tcqf3es32a9cCEcx
	 igKawOiVs2S81NCqwrDMLY8FppIcKatwxWV4UKxIWOlBPLP9GdNp4Nc4vx86PZdPgm
	 u/WIFoJA4MJbqBsRJZV2XTv0S46Z3xQ3vTNpo1WvkSb0M8aErLY4so3OR6wgXCW0bC
	 BrrTyLAmho4mXUJ2uUABD+0NsCyHVJEsCrg94flPMxsGZKD/L87+KbhsB5iJJXkooL
	 w+/LgGQWRUR1g==
Date: Tue, 10 Jun 2025 17:33:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool
 benchmark
Message-ID: <aEiWhUDsFskkcv46@x1>
References: <20250525034354.258247-1-almasrymina@google.com>
 <87iklna61r.fsf@toke.dk>
 <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
 <87h615m6cp.fsf@toke.dk>
 <CAHS8izNDSTkmC32aRA9R=phqRfZUyz06Psc=swOpfVW5SW4R_w@mail.gmail.com>
 <6fd8b288-2719-424b-92d2-3dcfe03bbaef@kernel.org>
 <CAC_iWjJcC7sK+71GVZHrXzPL=e3N_uFnKPnhSEi=PJkPwUywsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjJcC7sK+71GVZHrXzPL=e3N_uFnKPnhSEi=PJkPwUywsA@mail.gmail.com>

On Tue, Jun 10, 2025 at 10:41:49AM +0300, Ilias Apalodimas wrote:
> On Wed, 4 Jun 2025 at 11:39, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> > Okay, I think Ilias'es comment[1] and ACK convinced me, let us merge
> > this as-is.  We have been asking people to run it over several years
> > before accepting patches. We shouldn't be pointing people to use
> > out-of-tree tests for accepting patches.

> > It is not perfect, but it have served us well for benchmarking in the
> > last approx 10 years (5 years for page_pool test).  It is isolated as a
> > selftest under (tools/testing/selftests/net/bench/page_pool/).

> > Realistically we are all too busy inventing a new "perfect" benchmark
> > for page_pool. That said, I do encourage others with free cycles to
> > integrated a better benchmark test into `perf bench`.  Then we can just
> > remove this module again.

> I'll spend some time looking at acme comments. They seem to be moving
> towards the right direction

Glad that you think that way, and to add another perspective, 'perf
test' and 'perf bench' goals are to run in any kernel, not just some
specific one where a regression was fixed, so people running plain 'perf
bench' will run whatever tests we add and thus widen the tester base for
the benchmarks in there.

Being able to combine 'perf trace perf bench', 'perf stat perf bench',
etc is something common and powerful.

But then the most important thing is to have actionable and expertly
written benchmarks in place, that have been in use for a long time, in
whatever form :-)

- Arnaldo

