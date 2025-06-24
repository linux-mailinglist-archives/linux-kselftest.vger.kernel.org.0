Return-Path: <linux-kselftest+bounces-35659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ED7AE587F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 02:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8C7172675
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 00:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951486348;
	Tue, 24 Jun 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTrUuKAf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAE78F37;
	Tue, 24 Jun 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750724390; cv=none; b=fQ/Pv5YfCUXETJC3NazJHLbrcO2HhTjgEhQf4M85rcwnaKKav3fP0qFDyhgRyPfV5VqmucCryFwPevOvsxYu2i61k5WGCbKyttb1BUVS9aTUoUvykhYtEoWSiqPolcIkfXNgTdOu63BpP0f5czwUUdEmMWniCLO2APiG0xeEN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750724390; c=relaxed/simple;
	bh=4oS4cXfEW6CmpOKLGC96E7Go2oB1omjBJS3fiYT09nA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebqhdoEKtwA3oR22T0RR4FAGAyqb4MuTt3EAG/UdYRzEzmmWVBwLUkOuxUtC8Yxf2sKae8rOt8PjCKCBDyXUdB6cmuksqBLso0V7J5O8hwyNlC7GXWbhj85CdfRB+wocDrLxROZDr+YVX8Y/iLxc+OqokMUsW2rLx0AFlRoit34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTrUuKAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CB2C4CEEA;
	Tue, 24 Jun 2025 00:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750724390;
	bh=4oS4cXfEW6CmpOKLGC96E7Go2oB1omjBJS3fiYT09nA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTrUuKAfYXMztfPoB4YdY3Vh8zSngHHr//7JbVb30jyU/jjuNSM3ziMuqfL0M7vyP
	 NK244zdQuyIZFlMtcLQqTUsEmXqsDgbjpvnf+S+JaqX+XuMtgBETKHjUIG3phS0OzG
	 fDyVdGHbMpZWXD3KjxE28dk2nEvIbuvEn8E1VmZKG6KUn1As6a/McF4wOIwww84aX9
	 R2Ezoc8LWz6eB2ZBqJnzoz7sGZANMH0scOq9GUmOgTsqiKRayltRFdWNc5kz7zaSKa
	 AjhE34HAl0LKnhv3KquRjva8gaRjK2HtnOq0y2Ozi1TF6+kwlzdSAb3SNt6cpQs38m
	 TPs4UMXElC1hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FED39FEB7D;
	Tue, 24 Jun 2025 00:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftests: drv-net: stats: use skip instead
 of
 xfail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072441674.3341634.13527297139177075247.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:20:16 +0000
References: <20250620161109.2146242-1-kuba@kernel.org>
In-Reply-To: <20250620161109.2146242-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 09:11:07 -0700 you wrote:
> Alex posted support for configuring pause frames in fbnic. This flipped
> the pause stats test from xfail to fail. Because CI considered xfail as
> pass it now flags the test as failing. This shouldn't happen. Also we
> currently report pause and FEC tests as passing on virtio which doesn't
> make sense.
> 
> Jakub Kicinski (2):
>   selftests: drv-net: stats: fix pylint issues
>   selftests: drv-net: stats: use skip instead of xfail for unsupported
>     features
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: drv-net: stats: fix pylint issues
    https://git.kernel.org/netdev/net-next/c/ca6a3faee66e
  - [net-next,2/2] selftests: drv-net: stats: use skip instead of xfail for unsupported features
    https://git.kernel.org/netdev/net-next/c/2baa45432d9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



