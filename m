Return-Path: <linux-kselftest+bounces-41236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B15B52F85
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1856A7B59D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA431A562;
	Thu, 11 Sep 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ne/zNsJ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE414314B66;
	Thu, 11 Sep 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588827; cv=fail; b=PAoXjw4hHZWgBnFecNuYCfSdV1mvGA2sSGz+gn6Bcr3hC1s16YwFrLzCSK0y7EHhAf/zob6NjqtFbLLLL2dThwUcUg4T9uoxl/iEd7AuuoaL9sYaJaXFdzfpbvVyeVR2le1Tw4Wtg6wgXXpRFbmF8HQ9gCtENt1hTCjGdNJvUAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588827; c=relaxed/simple;
	bh=C/dhWSWt+O3PZtD/17zVGFH5w/aYQMeOKKd7dgXZz4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCegxEDNlW/Zj0oKzWOrXtJ63HlXTPYJqQxQoeI6s1qtvQD9B2ZMQ/G1riwvfJUucugp7WTC8ZWRzCPeSD6QkCKmNoi2NUgabwi25UlfGRrCiA8kJZxiOXuBtc1mpro8RF09yHer81t6/2FZpfHpoZeCkAm2jT4ciXTuO5zUViI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ne/zNsJ+; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr8QI9o6a9YmzcneEvZGeCXx7Fs8zByfGvLd4SS6hqRSg1M0WhSOjBa7ouEp+flTsVmY4nuyjyyr0ISm6XCrGFguVH1AjOQYic3ItZHyLOxCoTBpr611G142WwWsRjuWWx/I7GNx7QRgiBJqEMkxHAcfJ+QvrvyNrskMAe0Qls1s9q3uUuu1nATKGPhnnhRSUFvpK9xtH0Zy7rjdijKdrf8i+I8xmWI8SYt/VrF2jyDMIXbPluZSksbf5vjz6kElWRsILXbsqw1LLlOiIOZkA5pNoyrkE41K3C9OTsnSvn+wQaT+5heIzMXu1kwvmpRlbzX4hjpe57rKM/RoA/WEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta9CTQXzfsJln+e8CsRqChrLbcfgUPSfklUNiwzkFSU=;
 b=FQZZY6+reuo6Hbe/S+35yV6uF1H1E47ti6GZ9NXxU8V53lEex2YVk+kzsGljcLRXaR5LakWSc9Y8hAmZ2nsY+KUmcs3U0/Ku5wh03yWyK/OM2awmwMp6+Rc1exP5ZJMGdSryJXKLla1Q9NP5j9osSZ//6pLcsWUHHl5Vchxwtw5vnF58KgvHgiDLNAvfUtD3vzJe+p2FUVlC/YoKcO6pk8gb3mAjx5kPahvT23A2tEXBfIWvCp7YIBwCc2rfmCiObbLBz9eRyoybuhqn/5L0cjzhlhDxxsUTdu5T28OftoYMxeNWDyZCkdYy/HHolpTOQE40cabvmc7gU+OPUMGamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta9CTQXzfsJln+e8CsRqChrLbcfgUPSfklUNiwzkFSU=;
 b=ne/zNsJ+LgzZbXpBARLgDsI+5DFXNd3PojKeXIwYFYOx6nGch7HOWn+4/FA/GUwrd8nzQo81uwrQmu5Mrgf6tUvHP69HD4w0oDBozx8y9m22xi17g5gI0kyJnjknVU53ltkYuyykj44j/bjbFHQKiR3ME4UDrwYJ72oNrp8bVmTeMZzrXpJIP8gF2AlLjoULlnGNkp4nFmwaS8obLrILfYKpaB238t8qkxvmqlr3fKah/9roVBnJkN/mHX4JVszhl9O04T8DAwI73QLyeTO1Td3lYY7GvKG2/h9NrY0hVKfFjuwZGCDyfX6njAEF+qk6RF56Q16NHriKIpldpW7MTg==
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by AM9PR07MB7234.eurprd07.prod.outlook.com
 (2603:10a6:20b:2c7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:07:02 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::4d) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 11:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 11:07:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 0F05C202AA;
	Thu, 11 Sep 2025 14:07:01 +0300 (EEST)
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
Subject: [PATCH v18 net-next 09/14] tcp: sack option handling improvements
Date: Thu, 11 Sep 2025 13:06:37 +0200
Message-Id: <20250911110642.87529-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|AM9PR07MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: fb01f754-f4b9-4ae6-7ad6-08ddf123562a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEw3RlFOWStKVE5zTjJOSms3Nnd3TWtnWS85NXQxRVhneVpwOUFxdzlQVG80?=
 =?utf-8?B?ajQ4VndjK0ZTMFVyRlFNK1ZNZSs4eXpKTHpCMTVoY0YydU9QbFJpazRuN0h6?=
 =?utf-8?B?OEZ6RDI2RTUwQUN1Z0orY0tmTmExUUcwajJRa3BQRzZjSUZ1Y3l2SHFWRFZI?=
 =?utf-8?B?aVhXUi8zR0tHTTNXVmw2bDRhczR6eVJOdGp5N3hJbGVUekYvc1lqdjZPTVJs?=
 =?utf-8?B?RkZ3ZWVyTjMzSkl4NGZkS2Z0RmRPa0VlWVllWTJRMWFKVXNPMTIydko5WDhw?=
 =?utf-8?B?V21OSytVSmkvdW8zVktzeTBkbEV6QStNdG5TZFdGNUJKaTVVakJzTm5YSnpO?=
 =?utf-8?B?SXk4QndSUGFIaGZETkxZV1VMT2VjM3FmQ3ZHUWxCQytjRkQ1clhUSXFGTE55?=
 =?utf-8?B?OXE1UkRKeDBqNzNKM1N0RHo4UnpsM3YyY21HR0VsN3NjUXhSQVNLODVZNlRU?=
 =?utf-8?B?Z2x5YWRiWEpzTVRHaWN3RFBSbHFLblJBVWNvZmJxRkRxRmIvc2UxbkJoTjc4?=
 =?utf-8?B?V2NYUTNZUE1rbENrSVFWV2dWbEhXbWM1RjdjT283bE52R2htYzNyeE9lWm1S?=
 =?utf-8?B?NjBFT0EwMDhSZmxqN2I5YjNjS0FlN2Y3bTk3ZksxcHpZTVNONGdLQWR1dG5m?=
 =?utf-8?B?TTdyZ2NjRDJCS1I4ckhudHpTMTllMjEwWGFGN082M2pPWHl0L0kzWG9Gd3V3?=
 =?utf-8?B?Mm5KNEFBZ0Z1bUhHQTROK2Y3R05RQnFmU1pPcUppU0ljb2pqaWYyNlNoVzJu?=
 =?utf-8?B?Zm5TUEVyM0pWNm9FM0NPZmpFY1lPbTFsbmU0Zm1ZcUVVWDE4VTZCL3hTRmRB?=
 =?utf-8?B?OHgxUWFtN01lZnVCQUtkQlh5WFNjOUZzMzZSZnVjeCtJSXc0SVpvOTRXVXFo?=
 =?utf-8?B?SUZyZk05bC9XalFZY25jMGZyS083aTNTR0FkTlZiR0xqVjdNTjB0NTVNeTZ1?=
 =?utf-8?B?c0IxMEFHYlhwQTVoT2loeE8zdmRRQnMzc3lWREFIT25CZ2IzcmFBZzR1aWxs?=
 =?utf-8?B?V0F5ZDNVS012UVV1U1NNL2U0RHpkTVhSZGRsV0I1ZUhCVzZ4VWFvR2pqb1k5?=
 =?utf-8?B?dUg0MTlWOVJnZDNHdG4wbHg2Rkw1Y294Q2VNaTBnTU42cUNRMUZLOHV6Z2xj?=
 =?utf-8?B?amxVWnlNdkg4bm0rMXorMXM5MExWb0JRUERTSTdFZU95aXJMYS9aSUQveGFL?=
 =?utf-8?B?bFFGM3g4R2tPTG0zWnlhNTVNMEE0T2FoRGdjNjBkRFhnY2dSSncxR1NwRUZ1?=
 =?utf-8?B?bnRnQUtKNWF0TVNwRHNlMTFUL3MyM1lYcWxIWEg0WU1XUXNuU3FvSXNsMGE5?=
 =?utf-8?B?aWpJVkVzT0JXalQzT3RGN0wwWHZzNUFJNlk5a2UvL1RiVnFWYUFoUFluY3hp?=
 =?utf-8?B?QTBzejlhc0tSdUp0dExWNEZJR0ZmakFPcmhkSkpkL05RNkFxQUdMYW1kb2RG?=
 =?utf-8?B?eFlUeWFlTUE4ZTJOckRCb1ZTYU11VFVrOW5JSjY3TndidDhGY1RnVzJkaFE3?=
 =?utf-8?B?YTNDV2ZaREwweERBSHlWeG0rd0pBQTF5Zzh6dHhBTWJjT1llN1ZjWHNwMS9V?=
 =?utf-8?B?NGZXaGREdks2d3dmeEpzaDhWK01leGlVZGNEYll2cGt6M3dqWTlCTmRVdzZ3?=
 =?utf-8?B?K0RmM1c3Rno5QzAzcDMybUVxanJ0RGVZUVB0c01ZZXFldFV5Nm13L3BCRmhp?=
 =?utf-8?B?cVNEVC91RWRQTjdPRE8yU044amF3cStBL09GcW9UYVo5VHVHTnp0QXJPSTlN?=
 =?utf-8?B?UkROWVNJVGN6TmMxcW9FOVFHTFJ1Z2RBREJjRGZqWmI3Ym1SSjZnblFUOFBE?=
 =?utf-8?B?TktKbTNTNnVHYmlWTmU1ZVdCZm42UHE0bHRFYjdmK3d0MzJEd0xvVGo0aUtq?=
 =?utf-8?B?OWxNSExxYmI4eStrZmNQaFJpTncrNVNEUHVocC9PVnFna1hvQ2RHSmk4YUdt?=
 =?utf-8?B?aXoxcU9ZQ0t6Ymw2SHZlcUR1MG5pWjJhZVBGbDc4dWFPeXNmNUI4a0YvaWJG?=
 =?utf-8?B?N204Zm94dUsrb3BsLzM0am0yQnd3OXNqMEFzS1NWMFVXK2tqUVVlY3pkaVhi?=
 =?utf-8?B?V0hsQXdPSGhnTzBXVm9PQnlCWjMzZnlUNFhHQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:07:02.4959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb01f754-f4b9-4ae6-7ad6-08ddf123562a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7234

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
index deb9b085a8a2..5be2b3eb73d3 100644
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


