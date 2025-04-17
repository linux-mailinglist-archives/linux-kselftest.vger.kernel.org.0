Return-Path: <linux-kselftest+bounces-31092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8763A92D89
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A2D3B2F8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CBD221726;
	Thu, 17 Apr 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KrnC0JMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FAF21CFEA;
	Thu, 17 Apr 2025 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930869; cv=fail; b=M8p/0jfNPYULkybMuLl2GnJCsI5ZjgU9QB3PY3e3orrtaJvWAeqkBG/3skyytzbZbTeh6j6VMdB4Yn6L1+6FP0hLfMlxc4o7EIuDkcdRLxx1rwd0LHTs1950uNTVKekUN8HJrQjyZCP8gX5wVht3V/ZlNsU84uyYiG4DkraDCyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930869; c=relaxed/simple;
	bh=bnrDau03MTqEb+55uE4ECIXJc1PXmTb+6uznb2nRdxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOi3dT/ANeR1qvEUK6Mm841qyEZs8/4FbgjuN1HhVk/1/6SxZ9lsa16ZzddrWVv3llWcnzjuH+fcxEcGP9n6AZRNwotLOh8XSmhKAQWPo97xSrUyOQh7KwsGqdeGPSOUOcwkRTh8dUYjhOoxfo7b4ME+B+22KHvqv8jOKxagT8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KrnC0JMA; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P23r9CRUSRILJK5MAlw9zGsXp7eOkX4iD5JYMmFjU14+TvR3xiszmFpB88bGDq7UASSVk1P34fymfUhx3psI7oowgFyWAf6+6REJkfGIRtI8slzHCbclRWrLXDU44+muVccM472Xm3OtWe/lGelk9WyUSTBha7pP6NIEcsSF6KbBqb07yw5bDVpF1my20VmWKhBr6DQE/pABvqp4VYo/T7ALiVUoVb5Vmknb2pPGuCO5G/uBYQkpGxM51/+FWhxtLDaaZJWkoAwzCReyjNGhfTWLfIbFx/ralTZGJvMeAxDFWJXqc+UrxCNm8knQG2vrwYhwMBqSe7h09gCvOoV61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF6XTXiEfjIReTh6hy2n4CrqURGfKz4X+CBDtXd3M1A=;
 b=rNza8mEv6RfZFCDB8m/79pzQ4Bs4FDfVNNQMr9aACoot7LlLr04hQm24c7aiCgkbyyXJD9KdPSpFDopR4YoOPF+sCnBIwyJ7XtT02Le8hoK2+wFZH9rP5uiIyZMlfxybA2KgjZidh6VMbAI63UF/divG2hasDrHBvgHTl6493ETvo0IMVgVAocu8XhkdQfiY051sLRrP6tlS77BsJjkO45AvrTgGP0E8i++A392ifVsQ8IMJZMBA39zB79SnQd8WBdQo3sXenO8dSYocacXvsTfZyROYUpG4Q2cPEjUwXYfvDgmCzUs+3G2ngV7vIuBCQAGDOyDtJ8uLYTQY6kAhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF6XTXiEfjIReTh6hy2n4CrqURGfKz4X+CBDtXd3M1A=;
 b=KrnC0JMANlV8x3DA1amv3sKJlRxSDqNdFy9sNtRkT3izqiyUn5UaLe4qU2JbypWIOzqDTZ84xE61YS/HcS6tK8AKY+ychymIF945YQ8r27GZxrEdmn+pm+xQaXrAyQ9EyRXtao1M9He75EeZ5OWIYbc/hcDjsqajwhRBjOmHCdwFYBGojKtMZJj0dony0yXCfwTxe7BEeV+Y6+YpRPBnGrwo6Qa0unW+iDN2QaLD4y+iR9Jl6DwZ762SRm3Mj//lkB94Ekm3/Gxv5mOLWWOIMVi3hSMabQCyiO9Ck5jqRSswrksSRK8IcjB0xE/pjilwluO0KqsVVPOVBbX5vL75VA==
