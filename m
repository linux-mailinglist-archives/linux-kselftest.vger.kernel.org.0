Return-Path: <linux-kselftest+bounces-38004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF37B1239B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB9BAE2128
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA02F1FC9;
	Fri, 25 Jul 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlSJVPYe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FD2F0C7E;
	Fri, 25 Jul 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467006; cv=none; b=YQFCT6uhc0g+TH5h/3sh6yKRALu7M4CLLpzlpfYoCCubRikDnUMJx7+Td/VSjDeNz7q9tOi9V9rTCYYTsuF+DvGkUgYboNG1iOo90m4HCL2XKV6BL42yXfiQ/GkaDUMkkcgr+PST4ZUg1U4o9S1r7ElVmbte2s4boNPYtq2Lp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467006; c=relaxed/simple;
	bh=alcCn+8AvRx4Jbio1MtaW71PX0Z+B0w+9YsO/EfUTtI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nDIQyIDAzda7kmvfvKCP8S6NV7RUiYG/WpH/rymftEpO519oVcEUv3bdZ3xNt058ex//+F47idPgUVLOm5QOAPLpXfeMokh5NGwRzWPcHtyPxvcF3q1rQkTeTyiYFMN1l9yNTWmfau9LPIwzpnRkguMi9YAnMSa9zurvBBP+myQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlSJVPYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9D4C4CEF8;
	Fri, 25 Jul 2025 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753467005;
	bh=alcCn+8AvRx4Jbio1MtaW71PX0Z+B0w+9YsO/EfUTtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rlSJVPYeU5ijGSnCNkxdnA5/HoF3rHeeCndSbAgh2BwemGdp9goY6SoddwfzJ+GZG
	 mHjCRXLfjQYBZOj113rE7bTDPGshQ2tVy+UtoHJhOPBg0kkcBNXEqo3/ryU1yFLHBM
	 wQUdw6Mm5mfAxrCDkkOkfyj+3eiFU7A2MaNw2EoC95PZkAaWETBq7aA8Sc7qV/mLDk
	 XikbDC88GXFtIGtisNNktL1EAZqY3bgP1skCRSm8AOWhxacNS2iAoUoelw5kBuXZyN
	 AvN3YfkpsPI+W7hE+jeObsDTB4AZZZjv/BEA2c90JzVoXgOBTa71XdbnjBP+hLJWMa
	 Bc6vlmJtHAGkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCA383BF5B;
	Fri, 25 Jul 2025 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] macsec: set IFF_UNICAST_FLT priv flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346702300.3223523.9183464744482476775.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 18:10:23 +0000
References: <20250723224715.1341121-1-sdf@fomichev.me>
In-Reply-To: <20250723224715.1341121-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 cratiu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 15:47:14 -0700 you wrote:
> Cosmin reports the following locking issue:
> 
>   # BUG: sleeping function called from invalid context at
>   kernel/locking/mutex.c:275
>   #   dump_stack_lvl+0x4f/0x60
>   #   __might_resched+0xeb/0x140
>   #   mutex_lock+0x1a/0x40
>   #   dev_set_promiscuity+0x26/0x90
>   #   __dev_set_promiscuity+0x85/0x170
>   #   __dev_set_rx_mode+0x69/0xa0
>   #   dev_uc_add+0x6d/0x80
>   #   vlan_dev_open+0x5f/0x120 [8021q]
>   #  __dev_open+0x10c/0x2a0
>   #  __dev_change_flags+0x1a4/0x210
>   #  netif_change_flags+0x22/0x60
>   #  do_setlink.isra.0+0xdb0/0x10f0
>   #  rtnl_newlink+0x797/0xb00
>   #  rtnetlink_rcv_msg+0x1cb/0x3f0
>   #  netlink_rcv_skb+0x53/0x100
>   #  netlink_unicast+0x273/0x3b0
>   #  netlink_sendmsg+0x1f2/0x430
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] macsec: set IFF_UNICAST_FLT priv flag
    https://git.kernel.org/netdev/net-next/c/0349659fd72f
  - [net,v2,2/2] selftests: rtnetlink: add macsec and vlan nesting test
    https://git.kernel.org/netdev/net-next/c/f6c650c8d87e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



