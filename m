Return-Path: <linux-kselftest+bounces-37827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC7B0D6BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4601C272B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3C2E6D32;
	Tue, 22 Jul 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aJoeoryV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D52E6103;
	Tue, 22 Jul 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178406; cv=fail; b=S2HhTGjZzfaii2Bhhfos6ln57Q/hXhzfm6X9/J1Il39IXfAo4ltZxLwyPfM1O5sSSYvrd1GhVamDuaGIsO0+9Vyk/N5ZadFnqTAXCAaHX+ypLTAkCYp4q9P0/xh3SCe/hhNBzsQn6JIjSmzGy/hdYj3zwAbo0PYrwMBFtpBS4yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178406; c=relaxed/simple;
	bh=J5CK8m36S0md7WjOpkUAeMGhY1hUR3ckcVWz85fr/IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dp5G83ygecdWcAfDSOdyLcdg5AwAJRxCz4bPJdvjAgnruOPD2ezqAU7M1pGk9M3DeY6hB5X5eBd2J3PmnjhMwgA5GCaePmiE2ej86rzpCJqhOwl2ODSrNWGnrybkj3UgaocZWtew3RSodGp46E0B01eyhh9Uwtw0ljM36yj/S/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aJoeoryV; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujLm3NJqIFfH+1yoOl+H5OrxX7gROr6vRt7YJyug2179jtuMYskFlpmeZrX0tX+k8TaIV2TfOp07aCvujGlgISXP4URkQLti6rrgrGmvc8tbVBKJvgyuBBtIpA7uq5rTXWw2qu8+M7Ied4azr2sAwKatzietD/Ufxuhs/NeZhYX83jvLvD+5MsTQUTsnmiY+K/LMEhTTBXOb8OATIGMYIPmTiLHmmGbiQ824TpPlXasElL8HxYZPiF2Zi+vLW2rASIHmadTgJkXoKzwDPrl1+XaMGujHTRsrRakoYDJYK7F1Jer7Whzq6ZgihITjE/xAIDPiegfd/qzTDDM38PZsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/CYrkUvCErLL+N8IV1S8MGPThtda/BZnDS08TiQVIQ=;
 b=vO/b4LTPJL19lfHOBAihoXlN0V3OrbixjqqCy7XEPLT7UByAnGCoe7O3XYi8Jcgwuz5QzCFsA6BiFTlh2CC0SaMRUZQgsysHOvsyyWZxOkRLsz8T+nLlkGBk014Ep+eUWmPa7KaLzhdWnFN4xz9hcuwKWoH8RXeYGlbSOtO6zCviIZ+iyPcnvs3IE/juMvAxqep7bnEof3dkbSgOZpMJa2bIq3jPqg3YNY9iHzrJuF1LrcpcLXviMiM3kDerfwXjuxGVpbUoeXJdyXg/XGc/GRDnvt+rlQW3X6BWal6S1KQ2AdrP6viw/igazCtFEmwsU1LOaSsKx++EIKyF/e06PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/CYrkUvCErLL+N8IV1S8MGPThtda/BZnDS08TiQVIQ=;
 b=aJoeoryV0iInJdUUKUMbCoXpisCchmTj1HHcKa14xswnEtFy0VFduSpkoaeDpogVpZOxi5mjWhe/PcVbo36vythHg1ZQV1Z7wNn3H0HfpW8JT+9ws0YbMLDHpE1/KTOvGhRr9VvXut409UZtruvql6R/wD9dzG6+FmiobCIHxe+y+MFi49kydbtbPlKHUvgvPavnmUijlSzPdUdarHcRGuRKxaKO1ah7UOHiSGdJUx3F43CHkzOXCHyS8Exg9/SHiRGW7h8E/xX5TQD7+ZvkPHKtHfIe4uSFutHZEn9zGtc5g7+M6H76tt8Gj5DinJTeq/ZNOS+LsxyvlzOrH3e1RA==
