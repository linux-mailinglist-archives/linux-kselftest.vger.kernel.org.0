Return-Path: <linux-kselftest+bounces-15367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF09526A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819E71C21D43
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18247796;
	Thu, 15 Aug 2024 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rt8yhkpq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620C3FB1B;
	Thu, 15 Aug 2024 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680597; cv=fail; b=KV11+0O/RN8Ubg0XFijq8IVdlreleMRLnzzJUrQIK9XfkDCBYTuMQxqDRQyWdgTsQyCGkr9kQ9Ah/aPFsHQjGyHyIalJtI7nMUQKuGEmGm47Ol56/NDVT2pq2XTrzQOgGLkTBabh+QTGHZZr0isRrPYWD1rGYHfYOZVOCk1nGFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680597; c=relaxed/simple;
	bh=4iDMZpNjH9wd+SJ08fKUkSY9a7FVu8ZyWrWdaAT4xgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUOTTgBidhw30cu19oUIQcc0M2CIxbIBTR0rNjouZ/DZZrLQ6H0P2PwzhHcDnqlBTonR1qlsG/YWMOkwbMM+Xxd7JImb6KbzXsMeeFc0dpUibXqE5LE4TTaNk0SRX+gsJGzkEbEc2YInNVnohBHMfP/P8oiX0v6OQBYJpaAQ820=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rt8yhkpq; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fccRzltrrhqsIR7m/I+wWMv0wNZUHoSuFHV5pyiz/athnJu4RTzebU+G0rF1ps+mQGrlgl4HrE4p8gQoLAc8hTs/q0xf9Te+VUiU7D92Ra9hJ5vsOEatlRGvHK/Vgnz0xZqCiHtzZKuOsYfZKxvf5kdu54vc5NCCMOoECtzoESpIWtAgq58+5gNjnW+MYtCFABs6teSFdq8VxKOxljajgwwdkaEkETggDDgbfrUujbY/bnGbcURAHrxfqhl61BUFTFll3P5D0aqwAEbUe32Y79ZaatG/gh/3BE5KN/7lIQtsle8I7yabLOWUrPmoAt9YdgM19UlJ9AqeTtC5deeAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgsffPOM8rXOTns59/RY1lYK6l81MKC6Z8yN/i/CIhs=;
 b=Kk2y9pcz89y6g4DAJrbV+9xoV11Fx8FNE6imRt+vj3Z6nMBKcvTsSe9DhR6QfRoytekBttR/UObtf4FrVU5/3GbCc/xWix5iYCIG21qewvx8ZaXlqYmOveh0cHWWTEZ8TNgnZe+iZzSkArX39rLMCqYDzBpGNf/TT93XN7oDzGC9wNeQNFekkPwukaI3lK8cvDDI3X7/lZTXh+mrkQ/B03reKfwgyJsvAHzA0+M5uCVH4uN3WL26d3vHWB6gKHWGWMNSpinMkcJTtAUTuHxzB5L5cxsO3dg+3j96JI06pI5yrI5TyTMQGDa+NUCze3EReh9QRLrHUUPBJG8zVUibFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgsffPOM8rXOTns59/RY1lYK6l81MKC6Z8yN/i/CIhs=;
 b=Rt8yhkpqXHVjBIdTPxZILxcmoU+sLK79u393WDg7PLA+T9gWKqy+6ugN1e1me4u7w6VxQGJXqrTeDpOZ+jTGWoT6vuub5TWuK51qLn3Klk69CL+foZzg/8gRP3MiNVRfAlXTPRkfup4HCG0iZNHsPYysY/wyLTPglRRO2U6rvSioDkOJJM9iYWUIVHlUb7vnKrjd28h0aLCJhyn5xeogxR8z09yclfN/fVURcP7uL1ZPbz712AHgti8Z/OOYbm/f9CZS6mlnhLWJkdLlT1+ERxB0p6C6zgPA6WKvSSq/yMvh+FC6Fw2Q70045fcZSY2fb/4NSzCS9Hmz90dH5uDucg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Hongbo Wang <hongbo.wang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 12/14] net: dsa: provide a software untagging function on RX for VLAN-aware bridges
