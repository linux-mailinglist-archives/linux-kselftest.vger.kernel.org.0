Return-Path: <linux-kselftest+bounces-42529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F308EBA5B4F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BDA2A2B0C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD62D7DE4;
	Sat, 27 Sep 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Yul0vXFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9C2D8DB5;
	Sat, 27 Sep 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962913; cv=fail; b=Ux4dOt0yF13UL5sy4yaheZW5yEwarV558uJy2V9Z+wu6dXMIh9iomOHwMSG1Bib/n++wSQxOu8egEiFWS+14P/PpMXBplCkRU+lvZ5W2Q08poAFW2vkpDDtusCLHl6K+cRd6+yrsbJQ9NlJFq+aZQSU8b/r0RY01IAtgCqkjJDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962913; c=relaxed/simple;
	bh=UlyWEbv2LAmAxozFwOwlSdo78SI3QsHUO2Ly0nb/vJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anONS1385YG7PBsPVizD63naC5ruxGvFT7oVtj9c84LmnSinQlh3sskLzrbWh8sM6dx8+R+FT5suZOP2gjHeRc+EzUfBH4zzcbboE3FOyE4nHdLnGqTXBTtS+EpVaBzhLu9lFzrCwE1gSNdzVcmaHbtuPFx6LgEaU2+Y6n4iAqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Yul0vXFD; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwcrXX9CnBOsW/O04NTv6ZtUGCtc5qLfM0wsIe4MsT6/tvjO/VEMx8YZiYoDqir2yajbQq2AhHylPmk0UXz6G32wkLnt1S/g+uKVzG1SASUIV51TJFcFKAA1BfmFzIWuNI4DUkhHqVQj+h/VqDH+tu1MoKsYtBK5yCB9pBgE/zJkjF6YtF4vpm0xTDyVsfPU9JWwgN19XY3sHRQFBvOQp4fHJL+eYm8rj48SdOzbFl+DheuAzZq5pGnXXI4sUbaWpuqdJLaq4wx5SyyTM4Xht9dFeHgUQULs1vLtVEEG6JSio5MyRF4HTUcYocDHQsrfWOpZdqpHGe+kbPUMcziYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqB16pQfRYSIzISJMCmHpwdSVoowt8sOyg69Co0fKfM=;
 b=tC5qoBX6wLtsShX+NAJL5DsbUoiN8BGMSR7tL8x74P518AJubG32Owwo9ge5CnGKS2gvQfCwZG8B3aOgXIWjQ2nBI1U79J0Kki5SAvMLPn7XJjf8Yo/mFMaANiATSxoBAbw715N42Dwlpl9b5PS/nkghUDjNHy6EEMxuaR6niCxUaPEypF3Dfw631rk+9nn549v3PsTPvAqtkhBgBkrKMzx0d33KHqwPnlsn9O6bfkEa2a0aBSJUPRTP6ni6wxDP8r+mEJYdMEb/EDvFpeg0gP6cuG6dXNejgpSmQC39odjaeFNZc0+uCNO35/GpCLsCokq+h2kiz2lMC6Dykyi8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqB16pQfRYSIzISJMCmHpwdSVoowt8sOyg69Co0fKfM=;
 b=Yul0vXFDso9WoM/DcNAeXANGkIMRPP3Of49bpE93htNK8psXiKM92BAkkbZGQ1V2SZXlINjyattGug58boKCGKkyiayX/SLRvBZjh2EPukvaEQlP2bhHZUIL2spNOAQ8rfz+jmQEz/gEQBYOExucXWUTTIJc80F02hDJZ0m8jcNVVrZ/6llTMMF1dR3xrpodGJhlJ0H/0lYLqZUZaDihbC1iSLV77geg+0o508QWQQ19UG3LRE6BhnAMcFhY+JbR5Vn15pic8lz6h/RYfCOCgHlZM933ghw9RxTsUMJunus9mGDYICeEuXvoZHhe/dWUrXUEAdJJEyVwaKIYJHA6Uw==
