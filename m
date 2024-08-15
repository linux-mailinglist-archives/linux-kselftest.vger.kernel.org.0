Return-Path: <linux-kselftest+bounces-15366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C69526A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8C11C21F6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853842ABD;
	Thu, 15 Aug 2024 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQOTC5CC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64C320E;
	Thu, 15 Aug 2024 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680595; cv=fail; b=i+BtOtV3WQGwHExqOP0NJQg7AifKVhR+/ijaFvIGj70J+IvQXddGNQBsYY5JsL/abbL7TvPRG6TNekZliV4xUNtQubYYNV6vRRK7kU2paNSk6u7Cz8i5UV7DRDXOQMtC9O3B9VuckZIH2FZqK4898GupVx+3GxPjcuI/lR/dVnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680595; c=relaxed/simple;
	bh=ewTTNPXhP4CLWiFHYHaRPM30X/YLC16EVHzDGVYAAsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3xc49qzlZvRUKYgEwKgwvIjuAEOtqBWpJakBy/+HU7B2KlWFQGdXyp03CnfOqNByPqbh2UyWfolHKleViQb0WIpTvP3NArK8WRKoqMaPi90CVJX8lEsgOu0+K16GxDOgOoSTaG85R4ATyh+M60rRZtpayi7JNHvjOnrR888IcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cQOTC5CC; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWUv8sumFq8ykULEHHos75QLOYGFJ0Di0YXyLSxcBNngjXsYZje8qi8Ie6utXQfS6S50IgZgzGnhAmlgDqXB5Pbut3AVCMrKMAzWLx80qPS6YlR6BU7KfnL3h1G3uaF308itvz7NZORmqJw8wHGajMHzhL/U7Uv2Vmw2aMHTfVf0FUGyOFTPh3xYmntBNWfvlVyUB37RgW5fux1I/ZA0XutI83OofeAbvBuE84pfUq2/S5MfIrAPgvTg+SBWPS1aXasjy66vp16XsebyTWYmZhTg1wHaejmDygpvvJCEd3m1xIwB43VncR3/MOT/adDI8qLcDt2mIdqY5farIZIPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK93u+FqJVMNrJ0tPhYKi5rVGTAXodfmHm59ntPUjhk=;
 b=ZkljvCTjn/Sk1w6LrQpWwaDuI+FMOPpaplZKVjm2132fFsuG9OHuW6UTJ/GRMSbBUOf5jY5IoVdBeftjL1+hDl+fJeeDslFvDTVsmnjz0WLUofQ0DNDSq9Pmb+cJ6zcrg7YML4qfCk9/QguPOnptWB1p2h0KoRsH5RFhLJ+uuuijK6PBbmJkSgRwS1Ip00NEHjm7D7cqmnRBPLcHvj8fEW7hUaKcGy40eJwGt/jhclHbhJFj2N4fOlh1zOSvse4rifJLWJMgTrSKlCsDk40myJk37b6jtn2cga+iCFAmsmnRv2BE2tSWwNAZSFFdkr9St60a+q2SXIvlcw+o3BSfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK93u+FqJVMNrJ0tPhYKi5rVGTAXodfmHm59ntPUjhk=;
 b=cQOTC5CC5pQ13FZBGwiXfLcuGFMzp0B/+/fyaPkQ3XBn+ryaLad0liywYBHHBtzhe4L+vlB2pBamixfvw8+IB4yLxjhDWK2lwNM96jZRtlZGDyP3XavyN2DzLgyERx7+9fPsJJc0Jk3rhEV7pDVZGL4DZH93chPhH5+2ew5bGTnxtOdo7VrsEU+LcGjACOIZlI70g5AG9XN3Uat6LjHKxS6CMApcARQRGaodTH5Fb6KstPT58iEtS/bNmunib715c3t6O+NPgK+suTVWvJ+LIu4Aq8AkynEZR0k+aMWTe4oUht37JLwwIR04Czhi3C3q4E15b28rtD2gwZ8MtyADSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:48 +0000
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
Subject: [PATCH net 11/14] net: mscc: ocelot: serialize access to the injection/extraction groups
Date: Thu, 15 Aug 2024 03:07:04 +0300
Message-Id: <20240815000707.2006121-12-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6bf4ae45-641e-43c8-a811-08dcbcbe935b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H48UvkrxxOcuS1wXQvBO1gVnhYxRbFgk/Cb/2K/9QLyCOxDkmNyhV+aPhZYB?=
 =?us-ascii?Q?ZmRKa/aj/IaL4jeUoaN7qe4APXF2nFsLaHtr3VOk/W7ELEuoWyCd3/ckdn+z?=
 =?us-ascii?Q?kKDN3sjFSLFRAbXtz7+GurhFsWk/Kg0tQ7nrStSeZoEADHpN0/dEemiE27Si?=
 =?us-ascii?Q?LXIE9z5wuFvBmQq2+/tQ7Mu+jdUcCfTYfNARRBPGML/I81n10RBgNxHIopGl?=
 =?us-ascii?Q?VpP+C0Ry9Rr+gzPd9+ZTnRMVqu6gy3cMEuTU6+p6tzVOlw2rR8hTlhFJTBUY?=
 =?us-ascii?Q?BW/MufBoHHL7GC9hskNme12jlYMsxxZRUyeRH7tP686ULwqFI8whKqerbGOU?=
 =?us-ascii?Q?HzRY2Yvu64pLXHhVPcmvzsuIFAaQyoHrwWMMxGaIw5FPJgX1XmrqcR8v3ftA?=
 =?us-ascii?Q?CXWWRKjMe/EFb3jSmCU2W5MjvnWz8X5YMNbnJiUfG9Xq4kFmYRmab/CGP7cV?=
 =?us-ascii?Q?hroI8MoKcMVTN5RiD7Z1OuyVg6WmWn+Wb1Qy6dW/BOLg7/65AEqqvHEnjllj?=
 =?us-ascii?Q?DiinPww9b5DMXGWhpliF6Yz5wmIzunvpwcdTGLOpVLSXc7nvwfGzhtp3XL3k?=
 =?us-ascii?Q?AJyBuf/Ihcw1Orojk+2MfjnrNYAssawUHoEp7Ew8Xo5Lw5lWtUQS/Y7pvRlo?=
 =?us-ascii?Q?UmFtiuUyqbd9V5TVoFuJh7N6L7kNdZHmPuv27YbtNEr5sAQCU9sMkDlzaZqO?=
 =?us-ascii?Q?okQlXhEYKyH0M1940jF/LAem6EVcm8bsYWIk3qK51h4E5NifDU4jgUFbSVeB?=
 =?us-ascii?Q?yySofykQc+PB05Ol6tSzr21J7GRF9xE5MybQnM3+n0JUJHys/5IOrNK3x2cY?=
 =?us-ascii?Q?4bAWFlMCRNyxUcyPJy7CVlDx61GPSTGtSxQKEZzjuty5RGtsEWVHVpb54q0g?=
 =?us-ascii?Q?b9/DPeCYKEux4bD1ElKAMxqZTD1BsCURlxkx97gQ0v3LKFp2OK/uyENWkaa0?=
 =?us-ascii?Q?Il2bNqhpD+V8rCoUdPSd9y/xuiALAIfCeu9aLfvBefWNzpkKcayhQUhgJ5ar?=
 =?us-ascii?Q?RJS5MN1/lYrf5izLCpYhLyAA06/xDS9h7H673gHTrEGQqj16Qw700towqSoW?=
 =?us-ascii?Q?tx053NRf0w3XPCBUN+RrTeRDYNJws0dDRjEGZ/tkbP5YwQeGjEEaoaAlpxDs?=
 =?us-ascii?Q?HJ8Z7WgaKwFEyKC0Yzat/cL59TC3Zn4+wdOFkyJmuUX1daYdAEAiceb5Yk3E?=
 =?us-ascii?Q?rgDmAzoB65YRPIUSPjRuFyFCITUFnjVHhgFxZe2D3Q3UnbcLCeNlTe5OjrAG?=
 =?us-ascii?Q?qnAKmwTFa7w9wMPzXzPQ3eGIScCiyIW4xmBBSd66VsVTOCYrvh8clpP5GZHA?=
 =?us-ascii?Q?lzP5oy3B1RhiGo51KsXbm/YPSWu7q1DpAhWoMCVv8KVHfD/ABxKaGepCi3B2?=
 =?us-ascii?Q?RQNnfWWGaQxTsUm59B+eK5Jf7wNU/BrQT/ZYNBOlCa/710EpTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wHeIikE2DR/aBCyo5SOwIF8AgUIWw6VqNqmkV+bGUXNE/p5MaqdjpBnuM4K5?=
 =?us-ascii?Q?hfryNM0pnaDGKazzSuIGsHSXPvcspnDBTDSDlVeiY+jQrwvMEXgGwuHP7tLr?=
 =?us-ascii?Q?YrmpAC356PQRMU4rKsxkzdHQDw9zilgX8fD4kPNrVoJ6Erv9k45eU1xel5LH?=
 =?us-ascii?Q?Vs+P9FzX5dMPNrNFA6fdNJlHPxPKdMt4boYKkWzuRyA8Y6WCoSrG5HZBF+5y?=
 =?us-ascii?Q?KhsWeqZWOIdh0eAyriyfOrizFa/agw3ddC6oHo9TWPsMevrCYkrVwA5zqqX4?=
 =?us-ascii?Q?cOB61eTOpLKlq/GN73cjvugZodsSzi5FLEICsZRVI+UMqe8RCFDy2o84oKLi?=
 =?us-ascii?Q?H5lOj+3fWPFnHwsgiukfj+hsEqq/LlT1WzJGEZEtDWfEMo8j2tCKCeo0QWvy?=
 =?us-ascii?Q?G+73xBVuSyHIrHkg6NYQpX2M6oEqEsHIql/FgEIXXOh/Sh6gHqvqk3JKtiMs?=
 =?us-ascii?Q?7DK0l88yFs9qaCmWzYBhoCvHXMd5m950sHgTTxUi7bV5HBfgtrHQPbAzqeN1?=
 =?us-ascii?Q?ZywKLUdGxSN6Vsa68gTDBvjErR57wRmsJpFB4PB4rrcMy30kStU6GW5cWmFZ?=
 =?us-ascii?Q?RPVONeb3ptYOFwAC2V5B+GDA0jVNLGtgPpTfmpwRWZP7S+yd4CuTllpTuije?=
 =?us-ascii?Q?1M2RJC6Vykvm0u80ItNw3kgaH9NwTJzSOKZd+k6+3fJwJV+HdZdNGIstDx/V?=
 =?us-ascii?Q?9qh1EzhWYb8NRx22/JEDlmCcp1ZmkJzMFVHG4m5Dj+Fuc+8ArbJJyiNlmZEh?=
 =?us-ascii?Q?SMpH3QB176iVV7GJKv9UkwilLwhl0nUd3iiOiLM9tHnL2PLpjKeJz6YU3wkF?=
 =?us-ascii?Q?rXDQYAubXDgxgRszEDlSxd4vd7tKLcpZqqCjmG4eX0yvk1oDWzEsbRdvdYoB?=
 =?us-ascii?Q?85Y5VWw3QhtgIsmVsbHCSQtScrvIApvF9DinXHy0vaKjAPmd+xPn/9J0r8sr?=
 =?us-ascii?Q?ygd2/5s/NUSKqK0HUN6PjWUbVALZM0iRmj/MLk98kYFDQHSp9vzu6A0hMATt?=
 =?us-ascii?Q?sVd7ahuS57yrbt1HGEtU82xLIWxcW0vgSuC63KguhRgHrfGkVM/FFtKscvrn?=
 =?us-ascii?Q?xO+yde6F9h4a1G9d21RknIgD5V90drGgVRpE0PpPewEU31rax/Tj0aUYcaqC?=
 =?us-ascii?Q?f/V+BQ/JXsJeJfjBKBlawOvA+kJRk+XSJMlxgNExHWEVjBd5o05Hmasit5hW?=
 =?us-ascii?Q?pHqLiGNawNtYo0E8EXsZiEcjWuhaTB7T5mF5Fewpv64n2Y/icPkjssTzJJwJ?=
 =?us-ascii?Q?83TXIy3ZojDNq86v+xjytQ4BQYfkPILtyakmbKAp9T8z7727n4Bu2b9bJHc5?=
 =?us-ascii?Q?zr9Q4bg9PcjWOCyteueFWlUwarNC2OrnXgg5E08aRbj/HhzzU0ZPWjbANmWr?=
 =?us-ascii?Q?AH7ZNkGyynbFGS/xO9U6pZ8952I/YjEueEhofGUfy2P08MrTQ6Fz14m6sqrw?=
 =?us-ascii?Q?WNLw5VAM0BKnb/RNTpMK3xjZz4dNCxsE7SA4GF8m3zfLbYB+yO1obcQl/Wty?=
 =?us-ascii?Q?eZheiA7mXe1Yq/Ks2w6QXv8OMGhTd4ZL2lM+eNqGvaVR447Sfm58aIJzJ5uI?=
 =?us-ascii?Q?HZHShty0zQdYbDSq8g32CXbRutRsFELntQqYFBFBb7reklEEBa6O+nC5TmOF?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf4ae45-641e-43c8-a811-08dcbcbe935b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:48.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hyz377l1QhJwG/DImikFEugFugPZMPCnQ5s4bo17hErAmlEfhnhvGMgknfj9IYI3mCNicArX3seoVesBUkQHyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

