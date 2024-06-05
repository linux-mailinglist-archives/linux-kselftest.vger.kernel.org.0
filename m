Return-Path: <linux-kselftest+bounces-11272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF98FDA05
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3161F24B9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD9161901;
	Wed,  5 Jun 2024 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ok+ANq+5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FC1649DE;
	Wed,  5 Jun 2024 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627561; cv=fail; b=ujenT2fWlsED36xsYwQwUj6sBEnkXxahWdOXEM02HcRdvCeiDAVMGjiaGi9fTz7BoPUmqX20CDEeiPFP+JDanqhwUdUMrVPaiQqQ4kTcm5dm3O0wxkumCnLEmmufCq5ji5btaDsW8p53ihNvkwFbddtGxIEkca9uGvqkLTd0mKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627561; c=relaxed/simple;
	bh=ejfyhKx5emZkCdHX3oTjSvPOD14BhKhz4GfUdDy2g6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEdkrVfu3Sao8+bvtsog6s+322++y1v0b3mks2nNb/sKFrXPTbErp6bZNRjFqIfWwJ1W2q3d4/akdBzz4RDxB4QI3aPJgVxVZF3x2VoceMG4iWriUaL/iSrjfR1YO/7Y7Rq+grKX1EX8DgzEmQPy0jDC38tdq9y6pCcz2zJR0bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ok+ANq+5; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inC+w9aIr18Z8cWwzJoMWKeUkyPeh4+e1B39mLD0E8YaM8R9qYc8of+s1kqBi6pRY/zWRsEEO5RE3v01MGU7TX6fNW+i/XZp4G6+74u9v9QIq2Y0vTVScgFlG/oWptT8+vPUYHCjEz1FXhPoMrE0idwrW2fexSqHzaUwofvJr/lwd/KNUKNC0bFIxnN0nlf8H2kSJdsJYy3KtJmSvQ//YF8MryDKrxi7j9T8FY38T2HjlLNMQ3FpOSt2yloLGgsqOlRzaG/rRYDHwAaVgv2FfQ4Ze9SdJq+JJGVbDliwkRw9hM1ixQY1gKwjdtAAs7kNcVBAUipRfHL52EXjtME+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxjfp8H8tADv284HFk6Eh+BJg4tsyz5PKG5nLXxaKcQ=;
 b=R1iNETCJe1tYiY1Vhd3j7gwpraOTWMzXBvtgLUsH6Ts4zvYXOLMJHLMVw56wjv5FU20dmGkJl+WgVj3LN0FdGeq5BwkARImOjrRYtiGI8LFwBAAas5jG+BLR5i94VAtFHriIiTsE37hELop0VkPy4IioYjdxaC8mwucxYrO2dusjNAAM99/5t73VMkG81skENtNePjG146aRzdBkYLG516lJz99ulp4LtlhgEPiaJMQ8X7AdmoNoVNGmMJQB7uh2fF+t/iXb6+qs0QPmFlwDnuWOeudMnI/fr0NbFzCS8xfehM8x3Y5jo3Y/O2xF6oLd1+995u02CtBPS5tJwjSKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxjfp8H8tADv284HFk6Eh+BJg4tsyz5PKG5nLXxaKcQ=;
 b=Ok+ANq+5hNpz3Y2D4MapMMHbFKwbYsswuh9PRuSnFzZ1YIrdHO7KIEJndWfqK3m55b1PcVre24UQyIj6RbM0xEMwvTyMf27bQ7z3b/NtsduRF33pKCwjkmDkqzMt10DYsRtWuFXQcHGT/hBGputsOSmrohvNrnoddbfAMkaEHn8=
Received: from BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49) by
 MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 22:45:57 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::98) by BL0PR01CA0036.outlook.office365.com
 (2603:10b6:208:71::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Wed, 5 Jun 2024 22:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 22:45:57 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 17:45:56 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v3 2/4] selftests/resctrl: Pass sysfs controller name of the vendor
