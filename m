Return-Path: <linux-kselftest+bounces-15369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B839526B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4A51F22B1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508486BFC7;
	Thu, 15 Aug 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iYbLRZPZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6754277;
	Thu, 15 Aug 2024 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680603; cv=fail; b=RaePTJnsfSLlrfuwU3esFCtJhSmwowFF/FivkdmjFK/KMsuUc/dqyEFA/6D0opa8GNA2ky7t6S4Q7l4W9fLb8GKyEy1qa3NnsJITMElIoG5Qbb6DT9KuN+gh8cjWJvCTNarw2qIf6jsjZ7jXnGwiLT0cIrFOI/ANp3A24CK7WiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680603; c=relaxed/simple;
	bh=VobV8zxIK4haQTU0UvzzwpFsZE7igu0yd2m4AF/1yd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcc2wMTsCL+qiIZD0reylOurPLJF182Ugsltk7VmNzuZIVJihfcIL5HobBuW1iCKvMXF/ambXxDneoZmyuEzdB2bpHJIIDOr8dtPaNcWv082ICrNv4fyMxbO9m1xexMrf9buZjHqQpm9h3CLM21fZGpynoTWT4h+EJ+RNwmHkoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iYbLRZPZ; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfMMk05CrZ9UbkTYkzlFLnRKI/Vd3Qi4D122EpCFEnAkOAPU73KfJuCrRuHSKELBJwEmQsMmjDIlEf/D5kISsDMsuGvGxCpm+YPix335g/sM7BpvWvenCbvnk1oqseUyRWw0Omj2D1LMJve1xED/0xjI/HrnSOFjHBppw/PFfPdb/IqKNnZjNS+H7ECTo1NTlZgX2m6keAt+Tvh3mtSETCeIgW9WhJoXmUR8FsuZiwTCn8tW4L4OgH6yWOcjMh78C5X0EE9TiWwGJwYnHTeWS3l6tkfaN8INkl9pKVOS8/qjFBOPZsIwPtJDlJibojCeZmWoG1a+zy1fy5DKykbnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5q0zdh32mXUKBWKmZI9rz1YkceYSFMMd3l/VmSLWRo=;
 b=l4q9mEZYfxv+Z1ahH/uo06NWJsYUX1IgNWz19isIe6ok19M+YOmcLK0bwA/JjJ3zXahj4YEBQ7y58yCtoYoGe9cmjmPz6Q9/+6tLDZq/Ga7O2qrocqvb3OWnaDfvpgo2D2i5j7xTyrO0dSMzBHvKCqWaMn8ceq8zemes0OlR8pkPDsJEDE/ZiLKl9EMOPY8RSo5i+gCBRj6LiA/2I+AtcQG1tVBSQdDf5P/gNNOfvKGlmall+7LQ4/9/98Gyko7Oqm3ohkVG9Mbr0JlVzvuY2+db8owqTCsZvFLeoiOZ62HJN30kiO8RzgQC054Lo9t6kCKqWzclcYStQ6kUsgT5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5q0zdh32mXUKBWKmZI9rz1YkceYSFMMd3l/VmSLWRo=;
 b=iYbLRZPZ5SccNCV54eTg9U81HP/oYvF7r9PNM/rba3J8HJSKeNF0O+LkXtQX/SU/C7x0WSPbLgk7miBB3zPgtYGVHCpQD0w18RerKZuz848G+eAIM4FJym7nI/oC+ZWRxusXmMPDV3/h5dgh3dGczWDZ+Lg+zVFOnU44tpSgLWGlayWY1TjqR3rZ8ba0BNYavluw2bR57pn+kYyXw0j7iiY01ZRTEobs8ogvleFc5yFLV18GtivGIZcYuQ21YK6c94/WouGOdNVvR6hGlQNCJgz9Z1wa9kedFYsyCtMMMCozLJEJpEb5N+DGtZmjUtLCpwOqv0GZ5HIbV2dSco2z7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:54 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:54 +0000
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
Subject: [PATCH net 14/14] net: mscc: ocelot: treat 802.1ad tagged traffic as 802.1Q-untagged
Date: Thu, 15 Aug 2024 03:07:07 +0300
Message-Id: <20240815000707.2006121-15-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bc0aa76b-9d45-40fe-deec-08dcbcbe9726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0mZc0oDh2ePfEMUNX3kVAhgne6A/V+16xmOKdJ9a2runsmoJacD1pUA8zPgl?=
 =?us-ascii?Q?bPxUil+5qST/N8XzdVOMPU49HFaGZ/b9RLLxSXpdcSirjg5kMsIdvwZlJVoj?=
 =?us-ascii?Q?Ga/z1KfbhALpqhcrTv0LnbE2Q6F381xnsiwCHXz3YXzT/jUKrjB4BNxuCAMY?=
 =?us-ascii?Q?2oNav8wtRMS4im6w7yd+bf38fx6lAiE+CmH4iUnd9reNytDFP47mECJhHFTc?=
 =?us-ascii?Q?XGr+3G3DW0Crxb9knGulsZ+hqU0do5laNQCfpCKzO9h7DsY1yB/p66ZhkWMX?=
 =?us-ascii?Q?DppZ0QC3c1vIMLjuynWuP4+TvapA9saj5tTO6+lZ+cI15S2fOT4F/lDpMK2N?=
 =?us-ascii?Q?pZTYcu9YEcfVrehXVfyyev10EUaVLxFSXCQCkgp3m3jm+CBPTqEMUJWwTjNS?=
 =?us-ascii?Q?j84A2xlIEN80NwAt0mLFG4BkBMmq3gVUQJVCKziY2t4Jsk4rsKYyfMfB3hbd?=
 =?us-ascii?Q?A2i3JOT6IzA8Z90MrL70j1lVYmcNfukMt2hhLakCpUNh46M7WnMyGcg63q/z?=
 =?us-ascii?Q?gQsh+giKCVGX/JK2WG+6heDJJF41iIjvtTHkgFWW9YolskBg1ejSLx0rUkuU?=
 =?us-ascii?Q?DYK+aEV7Gr4wumQGuBSJCPHzG1Ai4rVNlb0bnUjT15kW3KDueNAJzqAHmlU1?=
 =?us-ascii?Q?seeAwqHerRtuMIBC0ztUEiibCOtgv0z1VJl5gXHckcLLePiLwI/gGDqBrhir?=
 =?us-ascii?Q?sJIVlZ1PbEyGyFJhm4hUEV9JATSaQlXb1/TmCvEotZfuV2mhauLIoADNiGCb?=
 =?us-ascii?Q?dxX9Z6ksNizW+T1LSybtt+v4KBUZFlPVeOxg8zPV1SYEiDQJmMxBA2SVmuk3?=
 =?us-ascii?Q?XlfXZ2hJrnfsKZXqpgiCqQ3MhH0yivbWxBtg2q4f6PAb8zX3+cJVHRewakqo?=
 =?us-ascii?Q?o2acnYIXL1y77fk552nW6Yuw6Nm2BJ8Bz+HC3LpXg5jA5odIYYM1GgmcOXAA?=
 =?us-ascii?Q?xtEnKA9ubfQfLAYNUOrkYZLM2qQTDwDDQ4q5Rv40SoNDDa5otQdvuSA452MG?=
 =?us-ascii?Q?cABuUaQ8VudCTmcZX7Jd2hidj5oC/57EgyM9tCZeM/6ZYlGkGYAyW8ifFSB/?=
 =?us-ascii?Q?Avi0aSjfmsu0AhrRKY4c1fcogS7TKKyIyRsbfY864eu35dSda8EkvFQgZf+h?=
 =?us-ascii?Q?aCdSkfedumPa8hUebuh1fjiiksLB1CLBlNJef4N5v6abgTIFth+rXSn29azR?=
 =?us-ascii?Q?3ORmX4jSm0mHh462li72U+rh9JnuCDs87EGyH86BVRmRZiBzHjz+rdk9/lYK?=
 =?us-ascii?Q?Ek0V4Cnh7oe37VU4Y+1CaSZnxWSSuVcOtHIQUb+XHxJgSHWV7711PKak9784?=
 =?us-ascii?Q?xDueazk97jdbwHCjtU96yOOAHsFzLAym2D03YCMCbKveX8OFrLexAcwKLiPZ?=
 =?us-ascii?Q?ZnePKRhDt9tmfKoiKK6xq3UvQIEzUOyXovHjFyoxUXTWxmemhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LdYXle9AHj6RQGaWG3zKaiEfnsykRWIkxuFATDuE7Exm1QQczv9HICwe6tYF?=
 =?us-ascii?Q?sQ1fdaqAD9y/aJxt52/nz7QKrPoG7r9+OBlqD9wGEHf5+XGVjHyvbVt9Afgw?=
 =?us-ascii?Q?xQ5KGbIzi+LhLSQd9xVm6kONt62FPGRzYOsZ9H96dgm4GZ87f+aIN24hDBrb?=
 =?us-ascii?Q?8TYVoxOKmg4bfQRkEasq5NEkTSYaBRwMSK+qaPFRemJdagEysU2j7jm97ile?=
 =?us-ascii?Q?wTRvxWTaCCKWDewfLPYlxGDnm2x0EtkpdmtvgUxtqRif2w1RJByKoXcV8bkR?=
 =?us-ascii?Q?2WkgETY0a9QV6IAdPbu1uyl98h/P971K6gPw/hNZSpDbe75OuBYM1XBIS+Ye?=
 =?us-ascii?Q?3VR2tNdLCHd3MziZSbIkN73n9YBhGTxmaG+5DVqyucerte2iHs1InGKxNYH1?=
 =?us-ascii?Q?m8Dg0CPImBXORMbyr5947xEOvVMkjmzx3X5WGhoKfChs42Ors00W0RUlwYw4?=
 =?us-ascii?Q?d+b+ICXybpqXBq5pwTg2rtAWlWQDIUKA5RqOTRT/nQH5oNs/xXG8fhhecziD?=
 =?us-ascii?Q?eMlCFIJ07aemYTza/Kh5wO4rAVJUHpH6K94xG1xx4xWP1PDAs0PnaBAUmmmm?=
 =?us-ascii?Q?uSAoqkVHrMQbX4lBVPa0T2sYdZlExixQQKyaFze1mOr3GXjzW6ZM9yZT07+l?=
 =?us-ascii?Q?uJBseYEiflRj9lS3j/sv0h4zDaCQ6tg0+dl9fbZ/zSaf0MkDvm4l2Imn+O6R?=
 =?us-ascii?Q?5zeJCq7a6BdhsVKc6pA88Ho6jzlndtt7di25heoIbqsZ+nwGztQuJC23Mhe4?=
 =?us-ascii?Q?LhXXYN2KkpR1kN78wbAE/ofDb0VMAfJUPq5eI1jBcLkoy+PdosMd9tj6C9ry?=
 =?us-ascii?Q?VHYOUgybn6CnsHEu6Gfv0POtet+Wp36jFGhMLeWXyrjbNqgZXWeX/pEr0RKD?=
 =?us-ascii?Q?aDz/e3o6y6pqSh+fk2lUfUbw7eLvJ5/2/2XF0JMJaDT8Mar88jL003IID7eI?=
 =?us-ascii?Q?9j3Zx9ha5UmR57wFA0m69CSS7GELNm2CP9Vp4H3aGGpod41QFFLME0KhxPXM?=
 =?us-ascii?Q?hWboGMcpdgQVjF+VKese7yBwty7vv8EUn8Mk7JSF7dBoZcRePplROB/dsIAw?=
 =?us-ascii?Q?N3nbEDFMZiXRqzqUX5tvhvpxj3IiFw2Doq0tCH4ORlEheVfIiWcA4edkJSzO?=
 =?us-ascii?Q?sDHlJkTButZKA29arI1KUI9uD47ukbxQUdJofCxQfYiEfuGE0I5nzEzUhyxk?=
 =?us-ascii?Q?UIb0p/cXL9sesL0LVz51FyJ8hOl9jYcptYTzJz+jLL35RRWz9QEVKUCTWB0G?=
 =?us-ascii?Q?q4XczlQiq/N2PLMe7vp6P2XfJUYZpr+sooVD5DKT4WoOICq5Nr6tPZiUCztS?=
 =?us-ascii?Q?D+15Qek6pw6TmzTGJEI+wpbFM85kY3WGRAnnfCOxqrFW7mszRVsI2UsTtzgW?=
 =?us-ascii?Q?Gx8iIf8lra1dZghh8CVSkgoWJRiUyWXS5J3GqXSYGX98JSlwQ8BYGTG1n95y?=
 =?us-ascii?Q?/YqVVF8nhMBY0DLEZ2SXiQQN6rYoqBu6Z0xFBwe4J5vBg/cQjm4ItOhtbS8b?=
 =?us-ascii?Q?XCkM05qTLqwkviDgzLCw+81q6n5CcsZlDxRwb2SjdRDCiZMyELZojv+n8+yX?=
 =?us-ascii?Q?WbmZwm6W28QempnUjZcZ3/xUFt5IKqJTwrA9yziWEua2aEWu7qmDR679cQT7?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0aa76b-9d45-40fe-deec-08dcbcbe9726
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:54.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ou02J6Kyp+e0j9M5ZY1n4UBjkyXrFYaVpaGaKXZXXHJdqqBHpGxoI9mNCguguXCOWiIBe6WWEI22GVxx5/06Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

