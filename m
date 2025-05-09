Return-Path: <linux-kselftest+bounces-32793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD07AB1EF1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7FA0278B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7A263F2F;
	Fri,  9 May 2025 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Sdrs82ZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3425FA0E;
	Fri,  9 May 2025 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825548; cv=fail; b=TBcU1jRLcwSJM7/i+h6DZVABvxDGNxA3t7hVA5m3Z0tYXBWwxYyIsbhFEDgfsJS3u9ZuxbxBKwKc9fKP+FbkFWOEFIuC9toJNcnJX8N3Vj1xVDaVZsD38thQqwDnIGi7QVIF1ej7rx67Rua3R4pjdkh36bOADksQkRQQFqJdnK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825548; c=relaxed/simple;
	bh=vEiMyl0tItWbzCFovRoAhoe5pTMFIHY13iEfTNZhetE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nD4KqqfZTPm1PcnX+3aSgGOTU2ky0tEh9DedNm1zNVJpXG5sj32+dSop19aVBcIe+4VDUjUuS7H78Xuc7869aRZfj7M7N5kSmQiUJ/s0gj4vZAOj8KyJrJqkACupCQOMHMHy2S4egCWprM2TU82fWmM35+DGcC9hK9sUd2Cd7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Sdrs82ZV; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDzYvXReV7k8anwydUj7qZtYTjV7mK4jThZggGeO8ZQHM5cYdYwDn7qNl+BEQuDPmyKJwXOEK9Ptih4YePHKvvrZdyMK3nVrAbzvF6hSeHo01aJGHPs0gdME8S8tS3rz+URSzleuZRzUMevv9eYVw0ewWNVEpWDJ/rZV0Jir+2lU8krIgh1h6vd+SQ8CrujnqDvjNXn/xoILkkvC23zvZLbBZmKpbbPIIvdUHSXFi5fs1kJ1bg5gJEFqT6ZdkFcx6/1aY3THOKIrAL0CNGXQ++eGwb8xL02TIe6KDY/yZY576ftdVztUVRH5dPS/nJH5dYeRMZCD+f92W/i9scodUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmCn1YEUV++G3Rr42GWmORqhBlju/X5eu1+GdsG1HBg=;
 b=Vd0ZFiiAYG7PuxXPf2vqsDZnEGB3qtsDvlTKBt3Id5D5c2nADWEItgqtkX9Mkhyh9RpdWZX5C0UuHeHh5ZTdcZNiFdl3oQdwDtHZoVOD2dmzPDda+RllJFx7Seo5Yei/ooxIbw4BLZg9wzv5YueOd+7p787cQT7TDqs9XKga/T6pguLsUbm7BDFL8FzxQqaoNA0j5BvIM5MiFgdjl7Ue+QOLxsJAdEPaI2QRka3s9lEH0F5lXemoBirlktvoe7Ve+0j0ys5fH71e5ZxDsbpdxcpm7L4vXpOsj45RHbNm3cWOyBa8tW0y243iEm/9vAKT+Ewa4kOhxlP9PzZfJYb2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmCn1YEUV++G3Rr42GWmORqhBlju/X5eu1+GdsG1HBg=;
 b=Sdrs82ZVkwVS93wWutSsbpUi8C0J6lkmHjezl2ey/3jgn0Aymv7Nmgn6MgxIwwnWC/IJHlrpRQHW22LuqX7yaVfMHWon/KcBMjINUFK5kNwHHkQkRCtdsxwuZm6l82HMN2yWQ0GTEMACcYM17/30dmX3NskTXViv1/PrPoeBnCEFirAnDqGBSB/IVik8l/ostYz3I9Cv2B+aRs+RO74VqTHOijc8qQigpZnqrko2CmXDXS7H+kKPiEi19Y0NHOigv4a2DNvXGCyEsl4fDmepeRZBtuQu669/BGqst2SsfLm+7jBjK402c9KQ4xeIFyRCnj/HbiMqr6adZHzePf+Img==
