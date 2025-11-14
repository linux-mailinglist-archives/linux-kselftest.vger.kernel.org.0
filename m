Return-Path: <linux-kselftest+bounces-45624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEE1C5BBF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F1DF35C51E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175582FC86C;
	Fri, 14 Nov 2025 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DSnoTwA6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1CA2FB962;
	Fri, 14 Nov 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104463; cv=fail; b=cbL3I7e0L1MuvmxgWC/QFl9ixLROwp7PeQ/EnMHPVvckCVt/UoQIOE1U9BPJFiDVVtgYsQtkczHV6QEcBQQEAK81nAH1ISwRmHFkPTGb8otsM7LcxUA0d9kSUe8gAjSOZgG96/3Jzu3mP8mSM8PTIga1dD8UKTwq7yjs+L1NuqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104463; c=relaxed/simple;
	bh=7rtb5cXShbZBLAgbue2PNTPEXt9sH55ZsxNb1oDhdJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5IodofOQY41czzOV8b1neHC8QE13i+xW8UyhpVfb83ZZJ4MqGW8/2DAnziGIApyBiAmJecSPQ+G6ycoLPh5Ob3XugQTPPfq4W336nzFnYBNiOE27tUUYxMoBGkazIDeg2esCTtt/zUQl8aicTptAtjxc8ouyZkX0E5leuUFFr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DSnoTwA6; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUEjwTGkAF6HV/HtOc85CE0jM6Q0vS7ed8rxPwgKOY9uOK2A6j6+/WUABS4jkd3ZUciiVtCr5kNluCyvg9evTcVvtSsGuqSp4x6ykn/+reLTgBc6O6imnjcXRG+8ri71T3ulhbktSIsqoAQUhHF98udcb8Lmqb+v3R+aUAEGbHuCK3JIHukIrwAukMjCYVgjSE5EDHfIIg/Fj5D1Tz1gJrHbfp3Y8iypgfdmkjtR+45mXQh1XsuPlx5Fh3W3LHLhR1YjoCG4vuHTlY3j8oZm8tcgOD8qAZls5fVIXdiobFGzQiBvcvyMaNJBvSpcecvdUnMvJbQXN+3Hk5slhdujaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDCUi/r5+Ca1XZ5ozXtO31ZrL90s2opmMv2AUzOaj5o=;
 b=WBDQervVu0fjjWmKIeo+oNOfTfhM/0O1Q6Y61qhl82SNVj0i96m9Z64Xm1TBpsxmK4taPbeNGF47dieGah0a9PLwMAFhAQa0CLwdYrBxk8UEalFoRUw/GHVLmW2SDG0KNe75npUrX5Iv5l7TQiakgw3isrO4iaF63jSQdlYSDxKOH0ZX6bvlXZhvaEon/DnkC5nZKOBu2/fSianwtJJVVhHQUbV5HwiIrVBhAPvNssI+c0h0ElgUaGHoFB36fGkLYosxvE0FKnC9vh02YiqGfyWxZdBAA+4CDN9tOFG/yJfE8MhbCwJ9GIsdrfo6JbIkL6OSiCsmwrv4F6dZQmyBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDCUi/r5+Ca1XZ5ozXtO31ZrL90s2opmMv2AUzOaj5o=;
 b=DSnoTwA6w7r1Xlbw/kj3gmrF391Tkoq9aaNTzqAfrSbPlb6EV+/9iIEdwhC5VZ8BtI/7mCxip98sLqXzGV0hLnKG4KSMZlbAqvtCBxgunx5wm32lvOiSPNL0MsH4Lu6E6MQsN82L2GHEj8ibEwr3sWElp7rebYcWY5/yfXqAnx7KVvoGfEp4e+RAvNZ/03fVw7baLKXvwpgBEFy0SLA81zVyflEBme+xlUz/0GfgEL2zFHlmmh1wo2Ej1Udht+ppsPFESd6gJcaqMzqayJTozkb6eefnvlTuEM7/n0PmyOxkI20uot0YSy8dg6TH/tRARP6hLJe9nztXP6vRkef3ng==
