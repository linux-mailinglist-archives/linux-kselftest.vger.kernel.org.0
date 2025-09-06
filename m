Return-Path: <linux-kselftest+bounces-40892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23F1B47465
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4743C5884D0
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DE82FABE0;
	Sat,  6 Sep 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WkOheKTz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFA2F83D7;
	Sat,  6 Sep 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176167; cv=fail; b=ZO6R6Rqjf/N5MfPsDgx7Y2UaNqti3OSxUGnuUIHwVgnlk7nD0Q5Y0+2fU9a8gKv5P0QmYOh+8ArMJ3idel95DKr2FlRczoU05DK1Wu6CKeK6f/HYpP6jE+5YkWW//eY+PLNBhNPBSAx13xoK0xHASBkLQlPue2hU9/6llXBg4eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176167; c=relaxed/simple;
	bh=4roOIwVB4t/QyVRpZ7WhxO58mPofxqAcb5mjO44z5c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtPPwDPoHXOOdixWKTu43bQldoBSTLyQIiSxs3kJK7geI57yKsBMIUbAdiRQyKeTMU6E4arNPDQL1j9bLSx3piWH4nHVHIpPmtNH5a6pJrknTUlRTpX1bB7AvFzTwkFN1ahongRucBB6IrPJD9IRdeZ3O5H080rwb+CwrnHkAyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WkOheKTz; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkWu66Cr71M5E9I2sKne4wnfKtifZtnUzOJlEWkb1ozxq7VnfzvioIXByJ9qGnN3Goz2IgnGtPVGzFvZBYp+w7gKwjVM5tLyKlJ+CzkPhBo6dsonUcVCiq4rFs9dLInslPDDeqYTEfgfD00tV0nc6hT59dtP/fqPSRVrwgCq15ZpyoIs7jS9AOTlMts/UhEmiRmqC8K9EiSH+sRO4oVPopKN1z0hjx1si7o1joSJUj/KrzoVi0r8j/wgn1C7c/rFrYWxir9HsEBpzFL0D7dOC8LdaAy1LWgYHgMJ/+0PUv48Ry+OWicOriYdtOraXnmIpqaNANGgCU7viQ7bTOk79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvkpQev33JM82+voUy94wmxzIg5p1RbiMdjsJAb0Tf0=;
 b=pzVRSA+MhLXITJuY41G2n5Y3VhSpp6wEY0I3BuvtOV+wZAiM24qIWLrSYTLBVma8Mtw91nMvSi2bVtGP2ERazU+ey8JSzYNSiPq5rPFOMRjPG8l/FHojTtMVec2o32g90+zvqnin2Xussp1uwV92dLszPaqm+dtZWo2azyhoz+X7V8xIYmriPVwRp5ZdK1DZzDviIabSlIDiqfv7Sq1+DORhWYhvU5DHVr0a6qlNCxlZI7GaVFLf49cXuAakad78IBbYlbFp4YSgoCIbi8yXZVgIjqQ/vT7+IuILQcwQ5MoAc9WiGp3YfuORZobqkApkxJL8SvmeEo1p+GccRpfA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvkpQev33JM82+voUy94wmxzIg5p1RbiMdjsJAb0Tf0=;
 b=WkOheKTzJFg8W5BGAjsu54xNjpmcD01/16FckjEPbM2LzXPEux8n5f2bUunqoR5TSbfOc24OCEMyeeO3EIb7wd/SL81ab4XxHVqGWzMrdx5yMNGD4V8Cv8zVKPct4hhA6IJcMPzDYIMn7YIAaKgFmOdHKPokpc+DqCwoVhZ8aBoZEWzom7G3ex3q8DhFHcH0MYnbcC/TMQG9oT27y2CMa/nFF3+6ifpjxwA9F9hmRU7z7gSvKxjcCLD/jEmt2xIu3T98JjWkLWhV9MF07baD928tpwa+wLTNacMDF8oaPnMidrRU9DEBpNkW7sZLXMnq7vVZ1+VtJpXT2GZW5Z+kZQ==
