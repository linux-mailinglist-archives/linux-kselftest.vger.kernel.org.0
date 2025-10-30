Return-Path: <linux-kselftest+bounces-44408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27CC209FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD10C3A881F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54BC27FD54;
	Thu, 30 Oct 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ojdd5gm6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4627E07A;
	Thu, 30 Oct 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834895; cv=fail; b=Kd/DJGZnyqu75bzTsLb0BCDtp7d/vZdCeJfEWp651s7BdDvJxKHKh3m72fV6+rzY5lzGxQNk/vK1WzF94WhHSyT4B3P/wgnCvLmnvLlMBl7dO2j/U3uWK7QEZzZ8F6ctukQCmfx1RALkwGcwmXll5v3p5QKL3ccmHOR4zVhK3ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834895; c=relaxed/simple;
	bh=lkXEUoR6S96evbn6/0RYhK4eBO/k+S7LYkMlAesTj4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFtoDDT7+2N7bArO8m4ydacSr87XGxbcKdXnxFYSH3BR5uAseGPgRsgvZd/6GH24zypVQBtzfzi4F5GD3b51YKsTf8bRQhSEoCTl97y6DlKcqhp6njcfCUObCA9noo3TLMWio7JpXs1GbvuzDMByU1ZUUgMGUUEeJyUbTuLAQpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ojdd5gm6; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub2QjU9gFBowvi2tEK3pJCH5VNIyqDoh+rUe37iznAOO9zO+hVzvyNP2+eq/xr9BfncaYLYN++Db1cVpuiSHC+xMmuTfP0kVJUMeHc8k2CmLJJOdWytkJe1caEK/hP481lxDZeqJ46dPz66uXOCAed3nmC3gNby3wq2Lqrkyo9pejdrjL4MrC2NlF4DtD1xoCEnP5wocuVu+cIV13A7gDkBDgsSLUbdFTjJZMUaYfeTFFFHFkhxUmMYYJFR22KkmAcl/Dc6/Zjxx/4r+LgMz4g9hYMow2y48tthAOo+gL/AhhNfLa1hp5arUM0UOJbhCTxLmV9uS5wlWavDAJ8EuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ+WR5Rpcr5awvY2vMy2ryWE/91CmAnhFh5OiY5Uerk=;
 b=DCqOaik0VkWEawAH6wPXokEQygUuv+7oR9H5ok+RIvR346sh7GSdydTeQKfX1taDRfyog4DHZpE7g/hjUB7O7H2ffOJm19ov0fe8jG83fvTjULj3uvVYrkmSlwbSgS9ES5MRzMwDbzHqya+EnQ3Alaf0+STxebVaeAjNGs3j9cwl00W7c9MPkPggdWBxDIsKYYOT12pfWtdj4It+RQMnYIsaeqenn6Fu3OvYsGQVlmEibMQ1WGKSzr4SaI7TAZ3TNVKFhfGp5Hk0YZy4ddYrxJtL/CpVVIetMqDH9F52yKCj6I5jvAA3rRkHqAiPhRBsJXFeobIu0MxAzuy+nlHl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ+WR5Rpcr5awvY2vMy2ryWE/91CmAnhFh5OiY5Uerk=;
 b=ojdd5gm68uccgZdw0gsSIk8zO02V9mquyumxP/KL3yoNlD3B5RCa7Vd+dO3bBZxxhpn9o4ihdWXHIyIYtB5wh9oWTCnlK8FnznGwdjJ/4ttTfRRc2XZrgO9S1pJZi2G85I81FMlTXC41XxdxMrIRKNzsv4O/WVeQZTF41GCGjHR6kIw88jUojpIFJPeEoqQ0i8HlRsCI4xOF+PgVS/LkX/fWuGAQ3OKzawCnBmWXRZFbyc2iSNkFi6PkjqovH1elTf1qwt6bbQS6Gyh9mCp0eIz9eyVXuRqeyuz0L2I9i3sBbH+BZQkPigNdRlAqHbWYEQ6czU3UqNLh92OnNQMLmg==
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by AM7PR07MB6407.eurprd07.prod.outlook.com
 (2603:10a6:20b:131::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:50 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::2f) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10 via
 Frontend Transport; Thu, 30 Oct 2025 14:34:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 95DAF200E9;
	Thu, 30 Oct 2025 16:34:48 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v5 net-next 07/14] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Thu, 30 Oct 2025 15:34:28 +0100