Received: from DB6PR0301CA0075.eurprd03.prod.outlook.com (2603:10a6:6:30::22)
 by VI1PR07MB6607.eurprd07.prod.outlook.com (2603:10a6:800:181::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 23:01:04 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:6:30:cafe::c6) by DB6PR0301CA0075.outlook.office365.com
 (2603:10a6:6:30::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 23:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:01:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B65FA20864;
	Fri, 18 Apr 2025 02:01:02 +0300 (EEST)
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
Subject: [PATCH v4 net-next 07/15] tcp: allow embedding leftover into option padding
Date: Fri, 18 Apr 2025 01:00:21 +0200
Message-Id: <20250417230029.21905-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|VI1PR07MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e07edf-be26-4ea3-f6a0-08dd7e03baee
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ci9UQnhEdjRDWlFsSkNVdjk2SytxZnBNa1RjdFNaL3pMKzVBSm5CTmxuMy9x?=
 =?utf-8?B?U2p0bVdZdEZjU0MwWEU3cXNzZU5pNWwwaGpvejlURFo2TTVVK2E4dGYxOXBz?=
 =?utf-8?B?WFZzNE80QnhrYjZ1SFBoU1FhdUxsS2tSRW9NUnRtclA4Zzh3K2E1amF6MnJv?=
 =?utf-8?B?eVN5RThVTFhyN1ltbEdUblg1MmJLQkh6VXdmcFFDY2RFUng3ZEpDRFdGZHQr?=
 =?utf-8?B?WENKbXNIamsyaUtQOCthRXdKM1FiMm40dWxSNXR4UkFoZ3lFeVZPWVJ5V0R0?=
 =?utf-8?B?aTZzbnZWMmUyQ2x5Z09rMDhiNkJ5Q0tCTGhyZ0dCbW15V01KWFhjOWRIcktH?=
 =?utf-8?B?Z2hrUXd2Z3dXSHgxdW5IRHNXdE5mY1F6OUJUUlViQmZIOVVhYWtydytSYWxW?=
 =?utf-8?B?QmVBWkFVbXNVdWwwWnF3WTAwQjFBVjFoaXFjeTR0TzF6SFk2VEhRckhGUWda?=
 =?utf-8?B?SHN6T0lGdU01aEs5VjRpaFQ3R21qYkdyS2JQcjFUVkJxcnhtZEhOMUtNVkVa?=
 =?utf-8?B?QVRkSHkrVS9QN0tFZ1I2TjN3a1dtMUExSStlbTB2dzdUZGlTdWNWblk2ZWhF?=
 =?utf-8?B?N0RvUTBuVUg0azYxMjVkY1o4eDI5S3lZMmlvNGpEQ2NHaGhRckNKTTJ6NlJ1?=
 =?utf-8?B?RVc3a2R5ci9mbGRlUWMrT1gzVE5wSWFnU0FnMzBMUGJXdTQySXNVRmJCWlJw?=
 =?utf-8?B?UnlYRlhUQzlGdkU3UlBGWStmWFhmZHNpRWpmR2Flait0UGJsaVBzRGpaS1hI?=
 =?utf-8?B?WHd2TDk1WG1YdFRVSDBJL004V2ZxMUJsTnh3RmVxYXpxcWtiRUIrTjRra3k5?=
 =?utf-8?B?N2s1ZS9RMEJUTlIrRFV4RkVaTkVmSEczYm9VV1B3NXE3OElZaVFaa3k3NlFq?=
 =?utf-8?B?V2dIdGNocWxTcUNDNnd0UnROM1h1NUpyMHp1ZTNsM2xHQmJzSFJvUlB1UUFX?=
 =?utf-8?B?ZFExQ1pKQ3Vtd1RMTU1aSGR0YjhTcm04WnVSNU5wVkZSRU81V3dzbDZMbk9n?=
 =?utf-8?B?eTEwL1d5SnBodnBQdTRGYjI1VzlISUhPOHl4ZXp6L2pOWDZVY0ZVdmlSUHla?=
 =?utf-8?B?MDAvVDZ3RzZLVWRwZmJuUzlLZmJGVEdQbnh1aFZzRlVjeHQ0eCtZZGhUUW1U?=
 =?utf-8?B?UGZyMzJVT2NtdjczaG8yYUNqbU5zYTFZeHcrd1Btb2ZYc3pxd1hNYjNMczcr?=
 =?utf-8?B?Z1ZzMm9Kc0o3a0NSUXRHTnhYMHpEdU9FRm5iRHBlSklYTWtiNjdrYzhnbU11?=
 =?utf-8?B?amE1R25TZ05JQUNxbU9xWE1pcjYyM2ovZXVzb3pqajA2ZXBza3lwRVlidkhL?=
 =?utf-8?B?WTNlYjdUT2o0Z3hncldCbzRWamR6NStacmdSR1c0QS9NaEZGNHUvdVdyNXV0?=
 =?utf-8?B?emw4aFJ2bDBCOGJpZCtSUVltZVlab2NkU3RHOGF6dTBpM2w2SUYzWlVSQXdo?=
 =?utf-8?B?UXJrSk1Hb0ZsZ3VKTHB2dUVaelVQNGNPcE1pY2Q1VUVQN2F2L1BOd2dWV0I4?=
 =?utf-8?B?cjA3aHFCdnRBQkRYQ1hsNlc3eHFFN1lHM0FTQ3VHR0ljWlVqQUJqSGpKM2Uy?=
 =?utf-8?B?VXVQendLK3M4ekhWcW5oOFNEQnpEVktESHpkVGVzNHdKSUxFREZ2cTRjTXhB?=
 =?utf-8?B?Z3ZPK1lFa1RPdytWb1g5dEEyWXE2QlJUTTFlMGEvdlY5ak1mTi94dDVXTXpi?=
 =?utf-8?B?WkdIMDlrUHRMZ3ZjajEvSWJSK09sdUlwRXlIa0oyNHd3Qy9pR1M5R05XVXBi?=
 =?utf-8?B?anlLeTh5TFdGc21KNGdwYnBRMHR0VlU4aEJ5N1UzV1ZNekpuRU01RzE4eStV?=
 =?utf-8?B?VXljSmlManFVZzk3QWFSeWpaRnYxTFFxWVcwUE9SbGFBaVhZNUZucC96V09k?=
 =?utf-8?B?WlV4OEF1VEdvR1JSZGluRS9abmRrVWRrTmp6d2Q4QUxrcFNLeUZBZWUvZS9R?=
 =?utf-8?B?aFQvUTIvRFUrNFVZWTVvZjBjM0xhdnhDMzhnZTJlN3VMQlpIRVh6MVRTcDRS?=
 =?utf-8?B?Q2hMM0RRN0FxeXd5dFgra2pVTGFVQmVFQXdaSDd2c0U5MzErOEVxU3hDWUhF?=
 =?utf-8?B?NW5Zeld3UnFpU3RSM3ZZNDB1SzBEZy9YeFMrQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:01:04.2234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e07edf-be26-4ea3-f6a0-08dd7e03baee
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6607

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


