Return-Path: <linux-kselftest+bounces-40886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB5B4745E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A853B5EAD
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E212F619B;
	Sat,  6 Sep 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fIgYuqBW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04B2F28E0;
	Sat,  6 Sep 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176156; cv=fail; b=tO9hKurqVd5zG5mr76JrNzWs/DOzyWn+HQQyNfs0IflcWu45/s1uMtDcGqBYUKHevC3FJ00hospgjQLejFccx4GbCe4ltwvOLp2DdhWvBtkIUhupua0B6ebc+FCU4XjS6GorLXsQngKyS5lhcc3merMb/Inu8Mi775Vt6I+Aenw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176156; c=relaxed/simple;
	bh=aRcFNCJ2YlLqD8dPTUHRzyqeZ6j/Y/EXU5atMBKd/Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoFwZ3X8Jv78mbPDEhNaWe721pNY72z8bRprKZUB6zKVGtbFgpKraaDdGfmAN9FW2rtkkw+WFXaPz9KgGeBsiWhq2xwh576QZ7L+A4JAuTLsm062qkL5SSIRoE+dSxjgZbX6u/kaZHHfQUZq6fTD0qonItkI4qcYgAb2i9J++3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fIgYuqBW; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvYzWBfMZDh61XjNUxGWmgTm7A15jhty7e1BW+/8YdrgIMPUUyL/KJNCacxHzZjedhgdr4ZqJ6acq96LinjxB/STKeLx9xeVwoipfYrCkjOxQ//ooqj25WUmWk/JznWg/bPD/DdtZHHMbCOOtngRTNSPa8+UgAozgj66eqTfQmS9wdp+jQUlPMfJvaGsMWQv03utUjRwtX0sJqQ4ZH3pi8l0sbfv3VYieRg/wK4yFGNMc/wYEvmn1Z9weV45GMzNTqtv2OSmGojiHfGQ85yeY9YEhlhy8VKOphUMuEDD9wqJQM0GQuiJB83iXPSrU42OcxCWBvV3WAw08s7jS+xkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQIbGIYFjk4GSW/ZVrAgS6HFTyA69abrskTQq/ygng8=;
 b=gMbw5wvHRTC4okfTEkLJb19ouKkfm+0H5Z0ie3+lorfQd6yN1mFNjWzagGwPJYChk5rqGO4hvfMmGKRqO3w6ksvybf2tTnwxFE3o/xEo8eqoG4hwa3biGC9SFYAnBWNy5Im9wjmTm7cy8GgiqwlcjK0mwwghrzRVFwkUWghsZy6ne00LlmC4SYQb/9gJTuRrg/nhXgnUM7TGRlJnAzyYIYChK/2g8iKdcByWHQJ81klXULThFY2XsBmd35pHkF/aelu9BdDmZWbkxhnHP3F9iFRV053qKgrPPWzJLbh7uVCi5Xc3THetoK68aLHo5iEDdOiyTYcrn1Sg/qwZ2HWFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQIbGIYFjk4GSW/ZVrAgS6HFTyA69abrskTQq/ygng8=;
 b=fIgYuqBWQr9R/pv46RhBgA4OBW9dAXo/kmbMe5OlQ62kR2yt4pnXzUau5ask+k9kpXVdpZXH7VkRrSZX5Cbni7oBlPOaUV7pUS0x1Hc7Njy+FiJ2YbBz1dKRVOUhfnDJ+NZ4dGkKHpChAVO8Pu6oGVk+7TBIPI7+nN5aPmmbtwjm1MhdZFhE3n3I+O3bP2az1UfzGZdSx7NyKiGoVXKDGwXBL2YD8mKVHA6qa820Q3o2ZQGcur1z1JZOmE8pE1iS7+BlS+K+L/OkKpdWJN793jqlo2FlLoBjbtyLe2ya4ZyTf0Wa5Ts21dgpk2lRRivDB0Ej4Ldx4fSzaBt4fsLPrg==
