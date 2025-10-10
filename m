Return-Path: <linux-kselftest+bounces-42958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11342BCD1F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BF524EC96F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D72F7AA3;
	Fri, 10 Oct 2025 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QUJ9n9nK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450CC2F6196;
	Fri, 10 Oct 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102276; cv=fail; b=FfVLuqSjkH2Z88h6BAYGayMvvBu0TG+gJ/y80kqzbjbhZVy8zM25Nw2iF3hqseR/nkoYnCKbLVtjURslELhxqTE68nwFn2Vlsi68qDUTXBm5K9UFCq/JX+HrLmVqiY7JB/7XhpuzNt420YTtbNShHDWjJHMbvtZ4bdiCzFrsXsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102276; c=relaxed/simple;
	bh=gv58YVqQc32naQbvNjnqYeWjhR59UPjBNgb64FzqQWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRp3vz2LLsl6okLtBQqquIlcbVyDCVxL1j4yJGz4UQm4xZ+cRLKvlREkagQm7ZxNjUPBrMf18OZUHNcCNbgvb9u/TjhbwSKsPiXfyKmTceNbn1ZXpaxsHf3txpBNS87KvUI0bcbiH2olavYvHXWPvbkO7VqkdZHFjTc5+gyAzFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QUJ9n9nK; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMAELUbDQDRmoTWtMP5YsWkdSOKossUzEDntu/T+cDqlcNdqGt5SXp33ab/itWLuxMeqx3YaTV6KMrQqKE1/3Evaa3c+/0/oGgxHhz04Bx1DFL4MOKS5mtLR7iMkkFAz82sWeXKGOavDfUqQ1/NZ7b3fyKJfAJh5cw1soYHQaLTPWbY7EfpC1GZE8XDflgr1tU+PixkuZwZJC2lQq3B17s7wGgPA8SlK5e0oGEFBNbkUdrp7uHY9xcTY5P8BhWADvBfOyhA1RYIaUR1s0JEE6LQamc2EEQpu24PbukbxBeQzsGqHNMTY0Sj1iWdGnF/YnARXo42lI9tOq2TB5FBr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNmHisECK5vwJIM7/YA+SB/QKgjTIjsLyD6i1qHaYXI=;
 b=dXpc6MMJh3IeRSFA0uLTWdxSGYPc5aXegAB04i7szJ/KYkkZZFJtnNbYhMOrQpV/OkGJ7/Q96t5ZlYOP3jSYnbY/24Sox0musYvUXr4PTMonCoPlFXHZ80vvzxljXowTyZ73y6pSvvtmPMTBvE8kJhk4NOn+lYGeqw0sHvyT457CeEOm4zyJ4hJ0/elBtHfOGBTCeKXUMOMArkApkXzkZYtixRLaAl+FZe69NvpwA3kJaS1v8D0l4wXfGFOHwspwDCgSpeZI2fmDj9cF/a8OiLE10/ulrHIlACI797o6HZJgOfKTOw/6G1n0SpJK5OP6Ui1Oiik7FSKDtvOw+16d2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNmHisECK5vwJIM7/YA+SB/QKgjTIjsLyD6i1qHaYXI=;
 b=QUJ9n9nKRZRhOhQLGiv215l+DJCo5zWbEZMwZOuGtVQFzf1XwyqJlp0PVSdKQQmuBV1ZGVL1iYFCARxoUGKSoss4PEvYYSApjy+sBhL4f9P6KB7Gg3lV6XKntID9p5CPR2R9tm54DpDrFqdZwXSa9VfIt0dC1elRSnKjonS491YoBG//nSd2semUmDnaWx5yc0eSCdZK2T4V8LzqgtHbmjj61suwoVBJKoU3PO95lAPrXIsULgLQz8zI1+Jy/XoZJmfR6FAimuBjdirFGaac/4LChGq81Gq8xz11c/SX508NVJe+E+5dSziscKkHJSBr2karN4EVgjOER5bSV7UHBw==
