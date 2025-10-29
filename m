Return-Path: <linux-kselftest+bounces-44266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885DC1907F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D8406133
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99532ED2D;
	Wed, 29 Oct 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ExpdAxGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBD32E124;
	Wed, 29 Oct 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725205; cv=fail; b=uJBCp2wrlfSOC7SOzGNk6tfQaighmw/VSg27GiRKppASg7AchvglXbEJ2sdp/fCokj0b0OalzZQreiU+/2+3pxk334we6kY2wLSy2XoXde1WPGRc4l1pBMuoucVl13uR4sMgi8a61Kt9ayfUt0bRqGw4U5O14kNmECR+C671WxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725205; c=relaxed/simple;
	bh=p8EbWPhZAgw5Yco1CMe5F+ogL7dWnzdczSlCLacf/vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/ZOdFVIxW3PjGW89SDl9jfupqEr1RnvBR397+/WJBmjIpLkqcCaPW5i6c9NDdsLgMksE7tf3paEcZymH4Ul2IlYGeQv07wfZDfRAqbN7tKhinDAJzcq3kUOV90qXHdn2WhrH82+hyETfc7zWQDKSTWPJE2EPOVJoDNcAfVWQHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ExpdAxGM; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+ee7D/Wq6Xra5zUzkelNW61eRX17ZZd+1UkMvmq1stNwIZyvEfnKwjBzCxvRT1LrPNh7UfGmZfhzFc8M54CjTWhGpFYKqyWXEjhPjzd5SUUAV8rHAeVSsfw+TiFTFJMLBhj8G+CxZ8TE9puVsYBvB8zJ/8zQ/q6JlVHY+a76I07Ir9ULHdGmKeEGTb3esi7+EdDSUlv8D64/0OpQ+AhAMEoCcGY5P6qSSXYf2ipDCxfVtxkBqlWM/U47BmNomtnBw5KWXnMCt7bOzDKjRXbQHUYe5FYhv6mLycL/wdMenkcziMeEEAz8kTXMZtU/2IQgd3TClo3GkreyTlzc9Cfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9tkUiOQKL7hpdsjx57xfP3zPQDpD4fcJ9Hunvi3SzY=;
 b=DPK4tLr/wreM5M8Lrx2+YE1znvwdo1HwvJ1hIR8W+BKPn+0QseWMb+Q76F3F0fBmxSmUvpcr4vBsefzFHpfnyiHvDE+CcEmLW2IdUF9RJ8SXmARSsgeL1Qn/c9iour6VHkYnM/Bz+yi4apYxchmx+NoKqyD73Z713k9sZ+l61Z3GmzRQg0qVwrFvXFX70JvEOWD2Goet9bne8y5wbDVrT3gVMtuuTm27q1wJcGJYitf0cFJ4anEYD5WMNUhHUmf7k27KiEm1YXtgmxz35AbaIGwGxlenfO+yZyn4XuVb34g6fcJLbZH5ptQB+8X4SY4aMv/UyTCe1dzNXJqNHknhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9tkUiOQKL7hpdsjx57xfP3zPQDpD4fcJ9Hunvi3SzY=;
 b=ExpdAxGMiuzk5yu7HekgoCG81hhDq3rrWLNx2eZqcG0Rt7SU1dMgcTCerNQWt9kEvcDgoRKqm/FfI68UKjdZAz/WpYaMlBk9ySrpQi3gnT2+UqcEaTmtyQ6VXM60nihIWZorvko8ANFOI56pYnsg3Ob6EDM+EJwbMgPc4C5EsTqtBbBWvgYWjBlB98fsyKy2yhwrv7O7g1uecf381xQJDEwhfWj8t2cPu3H9wnPj0sUzc3DU3RlCiSDAdq/2TqsGWc0aIwaD6CRRySaki0AEJqppTOog0rBxRuybINmXOgSUCL6U2OzthYw9N4UQ9JeXdmhr0ejV8M6CFL1Pegrh/A==
