Return-Path: <linux-kselftest+bounces-30572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EDA858AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D565E9A053F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15132989A6;
	Fri, 11 Apr 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jXiFL8Ts";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cO4NMGgH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD81C5F09;
	Fri, 11 Apr 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365568; cv=fail; b=hTHQl3h08PaPSKvtNvFAta5TIGmbyvpAi0Kn1i/zDpYOYrQPLGVfovC1Hjn+wXNip+lssnso/m1PtS4piFgaGr7ZS525HsSp5uv2z1lZqaknnap2v1XZm5OSeh0VAEJNTlEJm0+XN1mIVVHekAD95xZnxGe/Pvv05D7FVZegBVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365568; c=relaxed/simple;
	bh=yskFPqgNJHd0oDHE1bY7Yn+zuUgw4kcmC/588W4q/cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=asJOZVLZ8e0uEQ472wSiYSCY9A/XLd6wJQvhspXeuAklkoAbz5j6GvQPRPtbwfImjEWA7nupGNQ2IWInHfqVoPJaUzT20tmiAqSz4MiP21ga16JgmxJqv3OIX5TTzTMV9Wq+/K28FRi5FEsNh7va/Dc3jxPm9Och3+SpPUXI8o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jXiFL8Ts; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cO4NMGgH; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B4xQtE029246;
	Fri, 11 Apr 2025 04:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=wEI1r5bW3uviIdqe
	xqy1flABT7gkVojrINmEKWJZEkM=; b=jXiFL8Tsem0Y9v00uBs8Chc0OCs+Oug+
	keKAHitL7FoljoQ7siSrJwsPQ6pbwx1ciB9iGengGyM+wFL7kmKdEboPhUNwGHfn
	+Ibgk1bBTXBPqHcp+sb0aWrincuaiL+JaxX2IlVmFW9i1A9SIaCPrHABla2jkTCu
	gZmjGteuROMT2aSIY0wMvT7UTdKUHKqXgdI+6tx819Q0vmJkWw5Eful1hYGndSIk
	tFh3wybip/nvSwDJaRBWETWlmQ8tmW/k/8SdvlthdmB6OfpxKmS/x4Yk1lHdpmxi
	/OAGf4uh7GvIzzckkq8EewWriVZRkXWCQN4XHvVL4DoJz0QCt0rY2w==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45xa4bhm25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 04:59:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNLq52RcIGeAP7wB5BOqkEu10eD6aiePIjjQLIE9X8Yca4Bl4Qegbr/ykWHR4KKJgEuGbCmwe8x6KxCFNWpn35XAlRWW8CP8JuGtMHwqHovd5h5//MQKBpK4MceZtwAHU2FP1f/YUkHJ0+/rNLRWuRRrClzm3fWzORAHl6TRiUUA0Mrhkxy+0fJE3yebFNMlcuskS0swDjPPXVimkZQEAyQ+nPiE5u3u/GS+FmXzZf7lVnu4+r+RAySNsl/N4xAihmQoQW+fsBMS+fp024Sn8+vgO50GX3wUXJCTWhVLNd2MIEXSeBEgS70mgGcBJy/6bEVf9Ad6MsFIn63ZuWm6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEI1r5bW3uviIdqexqy1flABT7gkVojrINmEKWJZEkM=;
 b=Lfgfb8YRwXGxNmbsOoC3fjo0AUd5alIxV5xm6d1eem5Y901NS8VO7zSmgbYPDXgMlqGtCGIFfLD5D9fiNkicMObEHM/g0bbZMKbNtSPgElSK+4j8D3GNSQ0xqcUpK7TclBYUj0hK1yLst8dAzJgldXkFHZRzJhYtfPAITCt1SqpT7CA45ZbC/vakv3CK2slRcPcW+razXyhqHr2/MAstO5OBGZsDyZoNC2E2G24gPTf8khKbDElPyzIxxAtzUHVeCCVQOrJyKuL8IW84wNqJZwgK9guiLWVqiczbyt+W39YOUGqqjN8sfuznTP3ewQVyGI5BdmVtD+ClQJOR9SaSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEI1r5bW3uviIdqexqy1flABT7gkVojrINmEKWJZEkM=;
 b=cO4NMGgHlK86ccKC/i9tQtaWezY0amkWxABnytiEEsNvgh4CB+W8QCMPirXqOLy2f1eq8onLjepiw7U80atQOQtAIg52pGj1442zd8VPFxA9/w/Ow3oLeYgjrqcwKvYvA2Asrl3hJZF6ir9LoQ88Ww3k0sGuheqVKt0nfdIeY+8=
