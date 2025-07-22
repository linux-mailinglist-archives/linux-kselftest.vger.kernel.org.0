Return-Path: <linux-kselftest+bounces-37821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86626B0D69C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6303ADE0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF222E5408;
	Tue, 22 Jul 2025 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mZVgQ/UH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D482E4277;
	Tue, 22 Jul 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178396; cv=fail; b=qNLHI9cTQjW5UpX/eAJbA3S2/sQ/JQyzT5xL/vl/Fvz2Ytt+foRrhEz6WCY4hx747ZdU6ASlLsjS0ECQsSRZC1oM6/bQcKJPnuBF+XEhgkSksd6brM//mIKpSXpOx9hf5dQNFfOfApEuE/jXdZiKbUfQwFEAGazRqHUFxmf7c98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178396; c=relaxed/simple;
	bh=o+rdQ06vJZN5N/UR/Ot5TSmCFovjFVZA+ZjXOZ0c1Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjFli6Hc1IOdu4f3vO0ZcTV3CXUSWrpf3YoqTu6bCRJPZpdwYgNvz4Me39aRXM6BcUcV/59cC6NdPo3QQpAMixL0VAAq5/Mf6mgxPQvRGy/fVxfUlRfQ86+YN8B+TdxVCEWdyScrEp4IVaL0oAvl7NeLDtSgSHKe3nSshRXmpKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mZVgQ/UH; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoORLWd73PQTwNDHhdV+iiiZLdr7Xx5ewoHla2bSdo5oDVr7DRgFAboKmarpkvg+Zzw8vyou7iIHyu9gy1Bt+VujsIdlbqAOW3xbgZ70RRqgkTbjIBWb1zvXJeyyfF7xSNGpoygR0Ti0p/H8ljEiKhaKKODYCusspC+9npPugAbpvr0mjZUN2MKW9egBoELokhX1oB0rXyg3CmbKa+8fqn5X60UVDKrkbP9a9SajSheXvP1YQx5jF+SRLN9RuTRJWCy8D8vfwwitbwiV657JP76QcjSQZBAeF+q0XkU3heNEOI3nbuvTnhZ0flhnqFeeQvJ5gujM+K2UZsOxk0KQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obl70mufruY95/rVXvyqQhbBu5/U3o+ogd8QuxrfI9U=;
 b=lzY7EDE6eosxCxi5o6tlJHSTHF7+LNjOI5CdoT6gZOkH/D+I35Vq442asCKihRL4KPDI8rKGPwTRh+o6YyqCr1FFycdPHJKt7ba1MyzGyoqe0axAc/NQgr0fjg1Ggfpmo+DiqkHouuhbO/hD0tENw5gxvEwBHR+h50zEwDohiAvBp7kqLmdZnTRIOw+o1QHy9jpUE86jpECNYCHvFSs0g8QLfHrJVrQSsC+cC2bAmK7GsEGei3/j6Hc91kClJpbB3qbD7EAdrK3fRyOG4QwF5fw59HiJ6UBeUg/2U4jjsDlOSOHzKhIgRbUjZy+6CMm9kr7Kk/I56yXh/ne8xj6p9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obl70mufruY95/rVXvyqQhbBu5/U3o+ogd8QuxrfI9U=;
 b=mZVgQ/UHrEHYmd+CwCmummM6U8Cv3M+fsnrn0XDWaSV6+7OYoRA5AMy6JAXv3JodqFQeQCTHz3JBBqs/g/kcDLsnx43hbNPi10VOjE00f5qoaKpawYbK6We0OArE7Af06mzIOBOJ2OxNFBLyBtEff5uY3eWMUnXsgRDHBTYEGGX9fcwyBfF+3k0BsVmUeXHNOl+l1J/CU7uDXwH7v+B9Sj10SYcA6RUGA+y+BUFP8s5pCAhVjN3EclIf1mqaGs0yB7MVqCjxy2B+ztGTAVVrQe4rUuX8aAdqmKUh7cQlM+xCQjLU0msPs7Hg4tgWgDRYRORWDzj6arsXtkBNJmIUxQ==
