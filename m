Return-Path: <linux-kselftest+bounces-15359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF295268E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653891F23666
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1C1EC4;
	Thu, 15 Aug 2024 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z0CIwSDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF718D634;
	Thu, 15 Aug 2024 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680578; cv=fail; b=YwB12634SRW0JhntFAzpeYZ/Ak0nxj1sjKiuMt+Txjej2ffbrqpCIq3oPnE/v2oljQiskDvC9VU6ojOjf6DbvOMnmxy4t9eOQ2uZ5F3Asvdct0pA60TYHaREypViAFD1COGMh/fdX4+X/Al2wXCc4MHx47dvNl0UgtqwwUo0f7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680578; c=relaxed/simple;
	bh=J9E10ilEkc0v5nU9Vx3EbuA5JtLa182zUx1cYU5XrKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jvyZ0+HZxnB4K/NZOWI4oZmh9twHAytajMQ8jeEDPbj3EpnKmfYSj4imyWs0U0M29T7FGerzdgPHJlPGm2dYF9ys5uF8MHk4lkQh/3XC/VjG9c3LYTBB9fCFf7yLVaxC6TDCxfNdbIjmkqgt1AZOU/55BL4UhKFMbcMllNy5S6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z0CIwSDL; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydl09aAFThEYeR6+yRKQNvgJzuHfo3b5IhJmEud10sbsIAql+qkqVNewOdHd2iiPFfi9rZJ4M6LWXr3+xrpx+oU+9Fznr1d81TaA6f5mZ0Siq3yZ3wFAyZIwT/uhZtkpp4XFJLB5HwXdn3kWpE6OBlBlo/5Qug0AfROLj/DuFjIo/EjwR1EC+zlwUfgguECK6L2oOuLITlDH5amg/4waLiPJLPhqniEGlVWTTHbI8laNKBBE3877JlZWWPFK93WVKXSXo+WvyrETN2fkQb4d9ewh5pQiPt1yw9hCjb/oV9S0IThauS9utnCQVK19uBKSe+/tGNjFAPSXakGWnXwKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqTB6hAXz3HNHSntiZ19+++LKg6qLNq0aRsiMC5+8Es=;
 b=cPZ6SjbaBdS2s4pG8SnTxAS24wvGSutfjoLcexPeyJYm0HasDRAxbuEEnKP9Rtc1pAtntf6mcR84emc6JBxw0dCiFRtDmaviEbD4Fya61YS/rq73spTFvAalUdsV5fc+Eba/zF9HROK3ZMbzFTczLKrDmotWeVHu6gM6IavjyiYBmUeT9HetiMcqz6wPuqLpMKvRP1BIjieQp1EfCkiZD7pa//A2MjKzoGS9tc+Va5RRVgtzQMWoyedtMpYK/yU2xszQZi4lC9Yp35fgm5WN+zoyGKbk5vQqRcVjtYhbQTSCLYRxlb0NW5Aws2Q4XXQWJUWsnZni3a0/RIZjRmU3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqTB6hAXz3HNHSntiZ19+++LKg6qLNq0aRsiMC5+8Es=;
 b=Z0CIwSDLuR5N7/TXR5c5r4IjqFJvtQmdUR6cahA4Rj0ZBs8rxNdG+4QqzwDgzA5JMZLk7VrZNMSlJQBCQmW/l/5gozcoSPbg19ABBwwC4CvU8lAc28nmxB7TtQ96VqZj2gklyANZrYJoQ949f0rdFgcTLtvz5LF1Quxo9wkvGxModbbFJRbUBELtIduPB9jP8D5xW0cpO0b+U87Hr03JdFnpA49UChWRJGa4oWsHKKqH5rHFOX0OR8VLALzadyWrDimQ3Xcm/YbGS0fzOiozSfseMSvgmQjlUHTkgLBf/H1DxWFVugsgm/UQrlfh8cy33K9m5iaV0Bki4zmb3i7hpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:32 +0000
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
Subject: [PATCH net 04/14] selftests: net: local_termination: add one more test for VLAN-aware bridges
Date: Thu, 15 Aug 2024 03:06:57 +0300
Message-Id: <20240815000707.2006121-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d95289f7-e3cc-4d2b-5c3d-08dcbcbe89a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4U/W5UeYjE0loewEdqTqbvA+ZRG1/N7yAGb8qRHwKK4i+KKskUK9CAu6rcL?=
 =?us-ascii?Q?/dr+BdpYD0gOcHwuTF7mgh3SBH2BtjqjpbScH6Um/82z6tvu+GQxm1R37roq?=
 =?us-ascii?Q?3D1DbNXfmpsE7r/TE3EXf/LLNcdee/pkvbuMvfQaEHIs26ajRVihejQZPuyt?=
 =?us-ascii?Q?1sC82HiOHpx/OZfhnFQdt4oDElsvgG1en45dTMXlIN7VAO9/1TWedAWvj/GB?=
 =?us-ascii?Q?9v2kg+mC06XJqfwC40L3iYdVu4B5msXRjbRFRTBKNgwODuKVdIo1DiThykbf?=
 =?us-ascii?Q?y6BRSGdlHNeyEih76yLFQVy3E0e1+XhiSywlMU+9VkWOUiPQzFCoMI/kii/U?=
 =?us-ascii?Q?SH9Qzf9/ItR4Re6sJinhH+ulXYKSIiwfXZ3rOuoW5GCHwX9Fjm3C9IaIZFd9?=
 =?us-ascii?Q?O/YcdD0DzB8qviGOUGSzV9CoAAAnfPG/z46SkWa7bM+9BzSTk1QG46tNxCNn?=
 =?us-ascii?Q?ow0C5eLA2z3sJXJXMVSmYTKjk/9tKhXZjGvVj5B5oDP4wc/CfJSodadAAml2?=
 =?us-ascii?Q?eTaNhQj6c8DizEfc7l1QDK3Cr1Jfn9HvhPgbAJFg1Px0qYHOabt8Jomp23Y1?=
 =?us-ascii?Q?t+uFDAWcqIaB0l1ZdHBZXWRMIexSWumO2x4xetHt5DVDwn9juyMVnk9GmEEv?=
 =?us-ascii?Q?YkM7toQX4jHgT/uUi0pRKdA8r0rQeEatZ92lS26m7FN4OGeyOhMsQObQ80Mv?=
 =?us-ascii?Q?dqxbgAOa7XBggmJ8zKJE3u7YfoOZWFpNfau7Wqvy/6W9uZvDUkELN+v6zoOo?=
 =?us-ascii?Q?UzS6s09QETK6OokdA0LvCoKyjg6ajQw4tZIDNC/obdfK7RtnLVKyWx7QNf+b?=
 =?us-ascii?Q?hlUe7Dk0iTrDEvGF/JuW4qQ4C9zEhdoh6Hs+Jm/IgWQcZFqf5V2O0a7uQtCF?=
 =?us-ascii?Q?12Z/qHrChY9cJ9RPwIu7uyPH08RePEin4fpBgCVUkg3MUuH6wHNKnNxDMqFR?=
 =?us-ascii?Q?mCd3E1BRPLL6C6ZYN9DiPNHai7qeaAEVpi3bk6ZOFGHft+SH62JHe/R3hgvD?=
 =?us-ascii?Q?xlezmxiYMM6Vz28pYW5NpGIWIJFsJIkh39SpqhCJQ88nXPrvG8lR1KY5xkaZ?=
 =?us-ascii?Q?fApS/j8iuGYN9D4HO0he07PjCxE+jhrwbfTGDdDPLeYvZGZdyIiw3hzHwFhJ?=
 =?us-ascii?Q?9e+fniFfnsj9PouhstUsHX7OECmrwq6qFMyEocHYDcPOc6g7yg1zIoXGN9/s?=
 =?us-ascii?Q?bLm+mdyBhtZ0lwwPGa0JX14JiA6HHqZ8zr1AjSOItstYBmNHV5UtG15QqFJu?=
 =?us-ascii?Q?Ko6WH5WUR85rYvak06Bwrg7Bp96BF8RZfaHaDIzBONQK/pxkrZ7z3EEgFD/7?=
 =?us-ascii?Q?TKessbKAHvytRoiOMcp25aA3JyjVD1mIgeRXjd+C1hSOnbjeb3zsrx4lPJDF?=
 =?us-ascii?Q?7V+8JsDS10APCBSDNqkhDO2OCTAnkxZv1V3QLrCxRkrwJAHtHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KSVgqf1hr010rQiM+xptU0XuGJcHMmrKRAqS+MLLHpGkGf/62CCzy1ulQ2N2?=
 =?us-ascii?Q?hk9JLUM6avk1og+HlmgPHmO6D9Q+W+AqnOXo2DAovUGShkn+aFUP+NZ0oLna?=
 =?us-ascii?Q?qTHczRfLT3DIG9aX4hlsNDLlL34oxDVP6xrwBok/xEYAyrYoKoO6JhL49KXQ?=
 =?us-ascii?Q?QodOoVVLhoQQRZoOXQuaWElf8zJT2RcE4cWKM8iGGytfdZXDPkEGvSotUidx?=
 =?us-ascii?Q?VSNxETQwRGVJlVm03880OOaAZX9c3KkT0tkP+rPlep05q0FWLYnbMgxTg/o6?=
 =?us-ascii?Q?oDUux7oZBicw3AKYnumzQWpJCjF3NXlDgQ7xUI+n0Tnr2XRiwkeqS7n85WZV?=
 =?us-ascii?Q?L4gYEivDGSHRAvRM55Ofrs7/rhcp5hEofEyAXJz7dASHddXgEwFR1I6cQtCq?=
 =?us-ascii?Q?Yjzyg3uTbSXTCn2ZsUCmPtTtVC0z/xefXilAE/rFp7sVO4rQDOO7aKBDAhN8?=
 =?us-ascii?Q?DRNHy7Lf3bFUpl/5G2d4isfSbZVOMoc4HmDwztm3g+cb4AYV+dSX0B1mLy+y?=
 =?us-ascii?Q?kv0CxrJpkzXsicNoipg/vb19IMTp8ibD/KZFVvX7SjjSeSyB02XcIYrmBil9?=
 =?us-ascii?Q?ZSfLoQr6PRgPaSQEUBL38bJpS+KbrcPrZoDCD3EWk5Fz3MbnpUln01ObeOeL?=
 =?us-ascii?Q?5NGs/dYSw0cLBkxCoOqbOzsScSYwU6LNlgQIzYWbDdce+6idpl59s8gvSbKv?=
 =?us-ascii?Q?EXelKmjll34pdqej6R4FWjXbz35UrUVtOnQATzkWD9bixokTVRbQxkNU5ugn?=
 =?us-ascii?Q?LnSP4NFh8gVSv1Hed92/3uBL8kNAy4Xmzg31Nj3uTjo+iIrs8tNbFbAY1fWz?=
 =?us-ascii?Q?xBt1utQOa7K3Bb+mWZzQZGvpAY6uxVk84LMvBYedFoENnDwC1bJ19UuDRUMm?=
 =?us-ascii?Q?RLct5lniFq9EEnJ3/8Pn7BT1qE4p1hdv7C5nMZVkMQVpuFhCvn78/XodxE0A?=
 =?us-ascii?Q?J2YFvTn0XjHZsz0Too/ZJN6R+lbCcDTiVrpfBSEUz6sCSop873XKJRHZv1M/?=
 =?us-ascii?Q?fUe1h8J/sn5eze8e3I8lNya+ziUFSGlnCuwnYWAYikFjS5Ru3mMD/VaW4rpw?=
 =?us-ascii?Q?A1QRsn86/h+nUJ7y4IMnHBHEShFy9yyS3Sii/rbXLhPezxmTsZdBkxBIM9xK?=
 =?us-ascii?Q?tJIivSE1I1cgezmAXUppBXvkUpcHnZWXQWRqryXItQoZzMH5kj865p3s0cij?=
 =?us-ascii?Q?64BKcu6qYPaKUZNzHNRlfEiRLzqYcxkJEl+RkfaQelsn3rJlbO1ip525CGqr?=
 =?us-ascii?Q?c7GcURcd5sL3HXXMOrbA3cQBAh7AIl5ooulICY902GbzWaNznUVqeiYl2Tfm?=
 =?us-ascii?Q?ufZ3CuVStoeoiU5x0wg/wm0zNB3eKMsH0BNQDUDlQvIRQwxBwNjx5m7Vhf3y?=
 =?us-ascii?Q?EqB1hp1sc4XVoHQDzZT7xKiAomTJhZ7ow8oTERZCazf3K1r8EpTa4a5zi93p?=
 =?us-ascii?Q?icErULnh2XzgLjkpCdMvb/5KbidDSEISIMRK/BdcJzF8xAYoptjWIVKb2bbd?=
 =?us-ascii?Q?WPGY5S4qvNlsVfe6o375NIdkI4M2/Y0ArFMji5isqVbMRX95F+eJOptxBqF8?=
 =?us-ascii?Q?t9/WYWISfOThB222/6CR9pa7Z2bGx1q6xwJ4IfIEQdhgVNyl+6Pc9HK6x4u7?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95289f7-e3cc-4d2b-5c3d-08dcbcbe89a0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:32.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbXOWdTGVWETKNSRWOvvnxAA48pxL6lkni5sr+mYcuQopksGn3W9eyI4wrIgG2MSKVAqKO4sHidrRiW3MVV/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