As explained by Horatiu Vultur in commit 603ead96582d ("net: sparx5: Add
spinlock for frame transmission from CPU") which is for a similar
hardware design, multiple CPUs can simultaneously perform injection
or extraction. There are only 2 register groups for injection and 2
for extraction, and the driver only uses one of each. So we'd better
serialize access using spin locks, otherwise frame corruption is
possible.

Note that unlike in sparx5, FDMA in ocelot does not have this issue
because struct ocelot_fdma_tx_ring already contains an xmit_lock.

I guess this is mostly a problem for NXP LS1028A, as that is dual core.
I don't think VSC7514 is. So I'm blaming the commit where LS1028A (aka
the felix DSA driver) started using register-based packet injection and
extraction.

Fixes: 0a6f17c6ae21 ("net: dsa: tag_ocelot_8021q: add support for PTP timestamping")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c             | 11 +++++
 drivers/net/ethernet/mscc/ocelot.c         | 52 ++++++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot_vsc7514.c |  4 ++
 include/soc/mscc/ocelot.h                  |  9 ++++
 4 files changed, 76 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index e554699f06d4..8d31ff18c5c7 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -528,7 +528,9 @@ static int felix_tag_8021q_setup(struct dsa_switch *ds)
 	 * so we need to be careful that there are no extra frames to be
 	 * dequeued over MMIO, since we would never know to discard them.
 	 */
+	ocelot_lock_xtr_grp_bh(ocelot, 0);
 	ocelot_drain_cpu_queue(ocelot, 0);
+	ocelot_unlock_xtr_grp_bh(ocelot, 0);
 
 	return 0;
 }
