Return-Path: <linux-kselftest+bounces-15487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52566954531
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CAB286C77
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B063C13D516;
	Fri, 16 Aug 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaiFDElG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB313C801;
	Fri, 16 Aug 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799433; cv=none; b=LewovBDfjnyjeS68Gpa4mtrEaC3/3kq0PhCVSTYK8qZ3GGBsGoBs/AztP1LbdFCakQ2QlaCV0PO5fhi1wlzO2RoF3C1qW035suDTM9+2TuwLrsJUVwf1D79c0dav3RaFVse7hg1KmmraV+GlpWwPBrvtkyRl1cNmNVQQ/pxKJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799433; c=relaxed/simple;
	bh=S9r9yGxVBVVt8iz8VZ6BiPMcB2RBNjLI7DiZjXXCPnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdG+jvkrF7X4mred0YKfl+dOaqlaEpO796/S0DMAuErhsNOKxDlTrlaLI7J0YGJpXp3jGCyUTE6ahfPoAjwQ4nZeqB1AKhsgY8X71SGwzoohhSzUqxxCzZn0f4SYon5IQFYWjtvenq13QF7VtmL9NkJISazjpT3iydqubcpfcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaiFDElG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0593AC4AF0E;
	Fri, 16 Aug 2024 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723799433;
	bh=S9r9yGxVBVVt8iz8VZ6BiPMcB2RBNjLI7DiZjXXCPnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AaiFDElGcQlADY2h4llu8sBTpqefXgK+iL4Au8i8jzAi7VXApVT/OCSs+U5Ed6R4/
	 EF8e9hQa5VysVYQXNdIK7FdMgak7LT6I41P6rC/s/mjdlxNndtc8G9Dzmt8U1ecu6e
	 hn6NNbonoDUFWHkR28/hzNBMcS4zLEm83xpWcn8BPh1eMs4vx9ONdC3wQ7OsgwpDgC
	 y8b44M2W9uRrm6VerRZyS5QsBn5H05WrhWG9XBrXsbVRn1aQU35FVWx55Faz6KjWRI
	 rHgXDoIczxOBL+L3fB1Xqo7fJLEY+UKHeb0En/K6Pg5qrgDOcZN1H7emsCAx10hMzB
	 Mr2H6Kd3kTQ5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FB538231F8;
	Fri, 16 Aug 2024 09:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/14] VLAN fixes for Ocelot driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172379943226.3458201.417541764470956886.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 09:10:32 +0000
References: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, atenart@kernel.org,
 UNGLinuxDriver@microchip.com, hongbo.wang@nxp.com, xiaoliang.yang_1@nxp.com,
 andrew@lunn.ch, f.fainelli@gmail.com, colin.foster@in-advantage.com,
 horatiu.vultur@microchip.com, liuhangbin@gmail.com, petrm@nvidia.com,
 idosch@nvidia.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Aug 2024 03:06:53 +0300 you wrote:
> This is a collection of patches I've gathered over the past several
> months.
> 
> Patches 1-6/14 are supporting patches for selftests.
> 
> Patch 9/14 fixes PTP TX from a VLAN upper of a VLAN-aware bridge port
> when using the "ocelot-8021q" tagging protocol. Patch 7/14 is its
> supporting selftest.
> 
> [...]

Here is the summary with links:
  - [net,01/14] selftests: net: local_termination: refactor macvlan creation/deletion
    https://git.kernel.org/netdev/net/c/8d019b15ddd5
  - [net,02/14] selftests: net: local_termination: parameterize sending interface
    https://git.kernel.org/netdev/net/c/4261fa35185c
  - [net,03/14] selftests: net: local_termination: parameterize test name
    https://git.kernel.org/netdev/net/c/df7cf5cc551c
  - [net,04/14] selftests: net: local_termination: add one more test for VLAN-aware bridges
    https://git.kernel.org/netdev/net/c/5b8e74182ed3
  - [net,05/14] selftests: net: local_termination: introduce new tests which capture VLAN behavior
    https://git.kernel.org/netdev/net/c/5fea8bb00974
  - [net,06/14] selftests: net: local_termination: don't use xfail_on_veth()
    https://git.kernel.org/netdev/net/c/9aa3749ca4a8
  - [net,07/14] selftests: net: local_termination: add PTP frames to the mix
    https://git.kernel.org/netdev/net/c/237979504264
  - [net,08/14] selftests: net: bridge_vlan_aware: test that other TPIDs are seen as untagged
    https://git.kernel.org/netdev/net/c/e29b82ef2761
  - [net,09/14] net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA and register injection
    https://git.kernel.org/netdev/net/c/67c3ca2c5cfe
  - [net,10/14] net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"
    https://git.kernel.org/netdev/net/c/e1b9e80236c5
  - [net,11/14] net: mscc: ocelot: serialize access to the injection/extraction groups
    https://git.kernel.org/netdev/net/c/c5e12ac3beb0
  - [net,12/14] net: dsa: provide a software untagging function on RX for VLAN-aware bridges
    https://git.kernel.org/netdev/net/c/93e4649efa96
  - [net,13/14] net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q
    https://git.kernel.org/netdev/net/c/f1288fd7293b
  - [net,14/14] net: mscc: ocelot: treat 802.1ad tagged traffic as 802.1Q-untagged
    https://git.kernel.org/netdev/net/c/36dd1141be70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



