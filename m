Return-Path: <linux-kselftest+bounces-44415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A89EC20AD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D2B1A217B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12CA27587D;
	Thu, 30 Oct 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="e3n1+xfA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBE2750FE;
	Thu, 30 Oct 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834908; cv=fail; b=A26GmOkKHSeyOnF6qhXQQiGiQpezWRvww6bB9qT+ieMNG9LMxlxmFa8w0wCZHkJi/neSi9RAF9fDRGPo8karnooj0xRQwR2FJRFO+Mv2Nz1FjYkUDsDaZRF+02LG2WUfZI5O2OlpwsJFiL3GDtqgzovoXntvy1QL8N7fSCQs/Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834908; c=relaxed/simple;
	bh=L/9syWY5Uc0f6dVV5fOe19D+Lnvl9WF1Tjpw0JAHevg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJAYe8H6gnvA2kWO3qv+l2toVaOvHXUsX8B4tdIXs/LDNZQXBWDLYGhnvHOzk3jY4CrvgFMPK4/Qhbvpmi597RIyb+KWEM6BsphsWgMcLJB7IMV0oBEVIAtvP1GAwXKiylkk7KO4K+fwpr8Fez15gzD4IySYkkvG2Vnrn58fqmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=e3n1+xfA; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7Thbe4SpAbggrnagAZzpVo11ItehZCTLKyQLpce2x6mo9Pq4Okb2raVDOG3mMUEmx5ti8xTBYZVOFRWpPNlPtX26afa5j1jB9ewxkL5bSxN+JwGWTWKidns4ZwDpKFsatrHCepRGj4Ubt82XF9X+1U4vEq/xE7E+Hlj951bqA6wmrJKoaeZzXbKDij/cdObU+joqE5OLkOJDOD2E91Fsez5JIg4JMH/yJoDA/hRp9FHhK9yJnyBHSzAmhWhwGkitxW3cXFA4B9O7zv0rX9EFRoEjGrzwk+LUxWRAd+Bb4/Pqpz5dHKhYoauNY7VynBDoeLO/Uyy7Acub9omPVTpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO0M59Rnpsh7uQlqMipDNASdfTD5FHcmFDaC761vsYo=;
 b=SxuFzk+i1qPI7awCP7AQImhZW0Zj2pNcCct18OBUeR9IeEwofDjv1PKwe578WWkCGgoTVZJoMOMus5tY+OtfnR/3zVWDgAqcB1eNI+pUMdGrwnh/oMRCDOVOomamOpMtH5E4Ez9gPwAEeRe92vyMUY6bFkdn4Nh2R+R0JzhUw1c4cJGPOYKJP2n8J3bCnu0BZsZvSdSXNVBdl0b4ZpxeX9sxPPUJglh2R/80LzSKPkDtu7akRjSylphbu6umX+oZ+gBTiBCCQ0Bq9WVx3NY6d/G1bBmJ0iV5zvak1awBtmnzIjkGjt4dnU04gaCsBDgDF//7bvg75qPAa9yi82wPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO0M59Rnpsh7uQlqMipDNASdfTD5FHcmFDaC761vsYo=;
 b=e3n1+xfATu25lni1AnYdtxtmja3i+qR+GW8Ps7Q4c87+ZbSl43ptwKWiVJS4BHo9XuqYKVqkUW+r5c9dRMP9ZBLJ7ajO1lf+QfcC8RvrlNhgU9rGHLhOLAAq1+AyLa+dtpCOHzTlSUfOnvO+nZHSNEA6I7AO8udGAFMBQSud2riTNtFSD+Pn+hM/DtChXs2FdLHnM3kIgp1FjPtyF0n9pxns2yGwVbLbdp7WE2u5BXCqBMslFpX8ZJr/5Nz3scbF15hz98/nxnxjvU6Izu3SYBKVjIq6OhnziDa6YMlQ+jcINk4PU+2IKSLs6RJQWQB2+PHQsbS2JuGgGXYqmHI5+A==
