Return-Path: <linux-kselftest+bounces-41234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD0B52F59
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366FC1739EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1D314B96;
	Thu, 11 Sep 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="C/fGXFjq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230C314A9E;
	Thu, 11 Sep 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588826; cv=fail; b=bBiYy6No/hnlMgDEw6Quz4Aglo/7QEusXDRSgv5/GB0OXETVJrTSDg8s+Xt7rK59ePM5PmkWrjkh1NlQ6sjxad7q9bFory2hMbPTpJ1UF2Z9tc3zWt39p2y7Wg+8qLoMAbp7Zt62k94X017ufGIFgC+aNVLGV7JwpyXaWNHnzKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588826; c=relaxed/simple;
	bh=/V5Tsht2NDxkT5nX8xNrWaEEwIkpwc8MocPQ3W4gmkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imTTJD2a9nbT5Yv6pq3ii6IcnubLccs5sSdKY2jYRbMW/46NSr/jOdtb3IIBNK/nCrqkmfq7C2dYYdGjPxy1JlAnjXOMcoxFClkJs4/SNd8gx1pTKKmmb22h9OrHsBod5jHyHGw1e4IH6NtLvI+wBanpkLcVhmlBMH5bwnFHDI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=C/fGXFjq; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jylotFa1FgqBR1LabT3akLn/0HENA+FnO8nTQS1WCFeCzXuwTdzUlzvpUgQDGZgWHcO06J22x7LBXYiyukoLu8PMKZ1HzpYyBqrfnA3EvQ9mKA5PQsv42nIqpiM86kI13VfETJhqiFjgzpGBltE2j0YQusxHbso3oLfegFZGy2XZyMRkx25hbI49q0JGDEULqm/z1+sy3rKXRouj69HhAUebDdKtd22ZkvvO8vOOOEy42JSW2QodWVXivQRer+jibC5ADwWOoYoJLUzjTTF5vbV+QtGNwlFt+y8Y7S+cMICZ+gjkMxjEQzYx0RJhoEAGd43QRlGTgsZGh+oEy4zfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/yFbL74OQ/XK/3sptxkfjUCa27CcWJ0rFxpfari+wM=;
 b=BQH/qW7MtIfiGm6B0p53tTObRvgdTOtMYZ5RQ1UoM0O5o87Wa+s4Cg4Pnv2iMw8fT0FtAoagy0ZJC1uoqPqjE729tsCQUgnFRevARrl0avKnOz23qWXP81qlS+yJ8q1abEmPTYOKxHW4hd3zlevFjAD5htWkBiIfVd9nskXmA4X6rwsqmEvSomzvipf93DIKSq3L9hXU/rRKPE8C+QWy850xdK7H0B/2pH9oXSf/zG5R3QxOcVCEQjHfAib9w0ni1Wuc6kVTOwzPOEH4Is//oZEcjcFOteTzoL9FJDgAxWGlh63ROKg6tY4uHJAkt3Ts/XbOExOUUtK+M4/hyBuYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/yFbL74OQ/XK/3sptxkfjUCa27CcWJ0rFxpfari+wM=;
 b=C/fGXFjqY8LV8UDcM7/zYY3lbmZDF57KG/7hpq6+Ci3VZwU529eRD6D5SMU61NtGbPghzIr3tDeKudWC2tFE/oSNuXUEsax3B+3/SuFsWXWJWZNQUxjZQWWFPrD46/K6/S29/H0FGg6AKYo9I7nGmEUEYfH9m7N6sSaKRvSp6rewtzTTZmQiH7walBvQ2ed4Be0osu6PNBGr/UW9Ty0zTrNojJ2NFJS7Y8oreKwgnJmhTd4Vu4/KaaNfOUu3r48iTnO/XgiXlmuReipR+qJ1GTDUayocNayfB6sTKacbXBLByjiwkRorHkrDjZAvzO3DwXD9z3rVuHQGoqDQ+hCvVQ==
