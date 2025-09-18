Return-Path: <linux-kselftest+bounces-41878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAFEB85FF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C052A70DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1631A7FF;
	Thu, 18 Sep 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jWTcHICV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683231A7F2;
	Thu, 18 Sep 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212521; cv=fail; b=PAEvq/hxUJ8jwZu99RMyRK5R8NCKJa0ik9mRhmU0Hre42ehit0F9wCYOvrnLArTOODJ3jGWo4nCqiVJZuC4H9lLiRmsUcvoBxOY4keGWEO5lxYRFUer9uUEi4UEVwTgiHsvtFTHKYzFVQNGwboO2HHNm52jMG5OFnOOugE70uZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212521; c=relaxed/simple;
	bh=icQFA07G6cwWk12z2s4kh9tx9Aui9JJl2S/+J1jqZyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emF8qMTOt/L4Kh6i62virllfWOD5H1A8mHtcbWC4ywdgr7GfUluAVRYP02vXKupP1GJySvUyPYA6kiDWjRgApOSXSZQaGdkZkAx2JwP6Amy6zCbXVtJYObnIY3CKbeEvoT7IJi+IuGpT2wCSDD9pUI/SfKm5cXOii1CWRPMAuBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jWTcHICV; arc=fail smtp.client-ip=52.101.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy4Le0GzVOnJxOzYGol3bhKOYij/DCQwbMVrou5raiOLM1tTjI5o7c84W65depRsWQWz9JOZ/7gv3pgWKgTDNcjv7eWtRcUpft98yukI+P7q1R4BSnjA6k6enKUyioN3SjI8aCVKG5NltdiLduCjuxcnLsdzgS4II8YCdp9z05KS495y0kUNLsZfMdvULg3rerVZw5yMOHC8g3rUXdTzNv8Q5mWR0G0Gh6kUOnvEcFYeaCzQm2xkbMOaDHfYLYs1DENjCqUmFEvPQ0oCIarQzaulqvrL1/ew1EZpt6sfT3oyACcWdf50BRC5qGVDgVdL2wiiQbci75MjyQQpYHqCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFoMgv9J6O1RVk/KD3A26EGwRZgSWjRDR9kIjobd7UA=;
 b=Yso/Y6huNIqz0ediDHCF64j3nO0H9YbnynR4hc5wmYDvOGdT7PbE3U9cALuofpcRTg0sLVjCBk2DcNYyryvnVENPLXqb74yMJOrmBq8Vl59kSAWrbQN6CH4kzMah6oN1MwxSSFLKQmn9Qqi+KN2SFUYWXXjlDQtF0M4oi2T0T4LS6ng/5TNCfOp/w01OW2hr56jP3gGz6HO4HGc/aPRwa+1h2mr55YYaEPVxvPdNfr/Zt781MKTNDcy0Zvs6ej+0La6zdnQAzr6BD++KSTgFNY8oK6b0YQ6fyfYKHflepSdp9JDTT2Zjt74RJ2kxTX6o+ZlLNDL47tSg1zrnJdmvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFoMgv9J6O1RVk/KD3A26EGwRZgSWjRDR9kIjobd7UA=;
 b=jWTcHICVNl2zsN7W+vGHDSvma+6Smp9mM87Nc83j4R83aRDMvPc5XwCY3fB9pKNaWURbEa7mnGG06KAH44Kx5IrCp4rzYnRdY6Qw//wJfn1hQdjTFOVCBbUD6PWynts+UUMLtgjcz5dqhPyRqiT13QfQeDBkSEjtGY05Wcws8hq6vE15omRh1Ua2GV2jinU5FOjE4VOH2Xg6jNHi4Pe7yIHgKctPwymK5DUlgfVUXUoz4js5srvgUvrC1eS45Y8o9C5J447mrzVi0MX57YH/DLbT0mOD2TeJO2PGbC1x66NKJX00/7D1jMeW+hNTC6mx6TuqE6snbEhF7Cbb4XWJuQ==
