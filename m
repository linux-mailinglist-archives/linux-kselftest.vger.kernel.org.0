Return-Path: <linux-kselftest+bounces-36381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD1AF698B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A94D4A828E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831D296156;
	Thu,  3 Jul 2025 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EUpCLZgV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5236292B53;
	Thu,  3 Jul 2025 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519933; cv=fail; b=Tprc38Uw+DY6uzGhGUabqER2GyaOeYJT/MEw15cU7vVBCEa5hA1lXiZ4g2Mqy1HTetq7ALYG9lkK3TIr7QS/dpY4m8xivIrXCpQLL+bckE3YLSYfjqbnUWpyo7kwlfjDCTVDs6tuoHhtalJd+s2yrGacklHMpeXaSxR4QjAwhmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519933; c=relaxed/simple;
	bh=Mdybeq9G3B7GP0/beCF/g8cOd609L0fOuIyY9L1kj0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTWurXqHG4EFFGWA6V5JwacQ9S8bIXyLYobmJeFX4DzPOVxj71kxPOLj9YIHkdWjVhbfsm6irX73mTecKVb61mmIXQGcy7gu43i/I6oEup+ViW3ihXWJE7JVVLAIRgB6craZJIRMTJngRIg9+6Pun+XWPSIlVP5nu8XbPRr6e8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EUpCLZgV; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dtzx41/6MCA4CTUAlztd0b5uOv47aR15uNhhCq7DlW2PlhG3OO7IfbqDukw+e3WniGd4XU+KELtUWZQ2YbJVGQdoGbwCFtwRAgjfHPk3i+c2NalOE7g7k3Vxh5J/0Jn4s2ij2Vl3CezTvhmzwt7M1uqhIHC2WLKqABTYXK5wZqV12O+JYgdV75fywSGWQ5+edWJfZ7sU9bBW9coPI9KoAjl9my1ypgzjNXirk/SodoQ412i5KAHCq9FNsFgZUPEplRXtXmrhk+OahbfrGRizZ6ErprkwqXXd6td4aZrwFfYvueM3zhPxrvTy9rLQ/aqVv+rrmXMYExDKTn2zadNI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM0xWJCdgOMLIxC5MdTge+tEJZ9kxNrnSEOTj6/s8Fw=;
 b=DLgDYMu5atfb0ByWRanLDZcLmaTQBzc2RmcluXrgQLZr5Xgq1t3lGIKK0cXtAjXQh3rTbklQ+FuOBy3AGhcimBUpyi9OY4o4c+ukOATJN/7prR4tzMtturCYO2dYmDPOiTupS5b6cyiUb6lPxmlZdoaIOccme6uht3i+UtcSh3YsdtbziVL1KVCfGVFR7xKX78EhhiNS9PRsrNu0Ja+rCHQAG7PvKlG7JyTJaEo24rPJVlV5irrGsCfCW5vUN+Na9LXk2B7Bv6b2s/NqfoSPKayyYTxbxuQeHmdq697WFHbphWGWGna/YqgX2t1RyFwMO4rcBQBQAnC75aXq+wlT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM0xWJCdgOMLIxC5MdTge+tEJZ9kxNrnSEOTj6/s8Fw=;
 b=EUpCLZgV1W4W5T5MxxKfE++syOPh9sW3/QOQNb+5dZMaU0txJIMln8JawmXuVVcAZmZXzxRr5RZhn7rbtEkK+Wv5GyeV95sbNbWiLzNCuKuTU6rjkChpcvv8p2TCW4oZY7kesDxH/91Jc1rQz4ansyTL0JxzdD9vfP6rm68oWLYi7Tg0ULcUXDR9ZmPCbbiVzS3IfoZr2dCoz18UUe7q//ERI3oYatJbmEY+ju4CQfMeA9vcb4TEfcItqr/e2LdoN/RHvwfLHb9XD3enzOyQrxuBbFcY3kFS6b2b7G7TFkLeZo8Q4M/O6Ri3D5uqC9C1sZrp2R3eNkSzmNrz58s5wA==
