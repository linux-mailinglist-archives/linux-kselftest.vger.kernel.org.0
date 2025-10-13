Return-Path: <linux-kselftest+bounces-43015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACAFBD5789
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815344C2295
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C184F2FE04A;
	Mon, 13 Oct 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QuPstceh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFCB2F998D;
	Mon, 13 Oct 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375043; cv=fail; b=s5UaOS/M+eDR8GiSXj64IyNlJhC5znHdd65ZHz1Q5q1ivycshQh2HtfG4gGWaTZApJo3yFv1xJ0P4rTk8u8y1WzFvzD6fqrkm/yQLQQo3yNA1p47uEZlRDOTjEkrQMRxmkrQ4UxPs+fHGNoDfsDg2pTcmI3cD/xT64H1GtkSXyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375043; c=relaxed/simple;
	bh=qLRf6tsFlfJhvv33FUSUHtZq9F41RybD3Cseg6xfygQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYn1KvrJU4hKTD8LisQ2QopcEvhsKkjMWZOncthFJ6aq2nyGOnlqIkbX4TrFivqIWFON7dD3MomzRkI3CXvKj9eleufHi+Y14gUfADx7nIZUOrrknqxSIfvIdKzpoV+CWdI1h6zdwTBghY/72GQaV09aBxIZzWw0yQbvGAnhUtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QuPstceh; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP2peBmfsOzTMK8AlssDzAbqpa6nfR+cactFuHXWIoL6yNTSg23H3qUPIxFLWzOWpEhhzsXRVVAJUb4hU/KdHyiZOL8xCUJr6gUKTN10HAucwsrtcVRq2av8I0oxtUA52LVGtmhAI+ls4PIZ/VoYIumXg9cXcAdTPc6HGKzy/nv6Y+4KXkGgm2yJg/jcAboZ1V6vvD11fiIoW2udqPf61ei5BVGuOPyTrO13xYYv/QEmpLIP0wXvscI8VQ+s48vmioAfcTy0k9om0vLFb0yhuXckPJQaEZ6rr9u7DejUko+6fkR0mYJThYOT0+oPutxYjXlCedTumwi8o4XxASCXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIXoxxEVJeU0J+r+cLHt5HUmRp6UqevqHePtnM/lsoU=;
 b=pKGXk2zYKWxFGcf5uzxwcQ5o6kCCsd2dkpyF6NlQVd+Q3FnNAD6mLCaFPYcxnP2UV1PucCggjAOMwB5SJFfE6P/ZR6ek+YIqQ1iE4tCCPPeHPT/5gRIFuv6rcxGvvLHUUdH6wudXGqJblIdpnghpZwQIRgDfo1GgvnY2ohSY1NMP2b+pmr+r6+G95z0srsVd3lYiUwe6LkxdTLyhYYV7VOwUKTVIMcn2WBenPsIFefvpL9K1WQfQj5qkctF5peEs+IRGWEYMd8JV+LSzO05WyF2x/NwVyltdkFafmFQWkvtE1vttLvLoLMnkZz+XbPGY4devkdxkLLpPo+NFkJwVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIXoxxEVJeU0J+r+cLHt5HUmRp6UqevqHePtnM/lsoU=;
 b=QuPstcehncXXL7b3gZlj92O+CUp086iEYy6+pLi49SPJkJg3y/rVmW0r6XFFLvjpRKc00B+7+8uANg1VSdyrmc+bt/qDWgYYPAgsVg9kEa1BD3J14kgyS9nmZBWuzgdaQpnlg8a2nSBDEuveyPWtFQnI2DfSPxnGb/WJcFfy09awpKF8E8jkTAZqjpdgooLN3HWP3HdEhJMWcSXqx5Qdl6m0EErmYoyA5k9CRqleAa1+R9d32v0/eVsOYEGfDCmwWqkHPuzBCu/4WrqwvVGU0SmCsgffO/XhiA6rQ0Js7Uz9wlkNrNPtUCxY99Rg2oPihA1hqt0ow0n0xcwqb2ysUw==
