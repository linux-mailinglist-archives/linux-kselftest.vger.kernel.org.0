Return-Path: <linux-kselftest+bounces-42956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E3BCD1DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C3474E52B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A22F6569;
	Fri, 10 Oct 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dXNtpFbD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4132F3600;
	Fri, 10 Oct 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102272; cv=fail; b=LquGUGUaXOnjnw4AyDwKldNbnK0yrVAXJB2nrk6QN5SUWJwws7rJSdj6MeFdT1H7DhrCm0xuSEEeOqSrxHTCdq4iWqKR2bVoScpKoU/jzZf7H7YiGnRp5sZzjSkoNQILPajcw4hLwiNL2rMKOg024YXfcPcC19O3QgNfeHju/iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102272; c=relaxed/simple;
	bh=qLRf6tsFlfJhvv33FUSUHtZq9F41RybD3Cseg6xfygQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFeG2d9waPEulToFrDQOCmEQ676lf8IZusndBD+cXXR/FtRCMimtt1Bzrs4JTvNuMhS5pHGEUVfyt52C1MOJscWqgZ7t4sedZh6U1Idrto+ygW98UAJa0TJow5Lmn7vBF3UvTkraTi0ekmG0Thlg5/PdB1jXrGwFH/npqj2brK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dXNtpFbD; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox1Tmj7Uy/SVjyAZT9cK6tVMKhQUS33owYKulGXZsBiBhHO4MpmCx8Wzvw4THbMN+y4GLKu/g9pS5/N+HwkkYfFVHnD4Xi6/fE8muni6QTsGdUhoGN29fgRH4michFa1eoyKMPh+KWiJ8Cbls8zZs811GbIk6kjG68Gs+AUrQrh6HM6ul/V/RPIrBSrjCHt/9Tau8y+IfyulzA540yBkwJ5PYvaDn0qAfXalLoebbMLWjiMoEqQV0eVbb7HfgTWMynXb4cyqoRglV+jVNxtQxkhDVoY05En2atW/Lg+SuGAzUPUmR0bsZk6hGwyaoFfCddXxPFd/G4S8NKvwQ/Cvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIXoxxEVJeU0J+r+cLHt5HUmRp6UqevqHePtnM/lsoU=;
 b=BUcAwz62ixPbRv/FWrFDdOjb3l5LRMxCHPK0lJ0/A7FOQUIm1gyJlO4YQIHRMsljeU8QTcMpGC058HaRYtoN9jAtkoNVd25b4wH2a+GOwIZeiH9sIUEZ/aaQ0ztr7CrfmvQEJ1alSOHpYy/alrX2vF1Wb+vAM0a1yVJNttD7/DXgWS5JAN4HCDis/V33v2pDgB/e3rV7A/pUltDlOmAwsHzqWEiFDFK0fHn+gEG6NoU3Td5tFE4Miw60jrOcjISb2tFkRlqNO/qQJbUzLpcpBD0Bc/FsshivlaTX00lHM1+3XenVL2ELWJtLtZkix3tBYXaew/k/zXcX6fQMx9C6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIXoxxEVJeU0J+r+cLHt5HUmRp6UqevqHePtnM/lsoU=;
 b=dXNtpFbDsBeyHlnxZ4uyQrt4zGvvzyAvZla2b5mhja2AHi62pHU6bE2aSWegQrytefFxsW6rilNm5nV+RsV4WmHyffQAkK/DaEWpz87GwkIcyxCrV4ONNftbSmQi9+CKPtL2+JNYJK3T/rej6u+cowBe1zXCHpSg6ib+ZDCB8O6fl1g0Fvd9mPhZcZzfiSryUwN0UUbr/I0j+cfKMch4S54Ffwy8zlG6+kzadMn2cum+LYLBI+FI2FtPcyIxcgDBmL7/N2g1VUH+DBCCyxTQfqbJ6TgexF5Q2pbCwPopxHQlADrpFXgU1kyDm+GlC6OUtx5bg4X1nnuF58Llschrvg==
