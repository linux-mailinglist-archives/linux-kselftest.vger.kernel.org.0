Return-Path: <linux-kselftest+bounces-37822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068CFB0D6B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88D8562338
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8712E542A;
	Tue, 22 Jul 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ORTHqbm/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F38D2E49BA;
	Tue, 22 Jul 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178397; cv=fail; b=RndUc9AbgYqo/QVA/JBi6jvyIsY3h/Tyan6a+i5wB6wN8BTdmpkoFsU7om502/FomH/vp96GPmyneTKWuv8W2WlZ09BW4gMuqSt8DAlgZxj0FTgq73RLZeqqjkoau6E9TQ0oU+MVpUmxDxnW/eeK6grZG5ExVuLcIA83ewZzMU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178397; c=relaxed/simple;
	bh=bK4Xx+l1sBybj9q09xns660ule0tkgq5RmKraqLaarI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVnSDT5E92TJAVzPl8AvXzJ/lQRr/AbspSw1+0i5pCwwK9BUNafPMIowTKmh8W2MHcO3vmaqTAtY+wgkUCX2Jxl0RlY32JiK9W5rMSnOBTBzmAsu6qTUlVufAzjKbb05EML/bQt1qszRQvtUoOW3UjKMXJzt1gqZL1/sVdwfzag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ORTHqbm/; arc=fail smtp.client-ip=40.107.130.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYHeEVbRGmWyHGUrLdkPa+XLr2x/a3mcXN7nQ7btSEoOEe/2SyVYQVX+uNhruveOWgvtoWb0gZvx/2HQvS2wkPdFWUfgjGgeB548AjipiGXtfcDBa8w2yh+I5HdD7ZSGBoj57FZzyUoNZyriC7kmuhYf8NtfkrdyOA0gN1nMgh0X5qTkbPEvuJfUYWiryfWFC4zKamUWmzwrtbb7H07IVvzFKdAJDU0egsOwQaghmFYbAkhIgXp7HEXJS1Kkx/mWGKrBIAJu+0fPnones+QJ9bWN4RM9uphHmSGmdtiruNOQ0eUzq+vtNxj5q665EaasVNhF4WGBmWtrACE8vHe7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=kdluLBkbfUZmjfuF4JxaEMmZHAlpubtDjXYzR24UXt+2J0c5hEUW+ysPLbWsIlGKKWtT4opjGmBLCdqQoDC5l3bUYmRAJXkhuAIoCtWZXf76bpxi1Qbr2t/EE0qVULSm3drUIR3jwiKUuJGxUhc5v4U/pSJrNdNOypDsJxYvOdpYIKEzx+Yj/WBcbyIIqZSsvZh91aKwSgibKmvU3S20wVTR8mEB5GGZIflbcqcrv1UlRP3wlmbpaSslm2UcKZMY2E+fjcrwYhNeuvxRf55+KCgecqYPVBWgFGNmARGHV+4jIBzMwrfRK11iPnRrIXLvEazbj/41Tmrh0L5CJ2BLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=ORTHqbm/X90A3SuqhJTkaxUzqRq+Wr8f02AX4uE8aD6Dm1QqZ0dh7mZxZYOcFRFT7OWbZu6E4sNKFyoOtuuLOA9yOZXE3Mfd0T542jY9VNIOccfQCyiX4kTolF5O3nhX6SVlm1ofyyVw4KF0ZZg0ADezlOM7s3naREcyFH7zx8+cq6dB6Ibva/Pe9V8jBui4gSMdH++u5uH44VT49xi6MRBZkib6cfATmcgfZvRWZGsJtnD6odg4e9uSjprLPwhXuCQ1B+T3CQXcA021v3sl44qVk19xOsp4xqvGJxZWanNfRG+sbhyuemNir2V9R679nCY6kfNxvBGc34BEuKES2w==
