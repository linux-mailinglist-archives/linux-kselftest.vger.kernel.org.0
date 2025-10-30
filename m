Return-Path: <linux-kselftest+bounces-44414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC22C20AC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6600E4F0366
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB33729B796;
	Thu, 30 Oct 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="cjjrZi/g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C3274B4A;
	Thu, 30 Oct 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834903; cv=fail; b=jpHFFodvDgxtTMm1bx8doDEL7FdV1hAWsVZSruylAFTGXy2hmDQwj7YUtWgwwf4lGOpyqlbYE3ndgvahAgsKD/wu2EHagNR8iGIDCbsaBgFDr/03YhYyg/9K6bK3aR2CxAE/iTWns5vQhPPChL1x12Wsdf/Iz2hGn29UIBGVZYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834903; c=relaxed/simple;
	bh=q9RZpqVrffaV3J+sagRjq+CHlYViTFY4M440rBIvC3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJdqwVIxJ/YIw3BW4kM6eFDjM5+u317vNvj0NDbgdYpOBSLeZug5ADyBHimdjiaAi/TlrEHp3IwlpKBpCfBklCEqPvLvzx8VWBtFERuxLyx+qP1sHHCBAQDkVEYy/73wctWanCkEWP8b2prYwv+gMwvZ2jLN+AVI7d0JGFqyAPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=cjjrZi/g; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtkmi8Q6f/LvDSjTHsTDJQLiXgZlL4yicxcASqhNs7HnukUaF4pBVBatqXhPDdP2ZNcj5rSyyPAt6oXge2kAJV+9pUCU8L9X7R5SLKZSC8W2m10hmXbWgrTaOBBQsswLeBo5FfUNTw0uAjfqtMg7pZ+KrHgKlRIB9Wnpodw0GRpyqaLLB3VM0TFutgcZSrv1i/eCFCZIXvjscovV639Tr92l3y+TN+3LBBN3F4GcjEgeoGKC7EV/ZfRbTVmOXsIlWszrepvX/OvtLa3dv/d1Hn1WQPLeMpiQxvPL6Tv+mbi16gg60UOt3y1/AvzTSPNGWOeEohYkHiiRLjpmk0YzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf2aQmvVsDpMNMoczWwROPUgccz2e/xvLLgSVBce2G8=;
 b=WaOrCb7+zBcIkcv8KNQDn4SWRh8+Iek4bLWeFa2D4wslfVMleZIOVFbeWIdzETm6xXtbYILSTMLQtXFOk/C7FWGBUnVsCR+bbKcPnMbrLzNduAeBZGtIYDMpxtfhSVPgWxdEfXtaRfdqnTWEjesqcR/EOoa1mSLemMz9M7zxM4QmBsEdDyqCZnqp37Xd2yy1U9q9P6j+Qqlw9LmU1WU14DSqALaPdZq8yGTVgGZ5DefiZB5081mdUjmcIwpHrLk+BbWKAEpB4rDA+EWqFuD4fAE6fE/er+c0xV+c1uil0c055aEVALrBnbsZUvaEry1Godix/JTZM1AqCpxC2hrATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf2aQmvVsDpMNMoczWwROPUgccz2e/xvLLgSVBce2G8=;
 b=cjjrZi/gn85/rE41w4P2e8SydjQclXX8tbD32asjAs1DPlGNNWwmm4SuWAyG+yx+Qgmy23McEJnvy4MGPKHWV8mVMTyjgRFTsneFWnTwDwsmJLQG/D4qOueGP/wm/xmCC3mgQD/hbE7xrxsHJiOhWRZ9lAQAk3eTEX6Jg5XQM8quH6RtpaMMfqygC6PpaR/o9rOWxK0Jf2x5WpACT3Ko5bie0fjLCJOoIUotXZyYiSdLTtjd8yFtw8I6F5RRMER4Km7hiYK7sZ1e/vzIc9XbnZ/72Q5M2O3WBQOoxTiGj2qBgr4NIZwRVH3Zd7FhU0H44g27s8aG2wpBjmn4J2hwTA==
