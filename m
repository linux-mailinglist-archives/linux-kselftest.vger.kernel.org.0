Return-Path: <linux-kselftest+bounces-32782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F84AB1ED2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5DC1C27C40
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEE25FA24;
	Fri,  9 May 2025 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gDxhuV5V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2325D533;
	Fri,  9 May 2025 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825514; cv=fail; b=fwrsxsJswRo9C1ic3FHguHRpi+BKLejR9QLjbiJC2X/SWZpcIj9tEma02YJGHhl3d2yfKQdXU10KyWkGlxMTpTB3NhLqgcKx74LUjAR2XePijZ8aocuMyfTa79DLOru02LmaPEE4JcCOTg4ggyvEQJeiX8SuQnKG+EYJSax/K6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825514; c=relaxed/simple;
	bh=jzGjlVHTjyWEGx0OxJrvgDWNiNQ6gwMZm/yT5kX2loA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0GOSnl6dQlCExBb0FQyD1Ml67yi8RBLzy5zFN/lnxt2crIeTVRtxU9zCVADDkkXEba0gkeE4bkn0tzSovs/62m++tCprFbJM/Qu6qKymHLX6HPo5emrpRT13a9X4kWy6yQy+Dmeer+w8139vGp2m5LiNut5VmLQRqNxSHvbehY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gDxhuV5V; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOcCc5u3+fD/dco3H9kzpcib//FySLIqPcdwO+b2XDkaVLcIuzBVKBJHkA7274CrREYZa5xIFfPYM4I35xXNpCMe2kFjg8bS2WtU4M1oVpckZFfUTvTxbp1STPTkABzWjW3xSwG4Y5fSuM2VD4VSvDJ9RcNE2gTQ0b72V65eIjCNIm43C//g5wOto6Pmb6yzhd5D/v8K4L+60poNrsqANzPNjpy7ksTArP3tuC9J0Uiy02hPIMrJ8CFEiKOcgTIZ4t8svQ35sdfl1/c88qfO4sDPCrM4rZPW7uR3tmYj9nfG75cpfGXfjQ2s7xnk9nd1OKEP6DvspMKvNcpdayGP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=hfeWbkHS1E1S/EHjnD0lOVzsdyz9BQlHnGy/UyvlwCU+RLhBKMJ0zIEvmLUkkTiNenuSmQpMbKb1qoTG5gKy/BFU4pDwPJKmpB/1nflW+H2245nQmU6XcFHlfW57YV++WALgRusL0oYlGPXHVsejA/3SuR84I85kjEeGqdTxHVcWgoYgD0zjDo7+fJasMox5oaoawN724gAiSiTeXU2+kPG49STQsjKepzX21sbPJDLRsJ7VYPcBrId9KDNVAAGmDsvkM6saYddkkZ6nFnoCBbDoDNo+FJmPumjH/nkq6GjneXrvLV1ecemg/VEaC3LBwGUwcUWT+srLgeNTPPjzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=gDxhuV5VjoBvm45XhGMpYyt8188mKn+ovzz0E1kBvjMBG+l4gj8StmJrDJvK2aAUzSOLR1rRfyuUQjmjmQpB3X0ZsBNqQo+u+8ADDktkzvt04FCskUesLBgxvJcuZvJh+w1wRi4ABgugtqe5r26wGPfycBEbKZY6DR8g1UMGjFzLV97x1v/gQgW5akLNqrysfnc0uGvcB2+nCen7ajg0h7B/QSrR3igymjECmmIV9eAam7oJ2XLM9jpGwPH27egNpu/yn+iLzodPXZ3pIP88uF32nMFYZA6kinPxDQAHbabgq8qBJnitAulBToq4+4eDl+dN4qodA+/C0QCGQHkL0A==
