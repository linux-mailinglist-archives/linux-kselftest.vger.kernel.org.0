Return-Path: <linux-kselftest+bounces-8888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E28A8B299A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E3E282011
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF8156231;
	Thu, 25 Apr 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kFuuMhBy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96389155A5C;
	Thu, 25 Apr 2024 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076269; cv=fail; b=J3VjPuL2ITy0gW7IkaKGER+8LSjFkSC9l9ybT1KVy2jjSGXWFLWQNzgiZ+b80h0Q2W8qcaVf/4VuJxaHNtt0rNtklENODrP+KeXH8rYlLHj4t47dMRc6rinn0MgeJAxWtuc40EeD3vgMEXgQl7aWx8ZGtOJHeBJikyW66CBr6KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076269; c=relaxed/simple;
	bh=LXoin37qgEkVJdwTQcMoYiS7oQSmQULIvjCq1shD+mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpuzMD0jBWDuB1CRBoVw122Xoam+tMhLVt7p3KyPeIJoBgeiS9ESEX8RSwN3FVegAl86jbNMCzri4y5WTo3fSTzLZQN6kuIYYd0zMy7tLJaN2Rc7G6dao9TEH4fZrMUL9jx2uAv0J9mX7RpDATpfV6cHi5GBC4WHrKFz3nGfM+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kFuuMhBy; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhKqg7R650HSgggMmBbO73qwQNfNrfPV4WQn5lk7toaqV92F9m3sU9F3gRf9S8o/XH2kZ/9hIYX3Miho2INulyi0yWYDYWZ84SRP6w14PzmQpZdit1MoGOFHaON5gO9MPupaWOPGD6i83isdu0FzEGQEPxdyCk17Of7DgGhro4aN9ulFUWsEGsyFqokcvy1RcX7bUmQmH275pt48UrPaJkbxpghWucCHGbUauG6IwGImmRC4e/qF0DLdQ6k8WpocoCm/HECreXtxcnTPy0X6AHbmuItHuKarehUziGd95kz9Z3aw9JAkfgfANcTXa191SqrNNAsFbfLuYEeN/ZI/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR6tOkEDTn+WRNMLroYN9wIXzBVLOZUT0XkQs5MhFL4=;
 b=ZqsilSE78zlSQLOpwOyXD7jtUbjHeUW/pvKA/mnK0sHkrBE0HTm7r6OUXfGz3OiSlet2RedZToNIYbCLMG46+NlU5bxLhgm8dXrevY6+U3MjLyNtR1X1yQK7/olamg/uyYyw36RMET6VG0RmE+y2lSUp03W7yrR2d1krGEFdXhBPYleIs/wPycm5Az49KRzASL4CVHCB13Vz8bjrnZUY6GBS5UOcmF51+3I4+OnhIihSah95QLQ3mI7x7E3GQW/iflt38QjQmoP1lL/WwhDidIuk10BJRPJMwIyPfZmbsZcPYZIVIVcRo9NjS8iKYYZBQi2Rfa1T2VQBqtEOmav+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR6tOkEDTn+WRNMLroYN9wIXzBVLOZUT0XkQs5MhFL4=;
 b=kFuuMhByCXTlHT4VZLGtlt+zwmclqHraQviWNcy/Zhy9Vb8MlxDW40Fcw2NX+652IvELUiXhMWdvcTYwIFg8/aBuJPOdj51XgkwCZAgD2jo4lGtFdbWJuVm49/Vh0A3Bz2matkAOUsBCjohzHVswzRsBvYVVAg5pc8/tctu7+WY=
Received: from MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:17:45 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::5a) by MN2PR07CA0019.outlook.office365.com
 (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Thu, 25 Apr 2024 20:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 20:17:44 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 15:17:43 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v2 4/4] selftests/resctrl: Enable MBA/MBA tests on AMD
