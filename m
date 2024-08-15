Return-Path: <linux-kselftest+bounces-15364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C395269D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71C11F23D66
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935FA39AEB;
	Thu, 15 Aug 2024 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CLYd0Co0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89534545;
	Thu, 15 Aug 2024 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680590; cv=fail; b=Vq65RexCBalzVOkfHjMmU2vLyO6IxxSKTFvK9rcDCxM4MmL8FdIXg8yhq37INGBA5hsyzjSwYgQ5EA64FEHcb3/qWL4layCdg65TbRQQ4ENPfeHTOVQEejLm2sRh/J6fguzS9TEeFWBRL3lW6XUrr0h0Qf1sCqATcmJhvrr/+oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680590; c=relaxed/simple;
	bh=sJCKlESlpTWPfCFz3pE7CHgkCPkPcLdrbRFLpI5fl+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGcs003mv7KPR2JwFrgIlwoY4Rp1dcSvzqMZmE3WN6xUAcFoE48CLLX7PtJn3/UaITt2Etwc8VGipu26RFO6Yc8esvUGgvMDSnuKBwm6Wth4AkYVcJzmKeSvUKcYYfyQ3NxzQ157Hq8WSilj9uz85/WvW693m7HFG2sAB31e6Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CLYd0Co0; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi0k2e1NUdv1Cqg5ztJsypNeSUb91UFPqJr7+tXZ+SD8sCBQYW4KAW6NI6QKfgXyfUCykKERjKavx4YQg6Pv9zVaDyAfMXYXte0Pp5UBUkD9VyWaDdM7un5o4pjce0koQLEdhhidW/Pf9kg+K58aAqUwkAV4/i11Jpv5vWGTklq00NI35DmH85aJ4V0qGkSUo9mZhJ9zXElVqWcVGUQQz1abcF4ZPVVvdto49inPpRUQoBvblZvxWS/bHmRkbf0cSu6LhsAnoKnxWQJfIB9+HJ79HXtyQQWEVrQGg1nT6zoWOgo42iTBHO1UwN8uiSgHaXJQpTBQJ+CS/M34x6ey2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi13mTGYFPkuHRsE67SiIHqIHDStOx4pUBPgtgrBaMY=;
 b=yB+GlT5+ZzXYkwI3ND505XdfXDtLwl3T+W9QsAXbDiOuAut4naQ5C6IzjY4KC4NGsJwK/q4D9tz9jPfvzzlkGdIl+nX6NEPJIf/PulwxoBN+S/QvtsMo4viJrScQuZKCf6szC1LzQo79XhWMsqmB2DIDR0hHn2q395BNAP9ojMxzPxjB9BFENBQMZ4Of0blLo5FQHW7p9W9e4K5AVQ8FCnXWN5Bo/2csHMg2BBu/ica9J75UUio9OCLYeAzMRuE7Ftjdq9+vXr8yMUFj6JNsU1GTjku6xI4fO9ZiRwR1C27ZTBWV9sM6DGOQbW7QJQwNuLOZkcd79zvUFGiGTAuCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi13mTGYFPkuHRsE67SiIHqIHDStOx4pUBPgtgrBaMY=;
 b=CLYd0Co06TnEYnlZ+8mxHWzexDdPgzM0wFQnStcMZ6CAXOZKsRjrVYVenBg484doIN0qp3DZvaaZmEfgiK6u9SXk6PrJ+ikq3J3sHVMrT8e34GHQEzJTuYXrQYfhGw+ruSSlUhOegrjlSYKnUJrTYaaGT3U0PY3MgbjKGS5sbeu3yMEEfjfg3ZXnG9qX4+qT55klzVJKpOtghD7ZqE7s4Pp8ow9CfuDBJQ00e0r3rctxCpC4M8AdQn1xydFjNglccnYG7An+OLaiZk3lPECvc/DPcFuWAkPSs5IjU2oT6RKaToX1s2hMz/VQSpwM6atTd+x0EMKprd1FTP1WXu/QvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:42 +0000
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
Subject: [PATCH net 09/14] net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA and register injection
Date: Thu, 15 Aug 2024 03:07:02 +0300
Message-Id: <20240815000707.2006121-10-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 05850c8f-f806-4513-76ea-08dcbcbe8fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VKMw36enhFJm3dYSNIyrLC4pGZTt+UVCHqxlPAF+sbiqJ9+3Yth2wdTdgbnu?=
 =?us-ascii?Q?L3edOJAW/BF+QUOcOxgiIY1KeFW2X1RAhizLef4gAVOwCOkgFgsyInYP3Kwx?=
 =?us-ascii?Q?0wAsFd2PFV+UYQBAmp7KyYXq/8TBkfRmYo4rP8Q74K1/n0fMUqkLGcYXi7n2?=
 =?us-ascii?Q?TGtiIzWvImFuXkhj94gKuJY9dPBaJ8Qz6c7uy/8bJ22TBQbHWR1bh2M6Lhdt?=
 =?us-ascii?Q?MxnMTwM0LbdA/W0lQv+d+tttwQ4+vl7rubn4jiaAWXXSLziGdKf2VQDNp75L?=
 =?us-ascii?Q?B8vJ95NANfg4UXN2vLsOINygUOKJ8YWujoWoDmV6oSzNitMCrMubOXR1k8Vw?=
 =?us-ascii?Q?IXi8sXTIB6oN1VqrJ/YC6mbIeFrI8oYD0LAJqOhrkLGLD5JyKp4iVj1+NKdh?=
 =?us-ascii?Q?xZuAfC3i4TOoFoKK4NBp5+ucO0zBmAe+/J6d8sMulcKyXSHZiFdzL7BH1Pvi?=
 =?us-ascii?Q?YQizX4vv1+FoHWriZZsALuJntMMDd123pckA1COZ1oKvq+uWG4zg8trFADtn?=
 =?us-ascii?Q?rWBv01Z786fRmLPREkhfzYPVrH4urFbX1bix9Jw3BWbroXG2axT+dBCK61Z+?=
 =?us-ascii?Q?JQa7jP1kjBRUupWkTQOteq2n49NWGKv6ohiXd/Dae9lyltLJYISpyF4eSxdP?=
 =?us-ascii?Q?O1ZeZofu11pC4Nx3SdcHnUnCrIt+MnsTcak/SWQn3zZTC2onkhnksydNGX0R?=
 =?us-ascii?Q?h7dGSlFXE1oujaj8esXBGtvasexFJyM0wjG+g1A+fPVyCvFAbCeHl2XSkVSf?=
 =?us-ascii?Q?b6egsBs/Gi2zsr2+qBD0ahuFNAlb0QjYIDt2/UXotYdDq6r/03gMmlXxz17q?=
 =?us-ascii?Q?mxEJRFZq0IQps5cRwsu4mhoezU3Np4LjkGdGoKSUKZ9qqL+JYoAmQoUFMMjv?=
 =?us-ascii?Q?S9IQmzpvYkcvm7wIIs+khdSO8yUnFrTtYQHu31ILmA47DQgtP17fHDBiMaj9?=
 =?us-ascii?Q?Bx8sqoIs+Nf387iedy+PH0uM5354cTAY3Vmebvu+EfJBzmPwxkowBHRQy/qd?=
 =?us-ascii?Q?gio5/zItRSYQykUkNLWM6QIbn0JInrxOlpddJY9LahlWv3K8eOqghUNv5iQ4?=
 =?us-ascii?Q?Jrqdz3dI/Tk78i2DKWdf4bYk5ZCCjl9zBoXnkZinokZkjt5aTN3PRufaCtMP?=
 =?us-ascii?Q?JwYNt53VZZCicLCwoJTXR2iK1/blDIHE6CyhZsOhYTJwH3TZsicuaxLyhq73?=
 =?us-ascii?Q?1kGk9QwwNOPxqKg7g0PNaBvXv7WQa/w19w6VymEREvDc2qR0qHJ/rIQ7J2mh?=
 =?us-ascii?Q?unllKENKrs8Wj97fLaM5AxQkl8BSmC0O4HyMqDqfL1Sick70LCvuQTFv/Tog?=
 =?us-ascii?Q?aXKJHyNwD0yoZ7F4FSCwCyfOhgoZvgLlLZ/A02ICKx45ACbUbxTMEfeGtdPU?=
 =?us-ascii?Q?SkNijn3mSxDjrvwVZBtyq/IFBwiQ6yAlQt4Lk8ojVnOLJ27dcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhIGTJvM2iO2xb0GT5ISw+FPTXcG67RFTAofwtPSK2a4GHtWEPkHchD1eYtF?=
 =?us-ascii?Q?ZxCs9tCrmldLk+iXL8PRBFqZLqeRkUkZfH4/FvAsBVEIbYukAIzEdPzOhvOV?=
 =?us-ascii?Q?ON4DXcY7yaC4bHaS/ZyBI/qjgI8W/+U0LBjCUVu9YjQlK4zu7foRZ1st3O6Q?=
 =?us-ascii?Q?B0SYG9bhaE4z4/5iJwU+SuXo9cCNb07GuaYQ9pQ5kB+ZXWoxTPcaLwWkNLOc?=
 =?us-ascii?Q?GiEceT96khBG72qU9iMZ1zhLHqVL6n0JXZTlzWEBZwrCk3ZfwAt/CGlc57eq?=
 =?us-ascii?Q?k2mvpxkQBXvnw+Yo2H43CqdOzQPTZrhunGK4T6ZM6KxQaZgIT7v5mFWMB7R8?=
 =?us-ascii?Q?2f06e2kWgLIrkXIy6TymritoeemHg5zCGi2BvN64UZQU9tQeyAjyUHx6J2+O?=
 =?us-ascii?Q?gExCoUXwdpZqBkJ2oTMo6vaM61yAa7Gf3yO3d2Nr+rfr85Q2AUo8gokttG5C?=
 =?us-ascii?Q?ldo8//G8HysMBc4FOzWigE9wrFq3YjOFDYQAMpkgCMHnYaMxaGCbaly9oOWY?=
 =?us-ascii?Q?X7z9ziG30Xfli5Ye2mHFxK90SDtPMmabWPA7WVFbSstJ1mV/dcgJOUE7kEHq?=
 =?us-ascii?Q?nMM9VKpG1Dip5SQdtXMzaqSv0Lr6S5raw3o1/5E6ExF1zHpKugN1QWE4D5gW?=
 =?us-ascii?Q?Q/pZJ7qGRXxQ/vKWmTrfqNbpJ1ExU11X8ZxG3oulu0k+6Bwa07a+fWyRA6H0?=
 =?us-ascii?Q?Tn2mjESqaOdn4vKwPAjN0K5a4eeslVp6dwWQoM/Usxicf9TR5VD07pklSBb6?=
 =?us-ascii?Q?S9IlveI5DVp7jqHayTuIQb7H0T4xjK+wJQw5+LT7I+MU+W8BCVM9qW9262Ll?=
 =?us-ascii?Q?oxMteLledv7fSVvC9Hj1m21PFRZhGUrnoI1taMCjCVMlEcI7mZGM/wVYVwDK?=
 =?us-ascii?Q?v3kS/wrtG7F+6tGdTQYRwRupte6+LjxOatkyKt1QrlMMq6z5WpJZj733MEnJ?=
 =?us-ascii?Q?9DB3JWZPhWIANcrxSF1zOC6qKbWFOzrYKkKN2Zh74iH3lhpi3HLfBI+TfaPd?=
 =?us-ascii?Q?93ci3bHwETYvS4ZUniwnYIpkgDNV93p9V8SS/cqcjXgP7FYhcT8c0+fre0wk?=
 =?us-ascii?Q?7rDrI0sLJu04Qq5y3JIx/XHszUVpGhv85h/KzrSnpu86w06ymVSOSn0jF0Zs?=
 =?us-ascii?Q?mUrviJnlfDoYse2Dn7dU9MK/KR7pjB5twEnBVHcfAO/ZAlxQlNMM2v3OSIuP?=
 =?us-ascii?Q?MWqciHuUwQTkIjYMiALoVoUUtPSi5ikmxlfzmEHj1VheBDgX60BvZk7k4uwM?=
 =?us-ascii?Q?IAmO6Loro+hRUeeRdD3iJnObsDGttwRR1pcGu9nvlsofnHSbBFBu0gQdaC52?=
 =?us-ascii?Q?CDBWZFMyd/vp2a9Q62Q60cisgSB5QwhFdT8bPsY1qmXoeDUvoyvdkc/zkDv/?=
 =?us-ascii?Q?7ODa6gnzticOYpZsBRSV7Uf9+9O++N8YlVegLR9Jo3ZNyBo+gn7m1LulIg85?=
 =?us-ascii?Q?2BGdktILjrh+0EMEj6lgrANZn1eoCaqhfzmQF6RgafzzcZJca5425EL/jw+A?=
 =?us-ascii?Q?XScRMaX0aPkG+v7L6bJn5XDMz4PT+WLmUHZXpYHIjD/ZO1JCDFbMjBBfg4x0?=
 =?us-ascii?Q?l2SgUZFb755jXpa6pwiZUgl1LvP7zNY/hfFjAMtQECaHh49FxOkMY7ROe0sO?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05850c8f-f806-4513-76ea-08dcbcbe8fed
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:42.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdcgLLX4hx6D6TkAc8Sgw/kZl57x4neRqW6r+6EYmhlRIrHFihaAJQS8mY78dBZw83DJ9Fo9EbZBQSkomSoJww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