Received: from CWLP123CA0050.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::14)
 by DB9PR07MB8701.eurprd07.prod.outlook.com (2603:10a6:10:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 21:18:28 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:401:59:cafe::8e) by CWLP123CA0050.outlook.office365.com
 (2603:10a6:401:59::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Fri,
 9 May 2025 21:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:18:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id A2B3F2009C;
	Sat, 10 May 2025 00:18:26 +0300 (EEST)
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
Subject: [PATCH v6 net-next 02/15] tcp: fast path functions later
Date: Fri,  9 May 2025 23:18:07 +0200
Message-Id: <20250509211820.36880-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DC:EE_|DB9PR07MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fdcf21-8834-49e1-2194-08dd8f3f0aaf
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MndNaWtnQmdpUHowSTlPeW5kRm55M1ZvU2tsaUxsQm1ZZFFldzg0eFFERkxI?=
 =?utf-8?B?bVZ6T2MyamJrd3lNZFZXaVVzWlRTLy9xYkZUZkhlcGMyM2ZwTG1oaDlpejE3?=
 =?utf-8?B?a1FvcmZ1ekNVTVd0K2YzV3FpbGVnNHd2TlhXZjFZZ0N6Z3E2QTRRMXBjNjhp?=
 =?utf-8?B?Zjg1bnlrbDI5U3VFN3VoanFMZHJBb1Z0cFc4VUxqOFZ2NzRtaFFnLzg5cG1V?=
 =?utf-8?B?dzdFTkJTWnFrcjRnSERpZ0FOcVJVUW1WaXQ4eHJ6OStFU2dHWVN1dmJOY2V3?=
 =?utf-8?B?ZitxWk9YbGt2U0w4NkdXSXo3cXc4cXVISEREemlZUEtueC82a2lpL1FyM1Vr?=
 =?utf-8?B?eHROSnk2VGc0azVCUDQyQmg0di9ocjdJZVdpUVRrYmgyaVNwendzSEdHVFNQ?=
 =?utf-8?B?ZTdGaDNVdUhsNkRTejlNZm1pQVlWL2ZDUHFkNjFjOFB4a3NuOFN0ZGJsdm16?=
 =?utf-8?B?c29nc08zWExNalVyaXhEOHV1aTE2QXN4K0dtL1pBRVVmWmxvQ1picmtCTkRt?=
 =?utf-8?B?bXhSVE8xM1ppRmNaRnlkakNjY3g3NnRhMzFSbWphUjIrK1hoakpIU0ZmSkhJ?=
 =?utf-8?B?dUlyY25SRWxlYzRxK2NrUkFrWFZZUEF0bHNWRW5BQW5lQ09KblJzTG1YcU45?=
 =?utf-8?B?dFM0cGZvZzgvdEJmWEFweG51eXJEL1BJZFJaVzd4Z0xQLzNYWTFKdnduN1lu?=
 =?utf-8?B?WXZHMi9zRHNNeW1QYU9aWnRRTEhVUk81QUJUYmEyd1ppc3lJMnk1K0gxcWNv?=
 =?utf-8?B?endjYXJodC9LcVJEOWRLeEZxdldCMGVSMS9nOSs5aloxV0Q4OXlSR0lETDFZ?=
 =?utf-8?B?eUVYeFVhWXEzbGJRY2toWjZOM2JmRTdGNDdoTDBPeWV1a01BT0d6bklBODJt?=
 =?utf-8?B?Sm9SV3VuajJ4akRndkxWemJKMGNMcmJZb3dKR1NEWUt3Z0NLbDJjNU13aVYz?=
 =?utf-8?B?aElqUk5yOFNiT1hUUEV1RENRaG5yV0trS2VqQzNnTXJicFRqWTYvRDlXYng3?=
 =?utf-8?B?WlJ4TW9KT2dKNnlXWGcvQnlKc2lQa05EM0FGdHFBbll6UC9mekNGMFJRaGRB?=
 =?utf-8?B?SnRBODhEM1plQ3NsYkI0bHZLVGhTZmUrRGdXNDZQNHRyOXJ2dHdHZWF1RDg1?=
 =?utf-8?B?RHIyRlIzMW1RZ2VPeVA5U1ZWNnVDRjg1QlIzTGZBLzJwOFRKbndXSEtwS3p4?=
 =?utf-8?B?b09zV1hzODF1bWt5TlFRNDNoa3dxNG1MU2l2VUs0Q05wUTIrU1RVVkgvNDU2?=
 =?utf-8?B?bzRTSHNZVDlUbzFSVUxRU3dLYXFJNUtkSjlmM0FDaURVeHl3UG82eFNNc0Jk?=
 =?utf-8?B?dC9vUEkxY0d5YnRXYkVmWjE0enFNemNnRDFhbGVzQnhlYVFUREdqWUVFUkc0?=
 =?utf-8?B?N2x2b21JNlUrRWt5UjlORDFxcUc2RlVNNXVCZHNjK2ZodWdJMkJIUERZYmZq?=
 =?utf-8?B?d2hYVzZpSXpHSkhxTkNiSkpkUFYrNjJORnA2RUpjQkJnNVdqbnFONkNxRlBG?=
 =?utf-8?B?ZWJ0bTZ5KzlSV1RBRVFpYUhLUk5EOUpvWExzYXI2L3k1K2ppWlJiVDI3L1Q2?=
 =?utf-8?B?SGtENzcyc0tCRTRwUHVKYnJPQjhEbHh3bjh2RVkwbFFvVk0zamthUTkxZWdE?=
 =?utf-8?B?U1czMXlZMFBveElBUkI0MlRMUlk0cXArVmZIamtDdlNadDhyTTFXd2V5enNm?=
 =?utf-8?B?QjFWQXZ3dXFRYXVsdmIzQjVQbEdMT3FjT3hROHZJOWNWY0xjM2huclkzSlBJ?=
 =?utf-8?B?M2ZQSkJwK0c4M2lta0xLZXJSSDl6QmU1VGMveHFkU3RXQloyL3FaK00xSjJL?=
 =?utf-8?B?aG5Eeno1dG1zd2xxb3c5anBmOFZwcXMxTjEwWHRnbEljeXdyYlV6VzRlTkor?=
 =?utf-8?B?YVRVT25zNVBWcXVnWFk5RHg1dDAwSVMwYUFxNEsvVkgxb2RKRllDdm84MEk4?=
 =?utf-8?B?SkNiUFNmZzZOWS8zN2hFdFRHQ2FQLytSbnZOQ3VaNks5NE5FUm1LZU9sNmpa?=
 =?utf-8?B?aTczUytPUHFhS1MwazYyOHJRS3RkNlJLdm9tLzhiWGpKVEVtbWVNR2ZZeGYx?=
 =?utf-8?B?K09mK2F4R2lZdnpNc2tsMTFaamxwMjc3ekZaZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:28.0247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fdcf21-8834-49e1-2194-08dd8f3f0aaf
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8701

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


