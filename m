Return-Path: <linux-kselftest+bounces-36375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEEAAF6971
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DAE4A7A46
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7993290080;
	Thu,  3 Jul 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bs0m5QAu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442528DF29;
	Thu,  3 Jul 2025 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519921; cv=fail; b=Ozz768ieKXe52aidN5ReOeQEi5S6xp/9+61vx1l5XaQtT6hp2DiHicOHl2D63FiQeeHt67HDEq45Jfvut9VXiecsJsG9/H3/3e1ZHtoLDnWK+BOuL7J8ezVFSIwfPz8K8FO7O4+X914+pdxzgmLc0Lst0JukOOak1k0I+fVZvlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519921; c=relaxed/simple;
	bh=hgg1HMuKo2okA7YoJWXqB3c3Ec5KCuLARxUTMC3Ad6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRKFl5qzFEbwv4Ri5Uk1MgX/aLvSAERBFlxqtomD1RrLhwCaLuWFocwl3bGI8n16VcQYNpIHPMon7Mm2E+7XOtg5Q59CQz2k8dHpUVFzB2yMprYdvzj9qalVhI8q5LTREweckkkHEMfO14bPvNR/BYSX3yHtEBFhrc8C54FiRrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bs0m5QAu; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqTM2jRdKBjHCWnJ30nRgHGbz/L8ud5y8t3kBsKyUVSG6C6qE5FHbZ0oqT8/FrRabsn5/YBlzCeZXd6OdzqQnmjS0dARd0aH/9uUPsSU4BEMtF+j9XWeZSunFXPvWZpPrhNvwTVlhej+LkHg77uX+fTZ8L7yR/D/mLU9LTfQo/cmFH3FFxX6ffK/ipXF7ps2HksRLelqkE6MqXzSCyuiwZdqs97IhWCcyXF/PD0+wRpvIQLFD8OLm2La7JAY10xDWLdXz/PY8TlUve3d0dBJoPHUWqNNX9wEu5x2dSizVSAlBdXRDm+OQoZgLOEGEGZn6y+E+DjmOlO/nlO3IbwrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23dTVbiaBq+oIvS2aK1JS0R2xvKtAI1Mq7rqlS1bxjw=;
 b=F5C/1tDdD8I81rFDJ5KHj93JOsZBeCZi0wDz1McVKwMs7xl02cTlK3a/l/3e8/RtjBYz3WVWIOq6xenVWY8u8zOYn7VhrEh0RJavtkErei4mHQaT3CryQJR+9lPXZtQShCWiXi6V3wsNC/1UnKLe/2/RLNwfEaUn9i1QfUuvOtrF0+viu5k6Hq+eInsyqWr44nH+j8VCVuzdDuq8uBVCM8iyQQvGYkjyPkfwHgPcKXlYYXu7tIDg7uXtjd3+tteJ/7fq2W3Mo/Jx0ISksBclMQuFeFYZIR/dAlY1QwNr5qMiJxegcW77XpX8bIvZOFqRKZkH3i1UOr4aSk6gVkibzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23dTVbiaBq+oIvS2aK1JS0R2xvKtAI1Mq7rqlS1bxjw=;
 b=bs0m5QAuo6sTfIT1gvougidqd3RREOCjB4mPpL3Br9ruFPBcOZkVdHiKj8FLQfMBeSyZjH2zpYEENQgBLj/2r1CTDAjYItbu00v7yft3FBl/Zdo8XrUw/jvNW1sKynmSmoekjifIAr5uzmSpDaIl1ZXxNyywJWG5Yrhj0yFalABEpVz6XYwfpc4bxAbobg9w4HCQeSmZwof65883cEijF+0y7ZH7PEi+59lUSjeg86YWzgYe5PwWwLFZZGEsnzpRm92fI9xTQVMtunKc1+T/KYL0xd6DSyL7cK6b8jGDrHFKXuv+NCAObrEBLK0oIQ04vzbbod1/ug9xBugDoq3bcw==
