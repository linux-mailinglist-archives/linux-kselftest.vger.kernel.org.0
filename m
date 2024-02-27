Return-Path: <linux-kselftest+bounces-5469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500FD8687B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 04:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45F4B26B09
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F131EF1E;
	Tue, 27 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds6+qhyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E91B949;
	Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709004030; cv=none; b=lPbXziJ4TJ75dY7PkKvuuZSBBxVXBaH+15dXDDPDn4p6ZeobF8sy1LP/JdQoow3Pig6t4T+OhUSrIaSBUnH9h9yf1lXo4LpM9o/hTwPOvBRXBiob98Ro+RzSLW5lDE9QJNCHGxggTgk+aZBnYf0FJxPL7zd8GZERlDIPYcJvvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709004030; c=relaxed/simple;
	bh=s2eioNfukDMALIYmsfTbL/3nVLukiMf2+0qLoHY9ES8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AyPDmorH+dsUhtG4MRNGrSYYF40EXcH+IOT1fDHKMu8vgkxjU5hbp3ALQlxLBT7ev6yy2UMzF6qHY/b7caJenq8GaEtPvq239CT3C3aW9mJAd108b9BquwgCi+H07bpH3KuSnfURIhpha5SJ5HtPZvF7KPv8WaYCY8rUr4kxyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds6+qhyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75D2BC43394;
	Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709004030;
	bh=s2eioNfukDMALIYmsfTbL/3nVLukiMf2+0qLoHY9ES8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ds6+qhydg6HvWtNREWG8A+IjqexZMZ7YWnTYjxMV+C485aQAvxyCnH9eGyGicW580
	 Sgm2PDzkvNPOd80rCdTMHbuHKt+5DbsdufrqTDeeD4Njtfkh8LJk3B6lgk2TXA+MVF
	 dVQ274u4amFeRIN3El/DsS4hhzl6rB9hOamyu7JahaHjIdp+EBDan3VUMui1u9PdBD
	 48sa5tgNPsjZxIyzWlm7NbHmk6YIj3BC+a4/dm3+PrMnoeoMSzIvSHl3/KWA7wwJCV
	 6Z31sUvzHAu1jbE0DSdlq45nI6xzz3Xcc83t7QIRqIPAAkwWQDxbGm1QW2fqDrQLxe
	 1alt0e3SzRnBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55D29D8C976;
	Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] mptcp: various small improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170900403034.25082.12541895722139534693.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 03:20:30 +0000
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, tanggeliang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Feb 2024 21:17:52 +0100 you wrote:
> This series brings various small improvements to MPTCP and its
> selftests:
> 
> Patch 1 prints an error if there are duplicated subtests names. It is
> important to have unique (sub)tests names in TAP, because some CI
> environments drop (sub)tests with duplicated names.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] selftests: mptcp: lib: catch duplicated subtest entries
    https://git.kernel.org/netdev/net-next/c/9da74836740d
  - [net-next,2/8] mptcp: token kunit: set protocol
    https://git.kernel.org/netdev/net-next/c/28de50eeb734
  - [net-next,3/8] mptcp: check the protocol in tcp_sk() with DEBUG_NET
    https://git.kernel.org/netdev/net-next/c/dcc03f270d1e
  - [net-next,4/8] mptcp: check the protocol in mptcp_sk() with DEBUG_NET
    https://git.kernel.org/netdev/net-next/c/14d29ec5302c
  - [net-next,5/8] selftests: mptcp: netlink: drop duplicate var ret
    https://git.kernel.org/netdev/net-next/c/488ccbe76cb4
  - [net-next,6/8] selftests: mptcp: simult flows: define missing vars
    https://git.kernel.org/netdev/net-next/c/fccf7c922459
  - [net-next,7/8] selftests: mptcp: join: change capture/checksum as bool
    https://git.kernel.org/netdev/net-next/c/8c6f6b4bb53a
  - [net-next,8/8] selftests: mptcp: diag: change timeout_poll to 30
    https://git.kernel.org/netdev/net-next/c/e8ddc5f255c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



