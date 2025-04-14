Return-Path: <linux-kselftest+bounces-30693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F2AA88164
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8271789FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969682D4B6B;
	Mon, 14 Apr 2025 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="n5ilQgUv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F42D3A6C;
	Mon, 14 Apr 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636452; cv=fail; b=W28donqMGMONzwhcvuP002aPvrEX9Cq5fBrg0EiOTUm73E3mVe7QqHOuXRZpdCCMgNi48yxqNS8DBxFDwaUocqhmOOJOSQ/tSiHYGEzc0xL4uN2xDPQE0itmD/JGp8e5e025fH4KT7L740g2LZmxCiKP/rQEam5BR10nvEaVmcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636452; c=relaxed/simple;
	bh=bnrDau03MTqEb+55uE4ECIXJc1PXmTb+6uznb2nRdxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1prt6lnIuoEvNbPhmhoELwOvWZzxR0BdL1rF9jEd+dNf+iUgzWzo9t2pWgnPtqTZEfxF0V6ozGl1KJaBEYaRveWriXcj7EuQ5kVzdK4LuRF7JTUYawuGMpbfOBrx2wXgQuNfIul+69SXxtenCaalsbU0xV5NeotSz9tavwbgvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=n5ilQgUv; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSvllEQLbzbDCYsMY7/HdzuatcjWAp94zPLGrotqfGz97fuTdX5fjys6VksUPNFYYaZXqSjpDlUF6tze/3XvL7yF5EmCYNEgmWZwVMb9aqwLgyQ52LGoTVYFF4yvo6eyuzOX5hBqsYOT3KmywE3T6r7mvUf6GOkEHhFkgcsbZtfPAdmnRyumID5E7Z9CI8/lQ9/P8zSXYwFJKmu89fGac6dr1O+ISl2n1nPBD0U921iZ3nj73oyGJGCQEedUTrEmI8wkqGyenoNEr8xz21rOpQme3aokP2CVvin7JcJV/t1JxphH+Y8Fm105PoGFoewyP4l4w2Tin0HkhCEo18myGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF6XTXiEfjIReTh6hy2n4CrqURGfKz4X+CBDtXd3M1A=;
 b=REklVo2ctWOBo/PJ/RqAN1nDtJGvix10DYm/WkzpP5gcK+un7jDy9Voh4Xiqfy94d6T7kHctgQshbaLxdN2CLBNuqcZ8tgEA6jRXQtLbtppPyoq59gQioKK0ooPUoZZi79A9SGzNOb6PF44zanVOxSfbJtKe+yJHWx81PQsf9jM7U5e+WsvhX1jUyyTGM1N+UeAOdLgT3W7i95ojUi2G5/QQPo77vNi41aUol+7WAOfk7JDzHd1BsImY0+yR2eVUVbJE0cPawm1qJ8tlbckfwwTWDmyJcBfFr0F0iA5hsZFKQRwr7XDvOW2K9JbBBACugeIx7B6b971g+z4JZq+FJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF6XTXiEfjIReTh6hy2n4CrqURGfKz4X+CBDtXd3M1A=;
 b=n5ilQgUvBxxQYPIxws9IWng+FRkcocO22xoXBlx++hBBUYCtM2qnpuRnxiJiNsB9Cn6fcCwvYacNpw+FGp+/fhGGVsK1WkWwYxc+Nj/bl4EeI+nhu5M6HfAogpQ1nyM9twhUVzWK00nf38AsmyNr0foasAh3crwFGfAeO+qk0uJ0C2RJfGcH5S+x5GFqdbSHDHCdEgOEQQ4Ce+i8TKB4lrC2uX3UTCgigaspPTQIpDE6CSszH5oH/7XnmCWv3JxrErjNv83DXBLwu3idJs4IuUj1evpBI+JdQ1EVlZ8ao62sB8W5Tdo9XS6Mt3VV14S/azXcXvsajVZLVuSuFaIj+A==
Received: from AS9PR06CA0287.eurprd06.prod.outlook.com (2603:10a6:20b:45a::21)
 by AS8PR07MB7992.eurprd07.prod.outlook.com (2603:10a6:20b:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 13:14:07 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:45a:cafe::3b) by AS9PR06CA0287.outlook.office365.com
 (2603:10a6:20b:45a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:14:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBI009623;
	Mon, 14 Apr 2025 13:14:05 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 07/15] tcp: allow embedding leftover into option padding
