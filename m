Return-Path: <linux-kselftest+bounces-49028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FDCD2486A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED12E301D2CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647439C63B;
	Thu, 15 Jan 2026 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="B0rsy0qk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2739B487;
	Thu, 15 Jan 2026 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480170; cv=fail; b=ulAfpzo308ChHC1Iw+21Q/iFCsGhnMmMt9lL9+7NBe3TZ9sFCJzJIbwi8sO5lIFm8yQhDk8SgYlGLtNEyms7WJfjrsqGEnBfGhMphMVT5N+S7TmRZWMdjKtI9uDt8SnMy0zOOEiOWx5CLpWKQGUCiwJ8fWoJhpWRXKIBRzy9/Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480170; c=relaxed/simple;
	bh=K9sp/cKFhO2N1xPzkjJWGMSrD6M/VgnZ8iPjal4WcLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpP2j5SCGFC9/Pg3sRNr0lpgeajKmRWwNPekeGdthu2fhHp1+V+UbmxDuhB9wfKGp4nS3yQiT84C8rmUWhRxZKgSTZtTwrjZb1toha2Kt4lGXIn6YEKwOKeXWUnRLT08XiiDhwrwFRkk9H3Sek82kJ3QA6CTgAkDKnpb5nYJ0qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=B0rsy0qk; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8iVqT3QS2trot1qBDzA2Cufdzb6y07aDHIAiFBvnnU+4qKKHXgh5FXgD3yT47C0mcX6eHuSkiCZBjKhQmE6McHrNf/q78M+OHMPXbE4eWLxYZ3ISHIKr4GgP4PTTIiE58o3Od/A8FGCbCZsMYeDReQ45MqLB4Hb2q3T4q8kqCN9gTsAAUW8Ue74jPRylCfDqEeXO5TPe4fuF4QqpiHM73s7t0vOh4VRebOyhl9J5uV0pRUN+9idgesG5sB8Btegi7eIZoLUiNAHiu++xuWfU/8MyluoNAIddTEgqcy7QUO2zQcqPKqbrVcjHvCmM67tuoy/Gc+R6jAp5DEwdSjP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=Tc7TlVDyMeu5GCOUnCEvPthhDCDopUNXatv3UrHe9sWs7exdqwMolbo2BPP1rhUyGCMjfeYS2AswQ/kQNC9Msy90vLMUFm7qNdkl/9gqrLpmmeYEvORICA58OYZ1dCVoYMR8ZerKz00pWk0Uo1WQVVKZcfZ8XvoNZBXrma//zxVX59i85jDENTxMH2usX0BPkOBq5J6uQb06qNDqkyXyBW94e/LoiARVO7/GQnMaEllHWYu4eeCq1TdpiRJ2Sdp2973crpIC1BGNGgiOvCJsj4Jh1JpIIR0uUtDb1s0kwnNIkbN0VrR3ipMmjVbqsdvZFRt5ri+zV+QXc4TzKZBQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=B0rsy0qkGpOgn7jfADwxsyoau8k55m7vpg1WTuePv/KIyQoanOt68PSl+2rG/9Bw46negUfkb8aZkiKIg62tzYrrxj6R/3v1c7xEVBros3qa4+0G2iV0ojBfU6d+zTaHYw21K9DHu+96XhJAh0Pw+HdTmipB6HqdjL5nEcgSVailwTR6sEOoEiN4lBaGVoZsZjFiL/cW4ozoJftphtiqvq3DbEB94qc2nU6hUt393HtrexlVOVX2SaozsAxxT/sAR/TjpOUFJX9vbjeBydSH3nMSfXdEItmNDgEo5j/dioKlbMfGszq3tgShvKJw4JKcyLrT/PNlUE+qKp2UTyiGYQ==
