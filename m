Return-Path: <linux-kselftest+bounces-8886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F898B2994
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C9F1C21A75
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A015574E;
	Thu, 25 Apr 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U2LP3Rri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDFF155748;
	Thu, 25 Apr 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076255; cv=fail; b=Bipu0zhCdeWlepu6gWEVNEK+sdSz+C5HAhrZvVKM4WtaJeVeQy2osaQmWQZMGvY8EUiYgS4Fl18yhspyEbjAis7ws192P8geNu+nqzFDqCTPYdHeXlrVhWgwkRSGh4BdPzDYD6/spfRpt/g8oXDEpFZHn2r7bnUMn77W6dgb+qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076255; c=relaxed/simple;
	bh=CvCaBzD2H3e7pJMwzDsMO1V8zTx8l5usKheSJfb+nHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHRonkPw5UYVaHPm8O3pEhVtIEccQK942tsX7FlHB397uHGF0J5bq5NR/TtnfAxMkfpPfPkiFC/EzOOCcBtQ8ujAm0EBUlTcIa7gSP8UhdfmOKptndMobkTm5iXSezhnpbc3+FjTW5Q58qLeMn0+WMc/doz3uFop/ZWlTb4ufhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U2LP3Rri; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfUI7Nh9ndfmUHqQSMEjrcGRNJmCPXtEAfxwHhhhr8OdT+dC2IPEF5jYcXHtM/tgf7g8wjAthgMIZo60WHmUmrw0adhuWlG4SdZtVnqVL6iIU9pddb2x70u2oFfrcsOMsU1o+HZPpiGDKriA7hevoLayGEQHVsRXgwewm19UxOOcQTRpeDydmVxQBV3/WQMC09RiYoJrHJrRg1j5hI7zcc3sfd9C41mS2RLEqEJr1WQfdB4pxI8zQBuNtpZ+ffDJ4Ci1Eo75XNJ7hpJ7aLjt905vnh3Q6p6Yt1j7RkmWZR63+gK5p+oq6P5SQanpL0/L9nU2FiGeRh849lKR9OK+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtOMxceJQIxZQnXwyscsv9sKZ15Jpxniu8V61HV8/hg=;
 b=a9wIbpCQsHvh3B0Z306kwgV7mweCi73402Iwsu9hWf4LDWWXjAgvCcJSdfBBm8NcLUBzfIwKWdUk55c4pDNfZWkGOzEhTakmhpz1BGv5a17t43MAbNwP8DK4sXZo85iIrKS4LeSFQTcub2CqX9nTTlaYlzd0v0A2BL9cC2N6qz7xyA8dDXczbp63sc5j9igRKVD8sTv3Ic+6+mGfNns/mkYPxsWWMrLUl6XfczIYd0hOYuOHRmLRlT9buAOyK6lQBDFNiQbmWFvICXMFF88jyAG1AKYdlzWNWDtnQ08a8lxiHX6+Rme/F6SgFqKcmFalyiparliWii8P/Z86miLv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtOMxceJQIxZQnXwyscsv9sKZ15Jpxniu8V61HV8/hg=;
 b=U2LP3RriPqrvS+xMrS4lF9iUkbpUXpeILuXVaIZ94tVKrVfwWESXl3DONrayrzDPIhxAbkpdMUTsOj5N/9lLCjYeru1EfV6vgylVTZPUR2WV8GlLHgPkRyuLJzmi8/n2fEwyNIkxv5wXu+WyHLI9EAXDenaSUtac+1BoH9cEr1M=
Received: from BL1PR13CA0157.namprd13.prod.outlook.com (2603:10b6:208:2bd::12)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:17:31 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::17) by BL1PR13CA0157.outlook.office365.com
 (2603:10b6:208:2bd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.9 via Frontend
 Transport; Thu, 25 Apr 2024 20:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 20:17:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 15:17:29 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v2 2/4] selftests/resctrl: Pass sysfs controller name of the vendor
