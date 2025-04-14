Return-Path: <linux-kselftest+bounces-30945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB9A8B6DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 12:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF64445334
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDC2220696;
	Wed, 16 Apr 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PYEiRK04"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166D482EF;
	Wed, 16 Apr 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799860; cv=fail; b=QG7OGfh9d1D2OYdB3cfkYBAQTaTfa+h4lrMPjiBr7zHSjL8l57N3nBuWCitVSFgMxYQtGZZ4ZPbK23gEK9K0trJzPjVouhddvkQh1MwwEMU7gT3rSk5UymDptg5TQDncdkGAlozvUpGezNVJ5Es8wHt3YrKfN3aLvy/mUrpLegw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799860; c=relaxed/simple;
	bh=bnrDau03MTqEb+55uE4ECIXJc1PXmTb+6uznb2nRdxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZc2BoPtXa83MjX6JylfU6QDKulcvKMYbkXWRcC76KOfcxlDiooI3UFNakOe2ZLwVxLlg/tBD2o95X1CY5YLVtFNEWE4x78z+iPpcofJfK6PoeUqKZq8vYs2yRk5K84JIP8dg0RbPknON+5BwgQHmTY598PkWtC2kQlyae1KpUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PYEiRK04; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2gPeTaVcdVSevrXHnhcmSylrf9JggiAY6Mj1ri8eIbSUhd1BYvjJAi4z+aPcWEDtvjc5Js3J7TgPCR3/e2/Bud4AJXFx3G2sqJyRS8DIMqadJ4JZMQkWzlEn4gVxvM1iLTy6TKLeFltR6Zuurkj6N3MUiyqei7UI5tUVx09/lYlA1MxG/8AqexD9mgZFGQAxrLlODLztORIb3IQ1JDxT4/Kv4L+3OZsYF25ZQaKRbjGs6v84sXD4ymqMc3bTGfpLH0x1JJtognOW9ZSfx5q0wjGtUQRvUV65OGiuWj6gkFeLp9yXSPhwoSBY/X2N1cUTEeLLGKLyRIU6ADGSZSBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF6XTXiEfjIReTh6hy2n4CrqURGfKz4X+CBDtXd3M1A=;
 b=tgMRoy08O5Ex11bdqwh/vcq9vBh9yG1UUDS1HmyQ5YOfk+ncooqZR4NjnY8M3ovsm0zXBkKfnyFbwE7OkzjmfzHGhYjZ1Q9DZUXjKxN2WZyh44EBNnKJD/qJbCDUyUlYG3pHqyitjdKnu4jF4YhSx8xJPk1fFqlm7uoKqGhulLfOMMvJ6MJ1P56VBYD9QD5zCG5VGP7XD2pPTRKHccsVVZgnItIfKgmDeHNr39PVcnpFYaGZJiXnpkKfnBl16qiwtCJnJikzx+ssfD0qdfaYmY3+JN68fYVO74Hb8Fb6SP6EOkwC1toA3Lcf+FG531go5fKUlie1Cacw5bSdpXq7RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF6XTXiEfjIReTh6hy2n4CrqURGfKz4X+CBDtXd3M1A=;
 b=PYEiRK049dXtaZ4jby1KEn2E2t9uQDNQ6rnEhvNj0R9tNxBcZq1P8+oxFcvl5hLPkBc1LzbHHZYTRWEmxDHmMaBqE0afQb59zFXuzqqlLvuoDOOuwIkLAW7PqndSw2yI9HUhgP7nHC26bfXxHVEWmSV9wcjFWB8Ge1ptAiA1onorA/4EQVd9Ldx030JUCwoWWpaH57tfEqdABtmnOvvTlsDw+Lxb11XeK4lCe4+6QsGm0ityWzfKSQ5PDsMDwKRzvesbtrmmnlzXvw5BjBH/MqFGi4p1+ZAJr+HEDKmjKrGYRtIHJJpGxI9zFsKEonXzLuyO5+0cvi4/KYtWtSIsog==