Date: Thu, 15 Aug 2024 03:07:05 +0300
Message-Id: <20240815000707.2006121-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
References: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10285:EE_
X-MS-Office365-Filtering-Correlation-Id: 305d7dff-3276-4137-97ca-08dcbcbe949f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sF4Entb4T4NOTw3yLvkRlYIvxWtxc2demQ7bFqMtmpHot85WpB0KhwQRVMIa?=
 =?us-ascii?Q?G/9rnclsFQHR69A3SCCrTOEPbIcmv+SP05Hoc8n5MrW5OrXcM7tA/TlezJpp?=
 =?us-ascii?Q?U6teoX+yqig0ML3VW0zAuEe8CCEkiFHj5nYnIr7NpPjxe5g/3yx/Zt18+/l+?=
 =?us-ascii?Q?/RtQQi5gbmpE5Q4uYYSsnWUidI9rxdgeab54amj55Lbsh+s2Zs8T22mcfXPh?=
 =?us-ascii?Q?s2YsUNnPc4E/VJ1H2KelnNk1rSyA2g1UEFqiCiBaKb3ENNKzHVM29oYeu+v7?=
 =?us-ascii?Q?Sj6+pPIhFxd8cH6yLp6wdlvvZaxzuxSsFbtRQg56AmsZ1pxcSM1WoKAgKmBe?=
 =?us-ascii?Q?RwC8WmFdMvX7LgUoI7gMVy1cw7LwElTH20fBLBjbmJijzprZlHJLpNfi5UiC?=
 =?us-ascii?Q?KNNjNcqzeTyxTZpKheznuj5tGIrD4K6PIuv5iRhUiS/ufGpPPbSRH0tfCqUU?=
 =?us-ascii?Q?WkLKsw3KbHrgIFalZgL8BdrI03nBXvNO9GSJEw/Me8yzPTYuDBT+Dd+oIlao?=
 =?us-ascii?Q?Gdtr5shqfl4CWH0XSaeBLo3A6ER9hZTtiHEzNDavlPaJdKxprKRMecGj9qmp?=
 =?us-ascii?Q?sLpeD6k/6sO2L7LGzVXmigjeG0Nnot0rK+o8qLhQxwd2ltSIe/XC7qk1h2gp?=
 =?us-ascii?Q?vtYzQ3adHtsfFFhX52LYYy4QLdqLgRqJ9uf0JBXri5x/hbfxFos/nwaCFjmD?=
 =?us-ascii?Q?SSMOORqvWxrW8LmGutvCFItOwZoAn+mj2qyiZ5MKqa+bzQOxnJWnXTQ3vALc?=
 =?us-ascii?Q?CWQ3KL68Fs4wUzH7rcbxxE7IwR+jIFJZADZAvd2jPBpsJlZdRaYX5qJGmVTr?=
 =?us-ascii?Q?Zf3aNuJox3SGYIy9Rqfml6HOOoladO2KNAb5nZFPuPk7rHayzpGQo/Gg1iEe?=
 =?us-ascii?Q?nKg22a1R/hn3wTgpUphOwT1DZwIt5hE9jiJF0xpHkPY3ESaz8S5F/eNW8PM8?=
 =?us-ascii?Q?GLWSdaWVJZB80tvVVXVjiJFu+hVz1N1sdjJcnJ3yG92L/DZpFD5qz/TcJc0U?=
 =?us-ascii?Q?Xa/zs8QBvR3/ZSFWZ5xXedGgu+H6ik7rrqDbZ6nw41Q1tfLJP4m7DWroRtHR?=
 =?us-ascii?Q?ZsaJL+jqB4eusuEsq4kypGtc2d32MeHjjHZa8Wp4nuECSjBvgoybYHcCnNMD?=
 =?us-ascii?Q?SBAhxGWalGFKUvTN23WjhbpbvbYsEsVRGFwAgkjTwLztfvTLdRT+Oq07FlFE?=
 =?us-ascii?Q?d6f4tVx+aOJOLjmU2QLie0Wig4tvyVM4RrWhLYkE619XExH51Y7zNe5l5Ick?=
 =?us-ascii?Q?hYg/Z20h1EbkAzQ1Fj0KdLXx68CWchHlbdR7K38T6Y5iF1G7VC6yCauovrRk?=
 =?us-ascii?Q?wfKW48WLuriq4uXmHRLh1AHnqO+YEnTqMZ2fsvDgD4GEE/iUDA1ZaciXzKil?=
 =?us-ascii?Q?86ATuI3BXgABIGJFBD0crVFuKXunYRGWcS9Xhy/r6DUAw8g50Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1dy3zrDBLQATXZYiR+xoaVp3/dfXi/M94IwEU8eQynF5jKGyRRjUjAApzyuQ?=
 =?us-ascii?Q?0Ma/82X8cS/lwr0WvthnMwOsf4yAdBfDaFqhdy0BdmzNzhqiUhMRXEbOm7HM?=
 =?us-ascii?Q?M9FO2dszAaRSlE4RvmpGJ9k/CT4HQB/3k5wjqMW70HUdnGXP4qManI8dIwJl?=
 =?us-ascii?Q?CbWY17gG2odF3SMCz78n3qsc1GYtiKGBaka0k02tYbtbgOidYEr93o/JcMXt?=
 =?us-ascii?Q?7++uZhWTv4mX4KsMMID7MupMCX1RmqMWKSaLJ4gBAMDztX0nLt/jWCTpBRUX?=
 =?us-ascii?Q?TYw58QXFfWA8YX24cUdd6YIictr2NSndqHMkAvbUcqY5uVeEN3tHUFETCCdz?=
 =?us-ascii?Q?12WGxPCSdbny/w0Be72K24BmLf9oCtdW38TgOOqCVki0nTHY5fF9J9AKyV/I?=
 =?us-ascii?Q?EPZJhsMDCheDaahpcxxxDhZLjMghlqVHLp3Wj4bAPO/8qSlYpRYXiywEkKCl?=
 =?us-ascii?Q?p3UyamxSxhPJJqiKo0DpKcxN6jZ5j4YLjjcHh124kog3qBjHLvF4Hf8AF1vF?=
 =?us-ascii?Q?inMw1HCZv+ro3uoSp28W87rVdoYdZ1Nvt8W0i+eaPJeQm8vWxW3zF0YEOOwR?=
 =?us-ascii?Q?qnMz7D5SY7TOj/ZO8KCK+EYwZ4Zv8JMRQ5XPCFyuL9vjdgnA7d7eRRwy6HzM?=
 =?us-ascii?Q?PMI98Rh2S86WfoWI0Ix6UBo8qisPiLWyIkV+72GOa+tLTuVeg1kBIqzHaRlG?=
 =?us-ascii?Q?pE4oLkxoywaH0ftGKWMcWkRqzVcplcjY44HPvoxampby6WgCdq7Ns4sBfnwK?=
 =?us-ascii?Q?YAR9/lz61vP66YRIzqDQXIltoBYTmhFmSHnEMlFrFGvYo+Dea1Rr+tVAsLJW?=
 =?us-ascii?Q?cw75C1CfDsn5Q94YlqpA9ZnQzvSHcRTQpLXEtS7zj2g6RF4UL07zUwc/zx+Y?=
 =?us-ascii?Q?ky8fNip2f8uIn37PIi4LZHlX5gbGR+LawPjX06OjJxc9W+o9+4zuBhS9aIKh?=
 =?us-ascii?Q?jpw6RbaaecXWp8Q2ff/vZHRpp2Yy/Q71DRLbQLdw2x9jd9ZqKeQtpftOxHH4?=
 =?us-ascii?Q?7VRYeQEAzMvJlT8USdMB9jYiW5IBCBCyFXP6VSX1YAx52MWBzwxDbAEMZ7YD?=
 =?us-ascii?Q?QnZ4CMIGt1ihfSqG887c7yGuca037BpeKnZTfv2ryvIzumbm07o6iBjLUjn9?=
 =?us-ascii?Q?664MfnXnATBQ2EuGMUDRcPLgd8vEOQzYLNkFGqQx89Q0LtFeGjszsa9+dneC?=
 =?us-ascii?Q?XOE+1jMwdcDcBtoiwFwIHEz+frAdSbg6Nc96nSfrOFQYLs32TvjuJ0vXJg4Q?=
 =?us-ascii?Q?itWTFfR1+2tZ5QHJ6ZvOfpn4Db/ic6B1HE5o3f3Cx17/yqa4RXDp5zUisYlJ?=
 =?us-ascii?Q?hV5AsMXXXf3lel9srpguYB3gX91gObJ2JjJRX8I2lMX3cB7wB+MypsVs7qq2?=
 =?us-ascii?Q?D/KVaUEt8mDH1dNTVfR8sKqGjjMikJBh3h/01VwKOMxX5FSmeJrLsJxdLmdQ?=
 =?us-ascii?Q?rO5lfIxJ6AgZnWHhEXctDnMerx3evXtg9Tw4oiu7bLsSuaSp2mIzcSlCQPa9?=
 =?us-ascii?Q?FtSHUsW3Z3WvPexlq2U5Bp24eWP5blcc1cgOeaiktIA53E24PDqYR5o9+Ujn?=
 =?us-ascii?Q?txIQoiMZcOcyud7zVMhgvBq1K7GW5Qh04N12GLPYArqsN4m9sRYBBcz3hQA0?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305d7dff-3276-4137-97ca-08dcbcbe949f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:50.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qU7q2IRN0av3scSwUL4XZn4L0QxrF+yNSBAMxj/StJU7fOT4ctnk5lsFi9lQYTpX6WE/uoRfJ6Bdl3+B0oioAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

