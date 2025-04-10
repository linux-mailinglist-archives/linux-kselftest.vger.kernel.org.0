Return-Path: <linux-kselftest+bounces-30477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A0A844AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 15:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DE818925CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202728A3FF;
	Thu, 10 Apr 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qORvIrA3";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="muP45aCa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59782857F4;
	Thu, 10 Apr 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291317; cv=fail; b=r+n52xWskWaLfGHr0NqBPZXg2frGAtDZe95x8czj46w+6ZVaT8nXgO4Mh/fuFh12zLwv74ZnmqCgGaBMNizK+k9hVzlfPBqW1IHfTFe76zh0hiZrQ3cPo2q1Cu1cRwc0LJQY5SWXRyiCpafw2OrrF/estsbiF2zEl+eQ/7Mp0e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291317; c=relaxed/simple;
	bh=csdlxqAWeWk/Cu56CCyA7J+Mfthl8b40MZqy7N4mqJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kboklBIXfJhtHJnZ64MDa1x7bP1JzT1fm0KnOWiQM6/Y/l/h8PvGdm8rjSgYD8/eMwA5hbArMXLddOirTtAwY3Cg1cAaG7zwqRd42ffvEaEKW/cF6M2nx+y7gPTMXa334E8t3+LnxEzyIlcxfu9+1e6TUzTXyJW2km1Bnc5Ez18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qORvIrA3; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=muP45aCa; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A82DSO001301;
	Thu, 10 Apr 2025 08:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=4HAesXU10CaKm+f8
	Sbl1hA/DhDYaB5XlC2RR/lYMMhk=; b=qORvIrA3S7nA5Mh085sPBTJ5LOf+mLO0
	s1i6YA0fWlm6ODDz5nBuzlwclYWh1Ubmw/nEy1EppjNX480ogmwPz/+W0eht3625
	ShoqR6L/cy9lixwJBrUGiMnJFOUnEIKs73alMMoPIrUvaWQgcIMUTYQWxuZDusDk
	ccPcS4kpbthatWGPioaIc6AW2EnZ5QK4ZtWM5csME+AFxgMIV19s7u2a07qQMrDa
	z9Yk3y199AOa5/ATCtBR8krw1lkXQSm8gZ1JCsB/sVhSkXqWqn4bonJseTwkdICa
	SSJ/TrVvPN63nGaioEzqokccKVHF3ZiCfYwysf/a8jLDaaVdwz46Rg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45xa4bgbcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 08:21:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro9NEdLcBWCnI16OJ/luiOYzq/CwzmjZn/n5IgLclCjkOdhd2ENpGNqdBL/AxjMINKszoBSeYyWgzg5U4XBXqL+NigWK3nWE27B1jEipyWAAdU41EqRhcFnKygWfiBLPggObd38QC4k59LrE/GTBiYeFkb23F2HncbEGX8aB2iBXpwFJnrWokOuRH5CcakIcM/f7HXl33UKixer4EgGK632bbCyaATSgoKIRjCi/9ffvYXK1WQfyWiGzCRDAfFaPlgn7CxZCyYGIPGR8s1wd80Szv8EdgM5Em+ZU8WNp+u6nBjgcGsS8hbaTEomgSbPh7hV6EzKEsKfBBLMKJ0+B0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HAesXU10CaKm+f8Sbl1hA/DhDYaB5XlC2RR/lYMMhk=;
 b=vGIW3u/qtCEQAuXVE+1qq/FCyaQ6KhE7eDj+7ncJsmzBp5rVBAJhfsy4TLBgyjulC6Srh3Z6SMAHp89C0nTATy+3/u2zlZQ2aSo5WYX+Daom23rRceFMdTfvdwvS1jLwApbQAUoyOb8cRjbrCtkl9ihxqy4d326uF8SxPr0MQDmJzqQJIqfR8BtVKiQxo70ZZBAZdLmqcMxDj6+/ROPlL3LgtJME5t35tyKjOEWukUP/plnGu9IZ3zwovgfuxqkGQYW5gOUSg8SBtluuTtSu/Y9/fsi6rLu7g3ZCpjsmn9EYBXYSnZA1gshHXnWgF9BsIpZqoM/AF3AXdHS9jnvYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HAesXU10CaKm+f8Sbl1hA/DhDYaB5XlC2RR/lYMMhk=;
 b=muP45aCa2jYtU+wKaNsIePimL1uWqQ9LpUeEdt0LoseBtExLbRqOkRmIF+h+nF2kXqamM22ntcTHYJICUfUNHq98l6ADI7pjFENzOkbIVdF1wO4cvLhw0manlroXnaB+aOTSqgqa1MYFdUEmLQNUUJU5B/CXCil3oKX/XpHeIfg=
