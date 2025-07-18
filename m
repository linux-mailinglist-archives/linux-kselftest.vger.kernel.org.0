Return-Path: <linux-kselftest+bounces-37569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E934FB0A623
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956945C0392
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACD2DE6F1;
	Fri, 18 Jul 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ak/paFvz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD92DE1E3;
	Fri, 18 Jul 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848461; cv=fail; b=sjbXtyJeYzoLb9ZILNcYPxWz9V8HKlO6tEFX/lhIxZIC6UL4XxOdeeQuz8vYiq2yoJf0f5eahhPpuP6oP0Z/pegnJpEhKFSBdsTcLXALoQNR8ktMGGGFk2Ierte1IXmDJGWfUJ9zNlgjTA0bq0ZP9vgZ5QYwmOwECI/yFO0Q3uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848461; c=relaxed/simple;
	bh=Q8FPCaoHZq1a7DuJEY+w8xFNnUK2q3LkKbQDGOjFsBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYEIntW+gNwiei5bU0hWcj9Ys6hBVzpbe0bWQgKx7oB3A61kLPAq5uXsHvAh3317L2KC8Bz/Cw8vWhwH/mLSetR1f3RJ7BG01b9PuHLIhXSAk8tU7IURtMtZ/7UdNOjDYurobPn5n61yCzZJlZPxb1L79IFNx2EciRf+2dSLuss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ak/paFvz; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BooyUXzdMOBu+Q+P7yJgUyzgA6gnBSLBGUFMLaiLpllmG4FxMFsbYf8xsYvR9nchioIPmO6qHiagdYIEzvmf1yhb+iPImI6vnsfSA1gqJ9CuVN8bgvxS+fHvAUszMV2dQUFoflycZBOUo4vbchVgNFhATkyv/qTQJ8aEKbEIUQv7jB86vhXJ4LYRN3srBOpVv2AaplLhlFq+FnLVuS34wNViY5eMl09upw+uccVwUm1KUdJNMOEPmzmc3uuS5lVwOiQmI7EAxkVuybj5jleSeICqC7XTi2OrwZ8hL1FgjcIPb3R41UcswVVRAIwZLoNzFNS0uJJHYBmYvc3lwq/YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qtQ2zftR/aBSzuvFVCvD1eTCNdwXF1Fa0ITUy7UcBA=;
 b=K//31DrTQvA7cYYJg+F4csqACEZgEifmAKCJ6cdYEpNwC6XWZCBnW+PuxjiJGk/BWHAOIIf/FBaW3oewYXbHzX8tnU4cWPPlvNRiURgk7QiQ2vku8MGGQxxGnbxNUx0iEoi0XUwDJq5bwJgr4Q2VB2GM30gCw9ajz9vKHp71NO0DB6HGRKWSo0TIwzbYh+si8IZiZNYabMYqHIvyzaSXRotSRVZgm27VAyRYgwYygr/KfnzIZZP8iEmAiuV0lphm3bKvyAYzuaKM2N2t4W6ns0wlkYd848DTDLwFxTWXkGMGDFv++NARCJ7A9kdBXstE4j7VeCgV9rfk289aIzcqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qtQ2zftR/aBSzuvFVCvD1eTCNdwXF1Fa0ITUy7UcBA=;
 b=ak/paFvzs609amRzGmHwCaOOloRiG41CLZrwpqztN1MNoBQ448qMlkSRVDD0lGS1JpRpDSNUcmqR7CgL/p2h4Mkx/59cdxhQWezrkCDojDNXBkHJT7r7WCn8rBBTONOP0ysxcCd/zWEHbApDUkt1B+7t8mPvA9sd+bVmO5PIGcnZIDJv09y46fSFFrbuaNOPI+/Ehf62/vuqLZ/DEQn9SG6SY6GuUzIYz3KChthtba25+EY3TctykI3ug26piEpEoUcNiGCYeCCD7Eedy9RCQ/EPP+eF1BwgBMhiY5KCXTYWMN3jSD8fo0oVLwzGCGCcBsjSheG1CLUsdxtU2IVsuA==