Problem description
-------------------

On an NXP LS1028A (felix DSA driver) with the following configuration:

- ocelot-8021q tagging protocol
- VLAN-aware bridge (with STP) spanning at least swp0 and swp1
- 8021q VLAN upper interfaces on swp0 and swp1: swp0.700, swp1.700
- ptp4l on swp0.700 and swp1.700

we see that the ptp4l instances do not see each other's traffic,
and they all go to the grand master state due to the
ANNOUNCE_RECEIPT_TIMEOUT_EXPIRES condition.

Jumping to the conclusion for the impatient
-------------------------------------------

There is a zero-day bug in the ocelot switchdev driver in the way it
handles VLAN-tagged packet injection. The correct logic already exists in
the source code, in function ocelot_xmit_get_vlan_info() added by commit
5ca721c54d86 ("net: dsa: tag_ocelot: set the classified VLAN during xmit").
But it is used only for normal NPI-based injection with the DSA "ocelot"
tagging protocol. The other injection code paths (register-based and
FDMA-based) roll their own wrong logic. This affects and was noticed on
the DSA "ocelot-8021q" protocol because it uses register-based injection.

By moving ocelot_xmit_get_vlan_info() to a place that's common for both
the DSA tagger and the ocelot switch library, it can also be called from
ocelot_port_inject_frame() in ocelot.c.

