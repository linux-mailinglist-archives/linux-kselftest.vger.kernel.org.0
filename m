Return-Path: <linux-kselftest+bounces-11285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9698FDCC1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 04:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B4D1C2268D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 02:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD011BC4B;
	Thu,  6 Jun 2024 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAdemrmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0180199B8;
	Thu,  6 Jun 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641032; cv=none; b=snlMka764TD4eM5K9AedHWTxEC9WebfvryKQbUW1qOnCFl6KilB5CBYmHUQxX/78dXATDu1oohDL7m9ZDbNdXuvom5iX55ATfXcbN1jUmp9+O0huCyQ6SDkRSDxJ2v3gCUW5VHiy3Qo4HRZjRIsZ6zC9cy0jDzY6xxKaPdyDalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641032; c=relaxed/simple;
	bh=3U+iDnACpZRpRUjZPACLMO+CtjRyATslJry5JmeZRAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=famBVOrNU/YeUz3Tt1mdSsYaq6ZzMKN04vHKf8LPkil7PNpBXvCQwIdEKZVaKQbj11amBC0fzdUtBn6xRJ1Igvi06w9KufdpM5gaeWQYYSO3OeeWUrPWBVd9x/PRxbecRdR/ng+6wbaR3CYMYp7+6WBUWwxb1IToR4P5gHvNrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAdemrmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27EA8C4AF0F;
	Thu,  6 Jun 2024 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717641032;
	bh=3U+iDnACpZRpRUjZPACLMO+CtjRyATslJry5JmeZRAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mAdemrmibkCws598NOoG+9P9gC/N3ztL0ccyPBi4TZeRjA/juzK1boFTkHMaZDWF7
	 LJLPb+UPWm2iFbFx5nZWXbcGuJwaBmtwd50lDmoOWbRsptWqAKbt1e1bAZoFPjbRk8
	 0wA52q0cKTUnHWtXUEYDEnN8eiff84axgK6wloABwpKYYD2IS5pn1cflvcd7rNxb7q
	 6RYkXQ/Yp2cuYrm2WpHx1vQ7tGeOOLeGkUxQNBIN5SxyzWps4qb4XrsJjp7Y26Q1A1
	 Jz4E7ZQiwpSYJ7cpO8+cLGa9rVUkIAn5RoCjmP7I1Fz0pA3GPl8fZyy5vNGnupdfdL
	 1c+jQ8KeYDC5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CA35D3E997;
	Thu,  6 Jun 2024 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: hsr: Extend the hsr_redbox.sh test to use
 fixed MAC addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171764103204.23267.6023664663218256417.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 02:30:32 +0000
References: <20240603093322.3150030-2-lukma@denx.de>
In-Reply-To: <20240603093322.3150030-2-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, olteanv@gmail.com, davem@davemloft.net,
 o.rempel@pengutronix.de, Tristram.Ha@microchip.com, bigeasy@linutronix.de,
 r-gunasekaran@ti.com, horms@kernel.org, n.zhandarovich@fintech.ru,
 m-karicheri2@ti.com, Arvid.Brodin@xdin.com, dan.carpenter@linaro.org,
 ricardo@marliere.net, casper.casan@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, liuhangbin@gmail.com,
 tanggeliang@kylinos.cn, shuah@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Jun 2024 11:33:22 +0200 you wrote:
> Fixed MAC addresses help with debugging as last four bytes identify the
> network namespace.
> 
> Moreover, it allows to mimic the real life setup with for example bridge
> having the same MAC address on each port.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: hsr: Extend the hsr_redbox.sh test to use fixed MAC addresses
    https://git.kernel.org/netdev/net-next/c/955edd872baf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