Received: from PR3P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::30)
 by VI1PR07MB6608.eurprd07.prod.outlook.com (2603:10a6:800:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 14:20:55 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:102:b5:cafe::92) by PR3P251CA0026.outlook.office365.com
 (2603:10a6:102:b5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.25 via Frontend Transport; Fri,
 18 Jul 2025 14:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:20:54 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 08FCA20119;
	Fri, 18 Jul 2025 17:20:53 +0300 (EEST)
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
Subject: [PATCH v13 net-next 04/14] tcp: ecn functions in separated include file
Date: Fri, 18 Jul 2025 16:20:22 +0200
Message-Id: <20250718142032.10725-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|VI1PR07MB6608:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 56c749c2-bfcd-486b-c02e-08ddc6064e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YWX8nd19Atnk7kOmaUfRqqC4SMeBef4ctpL4xHjry+MgLI8zX08DAQmQC/Oi?=
 =?us-ascii?Q?eXGH2pm1HG/tDE2WJRI+a+3AEUfIFHX2IPAtps7BQlcKvBJX2v6riowVbtjE?=
 =?us-ascii?Q?6BPDNNpWm0MSpXc9rpOjH8jXW8AbQ0u2qFaf4JjRoQ8o1MfwCcKL8RlJ+hFU?=
 =?us-ascii?Q?PbWCc/IW2JNIBk5uq8EcdzFUuCp7NfXhAOrioT4jlbMd3rx/ZQX1zUHr99i7?=
 =?us-ascii?Q?fEbqnQIuK7rkvssNDrdETV98Oaak3tjS2sDnGZqWRWA1zr8Lhk6P/wuZOwv1?=
 =?us-ascii?Q?v3Nb6cLa+scvr6sdd3gmyKk22mQo7o8r0yzOiD1F6uMipBKZ/5/7mHdUL0NQ?=
 =?us-ascii?Q?eNkw3a/aV776c3cuWK6GW4PsciR7Vy40tHU0/ENsEk3+mujqtehxlCEYuR3t?=
 =?us-ascii?Q?jAA2DHndosaPTywAAmpwmZbkwBGv+t+qKOenHQG7nt8gZlrVyh4yL+1OLsiV?=
 =?us-ascii?Q?1K8CR8DuLI7LD/1ceNjbWCLO2iMYrt46kqHBE2aIW0RDWn8c2/ZXEaPP7Ee5?=
 =?us-ascii?Q?aYNkoGE6RYGO07qdkMc8ZD2lWapkbljeUFMvg0n/l+0fJ/tCNWWPuSqRdGQ7?=
 =?us-ascii?Q?7omyjg85Zb3IP8lx9DcgJNdZQChVJWUbUMskfhtlDGTXIVQFw6TJjMCRCteJ?=
 =?us-ascii?Q?ePff9FvEymMTnTtWpNoB8/4yU4NmFe5sD7tdUm6V3kgveiG0s5CsG9JYHnkn?=
 =?us-ascii?Q?XwPzZh0Ahmcb8FvR8N2lHd8fLFRAlqur5heCcuRE3ZVWTXjj8N8InQ6143yh?=
 =?us-ascii?Q?VEjefa95fwjJ5nFiQe+ASFEWe0lYwQRQZPFCxkZfYXXzUQnp8bWSItB28UIG?=
 =?us-ascii?Q?jm19kg1OSAVjcn5rXUa4HV0HjPncrS9FcM42Q9wkkx/FoRSVOf81Uai1+grw?=
 =?us-ascii?Q?HOxnhFq9KMut+2/f/JmIQ1BxxnlfnvKm9HyL0h+fIww4Hy2ijYNpGs+ATCXJ?=
 =?us-ascii?Q?6sDeXcarwsx/HsVuN8xCF/evBUsRLFpx9pbkjQwF4yeJIvrZGkUic5xJfYM3?=
 =?us-ascii?Q?ZOGaqfHEFibR3m+9JINmE41kKOmPQ8YCStgc87PtnEk3zUZ5/pHEYPiW5nJo?=
 =?us-ascii?Q?VEGhYcyDsa5EOM/eaPo065mnqFf5Kq/1cCf6whkIcEJzWZuaYfTTwMPX9KIm?=
 =?us-ascii?Q?AQl5LJg2C/ZM47RQN/CT2CE2EjZVCmnljGk27eIT1xUlpEL8BqB10e9l9dS0?=
 =?us-ascii?Q?lRXGB+AqQLtbvB0HjR4/W2MK9DuaIvLZsdz9ylM3SOU6/c489Igt5PoEQDTs?=
 =?us-ascii?Q?dz7NvARzaLtXTMXGspYLHOxVEvHG6C+n3epuSiQCHb0XYAdEQ+6CTyYYNU+M?=
 =?us-ascii?Q?73hd15aAbEYzjSqbEQAFlXLsMFH+fkO4R5/1dKUAcnCXUNiDn8BwOiqJQdJ9?=
 =?us-ascii?Q?SighDdTH3e2wLrL7ILsR9RrXc8xVbp8FVd9sVKuOrJvjIp/8HV4KS+TQSjAq?=
 =?us-ascii?Q?omK5auMywOph6aPeWHqBm/IyJRQX4CeFlGfqr4Ss64RWtZ8Wpr6W+YW9VvoL?=
 =?us-ascii?Q?hNUg3zjxsMelRtHDGhTHa7HEkYXTIEX4uySHYe6SIxSXUYgq7WPHZ3QZQQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:20:54.5798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c749c2-bfcd-486b-c02e-08ddc6064e8d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6608

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


