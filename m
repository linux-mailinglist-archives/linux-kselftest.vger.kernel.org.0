Return-Path: <linux-kselftest+bounces-40971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C0B49710
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1175B207132
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D531577B;
	Mon,  8 Sep 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GgG1KZS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F6314B70;
	Mon,  8 Sep 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352871; cv=fail; b=ev26JF+p2sMa/D3i6Gp/GIOuGuZ57HlOTk0o5mdPMvAqG7Duqivupc8TvcJ9FPsOUsGWDFngZwpxZMykKBhmuDZCr6DUQ/dfC5YvQ/wi/K0WtZS5tTUAyJxitU3DP1rL8xqD87K+eZ2EVdYxqLxOiGsC7YZX7e3/ecWz5d1NN8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352871; c=relaxed/simple;
	bh=y2vo6ciWDHzcvUpSHpYdjzvxs7Kiw/1xsUYCsOJfX5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6ZerwUPMAaofGf9tUnSr5GAC63GJN8od9OuLj0w5Cw+xfVc5SxFo+LjxoN+g/sqW0av1/OIaa2X/VHnQ3NZQBOduwtaNElUhqtRIPQeERmwC4qrtcrF4qKajvaPF+fAZgHvYrc6ODZ4E3omGpIWFBoV1+J30GZbx8Pk/WkFsb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GgG1KZS6; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsOWJ4iK9N7V6Ul3hUoE062AZdBSBVLSbZlbrOZ+C86P9ojayM/Gk3fk8GSo1E5jmzKH5UBKJsM37abQr9OjUu/+HKu0Gp15CiyIusUkH2sPN+MLn1Fkh1XVHvGqXMPq9vf0hkk4jTPYfDrzBrgjVSM69xDUVnZ7nBQzevNJpEzOi80eLXnvDuRdLKP/lnc5ghn9M+5/bYP+sz4Du/Ph+CR2puiBeforkrSW92RFNNUnl2N4W7QqDTyF6QOzc9x1xe8Jfe9pOY6M4cfZrPG/lQ/veUIH47xuSHUqvXQtfCK5gB+osjgGt08bPxV9kLYqITU/bhc0XAL8CbqUi9PgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYtNQOpgqfskPUYJny1nJBfTOujYJnp+eHZ87foCQsc=;
 b=XHyQaYLNtNJAPHe7uS+evn7bI3iuqoosxJ/scCtCqI0mmxm4b72YrrAbtha81eesL/ru70h9ZCuCTzY6OSOznnTDCbsDvjAtM0qV23D/xaTTBB1E/Py8sUMKgSxXMkdO8alPrzo3RgbJwTlNRDJg5pQzWuUY5ea0F3Y+O7Cqo6oSkhoE1io6Q/RiCWfmcT0Y1a3WUej0zceyrR6tt+lNrpnajESjuDSF+6Opz8rhGG606sDm375pJJiU4T1caVrwfEr96yDekgNuxBWkAnvxGVQCvMuFFnIsn4OKz1Z5YXHprY969YJUdG+M8Hv+5kAUpRaQBsJiyakJWR1H83PovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYtNQOpgqfskPUYJny1nJBfTOujYJnp+eHZ87foCQsc=;
 b=GgG1KZS6/T5kH1okWsvOW5iFGZnHpwODAlnGG4tgnQ8ft22rwLTdP2mom7RhUhaKD18iUx8hVu/shYr/4J61PZEn4B3+RUhz5szqCDlZET1jar0pJBkGHofwzwhvFIux6QShS1IGoBT1lEt3PDS67PfcvVekHlAh8zqNHNaDE/a5kdsQJPTFuJPBh7YQ8OYFGPe7DENO554P+S78FjiE1MnaMJKwLy92hcP4NV4jHhFTtX7FAlSkHhjbgKHlvLMEbUqLCPugo94aJkxgnQV461GAK1O7cv/3L4lFpdyDYiPWQITdyD3VU2MsY/oBu3ixqobRcEIKFFeDyms74pVEmg==