Received: from PA7P264CA0240.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:372::17)
 by AM7PR07MB6676.eurprd07.prod.outlook.com (2603:10a6:20b:18e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 05:18:34 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:102:372:cafe::eb) by PA7P264CA0240.outlook.office365.com
 (2603:10a6:102:372::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 05:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:18:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 937C9200BA;
	Thu,  3 Jul 2025 08:18:31 +0300 (EEST)
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
Subject: [PATCH v11 net-next 02/15] tcp: fast path functions later
Date: Thu,  3 Jul 2025 07:17:15 +0200
Message-Id: <20250703051728.37431-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|AM7PR07MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 6641f6c4-b168-4266-12ac-08ddb9f10e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3g5MEt1c3pCVkN4R3NaNER5S1pLbXJYaDB6TTZ2ZUs4SWF4UGRCaVlnNEdD?=
 =?utf-8?B?eStsRjZqL3EvVVBhbEYvbC9ORG10ZDBBZktucENRcmk5MDJmNWcrell5K3Zu?=
 =?utf-8?B?bS94dVVROHR1WWVORitQcGZib2xHbnIySFplckZlSml1U2JPTEErbXdJWXhw?=
 =?utf-8?B?dXlTUzJNNXFWOVhSTFRyUEFpRkFBVUZZU1BnNUkzNC83UDIrdks0allvcGNO?=
 =?utf-8?B?Rng1N3UwemFaaXhDcG5wYmRwMFduOCs2VnlXUktkeUhMbm4vaUtKOHBTODVi?=
 =?utf-8?B?VFJLUk9xdXdVZnAyQWY4Y0RsU0pXOFlDUEZCR2VKTFpBUnF4QzU0SGl2UzJJ?=
 =?utf-8?B?MG44LzlQWGV1Vm5FT3ZBUGlFRGNGdU9MZ0pOSlo5dEJVMFRuenoyNTVXTGVB?=
 =?utf-8?B?M1czcVZCVjUwZ3NFaE95UkNiWE02QWNqRmRzV2NrYWNjNlNsTC8rOWJoTS8v?=
 =?utf-8?B?czRlbVJSdVlPSjkrQWdqR1ViNWIwekpDdUpJNjJXOEM0ZURNa0FnekhNZ3Ax?=
 =?utf-8?B?Nm9HVGpQRTN0bzJWSmhPSlcrbnVBT3QyZWdIdWlBQkxEc1dhK0FrdTZIQWlQ?=
 =?utf-8?B?U3dzNm5VVWF4cU8yNVBIVE13L2VaYmczSWZQd2RZWDZGdjFKUElNamowTGZN?=
 =?utf-8?B?S2ZJVnViWE1EYUhCbk40OHVwWE5NUWxrQjZZUG5TK1dyTVB5TjJvcTgxa0VF?=
 =?utf-8?B?UTQxd0dyM2N2b0FXdXcwQ0RNZ2ovS1N1MjMvNDF6ejEyQjRhVWpZRVEvV0dE?=
 =?utf-8?B?T2hYRGZnTlpXeC9ONEZvOGZMT2NLcDBkcmt2ejROazVmSXBWTGw2ak5kOUxX?=
 =?utf-8?B?SUhnQlJ2bXAwaUlZSkhkUlhCbWd6THNranYyTTZ2ZTJ0NjdTVWczblg4MTFj?=
 =?utf-8?B?aFZyRDhLakdSbi8reVRJZmpGNVVFWXFRU2ZRTG4vYkUwVWpraTdjV2Qyb2Rj?=
 =?utf-8?B?WHBvWGtEQ0YzbGZZN0VVMTJ3NmhXOERVaVl1SHZkV2VDSDhXUnlxOUd1Rldu?=
 =?utf-8?B?cVJiZGpwYnQyUmpSL05LRWIyWXBZTFBGdDJ2WXQ1T004cjJLSjk2eE5iYk5Z?=
 =?utf-8?B?ZXJLaFZVeXI4VTBvdHVtSnhsZWRxd1VqT2VXaENUWWFMWklKL1JOa0lyN2Rv?=
 =?utf-8?B?Qm5PODY1MW15cld6cGNYTytLSzF3VnNYbFNDNEhxYk5KUmNoRHVCU0wzVW5T?=
 =?utf-8?B?QkdUdExoL29KNGM0VWpuR3BwMDJIekxNSTJXbUorVlB5eDk0R3MvNUZ1VExS?=
 =?utf-8?B?c2twMkxNWWF1elk3MzlMQUlSOWlKdWh3RitXaUZMZEZBeVZMVk5DYmZOMEVY?=
 =?utf-8?B?cWFqSDlxcDlzTDdxS2lJV0NIbGFFa0J4R3ZCSGFubVR5dnRJYzNTU1Nob0cz?=
 =?utf-8?B?STgzV05zaHhFUmZnWlJQVUFrYU9BaVdaampPdis4V0V4U0RWY0tYN1FqZ1VM?=
 =?utf-8?B?WUFQMy9BUzZHNURtYXhVb2YyeVFpSUMzUEw0VW9ZY3BuUzdVS0NZMDdaSTQx?=
 =?utf-8?B?Y3FKcFpkQkhxRDE1ZVpzQUJBSFpweTd5M0dUQzNXU3plVXVVelhwZnNRVUFE?=
 =?utf-8?B?OExISytjSkZ5Y1p2THBLOWZXMXA2dHNvRWRPbEpXOGdPVWZnZ3crZlhveHFr?=
 =?utf-8?B?R3dYQzRIQjBTL0JjcE9DMEcwT3d3SDZrT2RITHFIc2xQZ1J3VWs3ckthOFpo?=
 =?utf-8?B?K3l0SUk0cEZxdHhob3pEWnNyZ3VWcDVSSHM2UFRkWmpZRFlwMW5VRUVmemgv?=
 =?utf-8?B?RUY1NWhMdEZ6U0VOa1BrNUpMVEdQVzF3anVwWG0rcVVUcTNDakZrUlZnNDc0?=
 =?utf-8?B?WmwrZ0wyQWRzQ0F4YmVhZG8xOUFIZzFMUEQrTDh1cHZsdDJZWUJWVWc5SEEz?=
 =?utf-8?B?Ym1HRmNPN09WNFd4YUc4RHNnZ2UwZ1RQYjZqWTBmNExEdzh1akZBREUyVyth?=
 =?utf-8?B?NG5EY3Bua1R0WDNWSWJHbDhCZXhET0pDQjFEQmxKVXEzNHJ1SkVwUCs1ajFs?=
 =?utf-8?B?NFNLQlJqRDZNZDNTYWNaRC93UUxCNzV2UUJHb3NaVGs3MDN5RnRiY3hGcWNx?=
 =?utf-8?B?QXZJT3FseEwydW1HVU5wbHpGNHdMVEV5ZWxFZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:33.0451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6641f6c4-b168-4266-12ac-08ddb9f10e1b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6676

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


