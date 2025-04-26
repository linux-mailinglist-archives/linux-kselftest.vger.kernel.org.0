Return-Path: <linux-kselftest+bounces-31707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C09A9DB8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B067B2522
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77525D904;
	Sat, 26 Apr 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JOHk+tUE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2F25D534;
	Sat, 26 Apr 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745678968; cv=fail; b=bhVPp1/1hCCj0arkwfMI2AFagB2u0gbqS9/3C8kFK+KulphBSt0TMpHJpKCVCGmscqGZLklYWftPSMn68PAM1+Rqir3W2tGoQDcrLyn5veO7RRJ0Jvw8Zu3Go9ab2mgXMZtuKM6HxFxSXeIduQmfbEIZ7dkEQ509CA/kkhqlIM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745678968; c=relaxed/simple;
	bh=fUFWSX2AKWEIGYTwuFAHpp6EZ/Es+q1u2AtAHz4CNmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHi8/5+XGuSW7e+3DqNh+q6d2NPlIrXX3+BQrCw3nxVvs+jXedFM8mcCAPf5Z76K99LcmNb7k8m1JuJTXORLMULi5+2KNmH/hJl+oiDJWhzfYCMyyk53CP3sFBrPGrUB/MnP0aSsLuEoMcnMHLPrQaFLVcUq4oG8dUoTTqjXPUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JOHk+tUE; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4+5Jom569jg5t5RDIX4trcVVN4JPKSGuHCIgjfW7PGFlqJB0+iCgsx9dvqI2E95QuJt+B6s+Kw1Z/ZuYVL/uz2ya+1NIu6/3w5ecPne4jNifQ8HYUR6iw/FrZordkV42h8rnGWnoEUsH9fYbvpTxdVvix13kR5KRF0bt7KwUmO+1rHwgkcEYmpNu5ION9U9r3DchsZ+sWVs5Bf60i1UHnb1juNeWJwdmtRxp8CBRjla9MtUxX5ElvQ/3aKPKwzxXOaEuDon79kjbuq9XHliv38aU0FbmMNQZ9/1ImgIUxq9JP89ruifMN1feqf+DsV66g8EB1jyhwXPURTfwD3gRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzGVlmcucbyEYDTN89eB1We7zilEXXSY3sBwPJbj/4Y=;
 b=Qhz/5NVIDDhcjAtOul9tK75s5eYcS2kcm87Wf7APGRwfOdK/YIx5rtHuVWonABZQllh/ailR4LS/lg9oWDKEDWEIXYf1ktj8uT2hDV/qKu9IcP99AWFx2Sw08nI6qlfqh/MyCcM2mwDeIjcxBaEpRmVXrmTsk2nVGxnp//r8Ocfw7VCylbtU6pFsAGcGbezbcxVpLqCuxoXibgbt4to5GxaUx3kVWvQKlBu0q17Tfg4AdvDKuQd14STtGT0o3UO78LkAFoAvMICMkz+z97Vbr++4dVzqJd80SzvtNb1GqQ+VvKdl+GfEvL+JR1KuPkLd4lBmCX/MM9N64btEMngTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzGVlmcucbyEYDTN89eB1We7zilEXXSY3sBwPJbj/4Y=;
 b=JOHk+tUE92v7vJppVE+wsiCDzikafRUVDWhO5OY6vKcwlJjbcMLhq1Joix2cUoRBrSHWvj01U8q36LRu7NsiieTvTDdS3/+PasJzDnof7L9+l6+C2QM4SqvwEJAXSOwTmhRnqeeFV7jKlzNVYSiFjLCODxWc5t4X0RLnCl4bIv4nCCeC14e7Dswjf47E4uF9iIMKiAChn6mNMIfr0uvDfDnk6N1/PPnyimwH72s8ZZkCMPkVS08iuAhZBIXKl93amdA1uJ2NCjxaTrJUgjG/fDq8QyJENOQE5mh0x4IvsA6/iiHu+yEG09hSND7wNls1suTCP+qQAypMXeR4NdR7eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9019.eurprd04.prod.outlook.com (2603:10a6:10:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 14:49:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.028; Sat, 26 Apr 2025
 14:49:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Richie Pearn <richard.pearn@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/4] selftests: net: tsn_lib: add window_size argument to isochron_do()