Received: from MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21)
 by SJ0PR19MB4747.namprd19.prod.outlook.com (2603:10b6:a03:2e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.40; Fri, 11 Apr
 2025 09:59:08 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::36) by MW4PR03CA0226.outlook.office365.com
 (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Fri,
 11 Apr 2025 09:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13
 via Frontend Transport; Fri, 11 Apr 2025 09:59:06 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1702F406540;
	Fri, 11 Apr 2025 09:59:05 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id F35FE820259;
	Fri, 11 Apr 2025 09:59:04 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests
Date: Fri, 11 Apr 2025 10:59:04 +0100
Message-Id: <20250411095904.1593224-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SJ0PR19MB4747:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dd727402-33eb-4770-3b95-08dd78df7fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Yr2BQ/q2wFyp9BNGX2RJxDX8kiVclZvwFzMo0IzxYs6Dluw3/4Eoa3qbQ0z?=
 =?us-ascii?Q?WcvAeQhomAM25NoERBRVo51KKQLQ0iSUkU1u4HVZMIv4oytEL917fa5c0HER?=
 =?us-ascii?Q?YXaxVu98XNJQUL7tjXu8fQk6RF8LgJtRdax8hVvU80oRmKehrfMMm69xTgSB?=
 =?us-ascii?Q?xHq+KFeUQ7n8GJagcEfoHxwW9W3UEhBouLYaPCyAe3RgrusNonYGWNEw/ML8?=
 =?us-ascii?Q?ZVTg4vRLsguDJt0M6OhHWtfzg9mItyJ/RVLu38rPc0i3lHuaL/hK8rcGQXKr?=
 =?us-ascii?Q?HHE9Ba4Mv1e4J6MspCLIoX2MzDn7O7nfqbeJ2BAnd/U/lE6rtC7S/H08d52B?=
 =?us-ascii?Q?oXlBZ13MK/m1wAtdXuiwQ3GAihXXUeKwDKFbAmcVVaueZ1eRLjFlCOUkHcgx?=
 =?us-ascii?Q?8F2J1uc4FIQAu3zbeItXQ1Rv4+ABYCjuFTi68hAdmNMx221qQYafG4/djPkw?=
 =?us-ascii?Q?fDRT0ffg9QLJpCFj2lAgc6zOP9N7AjGCO+1ThUDSuyVod8eT9IvAD5zBsZ3u?=
 =?us-ascii?Q?gEHJJasBKS6pSg85zSYCqWvsvK/1XqMgeuzq+KvQ24xtXVs6Zd2Abh9nYpWs?=
 =?us-ascii?Q?jwKAIm78KLVC/oEXNyztsD37Tehx8tFJYlTfogcr1Of78YvtGL50wdthEuUX?=
 =?us-ascii?Q?Cc1DxY24A9OsyijzyMq3AA9y23znUo9Nq+uGHtxuLGxOK8uUs+CGetUk8NvY?=
 =?us-ascii?Q?Z4bKaebSO0XOllq/F1QmTrNdzsx/508lH5l2R/r0yTPZ1dWi8DgnYLFadOA9?=
 =?us-ascii?Q?9N3YMmCcDY8xcPAKd2uYXfb4lI3NZco6zTdtR6Zh8bjXbhXKnGqELEE4efLz?=
 =?us-ascii?Q?wpj1D4I8rwXyUdDmuYyOud0uzkKRXxjOeORgcxo3LYTB2Ebkx1scYB1N56rC?=
 =?us-ascii?Q?vU+a+qW+VCq6qqezOAjtK4zx2w/4UcQNj/x3r26P8ZR0eN0yC7t6KxcRgooC?=
 =?us-ascii?Q?8dVvltDz5/bUFu7JjXR5KhBTSTsbvP4NGTMFEZmruxgPxu3WZtDKmNvBLg4v?=
 =?us-ascii?Q?xPgzkE5QWMrhF1qviQiunH22E3HLk0lW0GRvWCojl7S20lMm8+Ivnvit1UQh?=
 =?us-ascii?Q?mMIPINtYDemE+BC6tf+4kMLSjgsczIA5MWF5MwADT0vGOoseeBYS7XM1cv//?=
 =?us-ascii?Q?lEEi5tINU6faxkJ/rVW1rNdYrBglhnrQFyaqjfVCwrdEqHl02FVm2eOJFZwK?=
 =?us-ascii?Q?4ZSGta9RKCXmWmW7kgcAnY65ighd8Dgtmt1xwfjDOyHQNeZA/dZGsHKzQDoQ?=
 =?us-ascii?Q?gFs/GfBMuXhKAG2j/FNYyP6sx1JEm9OZFMv5IeJyDwSe0KY2GtBrEpaKKmN5?=
 =?us-ascii?Q?XavggC7/AoIDIHZNydCHHuiLrPa3yM7eKwBl49o0wZa0EkTV/EHy4ej86v+o?=
 =?us-ascii?Q?RysMwbjNQmVDPWv2P6rRLHNwFH8uohD7vNcSL7aqn6QEoSZem0tnBvS8atTW?=
 =?us-ascii?Q?Fo2sD8RBfx0L1N3/OXiD2HZaYZCKnKlyLGA8HDHlsrFUdn1fjwOzsm3JPNoR?=
 =?us-ascii?Q?rA23cKumqUQbyXhVcCKZTmQrPtJ01XRRHZ0+?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 09:59:06.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd727402-33eb-4770-3b95-08dd78df7fc0
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4747
X-Proofpoint-ORIG-GUID: 3IggL4IuALT3YIHHyFdn1hBQkRBaFJQj
X-Proofpoint-GUID: 3IggL4IuALT3YIHHyFdn1hBQkRBaFJQj
X-Authority-Analysis: v=2.4 cv=B6W50PtM c=1 sm=1 tr=0 ts=67f8e7f2 cx=c_pps a=9T78G36u1E64A7MtQSounQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=lHWFLdnl7NMM46MAG3EA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests.config. This helps
to detect use of uninitialized local variables.

This option found an uninitialized data bug in the cs_dsp test.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 tools/testing/kunit/configs/all_tests.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index cdd9782f9646..4a60bb71fe72 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -10,6 +10,7 @@ CONFIG_KUNIT_EXAMPLE_TEST=y
 CONFIG_KUNIT_ALL_TESTS=y
 
 CONFIG_FORTIFY_SOURCE=y
+CONFIG_INIT_STACK_ALL_PATTERN=y
 
 CONFIG_IIO=y
 
-- 
2.39.5


