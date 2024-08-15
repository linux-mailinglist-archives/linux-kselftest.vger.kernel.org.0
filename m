Return-Path: <linux-kselftest+bounces-15360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1EC952690
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6F41C21BD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770C18D647;
	Thu, 15 Aug 2024 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I2XQBgwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6FA18D63F;
	Thu, 15 Aug 2024 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680580; cv=fail; b=p4HDmxRvqg4xRh3WMCUYE2Nu2rPU4OxkL3z6/EN8g+OhZPI7zvIeFJAI0yJMoOH7luCZN13K3Eqn8JBVCbl0wxm7+ee8GZvrq01QXNDDfFASnfpqSbN617HXuz8+P4y3RAEO72P8a1wmZrDEqakxSsaVGwvmKmUVORcb21HdVNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680580; c=relaxed/simple;
	bh=pcjavQkcbyW+3dxD/qTZhKFDigvWBQqvfT2DOgOJwDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V5XRGNGHb5QdYYzS5se/Ifoqssn7AG/U7zhm+vdYgGR2HUVP89JmZDJbNrS6xlZzaUmCjYV+X3xTgHguMx4zsQt6RBMIbBfNqQhFRXbc1F9R/AfdVdVF0vmWs8IUqvTkn+0qYwYRvDpvevyz6Q1o5kO9TtZDm3KWAwjVKNP2wT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I2XQBgwr; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQ4Fug7Z5sqLI4DiHrIK74acalNhuYe7uaz88hHrVJpwTUw4UtWosJpOCPe1RRExvw77eW3WVFz4EQxNas/p9AoZ1PlpsnjHYS9nxOLdKLcxaP0GYSJ64VoGsxLySJO+s544hqT0DwAuwV+QJk+gRFXkCz+2ZW1V876cZo/5xqjycA4mZ7jG7WpbIrxFcIDZ2VS7StZ486OO5mtO4Gb+1DjL+xgxQwD1XlDZIGaTUqicvLBdauBsIWcBVXTwEVwMCMoVYg0wcG3FC7tiUKb6TPgyTsOUGC9ATl21hawVhwgBfQGM339z78J4JwFNexBw6VE+hRB69XEtuNPZsdX5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q1iWuTX03yxGDOOqYhE9jWi8hCJOF4tyGzrZjEodVw=;
 b=oAcibrCX6FZzrS3Z5PxTOEiPGiL4ncInEVH1QFrzJFYFzix7knQmeWf/rR2tIPlLmjiOMyJIkFXlriX7ClSzUrVrpTBN1nTPkPME4nV88cssZeU5vn1n+PDPDmtL9KfGK8xjdKCmsqF+0otaY+RrmfAGF1y+Y6utDBYWIroygavkF99JtZuosi4DsALnqPeOe+Jr2XAIW2zN+FnVxphccwnsX64T7ioWLejqnDMVZPbJArOxLVopI4T7YjZzWYubq5tc2eLZeT3Vi16utO99O0fW1QaPLvR3nNZGfqbm0+cM9FxYflz172GvureuEAgc5ZUiIaEX2MNKzShIgi/bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q1iWuTX03yxGDOOqYhE9jWi8hCJOF4tyGzrZjEodVw=;
 b=I2XQBgwr7Akncbh7AIoWe1Utbv/SeuB/GLw0QMfj3eel4nNqlZzMg2GauL4n0iQqBDoxG7cxu1Q+pGhUany85iNiRLA7UI3HBZakF4PewnumVvqD4fADEfba8Os4QsbSOSGdqlafPIXtNTo0/rkdPE388U+aoay6c8sd9sq3kVY6n1WquFf2sh+mALLmppDtteeeRc8UWK7Gb4x51B8geEmyWCh9HJNcOBRm1644Df86JlWcR0mPompIAnlgy8L7ut35STIPKgzHP30btoth/Q9Teb9K1ERsLzBz3V9gJ9IhejVW1XDv2yEdS+klIFMPBKC5OQXTesCmAUjx8eyXDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:34 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:34 +0000
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
Subject: [PATCH net 05/14] selftests: net: local_termination: introduce new tests which capture VLAN behavior
Date: Thu, 15 Aug 2024 03:06:58 +0300
Message-Id: <20240815000707.2006121-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f08b2a2-3cdd-4c57-77e7-08dcbcbe8ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvZd0epN/HU0u+UItTjo/fkmXVf+vXUzTtHJPrAZgsGnUewbj7PR6uQ0BZMB?=
 =?us-ascii?Q?Jf07aA+xHZCScYOE0GCNdfzjxMhjcnwCP5ht7gIjCkKIt+GaXaUg/waTuV2L?=
 =?us-ascii?Q?0SNhF2pMXudsJTSWrsPsJ9bj3u2Q6FdrZrT4aw4lVfyw7ShSxFvMaCq6rQZ1?=
 =?us-ascii?Q?jhXk2DBsMvpDuBp9RTJ35X/Om8DNLdc8wQIbFmxpsDzlL6i21WD4mOgsowEx?=
 =?us-ascii?Q?jjhhEMrhBXNBegNYR4wayvGeTM6BxZDBxBqZiA/A/gK6TvY6l61ACAgbcRC6?=
 =?us-ascii?Q?Gove2ArHAYkn4bBlcisjuAPsKR2MbU6Sf38jc5qHgF4VGqqG97G6GM51Gbt9?=
 =?us-ascii?Q?5dzN/kRkxeBQr00L+CsBjLx/GsrH+mO4+nZMBk48n/yihFvwEg22atbf2Gnl?=
 =?us-ascii?Q?fF9T3DnQelaLpNdyJ0XbUva8PlbaN06I+Ae/iF0FcGRIBMfdzHuJ2jKjJI6o?=
 =?us-ascii?Q?8hIkG3G8D+S1DK9991ItIKlcix3pfuVxd2xcMjQuj3lCm9oPvX2fCd2mclkD?=
 =?us-ascii?Q?yDX4368SSSGJIQHzClffq/gbPKbQgnySqkxmbmimS6oGvdq5BcoFLvTOOwM3?=
 =?us-ascii?Q?bq107gfMtbqfr/T5I6XFHXJsQ5BFfmVdduZo1TgWUbcYgyz9f0qF0RE+RqMi?=
 =?us-ascii?Q?3rBf1XrBH7mpQZRE+UJWLo9HDpoiiDCTIXaFI0Jbti/HATxi2EdpWp0VE9Ul?=
 =?us-ascii?Q?WdGllP7GUjgVX/QdOJOXr5R5Xw8SWQVBwAE8KU7dL31BwV1yW527nJ3hIlhq?=
 =?us-ascii?Q?0TzosuOLOQlb5mPKbtNBtpDBReYr0KbV30K7WVQhHKuu5omr12/hlS1dlmfU?=
 =?us-ascii?Q?mjNeqYdCyWtqapWSfLNWa5ZHfBzB7a39fnRr+v4Y3HcpshMxjg6OyQcSAjXL?=
 =?us-ascii?Q?8ZFGA76FyYwRmyrbjWqUT9ox+0TBHRZpJ+emKdqMLBmcHkbpMxwlPjkPHgrc?=
 =?us-ascii?Q?pzisWwCJaa7wmsdgJJc07ruUdWgI1wK7FlIEdkBqBCwW6lx8MNRh989nXtam?=
 =?us-ascii?Q?gFe6FepXM/YBYF6skl73K1mEHvCSKqnQQERfMhW5Jg2LN4wdLXqV+FHfHeVQ?=
 =?us-ascii?Q?D5KtmfodN+s7ofrDiN8kayYcW6J8+w1fyk/XvAXc4aMsW0syRthJ8KYXvV/u?=
 =?us-ascii?Q?TXG5oWBU9rgvtITCzpkgt3M06cMMLMwDzo03hMFjBVUy87v6yizKhmcVY7mh?=
 =?us-ascii?Q?tyf9n89VaGSdTBpG5In7Y5elQPEKAYz9vMwnhMuFFeCEzPL0TLGw3nQgdVUB?=
 =?us-ascii?Q?cCfhyZZQMSLjfxKkwns4FrqdcCMzWS2E3R/DhFT+TgBnCNxzsIQkcROrST2y?=
 =?us-ascii?Q?6n4Y02N+QlmGVeGmLaSbE1uuo+beAsi98SXXFg6eoGqP0S0jnXwt9GkbSOoj?=
 =?us-ascii?Q?HsS+QW4swW590O7FaIMy2ZZDOvTypwvv2EOobnuqys9ZiZ5i/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obwbBYgxYvEuvSl0q4U1IJBEPot6VgJeXO8tvpaf3yopsdQnwa+tFmhabK4P?=
 =?us-ascii?Q?tH5tbhVTTR55kJER9wF5LIwS7AHYES2l9uINkOsaTlL6729n7AHFGL8ckqmv?=
 =?us-ascii?Q?GnQoqlnyzk+MLC1AZVRripisxRA6h9nC/ZjPo5Qr2m8XOU1txfHmEJ3/K8uO?=
 =?us-ascii?Q?SdW/qRhosAO3tROacQNvqNwmSpXG744dXPuYGbMyDlD1+D1h7AKo7Q/EVZs7?=
 =?us-ascii?Q?JrF3/MQprIQuHyviiL+qk+heGkrUOfIOsTcarRKKQBahLmoDCAlpdUvVjtll?=
 =?us-ascii?Q?VIKu1VTxbK4UoBungMa3TUZKfNLPuSGm5YFmTr6gK3iG8h6j//uXxNqReyNs?=
 =?us-ascii?Q?2LP7X0JGsPHKfJejNeTpAA7XkUwuaKq0xeSnNyattRHsis/r0UiEiVQDO4Ew?=
 =?us-ascii?Q?t0F6QAMRbryrAujN6kB8shL0FAzpUFd+Rri892ysmGoPCAmt94kyP/wZGn19?=
 =?us-ascii?Q?uoOOQVo17qsxiGmzGfu+UPiGKHlbQwf6turj7roLt4ZRGtpsYDPjUzAOp0K6?=
 =?us-ascii?Q?vcKiW16QXfOmlcsOK7t7ReymWQOJCoWOLXMedKlkCtni3OUpw3/cO/kHWlMu?=
 =?us-ascii?Q?6uQXN6dhQ+FcNb9WDetj9gJ2pDN9VU4q4+APJYRSD40n9bHbqRtdUs8LgMYl?=
 =?us-ascii?Q?IepukRq/AR2VQT+5q2kezhh7IPJlVIfv9xYTBTKLcVJ0Dg7iIX3iR9BKHznG?=
 =?us-ascii?Q?3wLIRnXH4EqR9wosdRZZ5reI0Ayutx7ibkQ2c9wJQxLse6+bPBd1wuSi+9Fi?=
 =?us-ascii?Q?p5LTugFytRqG3DDBWeuuhYt+G2IQOsUTQmYR3JzMhoBn5hg13WbPUcVhId/U?=
 =?us-ascii?Q?p+PYtzbFy/ksxS8oY72o79/C6bTVyI4o4FN3UbLCBwp0078mgrgKUDyX/ULe?=
 =?us-ascii?Q?sKg/9dyw6gThk2D9wjU/0FhMp+r4lu71JYSVKG0J0UYVB/DXYVOWgfi30sJ1?=
 =?us-ascii?Q?8or+5rRXLBGEyYdyAa/VDf8T6+e7X7Eqz18OiqtOdwy+O7E3CFpBsOmuG17Q?=
 =?us-ascii?Q?KPf3PlkznsgGdQ7H2zlUWLBdMngUw3aA35ivQdNyQ9sJHBBMcg2uoAX/ik/1?=
 =?us-ascii?Q?HpweT+QQAFosYOZQA2Rq9gN1k/sf00t08feUFzZrzUafjgKsj9vMZgqPXznX?=
 =?us-ascii?Q?vA4IWXMLfnV8f5i4HC/Q6zWLTTUx8cUKPyUJy61kYnUSa9fxFJYj6ot7ebuy?=
 =?us-ascii?Q?Bk9knzkuW7bt/vdlZDOlZ+2xr1dXNssgNKag/G97OK3ww05ebjOTQCPXKS/m?=
 =?us-ascii?Q?y08mlNZzSjodHR8c6cA1J8HTqPlpAKBcNQQK1MghdXkfbgD1XbgkPScpbRl9?=
 =?us-ascii?Q?gN3xGS4eE6BPsxrNz66ZPFfJwjsO/osx6vUuDMKEENbNsONs/WA/ktm+dTO3?=
 =?us-ascii?Q?DVZUdlGRGVrFOujOAkAsbDja1Z4yEOsi2eGPrdaD+5KJjlI6X9C/3betkjGu?=
 =?us-ascii?Q?dcxSB2dpIR9lx+sn+DDdPZjif/+4KkCvMv5t+aXmU19Dy59+d9WPBPdFtRlU?=
 =?us-ascii?Q?4PWOy29cjmAlCWFxnCoBFqIQ+5XRLeYw17R6x23ISAmgZC5CDIgiYZZAqZpm?=
 =?us-ascii?Q?UGYN9nc6jO3UUkyI328gC1qERq5prRYWUSnuut9GnbXloOhSPnQqgHZkJava?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f08b2a2-3cdd-4c57-77e7-08dcbcbe8ae7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:34.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YekTvIkP355e9UQ5kvHs2jWg8VC2kNqHheDjiGsKT6sCIg6QoBHu7FAl4VwS6DNHPG/xdox3XBDHoHnRh8ik0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

