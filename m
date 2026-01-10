Return-Path: <linux-kselftest+bounces-48655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481FD0CBE2
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F24930094AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4F22B5AC;
	Sat, 10 Jan 2026 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPEBx8pG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445832A1CF;
	Sat, 10 Jan 2026 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009418; cv=none; b=dpubXM+/oHv6odjfcFw1YZ3ZQib0VOOwor1OXwjBLcKpsrMJtpzn7Asrit1CmIbklpq7Xbsw7h4zhqiepLdS8xKvGmLW5Bmit+ylOq3WopuVh4u0YEtmW9eZjSIE10y+Upl4ZoZxxgCt0/6LrKTRKHO2QuEzzl1z5Gul3hK0HW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009418; c=relaxed/simple;
	bh=SooGb7Rs/BrumFC1Ul13PYFGR0gg7pXpiEHHkzi8YFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cg42ne6e7whbOpZ8O1/+xfRReQb/BPQsOTmvkzldfFR+aX0ZLTl8G142rEXtXPt8kzllNjhQ1peHalW2gb24A3PiN/9wIe0gBN2JQ/e3UTp77wfRys5m+5vNLK0FdSVcwViC0DwENvfazuKVmVkaZQEPI9FhBqOCSfIrpyOiotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPEBx8pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AA0C4CEF1;
	Sat, 10 Jan 2026 01:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768009418;
	bh=SooGb7Rs/BrumFC1Ul13PYFGR0gg7pXpiEHHkzi8YFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XPEBx8pGrfJHcMd57d4WYXNWfp521AdH6BZmM3JYHPGKTipiZN/dY3jB+A3XpSjd3
	 QzswL2NYRgrpIegzA71IEdmT8foAzU3P8wGGtNeXelLds0B1Zwot40WzFlsRMqhcnk
	 Ce9qMxmywpwAYE8oaEQ+wPZXjG2O7vq1uP7QE4IuPyvQ8+cBL7g1T75tK6pgJjq7UQ
	 4Y0rDgRNO6KT4PiGFQX4lKATxjwIiBJrlRXtzX813nbeKch9exFe0BnNuNL0y5yQ5S
	 YVEcMC/2A7x0/ywqlYh+DL1sugQEoDa7x6UaGVY0FuhHCc8TBAZ8jOKcH3yAlJyl3Z
	 OvlOMh6ReuM7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B8D3AA9F46;
	Sat, 10 Jan 2026 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: update PTP tcpdump
 patterns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176800921377.446502.1178944732050569872.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 01:40:13 +0000
References: <20260107145320.1837464-1-kuba@kernel.org>
In-Reply-To: <20260107145320.1837464-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 vladimir.oltean@nxp.com, alexander.sverdlin@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jan 2026 06:53:19 -0800 you wrote:
> Recent version of tcpdump (tcpdump-4.99.6-1.fc43.x86_64) seems to have
> removed the spurious space after msg type in PTP info, e.g.:
> 
>  before:  PTPv2, majorSdoId: 0x0, msg type : sync msg, length: 44
>  after:   PTPv2, majorSdoId: 0x0, msg type: sync msg, length: 44
> 
> Update our patterns to match both.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: forwarding: update PTP tcpdump patterns
    https://git.kernel.org/netdev/net-next/c/68ec2b9fc59e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



