Return-Path: <linux-kselftest+bounces-36377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB8AAF697B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C3D523886
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA452918F1;
	Thu,  3 Jul 2025 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZCdXA1Qn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE72DE709;
	Thu,  3 Jul 2025 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519926; cv=fail; b=SGvk9CcRNNoBeUCElSPYk5cju39Ec5m/u7RALZyKTEBiyePy9QOEImXeBEkv3/sgFXMPcA220EgQkV+QRnwOdu1MkD0O1kyZdT8NEJbh965QSa77XGi+ncqYt7X3C4VGWZpeSv2YxbN1tzao3s/49Up8bVoWjnrqlddhPCqlDPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519926; c=relaxed/simple;
	bh=zZZ2pX7xnMW34k6idZgiKWipbQNjxaqA+ig7eBlDEM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOFPPbSc6mq22WJ99t1FPD79rCawyXuQwGFpK1/vg5tuBzt2sAoEPseh/dadmx5UA0aIYGy3PQt/1ebpRL87bAqEO3XOc1oSWa4AbIIOe7syS5uJSQycO8ceTrai+Ks3D/KvgFAFQu1hS4Vv0hNVRAv3EpwUFlqV73dT2sylmx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZCdXA1Qn; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEzFIdl8XTqkBK2744FDTPRysTOOdZgVtHoCDvOlLdyvyNcbahoVeZ+BuyxwTQHUMO4/Kxzs1gvl3nVB1fbJCZkYghTYo4d2AJv6Mdgkxft//jqpDrAFPodN9JsQubCEOzYsJ307b3B0XrA1KjU0QnLR40Co4cKAqvW3CFoP0zKTX1qLmo9wDj4P7ztRH3Nbb5ZxtvO5BWmjNBW/Q0CSTYyU5yHZikvh49IKXpRU6Ma4iCqFpfqXYQUoktbnr5oFkj1W6e/9BEQdJ4FijJGAhytFNc8cVuWIrGz2JXqT45TJ0TCAS0/5YfTSTyW+WdqNeiSzC9pennoo1dRGeL+lSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD14Zg4C2ouWxMhquZli90O1O/LTTMby3cqJ51K1TSs=;
 b=LjFS1iUZYJ66z1/ITjdPCMy2nqWG3trLzajga93F516zUWiOUVOfOg1ynW1fViVyC3WJGOcAmzdtyM633SrmvrmFiEFNhbhfkj4m8b+XuHFl3CutTRlHtu29JdLGXSRtYl2KhClgq7isS//cGFPQfA6opxZgJrc1UIBWL7eutDUHHN2RCznOs6i8NrbUyhmc5NpOq6/s/lzzuc0PgnPDVA6THoBXQkgA099nq7lbI5/mb1tTb1q7OM7Fniyg46ri90qvklwUM3CUopZ7d9H9RDH9ufcT/dTIgkGlWt0vyzfO0RjwZFm2I2nwCdCdDssnP7bpOoJ6C0kZTg2CJA1b4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD14Zg4C2ouWxMhquZli90O1O/LTTMby3cqJ51K1TSs=;
 b=ZCdXA1QnIJhIvHjQmd7MR/X1WAAbw3lpcOJacUtZPaYo7ejMhN4BVMHs8LLxbFZwV4eIy93zkKeE9taUpCWv0XMJDWsF20VPkjZck20kw0+VFOs1DtzFd42KPN7RzLM/tMWI9luzpVtz+UhmuhStLta5n4GXN+26GrqRdVMGG3Ww2tjc9dokeCBPC098uJf8upOxXnZeDb0RZMG3oDff1RnmMbX0/0gW5kPDRYCRm95B2RHmVXbjM/uNuivdExMSXP1O81OF9TiAglaiZRgKv/af2z+TTZREUnqvt/2+fINSwziEzEUBZBUfUm4q3E76dHEoB8/9ZrtXpXsOElzZMg==
