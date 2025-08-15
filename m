Return-Path: <linux-kselftest+bounces-39070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ABAB27B51
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCC9A21645
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B3259C87;
	Fri, 15 Aug 2025 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pA/qm3Hd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F532571DC;
	Fri, 15 Aug 2025 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247189; cv=fail; b=grMd3VpzMdF9YU9bN6hkoPYk+7DO6N8/hCZzzWoeyjSJAJukleV2i+Sp0FFpoxBBhebHqla6msJHwDh5P4GDjz9tZ/OPqM/kkBaU1amCyJMphnA1K8BZ4ol9GY+CfRnN82iKDHHAmqlvkdUbzG9zl2ppTXUhG2m4SquswV8nTHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247189; c=relaxed/simple;
	bh=6/7MrXJi0PgnvByl9UfKK29crHMGhq521IPg+/o5E1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDuko5cFBFB3fHOAypDoid/dwpB5ZI/jItmfl5rjq5VJplvL5kYdsqip7D4XIkd+9JvAW2QKp3FWMUUkU++/Sc5R2ja2qJs7nDKKiYDb5CpKaBE+tqAzrDhuiK5CwxSFnJ870RnoGFiqdlodE3PEbyR9v1rWrncT96FTXne/tw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pA/qm3Hd; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV4I0q5D+W8aZIEBLMxgLjccvcVZH8IBPbS9I3LsAQUWnb71oIeQyYQ0xOfoeVPvtZAE8bCiC213xibEifm0g9XCX39uyc9vhXOhalVXLQ62ngD5dlWSVmBjMgReAJNLj6IrCPu7PfhM0PEF8jj+jTz4/hyvjLa/5oKyCRbp2TKx+yvyoq/F3ugueW0RezlPlFINAHHtB3qaLoFQvYQvhwpu5qRfofbxo5oG1kylQdgl/h6SKf5CKg1gVWH5jDKZHTosBld7YEiQVgscq6X1JZk5G04z7QTIBVQeoIOGDqtgwn6+wlWAeYnsLPaKTrCZlRYVgRdhdPFGXUOhisB8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ys0T4KtDDbZa8sdXc4o5nWjhfTBLx0nvSk40vtW3uM=;
 b=jncBh7nzoE+asCviRYptgn0QhJHg8j6/1vZZv81VgGP7uq592n1OGlaWPk0ZY6RkMZi8v4bzfqTz3NrysT4LjzotRlVCNoX4us94vNcQztNMmzVZtK7Ql5T0dG5b9NEe7227HNKy0ybmjMZG6ztw54pg2N62OeThfV7ys5r2Ipo03jJZ3YjbJ+WiW9WVFe45qjZ1iVgdu3Lygk62iPCgSJMLj0UmhV8M0tC1cdqeS/56hymxW9aArklMTB7Ai3wcrXC2SP3hDnRNSqXO+qpB70IfbIK/OfiyqhNU0Q8vVe2QtTJ81nU/mXHlF/VgoB5Sj47SdC2WPp90SYYk6mrkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ys0T4KtDDbZa8sdXc4o5nWjhfTBLx0nvSk40vtW3uM=;
 b=pA/qm3Hd/DCcsAzjLJBdhD8+0usbILbI0ninaYZHC7MH+3bgJDzyau0T5ve0QaixY6un0MRvOn8TnkLwR9u5FE2AKnu3hqTlSzpjtaZwEukmwCQn4iXmDmt7h0wjSFekjOZ9KE1E8CWqhR1Lrccooa1+xbALqpK6DIYXFK8ksneB4iaQQz89dK8N/TT5l2dlI728Qpm7Wd/G4Eqj8xqNFJELLdzNd03ZZcJX831+B3A+CqzEo+pLHpobwjH+pOMi6AIYPK+71edhleU1PyqTcinihO7+000XHhU7vOaToE2AeyqWpp2OW4KzXyJs9q6HWiy3cCodAStkTVXLEFVrRQ==