Date: Wed, 5 Jun 2024 17:45:32 -0500
Message-ID: <f45784f8882fa41d454ac3b35b203ee6d04ecc25.1717626661.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717626661.git.babu.moger@amd.com>
References: <cover.1717626661.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d0c36c-9915-4a53-f6f0-08dc85b143df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T7o2CWOTP6t9fxm/9ojAoR1N02AgcZJL/QoZStsf5qNEG0oC3xvUUahGSR9W?=
 =?us-ascii?Q?MnzDd2rI58dUksgt0xAwO979rF7x1MK3GIyPJt4wWb8cvs0yzF1mvDN3eKDo?=
 =?us-ascii?Q?1MSa67pDtNKyjWrBqZY2ribtsrsYNWRQOiAEfe6KHPIPNjanxqheB/5FuT6x?=
 =?us-ascii?Q?cKrSBSB0xKRas9kbTloiadVQmf8iY3EIEtcrePXVEHYaO+OTU6B+NR2Vj+nK?=
 =?us-ascii?Q?PLWknPEdzlzmMhtiPdQwlmAUlpZ5Os9QEyTS8JPk3h4Fp+7UDlwBsDBdSgE5?=
 =?us-ascii?Q?JUDURNnPbmIBi2P3GFPGbozqdreUcyDczkct6UCoWDV7Paq5dNhgVRGWOqXR?=
 =?us-ascii?Q?PuNOA+LA5bqjMPmgJ39zXxL4lPlXuYEK3PDAgowbAKumWywBw/wNT8v60SWB?=
 =?us-ascii?Q?sG7CjD3IcxG6wbXPKXcew3fYlzesC9zg9XSqEbPrvsdXWdOU7sRO7i8M1mtF?=
 =?us-ascii?Q?qMaVvXC9GEs/WM1/OPtxZJzNLOoe/Cpsap+i/uq442yEcFMNrP1KPcjPBgq9?=
 =?us-ascii?Q?WbNQC1q/hUb0kAkXMd89b0Fantai2AKlKtVq6UMWWk7qB+PTSiHgyMFOdLlb?=
 =?us-ascii?Q?DZ6HNSvVVVjhTPWzWK7+TC45BNA/Dy3xvw8BJ/dKGawXnTP1Y3Z1apC8Zx8q?=
 =?us-ascii?Q?dmWAbssQCjctZJYpivgOQJylXxXBWlBG95J3ov47o1GNl/bAAex45EJ+B4Ts?=
 =?us-ascii?Q?BG31JY8C0CelW1/zTFM5nNCpxx188vyb4/8u4QUN/hzdber58Oa7LjyPh+/3?=
 =?us-ascii?Q?q3pqW+WP5e5EZtOG0TXxfERPg6N5ApuS4FTTzgB/RHuZbZrI5PbxYLjTVEGR?=
 =?us-ascii?Q?yQNZlZ+j0zJrj27glOiwl0g+zb1FuIQ6s+Jb75DNWcgrCxR4ZhHjql8ZllNH?=
 =?us-ascii?Q?qLZUgGDeUih7Lcn/NB6lOolvoszH2a12o39vAd0rpT8TzEAXRm5Nc5AEgOhD?=
 =?us-ascii?Q?hdypdjkw0W1WIzbVpz9HCJ92A95z5Lh+4KNb99x4rfZx+3GfOuAFkPBh5SFl?=
 =?us-ascii?Q?Okv1YuB8IN78bI4kh+ARRmiMc265O201fdFJwVDqWZIEJKkL55agmheMjlHb?=
 =?us-ascii?Q?25/bDWU4Z/RvYQ1DYCB1AMDbCv3r+0U/PvrE8t7stVUGHnLFxTdsfGVO8DIq?=
 =?us-ascii?Q?ugoy5EE1uceIiCvYJxn+dGaT+ZFkwYb8Q//fyWv626C8pJ3zmwtLGNmyufMm?=
 =?us-ascii?Q?N8Ei65sLNLdgPICMtqxA5u+RuZQ0qkjp/6azn0T6gbzlswyb/+Y4Rq+ePHZP?=
 =?us-ascii?Q?5mCWXhKQaU6wJn2H3Tmpi7Iwcg5iWw1fgXKhsGSpgSAuHR0569sZqOrECACK?=
 =?us-ascii?Q?Fj73wAP3+7N+eL0Q5buZQPDtbaMRbBNASWTZwEWlg0fvJLjHhLsb7+fSyvdS?=
 =?us-ascii?Q?u5oZnZUgoLA9zmxNIi72fYDwMKKl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:45:57.3599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d0c36c-9915-4a53-f6f0-08dc85b143df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

The test detects number of memory controllers by looking at the sysfs
file system. Detect the vendor to pass the controller name appropriately.
So, that rest of the code will be generic and can be used to support other
vendors.

Also change the search to look for the full string "uncore_imc_". Replace
the sizeof with strlen.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: Change the search string to "uncore_imc_".

v2: No changes
---
 tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 2d5e961b3a68..23c0e0a1d845 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -10,7 +10,7 @@
  */
 #include "resctrl.h"
 
-#define UNCORE_IMC		"uncore_imc"
+#define UNCORE_IMC		"uncore_imc_"
 #define READ_FILE_NAME		"events/cas_count_read"
 #define WRITE_FILE_NAME		"events/cas_count_write"
 #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
@@ -206,24 +206,30 @@ static int num_of_mem_controllers(void)
 	char mc_dir[512], *temp;
 	unsigned int count = 0;
 	struct dirent *ep;
-	int ret;
+	char *sysfs_name;
+	int ret, vendor;
 	DIR *dp;
 
+	vendor = get_vendor();
+	if (vendor == ARCH_INTEL) {
+		sysfs_name = UNCORE_IMC;
+	} else {
+		ksft_perror("Unsupported vendor!\n");
+		return -1;
+	}
+
 	dp = opendir(DYN_PMU_PATH);
 	if (dp) {
 		while ((ep = readdir(dp))) {
-			temp = strstr(ep->d_name, UNCORE_IMC);
+			temp = strstr(ep->d_name, sysfs_name);
 			if (!temp)
 				continue;
 
 			/*
 			 * imc counters are named as "uncore_imc_<n>", hence
-			 * increment the pointer to point to <n>. Note that
-			 * sizeof(UNCORE_IMC) would count for null character as
-			 * well and hence the last underscore character in
-			 * uncore_imc'_' need not be counted.
+			 * increment the pointer to point to <n>.
 			 */
-			temp = temp + sizeof(UNCORE_IMC);
+			temp = temp + strlen(sysfs_name);
 
 			/*
 			 * Some directories under "DYN_PMU_PATH" could have
-- 
2.34.1


