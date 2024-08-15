Return-Path: <linux-kselftest+bounces-15357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D5952688
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1161F234BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14BA18D62C;
	Thu, 15 Aug 2024 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L3qsk6yr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502B2F36;
	Thu, 15 Aug 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680573; cv=fail; b=bjG53WzkUMOQYr4JuZKbe97N/XzVHG/Ruur1TW2OxglhUjsyxAYNx0GeV7o3vp694yP6ySA/34jFh00b+EwSmtpctAunKdd9HfGobbtILh/DCvylOVYUJnEhT8TeMiHXUchyU0tv2KkHWCaN4XJ3aSWeAk4xdY4CNqmHLsw13K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680573; c=relaxed/simple;
	bh=G4pwKGe+WsX1UC+GBdHvGckleB48mtCEHy0usf9zCKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9deLhcFckPfuoyHLfe14ecP31Ju3Wgefm2A/BT40985Dbzh4wbpr41jf5dBmRqOHnw8LS73Ns5jYHocho7FOJ+txmkF+DXR/HD4LqXR8ggHoriEHp+sQkOcQJXhrmx0w/q3Y84X4UvY88SDaWWig33Jym7IdlSqak2TsPSo8wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L3qsk6yr; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvGY3wRr+EKKj/sR9WQOExrn2ufDLOKwgMShvtBnm+Wao78sGB2KSc7lDbTTgPCJ748qKNfgPFx0kjWgXz+44SkYdJsx6utEBggSRQ/+0NkOh4vArMDLEmZDfiGnTtibStXNYu1yxw8Q6a4kvs9la5ZaphNme4HOPCzFGP1V/QOtjLkTCmXWmo1XRkuixs4qWVAqXvF6c2NFS8x/m/fQoRRb9H6mUKKxb05fgf78Jvz/PjRMhWHzcc+j8ePKM3amgkF+YlG2ZzJ5MgUpNOmISpRwtplO1oim+XiRsX8zymKHetlSOhzwl9kgbVgqa8I8VpHuVT231vOW3/i4OFJhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEvSFc1lQI1uob82+ImRUmyxFZAv+rGlxzitzLcdjQQ=;
 b=R2cvMwQJl+giNImdf4kJcEkkH9kylMZxTqqW6rB2DX7fB4N7d/wTVS2R6askiCv+BwkxLJ5z0Tu0N2YjhOQ6EPXIAEeZlJ2prWkwwnZ33M/9wcj1qxqMhlgUYtsP3EcFREnuy1YzIZRxFAKlzqkZQiShzoFg9V5aD4ufu1fOE5YDGstmb8MEaWLesFApWLlVIKYD9MEshIrqznIGRXW+GWxUQWYH9DVosV6j9azLTHoAVCvsHLOEbt+Ll7w9a0fwLJJLuzOobS24DebMeBQ+LSuRrqW6bI+VR6u0GW1oB5TIkZpSo91pEIo8NPSLWADNYQ1CZJwkTRqF2h9t2m2lmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEvSFc1lQI1uob82+ImRUmyxFZAv+rGlxzitzLcdjQQ=;
 b=L3qsk6yrEjDC981uzjA9E7hknTRR+nZNd9zMWJbWbyrnKGOyKJgiPFdNgzHftJxWORS5u5x/ochIf/NsvNrm42M4KVIO6GuWZS21B4xEwfR1o23r//Ozi3eesaZb0+rLDmYtI82JoZqY/HXMBU37JaRlKbDdjQgLOt9j3LmyZS1DzVm3TQWWdXFCkgZIltVpRe19Xl2x4U9m5UDTK5JLLWClB1NJ3jGkM3cfAt+4E83IwYXeOT99UXkh9I3iMKmknRMqVFpDmnIHc6O5ySIVSx+Fm7HZFcNG0N9UQuPbbqpgitR5bV72V7EQomQJyy0wa456b9d4stDfSlwBsLgbfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:27 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:27 +0000
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
Subject: [PATCH net 02/14] selftests: net: local_termination: parameterize sending interface
Date: Thu, 15 Aug 2024 03:06:55 +0300
Message-Id: <20240815000707.2006121-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 891f7bef-c27d-4ef4-0c94-08dcbcbe8718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zfOLVUqTX/zjI7+RprvSa5q+TWYyE0K+e7lTBQWHSkea9ZjbjaMC+82Xwa9a?=
 =?us-ascii?Q?hXp2GcZYB9Vyw6Tvt8LQjTK/twponGOH4RvLL+0tIOMdVbvZVd9ieFonpltZ?=
 =?us-ascii?Q?cWNcTs6F4vUqUVxfuETAk1uDWWFY1A5EFguaDYi6IEL2W38Cl0Enn075BBYQ?=
 =?us-ascii?Q?j6HD/cIH+s3cBDpyAsv3eAEoznjHpVBzWp5+SFqoZMJKfJhtpCw+wdEyH4WM?=
 =?us-ascii?Q?dvdqeUJYd+ketRMLwR5TMNgRRQtn5R9deoNg8ymgA4AbZqhxxTEltLuYubiM?=
 =?us-ascii?Q?pM9I+EqSHXh+9aFRN0dGvRmy6Xft/AdgpwntnmbH0OwCfTBhJttbM8HWeQ88?=
 =?us-ascii?Q?rdaE/lEAVQ63giy9at3T9v6fhcmWO2dfAHYkSa5P/jCRK89V9KILHn+suXKJ?=
 =?us-ascii?Q?A+deZIFOgYiZpwG8tt/PpowfZO/1WkMww3NUc6mYqsxMzMvJXMaj2LtI+MjK?=
 =?us-ascii?Q?T5oTEhtqK/Zq6mhoHeRZH/hoWNjhWqrOcX3H9AgGJxuHUPTzMI1U9HgfaLi3?=
 =?us-ascii?Q?WfTgT3abikxb/SmWsx84dWzukAgHZZ90CJ8Rv9OpBhxdSzWTATcj4TwZJwLH?=
 =?us-ascii?Q?TPhAWn4l/gbUg078xMVqSvD5A24ImO1pIzIIx58D2NHqM2bApRyOZZsfbunk?=
 =?us-ascii?Q?3UnCD0PcX40sI91JsoqqpETLnKl4GcfpXJ5+4UgkWq9XLEGNJsTELpuSQAXe?=
 =?us-ascii?Q?p1frflOQG+Nqfzl8xrYP2yZItbiRFYuHW3mpe3yEVgN4+pzxQpARSnmf5chp?=
 =?us-ascii?Q?EZQ1vbBqicklU+xrZ31/yWfPiE53KFHwOsQtq1rmSORgRQOfpL7zaxdVWjCP?=
 =?us-ascii?Q?XQJi55FrqyQWLpfFW1tbPQQkX/b/c50wsfv1JMIWVaVe+QQKBSWwX+qTBNF+?=
 =?us-ascii?Q?P/4jola+6Y79g0jg6eYOKcojIW/yx8neM1eboQ4GgGbTZf4rQ4Bv8jHMNtiV?=
 =?us-ascii?Q?XN5LUJdQR4+bu1pY0HUWEHVYT2jJU1tOh16+yvPXLPK9Axhr4jzhtOni2jOA?=
 =?us-ascii?Q?4XmkCHB5ZjhzHXPTAQ95GamXZrSjg645wbQOTrO34ccRfswGsWo84t1Z6Gge?=
 =?us-ascii?Q?2RyLcuhA9ARPkDSwQUblUgAOpaxpT4DMLO6ffy8R4zUDC78zMVW2R2UhQz+W?=
 =?us-ascii?Q?hNAoOzxDRjFcA4JeT+r5cExKojqzA2SHUwxXZAVTKP6A4bWHqptiEyvY9JAw?=
 =?us-ascii?Q?1iGu5zDWk66YofqZPdpKNL+LMRdeSGZqpprDLeQkQhHDHnNm7PrESV3LA9ga?=
 =?us-ascii?Q?/CTcNqkwmhhXens0na508X1N48j4ZeMLoGJ5amff2RXtbSs472n3u+pJhHD/?=
 =?us-ascii?Q?n8a4PWOXn7iDC9GW6X2ztcq3m2ZtGGQCG4EWRaeI2FJO5RfTu+Ilu1TA2BLv?=
 =?us-ascii?Q?sedS7COdj4LeCQc8HTfCK0vS+NFp/pprGhn4FGSYxQ8wFYopNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rhxpkHHXc2rTthXltA5+Bqqm4XLV5F1bY6KYe6AXYGL2WU2EdFFNmnJ2mFow?=
 =?us-ascii?Q?kjKkzehlcOJMIoDupJoHKE3TVxw7qErRhC8ohAoGTQFznZnd3Vrhp28YRZjb?=
 =?us-ascii?Q?a73G85fcqlfxNcQHLk8jY5TjOuYx2TsNoz8ZoJ2q6oVf2tnV68yhSkFYXC5U?=
 =?us-ascii?Q?GWq9pcxoYq68N31PIzQOPLzFUeqfZCnjF2SCfnCvRKehf98n7FbbrWHBurGP?=
 =?us-ascii?Q?GmSgdCLMgobVVkpPpxnvbbaKagZ869Iw2lWXPrdP5Hakhc1JZzA0JkqePs5m?=
 =?us-ascii?Q?TpTRyjB3/mmWGdkcTae0w//Der51xbo6gaZzeGYt/aMWRmVOSVvLsJMKasTX?=
 =?us-ascii?Q?FwWqBH+4CSGAGJu2AiMAiRHbJvbjWo7m1vch7uTSUO5iIKWm3kZyZCfXgdzk?=
 =?us-ascii?Q?g4VyRKBXgPctNg5jqIuNgomBfDv6W9Mja7I7PRGK4uuwt3WLA6CZsPLAgUs7?=
 =?us-ascii?Q?FS/kImHNnDeCR9GP4zg5jwaxzOlQyLku1rJDmGtORW49Kg1wV4CEqOWEdQLa?=
 =?us-ascii?Q?9tpwK8bAosgesiJy+7UW8fT1DGWK6MytLGxXKLK2azoQpPvA3f7nk1/P4rjT?=
 =?us-ascii?Q?D3G8wns1EnbY2qNgN1oNdNTbjVMBVenq1Jm2QLOhMK8a0phVwl5z/8J9rHVn?=
 =?us-ascii?Q?YxTgmx+Cn5WXzuTAoW4gmoM+shVoGNTLhRu8+52KSCQtD/KnguX+cJY8QYIH?=
 =?us-ascii?Q?surf32XcBGyCZCPoUsAVpnwbHdgyXor3BQoF2jPiMFekprOE4+qS7gyCta7z?=
 =?us-ascii?Q?e1E4U+c06EXrBLYGK36rSusIwjdPrISd7U2kXD+l/wrK9QOeEbCwdlJS5VAh?=
 =?us-ascii?Q?pvg3oa+MvoNC5H0aoyzAxcCgkvCKwxZje8eDhYHCfYQKX66MPfcwS7ZkTw0T?=
 =?us-ascii?Q?+YRUv1KoKK+9xOUASZ/gyqZZPiK2UoHM7tthvqbVfeZqoZ6SIUt3iJEAkwII?=
 =?us-ascii?Q?CMjhD9/K6v7R7fWYw60RfjbYNLntrwvpxvKmCkP0IOmHSGfhBW0/OS/9ANT3?=
 =?us-ascii?Q?1cI/KWWYkjBsMskLtAQOauJN3nd8bzJms7detRe4c8KrZriHLCtoDUOAje/C?=
 =?us-ascii?Q?5SG1GXhz/qNqF7cPpPsnprKo7bUjxTm59wQURq9F5yD8K/13KKsZ/xMDwLyH?=
 =?us-ascii?Q?k5G9+gaLDKH3xmA7EiPYPd+ciXBbO0CNchFAmfk7AACXNGvkfHNTB+7ncstG?=
 =?us-ascii?Q?UWqS23UdPgDImBF/fL7Jej4rza1oBQu3y2gfcaXO/X4gsiiS+88u+DpMj+q8?=
 =?us-ascii?Q?40ApR5Y0FbSmQ2+tHH/OSF9+NFEPKLSabhSekJgxpE2ChalODLO0eDpfGHj3?=
 =?us-ascii?Q?nJBKirPXzfL+16ZOw+0U7XitpYkB86gVbVPpawWe9Z5tBt7+X6xWiZDqpsJm?=
 =?us-ascii?Q?FmAQPWZwLqziwM9Ww2Ls1ZE0uJ+sweBCLw0rG9cBcKrlMgOdUfC5Vn0I7Og+?=
 =?us-ascii?Q?/Er5h3DjIXlkK3By5o3EMZSdTkhDW5INbe9tUXe/aTasuC40RmCoBL1XJ/Tp?=
 =?us-ascii?Q?drVyeR7Ky3QCKL5fO90EVTCY0keUQtQyqM9TvdRf+Gw/Kn51S7DBnnHL0OpB?=
 =?us-ascii?Q?aWdV3JYJyVwYTxsRo4YhHSbRiTqrhVNASLIpmWt9sj5jR4C0sbwTfmhOS+4j?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891f7bef-c27d-4ef4-0c94-08dcbcbe8718
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:27.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBDC5fseWmVhI9Am4FFV5dOr7RA2K+gCWqD+Dn9xNddOZXipK1C1h55PqE8CfzTJ/Sid5itVQ87fbgMywo6JyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

