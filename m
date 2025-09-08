Return-Path: <linux-kselftest+bounces-40975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 861CAB49732
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED957A3FAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDE317704;
	Mon,  8 Sep 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="h6ic/E4l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478E3164B4;
	Mon,  8 Sep 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352878; cv=fail; b=oisN0V/IY826vOgcKSiAw3EnuHA64q4KRvMSqQL4hsjRn6dzDvyFVXWUqu9z4LooMvhN6z1lFkBw6nySt+90t/hKLdIBiVU4DyfPH1ogqK+XZpK8emP0j2toIibjUfOdqj/1mdczGV9BM8uiSBEV3FGvckAua2UyPJfJEBjxZZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352878; c=relaxed/simple;
	bh=aRcFNCJ2YlLqD8dPTUHRzyqeZ6j/Y/EXU5atMBKd/Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNTjibtZxsyJHRDP7pEG4ItmvsKOGPwnD0sCqBQMeYO7AsGHcVyy3LFnRoXMVclirdl2qc2gSLb2ZXm9GS0S5CYYW5A9esLYyHadIoPPca6YOIJYk8n4CUoJaRp7h2GmulKxCKI0nKnCnajjGO3Q4Ru3cF7CkYjUhoswLRR3aPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=h6ic/E4l; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZku/oUq369qKoRmu0fnjg9xwLUS/FR4WTTlguc8jyhfTzgBP9UzQckHCogqVg+wJowM9q/ewFdp43awv4qmxTTrdIpNwJGV5g+Uxn3TrZMnbXoTho/NImmYLK5xKkcuUUthdDqr/CVlk3RvuyDEGQ8ZGrjVc69M0qD1RFrv4I1Je64Y9Pq20/Wo5Ex3CsnSIIQQB4JuoEE+tCNkXFyXo7H1jtmTqfxaqism4ggS6/UkRSwZzgapZntplvdzhxuGXTDsSWDSARadVgT6G7Ig0onfySI1IntUMbYNWG2sojd05m/2HCN/JStmqICDZAiA8ziwPE0PAqinfnQmWLQF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQIbGIYFjk4GSW/ZVrAgS6HFTyA69abrskTQq/ygng8=;
 b=nVBa56JiA0IvLFpobn7k49aKzya+sdtv2ArPQdRcGubiTJEsGdpspwiJ8AdqF4CCNUE7ZoWnrC/8fUPHufpSOsMUexIX496jPkLc/Qdy2mp8kHXf3jDIUCY2k4pSMXODxUdNJuncf0eNTFVf+0K19xF0xD1lQmTGtG4yynKdmqB9GCc3GNeqGKriDIPs3aiJ8MXYS3SptO/qcNIR7McZTQaEwzAqnSbcVJEvsDpQI6UclyHlIMepiMmK/bzTvd9AIuWDbFlUiyOemNxxjMuUbJTQbCDoTO64ugLPQzlcZ19sjVD8z5AOMgiQQUbhiTx+knRcGKv+z3oWIuQnRgjz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQIbGIYFjk4GSW/ZVrAgS6HFTyA69abrskTQq/ygng8=;
 b=h6ic/E4lPJhp7+J1DeIfRh/ilWu0fd3RNnqZb4p4fqrMEWlDkPsPuwS9YxgeqIqiHNbdNgn1QbG176W6uPqLU6ozmCM8BxxNXanN0qqJF4RyOBuyF9iLL5FlXsTN8SmXgB9emscYw+fpn8M/UCATxAZgBYDHyY5ZsvWYNQPEiCYrT0duYutNpEaIcSJ/u/2zG8X/K5kyECNgmTP5aPsjeH2y9I9LaZFA72NQFD1au0yfnMDoBFaE3wAOrsemqBGpCL/dtjHPhH27Fap2dfX0EEdjmFYa3c5AAn0mh7S5YDWDZyoGGTZGWHLLrZw0nOosBgxXM9JNCM5M5zDZJuSNXw==