The current bridge() test is for packet reception on a VLAN-unaware
bridge. Some things are different enough with VLAN-aware bridges that
it's worth renaming this test into vlan_unaware_bridge(), and add a new
vlan_aware_bridge() test.

The two will share the same implementation: bridge() becomes a common
function, which receives $vlan_filtering as an argument. Rename it to
test_bridge() at the same time, because just bridge() pollutes the
global namespace and we cannot invoke the binary with the same name from
the iproute2 package currently.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/forwarding/local_termination.sh       | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index af284edaf401..5aa364b40e33 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="standalone bridge"
+ALL_TESTS="standalone vlan_unaware_bridge vlan_aware_bridge"
 NUM_NETIFS=2
 PING_COUNT=1
 REQUIRE_MTOOLS=yes
@@ -233,7 +233,9 @@ h2_destroy()
 
 bridge_create()
 {
-	ip link add br0 type bridge
+	local vlan_filtering=$1
+
+	ip link add br0 type bridge vlan_filtering $vlan_filtering
 	ip link set br0 address $BRIDGE_ADDR
 	ip link set br0 up
 
@@ -277,10 +279,12 @@ standalone()
 	h1_destroy
 }
 
-bridge()
+test_bridge()
 {
+	local vlan_filtering=$1
+
 	h1_create
-	bridge_create
+	bridge_create $vlan_filtering
 	macvlan_create br0
 
 	run_test $h1 br0
@@ -290,6 +294,16 @@ bridge()
 	h1_destroy
 }
 
+vlan_unaware_bridge()
+{
+	test_bridge 0
+}
+
+vlan_aware_bridge()
+{
+	test_bridge 1
+}
+
 cleanup()
 {
 	pre_cleanup
-- 
2.34.1


