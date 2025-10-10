Return-Path: <linux-kselftest+bounces-42954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C872DBCD1C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66133B20F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AE2F60B6;
	Fri, 10 Oct 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VaN3OnOd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56C2F5A07;
	Fri, 10 Oct 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102267; cv=fail; b=rvhmDVhwxCc37BLjKjGRuwK5cuqvgTGx/eYk4b17HPdSUxs49uPfagZVRg84DaxIwFYnRUmxCnjFFuPDuNluUqPNt/lf6Vy+Ju32BgEwPUQ6JljAxxkKszYA6GlvfAHtXlCqayBVLKfxpueCV2qHsLRczhIin9/fcNEwa+gGPrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102267; c=relaxed/simple;
	bh=Bmd1yqV6O1sES9qpyJ2kMDlR/P3iTbOt5T9WIWk1MmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzSaA/N+XJ8ERkYiAtbzgoDMlTfB6gHwoE2uqFyJJoawTkxbulzPQFand/Pt7+/g7dSW1ZdVt8XMYJmdo8BeU/Cc1Ljtb/TNufeNihyqoovbb4P2B8OjOm6SDqT4i2oh7ASSZkdrfeu8zRdW2DaXoxNUmuu5D/fJkR+E5pkaFKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VaN3OnOd; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwgo7QFYW025MT6Z8w3EOudAJWrdwPH5uWDYqS2dYbmUeR0a2J88+u/J54b3PbnqmlKGujXxqxcCOkhw+vaKyL2hclT3z2ZJgHR4DDAwE9b2bZ7K523f/URdxP6xj37+I2MQ/HauEFvpC47QMbOnIMxe4kGEvrGv2mFEJDfx1xMRBBdOe1MHK2MNhWTxwlkmBYHScibc7Z9R9oef2bBhrMmC3+9IEosPW8JXGBLa3nEdkY3ybtz9HLpybhW63Takbo7mNokL5LZNKHgxcR0fNqDZNjIxkcUy8oFVbmgFeiUnDxXp0/SXVeitREmpEpwi36JmoL6dGVzQuZZQVkFx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uQ4bl4fU0QRZxb2AOptBsDSPl2kJgcYchY6xmeybn8=;
 b=CVOK6qG6GAsmOyku/A7n9ZWAthe2EjpblVn00V+TpIvhCnlUmptXRapOT8IJL3vb9WUfnXkaGldH4I8FAwVeWq3O96GbUSU5hgl2pIXOkHcsIq9ldhvhqAEXkh2wrInvsD0gyBt7DJkVcz6eGw5TCgrE7xh0xOJJQYQGECRDyGeeCxZy1hzJ8Sy3PALtbdGlfyfwiIFfNN+ZBkYhx69lbH8YjA3y5QDFn6r9/NPyeFAssKZ49febDsOmy59jFHj5aV9K4/fUS9zIb8cfLFYVony1UMIPuiCXm+Od9IQeGShoKv/ZZJpJAvwF0Y5gJh/yarjeBmnRPu4pDHySRdrkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uQ4bl4fU0QRZxb2AOptBsDSPl2kJgcYchY6xmeybn8=;
 b=VaN3OnOdF0tJRW2VW6ylXfRw4NbkBjI3w+m7HjpGNMoHyOdd5xXMnbVtwrwaNgxHgZctT4tvQPZLZBuUHH/+If4DSH6fyxV9dBs4mvv5dJh5li1q1aOS/T2mNtohuLLpBn0d+6vcjsAJW1rpdb7S0NWU1zxg3oKoX2+k44XVFNcEt0gf18jkB5aaeJwxH4S+dssFZRncFHyS1HS07AxYzebK/cE1CNxxsnWHucQTm/aDChT1df+Hqre6TJPW2ihInatGVZH4KL0jE5dXQkqffmI/7VgWAsej85ciXXfD6X9N7qTv5hsVEYzrRzhZbkwC+F/t3PJIYk9b2r1zui92vA==
