Return-Path: <linux-kselftest+bounces-48114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20310CEFFE1
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52570309ABEC
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B2430BF79;
	Sat,  3 Jan 2026 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="W4NNhNch"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2C2F5A34;
	Sat,  3 Jan 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445859; cv=fail; b=Wyt/5BOvadR7bCoCs7P+f840khuGKRTzLa/SAeJVGY6W1yFjUT3hviMSy2be6JVcVA656xG7slzIXoRT1wDeMP73ip08wqC/jXV5jIpbLGzAzE3Nbn8B1gfGtFrRLDxMyDZIDelL0+LmkPjnzHXOZ1r85cn5Nkuc7RSQJR0/nRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445859; c=relaxed/simple;
	bh=xXyJ5RoPsXdpYdcWdRnI+hUUCRdGNGmN2mlHess8En8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoAPfJcPvUIZGJlERf0XilA31Ueen+W4ulg9ND1kc4boEJqlC8LCl1XRHJySVgfYxzSQkvg/IOftBPIls1/PAMKWGlmxRSmcJ2g3tVNjxq7kffVfnYFnYFYmjyPn3RLlGQ3oPswFSC8YQa4hdID607IWtlWWA+DvmTREHL6vJ2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=W4NNhNch; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCqAxRhRxEjta308MbJIyWapaa8tr8blcqgMYaTLscs+shif8so4rZlkVXG0nMbFS3DnO7SmJNiyduB82ubVEsQuycBwLbZ8mmA6onSVFo8osuEwao5Q+Mak4Fh5xfkIjN5ZJR2L1fbiaYnIdJDsqNG5ZHvpiSDyBAaROuX3hjPpwRC4u+WwtWnQG6O65c0AmxZybdRkNbwEndVgM+3t9nFXvwsKukcq3g/ZqbwcgLdtixuuhDwTfQPc8bk2yLAyU7/mhpE+eRiN9jqRrcIA7Cd0SrGrvOJ9ObBZhvePge/7INFdnekyU2R4UtlirURxAlz6/M9Pj/dWTnbskbfcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtiZpceHrtvLWOySs8QFD2mj+ZF1liVMnngAePii6uM=;
 b=yn4u9yEhqg7vLi4Z1jYax3vINlsHkWiw/GDXnn7UDXLjDFDPP8TgC0Qb9l4NAYSKr+tWEnDfKPFHB8aFpqwjCGWo7PiiZlarc24zNINoKVooqZUP9ff7H/1ls0fgUZPR1h+cnqIFnwNdBRG/84ecStN6LI7IfkAuDAu4BGj7oxldeRULYZC0oP9XZn5ieieB8QohIAoE3oiT9wh06OY/SCKv1PTLNNgpwQlLqJxKQYlx60ei/Uy2IDyfldInNt1oHCXp+1eIMDuBlbhTGyFrs6sJHH4Ax7oaO7O/Ky28r6qzjszCmEcrUYuLlwxesGxfiDNcq8awilEPZyRf5zIJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtiZpceHrtvLWOySs8QFD2mj+ZF1liVMnngAePii6uM=;
 b=W4NNhNchfxxTv97fwFLAlrLlvvOEGx2rv3K0jIRVgGQTK3FQjFfc5pK+fCJqelh75CJtVwQIXPB0ehoK0v0RaQc34+0R730jRWi0J1c3Z81gOPcepA6d9AN7hZHjTWpUdlLePMb27xWJRVVY6u7Ym8PG6IxQtfQd9mN2aA/690Goly7xyDRcCKjlz17eM6g1GORKBOWQETnOetI22aPvnUkcpYNIUrjnIDVSdPPbLIzrBkLYplw4taXvG35+3NfLzFO2ii+/Ub9YT3tImAmQfdTRBmLTo+X+egSIRJ8MaXUdTgrTu/IvDwJFF4FGGc17Wg7m7g30t9/LhKPCQFoS8Q==
