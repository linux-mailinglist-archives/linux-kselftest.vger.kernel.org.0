Return-Path: <linux-kselftest+bounces-45279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7609DC4B4CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 04:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C32474EE8E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 03:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A034A78D;
	Tue, 11 Nov 2025 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+2ZkxNk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414CC218AB0;
	Tue, 11 Nov 2025 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831244; cv=none; b=Iqjf5bnJj/ipUTlSDwAV2cqlBYccU/eFYAbf0eCwIz3biiaEPUDf5a6LWPOPx5xs1phhsBYNvEnVwtigX5VlE49Y+NpNXHjOmQhG7K4c3gk9igYPyB8gP8wr8F+PmhAlNHjjUbpB1/m6Se2+1/3mgS5qrFEMdV46ikEIpMNXZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831244; c=relaxed/simple;
	bh=af4VoRSK13IIBf4mIv9ywlLxBVqvCOsooc1obp2ZNc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kXA7x0D6/gvyUlrpIPr5f2FA5AWnvboEl68UCYhgr8sQGqer/3oSRoPtTMv7BEtupt5tT3KuJSN6NO9lttBeNI2BzSZs1DjKTfZsD8aVD8Lxvs881KJI4EDwh6sNje5c8TzLbs+kTjh1nk37LOMwJQ8O7nTGIiKMPC+GYvFBof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+2ZkxNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B660CC4CEF5;
	Tue, 11 Nov 2025 03:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762831243;
	bh=af4VoRSK13IIBf4mIv9ywlLxBVqvCOsooc1obp2ZNc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+2ZkxNkfCom3N6TAQsHisdfRcyb+evRpWVQoedb0fIcUVfNhU8OywsloqqAq5v4K
	 3onPLUuEXTogeiwZR24deB4sJAC+PcnXXRk6Vrg8sTesqVtCta1y4NMN7PEq7ZD5EK
	 8o4OvmqFKK36KXG5BR164qQMILzGM24Up4ui2nHySQKw6yyVOE80EF5rLe7/PLUJFQ
	 H7oZzt8uPQ07GDUBnAd7pjwtf2ITXuKXZ1jrr9LpI5Eo9tnprzMb7eNMHfMnrc74sB
	 pL1HysglyX3d1QU140E9x50+DLWt+hV3Xg6I0GeCVHpNDvurbRnXeEXJqJr4EOZXfC
	 42q+36E1o1uvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB8380CFD7;
	Tue, 11 Nov 2025 03:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v10 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176283121399.2866443.8746710969595986737.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 03:20:13 +0000
References: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
In-Reply-To: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 decot@googlers.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 calvin@wbinvd.org, kernel-team@meta.com, jv@jvosburgh.net,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Nov 2025 06:03:36 -0800 you wrote:
> Fix a memory leak in netpoll and introduce netconsole selftests that
> expose the issue when running with kmemleak detection enabled.
> 
> This patchset includes a selftest for netpoll with multiple concurrent
> users (netconsole + bonding), which simulates the scenario from test[1]
> that originally demonstrated the issue allegedly fixed by commit
> efa95b01da18 ("netpoll: fix use after free") - a commit that is now
> being reverted.
> 
> [...]

Here is the summary with links:
  - [net,v10,1/4] net: netpoll: fix incorrect refcount handling causing incorrect cleanup
    https://git.kernel.org/netdev/net/c/49c8d2c1f94c
  - [net,v10,2/4] selftest: netcons: refactor target creation
    https://git.kernel.org/netdev/net/c/39acc6a95eef
  - [net,v10,3/4] selftest: netcons: create a torture test
    https://git.kernel.org/netdev/net/c/6701896eb909
  - [net,v10,4/4] selftest: netcons: add test for netconsole over bonded interfaces
    https://git.kernel.org/netdev/net/c/236682db3b6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



