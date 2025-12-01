Return-Path: <linux-kselftest+bounces-46825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B9C984E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5975344845
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F50633769A;
	Mon,  1 Dec 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Hm/ewpnH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3E3375B9;
	Mon,  1 Dec 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607126; cv=fail; b=YkLXPjlZqRHq80t6PYeys9saSAog5Aaiyk3NtshOfdhNWkxnLdK+hU9uc75MiNpnV7klKsaWQCKE07ZvqLxF2BYALpYQV5pxCBLw7W+YuMGy2QRKt9obcnzROHNYAibFKJggIKwrB9NLkx8mrJJTwquD55gquQFwwpNK63s4nZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607126; c=relaxed/simple;
	bh=xXyJ5RoPsXdpYdcWdRnI+hUUCRdGNGmN2mlHess8En8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASVq08UHcI0lluIC+4Fyg0UGipCh2S44YAaArjN6vb/QADVlgUyfTnBov0nAK05BUAryx1k+M9Xh85ObfMmvpCHQZ9cgT3wM8ByCqQTK2bJTlx7HNH2KfjsjhDMjh/1q4RIw35q5RNYkt6/8/BFLAsYyGmcGqMrqMcrHjJh5k34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Hm/ewpnH; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EobLaQ0sIkjWxsh93Z5uCwwsy4Br/vu7gcon1vFOJYlDFUyc++im3+uEnTHZd+DJWaeJA8UsPfcv8lbaq+MFu4yccKpF2GkP3DUf5nNmRfeWVqK6olrV7Ixsf1ozx/qW9FZyGnPAaQJauy0lkOOQG/SqpHa3hj0toNr5OjUs2t/P9DNd59JHvoapet5QVYiHk3fQovMo/k+KcaLf1LFjjFsFtxXLRcgNar6l8ntZ8l6TLHJ0ahLysoL61jVgmP7uYYqBd9IKuQ6kh5j1WSvyOhkmS8EoZzhPnJadefUsdePUkU3rTOyFMcaDZVojcngzVbCQtCHWkXQ08RjLwbpsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtiZpceHrtvLWOySs8QFD2mj+ZF1liVMnngAePii6uM=;
 b=XLnb2JeMJAxl9cx+PgZFrUjYY59NDWAkZ9gfEUWvaiE/lamrnBTi5jsVGjo6s1hKMoJGLQPI0kzW2KQCull+Gc1jKbcVWrirpsH9OHaFXmzsZ35iDIpzidQkVG6OjoxsC9DYUSD6CiRIxjywTdHqq8jt4Mm/tIvNqZHDMFxlJYfg4cCGu2jkb90+8sgGX8112UbzjjUMXV4A7wi3086vINlZ1WugETgHlaxH9KOE4kMoFSTxEAnWr5j7aVEwS5yqr7kYBgnMDPL3Bds/I3zUwv23hmC9gC4P5pHPhps+32HNlqJ4c6BmESxJJ0ZelAlWuO6+Y6F/0rXkydZE1QUqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtiZpceHrtvLWOySs8QFD2mj+ZF1liVMnngAePii6uM=;
 b=Hm/ewpnHdXzDxXAYYPuQpT+pCAZMZhAiJflDTrMuNn2HxX6YAzlyI8aB1EJKwtOpvRR14/mTSyu3GvQ1ft0925FsSo/tP8lB/cTgeTGtu52jF/nPWJRnMV+sH/2nfOp9nONJAal4Of0mfRDVSCN8CEjE9yBx07x6REyL/Bpkwd20dLecjszCw4Iv1TeN8GC/8yWa4sp6gujc6bLUshyeG4qcEtXAuwO/VyyUD4cpjiq7bjV2UPMSdWT7VhqTpYWAR9v22X5cICjIxWb84ugzd+r5UF3+zJqHATeh9N8XE708pvSnMbRzApYL69zr66dnpUcVrMxedH1ar6XvAPsGXA==