@@ -1518,6 +1520,8 @@ static void felix_port_deferred_xmit(struct kthread_work *work)
 	int port = xmit_work->dp->index;
 	int retries = 10;
 
+	ocelot_lock_inj_grp(ocelot, 0);
+
 	do {
 		if (ocelot_can_inject(ocelot, 0))
 			break;
@@ -1526,6 +1530,7 @@ static void felix_port_deferred_xmit(struct kthread_work *work)
 	} while (--retries);
 
 	if (!retries) {
+		ocelot_unlock_inj_grp(ocelot, 0);
 		dev_err(ocelot->dev, "port %d failed to inject skb\n",
 			port);
 		ocelot_port_purge_txtstamp_skb(ocelot, port, skb);
@@ -1535,6 +1540,8 @@ static void felix_port_deferred_xmit(struct kthread_work *work)
 
 	ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
 
+	ocelot_unlock_inj_grp(ocelot, 0);
+
 	consume_skb(skb);
 	kfree(xmit_work);
 }
@@ -1694,6 +1701,8 @@ static bool felix_check_xtr_pkt(struct ocelot *ocelot)
 	if (!felix->info->quirk_no_xtr_irq)
 		return false;
 
+	ocelot_lock_xtr_grp(ocelot, grp);
+
 	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {
 		struct sk_buff *skb;
 		unsigned int type;
@@ -1730,6 +1739,8 @@ static bool felix_check_xtr_pkt(struct ocelot *ocelot)
 		ocelot_drain_cpu_queue(ocelot, 0);
 	}
 
