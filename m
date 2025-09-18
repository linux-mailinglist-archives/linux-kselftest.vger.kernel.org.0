Return-Path: <linux-kselftest+bounces-41880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796FBB86050
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5AE1C21BF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287E31AF1D;
	Thu, 18 Sep 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DpBTMcyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B031A7F6;
	Thu, 18 Sep 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212523; cv=fail; b=B3Joby2YXiiqvbDONdqZhNWzM45383WYgdhXuxd6UGeCMMeYwg2W8cHC666FsuSx9HBtdfk5ro5KZywtpkrGsnUB13Z50sUE/GkrfBaHO8vyvTwhAeKyol9KUarYRImSGAt39N+H6CeZXtZGjkk4h+Xjg7RSK+8saFodejly73E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212523; c=relaxed/simple;
	bh=ICeKV345VnEApIhxYNVarra0/u0rQ+KpSW7qC7AQ1/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFaCAJ6Fn0PUJSpRWIeW22heEyef0IVHvKEsrVgszgTF0MVXfEMl8qtkSHhJ7qX7peM/qgSYpH9z1RKeQhATKltZC3OFMraiNeU3xotBJTwErK4BXhlgksjL+XzTzo6d6Cavxp72NzakQE0j5bNvCNKuTy7Ub/qHQQa/jzioILk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DpBTMcyl; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGZmZuj5U+KSmWCL18vVtZyb+aCsRoM+2+6p1+HeVe7w1so8SfZBj+RpBXxgXRyiwLJNWgIn+3MPmE2c9eF/CpdDGW47RL66qQKKuNK7TOmw7v4vlazqUqh47d1fl2n4AKwzLkrReQZ/SXV6fML2zssRSRACZur9Nlaw+hIUrXO7jxERliMLA61PYRh1Qm8B8dVwRIgYLp4wnhmmvCQqnvATX1QsioXNMH0o0bwB1k43lDc/mV2mIY87ehZ27yc+IQ59EsLIKP8S4zWfpjUUswZfZROAyUn6KXtDh6KROW7DYUsrgp+cw8ym3+Vf2Y8bzDWTvltgZSw0B1aduMIUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDiJ9JWzvmHFe21osm0Mx8nao+rAndnnw4AD82yJrEs=;
 b=PbWKWb31CcK5p5UL0rZrUANEdz5/8OzxySeudq7yxwh6MlIMZtXvfBllJMnlm/iqzAkQCpHQ4ojuZW0AsbPf6+gCV7rE9JVTz03fQOAbUKD0IFAdNq1FHbHOwRnCRvaWlcYpjhAcpZpxpMDwUkPBaKqb4XUdo1KvHrknxmbOyVingqNpwGgr4KBNYEaRLgpGMH6/DcI5acnrC8UvbydeVtFvtPSBw7ITkHoRnOkGnUp68UDRT+ON72/TGvMhbyr3pWoc6SZEr1qujyGPpivRkN+k1Mg7RsW0P+R30ZmH9J4QhhfieMpqEzHzLb8anfXazVbTVM+Np044sXAWBNDqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDiJ9JWzvmHFe21osm0Mx8nao+rAndnnw4AD82yJrEs=;
 b=DpBTMcylS2YP/bzquzSAu9lycsNzTQK3TAcx1jnfXQ8FXF0RN2ytZfvQRV0bQj9RPqI42SQtan6bZGYJXUCCXweiQTGs9tkZqOfq/6jtuSUN62nj7UD8DkkZ4/Z/sruKbW5UAImy6ZgAsE0UcSyh9PIAaXm6kCyPv2QAAbEY0O5Gz9wmlgMSNRlhoxQgd33ihjnPxSB08XQwoDAgHIfxddwVYlukeNkC++/diEa7zgrzliGONuh3yOkX1J6LDzmGdOlPbdd7T/Tda3WmdryNGBV9noj+3DEtZe8ToK2s5YvfHTpDLofiTIJs4O+BQB+PCM1IFuxk2fGUxBGKZ4/ANA==
