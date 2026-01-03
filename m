Return-Path: <linux-kselftest+bounces-48113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAD1CEFF96
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE86830203B2
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB23430BBAE;
	Sat,  3 Jan 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="d50PLfCF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D030C350;
	Sat,  3 Jan 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445857; cv=fail; b=hWEQrmuYAr+maoVfOZNT79xdlkAJkKwFiMipeIMeUJFN84tAlZwceYtiD5uC190t1xf3nObZxElhlTmY9LHTl1+uXeG9A2YztVRrEqcMzLkf2H5M22bB3xpC9eBlzj8GF0c4qJ/dp3NkByo14RKzbWYE/YUQcF1FWbjsKbtLJVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445857; c=relaxed/simple;
	bh=Yz3LVGKV7GdIcFJUkL4roqvIAGL3HUpZUX4u59ThZzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRBKcBgmY9i1o8kX1oxR5gJHrpQ347Z2Gbi++TpjYrY9fs9SgIW811eT8NXREs9K4MxM9SopCURNQdJT1YFIKN6RoaxFUKGvtkkaUeVroUjtxZAnQ6vX8EaDr782JT8azW6Dm9J3IAkpie6Cq1/TCKqRZuJlLpdHJlNkPKgRTH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=d50PLfCF; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcyEknJ98uCFWYXtM09ABnZd2gLApE7PujicZp504F5kdQfBuBOiCeTXL7JL98DUntlaHEoj6QRJiPLYAKESc5spZUU0YZFQ/hOP4S7RMMRA7Vrve6UpyQMWGtQwgj1n0XLNlD6bU+yML78DKypbN5sPyrADxHSU96H0Mn/ZHVY953zsrNy/4F8GLtPv9UyEBWGX6Kh0LwXNNYbDyuLH0pPPljRNhXtLqcrgrGMgO17Ijm4pV8lyHVAZAVSFY8JBJyDxsxBr4d7Bs40uYeF/fkqELzX8Xjaq2AA0bX9kv4pUUW2pvv/RP+nn0iYqrwiHQjc46nHckGHkuH7Sdc319g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDGFihql1RCEocLlYIjABFWzIvs7MY+rey6BXk4miuI=;
 b=dOKDggeyPaVeuw6USmT9LmkErALZdb4a/4SQ9b6LiJ7qx9kQ0/Xdou2ATwLgu3pu8EjUK+HV2ZgBdGW/6Gixawx1Mx0yG5r3PpGvHWi3K/RE1LPj3XQ3s2LapYkDm4hN5OBZmpynocMbv+YJCwx0uMCM5mFSbF09Bn2J4DxWZ30L7ZHNTLsKX2TWdrHjYlPzG+n681UIXE9GlI82+04kpEbMTVoMaGKNSNm5JGF1Roiggh58y7ywIUgq3AthZhHUTR/wlGHYRFkDzTMyGSWaEzb1ozsO2nJoPmCJOkbs91Pz12pIdzbS//2ltnhKzFN4J+NcP92yBJPA6DkSdmSNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDGFihql1RCEocLlYIjABFWzIvs7MY+rey6BXk4miuI=;
 b=d50PLfCF3riAPtSbzyCYnjlZT+ygXj1en9J2AKTHL7TemEfHUR4p+jc47UiBtlkltHeA+Z+4nql2bUwOz5vColHPy8EyPqNAhveqZK8dcCyuNrb5EZnqHsd+PqAzAArRpY/W/u2jcqXedJYF11IfVaSsSBPmBun8j0Tptcc4j36gTs/ac6rS525qDSlG/mhds9rxcvRcclpFgCPsvO6plP8c7QFkASqOqNQ5fFYxriRf6jox3KiOBHtXHYo8CMz3AiSPfLR2cMWV23RR9yHxxG46bJ6HKbIAuSJ/SM7DmDW4Vc8RxUYOWd0qHmUZTPy+PdjarjiaikWIgT0aISc0Sg==
