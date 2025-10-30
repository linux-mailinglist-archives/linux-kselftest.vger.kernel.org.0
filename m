Return-Path: <linux-kselftest+bounces-44403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB2FC20A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C6FC4ED585
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8D274B4A;
	Thu, 30 Oct 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EaNN+0bi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3F26A1D9;
	Thu, 30 Oct 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834887; cv=fail; b=l2ulUd6YGqrmaqWYCkOqfQI0YvNqLaa4Cfe0DRF++prEBgu3KfFPcGj3I4GC8zLrRFN4rxa/mlhLxxUK04tTx3AXUriALYwUMaE+Wqo/uulg0KegNp3x3sED5Nsw5vFgNRfFOTA/Z82agy2YBSXMTrty5qbYjtqohHNP55mAWec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834887; c=relaxed/simple;
	bh=URyf41vxHRFvXQLYT6pOvecFoPkUnLMw26dmWBEXCOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sX4LkxmWpKhY527dG3MmbtVyCdIRv8tfaOevT7avTSETh65NdNrKLgkGOmdzBQoDOHmbDs2Us7nJb6UU07AyImnwAuCZ+gO8mzL1AmWtg3Ji6JVw17/JUtYGVCr8ZuQynrUrTPG0zTnZQx74NYoXw0NST/sa2ztPPjVT2/dDG4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EaNN+0bi; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dolx2O+FHfB9zKzIZvcflQXKY8TWaLA2bDwtjzPqC2qSxAvNoAQunGPexEnEwHysVwsD0mmQVApeO9EgQA3sTV8FFSJJNfsrRMLHfjOhUnUlhviCUIPfwAuPqOlgbl+0butVesh6wyBjUoeFi4+ElWYyrD2zJ0AXPfZC3RTe6a+4ODRSn63Ucw2SoBxcI67DOWCRmpl2Fg0U/ssySDGKjEUgRsurN/wGu4mBT22Qt11ZSuzl2i9uysMkbZrxJkAB47GCICsoPU+wpfcaJwsmvttqOHp2swRc5TEUDhOQkPEwgIIPN0Bmq9wkmVdIrpbgMZUnoSA3o5dr5ZJAgkJIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=l6V0n8U0zj524JURm81k6kHZwN9rKndmXmpmBTEbtrOg84dCikXO/Fmsx0uSGGfM/TMpngYwo3nJsV39vaRTjMTEVfX8f6g5siQ4GOZRxqKBbreAgdpmr5gjAPBqwTL75R/9d6fIdXCTisKoNSVgqy1LojVSktb8400M/gMECD5JRe2d+AwrWZKPQ/v29mXe3v2GyFDt6+uU3GTpV+42/ClwPx/OKqA6dvkuzrjFtPIgSbi3jTa6G6tIldYaYvl24EbFLmq9S/pKQjFRbQzX5GMSx3aJ8F4X4nwdk59Zr7LgAB4UCztdVrgOqfB7c427gZtH259pp4LAJXLjZYt03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=EaNN+0bifOzsZG1QHLg9ru7BY+FZNOvxXJVBRQVmiChBnrd0o3ZkfdoCeb34eI9GhBlB8X6jGkjNgWyUWtCTS499sdCEF4NJlEVFD5tQk1suFqlGRMKJgOtERbjSVUSBsaqeev0aGyZXx5s2XiDgOmJny+pY9c23/2BZU4NfnZEFc3ZFRBneARYT1Y9Oot4g3pPPUDODSMt+v4noj73MJeEM46AsZkXfUTFKQL2+krNy4uL3eatsim1JErdDrIdaYyIjPqM79aXz1SCB6eSieayskydQ6I7dd97z9aKn1PIQ8gXBjOcuOrvUx8NAofEqDTXyty+Jkkq5UYnqVSEWmg==
