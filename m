Return-Path: <linux-kselftest+bounces-41231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 901F4B52F56
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F377AFEF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7D3148B7;
	Thu, 11 Sep 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Yxs5Pq4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CA3148A2;
	Thu, 11 Sep 2025 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588820; cv=fail; b=tPsWyOOVo3Filz/LL5eZHjG4bo/HrI6rXewcJn5kh6zNma2cRyvwB9s6tMhC+KPD4HvtMKnNVaiYAgI8ikIOQREWU2GOSULGusYm1lhYy2UUuUDSKkXNiAaCdWedzYV0v7rU+Cf2UrwH/HYuSbgdLvCuY6sd2WpvTukaSEyWZZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588820; c=relaxed/simple;
	bh=y2vo6ciWDHzcvUpSHpYdjzvxs7Kiw/1xsUYCsOJfX5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIkt71khzj+YW7GUgzHx6ZwQ6CvpUkdnw65Mq89z7TqOuZjQNXAyMA8R7HGxHOKipVHbZYriAw1iVGTEK1UtqXQ7zXIcj/7cYNW/NUHGpwRCb4TAOifhq5g9kBgyqUaM9NgcIjV28njSI1LTPZajPh9elNtfVRdF1SHF3KzFNZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Yxs5Pq4k; arc=fail smtp.client-ip=40.107.159.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/azK0H59ynUyA8woQp7IGYiO5veizsFYwjIXRVeMFxtCon1YRS9tilHcdHu98wCr2iTlVk/Hs/al0YkuzB5jzS94qa3U5cOBvCtRSJTABaQqlKjz96WYahB8YcoZpQybhsUP+yrBA4L8tFZ0pEmtZnQYION1zGYrrc4dOJelvto+iibFteYfH6mQvOLBT83q2C9itd1Laq/dYV9wABWGC7rnxKWs00NCoud67G+ruutA3eVnQJNikYB4kzw2QnsThYVMje8+KT2NnBsNBKqIz3qk0HMrPFYWCvBW2fPMR1gPg1aaWF98VyLaxHevjKHNcAWp5LavwgLUSfogOFqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYtNQOpgqfskPUYJny1nJBfTOujYJnp+eHZ87foCQsc=;
 b=kQYhqdRnj7g+CO1AABwm+yJN5IsuMkrQAea0yLQcliCjkofFBc1bXHDhGt8FcZ8kMWMU7nmFp8rvu1+LZ2leKxNYcgg8GRVvxEVfngFG6BM4SYhCIffV0DT+74l44/GkroDQR/H+j4Gj1jPQqRojhqLskIJCpJXbkkKSc3DxN/suk9LN5i9/1KzTewEVThNUGo5wL10rI2f67m7NyWxIB7omBM3IerY6pFxCe/TD9sxJgB6Df3pVxx3/utA9fOo1nQJGyDHG03XcN2HjJCLdj5LRUJ834HdJJtB1hBS/1E4rgbu1fVaxGXLSQTJfUjb4T9Sq/nicMPY2d0GOErZsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYtNQOpgqfskPUYJny1nJBfTOujYJnp+eHZ87foCQsc=;
 b=Yxs5Pq4kOZ5gGTjFRN4GPQYH8sIs6gnZiJRGElpHGss4WxbWfVW2UonZK2AKoRjtSEeAQqfnzOo34jEgCya5nxHXyXx9wI0s0bT/A/J3bk7VAO7aY5RfUoOaTTLked99/EYc6ewHlxjjYOXBqvQSb4ZPMVGaSvJd/WvnvWtx0X2UBYygGbqQCJkL8UjkyLIliZ4HMuFM3GnZe+M+fje45xeTkPQIfw8BFj4o9WM4yJbIO1HWCZn2EPTMCckIYiNxMsQ1FmJbhT0EM1Uc9DrPMF9ZGkjZj1QXi99DcOaksouSmQeVa6oq88YsHyUWmdA0IUmNl/kEh89BG50mZqoQfQ==