In future changes we will want to subject the DUT, $h2, to additional
VLAN-tagged traffic. For that, we need to run the tests using $h1.100 as
a sending interface, rather than the currently hardcoded $h1.

Add a parameter to run_test() and modify its 2 callers to explicitly
pass $h1, as was implicit before.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/forwarding/local_termination.sh       | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index 36f3d577d0be..92f0e242d119 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -104,44 +104,45 @@ mc_route_destroy()
 
 run_test()
 {
-	local rcv_if_name=$1
-	local smac=$(mac_get $h1)
+	local send_if_name=$1; shift
+	local rcv_if_name=$1; shift
+	local smac=$(mac_get $send_if_name)
 	local rcv_dmac=$(mac_get $rcv_if_name)
 
 	tcpdump_start $rcv_if_name
 
-	mc_route_prepare $h1
+	mc_route_prepare $send_if_name
 	mc_route_prepare $rcv_if_name
 
-	send_uc_ipv4 $h1 $rcv_dmac
-	send_uc_ipv4 $h1 $MACVLAN_ADDR
-	send_uc_ipv4 $h1 $UNKNOWN_UC_ADDR1
+	send_uc_ipv4 $send_if_name $rcv_dmac
+	send_uc_ipv4 $send_if_name $MACVLAN_ADDR
+	send_uc_ipv4 $send_if_name $UNKNOWN_UC_ADDR1
 
 	ip link set dev $rcv_if_name promisc on
-	send_uc_ipv4 $h1 $UNKNOWN_UC_ADDR2
-	mc_send $h1 $UNKNOWN_IPV4_MC_ADDR2
-	mc_send $h1 $UNKNOWN_IPV6_MC_ADDR2
+	send_uc_ipv4 $send_if_name $UNKNOWN_UC_ADDR2
+	mc_send $send_if_name $UNKNOWN_IPV4_MC_ADDR2
+	mc_send $send_if_name $UNKNOWN_IPV6_MC_ADDR2
 	ip link set dev $rcv_if_name promisc off
 
 	mc_join $rcv_if_name $JOINED_IPV4_MC_ADDR
-	mc_send $h1 $JOINED_IPV4_MC_ADDR
+	mc_send $send_if_name $JOINED_IPV4_MC_ADDR
 	mc_leave
 
 	mc_join $rcv_if_name $JOINED_IPV6_MC_ADDR
-	mc_send $h1 $JOINED_IPV6_MC_ADDR
+	mc_send $send_if_name $JOINED_IPV6_MC_ADDR
 	mc_leave
 
-	mc_send $h1 $UNKNOWN_IPV4_MC_ADDR1
-	mc_send $h1 $UNKNOWN_IPV6_MC_ADDR1
+	mc_send $send_if_name $UNKNOWN_IPV4_MC_ADDR1
+	mc_send $send_if_name $UNKNOWN_IPV6_MC_ADDR1
 
 	ip link set dev $rcv_if_name allmulticast on
-	send_uc_ipv4 $h1 $UNKNOWN_UC_ADDR3
-	mc_send $h1 $UNKNOWN_IPV4_MC_ADDR3
-	mc_send $h1 $UNKNOWN_IPV6_MC_ADDR3
+	send_uc_ipv4 $send_if_name $UNKNOWN_UC_ADDR3
+	mc_send $send_if_name $UNKNOWN_IPV4_MC_ADDR3
+	mc_send $send_if_name $UNKNOWN_IPV6_MC_ADDR3
 	ip link set dev $rcv_if_name allmulticast off
 
 	mc_route_destroy $rcv_if_name
-	mc_route_destroy $h1
+	mc_route_destroy $send_if_name
 
 	sleep 1
 
@@ -267,7 +268,7 @@ standalone()
 	h2_create
 	macvlan_create $h2
 
-	run_test $h2
+	run_test $h1 $h2
 
 	macvlan_destroy
 	h2_destroy
@@ -280,7 +281,7 @@ bridge()
 	bridge_create
 	macvlan_create br0
 
-	run_test br0
+	run_test $h1 br0
 
 	macvlan_destroy
 	bridge_destroy
-- 
2.34.1


