Return-Path: <linux-kselftest+bounces-30707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B4A881B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CE23A905E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277CB23D281;
	Mon, 14 Apr 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="R9Gbqz1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222A2E62B9;
	Mon, 14 Apr 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636803; cv=fail; b=H8XHv+QJLRwb0ZninndS3GdCaAzsYPUAlw8AsiRaN+cmgfJMTlniAtkuSNevvU9Fg9hVAf9vISi6Gn8xTxfekB3nZrtn4cbMWgQppmzSlyoT2InzOmy2HJoPNpeQY7DdPysfZqDZb3AV9V6JtqJeFwxBVrZye9Mgwtoc/w4U+o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636803; c=relaxed/simple;
	bh=jzGjlVHTjyWEGx0OxJrvgDWNiNQ6gwMZm/yT5kX2loA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJgFHNyAh2LJlI39xhbP1qp7ML/+A6v4PaFMLkiareFXTgFp/6qXhl+Fn2dI1xXnmdy2+NDLBk3F/636LUe+j8W3zILjbiiAH7+5AqwEiBHuqD6VHba6Uk0y2MJ7O/ZMVtBnfngBrHtdANpwTS6x3W562l0iAoZSG04lVGnV1B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=R9Gbqz1p; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUgg3D/myn+alDPUaFu0v6v9pd86yMzak+kx61bu1/5iK83Y7TNNwPqmdjQTIer4hDxthaFApjs9JvgGmWun+p0imkVAuYgaM+0iLzWzuv19Gd3TqxMrWBwEmTQTyN5x0uI7kJberAtcjXKV/Mle+460odKqMkuZUouGegBn9Fu25agXdC4KxgeYv3NHXnEIKuteKmp9ukKylwy+pc9jd2utWZRQ0YjMPyMQuWeLJ/f5i/HOcLBw9JdAaK2Uv5bK58LrTIDbU4bn8TRoQv6eQ6Ai6j3GGvzBmvkQ+LfWQvIwgkPA1Jy5hBrnuUHIPqn41QydgEViygk0zdRcj77yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=qWvoeFl3pOzDu77b2fyBbrSYMzrlPjal1YYxkrRyeD0Gd++LkUrVlSxAXsbk+uzZweo6uPJFWj4Pb3Bo4I7qqDWWvRm8DBnkf6VYJpFd6ZGOIcXaR2VoS//QUtHmH2yPpMCnfyi3PzsiuN+qkMoERTJbnhgX8b5pyhrGHmT8dp6pNAsrzpqcjhDv+51hjUsI9EtLXKB0cb8gK7QaDzRVEeQ6wA8XiwzoWFedgm5tQh9ahBjTNWcM87AEiZW19aQ1SOIj+TRuI1nWEUNpN5jYos1Z3+us9830CdG0saUm58aRXwXepwO1WWR6Wqw76umb9O/go6p6FZZjAO/TVJLIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=R9Gbqz1ptEgNScOGaUtx5jJIdPfA23DcC+KzL8C9fJooVNkX0jc81FiBMl3DGB4nh6+v14vSxW4Pg1/d3l7OuDvjo0eIISKL9T7+iDo41icTGa8tnQuyjoba4l57jr/WsHs6Edu464xQnx6SA1iKeh7kw3BIYe9RdDpvHU7QE5xt5asDBM74Hm+NqO0AZdT8alY9u24w5QEvDkdst1wv0rn/oo1W/tjbmkxtAH99weEzB/a/V3YZKqZ+hcws9FIg4hAiUQiBg+SHG2w6qd65E7zNTed0hE7Cb2wYuTcC3FdRvV4rbOzjvTqL0Fcclqo3+kMqy18Tj2fBY5rW18Ndmg==
