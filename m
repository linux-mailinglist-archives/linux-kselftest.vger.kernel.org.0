Return-Path: <linux-kselftest+bounces-30597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F71A85D6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CAB4491FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1562D4B4D;
	Fri, 11 Apr 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="p14ToePp";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kKVebrYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9D2C376D;
	Fri, 11 Apr 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375017; cv=fail; b=unuXn+YMYiGLihVJJr0txShbR54NfZH5WrHrRNO+paXC13DvDdDZwBZlEA4Fk4UnG/nYnc0oA+rIlUSwe6xgZoiiX3tUsE4QR/2tL+1w7HM8DLnlf6NtTpF+pLftcXrvMKYebuvPEkDAxOsjO5w68gcshRiykMNDzcS9284+V+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375017; c=relaxed/simple;
	bh=zMHsTmx/jXt6V5X+b8PYIKvMBDORKNqnBvkoE+7nGO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTfSTobu4iAsi+zq6cLM+Jvn5U17iuN5K+BVCPLvThcswoDFjLF2qcUi2mQp7wfIlgVaLwMjtpH6UEoEByS6QoyRsnBHKzGnnAYyLxV34hN6ZC5jr2JxZ6JcMypJlnYU/lMbqxHj3RcDWs2+Y2oS3fiuK9I6zWsdC/RLGCHEiDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=p14ToePp; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kKVebrYS; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B4gkZu011201;
	Fri, 11 Apr 2025 07:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=deTRgEByAbIV/tjM3T5XXM2YUaWWsinq7/Fy65bhMXY=; b=
	p14ToePpi/1KntV3pSLksmpmO65XYGq51WI9Qc98kDsA+lAw75DZJuMfOEnPmmqI
	N85dz06wPrv3LTsSuwPHaywyknO6RQQ8GdTXapUt4bSaWr+qJENdjeLZ/3j+qOsl
	9auJF3r0BYsioZkCF00KlaxyEaH34Vkiu8afCNywScdS4wxBkzGjtnd6MpW/pdk/
	le51/7ljAJEbVeHb409ZM18EswGWAMxqKquXFYKFOgf4n12uUOl/9ZEH/mE8/fvK
	e9CbXlQIhzG7+fNWiYV29fawa9/qzWYGaP3cInZyutLzd4zT2HJgENR01xC8cI5t
	mUUdKXWLsdj86hfIQ50SGw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45wf0gutyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 07:36:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiFDBdjEoPb5YsMagsnARAf95F8HuFubhKeNKAbKbT4g9eca0KjmUf6R36O+YcIqAYOT06jsGivoELeHbnLBcv5v1M9eBG9ZmgmZlwrM8BzYk3lk/J3i3+Of8Ws3GbflC/ywTvgNqKxTTdgxb4U/s/lSodoHgf6UOWPyYsi5lW1ZHQ14EROix57yc8D0CkUTsl0QgpX7fmYsPuQBl28jeRIfxMYPQwoKQNsn60df3Y9XuzxypdYFq1+CvGYvG9o2VnO5lXIGjopEjWdS8AzIFAFLtpxTsZH4D7NCY91KoWNO10B6+bfdBkLdfujrxfVNePP/JCYpUTegHQheoO4BOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deTRgEByAbIV/tjM3T5XXM2YUaWWsinq7/Fy65bhMXY=;
 b=GFYJCPWfHGVr+QOHvi7Ty6HJ9hk7UtPL0nlol+zYlcmKfja/vBPX1fQafehh5kYAhfCEkI0jobslWndrxk44rRUqUyCrxF3xbj8sZxsXkAJlSLV7G3Rgfxl/KbQXwHyAuObpkRi3wDLuzEFS+2u49M9NUL1GM9ZcfguwG2LvQQNJnSAZv+38oZJlDdg4e/cb8VW0DdRfeVxOTvQQ1rOQXJUq/apC8t8uITm7r6fzIYXgVoXxtlNX7vgrYRbQpzxVJ5Gjttdf8vUW0rWPnCKMOr7J5CIBjl1RhOiWOcqS3uLKfw2m2IL06evLV2a8G/NcpQ28PRUYaxSTHE4Gt9VkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deTRgEByAbIV/tjM3T5XXM2YUaWWsinq7/Fy65bhMXY=;
 b=kKVebrYSk9vsU3MiuzL5r1ce0WdTznB+mbdoMtTx42rxv70uo9Nqvp0QqAe7iJzncCMkwoPKWiJCwem6IsvUHWB6FN4zIUW0tV18LUusbFCjcATYLOSebSKhCgTypzzk4Nx2+2sXVEoLFH5mojZEVk7ADPJt0KHqTCfBwqoNxdc=
