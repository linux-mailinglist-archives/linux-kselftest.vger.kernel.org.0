Return-Path: <linux-kselftest+bounces-31311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14707A97140
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA513BA60F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1828F53B;
	Tue, 22 Apr 2025 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kf2viTy+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3219F42F;
	Tue, 22 Apr 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336310; cv=fail; b=oo60q/Tj3x/cP69g+v2/Y3aP9iqJSl6nTNkXyO7t4yX1DVbZdqr/HXxHWtFpePkswqOdvlXTFEfy0pfSbXCeCCfNGlRC2CEJ/AEfoslLTGfTC8LpZdA4XjVTBHkbrgXEszfc4P9wD2Ar+zQpdSLdxqSMo1G7SXwRVlcpjZFTtrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336310; c=relaxed/simple;
	bh=jzGjlVHTjyWEGx0OxJrvgDWNiNQ6gwMZm/yT5kX2loA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcpdgyHX7Uxl1M2AvVyaPNq9GLQBZs+pkT4uDH+67w1wFVzQDc2AMPzMsFY4qp+4EKJmlI6waqydlD2HTZ9AcTvTYuGNn1nRQ7GoHAX1YVosVsEv4RKG1i8UTylawCV0Oc+rGlXgQIii7PYZAGcW33zI9iAqk7PyDr6XYJ46mLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kf2viTy+; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0sjPj5uRVMPQ5U9lhTBimg6dt6BXDYu7aMYx56/7GZXu51up7aTY/XK31A9LiBZWxZx3I8z9ZdW5StwGzOGGkNTn9S91+SHx6qNL8C36fhyYxYgsAKOKmqn/KO0u9rORN0c+2BG5ZHdmaMGnUPh493Tt/RWbKiMMghXhO0Vo6ZLydx/Rkw+AC/gtqMbnAmf6oKhBtZDpfiss6qYgNU3KkMBri6s5169Z0AuB5KtMSrgM+d/SpB2rvA4zGmUfj2xhWsevVmKzlwTUkxvvGRzScsD4ODp998/fWfmTqioUih25mCISHzJHWJy8CZV2kQOxevmvvJKPxYUmJt0cdorKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=utn/cujIvBb8dIVPxj2+OtJ8dw4GZrxs3hOCeHTlDNG9l9rhAqTmzyGIdGype6GOdK44EonzqnELv98Ww8HS/Uhs6kSItcDE9ei2pLkh+2D854isZ6uYdHy73kyl9w/1QPGMhFPhGxiy/Tt3de9E4uS79vAvcwqYBQkaDDuBXrmxyfz9/6fE0N4+v6y2Ul910/iwhKAv4GzxCRlm7CDc0+ftQuKIYk9ywgNyumN9OFEFdAFS6uSmy67gz9XebRlZS1ILcJblQqficeKmW7UKZQi0wqR0dYxEmS3llQsamRgsfe5NWsdaS5MVO7RR/HY+Ykr70UdipKHJwV6aP9QoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=kf2viTy+WwRhjL3bpIbcpaoXj4Ev3lB7QsS6fNAt+434LiD1SFlWujth/3WSYwp6LkBvKiKjrQO35tZHh9/HJfE5TF7dGJvV+S6YnjW5F9ptUBb4/G/fuQ9OlDxb1huZk0BYiXsUHieDwFcn8+yUx4YYnBIb5l4R/B9/w5dY3X3Mkt+5omomUYPclqoJIkd5NKyJ7twMGd6otBbyc/8ZRNMFTpXO/69eBJRPsXq1DR0sCbH9s42CQXPtmguGMBYvPPFMhFai7UkiVW8rntiW/eJCCA/pKL0SdUWoTFsL3uWEsIyz7+DDt4TITM+qaOtwlY4LGe+HWDY4hm/2g6LExA==
Received: from CWLP265CA0309.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::33)
 by AM8PR07MB7650.eurprd07.prod.outlook.com (2603:10a6:20b:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 15:38:24 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:401:5d:cafe::67) by CWLP265CA0309.outlook.office365.com
 (2603:10a6:401:5d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 15:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.1
 via Frontend Transport; Tue, 22 Apr 2025 15:38:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id EE57220A2B;
	Tue, 22 Apr 2025 18:38:21 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v5 net-next 02/15] tcp: fast path functions later
