Return-Path: <linux-kselftest+bounces-36363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9158AF65A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 00:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA3A1BC034A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB98246335;
	Wed,  2 Jul 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVrQyKke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED515624B;
	Wed,  2 Jul 2025 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496601; cv=none; b=CHe4ieK5MskB12CiqQnwRgUImdR5AosrQVXpyff/TdwbB9//qLZ3ce4zNsxlCVOp0hxy7JblRsegr1t/MaeRy/wsmcr4f/7Ml9wuvhuZflE2r4EUQcKfNu0QISE4rmPp8XRCuhfieRiW3v0XXqh1aOq5RESGRoKrNUT4nGWhFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496601; c=relaxed/simple;
	bh=wU8Zhraeh1yNzCGp2EgiAgwWtGMVkPgxeEnPDkPMUmQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FtbGFh1pWWnY/3TXC57UB0MQpn/j9+tOUigkzE7C/pTKEddKeFCMRQm259Y1Fup9VqzFCJ3lXMFD8gCco9GoPrGXhzp2HbvNXItYJZQZ22expYU4pgNV32CQEv71Kwqr1q71fyZfN2dhnEIRAHLhJagOynq3fWu/3iISWnjLVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVrQyKke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7A4C4CEE7;
	Wed,  2 Jul 2025 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751496601;
	bh=wU8Zhraeh1yNzCGp2EgiAgwWtGMVkPgxeEnPDkPMUmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jVrQyKke7z/XJrrGX4841VHebRnBXnTnWdXEQ/R+A7DGSSWvUUOgZWC3bSto1/8Tm
	 K/1NV62e4vEE5Tc86WqGxfGaqm+ngndIi19aVgFJhoIXiX9qXu35xeg47vqYB2O3tb
	 NzICAZPxprMVXUQuH/lURQmVCFJ/URxLk02DJsoHh78u+aqt28RUivbvUVTQlNsWJd
	 gp+E2rLhc0xW5StqAKPyOO3tDGfOYS9YEuE4o/mog+IwwfUHBDGj2eXYZoX4eZ+qEp
	 1vB8e4kTExtVgqEKPsizDwSRhPevYRwJjGoqm1TrhkdA+P1ibgZnCgfKqPch+COtAu
	 riLWeU4TbXHkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06A383B273;
	Wed,  2 Jul 2025 22:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/8] Support rate management on traffic
 classes
 in devlink and mlx5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149662576.890932.9074896205205825131.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:50:25 +0000
References: <20250629142138.361537-1-mbloch@nvidia.com>
In-Reply-To: <20250629142138.361537-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 donald.hunter@gmail.com, jiri@resnulli.us, corbet@lwn.net, leon@kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Jun 2025 17:21:30 +0300 you wrote:
> V12:
> - Fixed YAML indentation in devlink.yaml.
> - Removed unused total variable from devlink_nl_rate_tc_bw_set().
> - Quoted shell variables in devlink.sh and split declarations to fix
>   shellcheck warnings.
> - Added missing DevlinkFamily imports in selftests to fix pylint
>   warnings.
> - Pulled changes from net-next to enable these adjustments:
>    Inclusion of DevlinkFamily in YNL test libs.
>    Introduction of nlmsg_for_each_attr_type() macro and its use in nfsd.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/8] netlink: introduce type-checking attribute iteration for nlmsg
    https://git.kernel.org/netdev/net-next/c/42401c423896
  - [net-next,v12,2/8] devlink: Extend devlink rate API with traffic classes bandwidth management
    https://git.kernel.org/netdev/net-next/c/566e8f108fc7
  - [net-next,v12,3/8] selftest: netdevsim: Add devlink rate tc-bw test
    https://git.kernel.org/netdev/net-next/c/236156d80d5e
  - [net-next,v12,4/8] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
    https://git.kernel.org/netdev/net-next/c/71092821244a
  - [net-next,v12,5/8] net/mlx5: Add support for setting tc-bw on nodes
    https://git.kernel.org/netdev/net-next/c/96619c485fa6
  - [net-next,v12,6/8] net/mlx5: Add traffic class scheduling support for vport QoS
    https://git.kernel.org/netdev/net-next/c/97733d1e00a0
  - [net-next,v12,7/8] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
    https://git.kernel.org/netdev/net-next/c/cf7e73770d1b
  - [net-next,v12,8/8] selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution
    https://git.kernel.org/netdev/net-next/c/23ca32e4ead4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



