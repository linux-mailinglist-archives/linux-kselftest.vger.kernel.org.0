Return-Path: <linux-kselftest+bounces-15356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C9952685
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F2C28329B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8881929A1;
	Thu, 15 Aug 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qxlfva7B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF4A5F;
	Thu, 15 Aug 2024 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680571; cv=fail; b=D48WzjKBiJf3FqVg+98hc0CdP2mTj54gFR6ekMX4Ula1G+oTnMSBeiBYB649C8yeDt3u6YPCrTKApnyNkUO2mQG5B7ERUicPGSgEd833WPc5AUt5vDDkq29IJd7spCBKBlBvWq+68JGR7DL+vW9aBj5eYSqjCQneQEwj1B87YUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680571; c=relaxed/simple;
	bh=XLQqw9qGpbaI+f1SJO9XgCFqe1LzNvVZapeMXJOG6ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGVogxpOAhbhejVqBEP8D0UFMdOilyPDFo143sXZT5E9hdgakNPUeX9VlgIWiT+4RXJf7llZxm9nwxTLkqQO9VkxY+vHgRFJEc690oz+220Peuk9JjC5AjKJGatMzdmWWv/z5Y1M1qJEpJpWbh61eqjJx8dDS0jk4Kru0SZTaxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qxlfva7B; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJXhpoe66zeL5v7G+8dgP65gmttTUtMO0ez5XsJCehFZfoSasGOvLQSArqLlUkAVKKROFguYyteJ+Mw4Unt5svZeABxR7OdZmF/qLTAMUx/opoQshAmlZlLtuW4RWV4oO1qUfXD0uhMuQO6sYsPmRGg1f2uWDVUY7HSGbz2W/eRYvn2HT5zsThjtqkjMeSkSq4IZg8xTr4Gx44m72TD7GUelvnm14IopefA4qOLv8q525WPUUdVvuoA6LtXbofP4P/ExKqq7fiDLmV9igvLIaBQzXH5zd+nKjo11FmhUehFU5GJBKCEV5Q8DokhQX+BAqAL4DCymcVVRwVrKnrIBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpQPqjpxvg5cga134G8GkigAdde7bePZD1zsjo13MEE=;
 b=LV3MNWg1tyGM3F/A8ysTMElyvFdPFHOchbQtjpH3Jltvh6FpVly03IJEslhJ+MboAiqUAH7q3R7Z5O+gq3tnpI1nlwYO3RT8ohU8IrppZOzv0nw3J9bWLVMSQnNYD5JrwpkmSSkG2GujtFcGCX/bglGcy5dRnbS95TNGtPeVlE9vdGrgiO28ChBPjy7/Ub5EwX8C58TxfzKuYcEW/9njQOvOdmeAmE27XlgOBbuHsquvpzXshMfGh6blOoBOP4h8Y2Cey00ojdHJVvOnm/iS+jLUGH4SyfezS5K03aPYRBxqeolzLlmVtoQb0wAA8DpkNPWkGfOi1oj1EXiMhK6HGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpQPqjpxvg5cga134G8GkigAdde7bePZD1zsjo13MEE=;
 b=Qxlfva7BJB7vpMOlAgl/7FNjJK7Z3c5UjGRGpHxt4NujDU20v0/TlPEwU5w351GezmkAuUd7NuMZ3iTGUC9BfhegYazlE2oe4zh7BAGV6k9+exKTKuC5S27ajPO3TajobN5Gp+oOBOJbzPxVcRwKDQNeG337QKiHsX/eqIoxI783PZ2eDcXcVE2ybhhzHFgJLkDPaNWb5V3dhXYpsA3zwYwrMCw/16P79+eAtYTZKt+//Y7wDs4KxDEkmdy22d+qCzqbsmps5fyV+Tz6tVBQLTNYtKyv2ae+QH336mKxuaOm/C0sGxxt/k0X/hG0H0GNDgjiwK2HiIF1ng8kHcAyEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:25 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:25 +0000
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
Subject: [PATCH net 01/14] selftests: net: local_termination: refactor macvlan creation/deletion
Date: Thu, 15 Aug 2024 03:06:54 +0300
Message-Id: <20240815000707.2006121-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f147f40c-f3f7-40b3-e823-08dcbcbe85c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ynCeM1L5cNpAEazSX0hOQRiIlbXnPoHoxS88Iq4g5d+9NWR5QIeW/9wr8+4n?=
 =?us-ascii?Q?qzMI5SnasnzpgND5YfheyONtw5xl7nwptUuQthU/zkU8gipOC09AlzsPMbwi?=
 =?us-ascii?Q?7PWuXYFnFZoDgRjxWl9kupjghFsj2N1zWN/s626EIBVXmpTKZcjdjeL1bH/A?=
 =?us-ascii?Q?oWw7Ijs9uCP7NHlEjl1c4mbFlWQp5Ve0v6WSow5Ta0WFsPAD+zQ3v/k+pBQD?=
 =?us-ascii?Q?La3RDZUylRtf5dhNNpPPVnPnXFGf0s64C5koY7zdgLfRgSJ9v1bxMcRAMKJv?=
 =?us-ascii?Q?kiyITTG7Ng4MYx3cuN4a+77m9iktkA71bZ7ZXz1+EEt5OYGMfq4RTXxkSB/Z?=
 =?us-ascii?Q?ViKP/d3UMkYZWtfYiRCIl6o4zEWgdfKUp+nyjN4b6oO+TPyGyUuxveDu6o+k?=
 =?us-ascii?Q?l79AK9vgVxZ6iR0lXGhNiMdIDynwtYsvzEehKngQU9/fBxrra1Q5cFTM+Y98?=
 =?us-ascii?Q?g7VAWIBI0KHMA2WTQrKLRpdCqv/QeehMdjc6rH2A00gxKb6qc4d7sWmhAj5V?=
 =?us-ascii?Q?8cbSDdAi/7pnQATGWzkH9jWkXX9q3l9+DKZNCTMmaADPv1dJQOuq0yPG3XUA?=
 =?us-ascii?Q?lwIruCkfiqzItjl0FnSOQ1TMXmxf8hYGuy4PWROdw//7yLMH6a+a4CatL/H+?=
 =?us-ascii?Q?Y1hNguWfRieG2nvI/insQf9gSiNm45pifnpkJBorPrJm4zABWrNw1QDfmEVP?=
 =?us-ascii?Q?2HCs1Bs3R04az8F6ANJyGzkl6df2jhqusMz0XETAQVhSjJM1hUwHrVuDiuDw?=
 =?us-ascii?Q?enYxE15Ak5Oc6HHAJsQjAtpSCZkDWtRU8hxXTwbegSm+1gKsZ08vq4BN4xqS?=
 =?us-ascii?Q?OmyQehankZZzqJ6JYvwkbI2Q0nE34wxFxMDhWL8eWHHaNnfa3DOqTdJzFvAM?=
 =?us-ascii?Q?1Dg4cdu+VAwE8VivEFmaxNAVKAOCpvntAJfD5lXQTE8TkhhJbi0SENoWXasg?=
 =?us-ascii?Q?406U1k44fcSbqq7ZN4z8Agz2NNuSY/r7dKjKm2fDR+cMN5RW+48xVY3a2JuU?=
 =?us-ascii?Q?PxXIdgtJZ8CY78UTJmdVKg0/j/f8KkXn2zsq6fmskyWiypq38tFnje+10tHu?=
 =?us-ascii?Q?gNxdYzZOf7lh9rFarly6T34ZewLKtTK/mpuIkG2OEXvPOeBgLI8ZkT9H0BCr?=
 =?us-ascii?Q?saBRl5HRsGXNGtVdZcV1Cn0xywg96QSGllDR1hjqNwmMEgh7k441NZKZCRW6?=
 =?us-ascii?Q?ggclRuJz5cNl1JfgvD/CNBSNTL907RduB4igbfoB+unV6/4+n65IBcnjU5nS?=
 =?us-ascii?Q?SVpo5c1D/uAjWDHGDiQ8eGexgCzGXjoiQXO3nM+hh1hGjB4CG/pxzVv7NhbW?=
 =?us-ascii?Q?QhHVHDZbkFFvY3bYY7ws6U6SdaPUoe+nQS16NrlB81Dx31D3tGK+lCmnu5gc?=
 =?us-ascii?Q?UQGW+AbstUfveyW07BYIS8BpN+M0uT4UsIubJOk6EXGBWl0eAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NO42McsfASzR8qDifiNA7QUxw7EmTz7xA85OpEcjLAVWUvCtKatPyw9LfUr?=
 =?us-ascii?Q?Xfyjz5A428GT0/x8f+PPpA6nxolGEyM3NoiI9wGLevFelWobxpDRRUgiQk5K?=
 =?us-ascii?Q?cSapBVhMO58MiDIRFPXPEbsW0OEOM3SqPTm4yvPMz5uGvfzwZ5Zc65vDpBLG?=
 =?us-ascii?Q?kTz8cQKK9qAsNols8RkpZeqU1P0KWP/GjJMtnjh+/bTxtzkWyiUJmtqOt7Wr?=
 =?us-ascii?Q?OPGFlqBAv11dxpxDulpQZdt2FiL1yoPQUEiX6zRlJpf60xuFhsq/4xRp4pay?=
 =?us-ascii?Q?VgFHmhS5iLDaNmIR+zXHfNsA6km2Zu6aAMhCeIzKaA0/1ZeLyyWxtgiJcbaD?=
 =?us-ascii?Q?0Ftrl/f9r0yHNGM33E3YyOmUGLWLLl3l7iHST0xiHaK8Rf6djVRhzY6je08/?=
 =?us-ascii?Q?y75HwYdc9VsyjILmn1f/J3w3W88SjeUYscIBB9eL6XSkxzwx2dB5eLlb2uoA?=
 =?us-ascii?Q?qnYheNHS0W4wGJFaYvksrcrkukd1dA4DZEu0ITf0LB908dLC8gzLkeoTEkHo?=
 =?us-ascii?Q?KPGTJ4V/uOm2RIrywhbKG7TtBo9Me/zSyIL5kOXdBzSWGTasSDMOaWiovC0U?=
 =?us-ascii?Q?S4A8lbNd8nZNF+9NbkaK8WP84Uy0oM9ricR30EQubZNAw9W55Nsx1dtyluXP?=
 =?us-ascii?Q?1GEGuS6C7a5RnXzAoZg1ePfeiVVoYAk2pfFsT9Zg5+IKK56mSSHhb8QXogio?=
 =?us-ascii?Q?Wa3YM66DPUBU0nbI53aqsLLEzSz85GUD3tOQ4eOnC02ANbM8QM6bgpMZtB/V?=
 =?us-ascii?Q?i/LBEkllG6Jr60H+zT/6tLDB+/F/qQMDc1TCJsMQ3tA/lu1Ki0rlH3odJsez?=
 =?us-ascii?Q?9rrioY1k5yP1QTjuKR+rjX1FT7p3O8OwHeaxHOQ1RlIDygL4nTKXoV9ToR3A?=
 =?us-ascii?Q?cKpn7hBpCxD/vh/+0ueA9VD96pA8nOa10RiB0nBRUCJHPmAGAYKOTceEu1IS?=
 =?us-ascii?Q?IxNx7wFk6agUCdGqrwjA/GzUWmLpAKeQ9ijZVs9cG6iM0vZ17KVHEokTvxuk?=
 =?us-ascii?Q?Zhoe02TJirnaslxdNXt3kxBQe4pLTuaS04Tvzv5n2FnvbKgF6J8VNLsWPEI9?=
 =?us-ascii?Q?va5Szmg+yr0Jo16Hq1lraIv6gsKaqGgnsXsi5l8ytO9kCt6DbS+9qHMwt+gR?=
 =?us-ascii?Q?oX1sMrYsAbds9dh2KYstEYeYFmUAAD91NVGB50qxfonZmR97wKPZz4cLW0yi?=
 =?us-ascii?Q?tXh6TPMpEb2J5DyvdsHrTxNFprQqkzxBs2bhEYiv192XHqvitrT+hMOGAjdM?=
 =?us-ascii?Q?wHKYrVdR9S0TwJARbCcZHXyDpZcMA0IXc82dPcyhPXMpIE/XoVlTVBSqWV24?=
 =?us-ascii?Q?JET4lsPUmmyFP/9AJubFkDHv86TMphGbuoiyLp2z942xPDs2ilQ92oflm03B?=
 =?us-ascii?Q?Atm4mD3FFupNMB6Xbs/BjvpIEGxYVk9IbPGWmNOPcpdUTmo9+dOcvN24Q0eF?=
 =?us-ascii?Q?evV0x+xnemD/uDh5BCty5nPTWYFS7foSkXovAkdqmK8Pj8nJoKQxl+RguNHp?=
 =?us-ascii?Q?X7Bu3pdrl+nkSqg4nso62/wAwhuu1rvtJj6TuwECrrGFq2WwpBlH+YfQM8fF?=
 =?us-ascii?Q?7j+W1c7qkCs52xlOJisJFpU8xj+KLA+tQ7tjkNtQAxABLbffyLJfYdah4JwH?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f147f40c-f3f7-40b3-e823-08dcbcbe85c4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:25.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8e+rVuCfj9w1DAJcSez3oWBgTmcpMkDCJxSufDE5UPqhoVvGU/2V2BtiVpWi3Wrv2GLyXZncdfJFDf8ICpDU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