Add more coverage to the local termination selftest as follows:
- 8021q upper of $h2
- 8021q upper of $h2, where $h2 is a port of a VLAN-unaware bridge
- 8021q upper of $h2, where $h2 is a port of a VLAN-aware bridge
- 8021q upper of VLAN-unaware br0, which is the upper of $h2
- 8021q upper of VLAN-aware br0, which is the upper of $h2

Especially the cases with traffic sent through the VLAN upper of a
VLAN-aware bridge port will be immediately relevant when we will start
transmitting PTP packets as an additional kind of traffic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/forwarding/local_termination.sh       | 117 ++++++++++++++++--
 1 file changed, 110 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index 5aa364b40e33..e22c6a693bef 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -1,7 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="standalone vlan_unaware_bridge vlan_aware_bridge"
+ALL_TESTS="standalone vlan_unaware_bridge vlan_aware_bridge test_vlan \
+	   vlan_over_vlan_unaware_bridged_port vlan_over_vlan_aware_bridged_port \
+	   vlan_over_vlan_unaware_bridge vlan_over_vlan_aware_bridge"
 NUM_NETIFS=2
 PING_COUNT=1
 REQUIRE_MTOOLS=yes
@@ -231,6 +233,30 @@ h2_destroy()
 	simple_if_fini $h2 $H2_IPV4/24 $H2_IPV6/64
 }
 
