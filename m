Return-Path: <linux-kselftest+bounces-12926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1C91BC13
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597C9285880
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AE21509B6;
	Fri, 28 Jun 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxgzzkOU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090529CED;
	Fri, 28 Jun 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568835; cv=none; b=QGaBWg869+1ANGPlfvcmih91gPEpZu8Tu8K0Q/rHci9QXwkhATcxTgPfTXeonDNlfCGcjwyATteDaPRK/MMVvTPQtCga6AVx4omqvphy8sotNqzg6qKMlE5v6Vl2hvsQKZliR1GYNLcsli/+M7NbPe5tP4piqG1y/Wysi231qFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568835; c=relaxed/simple;
	bh=sttuXA446k6D9TJkn9PvBWJSSFpboC++0Ostq9+OwfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bILXP6hIlCTuXvToW/dOABu+wU5LG5lBOJUnAsRrCfdhzYOpzveW5g5O1CmgUBu6AwjsqzbW2kmGa181eQaGCcTRgi8cODWuQDehdn1HXCCHz2OyIxH8dR3Tutou8nUbJYYrj41L5SOzntn7llIdCaO8KBGdp8gJJp5PK9JaeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxgzzkOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF2EBC2BD10;
	Fri, 28 Jun 2024 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719568834;
	bh=sttuXA446k6D9TJkn9PvBWJSSFpboC++0Ostq9+OwfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YxgzzkOUxuXEoS4aFJ8R5NvZe+jIIY+YODEYxMcQ+uWPpEAfjvdkNK5rrGPHVrbvR
	 JE2KYX3p1YapwXaOxnhU8BOnpltMUXJZ5qJLAd0HtHjnaMRdhEirySCpQjgj3jWZ27
	 aXr6q3S2pqeiSVEGpw8YnysQikQYdc61usFV6KIb6KkI/oI1yrw4TZeext7DCruDUP
	 n0kmCxerLDPms5Wwf1LwUGmIAl1RI6h0lhKynxSX/sPrrGNZ3CYlENt8DT/xjoNKdr
	 hUkmgWKaOQQAwqfxLQDfviKCXAUCNQN0sxVr9T3XM+pwi/n++rfZx21HRW/I2ohl4R
	 AfGkq7ZAoiJng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E644C43336;
	Fri, 28 Jun 2024 10:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] selftest: Clean-up and stabilize mirroring
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171956883464.3919.11261341369331277136.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 10:00:34 +0000
References: <cover.1719497773.git.petrm@nvidia.com>
In-Reply-To: <cover.1719497773.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, danieller@nvidia.com,
 idosch@nvidia.com, liuhangbin@gmail.com, bpoirier@nvidia.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, horms@kernel.org,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jun 2024 16:48:37 +0200 you wrote:
> The mirroring selftests work by sending ICMP traffic between two hosts.
> Along the way, this traffic is mirrored to a gretap netdevice, and counter
> taps are then installed strategically along the path of the mirrored
> traffic to verify the mirroring took place.
> 
> The problem with this is that besides mirroring the primary traffic, any
> other service traffic is mirrored as well. At the same time, because the
> tests need to work in HW-offloaded scenarios, the ability of the device to
> do arbitrary packet inspection should not be taken for granted. Most tests
> therefore simply use matchall, one uses flower to match on IP address.
> As a result, the selftests are noisy.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] selftests: libs: Expand "$@" where possible
    https://git.kernel.org/netdev/net-next/c/d5fbb2eb33c2
  - [net-next,02/12] selftests: mirror: Drop direction argument from several functions
    https://git.kernel.org/netdev/net-next/c/28e67746b73d
  - [net-next,03/12] selftests: lib: tc_rule_stats_get(): Move default to argument definition
    https://git.kernel.org/netdev/net-next/c/9b5d5f272654
  - [net-next,04/12] selftests: mirror_gre_lag_lacp: Check counters at tunnel
    https://git.kernel.org/netdev/net-next/c/95e7b860e16d
  - [net-next,05/12] selftests: mirror: do_test_span_dir_ips(): Install accurate taps
    https://git.kernel.org/netdev/net-next/c/833415358f34
  - [net-next,06/12] selftests: mirror: mirror_test(): Allow exact count of packets
    https://git.kernel.org/netdev/net-next/c/a86e0df9ce25
  - [net-next,07/12] selftests: mirror: Drop dual SW/HW testing
    https://git.kernel.org/netdev/net-next/c/d361d78fe2cc
  - [net-next,08/12] selftests: mlxsw: mirror_gre: Simplify
    https://git.kernel.org/netdev/net-next/c/388b2d985a13
  - [net-next,09/12] selftests: mirror_gre_lag_lacp: Drop unnecessary code
    https://git.kernel.org/netdev/net-next/c/95d33989cee5
  - [net-next,10/12] selftests: libs: Drop slow_path_trap_install()/_uninstall()
    https://git.kernel.org/netdev/net-next/c/4e9cd3d03af2
  - [net-next,11/12] selftests: libs: Drop unused functions
    https://git.kernel.org/netdev/net-next/c/06704a0d5e67
  - [net-next,12/12] selftests: mlxsw: mirror_gre: Obey TESTS
    https://git.kernel.org/netdev/net-next/c/098ba97d0e89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



