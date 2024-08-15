Return-Path: <linux-kselftest+bounces-15363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB23D952699
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F096F1C21D14
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B0433062;
	Thu, 15 Aug 2024 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fi9a2ONr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21082A8D0;
	Thu, 15 Aug 2024 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680587; cv=fail; b=I5j4llP5PS9dfWjJopxO+y1D1Oty9FYpNb/8zmthENtt7j8WZ0ALoqxKkea0ektyGY1ePXFyUYJlA77o1Brk+ikb4XjuWzJD8Gp759vWixfWjYwSnfUi/Z3kCkvfBax++uVilfRBO70A+ZdvZKGEbM/XJCJlZk6d1V3TC7E+xfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680587; c=relaxed/simple;
	bh=JIR1sy0F9vmqeNRwxSxMS4lJhnehJ7t+hZFm/3Tv3pE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIL4YMOnuX1qOE68MSx+GYeRWyAXb8Ew1ioFHS04SS+Dkjyn/zWC+W12F5XZ0qDdUQZWf5FPw1dzQpBWSbctB6Ft9HCYVQhJX/+oMsFA+5IgBeCrX0yfiQmxwgxQyx9w9mugxIsWFETIYxwsuxpoPtwT8rdr/NtG+sRJf17VLBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fi9a2ONr; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSlOFE7MvigPVHq8QDkc5Xerk7CDtZALoP7pV9dVHa3jEb1wSSmqlON+R7B5pBCWi/8HkhZVu70gOh86fj9vSpGDEh5yhpK72/YNlTDd+mt8LTZ/nu/7+orvvkgCBDMpuaDvXCjBrPScah71fp30oTqwXqx53wxZV7OtuYqXH5/wYvd0jpm6U6vOSfVCwFpEjLYU029nT2X9LcBhE2hxfZoEE7SJzJfqJj4DsJpon22ZVMOcU6twfSH7qFj8avU9QAaFrmDKXou/KsfPJATx162Bfv8BFfDETKcWnb0MhlAaHNK38cv7JS4+oChkIcmKR74KcBH9bV1t79O0g753nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s1MqFRA2krXeubenVd6D9DjZBf1ABW8Qi6HceVxlU0=;
 b=dIeXKweSSw8E8b6ykV/cbzZ5FarC+5UCy08ZJo9tbyMwKl52Ph5DSu9PHsumYZ17ZvW9/TBJmsbn47oK8UXQHZfdQ7eAEQhNVcvF2j7otxU55TPNiJa6EmLwrZwdZwXSl3nhC7PbK/TH0bxxm1brHNlv5dtawa76KHwo/1ivUzjl8XdoXbJp4BWwoC6CcyNq0EnBqodbFfPckUDZRSvXQU71CVpzLNcbuvP6xmAgizgAKc/pGZhTb7LlehKo3ZGerhLIRWtiZVjFvP+tZHIk5JEuroY2UL1qji3EJ7arUEJ/q29Hv/o7Z/GdCVimhnbmIQxT0V/EXfFiySUM8OEsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s1MqFRA2krXeubenVd6D9DjZBf1ABW8Qi6HceVxlU0=;
 b=fi9a2ONrTSzFGztqx/MmDuk09ziThg7XOQGbhYsy5NbkC5sD4t4VsD+2yT9FDu+qRmZXV12twWd0JsYkJv/HE8mZNGV6Hu+dUe4q2BDR+Q2+XcUuNjhR2xKZHiQzytH7BroaeEIduHXqQdNnXvhGpGMZ+bKdMuYnVu0xYdgxprhhWMZVNp3mJDSiwGgL7E6ClaCERYr2I4gNd/on1wfwNsWjFIax05EVS1vN036G4LCwArCDKUhBz/888Ac5vf/2eNiXmg44wzDTCdoaE6JmsCjJeDxW1qbKUUdW+5ohJVLrm8yE01TMFA2fDT6CFtBXdL2NUsC5B6eReg3jPZLgsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:40 +0000
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
Subject: [PATCH net 08/14] selftests: net: bridge_vlan_aware: test that other TPIDs are seen as untagged
Date: Thu, 15 Aug 2024 03:07:01 +0300
Message-Id: <20240815000707.2006121-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99452f56-0b8c-421b-31e1-08dcbcbe8eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZH8SX+C3GJ0oaQvuIE4dqBVunzayEW8Rem6RI8wKddoqpfIjWIaHt2FuXEs?=
 =?us-ascii?Q?gk8GU1vn40Qy9LsJtoSWIEiKylhknI+YvBWC2tDHRjL4vwm7OT86ZwyAylfl?=
 =?us-ascii?Q?Dk0rqimIWjWtAVcoUOT0QHDvHfp0hh84LpiyK14qU7/QT11o/kvckJ+8nZXK?=
 =?us-ascii?Q?pIADkruXfrccjQa/E0qFS+C5kDgLKmuwWlZHqUnP1Icn2grNakHfdCSx/+02?=
 =?us-ascii?Q?E1L85BGoJKS/HA7PkmLXrBg9p+A1XsDLg8P9b1vnFQiz8RFN1dZot+odbFWh?=
 =?us-ascii?Q?QqBnRHWMKiXGsQC8rp5JcGuCvBfWgFDBkzfQ9q54pTZWzsyshxAM1JXiP3SE?=
 =?us-ascii?Q?tXcwwD8Meb5jrYkj50wCphbzKpyB3QxP0s0RLUtAXKNwcKoohyLgGZu2wA/2?=
 =?us-ascii?Q?3OfquIAo2ehFVpdVQBPdskdTMo8cMFodUJ3kibex/2Ab+4AmB59APKkHo/4V?=
 =?us-ascii?Q?hFS9FgiIqLEHJ/MUhxLC9jox+nNVb6T3qoDTGuGLRAYGUAf+DdIvLZpTWw46?=
 =?us-ascii?Q?tLeNxyrQJOHO4272M04+y2br1O7QDHNAxuxcB8KJu8W8TGMAaNU6FPvXxnZn?=
 =?us-ascii?Q?F+QNBm6Mfsnb/Beu6wgsHF+fdNldPBN+Rbox8AH4fpl/REQbEFndwLIZYSDr?=
 =?us-ascii?Q?G2oAvGtSsPhDFmP+p3x/PlNLHvtRYlrd27hYWSXMX2Y6GQoMMkEH8hegB4XE?=
 =?us-ascii?Q?4xSJ7BkOgxpGCP/wJw4UwMaUUiBCTxxjALhk3eWV1YY2NTEjFi6fbZ3QNNfJ?=
 =?us-ascii?Q?cLnLHURD7cBBe1GxNRBotU1YpjV+laPYty6mRsqYHcPduQ280xh696oCfGP3?=
 =?us-ascii?Q?dMnHaaDhZWSEM6JmCS4OT93IDR96NAB3GUqBdpcMPBQGu8z5bscwypVt/zGf?=
 =?us-ascii?Q?2j/hY33XojRxFEF2XVSod7e0w4Cz9LE3QZ5wSMQYl98t4+yRRxZDbXaqyTdo?=
 =?us-ascii?Q?rT/PM1r1T/gpBiR0wOhG6Z4vdj/kHOhYx7kV3nL4Bp5PQM5kBsImYO1p7Pag?=
 =?us-ascii?Q?Ycn7EqEahAyLQMKImNcWIg7xn4vNIu7qwogfXmq5FNGTh/6P2eqP+So2oKBm?=
 =?us-ascii?Q?QaWSVoTdwnak6Jd+WrPiEgcAPygyQKI+15bh/FBD18WCT63cN416WtxdfB2H?=
 =?us-ascii?Q?RJHb16hEqAg+iUrLlaUIgxbQHWEJ6rgIC97Qi8+LwWROPsq9Hjj40DwLrivd?=
 =?us-ascii?Q?uOVOLqLkHv7O4Do3eoXPeEFm3X/8xcKi+LrzoMLg/Fa6ye1yThB9vfZ/rmEj?=
 =?us-ascii?Q?Fuq/6kuuX9FGBwXjy5u26JHICH+yTtJUtWTOPu4jgbuIXa6sPXcZjF16lpH9?=
 =?us-ascii?Q?nWNGj7EZMMFGNdztY7Uw1h5fGFv1Erxv2W18rYrXtJNbZZ015Pf7SFKoijT2?=
 =?us-ascii?Q?pektm9EtGi4atc0aPfJER7pTzFNOJ8c1PAm4WW5+0Tk/4LCeyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?br84RqIQE1xXahFsAxjDJ8b8XwDbouyXeNqFzScgLpSteRpZrlzX4aG2lbv1?=
 =?us-ascii?Q?LMTif1v1M3LSSsUqebJ6KKxE4Nx3hzgeAIFnnh/S6O/Xv9JzZHEIahqpBqPg?=
 =?us-ascii?Q?6hoUKsB3jXeaJ6PwsHg7E9XRg8Rh2Dd4ySOlpDSXnZ4a+9UAuQJRuAdbhBW6?=
 =?us-ascii?Q?7YHQ7W+9S2vQE2AFLDTOazJArx8bxBnYXOgmQ9zwc6XvfIaO96DaGy1wCbnV?=
 =?us-ascii?Q?8iK3ot12afOptbvSgDlOdLyZPauNdQaerSjEsAOA/ac3tMfLHD0z5izxYUff?=
 =?us-ascii?Q?DGolDGSCkT920hXGxl9mWW8FMuHcMigluJafZNPyNAFbLcIyDC8FfDfMLMcq?=
 =?us-ascii?Q?cCiklavnN6m6RKGsFlxBzmOe7+JI9k6LoseIslGaiXfYEndhdN+6JYx5muyh?=
 =?us-ascii?Q?7xxX/nCVCi1t7WWCTJv2RPi1mPBYu/74KPxPlxPzLEvLm5MAgAG2gBIBuqRT?=
 =?us-ascii?Q?cJ38Qtzqq4uOGFTWoX22N5ilHnWwaTuMu6I77yxGlfaFYiMhhm6n2Bx4+PGH?=
 =?us-ascii?Q?9izFMqhN70NZMJtAOp23gT5evh65W8KFsmPkOTYMPylcaUXdCQL57ZLIQ9lt?=
 =?us-ascii?Q?6ETzHBgUwmqWJ6tfpSQ2G0vq8DMbfop/jkLdvtuUyerZUpZDky2U87Gy3+PY?=
 =?us-ascii?Q?bm5Y/14sw2Pwv9Qw6pfZt2Z38oomcHSKFvqu7YKVCfFObhJGvVfeT/RaTSir?=
 =?us-ascii?Q?I9S6dYQmORlzZuk9++pwVNdtqM0U9pojM1LM+uXeAGt43CbqHcWU+cncuBUL?=
 =?us-ascii?Q?vl3YGfdkigQzlBN/r/eTgYsUH0f7ygs/ZlHnEJvkPBZ9gLll2ahrINuDcN1i?=
 =?us-ascii?Q?aNF8hjWTxzsdz3fZOnUs0JJGR6Ra9tzYcv4MDmQmsvJ+FG2yIjuF8U+O1IvY?=
 =?us-ascii?Q?4+70ikGg9RPQStPDYEbM5DAsa9gwEorVUaHfV/oEogxJ7hxdP/Fe/70H7Q74?=
 =?us-ascii?Q?Ni2BFJV2nvvTrppoaYXsWIw6IlXbx0K0WlceH1cFxX+H4JRWBCMxrVSq106e?=
 =?us-ascii?Q?myAZvm1CVxd7YOgKhL1yvas03hlZVMr9w+YWlnjy+oBNwzQYsnUudjv5gM9v?=
 =?us-ascii?Q?d2h5Yi7WMMC1mjvMlrRmr5YUbVkASItyiFbu92AoW4ku6coQ7+Kj8TTyCDBI?=
 =?us-ascii?Q?GQE7zg7B7v0bq1QRFyVpp4YKBuhSFk68uG1k7xrrtGSr3tEvU8ag9ph5b0+6?=
 =?us-ascii?Q?cZ1WvYUpVn3MxyqO+42eaKQgf87F1R7iwEBTt8PLK+ibru+uBojR/GmS+DwY?=
 =?us-ascii?Q?Q59ALFo4/w0yPzmjwQF0DmkMm2hsqeCLhBe2nDzqz7xe9YanXIQcLW4lvJ66?=
 =?us-ascii?Q?1V91QG6F0qpeR7iNlgrvS4APUTI4KPCBbasTuO6aX9nNal5XhmdIR6NDGoPX?=
 =?us-ascii?Q?DFx/XNWnQ9sLXPjJKnlWDYQ4Ukiyy981Ld8PupCQ8NcRVl1YhLWCQ7bnATGj?=
 =?us-ascii?Q?88HEdRqJBWw7PN4NNzAYpzObDRrPm75cYEHt+X1a48di5MHmywHl5TqfJpgB?=
 =?us-ascii?Q?bfbjid7/h4CzdXfR3yMPL1HrT1nxYDxV9aekrDqsuAa2nWDr3MYDN50a1wsf?=
 =?us-ascii?Q?iO4ppQBf0asmpZq82HtX/NdnR8xx5Bz4YecHWxJtYbTTfFoU0tN4lPl7x28R?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99452f56-0b8c-421b-31e1-08dcbcbe8eac
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:40.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iwRuSABkLKaDL7UG5KlR4mUJhggQszBG4GbRit59EWtNG7KBHlstQJ5D5YlCLW9Cgx9biUitDSQt/no1RD6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

