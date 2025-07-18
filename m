Return-Path: <linux-kselftest+bounces-37565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46056B0A611
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578385A58B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1D2DAFA5;
	Fri, 18 Jul 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CBUIb6zI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F1189905;
	Fri, 18 Jul 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848454; cv=fail; b=Ph10ULjYPjyZN0Q+PRIqmSYJ1Lld72ed7QD//Ou9Bko+CQ6f1a8lo4iYxVkujLQyYiAhGVaqFGmax6VFuQzUks9h2fqDe1ol7o0TNPXme90g21WaDJkuUv5DBBpvg/ag0qAFqSZFrwpbhjySArgCY7VRxfh0I3hhiItOKhGkZcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848454; c=relaxed/simple;
	bh=QheIjnkZhAAj/gUXxo2UK5OQhY+fZUG8lLWtSanvv3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq6/BXMIuhnzwnaLeevNKVWY7qz44ePSPCamoQ08JI0aGiRDqRWSxdTLYIwSQgjppYXclP4WnTn/waxvxGYA2Ys8xe5voJtNj9fDAiMbNvYnUqfArpG3ghc991WRN8FBXYTKt2ns0ExVxOPUHj7ZKlFF5yPx/SxrDBfp9yk4dRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CBUIb6zI; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyPLBDPL9Hn1p2log+EB2IC5q4ELumOxoGrJ+E4myZLD3fwcQC7l62gBcMc3jOG3H9iDWRPrzuWhsXHfw6dLdH+HypQuDILgERZ3Ee7O1OvR1jGcGSR6rw7JoZpcXvuNCl7RLRpZ3LOk4qQh0jDYrJ8UYhwT34UtVTMQ50X6+oqTSQUeJ3Y1Fz0XBCD/r3Zno+ZAsCaCRYhUtpidYZw6dIJ/bKzfV67VXTQc/f3NSTQT78xLsNyGHWVAEr5SmlHqwEvxld8PKxg39pW3w7utL0qaZzMwD15GHvtuASRA4Z8GHQAw0Ej2byr0CFpwNMopI78e5BTRkoPBlccKE0xDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=ZTgMnmS4wTOY8qPVe/EIpNRSpc0qfMdXxcxIFkkg6GpASRW4DAw3lR21U1f6S+0JhSKn4rz6E1OShbEtwd6SbpEt/XtxhG6eTkJbH2NiXQsat8JRrNCNcn7TBqdeHsIqboqDDYa9Y0mvyvdj+XUbR7uNPDtYQacqkvtLRnUYqNmuO0/2OYL+KwKFJFgmY/dC6X8V8bkuYVFKSAlhr4V59ibAPNhUlfbK8uqNl8UpwoTcv19ice0NthL5CHrwb9o9cZTO5uXdH0fGT+dLl1H6z6OvnmcPpPm6sH4bjgRPWs6OZXFFCWiuSNWdMtft/26sqx4MtdwDWYoTYc9XHFicjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=CBUIb6zInehs7JB/cQqrTh+YmxMBecMHI0N+LHzjt69tqIaZIrFjXhdEnBf8l4owtlSNiisVrA3hoCBylG+mSfsaWle9lnCTXuelAg7wjazkUpwGKxYTaPtnZtnIVKaK82zxLjeNL0KphTnupwulQ1KLMbT1NIzXmNDgf+NkGdytgJsaDPvI3qgkxT9gn4oQiPs1Kejtty0z5dab5W3zw8e21kmYK6qx/KY5tufyqwidyQwW7l3+GtCMJHO12u3EAnbx1kvZhMphoE62FRmdSNDD7AD9X40b+Bhvhoh3NgLwn4O6vtMpBTDEniA9JcYByMj4cfagjz0cD6AtRe7zZA==
