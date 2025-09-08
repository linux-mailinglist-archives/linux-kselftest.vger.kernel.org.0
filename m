Return-Path: <linux-kselftest+bounces-40980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D685FB49742
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D507AF3C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089B319852;
	Mon,  8 Sep 2025 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="auubr69G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CE3112C7;
	Mon,  8 Sep 2025 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352886; cv=fail; b=EYqe6+ia1G+ryehSgZ/TNGl7helElZebKbTn+VJUKH9KFNb5KHJHrvc8929BRQ07Fdb+yjQf4dZxaHvqBiQliyVM0vuzM0rgy4sgdqbasqVhnXhU0/bNQJp8vf3L70Kt1SXdVcrVAeSaO9HVB/kjQ1w1fbzmyAxdrSExdq3xgbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352886; c=relaxed/simple;
	bh=4roOIwVB4t/QyVRpZ7WhxO58mPofxqAcb5mjO44z5c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5aQK5RObCwmita3iMsWts9FqRCsrgQo9BHJs/pvXUsSY0AQhVy/Sm6R9JvfdE/WXEvX1KlYLDp8vmqI9m174m+vz+Z/rEywdNwTETyIyy8LZvZ26phv5XLwLaDqJNy2i+twCgqDv6oWgHTfeL57XR/FM1LJVGMdWnCU30WCdDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=auubr69G; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzSxxITOafM6wOIMTwKsDpHy1CETO8+L+qafXlifmFlo5jKFvlQORLfBB4yWMe+kbTp8Ef+dq4KNsU06jU9d7MStQ8p2KAINdqpD7UvmASCPALeIdeNBAFsWw/Th5RGyLuJAdC1eFokt82EnSrkXM+6ZnOO14eFU9+nxnwgONq3EavbBriwE5JwBTAe0IJwxdkVyw2tvBhuBHiErYRqkHPjVVDiQLPc/48UloS0EKSE+MYW7iPqmrBMSf3ClVZSGxLslipwF2S4h4zJLnXhz9rRJvpTKAwPZsARRKYqGY+fcBR0jr2p9TK9AnQUUsICg28pM3/PN3ASM+Ctg1Jus7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvkpQev33JM82+voUy94wmxzIg5p1RbiMdjsJAb0Tf0=;
 b=ktT0RAP0w+GC3Ck9BshPhBAojlPTPargd1DgiMrXlxbxedwlBSElXYyT1FpZ8irUWpRzUFoyhg2sO6OWPpxeFcgB75sTXKJISoZ28Lt35PhRnDDpHwwGfzZQUDhnYMrlU/nfOCK0xt+Cqe8Sr6lhtvAMEtjHe0tPFWqRSSOe6HHRH4Py9ZOv88yglfmgrcGHB8Jgi3eXoSx3nAWXU/RUbtvHRzS7DsRJfAc5R8dl7fGwn5lqgHeIceOb8v8LJdBPO8hbKTuZGZVwy3vnbw0DeHqpkR305IbZD1vu9WeeiGA6R0/gTKHrjCKUmI8Xejl/+U70WdSOrh/3WozZ6UrhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvkpQev33JM82+voUy94wmxzIg5p1RbiMdjsJAb0Tf0=;
 b=auubr69GcZPvvGPUbvmPGRLticZvHX5M0/P8GEvPcYdQy0Y4z6XzR5X3/qEbrFDARuaIM7e6fT/KtOrHfHOdjFQAi6r6AcpCBFxz4ulDw3mNR6/p69C9OX9HrnVzWvPvpdgPCM1OfrU41Ncf6bORFzKCz8hrSFLrJ+iRmEJAKchklpMlBE8EmE8YKEucsAP0rnb5OgRKkHfMs1bIaKRMjMApFfN/q3nkS9ezA7bh4s+5CrK0dk16TgSdaChp4OT4Pre14/SGLEGVbKe+ABIoYK6aYb1kMtfLNjRFLhKRVB7bxj9U4EKZTcR1BiYBr/U7nLazRpVWsS28zWeSFwNsYw==
