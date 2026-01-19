Return-Path: <linux-kselftest+bounces-49405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B24D3B69B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9762530F9BDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8F38E116;
	Mon, 19 Jan 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jr0wggvi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD538BDA7;
	Mon, 19 Jan 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849173; cv=fail; b=fOwEObboPqUKheExs47PLwGGC5tto6BvmZ4y0UZyCaeR6ZdcD6TnFk5a5ufLrbMMjaLDi01bf27Eo12mBztCTLmYOmGB4VGNUDO7NsEug+heFIRCR+hAOGGdoFEysuVTs2mV2REQg1C+Xt6uqnsKcdC/funxsv4RI1G8hZWlyVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849173; c=relaxed/simple;
	bh=bGrDa5EkVhUN+KgRlhyfCNJ/vfklSbtm7Gj3iIz80Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGi7AZ7LNSVSARMQv2GriYWq2wI0cOE6AgrYzkFW6QulD8FE8MF+4RdODyBYf9szKXrFreBu8PhvHEOmbQH9j6jVUYzREcVf/8itqhjZ5LvoOy8msJHdskdvSenQ+JaggB0oo7wfflZx+6yRVqwSYbA7bOOIlZr/0Ou8GIPOxxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jr0wggvi; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AreNceg0YCmXFnYM+79yOy1UICzF/HizEEp1fjoBdAZWECdyyz+Q+zDoBm2FS7RuVcOABx9z3vXb3ignp1AOWxBU6v9dO9Sr7mLvPtS58KiNLkhwYqVuya8R/KMI7hIxOotRIWO5fb0J8N1e5eRNzEC9TEqBRgHxtZ+9ANiKh5VVtnKWHfdEspdtzyzliXccB9tigyT18TnLH2GmD1m+/2Mmd7dmTah0+kDI9Ml34dB7DCYIzBgHqsMFTF/GlbaPITpd3kTFBrlAM7MKgTq72rNIXKVDgTv/d4tykTRWsSUcasIfvNHgeb0PwH0Od5k5mL4hVujGL7Z/t0LxnKT0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr5Wlj5y4UaCCLUMXC/uQIvk3dFXSguLdULxWSqrRwI=;
 b=MBk7FaLANL5VTWs01tX3q9y8E+lr6KmMMFdncUarJAfZ+EG/YklQ01ajvTBRev44LXeSW0hkdBlsdu7wqOPsf2sK8M3IxwO50bBdAc0WuSgbVOoeUSpKUWZTCyVj6SD2RCmBL1f5UjtutGQ+a/C049Xe4fB60iX+RaIQiZ9HEhbyssof5evba80PeUFIdERbBE5144dIZtrHRVQQfYZbsdE92seE2w20RJ/yALsUKoT8LJYHZ7iRLt2vJtdfvTJlFomTHCu8yqwe0xSz060BZIk9TM2ScJmHaYC6MXF5WDdx/hfEqH2/7KnKe6EZTIOrI8MZ+1+8wYGUu72Hip1VBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr5Wlj5y4UaCCLUMXC/uQIvk3dFXSguLdULxWSqrRwI=;
 b=jr0wggviNU2cPd01J4ZbhnGdz60sldL+0x8UYAomkVpWvASKzXxyIf4KVFsx2sBPqX28LiQM0Gb6n+1prRhuBewQAcjLamQbcxmgriICkZUWy8nCMwkXpw8vbJ2FaowlzGjrajCJw9mmwiS76moewzqlXza2udBiwxWac2tqB73HgV93YksLfE7jEW2VKwzNwSv62EiPYHU1OQVsJOv4Hnrwfwmu5Yur8JO6JjFjYxBvRofFwh3n9SIL/yQkxR/7uCjdDPgQjqLJkvjdVXBqu6g5kv1fXyg1OuSetm6eNlizykxe9Zwm+fHFCs7+ODXlweE5VwVQatO0rACjVJlvhQ==
Received: from DB9PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::19) by PA6PR07MB11293.eurprd07.prod.outlook.com
 (2603:10a6:102:51f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Mon, 19 Jan
 2026 18:59:24 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::29) by DB9PR01CA0014.outlook.office365.com
 (2603:10a6:10:1d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 19 Jan 2026 18:59:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 3F7CC2014A;
	Mon, 19 Jan 2026 20:59:22 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v9 net-next 11/15] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Mon, 19 Jan 2026 19:58:48 +0100
