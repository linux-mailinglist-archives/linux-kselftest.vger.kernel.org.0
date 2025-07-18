Return-Path: <linux-kselftest+bounces-37574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174EBB0A63A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72571C809AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EEC2DECDD;
	Fri, 18 Jul 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="r6MWsw1O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A12DC345;
	Fri, 18 Jul 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848469; cv=fail; b=F7Juk4y1ezRbxxY9ZdmS8MMZ3r6EdqBzB1xQJfyhDs/2bJtTWJeolMBf4BTBeVm+PknzPIuDn7MAYbXuSwYgNUbp8W4s3RPIK6oM8eqWLRZZAhgaipd1CKVCVPR21maNnByqCTiCNmUNeAtKWvYyTZXCo1xOlBCEQhyItyT639s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848469; c=relaxed/simple;
	bh=bK4Xx+l1sBybj9q09xns660ule0tkgq5RmKraqLaarI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I04bx/94CNBypRlD/4PC4MweRq9SPt8xJ5U+pIyjwouVnURVjHyM0hsSldye6bMSjF4bNFt85lhAHrP+E9BLwwzQ2hSo4tr6McsT/p4H4M916SDFOWwm1xdKjlMAhvGypMRbz+TjGZ/UmP1ee/wm33s7GlYxkUVMro3Tv+BUgq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=r6MWsw1O; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjDuRe/KJ+A2KRuJm/D5sHxolcAstWDOaWDOR8tEShEwFgd2xECwEsFTURQrdh9ste7LiXlUcSQtUIjHuGPaVcny74HasTThKE7plzmB0ZdmFsjJCakcGtAI0UK4gUt5cwE8Fo1tYhpS6TP00mwSggN4EhmJ2UXlw0S8YwsmeIk3jwu8fnCg3OySJECxhE7M0qFLwzVBM4vaGsCC0VXDRKJod+DXgfMN75B2cQq9tHrCt0MwS11DKKBm0D9Ec+fBRlev0RYqsF9+ueI2cGf1q4FxoZra2fAJy1v4xzV5YerCsL13T5VTMZ7NZAj5KplpKxunK2RYt0o0Z3f0QEOGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=IUEZVgSlU6ipLvtsJbfJJuS0ZD/v4r9sG9+fGeFImyPrAFBfBmGr22K9sigSJCQ5hxIBS0sU4XbM4Dg0wkpTTx1sUGj7M1O/F+HjtyyFCNb3SRYUg8MJPFCjL3tfcoeCHyEhzqek8WH7dpSuSzVhybNNTBacKILt6AHUiQn+Rri3Qx0fsx9HKxTRzOmq38bZ2KZfsOLCmj0LtJt5sTk8MrO/3SHHit0MSYHiI7D25u1iCdDyw4cXy1we7L8qZTp7UmZ8mbg5qljz76iDTkNRtbHw6KgO+SqvExOdXDy/HyumROR0dm0trXtLdydJUMV2ugDTzKwm7qBu4ySNOUwGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=r6MWsw1OYGv8Q018LZOAacwMVRfUp/hjAGQRAqzLC1W2SXvCj3p08zATHO6MwGeVAoyZbRWT3j/zjXy6R1vipBLBd99X0EHFFkj8K7uzXH8CbABF+w3VGz6TIrUp1ZxGRNIvF2gvpE9IFW+ujxMXq3Xy6sAsufWsF0Cz34wOLLmFanNm55br3zT4hbvYzm/GoyVAadesW9xxIYb/ozCSOuc96vZmEAIqhF1uBoCbo0XkV2yEImVNS+yF1D68m6sI6r6nDwRKjYs78XXIqpCNfDlP9Ufxmx7r0alpjfJLnbRNaGHLPLBfgQvA/pFwMw1a9xp/1wadwjIvHPUD+lsBgQ==
