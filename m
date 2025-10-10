Return-Path: <linux-kselftest+bounces-42959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C2BCD20A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82DC14FD73D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADE2F7AD3;
	Fri, 10 Oct 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jhgyzqNK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7A2F5324;
	Fri, 10 Oct 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102277; cv=fail; b=ISJmQElTgOnUkDIAltOHu691JrLzHyI/IO9RZMICs4Qmvc9jVwyfDaUUXNgaF0u72neCnNfcbi+WO8JjkCXc0A50u5D7X3GJPp8Io+qjl9hWOB5fW9o0UGhia6kgIOFMbz2f+QMzBBIF+6c0wDWjTRcskTtUFAPN9uxaYdqtMKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102277; c=relaxed/simple;
	bh=UlyWEbv2LAmAxozFwOwlSdo78SI3QsHUO2Ly0nb/vJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF8jMDzo7lgBwYmHZGyWbERnlNeP58Ks5gnxDfVCnAtqub2PQJdCItIoDQkYB5nZ4PEYMstAIsYOptQh07g9yhNnTudA7fqmJguvOB/8ONUHts+xJ1RadFkVPjU2KseaaJiV+2RsGcOzZVWK1tro46Aw1G3v7mbjBojMcaNQ72s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jhgyzqNK; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1OWrAnvvskEOkBNXJYk0RnwxkF/jbRNl0Tx8M6rTFxC0eCYMf+CTRsCG4sui1/+9PlB6kBkAwN8gEhUpCV2fi9W2YzS+fxeUnMdstgXSRR+iEC3gDShl1BbbIayjM9lVxbU39dVHEXcnJfCsR3GLHsSAILLbcrLvmmhvtjCxbWq9MbHtLtej8KV8KnlWxnG3nFsZqwdxt15Qe22FVuX+5zxBRaWAN1X7Ro0EGs1iOZPPKLFeLkBLPZBgcSOYjOrhYKD949eqTPmenfZR7dTPC7wvguIQjjEIwc0sviQMkVlkgOtyxM+I71yUFqEayY7Bz1EM6sCcRtAfKdkK0Bnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqB16pQfRYSIzISJMCmHpwdSVoowt8sOyg69Co0fKfM=;
 b=mh9egLZm8rChrL7QW+K2srY0YRcJP7scX+mPKF5ykyvgGhpLSGmWpBd0SaBuvB6T5KtSQfthKkJ8y4Xn/GxbAKLqeQmHKPVgLB5ssTSHjGvhbgb6TL9wpNiroBui0GXpkWrb7RkoC3Ble36ooK21EZc79Gq3EJTHfnzGg7QaTq4FjvrjBWOTUFHCwZ7E/Qw0+ysksdg0lQQu/DqZg40ySmamgTYZ7SvQNSOMnppJgDmo6DFOKUemZvxYik825bVaaiZw389BcxdMKuH+rz32qhntb+SfbcCJAl/pSZm2bkOEy4jPqwyPF5BUxg2lX9bZncWn9SyjMTEZ8aLzT9ycnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqB16pQfRYSIzISJMCmHpwdSVoowt8sOyg69Co0fKfM=;
 b=jhgyzqNKm2CBLPAKtJvl0iYwiIQ1gKHK1SchZSk2NRD8juJ1X13tdIo7MSdVVna2XX802v/+YdeUUifSJXP7xn3Nyan5SlggV0nJygBp3sXvPDgAi9NSbFS7grjZNzI0A9yCbHvjYphbQfGOC2CIXY7wsMCCRq/UphX2ek3G2P4qSgDqiUCRa9b+VItKUalWQKtce930V8CXCGb3FFHijoaojx+zVXKsihZfph2t9lFcm4GkdCSVR3iYZsuPdcLmZauRdML9lfXSd69lEdST/d2IUViQVFB82UHN9uYE1un4VlyUHJoYnsPhfyISDZ4pf9e/tTt9oHmhCbI2YmfMCA==
