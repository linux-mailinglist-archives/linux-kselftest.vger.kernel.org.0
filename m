Return-Path: <linux-kselftest+bounces-31670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E9DA9D71C
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4119C2C4B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 01:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836AA1FF7BC;
	Sat, 26 Apr 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfaRXPM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538251FF603;
	Sat, 26 Apr 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745632799; cv=none; b=IiMvPzihYtww9uinrPlwdWru4ZNP5cuIA19kQKAmRgKivH1Y1ZivLaKJExVtwIYNEeQww2+Ikz1PuDazzeWHcAypZWh29SaBofZb5OkPQlYpYU+HFFuAx53Ce1cGSMTX8He90i5oep9UQ9B2TZ0pn+RMW8AGel0/wB1q5yPUp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745632799; c=relaxed/simple;
	bh=DPB94Wgb909dzPRwsfkM9u3/GKWBHqD6K46P0E1VrZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fmThbQXnj+FfGGtOauZqZN2/S+/RNWk3OpYAx0ideBfeaABA/ModutabloxFkhrbYWFgFwFe1nphsuxhjjxopLYAKEO91ultGUUPWpiFOuBKuBj05O298ZoIbnLdVb5f817g7v54zy30eRVHCYryRGyigvIiPm7FVckRPocYREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfaRXPM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3A8C4CEF1;
	Sat, 26 Apr 2025 01:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745632798;
	bh=DPB94Wgb909dzPRwsfkM9u3/GKWBHqD6K46P0E1VrZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PfaRXPM/XVXEvUQ15D7MsFaSZTtHLq+iPjaRiOTmV4n5g3WkSlgKrel8bI/xIyRx3
	 L6UjBoSZAJwmpQuqEWJlzTOcGxHvN4WxzbQ2QvPgoWuL8wyixiUXrzysv6rjy7ygAP
	 PevqIARX+kEYgoE37DmGtZWWG0/G5Gbj5q015haBVKcDQSeyfoJcPFOWB2achSYEpG
	 U3dZ5Qiw3K91ivmOijMCNi3rM4ECXMb90nrRPFfmrimQsYu46nemOW+AS2GU8l1Puh
	 b9ihsKwhwYDSHyeYeNCn31VyRXfQmi5T0bSi4+ZU5OoSo3oBayXLxwaNTyC3wgISBw
	 Fc+tb42B5r/aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF99380CFDC;
	Sat, 26 Apr 2025 02:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: mscc: ocelot: delete PVID VLAN when readding it
 as non-PVID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174563283725.3899759.11491606624304284418.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 02:00:37 +0000
References: <20250424223734.3096202-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250424223734.3096202-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 01:37:33 +0300 you wrote:
> The following set of commands:
> 
> ip link add br0 type bridge vlan_filtering 1 # vlan_default_pvid 1 is implicit
> ip link set swp0 master br0
> bridge vlan add dev swp0 vid 1
> 
> should result in the dropping of untagged and 802.1p-tagged traffic, but
> we see that it continues to be accepted. Whereas, had we deleted VID 1
> instead, the aforementioned dropping would have worked
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: mscc: ocelot: delete PVID VLAN when readding it as non-PVID
    https://git.kernel.org/netdev/net/c/5ec6d7d737a4
  - [net,2/2] selftests: net: bridge_vlan_aware: test untagged/8021p-tagged with and without PVID
    https://git.kernel.org/netdev/net/c/bf9de1dcd0ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



