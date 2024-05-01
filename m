Return-Path: <linux-kselftest+bounces-9216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA18B8CE1
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0557287A08
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817251036;
	Wed,  1 May 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w0rANCdS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31112F367;
	Wed,  1 May 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577126; cv=fail; b=jrh7tP1r0IDCVn5RKl/uXl1ukWvU6Q2Nlt27W6hc0VwpxZZm6yLQzeW5eJpZXFE2q+NceStkPQzOf64nsz/qgUxUnmEyu/dtuMhrn+gB7E+1qf2bETg3BW7pfotnn7VXeyaOqkdMwK8qVDu5K7YotCWeZHNgAIGO120M/HfFpvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577126; c=relaxed/simple;
	bh=8Q/BwGgRnJ/c8AoagQIsmOlDsG16idCCbkFf4uY3V64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MxRzFYXyUvBmcubaQ+C7FzEcX6zHuwmk7noGV3O18wRtAgwvh93XMj+ec7T1sdjm7sDUadcBSBLjpznQnYSsFn2UzxemYKs2TFXp8S1xglEdiwQmTMTze7k+tr3IG0TJjUx+C9TDtW0t0fdw3Alh0LSiLEqlFEaMj8Qv1VtqNN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w0rANCdS; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpMbPDQ9odcVGQ+nCLz2SdsETGra3hNanOXyd0Qr6cpkaoobJmRo4Sm2BzmOZylemqLDnALNs4DnOb2c1vbi19qTPSPxN2EzbancHxHwHgIdE0KzeU/ke55b3ZZ41TIJgPYh0z11+ah/V0Vyz+PoksO+oKBtUAyOgU/RPaYTG+drPisWjj9pjsROu7F4DrbaN5Plxj+coMdg8ggspqnwc/Psy3k5SOoY7kGEWWBH4FoPNDstO+1eA8BqlpiX7IAp5cyTtWz3VPkeDpc9lVnpob7yWZrPUBUGZwDV3Shtby2GfBSGIDB8dTVNLf5cDjboO8Wqk7bxnMGCgr8tuOwVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJqoqLDINgrPMq1Lumuqzewafpgh5xiStrmF1QD3U/A=;
 b=NxteqlDDP/eU0TD6UvtaMNTcZsmFfJv8zAd+kR1i5CLM7rtEhyW2N4kngpvOrCqNUxVUemY0TemxrjzLiS4XWSt597nEwF0T2grLP4pQUCvaDpxzt+hdlRluyzFSD0gTX481sIW2Y7Y9ZzM9lbZMZt+WuPNqVmjTf9Pbk1HOfmdlGwVNdPg/0rb1E/CzCU0I1LmLThiYQbZMzWK9B/GwEVi/6TUSGZo91sFmEipqYCXdyD0TzG1czt6aH0zGJbry6L3Z26tcAFBhYsFib87ucA6bXXbFmwiCaKanqbXQccWCgijpU5RuKT/Vqiz9bFFLTb8V6t1JooHGpARrkRskrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJqoqLDINgrPMq1Lumuqzewafpgh5xiStrmF1QD3U/A=;
 b=w0rANCdSZCtbFS+PGNY12ZY6GGZCrKAKoGlAJuViX/hUEAz379GyGZYu3g1IJehrAzYO2r0xm/D13GErwZK2s2NolwyoAhCdVz5oVMm+UN9u2bD35JBpchwbclC8afkZThU2SYia1yIGUi8lKtDxp4SY2omqE5fk8DPtf1wTTrM=
Received: from SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::14)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 15:25:21 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::dc) by SJ0P220CA0010.outlook.office365.com
 (2603:10b6:a03:41b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Wed, 1 May 2024 15:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 15:25:21 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 10:25:16 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH] KVM: selftest: Add family and model check for zen4 in PMU filter test
