Return-Path: <linux-kselftest+bounces-40664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D690B410F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B754120A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081E72EA48F;
	Tue,  2 Sep 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVQVKfbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F6274B51;
	Tue,  2 Sep 2025 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857003; cv=none; b=FVoNIY09SqN5ld/WxbOTOMEfAzkd7YVXhva8MhtEGXSARC+22jLuo6ZfFilpu/xrKMzj1nZiRBwWwwKEz5bQHHWKdCeM+cYkCRfkjnAl2A/5+5dUKezXqoM8NgKXS5R/zCJoE6OGhTGZPhE2iTec2rqi3G4fK1oMLrN1LlKx2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857003; c=relaxed/simple;
	bh=9U/Ky3yNBRcz05JV+fG2x+dIoICYXW+AY/iTU6QURg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SzZhR7bhRdCbjt9RQ0Q6tETJbpEhQk8gN4TNiiBj09aip/jA6w4FFP9wDZXGk6PrKIXuSa8Q+exy4mv4Mroil4ANrcje8nT2aLa9C/+jHlh/sJazZ3UXLmWLAXCaxKvijSA6KjPeQSaeG1gKb+0y069PO+dKzRDTTmjZhzQZNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVQVKfbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61010C4CEED;
	Tue,  2 Sep 2025 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756857003;
	bh=9U/Ky3yNBRcz05JV+fG2x+dIoICYXW+AY/iTU6QURg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mVQVKfbujn2yIKsWpUWu0HfZK5lXywIRNh41oCjg1j/LwCt2Y7j6iGtIF47b+nlcK
	 2776UmA/k/OIQ9lAvzFmDvUN1co+SKrLpsJqcOaG2bqWNSZbL9zdP3m+bwgTNjNd+J
	 n+qiwarDkeYyzcbBkFfyNkHGO8Ax7eLKg++ylQTU1NRxa7GcdJGQW60jjulnw6UQHJ
	 Vi7ZHg/1ktR08m33ZPq5EVhzMBtI0yAlV7Jf1axhC2aAM4eg70ZkDSzNaXzlxiEMi4
	 QrHBqmN/ZdntaOtBFy38Y3vld6TWfXyDTxStwZMOKMzIiJpAX0rLdAhxc3uARxK4Ov
	 6tVAyoK/PxBdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2C2383BF64;
	Tue,  2 Sep 2025 23:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: rss_ctx: use Netlink
 for
 timed reconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685700877.471478.8564578752631875348.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:50:08 +0000
References: <20250901173139.881070-1-kuba@kernel.org>
In-Reply-To: <20250901173139.881070-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ecree.xilinx@gmail.com, gal@nvidia.com, joe@dama.to,
 linux-kselftest@vger.kernel.org, shuah@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 10:31:38 -0700 you wrote:
> The rss_ctx test has gotten pretty flaky after I increased
> the queue count in NIPA 2->3. Not 100% clear why. We get
> a lot of failures in the rss_ctx.test_hitless_key_update case.
> 
> Looking closer it appears that the failures are mostly due
> to startup costs. I measured the following timing for ethtool -X:
>  - python cmd(shell=True)  : 150-250msec
>  - python cmd(shell=False) :  50- 70msec
>  - timed in bash           :  45- 55msec
>  - YNL Netlink call        :   2-  4msec
>  - .set_rxfh callback      :   1-  2msec
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests: drv-net: rss_ctx: use Netlink for timed reconfig
    https://git.kernel.org/netdev/net-next/c/4022f92a2e4e
  - [net-next,v2,2/2] selftests: drv-net: rss_ctx: make the test pass with few queues
    https://git.kernel.org/netdev/net-next/c/e2cf2d5baa09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



