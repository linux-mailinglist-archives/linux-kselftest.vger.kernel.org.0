Return-Path: <linux-kselftest+bounces-31093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C2A92D95
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26FF1892AC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A092222A9;
	Thu, 17 Apr 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RGwwTe+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CE221F2F;
	Thu, 17 Apr 2025 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930872; cv=fail; b=j/WbXIJkdtMA4ym2ox/ZLyDIGi8MDnDpuxgvPehMGYz9pYpQJiZs9nYtGQzyFpMF1mcvBfvibi/h6CDJI0/A31rGv9utM7Fd75Y8RyB9bYB+MIut0udWR91KP1ii/VDUmA/EuX8p6tLagD++8ZAbPko31OahrPj/2TYLXcs/7uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930872; c=relaxed/simple;
	bh=+ezEZy8hckPaea1lF4ilsBt0GsZjvoaMn1f9l0j0RCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXbU4Lr9s/bfvLFlKvV5kuPaEV9FQSy5AeD7gkG1jUI3OiYq82Vi3lZ6+a55nhKRYL2cXgVGytU+whpII35x7M+dyNCpgg2Na3lXR3vSVOSkbK1UdbXcNr8iB8e9fL3NCpJgGw6w+UIxP0lCuV2exebL05mL4+G83tczCaE+rWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RGwwTe+A; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoyTECsrdB1+cMztxq+mduo6tkQaLfsK1gfy7ZulxzlwA45Xt5uNkaPfg/g6TfOmeqD7L/PAAzyXhbkX5QQve+shoL7e4Aq1+RQXVRiPmp3EMR012qC2bw04VRMJxUEmG4Iie8lF1jjZh4XqLQjfDoRzoyQwuVCclraqNcM9QxJkrRo06pYpquKGre3BhdZiyz2whwvSd0I9vwcNZXYZG09b0nDy4z+Q2e5qYOZyAHZlDC/6urna5JD+uC4eCiT/7oV7tWPa+XZwVY+8yCtMWu4kx6J75iulrae+VXFm5VW0ZzgiuTH/VmQqqn5Db0/hXJAgg1UtHElr43ERcPmdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix+QtM7JJKtuEJJnzOOAErViBOEsmOlScq7uOdppACk=;
 b=E8XvbHD10Kynxt+0M0VFdgJzy6GEyeGWKg49by6OYR9FhWA2Z3Fz7uPP8htJUrSz8YmnmWIhKI552H5ltDWAQy069RgZc4c2rL96Mc2ZTdPOSeW3PPabM3YajEOvnNOAqLDbnlKIeOIH0bwiRjh6lupYwmrJShAadnMKWvHitN2ANaoFDwYvxBtlf1+wYFYtgKyf8cNDaOQO+qrK5QRdP++E/KZOzZKdsTJpaFegZ56X8/NCkLkP1bFYVqhBBiQTOgiqWYdYCve2tV4Mzfa42Ol1iTBICmF4U8rPyd4oFqDgErI99wNZ2NJ0NlGZtUk92Zdz7lajRHXaDEJv4rTgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.29) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix+QtM7JJKtuEJJnzOOAErViBOEsmOlScq7uOdppACk=;
 b=RGwwTe+Ag5GPySeZguiIAOMa7oqZHH+tB8zMhjFa4VLOIuJ0xswiMj7VAEWfbAC1ySDOe+F/kpTtUPzK/G8QxToX9v9KGObX7AACrlWHYXg8jP2F3WTEdSC1ojW8K+V6dIWtx23+HGZzvBuZWzbhxQiSXTAozTwCNNjUnTMk8Kzt+7TuRiD1iSmWWOTBRBe7g9+mqjyzWHJsfFW9svAKVWOaoVa1Q6Eeex7Cngv1+nVANMtHTS+7wbQ8VUGTyfyY7uejCojsLc5bxNadb/hEi+bHoHBlZylnwB5AdpI/iD0I5IaLBqNR2ODK7ugAZOVFWO8zhc02iyvR5w9WKwTvWw==