Received: from AM9P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::27)
 by DU0PR07MB9289.eurprd07.prod.outlook.com (2603:10a6:10:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 10:37:35 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:21c:cafe::43) by AM9P250CA0022.outlook.office365.com
 (2603:10a6:20b:21c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Wed,
 16 Apr 2025 10:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Wed, 16 Apr 2025 10:37:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 9878A4EEB7;
	Mon, 14 Apr 2025 16:00:12 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
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
Subject: [PATCH v3 net-next 07/15] tcp: allow embedding leftover into option padding
Date: Mon, 14 Apr 2025 14:59:36 +0200
Message-Id: <20250414125944.97350-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DU0PR07MB9289:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e81a63-d613-4a11-c656-08dd7cd2b26a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TnJ6bHFPOGozYkl5YXpocWVLOEFHc0lVM3A4dWZ2WXMwSEZkZmZxZEpIeENh?=
 =?utf-8?B?cURrNUhzeDVwbXFhSTlPUnJYRmtmZytPZ0EydmE3T1NsRGxOVFZWNC9PdDM5?=
 =?utf-8?B?WVg1NzNqTEhPT2pWTER4citrSDIvOXhHK3NBa1RMbzI0K2YyeW5ORUY4c0JT?=
 =?utf-8?B?ZUFzU01ROHBJN0I4OHRPOFh3WDJERzhTQm92M1RkZWk0TXlJNld5aHhBMWFN?=
 =?utf-8?B?cUdiSWNZR2hNbHNWcU02VEdRbmcrTVVIaW9qb1pxY0xnNDIzMVZPU05XVjdX?=
 =?utf-8?B?dVdXSE9hcXp1SEpBWkJ5NGJKRHNadGhiS2wrRGJBTzdyOVB3NEhHamtWbW9y?=
 =?utf-8?B?R2JvWno0OXJLUURVekRjZjNZMHZ3VmVLUVFTTFYwb3FpbC9EdHJKdWVoUDRo?=
 =?utf-8?B?VEhmL2pkZlQrRkpUMzhDM2MrRjE2VTVIRUNSaGV3WlQ0NUNyNEIxRHQwTWYv?=
 =?utf-8?B?OVc5RFlFSmkzZWFLRFZ6b3hwY2NNUjdkNnUxN2UzbkcyWVEyMWoreVIvcyti?=
 =?utf-8?B?dTBKUXZnbUFKVm9udm00MkxGMi95QUVyR0VDN0hxRHF4bzhGNjJONllndy9D?=
 =?utf-8?B?dVRsOHFvTkxPN0ZNVi80Ym5wS2VRSkcxSjFNalNBVDlhQW9rbzRDalNScFlT?=
 =?utf-8?B?dDhjVU41ZkM2VjRuZmRFVUNLK1FDTTBNUFJ6V0JQcEZXNGlKWGZWQXJ6ZGlP?=
 =?utf-8?B?NXhjcTdEV3d6ckFiRWgxTTVKL3dpTVpkV0xRdEVsemRZUk16YnJFUENzRi9L?=
 =?utf-8?B?R29HQURMT1k1VHB2UDJyM2xIeHZjV3RTOWMvTjljZktPVDBRc1lvUlZGVzFV?=
 =?utf-8?B?dVJCdmxlT2RackF0LzBmVmp2VU51NWwvblhobTM1WDNWb21Pdjk1bDVMQUxu?=
 =?utf-8?B?eUZUN0xEa0E3dkIyRlNYbVQ5UW5oS1lFSkVvd2p6aFRnaVpYb01aWHBRbFhq?=
 =?utf-8?B?dHptbExkOXhZWS80VHZSd0lVOTE4MUYwd0owOUJLUHMveXhWKzlxVGd0eS85?=
 =?utf-8?B?Z2srbU9rYWhDWTFnNERxb0tlcG1USUg4UHVoTDdaME9FRktjV2lkS0xGcW54?=
 =?utf-8?B?MHRRemErMTV0KzFuVldBUFh2UzhDeEp6eFhlczEwNC92REh4TW9MQVN0ZWFG?=
 =?utf-8?B?dFp1OTF3bTEvc3F5T2NweXgvMFBiN1h4eVp0NXdURmRpU1dDNzdIbjV5S3RC?=
 =?utf-8?B?YVFzZHkwUFVaVy9UTFkxUDROZm9ha2VVTm5uT011TkRTbmxqV3Y3Q1BxNjVQ?=
 =?utf-8?B?YTgxNkNHa2wvSy9yWHN0eXRxbnZ4dFR2aWNQMVB4czZ1cnp5ZkVmZTY3Uk5x?=
 =?utf-8?B?WGRyMS9rUW9UMTlha2wzaXc2K2dPQWkycE1tYUlpYTVzSGkydFh0bjJBYmF3?=
 =?utf-8?B?anhoV1Vhczl3NEFvYmZLYW1JOU9mZVFObmVYRTliK2tMUlUvbUNBT3hEM0Rq?=
 =?utf-8?B?S3pNZVlYdVRyV2d3b0UrRkY1akNGKy9XMG95QzArbG80b2VTd3pwSEFnV3Jj?=
 =?utf-8?B?RmtJaFVuK0RoU1dObkdYRWFEVzZLNFJPZEFtRnM1elZDNGhXVDRxSU9mcXho?=
 =?utf-8?B?U0MxekRycXhlWXpHcXZlVnZpNVpmdzlXcE5acGZ0dEZPWk1mWURaamtZT1lk?=
 =?utf-8?B?QnkvQjg4QitrSGJzNlRYeHh3eVJIOEdtdVRrQWljQXN0SVNwVFZtdWtWaDJI?=
 =?utf-8?B?d1BLMVgyWGYyaU1naDY4S2FqM3NSU21Od0k2UEVjQ0NKVkFTYkFQL1BMK2JN?=
 =?utf-8?B?VG9KOXRRNVQrSFVlRVF6cUU5YU4zTXptZlFkVVNKUlViM0MyNnNoSnRMb05n?=
 =?utf-8?B?WCszZ3VLODNCRVF3dC9kTGdqczZEb01lU0VOMS9VcDlneC9HNWdnTkpqanpP?=
 =?utf-8?B?VWU1SUNxZkE5WGF6dmpROUJlYVdoNkFjdjBSbjI4MzFJQjBEVkI5em1zV0RB?=
 =?utf-8?B?b01XcjhwcHpVTkJwQXBZaHdaN2ZWZURYV1VhQ0l6OE5tQUF1alc2UUdVVDRW?=
 =?utf-8?B?a2YzTFRDRlZ4NlpQa2h3eGtpR0hTazY4MHFCL0NoVTBkYngwN01vQ3VwUmZ0?=
 =?utf-8?B?QzlBTFU3QnRPa3Y0cXMrVTJ5ZGx4Wm9ma2crdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 10:37:33.3859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e81a63-d613-4a11-c656-08dd7cd2b26a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9289

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


