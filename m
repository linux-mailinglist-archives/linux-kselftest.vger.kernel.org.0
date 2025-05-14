Return-Path: <linux-kselftest+bounces-32942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63746AB6D9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3EB1BA0643
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711827FD6D;
	Wed, 14 May 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="E7cmmelO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B227EC74;
	Wed, 14 May 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231029; cv=fail; b=L11ZzOUhtUvosRjPIocEgNlXpwUHQpRH+HREZWxRFUo9SpcX8hQbRO7Pdu4b7joGecCRccDM3OmcMrCI2mjZ6Aj7Pw81KEaUDEuec+9nW6MItmRCFxEtu9w0pYqSMnKeSPtbTlYjNteDROTxtiuWPPl7XZ0NLTq1F2e3AfhjiMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231029; c=relaxed/simple;
	bh=eAUvwCbiLkmlOzdxJ2g0h1heXbWiv+BDq217NtOcjN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czrNSfKyazcLkN6OE5kcmPOo+YRo4AWXeKRpHzxS9FILtfLXbyNEByvK+eOEsgQb4oXk9gD/gam2KZZtvar4LOQB9QwAM+TNnqjr4rJsHl8JCGdKf5wilRxzV/bRDcL3/9IwHKILNKVgEUCc3kx/JB4cdYSBC8Yorf9YQWn8aFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=E7cmmelO; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBHSBnP0njsSTduHU5iyAE62aPW17AS3Nh7ZvhJdsbcj6u7yOJBgRGLjEEc+lZQj3xC4onWFTk1jQBh3cUVdS+T6mXDdIKQnmIYSqGXrXQPvTit9AZ0mk/n5BtScY2CLHKYUeQBqex56c4sXGHAb+SClJpMrQaGSglf5Z7QkVyYWw6soMM6Sep2OCGdLrvyNIREH5+Q4DVdAlK9zI6yWmJLQq2pp0sfuge+JUbYuxfEpFFWm1pXo0DF6U7T+w3ENC0BNVJ0oFXl35QGrDHNFsQlOiVL4rFXG80mXTd6BfPSYQcsvSyYMaXKi2gC58diOBOEqGM0N9+oLu+6U+vgn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4/7BrnXEHeR6HO8qSUX0Va1mr3FKn9AKAZAnNRsH40=;
 b=TdznJK1S4P17MrLAA+8CpR86Uw+5hZ03ikLvgY5mzHP2OSel436S2nKKNnqdMreqzzpeXlRpWYG8BYbMlEmPWyrIrl7mHtLvNB5eZikeFyK1HvIlfl/7R3a8HoeD5F0uNWolyof/r5xY13uoiwkMgtFjiI+bQduQgo7BseKnGdG1M4a9Vn5aAitehKXrXZhkL7YzCHKF+hlIqtSUTBQAc9fRuPfGWQ2ej4VlS4lu37Pnu20sRxca1FVO0iZRNsp/l5JoQkITFGZjtRM2uvpdiHONjbQTj5fYqVUZdAxxg2wB3GDV9VbRrYSEdflsgAJ+Blgx2OPN1GXlmpsIJExEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4/7BrnXEHeR6HO8qSUX0Va1mr3FKn9AKAZAnNRsH40=;
 b=E7cmmelOxAHmbyU+aoO91CMWCEBUpZDNFa6OlekGWmBxBBKQ7mD2lgzpswHm08vJzdTz+9n6K7rIadbmRMRMnnDZXffRjROQt2R9fSZixbwl2Q4rew89B5bLbdtKsUjFY73h4w3F4SHFiRJ5i8dheJ6UpPNK5212j5Gyvbp3oGYSafPCHU1W155Q0q2l+60ncctPD/R7Wrk5GdHV/kQI2gFQKOK0SgGefRLRdeNiIPCwhc26LFwS2hEJPQudtC9M7C0JzkFs+Pvqj8/F+LIQ64QMXsxZnVCxUwC4DbRpkoOX8BPaR36F8/7g8EOhHFb+PGHbzBstjCRHMUtBOuCEGA==
Received: from DB3PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:8:1::14) by
 AS4PR07MB8559.eurprd07.prod.outlook.com (2603:10a6:20b:4fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 13:57:03 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::e4) by DB3PR06CA0001.outlook.office365.com
 (2603:10a6:8:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Wed,
 14 May 2025 13:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:57:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 64031200BA;
	Wed, 14 May 2025 16:57:02 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v7 net-next 08/15] tcp: sack option handling improvements
