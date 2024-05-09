Return-Path: <linux-kselftest+bounces-9822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EC8C158D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0FF1F231C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70E7F7FD;
	Thu,  9 May 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+JaM5eI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B1C2ED;
	Thu,  9 May 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283628; cv=none; b=gyjI/yTAcY51ZleRallq9F6HyovocZAZIC89iDNkahMNMRM07F00O0gpyLrl6rSdUd7Pd550jcWADWC4jXU48VS99twVDk7skzqHfK7NmV9X0mpWJz14Y2ymcVtZaZ7AhkZT79gs7XY8RdM54F9XO86m85v4r76Jlnd+HAp6P5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283628; c=relaxed/simple;
	bh=Syz/ozW0y/v/oKXIKjLMnVSPKSibcKLyKO5odXaFv5c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UECFDFQC/UoWPEIpZVoFevSrBnTvRoSLgQBzwulnMgE7lqjg0n23e+JUP3crlihz1TKjmcy6+b5MgZjLKXf5Sbv2jI7LBcBtEVErVFMHBngzSMeT0NDOAolDhD9IEYZmX9jRrANuODHlujJQ/BV+Y6xti77HLPDXK7u0O4octpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+JaM5eI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD569C2BD11;
	Thu,  9 May 2024 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715283627;
	bh=Syz/ozW0y/v/oKXIKjLMnVSPKSibcKLyKO5odXaFv5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O+JaM5eIlVp2yLYxugQQqCoG8H6myYok97rVKYOsGBk1GBfEzKPtt+Ex7Pxh8AvN2
	 7iEdZ7gMbZNCu9mt/xMocuWKpTwU692ccszj+SHp0cydXNWCE2p9DMdMn0Ctr4Y0zM
	 LbceWKzYIBUUFxjcDugUXd2v8omx1ZGoMzEGcqKi3+Ootg/A3SDQdvd/imB6tqJdnv
	 UHqa9x/gMsXZ7mvSKDj6RSpZftD0jcRw4+Ti30k5G/N92vfNKjwSaB7M/EH1k+iA3U
	 s3Zi3YG6afo8C7s6+DmTHv72leE0bCLeAX8c3SNk/+S69hbjluRrXqced11UPbABoX
	 Rg4lpbn4kExXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC707E7C0E0;
	Thu,  9 May 2024 19:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH REPOST net-next v3] selftest: epoll_busy_poll: epoll busy poll
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171528362770.20134.14528995105510778643.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 19:40:27 +0000
References: <20240508184008.48264-1-jdamato@fastly.com>
In-Reply-To: <20240508184008.48264-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 May 2024 18:40:04 +0000 you wrote:
> Add a simple test for the epoll busy poll ioctls, using the kernel
> selftest harness.
> 
> This test ensures that the ioctls have the expected return codes and
> that the kernel properly gets and sets epoll busy poll parameters.
> 
> The test can be expanded in the future to do real busy polling (provided
> another machine to act as the client is available).
> 
> [...]

Here is the summary with links:
  - [REPOST,net-next,v3] selftest: epoll_busy_poll: epoll busy poll tests
    https://git.kernel.org/netdev/net-next/c/60e0f986e89f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



