Return-Path: <linux-kselftest+bounces-8016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66138A5A02
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2071F21579
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1424A154BFC;
	Mon, 15 Apr 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F76Djn8G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245D139CEC;
	Mon, 15 Apr 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206429; cv=none; b=aM/FJKcBqXARnkhHZug/6Bh6FvziHzXOx05XzcPEZr3flAKSM/W8u56CCYCOjhk1vZOKsk1ubaD4xxa4CKyiE+NhRLhX2MBDSdKLeWkSow8s6zmX3zIwqizLyA4VD1/ngSNfb5hiwRncvOtrB2VgTVmGdUYWrCH4ATp26g6dfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206429; c=relaxed/simple;
	bh=qgSpcyoK3xUB+Vn+ZWMgWScWqWWQJPItCnITCl/a6SU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lyk27fzVaXot1R7Xo1fR07B7b+g95z7pcl44DlwrrzS378HzQIXZOBAKG2/ed71ZRf8pCJA4Z6jXEyd7E6axbrZczeYf0a6UE6LJbtnWZhRsPVL2igN7E0OlmykHrZlBcMzoaQyGuQ7rkc3zBPWoTLExCEyE6Btt4GOcZnf3/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F76Djn8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 791F3C2BD11;
	Mon, 15 Apr 2024 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206428;
	bh=qgSpcyoK3xUB+Vn+ZWMgWScWqWWQJPItCnITCl/a6SU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F76Djn8GO5/NsXdvcXKzJrc2ihXvpvFq8nBckOhMmFzHF2i/rc0whhc1QTo7AHMbS
	 b89DYLyts81aTjLCImE0Ge9hyfaDbmVW5MxkVaCOnYdPvcYWVDMidg8h+YTXpQ3aTV
	 JXiquFuSHlpMsxiNh9aqEgWCZ+NQeQZTRUKupTvg/UVFRINMkvvhcjJrRpQ+tLWsDG
	 NgFyhHa9i4jJOJ0gZcbDVjlPmBSZdKj0lKyHSouN5Uno69eZe/tnUUj0YBcvgrnhhU
	 I57mylpdGItCoWBygWoQj2TVc7mk0XKCrHAJXBaKIkpC9e02aE+rKDgDpazh7m+LyQ
	 U3WtcyrAIpTzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E4B5C54BB2;
	Mon, 15 Apr 2024 18:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] selftests: net: exercise page pool reporting
 via netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171320642844.24301.8058088349546274076.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 18:40:28 +0000
References: <20240412141436.828666-1-kuba@kernel.org>
In-Reply-To: <20240412141436.828666-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Apr 2024 07:14:30 -0700 you wrote:
> Add a basic test for page pool netlink reporting.
> 
> v2:
>  - pass args as *args (patch 3)
>  - improve the test and add busy wait helper (patch 6)
> v1: https://lore.kernel.org/all/20240411012815.174400-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: netdevsim: add some fake page pool use
    https://git.kernel.org/netdev/net-next/c/1580cbcbfe77
  - [net-next,v2,2/6] tools: ynl: don't return None for dumps
    https://git.kernel.org/netdev/net-next/c/72ba6cba0a6e
  - [net-next,v2,3/6] selftests: net: print report check location in python tests
    https://git.kernel.org/netdev/net-next/c/eeb409bde964
  - [net-next,v2,4/6] selftests: net: print full exception on failure
    https://git.kernel.org/netdev/net-next/c/99583b970b90
  - [net-next,v2,5/6] selftests: net: support use of NetdevSimDev under "with" in python
    https://git.kernel.org/netdev/net-next/c/8554d6e39b6a
  - [net-next,v2,6/6] selftests: net: exercise page pool reporting via netlink
    https://git.kernel.org/netdev/net-next/c/05fa5c31b988

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