Date: Sat, 26 Apr 2025 17:48:57 +0300
Message-ID: <20250426144859.3128352-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
References: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:802:2::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e3559c-dfa6-41fa-a303-08dd84d183d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtXKRYIzXJYkbnQWuYg9zo2WYG0sjBP8SesPzYEGwxwm+oULaM3Fjf7jdwW6?=
 =?us-ascii?Q?l68yWsUtww8lpfgslzZbHOztfO86nugXn6jDVRqaQbCipEMLDawe1BUQTjTq?=
 =?us-ascii?Q?UI7Jzc5GxZ7U4/UbrnGkVzmVKOBM5jwBmQGOBeZ5lTmA2NQdI6J5L/cTrwA9?=
 =?us-ascii?Q?bFbrQ3o0ndqQte59jiYPhAFzcvHX87k9Fj7uCeDoEGNUI5yqgvFHtXHDoxuW?=
 =?us-ascii?Q?FlUf7LXDuICevmo8/SZ0iZro1AGgqq4jUpP8jgM7lJsyJdxO0wbsICvB61PL?=
 =?us-ascii?Q?6R7EKMUxb0/CN920MFP//XAHlhzaDseScMuvbdc9aqHXZHZxB9TsShBdwfGF?=
 =?us-ascii?Q?xulah6FBwBOC5aQzzXOaWU3xJemv+BetHivinfefU+fSmsVQrNHgEHXQHRLs?=
 =?us-ascii?Q?79qK49a24DavZI7mtx7kVv/mmqQgZPKNGLYZcjiK0TnDTB/De0wb3MGAvYu8?=
 =?us-ascii?Q?1b6RdQuRbEOSNAJUsLztLSswOOmwhBOByP7uExF7pGrz6vyv3HUBiVUYxIWy?=
 =?us-ascii?Q?me7aohx8xCfh+8sEhPk58ewmL5/aV8aQCYf9LPCyUCBKib2g4tBstbynkupN?=
 =?us-ascii?Q?frUI9XS5V8hhsfP6Q0/CRB2hx4DZenHF5e+EnPKjZovHXVH2Vti4NrZbGjj2?=
 =?us-ascii?Q?FZEH/TEtP2A3UnaCxYgCTMenTr+KJ0fRsS4a8tharFtQgx3Y70I9I2Zeq2Kh?=
 =?us-ascii?Q?j/zN7mayPEV7vHMnWeyFIBUJGl7TH7xWQlSt1MNOaBENzQvxhKNeDozD9gED?=
 =?us-ascii?Q?l2poL8vTL8ye7LoVAzuDwgizKTd6bsoKJdN1uGKVs8fXUTbq0zdnUhHewvD4?=
 =?us-ascii?Q?enn3lJLMsXAl8TFYJHxctIO0EVBvhfn87o0VDQHPgNX4EAr8kmq2wjOPPS3F?=
 =?us-ascii?Q?C3P9OIQMWMsqcfkAiz/YCR4sIP/O9K5CC+zacc5I0xr5goedKE5CAKVbZkY8?=
 =?us-ascii?Q?VVaeSORZhC04B9PYyxvPCSRZnEvroFj3lhfm64XTnDE2gjr6byonx0cDeoCx?=
 =?us-ascii?Q?skf9BDa+6+8iUSI7YuufvMELIk6Czami4H8K4MvidW3nrxaQ2XKidHAvfY68?=
 =?us-ascii?Q?1xHLq2ory2/SNlzL5jA8a3wjPHn/ipg/kn2sZV/TuGU5D8XYMeKCUPfN40ao?=
 =?us-ascii?Q?BlSRJ9vj/pO2OYGF+uYFVMvb3bIrPa/xbTXEg+hAHyeNuzGhHYViELqu13nV?=
 =?us-ascii?Q?0RHRNUHm6ohBGKa1phj4Jtcix9PTMSBays8UADSj/N354sEVtRc8B8hfDdxB?=
 =?us-ascii?Q?YvxoTwomGg1zdmf/bOhiYfO59sLaZh8SV5/mP0mxSt8bONimZN8jlgWDeltu?=
 =?us-ascii?Q?X8nE01Sc2S/eeMO50n5CRzVGY5U2Ddnj8nPM4K73fpanFO+ztsC+ioVdLi9a?=
 =?us-ascii?Q?1m/t3G/CZYIGn1UgLRsNUhehwAxwq1mVHuifV25RP9fXSJpSTXnuxXihcLo2?=
 =?us-ascii?Q?mRjBcxMQqCFlkYDjUztefSPo3OF1PbW5chvWOg0hon6ghGiAx4wkNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mqIALqcpUaYhvcN9nBdvUAuDffEwS/DAw9Pm+KCmz+NXjtF9YaJN39mcMepu?=
 =?us-ascii?Q?9Icl5ysu008Ak3/0+PXOsCW0RtG1slQukJ4GJm/c0GFQubvkApdtyyouP4Pq?=
 =?us-ascii?Q?7C0ApB3qkw18dMbN0LPdWAhIgF9+pQBcuqDHN355zFAU2XPsNnYx+kIeKmxA?=
 =?us-ascii?Q?MRL6qHoo3zzFvJySJGrU5XqbhR2ZiK+4ptLbZVPuaMOTAph1/ZU5JO3oJieU?=
 =?us-ascii?Q?PEiKcnVtR8AywMk+8Y6LzdJjSnEHlcrgwlqcsIF9GuWsSNXpNCXKHHQzDsai?=
 =?us-ascii?Q?bxUivGfyF5r0BIefLG7459LuQLT9pcRHFK5YN+BwyVbaiAU2ahHQyfwc1ce/?=
 =?us-ascii?Q?WES3xPhUtX8wpqnmV+ROqW9ghA57v1NZ1Jw7NSdtWxaeQan2th42NQ/EZSeY?=
 =?us-ascii?Q?elSeH1JwOl9gN9ns6WRHJfSuGKB6L/AJ5+6ixwAiv7E5RVPzsohjb13sv8Qz?=
 =?us-ascii?Q?Ardk47T5nxMYGcwIPoZ1cyUKJTo0vqGyINE9g0p6LhpJBXrG0xYGVgZ5JiOO?=
 =?us-ascii?Q?FoEWY5CMGX63lGCPgcPgS9BOy914UXoz0HvxS+uoi9ghKV1wrRnFMpQC4id8?=
 =?us-ascii?Q?rDeyHk3otxUWVIlcGrlWD/KfYX4DYX48w3KpT1mwW1P/uIas0DbmSoX5tC59?=
 =?us-ascii?Q?eSFJJKCbj0vBXYuXy5hg+KtZtn9jGNHlQI8UAsi9kdlGc7Jac4JlXjAritOL?=
 =?us-ascii?Q?59s7mLVWA9tSpAEMy0ayKzCggw4x6J5y2RGnY/ZcYTZYZHvNXn96LmelYtV9?=
 =?us-ascii?Q?07Tc5UxE2cOEO2Hk59Ih/yqmkJO9BuiUYREj80V+yqZ2u0nEB8tyFlEulpaL?=
 =?us-ascii?Q?Sc9hFaiZr0E1+vw6nO9TxCiM6s3R7XFoWirIWpCeXNMedSGrnjfPo9BuV9UC?=
 =?us-ascii?Q?FxuvEUZLvhuft/NwjXQQAgerlBLd5BCVsbVV4ZVxCW87mA7yk6eaYE8tRAZR?=
 =?us-ascii?Q?DcdGyAhIWpyElwKaVCELn7gICH5a5S7YhPCU0+3DC2yOoPqnhewHjxFBTJ8R?=
 =?us-ascii?Q?hWo4oATfO1x+i8b8sAXPrs1ipgRp1crcdPSQcI7V1rEOcnGMaCNkKQKpox4e?=
 =?us-ascii?Q?S61G27hkV1uZcVK35lY748sRDqRuqavoBKzbitcAvShhPnlwWn+JjjbRI58V?=
 =?us-ascii?Q?03daGQYdSFw00dpZiubc5V51azROQQYldpH1FqrZHvRMDmNFkTsWv5QT7olh?=
 =?us-ascii?Q?/sqCA5z3ggNXbZBoiLcZG49KiZTKErK7D7/lhPV61Eo2XczUKiX7QTnDVt6t?=
 =?us-ascii?Q?YgS79Zd6biPki24xc6Nbw8/YrV7x2YGk/PDD/Q8nbcNMTFsWUbVsRFVuaObn?=
 =?us-ascii?Q?aFTFxx+OEMO8eMMTJK7VAAYvELTmnmQSPT97i5sNK5pcLiDNbTO3EmZmELLy?=
 =?us-ascii?Q?IKI4KDMsVHZ9aVEbmNnF91Fuc63VBXy8mqo6kzwMJWcbAyM58GjZt7nuzIo/?=
 =?us-ascii?Q?sGadGdvpOEU2ecIVyaPKw8M2d9CoHTdDl5XNxF39MBz8sdzZoKUAEmDTHVBM?=
 =?us-ascii?Q?+dOq7E9yL9zD8WdnEQoX5mTbFb56JKFN2U73xd33XWr7Z0PHm7KipE7EFwe/?=
 =?us-ascii?Q?f92UGcBptEMaRqciklGqI1Y5/aM0fjB/pwjWM6uuArn9r5nymWYjny8UPP+P?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e3559c-dfa6-41fa-a303-08dd84d183d8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 14:49:15.3426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zHvGDW91XnFuP9v5h+MjbQsF9Qdiy50bf9+xU6IQJpfj+b7Hj1O7u6Z3X8vcQvSOes7X9J+NMvGZ50xN8wtuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9019

