Return-Path: <linux-kselftest+bounces-44268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6FEC18F6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E930A561ADF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5093F32E72F;
	Wed, 29 Oct 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pKT5mtmO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF031353D;
	Wed, 29 Oct 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725212; cv=fail; b=V0PRFw6jnCj+sV2ykHxxTwqkvw6Oc3Q0+3454w4MvU/Q9j0SoMIPuE/N9UJOz7KTYAa44qQD6D6E2f3DMiQ6yw97v9vv0OfEBZgc/osWgEHK6jog7QDzMLMc0F5tDoWJcG2Y57xT9LHSgURSv+9OeZC0Ep6HXYJQ8ePOoh7QJYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725212; c=relaxed/simple;
	bh=YRP132taWkgNyQYz86N1X9emhm2FTHuW0+suYCJwSRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9yPTCBDhm8NFdD4lzw0rblYWUh5ucNL9yn2flfCHPAnPyI4DJ+P7WLEcXeJU2+0hcNvau2xw32Voq6OJ+If0ZYBsYcV7ozVicb5RPQ4dLNPkTbF5kE63GjbQrgLYpK05f30s78JbJ0tSQBi5O3ih+1i3DiyNatExAPfaP/0FPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pKT5mtmO; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGcxpZJqfMWM2s7yM3y6OPW3PJAbC7bkuwIb8q+Q+a3fiAcrMeGNtff9zqMOUzTpzuQX4SfCzV/NI3ceVHhbVu7M9eSAm4/kR7uEDdk+dYGS/Wb5XHQikuySXfKybtS0Isfrhkt/KeTxVGVKYkRGhGCs+fX3pEPkCpSuPOO9e1JScLtSIcigLRr/OTFEeXc68G4L96Guelgzn5oTMkt4SrAA+JFas1tBRSnMUQGzBdUUet2vSaF0AS9U50x/qAL54bf2CrIMYPKVBA4Gol+gfuwq/O9cjx+Y0sCQwweGQUauKl72RNfHr/u2yIkbkuwwIhsH54qMUapqh6/rg+URYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCg2EMw2XRkq8ZGaAjDIJbN0lRmhdEsGo54KVZzooZ4=;
 b=TN5/DaEy9tRss+hco7fRDHojRBgk0B6h4cc0p/B4louASGzzVzpPVwJw4YFr6W0VGcfWQg1Sxm9HSYGRjnrpsdgTp6LexYVP3cvKYM5eOQyL+kS5RYzY1VSrKpZQCAyzu7WFyBZ2XTxTOmKgq4q/JdqPuFMH+ZuKtvT4WLektTLwJBX6rBRoTWhw/vRPNNaEJBVGK3DyAQVr9xv0Bx1OrLsiJm4ukHH4JyjviSvTTMKI65ifqAB34ntshkdHfTgK3r8C567YorKNJEp6YRQWkx3ddPQIcBDeNiPhSIlH7wrK3jrs3mnDJTkV8eB+G5a6lSRq8gfeT8i6yuINciYe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCg2EMw2XRkq8ZGaAjDIJbN0lRmhdEsGo54KVZzooZ4=;
 b=pKT5mtmO+Vhc28Im/190JHII7WeCp5hbfq74kf2TPsEUu8hTV51en+U0QOGLsE94jj1D+P2QJChtES0qiHBHYZw9aCvXgDpyUJUCXP0gz5ZilYuRizbW4BZpyiYG7l8IVQpz7WSMSdaGbi/SpkgLMCTZluCd+nQpSL+Kt5iCVckp8LNflU9l6aRevU+nWtSwmMds8scOtSnPwYYWMgfW8Ch2YyIdr5QEApvST77R/WNe0ZXUK4GZFheh2unpsBy+z3Kr9Jqhc49IepKMbQAwegla0UaZT3xGhuAbgPcFPJkITwLw45i55jV0BTgJlx9+B3WKlL52nrb5mwkGNbm3EQ==
Received: from DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) by DB8PR07MB6300.eurprd07.prod.outlook.com
 (2603:10a6:10:13b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:06:44 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::6e) by DUZPR01CA0007.outlook.office365.com
 (2603:10a6:10:3c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 287F920202;
	Wed, 29 Oct 2025 10:06:43 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v5 net-next 14/14] tcp: accecn: enable AccECN