The bridge VLAN implementation w.r.t. VLAN protocol is described in
merge commit 1a0b20b25732 ("Merge branch 'bridge-next'"). We are only
sensitive to those VLAN tags whose TPID is equal to the bridge's
vlan_protocol. Thus, an 802.1ad VLAN should be treated as 802.1Q-untagged.

Add 3 tests which validate that:
- 802.1ad-tagged traffic is learned into the PVID of an 802.1Q-aware
  bridge
- Double-tagged traffic is forwarded when just the PVID of the port is
  present in the VLAN group of the ports
- Double-tagged traffic is not forwarded when the PVID of the port is
  absent from the VLAN group of the ports

The test passes with both veth and ocelot.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/forwarding/bridge_vlan_aware.sh       | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
index 64bd00fe9a4f..90f8a244ea90 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion extern_learn"
+ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion extern_learn other_tpid"
 NUM_NETIFS=4
 CHECK_TC="yes"
 source lib.sh
@@ -142,6 +142,58 @@ extern_learn()
 	bridge fdb del de:ad:be:ef:13:37 dev $swp1 master vlan 1 &> /dev/null
 }
 
+other_tpid()
+{
+	local mac=de:ad:be:ef:13:37
+
+	# Test that packets with TPID 802.1ad VID 3 + TPID 802.1Q VID 5 are
+	# classified as untagged by a bridge with vlan_protocol 802.1Q, and
+	# are processed in the PVID of the ingress port (here 1). Not VID 3,
+	# and not VID 5.
+	RET=0
+
+	tc qdisc add dev $h2 clsact
+	tc filter add dev $h2 ingress protocol all pref 1 handle 101 \
+		flower dst_mac $mac action drop
+	ip link set $h2 promisc on
+	ethtool -K $h2 rx-vlan-filter off rx-vlan-stag-filter off
+
+	$MZ -q $h1 -c 1 -b $mac -a own "88:a8 00:03 81:00 00:05 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
+	sleep 1
+
+	# Match on 'self' addresses as well, for those drivers which
+	# do not push their learned addresses to the bridge software
+	# database
+	bridge -j fdb show $swp1 | \
+		jq -e ".[] | select(.mac == \"$(mac_get $h1)\") | select(.vlan == 1)" &> /dev/null
+	check_err $? "FDB entry was not learned when it should"
+
+	log_test "FDB entry in PVID for VLAN-tagged with other TPID"
+
+	RET=0
+	tc -j -s filter show dev $h2 ingress \
+		| jq -e ".[] | select(.options.handle == 101) \
+		| select(.options.actions[0].stats.packets == 1)" &> /dev/null
+	check_err $? "Packet was not forwarded when it should"
+	log_test "Reception of VLAN with other TPID as untagged"
+
+	bridge vlan del dev $swp1 vid 1
+
+	$MZ -q $h1 -c 1 -b $mac -a own "88:a8 00:03 81:00 00:05 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
+	sleep 1
+
+	RET=0
+	tc -j -s filter show dev $h2 ingress \
+		| jq -e ".[] | select(.options.handle == 101) \
+		| select(.options.actions[0].stats.packets == 1)" &> /dev/null
+	check_err $? "Packet was forwarded when should not"
+	log_test "Reception of VLAN with other TPID as untagged (no PVID)"
+
+	bridge vlan add dev $swp1 vid 1 pvid untagged
+	ip link set $h2 promisc off
+	tc qdisc del dev $h2 clsact
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.34.1


