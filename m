Return-Path: <linux-kselftest+bounces-35807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11BAE932A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 02:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73B43BF9F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 00:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951117741;
	Thu, 26 Jun 2025 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjpIM1nP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C323632;
	Thu, 26 Jun 2025 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750896186; cv=none; b=kJtNA8jYGsXfMHHNyZcTai7ebUrenRfXntZM8Nb4blmv+dvaauDXhxez/FJlEaiROImFTupeidl4obwPli8Z66FiY10tNJyiDRq3W7BPjSsOGQxBrAFjmVNPPVFL3oe2trMCMWVN7MfadTjWJQmIkA73C5TZ8hoythc67Z3htbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750896186; c=relaxed/simple;
	bh=HFABuNEHPaIbAc/UUw5gXaFLGDkRMZ3J6W8qys/2QS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O69itcvp8yKruk3C/BDT0Kk+ULs+khGtJenoBGl0H8d6O/u2xkYpfThk1Klk8MxKVSSlKaRDKfg3aDjU8EjXuyj8ipb363mP0R5yBAs+qwGZqonuI+ZS9NZd/BcasqBPuStBgWxP8rAJgXc19MevSwgxaHJMEi+69KgczPYk+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjpIM1nP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A5C4CEEA;
	Thu, 26 Jun 2025 00:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750896186;
	bh=HFABuNEHPaIbAc/UUw5gXaFLGDkRMZ3J6W8qys/2QS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mjpIM1nPX+8JXarTqqg6V54ut4TV9xc3ShADtdN1fA9WJ8vzGaW4gb8Y0L8Xxinbq
	 LEILzopNYzG9XnSNilHoQ0L/NgoEh4/vYKAAU9dsZFLCOg7yfYhS8fjzq2KAL+9o8W
	 2sD7DgLWR46G5HPjxYtR/S/O77QRU+Mp+4jJCuRHtfqx1T4E5Zx0cEC5Ac7TtccOdJ
	 abqHdwmqTKl3MFC62LbX7knQNJF05TkSrpJQckOKFORfhVErI6R//hndNxam8E/gFg
	 NfLX/AwIjySgGXKgnkdzCc2XGJJoDnGhYt1Jc6NyY0++eGdnyeOt+0WRdB/z/+i8bC
	 6VJQRvr1OJGLw==
Date: Wed, 25 Jun 2025 17:03:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 hawk@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 ilias.apalodimas@linaro.org, toke@toke.dk
Subject: Re: [PATCH net-next v5] page_pool: import Jesper's page_pool
 benchmark
Message-ID: <20250625170305.40d8c27a@kernel.org>
In-Reply-To: <CAHS8izMPWjmxLWJr+BSqd5jamsFHDOm71NkG7fmm-78SkLxQTg@mail.gmail.com>
References: <20250619181519.3102426-1-almasrymina@google.com>
	<175072801301.3355543.12713890018845780288.git-patchwork-notify@kernel.org>
	<CAHS8izMPWjmxLWJr+BSqd5jamsFHDOm71NkG7fmm-78SkLxQTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 16:45:49 -0700 Mina Almasry wrote:
> Thank you for merging this. Kinda of a noob question: does this merge
> mean that nipa will run this on new submitted patches already? Or do
> I/someone need to do something to enable that? I've been clicking on
> the contest for new patches like so:
> 
> https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2025-06-25--21-00
> 
> But I don't see this benchmark being run anywhere. I looked for docs
> that already cover this but I couldn't find any.

Right now to add a new TARGET one needs to have SSH access to the
systems that run the tests :( The process of adding a runner is not
automated. But this will probably need even more work because it's
a performance test. We'd need some way of tracking numerical values
and detecting regressions?

We have a vague plan of moving NIPA out of Meta owned systems.
We may want to wait for that before we tackle performance-like tests.

