Return-Path: <linux-kselftest+bounces-36383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D96AF6992
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535A54A74E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C0B29992A;
	Thu,  3 Jul 2025 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="C0/F0RAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E7298CA1;
	Thu,  3 Jul 2025 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519935; cv=fail; b=XRF1kM3VgCc3MEEaivxmcrwPbei5QVLgmnPbG/pBFEuuE8+6D5pJERsykbSU9iaaAuBYBumxBsaIv1/L7mF2G7pGhg9N6QjY9Cjy+LjakUXsExNOWP3fXzKnVty6sECEMplP2ebJze2PS9Gu87sNAZgxf41J0Yk1AC5um6KxFiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519935; c=relaxed/simple;
	bh=bK4Xx+l1sBybj9q09xns660ule0tkgq5RmKraqLaarI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7Suc+/azNRHOTAy8qQI58Y9gSff9PsQSWfvbT8ks20Wbz78d7jGSd++YVknLaPQM0lNZpAkqmwpGrHq1TTjrcfGbSznV1vDI4daafZrnTpneTia9FDqOcBQ2v/Wi2Cni0bQhHSj3bIA0dgkZIQ6vW8Q0PS/DOsbCGQTSrTCYRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=C0/F0RAq; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAWbD4FvndNaPAlClHCuUANKPTkknzFMe5I/Mr5qn/Q3uExGQ0GBFQ5coD3PiIKOl+xavds95x6OtKI5JfN95mINgYP9YrrNwYmGzEzkhZLzopxareWVurqhxbnbC7GWg4oquDlysn5psKpTR00I95foN1snXHbOFgl3mCgMkroMwOo6hGDHSVyiTDDM+ci0qxWT1g1ip9BtEv4LfGtZaErAkzIG6NnH3HxdcTF9rCGRm2/8oKY/oDctHN2jwYNXwJzZMPgqQ4fVEAxBXYh9ptuNyzvaElmSxSFHrYcgoTZZJfalBBKklpKZ7QdDrhRWTSpcf7cAjFMNP5HbgBNcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=OIy1ZxJAAUnMa8Y6PCUHTTomdclTXLqaxjX5pAMQPqnaSFd10cG6uBxQncltTHJ+nZwbX2Ic37DP+SIRTMOokCpP/kGdF783xAg8TCpPC20jRTY9O220aUa5yNXbVxc4bazSL5FY3Klee2gf0/4W123RgThNLkwwjP9BMMJFQGezZnBh9pPKtjfP7wl07p4MduzO8GTRVeVUb+GgMsxgvBoagzeKAbWsr4Ol3uasHz0Q+QorjHYNsEpSdRQeBSVCzUHxLTzZ0xSjyl8IvsjTX3I5Q+qFSFBAAOQOjzNsBv15T+A0HWZo36aEJ0GgAWgRhHJaEyU4phfqRfJXUS/0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=C0/F0RAqz1gkqE1sucbMHO6LYyRJChisllfEux+huRfX2ZJeg4gZ+Dy+xgnVvfh9JOVNBcvnM/A4PtaMR52bZuJXtiojkQR+xz+qpP/UovKVLq4nDDMmXwqwPUo60p7SYLUkogGSb/aMZ3u2n9KbgBEUuUiXDHb2/oPL7zVpixrJre7BYNv0uXo9msARztZPc3Vi7Kx3owQLU98+CrOOr6oBqWEG7PoWlVKtO1X1GfqZkGKEkAEAdNVcvxnERFKrwiou4FsIbGRGhCR/5JTfFINu+9cCCJC7/iAe1Ee8nKTL6+cOK9qUYO8XqrXZ/ejtSeHOkAJMyYCW1Y4DKEZgtw==
