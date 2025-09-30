Return-Path: <linux-kselftest+bounces-42613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CABABFC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 10:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585001926787
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F922F3636;
	Tue, 30 Sep 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVCORgkf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F892D7DE7;
	Tue, 30 Sep 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220415; cv=none; b=nvGc2RIPHAZBAU3IXgYvwsNZs2ektBEwOrUG6L9orjpDUIrnKt33v6E/AQ2zLsNriBeywRmXxddxBVOd1e6TLq31TS+XJQaFvkeANiNbUnpn6GfwCid9X0ON4lDywrUb+D/k6PGcOEFYATQ1+tCdbjGehF52GyFKohe4RYVRft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220415; c=relaxed/simple;
	bh=LFc+OP5iGZiXjjclQN+mYfcSLfMCJgZVX1hoB/t5dbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NMwOFZtu1HeiJ/dafyxvYe6I8bPQ+ZPRO2q0I9kOg/ti5V6ajhU+hYSfWkcnDvyIVNunBYwtIBGkvVsuXKTL8aszg4G1eg2AHEZBY43aMSbnls1zt6x5pcsZeICy8kssgbE9gVHfL//8IYncTReaDtzURgGh1DhyXIfLfxqx3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVCORgkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ED6C4CEF0;
	Tue, 30 Sep 2025 08:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759220414;
	bh=LFc+OP5iGZiXjjclQN+mYfcSLfMCJgZVX1hoB/t5dbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mVCORgkfEB0DiIDc5tCoTjqm47to9EoBjfv4xHn4YGe+XGxfFpILBiZ74f0u+DYur
	 P3FskhOxfLWdCONk9TzzdDG9fmZT3me3Qd9OoFnmuYxcaMaszZU3E7IZ590JbnEn1Z
	 He2A8vdnJ9UdhJuAmGC6GivMI1Gfb+tv/YC7ZEzvvH9TZgKfwj1ZAdccvybI3Yqymw
	 zrJca2B5iQu702Ay7E4uK7/8OX8ph/O/j+1zoTQA491st2zDTfUFuNpmn0X6D74Qjb
	 w4IdCkxlrC7qaenKepGo2rSUcX9G9w/BZqAFRDPS9wMXGRrZIJi7kVr4KYOay6SWHN
	 zmdCPjgHCiXmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04C39D0C1A;
	Tue, 30 Sep 2025 08:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net 1/2] bonding: fix xfrm offload feature setup on
 active-backup mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175922040752.1888939.8527020251464882596.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 08:20:07 +0000
References: <20250925023304.472186-1-liuhangbin@gmail.com>
In-Reply-To: <20250925023304.472186-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 25 Sep 2025 02:33:03 +0000 you wrote:
> The active-backup bonding mode supports XFRM ESP offload. However, when
> a bond is added using command like `ip link add bond0 type bond mode 1
> miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
> disabled. This occurs because, in bond_newlink(), we change bond link
> first and register bond device later. So the XFRM feature update in
> bond_option_mode_set() is not called as the bond device is not yet
> registered, leading to the offload feature not being set successfully.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net,1/2] bonding: fix xfrm offload feature setup on active-backup mode
    https://git.kernel.org/netdev/net/c/5b66169f6be4
  - [PATCHv3,net,2/2] selftests: bonding: add ipsec offload test
    https://git.kernel.org/netdev/net/c/99e4c35eada9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