+h1_vlan_create()
+{
+	simple_if_init $h1
+	vlan_create $h1 100 v$h1 $H1_IPV4/24 $H1_IPV6/64
+}
+
+h1_vlan_destroy()
+{
+	vlan_destroy $h1 100
+	simple_if_fini $h1
+}
+
+h2_vlan_create()
+{
+	simple_if_init $h2
+	vlan_create $h2 100 v$h2 $H2_IPV4/24 $H2_IPV6/64
+}
+
+h2_vlan_destroy()
+{
+	vlan_destroy $h2 100
+	simple_if_fini $h2
+}
+
 bridge_create()
 {
 	local vlan_filtering=$1
@@ -241,14 +267,10 @@ bridge_create()
 
 	ip link set $h2 master br0
 	ip link set $h2 up
-
-	simple_if_init br0 $H2_IPV4/24 $H2_IPV6/64
 }
 
 bridge_destroy()
 {
-	simple_if_fini br0 $H2_IPV4/24 $H2_IPV6/64
-
 	ip link del br0
 }
 
@@ -272,7 +294,7 @@ standalone()
 	h2_create
 	macvlan_create $h2
 
-	run_test $h1 $h2
+	run_test $h1 $h2 "$h2"
 
 	macvlan_destroy
 	h2_destroy