Received: from DU6P191CA0008.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::20)
 by VI1PR0701MB6943.eurprd07.prod.outlook.com (2603:10a6:800:19b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:21:55 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::79) by DU6P191CA0008.outlook.office365.com
 (2603:10a6:10:540::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 23DED200C6;
	Thu, 18 Sep 2025 19:21:54 +0300 (EEST)
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
Subject: [PATCH v2 net-next 10/14] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Thu, 18 Sep 2025 18:21:29 +0200
Message-Id: <20250918162133.111922-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|VI1PR0701MB6943:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f39a48a-fa54-4a62-a451-08ddf6cf7c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOk+pk57rHwevRdgRNIFEeVUXOoQazuAfuJt6uzOU7g/OO/VtotIGKvp3Wze?=
 =?us-ascii?Q?ocHbOqRuhIzoZBa+5cp8CUMbdW+X3cDYj16MQodd46zCcOiz3J/eLSfkUINh?=
 =?us-ascii?Q?pDyeHZKD8vr40u9nhyEn3CSSzsPwBhdygWzNrHEALZD0RSTL3HWdhEEm/WeB?=
 =?us-ascii?Q?XwrtQckSwhgGHRzjKKlCX6oCa/H46fKqOF8dipAsC8dFL4peEOuOVGcFhEWn?=
 =?us-ascii?Q?OqtuoEolbLIQ+fp9RlcKCjP5AMusaTVtkTR9RMYmW7VSwGThoCpTN4JycWfC?=
 =?us-ascii?Q?EBG4XxNVpcUuYJ+J1REjk4gPSl5b9jO0oJE1tUUHVuiQMf27tYshEoocRcyV?=
 =?us-ascii?Q?nRymDC6yiCRtfNEoGLFd4b5Xv7qUFaqJ8K8I3tV6DNaVBSyxv7zuxjjBo3bt?=
 =?us-ascii?Q?HnBpgcKVrFNjYDhebqA2iId6TJOIApl3hGDbE5n1ggHA1jOjivImqEnso9NP?=
 =?us-ascii?Q?FY0Vzgt13tDPTx6i6EGol9php+6fd+HZekck49yXqshivBYmXSoX7TNJh96m?=
 =?us-ascii?Q?AcO6ou93TMvuIo/Z4f544uxag8q6rYqjUNkXxd9+h0OvejcDNvSMnJgp3YEv?=
 =?us-ascii?Q?1lyo8unR/wz0Iu4USkSsPAjPR5sT4pU5xAwa2F0lm4OnE1ESxj1ExrUbU4Xk?=
 =?us-ascii?Q?gIKT1ZV25yJ4uM82m6pheSR+cvH6LL4leITJvcWCO6/6QlKMnbUE2OlqJTql?=
 =?us-ascii?Q?Tk7HLUXvM5HMRgz4/Kw63Z4F7iyaIllW7cSiEYhrKbwsnbHNsxIqlsBPM8nP?=
 =?us-ascii?Q?Jfu7QBoHl4tTwp6QGs/2AE/ZtIDeJ1V4lmDYlPRVtxN7b8cpWqLVLK8QT70S?=
 =?us-ascii?Q?J3shNhIJgCtwpjNyV2c74Fx5MyIL/cuDoBkVbyXpz4bhlSU3JqeuQ91Ld5cf?=
 =?us-ascii?Q?4BUKTo+D3BJjE/e1xljF1PDAfcW90LkNNPh2FrnqqK1dhcFXC+3hyZD1QUaS?=
 =?us-ascii?Q?kSy9uTh/AeQO3Cb30u7ahNjiwn8Gf+esuBt2nFDBN1H3+BSPSmvjEl3R5CaY?=
 =?us-ascii?Q?Gb+J3aGuXySyKsNxHjLRSMEZr+GpquFUHN+Hci4/oZKgINSw/KjdGh8dSiic?=
 =?us-ascii?Q?JqqjtdJYXmSzbMycGIoq79IJ5pwmnqc8rnNQgOZGiwro0TMlM4lI/t9bYsXn?=
 =?us-ascii?Q?A2F10MmoJW5C2ZB4U0Y1Px3IkAKLRFSpPyJCeU22FpzY5naoHMt5c+PkO3wv?=
 =?us-ascii?Q?sBH7XEOPlAT0nd0B1y5Qo/YY7wluc4UTQPAhhINhPFV8nO10ez00RkSqo7jh?=
 =?us-ascii?Q?kGI+NTHaWQosgRY3NC/AcSQG29WjWVg7oYwMYmGguLErf1cTe5Yy/1b7mlk0?=
 =?us-ascii?Q?DlGQoEsx2dewlCxXvj6G+0JZ8cMyHHzkNfGnDNLq7aZ8Dcv3kWhE8QBAeY3Z?=
 =?us-ascii?Q?vFSRWS25XT7IlbNCEtj0ZbrdaEGIo35C8OXyiK7XcMRmA46hOTuSfEFq5sBa?=
 =?us-ascii?Q?1kHVxythdPQm9jiiXfnOI1+kcqIv23IHEkVUQf2wxhugD2KkRFMtkN8Hdh1M?=
 =?us-ascii?Q?sUKU6gajghpMfIkUspuwuIz3mTViRDpgArTYkRyA6v46XRlzh0LpdPK2cw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:55.6205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f39a48a-fa54-4a62-a451-08ddf6cf7c16
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6943

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
index f01cac9d39c9..2256d2efa5ec 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -642,7 +642,8 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(struct sock *sk, const struct request_sock *req,
+		    struct tcphdr *th)
 {
 	if (req->num_retrans < 1 || req->num_timeout < 1) {
 		if (tcp_rsk(req)->accecn_ok)
@@ -653,6 +654,7 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ae  = 0;
 		th->cwr = 0;
 		th->ece = 0;
+		tcp_accecn_fail_mode_set(tcp_sk(sk), TCP_ACCECN_ACE_FAIL_SEND);
 	}
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index beb23dd34c5a..752251268cbe 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6190,6 +6190,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
index d4aae5dc2201..df07b76ba84f 100644
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


