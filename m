Return-Path: <linux-kselftest+bounces-31097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C46A92DA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C3F1B65B84
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FDF223322;
	Thu, 17 Apr 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tSmJCdfL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722021D59A;
	Thu, 17 Apr 2025 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930887; cv=fail; b=oMqWVkkQfJOPrCOY9fCk5j5v6dJ8pLL7SRO3i3RpM3dA8SEB4WyxrY5smovrzqn3nCXFicYI3vldL1abZxE2nHMQqNFsWpX+g4DlWiv16E3KkiV5KFhL39oVaNqgT2FPAKtzdAcpsRoNg4D6609Ge1f1pPQT0xFMAazihjoN4ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930887; c=relaxed/simple;
	bh=O+Ij6PnJNya24eNiQTfN4/gm9ym90RRZa7lNIALkuHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHPctEQht2MxzSvjBSY7e4N1lXhrAnRvzWj8zTJQKwcJ0zeXTL7fmMxvV8mzaraECzPQP4jpMUVRQt2f78Fo4MsgbOqyJqFQet9/4WOP0ZIaX48hwfmJ6i1vwjZrQWCeLZJzlKTTgDAQXULmTA1L+dETqsC2Le9Vk+QmK6KdQBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tSmJCdfL; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNbHfK4ogjylaZfFPXFtOxQUKQ11oJ0KMSWJs7Ct1QLlw6K9QgLWAHIfJhy2RrAAh115AzJzxrQclg3w/NQurU1ukttxYqfburmb8ohf+Gwgob0NxuAcvKWUkDuGwtI/tRMTYdpJ3aaqp87G266BpN7yultQjCvPGcMxxHCxBzlonVNMVtwSwbdKksb0plhdhni5oHDX3EjvIaqTVJLdsM13yTPPfcPWSy1puNQBY4rD62N1q0/yze/GqrG+0E6csbC4ngJ+gPa+UTS20EoMZiNGk3IJE89GucknSc2Z0Nl0dSVPh0Z+3J1gEvPXhzgvRvuteaj3vUaIs4BkOMzWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKL/5UK0OSKaRdCSKsrub6d7dkYoherKF2ghFpWUBbM=;
 b=PL2og8TjwG6hhJV7zHHIX+PlTVNR8bPeq27zjGNT7Bc5ysdeVMXkiMD8bOBMUPD+KRWrMs3LBVKsDrGZJ+dz5PKsQ4Bx5U9ndllcsSF6chfvkDRjA/xH3gzpfJ7+HIlkUwbQLFXPKBY5G+otMKedr2JrSORlGWs8kIZF5oLwuPeLVyZdCctsbp9JL++js9AbfEg4qf3z0U1xWCUQsAOOxa7CLiTvG/FuogLsGtGySCNAkiBzqg72+2YNsi6EGl1isoF/eXxbJ1rc7z5O58zAMVmrqcTMxWVEwqPkLZFGaLPpqLjLbC7p7swsKgUMjORmhjrPyyJ22j2+ZSin3fL/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKL/5UK0OSKaRdCSKsrub6d7dkYoherKF2ghFpWUBbM=;
 b=tSmJCdfLrcreTsZ5tisd2poo3oK5vvPqQ4v2b4p0pp9UF5iH5B00TlpmA1ZuIpDn34+dxaW9mlTimkPlKEgIGop3xx1Dvvtpp5cwk4AAVvDbEAwQQCt0Uzg4RcqRpU9YboxfkRn7O9mPlsSZhkvEjFmVvpD4Kc48nziAtEu7I0Yqed5yoqW2idpwmJYPqEG+vrW0wcJOGMkP3vqXmIDHS4EKw2e4BRbY62abL2tQFnGNBPek0Kmt20IY5fKiZM3C6vddPciM+27VIeEkbQeW4D1L2/K8tnHgIf49C/75yxkXDZX4dx2r7DaEEzROycqkpdeSem4y1HNpZL5W/m34fw==
