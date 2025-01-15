Return-Path: <linux-kselftest+bounces-24599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C530A12DB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 22:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F55A166576
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A921DB943;
	Wed, 15 Jan 2025 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuPs0veq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC691DB375;
	Wed, 15 Jan 2025 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976624; cv=none; b=sOd74vOXBaevi4+IkQtn7ZdYUd7ehRWB7JwljWwsyA5JqzrCuCXWCupja3kJclTe6vHideYAXA6d+pmUBRb7bpi3Bd4W8hOuOr6oKradu6wf9m8ibpmj+f2NFYYsHMdhU06t7k7pA2Ud72KrceMdV0FtzsAJoTzK5WuWJrtzhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976624; c=relaxed/simple;
	bh=+Qle6uQadHWaIm6pp9CUrsXp+ZxOu7gfPtu2P0KyXyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gYkf8hzm5r7dx09moF1H4UyoNCimwzjx/8mCwA0rX2ssaRWfU8D7cpXmrg40nEJmeaiy0o0/E3eMWUVujbfrPJazSolKdBd1k3/+9C/Drk5VJRMD0LivYC+eMJMi17eheM7DHgiLF+sF/aGjeQyiNjWkeN0uq1CPcLt+ipOncWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuPs0veq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D628C4CED1;
	Wed, 15 Jan 2025 21:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976624;
	bh=+Qle6uQadHWaIm6pp9CUrsXp+ZxOu7gfPtu2P0KyXyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QuPs0veqSN6hBMQv3L1aVEiBlxyXwUdOE2s2BV7EkuaS/J02RL2/hcYWYm7nCZ3so
	 ArJB5S/UkjkseagD5RmmvfmirXwSOC7KrMCC7SVyDaocg4ITA7NyQyZRpiSWTk351C
	 1mHiyfaZxD54PGdgQmzJtoXP2rJq08MIq4W5t9CZ05VKx5CJ54hGYMIUTLMuTSe7md
	 frLLiWWm6nidu7/SM+XsaW+xeToGRvCfdm/jvK0LxmLbMbm9jNcy6UsIF3PxInt8Lr
	 t26LTBui3POxAEL4Io5Jea05pIoX3YtlfjtFt1n9um4SUD+gIywMuakC93npAgfI2E
	 ADoX/BVdKUYNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3421C380AA5F;
	Wed, 15 Jan 2025 21:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mptcp: selftests: more debug in case of
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173697664689.885620.11280936137681114654.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 21:30:46 +0000
References: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
In-Reply-To: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 19:03:10 +0100 you wrote:
> Here are just a bunch of small improvements for the MPTCP selftests:
> 
> Patch 1: Unify errors messages in simult_flows: print MIB and 'ss -Me'.
> 
> Patch 2: Unify errors messages in sockopt: print MIB.
> 
> Patch 3: Move common code to print debug info to mptcp_lib.sh.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] selftests: mptcp: simult_flows: unify errors msgs
    https://git.kernel.org/netdev/net-next/c/894dae026bf6
  - [net-next,2/6] selftests: mptcp: sockopt: save nstat infos
    https://git.kernel.org/netdev/net-next/c/3257d4cb8d5c
  - [net-next,3/6] selftests: mptcp: move stats info in case of errors to lib.sh
    https://git.kernel.org/netdev/net-next/c/8c6bb011e188
  - [net-next,4/6] selftests: mptcp: add -m with ss in case of errors
    https://git.kernel.org/netdev/net-next/c/5fbea888f8aa
  - [net-next,5/6] selftests: mptcp: connect: remove unused variable
    https://git.kernel.org/netdev/net-next/c/b265c5a17423
  - [net-next,6/6] selftests: mptcp: connect: better display the files size
    https://git.kernel.org/netdev/net-next/c/540d3f8f1dac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



