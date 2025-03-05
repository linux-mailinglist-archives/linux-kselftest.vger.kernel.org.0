Return-Path: <linux-kselftest+bounces-28264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B12A4F36F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C481890AB7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8115B984;
	Wed,  5 Mar 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+IP3M2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C670158D96;
	Wed,  5 Mar 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137609; cv=none; b=TNm1++3Gr2COvWWOdkFNEEbMLULDVNkmKJlF0UidT9dfImXxWzSOM9ukPOkOxGESi6cSwavUBP/S0/cjhU32Mv2gTb7Ya/3BD/MwmyarKFeBje5JIXwZs7AHMagbFxjyXzJFUpGuyz+wtbtE+9ygmmg9wB1X3BgVuLPJiVkMYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137609; c=relaxed/simple;
	bh=eFDqEPs6GQfYA+1LGTvHipAhRNBHO65GDgDvQ4ng6lU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NOMTPvXGUxc8z+0Hxf48lLgY1HFzDhtaHrQIyVHwcuS4tsS2umxvz6gxS22ncd/Uxj957CPpHvUUTdd2mynOWvlHfQDFF0H0z2kN54ta4kOb0V720nDXf84jnOIRUzgP1uaD36aIvAZtmUxYbXNEkRm/mUUAl7tMGxAFUuQF0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+IP3M2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4399FC4CEE5;
	Wed,  5 Mar 2025 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741137609;
	bh=eFDqEPs6GQfYA+1LGTvHipAhRNBHO65GDgDvQ4ng6lU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H+IP3M2PbXqjcTpyGaO72bOnrjcCgXmSfh7uMKQah+eVGCB+DL2FVstzaK8+2vZg1
	 QUdo9JkT0Wr/zZIHIJBE/ouu0VQnH70PR6zkH7y+iB/WqqrvieBu2kCSDB+xLJ9YXO
	 MvUUwz85UYefYs/sl5nDM3B9tXrZ6I6nNJ30E2XNkw0w8NlyqPws1hzqsd8XxL3EVh
	 1uEUCeqwfv7ouqjXovWli7qZSQ29ksRA5Hc0O5zey4IXMTC+E9dXx0r05GoQcoGBMH
	 fB/YNH6AlWiRxC4VNhWXZOeFSzGePeupsJiJUznaSBUzl+ra2iN0fBc7Y2d8s1s12j
	 fqksisL0vAALA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF4380CFEB;
	Wed,  5 Mar 2025 01:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: use env.rpath in the HDS
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113764199.356990.10793712741081392079.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:20:41 +0000
References: <20250228212956.25399-1-kuba@kernel.org>
In-Reply-To: <20250228212956.25399-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 13:29:55 -0800 you wrote:
> Commit 29b036be1b0b ("selftests: drv-net: test XDP, HDS auto and
> the ioctl path") added a new test case in the net tree, now that
> this code has made its way to net-next convert it to use the env.rpath()
> helper instead of manually computing the relative path.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: drv-net: use env.rpath in the HDS test
    https://git.kernel.org/netdev/net-next/c/ea4342739df3
  - [net-next,2/2] selftests: net: use the dummy bpf from net/lib
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