Received: from DU7P251CA0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::14)
 by AM0PR07MB6321.eurprd07.prod.outlook.com (2603:10a6:20b:151::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:35 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::b4) by DU7P251CA0001.outlook.office365.com
 (2603:10a6:10:551::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 57A9268002E;
	Mon,  1 Dec 2025 18:38:33 +0200 (EET)
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
Subject: [PATCH v7 net-next 10/13] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Mon,  1 Dec 2025 17:37:57 +0100
Message-Id: <20251201163800.3965-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|AM0PR07MB6321:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b374d315-67a4-434e-9b21-08de30f81250
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?OwpTFkIEC4NSbWDLn6LkajzCb35PsaI6pNzk4M+YQfgqKOdkg6kRXfmj2Frv?=
 =?us-ascii?Q?fv6nFTe2NDaJNYZDpoBytt0Jc2XGWPYui/rSFeCAjuUf+JcN7IX9wMC9nnEd?=
 =?us-ascii?Q?mN3ztxdB0aIVcALTv8ANxIXAY7Q374RrEMhUMMfF5VpjkBFYrI3jL2BaMVaN?=
 =?us-ascii?Q?1Z2IkAOq3UsOATgX97Ts4F+gq5ghUe5HSLSmGjX97q9bTvlhi1mVErM+SkPb?=
 =?us-ascii?Q?eS4cZm7HHKHDsOOaBVN75xs/un2RRNtHLCtdS9/4KfbO6rNOIGFM358+G0Zs?=
 =?us-ascii?Q?tDxhT6wDfS1VV0MU+5RkKdbBqZvcBqcTacTRbJvTPglrSERGix4V1YBmUxR6?=
 =?us-ascii?Q?Hc3ExJs79duzPuLm84BOxBgcZ9+me0+nvGKLv8YfNzW29cqZPWGOqVYRrcmK?=
 =?us-ascii?Q?g9AToDJ0qiDBzdAGkyhOIcafgVh5dHeW8IYBMlikgP0tXKSYobT/VH5g7xmo?=
 =?us-ascii?Q?kzmkRNrb1JFbnXkHWnKZaaN54kPyF7cTaU8YQ+T0u5QUJ7LHOuwvWR/n3ENa?=
 =?us-ascii?Q?BOc2n0B40pyzLDtcZRTCrbitJV2ENhoeTEXt/KPnhVt4VCsFHrKCZh9IDwVw?=
 =?us-ascii?Q?GTWIVPmAgRiXtJ9tSKhnJDN3suxn3VZU5PwftgxuXIKSkvjO0cLYqYf4glAH?=
 =?us-ascii?Q?7vCbeJiqBPAkQomz60rN4mYGlW5HYnAstAGyM3e59r8Xl1rBH4aSZpxGmeOz?=
 =?us-ascii?Q?vgPodMQZcl6efIXtnAW03GdTwTW1eHEkwiZQhOlE85ggJHySjzTNAC7zB5kc?=
 =?us-ascii?Q?p45W8VSjcDzNpO6DVWRJqpQCl4XSAXWFENEYAy95OH3F6/HwaC7Z2SvHZfm8?=
 =?us-ascii?Q?YxIFLUH9E6aXlYA+xKg3Tb3kEVQ02Eddnxzd6bg3Q2HMeV16dSrV6T8CgPyr?=
 =?us-ascii?Q?70Sl1qtj9LQk+jAyiHu+vsJyFtsyGIW4c53AXTQvDJBxmrNJ2Q3CXiW3TcIa?=
 =?us-ascii?Q?RBjmzIMkKdo9kTNCIkCt2Sxl+bky3mDda8buCyZ86bXsRzU9OEeLftNxEcz0?=
 =?us-ascii?Q?xPZGLjZbLnFIDOudPQKzXMUvh58fl/O2HOCZHRQt6dF24xEZZ3WD6IPL31MH?=
 =?us-ascii?Q?0m4pFts3CMFjXt3HbpmUX7dKScyRIo8NO1AcArXsU1Z1EjL0Bf73jurTlP3V?=
 =?us-ascii?Q?c0Io7dQbC3NUhIxrzQhCf953my62lkLUqION52K664hG+y6xrtLp58teqaMD?=
 =?us-ascii?Q?s9DhLEoMGsS+tpJbSxYIswfGbKtt8tlTfANkHbnkf4e5ZPd0hrCljSm8/6nV?=
 =?us-ascii?Q?ccxuBXqLNNWRnNuLQ2K9fcTy/P0tfBx2rgWHl9UXHBnZZsj6njO5m/rxo+eh?=
 =?us-ascii?Q?3Fds+RL2OG7SwBwrW2fzBCmwcC1wxJxEAVmGWrFYLVki6nhlWavg56S8aAUw?=
 =?us-ascii?Q?Fl8Wux7XQU5p7SphXtdahUKTKyvI9jsRddFH5d9/QqN99LMxio4hDmUx7S5u?=
 =?us-ascii?Q?8nCsLyx0l/UoelwM2Suy8FJBrl5Y1SdFzhWuU3ZmetmdzRMv62iOW13tAl+N?=
 =?us-ascii?Q?W5ntin7cFKkVh6T3sOSiWmo9nQBNt03WyGPRmktecJNLU9I59DFQqx/S2aaw?=
 =?us-ascii?Q?2JofoFu5JgrYcYbjgO2kqjRwZ0GspjAcIYb+YmrH?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:34.9671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b374d315-67a4-434e-9b21-08de30f81250
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6321

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
index 97d57c52b9ad..c994a00c83d2 100644
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
index 9776c921d1bb..ff573fad465f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -749,16 +749,35 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
index 160080c9021d..8ef2f105cc21 100644
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