Received: from DU2PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:10:3b::19)
 by AM9PR07MB7266.eurprd07.prod.outlook.com (2603:10a6:20b:2c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:59 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::32) by DU2PR04CA0014.outlook.office365.com
 (2603:10a6:10:3b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Thu,
 30 Oct 2025 14:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:58 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 494FC200E9;
	Thu, 30 Oct 2025 16:34:57 +0200 (EET)
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
Subject: [PATCH v5 net-next 12/14] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Thu, 30 Oct 2025 15:34:33 +0100
Message-Id: <20251030143435.13003-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|AM9PR07MB7266:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a48a9fd2-d80d-491b-a244-08de17c180c3
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?U01stFE3B4/sqrngmuCPY/BKfRkYQIjwa+PdaMd+jlPxUzXYyxjERMUHglcY?=
 =?us-ascii?Q?InNge8v+WC/Sh4ra3q1UZpLXI3oOM5IfnhTcugLvenhW27WGODPYoNmCXOV7?=
 =?us-ascii?Q?lb5hCagt02qK7k4LWXIQ/5M4k79wQIibBXy78CByvpFSFKDNW6hKEw4T+/3J?=
 =?us-ascii?Q?1IDiCFwMw7zTqvmga5i6ov1l+mkEzXE6CK6NGL+9eJXAyIqeRN4PKvv1VfKZ?=
 =?us-ascii?Q?Huw7bo9APYGiOt6HW8GyhvqgDXmHFsFM1wtiOxHnSbTdsfMZ6diy/0FL+CQP?=
 =?us-ascii?Q?9vLAzPIqE2L6155nkKDZWUUHmLd69OTov2Y0Af+/l24uCCuKpNTTn0QYY7fX?=
 =?us-ascii?Q?mfVgP/zxmVIOnSmWEco/uxCrDYx0Q7TPlw/Cq7wlUEOttU/9iAzFPUfDPd2t?=
 =?us-ascii?Q?eQ4dco0+wKH1YF5kAJImbsxl+MbiPAkWPmjeMDfSyEB2XSvPjM5hqlVrI1iX?=
 =?us-ascii?Q?aP3yB7QhCrxs6aYirt4dPAv0kH8a8LaDz6myYg+19aeEAw6DATEcYKYcUvE9?=
 =?us-ascii?Q?63KZudcuDJrGt5jm6Jx3qJo+Qa/h1B8P9IIAG+qZizqSJN1gnbms6WJ1mUgA?=
 =?us-ascii?Q?hRcz57LCyk7nZDkOp5F/ityQNQrAYYxQkZZ2BmgqisY0dwZfwm81MFc4ZuV2?=
 =?us-ascii?Q?slFFic8kJeMc3bDaZteXlqK7C4JpiQv+G7uobRNAsYHyLOs5dLxkL6ZWIGma?=
 =?us-ascii?Q?Pyrz8Ojvz1UqlLsd8gnYRbqovGLjqqipjd8XP3CEirJxJBeVEoLMt84YNN9/?=
 =?us-ascii?Q?nPGfQNY5mz22YdzOYrG/lWq8kzNaHIKmYwU+tGpJoZinpDx+2SLbjfKpBwTn?=
 =?us-ascii?Q?xgoC3occ7SpEjgHK/XsFjdxjJ66+VMiMdlh7gBcNtN2aYtTUmA3eGQt0xawg?=
 =?us-ascii?Q?zGkgvoEV8BdnrluQ+RS268PUCc/q6xlJ2mc3hLsF63sWw7hGdl0sD9y9d0k+?=
 =?us-ascii?Q?Aa81qo/SNSAclFFsLFq7h7QA/JOIIMRv+dhcnbET0SE+r4tw3M/CNN6joYFU?=
 =?us-ascii?Q?qLTMPFXNODmIk18e69JZbfP0QDGXHlpfbLd5BsDuZf0AowE73qlYW6T02PRb?=
 =?us-ascii?Q?h2ngP8LT6WIkB1zcTBRiauwCLlO2De0ZaQfFwRY2r+mS2R+m70oLcVKpEbu8?=
 =?us-ascii?Q?ufy1375PO9eu3n+TKKCXHvGlm65KdVOh2VpTDDAHj4TlmRcglvDrGfXFLxK+?=
 =?us-ascii?Q?cY+Di5gijOcv4U/bCvOODZd1I3PYaHubdIoPC61tBJZKMOti6pim2e9m6j+Y?=
 =?us-ascii?Q?3AsUIWPkEO4jGfK64/pgsVhvSA8SvJxguGF00eGO6fuGMUuaYRHKeC17cbK1?=
 =?us-ascii?Q?CYPi6mtb0LEIaHEj9kbkaxZ6PcO6EE/VQBndcHfqa/MSQbYMW4Ac5PCf0AJF?=
 =?us-ascii?Q?N3EfxVhALBUyVZAYI0wCvV96srKejSwlxxplgpBDY0+ourx0udlEGnj1mCqY?=
 =?us-ascii?Q?6xfAQSJZM3Lbdqc+YGZgcLQcq/8dKbq/oK2J+tieIRSXWwaJT8KXtS36yCwA?=
 =?us-ascii?Q?Z3g4HJgZ994arxglWB6gZ2UZ4y+EoH6pt/Slq7X35gwxGt4ogdL6VijDnCiv?=
 =?us-ascii?Q?tE89dHevCj6aEOOvDw6Ny5ObESloti1xw68gCfBO?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:58.8771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48a9fd2-d80d-491b-a244-08de17c180c3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7266

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
index 88a328e7bcde..c82b5a35db28 100644
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