Received: from DB9PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:10:1d9::23)
 by AS8PR07MB8022.eurprd07.prod.outlook.com (2603:10a6:20b:39d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 23:01:19 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::91) by DB9PR02CA0018.outlook.office365.com
 (2603:10a6:10:1d9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 23:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:01:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8F4FD2081B;
	Fri, 18 Apr 2025 02:01:17 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 12/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Fri, 18 Apr 2025 01:00:26 +0200
Message-Id: <20250417230029.21905-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|AS8PR07MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb4da39-ffc0-4282-771c-08dd7e03c3bf
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WkpOUnNkanc1V2NIMVlLOHZkK0VPRjhkNmFnTjIyNlIvdVhPdCtVcTFWbncr?=
 =?utf-8?B?L25DYTk4YWtuOFU2K1k4K1BDS1ZheWxTaHJpdTVwK0hpbExMY25VanRoWEN6?=
 =?utf-8?B?SStBUkh6REpsRDhuYVFNMDAwRno1elcyZHJxVmNDam82MjlzRGdvU09kb01x?=
 =?utf-8?B?Vng1RW05SzdPdERPck9nRDBML1NCamcxejRkdmgzK0VyMU5EZDg4WWlkb1lR?=
 =?utf-8?B?Rk1DelplQnVPQ1VNTTR0dG05SmVZOUVtUi9nVG1FV1JGL0pBSWpaZ3F2WGtQ?=
 =?utf-8?B?SUJYQTBUTjhwUUlWWXEwTlc5ZTZ6eWxkaWFzUmtmZTZ3OTh5SENHdlNYVlRm?=
 =?utf-8?B?SzVHTHBuUVRkeWh3WWNhYlo0YXpSQU41NmlabVByV0QzVmYyanhEMVdzcHFk?=
 =?utf-8?B?YUtreHdBSzQ2MHVkM3dNcFF4b3VxM1gyaEJrRmdIVW5CaU83cnBKRVhCU20y?=
 =?utf-8?B?K3hhK3MveEZJQmlsR0dpK1IrR3lyeEQveXJCcWJCSmpSZGprT2krUWNGZWdu?=
 =?utf-8?B?MXoyc1AyT05Icll5K2JyQ1lKdWdneHUxdmVMNnk1M04rZjVYNStUb2R5TmNk?=
 =?utf-8?B?RjNaT3JCMG12N1ZBZTR3clZpV1RmOThyS1lteFFwNzZSV2ErQ3NBQnM1YlJV?=
 =?utf-8?B?ZHNGS2V5RGZ2ZmNxYWU1OWhmNVllQlFKa3N0WVdOTVlueXo5SVpwdTVUQkhT?=
 =?utf-8?B?anE0RUJqejY4NWJLaC91bnhRZFhpcnc2cFZZTkszdTVvZWdtbEVaOTIwZ2VM?=
 =?utf-8?B?OUVUYzUzSVM2blJ2RzhRSytMM0d5NVQybXhCZ3dOa3hhNDdaSlBtSkNySm1G?=
 =?utf-8?B?cWF5ek5NLzE2Y1VYYnkvYXd1dVBNSTlXWVVWN2pmeEJwSmlkQk11b2s2aUZ2?=
 =?utf-8?B?VS9pd2EvOEJRUHpGOWNJeldmL1gzeVE1dm9WU0dLZGRZN0gvcXZzalFndVNG?=
 =?utf-8?B?SmdKVFRXTHNVV2E5NDRBZXdlSWFuSzY3NkdHNElFZHNwQTl5a2JZRXAvcmg1?=
 =?utf-8?B?RzdrSFpXb0xlQVRiZVB5VDB6TytJem1RZGlyZis2TnRzcGdhMHNGaW15cWlR?=
 =?utf-8?B?WlNvaXEvbDBzSlFvT25HTHY3VHBEUm1MdFp2R0RRdlM0cWUwWUMwcWprd0RR?=
 =?utf-8?B?eS9yUW1PWDV6TGZ6ZVN2UUplb29jRTlhQ2RJT3BnbWdkNm54a1Z4d1hlVStN?=
 =?utf-8?B?UGwvKzNmVWpONThXR3dXRXNyZkZ0Mkl4VElsamp3bHI2REJCc0t1K0ZiTXVk?=
 =?utf-8?B?S1pqOHdId0lzeEVqNlF4ZDduRWNPWExEeks3ZGJwdktGQzhBaG1JRFgwcmls?=
 =?utf-8?B?YXMrZzJzNmpWTFZwbmV2ck5xdkVxdU9YRjNiQmc0MkhENzZSeUJsdG5xSHpX?=
 =?utf-8?B?VTNGaC95SFNEZ1ZTTHJ6ZUVEKytDcWRyYk1GeDFsRjRYam5uZW1Cc2toUjlD?=
 =?utf-8?B?ZXY3a3loamVHbXVJUDNZTTZqUGJTQ01aSXhDbG94S1Z6TjJsUVVkN2dSMzBt?=
 =?utf-8?B?VUxPTXg0K2pxRnE5NmJhdXo4aUxJMWRSajYrelJQR01BL05PLytRWWRnelhV?=
 =?utf-8?B?ZU5CeERFck1SbnBwV0hqYVNDYVczdEZjaWJTT1ZOQWVkMWpuNURMY1NZVGpk?=
 =?utf-8?B?eTd6dHp0VUtmL3A3VGluQ3pMYnNwd0U0NGtEOFF3MUpZU1hWd3hua3RqYm5a?=
 =?utf-8?B?NUEwcUFWT092QWlGaUNWQUpGOTRXWVhCaXl3cHBEa0hMWndhYjZyUlhVZ3py?=
 =?utf-8?B?UVlpbTd1RGUwN2hwMnZKNUk1WjVvYTBZeEFWbmJ4L2xzVzFWTUFLNUlGUGtO?=
 =?utf-8?B?NUEyUm9FS3NCOW51RlVYTE55Y25kb3VXaHN4Q1hUby9mSHRwRVpHSWNqZzR5?=
 =?utf-8?B?Ry95THhDbXQvT2pNd1k3NXZyTEMvRWd2OFI1VXZlcVBnVE10em5JbDJIYWRY?=
 =?utf-8?B?aUVOd0ZSN0J0V1NQMjQrYXV6Mk9VK0dOWC9FUERVUnYrR0p5TGY1amVpOGt5?=
 =?utf-8?B?SXNITG9yTXZIZzl1UEZMRCtCaFE0cHY2R3FSV0hrYjhKM0cxbmZ1NGhiSWg5?=
 =?utf-8?B?aW9raTBiTXZORFBmNklqVmFDeGh3R0hwUEdOZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:01:19.0103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb4da39-ffc0-4282-771c-08dd7e03c3bf
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8022

From: Ilpo Järvinen <ij@kernel.org>

The heuristic algorithm from draft-11 Appendix A.2.2 to
mitigate against false ACE field overflows.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0ade2873b84e..3ceed4792d13 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -244,6 +244,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8f1e10530880..54f798161d14 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -694,16 +694,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
 				int flag)
 {
+	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 delta, safe_delta;
+	u32 delta, safe_delta, d_ceb;
+	bool opt_deltas_valid;
 	u32 corrected_ace;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
-	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
+						     delivered_bytes, flag);
 
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
@@ -726,6 +729,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+		if (d_ceb > delta * tp->mss_cache)
+			return safe_delta;
+		if (d_ceb <
+		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
+			return delta;
+	}
+
 	return safe_delta;
 }
 
-- 
2.34.1


