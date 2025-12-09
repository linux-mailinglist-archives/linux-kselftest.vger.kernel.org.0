Return-Path: <linux-kselftest+bounces-47299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383CCAFD50
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 767F13011F9B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94772E6125;
	Tue,  9 Dec 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ0ReMh4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929521D3CC;
	Tue,  9 Dec 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281199; cv=none; b=FOtpdpxGfljgCusaNuEhiSk0njBsP/Ncdkg+PJg7tZ3fjFcGlPubk7UWn+o3biV5GRl5fjq9sdbIsIeNSLQMB0eanCtzsgoMWjrYwNkpSyoTzEcckdBv6za/ITR7IxBZrbtEKsH8Yj8c//AIB3mkJHiL8zmzlQfBa4OQxFIgAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281199; c=relaxed/simple;
	bh=L0g662WB0mVl+WAkbemEVpXhr6ChDipHoLJVsRbGaPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=krFhl4zwig7tkI6o87+TZieiAz5FoBr14iGEBdVunYgZx2H0VV1iHwW9k1GnpoixaupRBFtGcEcTMGcjLQ/TZsKmGoNS87VUGXNuF/BYSy2dV+BdpNDDCZrPZHLz0Qyxr+Q3gA02xv8NRyC+NvlPjKdQFwILC/TwGu9U6/Q02J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ0ReMh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12252C4CEF5;
	Tue,  9 Dec 2025 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765281199;
	bh=L0g662WB0mVl+WAkbemEVpXhr6ChDipHoLJVsRbGaPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mJ0ReMh4GUErEMC2XYEcSamkeS0rELjBZjfI6Y7kOzQ1/WlzGNGXarqFNJt83Y33H
	 xf/RlYFOA0j86PtSMgwY1hzVQzWKUkRqyABakTKrB49+EpEIrUpw5zEs+rEg+lltv7
	 2wEWcgYxFl13fsZoAv8WO6bl+A7GCBPjndKOHYr/2dbx31CqgzkKGGsrcJ5VQnpC62
	 n3kyetk+uujbrQDhtJ8DwSqUY7eJWrVSCV8FoS5bCALCXzOymJ49Rdb/ECn9mqNGkp
	 Ydt7bZ4YlnpS0Ygo3/Ps9TvyqbNyndt3b5HB+f3BOxGG9OPDmS5HXHsOVnE2oUNbS6
	 FMaH+BMnv6Gsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7888C3808200;
	Tue,  9 Dec 2025 11:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: misc fixes for v6.19-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176528101428.3919807.13662926558612296874.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 11:50:14 +0000
References: 
 <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
In-Reply-To: 
 <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, kuniyu@google.com, dmytro@shytyi.net,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 05 Dec 2025 19:55:13 +0100 you wrote:
> Here are various unrelated fixes:
> 
> - Patches 1-2: ignore unknown in-kernel PM endpoint flags instead of
>   pretending they are supported. A fix for v5.7.
> 
> - Patch 3: avoid potential unnecessary rtx timer expiration. A fix for
>   v5.15.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: pm: ignore unknown endpoint flags
    https://git.kernel.org/netdev/net/c/0ace3297a730
  - [net,2/4] selftests: mptcp: pm: ensure unknown flags are ignored
    https://git.kernel.org/netdev/net/c/29f4801e9c8d
  - [net,3/4] mptcp: schedule rtx timer only after pushing data
    https://git.kernel.org/netdev/net/c/2ea6190f42d0
  - [net,4/4] mptcp: avoid deadlock on fallback while reinjecting
    https://git.kernel.org/netdev/net/c/ffb8c27b0539

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



