Return-Path: <linux-kselftest+bounces-2155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0B8170B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 14:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E42282EE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B621D123;
	Mon, 18 Dec 2023 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwCYVolm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4547129EFB;
	Mon, 18 Dec 2023 13:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81580C433C8;
	Mon, 18 Dec 2023 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702907012;
	bh=HdgIQfKeUoqhoGuxp3/bFAKwSDG4brUanTcEVT1/dX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwCYVolmUtJwCBurjz9yD4hs5y1Jf5p3kcbbR2kUomMIUooxjb/bjRSIv0BU4FMhN
	 e1//HcgCs+bsAcSNg4eBmErLCS4PBtRplEla4hPo/T12ZEsDPYLIxgYGBq16IuNg0n
	 KOljDAsxZ2Nxe+ep8zK2TjvxlqAFIPb0RAc2mxUcPn4VUy4C9fXxCJMetWOftg9jM/
	 mHOkUdP+5Ihm1WOzHlKTehnS18NFt9xGZOzUjKo2gOO3PVD0vlAkAI3SKjNxxdlqR9
	 S7pbWLAjergnuWSJJg260dQDjz/oPtsoAsVN29VVn8dXRX4iwiG+CCmN+4TeBDhPlF
	 b7PouNLo3+3mw==
Date: Mon, 18 Dec 2023 13:43:26 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, vladimir.oltean@nxp.com,
	s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com,
	srk@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 08/10] net: ethernet: ti: am65-cpsw: add
 mqprio qdisc offload in channel mode
Message-ID: <20231218134326.GD6288@kernel.org>
References: <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-9-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215132048.43727-9-rogerq@kernel.org>

On Fri, Dec 15, 2023 at 03:20:46PM +0200, Roger Quadros wrote:
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

...

> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> index 9f0a05e763d1..7ad7af3b3c60 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/pm_runtime.h>
> +#include <linux/math.h>
>  #include <linux/time.h>
>  #include <net/pkt_cls.h>
>  
> @@ -15,6 +16,8 @@
>  #include "am65-cpts.h"
>  #include "cpsw_ale.h"
>  
> +#define TO_MBPS(x)	DIV_ROUND_UP((x), BYTES_PER_MBIT)

Hi Grygorii and Roger,

a minor nit from my side: in order for BYTES_PER_MBIT to be defined
linux/units.h needs to be included. But that isn't added until
the next patch.

...

