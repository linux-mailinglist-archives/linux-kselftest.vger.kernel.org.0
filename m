Return-Path: <linux-kselftest+bounces-49403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7565D3B691
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A9A306B1D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3DF3904EB;
	Mon, 19 Jan 2026 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iwj9kp96"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841B38E5DB;
	Mon, 19 Jan 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849168; cv=fail; b=aacxT83jGXoXGx7SGCq1z5FczIDXXEwYnXtynfeCMoFTMmmqpef12DfjDmMcbncJ90kWd8AqB0F8Zp+UTYos0G5otL248Qwnm75SWPodfeQyw4YZC6lkaHGhZMHqqporX2r9E5d02i524HGPilLMiCrGUTi4IwJeHGPikIPNdck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849168; c=relaxed/simple;
	bh=Q08bqtqoWFY/FO9EwMt1l8gBSAiz3jwdQfOO/ymdTak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoIF0Htq4syWyzq6pXYDR/rhMtwtClXTHp65eb50HmnItC/WIGk8fwPE+/eioOsRb15slauNeFPRFEP9ngrGgTCJy7gQ7X0tI2n+YKNycx1V67mJNhoHpipd+hiWMMfR4QBNzSpWwvkIesyQUn/fOdJzBP8u14bEZXF+jWCVu+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iwj9kp96; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4n9bE/HyLEc4A1OXim7yVjsbg+stb/xcea/tyno32VyxayqONy/8U3mRhqTse4hh7r1D0YXTkjPvlDRKAslJovq8Gku0OUMh8i7RY7TyLdxB8fOooVzGJwVaygEXOD7ZerJXMtg7kCVmw56qXvzlhTI1yiF3nmEY2oGwgAYq/hqtAgK296U8bxY5/vJf1zVc2Cwy3k87Foai6gDAa91BpdQ+nwVJL5o2W1QIdgeqvX8z0KPEJSZODXCNQ9EGhyWAzb43ba2f+GKAlboxBLfYuVbEP0QjgzMJLTuYURVY9My8DAlt5ELMPi7vQToYWmL+3ZLmHkScJQBcckX4FDQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1xO7aia2jg65YYELcnVgKEROPozDwxkOO23ueyWS6o=;
 b=CEwuYnjHtfmFnl8OJ/qI7qzOBoGDmXboPzjJkYaj28zWu3sjfE9EiS98UDWsInbIuzz3F/HUJedb8JuAuKsmYOLoz+1RxfzP9nLKzWOvgnUEmicLkQRDLcjFhCRfEwi0MiWeYFZaCisjgc8l3iODqFPepTqXX/u02mSwSxzb8ccsrFcPnmSGAj1rcTABhxebe44REQ30JlLCYrCUNNSSgqg5aEpZrIAEfYhsPk4yTKLp/2ISyHz1cTFubAbbP6EVMUaJ8Fu+KMSstgfQPE1rZIHKveqaliNHdwMMHLhsOZfoVq+uWR6t8/+mzdiiHdyx+dj0et3S0uAjI1mkQm8nkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1xO7aia2jg65YYELcnVgKEROPozDwxkOO23ueyWS6o=;
 b=iwj9kp96PP8GIi2K7g9fb4OOOCHvopyEe5BjMY2SvUm3R6Vnp9ABzeJDR8iXrorcZcWnqK2mkT9KhFGI1ZSQk34s8BLU7CRqMHEr6FLY/AztDe0s8WMCjwvvQvCfJsYvecIhEID5ph3UZ9rFNN245DD8lcilbW3ucruxFexfe3FtBclqksUrPNNEtJPtvAhIh1MdAYcxZOtBvV8+LvpoLcyBdtOCoOnDNiVXl81sgifYuV0MdXnUwQUAOyu7YfrFbYuO36jC2DxnYJanGPRvgOA5yykqvbjLM+0BrMpm4smXteewzCOciUpxcWM2kmbHyotiseWEhzWmEwpCEIKu6A==