We need to touch the lines with ocelot_ifh_port_set()'s prototype
anyway, so let's rename it to something clearer regarding what it does,
and add a kernel-doc. ocelot_ifh_set_basic() should do.

Investigation notes
-------------------

Debugging reveals that PTP event (aka those carrying timestamps, like
Sync) frames injected into swp0.700 (but also swp1.700) hit the wire
with two VLAN tags:

00000000: 01 1b 19 00 00 00 00 01 02 03 04 05 81 00 02 bc
                                              ~~~~~~~~~~~
00000010: 81 00 02 bc 88 f7 00 12 00 2c 00 00 02 00 00 00
          ~~~~~~~~~~~
00000020: 00 00 00 00 00 00 00 00 00 00 00 01 02 ff fe 03
00000030: 04 05 00 01 00 04 00 00 00 00 00 00 00 00 00 00
00000040: 00 00

The second (unexpected) VLAN tag makes felix_check_xtr_pkt() ->
ptp_classify_raw() fail to see these as PTP packets at the link
partner's receiving end, and return PTP_CLASS_NONE (because the BPF
classifier is not written to expect 2 VLAN tags).

The reason why packets have 2 VLAN tags is because the transmission
code treats VLAN incorrectly.

Neither ocelot switchdev, nor felix DSA, declare the NETIF_F_HW_VLAN_CTAG_TX
feature. Therefore, at xmit time, all VLANs should be in the skb head,
and none should be in the hwaccel area. This is done by:

