Return-Path: <linux-kselftest+bounces-30882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08FA8A2AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52310189E579
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E51DF963;
	Tue, 15 Apr 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfiR6T+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB7145FE0;
	Tue, 15 Apr 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744730998; cv=none; b=X/YOZ+oNbtIGkE7nq1uEEvBvxD4lzGBqB6pT8U7kiPZ3MBFoKyaZD6ALHT6LumOvDA7YJxdLVwLsDMCMkiLEimj9eO8PON5P/rW6PxjsRLgaak5U9D96IQyfdAtqbivc1zpYCs2jJV0/sB/Ry2bMJpOwMquQsKs4iEBgCxQkPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744730998; c=relaxed/simple;
	bh=Nb8PuR7yLYMsD7vKccqLdB79LGQ7+UDHzf/LfFpFsOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y6b4p3OkbPszi8EoULW1hk5jNvW5kI3uYFM7SE+zeEdprkMNXWs43/PDpnfK0bh4b0OhNRK2zq74gsW7RaPD8kLISqfrlAlbAAPn6a9WFLWweTw2VDjMbDUNAfdau73+ZdgpgPjS6Bemp3R5c/kdb1nWir0V6nmT9Cmx8cFg938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfiR6T+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0A1C4CEEB;
	Tue, 15 Apr 2025 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744730998;
	bh=Nb8PuR7yLYMsD7vKccqLdB79LGQ7+UDHzf/LfFpFsOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sfiR6T+AyBHbCYHylx/cFJ0sCRUnYkuO6iD9AVh9oGPU5RRZnHQmBkqQuVip9LWmH
	 qV/NDDA7E8tGuU9oRyUisWO4P8NXun6xncrZKE91cauVE1r1Ruppy7ZU15iUSMqb23
	 SwiT1NgHQyISu0tZFNthVsWbJ8YmCN9KPbY/YcVXaT1KVLaAzQs50wiC95ABORcnbg
	 oOdCYjBC7n73yOTWvcvFzwDe7JrNdVoDIV1pSgbATduqOkGhTFMPdUJEM4ezcgHyGI
	 HLrAzYaKM6PD7SmFp+LR1EsMihYrRe1h+YwJ0ZgEOlq58lyYNFKdlVXDFxw3Y7aL1n
	 IWAUwzDfT6GnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E853822D55;
	Tue, 15 Apr 2025 15:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] mptcp: various small and unrelated
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473103627.2677629.8047021471337613014.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 15:30:36 +0000
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 thorsten.blum@linux.dev, pizhenwei@bytedance.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Apr 2025 11:34:31 +0200 you wrote:
> Here are various unrelated patches:
> 
> - Patch 1: sched: remove unused structure.
> 
> - Patch 2: sched: split the validation part, a preparation for later.
> 
> - Patch 3: pm: clarify code, not to think there is a possible UaF.
>   Note: a previous version has already been sent individually to Netdev.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] mptcp: sched: remove mptcp_sched_data
    https://git.kernel.org/netdev/net-next/c/6e83166dd800
  - [net-next,v2,2/8] mptcp: sched: split validation part
    https://git.kernel.org/netdev/net-next/c/760ff076695c
  - [net-next,v2,3/8] mptcp: pm: Return local variable instead of freed pointer
    https://git.kernel.org/netdev/net-next/c/def9d0958bef
  - [net-next,v2,4/8] mptcp: pass right struct to subflow_hmac_valid
    https://git.kernel.org/netdev/net-next/c/60cbf3158513
  - [net-next,v2,5/8] mptcp: add MPJoinRejected MIB counter
    https://git.kernel.org/netdev/net-next/c/4ce7fb8de556
  - [net-next,v2,6/8] selftests: mptcp: validate MPJoinRejected counter
    https://git.kernel.org/netdev/net-next/c/98dea4fd6315
  - [net-next,v2,7/8] selftests: mptcp: diag: drop nlh parameter of recv_nlmsg
    https://git.kernel.org/netdev/net-next/c/f9c7504d3055
  - [net-next,v2,8/8] selftests: mptcp: use IPPROTO_MPTCP for getaddrinfo
    https://git.kernel.org/netdev/net-next/c/a862771d1aa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



