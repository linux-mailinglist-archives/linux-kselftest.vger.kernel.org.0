Return-Path: <linux-kselftest+bounces-39083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D2FB27B90
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF321D02178
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E82E4247;
	Fri, 15 Aug 2025 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Kveeew0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4B2E283D;
	Fri, 15 Aug 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247215; cv=fail; b=A8euFZJoH6LHhtpxmHosbjhjuTB1BcZp3U87JuK3Z934guaKgeRKW3IJJshw5g0KUGTU0ELitHLR6W+KZVmRto8jJVVhjNZ/+J3JolEEYxWsnXrvviGq8NuQMmUW+TuS6XSbIsdLzNcms8ddxI7fp+ML6pbN9dHHHcT0/hWN1pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247215; c=relaxed/simple;
	bh=+c3+qixrC/Y6ZF8ht6/sJga8Hq9UAEdcdn8H++2eJ0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pep5dEPgLgzv1Z4jlEyzdgvHIq5/orjcHONDhTm15JXtJjb+N3B/5synnK+gDXpwD4MrcVutH5NPfb8ehkPS9GU2cVXD5RU0dFT7A+5kuTwhVVvqH6MhYsy0eLn+sQBsoG8pNIbm1JUZqNsyfxhmmZIkH0kE3tVzJtUxILM3V3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Kveeew0U; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haBE/9x4iPpEBzxtY3OcyQUOhb5g83wfEMpZX4KgX6AbU+KDuBwDh4/usA+QGibiIQrxOsD2NMrBdMjbfLL3vE0rDBmENTvAJIORtW68QUBYyknqvPUJ838tCMlEeBcfXzznnm+OE54Akh0rel9j2sFDv7njKEifQFKRKhx3tZUj5Rc3mu2e2EOCTqK6AfFWvUj+wWslRDKOnKyv/AvT6l6fUAQ+xjV92Jkxjjamfli41hmLJnX0++5pOOVpOF2UwOTmD4JfibiGZ6x6Enmqj5+k95ginkb+El/fgLFfUMv9NRFo+nJHRZfG+uhpOh2lN4XAf8iOYa4rlk/776nEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Muu9IXfrMhGRMv3EYAzn8r3ZNWQFwYt05U00ZAMJwaw=;
 b=TRIYvjAOIR1yot4ess5dVqt8oKN+9Qn1NvIlYJn2sNvUvEf/6EkciBJEOUD4Daymu/HnsdyWFRl/lmrQeq0s90Q3BbZVomh94YwF7+rfG9tazSoMVqkMOrRPdljr/ESOa9+teHro5Celv4zkTNq3iIZJmV98HceO16XCLHcoTZjHT9zW43TKrsSTeiJYbZb85SO+SFvd0bFFf8v3JxaYGDVDkOmG8aIsOycTW9V4Jm/YFfC4BHqtmdWzNu4rannScqm4IBhV0N4LaP01x/XeH6mfrwfq926/51XRd4kZUmjK+cXuE0GFowvU6HT7aIt4I/9CJr8356xulR+2J7W32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Muu9IXfrMhGRMv3EYAzn8r3ZNWQFwYt05U00ZAMJwaw=;
 b=Kveeew0UZFBd52le8PnhnEKSbCn3SDr/AHTF0QUni3W7+NQGNu2wkjAyiEyutAEwJL77t6VEOBgLeSb9R8d4A4nHOEll3QPA5NMscn0FTTt/MRXgi7/DcePRxDSuoEDGg9IWhDdz9JUTPIoP0ZlUyBkc0ioyLB+QQr/PNshQuRrZtGlP+0sJyiPLs0Y9Caewqz4VHFGdJv+YKuY4920YRu+QC/Unqng29NxBeTS31g0DMJBhAC1lVMiyBjBxvFzlSqkZUxcVhQKmvAt2I9VRIzR5bx8nPODkzKYgvaq9RxAEKq1U+uj5/zRD6A2+/SQRju9uwDFoEWOXU0hwfc9uEQ==
