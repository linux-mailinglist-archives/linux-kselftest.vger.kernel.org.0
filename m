Return-Path: <linux-kselftest+bounces-45623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F4C5BBCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB733BF62A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D602FBE11;
	Fri, 14 Nov 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jsnszwYq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FD2FBDE4;
	Fri, 14 Nov 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104461; cv=fail; b=jyOBgbP8XlDmveUm7XPwuaZTMWHhzHTAQuuxu1Aw+1Xw8zetBk1ldTtQH1JmtoSULFn4zfyNm95Fzmy0JZnwJyIYEIog9HxebVpiEwzS+LYP86Y896lT079Tl+AncUvOJZSLV5edY5jSOMzQUNXgkKGlC2lHufR5til6ZKEw1sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104461; c=relaxed/simple;
	bh=lGONDNudOt53M5R8HW6LMl9qv1+ISH4YbBZq8ZBPd9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8azK/B16CZagniGEivVOGNoSEHDkYQihuXHN7LpB6+GvaEFatef/e5tDXfM/fNh6OYEEuQtdRe616HscHyUy1knVZqFEZqz9BLT402h1eyqWQgr+DVt3AJCmjO8L+iFiX0S9YmpkmnlcTRFTia7yqMheNxaKjntpieChR2BFuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jsnszwYq; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNPKQfIVBzUYNlfI5f7xdTqd/Vzg3G7zFSxwZ+Cvnptuxz/Tq8gPOFvILiMdMi56SdmHBEABy5k2Wj1x+qPryGQVse2luH4pcj9QDsaeSLvQqbAHSwgQzE9UBuPwisEHppgjAWW5Jkhu1kBp4FHGYkXV7n26T0Yavswv8DFWJk7Bsi2l4i6XrQiPT+ue4SZJQBCvSbw8SHYkyCGoCled2kNsqrLsqPW8n6k5UkfISorVuBBGMpqXDW6gqgA6vQbBJYsoQKs9PvT/YDT9c2M5KOwyYiTSOu+bbCIhaUng1XDnrQKmT62l2zPjm3gJmY+gB8IOkfe+0d8jsjQUP18yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3JCpKiDd7sKI2pS5L9RLvyz8vJAczdr66I0y7OSNnY=;
 b=SKgw2TPuanuVB7wGOZAkCiTVSn+TApGgaswhgp6Sr7bTEDQ6ANBiJvIXWQv1XvZvyuyMXt4agwNGm0hfMgKrjZdfWAFJXph/17lgAY6Fsv2GKJB9u1GZoKqfI1UioytxRlOUGsjDKijXkkYkATPYHmzYubNyj+K08bBTa26zdCVlql1u4rT3FqKz2JcpUjxpwvw6Pk/RXiOMzXtpYUICwozVWfLm+flH/e8VH1h+TyTFNduBvYIC9/Hq3FFzfZ51JahFdl0QxmfvdSu7uAZ5T9/kf3OdjR1USHL1ulRKRhth2Mgwh2iOho1ABPPIffAlvYJF9fgWhsivznGt3wgsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3JCpKiDd7sKI2pS5L9RLvyz8vJAczdr66I0y7OSNnY=;
 b=jsnszwYqY9tjWYeR3uSlRd+vxd+DooepQFZO4uYly7HVuZS72iOC7JkRNcQ4Bs8L3ZHCrpz1H3Qtt6SAqn/+04/0tjicbXYO8X2Y3rrN/B1LfA66gLEZ1zsd98DJPMzcxsYBrIGleg1aco+G11ZO7ti18xJJkzzBVveeG47SeSpKPuTRSe43Q/ij3EKp0JnDAjLSpbyHNJUlxB+x/rRDQ/RTKUWeqH0k+LhlXKiH4JEVPM0Fl9SKW0WwpWRLVBThI1sOAeL2Ov2JheHJlAWLkmcWNsucAakQUZIomV7YRFOaigvOJ3wvr2oEnmeu1IKHut8EPbqCbONCHUgObjUqlA==
