Return-Path: <linux-kselftest+bounces-41588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725FB5908E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD467B2FCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315462EBDC2;
	Tue, 16 Sep 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fYvNOFpN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492782C11C9;
	Tue, 16 Sep 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011139; cv=fail; b=YsMWXdH263bb9vJ8Vc1UtSIz+OpxQjtr5ILOE+YUDnuY4BBf9WPN8Lp18FEKXKyOV3lNxisYpyAI5BxFqZZ8SurtE4xAjrfVF1XOKJIG+LLztffRVUZzSly1cyge0dyRCMt5BilMdQPqLpyxnZ9p3ABrgaSbybp9a5pBShSgMZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011139; c=relaxed/simple;
	bh=4roOIwVB4t/QyVRpZ7WhxO58mPofxqAcb5mjO44z5c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKhQ26TU3pQ/u+zJTaVGeYgomdalhe3PpKHGqvPbvX/AsUcStCzgDtr4Jk8SmX5PyBZ72OeGeBFSAm3IPPGfVH6AoDdFyXDyMAqOH0jKwky4vIGnZMLfUghORpH1UD4rTaVudcsKosw79AlApz8Fk0tqzAtHE7B9lOFjkLA17mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fYvNOFpN; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he0NRbp0Cil/RqEjuQM2nFPP2oF4lWXqWUtUY9qTtoNKmhkTFAjugMDKvoG4sPpnOe0+9+RMRwXTc8eHSUOOb2ciaNrqeE8lSYHoQFesIb1sy9+Dv84lBHDyCJXcFQoF+acc4i/XJ8qJ3QdS7HBTUAwgYKlJHP4SRY35dLH97TiQKPAr0Z5gb6uQXVGT1Ih267UTfkqGbFQU6KvuWIB6gENux7oqBErLQ1S3e6YnAMavYBn3o8pUDMOgiOYo6iXfglYk8wsAlJS6ESdUeDkO6fyTZCgTYaivDYkfSKCD6cm82Um8Ickflnzmmnk+s4vlgBMNXtVMrfsjuoe2P8Gfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvkpQev33JM82+voUy94wmxzIg5p1RbiMdjsJAb0Tf0=;
 b=t6SyUqWCCcnd66BlHwjCZDtyqwu6oinKaU59zIUSHFx2TLwfamks8YZzlNh08kecfXNsRr1Qh1hBIIU6x9lR4pXfYczcxTwstCEmT9JAlEkFbyOYI2z1gvqv+1MygW5E33sqobaJaSiY+so0CduAGns3TpaUTlDydxGrrn+XJ60lF2/z61pr5rU+q1KFpX65r5E36iQXyNmuAIn+jNpSozwB+Nk6aeFhhE+h7nHzBol/JmBku602UisEqikqylxpKtqtoNLVytTpZxCyvFAdvnjNKl8ZwUq57qsVhsnjtL3EoX8tRTyWUJvy3xq/VNsw7FppfSXHbRIFvIfJhkdvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvkpQev33JM82+voUy94wmxzIg5p1RbiMdjsJAb0Tf0=;
 b=fYvNOFpNKOZ4hii2I1Wq4937qNL8LSi26qNmSMGvg7EhLVJhws5c0dAreWaCF5UZAEYcSWe7+4yRa6K6lu7QLjfqq/yii2Ptm+BvC7ueMu82XEs9AcvK+ZmbP+2/omwFC55Nas4qgQ/RBwtxst89TTh1WFJW0VbQVSlgC7dxIOD7YD67VXtZ0hYMMLtii/QY4w7Q3sLqZZXwpUux4OoDDZrHURzWiHfcYYLr86Nwv5sFfvY94wX0/NOHMBD7UTr0o03TOqComw6FaX9cJQI4VEYKd3jQiZEGV5JjpRID6febMaoszepeghWTSOjaSv2G2bwQ28Hsj7/MJzB8g66kjQ==
