Return-Path: <linux-kselftest+bounces-30594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C01A85D32
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01494A8843
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D6429CB4E;
	Fri, 11 Apr 2025 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="q3i0pcGY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="R06JrkSs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53CF29CB3E;
	Fri, 11 Apr 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374994; cv=fail; b=VphPavpE9ceqpSEAmTBQeUijJwEp2opUtbqDMRs0iemV4jhuis4edfuz9bw+ByF7i/EtB247hkVSr6IbEDjesLeIMwZUH3kFmV302g5kDQiPCamY8/7qMj7fUG32RvYDwsHDdIBPP8KIsxRRQ8oeNFcSUZhKlxy5ptrVg65JWz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374994; c=relaxed/simple;
	bh=F5SoqIwknVE4vMhPxe0KncfvObabnR2lDfSPcaFh4AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQX5k97RwbTODkNflt4YzlZtmCGshPMA/0ix6Y9FWR0oXK4PjWCSanTwv8GATdBx83Qmqc+l2KYtLFZRfrfmPuOUkI8tdIizAresfGG5HGzKiL+XqwEHMFj7pBZzI534r1ZaTOsFW2CW1PY+y397SOsJqXaVTYy/mQq2kG0hDFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=q3i0pcGY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=R06JrkSs; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B40Dlr011308;
	Fri, 11 Apr 2025 07:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RXEGYdTsQ66uXOZ+fTMTobvSrxJNI9g4YJifQ2nijKs=; b=
	q3i0pcGYrqWxXn7RIaOO3PYNb4PIJuIKOAesEucI1g0TF/03ELK2afxyGWDb01mo
	3OznHtJVUHN5DkWFA5j8cxrkfYKanBJ/pcHDV5Hd3V9IvQ7g5i46zVo1TkI/sM71
	Vzvi6vkijHUCi7XhhEcEkLg4rs6XyovB1MSzikFJ174Go8USZgA2owxMX/4ZVH4m
	ilv4doAMPbahRcK6u7MksXmO8UmWD9VMZHfwEwMFELRQDHvODqwKMeN+rYNOgO3J
	JlKD4gpAl3zgs89kS8vmduVL+jnzeIYjPghunmPGio1c2samhe3iRVguz8RFfips
	vqmxc1Tt6h9nQJF/oz0YVQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45xa4bhse5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 07:36:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXxHiPoJWEUvoxow8gFSmlDPk/hmUmIJh9MqhIZTYweCaGiI/XeKnunfuosSRkSyyCiT/hdxqwB/kQd6+uGXeYrL3BPaIk21TFIBmKuLuXPy3nrKTzXm45Q7kSBBME20WC/t67n4fKDMXs1A59sYfyQbAY2W/QjAw7g2r5/cITVx0D8SVhL9yfI3vquceTMiLMLT0IZxxXPC82QyPGZAYSuB0kJtquBaMkVnbED5QC1M9ws8Cg4dogsvLL8c7dfDWH7VpnoI1tOdVKKvIOazXnj6k2o/kJuHAHxPqSTJv4s/H6PAp35C3LDuXq54d+PhSBHBw5UispD//I0u8Qjkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXEGYdTsQ66uXOZ+fTMTobvSrxJNI9g4YJifQ2nijKs=;
 b=KNRtYs27a0GqfgVfi2i/rDHF0X4I9u6VsW+JlR73kC5spTxMWSNNZ8uCC0kGCJ7GOg89ZjtJQf/eApQKJ4Vf/AX6vGsZH3GhpdRDBOER3Sjx12EU1kiOGVEsHWNgUnPKgrS/f7ZK9T7znwz+C8AsRgswQNTlWiF4iyKDv43NtIjNuE4aINdOd6n1x3KanZbUd6YEPs86EzsmFGdFwPEHiYD9KkqRA7xY5XcwloEH6y1o3x0QHwFbJc/COw0U0o3Gn44VixQeZMKx7675TyLbGi9FgJdvrZWfJW6AYy8pwqrNG0oXMRaI1A6ipwg3pe3MVz0UlNp0iv6HYNp8OHYUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXEGYdTsQ66uXOZ+fTMTobvSrxJNI9g4YJifQ2nijKs=;
 b=R06JrkSslUnuzlgFTReCpsT/P1JP1XyHkdjZfHyCw45YVMWnl/5csqNcCsGUdtBNDhzfN+pXj4RP3ZAsmRou/BWBZ5Cig5Tq1GIfvxcC7F62Q3R4GccGd4rQuzknoXvJe+rCGtpaAvJ+V0hSMbh0taK1Yj6VEscTuTKTKRoJAII=
