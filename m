Return-Path: <linux-kselftest+bounces-37817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5FB0D697
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C33548866
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259DC2E3AF4;
	Tue, 22 Jul 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="HvXY0YgZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CD2E173E;
	Tue, 22 Jul 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178391; cv=fail; b=G6CnyIDXwBZ8m6/DP2Jaf3AfdxmFvNvuM2fihz4TcO96QCU3WLyzL+dFkVq6UvHPL4VQnfVUvuFxCwCQqC2qN9si06fTKsILIt+iHuPhuRCtQdV9eSOxoW4Ge8U+59QfwYerAlxf3VG2yctY5fY73z3WAk39TqNfAxUppGjVvjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178391; c=relaxed/simple;
	bh=Q8FPCaoHZq1a7DuJEY+w8xFNnUK2q3LkKbQDGOjFsBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TP/+cSnmSjPRPQainfJzVeLl1V976YtU9u7YYejW3CSGgaVjXNHCo/b7EBiY92/33bWKQ0OOZlsbpwhdOMkrf/tluxL11QRTkglg2hTJr71Wcd7hHuUNObPcI4546GB3YAme5/pqDIn3jJLBCo7m1O5CzQGNFdxXfwYBvrPgQas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=HvXY0YgZ; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btzrrhzIhFsQt8PstUbLWYKgvn+0OokHRSKplX+YxOIlDoXkLPf1uo177CcFVTJLzfxpZ55wCmkhgYeEyUxsmsh5hvve+q6GdY2Q5MzTEGy/mZpKr3J492dvpKYgnAR+spJ1jFIIrXNYy4wKrF57V4W2uF3Qv88FOBASAnhbRBndAXAoHxac1stUkPAIIdTIa4unyUA45JN4x/3kp16a2G7+rydJeQ9qr+iRIf2PA3oWtlqGtzOqD3BOBs4FxdZ/psIe5tZMIEDD/q9d2Weh390PKNSMJd7G9/uGQCe7XwAGOdoQhUvaOUvt33BiBbzE+9dzK6kKYl/Hifb/Mn/A3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qtQ2zftR/aBSzuvFVCvD1eTCNdwXF1Fa0ITUy7UcBA=;
 b=NZhz77XHzjpADeuLotH+OiDx02MJUIrxLPSeAtjChTm7oRgdop8rw5400udips4GxSYD3X4kFHREvHdCa1eksva0gck119Qb1DpqkzaDX6m9jcP3ZoA2AJN/lSWUClH/u3DKCCNTG9SKdI6zn2XhKDy222ySksgDl973tN9pEh44JW79P7aSVdhhZJhqkP5acsjjjhKNZUY78vcD6MSY0LyI87ZkEpiTAne7RZ9wy2aV3cTR/m4HpXoMpDQGfx0dmA3zrlBRrMSRHlSyYlUIp8P2bOXdb3eSli20MYuc459OkcBGnuVSnURDDfiCc23Gfl7keXG2eizEIWsitIF6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qtQ2zftR/aBSzuvFVCvD1eTCNdwXF1Fa0ITUy7UcBA=;
 b=HvXY0YgZYDPbT4xQA/mcUuv85jLLKKYcSz/yw82Rqx4BCqTuyLUIJoJyX91D/gVAHO8f7mc3fZIxQhYwlmZccalAJnSU+Po8D7WKeMZEeV1m8vdnV1Hv4vwnMA31ZYW7CKUMCUJnl+pbCC2CruhVyNznGum7V4FWdhW9BpBhIPE50mNAbdyuZF49P5r6UXOSX9BjY5u+D5Yqy8SsEs/GnShsBfeTbKVd9AMELtIHkJ6+kWrZJydxARTBsEb7PAXsrGqCz6ukj07Dl33fJo3WGVxWbsRcmXCgjfxn84BdvTC4gTmSBaGcgI8+22ro2CnkqbE4XqtLQ6YpyOe+DJlaPA==
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by GV2PR07MB9033.eurprd07.prod.outlook.com
 (2603:10a6:150:bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 09:59:43 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::3d) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:54 +0000
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
 via Frontend Transport; Tue, 22 Jul 2025 09:59:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 2C44568002E;
	Tue, 22 Jul 2025 12:59:40 +0300 (EEST)
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
Subject: [PATCH v14 net-next 04/14] tcp: ecn functions in separated include file
Date: Tue, 22 Jul 2025 11:59:21 +0200
Message-Id: <20250722095931.24510-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|GV2PR07MB9033:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d6a3ac80-86a8-43ed-a449-08ddc9067a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6SQyxZOEFdRafZOv/iQYiMfPLYvfbl+bjogZPl8SeCuGK0QGJQTfD9prBno?=
 =?us-ascii?Q?NUuvBPMOkSgQhJZHik4b3X2IWfpRxPbG/Uiepi/KqtJi87284jAfH3cxw+u2?=
 =?us-ascii?Q?zFjTB4bH0mhVq/fZ0/Y6QHHUGUa4EjJigh9qVnmDl93bkMUVpgGuYoyiu37k?=
 =?us-ascii?Q?MXBFZdTMhIbpT/qTa47ghDtl0wKqMWorD2CbmEbPou+K4Ni97d0H2+m5qthj?=
 =?us-ascii?Q?MSdoLfW0UKsicUwPBnAYj4FORtcpIhh3/MOkJEQeN6X3eXp1k68xam7WxqT4?=
 =?us-ascii?Q?H2oUQJIfACm0FkHTueMncM49+JgrZBwCQBLZ/Xj8/e6XUpxs93S5Y65ZuigD?=
 =?us-ascii?Q?FQOvFsriMhnUS7E9g1JSGabopsa8uEvdeBFADETqvwC8V4ZqoydDGRvw+q4d?=
 =?us-ascii?Q?cn/m9XSgO5n9vPyMatgiKv/2T7TXU1//XLyNsi7u52+Y3yXimW3+SsOpe6BI?=
 =?us-ascii?Q?Z5AvSpxytHK9fgppd2/Xb8FTlzBmQLi/pqVCQDIaa7XZdVKdwf2rpLJBQ5U+?=
 =?us-ascii?Q?tHPVoV/gItlkKmGRUmRTOoLLrW6rUUNJGGifaacIOJDylgni4ro/u43PQY0P?=
 =?us-ascii?Q?RZbzKCmNGFWCLx87N9HY/K1+9H+yTltFRYNFbTkOeBc+tRSrlWa9fstUwO9M?=
 =?us-ascii?Q?T6wnG8P4xwdq9YeXK6ZZCpaZDWG2x7dwzJljR+6QynJLLIar5SAwLm25ETcv?=
 =?us-ascii?Q?w1bynlHm13olgh9MAjsLYB2dkh9mjyrr84vcXXJ5aOtrcxbDHfwlc9AhuAJD?=
 =?us-ascii?Q?F7MOWdyDKjpvWZ/l+4ygcSGYJ6ccMEaW9MNGGvH4P6z/oBSdKf4L2f4XuGGh?=
 =?us-ascii?Q?x9N7kh0mmWn/nQ4OXTxTY6UlEfncyIEEve1lPNr8czGHXqhPBne5EnNF3lD8?=
 =?us-ascii?Q?gdo/tmh1YlnH8ruuvDIU+My0f6FcvetuP4IzkVwSzEN0XXp2z//oisrfeF/H?=
 =?us-ascii?Q?zS2hnW8uktUZgLeJeqmfBODHjtB6PBkeDSPoe39PPwfmpuuNjP6alAmUfqh7?=
 =?us-ascii?Q?noQO0ePvEpDknAHn1VT3WiFw23364YDSlQuBgcQCtFOuXrzp4YGZgCrE01mJ?=
 =?us-ascii?Q?K00cq58ty0yWulQodpNCv9LhO8wIzZr9SBz54gkcjnWIiTJjQOdNNUqcEsYc?=
 =?us-ascii?Q?vEqmeClBKcOlxproWoO6pdd3/xqs8vIPUwIsyrzaEPkqKEfSxTmpsnt7Xjc0?=
 =?us-ascii?Q?6t+rOGlp8fhvOUh4du576BSXaF1d+rh391zewzI9z2AFdgoiFT3CdQRZYe6/?=
 =?us-ascii?Q?FD5YYHe25wzcQfK0V3uRhFIyCDLUSc0Od1cVvYw9NEtMPSRbeQc41+zQbjlD?=
 =?us-ascii?Q?TYRV4jdmkje3muYrIX8zCO0r9RZdS7mcdip378SWelcvD8eqqJA1zdgEcce+?=
 =?us-ascii?Q?Lpi8wegXWrYPhr47O+tZXpFboRn6KEhM+E96L0RNOWT6V9pWTMSEqG9ARvPB?=
 =?us-ascii?Q?ey5BNMBy8xCQ7h6zihXQuc2l3feW6CVJ4khz89SwZj59u+Cy9klvXuGu8+XF?=
 =?us-ascii?Q?1NmtZyTOc9sLFFz5moztciQHWA8lmja48NAl0kFeGrP2O+N1Ey5aV7O0Cg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:41.8567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a3ac80-86a8-43ed-a449-08ddc9067a8a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9033

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The following patches will modify ECN helpers and add AccECN herlpers,
and this patch moves the existing ones into a separated include file.