Message-Id: <20260119185852.11168-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|PA6PR07MB11293:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 124782fc-b8c9-4e2f-49e0-08de578cdc77
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ztkQvP/vxBiQnosUXKTh1t/5QbwdpLX/AqPILnj4Kk361wlC9PzySqkkuEDG?=
 =?us-ascii?Q?n/syDe8ceURcMP+LsBbY3U+6w+krjy2zIR/Dl7OUU6dGb5o2sMeY3fX4Q1Iw?=
 =?us-ascii?Q?4sZNuXy5OqLflDRSgoh+qpTZgU1IH1hZz5fVoXPuU6lr0x+0xFTN3UkCLQ4W?=
 =?us-ascii?Q?4X75RT48k0sdT71oT3A6q44hLt1Th/ID97Zg+5MzKc3BCMPj3H1hCklorevs?=
 =?us-ascii?Q?MahCNX8UwilHNSxI4doHm+O80weL1jnPwJicV0I99kL24WdH9kF19Tu+tEgw?=
 =?us-ascii?Q?95j3/+Wm1+fway+8qsSuAdI/N0P26EPItUUryvRxxm2WIO85vmw74zrJt3Z/?=
 =?us-ascii?Q?j/MVou4+WSy9i+A3pIMwEYnQBCPbcHOfEJ7aM0ERMTB2URi1Rt4UEl5+8kI6?=
 =?us-ascii?Q?hs1ulIZvH056q1Tj38in4jLxBa+SAMFdaVB26rjvvwcaw5g9UvOCQNw3R0V7?=
 =?us-ascii?Q?0IksL2iAJ0F9y8AmtoQ6+b2zaZVhaSLOEUnBffVRwRdkWl6oeml3RP1nWRh/?=
 =?us-ascii?Q?11Zxfyg0afICeEWRsM4nJwG0m0fl1ZHYgVa6XCNUwB5jUK5Id91ziqH/GQ5y?=
 =?us-ascii?Q?rRbUB01Vv/cf8xMGGP+RcAPFG0Wf9eJ1FakZmbxYl/GjHS3ZvdyBJa3mHw2+?=
 =?us-ascii?Q?ZVSZvxUDMvfYxlQJrJwAqEu1U4GXGdPAhisgjwmIgh2eGa4LPLr61KkEgIwS?=
 =?us-ascii?Q?T726DOerlljUe5qGwbyMh9nraRG/XkNU398w6XvMCk8hjMQXzPpBTDsy5KP1?=
 =?us-ascii?Q?31YR0jNr+QuvDkCbT+rkYDhI4xqVsp2hWmvjX9sydhUKAZJJDmqVzvqvpUih?=
 =?us-ascii?Q?K1Ybh+APZp7ZvLE8sHBHSRioWrzos3NVE2WOi0sxEWIF7IWLvM7N1HDzrBEw?=
 =?us-ascii?Q?5c5Zf8veOQzIOPjJ+FGTWfpmFlubu1ae/f944THHvDXG/D5/dmqTLfPl8xg4?=
 =?us-ascii?Q?bys0qguwhkf571KSl4VpNoru+z/2LEd/zujO83/z8158aqn+0QQXWCzf7vlR?=
 =?us-ascii?Q?rVkOryl6+3Urfz24GfEvDwUlvwwTEok1zPNWI5t9tQkS9Dw9NxSaL8TK0cST?=
 =?us-ascii?Q?besvTn3J3BDEiOyRvdxAw1ujncQ/z/aXD6JyIijfoGRvX8W4VdSuvZzJB1yg?=
 =?us-ascii?Q?IKGUH3qbTdniYsbkVoNonD3iOfqDFosIOVAnwzHLgjzjXtotp0LWDMAdwTYt?=
 =?us-ascii?Q?Ne8yfb9CuHyCJdQA3gIMdaxQ7rZbKzp2scnJoR4MoYMlGJ8k8s0wIMFDb/f6?=
 =?us-ascii?Q?Qx7fQg7NpEplqwK1rvrAzO4eo4hQud8YDAEjWMJWNC8NXfbLx4g1gHw4lsUh?=
 =?us-ascii?Q?OA2cvCgQRuj+IVqJjzdk5YgI41/GY5apJXkd8SeIAVjr1wPNNAIZmf7YqAdi?=
 =?us-ascii?Q?uccHMMEmqfyHs5Ph/H0FhdrEPOF2G4YhTmM6V0JvJ5eyAOTR5dlplVvyVv+H?=
 =?us-ascii?Q?9JaHWX5CbDPAeMPUXWSK32KjnGmjLQyejA2+zIuCL9ShlbUSl0VWpXnc6g9z?=
 =?us-ascii?Q?usTX50A4HGgDv3A2bf+xWfhwZ1RHTSPy4UGiKE/Nue0r3ga4bQ8d5f+PzYts?=
 =?us-ascii?Q?zb/l3jwq+1+ocBzw3RInttnVxo0U7V0oQEEvfAiT+8zlI1xE3dcPW4NvUobE?=
 =?us-ascii?Q?tLQj2fqGUlemDJs2zc7qhORCbJjxzNJz4W+65eZKV66UqXxBrfQDVZ7ltXvj?=
 =?us-ascii?Q?k+Bje1k3L9HkmxCWHsxvEiNR2k8=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:23.8239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124782fc-b8c9-4e2f-49e0-08de578cdc77
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11293

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f5e1f6b1bec3..bf7d3f9f22c7 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -182,7 +182,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


