Return-Path: <linux-kselftest+bounces-39077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF8B27B70
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC487A21EF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E22D46BC;
	Fri, 15 Aug 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="p1veeL1R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A42D1907;
	Fri, 15 Aug 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247202; cv=fail; b=lEGEmo5Nd4iG3CGGgcXJDIy28SA18aE9/5hobWwqYi9yd4Rm3H2uiIUiVvzVIDHyWFm82EKeUjd93B6VshzBw90SRFyC3sWc0l1xUEFTN6bzDxfCNEU8OSd3DttLucVkhe4f85uA9eP5hRJOMMnwVj4RFCcxjzZmBo05XTsLX34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247202; c=relaxed/simple;
	bh=JWhxjAWhCnRDl6bxgbLAMQsSV1Y5fLXPUXl1nwBmKsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH6jqXiGjXJgu5i5mQKSTLGByGnK5g1RcavPy8qieS2T+Z9XYWuhOhnEfl0nmdfL9bERDDtgeSx/xCYOGntS6Wj2qzo3zx6nmLYJLwSscAGen+rdCm5b3qzqIHRWAAVNo8vDVcRv81JtyAL6yYYpY8J8emU79AeSEFeg5dSMArY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=p1veeL1R; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8NbceAA7KBMZCsyBR5VTFKbTgQC+4ezL99JWA+y+Rwt8S9MH5LjgNn1tBtOtxug4xwZgajJLL7fpOaaoV8ki6fFEECUY6X29L1BclwAIud6g9LBgbe8RC+qdOksuD3SjIA3ixuUiaB+CTR/gOtAbjueOFpsxIy3xEOmJf3q4kpQ41w89mdRjMEn8sxG3+ggiXeS+ihikCLncHsqXJ4v4XiRpULS+HLq6ZHbbIFBAmXTLM/D2tlstWLIcjGosMN8QCIiaigqazavAiuyjrPb2FYhkTue34gh+MVukKh3KmPhYyomMNIrE5MQCAbKgi7/tnHsQlKRoIleXIrP0IaeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V7t3Eao0J+GyW9ZbSFnWZ0mRBErR1sFv7MgmeScJPc=;
 b=HuhX+DWuGeJnBBQy0vp6AqD5nMN6qtSHQNWo1xfc2LF92rrkjkPVTPpDrqtJdHHAKAVGBzx3st/QEvWHT56D5by05bx6nm0a7T2W2b46SSQMTAp3PN59RAmFz3lJxFhWhdC8AD+6Z9CQZaezjjxVTia4ihS5VsStcENYxNS1KYV5Ja0ixbstUpN2u1IQx/Kv9tIoJluHx06YZnYb43DSbbvpo3nCh80rPqImzxAwZYzmuS/P7ctPwb/9dL8pyrUM6t9a/k/h8d3+f0u8yW4b7x8NIaijhmFIM3INMQDdJmPdkP3QOhU/joeBAou7/rk/VOzjBxj8T9Za0b7b7CfMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V7t3Eao0J+GyW9ZbSFnWZ0mRBErR1sFv7MgmeScJPc=;
 b=p1veeL1RJMSPkIpB4bfaMzKjjtk1OdM7xmWuUB67o2fmT4/Lhx4McmrG84eFKzFQ0nd7aEs60Z733EQ8fPDl0bPxB/l0/pIeDRNReyHraATeS/Ugs8uCYlvFZRtG3prs4HZXzM6qm1BjYR/GBzd9Fk9ujI0CaMpHdK/N9iGejwHdgIF8RAsja/PNHog2I8T/9zgBBjzIX8+tCLMhRi/vrwWibnfdWRpxdGq9kF23RSrRA4scw4o8yRdC3k6e7BtkKaFAF//7yZrxajyqr5KKux5FeUBdY+JW2gvnEyGwzeaMEZc+5Fm+KCP7u00D0l10CG9VZPxUYZ5FD7MXcVQPSQ==