No functional changes.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp_ecn.h | 116 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c  |  45 +---------------
 net/ipv4/tcp_output.c |  56 +-------------------
 3 files changed, 118 insertions(+), 99 deletions(-)
 create mode 100644 include/net/tcp_ecn.h

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
new file mode 100644
index 000000000000..b3430557676b
--- /dev/null
+++ b/include/net/tcp_ecn.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _TCP_ECN_H
+#define _TCP_ECN_H
+
+#include <linux/tcp.h>
+#include <linux/skbuff.h>
+
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <net/inet_ecn.h>
+
+static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
+{
+	if (tcp_ecn_mode_rfc3168(tp))
+		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
+}
+
+static inline void tcp_ecn_accept_cwr(struct sock *sk,
+				      const struct sk_buff *skb)
+{
+	if (tcp_hdr(skb)->cwr) {
+		tcp_sk(sk)->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
+
+		/* If the sender is telling us it has entered CWR, then its
+		 * cwnd may be very low (even just 1 packet), so we should ACK
+		 * immediately.
+		 */
+		if (TCP_SKB_CB(skb)->seq != TCP_SKB_CB(skb)->end_seq)
+			inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+	}
+}
+
+static inline void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
+{
+	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
+}
+
+static inline void tcp_ecn_rcv_synack(struct tcp_sock *tp,
+				      const struct tcphdr *th)
+{
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+}
+
+static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp,
+				   const struct tcphdr *th)
+{
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+}
+
+static inline bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp,
+					const struct tcphdr *th)
+{
+	if (th->ece && !th->syn && tcp_ecn_mode_rfc3168(tp))
+		return true;
+	return false;
+}
+
+/* Packet ECN state for a SYN-ACK */
+static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
+	if (tcp_ecn_disabled(tp))
+		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
+	else if (tcp_ca_needs_ecn(sk) ||
+		 tcp_bpf_ca_needs_ecn(sk))
+		INET_ECN_xmit(sk);
+}
+
+/* Packet ECN state for a SYN.  */
+static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	bool bpf_needs_ecn = tcp_bpf_ca_needs_ecn(sk);
+	bool use_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn) == 1 ||
+		tcp_ca_needs_ecn(sk) || bpf_needs_ecn;
+
+	if (!use_ecn) {
+		const struct dst_entry *dst = __sk_dst_get(sk);
+
+		if (dst && dst_feature(dst, RTAX_FEATURE_ECN))
+			use_ecn = true;
+	}
+
+	tp->ecn_flags = 0;
+
+	if (use_ecn) {
+		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
+			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+	}
+}
+
+static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
+{
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback))
+		/* tp->ecn_flags are cleared at a later point in time when
+		 * SYN ACK is ultimatively being received.
+		 */
+		TCP_SKB_CB(skb)->tcp_flags &= ~(TCPHDR_ECE | TCPHDR_CWR);
+}
+
+static inline void
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+{
+	if (inet_rsk(req)->ecn_ok)
+		th->ece = 1;
+}
+
+#endif /* _LINUX_TCP_ECN_H */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 672cbfbdcec1..75b9723998c2 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -72,6 +72,7 @@
 #include <linux/prefetch.h>
 #include <net/dst.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/proto_memory.h>
 #include <net/inet_common.h>
 #include <linux/ipsec.h>
