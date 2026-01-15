Return-Path: <linux-kselftest+bounces-49025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E0D248E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994873142703
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DB4399A4E;
	Thu, 15 Jan 2026 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lUbww97Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFF39A7F2;
	Thu, 15 Jan 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480168; cv=fail; b=QoNazaK2cAWdZbjbb8DCNhM+1pzAxSomemn4ZYDx+8pRNKCdaRQ9XcACzeIIzuorQIaKmyZY/NGhUUkU6cO0lBVM7l8x8oGl3w7ZZ/BSoZoC06aLW/uyFJzpY4xFwEHUymvr5wD06ScxqDbt/3Rxvq9mxOpl/Tz9EfLLjumYyAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480168; c=relaxed/simple;
	bh=qXE8+3uu+EKdUHJ3angOatt7VqSlowEfkK/PbQSGgmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FijzS5JNYzlhlIpLuJyE1+MPFSAzyCC7N9Q9xZcxNb2xijjEVDKow/u5Gif2sW6BzYJu7C4QvccDsNavjYZZ8Y/Pvlz+B/DXkIjNqz7aEYUaQ+3U44hZ5w0bkHGfqeaIA4lpwR5lojGyUdoBiw60rQfI0FSEvWVSeK2yXMvqlIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lUbww97Z; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEXnAh1s1UUDQdxBjh2K6sdp9uClDz8YLjkCGm7mJC5HosnkaIXlj0pP6CUS39GOz8VmysBC+Ahy5n8YFeq2xe4Pbn5og8A+oZGyeKO6af4ZhnKm8TgcGHcX6xr6fYopyDaGPR2FCaxtsQbXmRwuP/tAwVp8k7SMKL1IgG8FtFD3N4BMlAODYYFmjAEUOIq8G5VdR7ic+OQLKRglNgrxg8b4iPCygFXygwwcTvXj1Gn9gSNWC6QfQma5Ye1byq8nNO8hNO6I3cUy8p9P3T+n9w10sg3Co/VjKb83sNCVx6qY2a/muWhbAgZyVmmLO+GC7eJfq9lyPrl3POPrBRvpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJpZCtJoj5pLyoaVXP1yO/e6IEFZaK7BhDNtt83kDuo=;
 b=nPRQtYQunIgK7ZpIt3vZzrF0KoeUL33l2Xye/OKbvm/dhrIRoKgc8+jFfQCgBDC+GHqd2R8seaVyPf4HmwGLSz1/tpdH+Y3hRSwyMjCcZ9RBSqLnjMVzdQqELO4V97oKCja3Bfy9R0JhBzDjYwgL8U2ngudpYbtHvEAljMAUUejinLnBBNq78ishbapX6R35OQzI9OcId0/jBZyMt9FYNWnvt/S0elioSVX+9Z2x64UUuRLWvRHLe3t/CkfIkHj50h41HIUKzOvKSl5WCH/NkYOn7X3M9nrAvicyxetINun02MyhzueX+7fS4foiruzWR6g9QsO3We/HkDEQVGuZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJpZCtJoj5pLyoaVXP1yO/e6IEFZaK7BhDNtt83kDuo=;
 b=lUbww97ZD3I6+5VzbCye7sjGmEppPfZt+MB9i+uVxz+O5d5v7RaEUmcF6vAir6//OyeWYD9muv31LYSP6yJMlgf94IXkwfgmB4kOI3/p0dSCx2+0vx8jlp7MA7EvofK2N5XGTSDtP/h5ci+xEHUvQToRH+0b5s6DyKE4zjcIVAMSks1y2yT7V8G7YqfAtwvX6FMRAYS/6XcxRZbe0QKa/xVP2KNu6jkT6JiCAj1J/lfIXHF07I1fC7cpndHzwdG46lENYvwFcet+JVehXpXmt/W15UqGZYC14MQr7CZBLLPST9/LiydIAiNZfQcAlGssP7AdyAHAF/b2LcC7Q4xFaQ==