Received: from DU7P189CA0011.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::25)
 by DB9PR07MB9007.eurprd07.prod.outlook.com (2603:10a6:10:3dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:59:50 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::bf) by DU7P189CA0011.outlook.office365.com
 (2603:10a6:10:552::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20 via
 Frontend Transport; Tue, 22 Jul 2025 09:59:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 455C668002E;
	Tue, 22 Jul 2025 12:59:49 +0300 (EEST)
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
Subject: [PATCH v14 net-next 09/14] tcp: sack option handling improvements
Date: Tue, 22 Jul 2025 11:59:26 +0200
Message-Id: <20250722095931.24510-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|DB9PR07MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: aca78891-accc-4a59-644b-08ddc9067fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlY0cXBpWlRKc1B4WXVjM3E2SUhzT09FNithUTRTZHA0VXJ3TDhoSE5BU1VM?=
 =?utf-8?B?Q0trS3JmTWVnaWJiOHdFUlBoUFpzaXhQRGhXc3hKT2pkRFI4ZTdBcDI2Qmkz?=
 =?utf-8?B?R1JFYVcrRE9KUlZsL3F0UHNMcytlY3hhdStYZkdZUzZUa1RBYk9zcVk4ekNQ?=
 =?utf-8?B?ZlRtSTlPaUxzTUtQdURsVmc0UGEwM3B1Szh2YXdXcWw2RFpIMitTSmRvbjg5?=
 =?utf-8?B?Y2N6eWtiVlVJSUdRbEEwdnBVcnFDTGVISloxc3VhS1ZLcVpzZUNidTVESW9L?=
 =?utf-8?B?NkN1Wk5CbHcvdVkvby9CYjRrQ3ZNQy9zcE9wMlB4b2ZlN1FOUTdiVkQ5bEFh?=
 =?utf-8?B?VVBHc2NiU0lwOVo1SmRidGpDeUNHUS9qaElsUTVkRmw1aDFJM1JJVWxMYWZx?=
 =?utf-8?B?SnZGWDZrY2tYaHhvVFlGWncvcVhaNFFkN1QwL2ZTaE54Q2dOTDh2dHdrWmVE?=
 =?utf-8?B?U0F2dzdadEZ4ejdaUmMyOEdpU1ArUmFqSUhHN2o3R3ozWlVEQXJsZE40ak5n?=
 =?utf-8?B?RFdVOEpSOHZoaWZoUmlvYkl2R2pBT2x2Wk5DNzh2REZiMElkUzlHUDdQaDBp?=
 =?utf-8?B?NzVaUXpBQkxEbDV0aHlsU28vQkRKOGlwbXJldkZnL09QbTZ6ODRHZVNLUzRP?=
 =?utf-8?B?SklDOHBSQTRZRnlPbG9tbW1taHJvdlFGYnN2YnBvN0drRWZQYjFQNTM3WWd2?=
 =?utf-8?B?djlUZ1RLcHZwcUFIWU1rWXhGdWZFTCsxR2pUU0FoTEhnZ3hoYXpoMDlhZjNO?=
 =?utf-8?B?QTl4WitaUlYyQmlNS2tLaHppQWlQYURUekRCRmhrakdnNWNyT3ZsRjBnQi9s?=
 =?utf-8?B?am9jWktQN2NzWjBEcDJQNXZrWlRRYWt3eCtRMVRIeDdCZWgwSHlZdnk2SE5Z?=
 =?utf-8?B?WXFzQjFGdDZlT3Z1b2w2TW51YWF2TVUvNFpsbG41L0hDdUhmSG1UZFJjZjAr?=
 =?utf-8?B?cGx4dkMrQUZRdDJXeXV4SzhDdXpucUl1WFhQMnJ5L0FxR3c1SmcxeXhzZith?=
 =?utf-8?B?Rm5sSitQWmFmV1lnVEt5b1JyU1N2a2J3QWV4dXJsN3dYSVNFdFI2SWpaaWRn?=
 =?utf-8?B?TEhnbEgyWVNIQ0VIV3lqQlJJVVE4bXpmUUFKQ2hsM0FxUGVlZEhTdi9YakM4?=
 =?utf-8?B?c2RLYUhhWnlGc2Y2V1VLQ0NUSVdNYjYrZDJWcHkrdVYzK3VTdUE3QUIzbnpN?=
 =?utf-8?B?bE8wMTBCUUR4eUhvWVB3cTlkL1BFR1NSZlBweU4rWVE3L29TMC9oQkpQQkg0?=
 =?utf-8?B?ekk2K2xhVGNSL2EzZzdMa3FmbG9RZjNHMDZXVE1PVUJjUkJjMEtaVjBqWWNQ?=
 =?utf-8?B?N29ucFIzMU91cXBnTEZ2OExGOFE3L056SWNOMXg1L0ZuVUF3NHlTOE0rTWdo?=
 =?utf-8?B?UnkwbGYvMlgxYXhwckhFSndQYm8zWXdJeEtYbGY2QUJaMWtpZ2hVOXR4d1Jn?=
 =?utf-8?B?ZzZaeGhRcU9PUW1uUDJUZ08rLzZ5dm1uQXBYMlZudm4zTUFqS1VCVDRROE1C?=
 =?utf-8?B?QWd5dVUrenFuVmdrTi9EL0ZFdElPdVIrYVMvT2VUOStjeUpEai9ob2d5MDhj?=
 =?utf-8?B?dzAySUdUT1Z2aUJuamRSS3BocXhRNzFNZUh0MlNQaE5zZ0hzS0wzSFhQYS9u?=
 =?utf-8?B?S3h0TXNEdmJJemdrT3dwQk5ZT2FSUWxnTVlYRmNtU0NSMlkzTEhxRjRNRXBa?=
 =?utf-8?B?eFdkN001T3lRS1R3LzkwZEYzUjFPZ0FnNktFMWRNR04xWTBFT09Cc3ZaS1FR?=
 =?utf-8?B?N3lCa05wa1UyVER2MlBTUHlhVHN1TnkycEs2amlzc3dnNWQ2YkVibG5mc3ps?=
 =?utf-8?B?ajlNbFZObi82SWRUdlJZcmMyOWVKWWlkc3d4VXQ0UFF2SGV4OFdVRnZwQXZk?=
 =?utf-8?B?c2Eyc0hNenpnaG5mdHB5TWVhK0EwQjJiS1R1aXZQdXkzUWFkQjNpK1g3eUdX?=
 =?utf-8?B?QWdxUmVjaUI3YW1VMkgrRjY1UWJQb0ZrUWhiaWpsL0VKRU1YN3hXRk42ODQv?=
 =?utf-8?B?c1hLcUFmSnExbmg4Um1zdzRlQUdZVG1LbXVqbzNWR2s4ZHJkbUg5Ymg5ZlBH?=
 =?utf-8?B?VmhEblJKR0RmUU05MXFwNnNYZENyNXFMMm81UT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:50.8249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca78891-accc-4a59-644b-08ddc9067fe6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9007

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