Received: from CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::26)
 by CH3PR19MB8212.namprd19.prod.outlook.com (2603:10b6:610:198::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 13:21:30 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::14) by CH5P223CA0012.outlook.office365.com
 (2603:10b6:610:1f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 13:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13
 via Frontend Transport; Thu, 10 Apr 2025 13:21:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 20109406540;
	Thu, 10 Apr 2025 13:21:29 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 11DD3820259;
	Thu, 10 Apr 2025 13:21:29 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] firmware: cs_dsp: test_bin_error: Fix uninitialized data used as fw version
Date: Thu, 10 Apr 2025 14:21:29 +0100
Message-Id: <20250410132129.1312541-1-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR19MB8212:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4c3eab07-4545-453d-67fe-08dd78329b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZkEJhMrlRElgzdczaMmvRa+m5Pc2smImmOj2NYyMmrJNgJh3ZeSBJ2EAdza?=
 =?us-ascii?Q?NEJ3zSS3czIDLZ+RxoG6vzfu2aTGIdh2zT6zPvgRNl/MXZHrPE+cXvI0prG1?=
 =?us-ascii?Q?zwTT2FStmLAmRPpu8AWsuwMll+Ygm6+BvlSdh1io1yHEx03KWD/o4ZcVvoqV?=
 =?us-ascii?Q?CHDcxwJT2DUJmkxg86uvE86Sv/POJqdyw1nJ+5gHES0C4SsOB3l+gF/mzYrn?=
 =?us-ascii?Q?6Oo/mNy2AfefRy/KaKK7TWQp2Ry9JdroqoNRGeFpb6ees6lFRJIMyAyWI6BX?=
 =?us-ascii?Q?2czOsJxbA8trxy08sINAzlY6SJTZHHTm7r2Ps2n3OwsQbERsMJYYIbfUU9Pa?=
 =?us-ascii?Q?9FSXOqGd371teJYS/A4RvXhDf29oramdRl7KSJoxflneUi9vaFS6YKFEUS5O?=
 =?us-ascii?Q?VE1Ii1KlWc05/J3iN3cgtv5MorySn5GZ1dXFv7Bx0K9eHLQ8dF31Ehowri99?=
 =?us-ascii?Q?edyH/x/ZIUfQSNe1/Tqi6dH0rJ1Hx20pVY8MUHQoVWS0/RpKo40maFHr+s20?=
 =?us-ascii?Q?I/+BXUzW7NJuytRAc4R2C+ZZUAi5szL8E3F6ns5jqDuUG3x+L0rkJvTA7pEZ?=
 =?us-ascii?Q?SWjbvvDJow6LuobLAGYNZYDilyGDs0VM9rm9TCY0blvNAnuPNxD+0NjSw1ny?=
 =?us-ascii?Q?xxmxY0mlC/G7QIm5JIs5/lPUGXdNewdZZYFsUAM/HQkedzNqr2V5vziiOvLp?=
 =?us-ascii?Q?PYkQ0tq+Lc8EcEwdd46J4e4oaRsO3qimORjetG7tNPG1ZLPie6z7WNht1NiQ?=
 =?us-ascii?Q?jYiuZURyQfyJAaLRySMVDCM8neK421xNym6VfLI5Wj+gIhCD6UQDKUi4iznM?=
 =?us-ascii?Q?3r+CFQwyT7UjbmvFPsMhp+5bie9wzbXQBtf514QcacuMSSp6aVMBqiB2DoA+?=
 =?us-ascii?Q?Q2p7EUkKkEmnT722a2l2Yrm+y4OxiaVRTsXVozreTNkBkD0Uq9CB7DGxsLu6?=
 =?us-ascii?Q?TlU6MyLLvmI+L9FCs28t56IpfJqi5g94fR1zfBtpBRa2OLVu6QZAIat3TfpM?=
 =?us-ascii?Q?Xv5dM4bqaPRm+6It5fBJ4UedPwSKzvAzwgscGmv8hOi0wE3/uE39sbpgc05x?=
 =?us-ascii?Q?xGNJitv5wVCetp9Qxs4v7NE6JUz7vUFJhXXxHN9eYPPSRKzIBU6p0j9N5j08?=
 =?us-ascii?Q?TQScUPDp2WSmy2mCdXpuSJRFp8FcUbdzdWx3XhlzKlLSOqLhtEJUeXqFWDRd?=
 =?us-ascii?Q?pRpV0nT3IVINPQZe+2JtyUfY6jyAKBzKdYpEZKL968K7SGBu1jkJ/Kuq+6cg?=
 =?us-ascii?Q?iCwThhzMupOr6zC5Mn/8rl6RkMlSeEeD6qXbo+dA3+b18G+03dbxcLAzxfwt?=
 =?us-ascii?Q?BBlgT/75BXE7VQoWW13ZsVClLgkXnxm56oyRuJJMCJ5NQzLoPjNLcXctQxYl?=
 =?us-ascii?Q?jBkOhLkzuYCTSS3J2ChCvyA3tuiQxpL/CgGrAOgCrT04pCeyaUGCNQM3WrsK?=
 =?us-ascii?Q?yLgy+cVVPLDlctEYZkoWwi89Um1GkHIbQlYg+ArMa5rNzbdKAF899g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 13:21:30.2456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3eab07-4545-453d-67fe-08dd78329b3f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8212
