Return-Path: <linux-kselftest+bounces-4914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13462859643
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Feb 2024 11:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC8B284787
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Feb 2024 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054D3CF5E;
	Sun, 18 Feb 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC9TbaFt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7F383B0;
	Sun, 18 Feb 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252226; cv=none; b=U9vtFT8DtMj3XFymEm/SgaTCX7ivVZwOtF9Jjg9SmnqT1wHPLZAeiWqPwdE1A1tOxoSNNfSYSNTwM/IoPKMiu9V3AhToY/+wUj81j8Cr+mhnUW4ui0KFn0TflEfn3s4GEvkGNyDDGcHAa+zJBStIjP6gcqcqpTeHT/PQ1+eG/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252226; c=relaxed/simple;
	bh=3+SCX68+BR4ikcTOVUJ8dLGXtBO7YBQJrQoEZ0s5SlQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mNvW/yQb+DI2R7RKJjfVGe8sLp9j8l6jCP+4QqG7BPS1KHedZsQG3ZrfszREQkAHH30kveAWyM6ixnFX/wFMsMq+hXCNJkaIcxgLO+82Xyhk+lqyzgMWaAlpZzt7ug1eH2nRQRDoQ97OSkjYoSXqrBdq9PANSju3jj5aWL8TGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC9TbaFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 606EBC43390;
	Sun, 18 Feb 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708252226;
	bh=3+SCX68+BR4ikcTOVUJ8dLGXtBO7YBQJrQoEZ0s5SlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EC9TbaFtKL2cffq/Tnbi117BoptMRJgSL3M6ne1V4ew7Yk7Xo+gE5//ta/TYWCA8N
	 I5gyesn/3Dq+YL1+Z20nFZXVwqI2FlC8I3+7tJMb9DKjMAYrdCfdCkgRFAhtBzvMk+
	 85IDAWpXGd+lRqHSpFj8uiwA7yXutCFyHLJarla05FN6+dzMGNKsEEgTDE9uwEKC8E
	 KH3pCYQzJosIkkiEQnpWi/tWWHByUXJYtxkSsHhbPokC2gDwG3ZzvBoQuJSmPhlgHi
	 DIYEQAa5QKskn+DzQcawpP+S94RJJXmpBlOdNDORJf17Bezgb2Z90h9TjHbQpvmw2V
	 MctjWI6PLI44w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45BD5DC99F1;
	Sun, 18 Feb 2024 10:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/13] mptcp: misc. fixes for v6.8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170825222628.22893.6012598424482602231.git-patchwork-notify@kernel.org>
Date: Sun, 18 Feb 2024 10:30:26 +0000
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dcaratti@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 tanggeliang@kylinos.cn, stable@vger.kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 19:25:27 +0100 you wrote:
> This series includes 4 types of fixes:
> 
> Patches 1 and 2 force the path-managers not to allocate a new address
> entry when dealing with the "special" ID 0, reserved to the address of
> the initial subflow. These patches can be backported up to v5.19 and
> v5.12 respectively.
> 
> [...]

Here is the summary with links:
  - [net,01/13] mptcp: add needs_id for userspace appending addr
    https://git.kernel.org/netdev/net/c/6c347be62ae9
  - [net,02/13] mptcp: add needs_id for netlink appending addr
    https://git.kernel.org/netdev/net/c/584f38942626
  - [net,03/13] mptcp: fix lockless access in subflow ULP diag
    https://git.kernel.org/netdev/net/c/b8adb69a7d29
  - [net,04/13] mptcp: fix data races on local_id
    https://git.kernel.org/netdev/net/c/a7cfe7766370
  - [net,05/13] mptcp: fix data races on remote_id
    https://git.kernel.org/netdev/net/c/967d3c27127e
  - [net,06/13] mptcp: fix duplicate subflow creation
    https://git.kernel.org/netdev/net/c/045e9d812868
  - [net,07/13] selftests: mptcp: pm nl: also list skipped tests
    https://git.kernel.org/netdev/net/c/d2a2547565a9
  - [net,08/13] selftests: mptcp: pm nl: avoid error msg on older kernels
    https://git.kernel.org/netdev/net/c/662f084f3396
  - [net,09/13] selftests: mptcp: diag: fix bash warnings on older kernels
    https://git.kernel.org/netdev/net/c/694bd45980a6
  - [net,10/13] selftests: mptcp: simult flows: fix some subtest names
    https://git.kernel.org/netdev/net/c/4d8e0dde0403
  - [net,11/13] selftests: mptcp: userspace_pm: unique subtest names
    https://git.kernel.org/netdev/net/c/2ef0d804c090
  - [net,12/13] selftests: mptcp: diag: unique 'in use' subtest names
    https://git.kernel.org/netdev/net/c/645c1dc965ef
  - [net,13/13] selftests: mptcp: diag: unique 'cestab' subtest names
    https://git.kernel.org/netdev/net/c/4103d8480866

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