Received: from DU7P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::32)
 by DB5PR07MB9536.eurprd07.prod.outlook.com (2603:10a6:10:48e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:39:54 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::a9) by DU7P250CA0005.outlook.office365.com
 (2603:10a6:10:54f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Fri,
 15 Aug 2025 08:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:39:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id F2ABB1C0060;
	Fri, 15 Aug 2025 11:39:51 +0300 (EEST)
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
Subject: [PATCH v15 net-next 08/14] tcp: accecn: AccECN needs to know delivered bytes
Date: Fri, 15 Aug 2025 10:39:24 +0200
Message-Id: <20250815083930.10547-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|DB5PR07MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fe8bc7-3c55-4288-9a87-08dddbd74e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2pHd3BCSFRPQWh3MFc2bktxajJkaGt3WVhKSnVyaDA0dmZ6Ry91RWJNY0t2?=
 =?utf-8?B?Z25abk9IY3dpVHJGc2JJUnhaazQ2ZzhPNnoxSnZxSG1oMUNGYW04dlZuelNu?=
 =?utf-8?B?N09DV2RWRXpIYVRKR2lqSFF5RGJUdzRUSHAvZTlqc08yQzhwd2M3RHg5Q2F5?=
 =?utf-8?B?dG94cGdibUEvTHhQOXEvQk41QlVaeXFCVGwvdmEyOVdzakQxd29NVFN3U0xo?=
 =?utf-8?B?b0RNQ21IUVJkSU1ockpUeWNMckhWOU5YYW92RzNrK3lTQmZNSkwzYnh1ZFdZ?=
 =?utf-8?B?QUc4NE9Cb1dlczJxblNnOXBJQ1U2TEhuY2U1MHpVbG1rOHdJNlo4QXV6T2dV?=
 =?utf-8?B?c1VQNjVtT0ZZNnhvMUM4ekRyOU9WQmZGbElZYzBZYUk0NlVTNHZvdjhWMVFL?=
 =?utf-8?B?TzNDaFVlZXYwNTBacUx4MlFsSmpTMnp2RVlUR0dqbklMS3lHcDJ2Z2ovWDlx?=
 =?utf-8?B?UnBYUDVkeDBBN0lCa29YTG1ndEJIS1JOVFN3V09RNnNUUktlNzlpRW5CdGlR?=
 =?utf-8?B?eFB5Rms2a0lsL05WbXZKY2VpcHg5a1NMbU9tUDAwazRyZ0VObHpZdGxCYm1S?=
 =?utf-8?B?NCsySmxsbmtGN3F4U0Jubm9qSVdlN0VYdWxvWFArUXZ3OFFUZjhtMHZ3QkJl?=
 =?utf-8?B?K1YrZlN5YU93RWlaSCt2eXZWbzZ1M1FUb3hpR1dNV3FOeU1pN1FCb29aMW84?=
 =?utf-8?B?MnU2V3l2bFJEZ3B3N2dad3o1YVh2d1RvZ0JzeUpJeWxidGc1UEovRjlWQmdp?=
 =?utf-8?B?TWp0QkU2T01iNTIrTlQvU0dVTzZoK0sreGU2c2Z5dGppbVI2YkZiYnZLUXBt?=
 =?utf-8?B?bU9uQjM3T0N5SklFOFpYbnk4WWlTT0Y4Tmw3d2hjN0ZScjFHcTFtaUk0aXM4?=
 =?utf-8?B?S1dQRWZSOTVvSFNEUFg2ZVNMS0VCMlpSSFZaWXlvdDdTOE53dFkxSjNEbmpq?=
 =?utf-8?B?c2JpQlVwN0NqK3hiNEFLczFhS3Z6RTh2bm1hUTBUb0xNZ3JKZnByb0oraE44?=
 =?utf-8?B?dXBlcG9UUCsrd05lU0ZObGRLYlMxTWpuNmYza01YOXFYYmdJN3NXYjBYV2xt?=
 =?utf-8?B?aU5FTVllU203V0pqZC9kNFltNXFENGpXakREYkJVWk8vREVseVVmZ0hKQ2dr?=
 =?utf-8?B?UWJXbVc3T3FObWFERHUyL1duaEtXSHdFaVlzamhHbWp0RTQ0NDl1RUNNdElZ?=
 =?utf-8?B?Q2NMb1F3OFAzOTM3WVlMM2p1UWowa1BFVURGU3dMNTFaTUFLblVyeGErazQw?=
 =?utf-8?B?Vmh2c2I4TUNySkxvd0JmczYzQnBYYzN6bkJqWGZ4TzlqbzZGd1hnSzdOM3Fu?=
 =?utf-8?B?OW5JUTZGOXM3WlZ2akdUTDFlT1dpendvRXpSWW53UGcrVHZ5Y0lOYnIwOTcv?=
 =?utf-8?B?eGtsUnB3b2FCcWEycUwxSFNiSkpIZVd1dDNIdnI1MGt0ckN2dDhMVW1DYjUx?=
 =?utf-8?B?dm5zZ3VUN1FKNVNPZEVHTVBmdW92TFFnVmdFVDQyQlZZSzhic3duWWQ1M1d5?=
 =?utf-8?B?Qlc4L0x1SE51VEM3b3kwcTZLaU03WFBkaEM5eHUzZ2lycVA1MzhvbE9hZmxZ?=
 =?utf-8?B?SkxzRzRYTW0wRWFyMFlzZ3B6SnBaK0JjMjR6NktJLzlrd3laMkhpLzVDaVJB?=
 =?utf-8?B?Z2ZRNVdGenJMWWR6NEZ6cFRiMU9jdG1lZmR1ZVN0RDJ4cE9pMkxkQTNOb1Jz?=
 =?utf-8?B?THkxTDNTWnZlZ28vdmsrZ0taTTBVMy92L2VaZHg1b2xWUFJRcWtzZFZtR3Z0?=
 =?utf-8?B?NHRNWUlYWFNOM1NQQ0N4RSs4N1hPRFlMRDZQNVVES050OVdaM2NhS3VSYVNJ?=
 =?utf-8?B?eHZuaUJta3ZWZisyQkRMVGxZZEJaeUYyaUhaTFltbTJYZExrYkJ4ZXFkMTFC?=
 =?utf-8?B?dGRaT0NzYXZTMi9rRTlRWno5b3VBY1pIQWdMbU9pbXF1OUdiWGdiNW5ha1Yy?=
 =?utf-8?B?UDVxRUk0NUI3S0R5TE5QdjBwVkRsVnZOdW1OUm9CbTRtd1IxbWlNNnF6Rkd1?=
 =?utf-8?B?N0NObG1mQ1B3eDRyTklhMVIxM2pib3IvQnI2UGZxWWxBSERJNnA3OVY5UUNC?=
 =?utf-8?B?Wi9rQzRSaHdrRVRla3JGbVdVeThZcHZ0Zjl1dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:39:53.4936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fe8bc7-3c55-4288-9a87-08dddbd74e5e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9536

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
index c0d0289ce4d8..504bcb71d942 100644
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


