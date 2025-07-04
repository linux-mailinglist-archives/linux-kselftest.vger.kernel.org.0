Return-Path: <linux-kselftest+bounces-36517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A95AF8D16
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E3A1C46627
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C82ECD0E;
	Fri,  4 Jul 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eQQmxFrD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2582E9EDC;
	Fri,  4 Jul 2025 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619320; cv=fail; b=dH/Zc5PpEyKScdyEr5RZAhnQ1+RiTeQMdsWlWu9WKXOD9KThK/J72aYmm0vcwi3shUHIc0W++BSRVYRYy42NVKh6eyto8e/1Or1RTRpw91QMIBXzaJZjUZ8zOLY58PrGu/cIGZJQ957CpOyEflnl18lToUYVkMrRwf0VkurBmc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619320; c=relaxed/simple;
	bh=zZZ2pX7xnMW34k6idZgiKWipbQNjxaqA+ig7eBlDEM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3WF5GmL5zr64kuV4mgukUTLVVqTG3cqV6yAZLLwA5UUARlF4oJyOVvUURHipAYIpRLAdxeKyMQ6E3Yd+0Gk2SKwQgGaHgmSeHpTxulGUEBu7xLn8YQm2bCtqf7GnlfglfUj8A7DkgBxaMyPYGWEC8gPjCBbeez3NUV7z8/shOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eQQmxFrD; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iu3fjx8O1I6jD/cTAo4biLQkDv3rkg18RzNdUTPafYDX6Hw9pTXwF/pzsoGoVL97xcZrC1S24QxAu2w7AySs6QWnfAqmj1ckzZ4KQI9OnY4/Kx+9m+1C4I0e+SjD+opYxwTu3SLthH2ixpUIn2lZpMlK/qOxMTzn5dzIbeGNM92zZ412o+FM2DnUbpOYKEP+QYHhg3cfz/7V+OEgo+LX2dvOSLmCnsEewhQgxTJFFM/nfemesxflcEyymH27Kg04ap/WjEdLQyhDzIwWh7w9Dim7ckECPf7ZTBmJ8HMFSbqXUuITjMYK5wRAH7+x5tjZodmmpi1OGb/pL3iKv022Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD14Zg4C2ouWxMhquZli90O1O/LTTMby3cqJ51K1TSs=;
 b=HwF8CTHDxxs6AsLQtr1RzqECfMssuYqa0+fKrBdryYqFcdI7XHSBtBzcbrfVW2PJo1ICfsN2bhf3lLjDw708vklUdSgK2zrNXv7l0gFr/wj/B0UJAP01rT2pWVS4zACtSuHEBjXPvd6oWoGR11WAtUWVYnUe9CCpq0nNJsaqxyshIFyVD1iT0bt3RfkyrzHWAx8gwmOjyfWuzDch4g5q9C2+liU2jy1jpY9N/uzSgsNj0Ce7V8YEtFlWBhXnNxxIPUHK3JLrHKdGiSaVLJkw9CXe09YxpNN3SLMebpy9C9W16j7E/Zt7mhZcfLiayHBmzZBArFUKdZPvhs+4aJZfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD14Zg4C2ouWxMhquZli90O1O/LTTMby3cqJ51K1TSs=;
 b=eQQmxFrDJ6WcFFlzLQSKD1LdBetAXmu6X09+eAC4yTmWqyH8i+0KHIKKFcStsHIhz19rGhqx36+zbmW91cXoRhjc12nyQt7kyXhXj6Ktu5Sz3nEXPI9XXx+xjAGrLgRJHg28lP9FB13oWpKyXLeKl5boj6nN9muaCxUF2fq0CkCoT1FuokVoJRh6ErXM0gQnW4e/2BHHCeadaaRZQkfloUdiEbJ0h5TPLlLqE9Foa1H7990q+wMl9LlfUGXb1yeWKA9HAF5FZTA28iBXlRZH+gYnSZuQ3BaIYm+OgyhLNZGKCBw17Hf3HRD5V7dViwY9sQjRgz4N9F2UKJj1nTBAFg==
