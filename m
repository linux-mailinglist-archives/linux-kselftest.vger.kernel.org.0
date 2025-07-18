Return-Path: <linux-kselftest+bounces-37573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D93B0A636
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7541C809AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126E2DECC0;
	Fri, 18 Jul 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rPieplTM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0E2DEA96;
	Fri, 18 Jul 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848469; cv=fail; b=avpMebsmBmqbL7HjY7jQTx+n26eyt9KCUVg0cafZYCTTnf+jYdLMaNVQ/J61Eb+wifHTjBFuyKHtY3kVh3locqwhfAQ66qMbJrVfPUa7FSI23tsbc7qYX5E5dTMPien8tDGfekYO/HZzLNCggRypZcmxqBA8NCjhsfhk6JFeOYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848469; c=relaxed/simple;
	bh=o+rdQ06vJZN5N/UR/Ot5TSmCFovjFVZA+ZjXOZ0c1Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtE+DF9Eg6XF62yHGptRLrvwFu+sgQlmNBkHjIOatzmVHEI2ZcpPeOADFTl7vlIqHK3WlfPeGeOl9M+37E+ngGUpwe4VlzSHumXUe6s0JiFmhuUYN0KTTs9/ASe0Dfq1KXSogNI1QTekl974cllJR9hxEdhLKAxu5N8952ccX/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rPieplTM; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNz+JkQ7K+rllb+Bh7WuSL913E9bsU9AmWsUOWy5jU1BGocas1lqqU8WjGcNEqJOs4boTAg8xkiT3uXTUxY1JnYRHBJXA1FMe960jdvfIAd3BisRKuL59NrAxEOD46M5zJqHWgtW3OYu3NNHjMfsFlXtmmW5Lo5YlcCQ5qMY0uXqxsOii0l9dGNdJEkqNJG9ZpkfS9N1WeDnL7eLZ3bvlJtpqqMaGwS0Dtd1x+UJ1q4UWVBc7TvgZ0ammznmayZugaP2IBSEaKq3IvItv1kFoW6tKW5h33zqGnzQFrNdAgbMvF5ScTMfoljoIWynM7C1RE/d8EzaTxS+05sWOQbA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obl70mufruY95/rVXvyqQhbBu5/U3o+ogd8QuxrfI9U=;
 b=cjWKIePa8JGI6hOqQ5fe8Y8PGvUOT3aUqW3oSRbhKnKCq5G5GxIijqdqOU7v5yEyUdVJVMCB1pmTfbgm4JV1hPWVFJMQ27FP9zU9wpad9K5HXTmEzteOTWwDycK5fXlTxdH2nkvUaV6+4RxzvufQLwFNXsNssgZHVXsXWotoaKGKYHYvjYniJPekl5d8ATMF9UgGTYkx2ZxmmaX8qT9ZMfEdSIfa+UdrLV/00nCGLA6u/qH8Eh8SSOKWQeBfBgSWrXTRIwjdO56peTapHFMaj8vDO/l3UtE29rtOnC2Ift+E87yO/eO/IDQBE1/SCwGzFT5EOCAaWJJCB4x8Nzc6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obl70mufruY95/rVXvyqQhbBu5/U3o+ogd8QuxrfI9U=;
 b=rPieplTMrCU08O2VfHtGXQKbjjTWkPr4ENo16xoizUpkBA3JLRYQ48shdpGt4Ufim1SLi2ru9axXI9y/H3NdUhfEp+G8uaZkwJYKGMZ1AXxyU+3W24SMGdRViVYXBuhShi7+luzLbG2JWAQeAPCXuFMUsrcgF0PQLyG8pLrFZcxQc5gKl2dkhqutvaCmWHGddVVV7V3Kgr9XcGpi/jDYhEPiGvMofinnBDT7990alDIwC3SiumEXm7Puyn14YcM4qNF5zewikeqH8gRg6RZDRN2rPjg527Qz0+feH1aPU6Z6XCZDUQwOh0K9Tk3g4y5nCJA2ieydF6yMUd2ZHr0WNw==
