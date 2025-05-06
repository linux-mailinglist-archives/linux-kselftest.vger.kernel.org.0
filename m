Return-Path: <linux-kselftest+bounces-32478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF225AAB8CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F13506579
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D95529E07F;
	Tue,  6 May 2025 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqazx+rA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B6290DA7;
	Tue,  6 May 2025 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494400; cv=none; b=hkw8VlUglfmJKAhTH3NCTDNzC2G5VZV2j5y5bgFYgtTAx/Sbo0RV0qM1BjFWuW8kv/lSsEndAUpcZyx4NzdwfmPBqoWBuVAMH/pkUYLoeuqBEWB8itsbM9RoLu6uik3MTjtSfx7u/DfQSmyEeiICinMTjGupRUPv0pBLxNRPAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494400; c=relaxed/simple;
	bh=HeZb4yEu/qemPLRKxvS0qir7D6RVJyn9J6jjk64llkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gh4adq94wToceqwlclbKz2ZNziRJGQXQbVBM4hzAzJc3U19bLD1/2vtWYUJEeiTTdopz/gD+Rmg9FMoWLPvD4GMQKqHnUpwkJlQ1B9CXN1bp2mI8G5eJuCyXBEPrTYqcOFf0mjX6fMUuWl5/Xzq3VFLCrZ7abVuCSIxr7x03v8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqazx+rA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B34AC4CEE4;
	Tue,  6 May 2025 01:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746494399;
	bh=HeZb4yEu/qemPLRKxvS0qir7D6RVJyn9J6jjk64llkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fqazx+rAsW6HzcDLt4vTAwwZ2zJ0TCi+PwCBGxFmfnzzS92jsuskx4/mcYuFD5Hw/
	 LyBk1PRD9KgB/ASxpkPJMLIOL6MJ48POagziB673RrXQ5oyHisj7Km/Lgab6cLiEzB
	 Brv3oDMngzLISkNHz8gtPyPlpjmALuckPedkTpE6DzrNGc+NH4KVITBYt5Mc2SvdHh
	 C9iJ572n0+NUHWqI2QP8cTkTDhzkL5rOSaVQb5qSu/8Kfe8cIF9PopU71uXxV8usdH
	 vPnbGfsE3u+Fu8oMPNHl32GwKGo8QHuUGckKxvBaRu/RjHQMIUeBpc1NAsA/u7whPQ
	 ae9k6nlQPJL5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5F380CFD9;
	Tue,  6 May 2025 01:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3 v4] selftests: drv: net: fix `ping.py` test failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174649443848.1003512.17960359288270090428.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 01:20:38 +0000
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, ap420073@gmail.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 May 2025 18:35:15 -0700 you wrote:
> Fix `ping.py` test failure on an ipv6 system, and appropriately handle the
> cases where either one of the two address families (ipv4, ipv6) is not
> present.
> 
> Mohsin Bashir (3):
>   selftests: drv: net: fix test failure on ipv6 sys
>   selftests: drv: net: avoid skipping tests
>   selftests: drv: net: add version indicator
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: drv: net: fix test failure on ipv6 sys
    https://git.kernel.org/netdev/net/c/b344a48cbe5f
  - [net,2/3] selftests: drv: net: avoid skipping tests
    https://git.kernel.org/netdev/net/c/8bb7d8e5cf7f
  - [net,3/3] selftests: drv: net: add version indicator
    https://git.kernel.org/netdev/net/c/4a9d494ca24b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



