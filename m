Return-Path: <linux-kselftest+bounces-9698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943478BFC0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A221C211A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D5824B5;
	Wed,  8 May 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEKPGAi+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62C8248D;
	Wed,  8 May 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167829; cv=none; b=suzjQ9BJbOEv720fkTWsngB7fgXCKOZSA+mrRIzhkuiC6qr6daAcaW06Y47j+qANeKADFhihIuUU+UPxD4eNWT7Fy03O8pkIhEf47YJrmQ2ZEVj2VDN2e9k/Ia88+i1AN6TI2k0xQnTo6o2+ywxWeYuFM/7QGe2k+aE9k+VNtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167829; c=relaxed/simple;
	bh=axHrUToPoL787w2hxsBZe3Z6MmWMNp4EPGZTDCBJPl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MDm117fZKH6hjqxzJvhG+WkMz9/BCsWSiqyUgzDF9RAhNlyppfOxobhH1MBmG26JQMsADw7rsQOakqYMxdfZD3Ko5s1YrG/ErMxDFcvhAcuW4b924S3MrZ5OKOD/9L86OwWfmr1MQv5MDk+Dtg9M//d9FTWfsqKgSFhlVyEuubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEKPGAi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF13C4AF18;
	Wed,  8 May 2024 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167828;
	bh=axHrUToPoL787w2hxsBZe3Z6MmWMNp4EPGZTDCBJPl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AEKPGAi+YpkuKFQljES739yUDjh3q9jmTkCisXmC+T0r4YCapun/EatCG8NSYuJTX
	 FLvyPzR5FVlZGN9ncgnkS++gXNsoJHdhrsEG2oknpvg3btc3xK+P42RudyqZJtSMsU
	 FKPVP7+pVesAR9K+QsqIGaCAICE1QrHa9CJcAGx+vDUjw0YmReDA1Rvvk4C/xAhruz
	 OUvcjruGXohs/alDi9iFTdvvRAu3rEr67224uMT+qoD2kzQeXidqG/HT4VKFR0NuaC
	 gu4dcaZEg3FGa8di+US6Jv40PeW81VTXkQfxQDsqIbcIh6HiGWI4PTGCpOahgCmjBN
	 2vrVqhw0htlVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E997C54BB1;
	Wed,  8 May 2024 11:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] test: hsr: Call cleanup_all_ns when hsr_redbox.sh
 script exits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171516782864.10113.4815978135761063766.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 11:30:28 +0000
References: <20240507091155.3504198-1-lukma@denx.de>
In-Reply-To: <20240507091155.3504198-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  7 May 2024 11:11:55 +0200 you wrote:
> Without this change the created netns instances are not cleared after
> this script execution. To fix this problem the cleanup_all_ns function
> from ../lib.sh is called.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  tools/testing/selftests/net/hsr/hsr_redbox.sh | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] test: hsr: Call cleanup_all_ns when hsr_redbox.sh script exits
    https://git.kernel.org/netdev/net-next/c/252aa6d53931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



