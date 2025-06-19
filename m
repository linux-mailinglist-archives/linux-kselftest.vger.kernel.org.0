Return-Path: <linux-kselftest+bounces-35331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B30ADFB0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 03:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355CB3B6F72
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C60F21C9E1;
	Thu, 19 Jun 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwK+zBVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6E137932;
	Thu, 19 Jun 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750298391; cv=none; b=iP/bFYE8qaNj+Pavs8fu3sAL7Cp6ogDM+qVx3HuGwpd4CVV5sqsgpvG87C9W+ZmefUHJ5m4VOfxLyPEz5HVTZEyFfLvQmJ29vyslK7dDu0+qbLluk+zgRDAhMvwCUA04LIg1dadr7qBTbkvBJTdxIM01YXatmYVnLhZ/PdV1Ra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750298391; c=relaxed/simple;
	bh=94mN+2+g5h25MlO4Cl08JCW2RHY0uDyNmsYiIn2eS/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cs5Lu45UHPtL7kgJkGX4MgOWPUjuXTsMSS2uR4kB4Jk/qwmlan9vw4yvQwUs806qpVBGWC4kNIHs6uiVvqwQCJCUGNjaZ+i3+T5U1zFw7HQewPpYeQxk45KPMVbDcxL8fawatdPNYt8+wpl2SbaV8L66vIZLxY9ov/jQRvoumVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwK+zBVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB1AC4CEE7;
	Thu, 19 Jun 2025 01:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750298390;
	bh=94mN+2+g5h25MlO4Cl08JCW2RHY0uDyNmsYiIn2eS/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CwK+zBVWd9Vt8zSivCtzR8ekuuA7p+dsyureeXvVPF4+kzM0iB0o/1GUz0svw6kVI
	 ecIlNmV1yyU5D5c0ki3TBJZLgv4RvqL+M0MsMr20qQwj+mTQefW2ApQaGR8OiwZcCz
	 J2225Ho4HJbQ7u/NeBzUI36iMMG6yJP56aLaYT9QJ4cI+KuAKoLT2LQmbysUD2FNre
	 s8CNyHzFdJj7y6G74TxZclFFncO/ucFxgHG5HzljGsgtNNOca9D0/YkAuESlXpSZ4X
	 S6ZuexGLDGU9jkptP+FYSEE9A0U7tA4xDX2/XYYNZkujBjuPGusUvkdX2hG/CqA1lS
	 EOHj4+ALl+LbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDF3806649;
	Thu, 19 Jun 2025 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] udp_tunnel: remove rtnl_lock dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175029841848.320658.9308379649509683113.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 02:00:18 +0000
References: <20250616162117.287806-1-stfomichev@gmail.com>
In-Reply-To: <20250616162117.287806-1-stfomichev@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, skalluru@marvell.com,
 manishc@marvell.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, tariqt@nvidia.com,
 saeedm@nvidia.com, louis.peens@corigine.com, shshaikh@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com, horms@kernel.org,
 dsahern@kernel.org, shuah@kernel.org, tglx@linutronix.de, mingo@kernel.org,
 ruanjinjie@huawei.com, idosch@nvidia.com, razor@blackwall.org,
 petrm@nvidia.com, kuniyu@google.com, sdf@fomichev.me,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
 linux-net-drivers@amd.com, linux-kselftest@vger.kernel.org, leon@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 09:21:11 -0700 you wrote:
> Recently bnxt had to grow back a bunch of rtnl dependencies because
> of udp_tunnel's infra. Add separate (global) mutext to protect
> udp_tunnel state.
> 
> v5:
> - remove unused variable (lkp@intel.com)
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] geneve: rely on rtnl lock in geneve_offload_rx_ports
    https://git.kernel.org/netdev/net-next/c/3e14960f3bd2
  - [net-next,v5,2/6] vxlan: drop sock_lock
    https://git.kernel.org/netdev/net-next/c/df5425b3bd85
  - [net-next,v5,3/6] udp_tunnel: remove rtnl_lock dependency
    https://git.kernel.org/netdev/net-next/c/1ead7501094c
  - [net-next,v5,4/6] net: remove redundant ASSERT_RTNL() in queue setup functions
    https://git.kernel.org/netdev/net-next/c/3a321b6b1f76
  - [net-next,v5,5/6] netdevsim: remove udp_ports_sleep
    https://git.kernel.org/netdev/net-next/c/e054c8ba3bce
  - [net-next,v5,6/6] Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
    https://git.kernel.org/netdev/net-next/c/850d9248d2ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



