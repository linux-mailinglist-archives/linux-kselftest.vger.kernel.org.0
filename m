Return-Path: <linux-kselftest+bounces-37815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E09B0D68B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA521C26DE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF52E2EF2;
	Tue, 22 Jul 2025 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aDTZe1lS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8342E1722;
	Tue, 22 Jul 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178385; cv=fail; b=eD7FdRMZ8boBaqg9CnhzX+pbdD6ifzciKPdbzHEDjsiwptlG5F6TnOZVd6NbX6ayQkgJGTgHDBTFAnnMTB8Th/5tmuuv10m6p8qXWFfRC2rf5WyW0gLdOG7cxUGqFQmDOkp8SzU7DI62s8InkEIufGyfwz4Spe3yhwcWM57EaLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178385; c=relaxed/simple;
	bh=FRfTkPcx/9GQej72+HhIIyLX/4VhLQlklyYzXEs5rbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aosa/WL3/m7yJMyS65A7tSidxupOj6ma5qM9kQzzpuSB+V2NrxVWtHFrxuu8SKdAl1Qg8+I/igYKXZwd2u+qYuTBSyfBcqKpSO0Mp9FZGYXGmC8UgW0XAv3UGb2lD1N7SutAAdtGUVpiZmAXXQImfR7XierfdhM+bTdzormsYf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aDTZe1lS; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWhbeGlhqPqmmBj5pfNmErJ5Hk/GXOIw7LHviOhuUBQM0unIH7sKNmdy+p0mcwmd2sVSgJCvgtPrq4kcirdjfo5+61RUHXZlzkb17AI5JsNY/NVRGhet/X3riITPm1tlF1ISHSxpvtnKYTAIYqbKqmBvJsLUuYbNZ1O7kEgxjxRFMrlBqj/9jw3HeONmFdaWh0O4DADcDAqTw5AU7RQzKCRLEzu4wmR0I68Un8suUVLMb0Hha+aDjkFFMMumKTQLbTVi7D4h7FjbTcbLp81A1Ti0QoTgP+ybIWkH6VteL0zcBfj466hp9kHkbfyTxoku5NonJyJaOu+blP3MLiNDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l7Xhxk6hpodM+efxRiRoaAEw2Q/15alsbC/qjp5jSs=;
 b=zT7UXfVWpIZIf25mSg/eEVLGrkxuZaN6p1kh9pTDt2qDUapp7MSp82yRo9MJ0mnnPtABX8+RQ4Jl/qDSHYC8HPgooZtxzV0Vu8KUjLSP/Q+bZw0HwU5k3KNoUs0lRruK8EZxAJMqACQSbQUCta5IlSy6WtTZDQrfZSt4rXW1vwVB/q9H8Xrk83JiadFBBy8zn03859ErOBF5WoFeqLytj+a5mCUeTTPJjdxIH72OaD0fXz009A75gqjAEsQdiHS3bbPWJGC5QWseugzMWrqxZjsuf6tRftgN4sf22lg1HeqxWtFzOyZWTLPGwZNOnii0+Ntrsc9cwDjOzg8A4mYnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l7Xhxk6hpodM+efxRiRoaAEw2Q/15alsbC/qjp5jSs=;
 b=aDTZe1lSueXHKpODVyRXO8qnaqhgWWrmkOMi0LZfKNUxdJO+zSJ8mGGQY79jLfNb23gRasNNabHfyq2hUvv9izVmZYHflDUYZCnBF2AMK/uBIqXGd03PuAiZHVRCytB/eh/NlCcq81wP2Kvfs9PSuq8MKN54JEOiaN53tttqC0sRmbBw6S9ArOmzk9N1MtiDw4vmaepmpjAU7Qf1KsxXx6aALLr+ZBp9F4/vRBEkEV31VIVbSYMGXzwm7audeN7bdi9i9gfAzlxsVrb0b266wsfrLM68oZLZpHfqjIv3ECoPW2NQzzGJRTJhLlF4lYJzQUvg/RiuoRjCkSXdl36ObA==