Date: Wed, 1 May 2024 15:24:51 +0000
Message-ID: <20240501152451.4458-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f8b81c-f55c-4070-8b91-08dc69f2ea59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M2q+FKjgsdeN1xAfUVB50/06t804mxhoukHxEz3Yh9dVapIPlJRBJZr8jXs1?=
 =?us-ascii?Q?lQkvNZQH0ui6KEEx4eNkU7me9eALpOq3vnx074h+ZN5hODRMnYUEu/1LwP12?=
 =?us-ascii?Q?TdYjgdoEon5+LeFow7xbKHtvvZoNwWHCQaISMPwnk8XAFo82YZjJJVBnXY+C?=
 =?us-ascii?Q?4KZNGJjOitwfB7HvO7ZXtzLYp+i0i6X5h2+MhyrP3wdvPTMbAqLgMnAeQjwS?=
 =?us-ascii?Q?cRIQnCmNqzmK5TuJuqPSZe5aSGzanZOzAOZmbcCfIag80izeH+94g5E9ZyRQ?=
 =?us-ascii?Q?iYqR4fSsmTq1dvXIyZMZECODULCnK7weR2JfjbQqz995VlOcpmN/OMA1qYZd?=
 =?us-ascii?Q?PHiwjLdW2aACsjU9M6mtnoar1zTH7cLBhmE5sI9iIhByE3dgOTZyZwISUVUQ?=
 =?us-ascii?Q?DhmTBrkRDwc77R7j1SUjzHlUdcxsRstTlXZwOtAkRnLI4G4fLWPQjbZL85BM?=
 =?us-ascii?Q?YefmARYTyu3B5iLqHmSWy3IFaTCEAvg5JIqgus4k+BnDicqQ7Dw12UXQlq5t?=
 =?us-ascii?Q?CZlgOlRYPdcGfU1V2QIKLS3I+ojxcHNp2+ag/NCGzRJeMZOaja5KYfNQSwSx?=
 =?us-ascii?Q?6jfd+yrxf++vxNInVXSIxAaYjxU5EAxtfUCXF2V9gLGbuY4hIcl5drGEHKWS?=
 =?us-ascii?Q?b0CvWmP34Ut5LGeQzrogGjy23zKl1lI834KYT60apA+1esaiyVKN4Hr0LDWg?=
 =?us-ascii?Q?kJ1qaknEgcc1MsF6UpcBpYBxXlL7Wq+jfMrSLGktUJOdOZX5QnwavlJ0oyVW?=
 =?us-ascii?Q?Ic2hUczoQvupoeeS6zOcEsLRyUbChZ+p9Nm6qLKg6zPaF8Qwa9ONiMTDuk3M?=
 =?us-ascii?Q?TxQlZB7HuMUrZp2B9owD5Lmm0jdmcTmP8iqVfDAAgVTN4+CEjNpbbtQAV73g?=
 =?us-ascii?Q?TWK7K9nNH5vfuP12G6wrpiyjlj0cuMJecLRqEguzWyiGFgQi4lHSahWW8UHT?=
 =?us-ascii?Q?Yuaw/5XxtuRQJ2K9CCWtA2gBv3ZzwdNEx21QFYP3VSl6TJsoCya4hYEV4vpa?=
 =?us-ascii?Q?h45ZdJ4LOauPPozn4QRIIzBgRkXYtFoShyZxRElp8PvT379dBK3btr9mwxZU?=
 =?us-ascii?Q?8F8CKNMLR8J/MGxqab8/wkpKPX31am6gaJyjQ1HT2fqhOZk/C7PuyjVeQpRH?=
 =?us-ascii?Q?fewdz2VUQwnC2O2RFgAPYm8TCozIMfUZ4mKNr4YUqGg70dXeZVYaM3D60Uj9?=
 =?us-ascii?Q?BUsnNgOB6NUGeAufEOW5qwzsQkMikWwNjxcl41NRQRJYKTsAdo0zoFXkeDq3?=
 =?us-ascii?Q?FsVqrv1JG/Lm/Z8udAjbYGxBEFPywAYJNyHV4RS1updJ07Oj1Q59/+795Rgl?=
 =?us-ascii?Q?H4/XNgEEhHpI4Y2s6chXeme237BV3YjpoTLltr+e6dTNTN8bz7NVu8Jl2m9q?=
 =?us-ascii?Q?WyK0BUpA+aafyr1k1y0OarFWJbMY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 15:25:21.3100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f8b81c-f55c-4070-8b91-08dc69f2ea59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784

PMU event filter test fails on zen4 architecture because of
unavailability of family and model check for zen4 in use_amd_pmu().
So, add family and model check for zen4 architecture in use_amd_pmu().

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../testing/selftests/kvm/x86_64/pmu_event_filter_test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 3c85d1ae9893..c212ca4ffa72 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -374,6 +374,12 @@ static bool is_zen3(uint32_t family, uint32_t model)
 	return family == 0x19 && model <= 0x0f;
 }
 
+static bool is_zen4(uint32_t family, uint32_t model)
+{
+	return family == 0x19 && ((model >= 0x10 && model <= 0x1f) ||
+		(model >= 0xa0 && model <= 0xaf));
+}
+
 /*
  * Determining AMD support for a PMU event requires consulting the AMD
  * PPR for the CPU or reference material derived therefrom. The AMD
@@ -390,7 +396,8 @@ static bool use_amd_pmu(void)
 	return host_cpu_is_amd &&
 		(is_zen1(family, model) ||
 		 is_zen2(family, model) ||
-		 is_zen3(family, model));
+		 is_zen3(family, model) ||
+		 is_zen4(family, model));
 }
 
 /*
-- 
2.34.1


