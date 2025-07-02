Return-Path: <linux-kselftest+bounces-36256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B2AF09BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B344E480A95
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960C1E521E;
	Wed,  2 Jul 2025 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IIvPSH7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C0E555;
	Wed,  2 Jul 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431052; cv=fail; b=AvKQ1ZliSdOuSaLWFcYu1O5vgBGQYW0SKL9kM4uCp26FxPViNo0GVNaQ2/b91awjVWoclhSOubLagEROm322cqNL6URCNObQxeXYuWVqN0A6ygAjZvO2iNwsDFF6whExOs9y6QG5/zS1wINzc52XTE/Tw5xXxAPGJ88gexgxE+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431052; c=relaxed/simple;
	bh=7+cPXSd5AU3dNSGjhbq/iso2XAFQVgYDQ1h1yFd0n0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8E/phIUK4PFCeQlltJjsUmCHoOQ5l824i3+xxq+3H+e9nKwS/eQe6MmEiUw7VDS1UGAhkLpyTaLm8Xm8iYkJBw6qfoXORMcKJxcvbrAP6imaDwc3bdw6Nb7iU+Mpy+rGcw5wQdPZ7cf6l/LrF8wI4GTk6LlWzcDJkx2/5vaOd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IIvPSH7C; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKqxry7d5eMoT3ow59dcFIFvh7RZUbWt3Awuqje0lROc1SXkFvPpsM6/6aaFbjyKuQqeEYuSyQevUlFOeyy7EAVI6Xaq4n6OuPbVZr/X0wRwLtMN4ATRi41EU2B/2E8cFhPOFDW67nDziDx5LadvZnq/135ScHu/DqrCFzkrx/1WzGxs4cuD7VzfOii3Oql/XSmkzyDvFzt0fMmzSSaDB67pcGCHW5DjWHeiikTIpca62vGSK4HupYIx+VbHSXmAZZx8V9r6+1KWnkoytg+wjE+ZfYchAaNS5Trkag7VTv49fYd45YhuKaNirYx5yFzMUEMWBtoRSxpUWkdPV86BeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEgUyseHjyJjdVQWRi9DcO4lWtfgWcFU6zpNYZhDGng=;
 b=DudmYPFfGrML5nYFvSmmQihS9djq4fKVYYf5/BxyUc5Ol3VAHXkhSEkRa2rxFL5ETf3gE4kmyVYdnbCiTPZJgtTv6ZN9+5FKiXfAhJ3iOpCLYwjIArcygsmJcT79sh9TG5RlQSvCXF0Eqo13mEFGXzCwMJZT09bHp42e+GpwBwB7Xqd6ZeygcVGse6HJRdIEpu/RRJsRk/9pycOC25rQThycMre7vr68tsZRI6mWscvSxe+eAT/qRZWhNUkExz178AgVDuu/CKzncgkRx7/uju84v5QxSNOLp6FbTa94e0KhThbeO0Ox02QmYOFuLQqAGcQ4c80PCGD3X3Er0iZQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEgUyseHjyJjdVQWRi9DcO4lWtfgWcFU6zpNYZhDGng=;
 b=IIvPSH7Cr20xBPuUwki7ZNZ5u8RDIYrIkN2lc8eGgNhgxdc1GjWoBWYlQ460mOhR3ohTkM15b5SnwfXATf2635MSpxHCpNmWw/rOCFLORuWT8cE6wxyarVVogTwshogDCmhvuy0b8MJXLUx2JffbTSyvj8j7/Snfm3HX34gMUzXRYqlVDhlQrZF12Y2pV/6kOA4hqeCwTivs5yIa2LtkoHMW64WWE5HZRJ7c+h0sXNAktXlZ5OFOouwJZyXON4uEFEVvzbQN8fbdUD+HEsg7t5MZqKYk3a+LIXGjIZAka1ooONwOEdrvOc+832nkJeRyKstY2AIXE6QGw5e3ODBtlA==