Date: Wed, 14 May 2025 15:56:35 +0200
Message-Id: <20250514135642.11203-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|AS4PR07MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 612bd26e-52dc-4cc5-dbe3-08dd92ef34ec
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZkkvQ0d1a2pFMGpIWnZicTBVbzQ1K2J3RkFrcm5oYXZ6QzBCUm1EbVp1Tk9O?=
 =?utf-8?B?TldwSEl6b3YxRnV4ZCtzdk84KzZrVW9peEhXbmQ3UEthemt4UTYxMVBDeXdM?=
 =?utf-8?B?TGlPUVhnMFBtZ3psMEtoVUlhU051bkRPQjN6V0pBMGpJUkV5eHl6REIydlpB?=
 =?utf-8?B?ZkFXTTliUk42SW9RR1NNeDBlVWMyNDZSTWRBYTE1TVFyakFjakFSZXV6RW1j?=
 =?utf-8?B?ZVBCR2lnOUVOTnZQZm9pZFdROHJocGJyTWZDQ213TjE1MUVkMDU3K0RTMWls?=
 =?utf-8?B?MHIycWVXYmdPbjNXM1FOeFQ1a3lhWE43MlZ4OVgwVUhNZ2l6R0g0R2xMbTBo?=
 =?utf-8?B?ZU03OWVlOEg0OGxnb2RyMW91Z21iOE13QUNPSy9GdXBHeUVPUHJ5YzZRTWsv?=
 =?utf-8?B?aThQMW52VkV5YkRZU1ozRkRqSnNCVzJUNjhRL3FYQXdvUmc2OGtnNHYwVjVU?=
 =?utf-8?B?NjJ6cld5b1pvMjQ0VlJUekpIZmJMREdTamtEdThWRURzTHlOcEc5NU1hNjhu?=
 =?utf-8?B?bk1Qb3JWeDlycHdXNGFUckh2VS9TRDlJZjg1Q1l3N3ppZjNBV0QzRGtmQ3ds?=
 =?utf-8?B?aWRvRThuRVZaQ3R0RFBtOHR4ZXdYRTd2b2wxTThneUdONFc1TnhKK3dPL0Fi?=
 =?utf-8?B?anhWdS9LY3VsaVNZbnI2RzFRVzRjQkp1Wk5jRTJPUXkzZTROb2pKQjUyWThS?=
 =?utf-8?B?cnUxeVdnN3J1MEpENmtXLzcwOHM5bk42MlEydnN2WFcvQy84VVpOMVQ2NGpp?=
 =?utf-8?B?N3djVHlneTlPKy91V2JOaGdUeDFHVlRNZi83M1pKSnB0aTNhZWFmaEpHYi9o?=
 =?utf-8?B?ZUNKNTZzRTcvOWliWXVidkRzcnAzZWwwSWZwTnErUDJ0NTRMVWdMaEduLyt1?=
 =?utf-8?B?a1lFWXJ6QngyRm13Vys1ZTlibi9xdkJZU3RyUXZFL0tEMC9BakFnWU9DR2FB?=
 =?utf-8?B?NXlFR215ZzR6TzkvdnVTSlNXc1JXd3kyYXIwLzBLOWFLVFZ1SFJ3dG5iTldx?=
 =?utf-8?B?VFc1emk1SlJGelNxRFUwMTlYNFZGRndrbnF1UmhlR2NSK09IMndDd1lyV215?=
 =?utf-8?B?dk1BZ1lFakdyeWZaS003Uk9zREVjL3VwaXhwWmlFdnFKbTltT3FLQWdITUpB?=
 =?utf-8?B?ejlIN0RxY0pqSXVMaDZMZ3BqY3g5RUpQelJLeFpVSnp5MlN6d0RzMGdtaGFQ?=
 =?utf-8?B?SEhYQlY0N2FMVCt2NFdmdEhFcXNHakU4MUpLYUVqOFN2bVorUUlVaDFzckdG?=
 =?utf-8?B?YldKSHNvV012RmVBb2ZOU2hvR2lwYUNLcG12aUoza2JBdEMvdGkyNXdjdkF0?=
 =?utf-8?B?OENMbmZQdmFJK0hFUVd0NHdMTWxXR29qYUdVUlY4Y2p2SnhBTE9UcDduRmdO?=
 =?utf-8?B?WlY4Qi8wY2dINlg1ajRrajNXR0IzMVJmQ2prOUUrdEdBU3FoUk9rK0dvQVhQ?=
 =?utf-8?B?Q2wwakJkRXVMcXgxNDltYXp6b1FJVkRsbElmTUNoVkc3aEtpckRpOUo4dk1R?=
 =?utf-8?B?c21jRlEwUkliSkVNVCs2QU9Tc093cHZqVXhWUVVyR1dPM085ZmhoVmtWM3R5?=
 =?utf-8?B?WHFKVmwrb2t5TXJrWnI5MnFTb3RFU0NlUjU0V1k2NDBMSWRXcGNXSkh2a2pT?=
 =?utf-8?B?bUdURGJxL0R6RVBiNmU1UFdLamgwSkdjTDBJS0gwYTdHMHpodzQyOTAxeEVr?=
 =?utf-8?B?M05tY1VjdXNvNHlBYnNPSWFlaVEvMk5LMWh4MTFWejVORW4zYzBuYmhITURu?=
 =?utf-8?B?YytLUGp5bjlBc29WNVkvSTQ4aE1NMTN3MmRLUUNQQ0FQM2NCY0pJVVhHd04y?=
 =?utf-8?B?NGVIZlFtWXlWQzF6UEwzSDNmOGIxd3E0Z3Z4TjZ4K3d3amYveUExSi9VTDlW?=
 =?utf-8?B?S1FBeFpOTHFCc1BSWWw1VkR6S2RnZ1Z4ZTFFRzJ5aXZpbERsTzdpWWpta2FX?=
 =?utf-8?B?T2JFNVZuQ3FiZ1hmVjEweE1BRkxob1dIUk5ScWxOVDJabXhOc3hkMmxtaXV6?=
 =?utf-8?B?N1dKSTVISjF2UjZQSUl3eWZJTWswQWExME5Vc2RHQ3dSRm1OVjV0anR3c2Rt?=
 =?utf-8?B?cVl0Zmg2UXlYVDVWQWVicEI0VjFnSnc3MkhZQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:57:03.8468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612bd26e-52dc-4cc5-dbe3-08dd92ef34ec
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8559

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d0f0fee8335e..d7fef3d2698b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1092,17 +1092,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