Received: from CWXP123CA0004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:73::16)
 by AS5PR07MB10569.eurprd07.prod.outlook.com (2603:10a6:20b:6c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 08:40:09 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:401:73:cafe::f1) by CWXP123CA0004.outlook.office365.com
 (2603:10a6:401:73::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 08:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:40:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0B5561C004D;
	Fri, 15 Aug 2025 11:40:07 +0300 (EEST)
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
Subject: [PATCH v15 net-next 14/14] tcp: accecn: try to fit AccECN option with SACK
Date: Fri, 15 Aug 2025 10:39:30 +0200
Message-Id: <20250815083930.10547-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A66:EE_|AS5PR07MB10569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0dd579-5b61-4c17-b26a-08dddbd75754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnkwTGhvQ3Z2TnlJVzNXR3R2dGJ3T3EzaWZHTXczejFWVGJtTXcxNWEwYVI3?=
 =?utf-8?B?MFJaRmtGOXNxVE5ET2crWFVObk5GSmtRQVZRRW5jakxtd2NNYmxERGQwV0ho?=
 =?utf-8?B?RWxwRHYzNUp4VWF6c0NtT2F3SWtNM0M0SkJNeE5HVENiV3hQK1hEaEVCQXd3?=
 =?utf-8?B?NW1mRW9iQ1o4bExlU0svdkk0M2JXWDRCZ0JaZzhQcFZjbnpsZktCMkRpTEtJ?=
 =?utf-8?B?TmJMenBxOFBoc1RLc0tTVW9La0FSTmRydEFVZ0J3MTZsTzIrUnFzd2llTUhj?=
 =?utf-8?B?SmlKU2JwZlowZTUzcjhkZE03MUZCOC9GaWpkK0IydnJLY2VkdjdnbkRHNkVL?=
 =?utf-8?B?YzAyT2QzQmQxNnhzSDdZNHBUMFdtTG9wSVQ5NXBUQ0pzblJOTDQ1ZTFSMG5P?=
 =?utf-8?B?dWtIeE85UDh4Ni9iV3Bib2diZDlCaXF1TzNEcEhlWHZxQklNbERnNWRFdjJ3?=
 =?utf-8?B?UXBIRVdLMmFpOTZrZEZqeTBqZ2pwcU1iYk5LVysxZVJVV2hwOWxSQzhULzkw?=
 =?utf-8?B?anZvUUs5TUxlTXNMa3BDdFBoNEJHeG9Scm5sNWd2ZzdqMysrYXBmYyt2VE5m?=
 =?utf-8?B?d2ZTSlJjWFNMWXhsblhpeVIwanVRS0h2Y1gwMVlBK0FPeGlSUmNUWDlrc3lz?=
 =?utf-8?B?OHhHdlhFd1NyK3BTdDhjakwxUDdmV0xIVTcyUDJTOXNOeCtFc25Ka0tlZ3NP?=
 =?utf-8?B?RE5EemR6aWVRMEdYMWZPaGcxanFGWlFRa0JiTGdQbHpKMUJ4dUxPMWJRVFdC?=
 =?utf-8?B?Yk1CckdqMVV1dk9zUXdnaVV5N1RYakNRRy90bEpWdkdUQ1hoYXpsa0xnUVVT?=
 =?utf-8?B?Rm1VRys2S0VsMVIwamhYMndlMWg1cHdTb21LRGtiSU9zUXBNdGE1ZWN0eGtQ?=
 =?utf-8?B?aXl3YUw4dkRnTHRwa2l4eGxMNlBjM09yMXFQSCtFVXVFZ0NTNkVqQjRxK3lF?=
 =?utf-8?B?UWwvUk40RGdXYTRkSi9iRzFJeGtlVWpQWHc3K2k1dFk4cFI5dGxTdW5GYzcx?=
 =?utf-8?B?V3hsVkErMjhaS1ZSa3BsVTlvaTg2UTNqRzJ1aXFIUzQwdlRWNXNiZHpGcXdQ?=
 =?utf-8?B?YUpqbStvazRUT3V0K2RmRzBDbmovS2dxdFc3cmIwbnd5Q1RGVmZDcjlXRVF2?=
 =?utf-8?B?dWJSUmFYblYyclVSbTJGL3p2WHRudWVqTTRkRVREOWRBSDNuWi9DU3haV3RZ?=
 =?utf-8?B?MmtzUTl0QURucjNZNVRTMTBibWZwZjNMdFVIRTVUWFhXbTNBMkIxblhrU3hM?=
 =?utf-8?B?dytIMFJwM1BzZjdXUThXT08vNnhlb1gwYkN3bnBDRVZraWsrM2UxQlY0bVli?=
 =?utf-8?B?NGI4ZTFoR1dJMWM4VWtURGFpeWxiSGs2RHQ0d1ZNdmFKbU5nOU9ubE1FamlR?=
 =?utf-8?B?ZjByMXZhemNkY0xudktvTlRJWjdVTk1BUDVzOTFuYm5VQkRuTXl2MElnOXJJ?=
 =?utf-8?B?TkVYMnBGbHJ1YWNBZlpUR0VkUEZWclVubUY3VGR5bXg1STFuZXVxVjNpbkdu?=
 =?utf-8?B?L3Y0Ym9uOE0yUTh2eUhNdTR2cHB3ZWFsME1TaDhzTXo5eVFJbXVGZ3VHOVdt?=
 =?utf-8?B?THg1S2hLMTV5NjZVSmxzaXA5a0Q0eERIQ1liUmJnSTNaZUE3QUVPOERReEhK?=
 =?utf-8?B?OGJ2Zk9aSzhWRStGYWNPZ0dvVXBNaEYwWHpFRDlrS0dEZHlLNFVheHVIbmli?=
 =?utf-8?B?b0hVV3JneTFPTmRLYzgyeDA0SFlwYUIzL2lsb1BMenZLaDFlOEtSeXI3T252?=
 =?utf-8?B?SzVZeHpwQ0tqemNkenFWb1ovZFd1a28yV2IxMzBkM21EOTk0SlJsRXozbHFj?=
 =?utf-8?B?Q1FwUldzNjh5MHlKcjUxSXR0UXZQWm5tbHVoR1lDdUMxb0JIK3BKZzVMYVhq?=
 =?utf-8?B?MTgybVVvZDQ2dnJsVEdMbWQwZGx6ZUw2Y3d6d3VlNGszVVlVR1NtZVVuSnVH?=
 =?utf-8?B?Sllqa0ZFZ2RkdHM4UlJZMWluUHgvN2dneldic1lpTzJPNmY3RFV1SEV2cUNR?=
 =?utf-8?B?bFFTNjUyd1ZpYXFsQ1BUYTRVc256ak1TY2x4bjlTTlIxc2pyWVVkMU03cU1R?=
 =?utf-8?B?d2JCMWRhbnFzalM1MGJQTmtaaE9CWkxhdmpIZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:40:08.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0dd579-5b61-4c17-b26a-08dddbd75754
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10569

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
index e71740ec51cd..237aa383f1a9 100644
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