Received: from DB9PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::7) by DBAPR07MB6677.eurprd07.prod.outlook.com
 (2603:10a6:10:184::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:21 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::d2) by DB9PR01CA0002.outlook.office365.com
 (2603:10a6:10:1d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 19 Jan 2026 18:59:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id DBBF12014A;
	Mon, 19 Jan 2026 20:59:19 +0200 (EET)
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
Subject: [PATCH v9 net-next 10/15] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Mon, 19 Jan 2026 19:58:47 +0100
Message-Id: <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|DBAPR07MB6677:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7594cb56-6a4e-4804-0055-08de578cdb13
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?SOl5D+FzsKguQVQ1o0vVSJI2+qsAfHKFf0Ai3JTttQlXlIk4Pj0K+tqENQkE?=
 =?us-ascii?Q?FsnlZxblUXi3l8c/hoNxR+Z2VGjV3qI/+0ARRzQRYKXiltosfH9UGcWKpdU7?=
 =?us-ascii?Q?hUhIQfvj5k2buW+7DP0qDYsnenG74L6486t9D2iqkwMLGHwcCqSGqmp3ZI8d?=
 =?us-ascii?Q?mNeJn5sWIyVqPI462+gzjxOGRtYLXU8PGqAiCbNqukyi6rPVid3+RiLe0gb3?=
 =?us-ascii?Q?wkLz7cbmISpR3KX+7vS5uCrDGjbakAXVaCwAazNtVJPcbt9qYACOxLbtkvPe?=
 =?us-ascii?Q?Njn4aSSs8dH19wxNGngC/7lgRS4HcSRQt8nmSFtiV9soQuc92biHSN1/49Jr?=
 =?us-ascii?Q?sKyttqrch/mOmbf3vBdFN3k8dtcQiPfylTTFdiGl62pcjx47xSI6gcwG4hUW?=
 =?us-ascii?Q?T1yxUNMFS5kZfIzpI0oq6Ah5k8F24AwqWX4hdg1CfgFkDizJ7QSSb0jwXu8d?=
 =?us-ascii?Q?3/+kcZ/cizEiXiE0wOZSXA5cYmA0L01DTrDI72x2Ceh/omoykOBFCRF3l4bg?=
 =?us-ascii?Q?RctovmXq+OcOJ4wF3Y3Hij4GQZMFB65jsLES6BP2tmn+fCG2xk4BEIQL2bCZ?=
 =?us-ascii?Q?QZP1wQ+XpQQmpfm+NOKqrQemoOtilK7o7j0leSqIXuD3n17UHQ7/9khn/M6l?=
 =?us-ascii?Q?Jvs1z5W/rvap074/7hrY4hz++zlj5i5J2mrZcwssBcKGbfTlpG9Y5WT5viOb?=
 =?us-ascii?Q?FlE2I+ZnUEm8UIroRX5xx0CCX1u7qkjIsgM4sO429LlzOZU0i2cnj3U1EnB8?=
 =?us-ascii?Q?LRZSSLCafUtk9Ega7kSaog29PrZk/ezGgtLqth0/gRfkbF1rDhO+1IgIDKUh?=
 =?us-ascii?Q?nA8FfCWyHfh/S+d0N1oF3uE+361ToO84kX6lx4v1p5/yPRxXRrkD4PXiQYFc?=
 =?us-ascii?Q?lnJC9b/eSjuvhOpJ18gjZoU9s2KbHmpc1mtHKU409rH2Y2y7Yl9qgiQVh+h9?=
 =?us-ascii?Q?zCAV8YQDYzt9VO/yH6FvVerk+l2mZ+5WaAMNuxrRkdhVBiZOUAumuPpIAloq?=
 =?us-ascii?Q?GqJwaKoxHZ+juyTsAzWKuGlFJzIkTx/9sUalTC8mR6lCDUCurhJMx1hnzECH?=
 =?us-ascii?Q?zbdqcFQ2CO87SqP+Xx6f943UuZHALnIO8eI5AVqRyll0C8Q3HszhsAQfrktb?=
 =?us-ascii?Q?a5MhqdxpWruGl96pOIc7xycqaq5xLcYEWTq90E6y6BXNwHthJeSOEiJEIP+9?=
 =?us-ascii?Q?mAG0OyO9rdBS0ykVGOfYNXurp2FYN0P4LO9GaYasyw6piY7fE0rCkOACifNp?=
 =?us-ascii?Q?g/AnkevioHhN0efrEARd6WjWyMgz8nkebGIZjA/sWNvl5abdsl0TQ0kDq7o8?=
 =?us-ascii?Q?qYZVX4Tdox2E1nSdC3j1Y0ajeVJEsvW9stL+XCq+JExdySdlIsIE+l9pprbT?=
 =?us-ascii?Q?kXZO9oHieP9YxsX6wG6YtdkD0nn2BDNV17DkkHOJ6UvBRfPxIqAXF7mDhnds?=
 =?us-ascii?Q?heY1Vdz0pDGu7/uFvJoI8oYEMo9rffw1JpHzN2MiocZyHwD/zErq2ebRcWvy?=
 =?us-ascii?Q?kt5l3ts5okqY0TUaS1VSnKKDmuHD02GwyUTCqK6X1EBajGQyceB1A/EPl3Y7?=
 =?us-ascii?Q?lITzCZKS4b1ozdFUYyCvO9d5QrcfhAoSHSbQJm22uA1mapMH58d1MJI5pcnA?=
 =?us-ascii?Q?hKc+dCU0rlmhINFYPwc4OIuvrxNowjRGZgUGxyyQSyP4WeZPq+AQJwGxvDr6?=
 =?us-ascii?Q?2ekwfww+vY2TStMrzYe08BtA6KQ=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:21.4882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7594cb56-6a4e-4804-0055-08de578cdb13
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6677

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
index 8536ad08a668..042e7e9b13cc 100644
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