Received: from DUZPR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::14) by DU4PR07MB10537.eurprd07.prod.outlook.com
 (2603:10a6:10:5d3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Sat, 6 Sep
 2025 16:29:09 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::82) by DUZPR01CA0139.outlook.office365.com
 (2603:10a6:10:4bd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sat,
 6 Sep 2025 16:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14 via
 Frontend Transport; Sat, 6 Sep 2025 16:29:09 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 9AF001C0037;
	Sat,  6 Sep 2025 19:29:07 +0300 (EEST)
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
Subject: [PATCH v16 net-next 08/14] tcp: accecn: AccECN needs to know delivered bytes
Date: Sat,  6 Sep 2025 18:28:44 +0200
Message-Id: <20250906162850.73598-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|DU4PR07MB10537:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b70cd2d-76fb-4ddf-f76a-08dded62818f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1RJYyswT1p6SjIxcVNpcjk5Q3lFKzkwK0txWDZvdkpBUUYvWWJRelhtTzlH?=
 =?utf-8?B?WW5BeGdwV3ZlbStVS2F5SGF3YWNwb0NzY29ZemlvU3ZERmZJYXNKS3M5RHJX?=
 =?utf-8?B?d1lRak8vMmdTRm15aHRRZW9BY3ZmazE4TTg0WVA5SW95UHM1Y2FCMzc3UDFT?=
 =?utf-8?B?S2UybHplakdDaUptMEU3Q3h0R3BSZ21rbUd1V3IxMERsZWh4RkdKRHhteE9q?=
 =?utf-8?B?VFZOZ3IvdW9NbEg4SjJQbWJpVk4yc1pHd25GMWt4NHh0T2dyVWdFMmlhRXgw?=
 =?utf-8?B?ZFpzaFo3MGg5azU4ZzBaL2lwVVFWYzRjY1F3WlFWSC93dnJ2Z1hPSDRRbXhi?=
 =?utf-8?B?dkh5a3lzc1plamdDVEt1L2Q2R1lsY2cwcnhkQVRFQW9uMzEvbkhDSXh5QnZs?=
 =?utf-8?B?Q1JDVlVSRTRYazVjWmUrSEp6WHhCdmtKRTZaZGtFV292YUNpblF2RmduVnB5?=
 =?utf-8?B?OVlMbEtDZUhkWkQ5Rm5EcW5Mc2FMT2MrY09YdlVsbG92cFJKSmVESTNuRGFT?=
 =?utf-8?B?RTlQbjFzVHhvMWhhTzI2RkJWU2ZoMHNrOFRLbU5peEJSWTYydG5lKytIR2dq?=
 =?utf-8?B?cFRRTENEQTl1YkVPUHNnaUVkZlB6S2ZFK043czRLLytzV1JMT1M1S3d2aUk5?=
 =?utf-8?B?WWZVT2FkYVozOThvTlFyVW1uSGNwZVhOQ3kwYW1kQzdzWnhjVHZKV2xJRHVI?=
 =?utf-8?B?RTBmQWdNQ0V2Tkl5eUZtd3JzdUVkZ1pDZWl6eWFNYm1ZT0tJdWZTWSs3MDk3?=
 =?utf-8?B?cVNwSUNIdVpEbHNRQ1Y3ZFZqRjlYYlJOQ0VNMGNTZXR4OHlpcFBVRkFmS0t2?=
 =?utf-8?B?TE9GVzBGbmpyQklOb1pkZG5HRTNyQkxOUlc5QUcvSWRqY2JKRGNsNGlGY3NK?=
 =?utf-8?B?SU95eTFkZnNwUnIycXppeG4vWlpQMmJhWktaK1gwU1c0TzNsUkx2RVV4bnBF?=
 =?utf-8?B?VjVpODFLakdoVFhBOFlxVXZuc1ZjVmg4bkdrd25xKzdqSWV4bTF5cDlrbHZO?=
 =?utf-8?B?d2pZejR2bUJuQ3FIZTdLOWNCbGI1RWdWZ2Z4TWNlZ3pqV0ROMENweVBhZWdy?=
 =?utf-8?B?QlliSHcwSER2S2FtbWU3ZmtoT0txYmMvNjN6b3VsNkZoUkIzd2EwZFFGQXNK?=
 =?utf-8?B?NjIxNWNXNVBJVEIveVdUK2FkMUpWQzNhcTV0YnY3TXN6ZzFTdHpWUSs1YW1P?=
 =?utf-8?B?dkVGVlpma25FaTA1cElSNkFtQld1WGxmQ1JYWHJLem03N3lIOEJLQXA3QkpL?=
 =?utf-8?B?MFA1K2JUR09BMlI5R2xwNzFrcG5VQldoZ0laSWt1aU93dTJoZDRxVHg4aWpY?=
 =?utf-8?B?di9adTY1YUNiRnZPL3dnc21ieGRmZ1QwNjRZa0xvVlY4dnpqTlRBV2dJeGhs?=
 =?utf-8?B?cVA3YWVGczZpdUR4RXRicktIUEYrMkpvTFltOEMrWldNVUlwdk9uT2VMRlhK?=
 =?utf-8?B?NDFzSVc5RVcwMW9YMU1mNU5mcGlwM0ZYM2d1TlVVaVlUd2VZUE1rekRBalc2?=
 =?utf-8?B?V1p4cm1Pbm9ydDRwYzd3Vk14d1JkME1kNVZaQWcxbmpDNE04U2p6eDl6aFps?=
 =?utf-8?B?aTB5UzhwNkppdHpWYzBsY3gwSzJ2b2VZNzkxTnBNNkwyOHc1T01PWjJEZ21U?=
 =?utf-8?B?UWhvY0FIclJvZURnWlhPWEpBY1lGK0FiQ1JVanFwMi80b2M1ZmJZNVY4TXlZ?=
 =?utf-8?B?c2RKY3lOcndwbllUNTYzVGdheTl2ckxmNDJNU2MwUHprRWtjYk9LcGhiU0NN?=
 =?utf-8?B?WVRJbjFIa005cjBERGh0dU5PREkvTnlPVnF1bUlTdHhrSXRQeGR0aFF5UXdC?=
 =?utf-8?B?MkM3b09XRXNTalIrSGQxbUFzK25IN2lKSURiSlRpNUIyWjR1b3pLREJxbnV3?=
 =?utf-8?B?YmdIU2RrNUxER2xLWFFPaEx3K0hlWVVISlVjMEJxc2hhZERhSGJHTmJCUERE?=
 =?utf-8?B?WGh3RERpekJsQnRreW4rWmNiTjEwWTVIWmQyeHdZeHBSNVVRYWVsM2dhc09q?=
 =?utf-8?B?MUxORitpVGhpTkxPNUV0YkNrbXZES0lwMkRaNmNjbDY2TVY2b1Uwc1Y0d3NJ?=
 =?utf-8?B?Y1orK2JacWZyK0ZhWGRpTTJSUWt5ZE5OZmF0QT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:29:09.1962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b70cd2d-76fb-4ddf-f76a-08dded62818f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10537

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


