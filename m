Return-Path: <linux-kselftest+bounces-44261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01285C18F74
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5272F467144
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04432ABF6;
	Wed, 29 Oct 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EUfmVrz9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DCE313532;
	Wed, 29 Oct 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725200; cv=fail; b=ohpIoy4L/mqUSzpqmzsCn8wdkSIKo68+Ie5Ekb1ZDWFhPttODqeUp0qXCRa6w53AO4mie7W97rxCUsaUC8x1SrwSQlSV1Q+iXsTtAp7H/t3cb6O2TmynvnnP7jsppeuJ6uAUiDW3IdPfw/is1BfuXsSCGvLJnbZ9RgxkTmYdK/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725200; c=relaxed/simple;
	bh=GeTcQ7Cr98RzPxeasujjNcocwNmZtG/Gdaik4pF8STA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjoiGbjIeghnDd6Glh3DimFrRosgbrL018PCgB4DUM7D7sM5fUVsRyxamaoQVGRpZ/+oBxX+imkp2PY46oRL1cIe7ie+IYcX16j6hU2TxVrBbU687M4+0GCrTHPmpk5rXab8pKFXis3clYzKkOCqcymbAykJzOGDfnCybmOaelk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EUfmVrz9; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwXFooPdtppQPf2Zdx4vneaL+BpCkTY/gu68cYJO+3GV1PVfCog/QjLnSmY0nrugb8ADOzXoGcqRJiesM1H0s+ZgJPu45cW6Nv/f46ZHdSN3shBGTNYA35eLDJdt6cFtaw8imFU/wwznyDZpVKAMVd3l7/9J4orpQuYAN+g+JQvCjgP5ZJ76NRm+NpIghnro+1oHse1/RMVysjqCuqc2Xu7rwIHzXbroYVf52K/wKSYORLb0abPmMIkeaT4tgOlbMzKWIgd2sbnpvwwASRo2SoCO9i2IW/kNByMRo+XkLjLmDjciSYsICqs+rPNI/i4x4ZrIX9bYr7HNBkLqivf7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58lNnSobhs9Y81kVbO0FmLxd7z65M6EZZANnq4zBvO8=;
 b=IyaLXZQfVFGMsvYZpFig63TKivI3Hq7gmoZWZZEzGaJnGz2rv7e2tb3LwlKXoxKFz4YDDlO6S0m2sF5AxQUEzW/b0J4Bv06VjXaqBvjzGUi2THpUJJ5JzqDxjWT6SF4RHKVyOP3VaednfaltCnPBL7SqbM4Ace8WMctA2W+aEAicaK/SmGTWASj74K1hzVEjCdpnVRetVvYs7+LeJJDyGPXKN0s2se8bnQBAlfJVoQGT3RtLtG+1H8vtVPe0iYYivAEqvDEQ4Ql/noXfcj9bc1tcEq93xCmGoLqXbgFCxVOmDRy0MAOy3mlHbFDuxmBLRWhQ0sWWvB4/hKKwg4rKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58lNnSobhs9Y81kVbO0FmLxd7z65M6EZZANnq4zBvO8=;
 b=EUfmVrz9NAh8dI38VM4geoDt8FpDHHWOeOqs9IiDiKS1uxe7d/VBKUm7S/xW0YbjJNOR3gEnMGEP0DjZpT1fRi9NNDMpsphlhU2M4rLM3vYYo/4vP3AOaYXvqD16pMix54pfPa+I1LqSr+nQEHUPIzbHSgQu6EsL4oGgRtax2pxuFhP+z5vv3b6wistMgzINyLAqdXvA+H/f7pONXZYkHBRJDUQHWQi2qc/JqJtJzVyY1LeLwdb5B3uk87Kx2uDrcA/iI5JGVlsTkX1dIi5GPNLHFyOzqLXrAzzJ6LesAXcvG3UGSlYo2ed9Pq222YCpZDPsCb03ZzgnBmHi4+K9dQ==