Received: from AM0PR03CA0087.eurprd03.prod.outlook.com (2603:10a6:208:69::28)
 by DB8PR07MB6218.eurprd07.prod.outlook.com (2603:10a6:10:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 10:00:00 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:208:69:cafe::9c) by AM0PR03CA0087.outlook.office365.com
 (2603:10a6:208:69::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 10:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 10:00:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id C161868002E;
	Tue, 22 Jul 2025 12:59:58 +0300 (EEST)
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
Subject: [PATCH v14 net-next 14/14] tcp: accecn: try to fit AccECN option with SACK
Date: Tue, 22 Jul 2025 11:59:31 +0200
Message-Id: <20250722095931.24510-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DB8PR07MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f5c12e-625c-4402-f0f3-08ddc9068582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2xYNUFOdi9LcWdOMFFNYXJJY1lweUw0dGtnMi90VHVJYm1yNFpOZGhWRGRO?=
 =?utf-8?B?NWZJOCtUa1c4NmVKTnNsWG5SQzlmWTNzUTNyQ1ROWlJKSUJyZDk3U2NzYnRk?=
 =?utf-8?B?MVltTU0ydkt1RGJJZ3l1Sk9jOCtrYXZIaGhETFNrcnZTTmF0ak43bFZOQS80?=
 =?utf-8?B?VENqck5HQmozcjNiSXFMN0xia2hsVHZnQTI4N2xrdWlEaHkvQU55RkFkMWdm?=
 =?utf-8?B?VmlMSUZHQk1NZDZEZlVQMkJzdjh4M2JESi9UUWVqOThZamtmUk82V09zTGlm?=
 =?utf-8?B?b1ZuTUlvN3Y1bGVLSytDVlNnTUZ5K016QzJGQmpseXJXYnpPSTdpSSt2Qlkz?=
 =?utf-8?B?VUtKYnBsbkhWYTRPZklYMVM0T0NsRHJvUm9SdjhEdjhyMUJOVHlVcWgxQkh0?=
 =?utf-8?B?SUFSMGU4SlI2YU5UUkpSNmZ4YklhbVNhZVVKb0pleHNYQmZBRW52Rk5aODVV?=
 =?utf-8?B?RzFqRE1JNC8yV3VXWndLSzNmYStiZDJUbHMyc2NKZkpwSlQ4alNJTyt2NGZE?=
 =?utf-8?B?Q1hBbmhqV3VMRUVYOWNHeE1pUGlSRFM4d0FVSjhpTll6aXlvc0praHlFTFZF?=
 =?utf-8?B?UGVGMGJIeEduTFRKL2lab2RTbGd4KzFTRmJ3OVJscmVwT3FwYVJVamdTU1hZ?=
 =?utf-8?B?Rzg2T3RYSE1HYi8vaEp5VUpndi9SZXFxOWwvRUNLYXg5NnNtUkRvTzc5aFJV?=
 =?utf-8?B?YkFhbGpBdXF2c0RPMjJOcDJSM2pYeXdvUjFOeEpzc3RlVC9TQyszVTVyQWxB?=
 =?utf-8?B?d3k5Yi81MnQwTlVpOTRYUWRSVkVUMTkydjdKZE9WL2hiNTNjQ1EvVjRqTmhY?=
 =?utf-8?B?VUlNUDk2dStXWTMvZkJoaVVIV0lPMGdsSG1rU0I4cUp4VGhHVEJybXBiUDBh?=
 =?utf-8?B?RDVBV2RXY1lPa1pGRVV2Y01OTFdOdUd3SWhrQTF4elFSV3JISlYyRFE2dG0z?=
 =?utf-8?B?Mk5hbFF2SlZxMStMcWFNQ00xZnFIOTFZZWxZL3pLc0hIUzFHZTdRa0oxNzR4?=
 =?utf-8?B?elpNTEN3cDIrM043RHNkOGtnNmthaEh0VjlCYSt1enFOc2FoOERaZTlnRkI0?=
 =?utf-8?B?ZmxTVEhKNDN3U0xVWFBZcG4zK3J0UmZDakpLcFd4L2Y2RkFyc2lKUG9CTkJ6?=
 =?utf-8?B?c0RSd0VNQWZheWp2anVzQmRLQlkwZDFKTXVyTGVtTC9CSnpOalpqYUZyME5F?=
 =?utf-8?B?dFRKOW93cHNUcHE2SXQvRW42aTNIaDMvRUl5QVVtdHJJRzRnNVBuQXdTVDJY?=
 =?utf-8?B?aklOTUZuR0pVNGxYUVlXRUlJY2I1MnhJYzhGSTQ3bFd1RU5GMm9QMFk3ZTZL?=
 =?utf-8?B?cXdwRWxpaEFJS2ZjdUgzMkNVVGVkVXJ0bC9CSndQWnJzZkFIVnlFenBhcVFG?=
 =?utf-8?B?ZVl0L3pRRWNGMnh3N21sT3dTMGVJZFBQb0lRdnFxVmtuUjFRVGt1NUxQWStF?=
 =?utf-8?B?YW9SSG1lc0lrTzUxRzdyRzUybHlPNFZnK2t5WlhVOWNVQUk4VDJWU01jUnV2?=
 =?utf-8?B?U3p0MWlCTUthZWZiQkgydHFUa1kvNEtCVWYwbGMzUnIvdG4zTmJpVkdGYmQ0?=
 =?utf-8?B?dGxEcjFGWE5GenVIbkVTL21oWnNsblF2RHR2VjZlN1RCUUdtOU1acmY1RXNq?=
 =?utf-8?B?cTVTK3B0S2tIZjRxeU5CQ3gyTVZ3NmdJVlM0dzFUaXlJQ2xleUlBNmlUakNy?=
 =?utf-8?B?MzhHRmZCcmtpRnNnUHFpYnljUElrMnRlUFBDU1ozQzl6YVY5NW55aElyQzJD?=
 =?utf-8?B?YUk3R0w2ZXFpc1RyUUdUTkVIelpnaGhkaDFxdUswWjBjTERZU3FoOHV5NC91?=
 =?utf-8?B?T2YvWVowL0lJbTRyYXVjQXZtSldnNDAwaG9FaW9EekdaU3hYdTZzWk00MTVo?=
 =?utf-8?B?MlZ0SmF4SHNUR2NyajRjY2ZmY3NDY2oyVTlqYThKaUFwWmdwUjFTV2lzV3dQ?=
 =?utf-8?B?MGN3NXZMdHd5NTcvSTRQbWI2MWpibW1WZTdRRkdBcVdZM0xvaWZ5Mi83eWor?=
 =?utf-8?B?TGxDdGlRY1dWb2J5RnlHVU5EaU1jb3FSRUZxMXJPa3RhYnQ3cGsyYTZRaWZ5?=
 =?utf-8?B?ZmtLMzAva244b25GQzVjNzBkUzZyMXBrNG1zdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:00:00.2539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f5c12e-625c-4402-f0f3-08ddc9068582
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6218

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and attempt to fit the AccECN option
there by reducing the number of SACK blocks. However, it will
never go below two SACK blocks because of the AccECN option.

As the AccECN option is often not put to every ACK, the space
hijack is usually only temporary. Depending on the reuqired
AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
AccECN spec) and the NOPs used for alignment of other
TCP options, up to two SACK blocks will be reduced. Please
find below tables for more details:

