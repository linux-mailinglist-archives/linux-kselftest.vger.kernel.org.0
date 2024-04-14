Return-Path: <linux-kselftest+bounces-7926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE2D8A43B5
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC5EB2254E
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F539134CEA;
	Sun, 14 Apr 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0pTNk6c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0774204F;
	Sun, 14 Apr 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713111027; cv=none; b=eedKxIAOK79S5vLMQJIf7tIPqbMogxJSjMnXg2KeDJMbUMpeuUiAIZ2zpXoKkm3Fw0RLbEtw5TIQrBB6ipeqAJQYet3uy8Z8JSKwcdI0REyUTryFCObfcVlc+gQhniw6G8gRfx6+Qc2Wo9iBF3HktGi/1v6wKkLZk7BEGpG4x6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713111027; c=relaxed/simple;
	bh=GQ91brGH7ot9MixWssd4TprxKrsg8x2E2K9LgthC60A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bhWbRbs5OaRH5yZ9XjBoile1TuwlkxWlESTEUEUYj5E/CYybERVgTYSpZI2p9JbdEr1D7Jph5uIGj4Xium4Y2pdggit5QobodO8+tvVDPLeBZjc2QHqL6s1Az5WCZ3ytEStPUaOMvC4+7nlRtG4pZ1YR4mgAeMGrRp0KSEqG/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0pTNk6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73B32C2BD11;
	Sun, 14 Apr 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713111026;
	bh=GQ91brGH7ot9MixWssd4TprxKrsg8x2E2K9LgthC60A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l0pTNk6cS78Qen0Foka219q73WeB9WHPAPcFZr4c7CzeiaR1OABqbKkZGvUF35NkT
	 9PoETL6kCQ4KGsqeup9WSJab2Y3b8uBqj2Prqzc5wZrHkHWHFP9UQNW+emSMt6HCZn
	 KC86XEGDeUtpu0marwLsJJq0bDK2AlW8/l085iaL7VPrFOHKWy6fux1mirQYBowpK2
	 9z/UDcrGBI8yVadtobpw1Pcw2HCzI2bqcNndilCQ7WYsRS9rUcFZEq/5sh6luq9Sy3
	 R8ubmJkGl0jiRU7kQ8sbrc/+OS6CI1pNtLSMOgkwVlVr9GdZRVd88zsKc/hOcGWA/g
	 ukhLa6d30DqIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D985C32750;
	Sun, 14 Apr 2024 16:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] net: change maximum number of UDP segments to 128
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171311102637.24550.17026723901858878369.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 16:10:26 +0000
References: <20240411051124.386817-1-yuri.benditovich@daynix.com>
In-Reply-To: <20240411051124.386817-1-yuri.benditovich@daynix.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, yan@daynix.com, andrew@daynix.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 Apr 2024 08:11:23 +0300 you wrote:
> v1->v2:
> Fixed placement of 'Fixed:' line
> Extended commit message
> 
> Yuri Benditovich (1):
>   net: change maximum number of UDP segments to 128
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: change maximum number of UDP segments to 128
    https://git.kernel.org/netdev/net/c/1382e3b6a350

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