@@ -339,31 +340,6 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 		(icsk->icsk_ack.quick && !inet_csk_in_pingpong_mode(sk));
 }
 
-static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
-{
-	if (tcp_ecn_mode_rfc3168(tp))
-		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
-}
-
-static void tcp_ecn_accept_cwr(struct sock *sk, const struct sk_buff *skb)
-{
-	if (tcp_hdr(skb)->cwr) {
-		tcp_sk(sk)->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
-
-		/* If the sender is telling us it has entered CWR, then its
-		 * cwnd may be very low (even just 1 packet), so we should ACK
-		 * immediately.
-		 */
-		if (TCP_SKB_CB(skb)->seq != TCP_SKB_CB(skb)->end_seq)
-			inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
-	}
-}
-
-static void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
-{
-	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
-}
-
 static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -399,25 +375,6 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
-static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
-{
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
-		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-}
-
-static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th)
-{
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
-		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-}
-
-static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr *th)
-{
-	if (th->ece && !th->syn && tcp_ecn_mode_rfc3168(tp))
-		return true;
-	return false;
-}
-
 static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
 {
 	tp->delivered_ce += ecn_count;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index caa980c3f25a..2f1102616024 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -38,6 +38,7 @@
 #define pr_fmt(fmt) "TCP: " fmt
 
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
 
@@ -319,61 +320,6 @@ static u16 tcp_select_window(struct sock *sk)
 	return new_win;
 }
 
