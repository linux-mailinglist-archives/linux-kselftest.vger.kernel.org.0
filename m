Return-Path: <linux-kselftest+bounces-2163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E200E81788B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 18:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE1C1C23DCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CD5D728;
	Mon, 18 Dec 2023 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2yQkEnF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220B5BF9C;
	Mon, 18 Dec 2023 17:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A77C433C7;
	Mon, 18 Dec 2023 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920039;
	bh=mxQodVK8Qo9iWtDoh+f+wkylLrmy3Zyz6oU2mXSN1t0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y2yQkEnF95YPtGg+mLklR/7o4FtDTIxrwVBi4PYmUk+YTwLBqcT7WpUmFm/jV8+sv
	 VNScfR1KSaABDVNP9JzH40oMDEgbQr6DSyb42bkfc528E8CibzpjHYXJG8Su61gz1/
	 YCQZu5B7CIfpOK+Uyafa7Xqlub6I9MSbItN2deXY6MgKddE3LyJymziUMMLS8Sqp+W
	 wqLFfV48vB88DppDq3YBH7TBO5i/ieDZ8991cFtCCivIAKmn1og8tkYY+RmZlitg3H
	 ifkaTN7jH9ze3QcF9+ZwBiUXiQIFApfhUskYpeIsCm+wuJlAMRpB33E9blOO8K2kbF
	 ovcDOXfb5uHIw==
Message-ID: <a205c24f-f170-47eb-a21e-1809290fa7b2@kernel.org>
Date: Mon, 18 Dec 2023 19:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 08/10] net: ethernet: ti: am65-cpsw: add
 mqprio qdisc offload in channel mode
Content-Language: en-US
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
 horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231218125513.52337-1-rogerq@kernel.org>
 <20231218125513.52337-9-rogerq@kernel.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231218125513.52337-9-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/12/2023 14:55, Roger Quadros wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
> not only setting up pri:tc mapping, but also configuring TX shapers
> (rate-limiting) on external port FIFOs.
> 
> The MQPRIO Qdisc offload is expected to work with or without VLAN/priority
> tagged packets.
> 
> The CPSW external Port FIFO has 8 Priority queues. The rate-limit can be
> set for each of these priority queues. Which Priority queue a packet is
> assigned to depends on PN_REG_TX_PRI_MAP register which maps header
> priority to switch priority.
> 
> The header priority of a packet is assigned via the RX_PRI_MAP_REG which
> maps packet priority to header priority.
> 
> The packet priority is either the VLAN priority (for VLAN tagged packets)
> or the thread/channel offset.
> 
> For simplicity, we assign the same priority queue to all queues of a
> Traffic Class so it can be rate-limited correctly.
> 
> Configuration example:
>  ethtool -L eth1 tx 5
>  ethtool --set-priv-flags eth1 p0-rx-ptype-rrobin off
> 
>  tc qdisc add dev eth1 parent root handle 100: mqprio num_tc 3 \
>  map 0 0 1 2 0 0 0 0 0 0 0 0 0 0 0 0 \
>  queues 1@0 1@1 1@2 hw 1 mode channel \
>  shaper bw_rlimit min_rate 0 100mbit 200mbit max_rate 0 101mbit 202mbit
> 
>  tc qdisc replace dev eth2 handle 100: parent root mqprio num_tc 1 \
>  map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 hw 1
> 
>  ip link add link eth1 name eth1.100 type vlan id 100
>  ip link set eth1.100 type vlan egress 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> 
> In the above example two ports share the same TX CPPI queue 0 for low
> priority traffic. 3 traffic classes are defined for eth1 and mapped to:
> TC0 - low priority, TX CPPI queue 0 -> ext Port 1 fifo0, no rate limit
> TC1 - prio 2, TX CPPI queue 1 -> ext Port 1 fifo1, CIR=100Mbit/s, EIR=1Mbit/s
> TC2 - prio 3, TX CPPI queue 2 -> ext Port 1 fifo2, CIR=200Mbit/s, EIR=2Mbit/s
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/ethernet/ti/Kconfig          |   3 +-
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c |   3 +
>  drivers/net/ethernet/ti/am65-cpsw-qos.c  | 255 ++++++++++++++++++++++-
>  drivers/net/ethernet/ti/am65-cpsw-qos.h  |  20 ++
>  4 files changed, 277 insertions(+), 4 deletions(-)

This breaks build due to undefined BYTES_PER_MBIT.
I'll fix it up and send another revision.

-- 
cheers,
-roger

