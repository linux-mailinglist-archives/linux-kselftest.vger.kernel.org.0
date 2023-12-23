Return-Path: <linux-kselftest+bounces-2409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD281D0D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 01:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F4D1F2373F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D14644;
	Sat, 23 Dec 2023 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCdp59If"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8217C6;
	Sat, 23 Dec 2023 00:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD16C433C9;
	Sat, 23 Dec 2023 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703291426;
	bh=DEBxA0a3DbUGEy+wDh9q9I2/DY1LYJS6opQJPvEnoUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oCdp59Ifg1LF1Vmh4ebbLKrEbnUiWOGw9/5OISuF2ExvvwxEE/LFRQL9rR1Z+jM5S
	 BXwRPU2xI/sdOb4KWtNa8ywrDxMtP7M8TXp1qvYXJPYbXm84MSdvXFPDaWRWW6VtJB
	 aetm4FM4hKRBHxwwLuIzT4P/RJQM3bpXQDBhesQ5Ypbr+0o519oxNIanBF9n8ZEwxJ
	 yadSFMp2qrOGBjJ0JGow7IYmhfYE/IFNevB3aqjP23V2L7hybk/eJRdePOMIEOTWz2
	 dbQW+Ee2LCkOyZxUy3r1BYul/xePuQ2aSsat63oDUUKnco/nYoW1U0OCrh1arqUtJv
	 82lJBjtE/TegQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F04CFDD4EEA;
	Sat, 23 Dec 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: remove unneeded semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170329142598.4887.4551927362465419413.git-patchwork-notify@kernel.org>
Date: Sat, 23 Dec 2023 00:30:25 +0000
References: <20231219055404.31978-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20231219055404.31978-1-jiapeng.chong@linux.alibaba.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 abaci@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 13:54:04 +0800 you wrote:
> No functional modification involved.
> 
> ./tools/testing/selftests/net/tcp_ao/setsockopt-closed.c:121:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7771
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - selftests/net: remove unneeded semicolon
    https://git.kernel.org/netdev/net-next/c/6530b29f77c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