Received: from AS4P189CA0043.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::19)
 by DU0PR07MB8442.eurprd07.prod.outlook.com (2603:10a6:10:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 8 Sep
 2025 17:34:30 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::bf) by AS4P189CA0043.outlook.office365.com
 (2603:10a6:20b:5dd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 784041C0053;
	Mon,  8 Sep 2025 20:34:27 +0300 (EEST)
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
Subject: [PATCH v17 net-next 08/14] tcp: accecn: AccECN needs to know delivered bytes
Date: Mon,  8 Sep 2025 19:34:02 +0200
Message-Id: <20250908173408.79715-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DU0PR07MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a22f93-5018-4259-ed88-08ddeefdf752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STNPaUp3MnFSOHo3MEdjSXBGaTk1VzFydmE0RXhFU2ZFUGF6Q0I2anhabE5a?=
 =?utf-8?B?OVE5RjR5dVNGeUplbzlwaFQ0eWRTNnBkV1g1SXhsRkdxSnhWNS9nWWxrV2Jn?=
 =?utf-8?B?cXBubzVMbEtibDBSd3kvek9UZGJjbzhrRnZRYUNzMWFRWFkxWC9UTEdCeERG?=
 =?utf-8?B?MVRyQVQ2blExWGhNMytHbXBDalZUREV1NUU2cEw0SzZuZU01SmlUOUtZRjVj?=
 =?utf-8?B?YWUrdW1JWjRmcXRJRmFVbi9rckhSemtNUU0wMlNudXo2a2dRMVlIb3RnNHJD?=
 =?utf-8?B?MXVzekM1L2V1SlNNVHFBL1NKVHpyc2VlQllqV0h1THFBejUxQWNGaTd2ZzE5?=
 =?utf-8?B?MkVDcGNYamdRdmtzMWswNklmd2NKZEFPeU9SOEdDeDYvM0N5MGRKZ1ExeU9q?=
 =?utf-8?B?MFI5VVB5Mmc0SjBpTi85Y0JtWUthQ3VyeHVJdDJaS0t2YXlTVGYwOHh6K2Yz?=
 =?utf-8?B?cndYR0U3MFlFUXZqSlhCNlJ2aUc0Q1pOQVN4Z08veTFRTlMvNXlDbnhlQmsv?=
 =?utf-8?B?bE1PNStDRHNQN3JFcmJJWTZtbDdvSVF5d2xTcW5ucmhWYW9keFg5aUQyRHZ6?=
 =?utf-8?B?OTNyT1VyM3ZxeEtseVI3VU1XK04yYzNkZjQvTlB1ZUNGSHNQZDl6L3V0WkRw?=
 =?utf-8?B?bXEvaEVvTzVXYWZtVUNqVU1RTEJpNVJKbTA1THR0d3I0Qlkyb0JodTh5cC84?=
 =?utf-8?B?OHNEZkJZVFFrZTlmZHo5WGxFSTUzejVFQWE5elI1b2gzRlBtdzF1d1g4WVdP?=
 =?utf-8?B?dVdFWEoxSVh6Qis5NTdtcjlIbVNRRnVOTStRNGxTNmRjWW8rZDd4WUdCMUNV?=
 =?utf-8?B?VmNaMXZsODA0TFZjekFVS1ZXamlLVWhtOHJjMW9KQjVTR1Y4LzJSY0F3dVhE?=
 =?utf-8?B?YW5tS0pGMUNWcGRISWtsS3kwdGovM0FLQklLVHBSVHpYWEExaWVZT1V3Rzha?=
 =?utf-8?B?b2V2dlBZWndyU3V3N1FzTldCc2RlbWk0d01KczVXQlZkRTRLQzMxRTRBaGZu?=
 =?utf-8?B?NUNIZ1NZVTVPYWNGSSs1bllic3RkY1k0Sm9xbTNjTXoxWmxVOUNsQU5IaGho?=
 =?utf-8?B?dFRDM2FDY1hVOHk2ZGQ1YlE3MDlPemN5OU1DM3lORTZPTDR1c1FGbkxnQ2ww?=
 =?utf-8?B?M2FGcElxWVJRdkxxbERYb3ZiZURoOE5LNWc3OVV5SDQxMTBhQVp3N0MzYUJI?=
 =?utf-8?B?djdjWHEvZ21vOWtFbnNqUU9qMFBFSU1YT1NtZDRVdlZldXZKekhVRWxGaFV1?=
 =?utf-8?B?TG5pVCtHV3J6cGxGNVFaRDZTSTEzckxQdy9lS0lITG5UUkcvS2s5RndubDMx?=
 =?utf-8?B?TEN6ZG8rSGNBYVRvRnU5a2VOdXMyME9pZnhETG9ZR3c4dXBnNCtYYTFvbzV1?=
 =?utf-8?B?YUY2V1k1Y0hqZFdmZVR6VmVseG1UbWIxUXFzQTk5OUFUMTU0alpNSWZaSmxt?=
 =?utf-8?B?SGNzQmNBZHM0aGpvc2J2a3UzdXoyRzBYVWV0ZXdQcjVocWVkMFQ4WmM1UlRa?=
 =?utf-8?B?Mi96aWdtcTA2QW1Ud29VRFlLd2FNTi9nTzJxenRJYXBOZ1ZKZXQvL2NUOFIr?=
 =?utf-8?B?dCtBclUrcGF3THJzSmovekpQOEVNZkNHYUdBeUpZQVJWMitQOUV3NmNrQndu?=
 =?utf-8?B?ejBaZ3ZaN3hyQXdQakIvakJTZmtGUmlWV2c4bWRyT09QTTJNalo5TXlGV3Nk?=
 =?utf-8?B?S1FMcDdvemRENmplU21LaWR0U1NrYXI5MjIzYUIxUUwrblREcmZ2RTNtWnNw?=
 =?utf-8?B?NUpJZmZvTnNHMU9OamZEemlCZFAzMWw4Wm1ZMUZISSs1eTRVQm9xNUZmeDlT?=
 =?utf-8?B?SHhqc000Y21QZG51NDh4Q2p4dE9LaERjRmFSTlRUTWliSDJHemNmQytiVEdt?=
 =?utf-8?B?clFNc1dWK2ljZzE5amxsaXNLQmZpNWVqa0lseG5lc3RORFhnWkhVa21tYTIr?=
 =?utf-8?B?NjJUL05OSUFXbG1XbHppWWdMLzU5MStJc3lQOHZ1YURUbGg3N3ZRRm82TENj?=
 =?utf-8?B?bEJ0eFY2T1A0UzRTRWErZ2t6ZFRUOHlTR2hJUlM1UlZSS2FzU2FFMnFTUWRp?=
 =?utf-8?B?ZElrL1VrTDNDZVVWQW8rRE54bVNnajh1a3ZQUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:29.9366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a22f93-5018-4259-ed88-08ddeefdf752
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8442

From: Ilpo Järvinen <ij@kernel.org>

AccECN byte counter estimation requires delivered bytes
which can be calculated while processing SACK blocks and
cumulative ACK. The delivered bytes will be used to estimate
the byte counters between AccECN option (on ACKs w/o the
option).

Accurate ECN does not depend on SACK to function; however,
the calculation would be more accurate if SACK were there.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp_input.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 636a63383412..8b48a3c00945 100644
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