@@ -285,11 +307,13 @@ test_bridge()
 
 	h1_create
 	bridge_create $vlan_filtering
+	simple_if_init br0 $H2_IPV4/24 $H2_IPV6/64
 	macvlan_create br0
 
-	run_test $h1 br0
+	run_test $h1 br0 "vlan_filtering=$vlan_filtering bridge"
 
 	macvlan_destroy
+	simple_if_fini br0 $H2_IPV4/24 $H2_IPV6/64
 	bridge_destroy
 	h1_destroy
 }
@@ -304,6 +328,85 @@ vlan_aware_bridge()
 	test_bridge 1
 }
 
+test_vlan()
+{
+	h1_vlan_create
+	h2_vlan_create
+	macvlan_create $h2.100
+
+	run_test $h1.100 $h2.100 "VLAN upper"
+
+	macvlan_destroy
+	h2_vlan_destroy
+	h1_vlan_destroy
+}
+
+vlan_over_bridged_port()
+{
+	local vlan_filtering=$1
+
+	h1_vlan_create
+	h2_vlan_create
+	bridge_create $vlan_filtering
+	macvlan_create $h2.100
+
+	run_test $h1.100 $h2.100 "VLAN over vlan_filtering=$vlan_filtering bridged port"
+
+	macvlan_destroy
+	bridge_destroy
+	h2_vlan_destroy
+	h1_vlan_destroy
+}
+
+vlan_over_vlan_unaware_bridged_port()
+{
+	vlan_over_bridged_port 0
+}
+
+vlan_over_vlan_aware_bridged_port()
+{
+	vlan_over_bridged_port 1
+}
+
+vlan_over_bridge()
+{
+	local vlan_filtering=$1
+
+	h1_vlan_create
+	bridge_create $vlan_filtering
+	simple_if_init br0
+	vlan_create br0 100 vbr0 $H2_IPV4/24 $H2_IPV6/64
+	macvlan_create br0.100
+
+	if [ $vlan_filtering = 1 ]; then
+		bridge vlan add dev $h2 vid 100 master
+		bridge vlan add dev br0 vid 100 self
+	fi
+
+	run_test $h1.100 br0.100 "VLAN over vlan_filtering=$vlan_filtering bridge"
+
+	if [ $vlan_filtering = 1 ]; then
+		bridge vlan del dev br0 vid 100 self
+		bridge vlan del dev $h2 vid 100 master
+	fi
+
+	macvlan_destroy
+	vlan_destroy br0 100
+	simple_if_fini br0
+	bridge_destroy
+	h1_vlan_destroy
+}
+
+vlan_over_vlan_unaware_bridge()
+{
+	vlan_over_bridge 0
+}
+
+vlan_over_vlan_aware_bridge()
+{
+	vlan_over_bridge 1
+}
+
 cleanup()
 {
 	pre_cleanup
-- 
2.34.1