This will be used in other subtests as well; make new macvlan_create()
and macvlan_destroy() functions.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/forwarding/local_termination.sh       | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index 4b364cdf3ef0..36f3d577d0be 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -247,19 +247,29 @@ bridge_destroy()
 	ip link del br0
 }
 
-standalone()
+macvlan_create()
 {
-	h1_create
-	h2_create
+	local lower=$1
 
-	ip link add link $h2 name macvlan0 type macvlan mode private
+	ip link add link $lower name macvlan0 type macvlan mode private
 	ip link set macvlan0 address $MACVLAN_ADDR
 	ip link set macvlan0 up
+}
 
-	run_test $h2
-
+macvlan_destroy()
+{
 	ip link del macvlan0
+}
+
+standalone()
+{
+	h1_create
+	h2_create
+	macvlan_create $h2
+
+	run_test $h2
 
+	macvlan_destroy
 	h2_destroy
 	h1_destroy
 }
@@ -268,15 +278,11 @@ bridge()
 {
 	h1_create
 	bridge_create
-
-	ip link add link br0 name macvlan0 type macvlan mode private
-	ip link set macvlan0 address $MACVLAN_ADDR
-	ip link set macvlan0 up
+	macvlan_create br0
 
 	run_test br0
 
-	ip link del macvlan0
-
+	macvlan_destroy
 	bridge_destroy
 	h1_destroy
 }
-- 
2.34.1


