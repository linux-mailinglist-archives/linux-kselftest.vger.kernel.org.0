Return-Path: <linux-kselftest+bounces-32788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7EAB1EEE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B910554094D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD505262808;
	Fri,  9 May 2025 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="V0psJQ4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118412609DA;
	Fri,  9 May 2025 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825537; cv=fail; b=fF/UqUETcO8rGLJTptgkqr1/RYUv7xBzCqmTZI2TDPemFxQmJCtklMFZrou7DG+2HGUApvxbMYLw2Kib7kBIoqlTdl/oXyrnhlzeCHQzXvCSdFGphXwCxXD0JVyv4hd1LY3NVjYt8Q/X9mNcl01OVm4SuwCpVDWlbGtVARphBTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825537; c=relaxed/simple;
	bh=efBfSKDuHxcloj+DBa8sSHbHHP7NCEJS5VS00AD0ac8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3Y2huCIOmgPvfohTx146EQmCq/hybPxMHh6M0ha4gWym5R8yMfdGAxXKfggShwIyXDXI6LtHDpCK0lQZuUJCTPNshRz2PMQMuOGnnvPCFRq+3/joS/+sRPCcZjwjgY4CJjSWR0fsTY/XyKEefnvZicqRy8pOqn4WT4ZuWAL23s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=V0psJQ4m; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxNJU5BEdxeLg6UG1RhcwCFgbiYTgUxjYqzGVzHPG4OuaRRMYEFvQBS07sG0TYt3aoJsgt2i57BHiwOHAlg2538QP9gKwi4GbOUbfpTCVDn478KR52kdkiyZz0XdrmCuCZpwC/I/CxK1iuJjele/SzHay57Y7AoR5bbFF9f3hWp/VYFsNLYq+J/nFUkMExvP002ZDja4xVviqf44xGiO+LKvm5Fr48WYKN4mADizataWzGpMLogrOUF5QZn4hUHFHnLHw626verVYJobehz9IPiAfHRLAfD/WrEujJe9X7NDptqGlZJ9WlA0lGNA5gNggRAxkWfr1VH9VZqeG7MDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wdBaOw+R+gO3hHVWq7YjLCMZy0Pa4hT3OSUOV5WkhA=;
 b=J4npn44/gknPCRR+4bcIbyUSYGebSil3MoAA4l0FsJwO2wk47pJ782aHMubdYNqjpBaDcyyOqTNa3HhLpmjXn22gqUtq4GHZPTuMhkiru80RlGTl9xUELvfmNOxNJMPTipJZzk1SqzwQsDOvsYq0htYQn6ATfAxArhOD3mVGPYarB89UBWSADovwDtbVCVUbNdIWbNwWxWSlMofVNW5QrutaBu+On70dHuPLmBdAiQPZtWw/KIPa1Ph7KOpYoIIDVImhx/7ZY+nYBzOes2hJX/LbZYoNpbCSV0EoXn/YjVUhbDJF3+io5VMnxAa73lJ5VKMMcjMnNvxMzUPLA5tRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wdBaOw+R+gO3hHVWq7YjLCMZy0Pa4hT3OSUOV5WkhA=;
 b=V0psJQ4mFfIF6yG1ncSj37bafdO+KJ3Q0qnLmlBYhs/0gWI3k0OrfmpzJ3ULiY66r2HdzBsSifIKE8v1hHqO7TK3wpvw9uYvlC9GqNEl7mhVU8O/qmudma0DIzm/4QIjIX5Fi0sF8QA3Fw+WIxhuWfxVkVefCD+w8NZt0kzM/qaZmAQCs7JhS1y5E03bWneqCCHxrt80HJEaaEHK6pkC0H0zCFuY1ODaB154s5zaL3BI0Un3Nvds86UdaXWaKo4JZaeMJ/6pO80PU8n3su/FKciGmEzk8zQES8tWPjKboa3g+hO1po6JGTmcDpM6rd/BelqbPXuDAC4hs3zVB0S3Tg==
Received: from AM4PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:205::28) by
 AM7PR07MB6642.eurprd07.prod.outlook.com (2603:10a6:20b:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 9 May
 2025 21:18:51 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:205:0:cafe::cd) by AM4PR05CA0015.outlook.office365.com
 (2603:10a6:205::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 21:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:18:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id D78C12009B;
	Sat, 10 May 2025 00:18:49 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v6 net-next 08/15] tcp: sack option handling improvements