Received: from DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) by PAXPR07MB8769.eurprd07.prod.outlook.com
 (2603:10a6:102:244::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 21:19:01 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::da) by DUZPR01CA0333.outlook.office365.com
 (2603:10a6:10:4b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Fri,
 9 May 2025 21:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:19:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8A6582009B;
	Sat, 10 May 2025 00:18:59 +0300 (EEST)
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
Subject: [PATCH v6 net-next 13/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Fri,  9 May 2025 23:18:18 +0200
Message-Id: <20250509211820.36880-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039232:EE_|PAXPR07MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d0ef63-a0ac-4275-dede-08dd8f3f1e4a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?djMvN0hWQUJmWjJIZk1lUmZwaENkcjdxSXVBNkZxSms0Y28zWnVDV2tOUnVG?=
 =?utf-8?B?enRnZUd0Sk1EVjFZc0pRcVc3TE9YS2lESUV3MlJYMTF0OUJheE9sVllmZUN3?=
 =?utf-8?B?YktEQUltY0RjWHJDWGR0clMrQ055L0N1YmRrbERaL08vZmh2NlE2RDRydHRl?=
 =?utf-8?B?MFdaYWluVzJack9QbDRscHBVdWNSWENwWHFaa3lOd3hmamI3ZXFrYlVEQXN5?=
 =?utf-8?B?MG5lOHBGMnFjcUs1cUNKaDhLVmd2WGp4azJKY09jbnJZemwyYjJvV2hGbTVT?=
 =?utf-8?B?aW0zR0NPY1JXMlp0a3A2SzhxdzllNm5rQ29MNG5jaEhkWG1LblJ3aUFVeDRJ?=
 =?utf-8?B?UXZadWc2VzJDVGtPeGVtbkU1M3VYQ3A5eE5tMXpRU0pOY2dha0wxQ0wwS010?=
 =?utf-8?B?T1lnWEREamw0U1FYZEM5WE9MRW0wdGxvV2NHL1ZsUHZseDBTRVZnSllZWWFK?=
 =?utf-8?B?OEQvRzJwZzlrRjVZbWdTUm8xcFFqckJGRE8zMkxOQ1VsWlNQc3hkUUpnV0tr?=
 =?utf-8?B?UUs0Yml0TVN0eEtrbjl6RG5aeUppUEczRWc1SG1pRXlqS1dhMlhMQktrenVI?=
 =?utf-8?B?OGMrUXk2RDQxS0xmVFl1RkJZOVdJUGRoTXFWK3hhcDQzU2wvZE9nc1FLZVg5?=
 =?utf-8?B?dDY2Y1VVOE1BTGNseGNGZWJaaHMwdERUZklXd1dSVlZpcSs4SVYydStPNnFn?=
 =?utf-8?B?U3hvUlhiZDR6Rkg3Qm9ZcU9IRFdSQ0FRRGFadDlheGJyZHFPZUlOaCt0Q083?=
 =?utf-8?B?SFEwWjFMMkJLZHNyeGJaTEpzWEpEb0FQQlcreThNRExxejZCTndxbVhKcTdy?=
 =?utf-8?B?ODRzVXJyc1pCMkl5bTB2bHJoWFptOTd3ZFVrOFNUQU93UmJPaGRSTU5kalRu?=
 =?utf-8?B?eVlWNkcxYUQzYm1TTDhHNDhPMFNTMy9NVDQ1eWVXWngwTG5CQnArcGtSRVBO?=
 =?utf-8?B?bk5QZDA4aDNtdDlseVg4OFAyOHliNFkzQ2J0R0N5dTZXWVNZeWFEbDhLRFNu?=
 =?utf-8?B?c3BCb2NhN1JQSDdUQ0ZtbXc1cDNJenJEM29BMm55YzJ1S3A0U01pQWhNcGJN?=
 =?utf-8?B?NkpWTzN3SUE0dFI3dnpyME9IWTFSMVRvYzlzUTE1WGxpS2UydzNROW5VYzll?=
 =?utf-8?B?czE0Y2FjOXMyU0FyaHUvRkVFNWl1dkxOeUJpWDlrcjhwUDNDUEt6WUg5U04v?=
 =?utf-8?B?ME8yNDBZMzk1dnhOVGhicDNDckJTU1pUemJlazZUeUs2N0xpelY5anUzc2xI?=
 =?utf-8?B?TFdzdUpwUlV2Yi8welp3TFFsTEt3c0xLYS9nV05HdW83YXJBd29EemlKd0hv?=
 =?utf-8?B?ejFvTzJjWkpYcVBDL2xzRjdQSU1MRzEwb0ZPQWduQnlGWFNoVEdkTndSN1NR?=
 =?utf-8?B?WVAyWGhyd3Y5TUhyRXFXbXVJb2huWXVVNGdxV3NnejZrZUgxQ2ZDekEwTklN?=
 =?utf-8?B?cmUxamZKQXZRVS9JL3c5czlXUmRWOENRVEx2aU9GdnpGalJFTHpONFFaOGlW?=
 =?utf-8?B?RzRiN0tTWk0zZFNZbEI4WUhsTTk2cVpRTFgzRmNLNExwaXZoYTViUVNtYzBI?=
 =?utf-8?B?YmdmbWUrWEZqTUF5U3dxKzdkWmFUZERuNVZ5R1pMZ1JlMU1oQlk0NUtHYWRX?=
 =?utf-8?B?UWh1K1lBb1ljbktsZm9lSlpBZm1UVjJIYUxKZ2dxMmJqaFF0YXBtZ2dXTHhB?=
 =?utf-8?B?TEQzd1plQXdieXRvdytYaGJEZnE0NExyQlVqTTRJTGNMM1N3RklIK0tkUmVj?=
 =?utf-8?B?NW93ZWlLM3JQNi9sNW5nR0szcHh6cU9jMHhEUHB2N004UFZ1OEUxUHBzb3NU?=
 =?utf-8?B?SW5xR3p3cFJjTmpjdXROUll2NGh2bW5PeUZTbHp5aHRFenFJSEg1dFNvTys1?=
 =?utf-8?B?Mi9lR096cm80ZWVibHJtbzVvdllhdjl0UHNsUFMrbHNNSk9mbGVxN29IZnFF?=
 =?utf-8?B?QUMwc0puVldSRUladE5WYU5GZmZFbVFPalk2YmJLaTdIWXl3L25TUU5lU0Va?=
 =?utf-8?B?ZzR5MUc0UHoreUFYWjBjKzVNZCtxUmd5ei9pbHloTWR3eTc4aFJIbDdRY1hE?=
 =?utf-8?B?S1UrQWJ6ZWpIRU1MWWVmTkpoUHFkZTlESmFiZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:19:00.9960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d0ef63-a0ac-4275-dede-08dd8f3f1e4a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8769

From: Ilpo Järvinen <ij@kernel.org>

Armed with ceb delta from option, delivered bytes, and
delivered packets it is possible to estimate how many times
ACE field wrapped.

This calculation is necessary only if more than one wrap
is possible. Without SACK, delivered bytes and packets are
not always trustworthy in which case TCP falls back to the
simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f206c1a93a56..deced87f31f8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -748,6 +748,24 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
 		if (!d_ceb)
 			return delta;
+
+		if ((delivered_pkts >= (TCP_ACCECN_CEP_ACE_MASK + 1) * 2) &&
+		    (tcp_is_sack(tp) ||
+		     ((1 << inet_csk(sk)->icsk_ca_state) &
+		      (TCPF_CA_Open | TCPF_CA_CWR)))) {
+			u32 est_d_cep;
+
+			if (delivered_bytes <= d_ceb)
+				return safe_delta;
+
+			est_d_cep = DIV_ROUND_UP_ULL((u64)d_ceb *
+						     delivered_pkts,
+						     delivered_bytes);
+			return min(safe_delta,
+				   delta +
+				   (est_d_cep & ~TCP_ACCECN_CEP_ACE_MASK));
+		}
+
 		if (d_ceb > delta * tp->mss_cache)
 			return safe_delta;
 		if (d_ceb <
-- 
2.34.1