Received: from DUZPR01CA0135.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::6) by DB9PR07MB7964.eurprd07.prod.outlook.com
 (2603:10a6:10:2a0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 14 Nov
 2025 07:14:16 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::84) by DUZPR01CA0135.outlook.office365.com
 (2603:10a6:10:4bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 07:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 043341C0030;
	Fri, 14 Nov 2025 09:14:14 +0200 (EET)
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
Subject: [PATCH v6 net-next 12/14] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Fri, 14 Nov 2025 08:13:43 +0100
Message-Id: <20251114071345.10769-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|DB9PR07MB7964:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 98f0ee6b-ed3c-438a-dc36-08de234d6c2c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?vpACYYhlqHVjSbYYMyj1K2UxHE3hARyM8z1ppbvLvFSaUm5edjk8k5p+G/k/?=
 =?us-ascii?Q?8xR8XgF9/Ylr3SNDwkrub6D4YZKX8srFcDsZjOd1t9y0IE6AbvduFAi4uTOi?=
 =?us-ascii?Q?fYT1itgtgCBuFF7EXeVh+vYZkQIYA5T5JJ3FfG6sBmyFyy69UH//bR5SrFuM?=
 =?us-ascii?Q?sLX1zS1h30pCXgMGSgswY5BVxobYq6pmq9GGpoWjLHyA2sWvgz1lAYFxrSoT?=
 =?us-ascii?Q?dJjkbrZQtYadoKOXuv3sx9yhrrDxKdU/ElU48gC3Vk/y68MUBFDPj5YF0eRX?=
 =?us-ascii?Q?971NCPIwv27HkZRa5laH+Jxxa7jR4fjNY6QeLaCIj9WrPaLGofrDpdoEdts4?=
 =?us-ascii?Q?1DwJD7BQeMjiw4W9jzVHhFVkqQOJFBGard3/E8Nl9WibMNlZATDvH7Krs2n4?=
 =?us-ascii?Q?ilSwtycWUkHpYSCFPjkrNjTvJTWiE/SbVf763SN2+8KYQvM4oD0SXeqirren?=
 =?us-ascii?Q?1rxbdLfH13uXY3Fy3aJ5KFJCxKjKZHNA2vjux2uoXeHVA3sxwlrbeSTLgXwh?=
 =?us-ascii?Q?aaH00Z44fNsLBRJYEgmtmmCrlmUVRiv+x4x0lPXKPvj7WdiftXr06Ke4YRSR?=
 =?us-ascii?Q?Nt/DsBuDyfK5dHUD4bmz7ixOrZvzhBER64mMd6e6/P9yhVOyyFagKMQuiLxt?=
 =?us-ascii?Q?+mHm5Zoj4yzugOtHqi9fyQfdJMskFtHBWo5FjsojcEj950cEv8tA7jVJnk3S?=
 =?us-ascii?Q?LAGyoadCWKKRm1AvVvcM/2K5qvqu0Y2mAZMS4W6b6woZ/ysAsPn+kqPQ+OQt?=
 =?us-ascii?Q?RiBqLVgcSlIUpNtu2b6v8ZQ3SuI1aLIkn6uCoXb8JqJw1QpEugOl99wC4TiF?=
 =?us-ascii?Q?VPjhuSnuWZM0wi/8RoiV8LHLX9xti/ZygWUpz0oxtAtm95fa63FYkWB3/b5Y?=
 =?us-ascii?Q?XFuisgbEMIjXVG0upKvEeASA7B+N/3pj6GfW6U2+yd2inCBS7vy7Bsdkesvl?=
 =?us-ascii?Q?QCre/3DZEs8b0t/IoGiNOhkBg6zwaSw2tty+S72hxoWwALY8Ewh3MlY9sJGX?=
 =?us-ascii?Q?Q9cHjNL19mDVX8cHQV7FE1OT2mxF+/m/7ffG+l6SpZxmvWHutVVliIxEeM7E?=
 =?us-ascii?Q?rO9FrWQuPtN870LoL0FB29sHoFckBFOgVdNyWpgHrlbpAfhJqp01Wf/sjdjN?=
 =?us-ascii?Q?LmegkJyRJmZ3Tyo93OOr+Lu/8M6NPkikV54T81WewnjHjGsUbYsDx2YKDBDB?=
 =?us-ascii?Q?1wUhHwzUH+LV5zULGuBtmF3Z97qPB9OEneXRk8A3dBWIDvA+NIimaMS5yBIm?=
 =?us-ascii?Q?Yu7/POaFpRWIeBnzthE4H+9qLsQuEXquFgpThV3Xrf46B9zMQkB4/EiWm/Kt?=
 =?us-ascii?Q?ZEHawvv2eTONOgbjhr7ScNxWmCpNbrajpwjEx4YSF9kAYm74dePihFbz8rlG?=
 =?us-ascii?Q?RA01Mm+Ie/y6TqjdpGUkpELHSUr+jXCHOIU2j2gv0fdV2aDpYeBvnabBoV/g?=
 =?us-ascii?Q?BEENDhvLiLRY5HL9veqyXlSXoyhY7ZUqyf7moTJLDFocyEV6p4KlF9a/lb62?=
 =?us-ascii?Q?YPvSKFly7dO04Do8u7K6mNC+2tXXKxtE6cOlP4Loe+qPkJkUGSxFS7A6U1HV?=
 =?us-ascii?Q?wDEb/L9xCueNMMJIAoiZW6Ko8dlaBY4JBINPFO+8?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:16.6652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f0ee6b-ed3c-438a-dc36-08de234d6c2c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7964

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 57841dfa6705..42fd28d818aa 100644
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


