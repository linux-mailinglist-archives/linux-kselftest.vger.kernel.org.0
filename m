Return-Path: <linux-kselftest+bounces-5707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33486DF6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FBB1F2721C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643C86CDBD;
	Fri,  1 Mar 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0e3PIiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C526BFA8;
	Fri,  1 Mar 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289631; cv=none; b=PsMRBvv7bnu5gIqw8cXMs8erjfid8cKtHUttXlDioXLUzqkI26/YaY6G8syqE2hYWCDPRWCTNgsOKBnoI7vgTKldjl7jNMUwot7vrJTxdlnyvdzrfeLW7azWlnr9rI2IwtTU5v97ecbP4VtZnqlEfN//ZEQNW17B8B4HMnSsP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289631; c=relaxed/simple;
	bh=gZi/AY9atkfoxOiyqbo/g6lCZx2va4Vho5HFwtw0GZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bNpTDPsLniNYQLRyGpDd88Fs9XpVJlleLLFhyp+n3o4pkga+lDDNtSibBWjfZZZmA+yU77vDoidFN9qpMY5MbV2+INi7cOycmAT2w8tJbDrha17+s9GF0vy3XLs0XJszu5QckFQtAzxe3GiA6ykbBoulqY1SZJ5/ozVzeNdTDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0e3PIiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2C16C43390;
	Fri,  1 Mar 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709289630;
	bh=gZi/AY9atkfoxOiyqbo/g6lCZx2va4Vho5HFwtw0GZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h0e3PIiwkZI76XuXlESEIooGZbnbBheN+uz7Q4yoDcbpGANT6u4uV7+xhmBxNj8O1
	 JvzLds8mU9ox2pCgVkB4FAPU/NB8Pke+VR3Y+we915NBhV/wgBRZZRNWpGFY7oe2q7
	 v7Lp0ZxpU+uK4/S1O5NnauUikzXcI5oFNPxAR/V/z1YRfG1CdXLR71qZQHx8MntBrF
	 Ly2lvwPs6yk7k6xYgTEPHPXjaZFVTT3eSbZxhoThurKXN06n1rj12unVpqRVtg8D7J
	 hZ04uNbdLUY1LqJJUQ/oG4th9bPkyNhPUBdKdVFb1MTcVMle0J3KCWDRQgoW/CojEs
	 Whlk51x+tZVbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB10BC595C4;
	Fri,  1 Mar 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using xfail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170928963069.1389.8505815378862616818.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 10:40:30 +0000
References: <20240229005920.2407409-1-kuba@kernel.org>
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 mic@digikod.net, linux-security-module@vger.kernel.org,
 keescook@chromium.org, jakub@cloudflare.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 16:59:07 -0800 you wrote:
> Hi!
> 
> When running selftests for our subsystem in our CI we'd like all
> tests to pass. Currently some tests use SKIP for cases they
> expect to fail, because the kselftest_harness limits the return
> codes to pass/fail/skip. XFAIL which would be a great match
> here cannot be used.
> 
> [...]

Here is the summary with links:
  - [v4,01/12] selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
    https://git.kernel.org/netdev/net-next/c/e74048650eaf
  - [v4,02/12] selftests/harness: Merge TEST_F_FORK() into TEST_F()
    https://git.kernel.org/netdev/net-next/c/0710a1a73fb4
  - [v4,03/12] selftests: kselftest_harness: use KSFT_* exit codes
    https://git.kernel.org/netdev/net-next/c/a724707976b0
  - [v4,04/12] selftests: kselftest_harness: generate test name once
    https://git.kernel.org/netdev/net-next/c/38c957f07038
  - [v4,05/12] selftests: kselftest_harness: save full exit code in metadata
    https://git.kernel.org/netdev/net-next/c/69fe8ec4f673
  - [v4,06/12] selftests: kselftest_harness: use exit code to store skip
    https://git.kernel.org/netdev/net-next/c/796a344fa431
  - [v4,07/12] selftests: kselftest: add ksft_test_result_code(), handling all exit codes
    https://git.kernel.org/netdev/net-next/c/fa1a53d83674
  - [v4,08/12] selftests: kselftest_harness: print test name for SKIP
    https://git.kernel.org/netdev/net-next/c/732e2035280b
  - [v4,09/12] selftests: kselftest_harness: separate diagnostic message with # in ksft_test_result_code()
    https://git.kernel.org/netdev/net-next/c/42ab727eb95f
  - [v4,10/12] selftests: kselftest_harness: let PASS / FAIL provide diagnostic
    https://git.kernel.org/netdev/net-next/c/378193eff339
  - [v4,11/12] selftests: kselftest_harness: support using xfail
    https://git.kernel.org/netdev/net-next/c/2709473c9386
  - [v4,12/12] selftests: ip_local_port_range: use XFAIL instead of SKIP
    https://git.kernel.org/netdev/net-next/c/c05bf0e93312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



