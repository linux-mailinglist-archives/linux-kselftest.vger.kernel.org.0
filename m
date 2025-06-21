Return-Path: <linux-kselftest+bounces-35558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B1AE2BB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAD1173C5E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F4271466;
	Sat, 21 Jun 2025 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QhqZ8luD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EB271444;
	Sat, 21 Jun 2025 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534683; cv=fail; b=tx869QVRr+pj6AvOls6RwUsPA83PCbDTrxYg8EGr8jHLBGu6HO3AnEerPfNSqRdZ21R2tCAThO64uEXFf29WzhitoYR2faQ3XpKYfy9PepkxQ8KZBsVWQrlbYrXEBn2cbMORCeL+q1vstAAKx3aHD+PG9KlWsPi0pq7aXt2vYoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534683; c=relaxed/simple;
	bh=NYT7Kl2KiDpNEY4nM41AiqL83jkDnpKaJd/u91bu59M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nveg8DZsNjSgGPonpuRcOVOcL4zkuVambM7QAty/7S7hmJr6Uoyg36csOspOyJBZrdlK0zDM2SspDBFpnUdbgkNOOu6Ti+q29NvRP4hBOghxj4MbTcl7mpPtLM1gtUIaWqSncz0aAKjlYmQPxHZGTNaYJw5MATf8m9u8pyJ6kpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QhqZ8luD; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPjXmpwZFO6M24qVq3EsNqiNWEfSnk+K6DQIaQaG519j/pQS4cyCWwySs6h+X9cQfugbqiDOeKHkUVgI7+k+gmV38K3XOx+Kv/8TPwWUPiECvJNwQ3JPZoV5FlUIH2h3vhg4cRFAVrJEl+F2pulac0bcw2u3LIyYaVFSOolZANDkeLPbfWQmaePxW5a7q9dzOrR7RZP7Ot3EcQ9gXTboQxg0XVfSVo6aVq2+GfMlS+IPq+Ki+fHbgN1mUKSJMzA8yxCWW4xQoIyzIQBhOXyXA6adUholPo1Si8ITXTDOQTHcVd4WI0vLOhXQM3EpZXlMAZLui0or8bYjgV2+1RF9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAgSzxxqgHw4LofoL6wOl9/t1AIkJgJZ4LQ8aq2GlRc=;
 b=Xa1rHvLXR/FygmGgo0hRNVpn2QtbEcxHULacOG0YNxkIdHwhPLsiGa5RKoxGLC9s6a6rMUscvzYW3zSMMNVJjkZ5qZ2fN0EGm7KOCtkZjxWr9NcS51v19Plt6wZ741jTTag8Ketfm+dvyZ3Nwg7KHxi7SfrO923bmjCn06o3cSAiEVeVDLbwa3HQDjxTOYf785ITDXwrc7GAztaZf9LGc9YSnM6RaR7z5/Afp/sJr1SX1i83iT21qBX0bz63JcM9ronnCcFPsN0TfuWphyq0M4xS5DYiMY/aJO1nuwOPOuN4Swrm3KSyhviHe9D1HTRo+x6EF4KeUFMTpC7up4Dqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAgSzxxqgHw4LofoL6wOl9/t1AIkJgJZ4LQ8aq2GlRc=;
 b=QhqZ8luDil07tHvxgAr6uGbQqaCvc6qzZGcqXbcY9u/vctN8efrHO5s9urJqIo1IWlyvAL3hcpkgst5j2OSt9FPb4y145Py7bDL26LTesUyGMlO2D9m4tUyz/tMFmYBrRJVs5jWGFnKRkwyVa7tLcYCoSPzp9E2gicybEDLX7FApknodjFBeETEqbtHQVd9ZVo97KRwNgSHXcdn56gz5Wq6vaatMNzbtHvMucoA+yo896FZhUwkKcjljs9ATCOBzTbhPuHlnl/5JbBjGafwvgt+aGNSL4Q6xd4MfGsmMpEtXkL8pStNQ+TPjd81+2NYtUJch9JfYBEu6fSM/0fgvMg==
