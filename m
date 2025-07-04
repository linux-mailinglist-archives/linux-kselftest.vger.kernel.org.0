Return-Path: <linux-kselftest+bounces-36516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EBDAF8D19
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0CC5A57F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490AF2EA746;
	Fri,  4 Jul 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WH/RBF70"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4B2EA47D;
	Fri,  4 Jul 2025 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619316; cv=fail; b=dCtbYl0DXYpmSdtX43FJFQ4IEqJYf45cHWk/KTGdiADC8AAEqcp8FxoTaTny/0+8angTNyyjJJqIJN94iPXUwtobf3VR46UKFTKO9W7FRk8O39Pn5/eidG4riCbRtveZXnwi1Is/bqNYyPk3XdaCXlQy2ufG4V/nV40pZBIGe5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619316; c=relaxed/simple;
	bh=hgg1HMuKo2okA7YoJWXqB3c3Ec5KCuLARxUTMC3Ad6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKO7rr11si2NkH14FiTCvzIwIRVrZyKcCSNCFcfR9o1i1DIvXaDHBs5kZJl9OcM0gsZqIhZMZSS30g/WZ1HzY7zFO37Tf/297OA46Hfkzmq+otZ/PMSi6JcEujyCNziNOi9grY7td5OwodTtQ9eH+FO0FHzWHUEeRCjZy4+KJvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WH/RBF70; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySl//gW1d+MtpB6igHWJ8b1oaa3FAUF/aShR46JEFuP7Sj3wDFwwiMWqw/ACmV/LgrthPvyDTCIOwVDmSWJ3wlVP0SZFvO+NnhnWXQuN9HUTBONSV4PmleDSXSjn/S/g0pwwUhwu0Jw3pbPGvQAjpFvmQXvGQGWZQeLT0vHxWJMIayReRJu27MuPGuob2mB69jGeKRuZ0CyE1h1f0K+OPKcCdaKSXNKzbf1yaUn7WXhcXVHtEUr3V9JKl5ThMHizbvDgV76AH7MSxBO0aoChox9E7S/1dTC4uWj3fafZ+0YhqLSngwJNRsS4+RofWTMykIQk53+Ki5W3xfZKSXHISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23dTVbiaBq+oIvS2aK1JS0R2xvKtAI1Mq7rqlS1bxjw=;
 b=k6UKJXqRFJgcUMmtWwtEw0WoXIPg7IsUkhhoXyHBresXDPRpGdyh2aZl8DgCggUdda5a/YpZCMFuEZQ7Lgm645mjUfmXcu8LmB8iJdWv/fGXAu20F7g2jB+YDxbt4KRJiT8PLgnizlxwb8RQ9AQeKwpZtbhgMqcJAX8WgoGM55VgLA/5VSNVEFslNn+SbDZOyROGp8BujjuMLvfNI958Eim2Pck4PAvuHav8JaVp+synLlQjWdOM2Cqf/7vDbzfUfNidbFqrp6j3EU64IIBkLK3M26VIq2ZAlRdQaQhGXF48wkUZzhZns6ODMGm1KPgHwKkmAmJMC0/5XVObaN7/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23dTVbiaBq+oIvS2aK1JS0R2xvKtAI1Mq7rqlS1bxjw=;
 b=WH/RBF70gKtMQ8pjOWcoyP/m60cdNHIvXhIZD92s+XLRYZ4IDzxwFcld+I9uQZnGQ6lSMHQilS9dQX5lcr8CVbOTiICyRA0zMKpM3cr2QTfXhAORcQDuy1XilV/ZQTh7IEJqBGJB5gq3rv4tJPH/hdB4nSwsYKfqAGV9XzngjAwGpSjFlD4+Z+A739VxMYpoDpZ3NJd8zuZiqx52eQr5mDh6z/kDORwr77QIL0outqifAkdJEOT569gbpFUpv9br/40zVjcUUmVVRQGLuNi4I7zMeiB5m3vv1dyItAXcta3HKQg9CPbV/57GSguxcWRdxr0x4aHYObKYBaqgpTiI0A==