Received: from DB7PR05CA0055.eurprd05.prod.outlook.com (2603:10a6:10:2e::32)
 by DB9PR07MB9665.eurprd07.prod.outlook.com (2603:10a6:10:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 04:37:26 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::eb) by DB7PR05CA0055.outlook.office365.com
 (2603:10a6:10:2e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Wed, 2 Jul 2025 04:37:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 2675E1C003D;
	Wed,  2 Jul 2025 07:37:25 +0300 (EEST)
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
Subject: [PATCH v10 net-next 02/15] tcp: fast path functions later
Date: Wed,  2 Jul 2025 06:37:06 +0200
Message-Id: <20250702043719.15130-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|DB9PR07MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ffe85e-ec34-48fa-966d-08ddb92225ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUNOUXltR0ZtQ3E1YWk5bGRidnR1ZWNicHdQa0R0YjBoWDBSbHlKMFFtWk1C?=
 =?utf-8?B?T09Wc0ordlMwTUtLQmFDaUlsYW1lMzBxT3FkWVRBWmVrbGc0cnVOb254dzNu?=
 =?utf-8?B?M0VFZVhiditXK2M1cWd6Q3FML1c2VkRQY3JCREttd3lCRnJ6NiszU2l0Mkk1?=
 =?utf-8?B?cnR4V3kwK2U1cjdQWUFINGFxSnVjWEdPVk1YRytsSXVTSldSTmxIVTMrNUtt?=
 =?utf-8?B?OUh5L3phOTdYNEp1SnhjOXFSMFBtWW0wSnEzaTFtc2pkdnVENFZMWm0xMWxT?=
 =?utf-8?B?ZmtzeUp1Z2w1TlFnR1JHQmRvdkRUeGFaRU94M0hLZTNMWXVXUVBtNytiZ2Jn?=
 =?utf-8?B?aHBXYUdkQUVnNHhIMHgwNjJNbGkwNjYxVC91N0RNamJEUmRqaTNIS0ord0FD?=
 =?utf-8?B?QXVWMlgweE1KNXNKN215QlZGbk9XcElOa0NBRW1WdHQ0Wkk2bDdHRUpSSjY0?=
 =?utf-8?B?K0lGNUNiMEk3WnAwKzJJd0Q4WW5SMnNaT1NjZmZORWZmM1hZNGxJYWZtdUJ2?=
 =?utf-8?B?Nk5ZaXA1TDlEL0RRUWpDZFF6eGlya21MNDBpcVRLTTJick5RZkI5TTVYMGhJ?=
 =?utf-8?B?QjV2L1cvNElKWGV1ZHJjWUcvNmdMTHNLbERqc3ZLMVFQekQrUXA4TmdzMllU?=
 =?utf-8?B?Nk01S2RZc2JndExGMWppUTVYTkFKZ0FZcTk2MS9wdVRoQXR6VXhDT3FsNGNi?=
 =?utf-8?B?YWQ0TVJzb0N1aURUaFoyU0dyd2hic0VrMTd3YlYyQXB3N0JQY25qVkpRSjlj?=
 =?utf-8?B?c2hEaEJuR1JFeUFtZGhaU1dLdVZJbmZWMmZER1hONnpxZW9RZUcrSEZmdHFv?=
 =?utf-8?B?cE5RN1ZJRWwyeXdJV3F1QWtMTXBQSWY1SXQ4YVZZend0T3VEenZPVWxVOGZS?=
 =?utf-8?B?Yk9WQmZjNjBxcmcvSU5GdWlLOXVKeXQrbnhrcjVGK3pwTU1KK2VXSXZyVXho?=
 =?utf-8?B?Y1lTcTJGLzhyVmt1RmIzb2FaVlNyUlkxUzQvTFkxakN3N25NOXVzcmQzTTN1?=
 =?utf-8?B?UTk1d3hvZkZBd3Z0VndPa3FMQTJkQ3dIOWFqQ1h3N1o3dWJ0SHBZVkEvSnBC?=
 =?utf-8?B?MEUySUN2VTZHT1NDZjU5dDBBUXFJQytmTzdWTllHNzIwZUFURU54UGk0R0FC?=
 =?utf-8?B?YTRBd1ZtTmd5c1hzbE9salo0U3Zxbnc2VldDNlI0Q3E0MjVzVTVDejVFdVRG?=
 =?utf-8?B?aU9oNXF0ZnpBM0ZBczhBYThRWE54YkNPSzhWQlVrM3M2Z0pMTWRjWE44MVNY?=
 =?utf-8?B?YnNnZmFwVmlDMnl6U01DSWFRTmd1SHZCTFJWVnppcFQ0alBKVFBTSkRjQ3ZE?=
 =?utf-8?B?RU5iVlNtaExvdTVnSUpDYnlJc0FFWm1SYWRVTy82dmticHFYaEZFelhHY0la?=
 =?utf-8?B?amt2NURYUS9NQTFidUQ5K1lZQ0VJN1dtc2ZLR1dBTVN0RTV4S1JDbW1MWDVF?=
 =?utf-8?B?Q1pOZ3NCK1NkdVN5cjhNR2hLbUlFZ2FybURtQTlLYkRMdEJzSGlrV0hwUkM3?=
 =?utf-8?B?RkFqZnYrbCtleHRxV2FrTmcwNm9OWU5RZ2RHNzNiRnhWTFZUVTg0ODh2anJt?=
 =?utf-8?B?Y3BxOXBiMWhvamZ1S3A2VEJkb1RlNTNWcTlCS3dHUGkzWHdpeWpILzFVY2VP?=
 =?utf-8?B?TlF3dzQrVzdwVFJBRStOT1I1RUtYOEhyYU56ZDlxVHA1cUIvenRxNVJ1SFNu?=
 =?utf-8?B?dXo5YkpTKys0MHdXZUkxdzdSaUpTQmVCMnhuY2ZTNVRFRHE1QmpjV3BkVDYx?=
 =?utf-8?B?S0N6MVlSeHBVOGoyeTFPSldsbllsWU4zWjN3dDkyTnpmRUtkMTVlWThMYWp0?=
 =?utf-8?B?TXd1d1dGR2dXZDV3TTBOYzJ2VUFlS2JyUjdPODc2ZmZYT3RmQmh3Tktwb3pQ?=
 =?utf-8?B?SkRSVUtja2dZQ2VodHJ3VWgwS0ptaExUdi9zU2pqMWJiK2wvd1FkazRVT1hW?=
 =?utf-8?B?MWVKT1hBbGpqRU1DV1pFMWdYRTJrVVg2aGdEeXlVb0w0WjZoSy9rK0Nzek4z?=
 =?utf-8?B?Q2JUVmpGc1NTb3h5VHJQUEx2alFKMFNsb0NWM0dKNXhodFZyMXJneFFIbXpO?=
 =?utf-8?B?Z3ZLMDZQZ1NXVkQzT25XSldZeGNBbVlTd3oyZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:26.6890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ffe85e-ec34-48fa-966d-08ddb92225ae
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9665

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
index 761c4a0ad386..ed01ae4be7a9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -812,33 +812,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
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
@@ -1798,6 +1771,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
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