Received: from AS4P195CA0035.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::19)
 by PA1PR07MB10487.eurprd07.prod.outlook.com (2603:10a6:102:4f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sat, 6 Sep
 2025 16:29:21 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::af) by AS4P195CA0035.outlook.office365.com
 (2603:10a6:20b:65a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sat,
 6 Sep 2025 16:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Sat, 6 Sep 2025 16:29:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 51D471C002B;
	Sat,  6 Sep 2025 19:29:19 +0300 (EEST)
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
Subject: [PATCH v16 net-next 14/14] tcp: accecn: try to fit AccECN option with SACK
Date: Sat,  6 Sep 2025 18:28:50 +0200
Message-Id: <20250906162850.73598-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70D:EE_|PA1PR07MB10487:EE_
X-MS-Office365-Filtering-Correlation-Id: 269b12e7-6f5e-4927-88c9-08dded62887b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG52eVBMR0ZqK0FsLzNkeWlCQXdVeFR1dWpzaTZZTkZVY2lXM3FYR2NzVjJs?=
 =?utf-8?B?MldqZ2M4RUpmK0t3ZzhJSGdwY1o0bWdjT29zc0ozN1J5cEI1b1V3bktCdk1l?=
 =?utf-8?B?aThGWC9LdTZsTEdUWEtJQ1FLOXBTSmZhUUtIUXdCVlhIbnVEcjE5Y2l4ckt5?=
 =?utf-8?B?RnZNbVlZZkxrZkx2THVRancwaDc5MWlhbnQwOHBVbHVlbjlLeVNHR3AyVWJE?=
 =?utf-8?B?TjdidjkvMDJESm9HOGpXT3JVS0RiUEVGRkVwU3lINEVSTTlXMlczMC80aDNq?=
 =?utf-8?B?NGFHMTNaNWhXUVRJNUpPNGp3VjZXK1ZzUm9hdndGZ21WaFMvVzI0Vm02VWVw?=
 =?utf-8?B?QjltQTFZNXcwRzNvenlNM3Z1TXJocWhWdUFhSnVBMFJYN1Uzc3dqNmdVakEv?=
 =?utf-8?B?VXdmRDE4YWpLWXBsWFRGejh1VWFtaXBEOWwwQmRvajBuakRGVEdlUmtXWVll?=
 =?utf-8?B?TWVXNG9qTGl1WUJUVE45M2I4bEluUENERzRSMERlZnFGUUdvYlJnRkJLM25O?=
 =?utf-8?B?Y1MvTll1b1pMNkdCL0hJRVZ4U2didG1mTGVZWDhRb25RQUlOQnRRYzRyZTU2?=
 =?utf-8?B?Ui9tSWdWNEorR3lYbzB2VlNDOExaL0pnS2V2Zy8yQmNEM0VMa0VTQS9Xc1hy?=
 =?utf-8?B?YmJjY2xvaVp2RmY2U2ErT255UkRzeTZwMEVpc2NOZ0dEU1d4ZmtpRmg3ZzYv?=
 =?utf-8?B?Mk5TZWJGNjBYaHcvSVJFRTRxREJudThyWXVKQkpxcWpHWkpDdjk0OVNOUnQ1?=
 =?utf-8?B?dFJ3WVJYZStwOW9tU1oxcW05ZXVZdlZmeWl3VWRJTmlSclNaSVhHZ1cyb2Yw?=
 =?utf-8?B?cW5MSC9TMkJGeHZzRlNhTjJSZ3dJWVdKdDJCK25GTEphS1RzT0ZwZEV2bE5T?=
 =?utf-8?B?SzYrRWpWRU1BeklWRndYblZjS3lDQlZrZXJPdDdHSVBIOVVOMjZuVHhzRDNM?=
 =?utf-8?B?Uy9IV1p6c3RRN1NpMVdOSGVERGd6dWVnbHdDTTFOTnY2MFB5VHhpb09tWEo5?=
 =?utf-8?B?bGE4WW9CYkd5U1FyeFB4R2NuN1NHNktoRG5lOTBlWkN2b2JEeTBFNjFQYXhI?=
 =?utf-8?B?czJENWxIdGZuOG0yWFFKQklkODRUN2VrdjJQVmJodUl4V3NVT25RQzZFL3ZT?=
 =?utf-8?B?c1ltb29RMFIva21HY3dENFZWejBVd2k4TnlrTFlyUXBaQlJ1Z2ZXdHF2OHFS?=
 =?utf-8?B?MjhKV1B3dXEvQ3N1Y0JkQkZXL05vUzNZSzhpQW1Ga0NvWk9vT3JLWmFBdy9I?=
 =?utf-8?B?Z2VCSHVkUC9QbUJ1RkpIb29HT3lZM2ZyZnF4dEZuV1I0cUIwNkZ4TnI2MWE4?=
 =?utf-8?B?M01HdkZGK0lod2Y4Z3pLdEpta2tOS29sK3h0UDFFRC9SaHphT3hpWkdDRXI2?=
 =?utf-8?B?dFkzUjRwb094RGFLV285TUgrL0tyWGRXQzVVVm1WaU56MTlaTkhXTURkQTgy?=
 =?utf-8?B?S0tvamVxMnlMem53cXhMMnZIdkdsSXpLOUdtMzliLzg4eGo0aHg1M3FHNGhQ?=
 =?utf-8?B?SDZ6ZUpHUVhHWFZOYmdOS0NhZlQ5K1pQR29qSGJTaHVoSU9xS1lJU2dJTnh2?=
 =?utf-8?B?cXVZWTFCUHR1ZWlQazl5V2RMa2VvVFcyUXROS1dxVVJrTE5LVTI4UHlhbHd0?=
 =?utf-8?B?bHNVVGZKSU1ka3ZtTkFXcXM5UjRIbGd1TkoyTVBlZVhSOXFuWUZaSDFyN3pI?=
 =?utf-8?B?NWIwOEdKTGtIRi83NUl5WDBJeXhuMHdnRXI4M0FMOGNuRDdQb2p1dXE4cjdI?=
 =?utf-8?B?MGhMazFBZ3dKckVyR0JydmVnbitTVXV2ckxZTWI5MjNlTmthOFhyUGpKUHU5?=
 =?utf-8?B?RlU5RzhZWHkwSU53TFZ3VXdtalhNR2t6aW9qS2NXNG5COVZWb0trak4vcHB3?=
 =?utf-8?B?SlViQ2srcDQyc0tXeW9leVJPSlcxS1J0UlUrV0J5T1dieDVacDIrZjlpUzBI?=
 =?utf-8?B?UkM2RWpkQVNaWEp0Q3RtYTRVSGlpSTFvTGl5bnRydGE2b2JVQkZrUXNpT0tV?=
 =?utf-8?B?MEpDaS9sMDJuSEkxN1BrWHkzaFQyYXdBLzMyTFVmaTZSRmVOZEJxZVplRHF4?=
 =?utf-8?B?N2JxQWFVWkpGSnhjOHdseG16TUtMNVpaZmZVZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:29:20.8196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269b12e7-6f5e-4927-88c9-08dded62887b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10487

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