Date: Thu, 25 Apr 2024 15:17:02 -0500
Message-ID: <e3bf1fbbe3ab2d9c2dc1d9669a791de140dea248.1714073751.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714073751.git.babu.moger@amd.com>
References: <cover.1708637563.git.babu.moger@amd.com> <cover.1714073751.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 378762d9-7e9f-4607-d8f1-08dc6564c464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?boBEaSt7MYpomQedydglazJYSela6n+hxE6jyYekEMQdX9GjNi4i5ck1xX+L?=
 =?us-ascii?Q?Azwul5MUxtULqflB4bOeRKkaNARDNXy7bSp6ZlYc0p6uQyhp3+GgFEd6u3FC?=
 =?us-ascii?Q?CXkaxIWHYH6aQU+D2LpyYf/WridPO0NsxyKGMtzqnOeCa3s+D0oXMnXA1A3h?=
 =?us-ascii?Q?SvVJdP0Zt/Npkg8h7H91iY5NSRZUuYjXVtu+37cVBSN1nPj9tnG+gCLHZA6N?=
 =?us-ascii?Q?NyFVWGFia1VRyk4ANJG8Ot120lvBF5diCdMZ5QzZd1WUG8is/f2QLXFWulfN?=
 =?us-ascii?Q?wHXcn0bPy8270Qoh/6WHba5pqfNYRg04PVeC0ykx3JXIOyr4V0dqFvdC3yMQ?=
 =?us-ascii?Q?MoJN1HVewd4pOTce/B8CIY0MAdPKXQE12CLPhZzIb631bKCA921fMk0sP1vt?=
 =?us-ascii?Q?DsslXIC3ZxsFLabvpyN2W3p+shJvssVOKnm3wINC06mnpL+pA3XUXvPZW/nU?=
 =?us-ascii?Q?oBc5wLmZ6N2SKsKq/JU/+K2eHqXALSwMUbzVckuFFF3WAuyMRTqDrjPCEtE6?=
 =?us-ascii?Q?IoXagwPduKDpvgvsvMR92TRKvzMRl69ricc/SeuDFbL5tuf6nUu6bAkk7U8H?=
 =?us-ascii?Q?UlBKlOSdTBjS6e9Zy5u17RcY6ynFwRl1+KOa5qJ5Vw114UBChqd1zatF3boN?=
 =?us-ascii?Q?ZTZDDSswARxyXaOwfz2gQdivMIKSPRIw4k9mhiYgZRHdeC4KdxULDYcupmxs?=
 =?us-ascii?Q?e6Hx1WgYmPp61Ly3IKRwi/zYoIn/P4AT3GqsZf38msem3eSWRNkIU9RF4UU6?=
 =?us-ascii?Q?5P5zZbhoN1WMKA/Mfjld9/8rBEBwbkAMfauibpmJYt3HQz82Urk+TWXX27JK?=
 =?us-ascii?Q?e7dAyUQ24Fq3JITRcx8CEdNyN/orZV0qOqkRvommHosUa0j7bEfcaXIvtFvV?=
 =?us-ascii?Q?qRpCWnHLDIG8PISxmOJFYgv/kRx9r/UrFK4PnQgqcUchUt7szC0dDzkz/MYn?=
 =?us-ascii?Q?IcqtSeA8Mvi8kASjbGmIJQHlYfsZjLuc0EGk2NskYMCfJ3xv2XoecK92KKjg?=
 =?us-ascii?Q?bD8oOPnt8ufCsqIFA1n3bEJcFbnq4A9WGsvM5phDMOf4xrSL0txHCuQumqSH?=
 =?us-ascii?Q?eyiivi2rs6lm93YYL/NPUZTwW0Oo2gWf2bnODl1zUuV+EVFT5O6EM8M34oN3?=
 =?us-ascii?Q?dMXyxKGf5aUU05FDyETgEVoeoYq364HcETDDUYQDsEsgF9zVw0iGiWAKLntQ?=
 =?us-ascii?Q?PvvjHqckDwlieeRrTTuOoCQ/4y6vYZwHr6D3Ff2thFH2VZwG9q4gXY3N2gGl?=
 =?us-ascii?Q?Xh0t+S5BexqkU6ZHCU3QJiJpYPui7AcedYU+NB80nXBpBiypytm2+J/C7nxf?=
 =?us-ascii?Q?TtSe7rWRjx+8DU13DpT4aeowGopqCi3p8H6lR0IMuJ7SYwV7L3/DDHjiX5vI?=
 =?us-ascii?Q?FeJUwpVupWqZWvXYUQhbhEh6cOo+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:17:44.5377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378762d9-7e9f-4607-d8f1-08dc6564c464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

Enable MBA/MBM tests if UMC (Unified Memory Controller) support is
available on the system. Tests will be skipped otherwise.

Update noncont_cat_run_test to check for vendor. AMD supports
non contiguous CBM masks but does not report it via CPUID.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 tools/testing/selftests/resctrl/mba_test.c | 1 -
 tools/testing/selftests/resctrl/mbm_test.c | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 4cb991be8e31..b682eaf65bfd 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -314,7 +314,7 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
 	else
 		return -EINVAL;
 
-	if (sparse_masks != ((ecx >> 3) & 1)) {
+	if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 1)) {
 		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
 		return 1;
 	}
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..353054724fa7 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -177,7 +177,6 @@ static bool mba_feature_check(const struct resctrl_test *test)
 struct resctrl_test mba_test = {
 	.name = "MBA",
 	.resource = "MB",
-	.vendor_specific = ARCH_INTEL,
 	.feature_check = mba_feature_check,
 	.run_test = mba_run_test,
 };
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..f2223315b5b8 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -147,7 +147,6 @@ static bool mbm_feature_check(const struct resctrl_test *test)
 struct resctrl_test mbm_test = {
 	.name = "MBM",
 	.resource = "MB",
-	.vendor_specific = ARCH_INTEL,
 	.feature_check = mbm_feature_check,
 	.run_test = mbm_run_test,
 };
-- 
2.34.1