Received: from MN0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::22)
 by PH8PR19MB7120.namprd19.prod.outlook.com (2603:10b6:510:217::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 12:36:11 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:52b:cafe::91) by MN0P223CA0005.outlook.office365.com
 (2603:10b6:208:52b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 12:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Fri, 11 Apr 2025 12:36:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 67878406545;
	Fri, 11 Apr 2025 12:36:08 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 58840820259;
	Fri, 11 Apr 2025 12:36:08 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, brendan.higgins@linux.dev, davidgow@google.com,
        rmoar@google.com, npache@redhat.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 3/3] firmware: cs_dsp: tests: Depend on FW_CS_DSP rather then enabling it
Date: Fri, 11 Apr 2025 13:36:08 +0100
Message-Id: <20250411123608.1676462-4-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH8PR19MB7120:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04875840-dc13-4dd7-6325-08dd78f57018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GTaPUTNTj2ybPuIFOXaoYvgMvLT5wlAy4XuRDP/KAsJo/522f5e83fMVQmFb?=
 =?us-ascii?Q?KIa6JZYexpkrj89lV7LzeJvJCecV6btM0q07gD8wP3ArJ3DKljfO2GMiM1Js?=
 =?us-ascii?Q?z8ZVpBFrRpQ8XDemkdUovn4a0nHeavZdRoC4KIOW9tmNbUHbacK+mb/Iz0Bf?=
 =?us-ascii?Q?wB/p46mShPBpf2NVM5u7fdaH5MX3tgJJbRxGX7iiPBgKxgTVIA5n7CcNO/m0?=
 =?us-ascii?Q?6WuPcklOP7MQY90UYHjcf20LqgpiJoCnT27CJxU8rZb9UBzz775jJ49TfQez?=
 =?us-ascii?Q?VIw9nUggPSAwfXr/W6V5SyZwQs+oSPur7w8na/W6NYDFrwOTj3/bwPZr8wwI?=
 =?us-ascii?Q?xUEHuuwYZHpXhwkL5M5eY1+PobkQMj4N57zym8Iel+u7ZCbU2vRD3HbLmzPa?=
 =?us-ascii?Q?DA2I6Cg2zk0MUTGwLQ8wz5Y4NdCQwOlKYvM+qc5gJ6lunm34HhocNYNsuaGz?=
 =?us-ascii?Q?HZAiBUVQk555eSkz2fLzcB+yNKX3BqGNbSOpAhD4M2gz8sauDI+ZVou+4UNL?=
 =?us-ascii?Q?kZvahBqShavOYHqqqTh2PpiT+lHUTPdkS/TtMw9c1xaK9YIQdN+kfjaG7AHv?=
 =?us-ascii?Q?H4aQvPNoWj8n7mx8aK1LKE0UejiwYPQmQuRnk1r7HwGg1p1F1sgMd+1uITog?=
 =?us-ascii?Q?Kdl9RG0tMM9KWm16hGw65Opxt4Ms5ZASGw4/5xTEaQBNIIJIMRES4VOze3yf?=
 =?us-ascii?Q?rNaP0FFHr8A+mZxPsqyd3NDmVF9XHnC2yxKWcGuvjn4bvLI8c+9FcuSeaLn9?=
 =?us-ascii?Q?p3ktS9oY7ID5sUcrq4F5B5HZz+p7OfaWpA9gIOzWCUuvqzxjtaRinNR0UK5S?=
 =?us-ascii?Q?W/o+8UCOdakQCNGXn0WvHoetG4IpgjpIIWt99mfs6iuO1yw5aI9Y1sHVsRob?=
 =?us-ascii?Q?Fwbe+B9Q7Ua/+w1HKVw+QkqrdHm+wZf4bWdTMcXy9CI8UJkUJURy4sCNBZGB?=
 =?us-ascii?Q?uLrld+c84rbbyPE7yb/OOPLOYbtcxv/YU32Sp40nUNOamAVzdxiZj3krtgSw?=
 =?us-ascii?Q?G0UD3ZqcG/92paMGDYL4nEtDEMV0MCBjP4EIBPl6xFH5N656wFc/1AITovIr?=
 =?us-ascii?Q?20Ol0CSvft2BbEGIuayDPGObuWkMVHgTBmMzMh4u3DKScAv3/GJW2kMIngxX?=
 =?us-ascii?Q?LrZD7UVPqrvq5PTQ0UxvdgKZH8cZj6HplWNNWg/qLJhwTSKC5xsrZaYmgTNN?=
 =?us-ascii?Q?B4sqx5kaCLW17d0xhmD1WlnlmLd5PxaRtKGFfc0W3uuC1qFb/Mpey3q40vvK?=
 =?us-ascii?Q?NkOE9PFC8RRqwVmvxt6azFoMuEVtawmE3kIuQk4gbmp1HnCpV/GetHFfRava?=
 =?us-ascii?Q?tCUsYrVR3e3oO9KChxHfSp/iBRuy1zmKaZBoQBBrEf2ogMnYv+O102pESZga?=
 =?us-ascii?Q?JNU943KqEs2mDaI2wIek59yHw/TPxM3GUpP+1cVWMnPQotbO4eTzYirrhJIR?=
 =?us-ascii?Q?4YJhhdbZzF6lvoDblDV8wFWPC2VJeVTgUua/OYN1ca3mD67alYY8u0Aar2QD?=
 =?us-ascii?Q?XxJYLQ3exNKNXtCvSP9B/TEg/K2G+eXjymSO?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:36:09.7258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04875840-dc13-4dd7-6325-08dd78f57018
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7120
X-Proofpoint-ORIG-GUID: amHBZrmes0wB8t0Je5tP4qYvnMKmyZEm
X-Proofpoint-GUID: amHBZrmes0wB8t0Je5tP4qYvnMKmyZEm
X-Authority-Analysis: v=2.4 cv=A71sP7WG c=1 sm=1 tr=0 ts=67f90cc1 cx=c_pps a=o99l/OlIsmxthp48M8gYaQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=20KFwNOVAAAA:8 a=w1d2syhTAAAA:8 a=UbqW4rUhvwvjDBTGmgsA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

From: Nico Pache <npache@redhat.com>

FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
depend on if the feature is enabled. Fix this by moving FW_CS_DSP to the
depends on clause.

Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file download")
Signed-off-by: Nico Pache <npache@redhat.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kconfig
index 0a883091259a..e3c2e38b746d 100644
--- a/drivers/firmware/cirrus/Kconfig
+++ b/drivers/firmware/cirrus/Kconfig
@@ -6,14 +6,11 @@ config FW_CS_DSP
 
 config FW_CS_DSP_KUNIT_TEST_UTILS
 	tristate
-	depends on KUNIT && REGMAP
-	select FW_CS_DSP
 
 config FW_CS_DSP_KUNIT_TEST
 	tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TESTS
-	depends on KUNIT && REGMAP
+	depends on KUNIT && REGMAP && FW_CS_DSP
 	default KUNIT_ALL_TESTS
-	select FW_CS_DSP
 	select FW_CS_DSP_KUNIT_TEST_UTILS
 	help
 	  This builds KUnit tests for cs_dsp.
-- 
2.39.5


