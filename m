Return-Path: <linux-kselftest+bounces-43009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB9BD56B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D8D407CA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E32C08D4;
	Mon, 13 Oct 2025 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DxiogmH2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494242BEFF2;
	Mon, 13 Oct 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375032; cv=fail; b=fQ+y92FKdkcdkc6XkgiLSNC0HhcIFEFRQBXNklbRqkX5mEn5vY6nYkOz2laS7KcJ83qyDGv5sIFf1D1DSLGwG45BFN49eCtlPS/tvGtjG3DY6Ch9kKEH8nDcOccuRXKH6a2WVRV1Z8CZ8UA82Btlg9glL2QwaIYdkO0upTOxTGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375032; c=relaxed/simple;
	bh=URyf41vxHRFvXQLYT6pOvecFoPkUnLMw26dmWBEXCOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnntoNWlrNJvUnFGjtT6yVcqVAJiC2/36YBTkRVq3wkYe5y86Le3ywLQBUorH+umkCDXVQ3YNjpj3Md3yUzyzw/h/COImv9p2iIFNLBF3fIgYXNgfBfo2AiRdBjU/y+o+fajwrF08BI2P+SxwZ2FdQhJxWO2wTcvvbLlEaTtE28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DxiogmH2; arc=fail smtp.client-ip=52.101.83.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1cuAJnduOleemocj+HRt2SMPzPVkLz+7pBy55MvYFMibVq3vUnvR0TvxBhHTygTaBWh/MRlrfjDLfCuC/3Q5DQFLjNbQUo59Ql7qI+GQU41KwBFi4fZ0fFGdiOalv2YhIwl2GnzozWIcu7V1xrEzL1WFBxNDfoJPJXw7632wV8kQ0j/N12kITj6numlvdaInYae4s3hXYJRkrSKGM/CPDCYvhSOKsNvWfXKEmKSSKCoewucwenC4vfip1qamGRAuVBYlqbMciHll+PSFa17dEqqG/da5xyUYOhGYL8WBUiBW8w4yLYZs+TVcSN+Ue2tvCFu0roqmAnT/3pnquIb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=Oj6kfXlTuKetk+udNRAdikyq4s7+Eq9pjIZ7TgRa4u2t3pocjUEbaSRwmXAorRbWO/8ZX12NZ9pWdeAsyRJS577bnHfYJjFxsvhMpFVXTInjvVyKNTsCOiiEb4QK1QxtZSkMKjKMOctstBZaq6fBw0vyce3bb9Ex1rL57yzyQL5PTP+rZv1WW2JB3ZNdJbe+4HbH24wgV3MlS+Gq4mR7LN+kE+gO8sIMk3PRjhWw5ilhlVM46vqoHr9/CJ0xGNzrqpNTEcEZ+bG63XJJohkwPWevDygm9y2/DR0oAXAN3C6kwe8SHP1yZq9IQ8xdhsDVIuCdqcqxc/OxRKSHBufYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=DxiogmH2N2PRrW79k1TTagjqAiOyPZHPGHG2uMBh9HA83hhsnwUj+aU1kmMROWQnIRgkkPRqaOZ5Sds1AZnF3Hc4IMMlNAongJbBiW+CV/SrOSXtUIUaK5g1VO+mI/syT4As5J2Rj/h87cxQGnd25NYfJk8XGGrYBsOm0d5RigLp2VOerxhBx5BMSgNFmSP8w1dkG2ORgFIu0f5rlRYmEzZJlS8Y1N5M0GiRnEYHpi7rstBEGGlr+46yRWdiU5yPNH2yEMuz/9f1L0AvN9RZyaSff7FCEbwfNxMANK0UMn/ejqM8ixG1qi2bilqumYPuWK6wFdyhaTKzoUyQPz5SOA==
