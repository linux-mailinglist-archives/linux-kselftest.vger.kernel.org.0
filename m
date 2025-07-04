Return-Path: <linux-kselftest+bounces-36529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E56AF8D60
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49719161EAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067C2FA646;
	Fri,  4 Jul 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Ss6hMBMg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133172FA626;
	Fri,  4 Jul 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619340; cv=fail; b=K3YfQuarUbFwBlbvnJhGcILYapCiaxi8xoFewtizT3dMfeL8BwEKQphn6IjEBtaNnUxGY7U8d9WAAWsVAPaLNnS74t4BxMvSgZpvcsjrlxGSXDsfXtpZnxmdBJ2vhG9NPytsVcG+mxUfjOuZsrU8xq49b7zEhDSJaPQYUrTjghw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619340; c=relaxed/simple;
	bh=J30iOy+Lh8VCKUCbCfAEnUqRWAu53dq8wPfwoVdNSMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTIGEu1RMZxGaByevFCEPGA89JAZXvPg4ZfCDHBLiaSroqlVWQtUTMiUxUV1QsyNb3uAJLHwwadSVYZLiAqf5O+H9aVyWpUzILScxLwcRCCWvbWH+fSjXi8bJ259rmONJNf4DGsN+TOw0ya1c1b/Et90huAPXnTnkzZBN40j+fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Ss6hMBMg; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD54ZcJXjnT0IQYdn6d0x7LtqQUavVUsqCWzRp/X6LUpzPIKsQBebt6LFcodgRAYjIeVLP/k3EWube0Q1Tv9rrU7T002KRoV41fvuWqbi3+Ogx76hdMClNjtCXjxpFnR31hZQ10hWCjoRKHlgNelp919YRXHk4BewoTFvRPtbAVkQh5ZYdsi5xRnjXP1oHpBYz6RCwPpdEeUEct3P6nGRX29Wr9GnVPeg2B0IFHYXCIl9tuLpO8JeUzDcAqmwC+yEtD8MzjCxpUqfmRyXfxG7jRzWfQrIldJ41tn+2WIDH48/FrNo4JpVQlmf/nzbV1G8NdAGi9KWvMe8spaZ3LX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6fjybJ/1YtQztmB+/QhyRQqFiK3FOO4hsPtLxSluOA=;
 b=vudu+0R2zmJvUN1Y5E/JOakhmoRXR9kTmCKSJaBe//NhlIkcekLc8CXokVMPonePxO08bMAtfKHcd3Y5qrAtbA9Lnnon5smTJExnNGop/tDXYxrI7m4FuMT8+Jc+TodoGjbQ/JHS5c2xmHPomPB0IXL5FRz0DmDQqan4wKUT+KzS7yEv4dVMPW70d6UT847G7QCzuS7kNeiFc/u5dh6RnIczbu16enVAmk2c2xSG1yqM2u6uCVEXcr0B+XK6xyuzXxJs4eHItBDyGKhEGhiAJvMFe2e0fKSZvgMqDYCwJ4yiSoim07p4AylfL/JuT9VtjRxEPvxk8LApuJqKtUcqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6fjybJ/1YtQztmB+/QhyRQqFiK3FOO4hsPtLxSluOA=;
 b=Ss6hMBMgELcfBnE+apSkL8x11RBOEvMV1Fd0vWdslV73DT1BVzhA9KReB4r7u8zBtvnkbZgo6eFrU7lUfpQM6cdiby3TTKaELxLvyX0DMOVYJadoYqzvB5Q4iL4711Czx/evC6TZOFy5UMr3vxMaGSCqrCk7V1jUutCQ/7teHAz5YYEND6o+jYsqP3PxqcLrs9TtwFYZDvsB3PS9aURPunGtYyr11a0HQKrt99PGAADzb3zAMcA8fBb7lYq3VqEP03O+NV6z2BpGg5xgj8mbo9kvdHPz7aGVMsAUx2vJJyQdTGurAiUSN4Np/j6BG6zNkH7Y1gII+cM6ZspLHUEsqA==