X-Proofpoint-ORIG-GUID: HIEUtyBORDqGN_Tfx6fxHC5Z9gTa-KwT
X-Proofpoint-GUID: HIEUtyBORDqGN_Tfx6fxHC5Z9gTa-KwT
X-Authority-Analysis: v=2.4 cv=B6W50PtM c=1 sm=1 tr=0 ts=67f7c5e2 cx=c_pps a=F7QtyTBSWJEVkVFduP+sHw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=6ixNexTgZF7qXEE2jtgA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

Call cs_dsp_mock_xm_header_get_fw_version() to get the firmware version
from the dummy XM header data in cs_dsp_bin_err_test_common_init().

Make the same change to cs_dsp_bin_test_common_init() and remove the
cs_dsp_mock_xm_header_get_fw_version_from_regmap() function.

The code in cs_dsp_test_bin.c was correctly calling
cs_dsp_mock_xm_header_get_fw_version_from_regmap() to fetch the fw version
from a dummy header it wrote to XM registers. However in
cs_dsp_test_bin_error.c the test doesn't stuff a dummy header into XM, it
populates it the normal way using a wmfw file. It should have called
cs_dsp_mock_xm_header_get_fw_version() to get the data from its blob
buffer, but was calling cs_dsp_mock_xm_header_get_fw_version_from_regmap().
As nothing had been written to the registers this returned the value of
uninitialized data.

The only other use of cs_dsp_mock_xm_header_get_fw_version_from_regmap()
was cs_dsp_test_bin.c, but it doesn't need to use it. It already has a
blob buffer containing the dummy XM header so it can use
cs_dsp_mock_xm_header_get_fw_version() to read from that.

Fixes: cd8c058499b6 ("firmware: cs_dsp: Add KUnit testing of bin error cases")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../cirrus/test/cs_dsp_mock_mem_maps.c        | 30 -------------------
 .../firmware/cirrus/test/cs_dsp_test_bin.c    |  2 +-
 .../cirrus/test/cs_dsp_test_bin_error.c       |  2 +-
 .../linux/firmware/cirrus/cs_dsp_test_utils.h |  1 -
 4 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c b/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