Received: from DB8PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:10:100::14)
 by GVXPR07MB9848.eurprd07.prod.outlook.com (2603:10a6:150:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:21:54 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::8e) by DB8PR06CA0001.outlook.office365.com
 (2603:10a6:10:100::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 45468200E5;
	Thu, 18 Sep 2025 19:21:52 +0300 (EEST)
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
Subject: [PATCH v2 net-next 09/14] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Thu, 18 Sep 2025 18:21:28 +0200
Message-Id: <20250918162133.111922-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|GVXPR07MB9848:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5db5d1d3-9ddd-4da0-6a44-08ddf6cf7af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/Y3PkG1HSANZ3AYQM/40HdaanMv3l1IszScAlhYhVMDS3Y7CQYk07INNeGV?=
 =?us-ascii?Q?cBtYsoDGjur2cW1ZC3STlg3mqc3Y230tj71TGoVEr0HtybkOVhhbhPw77v3J?=
 =?us-ascii?Q?ywGXNoX82eboyiFDgpzae6wJ68ti0y/AjoL5g1C/1WM/Gf7t2mnApkLMIGE/?=
 =?us-ascii?Q?cTpQZFHWxNITDxTqulDa+6eOx+VQ5irNYZkzhRrgqdID2CXrTC77E51T/UDY?=
 =?us-ascii?Q?SMOgQY/RztwEKygHUjxoFSDHjoKGEPYeQVpVuS8FC+qeDVtXA4UfQLjbkHhq?=
 =?us-ascii?Q?vKCZywASJyMM3yUeje/o6MRH9YQlkWGXZczU8rMej2L6hajAjN8SW2LK0W2/?=
 =?us-ascii?Q?+zrOzdHABnCApqAKtKj7brOWxi74SHIHoJs0L0EtNJM4d5qkpjPWrEB5N07l?=
 =?us-ascii?Q?CtfIiGzChwEBP39J4nbXMyJZbOzvo50gNKpVmWGjRYnerB3XbLmkMdSfCvjr?=
 =?us-ascii?Q?P7PLiUbhzfF5+RUI6VkxKKNsQ7FiAFcHRNKFNebUUmuspPnuzUeqsADeZ58I?=
 =?us-ascii?Q?8FYGh8DfI1uLdRObvkmH4v3S0VSPgjPUsIM9couCbUqcJAvxh0ywsqXlokUL?=
 =?us-ascii?Q?NK45g8DziSvKqjECUepYUrSdlZjgO/nXSz8QVofsetWc6CesEBUK0NUZUFTk?=
 =?us-ascii?Q?j7z/mZPs9E5r0fdj40gPSYpLzNmFKIySCvdRFt/OeIndOH5K461/RpCwed6a?=
 =?us-ascii?Q?s/n4sFE0UAdRhDEXJ12Bn5VAsOBRo4SGSQR8j+fS1aTuo8RQxNRNB9EnRfim?=
 =?us-ascii?Q?H2hAnirgOUZGyzvokKCWzuKvnQunj1KIeObtscy34t7MDDv8CcKe18tlUoHI?=
 =?us-ascii?Q?9QDHvQHiN5pd7ZXex6+O63a1uby2ooodnijR+7uSuZsOVfb6fMC/97xWGy9Q?=
 =?us-ascii?Q?BGKGXsXRWBVjs/YG0PKZv9hRYIMb/xeQpuQKi+l7gFwsUZy8jHnHY54w7sh7?=
 =?us-ascii?Q?F3yPWnKL2k8cD1GP/blq8AQ9xHEYhI2fYKRFyx9Q4aWtK2aM+ThQXqtD6NYr?=
 =?us-ascii?Q?H/JUbmUScXcBJoYz3FX1qXecvwNj3ZbcIg7OgZgw6JUu+XlR9LvKwBqWyi4P?=
 =?us-ascii?Q?rUC/mc+/A+px11M/kaz2fPQwTzt86OMls7u0lw/hnk0/RJANnuVVihi+IvVq?=
 =?us-ascii?Q?kYxgL82wmYpDH/2YCjvSDfL8xyFTdgjHIOmh9KS7uh9oVWo3sl1lhaaz+auW?=
 =?us-ascii?Q?zMUbbLtx6QmwdVNjhyImg/wr7u1wjP5CwltCIl8MTeOhHw2gyAApPSO2ee4K?=
 =?us-ascii?Q?ka3zaQY8cXTKHOvxEbJGVxfQ2STRxqi+cre7XtYGq8iqRStLvoATvbN5D/Hi?=
 =?us-ascii?Q?942baEEtEhSec8M7qQBDfFOojf1lYuy0J4TbOqE0Ey1v4GHF+KkGLKvbNzxZ?=
 =?us-ascii?Q?S9uGcJ3cUqFD0pJyxEA340A+vEgIqBQYl0CbQ9OAB0YnrXvzsgdSNouJLs7c?=
 =?us-ascii?Q?ygWvIhbKNJjQl0bTlg7PY/R4lISH4/1LargADhAo6LE0rLv0shpBwMGJG/4+?=
 =?us-ascii?Q?e39cHL/nCfDcH1H29RBgOSFzkcmM7OsR6MfUSvFZs89k+05zFXOgQ29LPQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:53.7381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db5d1d3-9ddd-4da0-6a44-08ddf6cf7af7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9848

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
index 7ceb191893c6..f01cac9d39c9 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -644,10 +644,16 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
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
index bf90c2b33af3..d4aae5dc2201 100644
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


