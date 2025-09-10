Return-Path: <linux-kselftest+bounces-41087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D45B50A7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 03:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8640A443723
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 01:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D24224AE0;
	Wed, 10 Sep 2025 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew8GiYGx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4007221F06;
	Wed, 10 Sep 2025 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469007; cv=none; b=RueCJot3XurEbVhWq3ADvyQsMdm42U3iQq7FMGSrICEWtZZu5jVZuLpi8hfwu2+oCPw9tKBn76lMlOrIhgM6QHib8V4FuFlO8PNxRbAmt/5XUQyKx5Krh+Gwrns1fiN71XGy2Q+te3zAaw8Muynt06hi9sFGrQQ5fTkpO+Y19sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469007; c=relaxed/simple;
	bh=xcMbxq68mHjENi1WkmjxOX64pUgX31sPw0jQSLLPWnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UHFaKJ9lQSVfmiAF+odFyQncvPJTLOHq4+stoevak3mgi6JBrN2TB9RK+cdI1YsjxyM6hMTJn7YvySaKdNjLPYmwbQHJPDYH5IY1SU0IwBZQLUQG9hOfre3A0rau2AfvxKqL464fA1HM2Qd+6wJqRRauk4C12GSII/h5ZZ7w6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew8GiYGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26609C4CEF4;
	Wed, 10 Sep 2025 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757469007;
	bh=xcMbxq68mHjENi1WkmjxOX64pUgX31sPw0jQSLLPWnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ew8GiYGxM68JfRi4OnQe9RK68QnJcAsEXY5WkTZh9gw3RrL4uhAPYQ8GGWUiksEdG
	 W8jxuHyZ8sYdShYrkRxAF55Wnv3LS8ThqrgY+yNUbkRT9R668fY1AH1H1wMaFyYG0+
	 PLD27Vyv99Mu07msxN3EEop12wBCLixH0A7diQgmoXyHoIgN7GMhTo1hvqF1CPEVhu
	 qKkGXKRJ2EvzeIINg5ZS3wTzf9kTpaS1BEDNgwdRqff5IF/mWd/kx6NSUcvBK+JTIb
	 AdbBY+s8cgj9sSFrgEfjskLgsuAUmPiWnaGau/oTG8p5g0XDHXt8m55BdNE2wQvZWC
	 lMKBSoDUKitUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D03383BF69;
	Wed, 10 Sep 2025 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: misc fixes for v6.17-rc6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746901031.871782.6846414902696606931.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 01:50:10 +0000
References: 
 <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
In-Reply-To: 
 <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, dcaratti@redhat.com, corbet@lwn.net,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Sep 2025 23:27:26 +0200 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: Fix a wrong attribute type in the MPTCP Netlink specs. A fix
>   for v6.7.
> 
> - Patch 2: Avoid mentioning a deprecated MPTCP sysctl knob in the doc. A
>   fix for v6.15.
> 
> [...]

Here is the summary with links:
  - [net,1/3] netlink: specs: mptcp: fix if-idx attribute type
    https://git.kernel.org/netdev/net/c/7094b84863e5
  - [net,2/3] doc: mptcp: net.mptcp.pm_type is deprecated
    https://git.kernel.org/netdev/net/c/6f021e95d082
  - [net,3/3] selftests: mptcp: shellcheck: support v0.11.0
    https://git.kernel.org/netdev/net/c/ef1bd93b3b92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