Received: from DU2PR04CA0062.eurprd04.prod.outlook.com (2603:10a6:10:232::7)
 by VI1PR07MB9460.eurprd07.prod.outlook.com (2603:10a6:800:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Sat, 27 Sep
 2025 08:48:26 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::ba) by DU2PR04CA0062.outlook.office365.com
 (2603:10a6:10:232::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sat,
 27 Sep 2025 08:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 28D28200E3;
	Sat, 27 Sep 2025 11:48:24 +0300 (EEST)
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
Subject: [PATCH v3 net-next 10/12] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Sat, 27 Sep 2025 10:48:01 +0200
Message-Id: <20250927084803.17784-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|VI1PR07MB9460:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f1955ec3-e906-4482-85f2-08ddfda29f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nSdI4Is1CqWhbKFqhZ9+c24g6HYKIMoJb6UF6zvNqDqgcl7s+wtFM4T/wtbQ?=
 =?us-ascii?Q?LQh7XPf6n1PsBymV8emK+lOlNxsnCe9ugOWKDfIPUHr46I1ww4H8fN82LwTC?=
 =?us-ascii?Q?2ElsniC4CqoEcu671n6bR+IHWK7pm2xLYQ2i6I6Wy/cqdQ7uUUyLIypllkl2?=
 =?us-ascii?Q?vdRxBK+vnrIRqblWUFRlocV/SIyO95mn+sM5h2R9Bkhei/EJS6JEqk3eOTug?=
 =?us-ascii?Q?kmT9Lj6LQhxirsKxx1L5+OB84ZixRLnksvW/9TJwCHghEigQ70tbo/Wj7bEy?=
 =?us-ascii?Q?KbqzSiIi2+ff/Ht8E82Tb0jOz4AZjqfrM4z9Mayq6dvNGuaLUVg7NoxE9PCy?=
 =?us-ascii?Q?wJGt03Mf9Bop4lUIiPrQLHSh8orTyFhPbfbCQ8d8APdhJWonwIT8FtC5YKVc?=
 =?us-ascii?Q?PG5tQua2GutuDwBD2ZX7bBArYwHsxeOosCMDMRHVVy/vzEAZ+4zKCxD3RyLi?=
 =?us-ascii?Q?GopGs77SgP9XF+jSm1SotmC7dVMb7e7nqR8/Jj8g4SNWavNvmtlBSjMS4gL8?=
 =?us-ascii?Q?QICZtVG2K+uWJ4hx1sTLF//HgryAp1zXsgd8nHxJKl53rKozO5rKVHzKtLkH?=
 =?us-ascii?Q?z5307nC9YTo891o3nw8kLTud8Wb2W3MRCrpS0drMMFjmWQ1DBl1Jirbr17WI?=
 =?us-ascii?Q?1w6o3omPydtiLtH0WGY0+oFxqiBAjRDoqLxThBVtF6U2hb1/t1ltXEH6oUXN?=
 =?us-ascii?Q?WANenNay1Hz1gQeXmdaUpDxW1Zc17y0N/gy1en9BI6YBiDORLUWPfgWrVv68?=
 =?us-ascii?Q?iFKpps7vPUMjEflHeYLmdyFlu5vA4ss30jzx4SdfGRFxQc31GJNojSdvTq9p?=
 =?us-ascii?Q?UtRRGigxtHzlPD2Mh2A6Lt48+eYdvPqeMV5tyn+PJEx/5XwJeqXUdADvnYEb?=
 =?us-ascii?Q?08u55LBenYEqW3ZqVLE/8hNJrJfbBtUge7ZdOUo+A25AWPrnhltPWYe9vybq?=
 =?us-ascii?Q?OpM60ZJNVeZUpndsfjV4zmgZeXhdm9MASElGedN9ps3aBetQYhwJEVoEh7IM?=
 =?us-ascii?Q?EyyWedkXs9mSYuKUPykvFFC3zexllQbqpytVyM37It8NyBLNolM85UUDKYM7?=
 =?us-ascii?Q?pYMH4Et1bqM8u6kDAgVjdvBDaZklUtnTc08NoOddi2x91BYXy7Rjl6NPduK6?=
 =?us-ascii?Q?afFx1Zd0PxBeyrOn3X3lbablHVz2jvQHnFY3MVjUzMBTfUzmFglvRZRwTnQN?=
 =?us-ascii?Q?6LD1H9DJNXmOyOzig8AKmqCbd6IBg0scuifOWgHn5DhHnqNiHSPJypl07ptl?=
 =?us-ascii?Q?k6NzpehFnoBdYKYDpKCn0F87sHx/KjNicLzYITt9mn6meeS0PSW51sznloQJ?=
 =?us-ascii?Q?iWZopPrB6gQQOzbxZYERuPXUMsuQLJxCnHem17y/rB9lZPbDyynTl9az6cYy?=
 =?us-ascii?Q?wrfs6VTKSH7bLkumhzLuU8eHOPHiknBNYw8soSCsN8H3acCHafgGpDDfMHl8?=
 =?us-ascii?Q?cD2fEpiqyCRSWq6UhXh++HcJ7D2E3ihfxkRSI/6M3jMCFfz6ohUSpA2TQXtf?=
 =?us-ascii?Q?cYyCFTbZBFhw5AvCPyBEz+OwRquQV1JuIMJClocMavOfmG703HllZY5e0Apw?=
 =?us-ascii?Q?2qEPkXflnqHKKuV+CBO+gMC9JIi2SYbutem4KpPF?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:25.7158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1955ec3-e906-4482-85f2-08ddfda29f70
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9460

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