Received: from DUZPR01CA0280.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::26) by PAWPR07MB9395.eurprd07.prod.outlook.com
 (2603:10a6:102:2e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 08:39:43 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::df) by DUZPR01CA0280.outlook.office365.com
 (2603:10a6:10:4b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 08:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:39:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 43B321C0033;
	Fri, 15 Aug 2025 11:39:41 +0300 (EEST)
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
Subject: [PATCH v15 net-next 02/14] tcp: fast path functions later
Date: Fri, 15 Aug 2025 10:39:18 +0200
Message-Id: <20250815083930.10547-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|PAWPR07MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: ad446132-9bcc-44fb-527b-08dddbd747fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZwR3oxL2g0YytJbkVWMGxadjQxaVl0SEwyMk9ZaUpnZEMzdkhzcmdESjJ2?=
 =?utf-8?B?SXh6eW5LMGhLNWJOTGg1blRJNHRiTmFlZTc4RWt6QVVDMFdSTnlRV0hTeS9z?=
 =?utf-8?B?eXdXaitGc01LSVJYUkRtZ1M1Z1MrMVQ4Z2p2eXBFQW11S21IMHVEYUZacmpP?=
 =?utf-8?B?NHZiQzN5YlZ6cmROUyt5bW9uallhSDg0SkxEMSt6NDllbVg5M05vUmdvR3hl?=
 =?utf-8?B?dkdqSmlNWFZyQUovRzZaRWJRS3Rmc0xJTm5pMm9zaEsxK2dIU1JKSTdhem1C?=
 =?utf-8?B?M0xMUG04b1VtV3lSZEVJeE1qSGhtdDRtaGhraHRnR1FwYmNtbUJycDA3cUJZ?=
 =?utf-8?B?RlBUUlEydjJSamVuUDI1WGJLK3VZNnJqUCthclZnMjIvZndRbXBvRHlsR0pn?=
 =?utf-8?B?U0tQZjRkTDg4NmRmcy8zZmZkZnJ5bVp1Qk5mZDRBdU4xbXg1d05GeHFmTFYx?=
 =?utf-8?B?TlBkQTNqb2RGb1E0b2ZFQjhpVkpQNnRIcGI3dlBSUzFtLzBNdG5pZ2l6WW1H?=
 =?utf-8?B?ME9FYy9vYy9BUXY0QWFCb0FsMStxbXE0TzdvWW1CNEFTU05YdnQ5RUNWQkli?=
 =?utf-8?B?WjNPLzdESThocXRHajRjYnIvand5Ri9malhDU29sREZ4VmR1RzdhVjA2Z0lW?=
 =?utf-8?B?WG1LdmtDQW1kQnhzVWY5Ni9BT2JZTHV1ZERvOFM5NVBFSVBrMEJoZkkrYkNP?=
 =?utf-8?B?THU4cmppeG9RK3hidmVMR2E5T2xOTlFuNFBkZ3R5TGg0cTNIZUtlWE15ZzZV?=
 =?utf-8?B?SnU3Z3FtQWFRSVo5TEplY3JKcnVlM2Z3U3ZuWmJzSVJZM2dwMnpDL0RNdUpP?=
 =?utf-8?B?Q3FZR3NVYUZKZW1uVGg0V3ZtSHNsMnlJN3g5Y0ZwUE56ellyMEpFK2s4TlJh?=
 =?utf-8?B?Yk1DbDVlRUY3YzA3UVFVUVZ5YU9HUldZOG9menBYZVlYRU15b2ZLUjREeEND?=
 =?utf-8?B?TWkwNVRPM2lMTVYzaFFjMWVWdjdva3dneWs3aXcrWlBvaWJtZGpORFR3alF2?=
 =?utf-8?B?YUc4N0Z0aDNuUVNlaHdkTDNoQ1A0RUNNQTR1L0VJUzhtSlBxblFNbFhvbzhT?=
 =?utf-8?B?QjA3UGl4NzdzbDdZTEZzazU1VXF1aXRKUDRxQ0w3RUZNdEdiZ1IvMC9oVGpu?=
 =?utf-8?B?Y0JQZlU2MTdEVzJMYUdDckswaWR2SWVuN2hOWGFvSzBLNXdXNzA1NUVRaU9B?=
 =?utf-8?B?TGNKbWoyZTJXb2xWNVNGSzZyU254SXRySUUvYS94TUQ1cmRQdWVnYzY4OGNm?=
 =?utf-8?B?Z3dOeHZ3dGNWMXFIa2pRRm5Va0VaNE10WmtoUHllekN2WGhEMHJBbjZQdXdB?=
 =?utf-8?B?UkRTbDk0SU9XZzZMc0NZZ3ZicWVFSjIyQ0ltenNlblNva3NORWxJWGV5a1BX?=
 =?utf-8?B?UG44cm93WjE1SVJkeE5XbUFYaHJNQyt1VnVNQnNMbDNjWmZ1K3pFeGZXMTlx?=
 =?utf-8?B?R0llVFVwWWc5ZGJxcnBqZHpNYzkycUd5WmR2TDFxZGJrS2ZHWit4cFczaWsr?=
 =?utf-8?B?bnowUHpFUmtqK2laVFUvZnVlTG1vYnVQeVdSOEdTdUU3ZVl4RFpWRTdETmZF?=
 =?utf-8?B?ZUwzNEVvK2ZPTTRGZ1R0SzV2eTd1ZEUxdUhWL2FkQlEzQmV2V0R6cm9zZGl4?=
 =?utf-8?B?WXE2UUxZQzlGUTU0RTlxT0tVZVZYMXNVc0JrZk9NSTlUZFV0SEQvVDI3M1dJ?=
 =?utf-8?B?L0JyanQrbHErWVhoUmZaU09xYUhqMmZHU3RSaEZrektvSzlLOHUzVDI2djBq?=
 =?utf-8?B?YXBkcWxuaDFJNklDVWdOZ1hwY1hDbVp0S0pKdzBGSGlWYmp4aDJLd2NEbys3?=
 =?utf-8?B?RFYyQjJxYnc1S2x4WlZKalRkRHM4Wk0zeHA4WE8zUkI3NkZndlk1UU1sTlM2?=
 =?utf-8?B?UncwemZ6ZzJEMjVvaU5Lc2lXL09TQXNhNUVXalJzdG51c0pGU3dCcFBzc1dS?=
 =?utf-8?B?dVlILzE3S0FuRHdxdlduamZuYnpieUoxNlZSOTBrcktKLytMZ2hpYkhGKzUr?=
 =?utf-8?B?Z2lHY2VreVhJVkh0OCtwM1VMeVlDSXhyNW1yU2FETFZxNUcrQjZVL2NiaTJV?=
 =?utf-8?B?RzZzWG5ZaG1XVnhGMnRwOU9Kb05RNm5KMEwzQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:39:42.7730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad446132-9bcc-44fb-527b-08dddbd747fa
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9395

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
index 526a26e7a150..515b3b4180ee 100644
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


