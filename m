Return-Path: <linux-kselftest+bounces-3883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4541D844945
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C3828BFAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2438DDA;
	Wed, 31 Jan 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkoNaWmf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C564381D5;
	Wed, 31 Jan 2024 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734705; cv=none; b=C6iDQ3BZxT7wkxAvdBdLdJb2nCl+gjBiKPitBbPL9EeiFBnhgc0Xv+r9aIaw5Phf0DI5ZGnHM4Df9ivgyr8wgOqwVVsOjSLSKlBhWLdGnkf+7UiwahxHeUk13hE3m1PAuGVTQD+rNb9swAHcXeigCNQ94nn3lEjeOxVHYwJcYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734705; c=relaxed/simple;
	bh=gyOhcf/Vm2mCHkLNYWuIU8Ou+fslgXdSrn2CgcGmisg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDStPyFxf1iJVFvWJ6kO/DvoHOJ4++7Dll6T9+uCnuHpTb9I3WCnokUCkrvKU39jlvXgM1RJRJPy5zpVtqBMngbhBFzEP9Ik6fZy3nBt8fWKgFQdbL6ANw9OVJz/ZknlNXpfKmizn86VHIOa+J38J92WeRmXdpZdTESjH4D4Kn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkoNaWmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E272C433C7;
	Wed, 31 Jan 2024 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706734703;
	bh=gyOhcf/Vm2mCHkLNYWuIU8Ou+fslgXdSrn2CgcGmisg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NkoNaWmfrpYg+4AyQqhnI2nYBiT/bsFjknGDQIZHvhn0OnLokyl/fftjpp3nNGYRE
	 UMUYVo5E6MkfeIcFJSfVeEhkvqIxqOBlc/cJqvOqfDJejDapFQ+9AoZW4VaJfMMYG1
	 cc2ew5svOexWJjxg+R4yFaqvJQp3OCjT3f8VLiRfqYH2hmpoqMPqpT3vh3j5hiJToM
	 Brt2DFa5gvqB016mVieLK27ShntAAsFqT8LNPNq9kQvahBVOFjif63dD2UCCrUx6Ie
	 ntROMqUOwHCEuEdxg1kH3mGQd9wSx4Y1lDGnqZSR1M7WYoTpFSazCaZD/j4EPF7Z0z
	 bCIfrnxIBjg5w==
Date: Wed, 31 Jan 2024 12:58:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
Message-ID: <20240131125819.25c7c372@kernel.org>
In-Reply-To: <65baad3627cef_1b52d2294bc@willemb.c.googlers.com.notmuch>
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
	<20240130174736.03c79071@kernel.org>
	<65ba61ea978b4_1699fd294eb@willemb.c.googlers.com.notmuch>
	<20240131102932.6caac1e2@kernel.org>
	<65baad3627cef_1b52d2294bc@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 15:27:34 -0500 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > +1 I also think we should run and ignore failure. I was wondering if we
> > can swap FAIL for XFAIL in those cases:
> > 
> > tools/testing/selftests/kselftest.h
> > #define KSFT_XFAIL 2
> > 
> > Documentation/dev-tools/ktap.rst
> > - "XFAIL", which indicates that a test is expected to fail. This
> >   is similar to "TODO", above, and is used by some kselftest tests.
> > 
> > IDK if that's a stretch or not. Or we can just return PASS with 
> > a comment?  
> 
> Flaky tests will then report both pass and expected fail. That might
> add noise to https://netdev.bots.linux.dev/flakes.html?
> 
> I initially considered returning skipped on timing failure. But that
> has the same issue.
> 
> So perhaps just return pass?
> 
> 
> Especially for flaky tests sometimes returning pass and sometimes
> returning expected to fa red/green
> dash such as 

Right, we only have pass / fail / skip. (I put the "warn" result in for
tests migrated from patchwork so ignore its existence for tests.)

We already treat XFAIL in KTAP as "pass". TCP-AO's key-managemeent_ipv6
test for example already reports XFAIL:

# ok 15 # XFAIL listen() after current/rnext keys set: the socket has current/rn
ext keys: 100:200

Skips look somewhat similar in KTAP, "ok $number # SKIP" but we fish
those out specifically to catch skips. Any other "ok .... # comment"
KTAP result is treated as a "pass" right now.

