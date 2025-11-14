Return-Path: <linux-kselftest+bounces-45618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AEC5BBAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0E0835CF26
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1B2F83BA;
	Fri, 14 Nov 2025 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="niV77/1K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5822F6924;
	Fri, 14 Nov 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104452; cv=fail; b=dYLPUbJYU9Lits+tpqYpPpUVPJLU7fLE5KiOuMn4AsfB5jjHwciVB7urvS0hJzfJzDayk9JVb0c5zMUu1EYLjhApVaoCWQMiWR+BPFQdHlD/od8bA/yMfUfSs3OXIzA/imVPnPETUtr5k52R7506vEnnjRe/J3Q7vLOlO8gXZG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104452; c=relaxed/simple;
	bh=qhUdabS43GHi7aEzF52u1483YECMRE5mtn+ehFpAmiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGm58NPSK8SpU+hy+5zVxfTMzeFFMHetDzzylNiqJvTFV13PM67BwaTrh7l4ky5gOy0b1Dx4P/Lq5D8ckJkxyAw3Q1nvADcqVuTHOjCmV3OLHuxSmBAd47d1AN0WBD4ho5IcUIgEddjw87UUQJDoDcE/qF3hsJgUg4TQ4VSk6mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=niV77/1K; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2b1ZmXn5TlCIxdYAIJ2OEA8YOwp//X0U+perYBgD7QTBX1EZARaRggGL7Df3FgfsT9bO8Njf63CQWdtEJq5XJm5hY+fR6rb1yXgAxmClg02Qa4rjp/mlygINf0TaLd/7za0CTxYpnNnDT1nsDByWU6iM0tSb1SvwwTOeto+BEWKYGkm+8gmQMQihGd1gLmAwpq6B1BTrmnU3FJRGY7241FbqD2MQPItnqnrapXi5eI+/ykPAqjNQ9weIQiLB//xMwrQwhnEpvyulP3ju3VLV0Oigzaj7fra4dO+DHU0HV4Rkdo7iLSmtQH5jnFYrHin8NnbYCJVvrcIaH9yS/Qz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=tdK3p0prtj8GKVqRZZonsX7tfVxOMsoKWxrCMvssu7jQeKnIB5qHbf8rBkEREPmGVJqg8R4FFvw6dmgxHyWW1IuoR5PWHdyQjPmA8Y7HRl3K/Z/kfOBRiqmQ4QfKEnIuU+lh6UJhM5E6uqTptSb+kGjbqS6+sKm14bF/NhcV2IebT8jg6biof6XaV+evcUlkmJK7LNpnR73HDYlSBzPj8Obr47qmilzaCtOyi2zW9nWApSvMtXBjsTvDfkEq6uPxiQ/APyU0HkR8H0uYC9ljLYrrEJiDcP8rZFpc3yhBGvx/HMuiTl5GbL4nWsLUBaWfOHM6Gp5dVds/l88DS44mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=niV77/1KDRjy4VfaJkIWFmE/kJWk6FfDbSj+V/18c1m8GLusKyCqf+fUGY56RfwNDj6sYvZO0OTfvzRRCg7YAe5nEjMhmq6jX4rdiglYALbpwPm/tgXliMfZ5X9rOV5HoTfKUsVC4TyTzVrDd2rM3rptXkRMx+HoXIulCDNtzWE11D1vl9fvOgUoNQI0fGcvI0vTz76gpCT9FPEp338qAVgXhiowDqTDSWXXLG/XPiDXmq3gofZq5kg/6A3ZWkAUbuGByYI3BRVWjmfk8FTNnzGBEdSfLaN9fNaUVb9sLFVhf9x3FY8gi7BaizvbLD9Q3ib1wKVdWtimAlMgkJ5OSg==