Date: Wed, 29 Oct 2025 09:06:08 +0100
Message-Id: <20251029080608.92428-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|DB8PR07MB6300:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf87ff7c-cfa2-4eba-a497-08de16c219f2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9SyEBZ6V/TKDKKD5i2JW3LHNYilVZ8GQtDc1A/LizijAWyK4O2cN+ozQOcWD?=
 =?us-ascii?Q?I7NsecsbwjnDetcwtJbx6fhLpauqe9udrsEoCMf7ac3GfYCciai3kNtht0eJ?=
 =?us-ascii?Q?ePwaUkHxrRxhZmotTp7/tf+rR1SrRcbNDTjQLPRdbc5VzdQKhqD9K49QVO6q?=
 =?us-ascii?Q?A+iY8+EI6N07T8al+oMAs42K6bvvBOIwGmFLHkNd2QO3LJ9uQR6fqPZKAVMD?=
 =?us-ascii?Q?VZm564TtSTra1WFGX39l4VwGphRUoHE6oAibs62I3T+I2oE1aFkm11JFvCnP?=
 =?us-ascii?Q?MGWP48SoDdyKE3iz9AOgY55v1MB+aEwoH1+scpfz/voheaqIgyPGryu+jjba?=
 =?us-ascii?Q?uFuAbd06423HkSIf4qP9XvcSTbvV8E5Ff91AeBWSRpp17ET09Sb4hZ9FVT2m?=
 =?us-ascii?Q?HwCbPKi1FX+qdM+Ah1JpW0SSiYxSBDzovWgQWKwcW9oCmuCZxllQ5owMTPs9?=
 =?us-ascii?Q?frDxodyMfzz5fXPngbADTfZXaVqFJq4xGWY49r37q60TtzlntIuNcrkY1WnK?=
 =?us-ascii?Q?ZEX97mwhngGzU3Ik/hUX+9mvNp7wu49ppzA0zexRA3ww1KCtXiWLUrUDdRBe?=
 =?us-ascii?Q?q0Dw14kWJiXSqmDT289f30PGPGhyYX/KB0knf8CK43ShcsnjAHpkJ7qAqiJj?=
 =?us-ascii?Q?PpCtEBHNIzdE2zYMVWlv6zD/t0XbQoe/zVQpHtEZDzpmb0NszqzekNV0wJeB?=
 =?us-ascii?Q?aXD7l7H+Pva7TLOAi0oXIXXvT3K3eRb+QsURh3WMyKhAsfAMvry/syzOnH1q?=
 =?us-ascii?Q?QSZjQmxg+DqvZ6itj1dyfyyShrd3GY+I5LDCZLojpOV89AC4nlGubVyuSFA5?=
 =?us-ascii?Q?XTA3PENtZ5/13Jof2oKhP9VvRW4AwFyr99TMPmHABxqNY9E8EkHLamI7cxn+?=
 =?us-ascii?Q?NTEz9/6OZP2s1tX04Cb17pB1Yp8W/mAuZbxzDJHZg1W6cVFJws7xzdJWnWU/?=
 =?us-ascii?Q?m8WsKfB/pviATHJO9O82t4J/OGnPTG2B/lr+bSbnQ1anN0FBzslWWEiHSZt1?=
 =?us-ascii?Q?ouQX6adPUSAI9Kruy/UAdVxG0hFCZplxRqOxsD0JWBZ8s8Wdcro7Q+Ntmzja?=
 =?us-ascii?Q?r5W9Qvqae/3aSEh2gykSRSTr92RyrvBmNWzRvvTnLqbP1FYtWsuuPYhVtkZ7?=
 =?us-ascii?Q?XhLqKy2HdkSESARXaQLaIaHHJQ11s8fdPMIiSAZ8/P9HiUWYUrLnllQESj63?=
 =?us-ascii?Q?81q1E4Q5QI7+sBtlMRcBYH0+9savvZlISU3pvFNxdHQxLxgszyNyhZzI98jZ?=
 =?us-ascii?Q?Xnx/hNDQUWIT3xyKc+P7yvPc/C4BaAWDBs0ACcQBJdocB6mt+d7veCRsap0f?=
 =?us-ascii?Q?7YgcnKZ3Euu3fBnRFJzp1l0CBa8vMXAVYRFq5ShZouWqG05gsEKxsrspcE9F?=
 =?us-ascii?Q?NQ6hvKT23g8EvwfWN2M3Kidh7HMMVKub9R4CKDTzw7cUPCdv+21R3PE/3e2w?=
 =?us-ascii?Q?cLJwmF8tqhJ21zafRNtCC+/VNyWTgyNLFIY1S3QspZD5ywvTsTt/e70qh3ql?=
 =?us-ascii?Q?AHOKun12uuhN0TYielV0qzr8mAdfOYsfRucSFftR+np4tevAssiNWGAlceA8?=
 =?us-ascii?Q?gstihjl4YVHw/8qThnJPbJjiteaZczGaFy0H7z3R?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:44.7158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf87ff7c-cfa2-4eba-a497-08de16c219f2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6300

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Enable Accurate ECN negotiation and request for incoming and
outgoing connection by setting sysctl_tcp_ecn:

+==============+===========================================+
|              |  Highest ECN variant (Accurate ECN, ECN,  |
|   tcp_ecn    |  or no ECN) to be negotiated & requested  |
|              +---------------------+---------------------+
|              | Incoming connection | Outgoing connection |
+==============+=====================+=====================+
|      0       |        No ECN       |        No ECN       |
|      1       |         ECN         |         ECN         |
|      2       |         ECN         |        No ECN       |
+--------------+---------------------+---------------------+
|      3       |     Accurate ECN    |     Accurate ECN    |
|      4       |     Accurate ECN    |         ECN         |
|      5       |     Accurate ECN    |        No ECN       |
+==============+=====================+=====================+

Refer Documentation/networking/ip-sysctl.rst for more details.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 91a90c34a810..9072584e6617 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
-- 
2.34.1