Received: from PR3P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::28)
 by AM0PR07MB6355.eurprd07.prod.outlook.com (2603:10a6:20b:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 09:59:50 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:102:54:cafe::5) by PR3P191CA0023.outlook.office365.com
 (2603:10a6:102:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 6F35068004C;
	Tue, 22 Jul 2025 12:59:47 +0300 (EEST)
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
Subject: [PATCH v14 net-next 08/14] tcp: accecn: AccECN needs to know delivered bytes
Date: Tue, 22 Jul 2025 11:59:25 +0200
Message-Id: <20250722095931.24510-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|AM0PR07MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c610f2-d025-47e0-0d62-08ddc9067ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0dQSW9wTGIwRFdZa21ZdEQ3VjlUWU5NQjhSR3Y2anM4Q2FRbHVjZHBMK25y?=
 =?utf-8?B?c1U2dFQvSHFLd3BjQnBTN1hXWUtFQUlHM0owNVYvK3R4NzdzWGRtdjZMWjNl?=
 =?utf-8?B?ZlZYMUFob1JIendrVmp5VG1uZU5aL3E5bDBUNFJrUHdIa0pwbklrdjIwQ2ov?=
 =?utf-8?B?NFhYV292M0ZyZ0ZCeTdYa09TN3JYVHNFWTdrMVBOUzJxV1Z1S3pwdzhibUMr?=
 =?utf-8?B?SzFRUnp2c1ljUitFQnNCSkdXK0k0bnJWSjJOMzVLMkIyQlNVdzJrb1dGZElN?=
 =?utf-8?B?aWtuWFVnSVgxV1pXMVhBakVzRHpneWFXbzdZWHBob3Q5cFpkZVdKbWdGTmp1?=
 =?utf-8?B?NDBQVjNKaVpnVmExVHVFUGdIazZzSHJyVG5DQmQ4Ry9FWm1zbDFXVmZhMWZS?=
 =?utf-8?B?SDBtV3RBeHErd0xxN29VZkhLbXRaanhOVW0yUnNsZ1FCZGsxSU9xSzU5VWFE?=
 =?utf-8?B?MGNCZ0ZEa1V1T2FSVjVtMlQ4Mnh5eGNsNDJrVE9JWmw4bEYrVFJtcVkrTjY0?=
 =?utf-8?B?VE1neUljOGF6c1k1emt0RmdmeUV0Y1lvWEI5bWFYZllJOXgwZlJIVEhnWGhN?=
 =?utf-8?B?N1dCMFQ1RmxyYTkzcFhsdnRnMytIK3pjdm9ReE9iYVFleG1GQnZvQlRDU08x?=
 =?utf-8?B?UnZBWU9JbXFscC9jSklzaGs1TWMzM1JrclpGOXlDSU41YUZKM2RHcm5yODd6?=
 =?utf-8?B?U0pUMmxjTjUwUE1EODBBVjNzUmhzSlhpblJoMDBMZmZMbVU5ZVdjZG9jaHRW?=
 =?utf-8?B?V3dOalJqSk0yZjNxa01lZGxmczBIK21RaURnLzYvOG9adTl5blhaeDZmUEUv?=
 =?utf-8?B?UUdNZDEvYVd2TERYV0dNM0xFTTA0bTJLYWg4b0tZV2w0Q05oOWd5Vi84UENU?=
 =?utf-8?B?aW9OWmdRUks3c3U5SmNwcHE0akZ5WUszY3d4TFlTb09GN294VFM1Y2dUZWUx?=
 =?utf-8?B?UUhpcDFHRlp1ajlNRlZwN1JHaEhiSTdkMmltVnRFeEpoV0M4ZzRyWXRNbi9V?=
 =?utf-8?B?OFpuaHErZjg5Z05PV2ZaU0d3SlFtZ3VMUHpQekdSNDdBU1JTMWxBZHlkM3c0?=
 =?utf-8?B?K0s4NDEyek9qeis3OXJnRnNwTEVDU2Juc0llQ2VTZXdCa3YxL1EzZmVlUDU0?=
 =?utf-8?B?bllBYjROZnRNYXc5WThOMXNHK3dJT1NJNFZCd1lPbTFqaklkeHNlTFhkVFhH?=
 =?utf-8?B?cDVhWUIyTFZISVB3TEdGNFJqYURKNWNoZW5nYjZVQkJEblZjZWlXOEpZUVBr?=
 =?utf-8?B?MDFhUVB6TXUvQnZYbUxkaUpXRkZIcWVJSDIreThwanRPR2xWNkJjTm9Bbmpy?=
 =?utf-8?B?NW9yR2tJUy9abkxjZ3lFNHBZb1krYURFaDZwdW5ENUJiSmZhU3cxblhqbVRx?=
 =?utf-8?B?UXNVa3ZvRFY1eU5zKzN6NUlJUVk4OE1CY1p4T0xVOVk0dXV1eGhiVW9HeEJk?=
 =?utf-8?B?QSt5ZTZMd3gzSDRTaUIyNG1HNGRPRXhBQUZFSnp1V09Sd0FseDZPOEdrUEd1?=
 =?utf-8?B?b3dtSTE2R0xxcnNoajZzVHYxUkxsbHRubVBuUDFEOTN4MExvSlpIZjhHdk0y?=
 =?utf-8?B?K1Y3azZlK0NFOTRDNC9tczNOYkF4YjZ3MnNIbG93QkxjT3drVnh3eThLV2dR?=
 =?utf-8?B?c2Y2eGVFNFNubTFnM2hqTzVJc1ozaW9RTkc1RUR0T1NEQkc0MmQ1Q09VVFZp?=
 =?utf-8?B?NFlVY0ZXdmFML0lSaUhpS3cyRG9Kc2pVOUQ2MlY1emNPT2U2LzdUU1NjdGNG?=
 =?utf-8?B?a1FvUGF4ejZqcFRoT25NVzk3cG1wMHRVQUo4TzRrQ0YrYTBhK0dQbmY3cytx?=
 =?utf-8?B?T2ZqdDJxZW0vaXVYeE9PM3l5Ung0VkR0ZVpUeEcrTzlsTWZMbmF4ZGJDM1Fn?=
 =?utf-8?B?bktTOS96NGtrVEpSaS90WitWWGl1L1ZyaG5xMHFTT1dCNTZ5UDBJWW95aTNn?=
 =?utf-8?B?eHloZHh3ZlE2MGx2aVJtSGNBTXNDWkRoSXRTeXpCeXdGb0RzRDVwdGxodEpu?=
 =?utf-8?B?WWVFWXh0U3FWQVlDTHg5Zk42Z3dHNmVINkN2dHgrQWJpY296RlY2NzQzbjZG?=
 =?utf-8?B?SlV6MGt5YW95elllS2NZS2ZmaGNERDRvNzl1Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:48.9273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c610f2-d025-47e0-0d62-08ddc9067ebf
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6355

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


