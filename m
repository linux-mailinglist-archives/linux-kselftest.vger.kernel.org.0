Return-Path: <linux-kselftest+bounces-41875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC960B86023
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDE61C86655
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17259319601;
	Thu, 18 Sep 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="i2M238LI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47E3195E7;
	Thu, 18 Sep 2025 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212517; cv=fail; b=lEpQIkH+/OF/88UfnZnoLOKw7eofbpHn4e7sIdiC4JpksYsJ2fsXgRgvWlOui0ujgpYXP6y/hDOWPq2OZGsLTyJvJd3ejJ6PU2RBZC6FK5d/WgOfq2EhfBGFXQHIylEUBt1zlJuAFnGBxyqmvvIS7e/bj0/u9GFw5Cy95nm85fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212517; c=relaxed/simple;
	bh=YvgFBCbNUAYP8teox76JJf7VSwmY6IgfT9d0QuVcTQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcPg6HsfruSOsLBg8C4zHiDDrgF97H0NBIjHheDOdW2YnWb2ZtPLHOcsE9YDanAoqj7ygBCSgcSKvpSIrcZiXX2LAzt9XKoA1Q5NgkZjZ3jz1tuHgFjNkgPEmx9FOX5HdMrFUK6nisrg2JjzYXgDomstQU931pzzfWn/vrTlBug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=i2M238LI; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRhmuh/kP5DAVgrQNEKOnOWPV5yXw4SQvJkS8P9GSTWvi/QsbF1E9Rd+QLQxiZsbIx3PFaRH1qeaoBZ35Y/fRNlyiRq0cJkklmAX6KKwj/Ig8SwMsmttZX225xFW7jjkU5A/Q6onOu0PkekDjlztgFuq26Yh53epjzT5zAqNwIxVEyh/iNHgRXMDgWpRAvyM8eo9jmTVct73n+zsGwqJKQtSf0K2YK1YAa7sZEBFJlDWCStMWoh9EZOtHFm08YM60yOxS8Typ+75FqF6LqoXTsLX7vNj3P/uTycsjunj1/UckannnXSl7d9vWgT52Gov1fFTXOpe8GzJz8X7bKJZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K48b34ZeZn2HVI8+rvQ/lPobZFZaUPV3xZTfVzLhAms=;
 b=M5eSpxfaRdx25+ADO8OqQ8ADDansi/zBjP+5YfV3ryIjcsfKdsqQK9k6i1F2L/A7ub1A0FcjGnuCYaGGPabme+EBrs98S51JS0Le2TbNed5/1Jw+aiNn3gonNFLVKaU8ISIEhU62egJ8abhKl+qd6L5OvI6uIlGieeS0aVNJ/0wOy5oCWVlf25uGFCDu2rTv4cf+suVoPGoTgzS+L6ffvPRRVnlAkNBd8ZjgtsbpW4DhEo5cxPRGLImaJ7lAwlXjp0fxjVkkDuhXVBikZyj3M932vq2dJj0KvjRQWV+bEGQk/8HhWu+GnCCH8xrpLXe/ygbLylau7nQgAUS/m9xX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K48b34ZeZn2HVI8+rvQ/lPobZFZaUPV3xZTfVzLhAms=;
 b=i2M238LIWQVZAqY5hBxlupItrfKQcykxYp2H9j4cq1qUOKRCMg80SUaIm4xuafcyH9fYb7pyB03bC1qgGBcpG0f1VDjaarfO/1z/2nGtnnqaeNvP6VRScvHxn9hi3QiPQs6v2ki7ZXBxDZzPR/YeVhKPHeH78m2oP2iywZCVuB0ACzAb7+8RNiT+GPFSRXRpEmz6V8iv0aUAytAIyIbQ+G/thh+4vp3QHQ8OrDspOWSl2y0itUxhrOtoQnPsa61fqADmRC3GzrefCWQeFtj+e9Dam3nWBItTYormOTAfA74nrQa2308Yp/kfybZ4FvXaA8/zPVCpQBeL5moT1gxb4w==
