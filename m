Return-Path: <linux-kselftest+bounces-41879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64BDB85FDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E443B7E03A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A7031A81D;
	Thu, 18 Sep 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="U/JTbeDS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394B31A809;
	Thu, 18 Sep 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212523; cv=fail; b=caIpfM1zRLqF+QyfBrZ95REDH3roNA5yzVVXq0tE79ly7w4JePHnfli2mt3QMbEjm4ISuSb1nXeRW91dokOTgArFVzdqeY9rhJ5Ruur4SnBqtBeMZddTlDtM0+2EM/GmM03Uza1hhYh/EBRPpAg+rOTLuhYhQUna0iLRzFiUz3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212523; c=relaxed/simple;
	bh=tB8QLy75M+7OpIU1Si8bIXtOrcXPfFt1MWZN94Hqi3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzedLdA6YuNw9RJZF/V4neEu6pTUjz/xOihqeuENT6zjbMeA5A60JsG34rWBt6TOEJkM0bJQabUQKDCtW1Gri0w74Q5IbdzX6f+EcaF8Sfq4WFds7lkuebAH16AYG7qMoD6SpF+94qgklXJQQ5mBNkWo3gjC/RcwlHueBpi9Y/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=U/JTbeDS; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJbpK5zegZ5IjtUGB+cXuckc3F6ykBrI63OwN5kEN3gTMsQvTnj3Mvp3DwmHlFsYE8W2YOJbbwUxQXr6GbKsVpIcEmXolnDZ2eEeB5wZIA/WCHuWnFjb3GuHr6pv7NwDNBtJjUPQ+u3tArbgRh/l//pwLbfPt+dvypWaMwNn9w1Gvj9JQBqRyBHC9dR+N5IY48ul4JzAjfNKKcXD6+3k+kww36C3te9ZrS54Kgi8KaDgTdXSBffLddvLKA0AsqOoMD/KmrZgBakPOSH2btUyvaguxFEkCoqVqw8eoREDJPc5Vdu+bdxNUNuF2uCtMLN0AgzW4i7a1WErRHRmN1SUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPiFuLXVsBRdP1YV8VVF3SFFj8Ka8HVxjuN2PA1It9E=;
 b=oco2HHW0Gl8BE70hhdp3pPQrnZwPBNXIDPB5rEAso9tANriissyY4ViBtmUqhQgo6oTmRhScM4tFvKFtuoO9tO0r0AKd0ZKWudKEHMSRpGblSvf52+vGucxHLtCsVWMiJzOyx+eJgtKBKhHRxbsSNbTHQjgLy3UfAc/fhHwghVhASRnjPrt7OGDQTtoVvKJpQjQqf51d0HtJN68qkrAKFaK/NgZoSgspjFYfjz5KAJnIv+D2iwsHbucgi9x+0/LwzoLhtN2lBPgb8SpU9as5q6qNpM4Gp+bkSj6P325RApfA5bKCibvDPTsYl0tuCYjJVVkhpX4AjxGNUPZ+TQ7E0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPiFuLXVsBRdP1YV8VVF3SFFj8Ka8HVxjuN2PA1It9E=;
 b=U/JTbeDSKLEeZ6Pu2vOFEUIGoO2gvJKNQWDjKluUb6jqDENS8EVuegvxNlHZypJhhekkbOfHz15cSgKKHs3uZnQS1baJC//MGnBwBmM7L789FbKC17XSmG9lyCU8+e2s2duGW2gEVBx89/9g79EdwvAflIomDiJTxebnZ0hs5ZsVNae1d8TnqMgQQ7ZVxF28B3VMGu8BnApCym6thvdw0ciT7mujoX5UBqBpeb6E3gsPrskI+QQxFj7zeq2fbrr1ni0PYixj4FVfIdmK08kEv/BH/FaNe9/Lp847VaWN5B39Kx9gy6+2B8wjtmlboSyhDz16Rbc7KUV05ZkCen3m4g==
