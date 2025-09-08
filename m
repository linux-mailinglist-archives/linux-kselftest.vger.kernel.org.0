Return-Path: <linux-kselftest+bounces-40987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725FB49AB9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 22:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC67207EE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAD2D7DDD;
	Mon,  8 Sep 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlxUEUSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961426E711;
	Mon,  8 Sep 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362208; cv=none; b=HYONaj6tPAGt4iwo8GWW3wQtCCFR8vN2Za/9uYHByTCV2Gd03wGqxoCHG2DGuXNHDWYIqgtsqEjCXZXVJZ0M7yL4/AxPRMi7TP16qScRZNxD+XXK89T+sne6M5C/s6SOIMAdeyIgOJ5lAD3ZvFjaM7otwvpEyJm+faQMbA0Xa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362208; c=relaxed/simple;
	bh=RhhKkx5/dYL03cBRWV5noG3hsTzS51vVTlVF7sQGqAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9GDYu2AuJqAljR1qrxKrqhwR271vjs7jXRvCJysRRRveP8XDQZJlGdp6Weu2rkapxZR2+zFYUxu9lnjgYO42aUturSbxCTwy9xXGSO3SHDYoJFWX1LyX+phy0XCW1SQdQNMPY+BpIGIiAiuaAvejgB6G2hmEfvwUcAmJPK9hdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlxUEUSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE57C4CEF1;
	Mon,  8 Sep 2025 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757362208;
	bh=RhhKkx5/dYL03cBRWV5noG3hsTzS51vVTlVF7sQGqAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZlxUEUSjL+o/vEZw0YCfETDLvoKipbB9AmSTweSDG8dHD0cuY+iCAwSPKdFpqK0jX
	 1shc8XAXrfWKBTwoPX+HeLnpnww2COeR/ipNxyiL5tvGClM2dbFsPmD0r/OyR7qrRh
	 Nf4Mnushra2mmpENDKkui67oF5py2YyT/lCVz328qvMFNoR/ryJCbqZQpu9vIzsOw2
	 nAsD41fW9epBSiE/4L/sgdcKZscKqnxjoNwOKsM8fb0PCrW1+OUNV+x0dRXQxBaXqJ
	 YnIn2zcjRYkLx+EEdHlLFUMssC5oQ4zXLoCPoy0Mg0snJw9u7HmZZdiyA707TwRQGz
	 k5vzU216ETR7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE5383BF69;
	Mon,  8 Sep 2025 20:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests: net: make the dump test less
 sensitive to mem accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175736221151.38690.11343900699202360158.git-patchwork-notify@kernel.org>
Date: Mon, 08 Sep 2025 20:10:11 +0000
References: <20250906211351.3192412-1-kuba@kernel.org>
In-Reply-To: <20250906211351.3192412-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Sep 2025 14:13:50 -0700 you wrote:
> Recent changes to make netlink socket memory accounting must
> have broken the implicit assumption of the netlink-dump test
> that we can fit exactly 64 dumps into the socket. Handle the
> failure mode properly, and increase the dump count to 80
> to make sure we still run into the error condition if
> the default buffer size increases in the future.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: net: make the dump test less sensitive to mem accounting
    https://git.kernel.org/netdev/net-next/c/27bc5eaf004c
  - [net-next,2/2] selftests: net: move netlink-dumps back to progs
    https://git.kernel.org/netdev/net-next/c/f3883b1ea5a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



