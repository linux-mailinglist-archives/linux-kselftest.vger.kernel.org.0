Return-Path: <linux-kselftest+bounces-27821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A50A48E0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 02:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDA53B1A19
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 01:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC6335963;
	Fri, 28 Feb 2025 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc57WRjR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22B4276D0B;
	Fri, 28 Feb 2025 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706797; cv=none; b=mVAwHYqHFLIlXFvYS4FUAqE4KbVAKvh1eLSlksGXzmuDiwO076HnFDD46x4pAIyvsIjWc9DQwrm76FEVet/7PuAdkXkj9skTsTCqklCoRB30ijCaRx3i8wd+HfGx9JCKvvlKvNhc0/IhKycNcJtLCcAxgqkBD0jeZQJ0YBbzy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706797; c=relaxed/simple;
	bh=ojYLpVNPiRkjG8JoB/rvzAys6XHFkDYl+wJ0eo47Uho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sLrJuLRfpB9+X+lcNO65t4DQ5xnCvoBUrD/mSdmNs4yowL4BbB6Ych+UQmfrvTcz8KbgDKQuJ2m//WRsv/UCLhVUBFHyh/jo1xgQ8MXtbntqCJoLzbFj6JGyVKlupVcZ+KxsR+gs2K73F3i2tJpDUdnu6CQfKcKVxVCpKVMvz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc57WRjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277B8C4CEDD;
	Fri, 28 Feb 2025 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740706797;
	bh=ojYLpVNPiRkjG8JoB/rvzAys6XHFkDYl+wJ0eo47Uho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hc57WRjRWgPxvI5x4oZe7U5i7nReS6+twzVrGZUGgkF9MevODBXdV9m6St3cK6xfH
	 lOCgTx54ZLZ6Z90uJfRA1XlsOBfU+TQIx/K+nsamSVL7epVdUGTxdEwQRbSgNxjQo5
	 oKaIz7LvmBM2BCo/Qu+WZL1wtzYcR0qOv0EFCZJSOmxkyWE2A2OcwMRQycEz2tvr9s
	 UxahWL5eNe5jGEzpDj7v1/oiOM4wkz5awKSBDPHlN8263VBxqgKBFdzLh5UIEclXo+
	 YENTZXWV6zwNeoolIjbHfdFiXRyOYdqdlryRlP96Oozg1+SWqTgeJYodW+8ivkxqbG
	 OSOtLrAh2SOfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA1380AACB;
	Fri, 28 Feb 2025 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v20 00/25] Introducing OpenVPN Data Channel
 Offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174070682925.1649415.10325310803686050485.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 01:40:29 +0000
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, shuah@kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, andrew+netdev@lunn.ch,
 horms@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shaw.leon@gmail.com,
 akpm@linux-foundation.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com, willemdebruijn.kernel@gmail.com,
 dsahern@kernel.org, andrew@lunn.ch, skhan@linuxfoundation.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 02:21:25 +0100 you wrote:
> After some time of struggle trying to fix all hidden bugs that Sabrina
> has found...here is v20!
> 
> Notable changes since v19:
> * copyright years updated to 2025
> * rtnl_link_ops.newlink adapted to new signature
> * removed admindown del-peer-reason attribute from netlink API
>   (it should have gone away in v19 already)
> * removed asynchronous socket cleanup. All cleanup now happens in the
>   same context as the peer removal. I used a "deferred list" to
>   collect all peers that needed socket release and traversed it
>   after releasing the socket. This wasy there was no need to spawn
>   workers to leave the atomic context. Code looks way more linear now
> * provided implementation for sk_prot->close() in order to catch when
>   userspace is releasing a socet and act accordingly. This way we can
>   avoid the dangling netns problem discussed in v19
> * due to the previous item, it is now expected that the process that
>   created a socket stays alive all time long.
> * kselftest scripts have been re-arranged as per the previous item
>   in order to keep ovpn-cli processes alive in background during the
>   tests
> * improved TCP shutdown coordination across involved components
> * fixed false deadlock reporting by using nested lock class (thanks a
>   lot to Sean Anderson!)
> * exported udpv6_prot via EXPORT_SYMBOL_GPL
> * merged patch for exporting inet6_stream_ops with its user
> * moved TCP code that may sleep during detach out of lock_sock area
> * reverted tcp_release_cb to EXPORT_SYMBOL
> * improved kselftest Makefile to allow kselftest_deps.sh to detect
>   all dependencies
> 
> [...]

Here is the summary with links:
  - [net-next,v20,01/25] mailmap: remove unwanted entry for Antonio Quartulli
    https://git.kernel.org/netdev/net/c/ada9ce437a4d
  - [net-next,v20,02/25] net: introduce OpenVPN Data Channel Offload (ovpn)
    (no matching commit)
  - [net-next,v20,03/25] ovpn: add basic netlink support
    (no matching commit)
  - [net-next,v20,04/25] ovpn: add basic interface creation/destruction/management routines
    (no matching commit)
  - [net-next,v20,05/25] ovpn: keep carrier always on for MP interfaces
    (no matching commit)
  - [net-next,v20,06/25] ovpn: introduce the ovpn_peer object
    (no matching commit)
  - [net-next,v20,07/25] ovpn: introduce the ovpn_socket object
    (no matching commit)
  - [net-next,v20,08/25] ovpn: implement basic TX path (UDP)
    (no matching commit)
  - [net-next,v20,09/25] ovpn: implement basic RX path (UDP)
    (no matching commit)
  - [net-next,v20,10/25] ovpn: implement packet processing
    (no matching commit)
  - [net-next,v20,11/25] ovpn: store tunnel and transport statistics
    (no matching commit)
  - [net-next,v20,12/25] ovpn: implement TCP transport
    (no matching commit)
  - [net-next,v20,13/25] skb: implement skb_send_sock_locked_with_flags()
    (no matching commit)
  - [net-next,v20,14/25] ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
    (no matching commit)
  - [net-next,v20,15/25] ovpn: implement multi-peer support
    (no matching commit)
  - [net-next,v20,16/25] ovpn: implement peer lookup logic
    (no matching commit)
  - [net-next,v20,17/25] ovpn: implement keepalive mechanism
    (no matching commit)
  - [net-next,v20,18/25] ovpn: add support for updating local UDP endpoint
    (no matching commit)
  - [net-next,v20,19/25] ovpn: add support for peer floating
    (no matching commit)
  - [net-next,v20,20/25] ovpn: implement peer add/get/dump/delete via netlink
    (no matching commit)
  - [net-next,v20,21/25] ovpn: implement key add/get/del/swap via netlink
    (no matching commit)
  - [net-next,v20,22/25] ovpn: kill key and notify userspace in case of IV exhaustion
    (no matching commit)
  - [net-next,v20,23/25] ovpn: notify userspace when a peer is deleted
    (no matching commit)
  - [net-next,v20,24/25] ovpn: add basic ethtool support
    (no matching commit)
  - [net-next,v20,25/25] testing/selftests: add test tool and scripts for ovpn module
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