static struct sk_buff *validate_xmit_vlan(struct sk_buff *skb,
					  netdev_features_t features)
{
	if (skb_vlan_tag_present(skb) &&
	    !vlan_hw_offload_capable(features, skb->vlan_proto))
		skb = __vlan_hwaccel_push_inside(skb);
	return skb;
}

But ocelot_port_inject_frame() handles things incorrectly:

	ocelot_ifh_port_set(ifh, port, rew_op, skb_vlan_tag_get(skb));

void ocelot_ifh_port_set(struct sk_buff *skb, void *ifh, int port, u32 rew_op)
{
	(...)
	if (vlan_tag)
		ocelot_ifh_set_vlan_tci(ifh, vlan_tag);
	(...)
}

The way __vlan_hwaccel_push_inside() pushes the tag inside the skb head
is by calling:

static inline void __vlan_hwaccel_clear_tag(struct sk_buff *skb)
{
	skb->vlan_present = 0;
}

which does _not_ zero out skb->vlan_tci as seen by skb_vlan_tag_get().
This means that ocelot, when it calls skb_vlan_tag_get(), sees
(and uses) a residual skb->vlan_tci, while the same VLAN tag is
_already_ in the skb head.

The trivial fix for double VLAN headers is to replace the content of
ocelot_ifh_port_set() with:

	if (skb_vlan_tag_present(skb))
		ocelot_ifh_set_vlan_tci(ifh, skb_vlan_tag_get(skb));