Received: from AS9PR06CA0407.eurprd06.prod.outlook.com (2603:10a6:20b:461::14)
 by VI1PR07MB10089.eurprd07.prod.outlook.com (2603:10a6:800:1de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:46 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:20b:461:cafe::ac) by AS9PR06CA0407.outlook.office365.com
 (2603:10a6:20b:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 13:17:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 287901C0040;
	Fri, 10 Oct 2025 16:17:43 +0300 (EEST)
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
Date: Fri, 10 Oct 2025 15:17:22 +0200
Message-Id: <20251010131727.55196-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A0:EE_|VI1PR07MB10089:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa43e299-9ffb-4087-fd06-08de07ff6646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XiGMLmuGqjcQBza1+jBm+oU9Yg+zuGeUnH1WC8fJHmIEqiX/V0r0dgdIjR94?=
 =?us-ascii?Q?YMjqdbPAFHnK5xXuQrkflXAkMoI4skIvHgQ5By0P4W//uGC998HFa9PJVwtT?=
 =?us-ascii?Q?TZ5AktELuPdzw5ngBFeOefdTgxv80UyjVY3qNpH9WC132t5Co2BAz2kDm+l7?=
 =?us-ascii?Q?3w2lHCAh+BzxsJn3d8aHLv4kWwniDh1bbpmYZDgol7NJ/8mxK9NM8QVrCFSA?=
 =?us-ascii?Q?EpKSQtKyizVZK5HAs5OB7QEZCh78J23rxc/OssskmuaE1CZchLypfKl8UoTi?=
 =?us-ascii?Q?rjRMKhXChn/DPUAd2+OjRPTRhISj1GyWjcDCVb7NRNydb9YvrB0DsLNnHNtW?=
 =?us-ascii?Q?VW9YCeq2h75YlZ0+On0XkKgiRnoPkyU9k4BGKuMjdnZlC6DBqmSdxM42X2kv?=
 =?us-ascii?Q?EpTa/HfSaLY0dQVl3fWYH8SZhSwwROvVYhkaAfhscenjNnZZ41hS9zcpHhB1?=
 =?us-ascii?Q?I7wpSgSQpiJNwPywlH9JnY3NDDI+2jmF4pz3tUBml01smBF27usIzCVHIb6t?=
 =?us-ascii?Q?4CJEaZ0ehOOKrcllyF2i+xkHwE8WYZj7ipCbWCPF79ooDyVJJFKenoOg7Kce?=
 =?us-ascii?Q?qEO+g6j3orylZgHwfcmXx4qYPttbsSee96iVPuscKhYBQTjLE5lpvftnWarp?=
 =?us-ascii?Q?pGrsW3uhzHq0k9UsbiD35uxBsgJ4bcV4D4NFh+4RZLKKSdN2paZChvh0lYuL?=
 =?us-ascii?Q?h0TzOlsBqxxVEUEZa1tfhtNOErjxnB9bXea9eZyjP/aHw7mfhQyGtQHXkDnn?=
 =?us-ascii?Q?lcXO2I914UlFvvrGrursuhlMEeqjZZTpnRBNSFEoVeyjYnEnknj3QMHtdXF/?=
 =?us-ascii?Q?DR8N0rET3MIor5fUUUp06lFd1aOZg/H1pgw8SUDaV7/0ZI5qI8V4aCwYvKkY?=
 =?us-ascii?Q?aKl7cImgRsd5tQJ3QJuKVOkCnf4OVWq9INgXd2CjuIqYtklODftefNBu4uPC?=
 =?us-ascii?Q?kN1wdXn3LQ4P1Z81LuOgT+nnKk6rYnaTntyGm3HIXnfEit0JYlJouaJUleXW?=
 =?us-ascii?Q?9gVd7fw5VAymbTMTJ6goE4VNWmAWhUnS7euadqrkAEh5zIeeCQsxXaBmAOiH?=
 =?us-ascii?Q?5Vqqi48mun3HnZy2ROuCWzWFSgrI3jdm1/etW+8kgu0eEN41bqRloqgXCHeH?=
 =?us-ascii?Q?JLtrJfIcMrkW8MRoWV2X2GUT32u4hcXErWc1AUuunc0jcjxDChg21FEj4rnP?=
 =?us-ascii?Q?ZExkFKvPyCe1hqiWQhznzOgY5yQd/v/b/Qj6JXInlGD09LfBDEER3f4vH6jv?=
 =?us-ascii?Q?oZ6fCOAOLvVNAjOyl01aqeyBFzzvZpHiJc/seOPK1fCcq+E5PUCCmcWzjYqd?=
 =?us-ascii?Q?u16MvYNJbG26nNjYDRMHlUa9sKVjFuKvuE4LV87wOxgOxonJ4lDuVOpOly0S?=
 =?us-ascii?Q?8uQB6MegamQHFwQoICiU/5DbKkbT0AcnYejO/rIkeTbk+vYYvJi6VzSlKmOw?=
 =?us-ascii?Q?W/qlDMrOpBfks+jTOwzmGgSQBoNwyxHp3bm/l/d2gELovx03881i7r+NxxGz?=
 =?us-ascii?Q?42cf0aJm4p46fPnBqDCkdbqTTvdAvC95vCyUffJnunQwgaQq73t4uZmBCC7M?=
 =?us-ascii?Q?n71y+N9GMyrZOC1egONqMNphz0oARCuANLm/zOyK?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:44.6451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa43e299-9ffb-4087-fd06-08de07ff6646
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10089

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