Received: from AM0PR02CA0082.eurprd02.prod.outlook.com (2603:10a6:208:154::23)
 by BESPR07MB10650.eurprd07.prod.outlook.com (2603:10a6:b10:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 14:21:03 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:208:154:cafe::80) by AM0PR02CA0082.outlook.office365.com
 (2603:10a6:208:154::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 14:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:21:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id D973D201C8;
	Fri, 18 Jul 2025 17:21:00 +0300 (EEST)
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
Subject: [PATCH v13 net-next 08/14] tcp: accecn: AccECN needs to know delivered bytes
Date: Fri, 18 Jul 2025 16:20:26 +0200
Message-Id: <20250718142032.10725-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|BESPR07MB10650:EE_
X-MS-Office365-Filtering-Correlation-Id: 38706bf6-16d0-4f44-f79e-08ddc6065371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnNiK2Q3bUo1K0R6OTRZUXJtNE1sN285ZTJ3TWtSYXJJd1BlcUlpbTluaW82?=
 =?utf-8?B?b0xxUytkaERVdXIzMUVIa0k1NU5xbkJlS0NvQzZXT0ZuaTZGSXBMb29XdHpJ?=
 =?utf-8?B?bXdjNnJaS1U1RzJPQlBWVU5BR1hpbVdPR0I4YklFVXRoNFlmN2ZZQ0V4OHJj?=
 =?utf-8?B?a2pWeUxhV040c3hOTTFBNy9HWEVJRmMrV2lJQ1g1YTl3K2pKQWNxYUtCMDlw?=
 =?utf-8?B?NWprekRtbW5tSGZidWIwR1E3dmhEZkdXZTBWUms3WEE5b0toQ1NOZHlwdlpH?=
 =?utf-8?B?dmRVK1U4VTZubVcrdWFKQlVKUEpERkxSWXFLVkZDSmFTd3hoQzdZVitUSHBv?=
 =?utf-8?B?STB0UE1nTE93R1c5QXQ3RGlDcytxbzdQQWhpQ29teXk1bjhHUUZ5czhaeVNC?=
 =?utf-8?B?NkNtVjhPa0JCeFhTTDFFQ2JBZllTWU1QbDdYRW4xZWwyWG9hYldudUtYRnlC?=
 =?utf-8?B?TGNvQTE3NDYydGppeENRSVdVTTVFMW4yY0JmSmhmUDl1K21idkVFcSt5d0li?=
 =?utf-8?B?cVFLQTRoM0hMVEdCekZvcHFvblZRNGVPNnUxd09SUWdrOXA0TDZnN1JYRHh3?=
 =?utf-8?B?by8xWUcyS3VTMmRIbmZhZEcxclRwQkplN3A0c2h2b3o5SW9CbmF3bjhDVlB6?=
 =?utf-8?B?d3NpeTNieDRuUHYzQmNLTVpkbkQ5bXA3NFBlQmlWUGZ0QTNScVF0Z1FjcVFE?=
 =?utf-8?B?M1d4SzBTQTdKTTMyWUVmMzNRWVJLOFh2bllYZzhlQmxvMUlBVEdIcjVleFpm?=
 =?utf-8?B?Tlg1UGtXcnBuM2tiWGFqUW9FVi9yL0pmK2tFQ0FXbXREb0c4Tzh3OExyajhk?=
 =?utf-8?B?TUZXazBBRDVjSlpsdEZiTUQ3eUdxUFAvT0VjVXFYL0l5ZUZaZndJbHhwZ0J3?=
 =?utf-8?B?R2VsREpPN2Y1T0lEcGpLSFdZYXF5SUd5Ujg5SC9mbnhxaWtyaUpwS1ZQaW5G?=
 =?utf-8?B?UWNxaHQ2RXdvcEtzeTlUK3JsQnFHeEtvLzZmL280SmdKd1U5cytMOGdtNXht?=
 =?utf-8?B?eEF0dXRkUllsS1dVejVhWDViMndLMHJoY3M3Nnp2Y2xMU0ZLSG5LZ1lEUytm?=
 =?utf-8?B?QzkrWnF1WnF4MlBJNytpaHNXekRzZzdZdHBtMGNMSlYzUmVMWWs3Nmw2YlBk?=
 =?utf-8?B?RVgrMkxzR0RJS1pETXdHZWNnMzgxR1JZdk5jb0dOYUJuS2hzYlUxMFNjYkFx?=
 =?utf-8?B?WFZucWJFaDl3Z3dLSkZ4RmNyaElVbHl0bzdQTy95Qml3RnNILzdqVVhLWld1?=
 =?utf-8?B?eHBBRHBXS2huYWRDcHpDZHFKQm9DSUZtUmFTVzR5dFpIU21WVkFzekFpUjFq?=
 =?utf-8?B?R1E2L3JSZkhCVkljRm92TzdocmRTWjZkYmRkVE5ycEFBMDJQVHF1ZUNzSHJ2?=
 =?utf-8?B?K21FbDQyZ0pUN1R4c2Fmcm1tQVRINEFzZUJrKzZON3lXUitIZkJjVFM4RDA0?=
 =?utf-8?B?MWllRW1FTjU2YkQ5eGllVkYrMGxQaExhdm1pY3dpUjZLVXpQdmQxb3p2RWhx?=
 =?utf-8?B?OHE0YWxYLzc5S0Z0RG9Fa1BxL242NzVqcTE0U0RTcktTdzNGUHNaQXZzb0Ja?=
 =?utf-8?B?RVFXenp1Qm02c1hsZVZBTG5kOFJiN1BFQmw0Ylpta3VvUWZzL2k5RGEyR3NV?=
 =?utf-8?B?VEdPelVmYXIrVk95LzBBVzN1Y3ZIMEsxNmZvN3BqWG5YL2RvaVlzSFNucEgw?=
 =?utf-8?B?WFRJOEdyNWJvSG5UMmM0THZUTTgzSWJFM1NvdUVON1JHdGF3bHJpZGdmdFY4?=
 =?utf-8?B?QXV1d1JSNzIzeDlKWTZhTzZMNVlYdW16VzFFRkg1OEs3ZFZpVFF0eUE2Sktz?=
 =?utf-8?B?VzB4eVdmRlJvUittKzB2dWVIRExvR3k1c2NUQkZlL21ZNnM5RmV1ellwSWtn?=
 =?utf-8?B?TnFDYThSVkJEV2hTUHRhcHE0OXU3Z3M0aXoxYVE4ZDczTTVMN3RFNjVIbE15?=
 =?utf-8?B?cEFpbE5GR1VJbjk3YUcxU09naFpmZUJjRjFjZDdEeXRMWmlhbHV6Mm5CNHlo?=
 =?utf-8?B?M3pxT0FwKy9RSHNsUG56MHNjZkxVR0VBN0JldERQYWVoRUFQL0pEK29HVmcy?=
 =?utf-8?B?b005Z2IvNWVQTTZQQ0ZpMUxqWlg0emF5NWdDdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:21:02.3531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38706bf6-16d0-4f44-f79e-08ddc6065371
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB10650

From: Ilpo Järvinen <ij@kernel.org>

AccECN byte counter estimation requires delivered bytes
which can be calculated while processing SACK blocks and
cumulative ACK. The delivered bytes will be used to estimate
the byte counters between AccECN option (on ACKs w/o the
option).

Non-SACK calculation is quite annoying, inaccurate, and
likely bogus.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp_input.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 064b26e2086d..3d4bc2770749 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1050,6 +1050,7 @@ struct tcp_sacktag_state {
 	u64	last_sackt;
 	u32	reord;
 	u32	sack_delivered;
+	u32	delivered_bytes;
 	int	flag;
 	unsigned int mss_now;
 	struct rate_sample *rate;
@@ -1411,7 +1412,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
 			  u32 start_seq, u32 end_seq,
-			  int dup_sack, int pcount,
+			  int dup_sack, int pcount, u32 plen,
 			  u64 xmit_time)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1471,6 +1472,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
+		state->delivered_bytes += plen;
 	}
 
 	/* D-SACK. We can detect redundant retransmission in S|R and plain R
@@ -1507,7 +1509,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 * tcp_highest_sack_seq() when skb is highest_sack.
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
-			start_seq, end_seq, dup_sack, pcount,
+			start_seq, end_seq, dup_sack, pcount, skb->len,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
@@ -1792,6 +1794,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
+						skb->len,
 						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
@@ -3300,6 +3303,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 
 		if (sacked & TCPCB_SACKED_ACKED) {
 			tp->sacked_out -= acked_pcount;
+			/* snd_una delta covers these skbs */
+			sack->delivered_bytes -= skb->len;
 		} else if (tcp_is_sack(tp)) {
 			tcp_count_delivered(tp, acked_pcount, ece_ack);
 			if (!tcp_skb_spurious_retrans(tp, skb))
@@ -3396,6 +3401,10 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			if (before(reord, prior_fack))
 				tcp_check_sack_reordering(sk, reord, 0);
 		}
+
+		sack->delivered_bytes = (skb ?
+					 TCP_SKB_CB(skb)->seq : tp->snd_una) -
+					 prior_snd_una;
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
 		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
 						    tcp_skb_timestamp_us(skb))) {
@@ -3858,6 +3867,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	sack_state.first_sackt = 0;
 	sack_state.rate = &rs;
 	sack_state.sack_delivered = 0;
+	sack_state.delivered_bytes = 0;
 
 	/* We very likely will need to access rtx queue. */
 	prefetch(sk->tcp_rtx_queue.rb_node);
-- 
2.34.1


