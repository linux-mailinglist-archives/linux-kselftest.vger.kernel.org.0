Return-Path: <linux-kselftest+bounces-49026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E7CD24825
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCF24301BE83
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FD39B48E;
	Thu, 15 Jan 2026 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="HhqJwFJd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD1396B7C;
	Thu, 15 Jan 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480168; cv=fail; b=ddM3JYCy4MsGA4DC3Nh7ApHkdsNrSCQzGmneTlogDtTRprKGJ+n6ddbPhyjk2jEuHBSuXAFtDHEaGPZsP9YgLHzSfX7QASWQsBJj29gu+vt5V6XZh0xnSNmIb2D+x+zJs+gkR8QO+S5iwB3CjFWwYEARdzU3fc+WuARSfENcJ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480168; c=relaxed/simple;
	bh=Yz3LVGKV7GdIcFJUkL4roqvIAGL3HUpZUX4u59ThZzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYR8jXT9uMTPAIF9J2egNeLdH97E8wUQvDoVy3aysdpGr3tfK4twAHdlggVpHfFriScOvyzw2EUV7BhY0e0kTRF8uZBU9z86iwCSMrmcalmJJg3tBJ0hQkXOZtaKc0uORNBv1hpVaFoQHnYHFvFWoppGwuyJnywUM5fqmrhZQZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=HhqJwFJd; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEIFBtzsEZ1ewkEThTI9nFvRYW2To9W9LcHO9SydqjHe8g5a3LZ1PKgvnsPBB7YHr26xtqJyhfEzTmhUtE2OmaIhimTfZdyCQIp0nmDhBsdkS9+De2Oro46Y11MKoR/i4fkGLtFfwI+ncLJkCgmlqpmZv8RYFA3H4wAf5HrA7JGNSPI1J57qdVcgxAJ8S10eSHp4UyQBUO1ECpumCj2LNcgN4y5+JUqYlovUWgwyoM1BFMKVi0u4uHUenf/lSixXstX1qOyOO+oc0jmZes536bAfhutszNLLetAxB6UA+LbvijQYCNmi5RT1e2fK0NOJdHXL95Ian7+v51zLZhgwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDGFihql1RCEocLlYIjABFWzIvs7MY+rey6BXk4miuI=;
 b=pNr6eXd06fk9/oSofHW4lUX6ZcAB7CMpA5jndFv7Cuwniu0tC1lg/UbyCltGt/lvxFB/NT64M3zSjTeIp1DzD9BOoa80TZUaGl632p+WdrTREBVq4pXLqg2DBfiKf49klDrT/zdRBmRRV/ylIN9SLhB7WAiAJ52rh39Zlga3QumKIjdh9/S8BmIUIGzLyVYvBFPBJKMtI6BcN8uylWYp1Wo5CCT3d800whZKYtpjB14ek1l8OGRFUXaBDDnNtfFwEtYjbKEJ6fgyenUmoVKkgdSv6MfM6sOCE7UQ3DSb6we50eAjLMZlIB4GgEi4HSLUBRF3Npr1FUjU6mKjkeobEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDGFihql1RCEocLlYIjABFWzIvs7MY+rey6BXk4miuI=;
 b=HhqJwFJdDhiEu6W91RB9boNjFFTNZzSM39o1ZUrLgIJFzxDFPNAqWGBfrUBtzTVQt1TSq/TGDAktrrAWeM5Qxr+MUBGcaoRMClgjGnLJ/4Xh4pk5R9XlmYePvh9rIw871pXY5Wjn60z5EpliKRFia6Y0SzKdkl4s2QHic1XsIqWYaZi5qHlE9YMRnrFGA/GtQom0t7zXmmwzSEXjx4rQRusfDhpRp2F0AJBlAD+qhXZUSHoZ3l2YnCsDhB8ezOtWqipKhS/v0y0MX4qyo0fylDZp1YbZSX/vqJQ+oy7jyBkIs0I45sUR6apVMulPk6SWfkpsu9wuxe5NOYOfSY2utQ==