Received: from DUZP191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::11)
 by AS8PR07MB7878.eurprd07.prod.outlook.com (2603:10a6:20b:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:35:02 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::a2) by DUZP191CA0034.outlook.office365.com
 (2603:10a6:10:4f8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:35:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C519F20094;
	Thu, 30 Oct 2025 16:35:00 +0200 (EET)
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
Date: Thu, 30 Oct 2025 15:34:35 +0100
Message-Id: <20251030143435.13003-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AS8PR07MB7878:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a7f392b4-4b24-4c31-fb8a-08de17c182d7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?mYFaIGGQLzor2dycKZ+oTH1YIeMJ3g72b3p/WtFu2suffOmHJtH0Di6lUtRU?=
 =?us-ascii?Q?xe1di4DuWSVkGuT9GLDBGilBraQ8pion90imI7hfbYT5VdpbN+dWDLoSlL9G?=
 =?us-ascii?Q?kYWkV66dAcP4E01fmVxVSZOCDmQ+rZtXXR9XhNvdWKPN76jLuNF/FLT/NRda?=
 =?us-ascii?Q?fZu8OI3xN7uL62Ntwd5N7xmExDbKIgnLR4qcOALn5/pYpTEzy5IgV+XvRaDm?=
 =?us-ascii?Q?IiY5zwkSVseKGAhoZerirF2b89SpBXgXcqS6fhg4fR0Ii5OyeIBovJPeSwAC?=
 =?us-ascii?Q?ES0csNxv7KYlyeje2iH9L2Q9RWHYwbBDZaAX9ohwuTYWhgYQ2/k5kTwlvLVY?=
 =?us-ascii?Q?PvTUJzIfJa77jEIiJcQWj30nknCYGUkVPMzqmIaRTq2mGrZ15EB0czU/dBYk?=
 =?us-ascii?Q?vtmjsKhUbQchiEvpnlH/j4o1RmeYHccdv/QB+6cuNPTHcikoedOI3UhtnoV+?=
 =?us-ascii?Q?JTLvZEQ1ZnRbROpqu6kdPQ0VDd2EBIXibNLqYQK/Xx1Fo+7yjU2i1LkR59OD?=
 =?us-ascii?Q?l0/K18e8ruWji5IXbfBGlS2X2kAeh8PKVojSfmRHMda8h1sHpfY8SUnhe4iA?=
 =?us-ascii?Q?Z4VyQDnw+fJzzLtAto2SWOXtvuwgd9xpjih3UvVmJJAZY1VYIRF3A0OQfD9W?=
 =?us-ascii?Q?m5+8mLuEcUWcoZFcSszsEvRmpMi2zWQt+1IueepTLLA059xHO5ahDYY/HGy+?=
 =?us-ascii?Q?f0yMgiRi9uAi5IaciozbypRlgbhPKTQaZnVRODXDrlK04b+AC0mFsc+QLS8m?=
 =?us-ascii?Q?Eb6KRRXmD/AHSMXsp5sOGA1QZTal6P+v42c/gRbywnXREkND8zEJbmUZeZXQ?=
 =?us-ascii?Q?aWeF7gC+NvcFb4uumd8+60/UDVv+Oy0vm+dIACb9r+MyCJuHmnl0Avt5K5n4?=
 =?us-ascii?Q?uFh3gWQrgTM76g4sf/Zy0dRMC2JY8cjUMZM/GwrqoFDxRCuX+0BhGFQjgaKx?=
 =?us-ascii?Q?bfbNvDFQ4vatOItqKetPPCK2uxDOiCQki23crDw311/cL9Wlrn9vh2GA522A?=
 =?us-ascii?Q?B85q3g2qoegxR81qmr/R2Vg2QqnHnInjtAbEMCsigkd0kjO/ZDKW1vODsTtb?=
 =?us-ascii?Q?RHZ9vPqKQxcVYX92ebZQ/9lG/Hq0+FAix3KjcI74oGvgQOwkmSooqqlB0VvX?=
 =?us-ascii?Q?fKfKqMCqZaCBNB/znrI/OduVOKM/7IVtg/SKrjeuP+0qlUSefKFIyj1CtF7q?=
 =?us-ascii?Q?yN67iuiBTNs9TLYddXbBAlhQmb+/1a3CCat+VEQHuwpI3VvXIJWAG3oN+C4x?=
 =?us-ascii?Q?mQY6I1IMDgrfzhWTxxm6Q8nwG5q4sDHoyXb8pl0bgL5l5zYpgpbk1nGmJMgY?=
 =?us-ascii?Q?uaQkQjvCrUCWUD482cKhOOhhN5T/AMyf5Dh4ukByh52swslgoj8p8idAOqfW?=
 =?us-ascii?Q?VKjNfUpwsrloKbbyRpt8ylULLN7y7uIEO7gMMvQyrNNSupqEkS3sqeDBl8kU?=
 =?us-ascii?Q?bAKxWXHfb7rvqmQsj1vEBmcYEwsyTeUHsjUghokOsVgQl/QhNJBUj8tC9Gi6?=
 =?us-ascii?Q?i2y5Z6tjan0RFSgZzKKZjezjBwTVYM8H4kQSmTOLJHpXpztsNldxc4/3FqHF?=
 =?us-ascii?Q?HitjyijMkh1iQQMz9EkPIJbopoCjrKdEIP0EpnbK?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:35:02.3696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f392b4-4b24-4c31-fb8a-08de17c182d7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7878

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
index 6695a6022539..7edba98a91cb 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 static u32 icmp_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
-- 
2.34.1