Make out-of-band testing (send a packet when its traffic class gate is
closed, expecting it to be delayed) more predictable by allowing the
window size to be customized by isochron_do().

From man isochron-send, the window size alters the advance time (the
delta between the transmission time of the packet, and its expected TX
time when using SO_TXTIME or tc-taprio on the sender). In absence of the
argument, isochron-send defaults to maximizing the advance time (making
it equal to the cycle length).

The default behavior is exactly what is problematic. An advance time
that is too large will make packets intended to be out-of-band still be
potentially in-band with an open gate from the schedule's previous cycle.
We need to allow that advance time to be reduced.

Perhaps a bit confusingly, isochron_do() has a shift_time argument
currently, but that does not help here. The shift time shifts both the
user space wakeup time and the expected TX time by equal amounts, it is
unable of bringing them closer to one another.

Set the window size properly for the Ocelot PSFP selftest as well.
That used to work due to a very carefully chosen SHIFT_TIME_NS.
I've re-tested that the test still works properly.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/testing/selftests/drivers/net/ocelot/psfp.sh | 1 +
 tools/testing/selftests/net/forwarding/tsn_lib.sh  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/ocelot/psfp.sh b/tools/testing/selftests/drivers/net/ocelot/psfp.sh
index f96a4bc7120f..8972f42dfe03 100755
--- a/tools/testing/selftests/drivers/net/ocelot/psfp.sh
+++ b/tools/testing/selftests/drivers/net/ocelot/psfp.sh
@@ -266,6 +266,7 @@ run_test()
 		"${base_time}" \
 		"${CYCLE_TIME_NS}" \
 		"${SHIFT_TIME_NS}" \