Received: from PR3P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::30)
 by AM9PR07MB7330.eurprd07.prod.outlook.com (2603:10a6:20b:2d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 08:55:11 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:102:54:cafe::72) by PR3P191CA0025.outlook.office365.com
 (2603:10a6:102:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 08:55:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id CC3A6200C1;
	Fri,  4 Jul 2025 11:55:09 +0300 (EEST)
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
Subject: [PATCH v12 net-next 02/15] tcp: fast path functions later
Date: Fri,  4 Jul 2025 10:53:32 +0200
Message-Id: <20250704085345.46530-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|AM9PR07MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 71511349-6588-4eae-b030-08ddbad87c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTdtVmJEWGE3citzMVQ1b2ZKZ0JhVGZ2WGwzRHNFVHpUMjJGM1BaemRkTyt5?=
 =?utf-8?B?M0FnMU9QYVhoSHNOeG9ncGgrSkdLUXdmUzZBaE1UWE9Eci9yQVdEVERMUkZF?=
 =?utf-8?B?T2ttM1pmUTU0VU9xTDNUamNvQTFETE9GM25RN2NpalREeThvcFpBWm8rMDYw?=
 =?utf-8?B?eEtxekVGMVpPTTVqbjBSbWlCdjh3REdFT1hrWkJHTTdXbHdLdHVzK01CRGw1?=
 =?utf-8?B?T3pZalhTcENuV2RnWElCalBFZWlia1Z0UFhTNzZxcEdtaEVJRWRuQ1Uyd0dh?=
 =?utf-8?B?MGNwckdIVTRldUp6ME5zdk5ydzZPaGNPZ01JQTVKTUhyWlFnM1BRTUxhVmJ3?=
 =?utf-8?B?SzFoL2lQakZ2aUhiOW1qWlE0MVJEOWltVE5IME9CVE8vekpCV2w3TXhkQ2Nm?=
 =?utf-8?B?dkVuNGlxdy9xOWxKZ0Y0a1VWNCtlUjU3akZ2N1duUURYYmQwWnN3aHZuUjVX?=
 =?utf-8?B?c2xaWVhDMmRhMGFwWkNOLzJMM2VVNXRhMnkyNkdFb0JNM2JiRzRPckZsU2ZS?=
 =?utf-8?B?aVIrQUp1QWorZTg0Uk84ZzA3bmY2blBrRmVwWC9WN2VVZU12SHBBMXZLNjYy?=
 =?utf-8?B?SXhBLzl2M0E2WTc0bWNxYktYZUIwUnIwU25idXdZWFB6ZDA1Tk91VGFiQ2kv?=
 =?utf-8?B?dnBBNkRBaW5RQXlWbnJsWGRYUXI1ZTUzaGgrVUhnelc4VG9mQWg0YitXem1T?=
 =?utf-8?B?dWI5ZU9BaTEvOFNBUUZ3ZElybE9lSTY1bVFKVWJCcEJkQ3BKazVOYnowVlBT?=
 =?utf-8?B?ZU9WdkZ3MU12eEtWT2R0em1kZS8wZTBnZkFWUDFIYjNkQmVGWVlUYWxmdmlp?=
 =?utf-8?B?L2VlVWJraCs2d05ReXJxTG1yNDU0Unc2L1NLdXF6Z1JDK3ZwWGRBQ1FPcE9V?=
 =?utf-8?B?Wm1Db05UR2RBcVNEZ25WOHdXWG5CSXEzdE5Bakh1UHVCNThtNzZzd0d4S1Fj?=
 =?utf-8?B?U1BwMXBhZEZrRzNSdDZNdEdxVytteitrYTVPaGZDWFhPS2U2aytMLzhqSlRh?=
 =?utf-8?B?RlY2d29mTHMzeTVrZ3FWRU5ka0NuTTFSYkpzMlBzeDYwZEtxMEFLdjArNVAx?=
 =?utf-8?B?VHQ4Q2U2U2wyUzdaQm5HeFBxRVZybS9QRHBldmxRalN4T2J5SWlQU3MrWjlQ?=
 =?utf-8?B?R29zUmdyS0N5WjFjbWtDaG9WZzRiam5QRVZFcnB4YXhXZWdDSXg0Zzg5ajdG?=
 =?utf-8?B?VTN6WEUyT0RWY1pTM3lxS1poSEZYU1lZNEtnZU1yL3NKSVZIWjRuenpTWko4?=
 =?utf-8?B?ZzN4YkxPT3hqc2N5RXpUQzhVZ0R4SWYvaUNpSm9UVFQ3R2s1TWxxN1V6QmFJ?=
 =?utf-8?B?ekJnMkhYQWw1cUdpS3BaWXRXYzA0Mkt5UjlIaHh0L2hnUkpVT25FWCs4bTlS?=
 =?utf-8?B?SGNEemEzaTAwV1NRQ3U3eHZkWE5JTU1vNERpK2dQaGRJOXB3OFRaSlZKM084?=
 =?utf-8?B?NEY1UUQyMWVZdjF2L3RoejVTZFVsbituci9PZGUzYy9pYWxINGU4cXlBSm5Z?=
 =?utf-8?B?M3NDaEtkb0VQK0ZoMnNaTEF6clFyZnlHT2l1dGtuUjlFaEcyM1hoaDRVaTM3?=
 =?utf-8?B?eWZGb1laRS9pSndQYk9ycytvdWhzSUlFNkNYajgyNXlnZW9CN2dGM3pveERK?=
 =?utf-8?B?MXk4RWgrVUpIYmIzZmhnU3dUcGJ4ZThGd3dhOGFsRGlmT05oSno2aEtmSTZX?=
 =?utf-8?B?WVBWMDRZSWZpdzVTaDkrZnZHNncwSlU0VTliaFREWUkzZUdaTk1jY1R1ZndV?=
 =?utf-8?B?OWtUNmhOM2p5NEpBeE9VMHNuMDd4U2thZXpwcnZiRENZUEhVRUhCdUhsb3g2?=
 =?utf-8?B?a1ZVUE9wSE96ajhWRDJHVXlYTjBqQjVvS2wrU2lzcGdnRnNJS00vWnk3MHlL?=
 =?utf-8?B?djFtVjBpSi9JWUJFZ0VtdDdBQndmNDl3bGs2blp0c1hQNVNpWk8xVnlVY3JC?=
 =?utf-8?B?SlQxOXAyVzZyb1UzQVV3MmVWZmd0ZWFMbkxrRlI2Uk8rSGdwZ0EzQjU4N3FY?=
 =?utf-8?B?NUlCRnZBeTFYK1NwNm9HN0lWRll6WTFZTnhZZVo1UURhK3ZVa0dyY1AzcU1t?=
 =?utf-8?B?TkNXRHIzVVkrWktSMzBmVWt0MzBJL0t1QkQ1dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:11.2371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71511349-6588-4eae-b030-08ddbad87c07
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7330

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index bc08de49805c..b462f8c3e85b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -811,33 +811,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
-{
-	/* mptcp hooks are only on the slow path */
-	if (sk_is_mptcp((struct sock *)tp))
-		return;
-
-	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
-			       ntohl(TCP_FLAG_ACK) |
-			       snd_wnd);
-}
-
-static inline void tcp_fast_path_on(struct tcp_sock *tp)
-{
-	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
-}
-
-static inline void tcp_fast_path_check(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
-	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
-	    !tp->urg_data)
-		tcp_fast_path_on(tp);
-}
-
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
@@ -1797,6 +1770,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 	return true;
 }
 
+static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
+{
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
+	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       ntohl(TCP_FLAG_ACK) |
+			       snd_wnd);
+}
+
+static inline void tcp_fast_path_on(struct tcp_sock *tp)
+{
+	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
+}
+
+static inline void tcp_fast_path_check(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
+	    tp->rcv_wnd &&
+	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    !tp->urg_data)
+		tcp_fast_path_on(tp);
+}
+
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
 
-- 
2.34.1


