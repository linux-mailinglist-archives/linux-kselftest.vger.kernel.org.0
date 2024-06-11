Return-Path: <linux-kselftest+bounces-11638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 491DC902ED0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 05:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F289F1F229BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA9716F8E0;
	Tue, 11 Jun 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MocUnV5q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01341A84;
	Tue, 11 Jun 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074833; cv=none; b=e1marn4jn6s9YlS4JR9LGVEc58OojRANibHSw6/7+WJxpAheZkJjR9+nVH2foAkV53YIfPiw9OuameUyLUnUxZxerTasSDt1TYlboxQwdATatD6cjdjjyUGo2SOhZPkwHYv3FB/ByCUURz4mNdmP1mDV19LutzHF/hya1FQYwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074833; c=relaxed/simple;
	bh=pSvn6OcHpnhBY6s0/2yfy61tKQC/zFK2p4HFOCECfr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kEXV5LLyrvSyY1mF6U3o4DHuYPWqB/kEmKkuPs2baMvEmUzi+WDV+M+NWTk946CR1drWQIYka5MIG7G4T2tFHYAshsROBqNUHklGsgsJGHFbfFnw1ELFp3nF/clmV4mwCznH54H7zV2i4ywdu+kItG1opHQJRGuF3V0rnSAKIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MocUnV5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5ACAC4AF1A;
	Tue, 11 Jun 2024 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718074832;
	bh=pSvn6OcHpnhBY6s0/2yfy61tKQC/zFK2p4HFOCECfr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MocUnV5qoySoc/QFMiOWq8PTOLuEDhWCiDxxBMWVezCFzsKJ9sPalLg9CGowmVtKI
	 Zh/hdw56oGBIk2TS9zoDUZVQEtcwoaaveEpd02k/sYuYFZ6JLVkQEiQHNhdCsHEwG8
	 MjXxXeviK8Of+dVuy/8QnmRO/9H0PVxFaXWfUyvphSTXE5AIQ85mgF/j3yXQnXKyDV
	 sqAu69UoPhXoXJ+5DR4dDyp89ruLzt/HUpAW5kruRStNQKmVRit747UXviMEMjlAn0
	 kkwyO/kefGtttQK32Z4bdC1bpvelLMwFSLNJ+tp9o8wUr9FsRb3OSIudDeY3/6dLwE
	 QjU/dTwpIjfSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADC87E7C76F;
	Tue, 11 Jun 2024 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171807483270.24718.9377090151074860472.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 03:00:32 +0000
References: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
In-Reply-To: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dcaratti@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, cpaasch@apple.com, liyonglong@chinatelecom.cn

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Jun 2024 17:01:47 +0200 you wrote:
> The different patches here are some unrelated fixes for MPTCP:
> 
> - Patch 1 ensures 'snd_una' is initialised on connect in case of MPTCP
>   fallback to TCP followed by retransmissions before the processing of
>   any other incoming packets. A fix for v5.9+.
> 
> - Patch 2 makes sure the RmAddr MIB counter is incremented, and only
>   once per ID, upon the reception of a RM_ADDR. A fix for v5.10+.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: ensure snd_una is properly initialized on connect
    https://git.kernel.org/netdev/net/c/8031b58c3a9b
  - [net,2/4] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
    https://git.kernel.org/netdev/net/c/6a09788c1a66
  - [net,3/4] mptcp: pm: update add_addr counters after connect
    https://git.kernel.org/netdev/net/c/40eec1795cc2
  - [net,4/4] mailmap: map Geliang's new email address
    https://git.kernel.org/netdev/net/c/74acb250e103

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



