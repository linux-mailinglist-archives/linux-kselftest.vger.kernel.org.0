Return-Path: <linux-kselftest+bounces-10702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F058CFD79
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8165328124F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2913A897;
	Mon, 27 May 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjE/MciA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A713A3EE;
	Mon, 27 May 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803430; cv=none; b=LCBNH7W2aJiKP1wR6t/PYkxxTOSuT/lWk4aJ+OFDDOYLQG6e4+Ms5IGivoKT3EzPUmCweVL/5bVizlZzuRGVQUJ0v3KIq3Juiohtmu823rmh9sGx+lVE6eELWA8gtN3O44HHMmcH6XMoR1igpyltddNqNP1HVWaEAXNXd4hRy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803430; c=relaxed/simple;
	bh=0smEWZUcHc4G3cjHvHQ3IFsN8QKSZlpvIGcCkE29fTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4cYM1oS/WARzvcFbF5UFYlOcTpbQcczDRx5h4+wAHawR9hnkakliCdNywjfj2oyyvBjSwCSuqb0dS3w3H1gBpqFANe4lpGtRrZNntKLIWSfD8cose6OEoZ028qp6gGi37djqyoovuR5Ao12Tb1UiQbMmrxT0uhHzK/F0G9sg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjE/MciA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4A08C32789;
	Mon, 27 May 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716803429;
	bh=0smEWZUcHc4G3cjHvHQ3IFsN8QKSZlpvIGcCkE29fTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kjE/MciAffYuOpiBGeOY66jjaCBHzCzRjxnksb23t48SFh2h2hBkNqDILnmxRm1xE
	 3hlwZGtmGLVh6VyRATW8rpqIX/keztu6hoXVF4fA2XdCpqyhos37RurL3GiMUVJMDF
	 In3AhZ6AJKTVIT14Q2695ESZcoH83m1Krcj3Ck6p9lGbIALl7OkLobsCBVp30dA1rX
	 bmqTqJUweZlRzAVQ7KtNKQVIzr1iPoIuRqTJU07/3y4HfEMVqnXcGjCA0e//emfBmy
	 gu1bQzfjb6VUZ4jFNWu7QVwN9X4Js42i+/5NuKcyVRZLcUeQu9J/ooM1KtcpuMzjoo
	 bD2u+6h1eksNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F16ED3C6E3;
	Mon, 27 May 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: hsr: Fix "File exists" errors for hsr_ping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171680342964.8026.8613932471428601375.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 09:50:29 +0000
References: <6485d3005f467758d49f0f313c8c009759ba6b05.1716374462.git.tanggeliang@kylinos.cn>
In-Reply-To: <6485d3005f467758d49f0f313c8c009759ba6b05.1716374462.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, bigeasy@linutronix.de, lukma@denx.de,
 liuhangbin@gmail.com, tanggeliang@kylinos.cn, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 22 May 2024 18:45:04 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The hsr_ping test reports the following errors:
> 
>  INFO: preparing interfaces for HSRv0.
>  INFO: Initial validation ping.
>  INFO: Longer ping test.
>  INFO: Cutting one link.
>  INFO: Delay the link and drop a few packages.
>  INFO: All good.
>  INFO: preparing interfaces for HSRv1.
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  RTNETLINK answers: File exists
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.
>  Error: ipv4: Address already assigned.
>  Error: ipv6: address already assigned.
>  INFO: Initial validation ping.
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: hsr: Fix "File exists" errors for hsr_ping
    https://git.kernel.org/netdev/net/c/21a22ed618d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