Received: from AM6P193CA0091.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::32)
 by DBAPR07MB6600.eurprd07.prod.outlook.com (2603:10a6:10:180::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:50 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:209:88:cafe::dc) by AM6P193CA0091.outlook.office365.com
 (2603:10a6:209:88::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id AE6FB1C0033;
	Sat,  3 Jan 2026 15:10:48 +0200 (EET)
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
Subject: [PATCH v7 net-next 09/13] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Sat,  3 Jan 2026 14:10:24 +0100
Message-Id: <20260103131028.10708-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DC:EE_|DBAPR07MB6600:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 63a25153-859d-4942-1939-08de4ac98466
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?UeLcw2QzHxwFAeS2iA6sEKPF19xYRQe4u0//S1mlhUv3sEDwx3Ila6hHiJlM?=
 =?us-ascii?Q?e6En3BNqY0k01UMbMg4lb5EzUmuQHAmhTVlB+xv+7UxpY3vLVAgnWR77wvcz?=
 =?us-ascii?Q?PF9l0O6F4l84TzBJgqH/y48IujUl82fbv/EMc/Ew/2ylGNWoEaf9UwY9RUW2?=
 =?us-ascii?Q?AUsP56dcg8WWiyChPjYPqQ9+IeYD9VEu4PmMmWTrNBduPuBCC57TCMuleQMV?=
 =?us-ascii?Q?fPur5cqBJJjfog16NEpaRvvoHCW9VlOntQNzcng04F2wLsa/yimkcJm0gLEE?=
 =?us-ascii?Q?cwc5XFJmBwgLMw8sucg5jU7sfr+drnPkGmcR267g8QbrFhGWO1SweZEZm+MG?=
 =?us-ascii?Q?WxYaBuG6KsIIL4r6Nakebz8QID8PgJwyIek/VLrYZoJhax+5TEF/+caViB98?=
 =?us-ascii?Q?xprgJMcOVgEJhtvUDKIgrAla8Otj61LYc/GHbYleJSjcVKj+WuaMhECBmBcy?=
 =?us-ascii?Q?ECfuMMEBUkXE7pj9mGD2lVFB7OkwxcQdSa8EkFW/U+pB+lz5QOialqELOzRY?=
 =?us-ascii?Q?AG4SQnVPTIoCcfhXmOewGnaBMPTx9BJyfemJQ7839fciJ70pi2jeQEgIU8V5?=
 =?us-ascii?Q?EtAoAx3G8SvPz4z+4EPtPbcHVy9VQVEembWyMwE8hqF9OCXxi1dvbgdoVHvs?=
 =?us-ascii?Q?NcI72kVi8uHZvgcxwlXlKL2utK1mRaCbKup2Uj+/vKSArJPl0H2IdRMTgsUh?=
 =?us-ascii?Q?iE7fOAKzv/7ASiiJG3gXK+v+O74TfMLOYYSuMNkp1i1rZ5Mym90ArJtEapJY?=
 =?us-ascii?Q?1CzGFMRzHWenRqur+sGPZK2tG/2DwO21vwqeM+h0xWi0PdRpHynmK/nsqEQ6?=
 =?us-ascii?Q?hfUtVx6PU++f8rIsNGPhHIm0NIsU/9JoE4029CinrI7PWyfHC65nDhJqJXkg?=
 =?us-ascii?Q?RTOG2gsEIRdP8DtIOITLDU0RPZf4m7ApixARYkL8HmCZBHhZMTyengYGjsbx?=
 =?us-ascii?Q?8nqvUcRmp735M8IXBbmyvjr4UJgsmjuI4ACAV5+lYVrzmXxaUcGYKRWou1mR?=
 =?us-ascii?Q?BWasCnVC0e+6tq9JzIDY3IYpT6M2jD1WiqC1v+lw+PQ8wwzZUlM8Q7AA9Mrb?=
 =?us-ascii?Q?HIla22iUwZJNUcj94pnYW0QtsfOlPD5hA9zExAn/NIgSX22IQI+KXdYoXHvp?=
 =?us-ascii?Q?y5RVh7BTtp0TyXXjMd1VSwJ941ztysZ9k44nUAbPFlceEcmlr4fXPAaQxC7I?=
 =?us-ascii?Q?7mmDAQyG9eaFl3676TenbNMLSavZrQnxzLdB6QB20F7PKm9aWtRlfToGYrt+?=
 =?us-ascii?Q?slavzcOiSFiBbEcGuCaamwG7n+AWS3540rm04mWSEWlcJeNtYY4SGq12u+qN?=
 =?us-ascii?Q?KNK9f33VTRgexWMrKca8/WGjC9+frk/hWbeAbGrdgY9HBfUjTpY7/XMlLQus?=
 =?us-ascii?Q?ksJ7yvgRE20HpyjeY6VuxbnuCrPG9NnDuoxDP6CvSgd+b6Qp264wzkQxa5Hg?=
 =?us-ascii?Q?WCdFjDwxNlKXO1VdW0rwlaVcufoQIIGufyBNttDVaxwA706Z/hhGCtNtJjMv?=
 =?us-ascii?Q?h8vtogAV2spv6qBAomucuokPJXZmpMDBWb7ZocvS+aTs9xP/tlrNE09Tgfo9?=
 =?us-ascii?Q?kCU9ujtIWMEa0zQOY+zdc1URjyK5FLZgAa3SuUuq?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:50.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a25153-859d-4942-1939-08de4ac98466
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6600

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit such
a SYN/ACK (for example, because it did not receive an ACK acknowledging its
SYN/ACK, or received a second SYN requesting AccECN support), the TCP server
retransmits the SYN/ACK without the AccECN option. This is because the
SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN
option. Furthermore, if this retransmission also times out, to expedite
connection establishment, the TCP server should retransmit the SYN/ACK with
(AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining
AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN specification (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v7:
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout.

v6:
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans.
---
 include/net/tcp_ecn.h | 20 +++++++++++++++-----
 net/ipv4/tcp_output.c |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb..796c613b5ef3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,12 +649,22 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
+		    enum tcp_synack_type synack_type)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	/* Accurate ECN shall retransmit SYN/ACK with ACE=0 if the
+	 * previously retransmitted SYN/ACK also times out.
+	 */
+	if (!req->num_timeout || synack_type != TCP_SYNACK_RETRANS) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5fa14a73d03f..c6754854ad09 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1106,7 +1106,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -4004,7 +4004,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack(req, th, synack_type);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