I was revisiting the topic of 802.1ad treatment in the Ocelot switch [0]
and realized that not only is its basic VLAN classification pipeline
improper for offloading vlan_protocol 802.1ad bridges, but also improper
for offloading regular 802.1Q bridges already.

Namely, 802.1ad-tagged traffic should be treated as VLAN-untagged by
bridged ports, but this switch treats it as if it was 802.1Q-tagged with
the same VID as in the 802.1ad header. This is markedly different to
what the Linux bridge expects; see the "other_tpid()" function in
tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh.

An idea came to me that the VCAP IS1 TCAM is more powerful than I'm
giving it credit for, and that it actually overwrites the classified VID
before the VLAN Table lookup takes place. In other words, it can be
used even to save a packet from being dropped on ingress due to VLAN
membership.

Add a sophisticated TCAM rule hardcoded into the driver to force the
switch to behave like a Linux bridge with vlan_filtering 1 vlan_protocol
802.1Q.

Regarding the lifetime of the filter: eventually the bridge will
disappear, and vlan_filtering on the port will be restored to 0 for
standalone mode. Then the filter will be deleted.

[0]: https://lore.kernel.org/netdev/20201009122947.nvhye4hvcha3tljh@skbuf/

Fixes: 7142529f1688 ("net: mscc: ocelot: add VLAN filtering")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot.c      | 188 ++++++++++++++++++++++--
 drivers/net/ethernet/mscc/ocelot_vcap.c |   1 +
 include/soc/mscc/ocelot_vcap.h          |   2 +
 3 files changed, 180 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index f4e027a6fe95..3d72aa7b1305 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -453,9 +453,158 @@ static u16 ocelot_vlan_unaware_pvid(struct ocelot *ocelot,
 	return VLAN_N_VID - bridge_num - 1;
 }
 
