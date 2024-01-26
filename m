Return-Path: <linux-kselftest+bounces-3605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AA583D139
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA2629A66E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 00:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071F7494;
	Fri, 26 Jan 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erRpv4BS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F348F44;
	Fri, 26 Jan 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227228; cv=none; b=g0CaccTYNTXUDBnEti6PZBi3AqO07N1qPdGPvZLm7xZRWuulHKX886y7HkkTuToZ+sfTwR4NbeRjNXLqJl4GljRGlLNYGtvgq3127uf3CMuiuNjz8VwRhK+dEgai7vwLBnBW5OYiMj5M8gnRFKRRdl3wVHoS8l9jWWMMn0wcnME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227228; c=relaxed/simple;
	bh=xL9/ASUgp8AWn/fjHqtBmmnVIVRdMxEudz4VhTRhTSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JdFt+p5UOdqA/q3unkRSnXEDp1N2zOCi43jgZL1+xpZv55e1kZP8B99FF8aTCynwMkDUFmhjsPXVWBrIH7twLASjcKxuTWsdYzI701GCqEuSql3PSEJXUSgTGp/JALw8ruoyy5Z5Zy+7Xwbm1J0HxSX6pERe9KOwh3bTPGdizfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erRpv4BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87078C43330;
	Fri, 26 Jan 2024 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706227227;
	bh=xL9/ASUgp8AWn/fjHqtBmmnVIVRdMxEudz4VhTRhTSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=erRpv4BSLpOsNgIiHG9guU4oZanZWr9+q+VPIqwBSXY+xQ91eKAughUN1P/vcm3Bg
	 oiL6N2zea997hpgjTnzpnXfFNBPcZ3dYW7c3SFt6ARB/zW20OWcDubRWTsgaJIMe7l
	 XJOSZXP5S7G88FJVM2I4CU0fuPiYDLNSXxA57qUUFofP8ltkaXWaKCQaOfAddZ+uNY
	 mqOyghIhDmY82smZ2UMksDQwkCeJWhrdLx0638Kn0QN91Ko++yL+8ukdgfyr/3l1H4
	 pUZWbDbGoHVpzNO2LcntcY9gqGxY61tulMs5Zi409jS/M1/HGWvigz5JwDLp+oHNVV
	 qQrggWBXjsSyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D90FD8C962;
	Fri, 26 Jan 2024 00:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: tcp_ao: add a config file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170622722744.27026.5244575719322762458.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 00:00:27 +0000
References: <20240124192550.1865743-1-kuba@kernel.org>
In-Reply-To: <20240124192550.1865743-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 11:25:50 -0800 you wrote:
> Still a bit unclear whether each directory should have its own
> config file, but assuming they should lets add one for tcp_ao.
> 
> The following tests still fail with this config in place:
>  - rst_ipv4,
>  - rst_ipv6,
>  - bench-lookups_ipv6.
> other 21 pass.
> 
> [...]

Here is the summary with links:
  - [net] selftests: tcp_ao: add a config file
    https://git.kernel.org/netdev/net/c/b64787840080

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