Received: from AS4P192CA0043.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::9)
 by DB9PR07MB8822.eurprd07.prod.outlook.com (2603:10a6:10:2ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:49 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:658:cafe::7b) by AS4P192CA0043.outlook.office365.com
 (2603:10a6:20b:658::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:45 +0000
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
 via Frontend Transport; Fri, 10 Oct 2025 13:17:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 75BBA1C003D;
	Fri, 10 Oct 2025 16:17:47 +0300 (EEST)
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
Subject: [PATCH v4 net-next 10/13] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Fri, 10 Oct 2025 15:17:24 +0200
Message-Id: <20251010131727.55196-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|DB9PR07MB8822:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f87dec60-d8cd-43d3-fef7-08de07ff6909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FaiUQtNzK7F5UmrWUVPv65LTJGCNL/0g+jvy8G+8Qh+/CUGuDwEh8crPvyIQ?=
 =?us-ascii?Q?mYLWb0qxQ8XCA8Qrqw+9Go8+QrvLsQEBBE5LUDPSIbBmDI9smXfbxs+ylx5b?=
 =?us-ascii?Q?6ZSmu3ugDk+PB1HUd12pl1vSJNidRIA+bItFU2xDEtAulA4r1w2RJDExUYe6?=
 =?us-ascii?Q?IMJWnmKbeVVANCF69hHHspe0rOfSud7MhEeA9w6v/1qMMB2HTtOGZYZPstrh?=
 =?us-ascii?Q?CsekOQYrMQeG0K3DyzHEnLLnxCr4xuPw6Bpb84k9lJ8VX0Ckzn8dTN0YaE2B?=
 =?us-ascii?Q?Y8EWaLTztp7m9qj6nmn65/mT9OadUVi811VnkwpvhQWSb9RpaZgT2duPgTKR?=
 =?us-ascii?Q?5j4upM+zeOV0sOCDLaDgDCjkSXfchdBTPZcOWchmqq9Yu46lppSRJobmxANP?=
 =?us-ascii?Q?f8eoIZMmI6F9rsc4BNPEoTDUZtaooAxfOkXqSPTNqq4jvqwLFeQS9Qf7dCTf?=
 =?us-ascii?Q?B+HoyS7V6vSqxctR6/+zjOqRUSyG7lL8eW5fJ0BxlApRB3HGpDCX5ws9vzpT?=
 =?us-ascii?Q?j8h9C6jTDHE96YHCv5dbr4dtItTB9y9N8wEcxgTSKltg4QI02KP4K5ALm+d6?=
 =?us-ascii?Q?Hm1YljRhQ6hbM3jOa/UGyIuyR8FU8KOYpvjkdqFgCtoxb6PvMylXFoYiLP2v?=
 =?us-ascii?Q?XOPS40lr5sxjmsMq5epaTTVjzNRUMa/2PyOxF6mISoqxQMM2o2BjS7KfaVMU?=
 =?us-ascii?Q?yz6jT5jLDZHpIodc8rp5ORWg1QBlSSVg4zWGJaXdGbJlwaKZbXnyseho+4zt?=
 =?us-ascii?Q?k1/CssioufWXCI5qd1oIJAjlFPRo3Qi0kGWkCrFCO69+BVWe6PYWa4EtEhCh?=
 =?us-ascii?Q?EK2LnSp4kk2mv/cupv94iMD4Sc07dEsVG8Gw6ecS6k+soRmmS+nYRbk8vuCX?=
 =?us-ascii?Q?Aqq9pG5r+gGp43EEbtMBaymx7dwD1PYhb5+q8sVi66c8TkvMQrQhp9LiRLrC?=
 =?us-ascii?Q?Bf0jxQfKeHK/D8mrKYAFV7V1wpF0/5f/yn6I3bihhpT5aUgPfX0b91KKrt/Z?=
 =?us-ascii?Q?hPVZ0bED0pYoCt7ibYqnjTaEBOsLkexKQS5lrCf3xD14ZGfPwg5B7cB0U+Bu?=
 =?us-ascii?Q?9dvjFf3gl3/qrwPHZDS7mvFOZ4j6W+utJT9hDzRzwAG0iJCZuXJ4aZEax7ZC?=
 =?us-ascii?Q?synnbIUC4OD2BUryoR8q2hg4sEQ2OXDf1WXDmgwCKQ3oZYpToacG2fNVvPWY?=
 =?us-ascii?Q?W5+c3xl1OdSGEo2qgKRfICHM8t6PDqZwphX0Gh6QDN3A6MC1eB6VLgZE21xo?=
 =?us-ascii?Q?4dyl3xsJFo2DPyLNVnr5Kj4Vq3kIiZHh8qXNzyzlkHQE0CFjQs94GqmdZ6at?=
 =?us-ascii?Q?mGR+ZUNc+nR46RobwapAHXw+0Vgl0GqVbninrMaYbiWJz3uFeZpj8UhkuPq+?=
 =?us-ascii?Q?g1JRb1oEu9gRkmzECcmUOkbXQnftqavevBYrm290NrxzJ2u3z/8fEZbRZ6Z5?=
 =?us-ascii?Q?fgad3DTx3CBgRwHJBt8bNY/9DmaVn5rCEZhm1fvTfmAuxLd5H+IvtlGDpTfz?=
 =?us-ascii?Q?infWXGnYdy2oSoKCjzGsVafd7H2+lLDCdVUMhzxusX7+Ne3yTgRpPhLou30B?=
 =?us-ascii?Q?ZuDYZFE5EZ9OCWYokwn0Uh4Wo1qHlY971vRsziex?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:49.0486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87dec60-d8cd-43d3-fef7-08de07ff6909
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8822

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 50551430b1fa..2dfd2fda085d 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -175,7 +175,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


