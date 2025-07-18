Return-Path: <linux-kselftest+bounces-37567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE59B0A619
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74471C81541
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94F2DCC08;
	Fri, 18 Jul 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GE3syJfc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B832DAFDD;
	Fri, 18 Jul 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848456; cv=fail; b=j1S0nCFY1JJB5aZiqwi/Po0VDX2nWa+97mPjOhiF7bW6WsWKvDiCiA1DJ3QOvRIYVILfmYa0SdBQlAnETmEsw+KgYXlw7qRrfWYXHt1nZgZIn1H786J2qDTuzkvz2e1bkEvN69QvhhwLcXXJryMq188O31hhKuXlZqDtzLxCpZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848456; c=relaxed/simple;
	bh=hgg1HMuKo2okA7YoJWXqB3c3Ec5KCuLARxUTMC3Ad6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DX32WAgtZdYHYW2rtn7LcUJAeCrZQvuFtOoEuW0omZKwi+AJT2sj77bn+L6M0V+m80AAYZlKnFTyT5dkogBIZv6Ht/LfIIaiWyZk9powHvl/VjthvxS3wlyBWmNxQjnOwKtNnf3UpngMr6tcLmU245/aMUvRk5b3Nqh8RCFTRaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GE3syJfc; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMrQmeyVRiyD0gwqhBjCLHgp8FR6CLYUvaWiRTDStsIn6lkV45uEfHInOr/fpRD+wXZ242XS3lUqUSSNfnoNpPJzO1Z8zA02TnZ5jP6CUbEGerUHIjkW2xDprIqOsixWZaiiCylI5+hvIoS80OJsarjy9lSCK7/t65/sYQm6nhlfDrExjejhr3Lv/YKDUaJ4kXayXOn1qczDTJt8gbky89Kk/uIFVOpI6YsXG4VNo+fb5BS4cRiu9PW6Sju85TFQ0JboK7sU/Z0DiRytZta5MDFByCe00SWu16D8WSzFtnarxS6hNVc+u6Ps/V4DJOgSTRQ7vb5nqpIqmM+X2UoJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23dTVbiaBq+oIvS2aK1JS0R2xvKtAI1Mq7rqlS1bxjw=;
 b=bBtXoi6oXtgHWVhtOj0/Z1anEOMPamrQ+fsCqXeqpim0IhCdtFTngAk2KP4aQNCc8eZKJKQkKtp5mwO9Z3i1NhOhufk/KavPnKlEuyZ8dckwDt5VVPMiF6uI3D5To/kCLOZ7Dmw5oUFHAroazjq3+CJ28zxGgAeK2UR4ZG8aKdXe3GUt+lquWZ2yj24B2XxqzeeZzQKeBYwTEauNGuvfaT/ES0krD9bc4eKCThX3Xn6tM/R55pYtcpWZ8BmCJlZP6llhbuhevFJaiQJe0EXLml8MqUNkhomad6+6C7j/o0N5iyKHRguGQeA9JBLHXSzkgoV7sG8gqQQcBSIeuYbAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23dTVbiaBq+oIvS2aK1JS0R2xvKtAI1Mq7rqlS1bxjw=;
 b=GE3syJfcmQEHxvjU7XOqQbzLqqovPNtyGW6tKNQcB7Xa5J6vgCUwyxK0bLA9fERMApmnckg8PR9g+wXw8sMTQyqgj+qWsnJBKuHsDcyzftFAKxVeBJNN2GyLJckjc80b1wWghe5IFEDeziUGc1zwqHp8Hfhhk81ncp6ED2GkCGrZllfUbX50eoi0yAovlNqfeqZ0WTRriQliXnLI1xd4cfV3nMhUgeR9PufNkGJqwgTaM/F1BGOc7Z6bGgzD4Ye75VtrkkrF1QxzgS+AWf4B/eZmbTsOREww61W6F8z9T8/dpA7f0PtXgUk7Ukz7R8FXwkPjrvhM4dUB2uvDh9zAUQ==
