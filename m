Return-Path: <linux-kselftest+bounces-8720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4819A8AF550
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795A71C21B07
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5542413E89F;
	Tue, 23 Apr 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS8NxxNr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1B13E889;
	Tue, 23 Apr 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892832; cv=none; b=ch61TaOlKmw1aPQPCzsBKaCjb0sBRF1OO8yAGtpkDg9ywAmmf4l/WF6wNfzEvWuvRz1PQ3EOUSNAdn+Y2hKBQEfo745MyTiT5QWPi6vv0z9FIjQ6BtFIvtUeqAqozrO5Uppgag2eKrA51seFCErw0QihPSiIJq4nEGSKNCiOOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892832; c=relaxed/simple;
	bh=Z7QR+SHpl/gGifsTZVu+t8eehk3c4rvqi3BBga9nqFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RfTLSPBJwl/vwgIQEgjlPn9UmKzq7IfoN0rUGzia4yk5XEgBkYMOgIIBARBY+LADyt5N7uUByemuWs+8khgSa2iitydWipZLAKndjU4sCRvNVtY4UhCjdqbbb78DdjGXaBKpuBoAuZRLGhq7J5+hQDogXK1TbzVOnTqVQHQkJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS8NxxNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6189C32783;
	Tue, 23 Apr 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713892831;
	bh=Z7QR+SHpl/gGifsTZVu+t8eehk3c4rvqi3BBga9nqFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pS8NxxNrbCDZmabKWjaifMrR90eLE7G+qdfH4l2xq49W8iMut5Bg16T4dFwGjYHGi
	 j0YD7EKUcAWjBbnLkdBOzmZBZ++fFD6iVvEm4vVPjBEBn10qCUaNU/ph2+dZc1lisD
	 TweWVOMVe2it048diuF0X87zbLSKr8PSBcIAkSCaa19uc9c9jcb6WRI6n2EBPgkai4
	 2FH70t6C8GsdlZfobaKDoCwA67hFTsIYwKGE1Ex7GewJiTg7eEGWRM23otW0+XwrNW
	 y60SxUvsvs1Tc9MyWosnXVmQHfjS1XogdWpijwzgFfeGPiVE7/GVplYcU4YPPuDxmg
	 ZKSsLHOUDpMXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9779ADEC7DE;
	Tue, 23 Apr 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/7] selftests: drv-net: support testing with a
 remote system
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171389283161.853.7024600173174384381.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 17:20:31 +0000
References: <20240420025237.3309296-1-kuba@kernel.org>
In-Reply-To: <20240420025237.3309296-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Apr 2024 19:52:30 -0700 you wrote:
> Hi!
> 
> Implement support for tests which require access to a remote system /
> endpoint which can generate traffic.
> This series concludes the "groundwork" for upstream driver tests.
> 
> I wanted to support the three models which came up in discussions:
>  - SW testing with netdevsim
>  - "local" testing with two ports on the same system in a loopback
>  - "remote" testing via SSH
> so there is a tiny bit of an abstraction which wraps up how "remote"
> commands are executed. Otherwise hopefully there's nothing surprising.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/7] selftests: drv-net: define endpoint structures
    https://git.kernel.org/netdev/net-next/c/1a20a9a0ddef
  - [net-next,v5,2/7] selftests: drv-net: factor out parsing of the env
    https://git.kernel.org/netdev/net-next/c/543389295085
  - [net-next,v5,3/7] selftests: drv-net: construct environment for running tests which require an endpoint
    https://git.kernel.org/netdev/net-next/c/1880f272d2f9
  - [net-next,v5,4/7] selftests: drv-net: add a trivial ping test
    https://git.kernel.org/netdev/net-next/c/a48a87c08664
  - [net-next,v5,5/7] selftests: net: support matching cases by name prefix
    https://git.kernel.org/netdev/net-next/c/01b431641c33
  - [net-next,v5,6/7] selftests: drv-net: add a TCP ping test case (and useful helpers)
    https://git.kernel.org/netdev/net-next/c/31611cea8f0f
  - [net-next,v5,7/7] selftests: drv-net: add require_XYZ() helpers for validating env
    https://git.kernel.org/netdev/net-next/c/f1e68a1a4a40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