Received: from DB8P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::31)
 by DBAPR07MB6789.eurprd07.prod.outlook.com (2603:10a6:10:17f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:25:30 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::a6) by DB8P191CA0021.outlook.office365.com
 (2603:10a6:10:130::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 08:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via
 Frontend Transport; Tue, 16 Sep 2025 08:25:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6D2EC20319;
	Tue, 16 Sep 2025 11:25:28 +0300 (EEST)
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
Subject: [PATCH v19 net-next 10/10] tcp: accecn: try to fit AccECN option with SACK
Date: Tue, 16 Sep 2025 10:24:34 +0200
Message-Id: <20250916082434.100722-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|DBAPR07MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 811b8e57-4b9b-454a-6a76-08ddf4fa98e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnBLS3c5S20yL3hSdlhBZ1grMlJ4LzJZMU5va3hhazhEaUVjeVRlR1o4VENX?=
 =?utf-8?B?bDJtK0tEMGd1VWx3YXNPNVBsWXJtd0RiWGJCU1EzOVFyKzJybXFicnZndWwv?=
 =?utf-8?B?RFRCREpyR2x1d0IyaExva3VQMnVOTk9lSEEyNEdYWnJkbTFDY2pOUXJra2Ez?=
 =?utf-8?B?ZXRhOWZxOWpieU0vOXJHaHJvejdCVnhCUXpuUWNkNEMvTlRRQzEvY0NuRVJF?=
 =?utf-8?B?TU5TT281SXd0NitoVnlyYWFZTGN0M0VVSURsYURrTjVLNmhHWWNMMTlrZWtz?=
 =?utf-8?B?M0JuOWJkRlNFZkFJUVVFaEx0UXFXR0grcDE2RWhCWXBCbU5oSHRheE1PSlBx?=
 =?utf-8?B?NWlSbENyTW14N1ZFV085YitNOWIwMXVKTGtLd2RXWHZCYytyRGJXVEliNlpR?=
 =?utf-8?B?blY4bnE1SG8rRkVTRUs1QTFJRXRZZmZRUkZTVFR5V29kamRwMUdtOXBUNGQw?=
 =?utf-8?B?SGxjam15eUtUcitkTWVKL1dDK0RWcGljUXRsVUJrRXBvU21pVnJBYTlHUFd2?=
 =?utf-8?B?ZndTRVZjUytBVysydW1MY0NCOFc5YU80ZDFNcmtjSGdLeEFYWUhiTW8rMVVk?=
 =?utf-8?B?Zk9xL3ZEbGZFdXM5RTRyZGcxZ3FNdyswWStmRysxbGt0NFEySkJXaEhaRXFq?=
 =?utf-8?B?WWJ2c3JhYnQrV0dndUNzU29JbWlsNnlyWmFTRVQrMXN2QTdPL1hhUmhXVWtk?=
 =?utf-8?B?aWxFMm5kVVRPMXhmSnZzTnVWNVRsTmFWWTVPMU9uSDIycG4xbHRacnFiOVhm?=
 =?utf-8?B?R29IcUN0bEFhYzFPbE1IR3ZBRGhBUkEyUk55dHBKanhUNzB3c0JxbGFibDRa?=
 =?utf-8?B?TXdOd1hzN0tsbVUxM1FIYjVZWjZCditXa3VBVHlpRjd2bTkrY1BEWWdoVTZL?=
 =?utf-8?B?TG1JYSs3bUhEL0lmZTl3aFhBay9kSVMvTEFqTnpwaEdHczJna1V1bSt3MmhY?=
 =?utf-8?B?dmdlek5aNGwwM2o1Qis5aXdTaVU3L3VzdUl0N3NteXhxeGEyeDk2b05HVjZK?=
 =?utf-8?B?WmpCWTBHT3hQb3FsTjlud0NoL1dCYTRJaitiU1J4OW5LeEtka0podnZ0V0NH?=
 =?utf-8?B?b3RkMXhIMnQ5OWVwVWlESkd6MmNOd01DSW44UG1NaCtWeVd2aVRCbmZNNkRl?=
 =?utf-8?B?S1RxRTRiS3lZNUp2MkdxZ3YrUkdqN3lFcUZjSCs2YlZUYndhdHVQV21jMlVG?=
 =?utf-8?B?L2xJRDZieWlhRTJJZEhQUTZqSHp1WGlpL3dkV0ZpajNiY2VJZ3pkZW12M2tQ?=
 =?utf-8?B?eXZhZU5uVXpabm4rU3RCeXFiSy9TY1FBS2pmY3RiNzRaVURNQlp1SlVzL2d1?=
 =?utf-8?B?am93TDdFQ29WQmFYdERiSWhEWnM3RXpGVWdpTnJiZXhwWGwxckhyMDIzUVJr?=
 =?utf-8?B?Z1p4a1o1NldJRVVoaVhoekNBalV6SWJoRU0xSUpZUXNvVC9SMEZ0anhRVytr?=
 =?utf-8?B?ZWZjakM2eUJuOUJ4U3N3dXpUZUw5aU1ud3JIWmtYOURyNnpTQUJ0MHRUYWU3?=
 =?utf-8?B?VExlMHgxNm00UXUxVmJHYTZqS3lqV3lNYVlTMUowbk9rcGRXR1V2dzVranZ4?=
 =?utf-8?B?YndycjEweEpra3VyME40bi9YaFdENDR2REk5NUs5QjhNeTdlMk9Cd3BKaktB?=
 =?utf-8?B?MWluQWdvd1UxeTVXTmZHQ1kzMS9mVXA5aEQ1RGsvWDg4MFN6S3BnNWhBSGNC?=
 =?utf-8?B?MnBsTjJ3ZUpoZTR5Wmt4VFdrOStnNk16L0N6dVNmdy93R2lxR2NuSWJWbkM1?=
 =?utf-8?B?WjdBQ3NiZmFjaWl5MlM4c0dZWTlqOXlvSG1BcUJ6SWV2TGlaVm01QklKR1Vh?=
 =?utf-8?B?ME0rTjZoU2liZWxXQmwwR2NZRDJtVVEwaWF4NFltSXBMd0pHRDltWEZxaU9X?=
 =?utf-8?B?L2pVbHBXYW1KTXc0YVVld1ZoVVNGQjFldlR1YU54Z2xFMDZFQXBlNkFqV1d6?=
 =?utf-8?B?bHFHYURybTVLbnFWZFpFWDRhZm5ZVksvRWswYkQ1dHg1cUNIV2lNdUg1Q3B4?=
 =?utf-8?B?NitHZEVCa0R5WTYxTWEzQlpBY1hsNlcrYnJ6VXJMTmdrSmY4UndFQVM4eTdC?=
 =?utf-8?B?aTJkcG80UHo5anZxd1BJUEtVRUNLUTFTQWpoZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:25:29.9503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811b8e57-4b9b-454a-6a76-08ddf4fa98e4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6789

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


