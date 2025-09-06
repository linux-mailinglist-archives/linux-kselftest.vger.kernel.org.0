Return-Path: <linux-kselftest+bounces-40878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB9AB47433
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247E7587CFC
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054A82737E7;
	Sat,  6 Sep 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qmOuw77p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AB1F460B;
	Sat,  6 Sep 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176141; cv=fail; b=Ik3XAO1gbv0qNK77T5amoKcQkZVVu3ZoAem6FgQv9eC7Shy3r7/hfQocMGrdII7PjvmeM9dY2NUrazHn5+2L3cxeldKdDg9CdGKvJybrCkoCcyjZR2WigTQH2ZLc4n4wnHy2grnRxsHEFGhPPqgVPKkbn5i2hwsXwt1l3Fb2g/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176141; c=relaxed/simple;
	bh=QfBZJZTaijVfUGXpNNq7FqDbIyo3bYPrMYBOZNgpUzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQ1VZPDtYeXoIgq/KJ0Bmdya/WNmETSyvrPcXOnSbeW9AYrXDHT451gWrNV9Ujk0D8g3AJY89jwY2CCbBQ21zUENlBOCo8Az34+uCnbUdt7y2EiE7KuUd9nkuCEV4atEhPZUeAl4aA0wOlK0/gnuBBZ92RSTu3fQ35WAOZJ9eIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qmOuw77p; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn71r7zPqiVUBBx4eWjFcJ1Hwa/UG7ok2AD884Uv3y7rnXX+08rPApomF5fMt0s9Laf1a4juqMCxJ311SuohOyAWoe255ZbURXntIpOb4cLv+8vreDz2XV9GsiaTO/eUwyAWkDawmu9StubQk1+CU+eQZM4K+zwU0j7qajEXtPz6HEUlxUZBf7aGDwqkQzRlV5o4JeCstZjqT+OlnnZSrhvYXXQyHHHwss3AXeR/1NsCh3p60lvPcXL2wZ4Y60AN551PsZ3yH7E/qRp81Kw5j7QEo3Vw9MdqMaopo+MiJtXIzsUcT36zz4Sp1ERnU/+HiDi9dJ4o0kzKMHtF1oUU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo6KMiGFFPh6BbGe3v1eOQrACUwFe/695f3FEbGpowU=;
 b=krUosYGLx7Ln4P/pXl+CdTKBDQkE9RI1j3n9WH1hjR6go9Fb5Hgr/4hwVH5Y19pUrOIkn+l2ft1oQsSEE8FGDLXQzq8DEOpfPgntuUhn6BH8XQdd307jd60o1p7f6R7HdxQlu+k4vMRlaODmi8baL4iBXUvQM7uafsLYSGcB3N02nmFK5vQMzeY1epGHWBXjdFNq2oK9TlBIRSVq2speLNYlaFxBKMKtU9TnkXbnQSRHkHI9mQ5DKuA9zoo/UM83QobQIampR0txgIo+igaxZbPx0VIby+Yxk1T6yisEd+ogwFXhpVSBJBeatEZLlCp88fLzDsKPLhHG8/lVe/q9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo6KMiGFFPh6BbGe3v1eOQrACUwFe/695f3FEbGpowU=;
 b=qmOuw77pd8hZYjRjG/gV4+o7PppBcbAsN+60GO06w6EAbuTzgqxU3MGPvTlj+KGIXBO2Iynf4dodqxo+BuuYGRzQuxfXwWMe4MVSgaCxMa+GwGbV5xtpqCPe8PMBTJZnY4RKK6l60YXj3hbRrhICrmAeGaiqD0S1gf3Rz6KG/BFh65ouKZq+w4I635YnXzPlnETxfaS5AKgiXgfmQNVg6NcSmiFeYrU48AB1bii9+cjnaeQ/BNZb1e7VZsb6PQCH9c2xjtsLdPq4jwh6RQTKeNbGEaZf3wxNP1v614L0E1z62BPcSkNbY4J/E9m0QjkzZM+h+2dXI3M11Nv7prObew==