index 161272e47bda..73412bcef50c 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
@@ -461,36 +461,6 @@ unsigned int cs_dsp_mock_xm_header_get_alg_base_in_words(struct cs_dsp_test *pri
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_xm_header_get_alg_base_in_words, "FW_CS_DSP_KUNIT_TEST_UTILS");
 
-/**
- * cs_dsp_mock_xm_header_get_fw_version_from_regmap() - Firmware version.
- *
- * @priv:	Pointer to struct cs_dsp_test.
- *
- * Return: Firmware version word value.
- */
-unsigned int cs_dsp_mock_xm_header_get_fw_version_from_regmap(struct cs_dsp_test *priv)
-{
-	unsigned int xm = cs_dsp_mock_base_addr_for_mem(priv, WMFW_ADSP2_XM);
-	union {
-		struct wmfw_id_hdr adsp2;
-		struct wmfw_v3_id_hdr halo;
-	} hdr;
-
-	switch (priv->dsp->type) {
-	case WMFW_ADSP2:
-		regmap_raw_read(priv->dsp->regmap, xm, &hdr.adsp2, sizeof(hdr.adsp2));
-		return be32_to_cpu(hdr.adsp2.ver);
-	case WMFW_HALO:
-		regmap_raw_read(priv->dsp->regmap, xm, &hdr.halo, sizeof(hdr.halo));
-		return be32_to_cpu(hdr.halo.ver);
-	default:
-		KUNIT_FAIL(priv->test, NULL);
-		return 0;
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_xm_header_get_fw_version_from_regmap,
-		     "FW_CS_DSP_KUNIT_TEST_UTILS");
-
 /**
  * cs_dsp_mock_xm_header_get_fw_version() - Firmware version.
  *
diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
index 1e161bbc5b4a..163b7faecff4 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
@@ -2198,7 +2198,7 @@ static int cs_dsp_bin_test_common_init(struct kunit *test, struct cs_dsp *dsp)
 
 	priv->local->bin_builder =
 		cs_dsp_mock_bin_init(priv, 1,
-				     cs_dsp_mock_xm_header_get_fw_version_from_regmap(priv));
+				     cs_dsp_mock_xm_header_get_fw_version(xm_hdr));
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->local->bin_builder);
 
 	/* We must provide a dummy wmfw to load */
diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c b/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
index 8748874f0552..a7ec956d2724 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
@@ -451,7 +451,7 @@ static int cs_dsp_bin_err_test_common_init(struct kunit *test, struct cs_dsp *ds
 
 	local->bin_builder =
 		cs_dsp_mock_bin_init(priv, 1,
-				     cs_dsp_mock_xm_header_get_fw_version_from_regmap(priv));
+				     cs_dsp_mock_xm_header_get_fw_version(local->xm_header));
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, local->bin_builder);
 
 	/* Init cs_dsp */
diff --git a/include/linux/firmware/cirrus/cs_dsp_test_utils.h b/include/linux/firmware/cirrus/cs_dsp_test_utils.h
index 4f87a908ab4f..ecd821ed8064 100644
--- a/include/linux/firmware/cirrus/cs_dsp_test_utils.h
+++ b/include/linux/firmware/cirrus/cs_dsp_test_utils.h
@@ -104,7 +104,6 @@ unsigned int cs_dsp_mock_num_dsp_words_to_num_packed_regs(unsigned int num_dsp_w
 unsigned int cs_dsp_mock_xm_header_get_alg_base_in_words(struct cs_dsp_test *priv,
 							 unsigned int alg_id,
 							 int mem_type);
-unsigned int cs_dsp_mock_xm_header_get_fw_version_from_regmap(struct cs_dsp_test *priv);
 unsigned int cs_dsp_mock_xm_header_get_fw_version(struct cs_dsp_mock_xm_header *header);
 void cs_dsp_mock_xm_header_drop_from_regmap_cache(struct cs_dsp_test *priv);
 int cs_dsp_mock_xm_header_write_to_regmap(struct cs_dsp_mock_xm_header *header);
-- 
2.39.5