Received: from AS4P192CA0045.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::25)
 by AM7PR07MB6263.eurprd07.prod.outlook.com (2603:10a6:20b:138::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:50 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:658:cafe::1c) by AS4P192CA0045.outlook.office365.com
 (2603:10a6:20b:658::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Fri, 10 Oct 2025 13:17:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5B76C1C0051;
	Fri, 10 Oct 2025 16:17:49 +0300 (EEST)
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
Date: Fri, 10 Oct 2025 15:17:25 +0200
Message-Id: <20251010131727.55196-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|AM7PR07MB6263:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 832fc0b3-969a-4e2a-7d5d-08de07ff69fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4Pcrtund3IoIePWaQjALzAJKdVHf/fzUE1ghYs4TZ5dZJXt4DYU1Dm6MAdE?=
 =?us-ascii?Q?2KWETInlP9R9DsWABpA5E0bl46L1qoNmNKlrCBm5WU1kgScPJ79J2j1LVLEW?=
 =?us-ascii?Q?N7/ufVZyDIeFZqo3dMT28qMR4ibXDYtWNhwteGf7Qvo9FRf7ey/CHEDPE6v+?=
 =?us-ascii?Q?Y4NGct1ESYtmuwwxnyVxXlTg02iv/QJdNQHJ3RiGi4Y5No6rN/3XwXkCgIkw?=
 =?us-ascii?Q?TuIjsir0vpw96EajqClvqWlu6GxU5ylGynicE7JUVlWqOi2IiRUz32dc6wZ+?=
 =?us-ascii?Q?oXbeaUaPEhLb7qvF6z5Cgj1hc7lTsY47M6Dav0/9ZUsZogzgTZ2NM1e+A423?=
 =?us-ascii?Q?n3bE6UWSlSTAJyLpviokTMtf6Pbbl6mGSjuE+eZRN9wJcONNMKODx1R01hRg?=
 =?us-ascii?Q?VyIBrM7TFtFzmW3lWurjOk8i8VPoXpUq5IGNpuV52TJpnTRfFogSw16f9qpm?=
 =?us-ascii?Q?HEAtjHe6OEp/P6FZR0Qq6PZhStLG0zqrcJ7szUKJZxhHPqQhbe0cTbGO4bze?=
 =?us-ascii?Q?sSUulWoJc0VN2OOhH8RBqsz7oJVPinX5P3bCcP2VuEY6tiXMsveFkqniEd12?=
 =?us-ascii?Q?JymdLW33lON56iTpoSZbR67Ie7fhIoCzk3+c5vXE9PORqtW6Tqw1+oJ0Q22b?=
 =?us-ascii?Q?a26PfXZ0oueksyiByXRxgtuhYJEQIB0xlTyVaE43EjOmdhTU1zTD8jlI3HFj?=
 =?us-ascii?Q?3Afo5HhUjiSXsu1bER5ULnf0awxMGqEvN7I5eiEmD7WBaLaS1p8o25cflmTx?=
 =?us-ascii?Q?WYhuhTcsUhA0wuWjOT+np7IdCVLiJ3Moogvx/G+R6DZd3YUKWJjOTN8LW8+N?=
 =?us-ascii?Q?O2THTBmLBJH3OSv/3Y1ejP09LFYvTPCoXJvOCJufbKnn3zDOyPYlZ0uxqqsD?=
 =?us-ascii?Q?cwPxI+UeAqj8mRRofvFaArJISlgjeGj6QEh6Es4E1P8sh3xeNf7ac9UY2yXV?=
 =?us-ascii?Q?NJy3coSyhhnipBOidCPeAXH0QDSZyPZlMs5OAoA7/cgvQKTN8NULLiD4PF/w?=
 =?us-ascii?Q?nlZFjMwlxoLHZ3NABgRlVpzgFRCzaiBjluAi+PVoW59kDkmdYVjg4Jz4pPV5?=
 =?us-ascii?Q?T1NYKBQjLMoOLgV2w6Bt7PV+hZUefKzgFmuwSBalMVI409l9LAKR9JFl9uf+?=
 =?us-ascii?Q?slmSPISi7FKDXFOT1oO0Nq3t+AVXMs+2P/us/p6oRpV91sp+pQ4ECycSbHOj?=
 =?us-ascii?Q?J/VP22cQn+9AiHUe8jNy0XBOkUxB9NIEPPvL2VKra+S73GwpdZtpyZf3Qgkp?=
 =?us-ascii?Q?56DjVHijUaXEzVVnLh4Y3BprSXRRNy8kyuovRQvs761OqU/AKFUnq8zjgYlf?=
 =?us-ascii?Q?MgUu1SNaGIxdK6i5G1KeJHbFPb3Axbqy2MiXL/ObxyaNr1HsnfSY6Kv+Vyb7?=
 =?us-ascii?Q?Izr/LMVhIAwCiV0zJIV2gnnd0bBEkmTHMqh/fdyHokHef5U7ERcZsnzdOfU8?=
 =?us-ascii?Q?+iH+knL5UyHpLDpwqZCJuNWXx8LG4KNFzuggzPAQkhaijTKuw7dNyjwa494E?=
 =?us-ascii?Q?c2KTIjA1zK25I4N89GES/PLydsTbZvRoV6HJCaQsDyhwx3ACKJxBsxi0AF2V?=
 =?us-ascii?Q?kdjZ9EmlEhNunaZU6SihLmd6DIIK7C0DmNIdT7r/?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:50.8604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832fc0b3-969a-4e2a-7d5d-08de07ff69fa
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6263

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


