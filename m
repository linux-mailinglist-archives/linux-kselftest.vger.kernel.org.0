Return-Path: <linux-kselftest+bounces-16469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68996191D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 23:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A531C22C1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C478018859A;
	Tue, 27 Aug 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abh9KWpK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C3185941;
	Tue, 27 Aug 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793635; cv=none; b=H1KVEeQfHk7p5dTlcJ0aAjFLsMQ0ZoSlbi5BeXszn3dMOab0Sg2Igccb0LBa7w2Dc2tjSlu5xAL5ctiw4RdcK3UkhSlUiMN50kFDQFk4N0fLlbGlfkeMbovmm2AW8qw9ngUePCgOrJFsgsCRQVGyw1SfdPiZV0rO4APeW/J3tys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793635; c=relaxed/simple;
	bh=KhVPpFsePtmRPW/8eeWaTuWExzJ16bh65tUq7C5f96c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jTdjn8uoBaHt7lARwNR6lU2VamBORPGLO1GjhRGw4Uhw83BPIDPp1LJzLi1tLejT1miPUsotwc322OaTkfRm/xO2Fd8zER/k4Uu1HYBXdfZ3hlven0SIw/7uTL9kJJVsZbQTmPnQ+qGb+jtO58D06tvy+uisA6XAvsQpIbn8lRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Abh9KWpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CD2C4AF09;
	Tue, 27 Aug 2024 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724793635;
	bh=KhVPpFsePtmRPW/8eeWaTuWExzJ16bh65tUq7C5f96c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Abh9KWpKS8bxxiBCgDAv3jdHPMPTmR5Q5MeeCqTtOU/831RulH8yZDKvSiJk2UrS3
	 mqzKFhO3Ejg/9qL+vFwSaPNVBy12TvHG8T2PPTf4jEvmsq8Jnd10ApZuqSuPMQvJBS
	 b+XaJ1/ErHaeF4gXrvqENxjqf5ZM3yjGj5Yno9/klJfT8KKxsQFm25saqI6/3p3TbE
	 6x76XH5aINqnl9jMtG2sYuQl6TYHy0NiiBP0fcmskSU88KzMgpxe05ixat/KDyE1Qa
	 DUv/Pvs+yHBhP5VAzGJS/WU3lvPH6Yb8ip8N6lPwd5uOoZAKdZ3bl/E1AxtbE9wdO3
	 +iudXrYADuOMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E243822D6D;
	Tue, 27 Aug 2024 21:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/8] net/selftests: TCP-AO selftests updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479363525.765313.5940686495297400141.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:20:35 +0000
References: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
In-Reply-To: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, mnassiri@ciena.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 23:04:50 +0100 you wrote:
> First 3 patches are more-or-less cleanups/preparations.
> 
> Patches 4/5 are fixes for netns file descriptors leaks/open.
> 
> Patch 6 was sent to me/contributed off-list by Mohammad, who wants 32-bit
> kernels to run TCP-AO.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/8] selftests/net: Clean-up double assignment
    https://git.kernel.org/netdev/net-next/c/79504a47339c
  - [net-next,v4,2/8] selftests/net: Provide test_snprintf() helper
    https://git.kernel.org/netdev/net-next/c/7053e788ded5
  - [net-next,v4,3/8] selftests/net: Be consistent in kconfig checks
    https://git.kernel.org/netdev/net-next/c/bc2468f98221
  - [net-next,v4,4/8] selftests/net: Open /proc/thread-self in open_netns()
    https://git.kernel.org/netdev/net-next/c/8acb1806e8c2
  - [net-next,v4,5/8] selftests/net: Don't forget to close nsfd after switch_save_ns()
    https://git.kernel.org/netdev/net-next/c/a9e1693406f9
  - [net-next,v4,6/8] selftests/tcp_ao: Fix printing format for uint64_t
    https://git.kernel.org/netdev/net-next/c/1c69e1f43399
  - [net-next,v4,7/8] selftests/net: Synchronize client/server before counters checks
    https://git.kernel.org/netdev/net-next/c/044e03705125
  - [net-next,v4,8/8] selftests/net: Add trace events matching to tcp_ao
    https://git.kernel.org/netdev/net-next/c/586d87021f22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