Received: from AM6P193CA0092.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::33)
 by VI0PR07MB11084.eurprd07.prod.outlook.com (2603:10a6:800:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Thu, 15 Jan
 2026 12:29:17 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:209:88:cafe::73) by AM6P193CA0092.outlook.office365.com
 (2603:10a6:209:88::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 00961201DC;
	Thu, 15 Jan 2026 14:29:15 +0200 (EET)
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
Subject: [PATCH v8 net-next 09/14] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Thu, 15 Jan 2026 13:28:41 +0100
Message-Id: <20260115122846.114576-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|VI0PR07MB11084:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c8774fd6-b175-4b21-1ecf-08de5431b390
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?IdnOLjnFFhft03EOYL/fjl+2UI24RUv5fQBxqxHDIrcy2z8MgS82pSfcznXs?=
 =?us-ascii?Q?gFT5zkEx8Eh+fu76LP+0e/OOMOIjn8FVwpSp7tHqM7+ZDwfFmy8mFROOCoDU?=
 =?us-ascii?Q?XErCjYfq74Jbx6d+rORskj3kFnORzKCQ6drynx0h+W5wQJpCmFHamLWfb10E?=
 =?us-ascii?Q?BWrODaia+5uwN2qXPdpaFcLP3c56XjRDcPK/aPZfgm7GI+7MzXHaR5c2Y4Ud?=
 =?us-ascii?Q?VlbLPJYoL1jfDxoEE6Th1mtX5cCla+fevO0bBKgVQJ+LqIEzNPE6ZOKFxoSE?=
 =?us-ascii?Q?UsmbY4eseQkpuf75Y3VcrnXtXrIfNZg71lqZ9cvf0fY57rNOo03d4aWTWLiz?=
 =?us-ascii?Q?cwrxu3YG5bcBiMLPA3gtySnotTq6K4vivhtNn4+plVJebegoZmJcU5g0+Y0i?=
 =?us-ascii?Q?yxGXmiABWuEdy/Xifv4CxHgtKxLANI4sWxLIb8KCHuBoSQzVxet7WP+BCXtQ?=
 =?us-ascii?Q?dtAKaLlriQRWYN4Uni8s90kMgXmh+63EpMrn+vz054FcJX0VNXoyejh6DP3v?=
 =?us-ascii?Q?Fm3pkD7HMvLjijW7qBsiwVS8XNH4PRhwhegtM1CMjkpde5bhegE8xSBzlJnq?=
 =?us-ascii?Q?UEtzW9WLjvV9Yu9xJhkCAd3ZQy65/UBs6WUCEHthci/b7PPzrTqAShLWz7zU?=
 =?us-ascii?Q?LVfaZRAvKY1m6KVToisNsHDGM8bf1XB25DQhmxZ1CQqzhpFKv/AbQ1ZFvy5W?=
 =?us-ascii?Q?8gISpyawqtbLNbfvaqdRMdIhSAuUxvLUd29rS5RGup77are7jp1rShC9Ubqb?=
 =?us-ascii?Q?K58Pu4gYaFSblmx1ktNbwwUGRpd/H8wHroYwc6EpVFZF7FM/+LrRGpZYIpEw?=
 =?us-ascii?Q?+AjkMCCqeSXkpnViR152yZ5tmfuYKKXIQo3c8Idj4awgu0og17LCF/aMWjHJ?=
 =?us-ascii?Q?FnndN2Ip/DRCu6efN2wgJzHYvn4Gw9aH8ehMFHeQPeVJMh8AVcojMx0Zse0f?=
 =?us-ascii?Q?2aF2B7ew9iCH52Yfjk/Wv9LWqjD0DhIRCMhNnVKdUCZQ6awTKpqZCg8pV6Al?=
 =?us-ascii?Q?uXw5cgt10E3hN9tRFj84QM8g82ouHeSEpEYvRgFMUr+DE1QrXIa25sBEffsx?=
 =?us-ascii?Q?SZNr00/lH2zU9NNNvMP1M2K/nJChkXzmVwugURTxdEX0QTRZbhSkwR2YaR3s?=
 =?us-ascii?Q?p9Jgc9Aorxia0L22P9gJ6OKAiCYwUtjzGGhCKtJPSA7Aws4bP4aOZ5joRGo5?=
 =?us-ascii?Q?jZ0pGbQXeX3r0YYtG3cwTlMblwnDOSJiKX5IIr2ufGfw9+xHMHzpqzkMn2d6?=
 =?us-ascii?Q?fIIRDKPXHsN42XOV9WlptLo7WmWZ5QQOyMNDENyztqhBrf17XYY7HEbjX9PX?=
 =?us-ascii?Q?JvDZZ71udIoyK6KDUawXSqbt2wtZw8+ZY4jmvpE8QI/ONDVuoWERQOaL65Pd?=
 =?us-ascii?Q?u5vnmaRABSd+ASZc6gNftoGo6M6To8Vr9qn7NkfIriZB1GsdU2seRfU93fH9?=
 =?us-ascii?Q?S6ND3Z8+wZghbaK33/h2aAOgmHrZUpkAjLwg3r2CZFJfP5jaCefqxTwZJ0vB?=
 =?us-ascii?Q?99gqrM2DaSKopX0C/tVJ8apo6FvTjrCwx+BoIrHfdUzbKpY/EerFdesI5Mkq?=
 =?us-ascii?Q?jh4+CY3ikC5jVZ1WtuOlLApymJT2SXCmuB3PC9TuHStaCtT28HxWKPgwDJLu?=
 =?us-ascii?Q?3wOxTIfZIhQqAXnj8J0Do1zlkJh3scV3FaPpOqv0meRlUwkPufvk/uqYVQFK?=
 =?us-ascii?Q?W+Cw1qGkhiPEbPutOKsB9qqisro=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:17.5131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8774fd6-b175-4b21-1ecf-08de5431b390
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11084

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit such
a SYN/ACK (for example, because it did not receive an ACK acknowledging its
SYN/ACK, or received a second SYN requesting AccECN support), the TCP server
retransmits the SYN/ACK without the AccECN option. This is because the
SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN
option. Furthermore, if this retransmission also times out, to expedite
connection establishment, the TCP server should retransmit the SYN/ACK with
(AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining
AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN specification (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v7:
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout.

v6:
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans.
---
 include/net/tcp_ecn.h | 20 +++++++++++++++-----
 net/ipv4/tcp_output.c |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb..796c613b5ef3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,12 +649,22 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
+		    enum tcp_synack_type synack_type)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	/* Accurate ECN shall retransmit SYN/ACK with ACE=0 if the
+	 * previously retransmitted SYN/ACK also times out.
+	 */
+	if (!req->num_timeout || synack_type != TCP_SYNACK_RETRANS) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5fa14a73d03f..c6754854ad09 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1106,7 +1106,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -4004,7 +4004,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack(req, th, synack_type);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