Received: from DB8PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:10:a0::31)
 by FRWPR07MB10254.eurprd07.prod.outlook.com (2603:10a6:d10:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Thu, 3 Jul
 2025 05:18:37 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::97) by DB8PR09CA0018.outlook.office365.com
 (2603:10a6:10:a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 05:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:18:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id ADF7E200B6;
	Thu,  3 Jul 2025 08:18:35 +0300 (EEST)
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
Subject: [PATCH v11 net-next 04/15] tcp: ecn functions in separated include file
Date: Thu,  3 Jul 2025 07:17:17 +0200
Message-Id: <20250703051728.37431-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|FRWPR07MB10254:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9b820f0e-bc8a-4ea4-b964-08ddb9f11093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iqxtTi02wo9bwwSbfRTAoPYTykBLM3yOUKp8eVgrQn/EoxRR/+cWkn8ave3c?=
 =?us-ascii?Q?2a0ldxCDl6fbyH2AH+etvf8RM8LKLN1nv3YqyqnPlNEu89V3LjeAR5Aqndiz?=
 =?us-ascii?Q?9wufS7wxJbLZNdX22z9E+0waBCVV+dxI6KOBraXFRUrUbOlGWLSHHeTb/c5U?=
 =?us-ascii?Q?hezJ4w2D/GpVawueLwz+RJFvNG3xIoTtgjICYt+HRIJhBVBVPgmMnAwzl3Pz?=
 =?us-ascii?Q?q4F3VbB1cVmhM/aLMH8YV0ZdZW7xXx23Ez8SH7ANxs/9y2SwuREDaQaRaflH?=
 =?us-ascii?Q?IGUbUmEe623l2lNNRFVHgQlqkyc9UuhdSbNc+a48gtlc7tsSBla7J6nCza8+?=
 =?us-ascii?Q?1ykUUP1h9FhAQv0wrtzVpKSrEc0FidHyEiDm37ged29WqoPJgeQhVrc1bEzt?=
 =?us-ascii?Q?1VPoVlGI62zcnTQHFj6zVvPMwWztlWflQyRn0jCGGGoJz0c6ah1FqKkqIO4J?=
 =?us-ascii?Q?W20u/gdcWU1Fivdqxcz1c1ttzAHkBQL96QHhOPzPLRZn/D9XazqZgRvLK948?=
 =?us-ascii?Q?+2nPLqC9naOk18mEm70hBf4tP33/WeMnmxBLuFAgMifDUk3AG5BtiPiqG3+G?=
 =?us-ascii?Q?bGX/jITOLeXUkbzDkcJ2ZCBZYbaia/Df60S7Z60TwjhzplqQa1DssInZ73JA?=
 =?us-ascii?Q?dEWJW1F1iDRI97jbiNZEFkwfMMPjxUFUQWXBXJ3GHhVa/IJPP8YEGIpU5AzY?=
 =?us-ascii?Q?7BzcQ5NzIM7awOMz7/dnpCnZqkZZkBm85ubXVW+NLfA6SSdeKkdJbrIqHB+/?=
 =?us-ascii?Q?4pGJoQK/sp5tX/KZdrTBb6sNoLGVoDTgFAl1zGnmFbtv1u8T81qMV2UXFlNb?=
 =?us-ascii?Q?o7USLRS3utP3ScCFhKasuEo/IIzO8BoL5/fSL/Enubv1Y5rASdLKKy8OQ9q1?=
 =?us-ascii?Q?N+wmcD9HQrQt3iH37a5KX4Htc9vIZXHxVAP0r/BOhaiBsRTXPHaQ5cXm1+PS?=
 =?us-ascii?Q?wuTo7AbpwptLsDfZGDWC3ePEhwDmxr2Hdf7dmIpuQCl8SSW/Qkk/Tu52N1+I?=
 =?us-ascii?Q?SfamYg0//1vtah/vJjxs0waZH/1ZFP9EGfMc+bse0nE6aq8bdYW0q/OLeRHc?=
 =?us-ascii?Q?ufPJCo0b/lq0yXKnF7AFchKAjKr6ielCpeUNCuD57DzzWIYFfPnDeFHqP6By?=
 =?us-ascii?Q?JkYdRR7zSk4z5jcy9SMbp7TpCYmz2RCBcXKY5l7fR3nICCjd1ZcrcF5YYxsy?=
 =?us-ascii?Q?jQyT/MSqMXgj7WBPIBOSNW7nzC9GrxfH6+pJp/hBUGqPiChehxe70gM/P+D9?=
 =?us-ascii?Q?e++Vqo4r93Z6E7zLC89hBEer+MXdt/Au0+vwNeElJR8q/KISFPeUt6LNnw8E?=
 =?us-ascii?Q?KMlJQcCQSeSIKT2IgP5CcDU35DEZsvck4E95Kf8gx6KswjenkP3eIApx1K7J?=
 =?us-ascii?Q?xbmV8U7FG5UoddHTICSYSYW2OaB0dK0E1rduPh/f8/wSM6nGTIFBwJXsPPMo?=
 =?us-ascii?Q?K8Fohq3sJywiQ4qNdcNz7kYk9CFXU6BAuze62vH8UWv8rjjEByry3KRIMPU6?=
 =?us-ascii?Q?cUbhcmgmyQmoW2JFJys/kpQFVeXbKswijjazv3VSxuiBcnGLGeONHvrHoQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:37.2047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b820f0e-bc8a-4ea4-b964-08ddb9f11093
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10254

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


