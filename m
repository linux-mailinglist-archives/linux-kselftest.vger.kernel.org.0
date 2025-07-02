Return-Path: <linux-kselftest+bounces-36260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16BAAF09CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E53B480ADC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E21F4613;
	Wed,  2 Jul 2025 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="cF20/6JS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012023.outbound.protection.outlook.com [52.101.71.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE691F2C34;
	Wed,  2 Jul 2025 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431057; cv=fail; b=kW04oIcx+hVgXlE0pGvAe5SZpIV+HdQLsrk+WZ4TJ+Zu3kT1+oqswtBlyWDaNIVKgjexE+8QGCKv4ysvFd7nrb8bBTlKJZhBLxA33KUUFGqrkFgMObX6I8VFbq5j2xNPOvm3v+KX4XSqdSI4iozDo7HOO9WTBmCFqxT2GUPkO9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431057; c=relaxed/simple;
	bh=zZZ2pX7xnMW34k6idZgiKWipbQNjxaqA+ig7eBlDEM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpJ8f/S0OIgz68snMNM1mFcMOeoWNSO0eOqKJHqwb1kfdGehQWVPg9FYPkgumc9uXmWiutJebWMfdJO2Sq+y4jpaogvxWGzyDKJfTvokA4wgpkLHeFFYrmjADL+MFY//zA0hJ2koie1jv8QKeq+UyxPhoTzZ+nfv3Uu+HEElwUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=cF20/6JS; arc=fail smtp.client-ip=52.101.71.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuOeZGCcXqs7LveO90DWmfW9YYsnLD22Oh0NkFoYVDTJpEyAXXxIqBh2t+J26HmF5FSrKW4dCgT3s8/cYFCu+hGbaiySfvnrbxX6KLh1U8ZWLJhH8oNrWrX6PGmrXGR0+FSIoJBcrHLzzSBtYZTtMc1Bgp09Pa9orOe/n27iA7nY2OCwAR/PoDAngrxxc/M0cN9Qm9P0OtAVA8vEFoQ/+WhPf9l7iDOpxc5AwIyUWdWc5jouiVwi72PwVbr9h3tBsjbGkTkTbfqxTJU78pYpJ55/tESdqLeYZRB+WeMw2j8+dUqRR6owonSZFXcjGtb6zsazxW8pks3iUaA+e94SuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD14Zg4C2ouWxMhquZli90O1O/LTTMby3cqJ51K1TSs=;
 b=BXOP1oI5h+/ek4+jRVz/FU0NiD2bxfaiPn5rfjanOogaHhn4nxiFmrezqlCsvd8nSWAt1bgWh4iZGRdqp2v0b5MrJDzxgY8EG66CCkneubNkdkj7LgligZC/F4Fdg87gsgIMu/VlEgRenLEGVyRBr9Eq9ZvhA4bIdHED6S7fKGdkzfTzO5Gx5Q/UYdUkr3Dlg4fuNQQ15OdJibPGFjeMhRDVPB1DEYISfFZs3bS3sL8jP1Adz8nf12bD8ZxwdKCsUQFjiKmomgh/okm7yzxGyIu0pvgxBzl+FMNIkHmiFIUwrlCpy+9vcXyBjVGxmFjLCQztr0VCs12BMQHvvrkldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD14Zg4C2ouWxMhquZli90O1O/LTTMby3cqJ51K1TSs=;
 b=cF20/6JS74+UBHrXJ1luEmWMR0ghdDG9FZQlspJ2KxJAAWR6/QVIQRJWzPDabg8sZpDIYOeBEBLNKGDHVvC3a9UDBQaVOkmg27aiKqHkiMGUfICfN2Y1rbsAv2eaDJ9AzZ/oSAjo/xCFvb8WSIoQK+9fTW96yYk7arygwuYd36TlV8O0KOEbOqWGAyuisbOnDgh6JdnphNrfde6zQGsktqrtGSIz2S5MlpVZuBrBXESeXHBjuyGBRdQhnFW/lxoe5eKt2Idqu4ccvd5YBBqXuXWLPZNuvuy1CxsCrMP2eaiTIT/9ZMvarg7pn09yh4LCvCJUbUa3MJ19F717+7i3zg==
