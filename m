Return-Path: <linux-kselftest+bounces-44413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A0C20AB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 549064EEBA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F52291C1F;
	Thu, 30 Oct 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZudYalnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A218286889;
	Thu, 30 Oct 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834902; cv=fail; b=Shm5t/PHRFJy1eICT+BltM+RcPpfNe8uioLMcNvLXMJvKsuhzT2PLqt8K13PbWztrtixxxelz+GL1wvdzrIQR0W8Ko5/+iMA23FEpr4T/dGVQ9pHcaCfoMs/Msv0RJgraj3TTNRFdg6Luewtz5M/5+pSPH9slkHEJDnzOKqFhXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834902; c=relaxed/simple;
	bh=p8EbWPhZAgw5Yco1CMe5F+ogL7dWnzdczSlCLacf/vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBH/QkLJJxOlyV5bnE/IwId+Xp8jxsTflz4MMDfIuYIaeyzqnAddcmBs+pyI7RFGzcmi07vGu+GRU2zICjLhVun2hJi2/SbtoyondZ+pMOXQAdD8OzRkJcb9FPJ+jEKx3zBIik9fbxVY0Ad/L1oSylbkCIo1OlGGxDQjMhvKTFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZudYalnR; arc=fail smtp.client-ip=52.101.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoh7HwL9JD24x8ozv32OyL/rRpKQc5zVuVtBqNc928dedCQTvJ4vxpa7JUNBk0JElu0Wj15uW75ilvXtPxiEP1Y8RPDh0worvy+TaiHpXTI4O1DuAZ+SwzG92b0BivkA0dzCDKa7Qd8KbY51qNpS4yMOiy9VlMqloMW8s9qSa1p2JeUzAQtPmVpHw0doqc9lYW1WiYmMLlhTfFy9WRV+wzOyJEgJ+7khnc0EvBZ9tNufMWlPDfM0pxnK9+lW5lHgJzZZZuWbC7ieWOhzjvzET0GAGiPzVP7W4YJ3lmk9R4Lh0ZqHy7GEy74xgI/2AGyxsCwnHTLhLuowc+l88b339g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9tkUiOQKL7hpdsjx57xfP3zPQDpD4fcJ9Hunvi3SzY=;
 b=qjoHMypsl2xaQM4QfUf18CBWmZUNu+VVMjG986SzSW+T1KJBnDcUBYXhjpZRFSmrKq+r7H1RzLYW0cNTvymP/2t5O5HuGoXsIQesRP8xC0ooQ9wMJREF58Iq4R76rT/xf6zEOSBCBuw/IKbse8DK4XZqEAkZfdZjEYbRgq9uRiSeHEr1uCLaQJrC2QZv5xpHgEu4Nf2Bbqr5MRCPWuwH7YQ8Ue2xk0GDoyLZRodtfyfhgZO0J+6FOA8fVK5VU7PzEMAqbN03JUsWGpwsviuqFpIMnldknfuV0zYoa6rU8/llEyaQ6bXM9hPhvjM6EorYf4Aw+VTdg0PlpQJ33kPHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9tkUiOQKL7hpdsjx57xfP3zPQDpD4fcJ9Hunvi3SzY=;
 b=ZudYalnRl5wROe78gtrA3fKtmP5bCJJUEVI8nZp015LmbgkhkhZaQFfIM9Rh4immmSHV7R4/w+KaSN7TrzlziQ2RRELVFjCGcYtAxNuqOOXvh1WcNCKBMaZKlNfEtAWbcKnVrre/lzdCUYHW5DGXvf8oQjN/Br9zrQXkXu+Z/KpVUm5bfckmrmr9b7qVtzd/NcXvG4+thD/IRgVTaMTHzCEu4zjQ/1VpSU+GO4SKU6xjfMvFZPSQmZeAx4GGehZ9mFB22MWyAXctyfcnI2uMxCzEBNLredrIPwjsIXigxWs3TBnM4L5RYV/4OXil/8SBRRxZlVw2gUpq86DA129YZA==
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by AS8PR07MB7575.eurprd07.prod.outlook.com
 (2603:10a6:20b:2a9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:57 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::65) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10 via
 Frontend Transport; Thu, 30 Oct 2025 14:34:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 820DA200D2;
	Thu, 30 Oct 2025 16:34:55 +0200 (EET)
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
Date: Thu, 30 Oct 2025 15:34:32 +0100
Message-Id: <20251030143435.13003-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|AS8PR07MB7575:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a53d40eb-410d-4336-48c6-08de17c17fad
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?A3nxwFN58Olq3xhlMTMqcAN5gpNIFEuDKpyZcUApsfXiHwA1JrP2g4dKN8oS?=
 =?us-ascii?Q?ldWMRADaPiuQzlxUMu7TnASijZLFGJ2uBrd9rStHnBtdQfA/EZUelkuIxV6F?=
 =?us-ascii?Q?Rgq/zE+fkfdS74atPrZB2HXo6dEbCnHQ/6ixFuCPAnEkeKvFPC45hnxBHDLi?=
 =?us-ascii?Q?HjTLQyIOYz9+8De3nrIFfYOi9NK1Ka1zUCMRrrtiBEsMOdSJ9AneoTSl0eZQ?=
 =?us-ascii?Q?aB5STOUEjKK8ezKoL5Y/B5S9vaiGPFnEfJeM/wlla1Hw9p0hcDsw6cQk4CpL?=
 =?us-ascii?Q?Hlk6/4ba4HIRyxW086QdV7byIq3rtSe8XyPRwH3lUNvXK4uza2gEbJ7e/SVV?=
 =?us-ascii?Q?A297PAE8wQ7z2EnD3EGqxWwrLUeAEnB4+re3p5LdB6jqCY4gMuY+b2FZV7Lb?=
 =?us-ascii?Q?JXYu7HRMjrLEOZFUw+bpS5q18CuwaJUBAbEW3y0/7sSDJflaHoG/9vLf9sim?=
 =?us-ascii?Q?RRr+xEe8jsb2/aS2/aqvC9fQNvz3+zFAqncHso9ta+dg7RShYIPitqbsOcv6?=
 =?us-ascii?Q?IKih9G7RxNXx07lqOt5dV9oF0WMqh2Wkl6BObkoOe7gIXiJdxJUmdZCnfg1E?=
 =?us-ascii?Q?2p2junBTZ2fRVzRutTjYOBihENRyp2p+crbp6b3IfIhFgVBp4kK4yf0605Z2?=
 =?us-ascii?Q?TLiBp1fdERYMfptsDLdOQk0dz++l0csi8nCR8QWj52/zhdz7Ls6mPtLA48ex?=
 =?us-ascii?Q?51QbvAHkp2stKN2oAYbpmDdw5ntgdT0vWTqgz7kZheerFX5IWSFKm7hQiz/2?=
 =?us-ascii?Q?a58GZcOCtpFnZceEI3ZRZ4c3JooeofvjFFSqodsvRSd9pHtxQFyT7ksGF5W7?=
 =?us-ascii?Q?y9VY28bKn5H1k4GbFgJMoK52MQRwlrYwZEr627f80SI30QrDUckWSh8oCZ9P?=
 =?us-ascii?Q?rvJdl6EX7GhEaYPhlu/q48Q1ZY75Pe0aZQGdoGP6GQPde/FhUYVscHsjotkQ?=
 =?us-ascii?Q?0RNG0fhfbenO9TF9AzUiirHTPGeCVZP2QipwdgL2N0sfjlRuH8UYQql1nXuE?=
 =?us-ascii?Q?lpl5NkLoTEeQMhB6HTjZcvCYz7H4nZZTMLQGwGU44v3XZ1prg7RXsAlcp5vm?=
 =?us-ascii?Q?CSopq+X0Bv6+FhyAdfTHFg2KkONBKNT8Xo2PA6f1YO8p71r0UdWdAB4XD5HJ?=
 =?us-ascii?Q?pwoFDaLB/MDfgjItyN6kLZH7ttxe563ZUfBPiCmx1X56L8jZ0BDBKQw8r7ZK?=
 =?us-ascii?Q?3nxdt85z3NSgYEBlKjkxlJuWBGLiXLWZewXPK6r5KToQ5zos0w8eh1j6wWPe?=
 =?us-ascii?Q?y4+uCvovk3SPqzGUgl6JDkUDhSW4NfJr1R9VPVxHjZmS0ER9W7wCATezP/rl?=
 =?us-ascii?Q?ruBccBrq4HIsTEglw+A7TimJCIGEc24DLbIa2ResPYTs9DUi3RtbRdMiizmI?=
 =?us-ascii?Q?GwoMGQUlLJp8hRs84hCHkC+rb2F3olb0WZzeMhukr+yqllkT49HQNvMWwTDi?=
 =?us-ascii?Q?I02vklb+JMSVwDI5PzPbGlwKfeNCX+JqXVz9O4QJ4YdyqYWjuNVL7JvZXlZH?=
 =?us-ascii?Q?lhd7mgNgUNvc12AicZguznPOo6ECPAg6udv/cRPIyOcxwdNAS1YKygRMNWCL?=
 =?us-ascii?Q?pNPS01dc1GFN8oOtUeD6q++YVv/nEWi8ZYzbw7Eb?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:57.0562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53d40eb-410d-4336-48c6-08de17c17fad
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7575

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


