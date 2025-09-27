Return-Path: <linux-kselftest+bounces-42528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AACEBA5B61
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B721BC54C8
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080852D8791;
	Sat, 27 Sep 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JoN75lXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94E2D7DE4;
	Sat, 27 Sep 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962910; cv=fail; b=Fle8Pe2QSHazToDSsHFkcc/Uf8Uucr1dj9Q/MJTirwCAP4jTAQteBwi4/Xnt2NWeCgYiTginrekWC0AxGKPivsJxP/Fjy9PdDrdUjlroGLDAB9QXa3/Lwk8hcf9bT28zfBdfpzsRYPQd4EN5pq6h8uMKAW4hoOSzpyFhUy0mw3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962910; c=relaxed/simple;
	bh=O7cDQZ0c7G+ypBslCnRf3HI/Re9jtS2Z7680rn208mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b85Ak8IKbsDquOwK916Q7o4XY7piaYfeo2XBNY74vLWOa6Q3xyuS6qMcr4HeyFwYd0R6EAfDf2Wrh4OEPDrxaNVd7i09s/D6g3Kf4qm5oskbBezQ+zAqx/KifLzkSN/5TNnjM6EzzBOLH8Rzuhlz12fhJyBoUuAVIQQmgGOFJf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JoN75lXV; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHVTs0XVWp4cwARgEHjtuQi8cmAB6wzCcnOSegUeGrB4b2lb3f2aThdxAX79zdACvbp5JQP/xIRM7qzd9dG13O3BYPQL+98FOjlJofQpWX502SfXIiEo3jYkAd00OuOj2d2n7xwxsBADjIT+FNtps7gMtyqGv8PQWKMIihUZ579fhq6mGuzQRcpRZfhD6Y570WTWgJ4iqq+P+IXeGJQaMuMTequNgsAGlDBICAMyNaP8KEPmwukH8d0bOCQaB8223yyPGbo7Fgvl+s+hlmG5MWeKJA4hBNb2rj42EkCYHwE2uckowru4WU8uMdUjROjxLu66PNi5KXku/zv+7lzyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntAZM1gsWqxkkdRMUvwPQvTN5YJP7j0re+fpZoUmg8g=;
 b=nYipErghy1cfl2kFQoco5MWS8mUDGI2rq0YK3baPAfnLwe46eelUrM7Y+lDp0yeUmQkE4jeYafdhL+fccqN/7zW77dL2DZrnpGIBIbvCUoEhWsBP3JCFyt7YGFOzoXj72Q9sxjV8gNLYhbcGD4R71EUS1CK18KMpotHXyhvmUzfF5yurs7pD1Tx4jSLDtik++oLU4k55F7xXVOxAATi85LJ5JlnFuRmm1ZMFjR319Ps6L/J/W6kc6sh7xXgX8nZaPz84Cp06ll1+PBowqOJuuSTp1ZoFcdZGiqdJW7SI/EwnoQcSaLQvQU33xj4uQr9DpzqeLCmnFBeOkpy7/tZsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntAZM1gsWqxkkdRMUvwPQvTN5YJP7j0re+fpZoUmg8g=;
 b=JoN75lXVAY56sGYUDKeFSSuPEgAGREky3GQbPGBbJO7z/txMmfG/G24Uf50dKGk2wkzPrm9Z0c387XEuCjbG+tTtu3CjdsPQL5LFpGAjaY6rT2M1oBEqVvHyRUUA/9CZ/SIdtTwzFQsSICvX2Yu2PIW2hSJOoiEXRX9biZi2BYmaBMy96B504Z1r8h5IUaJbpvSviiqA2pUWQOS7oG88hGUub3g//HTAoYjvxVrioZtZYjKfm/eTrDSXg0QsAz3gNuA2NWiiDF517NX1BPnbk/FCofifGPpkELEN9ArhvQg5udJoTYJoTh9yPxXw712+i4NRhwl/QDP/eoLKJ0/dPQ==