-/* Packet ECN state for a SYN-ACK */
-static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
-{
-	const struct tcp_sock *tp = tcp_sk(sk);
-
-	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
-	if (tcp_ecn_disabled(tp))
-		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
-	else if (tcp_ca_needs_ecn(sk) ||
-		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
-}
-
-/* Packet ECN state for a SYN.  */
-static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-	bool bpf_needs_ecn = tcp_bpf_ca_needs_ecn(sk);
-	bool use_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn) == 1 ||
-		tcp_ca_needs_ecn(sk) || bpf_needs_ecn;
-
-	if (!use_ecn) {
-		const struct dst_entry *dst = __sk_dst_get(sk);
-
-		if (dst && dst_feature(dst, RTAX_FEATURE_ECN))
-			use_ecn = true;
-	}
-
-	tp->ecn_flags = 0;
-
-	if (use_ecn) {
-		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
-
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
-	}
-}
-
-static void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
-{
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback))
-		/* tp->ecn_flags are cleared at a later point in time when
-		 * SYN ACK is ultimatively being received.
-		 */
-		TCP_SKB_CB(skb)->tcp_flags &= ~(TCPHDR_ECE | TCPHDR_CWR);
-}
-
-static void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
-{
-	if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
-}
-
 /* Set up ECN state for a packet on a ESTABLISHED socket that is about to
  * be sent.
  */
-- 
2.34.1


