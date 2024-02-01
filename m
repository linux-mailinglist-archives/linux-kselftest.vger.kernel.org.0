Return-Path: <linux-kselftest+bounces-3944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A74845E5B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 18:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316471F276B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BA31649D8;
	Thu,  1 Feb 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txv4arnq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86F1649A7;
	Thu,  1 Feb 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808028; cv=none; b=si2INydRqWg4fW1NXetxKo/fVBIxxYmgfxj7C5zanuCM+X/m70p3QVM5wUzVO8rZcirSIfipcbzL0inBdStOAAWL02tDtQ0cvZOyPM+zY9EWV5RzovdNNqHeL5p6URR6hf+APFNqkt+3RS7MmYX/je4KLpMFtMfTCbn4W7PBLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808028; c=relaxed/simple;
	bh=pxNxp2jInNaPMPU2mt5mwA5Yn1hERV9B5vHmU6y78cw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GNrzR+wjU+cBdIHJY2Tw1g1J/bNx8YRy7myeyWP1+tjs7gQRFQQJixA7OF7vaCRonI4/LuXkC4kgFpEPggCkK1sg3JFwDsWfi6H012Y2uSsJuXOsO4IbbOwpogxVAxxHb/kb6AaOJca+uF9xm7HFlXv8Axve+v7+mn0KH6CMBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txv4arnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01FE3C43394;
	Thu,  1 Feb 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808028;
	bh=pxNxp2jInNaPMPU2mt5mwA5Yn1hERV9B5vHmU6y78cw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Txv4arnq5wa9wJ+pWoG2Dr0OS7TPVffhW1PLyUO0eNDFSgmDM14vZCJ2554f1g2lO
	 iF+o53AhSB3TAkhVeNfffg7T4nRAKxnW8MhjFhs3NqHta2guik0wPr9hCsAJz7uKH2
	 0VyBOx56/LRJSzNGUMOjw3+Erjx6dVMx4UGpl/hZ1DFjVvf6C0btl1etZUx+DBnSWi
	 J5ejAcwWADKgVR8kyZ2u8nFuo9A4FkfpPW2D2NG3xRojuET0rAlTfGRnRKaxM7lvpH
	 jQqPLW7YGWs8lnjyWqV3kqLxJ8chB0RO1nnflm0zZKnDEGJbKVEGelopWBQ75gRBjD
	 iUDI963VPRrGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDEF8D8C978;
	Thu,  1 Feb 2024 17:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] mptcp: fixes for recent issues reported by CI's
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680802790.24895.13487831241333435786.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 17:20:27 +0000
References: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
In-Reply-To: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang.tang@linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, geliang@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jan 2024 22:49:45 +0100 you wrote:
> This series of 9 patches fixes issues mostly identified by CI's not
> managed by the MPTCP maintainers. Thank you Linero (LKFT) and Netdev
> maintainers (NIPA) for running our kunit and selftests tests!
> 
> For the first patch, it took a bit of time to identify the root cause.
> Some MPTCP Join selftest subtests have been "flaky", mostly in slow
> environments. It appears to be due to the use of a TCP-specific helper
> on an MPTCP socket. A fix for kernels >= v5.15.
> 
> [...]

Here is the summary with links:
  - [net,1/9] mptcp: fix data re-injection from stale subflow
    https://git.kernel.org/netdev/net/c/b6c620dc43cc
  - [net,2/9] selftests: mptcp: add missing kconfig for NF Filter
    https://git.kernel.org/netdev/net/c/3645c844902b
  - [net,3/9] selftests: mptcp: add missing kconfig for NF Filter in v6
    https://git.kernel.org/netdev/net/c/8c86fad2cecd
  - [net,4/9] selftests: mptcp: add missing kconfig for NF Mangle
    https://git.kernel.org/netdev/net/c/2d41f10fa497
  - [net,5/9] selftests: mptcp: increase timeout to 30 min
    https://git.kernel.org/netdev/net/c/4d4dfb2019d7
  - [net,6/9] selftests: mptcp: decrease BW in simult flows
    https://git.kernel.org/netdev/net/c/5e2f3c65af47
  - [net,7/9] selftests: mptcp: allow changing subtests prefix
    https://git.kernel.org/netdev/net/c/de46d138e773
  - [net,8/9] selftests: mptcp: join: stop transfer when check is done (part 1)
    https://git.kernel.org/netdev/net/c/31ee4ad86afd
  - [net,9/9] selftests: mptcp: join: stop transfer when check is done (part 2)
    https://git.kernel.org/netdev/net/c/04b57c9e096a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