Received: from DU2PR04CA0337.eurprd04.prod.outlook.com (2603:10a6:10:2b4::35)
 by VI1PR07MB6607.eurprd07.prod.outlook.com (2603:10a6:800:181::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:56 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::d) by DU2PR04CA0337.outlook.office365.com
 (2603:10a6:10:2b4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:03:56 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 9589F1C003D;
	Mon, 13 Oct 2025 20:03:54 +0300 (EEST)
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
Subject: [PATCH v4 net-next 08/13] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Mon, 13 Oct 2025 19:03:26 +0200
Message-Id: <20251013170331.63539-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|VI1PR07MB6607:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 06a1e044-e3c9-4b56-9cfb-08de0a7a7ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nVX+TpBg/xtsRH2kfF/37FzcwLj/v8OREtL0LuYdfgZUipOTuEnTGlurT5Gl?=
 =?us-ascii?Q?E/nbG+Oy5eBR6lLk3s0DQgPxRcSJBpMN6coY/hbN4E7YHdVcRDhw+4B3o6YD?=
 =?us-ascii?Q?Rl6vygUj38CaAujd4sa3kbdBuVVRfo0UAkojxHnmmIgR/MYXggrt1z5DDA3E?=
 =?us-ascii?Q?g1jXCCMG3sTLi+Es7Mcrh3Tf9/eBUpEzQuH/iUBcQ4K/nkyWeXa3NUI2nx0I?=
 =?us-ascii?Q?TjV9W9qV3QhKMFMTMxyB7e/4lR05WMHE9Plzo39rJ439Wf9WckU69dkhOxsu?=
 =?us-ascii?Q?ZVf/zQlp9g0JKNvnLevAsgxi4/8BR02KIry/yFf5ZHFyzYoxC3igEzFhDBDk?=
 =?us-ascii?Q?scyHp2Vgh2do5sAI67VNbCYBTRuNCso+Dg/tBn0T6VY6hTLSBHg2eJYcQWV6?=
 =?us-ascii?Q?9mFcX4dftPpiFXSNl3mxUbSZZmG1lzJhbVCK9ydtzf/6GPrOH4OpjInEIwlq?=
 =?us-ascii?Q?JhHH50FC7YbvRZVrf10gsXG6RhnTMQh2ufhP/erQp3MX7g1t5UVI2g6QRZxr?=
 =?us-ascii?Q?OgYetqsCxpMwjc9XMTDRZD4OJK/jfBNnW4m1Uj17OUcLc5zQdCA2iKZniBER?=
 =?us-ascii?Q?oWlZjr9Itsow0kEriDRy9VzBASnbcVlsiNvVruTnP2vJP4BN8oZO1J/pMNFe?=
 =?us-ascii?Q?mPLbsH17R0KJfXoUKfxkVBUCwmFpvZxwrEhmqku1jucoz6BtocjnskEHGWqw?=
 =?us-ascii?Q?+vfjHqXULfcpIP3axEa+NiSrzDvnvVaXz01SqoZ1XkkQEhXAgYbS1HiVhTDS?=
 =?us-ascii?Q?PvyCCGISaXi1aA7tiDyftQ52unOB6jOYgwGBCThRnpvblBnjhD2dALqUrqgU?=
 =?us-ascii?Q?JYziSdvNEFv/dcGji0aoyfs7pj5I1WrGKFcocVbiQ5MrwbYtHUmDUWQaDOK0?=
 =?us-ascii?Q?XJMGwz/liQkK0kEYZvb/MvEygkDQ2+dXorzBslpSknHY+yWPk6v18vACnn9Z?=
 =?us-ascii?Q?CmhgD8t4pCe63tfu+uFl56uxKRQyykpLwf50LuEDwCQlW3PTqXQHLob7Yzm9?=
 =?us-ascii?Q?KAqySDalWoGF/g4n9IhCSR8vduEXXkNSec48joY9Q+cBpaEcISm0P3LDi0gZ?=
 =?us-ascii?Q?oxjIsd/42Y+FB8NbhpfG8EktouXcUr8JVVS7njNYyW4aBgve6bQhMlhcyAnX?=
 =?us-ascii?Q?svwyDcWccpzZb2XCQNsBINt6wJVMoXsEpWstCT4/olHQ6mrhQaBIsYoYig8K?=
 =?us-ascii?Q?dlcTwgS9BLeEENwiyIng4/yI0M3iQifQeCdTRm/ojOEB1Gx/iR8tiKcZcaVE?=
 =?us-ascii?Q?JGoQV6/xH5P1LCddf4HYNB7G74FmXcUofSJVH3AZB4kosZAMMK+VoeFGoh75?=
 =?us-ascii?Q?LRYPcPclyaCtsqreQKcMRlzh4VQqeuG8yA9GNDzCBjrNd/czWkGTcOP2e3ZY?=
 =?us-ascii?Q?eXntk3Z1fm7raeTcQ703INxd3heIDYaT95RCh8iiOcSghbGww4+PwGVbcOVX?=
 =?us-ascii?Q?DxfJqTE4aJNXdw1Pf0sX7zozIaqvDG6EIFBguCQCoI1qlO6otbAQZvU2yz5w?=
 =?us-ascii?Q?52NnnakBsyb8fMHiSORBGNsU9E11jCDEtesuZLALPyiOgrCakTVP/VcPNthw?=
 =?us-ascii?Q?mW83xEMkB93ukdXvdpD5If+LDSobimwiBSSJIzlw?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:56.2026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a1e044-e3c9-4b56-9cfb-08de0a7a7ecc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6607

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

If the TCP Server has not received an ACK to acknowledge its SYN/ACK
after the normal TCP timeout or it receives a second SYN with a
request for AccECN support, then either the SYN/ACK might just have
been lost, e.g. due to congestion, or a middlebox might be blocking
AccECN Options. To expedite connection setup in deployment scenarios
where AccECN path traversal might be problematic, the TCP Server SHOULD
retransmit the SYN/ACK, but with no AccECN Option.

If this retransmission times out, to expedite connection setup, the TCP
Server SHOULD retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0)
and no AccECN Option, but it remains in AccECN feedback mode.

This follows Section 3.2.3.2.2 of AccECN spec (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h | 14 ++++++++++----
 net/ipv4/tcp_output.c |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index c66f0d944e1c..97a3a7f36aff 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -651,10 +651,16 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 static inline void
 tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	if (req->num_retrans < 1 || req->num_timeout < 1) {
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
index ef008736e3a9..f2e8a068f1d3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1109,7 +1109,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_retrans < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
-- 
2.34.1


