Return-Path: <linux-kselftest+bounces-49402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EABD3B68F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85B630D5254
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC343904D1;
	Mon, 19 Jan 2026 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="A7irCcPx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF90138F951;
	Mon, 19 Jan 2026 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849164; cv=fail; b=GUK/ucvZlkAm+GR9XhJKZsgdOvlr72HBjU5TXC01Kq9EEGnPimhy+MUCKWgOwwA9b+ZHKOIZYbZCFbNscki/TOYFhBfZorOs/QlCKu7PSjKjruvYH2mZ7yyrRa1Mto5owl7Pb1pqt2kOf3G1QQiK1NfgkXN1YpFY2PMNB/cG9nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849164; c=relaxed/simple;
	bh=yknn5qOEJuVTt3biRVgC/FJ12NrpQjzqZeIJWngD5bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLBjeaq8YOrQJSDyVGcG7Qa51CysIVW1wHyAv8oDCEqvoAz127KRsgJ6mGPw2Ig8Jl/DVcla8YS/ZmgVcgtkD9mvmMhpOwBdBrARUcd5g+pO2Tzs4s5fRuiVLeacUy3Ktn4Nl9uGzFGUKrCaceo1UCHKuZUX9x/uAAabqERF5zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=A7irCcPx; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHA+pVx7NaKf8CMOtg0f2UgZQ3BVaeGfnHGm48B/0ebIycN/YV6OiktAjLi2gvx81byYbeXpu/Ajf4ESJoTObCXBli/JOK+Wu6zdzotMUWeG9nAoUFPwjcXNtH/a0qvJft1WK6MRyshuiW/3Dm3cGDPEXzyINkc4Bwn901J9prXcYpKWqIP4LWbkN2YcR/4cGGafwTQ91Pp7gH9QyYaHhEtPUpmQuw+VOQcKpqB6qNzHVMlsv0Z0ExR8r+O4vB+CRzGoswxV5Dfm1qic/JgCU3f1JkT5yOlO2/KZhv2/gGF5Yt0lsUGYoW+DSPVRxv809R8i2qBf7Sv+n060IyYBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE8pgq1ergSmy3XCSQfDii+kILAoS1zKL0Rcr9qZoLk=;
 b=M6b0+KDulAR6st0tdD4m8GT137VG6v4IaFmNgRirca+aPIdnZSmMhsRU/QoH9PGGcs8AwxXXvnh0oraG4XAOP2C8PFBhl3D6/zlb50h2yoQIsya1o0bxTrou0n8wBykUmP2WK1boMJwQbkZZ3rzCOwcJU6+/lTpceCkh/O2MQIwetOQn86qBnlDuLkWLnGF0o8wDxIRKULL4vbModKOb+nHGp54Mo1DszY0ywd8OcQSmKMv2cXGu/wCBhV9GUjXVtFy06JCE9fUcRlOSfZAjBO7XIEP12weM5ZzbiaZZozLjax37bxdnfDnU45ZrYdBHuaO6cDilFA12uHN6k5n3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE8pgq1ergSmy3XCSQfDii+kILAoS1zKL0Rcr9qZoLk=;
 b=A7irCcPxQzzcOrCCJ0QfaZ6yb4KTyCBUueJPV3ebKSWTgaDn41gBA2q2OXlvg4a7IZeUl2HvIDOQS+xddMcTtqaNQ5ufx23S+trvjSzmKDzGlu76LvLTLb3UfVSYawBUNDDvO15NVu6CPevrb4Fze7teqWMatWdqIgDS0/Zg4ewZZ47ci21QrqTbOp6DNUO9tAttwVqxRIT4utJXEobQ1+oKmcDSVUup29VgMaNYJKff8GTPGI72CQ4YixBVnqjyBdIJ3gebv88X9+Jx8mUFnNFPfcx/EqQu3MXsgPVNeWIPR9Zf+yuPTrHokGgfzskknt/fv66vZKHnBF7xgwjNHg==