+====================+=========================================+
| Number of | Required | Remaining |  Number of  |    Final    |
|   SACK    |  AccECN  |  option   |  reduced    |  number of  |
|  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
+===========+==========+===========+=============+=============+
|  x (<=2)  |  0 to 3  |    any    |      0      |      x      |
+-----------+----------+-----------+-------------+-------------+
|     3     |    0     |    any    |      0      |      3      |
|     3     |    1     |    <4     |      1      |      2      |
|     3     |    1     |    >=4    |      0      |      3      |
|     3     |    2     |    <8     |      1      |      2      |
|     3     |    2     |    >=8    |      0      |      3      |
|     3     |    3     |    <12    |      1      |      2      |
|     3     |    3     |    >=12   |      0      |      3      |
+-----------+----------+-----------+-------------+-------------+
|  y (>=4)  |    0     |    any    |      0      |      y      |
|  y (>=4)  |    1     |    <4     |      1      |     y-1     |
|  y (>=4)  |    1     |    >=4    |      0      |      y      |
|  y (>=4)  |    2     |    <8     |      1      |     y-1     |
|  y (>=4)  |    2     |    >=8    |      0      |      y      |
|  y (>=4)  |    3     |    <4     |      2      |     y-2     |
|  y (>=4)  |    3     |    <12    |      1      |     y-1     |
|  y (>=4)  |    3     |    >=12   |      0      |      y      |
+===========+==========+===========+=============+=============+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>

---
v8:
- Update tcp_options_fit_accecn() to avoid using recursion
---
 net/ipv4/tcp_output.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a309fb87bd49..f335936ba824 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -873,7 +873,9 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 				  int remaining)
 {
 	int size = TCP_ACCECN_MAXSIZE;
+	int sack_blocks_reduce = 0;
 	int max_combine_saving;
+	int rem = remaining;
 	int align_size;
 
 	if (opts->use_synack_ecn_bytes)
@@ -888,14 +890,31 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		else
 			align_size = ALIGN_DOWN(size, 4);
 
-		if (remaining >= align_size) {
+		if (rem >= align_size) {
 			size = align_size;
 			break;
+		} else if (opts->num_accecn_fields == required &&
+			   opts->num_sack_blocks > 2 &&
+			   required > 0) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			sack_blocks_reduce++;
+			rem = rem + TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+			size = TCP_ACCECN_MAXSIZE;
+			continue;
 		}
 
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
+	if (sack_blocks_reduce > 0) {
+		if (opts->num_accecn_fields >= required)
+			size -= sack_blocks_reduce * TCPOLEN_SACK_PERBLOCK;
+		else
+			opts->num_sack_blocks += sack_blocks_reduce;
+	}
 	if (opts->num_accecn_fields < required)
 		return 0;
 
-- 
2.34.1


