Return-Path: <linux-kselftest+bounces-45159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C4EC4255C
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 04:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626A63BF657
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 03:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F872D12EB;
	Sat,  8 Nov 2025 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+t5yeXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C532157480;
	Sat,  8 Nov 2025 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570857; cv=none; b=jN6LQcqAR/SUwZJ2ZTIN9bnqxOa9m+xMPRCCxdfapLx6s4XinAU9edL6LoRjz1r/FmfEa7pVUkyAlvSJByF+T5ddWWLn8JiQiP+YQjSh/X1+S459PFa1ImxH/tApPk5VP6+kfG5k/yzAOYe+JXA5xwsAqxAVkSLU1y0IJGdbujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570857; c=relaxed/simple;
	bh=CUXQiIM5wXxbV4Y3PP9of7ywamF06vsv9AbLzFNpXZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kpXTnRTwBr3LioNwX7N5moVTH6GbO2vzcO9gLWNRYhpgZuQGJ2ms8Xzq41wFdca2qfgx2nur5YRItKX62CW58h8dlAqisBkUD70iAk93trtHFDGbsSaEuHooMMsiFSr0fPyQZKb0QNQbMq/7Mo1GTsRgsTxA/B4lG+TeyOiITsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+t5yeXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE13DC116C6;
	Sat,  8 Nov 2025 03:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570856;
	bh=CUXQiIM5wXxbV4Y3PP9of7ywamF06vsv9AbLzFNpXZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+t5yeXHh9ZFkRGnsYsKzuunEzoaDfF/gYs+y0hR9ifSjd1W6Xgq+nYrXNY5Tjebq
	 Bmj2+GzsrvjwPLyC6hJqjQPKTaosJyMyXyj+ncKJnTaNNgap220evghIoJ082ore7r
	 gwsNsQgAT3gB02fJKJjUVbhLgHt+fqSpUHJrcoH1P6LvBew25QVoENeo6sZlJhwjTr
	 omlKmE2ZOCBZs7e5xFA9n4Ov5/QZLYkVEbbaRlmQVNoIapyo7wJEqenryjzqmW+OqH
	 E7I7LXxxEBOL1XPS/xDR1RKF0WzXEV0OCmY2+v983KulMpGxTWK7+utukgXQynwhB3
	 ElmTYwE/2yFIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D223A40FCA;
	Sat,  8 Nov 2025 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] psp: track stats from core and provide a
 driver stats api
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257082873.1232193.12448797261264120149.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:00:28 +0000
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, borisp@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Nov 2025 16:26:01 -0800 you wrote:
> This series introduces stats counters for psp. Device key rotations,
> and so called 'stale-events' are common to all drivers and are tracked
> by the core.
> 
> A driver facing api is provided for reporting stats required by the
> "Implementation Requirements" section of the PSP Architecture
> Specification. Drivers must implement these stats.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] psp: report basic stats from the core
    https://git.kernel.org/netdev/net-next/c/dae4a92399fa
  - [net-next,v3,2/5] selftests: drv-net: psp: add assertions on core-tracked psp dev stats
    https://git.kernel.org/netdev/net-next/c/2098cec32865
  - [net-next,v3,3/5] psp: add stats from psp spec to driver facing api
    https://git.kernel.org/netdev/net-next/c/f05d26198cf2
  - [net-next,v3,4/5] net/mlx5e: Add PSP stats support for Rx/Tx flows
    https://git.kernel.org/netdev/net-next/c/b1346219e535
  - [net-next,v3,5/5] netdevsim: implement psp device stats
    https://git.kernel.org/netdev/net-next/c/178f0763c5f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



