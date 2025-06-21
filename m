Return-Path: <linux-kselftest+bounces-35553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C1DAE2B9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B71F176490
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442827055E;
	Sat, 21 Jun 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Spc3uUx+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4C27054B;
	Sat, 21 Jun 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534671; cv=fail; b=f0/6ToFDB9FRHUg91V9fKbAdAPKfUHaDZL7Ohh/+9+/nnqLBGk98s5o2XZVnu7vuiA1B9mwfhdIlCg79EXTnywSLUrW2aN4nJ4nofDOjdwMLnEruHEb0RV98APKwLUf1b6Vvlmfzb2f/1rDDuyvgH/ZPoZu0B4mu3tpXrgwtUF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534671; c=relaxed/simple;
	bh=HrthedlZLSF5PvL+mGmj96I5YV+Xk4AUUKoKHivcNic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1VlsvA5nN5/vrGt5ketNpv/ZsF5euDCpDhA00+jxfsf4yOfa/2NGxAbTRjSCRLfrbLCuy79vdvAUTyRmE1DCBjYX7lu7qvIxN4RwYFtosTLWCgHlMqJb7mJd+Wyck2SVeU7D0eZohLSpZ6/U4d7lvPTlNTg0zLVwd0cHmBnqYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Spc3uUx+; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRz8eQA5jgBYZAAr/3fKITok8//mI6BhoABVrLYPSiIdFycqILCQ7QhO395Ri3WF5494wrmiYP0hCtHKdrsSN/88V39Z4Baet8IMfTjPGSNKcmfcBZV9TPxoPp65rySwMIjPRYzO6hFGPzf9ZocE6KiXGbjEgHy4zHzsu7U47rSRJEwK6aVr+OwKFdMl7C2mRVz3qfEckRm7n7MnRmo79g4+0gSKcjQlrbdLXhfmvBpZzdY2PvUCV3fyPsDeTP/2qYTLIbZ9RdRomrIzPraVLlh+p6UAtNpYB23NeOpTpW0giKh5B9YGHWnnm0dMXMVxfiA2EfwuiO+p/XIDMfFOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxhDhWo+zuu9Jb2jKlYN8O7BEJ1zmYitwA27xZNz6d4=;
 b=KBDkKMPW7JGPLF+fYR+dMrLIOKgEMgXc7TVA8rD3P3wz2XherQF6GDlR1RGwj2j0nGuf3MUR6KXeYYu0Q3CkR49cer/y4cKnKm5l3rkc+h7Zb+nQt1vA0DzjA1rzuoDV7U1PRhy8r7iXK5Go4GmfPKW1EAFNSDkwDUd7KT2OG+LZwSK47nnKw1UjCRn36jC06JTsoEdoVBdPYY7EMmiHXDvKPTM+IAIUmXMnmBEBxmBUuctkTyhAYSEgfZLPWtih+NvHZRoU0dY2ijYnakqcYmr4edrI5yDvqyQCqMkKIup1DZCGmCGB3cZWXfM8g0rFDDMCcebH68wIGTU3YtmL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxhDhWo+zuu9Jb2jKlYN8O7BEJ1zmYitwA27xZNz6d4=;
 b=Spc3uUx+6fbqqFhDwYB32clSzAbVPeOxnwmTQh/vysXG1MX8A8ysSM2wxVGb7q4hqmgoeQ0CmF+Jk7dJjS6q2mPIE4PxPnB+lvmJE21wz9ZkmlicOnp0jfCSfAivk6VegqkUEG/rgNGbJFE3HJr43+4+DTIietlg8DYpx/gj3z5um59FArfFQTvLJR20YlOq4X3ZaVRbR5/l7U8KM2m1eD8Gub1H8W/SYgoCWbSRCMHbUzF6bsaPcXbLBJulkTH+QL4Armav2CsHqZCBqJP7UVsXpZfGBwzQN/E4lJxAMsgcWGkvLndRFNwxOL57bJoxw06Si+dUlDMqpVitpm4wOQ==