Received: from DU2PR04CA0313.eurprd04.prod.outlook.com (2603:10a6:10:2b5::18)
 by AM0PR07MB6356.eurprd07.prod.outlook.com (2603:10a6:20b:157::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 04:37:30 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::be) by DU2PR04CA0313.outlook.office365.com
 (2603:10a6:10:2b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Wed,
 2 Jul 2025 04:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 04:37:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id AE0E51C0033;
	Wed,  2 Jul 2025 07:37:28 +0300 (EEST)
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
Subject: [PATCH v10 net-next 04/15] tcp: ecn functions in separated include file
Date: Wed,  2 Jul 2025 06:37:08 +0200
Message-Id: <20250702043719.15130-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AM0PR07MB6356:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27199bef-3321-4779-3d63-08ddb92227cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8S4JCgrSKZb3k6zjGnVhrJYprqU0Zk/WdS9mHMVifZE2cxpkKbv+S/kG4sG?=
 =?us-ascii?Q?5bIR32kfEB1EPlD/c/w5vEH3m2M0n5Ub8tBg80IfUFsvy0V0X/4GQ/RgQegC?=
 =?us-ascii?Q?+K0SJk0M3CKngUp9lzkmcN8N4arenSffC1sotdvJUM8wQL3xlOCkzYJiWq3O?=
 =?us-ascii?Q?6VH1ylX9SSfdDlP6pCsrpBtngm5rM0gbXmQLulFbbhZq80CDoXgZWqmhXYXT?=
 =?us-ascii?Q?mxat7UupsSyIpjTVFdvOSLokQfXDZJ7FnxGFFKxGqwaklAn1VOA+jbVLOhLo?=
 =?us-ascii?Q?8NvvlmJiyuxVQDNVTIPc1PRSAtYLcoDzTiPuEjsdIrX5F1GSEeOePWb6oZRZ?=
 =?us-ascii?Q?e4Jqe3hWJynBIiXZiXBir6lCuuBYwOxT8vW/Wm69lywwk8ODYKO6Uqvb/OQu?=
 =?us-ascii?Q?epvQ+7a9qanPCfVs2YsTVc95x6ECHO6rPA2Lst8b/kwN5i0IV0l6JsLClVjr?=
 =?us-ascii?Q?CHq4lLybpGUoaLUqJFtGa1bpCPHE0KleFOyaISyITqccjXGAZwPbbYrVtK9+?=
 =?us-ascii?Q?xM3G0o0b3x6oHk+9fZCUGOyvQ7pZ/TnLa8LJlRFdhh4rvRrfePKSBAtfcTOf?=
 =?us-ascii?Q?kbvaLdOYgoD2lrr/MaPTvG39rXHEaKFt+I0JySr0V6nivwW7726VgTikOIGK?=
 =?us-ascii?Q?sl5dw/5Aw9Acz4uH+95Rqvy/mlrd9sCTXHRrNKOoclNcTMubftP8/Rd1TL8K?=
 =?us-ascii?Q?nJCg14L4J4a0Mtw3IMFNYDzJjXgx0LdjIbKz18ORFe6I3C3n7bA7egueNz9/?=
 =?us-ascii?Q?mDCuJ34xfF6j3GwE+JoGK/rZ+DvAvTtUYoxNc0tLQTsZ6WR6R+a28Db88xYo?=
 =?us-ascii?Q?CeDfDeS5hk3m+oeBu/t45ACFyH8BlSrE6YK/HMN0LkOa15Rh8axUTXm6bc/G?=
 =?us-ascii?Q?r/E49/uwLIDA9wuw9kr/Js/fxTIliLId6xuHDxHssR2hIzctyPWaeLaMGPHr?=
 =?us-ascii?Q?PLH5xRWVrTgQ3TYaVjEiV26pt90RCzE10vhnzZXEutN8/bomVx45qDxfbixD?=
 =?us-ascii?Q?yHGcEmYlSc3guJabIeL6BjbHyi9Fpd126mYTeuPlivMqZUa8L0yjsFgKateV?=
 =?us-ascii?Q?y78v1r9K1Hhv3iAZdx9waG5B/dCfwX2Nf2oZDTHn9/7y6CeQP9fHnceTL/hs?=
 =?us-ascii?Q?t6AZd4PBq7TeI0/3sv/zjLgDS/8ZQBkzaRCqOWOfIaws1/SZSSNQwYsqJ2Eo?=
 =?us-ascii?Q?qyPJC+IXjdXXBSo+dOm7c2ff+hcRKq4S2zJMSGdBnwpuOunwQPz+dNLhhKQr?=
 =?us-ascii?Q?cjwEgtjrss65+VWSXk9B6203RsdOYFluuK1Q7FV5/fDJNRnGTbuy95CPX7HX?=
 =?us-ascii?Q?zm6m6KSuilmfKjVMVk6bI4zpan5Uz9DZd0foN22Ixq8eLCa5OXO35Mgzfiod?=
 =?us-ascii?Q?feorytYQ3iUo3bzHFZKziiJFECNztcusR7LWflw1UdnZGqVQlWIPONAD4fFW?=
 =?us-ascii?Q?L5jNbCCACEbdUiaxTlPk04snQaxBFYjz5xBuUs8IhaXcnNRPoTcV51499Y75?=
 =?us-ascii?Q?NAYC2wWJEPoHkXJl07DjrwsEA6oqdm96pYZ7hgxVJM47h6FXX6pR9bx+Xg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:30.3473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27199bef-3321-4779-3d63-08ddb92227cd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6356

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The following patches will modify ECN helpers and add AccECN herlpers,
and this patch moves the existing ones into a separated include file.

No functional changes.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
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
index 79e3bfb0108f..da4245718e63 100644
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


