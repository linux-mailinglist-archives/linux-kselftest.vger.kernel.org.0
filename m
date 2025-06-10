Return-Path: <linux-kselftest+bounces-34568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D0AD37C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419CC17196F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A42D3A6D;
	Tue, 10 Jun 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="hZHrsnUo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C112D3204;
	Tue, 10 Jun 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560017; cv=fail; b=gMldVvIZseE2b2pX54ixmTw8UTvnlP7pDIZt2/QJjQJVZSo8zzCsgITjTHcHPKubJaVuBxAS7ZMWIlZlbnwun9tutX9OywACUbgYLliX1uAZ+Gb9jM8JjWOeVBCt9P3H3IggNHLsNoFSQ8aDFVsrLEyBDkZfBB2KLB1+n7obxm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560017; c=relaxed/simple;
	bh=EGRJo33lBQroDMsTr+0Z1YbqpPlAFAopf+2vrdA32tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUcn9ilImzWdZUjUzXa/s0iufr75PQ5LcWKUp23at9PfqR6YVX5JvGJ5KYUFAkj7OWQT4Ds8Xqi2H2ZbSJ5dg2VWcRrTENGYSPq690XLL4PlYIdv4/t9cTTgiymKs4QDl4XTrjaguSmNozVC+asprAZkvIY5hEMexobIZXCg6xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=hZHrsnUo; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W45oFFvrbbeUI535VB+VpzYVMySimoJ7sH15bKR2jbRLhu5spk5XyMWLXeOZY4gNl+vjljoQoww56D1pfcFesEFpxofI9E7NBBU3OHxKAWImmUvbj0mZRBqQOCKjNNBVnfyMUX+CC9RLU742hKP21AJsUViUDvvuBpJk2ZilZ5R/0CatdB5iNPhXjP7hfbqIsIzAFMQ5YudNHex6Ai3uIA64k9DPJ6Ndp1YLVokLGq813ChAazsX/8lCX2mzlJpJjrAZ8jSOWbUD3lw9l25iu8eoJocKz6zmTLqLQ5spg5S8iqBondR8HQJBz0sjgrJRRU8LA6grkD5srkG276JE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A63pFd4p5HqfGm6fH2xeOmyQCu6fB4tKeRYhrVamMXs=;
 b=uGiOmCuvt8x6mMjRGDOodX79IYYTZkwgiKIP+rlxMk1HqL9BFmnGiQL5DYpZn5OpDgfY7TgFQhZjLzH5Q0XVGMaUv86/g841ir/wEDPv8xw5g34WHQYUPStkVU7P/9sGtBaH53JUH8HAyCwfoZR3Gii7I1MvIPXMeWzLySM9Xg3yL0FrSAwoO1SpwRiLJb4ftbgsboIlq9q4m7Q3xYsWmohbXjSUEBeOixlTnW1L+bxP7kW9HVilrd+zuKhAe7szCbPJUKpksHma3NRkXl+HV8q9JYP/mbCiBakYGD+5b52DbeUl916dDAxLYLmBcdij8TiM/kCPz8lv9qitBzADcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A63pFd4p5HqfGm6fH2xeOmyQCu6fB4tKeRYhrVamMXs=;
 b=hZHrsnUo6Jl67vv0ZMu3xt4wMh744V1hq5JMIgQg7XSsvYcvDEluoNv/CHz1LWTJ5ke2t/u2fcI6+o0okJey3B+Tc6BpRDwMMOuGrDuFlwLGesvsKpTGNUn8id80Ozo2Gm7CA9uM852FasgWiT8ba9v4qNkVGxiTdSlD+EDo0U/0TVAB2K8Ln4PywxlEw+qJFeTNBeEgVVdVffj/8T1p7rsJPztpkJIjPn4gthrkVttfOq6iLBGw+CEo+ffabdPKaI8bWZOjFDt5usqqi46HH4dFR8R2YfrE9RUoIUxZKiC/jLBpZBC8tf36z6vKMUDuSi0sycR1DQRv2SHcUZOKHw==