Received: from DUZP191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::27)
 by VI1PR07MB6640.eurprd07.prod.outlook.com (2603:10a6:800:18b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 14:21:05 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::c0) by DUZP191CA0010.outlook.office365.com
 (2603:10a6:10:4f9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Fri,
 18 Jul 2025 14:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:21:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 4D3612003B;
	Fri, 18 Jul 2025 17:21:03 +0300 (EEST)
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
Subject: [PATCH v13 net-next 09/14] tcp: sack option handling improvements
Date: Fri, 18 Jul 2025 16:20:27 +0200
Message-Id: <20250718142032.10725-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|VI1PR07MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: a022cc39-aa69-4b75-b14e-08ddc60654af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUtFQTVla3VXOWJXVmJnZ0xreFVpK1NGby9xU1FXY1p3UFFQNzA5UDNFczVm?=
 =?utf-8?B?Nk42S0NSWjJteTlTd2Q1OGl4YWZXbmROSUs4bXNZNUxPTW1HZHViTVRNQ24w?=
 =?utf-8?B?RjlVZkRUM0xyKy9rVG1VbEVtZDduOWtDNFhZU3NLcThld0NBT3p1L2U0WkV0?=
 =?utf-8?B?SC9GNlNsNlNEbEhlcEhUZjhrblNBSG5RYXQ0M3NRZjY5dzlMWUVWeWhRTzBS?=
 =?utf-8?B?TUdTR1BxUUUvZURRdzhWeklnNTlmdkZlV1dFVE53UFhrMW16YWtPekVFWVN4?=
 =?utf-8?B?eE55Y3JhY1JxSG5YR0M3UVBrZ3haWG5iWUh1cmtCNmtYSTNhUExJalU4U0dt?=
 =?utf-8?B?Y1ZyQWx1YWlyWlpualNQSXFqMzk0cFdyY3FHVFRRR0NxN1owb3FXaGNYQW9C?=
 =?utf-8?B?RUJ6NFdEa05HWkorODQySjEwUFJMWFB5R2dNQzZHY1Z4d3M0QzRVUkxvZG1V?=
 =?utf-8?B?cCtveGtoWUZtTzZsZHNjZkFEc1JzQS9FMHhhbFc1d3JiekxhNG42cU5WMEZF?=
 =?utf-8?B?TlhMTGVIQzUveW1EaHBDaldrR1ZKanhnMGx0NHNzRU5yNzdwZk1DVnM4RDhy?=
 =?utf-8?B?QmFVNWpPckZ3T05YdEw5WjJ0Skx3MjhBaEJneUZhOUxEZnQ5NEludWZPSUpr?=
 =?utf-8?B?cWNLenBsZGc5Y2Q5cVpVYW1VanBkSDRxenNab0JSS1hTZmtncEI1aXlMSE9n?=
 =?utf-8?B?K1d1MDVWdGoxNkZCNkF6akZWYUNiWVhQOUM5clJUMnYyd2pWMHBic21aWDZN?=
 =?utf-8?B?ZG8xUzQvdENkSHhVcUJ5M1UrelRlbHRDT01EakVqQUozTkJyTUpTUVJ6Rkhv?=
 =?utf-8?B?VklvbDNMRUwyQUxudGlrend5RTVoSExDRVYyS0w4NnU2OGVqMTBMYUE0U0Ji?=
 =?utf-8?B?Ri84aEtubVBkdFpZS2R5NHF6RXRqeWVnS2FZODJvUExTZXovU2lDSWhENUFr?=
 =?utf-8?B?dHROTEpMeDVPdE1WQ1ovMzh5Rmo4K2xLazhueE5WWHAxSXNOVmtmSm1XZjRK?=
 =?utf-8?B?a2E5N2dRT1RkRVI3bWd4anZZdXEvVmROMFZmS3A2NDRZSEU0YXdBRzJNT2x6?=
 =?utf-8?B?emNNajdzd3B4VEMzanIwNVUvaTZjS1BGWVBVZklkYk53VnB3SkQxRG5nRUZ4?=
 =?utf-8?B?RTMwZU11WWxGbEpNZGNtS2NwNUFXd21UZkdLZDk4REFKZjA2bklLRnUvTzZB?=
 =?utf-8?B?eEVMWW5udXovTDdYcUFRWkNXbnk3Ulk4dHRMcSsrSkpQblpWUEszS0EwQmtw?=
 =?utf-8?B?OTczdUdNb0dxWlNGck1qbjRTOHBqUlhUSldSRVU2Y1pLSVlOTTZ5UW42Wndk?=
 =?utf-8?B?U1NuYzVQdEFQQm95TlRRMHk1TTdHRS9Id1RkeEo4NUN6SHYyVHJFRVVKbGg2?=
 =?utf-8?B?ZEttNWg4N0IvcVhlYm54cGNKUTFObU80ajdRSk1qSU5iNmJPQ05NZjIySmtB?=
 =?utf-8?B?ZkhOQnpvMm42dXNsV2JpTGxsZVB3K0pJZWI0SGV5c01VanhmZytycnlRRjlT?=
 =?utf-8?B?bkhZRGdiZlNBVGhqbkhTdVlVME8yTUxMVUsyZ3JDcXZkMzk2czdRaU5obkJR?=
 =?utf-8?B?N0EvTDFrV3pLdkJkTWJoR1RLTEJZRlJydFRSVG5EMkJPY1RYK3Fwb0NVb1hm?=
 =?utf-8?B?cWV1Z0Q4d0JDRmhUMUhXKzB4S0ZYbDV5VEpyMk5uYnFLclJkOHFld1d4aXA2?=
 =?utf-8?B?eXg4ajFTWlNVM1JITzRuQmFWbGVSOVNQOEJrZG9DcE0zMTlKL0tzOUJSSTYv?=
 =?utf-8?B?U1VGNHEwbkhVNTZ2MnRnT011WkRsUXJIZjR2K0lxclROaVNOM0RKQlNnQ2J0?=
 =?utf-8?B?elJoWXdCMERhQnBiRUUxZzBhUzFqclRqazZ3TndzbWIrN0hHQWZpTTRtSXBw?=
 =?utf-8?B?TEl2Y1JBc0phY25DYkNGRFFOamFCbHRKOG5GQkZnRWIyT2QwQXRlSjFOM0hD?=
 =?utf-8?B?M1hlRWZ0czNoM0hwV1k1MUVlcW8xM0J6N3lweW1XTmpVYU1qZGF2SzR2Q2gv?=
 =?utf-8?B?M1FtWjFDMzYrcWdtcWI0Q3daV1dmVUZiUjBNZmdMdUNSN1FOMnJsNldJQU9p?=
 =?utf-8?B?ODBUUk9yQkVoMUw5a0tpLzd3Z0tvSnpDMlV2dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:21:04.8574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a022cc39-aa69-4b75-b14e-08ddc60654af
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6640

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
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v8:
- Set opts->num_sack_blocks=0 to avoid potential undefined value
---
 net/ipv4/tcp_output.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index debcb1d431e6..d98a1a17eb52 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -985,17 +985,20 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
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
+		} else {
+			opts->num_sack_blocks = 0;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


