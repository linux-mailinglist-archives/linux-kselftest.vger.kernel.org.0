Return-Path: <linux-kselftest+bounces-35552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA5AE2B94
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD6D1898857
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100952701BB;
	Sat, 21 Jun 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AVeVVdAa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9911C84C9;
	Sat, 21 Jun 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534668; cv=fail; b=lsFYJrIAnpqlP4PE4ZUpcf0m7zFkkslA6YY/OwtIerwIohNM2NkTVpueiUxeLyHrYLoe8zr273GjFUir5roZz7r70EOQcn4BOz0nQjxX3ylHvdo8Fo/n6UKWrJtRHjbkoDujgm9qNXxXAU/STBjvam2UyY6vptY/OTYDCJ5Mbm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534668; c=relaxed/simple;
	bh=ZbyPRv6z1sWsH5d+Qj5FCaTc/VXuaW8FmpJet0AAGSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbA9euf7YfLdxpd6IRZ/rdhM89TZlGRgKQnNh2nve5HOCoZ6yzoYXY3E8pm0wnU6Cii8zW1HKpw8H511RLaUPVhdNFdAovF9VQqKQFFr8F+O+9w8YwD8o+ljXePydzNy2zwB04apEaRwOHq6GMTtvXfai3rd/lAHnyFKNCjMXDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AVeVVdAa; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz5ez4pQna8z/VrRqMebYC7h5BX5tHBOPdNgJHmIJI73d0Y6jpmcboxR4CZEKse3423u7G00ScbqYjX14NRcOOrpxIOUH0g9GSbdUujbdiY2kwPQ+FPvk3DCjCBDqix/BEWctebGrLbHM9gtXGbqSO8KtmUXdJ+dxzQsnwsknVCkn2uzOElk8BPcRKMI1DS/I0oNrV6Gjlkq/1/PvR89H4tQdg8TYc7Kvwgq6guLa/95PO5AbdEoLIguy6g3dzyG+NiOC8iXpqU2WQslj+NVPxh54h38vmyiXdqeHSt9eA75GjmQUZ+JZSKM1STifttA6gO15EEsQ8axgnVhzEnDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+ki8hoHVBS2gNelF6T0t7ouhp1JEoiwTdPxxx3+z6g=;
 b=vwDPTd9b08o8O0tWq1om8gfd4+5hAGTjp42FdalN6kohE5RieehrGQJgNeXtKHFMkdGSdEJWU7J7Afnen8sbT0HKZrMQDVY5yzXqcj9tHPqMikA/lFfFzaUivO92CasiYtt/IW+CwkxL8GpNB3vmzXhcq635Brirpc9hBgGRXLMofGQiBXtgl5q+BXVeIH1T2CWoa0IDIc6l4FtMM4xih6M/XblEM0wqxJJsO+ffT0KCccIGkpDh/biJ/+dWQf0Ft9fLnFU2lkEXskwiS/XJK4k+EkgsUfNgE3Bpho78rOnVc+gOps2GWz/TVEf6s2B2KJcKKN/ZuyqeIJe/yvyCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+ki8hoHVBS2gNelF6T0t7ouhp1JEoiwTdPxxx3+z6g=;
 b=AVeVVdAaAF60O+5A+FfKWtZeT8xFgEaduNRFPORwsvAwHr1xtdfd4tEl4IOy+KOiI8ysbvPZ3MdKv1Rm6uU8dKUQ6ddC3jnrEJEcN5gYEh9+z1kw+slV+u4C2MORM3Re5c7+wnTLSAQ2DdD9MT4ORlA5s/AMwNGSHFomy+IlEyW9fqOeZAeTZtTWDBXUS0HsAOoavhNhPaDoMBk9Rh65O67G6SV49D2RX+Ca1TQpSeYtiF6b/ssw+kLwUqy8bTWnqrlnPNVtiB5i2n8OC0W8Bs5WYmc5ozhfJGEfohbD5EG3c+maX2DvksR2lPb9GmbjejlZCucPymSQiLGTk2sYIA==