Received: from DUZP191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::9) by
 DB9PR07MB10100.eurprd07.prod.outlook.com (2603:10a6:10:4cd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Fri, 4 Jul 2025 08:55:35 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::c3) by DUZP191CA0011.outlook.office365.com
 (2603:10a6:10:4f9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 08:55:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id DC29F20153;
	Fri,  4 Jul 2025 11:55:33 +0300 (EEST)
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
Subject: [PATCH v12 net-next 15/15] tcp: accecn: try to fit AccECN option with SACK
Date: Fri,  4 Jul 2025 10:53:45 +0200
Message-Id: <20250704085345.46530-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EA:EE_|DB9PR07MB10100:EE_
X-MS-Office365-Filtering-Correlation-Id: 777ce9cf-44b2-4d19-9579-08ddbad88a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW9nMDYzWjk4V1pYOHJVbHU3N0E2ZXYxVjZQVWJhT0tMTVYrbVBkZTU5RWwv?=
 =?utf-8?B?WkxiZnFSWXZTck1abXR3YXpOWE56Wk5iVmNJVkcxSUVGa2hmcHVwczhISThx?=
 =?utf-8?B?V2FKWjF2ci96alNBNXNYalRUeUZ2b2wrSE44empHSDc2WFpjVGNieXpzWEN6?=
 =?utf-8?B?OUo5aDR6V24xL3FNRUpTQ1Rpb2hCaUx4RFBPNVRER1Y4M1dXQmR6UjZpQmJl?=
 =?utf-8?B?R0hKSXJoYnArWVo4VE1UWWYvdnBxT2F5U3hkbm5NRmsxQlVMdEJTTGM4N3pa?=
 =?utf-8?B?TWI4Q2JHMUxzTTExUkxIZTZ2bk1nVHRla2ZrOXNxb2l0NEordmxQcjQxSHRW?=
 =?utf-8?B?MnI2c3lKZWdYZUt3RWoxK01vcmxVZmk0V2h2T0FFMzRpZFNaRHRJNDdHdDdo?=
 =?utf-8?B?MEsyak1KQzVaa0NMWEtVRlV1M1ZrcjV2NnV1akpFU2F6RE1Ock9hTGpabVRp?=
 =?utf-8?B?aW81eXZOQmRjcCtZOXNBRWZkUzEvWGZRbXNFNDB6RUJlWDlZSWd2ek1sZWFZ?=
 =?utf-8?B?d0tDdEx4NklJSm9WUUFsSHF1RG0wYUxENEZXNTRGRXFPaXYwQTRWME8xZWoy?=
 =?utf-8?B?UjJpUkFyR1NoMDJkbWxWMDlFZGJtN0E2dDZlb0JiK1k3ZXpBclUyMzBRNUNw?=
 =?utf-8?B?bHJoR1hENWova3VnUTdTUFlvZS8xVFExeWJCNGl6aFlxbTlkbjlBdnkyWk52?=
 =?utf-8?B?c1BEOVJ0RnAramJRTkFxVTVOT1B2bzJhaFBWNC9zbDBZM2lLdS9ZaUg3aUkv?=
 =?utf-8?B?bllRc083T0ZXQTZUNFlDcUpUV3I1cTFubmVOSUNsaFkzWk5zREE5MG5lVWp5?=
 =?utf-8?B?V3N6ZVdTN2tlZnA3WkpCZ3pBQ080SWRlM2pLWWJuMU1sYUZkelgrNTVNK2VF?=
 =?utf-8?B?VHhnZGFWbUZveXp4SS9rMWJNbGQ0bmoyeS9FR3NuZEt0K3dEUTFVdUVGQklr?=
 =?utf-8?B?ZnlqV1hLR0REejh1bllURUF3WUw5SFA3WmlFNERGZU1iV2phMnkvYjMxTVQ1?=
 =?utf-8?B?Z3NVeFFRd25VYXV6WDZaai9PQnphWFBRaDBXWjNnSEU4MjNQYWljT3lMYUl4?=
 =?utf-8?B?ZHFSdUJMVnVkUUJTTG1SNWtqaGNYSkY5L2NuNy9qU2krNEs4NndjVFdBSmY2?=
 =?utf-8?B?RW5BL3pBWEdKVWM3TjhnVE9jSklCL0s1bStJdUQ3NDVHVHpzaUZROXdzZWtI?=
 =?utf-8?B?UC94WVhKczA4U3BuQlhXSE1pT2hOYkM0MzR5QmY3eW1QcCtEdmVqUFUzeXQ4?=
 =?utf-8?B?bWpuaXprMGtUTVo2ckNyNUU3eXptUTdEYWRqb2kzSUJHWDVvNFJrcW1Vd0Iw?=
 =?utf-8?B?WFpCTGhvTFE5T0ZyT0RZSlhRS2F1VXh2Ly9sZC9JSGZDYjZ4RXBSQis0Zk1Z?=
 =?utf-8?B?bVZCZVNnVldMdXNvSThWOGR6ZkhCbFo2dFozNkZ5UEUvQ3V1TXNTdzlDZnRa?=
 =?utf-8?B?RGRNN0psUDY2WVlwNmRmUnNNY21oOW1nRkR6R3N0OW5xSSs4UFpjSDdxMy8r?=
 =?utf-8?B?Ny9pbWlERnk0dVVsRVVsOXB6NldNSG5DQmdOVlU0Q3hwTDVjaTFidm9aTEtS?=
 =?utf-8?B?VENlNFdFNk1NS1VZUTlvT0lUdlp4YUMrc2FPTTVuWW45WTFXNG9kSDZmSWhY?=
 =?utf-8?B?M1M4V3NTY29MempiYmdEeXlvcTJoc0pRWGhhZWRwVmlWMDc5ekY2TENDZ1R4?=
 =?utf-8?B?eWg0VHVxQ2c1aGxIWE9KcGI2MGREZWdQUkt5eWZLMW5PMGJianZzdnBMaVFT?=
 =?utf-8?B?a0FERmN5ZFVUQjI3a2VQbi9GaS9YTnA5VHV6emh2OER2ZUlGUE5pTGNmNEtW?=
 =?utf-8?B?aTRLa0J5RXhPQ3pNejdzeWZkMXBsZjd2SGl4WlhGSkoxeVUyK0k3MFlITVN2?=
 =?utf-8?B?anFpVlFMVTNzTTdNd3pRNDFOZXBGOXNNRFNUZXJRb3Jza3NqK1BaOGJXeXg2?=
 =?utf-8?B?TkU5Q0RJUi9KNmRyVG1NRnJHZHcxaGNPVVlwUXYrZ0tVYUNiVmNGOERLcEpl?=
 =?utf-8?B?MjhMWTJzZW1sdzdudlAwd3BXQlk3NVJEai9mdnlvWE9XY05mSTYxUytJNW5H?=
 =?utf-8?B?bG01eWt5dlFEYkdOZytpaS9PekVzbDQrcUdxUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:35.4285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777ce9cf-44b2-4d19-9579-08ddbad88a74
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10100

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
index 560b0ca54bb8..cf1d40e9c0ed 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -876,7 +876,9 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 				  int remaining)
 {
 	int size = TCP_ACCECN_MAXSIZE;
+	int sack_blocks_reduce = 0;
 	int max_combine_saving;
+	int rem = remaining;
 
 	if (opts->use_synack_ecn_bytes)
 		max_combine_saving = tcp_synack_options_combine_saving(opts);
@@ -889,14 +891,31 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		if (leftover_size > max_combine_saving)
 			leftover_size = -((4 - leftover_size) & 0x3);
 
-		if (remaining >= size - leftover_size) {
+		if (rem >= size - leftover_size) {
 			size -= leftover_size;
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


