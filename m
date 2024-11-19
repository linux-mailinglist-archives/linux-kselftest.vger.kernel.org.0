Return-Path: <linux-kselftest+bounces-22249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7509D2379
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B928253E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC21C3F03;
	Tue, 19 Nov 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="two4WkNG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54D1C3045;
	Tue, 19 Nov 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011618; cv=none; b=gw2EpEKBuepgm52N7URfTksJXoV4j+KVBkpwIsQCkFxIo0p4ziGdyDFkbJOrP5O0Kupv0c69ehr2qutaLwrw9WtTUR68Q9JAKwm55nYVfQNjtovI1v0/dL5NTBcmcW0qR3cYLASgENOq+SUyzVTWIDTAycEzMxZJ/Jfw+pD5qxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011618; c=relaxed/simple;
	bh=m+RTIJvwTBIXfjjqpGVkRcKP80nWHoUWegCFZ2nW83w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SlMLV8KFC/8Db6ZGk5F3ZerIj3OleCBrZfKHEu52aQJJqpcsfUt+7DzsOBqmqs+0iNUts47Qac4IKBHVdWSf6gYt7bYhbbmPr9iMaVrFd9H2ffdwiwZeUqkAlsSQLzdbox7c3J9ekj+MqYGBrd1d77P5pPjRWIkRWKux5q9Asqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=two4WkNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F23C4CECF;
	Tue, 19 Nov 2024 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732011618;
	bh=m+RTIJvwTBIXfjjqpGVkRcKP80nWHoUWegCFZ2nW83w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=two4WkNGe2Fn7jLi1SviihLLUYW+oqaw5kc8kpzzZdFiok5Gn8OZm0cMOxUN3IOBN
	 LeW8N5pQQ1YA9iJYIoBHcnHoAAvEkygURWJBl3MaPU+cepsr/b/W3niy96zv4YUDg3
	 Eib9Mzbsv9xg6ZgWddFrbL4I0amlvce5++QcVuvzWLpEWNE+2MWMmoJU1x+ty92NC7
	 0lsJJEdokPv40bm7fkx4yvrC3sA2QKUPoOl4vxzS/ZMoHWBa0sG16GDIPQ0TCbjQu9
	 r0pnQ2twMCN04oLdQzD0tnD217cRNqX4vs/K20wLLKh+t4KDk02OXbNlcXemYl+Y1U
	 lmT81FUlya+RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7303809A80;
	Tue, 19 Nov 2024 10:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] selftests: Add selftest for link layer and
 performance testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173201162975.486840.10132784093524723273.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 10:20:29 +0000
References: <20241114192545.1742514-1-mohan.prasad@microchip.com>
In-Reply-To: <20241114192545.1742514-1-mohan.prasad@microchip.com>
To: Mohan Prasad J <mohan.prasad@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 andrew@lunn.ch, edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com,
 UNGLinuxDriver@microchip.com, willemb@google.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Nov 2024 00:55:17 +0530 you wrote:
> The series of patches are for doing basic tests
> of NIC driver. Test comprises checks for auto-negotiation,
> speed, duplex state and throughput between local NIC and
> partner. Tools such as ethtool, iperf3 are used.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] selftests: nic_link_layer: Add link layer selftest for NIC driver
    https://git.kernel.org/netdev/net-next/c/6116075e18f7
  - [net-next,v4,2/3] selftests: nic_link_layer: Add selftest case for speed and duplex states
    https://git.kernel.org/netdev/net-next/c/c087dc54394b
  - [net-next,v4,3/3] selftests: nic_performance: Add selftest for performance of NIC driver
    https://git.kernel.org/netdev/net-next/c/fbbf93556f0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