Received: from DUZPR01CA0173.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::27) by DBAPR07MB6566.eurprd07.prod.outlook.com
 (2603:10a6:10:180::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 21 Jun
 2025 19:37:43 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::1b) by DUZPR01CA0173.outlook.office365.com
 (2603:10a6:10:4b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21 via
 Frontend Transport; Sat, 21 Jun 2025 19:37:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 6B5831C002B;
	Sat, 21 Jun 2025 22:37:41 +0300 (EEST)
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
Subject: [PATCH v9 net-next 01/15] tcp: reorganize SYN ECN code
Date: Sat, 21 Jun 2025 21:37:23 +0200
Message-Id: <20250621193737.16593-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|DBAPR07MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 136be877-3970-450d-3e16-08ddb0fb1759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEVESkc0OWVFdVdaaG0rMEhHMmFBb1ZqcTdJaFlXcFF6YWJRZnptczJ0VG1X?=
 =?utf-8?B?amlPbmJnZGxrc0lBbW1KaDVUaWlHaHpHMWRaa09kUTlqYVk5OGEwZ1BzVWpp?=
 =?utf-8?B?eEVOLzJjRGpLT0lGNUpVTEM3cUtlM0QzWE9XK1pOUSs3SWxKeGpHaGQxVzdw?=
 =?utf-8?B?c2s5YzA2OUgyTWVnUkxYYzlnSnVTK2dEZ2dlckhpQkUrNDAyS1VCWURsTjQ4?=
 =?utf-8?B?dFpla2U3K3hNb1BFTkFHbVRLVGdzcjhmNUhqb1doZjV2Y1FXT0hXZWl4RFh1?=
 =?utf-8?B?cUxSUmZaTDdpSXZ0WVM4eWozVFpQdUhud3NCSGlDRWs4NUhna3N6dVJ2bzJa?=
 =?utf-8?B?THlDbzVBMEl2R0U0S08xbzBseU1VNnR3NjNyZ0NiMGVaYUhiZzhPQ3JJRlRS?=
 =?utf-8?B?V1IzSm5RSDhTL1BVdjhDWkNFUlRyRXRMcUJBTmJVeHJMM2FxZmVsS0xhdEpy?=
 =?utf-8?B?MUNHU3lpZ3lBODBOMjdlcERGUE5qOEYxQis1eEpsYmtpcXdBaVN6NjNBbjlE?=
 =?utf-8?B?UHpKaFFmdFRhd0hGbmI3alZldEFDS3M0NHhhZGNYWGJJVElmelgrNnM2NHRy?=
 =?utf-8?B?ZUtNY1VrM3NqeXdNYkF2R2tuTjFRVlQxTEI5ZldKUDNwTDY1dk4vZ2w5SGFF?=
 =?utf-8?B?bjZxOFFYdGtwUHNNOTJHY0VXVjdVS1kwTTlhRXVtU29LMWNuVEpFZkxjdUpS?=
 =?utf-8?B?U25JWXVZcENKK2xzWDdCQ2YxWUFLSHpGd3dhQzlVQVNYQ3NVcWFjZjYzOEFO?=
 =?utf-8?B?cC9hWnAxVnI4MjRIQ2Y1SGsrakkrcVd4RElUYjFzZWw0UE0wbUZoa1NyN3Vq?=
 =?utf-8?B?S1ZaMjlHMkM2T2VWL3RKRG1zVzBGZHFRRVdJdUIwQlJ6Qkc3eWM3YzNlS2Q3?=
 =?utf-8?B?OU9LZTd2aEh4KzU4NGxZLzlQdEZLU3AwMGJDcnFYbUJac1F5V3kySHpFZUNB?=
 =?utf-8?B?WjFDSzByWE5xcm04aTZYZ0U5YVNrUzd2bStWU3VRUzczWWdKZFplY29vS1Z1?=
 =?utf-8?B?N0VPcTdlVnE1UzMvRTBPdUpMYVBjcW9RbnFVUGthSmo3TnRzNXpYY2UvbHZC?=
 =?utf-8?B?VUFNcHpLYVNQZENIQko4S292TWYzQnJaYTc3YTAzaTVxQTNZSmVia1FYVFRp?=
 =?utf-8?B?OWk3RkVCYmF6VVhzc2lqbDVtV055ODNNeUZ1QnpHVDNlRnpaRHhmRkE4WmlV?=
 =?utf-8?B?VzltWEFMcWg1OHRTWEZ3ZGVGRHd4UDlnNGtMem9kTzhjVU1ndW5IVFpiOVgy?=
 =?utf-8?B?bi91N3Rnd210QU10bXZUaWFFRTVQQitaUm1wYkQ4YnQxbGJBMjJUUkpZSTdl?=
 =?utf-8?B?MHNmQXhUUUpVVXJoZHdYeEMvNDljUktlZXU5Wld6T0lzck5PQTJhMmU0dzV1?=
 =?utf-8?B?VU1KazVZWGRhUmxueS9iVXBRQ0Y0em9aWmRMTzVHU3ExSUtHdWFQckdWa3gr?=
 =?utf-8?B?WExjcXFvNTFScGY5M1dqb01kSm9PSjkvb0x4cmlYOFJEZVkrY2lhZkZOUld2?=
 =?utf-8?B?T29sYjB1Y1JnWWdBT1lkMVNYS2I3Q2E2ZyswT3VtZkxjZEMrbXVwcW1CMEZw?=
 =?utf-8?B?MlIyeFZjK0NkWVdFN28rV1Q5RWQvekFKdmVZSnk5aGhnNjA2U0ptYUh1Rm1l?=
 =?utf-8?B?RjFxQmNxTUJreFUzTmFoK1VuUEhneDJEUXZiZUkrRzZ3cmk5SHZmRCt4TTdP?=
 =?utf-8?B?L0FUbEg0cDZsN0d2c0xLQ0t2Z2h5azFLeUFNNXF6cnArUzhWUERoNWRqM0s2?=
 =?utf-8?B?cnFLVGR3ekg1cWs0by9QNUo5NEVoZzRCNnVEdlNtMmRrd3FnTW85NnIyWHR0?=
 =?utf-8?B?blgvR1FkN3JFQ1JWV3pIRXlvcmJNYVBJYmhjeUZNbkFQUzc3U1NSVjJ3S0ZZ?=
 =?utf-8?B?dFdFYmdHYlYxNVB2WW84UEFtdldCcjlrMGRYODRvcDBlU3Q2cU9vOUtFV2M5?=
 =?utf-8?B?MWg1WmpETUVJS3J5dVluY0ZnUGhqM0cySVpCY3JHMWhTbE4vWSs1SVVFYkFi?=
 =?utf-8?B?VWRuMzlCM2l4c29FVFlBdEdveGFjQm9HUmVHQ3NHeGZ2UTQweVl1RFRHNEFt?=
 =?utf-8?B?eUdZRDJVVlpENUFrK3ZPTzBpcXVKdE55bGRNQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:37:43.0700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136be877-3970-450d-3e16-08ddb0fb1759
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6566

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
index 28f840724fe8..974e4062be88 100644
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