+	ocelot_unlock_xtr_grp(ocelot, grp);
+
 	return true;
 }
 
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 9301716e21d5..f4e027a6fe95 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1099,6 +1099,48 @@ void ocelot_ptp_rx_timestamp(struct ocelot *ocelot, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(ocelot_ptp_rx_timestamp);
 
+void ocelot_lock_inj_grp(struct ocelot *ocelot, int grp)
+			 __acquires(&ocelot->inj_lock)
+{
+	spin_lock(&ocelot->inj_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_lock_inj_grp);
+
+void ocelot_unlock_inj_grp(struct ocelot *ocelot, int grp)
+			   __releases(&ocelot->inj_lock)
+{
+	spin_unlock(&ocelot->inj_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_unlock_inj_grp);
+
+void ocelot_lock_xtr_grp(struct ocelot *ocelot, int grp)
+			 __acquires(&ocelot->inj_lock)
+{
+	spin_lock(&ocelot->inj_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_lock_xtr_grp);
+
+void ocelot_unlock_xtr_grp(struct ocelot *ocelot, int grp)
+			   __releases(&ocelot->inj_lock)
+{
+	spin_unlock(&ocelot->inj_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_unlock_xtr_grp);
+
+void ocelot_lock_xtr_grp_bh(struct ocelot *ocelot, int grp)
+			    __acquires(&ocelot->xtr_lock)
+{
+	spin_lock_bh(&ocelot->xtr_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_lock_xtr_grp_bh);
+
+void ocelot_unlock_xtr_grp_bh(struct ocelot *ocelot, int grp)
+			      __releases(&ocelot->xtr_lock)
+{
+	spin_unlock_bh(&ocelot->xtr_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_unlock_xtr_grp_bh);
+
 int ocelot_xtr_poll_frame(struct ocelot *ocelot, int grp, struct sk_buff **nskb)
 {
 	u64 timestamp, src_port, len;
@@ -1109,6 +1151,8 @@ int ocelot_xtr_poll_frame(struct ocelot *ocelot, int grp, struct sk_buff **nskb)
 	u32 val, *buf;
 	int err;
 
+	lockdep_assert_held(&ocelot->xtr_lock);
+
 	err = ocelot_xtr_poll_xfh(ocelot, grp, xfh);
 	if (err)
 		return err;
@@ -1184,6 +1228,8 @@ bool ocelot_can_inject(struct ocelot *ocelot, int grp)
 {
 	u32 val = ocelot_read(ocelot, QS_INJ_STATUS);
 
+	lockdep_assert_held(&ocelot->inj_lock);
+
 	if (!(val & QS_INJ_STATUS_FIFO_RDY(BIT(grp))))
 		return false;
 	if (val & QS_INJ_STATUS_WMARK_REACHED(BIT(grp)))
@@ -1236,6 +1282,8 @@ void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 	u32 ifh[OCELOT_TAG_LEN / 4];
 	unsigned int i, count, last;
 
+	lockdep_assert_held(&ocelot->inj_lock);
+
 	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
 			 QS_INJ_CTRL_SOF, QS_INJ_CTRL, grp);
 
@@ -1272,6 +1320,8 @@ EXPORT_SYMBOL(ocelot_port_inject_frame);
 
 void ocelot_drain_cpu_queue(struct ocelot *ocelot, int grp)
 {
+	lockdep_assert_held(&ocelot->xtr_lock);
+
 	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp))
 		ocelot_read_rix(ocelot, QS_XTR_RD, grp);
 }
@@ -2954,6 +3004,8 @@ int ocelot_init(struct ocelot *ocelot)
 	mutex_init(&ocelot->fwd_domain_lock);
 	spin_lock_init(&ocelot->ptp_clock_lock);
 	spin_lock_init(&ocelot->ts_id_lock);
+	spin_lock_init(&ocelot->inj_lock);
+	spin_lock_init(&ocelot->xtr_lock);
 
 	ocelot->owq = alloc_ordered_workqueue("ocelot-owq", 0);
 	if (!ocelot->owq)
diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
index 993212c3a7da..c09dd2e3343c 100644
--- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
+++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
@@ -51,6 +51,8 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 	struct ocelot *ocelot = arg;
 	int grp = 0, err;
 
+	ocelot_lock_xtr_grp(ocelot, grp);
+
 	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {
 		struct sk_buff *skb;
 
@@ -69,6 +71,8 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 	if (err < 0)
 		ocelot_drain_cpu_queue(ocelot, 0);
 
+	ocelot_unlock_xtr_grp(ocelot, grp);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index ed18e6bafc8d..462c653e1017 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -813,6 +813,9 @@ struct ocelot {
 	const u32 *const		*map;
 	struct list_head		stats_regions;
 
+	spinlock_t			inj_lock;
+	spinlock_t			xtr_lock;
+
 	u32				pool_size[OCELOT_SB_NUM][OCELOT_SB_POOL_NUM];
 	int				packet_buffer_size;
 	int				num_frame_refs;
@@ -966,6 +969,12 @@ void __ocelot_target_write_ix(struct ocelot *ocelot, enum ocelot_target target,
 			      u32 val, u32 reg, u32 offset);
 
 /* Packet I/O */
+void ocelot_lock_inj_grp(struct ocelot *ocelot, int grp);
+void ocelot_unlock_inj_grp(struct ocelot *ocelot, int grp);
+void ocelot_lock_xtr_grp(struct ocelot *ocelot, int grp);
+void ocelot_unlock_xtr_grp(struct ocelot *ocelot, int grp);
+void ocelot_lock_xtr_grp_bh(struct ocelot *ocelot, int grp);
+void ocelot_unlock_xtr_grp_bh(struct ocelot *ocelot, int grp);
 bool ocelot_can_inject(struct ocelot *ocelot, int grp);
 void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 			      u32 rew_op, struct sk_buff *skb);
-- 
2.34.1