Received: from DBBPR09CA0027.eurprd09.prod.outlook.com (2603:10a6:10:d4::15)
 by DBAPR07MB6773.eurprd07.prod.outlook.com (2603:10a6:10:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 14:20:49 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::6c) by DBBPR09CA0027.outlook.office365.com
 (2603:10a6:10:d4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 14:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:20:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 5F270201C8;
	Fri, 18 Jul 2025 17:20:47 +0300 (EEST)
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
Subject: [PATCH v13 net-next 01/14] tcp: reorganize SYN ECN code
Date: Fri, 18 Jul 2025 16:20:19 +0200
Message-Id: <20250718142032.10725-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|DBAPR07MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cffdef7-4594-4c1a-343b-08ddc6064b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXRBSWtibVloSDFVbVJOZ0N5SUdpNjNCN3FwdnpCakQyaWZFQk1ZZFZOZVNL?=
 =?utf-8?B?dCs2cEttU0NpM2hBc2ZYMFFDTWFSbGRUYVBtZVhFRVViUVNjU1ZCNU1ma1RT?=
 =?utf-8?B?Sk90dEQ2S2RTNjBXdFA4YnVwei8zK1o1cDRBbDR3QnRqZTBRNlZLb0FhOE10?=
 =?utf-8?B?dythcE1NVXA1MUFTeWF0RGZsMHA3eC9SVTV5Q0dFTTE3NXV6TDdXdzlZV0hq?=
 =?utf-8?B?YWRYbUp2UjhLQncrbGpsQmRvNExQZUtnVmFpU1U0OEFkZG5WNmpLVWxuM2Rq?=
 =?utf-8?B?MlIybWc1SCtmWnV2Uk5adDFaRGczMDFUSnFOWWgzZ0VnWHJBMjRQT3EzajFX?=
 =?utf-8?B?KzNSb0dvK0xDYTdSZkhwRHJoK3dBZTBzNWl2ZDExK0dtN3JLdENwUjI1TWdL?=
 =?utf-8?B?YnFybSs5b3lYUlpqY3p5QUQ0Sm12ZUpDeHhTUjI2K3drNEFDL0FmSVBBRlFQ?=
 =?utf-8?B?YjlEb0xvY3h2TmlQczVjMjFGbnlxblFpVEFIOWttV3d1NjNDTHNEekRWbFFz?=
 =?utf-8?B?dXVoNll0amg1MjBadVNQSWVtc0RwMmtFVkJQQWhjdG1RaUtsL2Eyays0ZGhh?=
 =?utf-8?B?YW5IamEzcytwbFQ4S0Jkam9rNDhleWpmNkUzc3YrdGo4ZkFFanBKelFFcHd4?=
 =?utf-8?B?SVRuQU1WRmhZaE0wSkp0akJ5dUlPNTFPWG51TFEzWEtKZlFHcEg1b09zUGFS?=
 =?utf-8?B?SDVNaXJDb2VHdzQxSElWYjA5M1FwOVE0SGptZUs4UXMwdXNaTHYzTmdKbEV2?=
 =?utf-8?B?NFJXSE1aQXBOMXJNODBIc29qMjhTbEVWNU10UmZRUnRFUittWjVBZEtCYzVU?=
 =?utf-8?B?d1Fxa1lodWYxT3lLSXlYR0lZcGV4NmpPaVJud2JmT3NyeTRHQ0k4bStibytu?=
 =?utf-8?B?UVZxaEM5SXJQK1pwRnNaUmRTNzB0cHNFdDVreDlUNzlhTFFOeW92NzNRTDQ5?=
 =?utf-8?B?UXhiZUNEdyt0dnlxMXNQNUFwSXFhMWFmOHpjQjBrYk1mS0U4cXNzVE9yUDFJ?=
 =?utf-8?B?WlpVZndmOHU5TXI1SFlMRjhWY3RQdDMwdnpnVm1VQWlhNXFjWUtyVnhhZm02?=
 =?utf-8?B?SURqeU54MTVkbnNVQS9wemlXZkIrTHNTMzgzcGlFS1VXWG12SDVpUFREL0lG?=
 =?utf-8?B?SklVcGpzTkNqQy9nRlNvZjBJWE5NUEJVOG04TEY1dnVXbjlxc3NtaTRFWE1x?=
 =?utf-8?B?Um5iN290TVMxaXZKSGRVYVkxTTRoZkRrNnl3Q0xxRzZacGdmVG83TnBGL2o0?=
 =?utf-8?B?cHNQTUl3VjU5VUJsMkRiZWpUTHpTUUdsc1laRGgyRnJZL0YzRFhkd0tFMVBk?=
 =?utf-8?B?VWJ0U1UzS1RzQ1BpNlFkM1dGZ1pGejRmcXo5b1hXUFFFMEdLNlUvbE9vMWpJ?=
 =?utf-8?B?cTRxNUJ0ZHgwRGMwM1I0ZjRkemI0V3lodGhFd21GM0J5NWMwb2VGVEdEZW5C?=
 =?utf-8?B?Wmo4aGppMHVMMWZ5S1dCVWV1NWpCUGdKVHBtRDluN1BRZzdyTDAxckNUQ1dC?=
 =?utf-8?B?YnorZFdEang4ZGw0U0Q2SkJzRmViaHdmTFZmekdMVTZFbGFuWEZWRHJmQ3h6?=
 =?utf-8?B?Yzh3YWpwV1JnaWdub1ZQSjFmeHFmWnJHME1zOUJiNFNERURqNnFiUzJHRjM2?=
 =?utf-8?B?M1Avc3FFd3pLNkFoL3B3MEJydWxUU1NFZWlHWjY2UituYUVNUXAzVDg4Q0NV?=
 =?utf-8?B?UUNlbjdVOGhURERKcFUrV3JVY3VwcGFJdllTdjdRazZMSFpqYmthY3dwVHpj?=
 =?utf-8?B?bHdFQUZXOFNmRk50dS9NcEJYMzVxdms4eURNRFBQNTdWdksrelNYN3VSS2pC?=
 =?utf-8?B?WkI5cHNadmw2ek9uSjlrNDNERjlmeVlEMU5rZmVXcWZnT05JWlNBWmJkTDlD?=
 =?utf-8?B?VVFHM0haWnhmN3JxSEEzODB5Mjd6ZjUyQWdrdkZwU0tpL2dkWUppZENUMVBr?=
 =?utf-8?B?TElMNitrS3B2bjBHUzJNOFU1cnBWRTg4azNWWW9Uc3JndE9IdU1FdmxFV0lY?=
 =?utf-8?B?dkxzVTZBNllRYkpsMTJnSnFkc0QvVS9qN3dMMVZrTkppVkZIOFJrREtSUmxL?=
 =?utf-8?B?OEZzanJac01lM0t0QTJsT3lRWWVRWHR5enIrQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:20:48.9968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cffdef7-4594-4c1a-343b-08ddc6064b3f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6773

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
index b616776e3354..caa980c3f25a 100644
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