Received: from DBBPR09CA0034.eurprd09.prod.outlook.com (2603:10a6:10:d4::22)
 by VI1PR07MB6621.eurprd07.prod.outlook.com (2603:10a6:800:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 13:17:40 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::f6) by DBBPR09CA0034.outlook.office365.com
 (2603:10a6:10:d4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 13:17:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 4BA0C1C004A;
	Fri, 10 Oct 2025 16:17:38 +0300 (EEST)
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
Subject: [PATCH v4 net-next 05/13] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Fri, 10 Oct 2025 15:17:19 +0200
Message-Id: <20251010131727.55196-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|VI1PR07MB6621:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7cb6598b-e8f9-4b1d-d5e4-08de07ff6376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfSAxyC9ba+wdLZGclgSvipBq7QrsayAcC+VE8stTcDxh/umskodK/YzXQtu?=
 =?us-ascii?Q?ESdsw+I1WrdwvIG9Tzqut+fJBjMyNjdOZg99X5TBAmE8sY/gCHcOURcSJLsg?=
 =?us-ascii?Q?zweMszZ10GQ+Vgb/rK1AR70eYQoD5NS5yZlh2UZO7IdV6G0mHaPrb2BFCAG5?=
 =?us-ascii?Q?rLrbLpd2nqbcU6cBiZd7kMikjgB7cvM5mhfqniAKsp0gjxpPe+v33+YQQbHs?=
 =?us-ascii?Q?f37vEZ3bqW5n2nRgbhvgHIKcwreNno3PiXkvCc+8CjSU7TZTttscFO7Nfqq4?=
 =?us-ascii?Q?CTOd7w8YZmzYdxFoSR35enTRpWr9nuFQ1VQO2GfEVZFjJvsoaHjPwsxNIlXA?=
 =?us-ascii?Q?khAr3DqP81am6ivULxXnjqiRN1VsXcSyjTOCMEd27+frdXtRWw07TChNwnXQ?=
 =?us-ascii?Q?shqFAbDo4C5OERabdrKyIa4aPK19gPGHyzqUIa5nZaW55uB1u10JtZ3Qj7o3?=
 =?us-ascii?Q?lSoCdRiGdM5t+Hnf5lzcSUGNsTxx83oLpdjPBv+JJiwc9FuDTibIIf7K+ctT?=
 =?us-ascii?Q?rhzmGa5+D1iNpfHwhokpsiFSOn7vrrv1jfbvmSbJMkgaANbsqt3EuMAHBi2i?=
 =?us-ascii?Q?nZo0aI7O7X6t2DZkznKko1T/RuJIEkKT9Q9pWloo/7+tIDUJ7atPH3VobWHp?=
 =?us-ascii?Q?QtBKbJo52v1o/Ur6Ml/K/9aKhbrLGGiD18l4ttjLW00NRUzcVTOwhkpMyO3+?=
 =?us-ascii?Q?MXxYN8B3Z+4y1O4IX8EP9TzlCv66GDJgvSsoeRO+Cp0qUP5pteGR2WTif1Bj?=
 =?us-ascii?Q?SKvhLwvwF+qMvBynZxqx2k4pjH/I55iYK5qObmcE00sfYTd/Q73HhlZgJBTj?=
 =?us-ascii?Q?YEgg+IWvAqpVAQegix7FXuNgIDIeezvjacbzKmJc4vZMJzLpycq4PhdIHYEr?=
 =?us-ascii?Q?2Tc8FF+5ACzIRoWWmGB+5j658jZL72SwdIPDtle6qFkbhxDhoqNzjIRR8cMk?=
 =?us-ascii?Q?Jgd2CYvKQLh/4pVMi9FJFhGDMvgTNl3dYuqWUS31S8dDG/OFaHd2jXh56mGa?=
 =?us-ascii?Q?gZQE5clQK4pQxhpKm0/k6GBCJ2k3fNhhwZFAa0uf4Iuj2YilyLUodksyvyEV?=
 =?us-ascii?Q?t+hgUtqKeT/WnPUAvPPVCJEM81G9ioY/87yHK/R4YgMFbaUwVpVt0ERZ23Z9?=
 =?us-ascii?Q?/iA4gQ0yW/0WU27A0TTSpyrpFlZzpgNb80wcvwEGO2jVIqlOFk7Sdc94PPlI?=
 =?us-ascii?Q?YaD74EzSgvTHue6lRjFWgwxK+c3MaeP1QA5WgZMLD7Jtbes62m/dtOEZ/zXO?=
 =?us-ascii?Q?sgqKsckG8nzhteQwAIveWLKZZCT9FPp/jJw95ZXc0rugaDdReChnlErILTwe?=
 =?us-ascii?Q?RWVV0myq4MagRE5aQIOHQW5gYptOHMz+8hGx8TXpPq0OROah1gllp6aGzKgv?=
 =?us-ascii?Q?XSpq7IFF0pMCPHlL9rMrrtiYuSpC2KCmA2/pMDmAuMDD5BNasT3ChxS0U6WA?=
 =?us-ascii?Q?nOB26dXeGFq6ZSlAjHjSVTmIp0bCsCGWjKYvD4ixsWrvfx6WDVVHWTv63uXW?=
 =?us-ascii?Q?vhwng5ookdqueKmgtpEQMCs7cUEBPR9Dzg6Ae6P7fh0zAf0NDEKw9LQZJkMR?=
 =?us-ascii?Q?XRnpcP4sj7uQvsBcpxXNoC/LMJqtBzwGqx+QtCng?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:39.9181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb6598b-e8f9-4b1d-d5e4-08de07ff6376
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6621

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

This patch fix an incorrect AccECN negoation of commit 3cae34274c79
("tcp: accecn: AccECN negotiation").

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a7ba21d298ff..c66f0d944e1c 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -473,6 +473,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -495,13 +515,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -509,20 +527,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


