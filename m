Return-Path: <linux-kselftest+bounces-43010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D7BD56AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96B5C502690
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3722C0F95;
	Mon, 13 Oct 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BWD2zMAx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640142BF3CF;
	Mon, 13 Oct 2025 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375036; cv=fail; b=khWilCoKxvbsqP1YUS57RM+F90FC9cfOxiXkSoW0eYYLQgdXr2ake1DgceAFw66+aGgIQyW3W4JUKd+RyEisDhhe0x/9Te1XP+dduLX0ZTGBAgeCbYC3ehH8QMTFF9M5tpt5PvD7a68A7144GV0uXk0eHyWb4ondu7qhw8mcmOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375036; c=relaxed/simple;
	bh=HG89KDgLb/Thxkh/F3XvA+9Em5jAI7lathjA/LNG7is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uL2wKCcfkzx4yA9n4q0ljH24HFea2BTOTeyasppRTpZ5MTG8PWOn+g3P/4ryxm5pmeSCUJ1sPswx7swu0ijXQ2uaUY5WT+RGjqMkZqUqSc2Eky83bjAXYoaPPsdOlVZQ2dG4E0Y1hr0VGk4byzv52Q+N6Q7w0O9o5AquiJ1hdNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BWD2zMAx; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSurOkW3vkyTXPZznjhbIxug1NyYZjeTgnqKqdEA14tM8qDGuwOyGwkWOZtO3Ufiwuc5DMOy9Se4eVkQHiWPobZ80oNFFnmvRVbxVzD+fOmjtTk7pme7BeIFIs7bMlEI/G1Uhk+M5nyzSYumjupeLv1P++iIrqt3wcBimJhZIp+llw/HuaNCZDqHjjNh3bAYLG/hvA4ScpRbzciCR/a3O/g53ypX2yuHAwyzRzlaUH1VienPM8aDFlEChFycDCTXKXXbNxRB9T7mXEdBGHlrt6fegARslymUgvnxQ/qoNzXt1II3bvNaGPv10PJ9kKJCj79tBTP6qncpNnTxm7UKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIRsH6eEtEwzcalK6eelVND8k/OculqcZVWMZYSHAwE=;
 b=ade4T+lbizy6w1FmSMJ09x+SSDEpSrpwidubul+0OONIlWSGTjbG0h4pRBPBS11Ln4bajUZ9D63yAtxYVXifkOQNJfDVakjkWSYG42vSQlGalUB8ad9X7z+3zudVGxrDAYonOgIJotedDlnD8pXYralFAaFdaK65cq6U2aG+Z56dw12r/n0kuPsciKkdq+3qQFxq1ThEmJtyBySHBvHmUY4p/86FrkYU7FePxMUp2C15mx35HPCAdx2i1BWkq5lZf7Q8k6v/rsPr0m6CxT/7ASQdUSnOyI9t37EnS/wDo4vxcieu6YCkeAS6sdW95Xq1Ies58jgoc8PyTqf3JV2wfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIRsH6eEtEwzcalK6eelVND8k/OculqcZVWMZYSHAwE=;
 b=BWD2zMAxeoiMBpzQpEf/iB6l73BRSiUxPFkvDaOdOdiHGmSgMXad76deWI3wLLrp9nzQVSNCa1WdpuJV0VB9T2qhe0KpX5SC2TMLivk1PqtlcWHkCSjLKoXGPO6V1L7MCQPc4YhrWb0rv9X7ChMA6L0+1Iu6kTnscjHOgl114/qQXN76TIYqcnX2XT1S69T8UMopkfRwmsRFF2AZGphOx43pVzHYWjiAtZ7aDEoTg2Nh0uGsawU6L7Y5UGoSHKzIQt9h52brZPM+veDZ4uoHPasEYZWRrDAdbOMYjOVITKE2DH1phn9B6FkvH3b72rvp2QVHtz4cccNM6IMn8RMYwA==