Received: from CH2PR20CA0025.namprd20.prod.outlook.com (2603:10b6:610:58::35)
 by PH0PR19MB4874.namprd19.prod.outlook.com (2603:10b6:510:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 12:36:11 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::67) by CH2PR20CA0025.outlook.office365.com
 (2603:10b6:610:58::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 12:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Fri, 11 Apr 2025 12:36:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5DA76406543;
	Fri, 11 Apr 2025 12:36:08 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4AC0382026B;
	Fri, 11 Apr 2025 12:36:08 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, brendan.higgins@linux.dev, davidgow@google.com,
        rmoar@google.com, npache@redhat.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 2/3] ASoC: cs-amp-lib-test: Don't select SND_SOC_CS_AMP_LIB
Date: Fri, 11 Apr 2025 13:36:07 +0100
Message-Id: <20250411123608.1676462-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411123608.1676462-1-rf@opensource.cirrus.com>
References: <20250411123608.1676462-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|PH0PR19MB4874:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce1e3260-20e9-4a7d-7290-08dd78f57007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J/yrW4kunW6VHHce0uuwgxEHS2V0fjnAaMapUH7k0wT++dk8I/K87wbWTc9w?=
 =?us-ascii?Q?j1zIRjGdP8H+y2ecQoJWxEUp/7CDOUpOALUkDPVtP+vqPulnGQx8Ss3crZ0/?=
 =?us-ascii?Q?yss4ffs7M9MoeerDJIDssPfBSZe4HcHwfqs7+rUKH69EKk5n1cwcNEoFRB4J?=
 =?us-ascii?Q?0sBmpgsoOSBi0DfTNan268VjuGxVGUquNzsnI2jzm+cBJuTXav+P+Qc0j8y3?=
 =?us-ascii?Q?+Slt8zSKMJRGVG6RrD+Q5Z+SLfd/EVH5WtrXV8yj/rxXfR0BhCargOdOVL26?=
 =?us-ascii?Q?5j0+61bW6G4mVCVpNlNBmBwZs+9uyNKAapV8qfhqkaqzWfo6ejhWGS74T762?=
 =?us-ascii?Q?wupexXNtYsauxHd41WEeu1Tgdr6BNIUCPWdzqtQaE7pVrdQ3OhRVH9Xy4n0y?=
 =?us-ascii?Q?G0D1X/FIEIMVi0Ti8qVVpN0n3Wa9H9WIN6//rRlpuk9JjI+QwAsqSDbhvFr4?=
 =?us-ascii?Q?9TCuIn33RIC+hSwAD1XkGO7exECGn7EQtVaM2WonHiOMyo+FvXH36NwX+LUb?=
 =?us-ascii?Q?Zj21neEztFfG5WixympDTyPRI/ZFpdh2IdrBFbvtzrQwXdtcEuTz9o3EvXl1?=
 =?us-ascii?Q?jjPIvwcjooWCmg6gEPb5YxAZRcxeaZXNCyubmIYGeFjpEy5koT7EpSKsKLP5?=
 =?us-ascii?Q?w3M+NRkG2aKY/pKiI1zkQ7hLt7snauBOfsY2aCslixIwv83KtKZOf7C2ZAEk?=
 =?us-ascii?Q?qU3HkRN+4TTPr4l5SqZbrGnTOLhxdyipSFS9bYqlkg06al8vMgYyLLNiRjau?=
 =?us-ascii?Q?FoRLH5WvTKdtmBoNX/ufwkNKHVwywAg0XdC0w/WsLcCxeV5PP731on1pF8Lb?=
 =?us-ascii?Q?nFGQqCMPk5Q+eYynsZhDPHzdwIBpxNE3LLu/JTUx+0CMbV6oToeUElVurFv9?=
 =?us-ascii?Q?ZTsJioYESlb79LNUWUuDLE7az57EldKVdKHui1wCArCGckwnQMCoVAJ5JtL/?=
 =?us-ascii?Q?O+PwKzrgmetM4sIEKKDrMaIgPhuQuIq5Nna0oF85YpXCIw6SUg7mF1REbPmI?=
 =?us-ascii?Q?CGt0Bunu242Y/yOREDoSbG9Ci3EJirSfLSZR7OpRcgcO8GL7Vi8863rM3emS?=
 =?us-ascii?Q?xgKP5XTPWRausX0LT+QgmCjJw8LoiEau3OoC0VvtBdVrcMG6yn24V//I2l3F?=
 =?us-ascii?Q?95lWGQ5iEVTzlCSNnvyL3quyLRClyrgWjCP/NUKYOic5Fj5nrianvl+TVflA?=
 =?us-ascii?Q?XIA4arWwoqCNVQGNyxW4N9f4nd92VR3u9Jn2H6a9hN/9imerXrijxD8PXD6p?=
 =?us-ascii?Q?eFOHx97oh5/T5GiKv6/Teejsa6bry1nIFa+r0TWAJKTVo6OSY9vKKxl3ck8t?=
 =?us-ascii?Q?zO1LeEtUuuI26KhMvqrl9dLVkT+B4Q5FzZe1TXcZT3yB+E3VVk3hnJDHGD4n?=
 =?us-ascii?Q?TCu7vdFEaXXfpevPtg8RKfGZITaeZFrehQovuhSMGaUNqArR06TSJMRzPYDz?=
 =?us-ascii?Q?pvoPCWLThQ30Q+s9pEaibIUWz4FAXR8/chyYQu0y8ZWdrod0UuQcYrJaJaIr?=
 =?us-ascii?Q?Ab3WFZuo4plSh9MlsKomFV71lqcE/xyZGf8m?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:36:09.5991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1e3260-20e9-4a7d-7290-08dd78f57007
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4874
X-Proofpoint-ORIG-GUID: FO-rJr_FkP_BatU3AVyiDwBSKWJuP08S
X-Proofpoint-GUID: FO-rJr_FkP_BatU3AVyiDwBSKWJuP08S
X-Authority-Analysis: v=2.4 cv=B6W50PtM c=1 sm=1 tr=0 ts=67f90cc3 cx=c_pps a=19NZlzvm9lyiwlsJLkNFGw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=23dBHJebA2L0dVjFQOcA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

Depend on SND_SOC_CS_AMP_LIB instead of selecting it.

KUNIT_ALL_TESTS should only build tests for components that are
already being built, it should not cause other stuff to be added
to the build.

Fixes: 177862317a98 ("ASoC: cs-amp-lib: Add KUnit test for calibration helpers")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 870eb90116f1..c388676ce380 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -776,10 +776,9 @@ config SND_SOC_CS_AMP_LIB
 	tristate
 
 config SND_SOC_CS_AMP_LIB_TEST
-	tristate "KUnit test for Cirrus Logic cs-amp-lib"
-	depends on KUNIT
+	tristate "KUnit test for Cirrus Logic cs-amp-lib" if !KUNIT_ALL_TESTS
+	depends on SND_SOC_CS_AMP_LIB && KUNIT
 	default KUNIT_ALL_TESTS
-	select SND_SOC_CS_AMP_LIB
 	help
 	  This builds KUnit tests for the Cirrus Logic common
 	  amplifier library.
-- 
2.39.5


