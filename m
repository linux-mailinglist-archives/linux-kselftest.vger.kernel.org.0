Return-Path: <linux-kselftest+bounces-43018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EFEBD5581
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0428D18A4E11
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92AB305940;
	Mon, 13 Oct 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RwNAjfJT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE702C032C;
	Mon, 13 Oct 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375048; cv=fail; b=mEqkFizYC7uiHbmk6geEhSsG/z9j+BJqTBqEXCPba2HieRqpbFlM5CGfy8m+JT426joUQDSLeCS7gt4rtD1Rx2CW9tBXc7w94sBh9kkDMyLhlCgq0OxKOYOovcn3a+xDGjfPb6a0tRXSkYNNk3x4H5pLgi4o4zJfWTYqfES2Sig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375048; c=relaxed/simple;
	bh=gv58YVqQc32naQbvNjnqYeWjhR59UPjBNgb64FzqQWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9CgOjTIQIN8LnDuXFX6qNsVup9jWCa58a9cig+dF+2dQ3DAE3+pK8vJhmj/iGZwbT4nZwB2H4G/ObxhJ73w9AcB2KPoWORVpbsRawFmy3ml8A8mOobV1u8IP8Fa9NrXlpFrU0CEkEpWOsEiep3GWMvl45pAwFicVoiunrHBWHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RwNAjfJT; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2aR68MT7hmeyLT3utfVFE0p8JzW1wYI1jloyWq5CW4NSwPZ3hY96u9paAwnkwp/AcGZ46YzMc0qI7O9G/Pu5YF2fheyEqIDAaWilRGjTCY3wHwa/zTWzzmZ8MHHJ17t2NWM1OVb99dLLenISHvU1310NtndYLE9dh7qTOXLLG/1cNLoR2JCcmxVEJ/MP/YVQpYo14poEmgkZ5P8RL88WjW4YLyFBbj4UB/C5+T3V8mj41/5V6DRG5xnl8353evoIKavJIZtwT1hRiTZXKX81LsDPpLybylopUKzaFTlC6DSg2uy3J3vdinc19NGZdDUNFjhmepjK091Fg6sVxh/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNmHisECK5vwJIM7/YA+SB/QKgjTIjsLyD6i1qHaYXI=;
 b=UCM7c/rcKE4/53/OEaJmMlkEXd0XKIJ3qOKaclxnwpumMQM1L0p32sCsP47U8+66xNHN9b8l9cBv8lKEbxXPURvQmWXDtChTkixHRBClQ6+FAvv2g88Ao0I6+vIoCt1QGybF7q2SCbwEYq9WmHVJr/3gHRZsytwGgZA6Aax1eYRKvUK3FQY/hgqIk0WB096XihFeHrwsJ4W3UbDfYKbaoHwC/2xthF2NEmerQ4tYBiYz6gbFEPb7KWTQApfv+eFrQHVBHZYAnuBkhWuVH8KhzHTFEBb+wXfwlp0I8Z5XgUlu+beqjgHv1e/pSOXH/AyDQfztbYQ66s19g8gH8CgP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNmHisECK5vwJIM7/YA+SB/QKgjTIjsLyD6i1qHaYXI=;
 b=RwNAjfJT03gtT7oAKPQ7RQfQHJlCTJATxtU0qceBw6pRpvcGwdXSAcyjDQNczdqW7Ea3mifiho7zQ5MFhgtM81S80jT2FzUJhmamRy/xCIVkk2a4bbbKp+AXvfmMyfQD/f6RenHgwTzeDAkG2O+vEUSi8IQUC8UGf9yQ9gC8eZX08R6NOB5GwpSZHmb5YMNNt8jRP6sbQCnLte4IuoS4vO0kvqjojo0iuS8onVXNTr6hOkIud/jaUWHMcBmmiJq1z4N3EYbNd0YIQllqOs/J73AiSq44Yi5BuYfjJejktWGRkFDdJGqY4a+bq3HTwhBluRRM0uQ7Zt+gd1xrQmmLeg==