Received: from DU2PR04CA0226.eurprd04.prod.outlook.com (2603:10a6:10:2b1::21)
 by AM9PR07MB7299.eurprd07.prod.outlook.com (2603:10a6:20b:2c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 21 Jun
 2025 19:37:46 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::73) by DU2PR04CA0226.outlook.office365.com
 (2603:10a6:10:2b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:37:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 054C21C0010;
	Sat, 21 Jun 2025 22:37:44 +0300 (EEST)
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
Subject: [PATCH v9 net-next 02/15] tcp: fast path functions later
Date: Sat, 21 Jun 2025 21:37:24 +0200
Message-Id: <20250621193737.16593-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|AM9PR07MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dd53a0-bdea-46dc-5ac0-08ddb0fb1977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHpXcUJiN24rd1RRRUd2aEgxVEVwMG5ieDJRRnpWc0RENVUvdHlSU25iV2pY?=
 =?utf-8?B?YkNhYXNYNWVtVUtkai9xVWNjSlVjdC9XTG1DOE53YUplMXVjTnJ4czdsTVBH?=
 =?utf-8?B?aC9VTnVEWkU5TUdyYUpsaUZVN0pWQUlwSXFKQlVyd1o2b2VCaUxVM3l0dkJw?=
 =?utf-8?B?RXExVWh5U0I1NWdKNWJqb0pYSXZPVmpDc0N3cVVpcEFDUGlkYnl5Tjg5Zzdw?=
 =?utf-8?B?MVdRWFN0UWF0WUhxUnZyZE5QYUFlbVdodmp6aUcwOGRjczRXdUVCclB1ME0w?=
 =?utf-8?B?UWZSenBsSnN0aUhPTVJWNmRLK1NVZWROMExyQitFVlhMTERUUEhtUDVrSkZT?=
 =?utf-8?B?eXI5TkRITWs2c21BOGNJT0hEVllFdVFOS2pRR05peUJBeUgvY3NUZ3A1SVFO?=
 =?utf-8?B?L0N1WERYTWNZZktqcXU4aE9MYjNJYkt1Ukg2d1JwRVhzYnQ4WXY3dmFMN3VV?=
 =?utf-8?B?QVRyYjlybDBOWTRWS2VhSzBTZ1hGdlgzejlEaGxqbisxRElYQUlrQkJmdm9O?=
 =?utf-8?B?OTNWNm5oK1hiN0dycWIvMmJHbFdKWDEreldLdDIybnRUQzRTWHFmYTlZNGNO?=
 =?utf-8?B?anhVSGJ4bDZZVFlLSGdPMTlBVmtad3NPck9LMU00a2dWcWRhQzM0cy9yc1RN?=
 =?utf-8?B?blEzaWlBSTRSR3NWOEgyOXlaL2NHOGNuT29WYm9qajN2NU43RU9QM3NQTytz?=
 =?utf-8?B?Mjl5WSs1a24yckVSMXc5bU1vYnFYQ1lIb0gxdSt1T1VZVjdsWmo2K3Q0aU1F?=
 =?utf-8?B?ZzdNV2VsQ3ptRjN6dzRwVFcxQUV4KzJwak5ucE51ZkcrblBCREdVemlOUmlB?=
 =?utf-8?B?dzZ4V0lsT1QrNzNwV21iT0IxaGIyU0t5QnNydkxETEJvWlBGM3d6UHdzQUdM?=
 =?utf-8?B?ZmZRVVZuVWxnejVsUzBYcWozTEZ0RURoLzFNMEF0Yk1rL29mQ25aZjM3SGlK?=
 =?utf-8?B?UzdSRzAxZ3g1WG13NXNZYytEZ0ZUaDA4T1cxWGpHZnBvMUVIbFpNaUZWSklQ?=
 =?utf-8?B?eHFudEtEMGpGLzhLRVdLOEl1YS80cGtRK3lhSldYcW1BbzNTdzMzb1JOa1Zz?=
 =?utf-8?B?L1RWT0J3LzR5RTlQaFhzYnY5bFYyT2RjOWRud3pDMkI2RmZqVWRINU9seFhZ?=
 =?utf-8?B?MjdLZDR5c0JkT2p5Y2o0Q2pKclpSYmJrd21TZlNKeklnNUNqQTNlOS9uMWo4?=
 =?utf-8?B?WGY1WE5GQ1FOMi9UWE9aOXBpMEJldjB4a3ZROFB4VlA4VDJnVmhySDFnb0RO?=
 =?utf-8?B?a3JBQXJhVXhqOXd2alZjRk41RXlSYUNsWXV3Qm0xTW9ManNaaGNuZnFxa3JH?=
 =?utf-8?B?NUxidkJxYWpYL3pCTVY4N3Jvayt2eExiSDhoTmRKbSt0S1pUQmRvUFpIWWlP?=
 =?utf-8?B?anNveUhWc0UxM3pMWlRWc3JFWSs1eUd6emZxSzB1R05pTzgwbElzWi9Zbi9E?=
 =?utf-8?B?SHBzRnJGcnpSSmJrdWJXL29VajZyWTh5SytvOFpLYWU2dnYxdmV4ZktLOW43?=
 =?utf-8?B?dGFtdVhpOFZTQW1DUUQyaU1GUElNd0N3RVE1My9PeERDZEpHZ0ZNMkI5R2pV?=
 =?utf-8?B?L3dQako5OFhRSENlOVNYTjZSNEdoSjZYTDNJMjNRNGdJVmx4eERtYXI3a3lE?=
 =?utf-8?B?aENNUlAxTVI5T01jK0g3cld1K1FRc2hKOXVLQWpBKzVhYzdidHNaaG1pRmRT?=
 =?utf-8?B?ZTdoNXNpbnp4VllMVlpiOFgwaHRvWW1nRjFBN29PQXFwd0RTdUZ2NG9MNmVx?=
 =?utf-8?B?Ui9LeWx3aWQ4T05vYk1BeG1yODhUdWNjTThuK20vdzJaM29oUk14RjIwdzFm?=
 =?utf-8?B?eEg2ZitXNmV3eFNWYTNRdWJlRnNkbnJOKzY2QjNFTjVYRnF0dGkrYUFzUFI1?=
 =?utf-8?B?T2J5ZmtMdDlRU3BvVzhDQm8wdWtKNXJZaEExUG1MRTJ4Z3k1N0JhN05XMkZm?=
 =?utf-8?B?bUVkYWxBOFl3blBIZEZMZUd3VVNubmlRUmNxUTNEZU5rYnNLZEI4OXdlMmdX?=
 =?utf-8?B?TmVJdHdTK242UkJwWHlTKzN0VG9JdVRmMlkyT3FhUTVrc1ErYmpyQXExTDdx?=
 =?utf-8?B?bmNDdGJoaDV3U1JuS2VEaGNseGJSUndiWHlDQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:37:46.6221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dd53a0-bdea-46dc-5ac0-08ddb0fb1977
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7299

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
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