Received: from DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) by DU2PR07MB8347.eurprd07.prod.outlook.com
 (2603:10a6:10:2e6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Sat, 6 Sep
 2025 16:28:56 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::31) by DU7PR01CA0036.outlook.office365.com
 (2603:10a6:10:50e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sat,
 6 Sep 2025 16:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Sat, 6 Sep 2025 16:28:56 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7E0081C0037;
	Sat,  6 Sep 2025 19:28:54 +0300 (EEST)
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
Subject: [PATCH v16 net-next 01/14] tcp: reorganize SYN ECN code
Date: Sat,  6 Sep 2025 18:28:37 +0200
Message-Id: <20250906162850.73598-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|DU2PR07MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 0803ee71-5fb8-45b8-1de8-08dded6279c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3EweE9rNWZocE1zM3AwN0huOXJONGVMNUYwc3JUVXFqT084eksvOXJjUGJj?=
 =?utf-8?B?TUJVb3NVeitjWHlBczR0ZzZPbTlzVmVxRWxBcUtXanpLRDdnK0lMdDk5cGF1?=
 =?utf-8?B?UWEyZzJtL3p1Y3FTaDZiazl6VW5ERFhsQTB0TUcwOC85V210NGs2Ly9XWmtN?=
 =?utf-8?B?WTcvVzl0U2tNdzBNUlZYazl5UEIrRGtTYmIybUkxSW00ODBiMkZBQW02aVlH?=
 =?utf-8?B?U3RBRE0vOE9XeWFPWGUxTXloS1VpN3pFQ0VIQVd4QTRDRjBQb3UwdmdPT2ln?=
 =?utf-8?B?WGpyOUQ2K2lzUWt3OGhCNXM5d2dDV203L0xiRWMyTlVFQmJGNk5xWERLdU9s?=
 =?utf-8?B?V24wU0I2SHZPL013a2JkaFZPRzJKdFRVZkFIWlFYZ2d2TEphclRUZ2pIQ0ox?=
 =?utf-8?B?dysxaWdlaFp2TFZ5d2JLaittZGo3VE1YYWptemN5UDloVk90RU5HMU0xQjJh?=
 =?utf-8?B?VHFXMExkWXYvcUlnWW5majdIaDdGQ3N0bE5RL0RsWmlTUzZDN0Q0b1FTYnFZ?=
 =?utf-8?B?cFZ3ZlBraU1SMmd1a0hrZGU5Y3pkWElZTGw4S2l0WGN5L3NQY3FITUtxUzQy?=
 =?utf-8?B?OElHSTR5YTNmTVYwL3hVUVA1ZmU0MzVOWHJpMmFzTUJRdy9WUnZvZzhUQlV6?=
 =?utf-8?B?V2hFSmtKQWxCNFRudHNyUDFUUmlMdUg4dlZsTVErNEFJWmY5Y2M3RlpFZ20v?=
 =?utf-8?B?TXZVT2tnV3Z3SUE0VkRrL1lmQndKbE9HMGpjd0orZjZ4N1dDWE0rRGxCZU1q?=
 =?utf-8?B?bjFBZldaQ0J3bWJxdGFuNTRPUnVzR2c5VElLYWdwNGNTaFIxU3o3LzJsUUFv?=
 =?utf-8?B?YzNuN3k1Rmh1WmpzVEsxMEpnUjM2UG5kZVFZYUdjMUljUFJaaWpzUTFwVmpQ?=
 =?utf-8?B?S0JjeDNGSi85YkZieGtvc0xUV1RRS00zdmNsTjlOaElWMXRYcUZZaVppbFpu?=
 =?utf-8?B?c25jamRBMUxaeGlReTVvamlOdzl1cGxkTUh1NzhqaTRqZ1NSaEx0QzBwY2Vw?=
 =?utf-8?B?dVpoVVpleEtZaFNOVGsveEZGazBrelFKblJSdUlhaVJuRDVqTUdwejQ1Mlky?=
 =?utf-8?B?OTgvZFBGdGp0a0E5K1ZaelcycVZKZTMzaHB1UDJ5a1NMTFM5NWFYL0tZeks3?=
 =?utf-8?B?dCtGWmpQWCtpbm1JNE9xSnNTYTFGZ0FLL1dSMDRhZytIc3F0aCtVZTJjUjhQ?=
 =?utf-8?B?VncvUWozWFIvL2NodUMwamJIalM2cWtqTUdxYmpXUzJHdXdoZXBqaEhCY1ZK?=
 =?utf-8?B?d2JGK1J0K0VKVU9uU1FnMElwSEdYd1N3ZVhpQmxkR1ZObmpWMm9IMy9kemVJ?=
 =?utf-8?B?L1hpY3dtckIvZnN3dWpiV05wTGNkK2hqbktTbm96bWo0Qng4NnNkaVpMQXgv?=
 =?utf-8?B?NWF6Z1VOTlhZZmhaMWREeFltbjdLaDRZWjYxbnl4bEVBbW5DeWNROGt3Rk9R?=
 =?utf-8?B?UEg1QVRSUnh0MENCWkUwN2UraFhYYVB2K0hmUXRVNUFRQ0Npd2FXdnExdW5P?=
 =?utf-8?B?S1BRMGZ6SnhZeGlmM2tHaTY1bjJOMkg4WUp1YjJ6RTJyMHFqbUczUjlBRFRQ?=
 =?utf-8?B?VHlsSVNSb0hMNjZZVVFWdmFaQi9RQ0hwdUJxbXgvb0VsWlN1aE5CeTlkcno5?=
 =?utf-8?B?TlAzWG0vSmUwOVAvWmhVN0t3Z3ZNNlkwWDYweEE0K2g2VlVKNTJacy9FdGdG?=
 =?utf-8?B?d0FjVVN5NTNrR05hdFNjb2s4TVJESkNUK0tTM1libEdHdEZTaitSby9iNDRZ?=
 =?utf-8?B?d0prcjJNSWZldUE5VlRIR04xTjRsMlJFNTFJTWs4L0NhSTkxd3cyemJjQ0Uw?=
 =?utf-8?B?VmtOdE1IcWxaRTRiRDlSRGVlSVBFbThzYzZBNDJiUmlWR1ZLR1lLVk9wbzRi?=
 =?utf-8?B?THJuU3FkVnJMQjNPS0NaUVhFR2NiMnNZUjlMR0tiYlJ5TGp2eW1tbHBmckk0?=
 =?utf-8?B?eEZ2MnNyMSt6SjYwOXk4OHY1TDkxUklOTXRJK21qR3ZoKzNTSzFBaXFVa2li?=
 =?utf-8?B?K2pKY1pJRk1XaEhQaGRxeCtnWEZ6eTBmdzRQMFNFM2ZjYUlKQmlsNzI2TDJr?=
 =?utf-8?B?RU5mUlVxcjl2Snc3YThnN3pzN1czblRCeDVEZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:28:56.0959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0803ee71-5fb8-45b8-1de8-08dded6279c1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8347

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e180364b8dda..54b8faa3ad95 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,10 +350,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
-- 
2.34.1