Received: from AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::12)
 by DB9PR07MB9766.eurprd07.prod.outlook.com (2603:10a6:10:4c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:21:59 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::e8) by AM0PR10CA0032.outlook.office365.com
 (2603:10a6:20b:150::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 16:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id F2448200E4;
	Thu, 18 Sep 2025 19:21:55 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
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
Subject: [PATCH v2 net-next 11/14] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Thu, 18 Sep 2025 18:21:30 +0200
Message-Id: <20250918162133.111922-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|DB9PR07MB9766:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9c1bef1e-92ac-4c66-4d41-08ddf6cf7d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vt6j79k8gVEK4urusl3aLXC1SrX+neGWk4auXgUnTAqq7kcRSCKBzhkOcsY3?=
 =?us-ascii?Q?s9RCQPk8QLKW7fvQraucxGoQcwwEWDbSdw7yflxUMpUGLkhzRjIhPtC/TAhB?=
 =?us-ascii?Q?HgXUYjB17DrtLArCJc/VvmCcp+83GvTBFGS8kPFRewllLDaQXbZ1eHa7gd2b?=
 =?us-ascii?Q?vtikjZEOUAtcCoeERlOJCsLyJzDo40mfnIIzVD5F3yguYPCV+AV8399vAd2N?=
 =?us-ascii?Q?hxaAzomzjAS0MB5S8aZGw/Zk5mON9h2B+pbDvn4Tt6z8KT+SinipKto5BWY5?=
 =?us-ascii?Q?bCqN2Iu4eYEkvsp9lngRNeMWEpANnROCXNPNWypr8fXw3dYYqdmdek35DHyW?=
 =?us-ascii?Q?IvtT0J7YFPt2Ds5g+ioFDwf+89lk6WWc8Llsm02sTx9x/pf5aaWtmWjjGcI9?=
 =?us-ascii?Q?giJESUmPugPFZmLMN89jr7ifLrbVwzb6lBGWaU47h4x47vW/ctW1YS9xT4a7?=
 =?us-ascii?Q?WhKffSENcn6Ay/sYdUj6ixs8UOBWvA7F7iRPAUY7PupTC9E2wQa7CiCcjMoD?=
 =?us-ascii?Q?DJqf73XD9TdLg65xWd05Nj++EU++nlDEE6EK3ObKQdeO1SsKfXAw/4bUKYO4?=
 =?us-ascii?Q?VNOOpIjhI8XCpLF9ZxIHsFaC8GLw/yZ9PAgvyAVfY+EiEhmQ+hgEWXgud5gJ?=
 =?us-ascii?Q?GWNTZ59OcV1qHcvfEJbcl+9VmAgihtgxfeYRjg9hhQoXH/5LgvlG/L/ssFcj?=
 =?us-ascii?Q?KZK7hIK0bYMkrPYF8sSgDMqg6TLY9cYfZPYMy/hwbYJr0VOSx0QlzNarFYCo?=
 =?us-ascii?Q?hIrMx28+rqS9BFdllev678OJnW39zUQ+/PmAdW5mZcXlL86ViFsXTxnV3muP?=
 =?us-ascii?Q?O7XS9wg8bYvd1TSi935LsvuUC6phsFiQOW63+d2+qiS8CGYUgc1crbtpa8d7?=
 =?us-ascii?Q?5av5Un7Zcjee0Sy/Eeej5+tqHQDeopIy91/6f7L2x1Icpwnh2UWJWWoQ1W58?=
 =?us-ascii?Q?GMDcYgKUF2ykqFsk4pgO4BBAp1pdFhUZRr8lQGw/4HIIc5zzDVtVlXkLqgwf?=
 =?us-ascii?Q?dRFj4vwGPgQH0B/fhTpSpa1We2cTkf//RGqFhduawbBCUG6GraHSSImjOPaA?=
 =?us-ascii?Q?tq0cnwgMf0jQxtRWkukpGhGiijZ4jkb7ASNnrUmaFS02Gc5/Wr3TwGdNTD3j?=
 =?us-ascii?Q?gERCCal+R32jWYBBEKpSz8hWRiKCNviWRrb7Em3hcaEngJoAv6xFwktQZ59O?=
 =?us-ascii?Q?kWdw+JtH90kBiPLAWftkHF66Ca+3pfCU6M6eoz08x45GQgbNQjQKDGO2pQlm?=
 =?us-ascii?Q?OgCy+KlP2XStGj2rDBTakrmsHcqSz8Oa4YXgE5GkYz3KBhI9ITlBywps43em?=
 =?us-ascii?Q?qRDY8zZKyLpdf8t1J9vxAaRmd1W2AcyE4snqRLNAKU1cYRSNeFtpRtFoStAf?=
 =?us-ascii?Q?pRrm5J909BKu6NUYNYWwhz1+z4QZAEgbkgMjfQMc89TrlV6PoF2D11RQ4kyh?=
 =?us-ascii?Q?cqFWzjMfHLqnLVhELbFs4e7X0fDc18SzE95Bpnb9Y5Qf2JdHMxZeH2GNn1ui?=
 =?us-ascii?Q?MogHj/avjeKG8+HKvFvD3VQgxQaTTokf3H1HswWhOKoNZkZ9RGImGKZyIQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:57.4905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1bef1e-92ac-4c66-4d41-08ddf6cf7d32
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9766

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 2256d2efa5ec..8317c3f279c9 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -169,7 +169,10 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked) {
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
+		}
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


