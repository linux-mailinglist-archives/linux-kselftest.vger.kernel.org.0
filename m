Return-Path: <linux-kselftest+bounces-21275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142D9B896B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 03:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2291F22076
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 02:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A71474A7;
	Fri,  1 Nov 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOVfOR6L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F814601F;
	Fri,  1 Nov 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428830; cv=none; b=uVOIl+N7Y2wn1wRnGC/a/E6YftEU5vhgBlp9KdJEbbnquVxrH/jLBF3gO10q/QLyLF6GRoRdMqfj7kMMd1uHF1o8p87OlHmkj1KhZGm68cxBrD4vPC3OPw+HZVdY/oQoSYegpjzhZw8jbNkDHh9N4p5yousjSCkKM8kLMve7uBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428830; c=relaxed/simple;
	bh=9CcQ2QOz4gtm1gzkXUI26ERleSJSxxWrIcX7E5UXnVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c3Aoox2H36cEbbazxEqH+ridjKNMkW2uf63OrsATAhPFVDux1rvNTOrQQ6gAj8FtEAPtFOxtj3vgEhnB+9ZX7kKjy0MZPOOq/RrfbSDdZYdr0zgvE3YMzf62XxsgPrEue39H5Bq8gLGobVo/URc8WcCHFF1wclkCHAcDy9w5SCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOVfOR6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE60C4CED0;
	Fri,  1 Nov 2024 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428829;
	bh=9CcQ2QOz4gtm1gzkXUI26ERleSJSxxWrIcX7E5UXnVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOVfOR6LZPSh0QNRZbZ9DHteAisuLY0/iQuqka1NXsJclU65WBrs2BNhFOiwwQuHj
	 vK1Q8/RCYy2gGMfaG8Qcbs4KjDq+ytTIne599JXwIqgwrGQk57uxvjbB92v6z6ygcE
	 5lf5iBJpvUfxVgKDHtTF09qGtYf6UKCyxAVE+EDNEv9mkvSldjqjrYDwkPV2fW9H/U
	 PvXF/9/3+o0GjxmJctFGYmcFV07uZROLu/fHKxDnCOfD4k04BOwneD3ckeK6M8yU/R
	 6+j9wwlOYRSp0oBftIPO4ocwii5M3ptCHMbJ6BJ3pfnHY80yCVE4dLX6IqYDpNHXTv
	 E2c17Fx0jGrEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB341380AC02;
	Fri,  1 Nov 2024 02:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: netdevsim: add fib_notifications to
 Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042883750.2159382.1479790840240979138.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:40:37 +0000
References: <20241029192603.509295-1-kuba@kernel.org>
In-Reply-To: <20241029192603.509295-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 12:26:03 -0700 you wrote:
> Commit 19d36d2971e6 ("selftests: netdevsim: Add fib_notifications test")
> added the test but didn't include it in the Makefile.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew+netdev@lunn.ch
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: petrm@nvidia.com
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: netdevsim: add fib_notifications to Makefile
    https://git.kernel.org/netdev/net-next/c/7f66456d776a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