+/**
+ * ocelot_update_vlan_reclassify_rule() - Make switch aware only to bridge VLAN TPID
+ *
+ * @ocelot: Switch private data structure
+ * @port: Index of ingress port
+ *
+ * IEEE 802.1Q-2018 clauses "5.5 C-VLAN component conformance" and "5.6 S-VLAN
+ * component conformance" suggest that a C-VLAN component should only recognize
+ * and filter on C-Tags, and an S-VLAN component should only recognize and
+ * process based on C-Tags.
+ *
+ * In Linux, as per commit 1a0b20b25732 ("Merge branch 'bridge-next'"), C-VLAN
+ * components are largely represented by a bridge with vlan_protocol 802.1Q,
+ * and S-VLAN components by a bridge with vlan_protocol 802.1ad.
+ *
+ * Currently the driver only offloads vlan_protocol 802.1Q, but the hardware
+ * design is non-conformant, because the switch assigns each frame to a VLAN
+ * based on an entirely different question, as detailed in figure "Basic VLAN
+ * Classification Flow" from its manual and reproduced below.
+ *
+ * Set TAG_TYPE, PCP, DEI, VID to port-default values in VLAN_CFG register
+ * if VLAN_AWARE_ENA[port] and frame has outer tag then:
+ *   if VLAN_INNER_TAG_ENA[port] and frame has inner tag then:
+ *     TAG_TYPE = (Frame.InnerTPID <> 0x8100)
+ *     Set PCP, DEI, VID to values from inner VLAN header
+ *   else:
+ *     TAG_TYPE = (Frame.OuterTPID <> 0x8100)
+ *     Set PCP, DEI, VID to values from outer VLAN header
+ *   if VID == 0 then:
+ *     VID = VLAN_CFG.VLAN_VID
+ *
+ * Summarized, the switch will recognize both 802.1Q and 802.1ad TPIDs as VLAN
+ * "with equal rights", and just set the TAG_TYPE bit to 0 (if 802.1Q) or to 1
+ * (if 802.1ad). It will classify based on whichever of the tags is "outer", no
+ * matter what TPID that may have (or "inner", if VLAN_INNER_TAG_ENA[port]).
+ *
+ * In the VLAN Table, the TAG_TYPE information is not accessible - just the
+ * classified VID is - so it is as if each VLAN Table entry is for 2 VLANs:
+ * C-VLAN X, and S-VLAN X.
+ *
+ * Whereas the Linux bridge behavior is to only filter on frames with a TPID
+ * equal to the vlan_protocol, and treat everything else as VLAN-untagged.
+ *
+ * Consider an ingress packet tagged with 802.1ad VID=3 and 802.1Q VID=5,
+ * received on a bridge vlan_filtering=1 vlan_protocol=802.1Q port. This frame
+ * should be treated as 802.1Q-untagged, and classified to the PVID of that
+ * bridge port. Not to VID=3, and not to VID=5.
+ *
+ * The VCAP IS1 TCAM has everything we need to overwrite the choices made in
+ * the basic VLAN classification pipeline: it can match on TAG_TYPE in the key,
+ * and it can modify the classified VID in the action. Thus, for each port
+ * under a vlan_filtering bridge, we can insert a rule in VCAP IS1 lookup 0 to
+ * match on 802.1ad tagged frames and modify their classified VID to the 802.1Q
+ * PVID of the port. This effectively makes it appear to the outside world as
+ * if those packets were processed as VLAN-untagged.
+ *
+ * The rule needs to be updated each time the bridge PVID changes, and needs
+ * to be deleted if the bridge PVID is deleted, or if the port becomes
+ * VLAN-unaware.
+ */
+static int ocelot_update_vlan_reclassify_rule(struct ocelot *ocelot, int port)
+{
+	unsigned long cookie = OCELOT_VCAP_IS1_VLAN_RECLASSIFY(ocelot, port);
+	struct ocelot_vcap_block *block_vcap_is1 = &ocelot->block[VCAP_IS1];
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	const struct ocelot_bridge_vlan *pvid_vlan;
+	struct ocelot_vcap_filter *filter;
+	int err, val, pcp, dei;
+	bool vid_replace_ena;
+	u16 vid;
+
+	pvid_vlan = ocelot_port->pvid_vlan;
+	vid_replace_ena = ocelot_port->vlan_aware && pvid_vlan;
+
+	filter = ocelot_vcap_block_find_filter_by_id(block_vcap_is1, cookie,
+						     false);
+	if (!vid_replace_ena) {
+		/* If the reclassification filter doesn't need to exist, delete
+		 * it if it was previously installed, and exit doing nothing
+		 * otherwise.
+		 */
+		if (filter)
+			return ocelot_vcap_filter_del(ocelot, filter);
+
+		return 0;
+	}
+
+	/* The reclassification rule must apply. See if it already exists
+	 * or if it must be created.
+	 */
+
+	/* Treating as VLAN-untagged means using as classified VID equal to
+	 * the bridge PVID, and PCP/DEI set to the port default QoS values.
+	 */
+	vid = pvid_vlan->vid;
+	val = ocelot_read_gix(ocelot, ANA_PORT_QOS_CFG, port);
+	pcp = ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL_X(val);
+	dei = !!(val & ANA_PORT_QOS_CFG_DP_DEFAULT_VAL);
+
+	if (filter) {
+		bool changed = false;
+
+		/* Filter exists, just update it */
+		if (filter->action.vid != vid) {
+			filter->action.vid = vid;
+			changed = true;
+		}
+		if (filter->action.pcp != pcp) {
+			filter->action.pcp = pcp;
+			changed = true;
+		}
+		if (filter->action.dei != dei) {
+			filter->action.dei = dei;
+			changed = true;
+		}
+
+		if (!changed)
+			return 0;
+
+		return ocelot_vcap_filter_replace(ocelot, filter);
+	}
+
+	/* Filter doesn't exist, create it */
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return -ENOMEM;
+
+	filter->key_type = OCELOT_VCAP_KEY_ANY;
+	filter->ingress_port_mask = BIT(port);
+	filter->vlan.tpid = OCELOT_VCAP_BIT_1;
+	filter->prio = 1;
+	filter->id.cookie = cookie;
+	filter->id.tc_offload = false;
+	filter->block_id = VCAP_IS1;
+	filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
+	filter->lookup = 0;
+	filter->action.vid_replace_ena = true;
+	filter->action.pcp_dei_ena = true;
+	filter->action.vid = vid;
+	filter->action.pcp = pcp;
+	filter->action.dei = dei;
+
+	err = ocelot_vcap_filter_add(ocelot, filter, NULL);
+	if (err)
+		kfree(filter);
+
+	return err;
+}
+
 /* Default vlan to clasify for untagged frames (may be zero) */