Received: from AS4P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::9)
 by DU4PR07MB10883.eurprd07.prod.outlook.com (2603:10a6:10:5f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:40 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::2f) by AS4P191CA0019.outlook.office365.com
 (2603:10a6:20b:5d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 60AE11C004F;
	Mon,  8 Sep 2025 20:34:38 +0300 (EEST)
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
Subject: [PATCH v17 net-next 14/14] tcp: accecn: try to fit AccECN option with SACK
Date: Mon,  8 Sep 2025 19:34:08 +0200
Message-Id: <20250908173408.79715-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|DU4PR07MB10883:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af0f973-b6d8-4134-6834-08ddeefdfd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nytld0I0dzBicWliTGRWSDMyVU92RjBrNXhwamlseFlRVnh2bENHWUhuVWp2?=
 =?utf-8?B?UFhoUE1jOHlTN3lhcUY2MkdqeDVrenZ3WnNXZFFZQ0Vhd3N5bE1Qc0hORmE2?=
 =?utf-8?B?TVdVS29XYVRrQkhzeU9yZVJxN1A1Uk1XQnhQTVZxYTEvY0pPWVBuSDFuZXc2?=
 =?utf-8?B?ZXlSVEhMdGtKTXJEdGRuVUFSTkQyM1pRTGpiUUFmdkF0L1A2YVFBc05iT1dp?=
 =?utf-8?B?NEJvcVdmblhZU2xEL2JmMWJ4dmFmRlRZNWQ5NmxjZ2xSeGVjN1VKSHBBU2hZ?=
 =?utf-8?B?aUpkUjZ4RW5OSzRnS2tlZG5XdWpZS3FaOUYyNVowS3JLVmRKczh4UXJGb3lx?=
 =?utf-8?B?NkFMTUJrWjd4bllKOGIrL2ZHZWIzZDRDcFQrZ09oNXQzRHdDQTZWQldsTkZa?=
 =?utf-8?B?anp2MHlmNGNOeWw5KzVkQzRHdEs4YlFZV2NTVy9FZGRydmlKRWNEWW14c3NR?=
 =?utf-8?B?QUlJZkdGbTFNazZxTGJGdkdZa0pOOHhZYnR3Zkc3UjM0NTFCWUsvazYvWER0?=
 =?utf-8?B?bzdoaHNaUThobTV0bHVuK1pCclZhZ0gyNWJwb3J5dWN2Y1hWZDdHQ3dSS1Bl?=
 =?utf-8?B?ZlQ4bXhNY0Q0M2pHNm9HSWY3dkxxbE1iRk1EdENIeHNDdFVISTNYMGQ0cjFw?=
 =?utf-8?B?TlFST1FFZW90dmxZWE1yalI3YUt2NnB5dlJuMjJXcU0wSmZHVTg4bG1XZFc1?=
 =?utf-8?B?eHJJQTAwOEpHa0doMms3MVZ2LzlSeDZVWEY3aTVGYmVCYWFUZ0M5Uno3UUw5?=
 =?utf-8?B?eGQ4bWZNUXlLb1lhSzV5L0JKanhOQmI4eVpZY0ZmZ0RJMHAwZUpwOWV2R2M4?=
 =?utf-8?B?dzc5VG1rSlFBbTNMYUxhS0tKOFZCL2J5Q0p0RWx0RkZtdnUzQy95Y0lmSUhL?=
 =?utf-8?B?NWhwcm4xdkxkb2xXMm1hVm51UkRtR21QcWNJUmdyVHRDZHFUL1Q2L2d2U0Y3?=
 =?utf-8?B?TDk2TEh0TCtPc29hbmxLUjlMaWp2aHlJSm5naWh4dXBObE40S3lsclI4eU56?=
 =?utf-8?B?UmhWQ1hVekwrbndpcTduSWwrc0JaZkF6MFJMZzZTbm1ncGlncTBLb1VoS2Vr?=
 =?utf-8?B?c1BrRVNOcjc3QTVib2N6UWw2QmdCaEVGUDVaYzRlVHdNdjJJaW5LNG5XSXpl?=
 =?utf-8?B?Zmg0V1VGTzJKSDMrNHIzZS8zQTJBQXo1L25mNzVSSVkwdGNzNGs4bXNQd3Zm?=
 =?utf-8?B?NkdVQ3FWVXhkRjdNNTUrdzZVclk2VnVPSU5ackVkVTBWUHBmZU0zMWRqWUNZ?=
 =?utf-8?B?dVRCSTNicXhuNmtoWGdjZjBacTd5MDdMTkQ2SVE1TkZSVXRxQUJHVTA4bTlO?=
 =?utf-8?B?dmdLa3lqMkR2Nk45cTNwcnZVTmRXVFBwRGJwR1lCQk5kaFR1cnp4WGUxaVNV?=
 =?utf-8?B?UldHendvMDdUTStzei9WRGJpMUpNVFozVkNrR1FIeEZJemR4OHQ5WTdUa2M3?=
 =?utf-8?B?UHMyMk9yd3d6M1R0eUFjamFkTXpzeklwbUFzOUU5WkFoUmxPYUlBYnBMV0k1?=
 =?utf-8?B?OHkzUW15enFPRm5UelpBUFQ3R3J1TCtxTTdBbkNGakF2OU1qMEJJVWx0TlBV?=
 =?utf-8?B?UGIrTFBiRVFRcEwwS3M2eTlBbXhKUmxNTmNOUTlScis1SVA5RzIxS1Bubjk5?=
 =?utf-8?B?YXhGbUdSWFgydHVKRkhKVmQ4R3hSYVE3VDJpWnQ5dFlkTkFiNE5peGM1VXhO?=
 =?utf-8?B?d2xzSGN5NUhBcWJpSm5Ra2tMM2VsSXJlSk44N1I4QWd6YTZTSmkwTHZxM2ox?=
 =?utf-8?B?cEhZSzhwVDB6bG5la2pFNVF0NzN0VjFmbEYrLy9iRVYvc29KTlFtR0xuZHNU?=
 =?utf-8?B?cUc5K0xkVzJha0J4Vm1OYWRPSWltZ2M4dUd5MFF0U1dxY3lSeEsxSDlXUGxV?=
 =?utf-8?B?RU5NU3R1bmNFVm1paDhpM3NoSHFsenYvTkFCK1lIeVJYU0U0VTZGUlhDaHZR?=
 =?utf-8?B?RHYwb3czdXlyQXFLQ3ViYWYvUnAxclRPOUVCOW5WVjNBcSs3b3pTeUVhWGFT?=
 =?utf-8?B?VGpEdmkzNGx3RVRMQnUvN3VSLzhnWS9jOFNHZUNKTzgrVmltU0NwRGQyNWlW?=
 =?utf-8?B?MWt4QTg0N3dSZFc0YnRzcy9WZ1ZyRFdGQXdDUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:39.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af0f973-b6d8-4134-6834-08ddeefdfd3f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10883

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
index 65b90f73daa0..388c45859469 100644
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