Received: from PR1P264CA0040.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::19)
 by VI1PR07MB6495.eurprd07.prod.outlook.com (2603:10a6:800:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Fri, 4 Jul
 2025 08:55:15 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::5e) by PR1P264CA0040.outlook.office365.com
 (2603:10a6:102:2cb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 08:55:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 411C020176;
	Fri,  4 Jul 2025 11:55:13 +0300 (EEST)
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
Subject: [PATCH v12 net-next 04/15] tcp: ecn functions in separated include file
Date: Fri,  4 Jul 2025 10:53:34 +0200
Message-Id: <20250704085345.46530-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|VI1PR07MB6495:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5befd391-5b7a-426b-5142-08ddbad87e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FMXe5oFvShlvb1VaMNv3fQ+rOFPEeRK4dQ3UpjDCcMugjuuLNAuytZu84gLz?=
 =?us-ascii?Q?vpfOtH75jifjTSjC/AjNbWaH1YLP1o4hEgsOJF9JZLMnQawcuid2VVbEfEFc?=
 =?us-ascii?Q?efGWF4vaMaEzyeAOMH61Ono7hKPPZyGHjLrZYrSa+fdqZUS0eeHwVaUZjNei?=
 =?us-ascii?Q?Q7QDILs62z6eDur2/xQ0KnVLgLItSDgZfLjXlP2Gg9I+07S9cbOXuPRnlV7n?=
 =?us-ascii?Q?BgXyevjy1CoBb1xa3hE9RRCvOIAhKJzzqPPTVAqP4u5EJTZAwBPILmXob3f/?=
 =?us-ascii?Q?d6KepBbQdU4XbxPR0zQYbmS+p9pJICGHDhst2nSTWV1kI1ruU0MMeUAMjmMO?=
 =?us-ascii?Q?qY+dic+fan0o1b7n7DxjXb2WHEkhc3gU4uqj/idpxlSdxIFqqYh6fY2YcS+i?=
 =?us-ascii?Q?w1YnUr7NMN+DsGzB/xUzfPX3SPVzEwYJ4FQ4GsYdFNAHff2M/3yMs85Psut3?=
 =?us-ascii?Q?wktybSu0nEGsWog2CqTz3KDMvdDeb6S9iomjFiWN4zIodAEsGqA7zD60aVqq?=
 =?us-ascii?Q?DeOrfogS6UjYzrOXzygOe/VEwmZ9sC2robt4SKQTVm/KtORfKRBad7HW4rJK?=
 =?us-ascii?Q?VjLol/+CGDwyqUIalR0AHD5li6H+eU2NYTSwTFEBVgVZp2dLwgh6SodXah0E?=
 =?us-ascii?Q?uWLi0BbHwJnVL9VMJOwhM+hGy4NwKBKx+lb8P0ZVHTL4qQwwv8OMw08cxsJI?=
 =?us-ascii?Q?aGCjVG6GmBBK3wszwNGi8uvqKIXZ2vhPkLblSDQEM7TiUHKhoS4U4IOmkr7E?=
 =?us-ascii?Q?wKBhej5Q+fNVEiF0Pe80fR8CKnn0avcJwmqYICfoq3BETS2C/wVuk0GY7gXK?=
 =?us-ascii?Q?kPd5zHG83sJ9RitsduX4w5+Hfb0M2ZcyZFpOhbeEXZp0Suj4iNbkMcW1HTKZ?=
 =?us-ascii?Q?QNItky33L6kXGemsxgCLqGCWuc9GWZlHpEvFRoPe12/FtHXUwoMYDNicdZg+?=
 =?us-ascii?Q?iHlTr5vVOkOvlH/bM5o7A649WpTnfzTZg8XpgnpHggI1U6QP9LnKpGb9lKI4?=
 =?us-ascii?Q?+E/ge+1Mvk//LzMqljqkDfWr/vmFloevpT+cL4Q5lGfP3KTajCC6iqU2eEyu?=
 =?us-ascii?Q?TbJRonYc/bNv5iPjVvG8XcJ8OWqzs2YKqASovsVxumqDXAhoK7o9MzpDIXAZ?=
 =?us-ascii?Q?nhjhZSG+pu2yACf6hjkPylAv1/zVrufl0d0ZI/4oLxa7kxg+bCMEXAAoijB6?=
 =?us-ascii?Q?qq3YfP4nXI0uJPuBCD78IG8rRVISIhRbVWRRMyTNe/xJY2wujb/w6CqlOD6B?=
 =?us-ascii?Q?l2DkApdFjEgutMYFJFIv8/ArarTSzMK9dTJpw+lR/7s9LkWCd3321AKOZg1F?=
 =?us-ascii?Q?F7Jeuz89vty8q3HWBtbcGSbreLIKVGMIiQPuI8mrKQjbnEmR5+be43hv7RrZ?=
 =?us-ascii?Q?ivD8ZwyLi2SE9xIgPLXllx/ZficVQxdlIGXnSmbNhuzlIz6NHq5kQVdHG0P2?=
 =?us-ascii?Q?5kPqYcDEh6F87NeJ4dbQJbkE0WNAWv/fP6WHTX/5UY0ObwZy5lBnhfb8W2qD?=
 =?us-ascii?Q?7aRu/Hi8dvhi47Rm8M/gTgZqTmTHhvDsjGI1gPAHLrm9duBMfy445wpw6Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:14.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5befd391-5b7a-426b-5142-08ddbad87e1f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6495

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


