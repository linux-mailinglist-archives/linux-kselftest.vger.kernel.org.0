Return-Path: <linux-kselftest+bounces-17434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1974A96FEA3
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 02:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93D01F235D0
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E43367;
	Sat,  7 Sep 2024 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1Sl8s2T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFD1849;
	Sat,  7 Sep 2024 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725667498; cv=none; b=uhpwZ5kkrcD+mwCFqs2koiZ6svdeRMTsKQMI/YG5s3L830XLVNUcklnu4HYjKNxe9PYLkq/IkEp+zOnRs66xLklF7tGoqFA/GT1XpVMUb40XxBMZe3zmKr7uVAmwEMyEglnrqVZ9W+HXWgjAzLvrUKxcyA+HSO/3BF/4rrNqR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725667498; c=relaxed/simple;
	bh=N3Qp7GYKSnKVy7AjygjC5ryaFvEImrqncE6zc0RiV+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/U4eGKUczI6Ip6xM+7ktt8jZ6ePBI30bdniMKPq+cH8rdEdcZtYJj8ZeEdPMml5x1TzRDY0d6t9P4OkLipbtn5b54c7N5yKQuH4gFdWbkD1IIMZeoTHP8xYhUIzg70h7jU95TQ7bsI64WSuvNilw9I4xhA/P9mBjqOfpN6BzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1Sl8s2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163E7C4CEC4;
	Sat,  7 Sep 2024 00:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725667497;
	bh=N3Qp7GYKSnKVy7AjygjC5ryaFvEImrqncE6zc0RiV+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G1Sl8s2Tp2lMZrfSIGw7e3IhHdYJ2y1CUFi7BvF/v9uTD2NdXOdKfdlcVDJkUqhZZ
	 gippSNSBxlxRpIiFXquf19LBB0TizRdE0W3ODH9vRWDgflFpa/MJVno0LWfIqeV/og
	 JdqRegxss3PgybVq1tyh0ru0VDfAdWOSM4sxd6lvtmwaUg42dCtbaKaiE2HH+AnZBx
	 4d5MZYq8uoQyx9EFfpB2jhQGGHhnWUsoUrW5UahAVLpntl4paZYTAADfQveFLYl8CI
	 GSZYoJq7ahzrkMXHFHDTFwAkKchs21kaIW0eqxbt+VFK47rN5T+hPo9VzmLKcxw6NV
	 cD2lKLYVGGj3A==
Date: Fri, 6 Sep 2024 17:04:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ncardwell@google.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 fw@strlen.de, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 2/2] selftests/net: integrate packetdrill
 with ksft
Message-ID: <20240906170456.5a113628@kernel.org>
In-Reply-To: <66db9008e0b4e_2a33ef29428@willemb.c.googlers.com.notmuch>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
	<20240905231653.2427327-3-willemdebruijn.kernel@gmail.com>
	<f63e7367-c4fb-4cdc-a44c-6accbc309c5a@kernel.org>
	<66db217a558c4_29a385294d3@willemb.c.googlers.com.notmuch>
	<ad780c53-9538-4d3f-a02f-1063828fc035@kernel.org>
	<66db9008e0b4e_2a33ef29428@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Sep 2024 19:28:08 -0400 Willem de Bruijn wrote:
> > > No, we opted for this design exactly to use existing kselftest infra,
> > > rather than reimplementing that in our wrapper, as I did in the RFC.  
> > 
> > OK, I understood from the discussions from the RFC that by using the
> > kselftest infra, the tests would be automatically executed in dedicated
> > netns, and it could also help running tests in parallel. That sounded
> > great to me, but that's not the case by default from what I see.  
> 
> Perhaps that's something to change in the defaults for run_tests.
> 
> Since the infra exist, that is preferable over reimplementing it for
> one particular subset of tests.
> 
> Or if not all kselftests can run in netns (quite likely), this needs
> to be opt-in. Then a variable defined in the Makefile perhaps. To
> tell kselftest to enable the feature for this target.

Indeed, I was thinking along the same lines.

We're closing net-next in a week, it'd be great to have the baseline
ksft interpreter mechanism in place in the next couple of days. 
The exact implementation of packetdrill/ksft_runner.sh can be changed
later as needed, and the current one works fine for NIPA.


Hopefully we can also discuss at LPC/netconf what to do about libraries
(where setup / cleanup code could live). Looking at MPTCP tests - do
they work out of tree? I see mptcp_lib.sh does:

. "$(dirname "${0}")/../lib.sh"
. "$(dirname "${0}")/../net_helper.sh"

but lib/sh and net_helper.sh are not listed in the Makefile. So they
won't get packaged...

We should make sure we support running the tests with make run_tests
and in installed mode. 

If we agree that the current situation with support for library code is
far from ideal, I think we have three(ish) directions to explore:

 1  build netns handling into runner.sh
   + already mostly there
   + simpler tests, no need to worry about netns, it just happens
   - not all tests need netns (HW-adjacent tests especially)
   - netns setup is the main thing we need but not the only thing,
     wait helpers, python code, etc. also need to be handled

 2a improve library bundling at the ksft level
   + we already have a net/lib "meta-target", it kinda works
   + hopefully in a way that lets us Python
   - no idea how

 2b put all the code in kselftest/, like ktap_helpers.sh ?
   + easy to do
   + helps other subsystems
   - could cause git conflicts
   - won't help Python?

 3  give up on target proliferation; on a quick count we have 15 targets
    in ksft for various bits of networking, faaar more than anyone else
   + fewer targets limits the need for libraries, libraries local to
     the target are trivial to handle
   - ksft has no other form of "grouping" tests, if we collapse into 
     a small number of targets it will be hard to run a group of tests

