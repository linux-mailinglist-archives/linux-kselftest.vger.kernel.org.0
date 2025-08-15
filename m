Return-Path: <linux-kselftest+bounces-39072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EBBB27B6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A6A1B62544
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243272C0F9A;
	Fri, 15 Aug 2025 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="oMy7iSVP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6625A35D;
	Fri, 15 Aug 2025 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247195; cv=fail; b=fl7Q4J+u/V4yOBZ3MzDNOtJP5BPssORc5w3YkAV+scteO8eYYfvMyd5z20yqC0Ll0H5+n0bWJ8sosSavsHY0O2ViS/oJJduD3+lWv6K1eEWWcN2Hb1bOuAvTv/VI6DOM363z91flH6VoW1tAA5lMRKCUMAS8soVUG1unrKMpgQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247195; c=relaxed/simple;
	bh=LKLWdmhAUgVkl/saht7ALpC2N2fOFDcp+Ibkd7Kxw40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LonvsCMOv64skKLT2e5ZS8g6tZOZAfd6s9N1+qqpW7uCdW8AJ098luJNW1aUDJaAdDXJ+v2h6Leont7eu0hLvWN2Sb2buNtHCqJNQAqgJX5LgdBI2VCc/uaBavXqxywwNTG2pU+s7WybiLj8Nme+O6bN1yOoSHxmnPqgHe4BRUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=oMy7iSVP; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVUmj3+8TWHA3pO5GZuTFPpkpH0Yveb4rBguHkWHfejXSVUWxgMaBxXr3g5KteORDzAmllNCl8tt9tPsxtjlvlLoa1a0VeJ8xdHpkbjt0ytwLCcPAl71daZOhuSjJSxtYvpo1HeefHATuZEI4+vj9mqbaib2tRw32yN1LQyVHUFRhoRYpCaUBGnJ6uQoK5NcTs8t0IIU50tPVgK7YUeKodNW/MIHkFj/XVz5Z0OguA3LYEUd3YfrgaRqcUJ73E045R4x0YDc8ryjai9NU7PQ2ZYVtji6dX16SXhnWA4/q4eUOPMPI0iKRtVXMBIMKoh8InlGVfANy/8vWpKB42xn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRFyk+2bi05raIEnYlTTl+sXV4WzUHTZUijX3u7bwxM=;
 b=hc2C2UQmj9VmaZJOwtUw78FVzHNTydhrp1023HcmRsSPRD08ghySwk/c/r7iWB1H9/di4A7LqMETzTfIv0HehRGsfC6V39iw6Wo4NHd+boYvOULs66/NAbFX7qQ0AzDYDFfRK0Hh6bwtCfJ9gT9YnrxxY2zNAm/kqlOlZwcSuRvxKozzixCElyC7TMecNGxiYsFZPycCVpcMQzPZquzCY1V8S/uhqSKsL5b/gDBqoglbaQ7GGMdzshMIXcza71X6ogqhkucrfaw4c8PmAHntv3vqrTLjtk28yDhEAiRr7VI9fVSR1JZF2cMeY1MjzK96Uznhb5FlCq/vJTQh7Soy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRFyk+2bi05raIEnYlTTl+sXV4WzUHTZUijX3u7bwxM=;
 b=oMy7iSVPxRcH3xX9HsN+p6eUNcCm9HV8oIQ1VFBbuFbYV75ljIR90vAbZm87I2B5tvp4GSBGm2J7WyLqjzft/wVm8zlT79X/8YCgUNYwe8HN0QUR9qoNV1yYaK7vsJQahZ+3TNxdwfGUnstg4jzr5eSep8bQyA6hPdWFlCyuR12hrcYYThe/EEFjCFFwJC7+h1JfiLAriNzHPhm0heLLgtMyDulbDKCTQsvEr+0jTeyJ7C++4ackT8VglgvO07y2TlWo2ykyH4YidEMc5YymUMS+N4TRQuae1S1o0EfoLhBrWSN3g3qzB/qmjCcU257JWgAURIudyhdNyRwAIy8sng==