Received: from CWLP265CA0420.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::18)
 by VI0PR07MB11111.eurprd07.prod.outlook.com (2603:10a6:800:300::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:06:35 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:400:1b6:cafe::f1) by CWLP265CA0420.outlook.office365.com
 (2603:10a6:400:1b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 9BA56200E1;
	Wed, 29 Oct 2025 10:06:33 +0200 (EET)
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
Subject: [PATCH v5 net-next 09/14] tcp: move increment of num_retrans
Date: Wed, 29 Oct 2025 09:06:03 +0100
Message-Id: <20251029080608.92428-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|VI0PR07MB11111:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d73c07b9-1642-4456-833e-08de16c2143f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?+NuNtwnTGegmlZye/Gqnoj+PRqr9/PHPot5oN6UJd+eZ1ahhpVAy0s34APZw?=
 =?us-ascii?Q?qwpwIzx2helCKZJhs2lkeUfO0DaHlOJapyfc8aIoqpPptMFeJp6dJWtyGaYO?=
 =?us-ascii?Q?cGBZDKilnYdLH0VH7w5nPyR/CqpBzUixUF8+giG0STziDL0PFQXvirY2rbEf?=
 =?us-ascii?Q?/aR9CtXWX2+UJhMSC5MpmQo49YSiPgxeVXd3lSBzFmuuNXWAval0uFldObX6?=
 =?us-ascii?Q?5ETi4AgvBF54pv/hLu4GaFv03qZgYp/QtXy+kNpZR+fMc1t2Deq7b/cqegXL?=
 =?us-ascii?Q?GgiVbqIl8U3rnIKTkz4/WKMml5Wg8JVi4+WJFP67BxmmrfLdTleqYy5dK4Ty?=
 =?us-ascii?Q?voRnPXW6aIQTT9TNrzti37amQimDfXL4BiHy0sT+GNXseOrlP4EnlhUA71pD?=
 =?us-ascii?Q?QhC407gIiMAcHN/9C8v//XVkFrSzTw18T31u+xZAMblWCSDH68marMeG3Ct7?=
 =?us-ascii?Q?KXdjXOYFDr4VQBxUpf3fSReipPIXM1+ubt/Txr9gxwc9q1SOaN76yqa167r+?=
 =?us-ascii?Q?dIh5BcspQWcV4f34rwIvmRfImtD7G7eXDcdPBXwnl+O+i8oTwArA5XL6MwR2?=
 =?us-ascii?Q?ipVrZP3I7tjrJTKemzI9xiwTEU+L1Q4IsXsBbuKQaodN6HgnMFS77I7H4xFj?=
 =?us-ascii?Q?NLr4cCbfFb/6RycAxsl0bgc7h22V975BR343p8TVI60I8X5hDkrddmfZn9XA?=
 =?us-ascii?Q?L3Fdg8vgmT2zgGB5wImNTlynPU2VcKlbF2jWcIEKgbSdcsQSSIo6bYugY5FZ?=
 =?us-ascii?Q?TA5ohvNs2891rJ59OFcq7w7459ZbM3g4eHxOm7eiK0BXAq53SJIGQBuyMk5F?=
 =?us-ascii?Q?xDhCxQBOI23PrUC3yo+qlNAVxi26BqhCBHwXJkRFCEz586VA/4FLfYvRlCPP?=
 =?us-ascii?Q?NQww9zy9Ogdv9fRR/ao3AoSre8pnqg+S7ZqiwQM1y6o6lF0pPeiGI4cjaUgl?=
 =?us-ascii?Q?ldLhZymDRr8xuEHfsAnK9XMwgKJcCaRBqzgp4n4MeY/UBwOVrx491MocQgW9?=
 =?us-ascii?Q?gNPPJj/Ys9Y1u9XP1MEn4c9CKpeZCjziUjedcv2YCuN2257FLlK4MVHCffm/?=
 =?us-ascii?Q?AYQZDRCXy3Mrs+7+uKZiOLzGzWkehnuzSJ2kz92s8YFRMttUZOXEBi8a5UXU?=
 =?us-ascii?Q?OKw/2WKdBnpbQ7OKP+8tVSGLxmFpPFAGUOwUWS4DSnJEE5DWwTO4RUVicEDy?=
 =?us-ascii?Q?h4FIcJYHs778havMhlUbk9wLZfvSbTP75jWinLo4d25OchqoMEarHH3rrozh?=
 =?us-ascii?Q?nIwSdBXnbxXs7vEvvJaoU1mY2CDOhuSswK5l9YRlnApHmAPzuIAzVRnMnIi8?=
 =?us-ascii?Q?0c7JOZBTltdGSqAS6m0lZuP/qhIqTFXAkJVJJ18qv8MJ6og2VfIndVPIJWXz?=
 =?us-ascii?Q?is3CsQdBkWutR1sGVQTQ388/xr7G9yFhbW74LKin+3CXw6VjS1B8HgTNZnt1?=
 =?us-ascii?Q?0Ac6/T+gRoDwwNQ9YVkui0q4aqzzjp5e7XJBqaeZy7ir/Pi6dXS6fBG328sy?=
 =?us-ascii?Q?j8UVkSmZ5i12bMLzPyKed1HROxH8vAyraLIAA4n3zFUfIWwONLHUswWlc5qY?=
 =?us-ascii?Q?TninDuZZ9gWZ1LyE7tviEvBUI7C1JTmQ5OLYSY4s?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:35.1637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73c07b9-1642-4456-833e-08de16c2143f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11111

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, num_retrans = 0 for the first SYN/ACK and the first
retransmitted SYN/ACK; however, an upcoming change will need to
differentiate between those two conditions. This patch moves the
increment of num_tranns before rtx_syn_ack() so we can distinguish
between these two cases when making SYN/ACK.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 71f65bb26675..90a71556b93c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4609,6 +4609,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
+	WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
@@ -4622,7 +4623,8 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 			tcp_sk_rw(sk)->total_retrans++;
 		}
 		trace_tcp_retransmit_synack(sk, req);
-		WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
+	} else {
+		WRITE_ONCE(req->num_retrans, req->num_retrans - 1);
 	}
 	return res;
 }
-- 
2.34.1


