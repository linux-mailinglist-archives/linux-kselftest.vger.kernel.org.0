Return-Path: <linux-kselftest+bounces-31949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C7CAA3B51
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95E81A85BA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACEC27465F;
	Tue, 29 Apr 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LELGss+W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDD2741CF;
	Tue, 29 Apr 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965196; cv=none; b=uN5ol07sum0/WVeilPYBdmsmth/hbz3gEJghB8wgPnEximcvDG01sgYs6ahfej0lBpUUAdOuO0rI/rps9jAZ/CQ+OxIlpQM/NHSPXv3TVHsjn20wk+G0PRhoVg+vHIF7bhRpN4FVHXg6M8Nod3P0dLgdE4fX9ebArNMZrTQW+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965196; c=relaxed/simple;
	bh=J/s2dhfMtRtTsNtV8l9kvGYQI7PH+pUdKUmwCzscTVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V1ae6nN0hY4vdB7O1TYospBq1lGPZKGeSKdMY61/jYViIVfeYj3OEjMqOKSkZRaYlsmAZ4t7cHkB1z/R3ArFDcrbV/3MzmjZ/CHEeva2wSsXMXRKawZSZiLSOekFJUcTYDKcuUpa8IISvMItiRCIL0qBXq/hw7o9s8iTbcduQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LELGss+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C40C4CEE3;
	Tue, 29 Apr 2025 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745965195;
	bh=J/s2dhfMtRtTsNtV8l9kvGYQI7PH+pUdKUmwCzscTVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LELGss+W/Qacqa1oJnOT0EY4FL/C+7Lyw9k7WUfCs1ewEjIBhFkqpLjIzrbqGvL8+
	 qtw6ECkAFWAs0Ml7AnISd+h4MG+P17/RZ54npdi97HokHvw1ren1jXaDyDjoBobmYc
	 dTnAX+m0QGAN/FElCSwzqpjzKEzAssTf/i9lRcdr+5ti5ZMDMpxjwliVBuQrNLuSbP
	 KfEApLXFoDiI9VzjitqkAjvFW++cQPQ/Po6EH6gYeoIbnEgiaRgQXglgXMkDB+b9MT
	 1NEWzBFxdwDuiIWBCIZGzPFHTBs9Snq61dLB8+FfRc2W5o5OREqAWdlbws/7WiW7ev
	 LWxEuX8cpxbvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0763822D4E;
	Tue, 29 Apr 2025 22:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] Fix Felix DSA taprio gates after clock jump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174596523475.1813341.4865840988683166459.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 22:20:34 +0000
References: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 richard.pearn@nxp.com, xiaoliang.yang_1@nxp.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Apr 2025 17:48:54 +0300 you wrote:
> Richie Pearn presented a reproducible situation where traffic would get
> blocked on the NXP LS1028A switch if a certain taprio schedule was
> applied, and stepping the PTP clock would take place. The latter event
> is an expected initial occurrence, but also at runtime, for example when
> transitioning from one grandmaster to another.
> 
> The issue is completely described in patch 1/4, which also contains
> the fix, but it has left me with some doubts regarding the need for
> vsc9959_tas_clock_adjust() in general.
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: dsa: felix: fix broken taprio gate states after clock jump
    https://git.kernel.org/netdev/net/c/426d487bca38
  - [net,2/4] selftests: net: tsn_lib: create common helper for counting received packets
    https://git.kernel.org/netdev/net/c/efa6eb7d77aa
  - [net,3/4] selftests: net: tsn_lib: add window_size argument to isochron_do()
    https://git.kernel.org/netdev/net/c/f52fe6efd61f
  - [net,4/4] selftests: net: tc_taprio: new test
    https://git.kernel.org/netdev/net/c/4eb9da050f00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