Received: from AM5PR04CA0034.eurprd04.prod.outlook.com (2603:10a6:206:1::47)
 by DB9PR07MB8612.eurprd07.prod.outlook.com (2603:10a6:10:308::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 12:29:24 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:206:1:cafe::74) by AM5PR04CA0034.outlook.office365.com
 (2603:10a6:206:1::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Thu, 15 Jan 2026 12:29:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 0DD07201DC;
	Thu, 15 Jan 2026 14:29:23 +0200 (EET)
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
Subject: [PATCH v8 net-next 13/14] tcp: accecn: enable AccECN
Date: Thu, 15 Jan 2026 13:28:45 +0100
Message-Id: <20260115122846.114576-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|DB9PR07MB8612:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 828508b5-70fd-4653-f9bf-08de5431b7c7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?HpWj4MtH8PNZpqqg5lUmsHND2JDMPi+y0Utw+n4KiyGYZQmGWStA7Cz0o7+a?=
 =?us-ascii?Q?ahSB/wIi4o27NH19s5U5YUU6sTk/9jcD+oy1bOpTP6dJxF7sbMb/98jrVFu6?=
 =?us-ascii?Q?qRPFm2mXwZ5+mE1XdUL1QXPUHwChEKSF8cIfd+o2GAYQPIp1wuostq/yLjTa?=
 =?us-ascii?Q?Hbw/+BmCwTVqhRCojkFKGr9uzTZUWmz1p2bGKVVLmfSNSkvn+iPbsTp1O/m9?=
 =?us-ascii?Q?HUoZ+z2rbc76CiB6DKfd0hUc5PVuVgLvYeOyfTMSXRLIrEuUIjUy8MNwipy7?=
 =?us-ascii?Q?MvdUdkKocymFqkkfTtoPbYYAWgIZcUamEoY8shb1nrql43aC5/+8X0lchdpa?=
 =?us-ascii?Q?uLwr0ntlIpGyiwvbt6lMuuIZAb+LSWGX7rh1qpuOSCfQr2eZwzXqCD7fVqRS?=
 =?us-ascii?Q?gkRgljUNipEHskReM1mEE3OuPMrBO35OQEFj1hasNBtnTjD7zuS5Rod/P8MO?=
 =?us-ascii?Q?9jmN88RDU1Uy9bAdP+naLT8e75GNvvmilkyu8nv0Mq/RcGlJg3c7D24Ap8Sv?=
 =?us-ascii?Q?HhqbPPQR1lUufBnbS+m74Jd9QctQ+VqhWC5JUBs3Gb1cTgelRybqwOlg9fHk?=
 =?us-ascii?Q?zFtHb0eHw2T3s/fQPlPNDf5Uiswavd+M8y1AXdL4uqf6lR99Wb8sY1rP+OeA?=
 =?us-ascii?Q?RjyOLxS/ZQFKsMZqTPXChAQrvorJEUmjm1OCqGo41oimbtCWKczLDSZHvpuV?=
 =?us-ascii?Q?pfmTeTabjdWALzTpM5E3DblGs2QSVfRLy+1x50+JMtLzmDh5gXp+VomFMTpw?=
 =?us-ascii?Q?vKAV7ecuUIYDAvNn17U2KVB2lIVQFxGkgSLJhOumGBXUiN6wwJA64xjbsWGM?=
 =?us-ascii?Q?a6pKwNRQP0s1sWTIVhklw8Qugj5JE+QzB9fKrgCDp6SdeKxrfFyEOsuFfJ0w?=
 =?us-ascii?Q?fYoRAtS25xUbbA0+J3gVL/2swB57S8Y1yYWuOOtYAP5eCUCkLhgsxOEpbsnx?=
 =?us-ascii?Q?bAFkIJipUgRSp6U9sYLmf7sJQ2LJOwPL5nF0cdeFm2bh+oqY0R1GlTvqcytD?=
 =?us-ascii?Q?sOn3I6cKQ+puSiAaG67wh/LDYpDGyrbbYZuF9auLPa1X+BYTQod0NoeII+Hb?=
 =?us-ascii?Q?iePEKfhhJPThvwW0QjK/pZwbrNCeIguAjSoT64esgyfFCOzFpLrV7bhYvWae?=
 =?us-ascii?Q?nEzXtCSIJs1WupMNVfuFgd87/ii5FdU0vqqKIZJEb0RnL7DIY/vdZD8An2Ja?=
 =?us-ascii?Q?h7R9wOZdcXKLVpltqGpzfaUCaQRk6/Sxo2SuQ9tFXmwksmsH7mgft1eKdzna?=
 =?us-ascii?Q?gVQQLd3NSV6GCd1yOJtIGmFsyQsKlHw6qqacSGvFXUVvwlBdFGzCE0xnoS/H?=
 =?us-ascii?Q?+Of5azRZkpQoNbmgv2/L0K1WD8W3ba2FR6DpkvXlS1/p8Hvlm+Be5+WRIeB2?=
 =?us-ascii?Q?4zus0ZhHPgArktWR0xiVkpEilZzomysdaxrXZp9iQYiCPrGkokURmq4+2JrA?=
 =?us-ascii?Q?l4v0Kw6QNahwS1AETsFGQIQPDvMVAEqFNQazNiPBf1LVrZBF81mcMLu4gMpO?=
 =?us-ascii?Q?r61e2D+TFv1DUpBTVzwlhVaVQwsRqjobBFIcBPIvfAetnvlO/pxP0yJd+DYE?=
 =?us-ascii?Q?T1z1TyfSehHmKAYFjojmDXYDBUFXdInSdj4mQlaHpuefJwZ9lHQ0zgS1AGtz?=
 =?us-ascii?Q?EtO3+wRkWjnZ9EukwvS3ZUJrGxc4UxK/jANGnAubLzPR3O8H1fP63U04ltTq?=
 =?us-ascii?Q?XacK/sPP5uttvi9wmqX+s7RdUCw=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:24.5935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828508b5-70fd-4653-f9bf-08de5431b7c7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8612

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
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 385b5b986d23..643763bc2142 100644
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