Date: Mon, 14 Apr 2025 15:13:07 +0200
Message-Id: <20250414131315.97456-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|AS8PR07MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: c12c9cdf-a623-4225-e67b-08dd7b563cbb
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a0hZWmhJdmp3UFdtWGxiOUVaamF6bjcybG9aQkduWDYzeEo4QzArMWthYUo3?=
 =?utf-8?B?YXVla0ViNGxrejlJbWlDWmppSzBPaFQ1eC80bUwvcTFFWEszTHd5M1FmaEtJ?=
 =?utf-8?B?Y0hvZ2dkM2tlMU9UMktITGpZeFhZclNnN05uaU5EaVNSTXVBdDlBT1F2enJ1?=
 =?utf-8?B?bWQ2RzUwWnRXZTNVbk4zUUI0c0VQVjViSW1Dd1dmRVl2V0g0TUNDRmd2VG5G?=
 =?utf-8?B?WkhNbDRQMGNTZmxzVVJqd2RueTZ5djN1LzV5UjlNS2s5a3hSbGloSTFjUkM5?=
 =?utf-8?B?b0NsU0NrM1kvRnkyK3Z3MHpDd3JJN3d6V0NQSlk2OU10NDBZOWtKMkFnK2Z2?=
 =?utf-8?B?V0IvSElMZnQzTHlqb3pnTTJYYnp5MzhSVFhaeEZycDBvRGVsanB3Nmc3NXo5?=
 =?utf-8?B?dkF1RFlBTjdZQVQ5a2dBYTZTUW9FUWFpRm1iemVIb0M3UDhjRVk1UlZEejdy?=
 =?utf-8?B?YzZIS2NQVmVTQlA2ZmVLcTFqMHRLL3VwVWtMR0xJaXlPb1lmRG0rQmFDeW9p?=
 =?utf-8?B?eUVyYk95RGNsSDNEYVhjcGNFWkNhQStZcmxCdG1xVzFrVTRGV1M1dG9QVjRD?=
 =?utf-8?B?WStnRnBQbEJ2d0pQeEFVQzROb0lRUW04OXMwRnVPSXNXcXM4QisxK2NYUkY0?=
 =?utf-8?B?QXNXL24rZEY0cXN2TlJJTEJxNlpFTHl0L2NhVkh0dGhMbTJkUGI2Z09LampC?=
 =?utf-8?B?VGM0eEJoWFZ0V3BDOUZsNTVYa1d1ekdYTGFKTFE1UDFsZit3VTRqakpVZXBF?=
 =?utf-8?B?VWsvdS8xZFFYbHFmOEpmNjJ5d0syOUxGajVJU3B6QWVsYUhIMnE3My9ZVUs5?=
 =?utf-8?B?eXRhZVk4TGwrcGlZb2c2WDhCdFhlUGdpN0ozZVJJYk1EWEE5MFp1WVJ2WkRL?=
 =?utf-8?B?OTByMnFkRmhMMEZrTVhDQk10UVI4THFlOE44SzAvaEJNN0lpUTl0aVJycVJE?=
 =?utf-8?B?N1UyNWRWNmliZzNnL2NpYVZ2d0NvZHhUUGVkMjhIWXpxamNIcENicFVBS1J5?=
 =?utf-8?B?aDc3TVptNU9SeVczblFqYUVCZmZEKy9tZi9SSTdQTzJacjNyaE9WUjRRamNl?=
 =?utf-8?B?L0w0dkhJSnQ3c2NXYVB1NEdXLzduNTVSZ2JkeEhLRzJwWmEwRGVFNlZoL2F3?=
 =?utf-8?B?NGtnWXZQazgvQVRFMHZucC9LZUhLSjF0Q3owL2t1UzF3aWNacHJCa2RwOG9i?=
 =?utf-8?B?Tzc2bWhFMEJmU3MxcXdmWDYyOW92OW9XM20yQ21STk4xKzNqMzVxRDhCbWJ4?=
 =?utf-8?B?N25rZTFIbWVSdWFGYkVwYitmOVhNSnhIYzZNcWx4MWU1QjRKNnlXK3kyeUdt?=
 =?utf-8?B?R3ZKVFFJUUxuV1pBeWtoQVJhZzlRSm5odGNCYW94TzBSdWlPSVltaUZKRHdt?=
 =?utf-8?B?d2xkNnRYOEhsTjYxT251eG8rNWd2eGtFTnZ2a000UW9aMnByZVZ5OGxpYnpU?=
 =?utf-8?B?b3ZlWm5NTFF1THhzY1U0QUxkTnl6UUJSTmUxMWlqTVFLTzJFSGVMbEY2QkNu?=
 =?utf-8?B?RTFBRGp3UXNBTGFqdUo1bEdWaXVpZUhnRmY4Qm8zcSt2UEhJeE14MVlZRkkv?=
 =?utf-8?B?azhVblpNMDc1bUI2RERkNmRXVkIycSt6YThCUjJ2RzVSbWRkRmE2NCtMMWR2?=
 =?utf-8?B?cU0zeU5LZ29qdWJCMUY0L3lVK3BtNUlpL2I1c0NYRlVaQWM3dmU2VXV6bFMz?=
 =?utf-8?B?ZldMUzE5dHp2dEw1OXRkbC9ZcUJkeHhXMHRIZUx4djZNWjlxcnJSTE5nNlFq?=
 =?utf-8?B?eTRVbnNyRFJYanVESk11UTNrdVRody9DdldjODU1Z0hVWXpRZjhLWnhnSUlz?=
 =?utf-8?B?Z2dUS0o5ZVFIUklQZFluTG5DVHNHTDFmR08zQVFMUVNyQ3VJU1I3RUczT3VI?=
 =?utf-8?B?UEM3OHRnQVB2UE9reVJvN0hTU3ZFWkROMXNsMnU1U3V6MlBLT3B4TllEUXRx?=
 =?utf-8?B?RFdrbnlNekxjeTBtVUVzUkU2QTBlVmNYbTZpbUJ5Wk43T2QrMkNHOVR2bTdG?=
 =?utf-8?B?STEwemlmbGIySmNUaW1nWTVXcllSYU1tK0EvWHdKdnNGbHEvSHpOcisvT2RB?=
 =?utf-8?B?K2Zlcy85NnR6N2hWZEpTbTR5a1FlbGVuRVEvZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:07.2048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12c9cdf-a623-4225-e67b-08dd7b563cbb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7992

