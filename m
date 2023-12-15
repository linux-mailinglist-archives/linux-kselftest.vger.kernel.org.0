Return-Path: <linux-kselftest+bounces-2085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40F6814E8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 18:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC601F255B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2649F78;
	Fri, 15 Dec 2023 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eHCO6StW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134383FB12;
	Fri, 15 Dec 2023 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCI4crTvzcUzKarpvL+r3yGAAbD5QOwoCQxqkGSsQphK1caKaM6fPbBBYUc2Q/hTT81aHDQ0rrRl6enERqW7lGSu4idSVHmUHbuvzb6AA/Qd04DNh8OlLTGGu81C4Wpk2/EG/CkGYS40FDifIUuQlIccoymT0W3T/6Njlfo9g81/3++ofAlmtO9jTf30UiWP47GyRxRDxu2pdSECohUolTrIcrGYTseDNluyEujVg9YIUecsTsmNlgm2zaKopEo8lFY0shbxvST6JiiY+J40KNC+adzQUHjyldkEOWEm7r25sFwQuHz44MWwNRf0vmb12rARNGS97fisVkQI+QaB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y9Y9QKiIBUPbhw2CUh1eKHMo808IskqA4ajiraBjBk=;
 b=Xp062KDYweF6cJpej2NWemRNl0wCs2DcqytXycvrS1Z3rXnUbNh0J11Lo7rIdhvUtmwMGV4LQovU/WRaidnGzHi0qRmoM+AeRtRPeHONUk+llyILXfDZiqNFfuilFUFnKzPYbBHDMv4w6hqhvYcrUYos8dchmwOZHFN2mLSAxgTvvRJC5KowNPUCD6aMPgfsJ84aJN4Mu8lMoEmcbEyN4YPxPFXVd9iXvFvqBTkjC9OtV6zhyMJD1Az0i/i8fLZvwAAuUwdGGjgbSLZaSiiYVkdUaFeIwoxpYFXLACZqKY+aZV+j4t4doEFIkSzs3se45xBQ9Yt1nPRP1T1J5hIsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y9Y9QKiIBUPbhw2CUh1eKHMo808IskqA4ajiraBjBk=;
 b=eHCO6StWTp/RarzdhtphDHMJU4wm7JOpqIJYdl9yEruvk38mhLSUhuc/RAVA9CyAinNt/hwWT1joam/hFRYXYY27TJFzXlv8tj1lNG2wL1F/qfyjN5ZJp7kZxxosBODxPDTkKcXyWdU87da5lMFaNrqtGEq+Sus9C9mUJmqmecQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8658.eurprd04.prod.outlook.com (2603:10a6:20b:429::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:16:02 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 17:16:00 +0000
Date: Fri, 15 Dec 2023 19:15:55 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 08/10] net: ethernet: ti: am65-cpsw: add
 mqprio qdisc offload in channel mode