but this would not be correct either, because, as mentioned,
vlan_hw_offload_capable() is false for us, so we'd be inserting dead
code and we'd always transmit packets with VID=0 in the injection frame
header.

I can't actually test the ocelot switchdev driver and rely exclusively
on code inspection, but I don't think traffic from 8021q uppers has ever
been injected properly, and not double-tagged. Thus I'm blaming the
introduction of VLAN fields in the injection header - early driver code.

As hinted at in the early conclusion, what we _want_ to happen for
VLAN transmission was already described once in commit 5ca721c54d86
("net: dsa: tag_ocelot: set the classified VLAN during xmit").

ocelot_xmit_get_vlan_info() intends to ensure that if the port through
which we're transmitting is under a VLAN-aware bridge, the outer VLAN
tag from the skb head is stripped from there and inserted into the
injection frame header (so that the packet is processed in hardware
through that actual VLAN). And in all other cases, the packet is sent
with VID=0 in the injection frame header, since the port is VLAN-unaware
and has logic to strip this VID on egress (making it invisible to the
wire).

Fixes: 08d02364b12f ("net: mscc: fix the injection header")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot.c      | 29 +++++++++++----
 drivers/net/ethernet/mscc/ocelot_fdma.c |  2 +-
 include/linux/dsa/ocelot.h              | 47 +++++++++++++++++++++++++
 include/soc/mscc/ocelot.h               |  3 +-
 net/dsa/tag_ocelot.c                    | 37 ++-----------------
 5 files changed, 75 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index ed2fb44500b0..69a4e5a90475 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1193,17 +1193,34 @@ bool ocelot_can_inject(struct ocelot *ocelot, int grp)
 }
 EXPORT_SYMBOL(ocelot_can_inject);
 
-void ocelot_ifh_port_set(void *ifh, int port, u32 rew_op, u32 vlan_tag)
+/**
+ * ocelot_ifh_set_basic - Set basic information in Injection Frame Header
+ * @ifh: Pointer to Injection Frame Header memory
+ * @ocelot: Switch private data structure
+ * @port: Egress port number
+ * @rew_op: Egress rewriter operation for PTP
+ * @skb: Pointer to socket buffer (packet)
+ *
+ * Populate the Injection Frame Header with basic information for this skb: the
+ * analyzer bypass bit, destination port, VLAN info, egress rewriter info.
+ */
+void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
+			  u32 rew_op, struct sk_buff *skb)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	u64 vlan_tci, tag_type;
+
+	ocelot_xmit_get_vlan_info(skb, ocelot_port->bridge, &vlan_tci,
+				  &tag_type);
+
 	ocelot_ifh_set_bypass(ifh, 1);
 	ocelot_ifh_set_dest(ifh, BIT_ULL(port));