Received: from AM6PR04CA0056.eurprd04.prod.outlook.com (2603:10a6:20b:f0::33)
 by AMDPR07MB10283.eurprd07.prod.outlook.com (2603:10a6:20b:6cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:04:02 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:f0:cafe::ae) by AM6PR04CA0056.outlook.office365.com
 (2603:10a6:20b:f0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:04:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id D2B2B1C003B;
	Mon, 13 Oct 2025 20:03:59 +0300 (EEST)
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
Subject: [PATCH v4 net-next 11/13] tcp: accecn: verify ACE counter in 1st ACK after AccECN negotiation
Date: Mon, 13 Oct 2025 19:03:29 +0200
Message-Id: <20251013170331.63539-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|AMDPR07MB10283:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b0ad6be-0e46-4448-4a0f-08de0a7a81e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x8zXpZ4DiD/gX7JCpQmTQlK4w5qflLakcHROENKxQU4k5uLgj1jAK8Uj79Gg?=
 =?us-ascii?Q?5blH0pi7zLRa6tJYNdpyZfnDpFyLiQSxchQPvyV2XNOaJ487TSeW3Sy6hFEq?=
 =?us-ascii?Q?58zdrc+3V2yRRRDH78iiM7xdrCVBQpKVWyeQnZzvlqWhtiKspMZM25TuzyaE?=
 =?us-ascii?Q?JCy/t4WB3kJZOZY3bkks8cipXU7rqoFPpejLWX0wGM5+jEkaYuwdH71us+ZI?=
 =?us-ascii?Q?PTA0FfQyf/wjRBhQci7VxXJ5YI38GVdlOgFGUusjtFafwc9PF8XgIRpwsVfa?=
 =?us-ascii?Q?ZbxqtNZwnAZyC/0kpyTS9Zdxa946NgLMia4LdxBq9CWJ0qztok6co8w57U6Q?=
 =?us-ascii?Q?HuLUzmqyRHV6TtPkv3s6rE+c2YnsbXirkMWqYsQUbZWROdXGaF7sYtC4vdz3?=
 =?us-ascii?Q?y3qR11kjqzrLP4aIcV+Zm2TYq09ki8pxXjYBmgmIaPYblC32ysGWy0sB+PLH?=
 =?us-ascii?Q?aJPiKXblC6qt921FjwgNdeBVx8pjEbXC2SVpGGMgK9pFSb5lqbsxAtv5enrS?=
 =?us-ascii?Q?qkTgfKhlx3EB54CJFCwLfGmj4nmZkYabG/jvyYrZbbQjcohcEsjKaLbSYqzt?=
 =?us-ascii?Q?irvzFT2fpZV6HrAKOVtorrOoAJtiC1YwcFrykFBdUMWHVpkervSc0rqynzw5?=
 =?us-ascii?Q?A05RuOKEAtk5J3bwMhQYdiSI2UhBi5nKwCfbN63M/NU/WTSJNgZaglMdA3T1?=
 =?us-ascii?Q?t2JfJtOfGFcKvwuoLfBKuATVyanz4yIyFw1lk2VTc8urCRggXMe9R8rsj7UD?=
 =?us-ascii?Q?0Z09sXWTe5gSS6WTUbmOtDwtP1kBlikDSDDcrbbsamKyd6XuTWo6LDxbcEMH?=
 =?us-ascii?Q?5mPqTy5mmh1H1LUccgDmltvi7+CvdR4S5ADMfx1P7l2pn59U10vVhD7kc5bJ?=
 =?us-ascii?Q?/e+le0i3un/K2z1S7CRhHZWB1ilZ6ZYDO0r1m5X7z7IYCu4gZnrB68jpl6/4?=
 =?us-ascii?Q?CRLRaFL2FVxkbl2bwNnBmGQKbD0ryrtW8ECpaEHZmnui7yVcM0qgp8msp2Ds?=
 =?us-ascii?Q?3WuKlclfGOBXCeCISuT8QYzKXEMyvkPCYYRx+t61DeTdnpbqYAUxGLPhr8Fi?=
 =?us-ascii?Q?kh1oU+ggdoMyk/p4u1oaE/MBG0wMGurU+Op7X2448dYZiNx6g4KJM8/tWOPO?=
 =?us-ascii?Q?bhSqCLEAn/jEs1LKv9mZ0dTrT5xI0vl1F7UujGOP13BVjjK0dxjghFHjiqFk?=
 =?us-ascii?Q?3c9Vis+XQIA5SkNKY7SSDV59ZJC5K3YwCX0s18nnuZLb3et+UvJHtbene2jN?=
 =?us-ascii?Q?YKFAlp+VoZJqiZEaRc+LSI/k0qYN/uB2s72TnJbDYjQNbaH5yv+V5Zf6Xnde?=
 =?us-ascii?Q?675Da4yPKr++8ha8xYSDoz6kDeWbk4gPtnFwzeYg+kBiiSN7SpinzczEk6A/?=
 =?us-ascii?Q?m9gA2kUbX2d9FgnjWA/UWnBIqATIb9q+zU1fNxNeAAejECkXHhT+EdzyK3eh?=
 =?us-ascii?Q?hw/NH80NFy2FjZMEbOPj/eZRmeyD58MQlzascX2MEEzecZZHoNgIdi42l+40?=
 =?us-ascii?Q?EjAo4LGIKwxPiR7t9NTr6TgDNf+gCPlfw7CYtBUqnY4byaruLTBjlyOwvtd5?=
 =?us-ascii?Q?/FhmmUkdW1jG07m+3PCk87aEAzHeQsEr8jumgNNI?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:04:01.3816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0ad6be-0e46-4448-4a0f-08de0a7a81e1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB10283

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

After successfully negotiating AccECN mode in the handshake, check
the ACE field of the first data ACK. If zero (0b000), non-ECT packets
are sent and any response to CE marking feedback is disabled. This
follows Section 3.2.2.4 of AccECN spec (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f1e73e264b19..61aada9f3a6f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -495,7 +495,7 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
-				int flag)
+				u64 prior_bytes_acked, int flag)
 {
 	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -534,6 +534,16 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (flag & FLAG_SYN_ACKED)
 		return 0;
 
+	/* Verify ACE!=0 in the 1st data ACK after AccECN negotiation */
+	if ((flag & FLAG_DATA_ACKED) && prior_bytes_acked <= tp->mss_cache) {
+		if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
+			INET_ECN_dontxmit(sk);
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
+			return 0;
+		}
+	}
+
 	if (tp->received_ce_pending >= TCP_ACCECN_ACE_MAX_DELTA)
 		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
 
@@ -580,13 +590,13 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 
 static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 			      u32 delivered_pkts, u32 delivered_bytes,
-			      int *flag)
+			      u64 prior_bytes_acked, int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
 
 	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
-				     delivered_bytes, *flag);
+				     delivered_bytes, prior_bytes_acked, *flag);
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
@@ -3997,6 +4007,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_sacktag_state sack_state;
 	struct rate_sample rs = { .prior_delivered = 0 };
+	u64 prior_bytes_acked = tp->bytes_acked;
 	u32 prior_snd_una = tp->snd_una;
 	bool is_sack_reneg = tp->is_sack_reneg;
 	u32 ack_seq = TCP_SKB_CB(skb)->seq;
@@ -4120,7 +4131,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
 					       sack_state.delivered_bytes,
-					       &flag);
+					       prior_bytes_acked, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4160,7 +4171,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
 					       sack_state.delivered_bytes,
-					       &flag);
+					       prior_bytes_acked, &flag);
+
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
-- 
2.34.1