Received: from DU2PR04CA0078.eurprd04.prod.outlook.com (2603:10a6:10:232::23)
 by DU4PR07MB11511.eurprd07.prod.outlook.com (2603:10a6:10:61d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:14 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::23) by DU2PR04CA0078.outlook.office365.com
 (2603:10a6:10:232::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Fri,
 14 Nov 2025 07:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id DBE681C003A;
	Fri, 14 Nov 2025 09:14:12 +0200 (EET)
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
Subject: [PATCH v6 net-next 11/14] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Fri, 14 Nov 2025 08:13:42 +0100
Message-Id: <20251114071345.10769-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|DU4PR07MB11511:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 90bf8572-ccf1-4881-aeb8-08de234d6adb
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?nG/EpuaRHa/tuIWK/9AqZlc0KC69qA1oazxsSEnF0Wv9viG01FtH3T97P6PT?=
 =?us-ascii?Q?Oy8ARYxn03iVVceLTusaCxbaZ4K/A4drh1JpJWkCG+EFJn1mdiEtefK0CbnS?=
 =?us-ascii?Q?Zafa3x3PShx5wBuCORDkiWwspx9sOT6NPe5hIDU7/L/U1faSn7UeQl8e7FVR?=
 =?us-ascii?Q?YmqwjLKAC03z7Moxud6DaI6MYwQlvWk7Ce2BItdZiD+lgU5c8fj8TvlVrGkB?=
 =?us-ascii?Q?/oKhjfzQCdkz3Y8F9PUElKMhhHsuCc50G+PpjZ36UVARrzhMrJUPAjrSekZC?=
 =?us-ascii?Q?JT/QD/+l12hMiGHei9SxwIX6PeztevOTqkgZRPZGZnnvJZIzFqG7GkCOCwrF?=
 =?us-ascii?Q?S0UsnhrLVJG74wwL2p+qkzPPq9pizD6Q+yk6pxnBArVTQDdGGuO8Ql4TnqXS?=
 =?us-ascii?Q?5a0H2sSCw+e5fvHa+EFOUXSc1cudyW9q3CtX7+wnpVBmK7FMjLS34+Ml4ETu?=
 =?us-ascii?Q?BbXnKjUfCjB8pwixJg/aVDIiT/zVaxki9DRe+FvrYwmdt5IFBytvxdBfqWVm?=
 =?us-ascii?Q?X3whj+ekGbhqDB8bajtiJ/brJ616/JfPL5brTj75n1382+SJZ3Du4O0bMsuG?=
 =?us-ascii?Q?0zQ7o9jAcAMvWoY0UwX5o2XkXfzkMLXhDmNtE7joePOt6M9vY+gK2YKB7qz9?=
 =?us-ascii?Q?v5BCh0+qP5IlEVaiZJFhiJEJ5wxqBLhdocSDHcsyCK73UTY85slH9E2+8l5C?=
 =?us-ascii?Q?xzuCkCYhI7CIfigPcvhywn3ypdCB0cl4iFz5MU6Yd48ol8SkEk+qYGV7IHPU?=
 =?us-ascii?Q?NcUAQoomnRBOb3EXq+u1tLpLwFxgMQbcu5qxGVyKQ4vNunnmo3ey7C/dzpQS?=
 =?us-ascii?Q?TyKEmNZ81zgrirc1F4ZzbzzSi7sO8PRwc0hg40OcIT/GF4aJ/9K9Spcr/I1W?=
 =?us-ascii?Q?LyEIZHjd5ETh0xjx9tmDiAnMrJhhs/Vx3kaK9xbAuweXExeMQ41DNkNv3SP8?=
 =?us-ascii?Q?GmNCKZqeW5OH899A//TmL5rVnJt2/jK9VO6cKVPthW9ODaL+V3ElqDND5zr3?=
 =?us-ascii?Q?r+F/ywSmLJw5dhinCLQNmoBAH6yfVvul21WokuhVBvoLe4CMoekvIwwvB0WY?=
 =?us-ascii?Q?ZRFXVkvpDzdjCGqvPb6vcragrtfxi6m1n/a0e4svBJKYx+Jxce/C2fcYdzuQ?=
 =?us-ascii?Q?9fgpNUwnVOI3+Oyu90Huzrrf8Haeia1Wo4kzaxoxh9jnuiW+dsjAd9Dvhdi+?=
 =?us-ascii?Q?Cx79PX6P/XmFqXCcKaGaPel+8JSDoER462VXGNqYpMHv+eeTf9R6Qc1RoviK?=
 =?us-ascii?Q?hfNmR4urjWude9o94nYfSTOD45D0KJWqBKUnWgezI02TOQz048y5jvb2aTJi?=
 =?us-ascii?Q?hI28geRxBzFiafpmnUN0oadVxVRfwxTQOhAIJ8VqLtVtTiIlpGeB8fObtLUk?=
 =?us-ascii?Q?V5UVlt/+JeJtdaNb+Zs9lboZPJfhg0mT3PNfz653GZLP077ft5yrkeiO5FH9?=
 =?us-ascii?Q?LLUU9HZt2JQklegwCyZWRHswOE7AFJTl0GuvKNrN3nBYaqgy8p2a2qABgcqS?=
 =?us-ascii?Q?ykkWW18QOjYsf63qPi4UlfSbV1o0wf0mHS6QS23o55iFU+zzjxa4Hgj5xJVW?=
 =?us-ascii?Q?J5F0J0nxA2dPeFy6EQkUo8pP7pLqdoJg5G8ZGWkR?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:14.4612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bf8572-ccf1-4881-aeb8-08de234d6adb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB11511

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
v6:
- Do not cast const struct request_sock into struct request_sock
- Set tcp_accecn_fail_mode after calling tcp_rtx_synack().
---
 net/ipv4/inet_connection_sock.c |  4 ++++
 net/ipv4/tcp_input.c            |  2 ++
 net/ipv4/tcp_minisocks.c        | 39 ++++++++++++++++++++++++---------
 net/ipv4/tcp_output.c           |  3 ++-
 net/ipv4/tcp_timer.c            |  3 +++
 5 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index b4eae731c9ba..ea5fdbf05b05 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -20,6 +20,7 @@
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -1103,6 +1104,9 @@ static void reqsk_timer_handler(struct timer_list *t)
 	    (!resend ||
 	     !tcp_rtx_synack(sk_listener, req) ||
 	     inet_rsk(req)->acked)) {
+		if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+			tcp_accecn_fail_mode_set(tcp_sk(sk_listener),
+						 TCP_ACCECN_ACE_FAIL_SEND);
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
 		mod_timer(&req->rsk_timer, jiffies + tcp_reqsk_timeout(req));
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1f354d3cf26a..7638aaa8befb 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6230,6 +6230,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 545d3ba0adcf..e6cbd4317fd5 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -750,16 +750,35 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
+				u8 fail_mode = TCP_ACCECN_ACE_FAIL_SEND;
+				unsigned long expires = jiffies;
+
+				if (req->num_retrans > 1 &&
+				    tcp_rsk(req)->accecn_ok)
+					tcp_accecn_fail_mode_set(tcp_sk(sk),
+								 fail_mode);
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
index 0672c3d8f4f1..58b9d8af4321 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/rstreason.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
@@ -479,6 +480,8 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 * it's not good to give up too easily.
 	 */
 	tcp_rtx_synack(sk, req);
+	if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+		tcp_accecn_fail_mode_set(tcp_sk(sk), TCP_ACCECN_ACE_FAIL_SEND);
 	req->num_timeout++;
 	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
-- 
2.34.1