-static void ocelot_port_set_pvid(struct ocelot *ocelot, int port,
-				 const struct ocelot_bridge_vlan *pvid_vlan)
+static int ocelot_port_set_pvid(struct ocelot *ocelot, int port,
+				const struct ocelot_bridge_vlan *pvid_vlan)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
 	u16 pvid = ocelot_vlan_unaware_pvid(ocelot, ocelot_port->bridge);
@@ -475,15 +624,23 @@ static void ocelot_port_set_pvid(struct ocelot *ocelot, int port,
 	 * happens automatically), but also 802.1p traffic which gets
 	 * classified to VLAN 0, but that is always in our RX filter, so it
 	 * would get accepted were it not for this setting.
+	 *
+	 * Also, we only support the bridge 802.1Q VLAN protocol, so
+	 * 802.1ad-tagged frames (carrying S-Tags) should be considered
+	 * 802.1Q-untagged, and also dropped.
 	 */
 	if (!pvid_vlan && ocelot_port->vlan_aware)
 		val = ANA_PORT_DROP_CFG_DROP_PRIO_S_TAGGED_ENA |
-		      ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA;
+		      ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA |
+		      ANA_PORT_DROP_CFG_DROP_S_TAGGED_ENA;
 
 	ocelot_rmw_gix(ocelot, val,
 		       ANA_PORT_DROP_CFG_DROP_PRIO_S_TAGGED_ENA |
-		       ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA,
+		       ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA |
+		       ANA_PORT_DROP_CFG_DROP_S_TAGGED_ENA,
 		       ANA_PORT_DROP_CFG, port);