Received: from AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::21)
 by PA4PR07MB8910.eurprd07.prod.outlook.com (2603:10a6:102:268::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:49 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:150:cafe::a7) by AM0PR10CA0041.outlook.office365.com
 (2603:10a6:20b:150::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:03:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 3576D1C003B;
	Mon, 13 Oct 2025 20:03:48 +0300 (EEST)
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
Subject: [PATCH v4 net-next 04/13] tcp: disable RFC3168 fallback identifier for CC modules
Date: Mon, 13 Oct 2025 19:03:22 +0200
Message-Id: <20251013170331.63539-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|PA4PR07MB8910:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af45afb9-5338-43a4-1582-08de0a7a7af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZSlUiF3MPTMU30w26uVj7dznalkMMWTtnu5QKgIX7iIL/VI47hYfgU3T1d6?=
 =?us-ascii?Q?XhQ8DXnTQUvUMPFRSDmoWS6MJ7NJzZdwok/x63Tqi017yNJe8d2K1iCbX0Ll?=
 =?us-ascii?Q?AfTvcOUVOcNIu+7Bon7b7U7qqsCjUl2+CyjD5s4GlBfU5t5/xD+oK/EnhMsM?=
 =?us-ascii?Q?6Jki2vUlXejpj51b0sDgPL1jhSx/VxNXgkG+t06xFgNaohE0fzgu4bNwiDDs?=
 =?us-ascii?Q?hhMWemXH4vWMY3BNdi8+4U8e9EdGwBmOu9gGRfCJKKDrQmGksH+3Dil4GmCp?=
 =?us-ascii?Q?WZ9Z77XsjVOstE/kNg6LctJ0hgj0SJ/lP6CZ7gwHgyvi2ERfjoBhdx8e4V+J?=
 =?us-ascii?Q?6E8wzn9NddFUOA8xcAPcilmWkRIRtVnCWLmmWboQsVNxrfg3QlP8/yT95pIP?=
 =?us-ascii?Q?xNYNdc84kNbB9+1cEAGIgtFold0yoshsCKodXO2wqYB/Sv+4TsUd3BMypd6C?=
 =?us-ascii?Q?9gmtfpeE+JZDIwoq/sZnYjGzPd5SHEh0kdVHW+jdX02CXDfyChaUJl1Rs1+M?=
 =?us-ascii?Q?jVBJfmzXnO8cSToMCdKy231plorokEs+d70o+KkDGjG3SR1N73ZyvzQwN0eM?=
 =?us-ascii?Q?C2RenAB7MNOt3hQg/r6fYwpuemDMd8DaZCnLLNzR7hD1hQoDNRc1RY081OUR?=
 =?us-ascii?Q?Qyx1q6EauMbUaKSpnpvow3l1ZrV8XDp6Hhrwm/0kjMCni+F2XFVjX4INhoYq?=
 =?us-ascii?Q?jG7K+rz7dF4Vij5Jz7kn8knq1Lb2BQo/WNSngrIDqOqUKk4LhW9g2+EDMwPr?=
 =?us-ascii?Q?30k5JgOOqlKhWoi4kOmkaooF2x8SzwpBBR71uIh9DSFttMj+ChpfLvCMiKXp?=
 =?us-ascii?Q?ZL4BcREVVGcwWXJ2hVIiEkrms4CZQUGX+/BFfxgpNzIQiocrFvrVYfaHDLix?=
 =?us-ascii?Q?odsH7bu+BUL4xaAzwBnSMitXIO0hpWLmOWqUZTp1IzR4ziB6Id3kY+R5QdZU?=
 =?us-ascii?Q?QyK2KZvdneVyrTMOuizDKC3nPgh3c0BtwRVMSosnkQ6LSLxD8J0sxL7BzwG5?=
 =?us-ascii?Q?LFgp+VHaZLAnxNRM3m5R7a/nE+Wzdh0dg1AYkh10kdC0uatIAJGj7JRS+utY?=
 =?us-ascii?Q?QmVMdszKhWtyXB4XDeB6NnVZko2s4Y+UwAkO0QP0xdiz+ggCRX8lo+XWbaOt?=
 =?us-ascii?Q?VEMOFk7RKvEXc5YRARKKXOZ1fxh66RSR5twms0aUA/VFG42ccjq4o/vwd+v4?=
 =?us-ascii?Q?MapvPs2sGtlL/7gzFQYC3niv1aA+4EjGd1KdgdMqMkiq9PaG/iwuKUMo8+SN?=
 =?us-ascii?Q?V6oWjE8FdmaPpmLk00lh3VfbNcIXjeIcEMdyB007RxEUtYJcuXWnD7Vii88E?=
 =?us-ascii?Q?DZNqUqs+77ngnFk5hZdc9lZeHlyUM59AK9t4Mb9Q33fdi2ehCXBSok3qCtle?=
 =?us-ascii?Q?aQPNufovMD2LKhbRFvUbvTEBl97i3jIZsBTRwIGNk7GbTU1tEodAyiTqeLim?=
 =?us-ascii?Q?jryXcAiNTx6e9IK1FrJ/RGEWeraXWsk/CkjSSpLsDSneDP4vkJa5dohgnN+8?=
 =?us-ascii?Q?sZALIXKivl/tn5XFd0pWDNnCJUWOOHlxtAUarzzynl7FWWwYROqpOkd8crir?=
 =?us-ascii?Q?6DYB547q9hWKIf9pS8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:49.7469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af45afb9-5338-43a4-1582-08de0a7a7af2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8910

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Add empty line between variable declarations and code.
---
 include/net/tcp.h        | 12 +++++++++++-
 include/net/tcp_ecn.h    | 11 ++++++++---
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  7 ++++---
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 8467c83e4aee..08ac4433535f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1195,8 +1195,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_WANTS_ECT_1		BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1 | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1335,6 +1338,13 @@ static inline bool tcp_ca_needs_accecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 0cc698a8438c..a7ba21d298ff 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -507,7 +507,9 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
 		 * +========+========+============+=============+
 		 */
-		if (tcp_ecn_mode_pending(tp))
+		if (tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		else if (tcp_ecn_mode_pending(tp))
 			/* Downgrade from AccECN, or requested initially */
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
@@ -531,9 +533,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 				   const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -545,7 +549,8 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) &&
+	    (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 27fba14bb3b2..4a6abf536dbe 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6828,7 +6828,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 2ec8c6f1cdcc..1fade94813c6 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -488,9 +488,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
-		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-				     TCP_ECN_MODE_RFC3168 :
-				     TCP_ECN_DISABLED);
+		if (inet_rsk(req)->ecn_ok && !tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		else
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 	}
 }
 
-- 
2.34.1


