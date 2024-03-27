Return-Path: <linux-kselftest+bounces-6706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E62B88DC8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 12:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF921C27AF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27917F7CB;
	Wed, 27 Mar 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZRKQX/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C00768E0;
	Wed, 27 Mar 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539028; cv=none; b=TeQi3Gx2ndg5U+4NqVjlmOb6jBUqcdCP94wPZrUcIeIk1zkqzABWfn5fZPyTkRlHQbJTGObGqoLRlW5mBmPDkkMnL77kuTIZQWiN5CPyQ7ZOcV7ddkiz12Stn2Z10fqiGrqHw6D0KekDWprb0uZjlibfwoH54GvthpXqd87JeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539028; c=relaxed/simple;
	bh=phBR8HnwN3JpoH9k712VIx/51mRz1pLABawXRE7KXaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DzBlYKjQUvvDeurnUf2Dieh293nvMCgr0X6pEkm7scAkVhTH1N66f/MtqwoQKkyWeuSsDkwyhKa2TM90mG92UkSN2q8MrUFIlGN55V+E/3579vzzBmMHSzS8ryW1seHorWZgKO9D/0nuWnmPbL8mzqKyzV8l3kqzjbOmq+KUFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZRKQX/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BA14C433F1;
	Wed, 27 Mar 2024 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711539028;
	bh=phBR8HnwN3JpoH9k712VIx/51mRz1pLABawXRE7KXaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tZRKQX/EATzj/toAGOH0uu1Oco6bBvdGSW9CnK8Eap6avcwkTyMLcmYeLEkdPDezn
	 +vXiaQIqK6EHiTmpwTVzleckdPVXHUH5utS0GQtzHGvrPvehV/kX93wCFV4R/lzTes
	 0oUzZsu3NI9tE+96tfkdH04ZzKdFwP7tU9KpxmOnykaJEYI8vmmXTLU+GehU3MX/cn
	 9LyQYF1fAl5HhoKHLEvqpRpM+peh4nwh/M/IQsG9WwfpHIWtsyjKjz/evhhWIkgNWo
	 cPVpZJ3d9AgEis0eo55kyEygXzAoSRFjZGYmS6rwh5qzIVjfB0X738BRqkhTPz9Szk
	 lPOqoOPERIjIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F4A4D2D0EE;
	Wed, 27 Mar 2024 11:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: netdevsim: set test timeout to 10 minutes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171153902845.27957.1857637993639532346.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 11:30:28 +0000
References: <20240325155612.2272174-1-kuba@kernel.org>
In-Reply-To: <20240325155612.2272174-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, dw@davidwei.uk,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 25 Mar 2024 08:56:11 -0700 you wrote:
> The longest running netdevsim test, nexthop.sh, currently takes
> 5 min to finish. Around 260s to be exact, and 310s on a debug kernel.
> The default timeout in selftest is 45sec, so we need an explicit
> config. Give ourselves some headroom and use 10min.
> 
> Commit under Fixes isn't really to "blame" but prior to that
> netdevsim tests weren't integrated with kselftest infra
> so blaming the tests themselves doesn't seem right, either.
> 
> [...]

Here is the summary with links:
  - [net] selftests: netdevsim: set test timeout to 10 minutes
    https://git.kernel.org/netdev/net/c/afbf75e8da8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