Received: from DUZPR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::24) by GV2PR07MB11340.eurprd07.prod.outlook.com
 (2603:10a6:150:2d0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 12:29:19 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::f2) by DUZPR01CA0154.outlook.office365.com
 (2603:10a6:10:4bd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B6B3D202C7;
	Thu, 15 Jan 2026 14:29:17 +0200 (EET)
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
Subject: [PATCH v8 net-next 10/14] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Thu, 15 Jan 2026 13:28:42 +0100
Message-Id: <20260115122846.114576-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|GV2PR07MB11340:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6132684e-e445-4e7a-fc24-08de5431b49a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Mv0WafxkTqdJlWWThZcPWzZ6seyFabi1A6eIXriqaS4RvpsuD/VwRl1t2PQM?=
 =?us-ascii?Q?5Rqea47aOJVOUjZffgENhMP60GpHG4HUvrXDYP0kh0YARzOVZVMNpUoL07TN?=
 =?us-ascii?Q?PS9/LpCXu5NPDGlqwRsB41rDKeuKyP/IYQ1+MOZ/eHSjyWqlNF3gy8QI+Zmx?=
 =?us-ascii?Q?15JpBD5dII5qHKNFhn7c0aBolH94IZRrwqrNppFbOv5Img5ix9Qnvw3p3XUP?=
 =?us-ascii?Q?s+m7ca9Fg5JVZD6SPm/Rh6JQRlcF3zn7oJG31qoIve9NINa0eo/smirDMLjM?=
 =?us-ascii?Q?VZwbsIZP7mTri8009Y1tHdb/m9Lqb4PxlQUgJEqVMC+jXfZNpfqTf9XJEnnW?=
 =?us-ascii?Q?OBOlANw+EMn3/dX2SJaLho0s1sirnZ05Imt4fzBSdu3KMk/qvvtzLsyZj6xo?=
 =?us-ascii?Q?wJFYapGtc9c89+4/uD15K3HPZVob+Gk4vxuVgW9fjU2l1MVIXwR7zYDU+lOg?=
 =?us-ascii?Q?G9tZhTRG9ObelALPkIVdJUqpzOCbq6oWv4R4sKThnH0qA4+6PyIlrD9eu7pp?=
 =?us-ascii?Q?/0/ldSlGtGI9Nyj2bl7ohMoRT0cvnXOVmKJQPP2QLQmdU8IeNUYgNCoT8oSP?=
 =?us-ascii?Q?Ok8+C7E82Vc7btb+Pb8n+ESJUfm2GEBP6fYWFsyls0rXxw/usl1xR1MKtbyc?=
 =?us-ascii?Q?Pf0oYeyMqwNEbUx4fpdQlMKx/bqVXoYqWqXppXNr7nNxBoKxaHgZMR0925Ur?=
 =?us-ascii?Q?D/5jwciCE1pu7IbjbxUG3M6OZA2FcTNCNsvBOPOqvOUangT6ReXicW6oS0N9?=
 =?us-ascii?Q?DnZuaNxPoB6jOzlC/FInaz/NydfPYJZQlC0D39Vt6I/NzY55cA9C3moRovt7?=
 =?us-ascii?Q?/eZUR3Eez8T20V3knvUk5g/DJzWX7cm7lsraSWtx+RmfcFFG55hxxC4cGKet?=
 =?us-ascii?Q?hfUPnAcKiOW2Ox+VjWFSl76s7qSwEazGpKxIY6SbOdQ+7/W5eGg9511JSCxX?=
 =?us-ascii?Q?l9zhPZfR4bqmZ9dLyGjjx2TfcoThsS8KWXcMjVHQZBY0Z2VXL9b9POdTbX/Z?=
 =?us-ascii?Q?SFsJ5ep55diGZlekcSP+GAzl7fziJL41tW1GS7g66K24RTAhDV9R54syRCBq?=
 =?us-ascii?Q?RH7Yq2vYOjMfv1o6YUlzc1aJYlaf5lasYJP0nujmuI5BLep06ws4dRbjbMNt?=
 =?us-ascii?Q?8hGcOFKHDuFwdsRDF0PsJ8UX7DgxIcE5VyJEsDAz5rLdqrJXZSTLgA4lGH2M?=
 =?us-ascii?Q?wnI3fkSvzrDTOXsQ+XtgBEYMWIkFtnuwU4hzlVTVhI8JpsPWCR4TlgdmyxJM?=
 =?us-ascii?Q?YU4Bn0uipKRANW3ziLNdbWPuCkcXinp3VpLjnLrLB/cPml6wTv13dVs4Kcat?=
 =?us-ascii?Q?+/Puuj6ZgLBMVZQKG7C/9js98NhmxgV8C2vWzZ5qjybS8pEXAlssCEGhIx/s?=
 =?us-ascii?Q?8S7Oln5RQqhzz0oyT+7+itJheTs5qeWmN4af6ZMbeh2oH0IQKHSDM5/Py8gc?=
 =?us-ascii?Q?gnmDjxPs8VGe+w0Kzs5h9Lzop90gJbhuqE2CXsWYL5Ef0yhru9Dxx4FT688Q?=
 =?us-ascii?Q?GrmIjfHP6YEG246hdBY0r6sUhzsXTZxBg1f+44Mxq77EiG4P5a89Vh9OVsPg?=
 =?us-ascii?Q?fKblPE66HOQ8wrX/+1/eORDM5kwHBDKmm6cSCt76lwRBfMexQUbEe8nHcrhw?=
 =?us-ascii?Q?8bGF+6uZNAjFqb/iKCzUsk3WfKP6FFmFaj0OTqBCJaNDCHOPt7ha2Ii295lR?=
 =?us-ascii?Q?sYYzfG+mEBi46/gJo2dyMkLhgFA=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:19.2557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6132684e-e445-4e7a-fc24-08de5431b49a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11340

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
v8:
- Add new helper function tcp_accecn_ace_fail_send_set_retrans()

v6:
- Do not cast const struct request_sock into struct request_sock
- Set tcp_accecn_fail_mode after calling tcp_rtx_synack().
---
 include/net/tcp_ecn.h           |  7 +++++++
 net/ipv4/inet_connection_sock.c |  3 +++
 net/ipv4/tcp_input.c            |  2 ++
 net/ipv4/tcp_minisocks.c        | 36 ++++++++++++++++++++++++---------
 net/ipv4/tcp_output.c           |  3 ++-
 net/ipv4/tcp_timer.c            |  2 ++
 6 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 796c613b5ef3..f5e1f6b1bec3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -97,6 +97,13 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+static inline void tcp_accecn_ace_fail_send_set_retrans(struct request_sock *req,
+							struct tcp_sock *tp)
+{
+	if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
+}
+
 #define TCP_ACCECN_OPT_NOT_SEEN		0x0
 #define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
 #define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 97d57c52b9ad..9d16cb9c3db4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -20,6 +20,7 @@
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -1103,6 +1104,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	    (!resend ||
 	     !tcp_rtx_synack(sk_listener, req) ||
 	     inet_rsk(req)->acked)) {
+		tcp_accecn_ace_fail_send_set_retrans(req,
+						     tcp_sk(sk_listener));
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
 		mod_timer(&req->rsk_timer, jiffies + tcp_reqsk_timeout(req));
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e5c9cf586437..db361daebff8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6240,6 +6240,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9776c921d1bb..889c4307b35f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -749,16 +749,32 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
-					  &tcp_rsk(req)->last_oow_ack_time) &&
-
-		    !tcp_rtx_synack(sk, req)) {
-			unsigned long expires = jiffies;
-
-			expires += tcp_reqsk_timeout(req);
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
+				tcp_accecn_ace_fail_send_set_retrans(req,
+								     tcp_sk(sk));
+
+				expires += tcp_reqsk_timeout(req);
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
index c6754854ad09..9489cda7322e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -334,7 +334,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!tcp_accecn_ace_fail_recv(tp) &&
+		    !tcp_accecn_ace_fail_send(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 160080c9021d..a07ec1e883f1 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/rstreason.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
@@ -479,6 +480,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 * it's not good to give up too easily.
 	 */
 	tcp_rtx_synack(sk, req);
+	tcp_accecn_ace_fail_send_set_retrans(req, tcp_sk(sk));
 	req->num_timeout++;
 	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
-- 
2.34.1