Received: from DB7PR03CA0093.eurprd03.prod.outlook.com (2603:10a6:10:72::34)
 by AM9PR07MB7874.eurprd07.prod.outlook.com (2603:10a6:20b:2fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 12:53:31 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::15) by DB7PR03CA0093.outlook.office365.com
 (2603:10a6:10:72::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 12:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id A1D322009C;
	Tue, 10 Jun 2025 15:53:29 +0300 (EEST)
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
Subject: [PATCH v8 net-next 07/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Tue, 10 Jun 2025 14:53:06 +0200
Message-Id: <20250610125314.18557-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|AM9PR07MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: a2786bef-c91a-40c2-9af1-08dda81dcd84
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OENyMjBHU25zZ0ZJMzc0eGU2SGhYNnlWcWhSWDNhTVV5aTV2UWpHWjdvak4y?=
 =?utf-8?B?QU12ZEdwcndxeVdtZ1RhNzBmSHJUL09WZ0dDWnN3eHhYMXl5M1JNaTFQbmVV?=
 =?utf-8?B?cmJXSWs2eWFVd0RHYWVPdXR2cU9VZW1OZWx2STZFZXYzdUFyeVVWQXMxVzVK?=
 =?utf-8?B?bzk5UkQ4TjZMS1gxaUp4eFM0eXFmZXJxR0wwdExoaGhRVyt6TkF3VGRqRkw1?=
 =?utf-8?B?YjQ1LzQrd1dQWHBDTDAwVTZadlBYS0taRGk3d0F2M2JBU1lKT1FhVnVyajlO?=
 =?utf-8?B?MlYrVW1CUG1WKzRIRXhRaU1sMHdMZThIdkhwNk9pTEpnWmNZa1h6bVBVOEpZ?=
 =?utf-8?B?WGVqMzZucVhSNU1IYWxZMkJCU0hoZTc1Y1FBbHNVVDh6aGdmR09qWGNXSElF?=
 =?utf-8?B?NTVlVUlzSlpCQ2d6UEx2QlVKRlFNcThnY015ZUlSOXlQMy9ibjRlYXhFWCtT?=
 =?utf-8?B?N0pzTEc4THpNdEUxWXRnNWxZTGQ2Rko3cFBBMDlENTNyVW1MMFBPcVRkM1Nz?=
 =?utf-8?B?RjJFbURaOHVTY1FoZDYzSVJRaGFCZ09tQThyWml0cGRIVDdOa0JMMFhHWm9t?=
 =?utf-8?B?T1hOMlRES1pSS1Y1eG1WTHVkajdnU29pWVN4V3VLQyt3SnBsTVoyUTN1dlJz?=
 =?utf-8?B?ZjNMTmVWOXQwVVd2eUJXUUZkbThtZnpmNG9EZkwvaFJ2dkxHSG1COWx6aUV1?=
 =?utf-8?B?ck91VlNGZkVyTVZLN25FM0VUN05zOTZ3VHArZjB1MFVGQXVGYWNVN2NDUFVh?=
 =?utf-8?B?Sk8rNUVaM0Y0N0Z3aEJaV3ZWR3JKMDdGVzA0U2VpQVdETWs1dGNsQWFlMll0?=
 =?utf-8?B?bWdSeVdUQzRMdXVCazU2cGk1NHkvb0ZxTUxia0E3TFdlMXBvTFhDUHcvSkJJ?=
 =?utf-8?B?SXJJaHppVjVoRW91S0JGWkRIR3pYVnhEYkgwaG9weDNwemtSRlhrZktsd05t?=
 =?utf-8?B?cVRpWTFpdG53YTBGcktlTDVSdjd5VU9WRVhvVFFzbHAxdUZnQjBVaUZLL3A5?=
 =?utf-8?B?Qld2bGVYSEEyeVN2UjlFalNwK3ZkbGZyMkFuMkNPd2pwWjR3ZWxtWGp3bDJE?=
 =?utf-8?B?eGVyRXErV2h2YitzUHduYm4yUnpzdkJZOXRaU0cvNUYxRFB5MG9HTG1BbC9N?=
 =?utf-8?B?NFdhelBRQnpRZUVubHEzTDJZR3kyOEhhbGZmcHZkeHRON1YraXRtd2Vsd3p1?=
 =?utf-8?B?bjY5bnp6YVVtVnIraXZqTkFNYlVKNERxTDZIbHZuRmkrOHA5UWUycVoyNHFh?=
 =?utf-8?B?R2pGZ2hjRVgxRkdDMjZtN1FnTXVzeXFWRUZQNkFDNHJlUkRLY3RCYVhYdnNP?=
 =?utf-8?B?VExnVjdsQUFxTTZ3UkZaM2R3R3EzcWhkTS9FOXNkOXprUVFnWlFMMDZ6WHJV?=
 =?utf-8?B?RnAyNnlSZUxyMVRORnorQ0RrVjM4OGQxTElsa1QxWmdNUE5CWWF5b3BRNEg1?=
 =?utf-8?B?bkhxM3VMcEUxcUhIY2JnRjRYQ2dadmtqdWpPR09OdEt5a1ZNeUxobHE5UmZH?=
 =?utf-8?B?bFZlK0d4cG1XeGQ2OW94bXZFcE93TVVlK0lKSnVxQ1Q4MFZEb0doU1Jzbjhz?=
 =?utf-8?B?YW12TlRLWlltY2RDS2FQQXJueGVxbC9aTU40YUNhN2RSVjVWL240Q2NpS2dC?=
 =?utf-8?B?a0FmaGVZOUxaRVJueitDUTFsV1FML0J2bWRnYlVGT2ZaQmRIYU5rajFkNUZ0?=
 =?utf-8?B?OTE0MUk5K2xWRzJ6dnh3VkhuWDByYzQwbmpDaGp3MTNwVmxOdTNTMjk1YTM2?=
 =?utf-8?B?aVdCZkxsMFFGUllGSmdXR25PL2VCQU5SbDBNQnd4aTV1RUxKdXhuSVBETzRv?=
 =?utf-8?B?Vm1UWTg0Z1dEaS9TRWpHTnlJUmsxQnE2TXBKczBJcVJoVjc4cjVHVVpGTXlk?=
 =?utf-8?B?azRaenhtZmVBODkrSTdaR2ZGTzFRVmp3dHljbHhIazl0SVFkNVBOSkpvdkx6?=
 =?utf-8?B?dUNGZDArVFppY1hIQkhGVHBJK1hxSDZZeFRJVHNxVTFzRVkwZUZFUlFMWEc1?=
 =?utf-8?B?c2JlNUcyUGViWk53NzNKS3lEYmIvcktIWFRNb0FFMUs1TXhmb3dzazk5eE1o?=
 =?utf-8?B?N0tHc2p1NWZJS2V0TCtqaDJDNG1WOUJmbmgvZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:31.1207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2786bef-c91a-40c2-9af1-08dda81dcd84
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7874

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
index ccaa768db145..3e7834bd7d68 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1186,6 +1186,7 @@ struct tcp_sacktag_state {
 	u64	last_sackt;
 	u32	reord;
 	u32	sack_delivered;
+	u32	delivered_bytes;
 	int	flag;
 	unsigned int mss_now;
 	struct rate_sample *rate;
@@ -1547,7 +1548,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
 			  u32 start_seq, u32 end_seq,
-			  int dup_sack, int pcount,
+			  int dup_sack, int pcount, u32 plen,
 			  u64 xmit_time)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1607,6 +1608,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
+		state->delivered_bytes += plen;
 
 		/* Lost marker hint past SACKed? Tweak RFC3517 cnt */
 		if (tp->lost_skb_hint &&
@@ -1648,7 +1650,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 * tcp_highest_sack_seq() when skb is highest_sack.
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
-			start_seq, end_seq, dup_sack, pcount,
+			start_seq, end_seq, dup_sack, pcount, skb->len,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
@@ -1940,6 +1942,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
+						skb->len,
 						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
@@ -3556,6 +3559,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 
 		if (sacked & TCPCB_SACKED_ACKED) {
 			tp->sacked_out -= acked_pcount;
+			/* snd_una delta covers these skbs */
+			sack->delivered_bytes -= skb->len;
 		} else if (tcp_is_sack(tp)) {
 			tcp_count_delivered(tp, acked_pcount, ece_ack);
 			if (!tcp_skb_spurious_retrans(tp, skb))
@@ -3659,6 +3664,10 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			delta = prior_sacked - tp->sacked_out;
 			tp->lost_cnt_hint -= min(tp->lost_cnt_hint, delta);
 		}
+
+		sack->delivered_bytes = (skb ?
+					 TCP_SKB_CB(skb)->seq : tp->snd_una) -
+					 prior_snd_una;
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
 		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
 						    tcp_skb_timestamp_us(skb))) {
@@ -4121,6 +4130,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	sack_state.first_sackt = 0;
 	sack_state.rate = &rs;
 	sack_state.sack_delivered = 0;
+	sack_state.delivered_bytes = 0;
 
 	/* We very likely will need to access rtx queue. */
 	prefetch(sk->tcp_rtx_queue.rb_node);
-- 
2.34.1