Received: from DU2PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:10:234::22)
 by VI1PR07MB6477.eurprd07.prod.outlook.com (2603:10a6:800:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:46 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::26) by DU2PR04CA0047.outlook.office365.com
 (2603:10a6:10:234::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via
 Frontend Transport; Mon, 13 Oct 2025 17:03:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id A269A1C0010;
	Mon, 13 Oct 2025 20:03:44 +0300 (EEST)
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
Subject: [PATCH v4 net-next 02/13] gro: flushing when CWR is set negatively affects AccECN
Date: Mon, 13 Oct 2025 19:03:20 +0200
Message-Id: <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|VI1PR07MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfc9f06-8127-4595-e896-08de0a7a78f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUl1elNuYU1lN0lMbndFdk9OMDVnM1Rhc1ExS0hka3lxUVlRTXNSR24vdmpK?=
 =?utf-8?B?TVlsK1M3VnZxbWRLaFVDTmdHV20rWGRjZ0FXMndQUkpySnloRDZERCsrT0x0?=
 =?utf-8?B?TVA2V1BTU01XeUZHNFpkVWlZUjdKK1pNR1hxYWQvTWkxUHFIYmdDckJkaDlE?=
 =?utf-8?B?WnlSb2VNUFNHL0xmNXlJSUVwS0xOQXlsTVlzTCs5bjJneUl1OHFoQldvb05X?=
 =?utf-8?B?bUh1c2NXd1lrK25oc0JxWXIrZG9ZcDlyNy93YWh5YXpieEVJcFc5WFJyUlhY?=
 =?utf-8?B?NStqdzZqS0wzR1F3U0pZTzR2QjBjZDlJMU53UU5LMVJGaThBUDR5M1VkbzZs?=
 =?utf-8?B?NmFrWFJTTUFqY2lFUGQ3RjVVMWdRb1l0N0o0YzUrTkNDYnZydzFRYlB5cnRK?=
 =?utf-8?B?M1g5bmZXbmozRVFWMmNGd0pGYU5jazNTa2V6WFd4dHB6czcrSE9tdWo1QXJV?=
 =?utf-8?B?Tjd0U0tScmdJU0w4VDRoZkM5RFFBVDJJV2tGaHdDSFJzVXVqemJRblZaaTho?=
 =?utf-8?B?T2hYaUtGdFNvOURvU1FoR1NEK1p5SHk4QVk1dVoxT205WWFpbzFjSkpJemJQ?=
 =?utf-8?B?UDlZOHNjcnRZMjdId0IwYzVSdWE1YmZPZUZWbjJER2R4a3hsQlpvUUJJcG1s?=
 =?utf-8?B?OVA2d1R1L21nSitFZnFDeVNjck9hbVlBS1pTZ0NjQzhreXIvT2RZVWRyWUoz?=
 =?utf-8?B?eDUyRjVPVkFsMEExRnVGR1ZRT0p6aGQ0SHd3a0JPMlorQmhyT1NZRFdzVkxK?=
 =?utf-8?B?b3hxSnN5Z3diM1UyWnpWUnFBL2htYzcrVFZ2UlBmeGRKQklDeHpHaXBzSlpT?=
 =?utf-8?B?ZWhCck9tMkxsQjZtcmZzZ1U3RlNEVlhFbTlKQUhidzhXc3dvRU1ITWZkUG8x?=
 =?utf-8?B?K1liNEVBVDFSNHIrT2cxZ3FVODYrb2xuU0FpN3cvYm9vbU1wZi9HUHJ2RXVr?=
 =?utf-8?B?UlUvWEFaZTVrSjREU0FWOHJpYnJlcCtPeE9IdTdCeUIxaVM2M1V0STVPK2pQ?=
 =?utf-8?B?SGJhUEVaZ0MySFI1cTcxZmFucEN1VlUySzV4UzhCMzN5STdzQkFiSTAxcU90?=
 =?utf-8?B?VGhtSFQyY1B3NkxQV2VSdlNTWDcweFRKbXBXSFRJSXJLQklQNVoybTdUL3N3?=
 =?utf-8?B?elVpdDl0WWtnYVJYeExFWWdHTk9DbGxDSGVpMXB4S0RhM2RYMUZydHVqMkkr?=
 =?utf-8?B?T2ZnbU5OQzRCdTN5S3R2NG1zTUR3Uk5NSTNRVnpWbElYVHZ6dGFWUHNjU3JE?=
 =?utf-8?B?VzFIUlI3ZXpKTlVVQStCbWJBemt5VGtBWVh1TVJSaUJ6VlRxdGJRSjMrcHg4?=
 =?utf-8?B?a1dGblhwaTg0bTYzQ3UvbkJuWC8rZVEyd2VIak81ZWVPQ250Tm53QnBzYnNq?=
 =?utf-8?B?ZjlKRHJ3SDFVWE1kSzFJME11OCtTQ3puNkx6Nk5Jc1ZYbnR0OWpDOCtMYWZo?=
 =?utf-8?B?VnNPNk1jUHZKZG9pbHdoaEY0TDZSamRENGNFT05KRG56YUxUOVZDSUVCa1lR?=
 =?utf-8?B?SGw1b2NlL1RuU3ptN1J0bTRFb1BoQXlPbHFwcHExN0gvNkNTcktWakxGYjhE?=
 =?utf-8?B?QUdBb25Yb1JFclQyQUJFUHQxV09rVmRxQ0NXQ0FSWms5a3d2OTJLWTRaMnE0?=
 =?utf-8?B?RlRYT3FzeWVJdWpFeURBN0czbmZsbjJHMnl6Rkt5UVFRTkVadm05OU9tZElh?=
 =?utf-8?B?VjhLb1ltN2tOUncycDJWZnZaOGlOcTdXak5xMmJaVnc3WXMxd1JpanNJSjdH?=
 =?utf-8?B?b1crYm0wN1V1NE5QTmhZYjRSY1llMHpSNDR5QlcvYkp5VVlBSFRpUWltNklz?=
 =?utf-8?B?TnMzNGF3Qm8wVXFBQjNxcUxXTUZjN21Sb2hMK3J4QXBSZUxOTGlQQW0yNjlW?=
 =?utf-8?B?Q1dnSzFtUzZhdEJrZTJRNk9NYStPMkczdVVLeStHb1hQZlA0YjFtS0JQZHFO?=
 =?utf-8?B?amtmT2ZtZEdYdXBua1R3VDZDczRWb0RseUNQZTZnampJUFVQd052VDg2YlNB?=
 =?utf-8?B?KzIxejVkNXZxSDZaS2lkcTMrdmlBbE5DRkVsWU4xS0NVaThwTGRXdWR4TVdG?=
 =?utf-8?B?ckMwcnZjZFRpRmt6YTRkdWw4QXhiTlYyck1CeFFUU2FjRnpCcUs5SFVzL2sx?=
 =?utf-8?Q?r4TZ5YA27UJokTaKBuBGgd0Zu?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:46.3780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfc9f06-8127-4595-e896-08de0a7a78f1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6477

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