-	ocelot_ifh_set_tag_type(ifh, IFH_TAG_TYPE_C);
-	if (vlan_tag)
-		ocelot_ifh_set_vlan_tci(ifh, vlan_tag);
+	ocelot_ifh_set_tag_type(ifh, tag_type);
+	ocelot_ifh_set_vlan_tci(ifh, vlan_tci);
 	if (rew_op)
 		ocelot_ifh_set_rew_op(ifh, rew_op);
 }
-EXPORT_SYMBOL(ocelot_ifh_port_set);
+EXPORT_SYMBOL(ocelot_ifh_set_basic);
 
 void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 			      u32 rew_op, struct sk_buff *skb)
@@ -1214,7 +1231,7 @@ void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
 			 QS_INJ_CTRL_SOF, QS_INJ_CTRL, grp);
 
-	ocelot_ifh_port_set(ifh, port, rew_op, skb_vlan_tag_get(skb));
+	ocelot_ifh_set_basic(ifh, ocelot, port, rew_op, skb);
 
 	for (i = 0; i < OCELOT_TAG_LEN / 4; i++)
 		ocelot_write_rix(ocelot, ifh[i], QS_INJ_WR, grp);
diff --git a/drivers/net/ethernet/mscc/ocelot_fdma.c b/drivers/net/ethernet/mscc/ocelot_fdma.c
index 312a46832154..87b59cc5e441 100644
--- a/drivers/net/ethernet/mscc/ocelot_fdma.c
+++ b/drivers/net/ethernet/mscc/ocelot_fdma.c
@@ -666,7 +666,7 @@ static int ocelot_fdma_prepare_skb(struct ocelot *ocelot, int port, u32 rew_op,
 	ifh = skb_push(skb, OCELOT_TAG_LEN);
 	skb_put(skb, ETH_FCS_LEN);
 	memset(ifh, 0, OCELOT_TAG_LEN);
-	ocelot_ifh_port_set(ifh, port, rew_op, skb_vlan_tag_get(skb));
+	ocelot_ifh_set_basic(ifh, ocelot, port, rew_op, skb);
 
 	return 0;
 }
diff --git a/include/linux/dsa/ocelot.h b/include/linux/dsa/ocelot.h
index dca2969015d8..6fbfbde68a37 100644
--- a/include/linux/dsa/ocelot.h
+++ b/include/linux/dsa/ocelot.h
@@ -5,6 +5,8 @@
 #ifndef _NET_DSA_TAG_OCELOT_H
 #define _NET_DSA_TAG_OCELOT_H
 
+#include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/kthread.h>
 #include <linux/packing.h>
 #include <linux/skbuff.h>
@@ -273,4 +275,49 @@ static inline u32 ocelot_ptp_rew_op(struct sk_buff *skb)
 	return rew_op;
 }
 