Message-ID: <20231215171555.4emy5fn77ej6oti6@skbuf>
References: <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-9-rogerq@kernel.org>
 <20231215132048.43727-9-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215132048.43727-9-rogerq@kernel.org>
 <20231215132048.43727-9-rogerq@kernel.org>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d3835e-0191-4442-32e9-08dbfd9181c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wE8YlDbu6I/CtnZz1uTtZHxL22yrsKcyI3rBYViDrvgIU1DarNzFctIObL9B3ql/Q0Qwt5Y6riSDgcY9SL/8wx69bHByUuWNO1cyKFahxNUT7uw4aE7f25PMzhM28xR7pkHdipQLvOx+6tNIc2qChrCf5a2auCAhggmpLk2JX2vFoShKLJDzzELzczlmi1LGIhnvSBC/Ye5vzVeJrD8MTLMT5/GK4Zyx2nqZWKY7Wd1pk6yjjzyCWIzV+tYs4mpWmzNlQnJrt4tz6Xvh+6uu09R+ynaGYLqmWZG4/2iE7aSpFkooTFczmeC4/57NneO6Ml40CaNkSjb3nj5otuVoKsGaK5xhmAw6YkdSXmWljeC3AvWb5ndubM0jUaL0xUPred+DCxZMFpFuAvMTSEjPL/Q8AtyMsNOIVQIQSauDeuQUW2pQ1rjyZOIFHfGO//8dkEEFObzy9rWm5pUH03A3nwuvhz0ZPbDFTVdUIVdwcurYBZeDC2OTnuO2NfRySZ8LRZ6RR3LM/0zaz3BiWWLAfkaz5K+BGGbzip/fP3WL+pEtzFRsMRagQmKJL9O6bdXcrTUDOAbL3Gbf3wQcvYkGpG3zkcL23KAcQ3D+g8qIDlg5ZCfkG/q3+4QW+o8fCFRf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(396003)(346002)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(6486002)(478600001)(6666004)(6506007)(9686003)(1076003)(6512007)(26005)(66556008)(66946007)(6916009)(66476007)(316002)(38100700002)(86362001)(8676002)(4326008)(44832011)(8936002)(5660300002)(7416002)(2906002)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q6S0W0sjsvUQ5Z5aac2M53BuMVXGEsq07aO2Z7kQn+0PGItc5sO/NeoMHu0r?=
 =?us-ascii?Q?YyD1QdsVXmXrW8SpyYJftWPEZ+3nqwfNT5JPDmjmS32fSta7vnpX2zVXVdhK?=
 =?us-ascii?Q?Qh600Tia5Iw029C7TpnVeAhj3jw/AICduhEKo2rHjGFZdjUN5cyTsRbVPHeD?=
 =?us-ascii?Q?ybWLdkzChSDBVq1IEoIg/NkMsgZXvhGXwiDEhYqz3K6rBD9YZ44xx6eM6JRS?=
 =?us-ascii?Q?/zZPyhqYKqCCxD1HTXHdzaMo7fSDEli9+Lva7pvv6/Su6MWBt/McPkF84dBD?=
 =?us-ascii?Q?Mj66fgQrUFVjoxIYo53cXO9ZxsdAd6Gzf8hz8n+ZFAh+tta36+bldXdtVkIm?=
 =?us-ascii?Q?JKy5bJtmFz2ayyXKcuzKIXzmsfKiT787B3RDXzZrmn3UH4Ij7LnsoZJYoH+x?=
 =?us-ascii?Q?/mQhc4jEbLusbwcUmb28ZHoqV4McmQyCy7SL3V9IrLS+XjYAwVoDeoBsbN2s?=
 =?us-ascii?Q?pM33LfIS+3AeYzr2WQ4zJJqQDbV5Qo1SS0Gm+FScacS3r8yBEeGUFBWNRgzf?=
 =?us-ascii?Q?j5Wt2jvG4WCwpQRdnYFYDugrJbETlSZN5vzcpSNlKYd5tjVw6TGYbK5CAzns?=
 =?us-ascii?Q?xBmmRjdrAQkHNq5maU2IAAupc5Z12wSt+fAjXlvjDe9yOTA6eP45QcmkxCcV?=
 =?us-ascii?Q?bpLkBgjHiaGx8AyEwoJEsI9R+6tpp8BfrfhNIhoDW74Y45ROOZHcevTNYH9g?=
 =?us-ascii?Q?9z6ppAeS3spBmfZNzwk9oja8ktYehGduJyenTgTJ3pGZR1MtUs0MIaI4L2DV?=
 =?us-ascii?Q?9jq90ERjDzT2vGDFng8djdzRsI8wWI4o8tJi5wHN//70E8IxgHuKg8SP8LcO?=
 =?us-ascii?Q?OE6aiUzlGeiTvl64dERGKqB2XPCrtsJidgNT4zKieTgB3gGsQpqndrCLsuc4?=
 =?us-ascii?Q?VfH+BuuICtxa4h7mV+E1Cw4WWXMoWq1X8goGzokpIr1PWqta4jzoV7WUnzkr?=
 =?us-ascii?Q?6It1JxAnc3mX1CQMBBsHB2A0G4Jciwzxl77JhSUuKw6i6qAxnfDd6At506zW?=
 =?us-ascii?Q?zIyMm61qM8t+/rdocCPmc9M48dp0chXdevM24ceCMu9JjkUXkCXwoOsbhstF?=
 =?us-ascii?Q?GWG5ABsgmetOYI8gEzZFfJCdfCL0LC1TZvefPweHDYSREt2qtQVidiQPhEEp?=
 =?us-ascii?Q?4n6rZqHAJtYJoP1aAMTa2Nf7xUJ5ZmQA7jYDPtCcX2cfrRW2SazzfQekn9Z8?=
 =?us-ascii?Q?dVV0BjPGGVYTDjNdi2mmREx5LTHcmQB9GVj4XiLiBgmoa8I39IgaFCbvBork?=
 =?us-ascii?Q?Ao1JHZQiBRMi76iODVzQ+tRnpm4M3Wk2x3MIvFGB7PL8N6gpWyhgC9xtm34p?=
 =?us-ascii?Q?TbtOfxCjwLoXZ1KepNWT5H40XI81Mtx88sR9kDFJaxGAaCtXp44fGOho4D8X?=
 =?us-ascii?Q?7OPN439qlHpvhRfT7ZeJIeroYb9Nm9R/yPtnrfSAa7b0y9kdPnuaz0U0rfmL?=
 =?us-ascii?Q?OxmhX4MouESGvwHHVIVvhny60JDTcNakpdFj+8q1Xd8EyjlsuwNLoSNqnoU9?=
 =?us-ascii?Q?2nM8pl+jyUKpV8ScayuyQQ57vAbh14eIT4YR2oC667DO/0xFSGvGUM58J+Vt?=
 =?us-ascii?Q?+O5ANtLkd9J6yF9uq953roXU43skbUYvPdetRB91h6FxJOU0J/1yLWePbRGN?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d3835e-0191-4442-32e9-08dbfd9181c1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:15:59.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40/UQzZbWaEebX0jJIDrJi13K6DcWNys4CLbSMaa75PXM6p5SzxUo14fXTGwDtpfNx8zJryYKeUwbbOOx0Rf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8658

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
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