Received: from DB8PR06CA0061.eurprd06.prod.outlook.com (2603:10a6:10:120::35)
 by AM9PR07MB7284.eurprd07.prod.outlook.com (2603:10a6:20b:2c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Sat, 21 Jun
 2025 19:37:57 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::22) by DB8PR06CA0061.outlook.office365.com
 (2603:10a6:10:120::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Sat, 21 Jun 2025 19:37:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id CAEA51C0010;
	Sat, 21 Jun 2025 22:37:55 +0300 (EEST)
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
Subject: [PATCH v9 net-next 07/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Sat, 21 Jun 2025 21:37:29 +0200
Message-Id: <20250621193737.16593-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AM9PR07MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: e12d1c6d-926a-4f4d-bbc2-08ddb0fb1fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnRmZERESERQWWNJK3VPbEtJQWpBbmo0NzAxbGRMa0lYWFlBMVVGK3NuNWRz?=
 =?utf-8?B?Y1hHdWQvVGpyTU9aSWVuNXRrY21WMTdjSVZjYXFhY3llTCtMa3ZFSm0wY2Ji?=
 =?utf-8?B?WW9MSnlzbEczbUpEVVhBZXg2NmRGQ2h1RHBnaG5SQXMxUVA5ZFAyVDBFa1hu?=
 =?utf-8?B?aDR4TFNNTWlwekk1K1E2amNKcTZKQ3MxaWRWZG00dklDc25ic1l2Q05odk9h?=
 =?utf-8?B?RzFJZVgyS3JGS3g0a1NLbWEvZlh6TW45YU1SeHJWUXhFM0dBcEs5U1c3T0pC?=
 =?utf-8?B?V3JHbWttVWU3STJPVlFxZTFKcTBaQy8reGpHemxiWUQxcmpuaWhQSzBmWFhp?=
 =?utf-8?B?c0VUQ2ppVFlRNW0xNWpYWm9TN3IxVkJzZ2MwcTN4N1hvMjhMWEd2eUlRa011?=
 =?utf-8?B?b0tPUEQzdW5KKzNIV09YaEc0NnJsZWlqdklZaWRqOW1EK2wreE9GRlFpRkl3?=
 =?utf-8?B?bGRCWkxyRU9kRHowOFJIWG14MFdnMmEvMW5IU05TUVI2UG9KNXBwWndCRVFS?=
 =?utf-8?B?YlYxR1FpMFE1a2dnWUFhdHFVYU9wdXRNTFU0T2xlOUFjWURUWSsxUEJLeDVm?=
 =?utf-8?B?RVdZdFp5VmhmdW45MTZnWWtkTTNEL0k3YlJhTkV6ODZ3ZGMyMEtBV0lueVYw?=
 =?utf-8?B?MUljV0s5MFNlVGFjQ3Z6Ny81L1FMY01XK2FjS1M4aTk2cTA3ZWxPcUxUS05r?=
 =?utf-8?B?VXNuTldGMFJoYlJPR3FrSTk4QjlQb1VtNnZXYVo5TEV6UmFjcG9TRWdzNy9J?=
 =?utf-8?B?d24ybTlLaFdQT3dyWHlabjNSSUtmZnJTYWh1d2dKV3V3SDFGWURuUUUzdG5u?=
 =?utf-8?B?UU15VTF2TzIvc3lwdjJaWE1vVC9KUjA1SGVuczlIVTRXd05YMmtjVXhNNS9I?=
 =?utf-8?B?UU5JWWhYZER2VjAreGcvajRmbnZwei9HT08xQkN4MWhZcUNpWlV2N3NNbXRM?=
 =?utf-8?B?WmVBTGRYQ0VKNlVwYUZMZU5WdlNaR2c2RmpkL2IrRngwRmsyNUdLNmlFWlBU?=
 =?utf-8?B?L2x1bmhFT2YvbS9mYWswZ3kxMGdkZUJrNDNGZUJKa1FnbUh2ZUtPUlhOTjVP?=
 =?utf-8?B?UUlqTm5mSTYveW16TXhWcG1RcXVkSzlEVXlEdFg3Tld5Y1lkTTVOT2FhREtC?=
 =?utf-8?B?QWd6T3VCQURDb2lpdE1qR0Nock5neTJxN2Q4eHVKWHNJaXBVRGh4b3lHZTZW?=
 =?utf-8?B?azhlN2crZFVrTHJmZHJZYlpSeU5qSi85eElGbXByWlB2dkg3NWdKMUphUVNQ?=
 =?utf-8?B?OWsvZU02bWNyUXU3NHhTV0dncDNvWnJrU3lnVkJWbXNPT0Z5SjBmdHVabVpk?=
 =?utf-8?B?bjFWWWtFNU4vQVlBUDdpeFl4WTcxQ0JIUjVsZ0xucnVMVExhTk9Kb1hEbEw1?=
 =?utf-8?B?dUErUnlDK0c2WFBFelptbUpjYlBDUEJ3NzIvbU56dDFWcTNpa2w1NkRGZ2M2?=
 =?utf-8?B?ZEtJUmZZalJyekFtcDd3bW02SXJ0VVROeE92Qk1lWm9aUkwxaUdUUUNieVZO?=
 =?utf-8?B?M01GVmN1QTFpcWUxMzZ3L3NCRklLRStUUGI4RXBqcE4wcHQvYlVZSjdkK3RZ?=
 =?utf-8?B?eWlMQWFpd1hXeDBQcG1ES3BQMWdWZ2NwbE5jeGxWRVhVZGMrSXdBUHhwUnR6?=
 =?utf-8?B?bkRiczNVNHg4cUdNS1J6MXhkb1g1bHMzZFlXNWhlYkFhYWEvMHd0Vi9IYnFR?=
 =?utf-8?B?a2VKTWNvdW83UEhMTW9uSm9qTEVHc3pkeGh5MEc0aGRsTU9OWEtMWndhUU81?=
 =?utf-8?B?ZTduN0JUT1hBb2NWVFFJaGNDbnlOdXlWdVhiZURhcHFTdzFGOFpMZS85TEVF?=
 =?utf-8?B?MnRKOVk0T0ZRY3pXOHdmQlFJeUo0U01mcUtzQnBPeTVNNzZyNU1YSklUUFNS?=
 =?utf-8?B?V0htd2dlTjc3Z2I5T1NBMUk2bG53K21lemt0K1hKSk1QS1AzWkNoT0xnMjVr?=
 =?utf-8?B?dmZ1UG8xMFY0Z0hYVE5JOXdvZ052ZEJOWWpta3o2ODdmUzY4QTVhcmFZSjgr?=
 =?utf-8?B?MTc3cGJmZDRNV2tOTWxhSndmV0hKUFMxaWQvR2lWdmcvRW41S3FuZEhqR013?=
 =?utf-8?B?T2NIMThxQWlpd0srcnNMQUVKZ3BId1N1dEVZUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:37:57.4132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12d1c6d-926a-4f4d-bbc2-08ddb0fb1fe6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7284

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
---
 net/ipv4/tcp_input.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5c0159cc0083..a327fc14b207 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1196,6 +1196,7 @@ struct tcp_sacktag_state {
 	u64	last_sackt;
 	u32	reord;
 	u32	sack_delivered;
+	u32	delivered_bytes;
 	int	flag;
 	unsigned int mss_now;
 	struct rate_sample *rate;
@@ -1557,7 +1558,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
 			  u32 start_seq, u32 end_seq,
-			  int dup_sack, int pcount,
+			  int dup_sack, int pcount, u32 plen,
 			  u64 xmit_time)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1617,6 +1618,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
+		state->delivered_bytes += plen;
 	}
 
 	/* D-SACK. We can detect redundant retransmission in S|R and plain R
@@ -1653,7 +1655,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 * tcp_highest_sack_seq() when skb is highest_sack.
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
-			start_seq, end_seq, dup_sack, pcount,
+			start_seq, end_seq, dup_sack, pcount, skb->len,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
@@ -1938,6 +1940,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
+						skb->len,
 						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
@@ -3446,6 +3449,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 
 		if (sacked & TCPCB_SACKED_ACKED) {
 			tp->sacked_out -= acked_pcount;
+			/* snd_una delta covers these skbs */
+			sack->delivered_bytes -= skb->len;
 		} else if (tcp_is_sack(tp)) {
 			tcp_count_delivered(tp, acked_pcount, ece_ack);
 			if (!tcp_skb_spurious_retrans(tp, skb))
@@ -3542,6 +3547,10 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
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
@@ -4004,6 +4013,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	sack_state.first_sackt = 0;
 	sack_state.rate = &rs;
 	sack_state.sack_delivered = 0;
+	sack_state.delivered_bytes = 0;
 
 	/* We very likely will need to access rtx queue. */
 	prefetch(sk->tcp_rtx_queue.rb_node);
-- 
2.34.1