Received: from DB8PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:10:100::21)
 by GVXPR07MB10798.eurprd07.prod.outlook.com (2603:10a6:150:287::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:21:49 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::a6) by DB8PR06CA0008.outlook.office365.com
 (2603:10a6:10:100::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8A3A8200E2;
	Thu, 18 Sep 2025 19:21:46 +0300 (EEST)
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
Subject: [PATCH v2 net-next 06/14] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Thu, 18 Sep 2025 18:21:25 +0200
Message-Id: <20250918162133.111922-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|GVXPR07MB10798:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46c3c1e2-bd30-4a13-a35b-08ddf6cf778e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tyZMAZVz3jO2imIxZuk8M8MBEuVKMhL+wYf8O7FQIkcikn1n7jl5/EfsXeoA?=
 =?us-ascii?Q?Shn7NnAL4BPKLQCwxfwEln97dOfItXNL7KNn3ZH57ZCVtmYWfY2VHCNiTks5?=
 =?us-ascii?Q?FeoSQPKJFaeGs3wOqDxoY/FIiKzIDoXavma/TlSonqxvwyeA8dwV4cecFE/N?=
 =?us-ascii?Q?0IpLFJJ//UsB0EpPmaMQhL7ynwjacO0kfJl/coi/hTbTCnDFELQ20ajFVLRL?=
 =?us-ascii?Q?idHaaAb2HLKwBwF2tvCjUIfP66XMDU0H3gvJwxUPVKp/fT7v1HLmRjQAW0ns?=
 =?us-ascii?Q?zB7yDdYCzpkd21cLPqDyAxBTAekSPuWdHXxS77BAap8bmhv8M9Ac1avzVSBI?=
 =?us-ascii?Q?jm0/hG5/9zgkG1DWXGxB5GHj6TMxUaeoavS/A3IdlV4XbFBTTrkP+fwD0Q/q?=
 =?us-ascii?Q?NhbUbKzCgk4KHU0nr/JUeYVce3sR2eJGs+6urLwaRVrWJWHZ6gSviUPY8KQn?=
 =?us-ascii?Q?PPTqwmUZdV4Y/IvE77mWtGeTW6o8V4D9A1imTcHIv04AcOOUK2h4sc9tkCdN?=
 =?us-ascii?Q?cTqJnvE4AnBQPfwatFuVtCFYEHTayDwbzmenqm6zm0Jt0QMpxQRfH5SHe7ZA?=
 =?us-ascii?Q?H+eTjXY6nEwCZQPBFaLAgwyqzLTre31+e3DVPN9aZrpLhxJvPykibPiebquG?=
 =?us-ascii?Q?5aBOogn+4S1GC9ruxhoXemuSsqCIunHBomo+3I5ekhTqJat+uX2lrR4lK8d5?=
 =?us-ascii?Q?fg+ODP5ZTyFrXdFa5BlN8UDQ8jfv9jygjhMUbovSvMpSl3c2bKqBMjaHsmyd?=
 =?us-ascii?Q?wG4CLNZqnfnA+XFPJnrm+ogvzfSA/g3YJLjrUWCdhfZsLAgrC1ZbVVftG0eE?=
 =?us-ascii?Q?aBGcCVZlXkCBc9Ee7pNJ+FGmm2f6YEAeEzddwLW3owYl+c8LDpZU/5t+m+Xa?=
 =?us-ascii?Q?0t7agX3q4Bxb4r1F0WWIZ02WEVMht1DRBvyRUQk7TrplwOLg6eQxbHll6oc1?=
 =?us-ascii?Q?5iw63IEVr9OVYXbbZ/47Xlgj+raivCJAjrGHZNWqbeOQXaCrkhsRXEp2VIeM?=
 =?us-ascii?Q?y8Q9WTVTJnmfz+3eV3FN+VSruwIbP6GcYMAhDc8FWOJA+IAg9NvpOfJCFSkb?=
 =?us-ascii?Q?LuLyVSANu7NntWHtKbKyXfFfm9JjYO2Q1LQ0kvVyHfrDfyp+S4Szsisxz/r1?=
 =?us-ascii?Q?msoPsyV84LnIrcoktQ0O30hbkfIT4HpYlP3xQuhFb9hXQTQC55I5UCT69Jlm?=
 =?us-ascii?Q?euoOcEoov0LuhpSs6I8f7UmcdsIsgepm39/IMsRm9DHMHmfV/SHgS6RXwI90?=
 =?us-ascii?Q?/v/ncWDHo+4gUs9W4jn1pREqiU7fvQhrk8gz+dFKsagQeq0ReLcmnK1UAMpm?=
 =?us-ascii?Q?fS4/rpwr0TgtJi8NUG8kHlYGu/XBwOZU6Pwg2W6a1ry8lucOrXKn2+CSInJv?=
 =?us-ascii?Q?2h5S1AfAInPXLGSRJJg0wVarguSZABdIIiClz/2AzFwWECrF8zuQZLfQixJB?=
 =?us-ascii?Q?qd1aV4MhS26Jfkb8FzCS9p6JSAWNhyg8I9GvLmgtCmOJd/kGDqZySxoUzz9w?=
 =?us-ascii?Q?FbGk5eqX2cMCUFU95Vmpb0kyB/EdgxqjqYSiXY59fZ3G+y9k7W6nGP/WJg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:47.9991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c3c1e2-bd30-4a13-a35b-08ddf6cf778e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10798

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index fb4fcb641d24..7ceb191893c6 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -467,6 +467,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -489,13 +509,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -503,20 +521,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