Received: from DU2PR04CA0162.eurprd04.prod.outlook.com (2603:10a6:10:2b0::17)
 by PR3PR07MB6524.eurprd07.prod.outlook.com (2603:10a6:102:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 17:34:22 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::6) by DU2PR04CA0162.outlook.office365.com
 (2603:10a6:10:2b0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7D7AA1C004A;
	Mon,  8 Sep 2025 20:34:20 +0300 (EEST)
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
Subject: [PATCH v17 net-next 04/14] tcp: ecn functions in separated include file
Date: Mon,  8 Sep 2025 19:33:58 +0200
Message-Id: <20250908173408.79715-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B92:EE_|PR3PR07MB6524:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eef92f50-922c-4937-c650-08ddeefdf29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+m9p2Dv+4h7dJrbBkuDWFC6vOWszihNhD5lxxjg/576fe9e9SRhT2GKg/0f?=
 =?us-ascii?Q?Jo4FzEsfG7dzjWvqPJC0uMBXdrJNdQbJRr2p29QG/+P+PurGYkMWU4m0cwsI?=
 =?us-ascii?Q?MYGBvyBntu/JRcPmxNnY9ytECw6Cj8cHIFZncVTcSGrsL5Oxmxuq5EXYjeGB?=
 =?us-ascii?Q?zy9Q5Bq8wcGbtmKBZWqNsqBJHNRL1qCJ5E/PLUtCnGXwUSdmQyCN7Cii4LLP?=
 =?us-ascii?Q?vpZoI7L4YPmX8futDO13N3rwq8gQYHpWoqAyvQ2UjqdHDGOKg9PuT+GWo/7W?=
 =?us-ascii?Q?LEvrVUSH1JNz5flsKbzIU8Q7ED7aF43EQt9Pg6+dZTSl5EwY6kHzlfMmx8KR?=
 =?us-ascii?Q?7h4Fi53mCuj14Ga5a18R3ieeKJJGW82YNVY7pzi8FHNznzIFKDqHXYo3T7T+?=
 =?us-ascii?Q?LSst6fh4WQaJFKRkC7iR9no6FXuS6wVCsA39/eHHwYPDSY8BVzJwd1219kc4?=
 =?us-ascii?Q?cofd+E/eM204Nuce6HDLG0/kc0DpYwXebcE1st4zZhaY06Z2xUNeDigNWjtr?=
 =?us-ascii?Q?wOKqa/n3wlYrLW/do7E4OMEMMTLWkOViPL3/sb2J9SG2eLO35ZOe/uH0HLBi?=
 =?us-ascii?Q?y7kZzcGunEIWNzCjTDfZufpu40145PapzPE1WON20mU1e/r0wFwGbDW/ox/S?=
 =?us-ascii?Q?Wonb5OWOZoZNjRdc2nEdVN1DsqfurLzD5w8y1Jp3O0uXc6S26XsaVLKeNcJp?=
 =?us-ascii?Q?9y8O5N0CnxNBeimZEjJ7q239xBfpMsKZLoKwz1EMarhZnDFOGA4kK5c/mY5v?=
 =?us-ascii?Q?+XZ0acEMadm/nXQwelIsFTUnVdc+Aco++VXxFnBs9vsZn3PRTNVQ+iTGZOHK?=
 =?us-ascii?Q?UnF2U1osS9nMbk+aG6ZVRQvFiwWdJIT8yKzbi/1o7D7heF6DsNNA99TpUoKG?=
 =?us-ascii?Q?swOJPNons+IGxJMqnnG4PP15ey7hjYY78oM/VZGTzW/G58Nn6DEtff1dUXRk?=
 =?us-ascii?Q?dJqfMkW6MY96zyyysYPZqWzwohPWN+mqEhvT9Qktm/CIhN3igrCvQg0umJEr?=
 =?us-ascii?Q?20ekcQHMkTCNsnpC6CxdnysElBdw+hmxLKyIhIW2pUeFAl4eDnFP8+y8fpjh?=
 =?us-ascii?Q?Lb7LEA4hm3C0euVZqrWEBTYvR1FXy91euOj7bjISk/akk0n1ytp1DTKfrUY4?=
 =?us-ascii?Q?WFOkVSQshqmVRuygQyOYKMIZ8j7KfBSGG4U1tGsk9tkCKjxCarnbqIrJKNAO?=
 =?us-ascii?Q?URPShNYR7g7rmk9f8C5WfNWlUarPSbZ0A2YbT2/a/yFCYTCKLDEYTFdAo4ox?=
 =?us-ascii?Q?4FUUBkw4kH8MEMBYXZDmrFI+W3hGkWanwE+5jRQeRoCWxR4G31FJjFI+lN7C?=
 =?us-ascii?Q?3G7NtPi2A3o5NVmb4YXYBJhz5U7PGg3ym2sylhjk2pjDbShdt55voKdjjSk0?=
 =?us-ascii?Q?q7ss9vmMcXIKuVicitmIm/cweO5qAlJ7vQD3xPo1PK/0Yb+MfLb2783aeFab?=
 =?us-ascii?Q?qSgPKEhd+gILzQHNaigRoMlvrKKmTQe+d8eeqtxSvBvcVfMx5p5kC+4PSCXz?=
 =?us-ascii?Q?qxzTNPNxIjXFTFA2NnM2g+0Dg+vokKxVC84lb3jURVUI+d39qi2knAHsRQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:22.0247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef92f50-922c-4937-c650-08ddeefdf29d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6524

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The following patches will modify ECN helpers and add AccECN herlpers,
and this patch moves the existing ones into a separated include file.

No functional changes.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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
index f1be65af1a77..b2793e749cfd 100644
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
index 54b8faa3ad95..be8ceefa5332 100644
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