Received: from AM6PR10CA0106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::47)
 by DB9PR07MB11229.eurprd07.prod.outlook.com (2603:10a6:10:60f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:52 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:209:8c:cafe::d5) by AM6PR10CA0106.outlook.office365.com
 (2603:10a6:209:8c::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:52 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7B8E11C0030;
	Sat,  3 Jan 2026 15:10:50 +0200 (EET)
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
Date: Sat,  3 Jan 2026 14:10:25 +0100
Message-Id: <20260103131028.10708-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|DB9PR07MB11229:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a95f19d-d988-4067-67f3-08de4ac9857e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?S9oq8biad6q0uVGujCCjNvXu4CCWcawj2JxW151wvBEfqcaQYmatnUa+BpMb?=
 =?us-ascii?Q?udwlotTFFAp2jmqLbfc6kZB/9jLHpgOByzBAGpvMV1FFpqA97HJF0fvuYe5z?=
 =?us-ascii?Q?f79BC2CAk2eRAKml+T6BCqPfN3GbRzSaWhxeZhjn3r+/4Pdk9NWUa5qih6at?=
 =?us-ascii?Q?CLGLQU4FyKEQebzAeRX75+0e3OA3Xtr7tMbBhJHeOwXuVothWz+R4bjoDU/o?=
 =?us-ascii?Q?4AVFzR5x0o1VlV63+ptM51bIf2mYmLT1EeymjU0+qoxoHBF4WZ5nHltmAj6/?=
 =?us-ascii?Q?Ln5/Vu9oCFWe8H3CSH/JTWICmJdRfIaZ2eEvtSLiW0dF07STPqIzer7+Tr51?=
 =?us-ascii?Q?9kyZhK4xSfkaQCYeRIIKW4omHSu6+PgAUJks3MJvMNoW+dUfTmNBdRa1uYlN?=
 =?us-ascii?Q?WqS7bJGL0PFfp/LWTnG5zkoZMUua/A4Je6k5DV1oksQeo9g0H2Rg0l0rdp/O?=
 =?us-ascii?Q?CSzYymB0PGp5qqgmlPy2njdXII0KsK0ouqToDuNDPVkJCKpQM1E76W6ItnYm?=
 =?us-ascii?Q?RXfJh698g7R3HJ5TXyWsDvbnflGrzQUZ7WrSC+OHStDXP+y+22sEmMNfaZHn?=
 =?us-ascii?Q?/48NWyBO3jJw2QmXrTHf5u0Ysei0AcXwyhKWBTh4xrz5rQGZwfF+i+1Qw+XW?=
 =?us-ascii?Q?N+pYL+WNMVetjWadkDUSD8XSxBrMoKtx+1Fb07VbgIj4UBII5ocM+upvJbaB?=
 =?us-ascii?Q?SrX7osjEOREP1pSAAEe9GeRkV40htrfMEhn5qhU5qf2XbaGnhxO0L4Fnqmll?=
 =?us-ascii?Q?Tl7hR2MZdIOemmRWhl4VG4S786Gk4vaQ1eqi8LAyHcXocnX20cnwBRz4Yuw9?=
 =?us-ascii?Q?wI+ZgJ9xID+7rny6OqzB7DgOZUMD32k6ohvssLCji2x0lqlOlX1oXFrHkdEC?=
 =?us-ascii?Q?AAtgiQ7+Ac3gafOTVcPnA8r1Znp2c37fjLoWVkuiVqkNtXEhnjblYdYbccLB?=
 =?us-ascii?Q?xFXn+JIXJMlILqKf2rU4izOWSAzn+O/oSYyVgtsCam5JCiEd4DPg3NwHd6pQ?=
 =?us-ascii?Q?662n0irnjXBsxITW9h6qGH2m5itHWEuwcQ1onT72z03ObtB3iwIejVKRnB6E?=
 =?us-ascii?Q?zf6ZEPGOaCx55RstN2fC374aZcWEtocqHyNhsdtK0W6+pWZY0Kx4Zz12wpx2?=
 =?us-ascii?Q?+ZEJHlPwzl9a+sCg4ACl0sZvs4GRKd8GsKjw5elvURx14ysUUl0mEuMu6Ip8?=
 =?us-ascii?Q?R07spQ0jkli/7+mMsJzi6KD/nhCm4n8tZajIZYYeiFtLhSDECV8cxojmAvsy?=
 =?us-ascii?Q?h739k0FdNbS0Yy0IhfAytlCU2DUf6aKlL+PgUdL/Lw7RyvgahjClm/RqXdto?=
 =?us-ascii?Q?V53B75hzWapkxE5I1xoYXKrYthJv4rejRHRzjffM4SRKP9RnuXhHB6KDSTS0?=
 =?us-ascii?Q?K5KhTd+3ccseXRlWCjuk2EgAAwWus8T42TNFUPtxqhcnNm+GDBV8zoiJaoj6?=
 =?us-ascii?Q?f4sxw4MLw9lvMCv5J2QA44GY0ao6CYVNadE1A7Mc9N8Flt8bOz/pBsL5rjqP?=
 =?us-ascii?Q?Jyzs3hxrtzs9wqrGNRv95ZPrvx2TEe8a1GQV1bunlSYAHpwweaNrXFo02+O+?=
 =?us-ascii?Q?LCsBW1Qhelzm1YmgfyzzgK/UIypHVMhsx4Aba5qE?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:52.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a95f19d-d988-4067-67f3-08de4ac9857e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11229

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