Received: from PA7P264CA0433.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37d::17)
 by AM9PR07MB7236.eurprd07.prod.outlook.com (2603:10a6:20b:2c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:07:00 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:37d:cafe::90) by PA7P264CA0433.outlook.office365.com
 (2603:10a6:102:37d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 11:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.0 via
 Frontend Transport; Thu, 11 Sep 2025 11:07:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 4C7B320106;
	Thu, 11 Sep 2025 14:06:59 +0300 (EEST)
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
Subject: [PATCH v18 net-next 08/14] tcp: accecn: AccECN needs to know delivered bytes
Date: Thu, 11 Sep 2025 13:06:36 +0200
Message-Id: <20250911110642.87529-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|AM9PR07MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 3846e08c-59f7-42c7-d910-08ddf12354f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU1KY1VEVnpjQjBWcUVPR1RvekRsM0djQUlaVW9kekxVRFJva1NoOTI4Y3My?=
 =?utf-8?B?V24zYnJVK0tXT2JIMkVlV0xncEY3MngxRmhUR2grdjlNeGltU1FqdTZrMEdD?=
 =?utf-8?B?bnJrWWZWMHZ6RGloK0U0MSt6dzZWSXpOWC9Da1RFM1JVOFNrNmxsdmh3Q3dB?=
 =?utf-8?B?Q1B5ekFsOWs5NHBzZUVvQzB0R2JFc2hFZ3NtaEY1YVhaNEc4NW9LeExrVG44?=
 =?utf-8?B?V3RkZXUzSXduYzZWeUl1dUtGR21rT0wyQ2xMd3RESDZoYzI0cGV4UVhlOFFW?=
 =?utf-8?B?NE1sa0RjZmJMdllPT2Nlc284RGgxVGFsSGx2bkhBSGYyb2lKU2hYSjRCcFc1?=
 =?utf-8?B?RW4zbXYrZVFnWEdtVWVoL0E0RkUwRGZMV0RZZTI0eG9RcWxKcjRqUGdKQXlx?=
 =?utf-8?B?dkJRM1VZdkFrSDIvN1EzTWxlV3NKcXhnY1NJOXN1am1ka3hMT2RianlNdUFh?=
 =?utf-8?B?aWg4dmJ0R2l0M2c5UTJldjZWaXJxcTJmNjR5L0hhWU56dGFFR2JtVzNXbE5k?=
 =?utf-8?B?eHlSRGxwU0Z3UEhBc04vcStrWEFObUp4d3hJTDVJZDhaZm5Kd2Z5cGl0am01?=
 =?utf-8?B?d0tMcjVCMGdwMXJ5M2JVaUNvM09Mc2FzcTN1YVhaTmEzKy8vVVhpdkxvMSt0?=
 =?utf-8?B?REx0ZktnNEV2Z2FXTnhadk1SV1JwUnRiNU9GV2F1djhaZHdPcklOWGxwdWpJ?=
 =?utf-8?B?ZFJKSUhTRkp0T0JxTk1nQXlNRUJweUxzNGg5SkxXaytVV3N3cDRPWlVub2tl?=
 =?utf-8?B?Nk9jbXhWUUFPeVhSUmdMeFVxa3QzUWVjNVc3cGxTRGoyOG5rOGlhQ24yTWdt?=
 =?utf-8?B?cEJGT05IUkdFZnRNT2NDSVNuVm5xRVFRT1AzMndrbisxSUdBdE4yMU5xdzRs?=
 =?utf-8?B?dWlRWk1YRmliMFNmMmZiVWJkN2MyUVB3THRyVGplMVM3ek1sL2ZGaDJUckhU?=
 =?utf-8?B?M3ZFSWtvV3BydkIwMzFYWG1QckZBMHZYZlZRZHQvV1YyamlUbURlWjlxK2s1?=
 =?utf-8?B?UE9INjNhN1hsRmVYeUp1RVlrMzBwTzRScTV4WFdrQTQvZVpKb1dsYmJpMTlW?=
 =?utf-8?B?ek1NSDdOQTJONm1kYkwzMGJMdEZlWGdjV1huOFBwSTBKM0xCVVNJZmpGNklh?=
 =?utf-8?B?TWpQTVlMK1A0ck1WUkVYUGhTRXQ3ZGJ2bE5JQVFQVlZLSWp4SGNwdVhvWFU3?=
 =?utf-8?B?TFBZWG1GNDB3UFJoUW40dUNpNlVZUHBvQkp4a2twSDdnUmtCRVpWSmpqSlNh?=
 =?utf-8?B?VkdjV0NvdmhaVkVmRnBHMGFEV0tLSVNvQk56ODYrcEdsSThWd3FwSndzTlZm?=
 =?utf-8?B?cVhqWGJTcnFvUmdSR3VXSGhwei9vZG5Hd1FObk9vakUrcU9ZWHRaam5ubWtm?=
 =?utf-8?B?aC9tM3pFeEpzck9FNURxVVllS1N2N3F4eVdHRmttazE1MWVtL0NOSForRU1N?=
 =?utf-8?B?UEFpeHdMRzY0M1ZndW5NcWU1cmlFVlhqcG9RU0NnVFdjSk1ySmV4ODYwMTU5?=
 =?utf-8?B?ZnJqS3o4b2lhWFhpOFJVQkxocGM1NW43dmZLRXdESFVwSzlOb0RpNWJyOWJS?=
 =?utf-8?B?VjN6TndyVDZFbnAzbFlPVmV3N0ZmeVpLa3VmRW56VDhvbXJrQ2RzeTZwY1lt?=
 =?utf-8?B?ZnIvMk5GQVJoTm9PSnplYUxUS25RTnMvQ0t0djM1ZjF1bWk0ZVhsT3ZQZ3dy?=
 =?utf-8?B?QnpoZEg4SnI1SzMrQ1p1MEZhRTJXV1VPbDZtR29mNDJwdWFEUTlTQjlGMHBR?=
 =?utf-8?B?U1oySjNsNU11SWU5dGxwcTVMNDEyeXJsYkxreVh6YUZqak5aMkFxeW9hQjk1?=
 =?utf-8?B?RVdtNUc2M0o1UFJGcjlLMVI3bTNURVg1L1hiMU5sMzNESXRjcEd4Z0VodU5v?=
 =?utf-8?B?cmVPNW5jeDZDUmRDZW84SHB1ZHVBNFJtb3RIR3hvNGFVaGpPNzYrUnE2Qnlw?=
 =?utf-8?B?d1JMMklKdHhkZkhXNTBuVWs4Ympxek5MNG5sdnVScldzSkVtb3lXT0JjZVhW?=
 =?utf-8?B?OHFHYzMvTmN1ZTlNSEkrb2tidWxqVWFlNXBZSUk1cHIvUzl2Mm54ZWNXR2d4?=
 =?utf-8?B?OW9GcElsTkNRMWRFKzhtOCtiSEZuWml1bXN3QT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:07:00.7426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3846e08c-59f7-42c7-d910-08ddf12354f6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7236

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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


