Return-Path: <linux-kselftest+bounces-6232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D04878AA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 23:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049101F22DB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26957330;
	Mon, 11 Mar 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncIpVrqC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6B58104;
	Mon, 11 Mar 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195632; cv=none; b=cF9kI/SqEH0uXpLTNKIGw0a5keWv7gZ1VhX0KTeKfUrhN4/Lh5sc1d/vdNtRQCj0uA+jQxGQ5imBtWFEV3LBzRX+Suff9CGos3iu7FY9bSzBtuMiXu+G/0hPmPGi6998rlT0P13fV7xsH2b9ahs9PhXc6cuMuq5JnV4gn0zcWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195632; c=relaxed/simple;
	bh=wpoixAH5hmLkM35K/YQ7kamEzrI2/hx3uKaAyzVuvW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k1mHRMDB9reRc+1vlxi25M6YiA2IxU837AG8j6NXJuBeJz3bWaNJDYjvcDWJ1gNjQuWrjaMnbBGhqslvyan1sIXEewzBsmG9p/ZS7tBo2EOIuL5aioraJdQiXt05gZR8zQZPnySK2x1IvvhIegEyse4X7n4hhZO+mqIMWKVg2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncIpVrqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9161EC43390;
	Mon, 11 Mar 2024 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710195631;
	bh=wpoixAH5hmLkM35K/YQ7kamEzrI2/hx3uKaAyzVuvW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ncIpVrqCU/a4KDUIUnKzFzOXKQFqdMKJhN1H9cFpEi4WQ49Y+8tEhAcTArdYMbGSl
	 CYNwlWMMJ7pqSXzqzuKEKz7zCSN4lUKIMHL2THGIyLYKsZ4m0/e3NLcUtPDHZbUOTO
	 8HBkpezzTDrpjoA3mdxMnhXIN4EqeLPTpOqqvxGIpYuj1N8xn4RI+VImGeSujOs7F2
	 VOvXMc19ZtL4g2No/59y9BZAi+29HNOxKFQ77wDNBZNI+/2L53hpVvH6U5cdWp8Jqn
	 X42lCpLrfFBfOh2FbKOp48kzcvi1RpvvwVbTTkDGWp5tpiDRlvlTD5/EGIvYKUQb0Y
	 Zw671a3g4LB9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74BA0D95056;
	Mon, 11 Mar 2024 22:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] selftests: mptcp: various improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019563147.21986.8830557428552738563.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:20:31 +0000
References: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
In-Reply-To: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 tanggeliang@kylinos.cn, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Mar 2024 23:10:07 +0100 you wrote:
> In this series from Geliang, there are various improvements in MPTCP
> selftests: sharing code, doing actions the same way, colours, etc.
> 
> Patch 1 prints all error messages to stdout: what was done in almost all
> other MPTCP selftests. This can be now easily changed later if needed.
> 
> Patch 2 makes sure the test counter is continuous in mptcp_connect.sh.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] selftests: mptcp: print all error messages to stdout
    https://git.kernel.org/netdev/net-next/c/6215df11b945
  - [net-next,02/15] selftests: mptcp: connect: add dedicated port counter
    https://git.kernel.org/netdev/net-next/c/01ed9838107f
  - [net-next,03/15] selftests: mptcp: connect: fix misaligned output
    https://git.kernel.org/netdev/net-next/c/c9161a0f8ff9
  - [net-next,04/15] selftests: mptcp: sockopt: print every test result
    https://git.kernel.org/netdev/net-next/c/fd959262c1bb
  - [net-next,05/15] selftests: mptcp: export TEST_COUNTER variable
    https://git.kernel.org/netdev/net-next/c/9e6a39ecb9a1
  - [net-next,06/15] selftests: mptcp: add print_title in mptcp_lib
    https://git.kernel.org/netdev/net-next/c/3382bb09701b
  - [net-next,07/15] selftests: mptcp: print test results with counters
    https://git.kernel.org/netdev/net-next/c/aa7694766f14
  - [net-next,08/15] selftests: mptcp: use += operator to append strings
    https://git.kernel.org/netdev/net-next/c/e7c42bf4d320
  - [net-next,09/15] selftests: mptcp: print test results with colors
    https://git.kernel.org/netdev/net-next/c/747ba8783a33
  - [net-next,10/15] selftests: mptcp: call test_fail without argument
    https://git.kernel.org/netdev/net-next/c/339c225e2e03
  - [net-next,11/15] selftests: mptcp: extract mptcp_lib_check_expected
    https://git.kernel.org/netdev/net-next/c/663260e14668
  - [net-next,12/15] selftests: mptcp: print_test out of verify_listener_events
    https://git.kernel.org/netdev/net-next/c/8ebb44196585
  - [net-next,13/15] selftests: mptcp: add mptcp_lib_verify_listener_events
    https://git.kernel.org/netdev/net-next/c/7f0782ca1ce9
  - [net-next,14/15] selftests: mptcp: declare event macros in mptcp_lib
    https://git.kernel.org/netdev/net-next/c/23a0485d1c04
  - [net-next,15/15] selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL
    https://git.kernel.org/netdev/net-next/c/8f7a69a8e7dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