Date: Tue, 22 Apr 2025 17:35:49 +0200
Message-Id: <20250422153602.54787-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|AM8PR07MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 87937191-4977-46e2-dda2-08dd81b3b783
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UXh3djZTY0YxSEY4aUZRU1k5MHNENjZSdjRNR1FhekIrSjI2SE9QbFY1MUFs?=
 =?utf-8?B?SE0zK2VmZ1JBb2IycFZzUHdZeUw0UlRaaFNBcnFJWmNHUHo4RjUyd1ZqNnF6?=
 =?utf-8?B?b1pDaVRNMmtyUEZVbW1PUGM3RExVL2tUVmhVRHlmN09hU1dZelM2RWlndkR2?=
 =?utf-8?B?T0g4VlUwbXg5S2ZLOTRGUm8vWjZtNGtIZ2VHQm1ZL0tjSXdXMGVYQklTSmdL?=
 =?utf-8?B?a25BdnRETzJzMm56dFV2VThQVnFIdHVSbGxrYWRxZVUvR3R4ZzUvUGgzWlF0?=
 =?utf-8?B?YmxqQi80clZZcjNFczByVkdnQ2VVQjBUM282NXBVUk9mNDhLQzJTMWx5VE1w?=
 =?utf-8?B?Q1VkcnVRSG1IaWdDUk84ZVJpNk53d1hRQVA0eXRpQVI0OFVxOXhYWnBQTkpI?=
 =?utf-8?B?eXk1Ukw2b2hYTHpFQUh4K3B2aVVNSGRsSTExZHVxd3Exck5ZU29LOWpOSUJO?=
 =?utf-8?B?cFRyUmtBNHEybkpCNDVxTGlQdzZ5enBuN3BMaGtuSDhLcG8xaVo0c2JCTmho?=
 =?utf-8?B?NDkvNHJhaHBLL0FiSWYyOUpMV3FaQlJSay9vVjJheTZYaHRMb1l2ZXk1MkRz?=
 =?utf-8?B?VERlWERFaUdmV3NzY09PeE1JQVFyTnhQSlZVQkkyR0VWUXhPVGZiTHFVeUFE?=
 =?utf-8?B?YmJxT0lqLzRQVUpuTGcyVVY5aWl2S0V1V2dZU2d3WC9KV3BzcUFlTUgwQ09t?=
 =?utf-8?B?ay96bzBOS3ROM0lucEVTanVadWdMQmFWQ2Z6ZEpZZXRoUUh4YlBVZUdsbUdL?=
 =?utf-8?B?d3RMc3JWWWZJWHdhenpZbWtxdTl0clB6bFhiNEFTTU9sQy9PclczaG9hTWVk?=
 =?utf-8?B?U05ndGMyUGZKRHFOd2o1c0c5TGRsR1ppejlCVFAydHhJcTBCRHVaZm1jM3JP?=
 =?utf-8?B?Tk1zQ2dlSi9WNldvdVFsMjRpSTZTU1ArMkJOMDFNT2RSdEs5TUpRUis5QSsv?=
 =?utf-8?B?ZERRTklScTlRV0krRitKRXRuNkpCa1RuZWJWSm5jdURyZTJ2ZHJiVktaakJQ?=
 =?utf-8?B?N2gwbkJEWmpWeVVRcnZXZzNpOFp3ZzZYaDBmS3IzeUY3N0QvVWNIRHU5cUNj?=
 =?utf-8?B?R0V0SVZoaDlnSjRTLzlZQW1GMnhpWG12ZDliSStEN1JTeGNsTm5NOGE0SDBh?=
 =?utf-8?B?cVpJQWJTdVB4OXdlNlduM2pvQzJPQnBoZW5mbldDMml1d1cwYi9vZGZicXdK?=
 =?utf-8?B?bVBKa29ZRUpQNXY4UENESXQvbVJFcGo0Zm1zcVFLdm1oK3NFa0xvVjlYL2ZM?=
 =?utf-8?B?K0huMmxiVk5TVUwzdEM2clFFNVAzV2xoNXJIbm9iM20yZ1ZUNENUTitvak9X?=
 =?utf-8?B?QWNVQ0tSakE0Z2tqZTZvWWNIRGtDZGRwRnJNQitnbG5TdjBuUjErMW1YWjBP?=
 =?utf-8?B?TTMvN1ozcEkwNEpmdXpUdWtYZUlRTkdteFFmR2tRbGRRUG1jbWtFdW8rNHpL?=
 =?utf-8?B?VDdPeCt0aGlrem5vQk5JRVBXNE8rS3B2SWp5WDNmWGVNQkk0Y0hyMWgvWjhT?=
 =?utf-8?B?bmdOZG9MeUlYcjdzS213VmV4Y1J2aTFVNTk0Q1FNaUtLNGVmQzF1c0ZBWW94?=
 =?utf-8?B?bGQ0aWk5TGxGNmFESXhzMDFvVnVTY2RVVmF2QndjcmNwZEpHUGNLd2hhSFA0?=
 =?utf-8?B?aGwvTlVvMEdySFVrSkloU3RRQlhKVWsrbzlPQXdESXdYczJETVdTK05ZOXIy?=
 =?utf-8?B?VWVOWm80OS8xVnFnczMvaUtTUWFpZGdHM0N5QUdGOTdBOHNHdEd5dVZIZzNl?=
 =?utf-8?B?SG03UGZYcW1YNnkxM0lRSW5DdlhSTkx4RklFd2pFaGNjTGFBWVhkQkkvTXZT?=
 =?utf-8?B?cElNcmk0YTVHamdFclJVdzZ4RVhhSGZoMHNHbTZpYytQd2RaZEFiQmMvQVhq?=
 =?utf-8?B?R2VvdmVmZ2JmOVFydE13K0lmRVNDMXFsVmtOblY3ZmRyR3M2SVIxYVRwaEJp?=
 =?utf-8?B?UHdva092NUJNajk0emVSdXZNbkZ0YW5YVVZKZWlzQ3hCSG5jdzRQSTZ1dVV0?=
 =?utf-8?B?OUdwRXgvcmZzaFV4bXBzK2QyM2c4ek44bndhYlk3NWRKcGhkanhuRDNhQ0JD?=
 =?utf-8?B?eFRnRG9VdnFDM05nNElrbG55Tm9wVStvNFV6UT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:23.3995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87937191-4977-46e2-dda2-08dd81b3b783
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7650

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