Received: from AM0PR04CA0040.eurprd04.prod.outlook.com (2603:10a6:208:1::17)
 by DB9PR07MB9223.eurprd07.prod.outlook.com (2603:10a6:10:45b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 14:20:51 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:208:1:cafe::a2) by AM0PR04CA0040.outlook.office365.com
 (2603:10a6:208:1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 14:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:20:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 5197320098;
	Fri, 18 Jul 2025 17:20:49 +0300 (EEST)
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
Subject: [PATCH v13 net-next 02/14] tcp: fast path functions later
Date: Fri, 18 Jul 2025 16:20:20 +0200
Message-Id: <20250718142032.10725-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|DB9PR07MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0440a2-5a94-4355-a300-08ddc6064c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE9GR2p2Y3NUblkydldxdmhVQ2RtMWI1QzRmbjdKTDdnUXo2b1BXQjh3KzBa?=
 =?utf-8?B?M2ZJQXR5NVE1SzJXU2tsZ0w5ZkVoR0N2REp1dEhnNUQ4QWhVR3VKeTVBNVVH?=
 =?utf-8?B?SGV0cVlHR1U0VkNZMVhUVFRoTHl6U2FOMktoZmxEZTJKZG9NM0t2aDFPODkw?=
 =?utf-8?B?SWxKRGJ2dWdtRVIrRjZ6U0pjdU5hTGYxRVJWQlFRa2Q5Zks0UitEUS9NUW9E?=
 =?utf-8?B?WnZNSnBvWGtzUzI5UW1qeUc0dlFMOXJWTjErYjZVWkxYdG5SbHpudkIxcFBE?=
 =?utf-8?B?d2tzK2t6YkNVNjlvcW1OMlE1OE45eGN3dFA0eVdBWUZVaXo3eUw1dVVJRnhN?=
 =?utf-8?B?eStmQkVmZitBODdEaFcvSXY1TUU4TzMwaVdlbDBpUlZMOFFxems2UmhXYVdt?=
 =?utf-8?B?a2hMQzQ3dWt6R3Q3VHhIQXcxNTZ4WmhKVW13eVg0Qm5GVzAyVnVEaDBvODkz?=
 =?utf-8?B?MHRmYk8zTWtGcHoxUmUySlJ2TkpZclArQitpT1lhaHVHa2NIamZXalhJeXBW?=
 =?utf-8?B?bEllWnA3dmUzd2kzeXFZTHNJQ01YUTBLYldiLzhaUUtsdU12R0hrY1hFVjJH?=
 =?utf-8?B?KzBlclJnaktiR2lIeFF0QTlTeEdUZm4ydlMwdHUvWGE5THpxWDF6V2JFdlJ5?=
 =?utf-8?B?L2R4UVd1NWYwUmtGaklNblpPd05BQWkvcmFuR1ovTlc3ZHUwbFhtMlJBdFlh?=
 =?utf-8?B?c2Y1ck52VlhrU3dKenhObnRrbU9tajg1SGgyL0V0REw0cmdlNDQ4bjJGSE9z?=
 =?utf-8?B?THI4bktNL0g5d24xcmVwNXRCY1pWTUJwbDZobm8vcnR6N25CaFg1Y2pZYXJk?=
 =?utf-8?B?Y0J1NllLUU90K2xIclIrTGhMbWxEN1FkempqRG8vYkFkV1BzTzVqTE9Bem1X?=
 =?utf-8?B?bHMrRW9nV0tLQVRXSldSUGl0UDZlaHR6VzJjMG1vMUZ2Q3hiOUNPOUdjVG5i?=
 =?utf-8?B?WHJiNzVKN0J5eEsycSs1YXIwc0NTNWxkS2ZDZThlalJLMWV5TmEwNS9WR0cr?=
 =?utf-8?B?K0JTNzdQQ2tEeHcveDA2YnY4TEVidFZCTWpnQXAvb01QNFBOMktMQnEzL3py?=
 =?utf-8?B?N2ZsRHFpOU1WdnhmclBEUUZNbGVORytQR2pLNmczYWdOYTZMS0ZWdzh4bDd4?=
 =?utf-8?B?RjZuTlVSZi83a2hvT1hoYm5tV3hGY2t3K0J6S1dEYTl4V1BaaW12VmV2amF0?=
 =?utf-8?B?V3ViNnBwTkdaMnZtdTdRRHhISkJTYmJZL3NZYi93T3J0TCtjVjd0ZHRmWU4w?=
 =?utf-8?B?dWNKTHlYTHJkc0pjUDMxeXdqRDFLOW5YVW14MHJNR0NWak9md3h3clUvY0xT?=
 =?utf-8?B?WUsyRjZJWER1bXF1WEtrUWJhTG9wbExMcXlBclpwVmZldGRXUVRyR1lyTXZh?=
 =?utf-8?B?SXpnd093Wm9xcmRWTU9PTGJGSWttVzBKWEEvTlJWV2tqSVZCRzAxSG5Cb2Ni?=
 =?utf-8?B?ZVMzYzZ3dGgyTEhYTk04aGhBYitnNDFIS3RJM0JQemRHZmNzRnNVd3BxRHFZ?=
 =?utf-8?B?WE50NWRkUzNneld0bjRCTmRtOTIyaUVFeDhoOXRrRzdVZ1FxbkFsTVFIejhL?=
 =?utf-8?B?THBUeHhFNStpNXBUS1VIWkFGZllIZUxuZTBTckljZGNkLzBINGVUc05oaDVr?=
 =?utf-8?B?ZktTMnppK1VQSlFVU04yYm9oay9DaGtqMEM0dWJGbVpaMXZXYXhla2NMKzJj?=
 =?utf-8?B?NXo1OWdEalhyVi9yMHh0TXl6dVpqMVhMU1dscTBmYXRJbVhuYWxHc2ExMEdX?=
 =?utf-8?B?R2pXdm5pMkxIRzhDVCt6K2xYdE1EN3lWRmRiYklSM3RtOTVLeDJ2c3QvK3JX?=
 =?utf-8?B?Vm5oVit0aFBPb3JXaEt6bUtXMytvbnVBUHFNWlNrMXd6ZnFHL2M2dUphblhi?=
 =?utf-8?B?OGhMK1daL2VKcUxLS3Uvck5QYU1Ld0hZSnRodzc5Z0RCSXE0empCbTlremFV?=
 =?utf-8?B?bHFaTHFLdWVFQnJsTjhXNzI4M1Y0TVhmTmVwVm1JU2oreDdpVk1Ea2RqTGNn?=
 =?utf-8?B?L0VEenFTR3c3YmhFcXlyNHQ1bXdZdWdKY2NMU0ZCK3FzTVBuMC9yMmxwYXJI?=
 =?utf-8?B?eHJDeG80QU00bHkzUlRkaFZEYXU3V0pzTFpQdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:20:50.7784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0440a2-5a94-4355-a300-08ddc6064c51
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9223

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