Received: from DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) by VI1PR07MB10066.eurprd07.prod.outlook.com
 (2603:10a6:800:1e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 09:59:38 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::66) by DUZPR01CA0016.outlook.office365.com
 (2603:10a6:10:46b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 10:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 8B213680042;
	Tue, 22 Jul 2025 12:59:36 +0300 (EEST)
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
Subject: [PATCH v14 net-next 02/14] tcp: fast path functions later
Date: Tue, 22 Jul 2025 11:59:19 +0200
Message-Id: <20250722095931.24510-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|VI1PR07MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: ab96a2e4-68b2-4d3a-6407-08ddc9067856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REVPZ1Y3WW0yckJSYTlVMStLM0w5VXNwZWRsT0F4TzNScmdDQUJCeVhvV0ZY?=
 =?utf-8?B?WUJIZlF3UTgwWDM0TWdPUjd4Yi9zZ0hpTFIvczY3QXIxSFVFSUlnTmJISmpC?=
 =?utf-8?B?ckFaTUExQTBldDF0RVJ6ZzhKL0E2emRPSXNxbkd5N05wY3E5SlpkQzhkYTZh?=
 =?utf-8?B?V1BXN01KQlA0US9UZWROR0g2dFRIYXE2RWJ2Q283ZENCVVVER1lKRlMyZEdp?=
 =?utf-8?B?RDBFbHFkRFljUktNR0Z4U0xxZ3ZWMFJEbHhLQTVzWno5eDEwdGttWnNRa2po?=
 =?utf-8?B?cXBIOTM2OHgzak9mbUFUNzlreVdTSTF5UVg4TGNRR2p6NXRJbCtOTDk5N3VN?=
 =?utf-8?B?S1QvMHlIbFNrWGVGV0xIZUVtdTJvZGJ6bUZzalpITjg5Nnh2L2IwVUdZN2E0?=
 =?utf-8?B?M01ZWlQ0R1pBYUhOWHZGa012NWRTZDJGTVc3VXorcVFUUWJTS1MvV2hFU0N2?=
 =?utf-8?B?cTA1cklsajJGNVNDQVNCb3RFRWh6NWZnY3p4TUtSL3dyN0JPRStKcktYZVFQ?=
 =?utf-8?B?Tnk3RWQraDdLZkN4TnZic0taT3JMd2JCS3NzNUdtMCtRREw4MjBZeEp3VStF?=
 =?utf-8?B?VHZwemFiQzYvYnJ5RkZqaDlqY2crRmFQTHRIM3U4M3dpOTRjMlBGTDArS0tI?=
 =?utf-8?B?ODNEeEhsenIxZDFRVDdxckZKTDJIY3p3aEhaZEVKc0pSOFVNNXU4YUg0QVFz?=
 =?utf-8?B?b01KT01TWGRzejdiUk93UTRONHBML3JWalV4SzFPYXMrSHU4d3AxWmxjWFho?=
 =?utf-8?B?SzMyK2VVaEZRWWJlRVhlWlJvRDRwYkJGS1I2RVF3bnlZbVFZYjRSbGRKbDF1?=
 =?utf-8?B?bEhjWHFvT3loMDFvTjhNVHNUYUdpbnF5UDR3bFNTeFBZa1JFeGsvL0xIcWZS?=
 =?utf-8?B?cFVndy9QeE9tS1F2SHUybFRlWEM0WVNIRHNaVzlCaXg4TkxlSXpqdDRtemdN?=
 =?utf-8?B?ZExVRXZJQzVQSi9QaXZOS0RNUGduLzFGMEpWWXorc3FSbzFFMnVVQ2lTUFpD?=
 =?utf-8?B?ZVR1cFY4b3Y4dVd4UzNYNVNwdWhUZW5qdjNTaEx5L3JWRy91dW1qWUhKbWlR?=
 =?utf-8?B?M0hBMzdTek5DeE5PcHdBTFk3MmZWbDVPTDlkWXRvY3YvVjdqY3ZJRFdZSXdL?=
 =?utf-8?B?OFU4dUZoODEvNmtDR0lpYlRCZ2kydVZKcWtkZk9GeHJUL2pEbWY5Q3FMTXFh?=
 =?utf-8?B?OFpvc0ZZTk9EY3R3NVFSdEFINE00Qm1IcHE2T0ZDamN5MkJDdTR0bGliZXVX?=
 =?utf-8?B?T3ZWeElqaEhLMkFZTUhIY0NDMzFyZWpIV1ZGSWV1dWdxWEVTTU1LTzZkUHVz?=
 =?utf-8?B?cUl5M0E5MG1tdXFDREJQQmdnYVFDSVVneXQ4MGxjNlVQaEExSjYvMUltU3JW?=
 =?utf-8?B?ZnJnZmJqcFpDanRUZUVaR0xHUXo5RnJVSUVNU3BkNG8wYXZmbG5NUldaeHZ0?=
 =?utf-8?B?NWNpc0hLdmhPcXo4cTBONTFyRTVGMWU5OGVja3NlSG5MNFZHSkRsL3g4S2hu?=
 =?utf-8?B?b3FtN2xJMTZzOXpEeVRHd05mOFpNQW5VcGhHVFVHUEprY1dQZ3Z1RHBoelR1?=
 =?utf-8?B?TVBaS0hJMGI4ZEIyVW5SZVU3TTBGNjJ0cEdaSDBjT3lRTVF0RUR0M1BjeHJZ?=
 =?utf-8?B?ellNdHRrMG9OaGF4eHYyVHhSMTQvMW5wQTFDc2lSSjRaQUc3Uk9ZTHVmS2dx?=
 =?utf-8?B?UW5oNXJuQnRLcDdRT1NrbG1GWWJGQjhsYk9sZjYrcmw4WkxSTHV4elhocUpJ?=
 =?utf-8?B?WUFVTC83dnE5OW9Hcm0rZ1lwMWdmV2ltbXhNdGdSRk5Ub2NOSjMvdVNyYXVt?=
 =?utf-8?B?TllWd1NkOTlGWmNkTmxiUG5OQXVuYjhjaGwwNjBNQTV6dW04Y3BnSk93bVRu?=
 =?utf-8?B?dmpTTFVxazFzTHJZampjRXN3Qm5WSjRVYzVVbk1lM24vYkUyTzdiV2FjQkZv?=
 =?utf-8?B?ZXpjemppR3ZYNEREYWYyS3FiUFY1bld5SUNlN1d5RHR6ZlQzWEV2dlllemFw?=
 =?utf-8?B?YVhUdjhUV3VyQnBwY2YvZFdLMFVOTHEvK0c0Slp0N0lSaTNvNXN4Qk9uMmJr?=
 =?utf-8?B?Mzc2aEZUMEl4SnREUlBoSm8vK1hKeFJ2Z0JaUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:38.1379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab96a2e4-68b2-4d3a-6407-08ddc9067856
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10066

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
index b3815d104340..1323a4859e99 100644
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