Received: from AM9P193CA0016.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::21)
 by MRWPR07MB10823.eurprd07.prod.outlook.com (2603:10a6:501:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 18:59:18 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::72) by AM9P193CA0016.outlook.office365.com
 (2603:10a6:20b:21e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:59:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id D4E282031D;
	Mon, 19 Jan 2026 20:59:16 +0200 (EET)
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
Subject: [PATCH v9 net-next 09/15] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Mon, 19 Jan 2026 19:58:46 +0100
Message-Id: <20260119185852.11168-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9D:EE_|MRWPR07MB10823:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 30ce5dc9-ac30-4156-4b89-08de578cd940
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?vM84Q96b3X/sqvq6SC6ypHiofHqArUFZ/3ljgJDzsO8zeU3dtbd8AxrUXK+R?=
 =?us-ascii?Q?vNQkbKBVki/6B373PPvOXwCwtuLfHBxddbpwj+QIheo+raIydT4bZUaUoRl8?=
 =?us-ascii?Q?+imk3TGFcc9h7qLZ3pYiLioW1BPdkt92MpzrhWN5pSxcmLT+fzIDlk+aKAjk?=
 =?us-ascii?Q?lvp2Q1B0Sa8QjkKY3GsWbAmqaUHVOIblynH2uxmTLumKd46rhPiwakBb8Fao?=
 =?us-ascii?Q?BoExxNndeNEasjCRYGOv+IOQ8MHk4imR1iqJTGB0mq+b2T/7vzEHRa7mcKo6?=
 =?us-ascii?Q?LsOzLDB96mLaWsxCurBCs5tS/lM7DlQ5db1r4rSwStX3q5ajhNfCSBu06JzV?=
 =?us-ascii?Q?JmZfAb/uBbEdOP7gemQR/UXfbTt3RsqXqIitfddXnDDyfIFjC/wmXfWBOXGS?=
 =?us-ascii?Q?R4XCDp0HVaaV5CBqM02DNstlMDvedBQY72zPUMVN3rFzS0xuO8PlPPySg3lB?=
 =?us-ascii?Q?YZsJrQSDHXvhLM8a80XyB6bBBv97SzzBiniUscK9J6b44X6beZAH3UX35LNi?=
 =?us-ascii?Q?+/S33WlcgBoDhg2mbekljbZEbqZUj/ECC7lVNa1A4DDbPUrU4gq/b85L4aLD?=
 =?us-ascii?Q?a0Elz00Oe3ITAI1MtNNJz9CDX4sUvEUnlw/NkupLsLUee3K3c+6UNXVsdi3u?=
 =?us-ascii?Q?FRINzEekPAUNA08C0ZVKaUZfyYfdMeC+OdTWm89jJtgS5+2sXIKfG8KyslzL?=
 =?us-ascii?Q?9nBEq6Ohd6k+Isz+v1b7aHQS4mqCNqckAW40EeKPgEIumRZA79FTxzLwVVJn?=
 =?us-ascii?Q?JiEUIXeG6bn6EhRN1FOssg8hlQqZ0vhzF8S8hDx/6ms3+hMd86esVmySqIc+?=
 =?us-ascii?Q?rNaaXMegAc2kiFQhICi7A3zuFRhK4Pz2+PNwIYX8dDC4NZZUG8aA1UNdNo/0?=
 =?us-ascii?Q?YZzcPrU1hN7SYHzaEM21h/XfHXDF7IVOaj5T9aEDoblc/lCQtZv/qJH35qjx?=
 =?us-ascii?Q?zNE13z/y3LoDg9bdzMgfpssVxGlTt8kboEEmdB+rR65uVIifNlo+JX0kwEtY?=
 =?us-ascii?Q?soibR0iM+8xYV+yjpF70z7KodRJsO1K6dpdwL7HOkAAWjxq66/7CSuF/EMIO?=
 =?us-ascii?Q?vEAjHoXrznYZV6FWISNcZSKnhc9JVGvVesS7bDXISnH1ezCkvlegjrvJFlkG?=
 =?us-ascii?Q?XJF3YUe1rT6I0q5FzB4E1n3zUO6Q1HN/oQylAj2YEyJ7F25v4RnGg3p/SU8/?=
 =?us-ascii?Q?VZ/bs2P0GLQ5Jlxn802+2X0HtmJckN72VugVJ0VbCstGunFKNFGYVrJ4KBAd?=
 =?us-ascii?Q?UE+AF5aGo3Ak5dOvV56WdRUu+xiCnKH7+F2xEa3iO8Y31pOwRCZhLrb2sbxD?=
 =?us-ascii?Q?hcs9JirzzBQJDdJE9+vALlf0JodRC0Mz/lyQopkb5PhJ/0g6WwOeZnY6VgyW?=
 =?us-ascii?Q?uKzENCqBDDxLTLk4qjPA4DFj+XZZ9iTa27tZpPKya2L/UPGpjFblImlnSK5D?=
 =?us-ascii?Q?SplG/ogP8+JZmmELS/3P/Xf3osZti0RPZiK7Dd+Ca9LTpNJpS0QIczRo5zAj?=
 =?us-ascii?Q?8Ho3CFa4FtH2w4OVDZGD69zsdjIXZ6pUnzVDA059/Nurmp92pmKDWO20RWXM?=
 =?us-ascii?Q?X9L3jHi2xx+2Jp43FAxHVmXGuGsQePWLSongi1daGWf/8A3dTuEfRmhE0XrM?=
 =?us-ascii?Q?F2HDRHSe/DRzHuTqaVPXdzbPBVoc7zxygeiB45GxGOoTC+zufWsJNwRdLR0i?=
 =?us-ascii?Q?bGoRy8w/iYHzs0Kq/6LJ9WO5rHk=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:18.4403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ce5dc9-ac30-4156-4b89-08de578cd940
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB10823

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
index 329e7e461c52..8536ad08a668 100644
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
@@ -4039,7 +4039,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
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