Date: Fri,  9 May 2025 23:18:13 +0200
Message-Id: <20250509211820.36880-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|AM7PR07MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 941e08bc-e87b-4762-e441-08dd8f3f18a7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bm82ZWtXTEV2WDhOQkRaMk1IR3dUNVJOY0IwODNHcVBjYm4yU3BPY1oxSDZD?=
 =?utf-8?B?d0xPaWRscm51YjRVUGxTT3ZDOWtEa3JnbHA4UTl1N3U5Zmo5cUsweStvYTZR?=
 =?utf-8?B?dVdvcU9MdEUzNXBzZjI3Qm10dFdIOE4wdlhKTHhFTHFiSFhLZWNoRjcxcmVy?=
 =?utf-8?B?Q1dQcFh1TUkzNlpXV3luVnA5K0JLZU5DMlFNMzdBK1JTWGtiejhNMVI0WC9w?=
 =?utf-8?B?aGNpYXhHVzYyNld5RzdsYjBVUWZmaHJVcUU2VkhHWDg4N0c4Vk03N1d4Ky9L?=
 =?utf-8?B?blBhZlpxaXVYVHlQa2NwK1IxV01HSmhOdTRiUmgyS0cyU2JUZ0VIbno3V1hZ?=
 =?utf-8?B?TUtnNlhMY0tFTkIyMk1HL1FEMnZHMmtwYWZnMVhWYjlTem1DQy9ybHovNmMr?=
 =?utf-8?B?bHV4Ly9oTWkxUDFCTk9wL1p5c1ZmWDk3SHFXV1FsMW9vSjQzbzlFYkRubUNw?=
 =?utf-8?B?WXdUK3ovTGRCVjdraE9Sdks0Uk9CNGdWWjlDdXdoS1dTOUlSVnhNOTR4clQw?=
 =?utf-8?B?WXVqZ2dBS2VPVldnNllGUUhXL1JaVWlYT1B1dE81RW5HSDFuM1FZam9Ea3VZ?=
 =?utf-8?B?YUh1Z001bktYZENZZTB0THYvTWwxZU1kaktmVFhJbEROOHBEOUVJQ1Q3ZjhC?=
 =?utf-8?B?U0dCTE9LUE5rUWJwSU5pcEdVcEpvKzd5MGpKZmUwSUQxdllMRnp4ZVdkVFBC?=
 =?utf-8?B?SjRnOVM0L29HbG9VU1VCa3NSNk0yZndGb0l4MUFwcGJKSmtUTmFzN2JrMlNH?=
 =?utf-8?B?dWFGSkR0WkFrS2IrZXd5OHNZRFVQU0JoOFpOTnFnS2RxY2hJQm5KWUJONzRU?=
 =?utf-8?B?VzhLUEZJQXovQzBsN1lXcklqck5xekFvTlZzWmFSTGxYcHVxTnRPMHcrelhh?=
 =?utf-8?B?d0NUUTNNRkh6T0FkeFZaUlR0NTdUZ05HeHZ6RWpZOXFrVnRjR0F0emx6dklX?=
 =?utf-8?B?TDBiY2hraTgyc1ZIdkhJSE80UG1SL2YvODllVkorTU1wSVRaSk40Z215MG8x?=
 =?utf-8?B?MzEreVhGWVF6cVdnYnFwSVRvUDMzN1BtS3doNmFhV3FoQm5FMlZHdFNWc0NX?=
 =?utf-8?B?VEp2RnVzZC9aQ2k4V1I5MEFwc21kajNQZ0hBejlSdDYyRlRXQmt4aThrdmg1?=
 =?utf-8?B?VzlYanhZRFEzaHl3aElLbG9hMC80ZXp4SlVDQmNoSHBZWlNTRU8vT0JISTA0?=
 =?utf-8?B?cmtPWUo5d2YvejBTdUluTmNsOThaVzU2T2wwNm1paVZzTE9NS2NtcktYeEJa?=
 =?utf-8?B?SEhUekJwS2ZzeFgyWGM3dE1WTno5cWtsY2dPVy9Jb01hKzhqVldOZ0ZwQUFE?=
 =?utf-8?B?WVpEUExqWHIxSFRQM3FqbUFYRnZHSHI0aUpCWUF2ajZ5MDQxaW1JenZaODgr?=
 =?utf-8?B?VWhUNURoUERjR1kzMkJuRHVLMHNsVXRWdkM5SGhTTGswcjAzL2phamtJWkR0?=
 =?utf-8?B?QyttTHV5WENLME5nSTZwenhYZEZUUkFZTGhncktCM0twTEUweitmUFlzOWxa?=
 =?utf-8?B?dUhDYUpleUk1RTF5NkdtTFdLQkVpMGpCRHZnNGJyNUhqQWxxelQwWFdKbDcy?=
 =?utf-8?B?UFhGbzRNSUFKS2JBSnZKRUJWU1pTWTJ4ZGp5UHJFY2NVRUJqcGpOUjFBTEpE?=
 =?utf-8?B?Y2d1UGZZQW5Ld1FOdW5EaDZXN1ZZY08ydjFjcDA1Qit3ZlRmNHFJTTF4M2Nj?=
 =?utf-8?B?a1J1bnhJaE5YVUtPV0VJNEozUm5ZU2hBM1pSSWJVWmpHb2tkdDFOV2tEQ1Jr?=
 =?utf-8?B?OW5SSWc3SjFnUVVjSTZqMTh1Z2tpTGtNMVhhc3A3VGIwZzcrbnptYUNpKzYv?=
 =?utf-8?B?YTdWdkMvU21uWWVlZHQ0TW9ET1B1dzZTbndrejM0WnlLbFBUYk9qWlVnU05l?=
 =?utf-8?B?eCtialhkU2pOSHpGeHJWNXBzQ0FwdE1uSlRsRmdNZFJNTVBoeFh3cGJQV2li?=
 =?utf-8?B?Ti9CajBmNUovRHRjNkNjalJXZzgrRkRLZ2dxMTNMQ3BBNTV6UG93b1QzNm8r?=
 =?utf-8?B?NVhvdFZ6REh5eXZVZUIvSkh4aVRGQzc5eWk0R29SdXo5L003dXlnMUhHNGRy?=
 =?utf-8?B?WGc3NjgvNVlBbXYxVkVGMHhXd3VTc0xpZHNoZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:51.2558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 941e08bc-e87b-4762-e441-08dd8f3f18a7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6642

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
index b4eac0725682..f2ce46476c41 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1091,17 +1091,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
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