Received: from AM8P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::11)
 by DBAPR07MB6760.eurprd07.prod.outlook.com (2603:10a6:10:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 23:01:07 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::9b) by AM8P191CA0006.outlook.office365.com
 (2603:10a6:20b:21a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 23:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:01:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6877E20868;
	Fri, 18 Apr 2025 02:01:05 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
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
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 08/15] tcp: sack option handling improvements
Date: Fri, 18 Apr 2025 01:00:22 +0200
Message-Id: <20250417230029.21905-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|DBAPR07MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c01de98-317f-424f-8b00-08dd7e03bc80
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cjZzU0N4WEI0YXBxVGhVV2I5V3ZUUWJxTm5UMCtwVGVXdTFuVDdMUHZHVXJS?=
 =?utf-8?B?QTRPSzBzYit2blZjSzF3enFnSm9HSDd3TzNJRHpUcFd0eVI2TTdLeVBnZ0lV?=
 =?utf-8?B?azlGYU1ia29mdDJFUTNDY0JjZ1Y3OXZldVJBa0pieGowQzZYNHR3UldmM05u?=
 =?utf-8?B?d2tQOUtLaGNYd3ZDb3BKcktTa3F3WHQ0d2V2ZmVJQVl3TnFBWU9TRkNTdnZI?=
 =?utf-8?B?bWxRaUVmMzVNNGhiaWlleUUxVXRxRk9PTmxhZEh4SWhjcHAzQWcyVEVjVCsw?=
 =?utf-8?B?LzNYcElwTDBMMkFwZDU1U0FJdTNIMTczMGFEMmVhSGk2a3BJMjh4dTAxQllZ?=
 =?utf-8?B?VnljMitqc3Y1bFRPcENPN0tGNXBIUnRkWEJydlRCQUF5SXFEeEE0ditsVmlk?=
 =?utf-8?B?TEJCWW5TN3A1TldJYkNWNStZeG5QNTZ3MFZFWEFQb0VtM1V2NTZtekN6bG5H?=
 =?utf-8?B?dFBVQjRUbnRvaDVPQzdEWTFlR055V015cWZzQzdCcFdESDhBYld3c2RaUERa?=
 =?utf-8?B?SFVOK0pJMHJHLzlQa2FNUGRmQmIzUlBIaWd2K0w1ZHhxT1V6UnQwb3U2T3ZT?=
 =?utf-8?B?WFJha1VDMFl5TVBxRUFKSXNvRVROckZ0b1JMRVliaU1lOVNaanMyRFdIOHF5?=
 =?utf-8?B?VlVqL21xeGJ6dnVXMHdUNjJFalVvNDZGVnlVWEx6MzkrT0o3QjhUMUdBSVNt?=
 =?utf-8?B?ejRDQllHd3NPOXpOUFNIZ293SUlLNXF6aEZVZmZNbmxrZTlOaitVVThGYno4?=
 =?utf-8?B?NmIyT1o0c1lUZzlBT2NGbUhIQW40TnNqdWUwRjVmTEdsL0N6OUl3akl5eDhS?=
 =?utf-8?B?SSsvakFQOXlCUVJqQWdLNENzSy8wWGk5Y21lUGNySkVGZkhjWUc3di8rSytK?=
 =?utf-8?B?SjdRSysvTW1rVnlFWFBSZWNRQkdjWkh4c1drQUlZVVhXWk94T2d0aVkwa01y?=
 =?utf-8?B?OExNM2V4S2tRQjFCSnRKekFmTURTVlpoY0xvRTRkMjdkWHhJdlJoWEVhakUy?=
 =?utf-8?B?QWthN0dmSUFFRGhmZHB3QnhmaDNpaHZYYnRVMGlZTkc5UUxRMCt6VHhDTDBa?=
 =?utf-8?B?VnlYcGRhcVJ6eWZrSlFhRGVCNnVHOXpJZEV4TTA5djZuek9YaUxrbkM4SW9B?=
 =?utf-8?B?cWlJVGpSRHZOOUdWRG0yZG9KMTR3dENZWENiY1NrbzlkVm12SlJiM1J2MVY2?=
 =?utf-8?B?TTd2M0NKWitTd3NIc0dLWkdZcXZZZUMyVnd3azBhZUlhUlk4Ly9ZSmp3ME1z?=
 =?utf-8?B?VGZ2NzM3Q2liNlczVEpYS3NuSk9PUVJkV2k4SS9yazFXaGFuemhSaldsM1Qv?=
 =?utf-8?B?bm1DVGFYNkhWSDhiSjVQNlBoUUtxTU13T0pJZVFvM21jUjFFa0RoYy90MUFo?=
 =?utf-8?B?VkxUcmIyN3JjMlh0RmpzK05vMTROU2JVRGdTcHpDTFJjMDdoQTRVSllZd0o2?=
 =?utf-8?B?cjRURkZ5TXg0WHErYWlOcXRMaDZuZ1RFV1ZNQ0pTam1FM2RSaUI0RWhYVkdZ?=
 =?utf-8?B?N3dDRm55UloxazdiTkxJWmg3cml5VXIyYmJwL0MvZU8wWjAxbkxLVUc0TWNG?=
 =?utf-8?B?NGZZT2hVVGNmU3J3cVdaVktFazNRTkNtbERJTy9maFZ6bXIyUVJTZEhZcWZl?=
 =?utf-8?B?MDRWWnVULy90ZzJIY1ljQzhweURYZXhCZjg5VG01M2w3N2FKdU1vWFJDOVVV?=
 =?utf-8?B?d1BxN2pmSHVDT1dyM3oxM0J6QlFBZktqeGdVUFIvNS9pa0diTDd4TDFLcHBM?=
 =?utf-8?B?dU1xRmFreFN2YldzcjErSzBiWU56TE9yU0RwU3Y1a1RzMDc0R2FMWEZabndR?=
 =?utf-8?B?VkcvUWRBbUxOczRzWEtzais5b1JKQ3ZnaVlsbWphV0N4cUJucmx4SVh3MkhX?=
 =?utf-8?B?c2RTN0FpcTJoNU82d3p6Z3N0MFRSMlUvUEZIK1R2blRuWCtwM0Q5Wm43eUlS?=
 =?utf-8?B?Yy9nL0tEa3BTRUdvaFlxTFIvYnJsVVRHMjFRbC9GWGM0N1FocUN0UFBoSU1v?=
 =?utf-8?B?MDlvZ3RkcGwrS2xkNWFjMG5IQ05zRUhUVTV0Q09LM3lLVzkyZWxxa1JEZ1Ji?=
 =?utf-8?B?VGVIdVFGSVppckNoVzExQ2xGcGIxVHAvck9VUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:01:06.8552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c01de98-317f-424f-8b00-08dd7e03bc80
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6760

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
index d63f505a30e2..ad97bb9951fd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1103,17 +1103,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
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


