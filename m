Return-Path: <linux-kselftest+bounces-16590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15084963356
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 23:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EAF1C23CD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 21:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8961ABEBC;
	Wed, 28 Aug 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FytCoi/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56FA153814;
	Wed, 28 Aug 2024 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878836; cv=none; b=CE3GlRLv0keEuTfbZTXNmGPfF2w13isxjNMMma9eTHAzPxli5cWHBUIJpH31X4SPZRL71c5bHhMwscLm10CriXqIBCtaAiKv73tclw9wlzblpAABSTvaerO25B91BTcW0pMcFz3xAH7FS8CuoFk3o0qyAnYkaOUinsd0TwyCTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878836; c=relaxed/simple;
	bh=cL9LZVNKhm1Z3H3x4kb5PPTbtNB3t94LpmTa+2gYs6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVVWuyj72KTjkpJyb8teBDEShMaiQLA9AtR1ttMPQ4lTIlJT4QxPoFniWIeKB60nlf6SA52XUtDUoNmamxTeKaRBECS/d5xu4jnDxc7ST6PNQZpAV54CJgXPsjpyebCLLu1P1hPE8bK3Dv9xJoLOdGS784KqXmU9+uh8XX2Z47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FytCoi/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF20C4CEC0;
	Wed, 28 Aug 2024 21:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724878836;
	bh=cL9LZVNKhm1Z3H3x4kb5PPTbtNB3t94LpmTa+2gYs6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FytCoi/QT4vag7m9bGJU81+YcOFm6NdGWg+sTe3Rd9Is04thjGZjw90FWqgDD9fNj
	 ao75ctl/O74niodZImKzilQFPC4MWw6HqV9ZbSyQQJBtsTfZQmY7L4hgQGOfnQkN9D
	 a1RMjbwPByQ+T3kgvzfC5SKTLLcWAQD0Kn1whNDJJNYRv4jaV6GadyQMlBRx3rOUml
	 GZkwOO+cv35sYZxnuMZy5d/nPAhegvbn8eTFTRgzNHTpYLsw6tfyOeoWzygthsS6aP
	 XCrEeoVKPXLJHoZ0HAm9HUCNmL6zRBk5zmsuY1uK4mLuEDEOCNJrqodNNxFtem828a
	 w/WMp3/6jqJNw==
Date: Wed, 28 Aug 2024 14:00:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, ncardwell@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de
 Bruijn <willemb@google.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 martineau@kernel.org
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240828140035.4554142f@kernel.org>
In-Reply-To: <66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
	<66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
	<20240828090120.71be0b20@kernel.org>
	<66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 15:33:33 -0400 Willem de Bruijn wrote:
> That could work.
> 
> Is reporting one KTAP and exitcode per directory vs per packetdrill
> invocation good/bad/neither?

To me "neither", hopefully and unhelpfully I won't tell you anything
that's not common sense :) The balance is between:

 - having test cases which don't take too long (assuming debug kernel):
     <15min is good, 
     >1h I will start complaining,
     >1h30m is bad because we can't retry and still make the 3h
            deadline that NIPA has,
     >3h the test can't run in NIPA at all.

vs

 - flip side is having so many cases it's hard to keep track and render
   in the UI. JSON is relatively slow to process. If you have 150 cases,
   that's 300 per branch (debug and non-debug kernels), times 8
   branches a day => 2.4k results / day
   I think that's still fine-ish, but on the larger side for sure. For
   reference net and forwarding have ~100 tests each. FWIW we do have
   the ability to collect and display nested KTAP so the information is
   not lost (but it makes queries slower so we don't fetch it by default).

> Three other issues if this is calling packetdrill directly is
> - passing the non-trivial IP specific flags
> - running twice, for IPv4 and IPv6
> - chdir into the directory of the pkt file
> 
> That can be addressed by instead calling a small wrapper shell script.
> 
> That would do the test_func_builder part of packetdrill_ksft.py.
> But without the need to handle netns, popen/cmd, etc, and thus the
> ksft dependencies.

Right!

