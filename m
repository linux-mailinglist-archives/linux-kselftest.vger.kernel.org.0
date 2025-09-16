Return-Path: <linux-kselftest+bounces-41553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76CFB58B2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB646460618
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0621C9EA;
	Tue, 16 Sep 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLdgGRcv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0A1DE8AF;
	Tue, 16 Sep 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986218; cv=none; b=MCSu1fmJsr2zepde7xp58z55D7WIh5UdkC5wfkVumzIK9pELQ/DGH2bLG46kARs/ZMsHH9buyUN9irzMiexeAB97jq4u/5smjg3ZiA6QMggOOi6Jn9VXdwSuqgoja/2rkQSw3a2fMYLLLjoF5EX/W3zicP0YTJBSnKeUjZbVcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986218; c=relaxed/simple;
	bh=TEwGEXAiXPihZpryiTp34CJavZYQMOxb4M1Wre0+0Nw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NN6+RJAP/k9EqLR+eahfaeJyQdmdUqCOAE1yt6efpyqpngVWl/WTRVSctUlSUdZZgleK1b8svPPhR/239odhHGGZ+vOHGjWTeBPEMh4BWbDwdDMEvcb+C5xdv/s2rSvDObNLFwxcImfIsA4z8TfxBqZg37bSD+VwGBNMjGrhDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLdgGRcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF07CC4CEF1;
	Tue, 16 Sep 2025 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986216;
	bh=TEwGEXAiXPihZpryiTp34CJavZYQMOxb4M1Wre0+0Nw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kLdgGRcvSYMBKpv2MZevGrA2MMFTohQd3RpZckKOnJQx58NwFu9SaaM4XI2EKYK7e
	 cDxa8aWf/goNUsQLpum8tS1MSlwwPTWrp3NnsGfXB6lIEt60qavIaeSgrdcczX5CCy
	 tHfB5bg6MlxmUTfzhfG1izVnnN/7ipCSNTMBrPyOITvwmsugvX/0En/N9IWlFQZ78M
	 cCeguwnJzCcxMuZeFsxxd1/3BefhaiYk3i989H9vIIepgXGTRg/TR7uqtuhk7mC3Q1
	 lyRGFmcouGZM2UQyWXD/hAno8Kk1eXN28oPiIqHc8orXuzicft45b3O5BhH6m6xOT/
	 +Gui56xLpH4tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7156839D0C17;
	Tue, 16 Sep 2025 01:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: pm: nl: announce deny-join-id0 flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798621825.559370.16652026022818101575.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:18 +0000
References: 
 <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
In-Reply-To: 
 <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, fw@strlen.de, kishen.maloor@intel.com,
 shuah@kernel.org, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, marek@cloudflare.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 14:52:19 +0200 you wrote:
> During the connection establishment, a peer can tell the other one that
> it cannot establish new subflows to the initial IP address and port by
> setting the 'C' flag [1]. Doing so makes sense when the sender is behind
> a strict NAT, operating behind a legacy Layer 4 load balancer, or using
> anycast IP address for example.
> 
> When this 'C' flag is set, the path-managers must then not try to
> establish new subflows to the other peer's initial IP address and port.
> The in-kernel PM has access to this info, but the userspace PM didn't,
> not letting the userspace daemon able to respect the RFC8684.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: set remote_deny_join_id0 on SYN recv
    https://git.kernel.org/netdev/net/c/96939cec9940
  - [net,2/5] mptcp: pm: nl: announce deny-join-id0 flag
    https://git.kernel.org/netdev/net/c/2293c57484ae
  - [net,3/5] selftests: mptcp: userspace pm: validate deny-join-id0 flag
    https://git.kernel.org/netdev/net/c/24733e193a0d
  - [net,4/5] mptcp: tfo: record 'deny join id0' info
    https://git.kernel.org/netdev/net/c/92da495cb657
  - [net,5/5] selftests: mptcp: sockopt: fix error messages
    https://git.kernel.org/netdev/net/c/b86418beade1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



