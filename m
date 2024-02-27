Return-Path: <linux-kselftest+bounces-5467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606986878A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 04:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B87284942
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590FE1CA8A;
	Tue, 27 Feb 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWIAYWL/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B018B09;
	Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003429; cv=none; b=at2XYRHlc2PDY0v3z8gaGmiX3sc4BYIS8kBSgoQWbuEc67eslD8ty7+YWpTl9x87q4dOXOgyRdCM8dsEZXHMS/+s4Nz84QWBNGDYEZnL0FMMRzn/zBbvnqc/S2dLplPIITJF2KJrx14ulsslfPK24QDeXT7oTkOekSGAYdQk0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003429; c=relaxed/simple;
	bh=px+FzP8nHYq7W65Fl++IrzC/G4rPXKu6PG/CBccJBeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SBic70/OTNoTJ8LwlDBLvL+LyoKd+xUawglCl6V8GlUFPOOCAC+skIszRm7DP8Ej4muGEsP7mEUf1596tRrbJBuACDE3J3GVuEFbOdE8C6sgD73VxO/glet6S4qD6BB7AXCFFGABPqXqvwxIakBPbhkDa5be8klxau7YHLq3zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWIAYWL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3866C43390;
	Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709003428;
	bh=px+FzP8nHYq7W65Fl++IrzC/G4rPXKu6PG/CBccJBeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BWIAYWL/zqHVMNL1ygzCyT6lKrBpz+Lxi8Tf5I5nvYRdK10Ak0DIOtZIDrwZJHynD
	 QS+XzVVTtjxAraQTvsh6Jl2KP9OP8qSCIoo+mm8szah5m9z1B7yjy92dSg9JEJZyoL
	 daZJgcU8sHq1qkSnhgi5MJ0Tdzv0Mwk6SPZyjaB4BsEVz/rIemtjda0Ps7OBH4InbK
	 sdSvaEaY6J9SH3L1kl7L5vPngeHcpIBTxyQuMffpOqQ4jZt24ls8kOE24TjCNrm1EE
	 CO7Paqxc2PFMxPrOJTYqFVaLWepHr87UAEFTn+Zkyl22qs4S7XAE8DkizbtE2vSk92
	 tIxI/CeZvrx8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96D48D88FB0;
	Tue, 27 Feb 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10] mptcp: more misc. fixes for v6.8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170900342860.19917.16044337565928875958.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 03:10:28 +0000
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 fw@strlen.de, kishen.maloor@intel.com, shuah@kernel.org,
 peter.krystad@linux.intel.com, cpaasch@apple.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 tanggeliang@kylinos.cn, stable@vger.kernel.org, dcaratti@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Feb 2024 17:14:10 +0100 you wrote:
> This series includes 6 types of fixes:
> 
> - Patch 1 fixes v4 mapped in v6 addresses support for the userspace PM,
>   when asking to delete a subflow. It was done everywhere else, but not
>   there. Patch 2 validates the modification, thanks to a subtest in
>   mptcp_join.sh. These patches can be backported up to v5.19.
> 
> [...]

Here is the summary with links:
  - [net,01/10] mptcp: map v4 address to v6 when destroying subflow
    https://git.kernel.org/netdev/net/c/535d620ea5ff
  - [net,02/10] selftests: mptcp: rm subflow with v4/v4mapped addr
    https://git.kernel.org/netdev/net/c/7092dbee2328
  - [net,03/10] mptcp: avoid printing warning once on client side
    https://git.kernel.org/netdev/net/c/5b49c41ac8f2
  - [net,04/10] mptcp: push at DSS boundaries
    https://git.kernel.org/netdev/net/c/b9cd26f640a3
  - [net,05/10] mptcp: fix snd_wnd initialization for passive socket
    https://git.kernel.org/netdev/net/c/adf1bb78dab5
  - [net,06/10] mptcp: fix potential wake-up event loss
    https://git.kernel.org/netdev/net/c/b111d8fbd2cb
  - [net,07/10] selftests: mptcp: join: add ss mptcp support check
    https://git.kernel.org/netdev/net/c/9480f388a2ef
  - [net,08/10] mptcp: fix double-free on socket dismantle
    https://git.kernel.org/netdev/net/c/10048689def7
  - [net,09/10] mptcp: fix possible deadlock in subflow diag
    https://git.kernel.org/netdev/net/c/d6a9608af9a7
  - [net,10/10] selftests: mptcp: explicitly trigger the listener diag code-path
    https://git.kernel.org/netdev/net/c/b4b51d36bbaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



