Return-Path: <linux-kselftest+bounces-46411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B109BC8330A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D333ABA80
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 03:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01721209F43;
	Tue, 25 Nov 2025 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7VhwAXg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703B1FFC48;
	Tue, 25 Nov 2025 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040260; cv=none; b=AJQ0KFE81fVFf6/Mw+C3HuWdbTfsFCYn2/ibXMXhrQ9yK59TK8h4yUSaFRiuQQUTdOB5/FTOYTJ5t+o0Q0LDZbePxWhISwhjujne+SZjmKg6BQsyPUexTX3trTPne5yb4sGEgB2hlrGGxZ7jUmseBpPCIVb32/lGnbMPsta/3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040260; c=relaxed/simple;
	bh=W7o467FUJCAvte668Za4SMtl5MroyU0t0GpTDeOW8BY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=knD8/ftTNIAd5Vpg4nxIGJ7bzvJ6arNGmg+i3HfhqWwlXSB5+r0fH8C3FgfsCClEKF+swsBl3e7dVZWE9i3i/4RfrbXNLV0xT0a1KEOnZye30GGNPEl96bEFpKkyfy2fw2XGItksyY3CodPT1HHd1bncv7YFYNq4AIP/9/cNpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7VhwAXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503D7C4CEF1;
	Tue, 25 Nov 2025 03:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040260;
	bh=W7o467FUJCAvte668Za4SMtl5MroyU0t0GpTDeOW8BY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c7VhwAXgdA2DHFHEcWtyvrjtNxRZPWA/9Y0vumvXxN/ealXAGegyzdmtIIazAm4ar
	 gKX9nWw20Q9Ugej0X0w1AsY0pi4zDR6VX9EIDUgfYbnNBIIlsoEvT5yZDnSXcChMn0
	 o3m/95F/pla4ovYOn1yJftT39utcTaP2IAnVaFgg16MGuCN+eAfCGy76mqm5QB1GFv
	 m2lEIMyT55QfrDYTqnrk2iSCRxi/gmEDvfk89+FGupcCCiPlRzKkE0T1ARczOlHhmw
	 MF9OQLkIwwe7X307QsfaN1ILA+vtjWS2rLZn0fyfjhjXJMKADhVj/E9oJX+5hlpI3/
	 XnTxcZXbkqbnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E853A8A3CA;
	Tue, 25 Nov 2025 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: netconsole: ensure required log level
 is set on netcons_basic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404022275.167368.10236479114735000178.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 03:10:22 +0000
References: <20251121-netcons-basic-loglevel-v1-1-577f8586159c@gmail.com>
In-Reply-To: <20251121-netcons-basic-loglevel-v1-1-577f8586159c@gmail.com>
To: Andre Carvalho <asantostc@gmail.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 15:00:22 +0000 you wrote:
> This commit ensures that the required log level is set at the start of
> the test iteration.
> 
> Part of the cleanup performed at the end of each test iteration resets
> the log level (do_cleanup in lib_netcons.sh) to the values defined at the
> time test script started. This may cause further test iterations to fail
> if the default values are not sufficient.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: netconsole: ensure required log level is set on netcons_basic
    https://git.kernel.org/netdev/net-next/c/00f3b3251814

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



