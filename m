Return-Path: <linux-kselftest+bounces-36270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F794AF09F3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507691C057EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594D221703;
	Wed,  2 Jul 2025 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gAk+rBe4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6321883C;
	Wed,  2 Jul 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431076; cv=fail; b=tJg++VNmPm4oWQPUN92ZKsLYqeNDGknUfTJL8EEhYpm6FSfxvVYrlcbgSOZyb7cU27l0HsxUscPx17Ff2iZAhtwuOu3TrddCiicS/PPmgPZk8WTrpwHkpNcgjaQ1HciuK7pcNxHAMf6ajUJN14R2fUOiIJLr3z7/gn5nRaj1+iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431076; c=relaxed/simple;
	bh=J30iOy+Lh8VCKUCbCfAEnUqRWAu53dq8wPfwoVdNSMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W64jdn1WcC4WRDJJTPHu7fsseRXtw/yzD1thCCzxMWrEPv1ghqnmaAuz2SuZwk8rF2MoxuCsx07UzyLZQEC5Xq+xSrnkWG3G9KTQuWPhVzNL90Y7foOyc/v5NP2MRtn50G9f696nnljpKgVL7NHouksK5nA4IXcdmCeC9b8GHvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gAk+rBe4; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+O6fb9ZtUZ8rcqcbByKUCWH+1jCJ8e6Mw8exQghBZK2Mo+GhBSUgBmuv09rIV6EGCgdmqTHjs4og7EBYrhPv2jYC7f0ez+hfIbxFWrOsOrzixabw27HohiIypeJGjJt8i+V8kR2vXkY7Css2sSW25n5NmKGbLNdLQt20DVbVxgdp+3LRKrVIGrLyOEYTgONT22/wLXHeGrAbjYHzpbiMZ3iOsPN4he5cbM+Vr28BZX+ZoMLoFkWARPtdaDElol2ZWTjJ2XAY4PkC/8SRo9+xJgwPv2JtjueajlH9WSs4gL+GDqgixfxajtt+O3DfQBtRcem8BHyYgjY+T2L7TjGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6fjybJ/1YtQztmB+/QhyRQqFiK3FOO4hsPtLxSluOA=;
 b=DNrTQMvjrupspyxeT3VZpkbI4cxFHW+2rEHrnjZJLED1FtpP3wxpKfBh69fzKzpYoIZIAMbs5skvJ7WEF4wr7UvnYxGMw+sKYjLwo4L4EqRG60snx+7g8XRgSI9eGjCgix65Vx+AieR2S2o7fE1v3j9y6y05OlKilttsYeYbCHnU4JEQG9bTaiAD690eeTsP0xVTIOWYmUuTaw0MUIv0jh9JRHmpSkhOuIzC+n73ocrj9cOfQrc7Uc0Vyt1IMjXKVFKM5cvro1W8yeEELRPPWkriqo5gmRRyGhi+ykSDg8/1sxp+dyz4xcVCrJYIZzSrisbZOAwf5mrCqgpSbATLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6fjybJ/1YtQztmB+/QhyRQqFiK3FOO4hsPtLxSluOA=;
 b=gAk+rBe4npQWhLk99nNBcNrXjdasMdrMfYXq2BW+0iDnsxps+FgyEweK6VldA6nxBPCcb7QNDzbFI5kmxAtTfpp85y69NvsgYNc2rMbKqYRzAMgoiLo6OAhHjQwODNV116Y9Ac/O6eAsy4vjcLmrjypUzqPJ+lRnpWz8V4UipqhEgxU2ANALlmvR2Dw7HT6JQjiwnytQ20gsODQAUD/338AUWM+ewf8XEMAaLd6RpENGu45zaRzZ151eTCo/eIlEhp3q3hWgkf0DWfTodTzYboIse8sECvDRLVY1vPS2O/07qNUNerFhhMdu6x9i4RXr2aBjHZ4Gsxmx5druGAewjA==