+		"${GATE_DURATION_NS}" \
 		"${NUM_PKTS}" \
 		"${STREAM_VID}" \
 		"${STREAM_PRIO}" \
diff --git a/tools/testing/selftests/net/forwarding/tsn_lib.sh b/tools/testing/selftests/net/forwarding/tsn_lib.sh
index 19da1ccceac8..bcee7960a39f 100644
--- a/tools/testing/selftests/net/forwarding/tsn_lib.sh
+++ b/tools/testing/selftests/net/forwarding/tsn_lib.sh
@@ -182,6 +182,7 @@ isochron_do()
 	local base_time=$1; shift
 	local cycle_time=$1; shift
 	local shift_time=$1; shift
+	local window_size=$1; shift
 	local num_pkts=$1; shift
 	local vid=$1; shift
 	local priority=$1; shift
@@ -212,6 +213,10 @@ isochron_do()
 		extra_args="${extra_args} --shift-time=${shift_time}"
 	fi
 
+	if ! [ -z "${window_size}" ]; then
+		extra_args="${extra_args} --window-size=${window_size}"
+	fi
+
 	if [ "${use_l2}" = "true" ]; then
 		extra_args="${extra_args} --l2 --etype=0xdead ${vid}"
 		receiver_extra_args="--l2 --etype=0xdead"
-- 
2.43.0