From: Ilpo Järvinen <ij@kernel.org>

There is some waste space in the option usage due to padding
of 32-bit fields. AccECN option can take advantage of those
few bytes as its tail is often consuming just a few odd bytes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b4eac0725682..d63f505a30e2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -709,6 +709,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
 	return ptr;
 }
 
+#define NOP_LEFTOVER	((TCPOPT_NOP << 8) | TCPOPT_NOP)
+
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -727,8 +729,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			      struct tcp_out_options *opts,
 			      struct tcp_key *key)
 {
+	u16 leftover_bytes = NOP_LEFTOVER;      /* replace next NOPs if avail */
 	__be32 *ptr = (__be32 *)(th + 1);
 	u16 options = opts->options;	/* mungable copy */
+	int leftover_size = 2;
 
 	if (tcp_key_is_md5(key)) {
 		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
@@ -763,17 +767,22 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
-			       (TCPOPT_NOP << 16) |
+		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
 			       TCPOLEN_SACK_PERM);
+		leftover_bytes = NOP_LEFTOVER;
 	}
 
 	if (unlikely(OPTION_WSCALE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
+		u8 highbyte = TCPOPT_NOP;
+
+		if (unlikely(leftover_size == 1))
+			highbyte = leftover_bytes >> 8;
+		*ptr++ = htonl((highbyte << 24) |
 			       (TCPOPT_WINDOW << 16) |
 			       (TCPOLEN_WINDOW << 8) |
 			       opts->ws);
+		leftover_bytes = NOP_LEFTOVER;
 	}
 
 	if (unlikely(opts->num_sack_blocks)) {
@@ -781,8 +790,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			tp->duplicate_sack : tp->selective_acks;
 		int this_sack;
 
-		*ptr++ = htonl((TCPOPT_NOP  << 24) |
-			       (TCPOPT_NOP  << 16) |
+		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK <<  8) |
 			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
 						     TCPOLEN_SACK_PERBLOCK)));
@@ -794,6 +802,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		}
 
 		tp->rx_opt.dsack = 0;
+	} else if (unlikely(leftover_bytes != NOP_LEFTOVER)) {
+		*ptr++ = htonl((leftover_bytes << 16) |
+			       (TCPOPT_NOP << 8) |
+			       TCPOPT_NOP);
 	}
 
 	if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
-- 
2.34.1