Received: from DU7P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::21)
 by PA4PR07MB8461.eurprd07.prod.outlook.com (2603:10a6:102:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 04:37:50 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::36) by DU7P191CA0021.outlook.office365.com
 (2603:10a6:10:54e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 04:37:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0681D1C003B;
	Wed,  2 Jul 2025 07:37:48 +0300 (EEST)
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
Subject: [PATCH v10 net-next 15/15] tcp: accecn: try to fit AccECN option with SACK
Date: Wed,  2 Jul 2025 06:37:19 +0200
Message-Id: <20250702043719.15130-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039231:EE_|PA4PR07MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6e48ae-6a33-4372-ce24-08ddb92233d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU02cTF6U0FqcGFQZG9yUWtVUThIbWhuNkFZOVlYRUZlMFVoNXNuY2FLZEFt?=
 =?utf-8?B?cnQyanFCWU1uZ1NqTFRscUlWV0xVanREOEFnZ0d2dlV2bGJBU05EVnN2d044?=
 =?utf-8?B?Y3Fjekh0T3laWTJqYnltaFErbC9nMjhQVE1oWXNSNElYRFRuUC96U2gvbjQx?=
 =?utf-8?B?OHR1VkxWSWFtSTNxeCs0c1dRNGVLYmh3YnU5MGJ2L1JteHlTZVhLS091b01a?=
 =?utf-8?B?VzdDeWg2WUpXSVdpc1ZucWdtSlBOcDIzcjhJZmRacThpUVZwRkhUMC91aENB?=
 =?utf-8?B?NGZLa1AwWTJnTVMydUpIYlN1Y244bG9KTWI3a3Uva3ZjQy83QU1OcWNQaFgz?=
 =?utf-8?B?M1F4NWsvMzZxeVUzYlhjU3Q3ODVza2Z4NzRqS2hkYjZsdmtRaldZRVkwbENw?=
 =?utf-8?B?V3pjL1RjT2F5ZW1ja1F4Tm5yNENzeklISWJ1cE43cWJMYUc1WW5aNEQ5Y1hh?=
 =?utf-8?B?aGpzZC9aSGR4NHdRd1FBMEhHb0hGaXJTc1VFSlRNcnFTQm90Y0wrNnViUThZ?=
 =?utf-8?B?aWR6VWtCNkh6K2diZHl0OStOeUxpM2N1TzdVQkFGbFZmQWJycmd5RkZBb2lM?=
 =?utf-8?B?MTdDTFl5QnBJSDNUWnhDczZjRk5ZMmg2U0dxYSs0WW1HdEVQOE5PanNhOVdD?=
 =?utf-8?B?NHc5cko4cWw3Z21VY1grclo3NGwxZWxSL3ZVcU5qeVd6eTB2QVI5NytHNkRN?=
 =?utf-8?B?MEtmVFJwdU5jemg0MXhreTJvRU1yUmJqa0NadTdGU1kvUWR3R3U0bHBPSlNY?=
 =?utf-8?B?WXVSRDlpU3NSWmJtTkg4Y0kyRVZvYWhRODk0eTZvcVNxUk9VTkRyWUtLNVd2?=
 =?utf-8?B?dkpUNWxaUFdSQ3VKbmdMRTZNbGVtblcrbkRYalFEZnpZR0ZTVG83OHpIcE1D?=
 =?utf-8?B?QzF0ZDJVSHFsam1HNGw1RnNySWNMN0RMWnVGRkwyc1JoRU1DMjRrbHNlWWx6?=
 =?utf-8?B?SmJjOEhGQ3IvVG13VmhsZEx3MzJJTk1ESWp5ZElWU2ppSzVNSEF1aFJsNUl2?=
 =?utf-8?B?c1J0ZWNCVjZWSWN3RWgvSWYwZm1NWjRoUGpLUzVuZ2djU2ZBZ2NobEJPZ21V?=
 =?utf-8?B?ZjZUV2VGL3JxaG4raVdsZ0FpQ1VEeUxtaVUzVjQrVHJZMGR1S21LRG5FQ3ZQ?=
 =?utf-8?B?dEEyYTU5ODZOZ3p2cmdjZElFQjZtVys4WlJRRDZ6REo2Wm5OQk84OUJiU0tz?=
 =?utf-8?B?WTRNa1hNclJ1cC8vbk5Hd1JQalZYU3VkeXdhaExmNjlFVVo3RGRRM2JsMXlx?=
 =?utf-8?B?NUlXaHRlYUl2TzAxQVF6M2l2bWh2RUs5bXJ5ZWlBUk9TVDdjN1kvM3QwUWYz?=
 =?utf-8?B?ajVCT2srbzdITlZycU1oZ1k0TXRlbmp4K04zOVFsZHJMdDlDWDF5a1N2NXg1?=
 =?utf-8?B?ZE8wVjM0bUxmTi91OTVNWGplaWpzUUFDbiszSHlBcnlTMUlTV3Fzd3QrQ0E3?=
 =?utf-8?B?V1dLYkdyV21EdVB2Qk85MkloRS9RT2RXbEd5RXdkdjNxZUp5Rlh5cWZXQXNW?=
 =?utf-8?B?ZE1VY3VzMnB0ZHBEUDB2MGdLSmJ2UkY5cVIxTUkvcDkwblVSUVBveGxmeTk2?=
 =?utf-8?B?b040SmNNeVgyUHRoWDJIY2ZOVk1wMFVTQ2hMTHp1aUd0U0g0ajRyVzBCYUFo?=
 =?utf-8?B?K2xwcUZJVEcwNXNqb1RaenRYYTZ5U1VnSGlzeGFuZnhvaVlRK09LcncvYmhy?=
 =?utf-8?B?aDhmRk5ZYWJBdmo1eUFuanp5NVNBQTRhdkNGZCtpLzdJYWZsb0wvVGY1US9L?=
 =?utf-8?B?c2ZlT0xYSkIyTFc0ZXJuV0lMRVNSR0huY2JTT1NNZlpyMEFzbWV6TzBjMTF3?=
 =?utf-8?B?NGpnN3p0L1dYNkVIM05KUWduNmRzOXVrdVMwSkdCdzQ5aDRneUYyWUgwa0RN?=
 =?utf-8?B?eFJ1M0wvdUUxdStQbE9ScnExRFF5T1JNU2g3YzJhLzJ5eVlXSDRsTzhzV2lk?=
 =?utf-8?B?OVZ4WUtIby9XWXl0Q2N6ZUVuTE5xWkh6aTUzNlJGeEY2OEx4K1lRbGIrTGxF?=
 =?utf-8?B?RnV4ZzJNNFo2M2lJK2drbW5KOUZCNWMxV09SbkEwa0FsaG9NSlA4ZnpCTmFC?=
 =?utf-8?B?ZUFQeEZ4U3ZVTFRPem14Ti8rVWx2KzdJRDJ3QT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:50.5484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6e48ae-6a33-4372-ce24-08ddb92233d7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8461

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


