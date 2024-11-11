Return-Path: <linux-kselftest+bounces-21830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2099C49B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1175EB2706D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95BA1581F0;
	Mon, 11 Nov 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGt17e6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F914A4DE;
	Mon, 11 Nov 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367822; cv=none; b=bpOIwN4l+05aAGCG2TcUTCICkOrfLGAMYmO4HpcoHaOPkbD4FSekH4uXgc9zzljdAsSUFRkprecqsaUjccmYZDsM+0oTQ1wf5Ki8p18mZbejnkFJdIDZAvkA38JyDAg1QiGUo94NSOMC66aqQ94Ie3+mhLJOQCRg9SIY1e0VSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367822; c=relaxed/simple;
	bh=lDnSkZUHCR6JXViDwq+7vD0Xg+BLr/GTDPrxYsx/bfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fem2CkmdXDprNBUE/i2bzfOi/fuRAqzJcTmJ4JJmlaWHFSUhWXSczTm16ixGa5aOjhWgrV18Maj9FJc8VV0nkiXchIyL2HzcXnOAP30aYS+JYzSIvpYlX0nhyn0OveYUtuLwcTd7kCeAO/xUMDyZFVfwTEIKxLxPQbXjWqgknI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGt17e6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3018CC4CECF;
	Mon, 11 Nov 2024 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731367822;
	bh=lDnSkZUHCR6JXViDwq+7vD0Xg+BLr/GTDPrxYsx/bfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DGt17e6dNjeWTUx/yQNSxwZWMRLRunoGdGOQKxJGqKUJaORL1jUrCUAPpdb/kV/6H
	 EbBrJLWzLNCaW39+ae14wDkhEQdVgPBXL7OFlOHzOeqJHim1v5aKzeVX2kBzYtQyjX
	 f5AdLSDXMFHbTM4cKsl9Sn7YroMu0FkX6Hips7m0tCwxW644ZSdl2+out7pr94m0jP
	 AQ6+CsQz32JbxMTRpszHPlRj/zPgRsHuraxnYBMPxoJ4pjEESOoRvboKAsEuAJcGil
	 +1cBA4Y/CYoMzzYuPCV4hGZJnphtn6JD706z/tW3jhE/pO2yY54Szg+P85xL5Qp0kZ
	 eqiOTezZgVong==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713303809A80;
	Mon, 11 Nov 2024 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173136783228.10093.17478137468626631969.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 23:30:32 +0000
References: <20241106010236.1239299-1-omid.ehtemamhaghighi@menlosecurity.com>
In-Reply-To: <20241106010236.1239299-1-omid.ehtemamhaghighi@menlosecurity.com>
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Cc: netdev@vger.kernel.org, adrian.oliver@menlosecurity.com,
 kernel@aoliver.ca, davem@davemloft.net, dsahern@gmail.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 idosch@idosch.org, kuniyu@amazon.com, horms@kernel.org, oeh.kernel@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Nov 2024 17:02:36 -0800 you wrote:
> Soft lockups have been observed on a cluster of Linux-based edge routers
> located in a highly dynamic environment. Using the `bird` service, these
> routers continuously update BGP-advertised routes due to frequently
> changing nexthop destinations, while also managing significant IPv6
> traffic. The lockups occur during the traversal of the multipath
> circular linked-list in the `fib6_select_path` function, particularly
> while iterating through the siblings in the list. The issue typically
> arises when the nodes of the linked list are unexpectedly deleted
> concurrently on a different core—indicated by their 'next' and
> 'previous' elements pointing back to the node itself and their reference
> count dropping to zero. This results in an infinite loop, leading to a
> soft lockup that triggers a system panic via the watchdog timer.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] ipv6: Fix soft lockups in fib6_select_path under high next hop churn
    https://git.kernel.org/netdev/net-next/c/d9ccb18f83ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