Received: from AM6P193CA0124.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::29)
 by GVXPR07MB11422.eurprd07.prod.outlook.com (2603:10a6:150:325::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:06:39 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:209:85:cafe::3e) by AM6P193CA0124.outlook.office365.com
 (2603:10a6:209:85::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 5A6C920105;
	Wed, 29 Oct 2025 10:06:37 +0200 (EET)
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
Subject: [PATCH v5 net-next 11/14] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Wed, 29 Oct 2025 09:06:05 +0100
Message-Id: <20251029080608.92428-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000192:EE_|GVXPR07MB11422:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 76e46f85-ffca-400e-1569-08de16c2166d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?DQwxNaWlFkYtAg1kpSRtFTXKYrNzDkXwqHrCCEgY/sXeJifVLWyE8xa8ySBP?=
 =?us-ascii?Q?9LJFStKg4sgxsDX1z3ZVYKCLeO8czHinpx2bvQDjO14yCGTUEno2pcW1sezU?=
 =?us-ascii?Q?GxPWD0OpKx5T68NPpAZ0qnC1acxBAB+x1CVVcxrCu0qq9pp1itdcl1sWpwGQ?=
 =?us-ascii?Q?Uqg/lzMgLal0SMo2v6iVByN6pRQQ+qsYd7kQkr2Qy7b1lkFyW7ehDH6cXAu2?=
 =?us-ascii?Q?yPqkAZ+hLhmFqx90JaxwCIqKNZBgBTYI7ObvajkJVR9nfGB2Mxj9VZzAyxXZ?=
 =?us-ascii?Q?8f6TzFi52fEhQRMpWt8gADv7frCC+eEWIvXWQ6WMGb/B/XG1db0lowjja2FK?=
 =?us-ascii?Q?mUEMuY6qDAvywD0op7PCWpsmvARQzeDbf/jjjRZw+HwlyVEN+1d0wGHaWDVy?=
 =?us-ascii?Q?vQuVhaP7i8j1SiDJ4KV+unAyr95E5+uccCYWY+JIFwMffGbUrQPj88dpjFTq?=
 =?us-ascii?Q?6GuNxcr+YKFPaJUTYNXySWuSYiHUhPfAesYOuwtlzK/Ia/Eb+GpL3i9Bp5wE?=
 =?us-ascii?Q?VttiMBNFQtn6uFeLBEZYApq3OM0WdkIvBKPr882gpa/sQGoRBj8dRBesYuUY?=
 =?us-ascii?Q?yeC3K7EJHPbwReRRC9dY0/nZxKSiFD915a7/UnjErJbO7m2jYykNxfvEMG1b?=
 =?us-ascii?Q?WbCAFqIYrreE7Qaoqhnttkr21FTmpAG3LxgEHeGP9RPShmXmaA1grnNHLt4h?=
 =?us-ascii?Q?KCZG4so0AChVHvCJ9kRtyxrQi0E59judw0sCtpVI/YnJjaP48593RKTSDD3Y?=
 =?us-ascii?Q?798a5UINWuG8fJ+CAoclR4MuRUKTEPE72hIsE+Ot+uif7Umg7zFSkgoCj42A?=
 =?us-ascii?Q?AsbzBrmK3qrGtwB49ZVFNsqb0ThdycUOB6OnhgaUB3fBf3evMieHGGo2V1nq?=
 =?us-ascii?Q?m2SVvRx3a2SVngwrFJPpHwp+g/O3ZnskN7JcxEvsoG0TOCe03nOT5X68PC2R?=
 =?us-ascii?Q?uyKF8iSTUHZC8vmLVeKJ8doRLgWERQ0Ny4EOKwZcRj2vhdQITzX8k5tMHHyc?=
 =?us-ascii?Q?DTDtTDOL5uaK79DPuu+iM6CxnmRGedYTS1rDKie69Bv8242FVDmW2hr+63Q6?=
 =?us-ascii?Q?FWLONASPu1lfHqGQH5xyo7E1cDUPQppQ0nDR86wEUETD9qxovOyTBYejZgzZ?=
 =?us-ascii?Q?7wXG5CjuZvqzqNSv7SavaFfdMkNjQq99ti4vIwVMOxDHwdq6u/xI8X/rGWAg?=
 =?us-ascii?Q?heVMOeulEZMVXpDuWFuorF+R22qupfhaXENpiX+9Yb+oYPv7CACXS8qXGwTg?=
 =?us-ascii?Q?UcHo8JKakOqLeNvNAt7tCg6Th8ycNUZ+EkLrPIm1fW9xpNmEQjsC8bM+tisF?=
 =?us-ascii?Q?T5JapuaiWYwElFv8GrKEzBh21KXIzYl7MerowxpT7fKN96+k1ULcEu/TuUkS?=
 =?us-ascii?Q?ABMZbxX0zZBhKo5Lg64cvBPzpvfPlJ0cxwSypl8CIZinLsQBPQuVdrNi5jrX?=
 =?us-ascii?Q?6ZI8rarDs4EF0Lf1829qeueEqukx/dsnKY+MAxnlnvpowj1S3aObpHtN9Z2A?=
 =?us-ascii?Q?aIck6ip6Jon+PRJ9QR67X3ELKbkFVC/hgYhHzzTlBhSQ4zGXKvwtocvSDoH8?=
 =?us-ascii?Q?2mvUJg5QmnsgAzU0g5eMRkz+lU8kqCIt/Y6mLBbM?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:38.8185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e46f85-ffca-400e-1569-08de16c2166d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB11422

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
if it has received or sent at least one valid SYN or Acceptable SYN/ACK
with (AE,CWR,ECE) = (0,0,0) during the handshake.

In addition, a host in AccECN mode that is feeding back the IP-ECN
field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
latest valid SYN or acceptable SYN/ACK to arrive.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h    |  4 +++-
 net/ipv4/tcp_input.c     |  2 ++
 net/ipv4/tcp_minisocks.c | 33 +++++++++++++++++++++++----------
 net/ipv4/tcp_output.c    |  8 +++++---
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 99d095ed01b3..88a328e7bcde 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,7 +649,8 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(struct sock *sk, const struct request_sock *req,
+		    struct tcphdr *th)
 {
 	if (!req->num_retrans || !req->num_timeout) {
 		if (tcp_rsk(req)->accecn_ok)
@@ -660,6 +661,7 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ae  = 0;
 		th->cwr = 0;
 		th->ece = 0;
+		tcp_accecn_fail_mode_set(tcp_sk(sk), TCP_ACCECN_ACE_FAIL_SEND);
 	}
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6b10333fedd1..cc39056d446f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6213,6 +6213,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 512920b23968..4a9190df0668 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -749,16 +749,29 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
-					  &tcp_rsk(req)->last_oow_ack_time) &&
-
-		    !tcp_rtx_synack(sk, req)) {
-			unsigned long expires = jiffies;
-
-			expires += reqsk_timeout(req, TCP_RTO_MAX);
-			if (!fastopen)
-				mod_timer_pending(&req->rsk_timer, expires);
-			else
-				req->rsk_timer.expires = expires;
+					  &tcp_rsk(req)->last_oow_ack_time)) {
+			if (tcp_rsk(req)->accecn_ok) {
+				u8 ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					     INET_ECN_MASK;
+
+				tcp_rsk(req)->syn_ect_rcv = ect_rcv;
+				if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
+					u8 fail_mode = TCP_ACCECN_ACE_FAIL_RECV;
+
+					tcp_accecn_fail_mode_set(tcp_sk(sk),
+								 fail_mode);
+				}
+			}
+			if (!tcp_rtx_synack(sk, req)) {
+				unsigned long expires = jiffies;
+
+				expires += reqsk_timeout(req, TCP_RTO_MAX);
+				if (!fastopen)
+					mod_timer_pending(&req->rsk_timer,
+							  expires);
+				else
+					req->rsk_timer.expires = expires;
+			}
 		}
 		return NULL;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 37c04da4cfb1..d52229d32b4d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -334,11 +334,13 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
-	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp) &&
+	    !tcp_accecn_ace_fail_send(tp))
 		__INET_ECN_xmit(sk, true);
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp) &&
+		    !tcp_accecn_ace_fail_send(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
@@ -4006,7 +4008,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack((struct sock *)sk, req, th);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