Received: from PA7P264CA0205.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::6)
 by DU0PR07MB10682.eurprd07.prod.outlook.com (2603:10a6:10:59d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Sat, 27 Sep
 2025 08:48:24 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:102:36d:cafe::7d) by PA7P264CA0205.outlook.office365.com
 (2603:10a6:102:36d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sat,
 27 Sep 2025 08:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 5792720107;
	Sat, 27 Sep 2025 11:48:22 +0300 (EEST)
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
Subject: [PATCH v3 net-next 09/12] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Sat, 27 Sep 2025 10:48:00 +0200
Message-Id: <20250927084803.17784-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B1:EE_|DU0PR07MB10682:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 290287be-9eb5-43ca-692d-08ddfda29e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iXX4iRGFeI4TWUtZ1DzcZDOZM3mnofC0CA3sscIQMid/nQJvW/NaImXRCGJp?=
 =?us-ascii?Q?/yEYySlvaA4EKYNjmlcxskmlXJgRVYrWU6JwwszlQrMV6gR4K+nttXMotgQU?=
 =?us-ascii?Q?5jm8hIRQfF32u8/2XBI0rDHb0gX/63jd9ckK4FYvlRIS96qMGHYqTfOIazdG?=
 =?us-ascii?Q?u0Pa2EJrFbJeT75lGB0BRvdDIEQBCbyPFZn8SEs78WroPF44L5nT7CIFM6Np?=
 =?us-ascii?Q?pRdf+vpruiE7fygDVYSSyvOf6T0HhrxQ1Uk7yO/VU7BfE0qe6qLL6UvD8CDb?=
 =?us-ascii?Q?3r2meIimqTMXtnjhhKDoUpIjgmrCflLSi3duWLhIOYBVJ839mwzbCfOvwxKR?=
 =?us-ascii?Q?Ods9+HYrvUV22EQoWRYFBPPW6xH73JEFVJIaXuSHsXepdApulNKK8HoGg/tn?=
 =?us-ascii?Q?fYcCGqs653EkQJgn50BjwdD2wfB0yMnUuBABKanmXqSPBDP23j+Ihi2rNWd2?=
 =?us-ascii?Q?oHTCvrF1mSB/ZkE5IurTflvxKO1DEJZ8sSNMOpBpw5+O1E4d6p0OTyprep//?=
 =?us-ascii?Q?3zTQCmFWzf0C1JqxsicQX+ZTpJEkZLXeb9xAsi64YuG3voePsTtJEClPnQlj?=
 =?us-ascii?Q?pRjAsj9JOVwOssEuuaA5QsIUqwLUYQyr7Azx6zNnE1BQh70w8xwvfRGsHVzc?=
 =?us-ascii?Q?LnfbNU3QlmmTHiHfJuwfvvW7mJy5xrbMnYIpnK4/EHo6RhOHh2Alw+4OE0IW?=
 =?us-ascii?Q?020TE/XMAY2wEpl9Hmqdm5vv+kcMiLfwUfCK81nqx1IQcyO+TQWasCdLVuBr?=
 =?us-ascii?Q?oTBVIzjoNqioKUSji7dRBRu5Z8miCogd4FWA3qRT5Ayrkglvu4L5gC7Sm2Ae?=
 =?us-ascii?Q?PNzIg6esn5+tZ91A4/GQzJ+1XdoePZcpIDpz3P8OOwoU4j+ZX1lxS/O8Jj1v?=
 =?us-ascii?Q?W7wWYZJRbQZ8gOZAIKA5fdC7jjsXFiJnfhjS8AO6rqUUOrDNnqRuJpx2y33L?=
 =?us-ascii?Q?e5pYETr1Ve9q/Snsg0QK0D7arHbldfihaRu44IRAgU3JRYAwuNgScVhGSUSr?=
 =?us-ascii?Q?Wgqd/NGVbawetByvwBk3itCrqbzmJrWEhmt1Uc6d9P7JXylA6/EpbonhuMKY?=
 =?us-ascii?Q?Px2nYaaZVb6xuanMRr8VNoqm5aNu5uoiZpnOpQYuAiLJvT8xyuRxLIYEm4AI?=
 =?us-ascii?Q?NPNVP+/fYS6j87Z4Y9+P4MosXTb2W5NapeRZQjV11D+LWW5xjIpO2vg0qZrF?=
 =?us-ascii?Q?Ir4WTN0+iYmRom4JVDTD7MLHudWQL+mI6OTpLvYrEoo0NltX1jTTEJAlKkLe?=
 =?us-ascii?Q?Z+KrmyjeQAdej1mtdXCxh4ixOnRa+zXYVZ48cTByM5Mrjj++oN8IUHdgYR4d?=
 =?us-ascii?Q?KYjOUy3FoaGE6u4cmdBpgisICPrzIPzgpEHUFnsojNROlIiXQfzALKSjtPy2?=
 =?us-ascii?Q?k9Wj3zRDulOdLrfzIS1V+qEb39k5V1/IdYthX6QYC8pUu2k3GbQHuLr/Nanu?=
 =?us-ascii?Q?svs4XYpAYRaACNlt0+tUZOdVgF0WKTtvHlLb08OOXax5okoVxtGrcu6zMUev?=
 =?us-ascii?Q?H4e6NVccCtEkcEXRbtdnu5uCSycpx/sQ8+b3W06yHQDQAK0mnP3BHa35/wHl?=
 =?us-ascii?Q?YjUwRw8Hl79GOcY7S/YJ2i2Ap8Vp9fgbg3Fq+Ha5?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:23.7552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290287be-9eb5-43ca-692d-08ddfda29e43
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10682

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
index 97a3a7f36aff..50551430b1fa 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,7 +649,8 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(struct sock *sk, const struct request_sock *req,
+		    struct tcphdr *th)
 {
 	if (req->num_retrans < 1 || req->num_timeout < 1) {
 		if (tcp_rsk(req)->accecn_ok)
@@ -660,6 +661,7 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ae  = 0;
 		th->cwr = 0;
 		th->ece = 0;
+		tcp_accecn_fail_mode_set(tcp_sk(sk), TCP_ACCECN_ACE_FAIL_SEND);
 	}
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5317d471a6fb..c1a6bdb57638 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6196,6 +6196,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1fade94813c6..ecead2b771fd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -751,16 +751,29 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
index f2e8a068f1d3..bd718e342638 100644
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
@@ -3990,7 +3992,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
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


