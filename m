Return-Path: <linux-kselftest+bounces-3497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFB83B584
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 00:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040CF1F23534
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 23:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C27413665E;
	Wed, 24 Jan 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGJh48LS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036017E771;
	Wed, 24 Jan 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138428; cv=none; b=k7ixaN6WTqpUt/bkVh1niRM708Y+NG3pQ3ojtuPsm6g+dtQBNcQ9RNJ/H4S6udu/9hV7lLiYpg/X3JqoeF/kKZ4NUo8HehgVs5ey8LLOVJG1j72gijT48hBnnUpbkTpsNyk3IpXh8l2iNhiEf0BEKcyflzKWx0Nxf2jUFCfb6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138428; c=relaxed/simple;
	bh=4BIwSjc75wasp+dMBYuYbQUZtMttnZeOaGT9pOuc0lQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6T5BDMPiT7Cal3KzPHeTfOyH72+rl8Z9fyD5Zl6HytWDLEqa9FTEy8aUVJ4pGImoOsajY9jVbh7sTH9G3j1zwhTQZ7TP/2B/wb7zXxUdWHddd5XtzBl05+1ESwF4Et+O2xD42aRsUZKdQbekS4XyBHLPaxjS4nAfk14QbCRNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGJh48LS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95C20C43394;
	Wed, 24 Jan 2024 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706138427;
	bh=4BIwSjc75wasp+dMBYuYbQUZtMttnZeOaGT9pOuc0lQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tGJh48LSaxDa9Nw0s6XRMDXoB6ivsVyZtEriLMCaCnVvgi/r2EsCBpwUYscnjOTzI
	 l4hMl49CYNDTKsX5NU9/qI9B816/NAfGdwB523oe6t6Xi7DFKAA0unRO2NkZKhb6Gd
	 MZGvpUPfMGDp0ZhcqZuSG/cqBg4hMXdoasjVjPUR4YFUxhNDohKv2uVbqi50j5F1lo
	 jUKTqUBOlJq1aQ56c2G6m3D01CW43XmSCb392BgMlvsge0pV0KJYKhACwKxsOc7PLg
	 jLO2l8Gc3MUrVoGlw57wFlF7BKRdf2H0PVWRDMNyqj4ngRCt5C+qmQG01+a+T5TH6e
	 W0r7LCqicTZFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 810E8DFF762;
	Wed, 24 Jan 2024 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: netdevsim: fix the udp_tunnel_nic test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170613842752.28029.8594988164514756718.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 23:20:27 +0000
References: <20240123060529.1033912-1-kuba@kernel.org>
In-Reply-To: <20240123060529.1033912-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 22:05:29 -0800 you wrote:
> This test is missing a whole bunch of checks for interface
> renaming and one ifup. Presumably it was only used on a system
> with renaming disabled and NetworkManager running.
> 
> Fixes: 91f430b2c49d ("selftests: net: add a test for UDP tunnel info infra")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: netdevsim: fix the udp_tunnel_nic test
    https://git.kernel.org/netdev/net/c/0879020a7817

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