Received: from DB8PR06CA0011.eurprd06.prod.outlook.com (2603:10a6:10:100::24)
 by VI1PR0701MB6912.eurprd07.prod.outlook.com (2603:10a6:800:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 05:18:49 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:100:cafe::e3) by DB8PR06CA0011.outlook.office365.com
 (2603:10a6:10:100::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 05:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Thu, 3 Jul 2025 05:18:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id C9B6E200BD;
	Thu,  3 Jul 2025 08:18:47 +0300 (EEST)
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
Subject: [PATCH v11 net-next 10/15] tcp: sack option handling improvements
Date: Thu,  3 Jul 2025 07:17:23 +0200
Message-Id: <20250703051728.37431-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|VI1PR0701MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b46948c-49bd-4b31-47d2-08ddb9f117c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHRGTy85dnBGNHhEdGpMejNaOUp3emVqSk1ha2FhVFNSNTFsZCs4cUtQRVl5?=
 =?utf-8?B?RWR3NjVxelBHRDJDN3V6YUVuWElLRzhGVzdHeVNFZWZTa0gxV25nOHc3clJO?=
 =?utf-8?B?KzZPK3VMakF2Mi9nbjVlMkJjZFE4L3cxYmkzcTkxa1NIWEs2ajBqN0xNdkkw?=
 =?utf-8?B?TTlUSjBaVlJpYkJvT21wZUdTQ3haSE95YjJBTUd4K3ZweWtlaVJmdFNERys3?=
 =?utf-8?B?ZE5waDZUSXdaT2NHVW5oYWx4Yk1PT0d1eXZBUHNUeElMYjU3NWE3d0J4SWV3?=
 =?utf-8?B?Qy94U1hHek0xelJwSnRlRkljTDJFOUpyamt0YkVFdzZwZlhlU1RoWk9yUnlE?=
 =?utf-8?B?ZDVEdjMyZTBiUnhocVY2RUlRZVNpRERDQWxjZGpYVWZZV3NMemcrbVJSMXEr?=
 =?utf-8?B?QlFPQ2xhZ2plNC9MWFJ6YThxOUZoUUgvUWY0V1I3dDdObmtvT0tHQ0xWVGdj?=
 =?utf-8?B?QmxLNTQ2R3RMMDI1RWUzOGRtcStxNFM2ZUVmaUV5Z25uUmlaS1htSFU3b0xJ?=
 =?utf-8?B?SW1BSUZkenVoTC9iTHg1cTd1QmxqVUt0S0J1ejN3bFh2NlZvN2Q4OExBTW14?=
 =?utf-8?B?NHgwQTZPM2xMM1NWWllxcm5aWUl2dzdRdHNDUnhJYUdsb0RwZGtGL2tORmdV?=
 =?utf-8?B?SUtRdWdjMmhZODF1dXZWWk40d1FveEx4bUJmU3RrOHlUZUcwS09YUGVGOEdi?=
 =?utf-8?B?TWs0QTVHSjhCc0VnaGwrazVUTTUyQVgxT0VMWGEvUkxlaHBWWmcvRDdTSnph?=
 =?utf-8?B?Y3F4aGE1VkhqWjhqVW5QU0htcFl6RVhwZG5UaTZvQmRlTmtJS0s1VHkrcXJ3?=
 =?utf-8?B?N1pOeC9ST1dzUktTQlFKdHpjYTd3cVdxeWhrNXBKSEV5MmRyMnU4Uk4yOUhN?=
 =?utf-8?B?bXZlM0lRN1E4d3o1ZnovOHdiMzV3dWJnQUpIdVJJQm1SbGtHcVpCN050Yjh3?=
 =?utf-8?B?U1NIRDd3Z3lZVXhJVTM1RjZCSzc4OWc0eWcveXFRdnRmT3VYWnZ1VmhaOFkv?=
 =?utf-8?B?MFN6bkJUZ0lwYmFrZXdCUE5XSGhmcmlNUmdESTdVUmRrM3ZTeDIxTHVLZEZ0?=
 =?utf-8?B?TVl0UVJneHRpaExEQlRZcTZPeUpMZ2d6Q2E0RnJNc0IwazByazlaQXNTdC9o?=
 =?utf-8?B?VVpFYm9OU3gxb0taenFreURTZTAwSk54YzNrT0h0djRkZWNtMHZQNlFnS1hx?=
 =?utf-8?B?TEIvRC9QZktDc3JzZmE0RUV2Q0xPVGZzLzRoUERhN1lRWnlITmx2ZSt4bWRM?=
 =?utf-8?B?SUhXL21oZTVVdzRVZE9OS1pDZ2JjTWtBalhKNDJDT2JZREpydUhPalBRVDl5?=
 =?utf-8?B?Q0pxVmdhMVJaK2xHcDdRa2FULzhiNTVEZkczK1hqMVpTbG8ySGUrNzk2S3JX?=
 =?utf-8?B?dElLU3czK09LUERSWGVNNEJJZXArVHZ4NWhUZ3FlMlUxQ1p4SUpPMzFZRmdI?=
 =?utf-8?B?SmpmcjM3MnpmOXU5UkhjRmRESEs0NmNmdFhwUTFzY05Tb1BQME5FRE9XZnY0?=
 =?utf-8?B?Q25aSjY1T3RMbmJBV1RqanJkWDhZMWlLdVRaU0l5d2tGcnNybFJLZE5RUGRJ?=
 =?utf-8?B?eDVzT3BqMzNuaGJPdmloYVJxOC9ST1ZPWjN1dk16cXF2S0pMK0dpZElPSCs0?=
 =?utf-8?B?NWU0ZSsrbzkzU2J4dlF5RnZBeGRDYnVMUWx5b2dUdWYzc1NTbUYvaHF1a2pq?=
 =?utf-8?B?bXlsYkF2eXJQTzFUMi84NnBsaUFOL01VZDBWOEg3dFJjNjhxUWM0YU9jY0R5?=
 =?utf-8?B?WXNSeXplQjRlUVdwRHM4Umx6UjIycjNQR1JFeWRHeWo2ZGhEdmNwRmh1ME1P?=
 =?utf-8?B?L3VMKzgyaFNmekN2ZnlNSHBkcUIwNFRWeGtyT1pLUDBDeitDaEIzQ1B4cFJS?=
 =?utf-8?B?SFdIYWIxaWZiQmtNbTFyNUs5eHFydDI2bExZZWI5WDZRNlhEeGJzVzYvdEx2?=
 =?utf-8?B?ZkhzY1BQZXJkeGRGMGZibk9vZjZZNVYxS0xnZE9LcTVKeHlqWmhOMTRydnhY?=
 =?utf-8?B?eDI2Z0hLNWhtSU5XcWp4bnN4emEwMmpNTUk0ZTNQMGFpMWtoaWdnN24rc0pj?=
 =?utf-8?B?c0hVVnJic0FRTFAvUXNzZXkyeVJpaVlmSFJpdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:49.2803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b46948c-49bd-4b31-47d2-08ddb9f117c6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6912

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


