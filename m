Return-Path: <linux-kselftest+bounces-27245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE097A403BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4C3BA32D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 23:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F549255E3A;
	Fri, 21 Feb 2025 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDu9ISbE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA77255E29;
	Fri, 21 Feb 2025 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181803; cv=none; b=dwZ0+xrvXraIoMK56T2e5hkFh7NEFt+8z69iCb8l7pLZ8HFNRktaUyQrr3qMTHjRJpNNoqkKclyCTZay1m1fNq/u05l+XligLbk3+unw4Saqu7x4p3mML9DnsNX4gQ0ly1J4kQxiQdTq4luViar1OqYoon3jjE/C/l1CgMSD9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181803; c=relaxed/simple;
	bh=CTqJ/KmzI6Gqn0P8GISxBeKnxm42pSWuEHz+MsnFwsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ha7J3DmgFjjEBnRmUT017nVDVLuzmzmoktZ6FWv+lOI8nY7RpPm00cNzupT2+BR5Eu1efsI8XFet4/WLFH05K2agSuTiZSTH+odPOzwqWtTlPB42SUTY7H2UbR6XnLFlUrGMJpLBIPnhDIbVJ/UVk3kvxx1gO/mhoi4rWg1pVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDu9ISbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D170C4CEE8;
	Fri, 21 Feb 2025 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181802;
	bh=CTqJ/KmzI6Gqn0P8GISxBeKnxm42pSWuEHz+MsnFwsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BDu9ISbENe4QBTzFvL3z1yzMFvK03RKEkTbSwfBUkHNtTUh87YeINV9ofzYEHWC3S
	 jZzNU5gsxWbwLeHefuhEiZ9tiDlx3f/7HNbz6+540xOxAjI7PR0td6mH30Y3+TKUgF
	 LvyTFKZzhdtpcsU6ypDidAaK+ncYlAPPafKV4INeuNv7tC9FhmAMN0Vo6m1FyHhHaY
	 CchC7RgW86hAUItr0fS49w52qJFaotrHr/KW9nOdhhDez05BFc79K9glnKMMjqoXTE
	 2B5QJHf8bMDZ6dD1+XamNosy4PieEtpvxtm9eOjBTRJHtAiLr3CyiD+AQA01DPTnNn
	 +FzWQRl5jE+uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710DC380CEEC;
	Fri, 21 Feb 2025 23:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 00/13] net: Improve netns handling in rtnetlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018183327.2240430.4249639047640655494.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 23:50:33 +0000
References: <20250219125039.18024-1-shaw.leon@gmail.com>
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kuniyu@amazon.com, kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, donald.hunter@gmail.com,
 alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 20:50:26 +0800 you wrote:
> This patch series includes some netns-related improvements and fixes for
> rtnetlink, to make link creation more intuitive:
> 
>  1) Creating link in another net namespace doesn't conflict with link
>     names in current one.
>  2) Refector rtnetlink link creation. Create link in target namespace
>     directly.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,01/13] rtnetlink: Lookup device in target netns when creating link
    https://git.kernel.org/netdev/net-next/c/ec061546c6cf
  - [net-next,v10,02/13] rtnetlink: Pack newlink() params into struct
    https://git.kernel.org/netdev/net-next/c/69c7be1b903f
  - [net-next,v10,03/13] net: Use link/peer netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/cf517ac16ad9
  - [net-next,v10,04/13] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/3533717581dd
  - [net-next,v10,05/13] net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
    https://git.kernel.org/netdev/net-next/c/9e17b2a1a097
  - [net-next,v10,06/13] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/eacb1160536e
  - [net-next,v10,07/13] net: ipv6: Init tunnel link-netns before registering dev
    https://git.kernel.org/netdev/net-next/c/db014522f356
  - [net-next,v10,08/13] net: ipv6: Use link netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/5e72ce3e3980
  - [net-next,v10,09/13] net: xfrm: Use link netns in newlink() of rtnl_link_ops
    https://git.kernel.org/netdev/net-next/c/5314e3d68455
  - [net-next,v10,10/13] rtnetlink: Remove "net" from newlink params
    https://git.kernel.org/netdev/net-next/c/9c0fc091dc01
  - [net-next,v10,11/13] rtnetlink: Create link directly in target net namespace
    https://git.kernel.org/netdev/net-next/c/7ca486d08a30
  - [net-next,v10,12/13] selftests: net: Add python context manager for netns entering
    https://git.kernel.org/netdev/net-next/c/030329416232
  - [net-next,v10,13/13] selftests: net: Add test cases for link and peer netns
    https://git.kernel.org/netdev/net-next/c/85cb3711acb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



