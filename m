Return-Path: <linux-kselftest+bounces-11244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB8C8FC883
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A171C213AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD01818FDC4;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeEhkQmI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594014BF85;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581630; cv=none; b=XyU6wShn4YhJKAEYSYEQMl4yJUiTldd/Z/tCdr8VQuIpjTnrfXfkoqWYTg5QYrlxQq5brOD6bUGsT7b8Ir1PEg1+v+1HkuHWTl0Vxlt8Q3Ne4BJjhxM/S8eyv1fIs63+FrQlaUpcVwxEyeUwUYIkN5LN+mgc5R1vCc2xHs9JCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581630; c=relaxed/simple;
	bh=qEGyT6i+dRnLZnMaKTAai7WVDQG00yIrKd8CMJQM+4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PA9phTxD0YgGohBW33LpjIeXPRGAg9JjMP7y4IiqgYOd745rJckqFNNhGKhwfihifHlAmlxHd1YWZRJIEQTIVFi1EFVLSSD83PkKGeiKZnIcs4TLwJ8oRheorCs+64hofgY82zq2sFFqe99l9f+709cIKrqV2BNNiXT/e1KtOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeEhkQmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04FD0C4AF08;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717581630;
	bh=qEGyT6i+dRnLZnMaKTAai7WVDQG00yIrKd8CMJQM+4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eeEhkQmI0IOUwKA0B/Wqyiap5jP+dC8gyc5i6R9xqNauMNPZ9KOlSWheflIWAdbfS
	 iY0xYiovV2oBEVvyuS0jrtzFmAdGKVRpiYiMnPhvFFZSpae/krss6FLC20phTRDLGf
	 y/snhNOz+W/gNeWAG3mRG65dtPCil1B8/LwQBz+rdEn528Vu7Oh3AvArbEVTbFFGn1
	 q3GFmVLsStiwur8COlrL4qvRUa2Dvp56X/Y8to7EGbQnvr6UnN/GUlr3UB8Ofvhi+L
	 SoUsdFEdjpgGKzRjRnnv1JJzqGEaQXaSHAcD8+kLPfwG7PoDUNvvJUhbgn/KKKZCMm
	 AtP8eSE/Qje5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC828D3E996;
	Wed,  5 Jun 2024 10:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: hsr: add missing config for CONFIG_BRIDGE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171758162996.24633.7399954746442463223.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 10:00:29 +0000
References: <20240603093019.2125266-1-liuhangbin@gmail.com>
In-Reply-To: <20240603093019.2125266-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, lukma@denx.de,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 17:30:19 +0800 you wrote:
> hsr_redbox.sh test need to create bridge for testing. Add the missing
> config CONFIG_BRIDGE in config file.
> 
> Fixes: eafbf0574e05 ("test: hsr: Extend the hsr_redbox.sh to have more SAN devices connected")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/hsr/config | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] selftests: hsr: add missing config for CONFIG_BRIDGE
    https://git.kernel.org/netdev/net/c/712115a24b1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