Through code analysis, I realized that the ds->untag_bridge_pvid logic
is contradictory - see the newly added FIXME above the kernel-doc for
dsa_software_untag_vlan_unaware_bridge().

Moreover, for the Felix driver, I need something very similar, but which
is actually _not_ contradictory: untag the bridge PVID on RX, but for
VLAN-aware bridges. The existing logic does it for VLAN-unaware bridges.

Since I don't want to change the functionality of drivers which were
supposedly properly tested with the ds->untag_bridge_pvid flag, I have
introduced a new one: ds->untag_vlan_aware_bridge_pvid, and I have
refactored the DSA reception code into a common path for both flags.

TODO: both flags should be unified under a single ds->software_vlan_untag,
which users of both current flags should set. This is not something that
can be carried out right away. It needs very careful examination of all
drivers which make use of this functionality, since some of them
actually get this wrong in the first place.

For example, commit 9130c2d30c17 ("net: dsa: microchip: ksz8795: Use
software untagging on CPU port") uses this in a driver which has
ds->configure_vlan_while_not_filtering = true. The latter mechanism has
been known for many years to be broken by design:
https://lore.kernel.org/netdev/CABumfLzJmXDN_W-8Z=p9KyKUVi_HhS7o_poBkeKHS2BkAiyYpw@mail.gmail.com/
and we have the situation of 2 bugs canceling each other. There is no
private VLAN, and the port follows the PVID of the VLAN-unaware bridge.
So, it's kinda ok for that driver to use the ds->untag_bridge_pvid
mechanism, in a broken way.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/dsa.h |  16 +++---
 net/dsa/tag.c     |   5 +-
 net/dsa/tag.h     | 135 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 118 insertions(+), 38 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index b06f97ae3da1..d7a6c2930277 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -403,14 +403,18 @@ struct dsa_switch {
 	 */
 	u32			configure_vlan_while_not_filtering:1;
 
-	/* If the switch driver always programs the CPU port as egress tagged
-	 * despite the VLAN configuration indicating otherwise, then setting
-	 * @untag_bridge_pvid will force the DSA receive path to pop the
-	 * bridge's default_pvid VLAN tagged frames to offer a consistent
-	 * behavior between a vlan_filtering=0 and vlan_filtering=1 bridge
-	 * device.
+	/* Pop the default_pvid of VLAN-unaware bridge ports from tagged frames.
+	 * DEPRECATED: Do NOT set this field in new drivers. Instead look at
+	 * the dsa_software_vlan_untag() comments.
 	 */
 	u32			untag_bridge_pvid:1;
+	/* Pop the default_pvid of VLAN-aware bridge ports from tagged frames.
+	 * Useful if the switch cannot preserve the VLAN tag as seen on the
+	 * wire for user port ingress, and chooses to send all frames as
+	 * VLAN-tagged to the CPU, including those which were originally
+	 * untagged.
+	 */
+	u32			untag_vlan_aware_bridge_pvid:1;
 
 	/* Let DSA manage the FDB entries towards the
 	 * CPU, based on the software bridge database.
diff --git a/net/dsa/tag.c b/net/dsa/tag.c
index 6e402d49afd3..79ad105902d9 100644
--- a/net/dsa/tag.c
+++ b/net/dsa/tag.c
@@ -105,8 +105,9 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	p = netdev_priv(skb->dev);
 
-	if (unlikely(cpu_dp->ds->untag_bridge_pvid)) {
-		nskb = dsa_untag_bridge_pvid(skb);
+	if (unlikely(cpu_dp->ds->untag_bridge_pvid ||
+		     cpu_dp->ds->untag_vlan_aware_bridge_pvid)) {
+		nskb = dsa_software_vlan_untag(skb);
 		if (!nskb) {
 			kfree_skb(skb);
 			return 0;
diff --git a/net/dsa/tag.h b/net/dsa/tag.h
index f6b9c73718df..d5707870906b 100644
--- a/net/dsa/tag.h
+++ b/net/dsa/tag.h
@@ -44,46 +44,81 @@ static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
 	return NULL;
 }
 
-/* If under a bridge with vlan_filtering=0, make sure to send pvid-tagged
- * frames as untagged, since the bridge will not untag them.
+/**
+ * dsa_software_untag_vlan_aware_bridge: Software untagging for VLAN-aware bridge
+ * @skb: Pointer to received socket buffer (packet)
+ * @br: Pointer to bridge upper interface of ingress port
+ * @vid: Parsed VID from packet
+ *
+ * The bridge can process tagged packets. Software like STP/PTP may not. The
+ * bridge can also process untagged packets, to the same effect as if they were
+ * tagged with the PVID of the ingress port. So packets tagged with the PVID of
+ * the bridge port must be software-untagged, to support both use cases.
  */
-static inline struct sk_buff *dsa_untag_bridge_pvid(struct sk_buff *skb)
+static inline void dsa_software_untag_vlan_aware_bridge(struct sk_buff *skb,
+							struct net_device *br,
+							u16 vid)
 {
-	struct dsa_port *dp = dsa_user_to_port(skb->dev);
-	struct net_device *br = dsa_port_bridge_dev_get(dp);
-	struct net_device *dev = skb->dev;
-	struct net_device *upper_dev;
-	u16 vid, pvid, proto;
+	u16 pvid, proto;
 	int err;
 
-	if (!br || br_vlan_enabled(br))
-		return skb;
-
 	err = br_vlan_get_proto(br, &proto);
 	if (err)
-		return skb;
+		return;
 
-	/* Move VLAN tag from data to hwaccel */
-	if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
-		skb = skb_vlan_untag(skb);
-		if (!skb)
-			return NULL;
-	}
+	err = br_vlan_get_pvid_rcu(skb->dev, &pvid);
+	if (err)
+		return;
 
-	if (!skb_vlan_tag_present(skb))
-		return skb;
+	if (vid == pvid && skb->vlan_proto == htons(proto))
+		__vlan_hwaccel_clear_tag(skb);
+}
 
-	vid = skb_vlan_tag_get_id(skb);
+/**
+ * dsa_software_untag_vlan_unaware_bridge: Software untagging for VLAN-unaware bridge
+ * @skb: Pointer to received socket buffer (packet)
+ * @br: Pointer to bridge upper interface of ingress port
+ * @vid: Parsed VID from packet
+ *
+ * The bridge ignores all VLAN tags. Software like STP/PTP may not (it may run
+ * on the plain port, or on a VLAN upper interface). Maybe packets are coming
+ * to software as tagged with a driver-defined VID which is NOT equal to the
+ * PVID of the bridge port (since the bridge is VLAN-unaware, its configuration
+ * should NOT be committed to hardware). DSA needs a method for this private
+ * VID to be communicated by software to it, and if packets are tagged with it,
+ * software-untag them. Note: the private VID may be different per bridge, to
+ * support the FDB isolation use case.
+ *
+ * FIXME: this is currently implemented based on the broken assumption that
+ * the "private VID" used by the driver in VLAN-unaware mode is equal to the
+ * bridge PVID. It should not be, except for a coincidence; the bridge PVID is
+ * irrelevant to the data path in the VLAN-unaware mode. Thus, the VID that
+ * this function removes is wrong.
+ *
+ * All users of ds->untag_bridge_pvid should fix their drivers, if necessary,
+ * to make the two independent. Only then, if there still remains a need to
+ * strip the private VID from packets, then a new ds->ops->get_private_vid()
+ * API shall be introduced to communicate to DSA what this VID is, which needs
+ * to be stripped here.
+ */
+static inline void dsa_software_untag_vlan_unaware_bridge(struct sk_buff *skb,
+							  struct net_device *br,
+							  u16 vid)
+{
+	struct net_device *upper_dev;
+	u16 pvid, proto;
+	int err;
 
-	/* We already run under an RCU read-side critical section since
-	 * we are called from netif_receive_skb_list_internal().
-	 */
-	err = br_vlan_get_pvid_rcu(dev, &pvid);
+	err = br_vlan_get_proto(br, &proto);
 	if (err)
-		return skb;
+		return;
 
-	if (vid != pvid)
-		return skb;
+	err = br_vlan_get_pvid_rcu(skb->dev, &pvid);
+	if (err)
+		return;
+
+	if (vid != pvid || skb->vlan_proto != htons(proto))
+		return;
 
 	/* The sad part about attempting to untag from DSA is that we
 	 * don't know, unless we check, if the skb will end up in
@@ -95,10 +130,50 @@ static inline struct sk_buff *dsa_untag_bridge_pvid(struct sk_buff *skb)
 	 * definitely keep the tag, to make sure it keeps working.
 	 */
 	upper_dev = __vlan_find_dev_deep_rcu(br, htons(proto), vid);
-	if (upper_dev)
+	if (!upper_dev)
+		__vlan_hwaccel_clear_tag(skb);
+}
+
+/**
+ * dsa_software_vlan_untag: Software VLAN untagging in DSA receive path
+ * @skb: Pointer to socket buffer (packet)
+ *
+ * Receive path method for switches which cannot avoid tagging all packets
+ * towards the CPU port. Called when ds->untag_bridge_pvid (legacy) or
+ * ds->untag_vlan_aware_bridge_pvid is set to true.
+ *
+ * As a side effect of this method, any VLAN tag from the skb head is moved
+ * to hwaccel.
+ */
+static inline struct sk_buff *dsa_software_vlan_untag(struct sk_buff *skb)
+{
+	struct dsa_port *dp = dsa_user_to_port(skb->dev);
+	struct net_device *br = dsa_port_bridge_dev_get(dp);
+	u16 vid;
+
+	/* software untagging for standalone ports not yet necessary */
+	if (!br)
 		return skb;
 
-	__vlan_hwaccel_clear_tag(skb);
+	/* Move VLAN tag from data to hwaccel */
+	if (!skb_vlan_tag_present(skb)) {
+		skb = skb_vlan_untag(skb);
+		if (!skb)
+			return NULL;
+	}
+
+	if (!skb_vlan_tag_present(skb))
+		return skb;
+
+	vid = skb_vlan_tag_get_id(skb);
+
+	if (br_vlan_enabled(br)) {
+		if (dp->ds->untag_vlan_aware_bridge_pvid)
+			dsa_software_untag_vlan_aware_bridge(skb, br, vid);
+	} else {
+		if (dp->ds->untag_bridge_pvid)
+			dsa_software_untag_vlan_unaware_bridge(skb, br, vid);
+	}
 
 	return skb;
 }
-- 
2.34.1