Message-Id: <20251030143435.13003-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|AM7PR07MB6407:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4ed95aa9-115f-41a6-5b70-08de17c17b91
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Lnm35STf3y/UKkI6gd4W+T9jbauG5xaFIIqIaLOcNK9qv0FaKnyq9RDmx+/c?=
 =?us-ascii?Q?fCo3klEws1MeJw90/jUFQKKoLW6+ZUJ+WK+894l9zm8xyDPxzaqw+NghU8Fr?=
 =?us-ascii?Q?+dgI1I9kxoa4fPg/wfVC782i3RFwkpnGBnA3j21jz5C/2NzLgsen1QIQuX71?=
 =?us-ascii?Q?CsDh9RbZhpYVG+XdcgLtl3/y8R9ZlFKUKRY7wAz7IGSAFUPLqwy/eqwdRP3p?=
 =?us-ascii?Q?ayBwM6BsKtnZUSglbsB5YqrlPKKkgQ3NLxS9V58+utH1qLTVFxE2QaeNooGN?=
 =?us-ascii?Q?mV1OEaVxSao6+lPfoIGk+KQ7XygDT50uYqriM6SFclscKMMRlld/I60zjrCI?=
 =?us-ascii?Q?p5hD/9qgOxiDoxZEvsfJTFVgkS4oSnS6mFRt51ZUqA3+vwefAVMJkp/Ewjid?=
 =?us-ascii?Q?RZ4Yzakfu29NcHCoqm//lI8FIK4gMQqQzyhEngo2rCA4gpxGd+tzJ9QRLDAQ?=
 =?us-ascii?Q?P1Joq5ErlgIwo1kptk19TXAdTh7n74EQHJwFkgnNYdCKtDlNG+EbVHiaC0pC?=
 =?us-ascii?Q?+c0xIQzx0MY4A7eP1b9xfEayyXpoKM4Yf03NC6HckbNCMO35EGdMoo5DVWJC?=
 =?us-ascii?Q?G1FwSMiPSD4JJQkiBAS9nVO0TJYe7S1Un8GmgV3yv4/se0aaPJt2m3PenN3K?=
 =?us-ascii?Q?TGssK7MpsD14rCAMTvLclLq1jTOs1sAAXC1fQ/+8d3xoPV6lEZvDOikUJYHw?=
 =?us-ascii?Q?MxwNIPFdWIYmD17LU8rFecSSb3vH4kCPg54wpdaT2NpTXlBDMemyhKdTzNSY?=
 =?us-ascii?Q?Kxut0QdIxgGPnI7yJAiF+aAR+mpURs4Gyllwzs9KHKcFmRjVXx3fJftvVZmo?=
 =?us-ascii?Q?Tps+mkOcFQThR0bHND/lSmPBxjtct+/h/9kq4sLmaFw23UvL/7j9ETtDrngB?=
 =?us-ascii?Q?/FHXVIxK9RLdFi92IxOipVIBEXqbolfubgTVvS+pOjtoV2NEIZtzWL/vo2qg?=
 =?us-ascii?Q?l0bzqt3CFkvOZAYThUCOS7CJMEwRG9IW+pwXLmzc4lhOIrp26S6jnXKKqYyd?=
 =?us-ascii?Q?70gURjJRoJ/UKrFCafe1BpphgjxAVZWvHZBRSncpXYQv63nCPXMoD8Msziku?=
 =?us-ascii?Q?jg5Raz2iDZWLwzO2btPCp52O3glnHm1rtAt4UIoqxS9Oi3SUz+81jrt6AcBp?=
 =?us-ascii?Q?xnMI+gUuGnYsJ1wrDN8FJEiHWyKm3c8BhaDqB124W2eINo2o4BeNDISt0IRR?=
 =?us-ascii?Q?I2oYznffWHVu+Od8PhI2iFuS6Ikna95/nGnTAIc4+N1ZuWOxLawulXguJ6Sn?=
 =?us-ascii?Q?4/PacW8Ta9TeseprHP0//JCw4Toul9rUxDbwwk0vREru0E0FL1bCfJcEbGKb?=
 =?us-ascii?Q?my/gfr+B2sTquI/0aqbY7jzt3ykiPr3z/iTgoAR50UY0zZeLZK1CUNdSUOvr?=
 =?us-ascii?Q?W+ZR6y/dCydpancpwOD23ZmbS3IWto9fPq54rpKhTo471KUicPyqpey1+PLL?=
 =?us-ascii?Q?MvuQoxHcs8UChOzyK36m2VfNhPA2c9OrB/pN1fN95qyP7Wf/ZQB+hh+Wz25o?=
 =?us-ascii?Q?r7vS9fhR/YRRl0PE//joN4MHf5R9YvJpq8uRS8zAFn5kuUcPs37vFkAUTve3?=
 =?us-ascii?Q?fZXszWbeujwrORlWHdQIPOenNkJjBscPwPeIKXfa?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:50.1431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed95aa9-115f-41a6-5b70-08de17c17b91
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6407

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v5:
- Add "Fixes" tag.

v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a7ba21d298ff..c66f0d944e1c 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -473,6 +473,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -495,13 +515,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -509,20 +527,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