Received: from CWLP123CA0237.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::7)
 by AM7PR07MB6343.eurprd07.prod.outlook.com (2603:10a6:20b:13f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:41 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::10) by CWLP123CA0237.outlook.office365.com
 (2603:10a6:400:19f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 14:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 13073202FB;
	Thu, 30 Oct 2025 16:34:40 +0200 (EET)
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
Subject: [PATCH v5 net-next 02/14] gro: flushing when CWR is set negatively affects AccECN
Date: Thu, 30 Oct 2025 15:34:23 +0100
Message-Id: <20251030143435.13003-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|AM7PR07MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: b0baa80a-7dfb-4d13-17a8-08de17c1767e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TXI5VlVjM0xoOVh5NThtNmlQeUExM012NHYrMXhvTzlROHlGUERFM0IwMXhB?=
 =?utf-8?B?OVZ5Mm9rL1B3T2xGanFzNzBoclpRWDZNRUpQUVRrZUQzUGxoOWxUUlVKd0V0?=
 =?utf-8?B?WjZKQktXcnFhRUIySW5jTUlRQllJbW5YRWZWa1ZiSG95aU1HYm5XdUdFUHdS?=
 =?utf-8?B?UHZsL05yZVB6M24zdXVyNVJ6N1B6ZGlrdkhFOUVSZitzeFhKZGdtd0ZieEJo?=
 =?utf-8?B?U0V0UXpMTThwTzZmdFhIRGxyVXRIbzlJQzlFQVV4NDM0MUhUM0syd0VCVWFw?=
 =?utf-8?B?LzhsVTQ0V3E0ZE00TTIyWklIQW5uckhHbDlYKzRaNUJXNmRpd3pVM1FQTHo0?=
 =?utf-8?B?Y3V1RC9ObVh5NS9KUk9aS3NxM0RLWDJhMEtZajlNZ0t6ZUNWL3dYVU5hOFpP?=
 =?utf-8?B?by9pQ3JWMmxLWFR3dE5wWlhyZURpKzdES1JodThKeFJEei95R0xzRzdsSEJM?=
 =?utf-8?B?T3BKUTRiSEFYMnd6SXBvOWNiK0VuUVJORk4vQlNvaEI1R1hkd1A4K0lSNzBr?=
 =?utf-8?B?dmIrRUE3VVNvckdSM0pZSEF1NE9aRTBzNGdaRzFwR0trOGdwV0w5OS9rRVpH?=
 =?utf-8?B?N3FnbnZndlhGMlRPeXBsajE1QTZLYnVaTzlicis4Mi8rTTM0eVBBTWIvdVp6?=
 =?utf-8?B?NitDYnN1NE4vZWRuVjFuMmh2aXhiV1p5YXZhOVBFOEFDVDlBSkgyaXlTN2FO?=
 =?utf-8?B?QUZRMWh2T0dNT1QvbHV4MkU2Q1JHVHExV1ZCRytMZ1cyeUxJQUd6T2hvcXR2?=
 =?utf-8?B?WWhuUGJaaWJ1QnZIc2dSQ2Y1R0F4ajMrNjhqRThRVC9YbnhoL1NTNFc0Qmoy?=
 =?utf-8?B?d0hLdEVoYnBtWUw5NEt5aXNSOTdhVHUweEtJRHNnQlgzNXlrMXljTTJUckY4?=
 =?utf-8?B?R0NDVVk1elZ1VE1zZ0lOSW1mQzNBM0thUmRVR3VrUnpYT2IveXRIT29UeHAw?=
 =?utf-8?B?VFhTSTFMbWxkTzRsa29TVkNzVHFsRlZyZGc0cTBGaEtDNVp3L3o0dE9mR28x?=
 =?utf-8?B?RjFmRHFiUm9WNDVlNGRJSUlpU0VsWCtvVWt6Ujk0SkR5NUZQNnZveGI5MlRo?=
 =?utf-8?B?YjJhekNFRGFXaS9YM3NYc1BWRVJQNlUzV1ZHYUtjOVoycXpTeDBCVS8rY3Yx?=
 =?utf-8?B?dnlzS001UW1tMkUxTk9QL2t1RzYyZ1h6NzVvRjdSMElHTVltTm5GZTJicmdl?=
 =?utf-8?B?MHRrazRuU01UV2ZXRFd0TzdHS2FubHVVbkpyOXNMeHdiNjAxV2EyRDFDc3Nl?=
 =?utf-8?B?Q3UzT2gxUy9vTDN2TlZOaXRPRUliSU5qRTg3Y29qWUJ5dnZ2N1VtbnVlRnNF?=
 =?utf-8?B?SzZBZGVETXl2alBINWhEYTBVbzljVXg1MzlhRldvK1JWV1FSSlVqekhNSzda?=
 =?utf-8?B?aU54eWJBUU40U25RclJrUDQ4QXBkdk1oZWpYUDk4eW5pUEUrZzUzZVVGVTEz?=
 =?utf-8?B?Yzd0aGRNM1pGN0xUd2xkVDZsV0V6aXlwdzZwbzMxdG44TVlYWDQzeUovVEZX?=
 =?utf-8?B?a3VmNGgxblRWTGtLcHQzbUtaSlE4SGFWRG02eUhKZnY5TW9CR1d1T3ZvQnZo?=
 =?utf-8?B?ZGpDNzBLdHpGdGZVQWw0UUxPdnRtb1JUVnJycXYvL0tXd0hER0JWcmdqVlp4?=
 =?utf-8?B?N3VDL3FUOTNzeEFrWDUxZWZUUTBmK2xzZmJuYUZ2WEF0a1JLL2tqYzBSajM1?=
 =?utf-8?B?WDN5d2dEWGhJTndLSlBBT0VXaGVqR0ZDUFZoVEZvOEN3QkF4RUUzL1I0L2li?=
 =?utf-8?B?SVd6NDZRSTJ5YjFSUmdiZHVjbG5NUE4rNGhteEFwSHZGdHREUUxkRk9zMUxD?=
 =?utf-8?B?Zm5FOEdLblVWWi9QeXFUYk85SGxQUEY0bStYR3BzcWZmV0xSTTJ1SjFrSy82?=
 =?utf-8?B?ZXA4NzlWdnR1OURmQXBiYUdZd3ZqdW15cUMwRVQrd1pQL29XQkxGSEgraE01?=
 =?utf-8?B?a0orV1FrLzBVaVBSM2VqQmRWVlM0WElJZFkrVzZkVCtkWFFKZzJJZndiQXpW?=
 =?utf-8?B?S1JtUlBFRloyRWo4YXBJZkZIUFZsNUl6aEI3T0QxNHNla2dCTHJzWGxrbGw1?=
 =?utf-8?B?QnN6QnY2MFJCc3JBNURsdGRLYXVUbnNYZ0FINVZYMittYmdEYnROTTJ2cVJ3?=
 =?utf-8?Q?Szpc4sgpP8694EUCGqnzxwvW1?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:41.6379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0baa80a-7dfb-4d13-17a8-08de17c1767e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6343

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2cb93da93abc..fcbf4148919c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -330,8 +330,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		goto out_check_final;
 
 	th2 = tcp_hdr(p);
-	flush = (__force int)(flags & TCP_FLAG_CWR);
-	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
+	flush = (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
-- 
2.34.1


