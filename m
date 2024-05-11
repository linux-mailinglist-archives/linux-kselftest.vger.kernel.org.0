Return-Path: <linux-kselftest+bounces-10084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0162F8C2E68
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C06A1F21EF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB41101D5;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK+AT9tJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B979D3;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391029; cv=none; b=ue0Svtwlo8CZz4jn4x7+WJMkcBUGYcb+z5IlsInZTRSJBZ67r5Uix4fgYqyBPG7HcEjb1bmjhnk48YVUtTm848Nx3eFrEgWIQXK5ODp3nEluSNHeeMYJaw2FTQS8JS7jZ09iRbHpgZLv7D5YwrrBccG4e+C5pnlMQVWaz4eOQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391029; c=relaxed/simple;
	bh=G7HxeJHvkKb5el8iF7xdtCwhl2ey/gQNL2iTshZLcfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gBgFicWTdRzlpeU/awkOoLWrLVNqfPVPQ55T9flbRHyI4m+hfPY87YGAKXM6LoMGn8uGJuIjdSHJZazMzXfT6mC5hi/ZmCp6hKhiOwYVcIu3q038qdIqcSE5Z+zk9pVpZleP5kXeoynq232bTWazLk5dj5tmS6Z2G2H86x9VJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK+AT9tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B91FC32781;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391029;
	bh=G7HxeJHvkKb5el8iF7xdtCwhl2ey/gQNL2iTshZLcfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dK+AT9tJsSscmLNgAEezO1FB8udU1vThESrpuMavleZy8avaNCFLCYUw3ItWj0VoS
	 HylIQGfAUlZcOSQFCpybWg/TpzUp81grcyr7aFn7b/liYyj5qnaf573sHHUqaWglC6
	 SQuG+RQGY0WfwYb8gmPgGxofSP9wfr6wtYZgSHmNSqRB9up0xR6yngapBY4n3rB8fI
	 Z8fcrw8dnc6+15nKntXjboK8u9h/Sq/k8OoVHaxRXc1dy2/ulCSf5IM118UveAfhUv
	 mX7O7ml4csQgm9PiQt2YS5GVe6FLzmZYgcBe3L6tAMqb0Bs1T6AA81mcR98Jui2w7/
	 7to86x/Ga8D5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDD74E7C114;
	Sat, 11 May 2024 01:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: add missing config for amt.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539102896.31003.9532678139869008403.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 01:30:28 +0000
References: <20240509161919.3939966-1-kuba@kernel.org>
In-Reply-To: <20240509161919.3939966-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 09:19:19 -0700 you wrote:
> Test needs IPv6 multicast. smcroute currently crashes when trying
> to install a route in a kernel without IPv6 multicast.
> 
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: ap420073@gmail.com
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: add missing config for amt.sh
    https://git.kernel.org/netdev/net/c/c499fe96d3f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