Received: from AS4P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::27)
 by DB9PR07MB9835.eurprd07.prod.outlook.com (2603:10a6:10:4c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:19:53 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::e8) by AS4P191CA0034.outlook.office365.com
 (2603:10a6:20b:657::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Mon, 14 Apr 2025 13:19:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 8A1FF4EE61;
	Mon, 14 Apr 2025 16:00:07 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
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
Cc: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 02/15] tcp: fast path functions later
Date: Mon, 14 Apr 2025 14:59:31 +0200
Message-Id: <20250414125944.97350-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004A:EE_|DB9PR07MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dbf8f6-69d0-447f-785f-08dd7b570b0c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WW9SR2hOVkZLVVFma2QwS2V0UW9YcjZFZDkweWtxUEZFaUhRR2x5U1g5aDla?=
 =?utf-8?B?M0pUaDZ1ZlB0R1NqSVNMN0QwTnk1U0NwNEtVMUJjVjZqTWp0bEFyZ243RTdq?=
 =?utf-8?B?QVd0aU01dVZvelRHcWpuOVFnNENTRzVUK09zNnFjdmpFNjdlYU8zT1BIZHlS?=
 =?utf-8?B?S1Q2NjVHMzZjUThwbmhhWXhXWjZOSGFPcHU0dzRVQ1pJTmFxMUdZOE9mNnFO?=
 =?utf-8?B?d0dSbUlrQUYwK1NOR3cvT0JoaCtrUE1rR0dBNDdRTmVwdHVsZDAvdXg2MHRJ?=
 =?utf-8?B?dlhYV2lDbmcxZWxIZ0ZMeCtHck15eUUrenRpYzdxMXFMY2VlVWs0VWN3T3g1?=
 =?utf-8?B?WUNvOWFtYmQ3Ym1DQ1RhVXFVUERwOVJQR01XbWI5UTdFOWdEdW0yRmN3OTJK?=
 =?utf-8?B?c0JHQitka0xhbW9nOUZGS0tKSStvbGdBUDlnUUJTVFc2c051dTI1Vjhvcmdq?=
 =?utf-8?B?Y0s4MUFIbTh6WXgwalZPYWxrN1FNb2xvN2U1REtYdHpEeWdibm9obCsxWjkz?=
 =?utf-8?B?N0hlS2NZUFYyNUFmNWR5MHFnVE9vUUtEMXZYanNES0lsUUN6NXZkVlRjcnIr?=
 =?utf-8?B?azZRRm9CNGw5cU5GT3FMa0JEd2wwdEI2SWg2Lytib3crTS9LcDFUUGpYYlhC?=
 =?utf-8?B?TUFTM2ZLWmNXaGpqdktiTDRJbHJCZlNielZ4dGlsS2szL0lQd2pmSHZaL002?=
 =?utf-8?B?bXdkQ01Od1RvRUQ2K0ZMMkxKczBlMUxSbDdHdU8vTEh1dGhzaDR4ZEI0K0l6?=
 =?utf-8?B?d1A5NW81TTNrWWQ5ckFDMk9pbVlYRHpiNU5jVjhDMHBoYlc5NTZnVWdTLzZD?=
 =?utf-8?B?c2p1SkVFK1RkblhrRzVIajN6bDlEaXhZbE02bkRyZWpLejZ4d3BGeTY2RHVZ?=
 =?utf-8?B?SHhVNEFBMkpQc0V6blhMazdFU3Npb3psaGVNb0RYWTkrYTNhV0FkeFo3dEYy?=
 =?utf-8?B?RnRwTlZzTmFLd0Nhei8xcVBGVzFPd1pSL2RUUUFvWWVmd083amQ2WUpmRzZl?=
 =?utf-8?B?eVpqZUUrUGxwRXN6OUoyMElHRS9CQzg3SXIrcXdmczFtVUQ1aVJ1dk5jVnFO?=
 =?utf-8?B?T1ZpR2ZWQnZKNk1TZ0x6WjFVaytYRDd0QVFMYVRaVnhwTVp5anB5N3ovbWRU?=
 =?utf-8?B?TVIybU9SMmxmcVdXRzI3Ym9pZHkvUy94ejR2RE1JOFNKWWlncnBmVWp5SU56?=
 =?utf-8?B?T2FDV1NBdXRRSDhiSVNrSTVYZ0hEditOenpnejJjeGVOTFI0aG9uNjJKUHcr?=
 =?utf-8?B?dWw2S3BlQ1pzL1BzQ1E0Ni9oY29tZVMxYWc1eGtUeTVXNXd0VnErTGJsS1Av?=
 =?utf-8?B?VGlPZVE3aGJMcTNJemFTMFl4QVFGYnRuZVFtSTJ3R2ZWN2VhUk02emN6WmpD?=
 =?utf-8?B?N2JaNWNYd1pJSHRnRjdiVE9aRGFkVGswck5pQ2E5c1UzUGxLL0pPSXB2MFpW?=
 =?utf-8?B?VVcyN0g4a2U2bmFmeGxwR0tJdUJ4RVdDcDlMQXdBd0srSHBsNUFYZGdVSk01?=
 =?utf-8?B?Z2xPMTRDbS9RbkxMYjRLVDh4YmVpekRvMzBvNjVpWENDd0E2S290R0F1UFQz?=
 =?utf-8?B?cUJGSWVqbTFmbHB5VzhnWFN0TWN2N05UcGphc1BVTytwSFVlTGNZeHdjYXBS?=
 =?utf-8?B?TGdleCs3VVVZOGtFVTJsV0VUY0RDUmhVbW9HTDRDcFlYUDk0NWhBd3M3WXdR?=
 =?utf-8?B?MTZCMW5MV1hta0Q1VmY5K01zNFU3Ti9FUGc3ZlREM01MVlhIWHpDMnYzeEc1?=
 =?utf-8?B?MkpobHlQdnY2dnJnbkpJRFp2ZmloNjVOUHJCQlRjLzNTN0VWeUNtbnExY0xY?=
 =?utf-8?B?ejRkdmJsRGdGRnhhSEtSazFucm5odEQydUhZNkxtbEFiemxlS05WMkhxQkVr?=
 =?utf-8?B?eUR4TUJsZHZkeG82aytCckh3bDVxNGpnTmJsMGc1OVlxN3NBbFdDYXVNTERG?=
 =?utf-8?B?dGFoR0JQS1BuQTdGbGx1dmprNUJncEVvcmRHc1pZeU14OHVBQUVkSG1PdERG?=
 =?utf-8?B?aElsd0VPQm1yZ0JxTC9ReGg5bmQ2Uk5EYnRDYVpWVVBWbkV4cmRIVit6QnQr?=
 =?utf-8?B?L0pYNHNDaXlUdFpqUkhMM095QjNGSStKdEx2dz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:19:53.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dbf8f6-69d0-447f-785f-08dd7b570b0c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9835

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5078ad868fee..4dacd4a11669 100644
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


