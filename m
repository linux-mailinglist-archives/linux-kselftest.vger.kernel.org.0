Return-Path: <linux-kselftest+bounces-31044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C925DA919C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E594F168A8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79F234978;
	Thu, 17 Apr 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWaYTg0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8122F17B;
	Thu, 17 Apr 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744887004; cv=none; b=pxpTULgFtHbcB+OyJLikL6075bejCFS7Q9ztNZZV1fJ/SLCdqxfB1SwqddKDIpKcRaqnS2mn9qMdVG71cxt5mUqDhKuBBZsgkwFdb8k1IM9MWpi6Mb7aIaIFRBzIKLBAPWzXyVa0ila9ISfMyGzRddV0D4HgX0z+jYIlNM4k6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744887004; c=relaxed/simple;
	bh=fqY4KQ2D+HxzZsXRSVS0wqXuoLvIAWlo8blt0cM+9iI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=abKbJsLBmNkiNd8/SL5rSVOYTQXNX1Hxq+N8/vdIAlJoWV586w6mlMv7j/eKrTl/NKTF0eB6cR7cPwpMX7Lcdg/x+uR+GUFGmpe9BLYTN+dHO7dNRBGPytHoAX/+6hJJ1vRHfpkJrR485lMzUNdnYErgD15Mqt2bO6fklljMpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWaYTg0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6F2C4CEE4;
	Thu, 17 Apr 2025 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744887003;
	bh=fqY4KQ2D+HxzZsXRSVS0wqXuoLvIAWlo8blt0cM+9iI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JWaYTg0OD/0fVFqBQdp4nJ/T3KWJ8BElM8UVfGbIqVFkHSRQHvvGugY1IBgbc2PpO
	 Wnuq/KooJPGA2PQGeW3jfhrvAwe0hz8Fc2NSRhvlROEHZJkekIfb9tWhHpoj+ATTja
	 BBrZg0usesTUXb9rF6jC/Pe3gatXWMa3iVkOWolvFV2aEnQkwBjhiPw4n6a5zyk38i
	 Zjrayy7jm4l12nMge8sB+Tk1sKc/68eKEMdN3s9QZIv+B8nj55T+ANlfAZO+Eit6cw
	 odPW6C5BrkpOZ8LtTCN/upbgMdiENZti1cObDMUctmowf6ilhp3eMTRoSuubn1ZnIX
	 WJOqgUnG441Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D76380664C;
	Thu, 17 Apr 2025 10:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel
 Offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174488704201.4029344.7980447608416873863.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 10:50:42 +0000
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, shuah@kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, andrew+netdev@lunn.ch,
 horms@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shaw.leon@gmail.com,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, dsahern@kernel.org, andrew@lunn.ch,
 skhan@linuxfoundation.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Apr 2025 13:17:17 +0200 you wrote:
> Notable changes since v25:
> * removed netdev notifier (was only used for our own devices)
> * added .dellink implementation to address what was previously
>   done in notifier
> * removed .ndo_open and moved netif_carrier_off() call to .ndo_init
> * fixed author in MODULE_AUTHOR()
> * properly indented checks in ovpn.yaml
> * switched from TSTATS to DSTATS
> * removed obsolete comment in ovpn_socket_new()
> * removed unrelated hunk in ovpn_socket_new()
> 
> [...]

Here is the summary with links:
  - [net-next,v26,01/23] net: introduce OpenVPN Data Channel Offload (ovpn)
    https://git.kernel.org/netdev/net-next/c/9f23d943eb6b
  - [net-next,v26,02/23] ovpn: add basic netlink support
    https://git.kernel.org/netdev/net-next/c/b7a63391aa98
  - [net-next,v26,03/23] ovpn: add basic interface creation/destruction/management routines
    https://git.kernel.org/netdev/net-next/c/c2d950c4672a
  - [net-next,v26,04/23] ovpn: keep carrier always on for MP interfaces
    https://git.kernel.org/netdev/net-next/c/8327a3baa9b0
  - [net-next,v26,05/23] ovpn: introduce the ovpn_peer object
    https://git.kernel.org/netdev/net-next/c/80747caef33d
  - [net-next,v26,06/23] ovpn: introduce the ovpn_socket object
    https://git.kernel.org/netdev/net-next/c/f6226ae7a0cd
  - [net-next,v26,07/23] ovpn: implement basic TX path (UDP)
    https://git.kernel.org/netdev/net-next/c/08857b5ec5d9
  - [net-next,v26,08/23] ovpn: implement basic RX path (UDP)
    https://git.kernel.org/netdev/net-next/c/ab66abbc769b
  - [net-next,v26,09/23] ovpn: implement packet processing
    https://git.kernel.org/netdev/net-next/c/8534731dbf2d
  - [net-next,v26,10/23] ovpn: store tunnel and transport statistics
    https://git.kernel.org/netdev/net-next/c/04ca14955f9a
  - [net-next,v26,11/23] ovpn: implement TCP transport
    https://git.kernel.org/netdev/net-next/c/11851cbd60ea
  - [net-next,v26,12/23] skb: implement skb_send_sock_locked_with_flags()
    https://git.kernel.org/netdev/net-next/c/17240749f26e
  - [net-next,v26,13/23] ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
    https://git.kernel.org/netdev/net-next/c/36bb1d713a15
  - [net-next,v26,14/23] ovpn: implement multi-peer support
    https://git.kernel.org/netdev/net-next/c/05003b408c20
  - [net-next,v26,15/23] ovpn: implement peer lookup logic
    https://git.kernel.org/netdev/net-next/c/a3aaef8cd173
  - [net-next,v26,16/23] ovpn: implement keepalive mechanism
    https://git.kernel.org/netdev/net-next/c/3ecfd9349f40
  - [net-next,v26,17/23] ovpn: add support for updating local or remote UDP endpoint
    https://git.kernel.org/netdev/net-next/c/f0281c1d3732
  - [net-next,v26,18/23] ovpn: implement peer add/get/dump/delete via netlink
    https://git.kernel.org/netdev/net-next/c/1d36a36f6d53
  - [net-next,v26,19/23] ovpn: implement key add/get/del/swap via netlink
    https://git.kernel.org/netdev/net-next/c/203e2bf55990
  - [net-next,v26,20/23] ovpn: kill key and notify userspace in case of IV exhaustion
    https://git.kernel.org/netdev/net-next/c/89d3c0e4612a
  - [net-next,v26,21/23] ovpn: notify userspace when a peer is deleted
    https://git.kernel.org/netdev/net-next/c/a215d253c17a
  - [net-next,v26,22/23] ovpn: add basic ethtool support
    https://git.kernel.org/netdev/net-next/c/b756861e6e63
  - [net-next,v26,23/23] testing/selftests: add test tool and scripts for ovpn module
    https://git.kernel.org/netdev/net-next/c/959bc330a439

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