+
+	return ocelot_update_vlan_reclassify_rule(ocelot, port);
 }
 
 static struct ocelot_bridge_vlan *ocelot_bridge_vlan_find(struct ocelot *ocelot,
@@ -631,7 +788,10 @@ int ocelot_port_vlan_filtering(struct ocelot *ocelot, int port,
 		       ANA_PORT_VLAN_CFG_VLAN_POP_CNT_M,
 		       ANA_PORT_VLAN_CFG, port);
 
-	ocelot_port_set_pvid(ocelot, port, ocelot_port->pvid_vlan);
+	err = ocelot_port_set_pvid(ocelot, port, ocelot_port->pvid_vlan);
+	if (err)
+		return err;
+
 	ocelot_port_manage_port_tag(ocelot, port);
 
 	return 0;
@@ -684,9 +844,12 @@ int ocelot_vlan_add(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 		return err;
 
 	/* Default ingress vlan classification */
-	if (pvid)
-		ocelot_port_set_pvid(ocelot, port,
-				     ocelot_bridge_vlan_find(ocelot, vid));
+	if (pvid) {
+		err = ocelot_port_set_pvid(ocelot, port,
+					   ocelot_bridge_vlan_find(ocelot, vid));
+		if (err)
+			return err;
+	}
 
 	/* Untagged egress vlan clasification */
 	ocelot_port_manage_port_tag(ocelot, port);
@@ -712,8 +875,11 @@ int ocelot_vlan_del(struct ocelot *ocelot, int port, u16 vid)
 		return err;
 
 	/* Ingress */
-	if (del_pvid)
-		ocelot_port_set_pvid(ocelot, port, NULL);
+	if (del_pvid) {
+		err = ocelot_port_set_pvid(ocelot, port, NULL);
+		if (err)
+			return err;
+	}
 
 	/* Egress */
 	ocelot_port_manage_port_tag(ocelot, port);
@@ -2607,7 +2773,7 @@ int ocelot_port_set_default_prio(struct ocelot *ocelot, int port, u8 prio)
 		       ANA_PORT_QOS_CFG,
 		       port);
 
-	return 0;
+	return ocelot_update_vlan_reclassify_rule(ocelot, port);
 }
 EXPORT_SYMBOL_GPL(ocelot_port_set_default_prio);
 
diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
index 73cdec5ca6a3..5734b86aed5b 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.c
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
@@ -695,6 +695,7 @@ static void is1_entry_set(struct ocelot *ocelot, int ix,
 	vcap_key_bit_set(vcap, &data, VCAP_IS1_HK_L2_MC, filter->dmac_mc);
 	vcap_key_bit_set(vcap, &data, VCAP_IS1_HK_L2_BC, filter->dmac_bc);
 	vcap_key_bit_set(vcap, &data, VCAP_IS1_HK_VLAN_TAGGED, tag->tagged);
+	vcap_key_bit_set(vcap, &data, VCAP_IS1_HK_TPID, tag->tpid);
 	vcap_key_set(vcap, &data, VCAP_IS1_HK_VID,
 		     tag->vid.value, tag->vid.mask);
 	vcap_key_set(vcap, &data, VCAP_IS1_HK_PCP,
diff --git a/include/soc/mscc/ocelot_vcap.h b/include/soc/mscc/ocelot_vcap.h
index c601a4598b0d..eb19668a06db 100644
--- a/include/soc/mscc/ocelot_vcap.h
+++ b/include/soc/mscc/ocelot_vcap.h
@@ -13,6 +13,7 @@
  */
 #define OCELOT_VCAP_ES0_TAG_8021Q_RXVLAN(ocelot, port, upstream) ((upstream) << 16 | (port))
 #define OCELOT_VCAP_IS1_TAG_8021Q_TXVLAN(ocelot, port)		(port)
+#define OCELOT_VCAP_IS1_VLAN_RECLASSIFY(ocelot, port)		((ocelot)->num_phys_ports + (port))
 #define OCELOT_VCAP_IS2_TAG_8021Q_TXVLAN(ocelot, port)		(port)
 #define OCELOT_VCAP_IS2_MRP_REDIRECT(ocelot, port)		((ocelot)->num_phys_ports + (port))
 #define OCELOT_VCAP_IS2_MRP_TRAP(ocelot)			((ocelot)->num_phys_ports * 2)
@@ -499,6 +500,7 @@ struct ocelot_vcap_key_vlan {
 	struct ocelot_vcap_u8  pcp;    /* PCP (3 bit) */
 	enum ocelot_vcap_bit dei;    /* DEI */
 	enum ocelot_vcap_bit tagged; /* Tagged/untagged frame */
+	enum ocelot_vcap_bit tpid;
 };
 
 struct ocelot_vcap_key_etype {
-- 
2.34.1