Received: from DU7P195CA0024.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::21)
 by PAVPR07MB9263.eurprd07.prod.outlook.com (2603:10a6:102:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:06 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::3f) by DU7P195CA0024.outlook.office365.com
 (2603:10a6:10:54d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B456F1C003F;
	Fri, 14 Nov 2025 09:14:04 +0200 (EET)
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
Subject: [PATCH v6 net-next 07/14] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Fri, 14 Nov 2025 08:13:38 +0100
Message-Id: <20251114071345.10769-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|PAVPR07MB9263:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7375f63b-9d11-4dce-95a9-08de234d6606
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?yxlflSdXVbByvIkK/6XojpLAnyG5lT8Nzmh0ftS4bScfflbCBng+KUtzDYKQ?=
 =?us-ascii?Q?su55b1yGihxl8Ut1m1KT9uLNsLMv8zBrnxImtuzmuPOafButs0VxEiIrb63X?=
 =?us-ascii?Q?wUJZus+t+eh9/28DTBnYWKTXp6NCbf7q0oh6bipPh9K/3kc2mr9Gtj0jGs19?=
 =?us-ascii?Q?VAXHv9xSL6F0043TCm0OH/hpeTfImwenDq/mmszGxoOelvg+90H8vdlXBJ1t?=
 =?us-ascii?Q?EAB1SjweERggqWquEGx4OoM/GTT46xNl3RVybPt0CU2mlPMhuqaEmte/rk8d?=
 =?us-ascii?Q?dlW9YhD8NGirX4oZMi57eAmYAck7aBiWOIkovaztTcW/ms5YwbuUoHDjP0R0?=
 =?us-ascii?Q?GtlfeJOoR6wggcrVBIoepJ01v4SLyBg55ZSlr0RUZgudwHKr++y21MWZhATs?=
 =?us-ascii?Q?E7s/qtgtrX8r919ZLJTTqrtGCsGNnsAVS7XOgkpj7TSspZPVK2Zx5cAKnAdu?=
 =?us-ascii?Q?3FeC/5+DkeoZ4FrvUD5vupd5XoUJh4TVIuTAs9YhJv0Ko9c/ZeAqdmdStKRD?=
 =?us-ascii?Q?rR2CUyoRJeDMzC9YXJ8B1wvc3NvqhAnB3X72q0wxOeCWKTsZMGshejefC5NA?=
 =?us-ascii?Q?yj192LeW3r6pr4oY+3yp2px+nS4aHldu3InKYs49VZq0Cl0K6t16hQyjSzLs?=
 =?us-ascii?Q?PB2wSzOx+rWllfnPTXQmN/76FMQ4S8NIosvGYzabzu0zNI3cTbhOKjGl6xl+?=
 =?us-ascii?Q?kffe7Ui1paSOKZgp8FCWyXp1WvfH8Ap3XUpXHkHZBDGRMEJlCRB3K7TwLGKm?=
 =?us-ascii?Q?NICJ7/tPgKr3VFOq5tIBiDV2k5wa4IlQ7fNcz4yQ0oyqF1DxZrYKnfutZEuR?=
 =?us-ascii?Q?derJnHuGmDJgvAVPddx644VS1njYJ3oG841LJ+X5mWubCOx6Bz9VXm+7f19O?=
 =?us-ascii?Q?aa60kcGRPDDHwySOuEFBfpdNR7a3p2NOU0XEMatrXUcUkH8pYBPddcyRpOIA?=
 =?us-ascii?Q?gl74667j2blikrh+X1N99iMR58I6lQn/9h7oqOhQwb1SKc7z70FnsGodMFio?=
 =?us-ascii?Q?0LaxJcdV7I/bagB+k+wIRx+OLwQ7nnehVSjn85lrf2P4YB5qKw2R4jEckUK5?=
 =?us-ascii?Q?gQ+XAKbfEspxxq4NIxWv2kEHT25e+5u+E4/wLga74D/YNqbV6dLQcrqcnVu3?=
 =?us-ascii?Q?e7UworhvOnTwiknjYINnxSs8F0Jn6d3HQmwNoJGeQb6qe4ehXEGM/J09LpAV?=
 =?us-ascii?Q?SvjOvgBgHy220iWxcLlLNDwZ1cyBjAQqk4ImR0HQOKnWV9/Y2uz7Sz5Z0oOQ?=
 =?us-ascii?Q?NbhcQwt/idbJldbAtEqpqPioiqtx8M6cLxZXYVRXuLd5B29tTZS57MrLPgzF?=
 =?us-ascii?Q?qX7DlVEaNkBfitEPpzdr9KVoe9fTE9p8Mn6RFCiIoF2XAb7wPNQi4Voa97AJ?=
 =?us-ascii?Q?/3BkPDkwLwniQEVvhDO07uAGGqsidM8fgDYWDgPr3CpUMjuSukRDXELNecwa?=
 =?us-ascii?Q?YoC1rVnVKM8ZRZm+IFTFr2qFFDieQW9Xu5kj7Ol7Jf+TdbbvqiANDEhSyQ0+?=
 =?us-ascii?Q?64yasNeEpxwLOgWTaMBjHpdRKxmr29dEBnua1Lj5r0CMsoi3WeRvBhUHPEL2?=
 =?us-ascii?Q?gtwBWEVAy1UrcHPaLDhqTdtdb8HXhfSH8wc9Hxr+?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:06.3553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7375f63b-9d11-4dce-95a9-08de234d6606
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9263

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v5:
- Add "Fixes" tag.

v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 2e1637edf1d3..a709fb1756eb 100644
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