Received: from AS4PR09CA0027.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::17)
 by OSKPR07MB10541.eurprd07.prod.outlook.com (2603:10a6:e10:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Thu, 3 Jul
 2025 05:18:47 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::8d) by AS4PR09CA0027.outlook.office365.com
 (2603:10a6:20b:5d4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 05:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:18:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 94FD9200B6;
	Thu,  3 Jul 2025 08:18:45 +0300 (EEST)
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
Subject: [PATCH v11 net-next 09/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Thu,  3 Jul 2025 07:17:22 +0200
Message-Id: <20250703051728.37431-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|OSKPR07MB10541:EE_
X-MS-Office365-Filtering-Correlation-Id: dd71c8e1-3861-4ed6-f679-08ddb9f11679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1U0Smw0OUxMVmR4M0h0MXBRbzRXOE5EenV0L0dvR0V4dlFieUFQWFFXS1ZI?=
 =?utf-8?B?WlM5ZnhINVVKdEl5MU1TMUpXcFJZcElWSFRaZkxmRXEyYS9idkRhcFhtZFlq?=
 =?utf-8?B?R2FIWXBTS3NsNWJSZ2xYZjQ3anA5MmQyY2NXMnEvOHFBdmRwNThRQm1PVW85?=
 =?utf-8?B?eG14OWNyWWI5SVdpclgxVERlWldXbFFmQWdGNTlRWlVZb2xTWDdib1NBTENj?=
 =?utf-8?B?SHUrVlRiYlJMa3dtQVNabGtoK1F3L0w0Q01CU3dMZm93TzBpWTZ1M2ROZXRX?=
 =?utf-8?B?RG5RTE9wN2owQ3NISkk0TjdDSkc4MnBseEJaYlF2V0pwNVVVSnF5OHZhN1NH?=
 =?utf-8?B?a0F5TmdpMkdEZU5kdCtjaHhSN3ExZGUvZ0JiZkxhUklaZkZVOXJ4S0k0eUhi?=
 =?utf-8?B?L3NLNDQ0a29xZyt4UmNFQ0tPSUxTRGlRaXVwVGR6RUFyQWJtNmlvQUNPemsv?=
 =?utf-8?B?RGZQWE5yNklOd2xtL3ZUb3Z4V2RZbllYQmZjOHF4M21rU2tPNE9aOG44cno5?=
 =?utf-8?B?Z2syUE1BSVRuOS8rY1NZTHNXK2R6d1lOY1FJUGVlWVRweVlGRFg5bmNqQ1Q3?=
 =?utf-8?B?dzBKOWFKaFdCY0t1UzRaV1JkUUwzdVM4NjU4TzFnR0VlUElNZ1lqMVBMaERr?=
 =?utf-8?B?UkY3aERzcW9VVVR4TGMzVGFhQldWa2pIcmt1RFdDdGxrR3FSRFBvZUZ0M1NE?=
 =?utf-8?B?UHc1OUdndWRHMi83Sk5CNm5STGxvOEVFajJwM2pjbVBiYXE1TytWbm1DNXVp?=
 =?utf-8?B?MUt6WjdLcU0zMkt2OUxHWThFSFlOdkR3TXErNXJRMVJYOHMvTmQvcDRnRHVs?=
 =?utf-8?B?Y0ZHRU5ybUdXR0Jibkw3TVBrVEF2TGlVRHBNN3dVN3ZjR3dnb0V3VVF3WDZU?=
 =?utf-8?B?cEJlOENkeEdqSGJCaXpOL1lDYWxSUWlhczlEZVpESW15aXcwUnMvSDdtTE5S?=
 =?utf-8?B?R0NQQW9ia3JNWjlHQnhUL01jWXozUmVBM3R0TThvQlc1Zmo5WGRkc0ZJSW9F?=
 =?utf-8?B?b1kxUDk1NVIvMmhCN0hScFJ2MEFPUjE5L2hQUlYvYTF5RU9hQmJTai9WK3gz?=
 =?utf-8?B?YzZHK1grWWx6b3c0RVFWYzVxV3VZSFFpUE1aRG9xc1FiazFPNkJ4NGJLR0tO?=
 =?utf-8?B?Mk94ekw3QTNUbEJwNnYwcGJiN2x3eXpINnlIV1JwRkVtQk1oSlc1bWlqemxR?=
 =?utf-8?B?aFZsRmF4NWN3d3dzbkR2UzlOQTBOanRoVWdiUmRkSStWei81aUZuamFkcjho?=
 =?utf-8?B?T0VuVFlmZ0JCOSt5WHdsY2lxWEVPME9ONU8vM1NMMWNPS1dwMVJrUUlxUDdm?=
 =?utf-8?B?N2NmTjRyTVhLaUxvcUNzYjNXdzdjMTY0N3pNRk96aENIaDVtVlI3ZWxOdTZK?=
 =?utf-8?B?WmRlbkZRY2lKSVZXcWI2bXpqTUljVFBmeENiSUZ6SlhYVTkxRTNBUVZvTnhk?=
 =?utf-8?B?Q29nS1lMNExOVkpkOFAzbEdqRVRwTWZ2SExDUSt5NnEvNkRmaFhCNEhCOWVt?=
 =?utf-8?B?NUZRRndwM3JaSm9xUUVQWnY1TkNQdVRBSStNSkRKZGVTOEptTDU3NTYrSzVV?=
 =?utf-8?B?QWtSVTNadnFjY1JRZXdQb3RyOFhLRnd5QlExSVJJSWFoVmxOU1RFZ3FyNDVY?=
 =?utf-8?B?VXZxWUQwU2d1SFFvdCtzQk14VzV4cGNUMDJUbHdZT0VjREZoc3FuZE1HT3ZS?=
 =?utf-8?B?TUZLcTAwMkJVelcrWFQ2aHB0NjlEN2xZNkJTZCtKK2R3NEpnUWtqQjdBNnEy?=
 =?utf-8?B?dlp0NjVLSjdQM1oxS3l2UFU0cnpVN0I4Si9HbFRJYUhNNVBQNmlscmlEQkJO?=
 =?utf-8?B?eE5oQ1JkRDFVZEgrR1BmSDB4RlNtSGZSbGVrekYrZ1lnb3FIOWtBTXg2K05y?=
 =?utf-8?B?WEgwN2N0dEY3Y09ldzU3RjgvNDhNMjZuVFp3UlR0NUFOMWtpcTdPaHVXUkp1?=
 =?utf-8?B?SlcwZjlhc0JLRldKcXJtemRNNkp2NEJPUCtXNlVUUnZCYk9sOEU5NSs5MlE2?=
 =?utf-8?B?RWhEYURNa3ZyNzVKMjU4UklmZnlCZ3E0TkZBblptOUx3Szk0dkpoeUE0UEFr?=
 =?utf-8?B?bzhTWVc5My9RNURTTjE2STRyTFFpTzN4MFhnZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:47.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd71c8e1-3861-4ed6-f679-08ddb9f11679
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10541

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