Received: from PR1P264CA0121.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::15)
 by AM9PR07MB7777.eurprd07.prod.outlook.com (2603:10a6:20b:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:39:46 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:102:2cd:cafe::57) by PR1P264CA0121.outlook.office365.com
 (2603:10a6:102:2cd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 08:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:39:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id D6F2A1C002B;
	Fri, 15 Aug 2025 11:39:44 +0300 (EEST)
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
Subject: [PATCH v15 net-next 04/14] tcp: ecn functions in separated include file
Date: Fri, 15 Aug 2025 10:39:20 +0200
Message-Id: <20250815083930.10547-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|AM9PR07MB7777:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 137497fb-32bd-45a5-4c13-08dddbd74a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kA1v5pTydBKayNHP88DnE0SrZXOCb0Q1h4A8o/IFIORHtpK58+3zkcW4IcA4?=
 =?us-ascii?Q?Uy8n4kaRdQQ7B+LaTxMmhJYSkZLiGv4HpFnGITqRVkphD2sapDxTadod3RSd?=
 =?us-ascii?Q?hag0wsCdDKLDVSJ+3aHqsxysTk9i19JD/gpwLsFwlccva2RWvVa003LFm1Of?=
 =?us-ascii?Q?oKyug2Cr2ocApTSnp07bNF+4W52IZh6ZsB/hUvAuU71sBGonyfqSRk5jIphK?=
 =?us-ascii?Q?lGMATPMbcAOLLFXfErXEw2W4VOTDoVV6z0LREHfGqfoLVUqcIDNnnBp5wykr?=
 =?us-ascii?Q?oINQ6j3kTO3//FHHYXFZ4cDY17erjeFPlh7dClW7rQIJF2RTRULt7J+cpXFv?=
 =?us-ascii?Q?j4nS6I6mtNyi3goGC1BC8zEILQGT5lX1F+JPZGpc186m9fMMvdu47q2mTnRY?=
 =?us-ascii?Q?G277swHnDCC173Z6nJoK1sFDKIP/l/dp21/9RhIeC0GwnO473yVq7h0GQ7FB?=
 =?us-ascii?Q?vapoiC56IDy3kyvWMGyOyVDrSviKHLIycyiSLz5ABaPZp1RpG550uHfmYJVO?=
 =?us-ascii?Q?eUlC9ZPIc6NOcJDpMl1BbR0cWG/uaZ9PJZMPZPeGnCBYBZE1eyatKHS7FRQg?=
 =?us-ascii?Q?eNLxWUMWMePkR6Ad6P3cUeudZiQrooItWqCPzaSgMwd0j9vMaSZC7pNLdeuO?=
 =?us-ascii?Q?WQyoWcwRZbPmbwL6ONeyNwEmlkcQACf74RFnKZ3AKgmDl0crnd4/ERKoyjCG?=
 =?us-ascii?Q?I+cbjpzwmGQWnnJcZHYgZMCxWoBZKEFZQqpb6oyR4ly/EZwqwdDnmP3ygrl3?=
 =?us-ascii?Q?Ed4DOD3IjlG0Tb3W10af4euv203Xc/4TEumw5+pfu5MrHDxn5P2yNIHmrzO5?=
 =?us-ascii?Q?989ZxiB5z7RfZMM6hK7dxGUXl2q038d8bNOVk+akV5Uv3K6m3q4oIUgZ/aP1?=
 =?us-ascii?Q?hCytd6rdXAvOrsoU1Tifly1HhVhUBTK81+pjQ1sjkVP43ahVHUu2FzeHW17Z?=
 =?us-ascii?Q?7CJbkOy/9+DzVJNzLrrhgD02FDPgmzRFNon+BrV9SdI9el/RgNn1dmxNWLSS?=
 =?us-ascii?Q?P9Ew6C6EmnRAE4Lp7GsMPEi7/gne/uW0DhzQhiTZaxcG3YcvMidD3GVMUGgS?=
 =?us-ascii?Q?m7mUwr3wcmo/NeR1WYFJ0zqr428zTo76fqwPaU2xgrIjeeCPaDgPgqgLHJLN?=
 =?us-ascii?Q?DpMyNnoldoQt0/mbxgsFnmu3O/VAGG7nDTWPFzEkZrp3pCfD7Xn4iofxkUx4?=
 =?us-ascii?Q?gDZ0vtrhRtM580M4ei2DViBy8F2wxNwvKPMjuOG2AH/Syj869FABSWWXHs5K?=
 =?us-ascii?Q?ne4YWvP1Og6oYs8h+8d7yYJ4EUHUVl1EiamGGYAScgQxF0iBzrof/ClQrjOk?=
 =?us-ascii?Q?ZSiTnvKqgRyHSe3wvNp61kMCitLeYGgd3TtbyAgMzJ69gJkNmsdHgJy1912N?=
 =?us-ascii?Q?t99uqWy6DShhZV36MNxyJypDurusE6mS1aePjK/mAMPP0rfPQV56nk73Khpj?=
 =?us-ascii?Q?sho7OdHBtz0cK29T0IKumJaB+RN3iod5Ab0VB3kjCumPBdxhjI0wxH8ylTco?=
 =?us-ascii?Q?rtDb8BUdoR4EnUHhwWxQPgZzlN/V4JpRAzby775JyQmYs/03VZ1XxTSDOA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:39:46.4846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137497fb-32bd-45a5-4c13-08dddbd74a39
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7777

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
index 71b76e98371a..4447bcfb9d83 100644
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
index b1ca5fc86239..a15154bd0e50 100644
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


