Return-Path: <linux-kselftest+bounces-48657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F75D0CBE8
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71F80300996F
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F9238C2A;
	Sat, 10 Jan 2026 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJVqN2c9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B482A1CF;
	Sat, 10 Jan 2026 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009427; cv=none; b=YX3KPBjvFNNZHPLGgZrjGHetL9BK/7lg2aFnf/7CeCycklUxWC/mbAdR7ZZmvJh91ZS9tXRGtndByw2ZoDymC26RsPD2VzaQVKRE6zBLhuuZx217olk0IqglJKD8bm/6yr6EiYTrZsJ5J61r50QlsXV5v46dYgjwqfJW0VpESPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009427; c=relaxed/simple;
	bh=riWkFrd0xPf9IiM00YFVeQ6M5jQu5sLb1WWKoSTPEEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IZDmo9V2RIdbOk4XFBy7NTCbzk/yyAHjD6AUH5PoKon/Y7O4+RWiT8p/XNzsC65jb3W/pdieUH9KO40krnsL+LMyK3IxQlaNpQdAZFmaRHnJ/3Pl4KZ+Iie1WN68HZfSnSC511/gBou/jGguy0j5bZ7IUPjx1uBVnbV1LyIR7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJVqN2c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61499C2BC87;
	Sat, 10 Jan 2026 01:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768009422;
	bh=riWkFrd0xPf9IiM00YFVeQ6M5jQu5sLb1WWKoSTPEEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AJVqN2c9+oMwihnYVUhWMs1x9TKFCABArStflSYftUpcqJJCTWSS8KvBN77oxyFEe
	 vefJuBcf4cQcFsqozCgx7nrK98h7AIB1AzgGb4j5BUUeAodPniFghM//HsgAf+w73/
	 nZSMWlXllE7A4eusgcmkCZgB45OGoEiIV7jiRytRYAvvFiQ0wcQRWGls5DbNg+lyGn
	 JVv28ygv0tvi94oAGW2TbxH3t0HVVPgyhvsnSwzNuZhV6hQibD1v20ZkatBtYS8wgD
	 KO3knAeC/NRraCdHfHBaWzt07MpBzZyPn/B4dveWHbnoRKj3qMvoDZ8vHHHcKKEcOV
	 hKOhnUvr90Ulg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8233AA9F46;
	Sat, 10 Jan 2026 01:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: tls: avoid flakiness in data_steal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176800921779.446502.85232767075015345.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 01:40:17 +0000
References: <20260106200205.1593915-1-kuba@kernel.org>
In-Reply-To: <20260106200205.1593915-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sd@queasysnail.net, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 12:02:05 -0800 you wrote:
> We see the following failure a few times a week:
> 
>   #  RUN           global.data_steal ...
>   # tls.c:3280:data_steal:Expected recv(cfd, buf2, sizeof(buf2), MSG_DONTWAIT) (10000) == -1 (-1)
>   # data_steal: Test failed
>   #          FAIL  global.data_steal
>   not ok 8 global.data_steal
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: tls: avoid flakiness in data_steal
    https://git.kernel.org/netdev/net-next/c/96ea4fa60c45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