Received: from CWLP123CA0173.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19b::8)
 by DBAPR07MB6840.eurprd07.prod.outlook.com (2603:10a6:10:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:06:54 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:400:19b:cafe::c5) by CWLP123CA0173.outlook.office365.com
 (2603:10a6:400:19b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 11:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 11:06:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id EBC3E202AA;
	Thu, 11 Sep 2025 14:06:51 +0300 (EEST)
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
Subject: [PATCH v18 net-next 04/14] tcp: ecn functions in separated include file
Date: Thu, 11 Sep 2025 13:06:32 +0200
Message-Id: <20250911110642.87529-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|DBAPR07MB6840:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d8bf8bb-bbd9-43eb-1108-08ddf123509f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ejaVkgX1WquxWCbaYe8PZlywCVOFFToyMEOMnlpVxicoZvqvuUpU0PzCdhN6?=
 =?us-ascii?Q?IHwHuSn3azNZIsSawqNto3P8sWM3IL0IO6hbsio5VuzUrWjAni843P9l2gQQ?=
 =?us-ascii?Q?/fBcUsto9JiAwIAIxCXSOp0icXiVWHVlDXAMJIVJSip8XBPB9jaOqD3uZvuf?=
 =?us-ascii?Q?vrNxdKZaXlCkS9MsahIOsK9a1YbS5jAbYSc6A9+o6PlNxBo+mz7SDqqMk7Lx?=
 =?us-ascii?Q?53xX1ZMtLmvt2Qb8uOOgG7ChK6s3EXJhEFEYejDw1hV95Av810RVP1zzQpBA?=
 =?us-ascii?Q?8ybhFxyi+4bu+qe87k6u1i2ySxtHcVmhGUYDMgIZO6Oue4NZY6n+Z3Hk0j9R?=
 =?us-ascii?Q?Mfchb5h/T30s2ILKmLqcunkWK0un74nLiy8Zx086VXSjDq1OzPcYNKXPcH8O?=
 =?us-ascii?Q?4L8YJ9Ln7IVC8sn0+PNTiRaOhA00SNXCTi3iaym18bQIGpeZ7RoIhubR2AMj?=
 =?us-ascii?Q?YaD7KCjDa3jrQuxESlebBPgyDeRNn381tPLwRIHrnf2zNplp5whJje9dGJO6?=
 =?us-ascii?Q?R8rf8rdcUQoJW0BtixnH4GJ6vdPDyGRGat/hLN6Xv5gc+/fu3pvzr8WghDfm?=
 =?us-ascii?Q?VhF9u626KU41+KzYSNfLYGDZ2+UqwzkrD3yaPDh/CDrO0RnIeH8JwmgJAuur?=
 =?us-ascii?Q?n6O22SDfrzXvWdrHOGOaIp+nFt51GhiDBHUSwT907P/7n+j0v1hQWydhtz0n?=
 =?us-ascii?Q?BsDOn3ifuUjlNIQ2oUM2me+FY1E0WT/bjENFc0ej1vcYxhzL7pBzAZvkz+Yj?=
 =?us-ascii?Q?okqvcXt4pUIo5hGXTTu9cJ1UAT8GKS5n24hzrIi70H01pB+Y17uMX1GR1enV?=
 =?us-ascii?Q?3PB/t8dWL3jvJTB6OqDGqTXC2S7zDi3kQ6QVJbLn1qD2zRLx0yQJzBIwBwhY?=
 =?us-ascii?Q?NU0CvUVTKUmlYYNdymzHU70B2MMLcJa5h9MYjB94EmyT3z7pXu1ted+kz8gC?=
 =?us-ascii?Q?aIc5YTcEoAWt8vfEH3z8mSAaifJhWd9z76FOD0GYOeZAPZ52YpLk2DdbZ/Ec?=
 =?us-ascii?Q?OwJ9yW/etuJ2SvYGj0tbKyMb26/7wZ1mIuJYq68I1gIYsD9MLGlxeLWkF35N?=
 =?us-ascii?Q?/8P1T6Kw6WgRFqnqHrzEke3eU0WQ8LjyAXQ/6l0CuvjWk0Er7revfkeSCduU?=
 =?us-ascii?Q?UK2QbQdt8lV+W3JTCs7pyqNUOTROujmL2rjq6XDdv0GQFOQPe7+Y6Ams9Cbz?=
 =?us-ascii?Q?ekI6lOxlgZxUqUsic4ins+4nioZaz6quFf3bZwhIk5qO4PiiMhADQcALm3Vh?=
 =?us-ascii?Q?LP46wEFFkQ/J4YN3X96uFVBMJf5BvXlx/UajTAxGfBrqN2ilewbAJ+6ZA7Q5?=
 =?us-ascii?Q?YPjHG4mJb38yTaXgH4n6lQ/yay2Q4UNX6HRI9zJxYYrWWa/Mk5I4k8J+tMyf?=
 =?us-ascii?Q?r3vu7QZmLlK3KiTpqdW0nH/kpRzN6KBPzsuLWB75T+iHJnechlV/BRsPTp86?=
 =?us-ascii?Q?f7vO4rNszjRki9mkyIdBPpFeXslT54gpljLyGjnD49d1RoCP9jEaVEKAgn4T?=
 =?us-ascii?Q?Su8TL7Z8XOU8aZ0j52QcM+7bawPsBiswh5VcgcDvFUHDOb5ZVAdibpKylA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:06:53.4555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8bf8bb-bbd9-43eb-1108-08ddf123509f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6840

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