Date: Thu, 25 Apr 2024 15:17:00 -0500
Message-ID: <406d1fbe6b480fbe13fd0b8c432cdc517a7bd8c1.1714073751.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 4542e6ab-a6a3-4536-391d-08dc6564bc15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IaiGaSvbQFWPgG7PLKA6IQpK6FnaQWT3ILY3qzDZAv4QW6qzq8rj/7zXYhnD?=
 =?us-ascii?Q?RcwmhQHP7MC54myjuDhjFp/mEXvMHqiOsSQlwL2J14ngXZWmt2fZYHyVqU/f?=
 =?us-ascii?Q?hIs0uctElz/vYdF/9HYNMecaJL+dpwpkwQtlRlX3TcinOzIVw2SHee2NHnXe?=
 =?us-ascii?Q?Ft+zRst7PPNjmetzDGzkZaABGb/3LhE3QnBe4haKgJE2yYuFPvuWAfM90ESA?=
 =?us-ascii?Q?z7/D7U2+PledCEy1Lo2bM8lCFfReJWdd2fabEd/4tnBTRZDvYQT9PiBit9OU?=
 =?us-ascii?Q?YZ1IWxnJeRoThY2w8NQA7v7BziTgitGhT6hJNim8a60i8cd63I2Dpl1ONIXU?=
 =?us-ascii?Q?57Ce0RMiYFL3VQKLfYX8idU/ITJzOqSneiOUAM57AKVe17sSyGQ8lkZ8QpbW?=
 =?us-ascii?Q?FYsK6Fj+g0jizD8dq4jcc5eK9YaZxKXU45j/PeZ7tKzox4Orf1vnF+lhWhlU?=
 =?us-ascii?Q?G7W5e6zqJNYuYZSq7DygmORPKDRK7jZ0+YDoKQC82pnR7J42fAWjuVVXLJSP?=
 =?us-ascii?Q?yNzQQAUpAlTK4soREBubBJLTvMSqoCzuziRGmAX9AXQRePZ6pc7OdAMtOlfT?=
 =?us-ascii?Q?JRuubYcS5qfMv6lh7skDdJo0psduh99ffy+R6CbZCn5gaJgvi3oJklucBc5c?=
 =?us-ascii?Q?nzQi1+TGz8T742T+I4oZmLZTSTgVnGie1JbqQF089Z8Q9njI4KxAz5SsyzQN?=
 =?us-ascii?Q?Y1RNshK06CKu9CboO6we5FAsYHlqzSyKgLUUrL4LQD9M06RZsnRnOdWEJjZ/?=
 =?us-ascii?Q?J0zS2k4JRZrJElEQz7fQG0ME1Y5TYj7i4+jgw9idKEMeEEBHZDkdqw7A8mX8?=
 =?us-ascii?Q?3mtTZ7DTTpDV9ffA+vs2jSCHoO8f02L5/aFlHguNdnz/gtg8j6e1GKaXLJkp?=
 =?us-ascii?Q?oFG63Y2iwQXByTFb3dOy3BA0i1UZPBzQWHfq+LSSGKXeP9mQKG/PeobdOo9p?=
 =?us-ascii?Q?sZ4xVuhIkLZmMSD73nHm+OZ+PSHHC8ZV6UcJ6bZ4gtztI+pC80mO+r5neg5e?=
 =?us-ascii?Q?mhYVWw+jFNg0RDcj3yOr0PGmQ68NkGMoAayrU2MfiCWiSE904gOF1zpbofgU?=
 =?us-ascii?Q?ZHFmrzQ2P+A/u/k2jqXoFPJX4KSGbb4D5j16xQzuacm7wGMdp8qdfPcyEVJV?=
 =?us-ascii?Q?uLxarZ2t+Zm2wAtdapwLOPt+lR8sN75POUu+4Yz6ex3BRdTHDK0JpvQha2tB?=
 =?us-ascii?Q?SplgyUOkpJec0tMdNjL8mhHYtIMmwfAGadZmSEKhd8uGO+W8Z/aSjV6w0sAa?=
 =?us-ascii?Q?PxZMJcw1qBQ4ovILo99huWnSkbAyvmXJBm0dd1cCiQZ2ZRMU+C7CYlH2/Oyp?=
 =?us-ascii?Q?OLSMnu2ht0UciPdoX2T8In1Ayz1XsZyaoAJRULzrqkgPYR4imGqQ6dloQI7s?=
 =?us-ascii?Q?I+DyR5WlHlx4PlO2DV5DBqyLUT4q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:17:30.5941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4542e6ab-a6a3-4536-391d-08dc6564bc15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

Detect the vendor and pass the sysfs name for the vendor for searching
the controller information.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index a30cfcff605f..e3b09128ec3d 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -224,14 +224,24 @@ static int num_of_mem_controllers(void)
 {
 	char imc_dir[512], *temp;
 	unsigned int count = 0;
+	int ret, vendor, size;
 	struct dirent *ep;
-	int ret;
+	char *sysfs_name;
 	DIR *dp;
 
+	vendor = get_vendor();
+	if (vendor == ARCH_INTEL) {
+		sysfs_name = UNCORE_IMC;
+		size = sizeof(UNCORE_IMC);
+	} else {
+		perror("Unsupported Vendor!\n");
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
 
@@ -242,7 +252,7 @@ static int num_of_mem_controllers(void)
 			 * well and hence the last underscore character in
 			 * uncore_imc'_' need not be counted.
 			 */
-			temp = temp + sizeof(UNCORE_IMC);
+			temp = temp + size;
 
 			/*
 			 * Some directories under "DYN_PMU_PATH" could have
-- 
2.34.1


