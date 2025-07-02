Return-Path: <linux-kselftest+bounces-36265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5EFAF09FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA9D7A854A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B949202C2B;
	Wed,  2 Jul 2025 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UOkcEKvA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012034.outbound.protection.outlook.com [52.101.71.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECA1E6DC5;
	Wed,  2 Jul 2025 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431066; cv=fail; b=nqeykG98AFhDi/1ZQBpFM0yteTQ7BeNHYfRWJp6Z18DRBhlt+eJ1tY73MkRB3Omp8h+eLmu/cvOAofVBNqCcWpndoDvv4Lk9YdiubrmVY3VdorQoe2fQ9qq6Lazpwd0mFSsq0a0NFYcg8Sq54pQPm33ij/Px6erCtDYD7WOYUS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431066; c=relaxed/simple;
	bh=Mdybeq9G3B7GP0/beCF/g8cOd609L0fOuIyY9L1kj0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBjkDl0mF2hlIl3LccACmN1pVzlKd4EM/RE4e0VWLkPM1Yle/OJgogE8VFVzTouz4+RP9BnAFeTxa2ki5DSlKL98/YnMbItHYHIDq8ck8cQ2MIy4KmaR9FKokYRpnwfXorjAjxVlAGfLODDlSQLv7QoYMIIVajVdqOXUBuuT2wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UOkcEKvA; arc=fail smtp.client-ip=52.101.71.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skL1afo8fxEOBaFYoOUWW5SuaFjqX216qYbxt/wKWQ2L6bDN+/RzqVRQrE6YF6BCklMsgeX0xZLNjZspfsTttpTW2TwDUAtKhL44VPMYew9eD8astOGCT5/8OVC6E64iNKPeTzqpAt5CBJIJR2AxbRriaRHuD4H1U6vH80ds1Iq3VUiRKVEmOUXgKjjpprzm6H6ccIgwiOlJalhQ2irBeOUhBOEJBoTLeYKBWGMP6dWmA/Ku2th58IhaB1XLmAhgitdLWJ+HnclIY2zYeLpu1SzGSDGy/wnf5Cj54Jo40uwvgPp7dvi6DEGKHpDyUPjYt8g2/m8C5BEQ9gT8GClfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM0xWJCdgOMLIxC5MdTge+tEJZ9kxNrnSEOTj6/s8Fw=;
 b=v03iAqBnOdJCLUSJgtiiEY/zDCkYNrazXy8aJJHiJhnzIP2hsRWgvEQ0f+sw3dy5lb2kMnloSqJuVynfzYvH7Xh7Z/MkItJL9+WfRMXYhVkEw5gVkYMIMWFsIqTZHwMdDcySD5F/QdKiRGfodamlGeNrrLMrH4BpbzpaMKR0EpEx9HaaAZdJnz7UfBpXtlNmSuuTzDUFlbJhrvHlA1sKZ7StVKHW0njsboBgDnyDgcPG+3SuPeu2fCXKIHA2LPf1hCSXAj13o2bpeu68SB3dBL9VcOKqOJitZRNNqNgmGXZoE2MsYUBw+sF1dteEz+a37VFeL/VhXEerTDJtcDFONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM0xWJCdgOMLIxC5MdTge+tEJZ9kxNrnSEOTj6/s8Fw=;
 b=UOkcEKvA3z2+o4AAoUTpy+B+b8Podv6ntsSMyBYRDxq6J26A7GdMcs7mcjtfZ4lC3ZKG1eWgA0tWrzZp8pQaBVzYM39usG6kHUF/F+6M08B8N9awhHV8lV8tC3WXd4B2ISa7Ah7k2QJ2b1s9uMMZ4LlmRifr2uCwktUmjcb3v9TzvvTiVfzAwuSGznVsGyDAFWAqKh0VshuK1FCupC9h9olj2CVe5jnaBD3yMsjyp+GC7JrWoyhrNLBViyQ98OMrf8wiPGniPxLPdkjpmKt5Rbt6AjXVs3R8przmArg5Sfgxqbe+yQTgfTff2hcAJdwjiMHRWqjzAH8pLEtIqe8/Ow==
Received: from DU2PR04CA0012.eurprd04.prod.outlook.com (2603:10a6:10:3b::17)
 by AS8PR07MB7607.eurprd07.prod.outlook.com (2603:10a6:20b:2ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 04:37:39 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::21) by DU2PR04CA0012.outlook.office365.com
 (2603:10a6:10:3b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Wed, 2 Jul 2025 04:37:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0240E1C003D;
	Wed,  2 Jul 2025 07:37:37 +0300 (EEST)
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
Subject: [PATCH v10 net-next 09/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Wed,  2 Jul 2025 06:37:13 +0200
Message-Id: <20250702043719.15130-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|AS8PR07MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5507bc-33e0-4b86-6545-08ddb9222d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitwUEMrbUxoNE0xL2t4d3hGM3BDbWN0Z2x0YnBJVlpwSTVJQkZmZStxUkMr?=
 =?utf-8?B?dWVLZjZSakFlVy9uN3JseUpQMmNYV3FnNjd3Zy9WZnBaRW5uOEtWVCtqaGVa?=
 =?utf-8?B?LzBJUm14VHRKS1hkMUdZNVJwenNMdHZiYy9HQnI0a3VaMUFNTHpNblpLM2xx?=
 =?utf-8?B?Y1lqenoyUXZ5K1RMZ2FMd0FZeTRQYTNkM2Z3d3ovSWFHd1Q0M015OW5Cai9X?=
 =?utf-8?B?aUZoNmVvbW56dHZjNmJtWHhXQTBaV2c2QTRRSDhCQnRpZ3BQZmJGdFNrWUQ3?=
 =?utf-8?B?UWt1aWhUQm9ORlRwRWVCWEtaTDRTY29wbmdYK3ZHMkRrYWh1TTBYVEQ2SDNs?=
 =?utf-8?B?eFNwejhMaGFuWUxwWm5leEFNTTJEU3VXdEp3OVdhYjBDbnp0THoxcVhZaE52?=
 =?utf-8?B?Qk5lK0lWSGwweTVod3J4RXZUVnQ5QUxRaHdQbW1nRGQ1SWo1bDRSc3NCS0Q3?=
 =?utf-8?B?dTVvT3Q5Zms2VWZUODgzbU5DQmI3SHpvNFd6Y0V0eTdueUJpeFFLaVpDcVFQ?=
 =?utf-8?B?VG9UYlIzYm1DRWpNUTUrL0V3dENSaVdqUUNhWWZzUjhZd2o5SW5TTTZtaXdm?=
 =?utf-8?B?WUlCK3JQQ0I2ZU8rYnp0aXRkdlJyUmU5T0dTRTlrM045c1QrVTNqU2xsbGZa?=
 =?utf-8?B?NFZIbWtCWE5jQTlva253WGpBR1VNM3QycWZvRzNWeklnZXJvTlJ6c3BqM3NI?=
 =?utf-8?B?NXl5YVhISDBvVFpveWY3cnd1UGF5bHowRmlBZENrcFRFOTNzbDMrSnRCbkds?=
 =?utf-8?B?VlhtbU4rRm8yM0ZrcllCY0I4Z2lhWTh4NjR3dDEwU0docmkzcUkvdituOGVI?=
 =?utf-8?B?RWl2b1hwaFJVQUJTT2oxWnE4WVhheDFBTHY3dkludG5VYnVPYzdTUk55YXRx?=
 =?utf-8?B?YnA2NG1UZnRMNHBuN1oyNUovdVgzS2ZlUkpWWmJjVjZIQnYzOXAwQklzRGtK?=
 =?utf-8?B?QTJ5S1VjU1ZyK1dnNFlmd2l1N1djL3RTRnlxTHRPMU5GT0lFYWhnQ1o5R1Fr?=
 =?utf-8?B?TWM3ajF4S3MycExVSk9GOHk3akVBYnFEYTE0TGFRdjlZRVE4L0taZllMOVJK?=
 =?utf-8?B?TldqWFhLbjdpMkd1RW5CYnlxOTllTWtuc0JCU1FtZm5KODVvL2MyUXJzajBp?=
 =?utf-8?B?aXlsVTA5Nlpoa2lCUWpmTWhEdjI3dU5CTkorSWNWOG84WGpnUzlLVEI0anFy?=
 =?utf-8?B?ZWNVNFFwWmo5M1I5S1h3a3JaTnhUNEdVQmF3TVkycG1Zbk1EL1AvSzM5clRD?=
 =?utf-8?B?YTFnOEl0TFRpOWM1NXVFOUxtTzVaTzI2T2RMYXpRcHVGRTdxREhuYjJxT05j?=
 =?utf-8?B?dkc3d0owVHJOMVhnWDZvZWJqUUt6bzVkbzVSQ2kwZ1ZWbnRmZ1BXZ1FPdnBZ?=
 =?utf-8?B?REFEZjJGMVRRTUJNOXNSZ1hlWVZuU2lobzJWWVFoaUZ3ZmNnVHh4MkJCMG1o?=
 =?utf-8?B?YnpkTWlvVjZHdWs0bTE4WVg4ZUhRdGx6K0NUdU5EY0R1bTBXbmR6MEFoZmxU?=
 =?utf-8?B?My9zUWozdjRlR29hRU96ZzRSUHNkS1hYYXRRemV1UXJVQWIzZDAvZ1Jxcm5L?=
 =?utf-8?B?YVMzUWR3azB1M1dMc0JTWk85ZW0rSGw4UnJFckdKdG4xbmZoYnQrUi8vRlRK?=
 =?utf-8?B?bGlRSWRXeS9zaTlqVG41VWdlUTdFbmNUTGtweXNUM0xwQlZRTWVyMUZxdmkx?=
 =?utf-8?B?QjdIV0RJYk5VTmlRMmJ3SExTeWdmcEFSRURxK2pDMFRWN1hoVk1qS0xNbTEr?=
 =?utf-8?B?K21JaTdsSmowWkFnd3c1SFVoTFRCZjN1RjMzYkJDcHJrNkJhSjljMko2ZWlP?=
 =?utf-8?B?eUUvMWdUeEFWRHFWelRZcXdXclh4SVE0NG13WkxjYnp4VXhpNTR4WHR4YVZ6?=
 =?utf-8?B?Tmc3SmJpZEpzVytROXlCcmcwU2Q1blVlS1JQTzVIM1M0UnFvelVnRVl5b0Ev?=
 =?utf-8?B?a0oyUFB4RjI2dVR1MC9hTUhZYUlEcit2NUZTdUl4clNLRjJXdnRSSFBueDkx?=
 =?utf-8?B?LzNlekpXcjBycVlINVp0bGJPMDBOa05DVWx4SHBLeGJwa1B6NjI1Y1N1Yksx?=
 =?utf-8?B?TkZrWmVKRXFZejlEZUZGVm1qSHEyWjViRWE4Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:39.6675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5507bc-33e0-4b86-6545-08ddb9222d5b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7607

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
index eea790295e54..f7d7649612a2 100644
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