+/**
+ * ocelot_xmit_get_vlan_info: Determine VLAN_TCI and TAG_TYPE for injected frame
+ * @skb: Pointer to socket buffer
+ * @br: Pointer to bridge device that the port is under, if any
+ * @vlan_tci:
+ * @tag_type:
+ *
+ * If the port is under a VLAN-aware bridge, remove the VLAN header from the
+ * payload and move it into the DSA tag, which will make the switch classify
+ * the packet to the bridge VLAN. Otherwise, leave the classified VLAN at zero,
+ * which is the pvid of standalone ports (OCELOT_STANDALONE_PVID), although not
+ * of VLAN-unaware bridge ports (that would be ocelot_vlan_unaware_pvid()).
+ * Anyway, VID 0 is fine because it is stripped on egress for these port modes,
+ * and source address learning is not performed for packets injected from the
+ * CPU anyway, so it doesn't matter that the VID is "wrong".
+ */
+static inline void ocelot_xmit_get_vlan_info(struct sk_buff *skb,
+					     struct net_device *br,
+					     u64 *vlan_tci, u64 *tag_type)
+{
+	struct vlan_ethhdr *hdr;
+	u16 proto, tci;
+
+	if (!br || !br_vlan_enabled(br)) {
+		*vlan_tci = 0;
+		*tag_type = IFH_TAG_TYPE_C;
+		return;
+	}
+
+	hdr = (struct vlan_ethhdr *)skb_mac_header(skb);
+	br_vlan_get_proto(br, &proto);
+
+	if (ntohs(hdr->h_vlan_proto) == proto) {
+		vlan_remove_tag(skb, &tci);
+		*vlan_tci = tci;
+	} else {
+		rcu_read_lock();
+		br_vlan_get_pvid_rcu(br, &tci);
+		rcu_read_unlock();
+		*vlan_tci = tci;
+	}
+
+	*tag_type = (proto != ETH_P_8021Q) ? IFH_TAG_TYPE_S : IFH_TAG_TYPE_C;
+}
+
 #endif
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 6a37b29f4b4c..ed18e6bafc8d 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -969,7 +969,8 @@ void __ocelot_target_write_ix(struct ocelot *ocelot, enum ocelot_target target,
 bool ocelot_can_inject(struct ocelot *ocelot, int grp);
 void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 			      u32 rew_op, struct sk_buff *skb);
-void ocelot_ifh_port_set(void *ifh, int port, u32 rew_op, u32 vlan_tag);
+void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
+			  u32 rew_op, struct sk_buff *skb);
 int ocelot_xtr_poll_frame(struct ocelot *ocelot, int grp, struct sk_buff **skb);
 void ocelot_drain_cpu_queue(struct ocelot *ocelot, int grp);
 void ocelot_ptp_rx_timestamp(struct ocelot *ocelot, struct sk_buff *skb,
diff --git a/net/dsa/tag_ocelot.c b/net/dsa/tag_ocelot.c
index e0e4300bfbd3..bf6608fc6be7 100644
--- a/net/dsa/tag_ocelot.c
+++ b/net/dsa/tag_ocelot.c
@@ -8,40 +8,6 @@
 #define OCELOT_NAME	"ocelot"
 #define SEVILLE_NAME	"seville"
 
-/* If the port is under a VLAN-aware bridge, remove the VLAN header from the
- * payload and move it into the DSA tag, which will make the switch classify
- * the packet to the bridge VLAN. Otherwise, leave the classified VLAN at zero,
- * which is the pvid of standalone and VLAN-unaware bridge ports.
- */
-static void ocelot_xmit_get_vlan_info(struct sk_buff *skb, struct dsa_port *dp,
-				      u64 *vlan_tci, u64 *tag_type)
-{
-	struct net_device *br = dsa_port_bridge_dev_get(dp);
-	struct vlan_ethhdr *hdr;
-	u16 proto, tci;
-
-	if (!br || !br_vlan_enabled(br)) {
-		*vlan_tci = 0;
-		*tag_type = IFH_TAG_TYPE_C;
-		return;
-	}
-
-	hdr = skb_vlan_eth_hdr(skb);
-	br_vlan_get_proto(br, &proto);
-
-	if (ntohs(hdr->h_vlan_proto) == proto) {
-		vlan_remove_tag(skb, &tci);
-		*vlan_tci = tci;
-	} else {
-		rcu_read_lock();
-		br_vlan_get_pvid_rcu(br, &tci);
-		rcu_read_unlock();
-		*vlan_tci = tci;
-	}
-
-	*tag_type = (proto != ETH_P_8021Q) ? IFH_TAG_TYPE_S : IFH_TAG_TYPE_C;
-}
-
 static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 			       __be32 ifh_prefix, void **ifh)
 {
@@ -53,7 +19,8 @@ static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 	u32 rew_op = 0;
 	u64 qos_class;
 
-	ocelot_xmit_get_vlan_info(skb, dp, &vlan_tci, &tag_type);
+	ocelot_xmit_get_vlan_info(skb, dsa_port_bridge_dev_get(dp), &vlan_tci,
+				  &tag_type);
 
 	qos_class = netdev_get_num_tc(netdev) ?
 		    netdev_get_prio_tc_map(netdev, skb->priority) : skb->priority;
-- 
2.34.1


