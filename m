Return-Path: <linux-kselftest+bounces-21271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE99B8941
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 03:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDBF1C2266C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 02:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8670C13698E;
	Fri,  1 Nov 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGImJ0uy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C53374D1;
	Fri,  1 Nov 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427624; cv=none; b=QPti8HF6msVMg8ywbDtEn0yPrNXJaUWs0pcpDvw/VjIHUrWAnl+j3jQeXz+psflxLGcaXFY0P4luRv7gmu+5un7F1oLIwgE7og9778V0vz2acd2acZhTBcFdYSu4MXrdjyox4tk+6Bxq3v6Rv50RDXbkJJDKkkH8kIX0lJlRQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427624; c=relaxed/simple;
	bh=l3G56VwLyVbj5jeXBNBFqZPUwWZQfwvPSLIVkclWxno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l6lJ2YZoKvOwc9GP1dLKCurZAr1OHhscDt4t9W/kusr4WP/zeIm2+sOhbHMTlrCTudTJWVKoakL4SB9t9CtrRXlIhQJRfbwh//1YnngRg78nx2FulHm0xOM+W/dfRJJdPYHBwxHY3WsvZPDbmFZICvpqVw/C2r3SLPnKv8VTerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGImJ0uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B37C4CEC3;
	Fri,  1 Nov 2024 02:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730427623;
	bh=l3G56VwLyVbj5jeXBNBFqZPUwWZQfwvPSLIVkclWxno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cGImJ0uyQrLC9ckyCsKI0oacL/cB1BLPqqnwwGCoyGi4eOWIk2/79ZIMdOvyy6o/d
	 SK9h1FI87HFCPhtB3dCW/Shgd498KbnS6eyfgezLa7+TfNyVuBpnNd3XtnvGewFJQc
	 ttDmFHmF4vp4LdNR0v/8YIyZV0t8TSDmh9x+ZKEYmyYHj4jXtKKO/fr/S7FL4W2W3C
	 cAdAl4spHaPF/nUSP68kLlH9RdqXToY9DnQtlmRONB/YiQ/m4CNDTVKzxu36BP47Ua
	 kvHSmyQ8gsTorQbwf5gVXAWLZ9kxaSIEStDh+qfbjq0th8TJbYkJRcWRre4ch0JgYX
	 IRoLAteYasZHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF04380AC02;
	Fri,  1 Nov 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 00/23] Introducing OpenVPN Data Channel
 Offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042763176.2156176.14944932128891815206.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:20:31 +0000
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 donald.hunter@gmail.com, shuah@kernel.org, sd@queasysnail.net,
 ryazanov.s.a@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 skhan@linuxfoundation.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 11:47:13 +0100 you wrote:
> Notable changes from v10:
> * extended commit message of 23/23 with brief description of the output
> * Link to v10: https://lore.kernel.org/r/20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net
> 
> Please note that some patches were already reviewed by Andre Lunn,
> Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
> since no major code modification has happened since the review.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,01/23] netlink: add NLA_POLICY_MAX_LEN macro
    https://git.kernel.org/netdev/net-next/c/4138e9ec0093
  - [net-next,v11,02/23] net: introduce OpenVPN Data Channel Offload (ovpn)
    (no matching commit)
  - [net-next,v11,03/23] ovpn: add basic netlink support
    (no matching commit)
  - [net-next,v11,04/23] ovpn: add basic interface creation/destruction/management routines
    (no matching commit)
  - [net-next,v11,05/23] ovpn: keep carrier always on
    (no matching commit)
  - [net-next,v11,06/23] ovpn: introduce the ovpn_peer object
    (no matching commit)
  - [net-next,v11,07/23] ovpn: introduce the ovpn_socket object
    (no matching commit)
  - [net-next,v11,08/23] ovpn: implement basic TX path (UDP)
    (no matching commit)
  - [net-next,v11,09/23] ovpn: implement basic RX path (UDP)
    (no matching commit)
  - [net-next,v11,10/23] ovpn: implement packet processing
    (no matching commit)
  - [net-next,v11,11/23] ovpn: store tunnel and transport statistics
    (no matching commit)
  - [net-next,v11,12/23] ovpn: implement TCP transport
    (no matching commit)
  - [net-next,v11,13/23] ovpn: implement multi-peer support
    (no matching commit)
  - [net-next,v11,14/23] ovpn: implement peer lookup logic
    (no matching commit)
  - [net-next,v11,15/23] ovpn: implement keepalive mechanism
    (no matching commit)
  - [net-next,v11,16/23] ovpn: add support for updating local UDP endpoint
    (no matching commit)
  - [net-next,v11,17/23] ovpn: add support for peer floating
    (no matching commit)
  - [net-next,v11,18/23] ovpn: implement peer add/get/dump/delete via netlink
    (no matching commit)
  - [net-next,v11,19/23] ovpn: implement key add/get/del/swap via netlink
    (no matching commit)
  - [net-next,v11,20/23] ovpn: kill key and notify userspace in case of IV exhaustion
    (no matching commit)
  - [net-next,v11,21/23] ovpn: notify userspace when a peer is deleted
    (no matching commit)
  - [net-next,v11,22/23] ovpn: add basic ethtool support
    (no matching commit)
  - [net-next,v11,23/23] testing/selftests: add test tool and scripts for ovpn module
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



