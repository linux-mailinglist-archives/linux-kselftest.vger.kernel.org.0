Return-Path: <linux-kselftest+bounces-11270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76268FDA01
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2BE1C21861
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96E160780;
	Wed,  5 Jun 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TNHtc3gf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D929AF;
	Wed,  5 Jun 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627548; cv=fail; b=HYx38zabmpTtIGsU2NevPeVOOxzA9ZIS+FaK+MuQhbsVFkunLoJAM2Vhs0U1aH2F0UibfQ2fpii/UMv7zNtSHCxY8dORRMGLytp41Luu51wA4m4PZnHLq2Z6FJ5mn2n0rfQbcDF/xtbM8hEZ6o0E1oiS3hFa5k3p1g/3tRhol9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627548; c=relaxed/simple;
	bh=gK6jMoZ/tqAQtvJxUah72x0cD5fTNPVrp49waTRG5/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJNZ1xozLf3oU6kiNJW6yfcITYy79HA1zZ05faqA9EVE87Q9UdTrzKWlVq0ro0O28kpeNI/qjsQhbU8hIwF1krGRbhQmwDklKKJcsz+pbs4qIDbH4qVfGxd96AB0ebl98u3uSlBsim9StZu8KCwVnr1N5ALMkDXiCt2+MzIpZ/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TNHtc3gf; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8qOR4q3gKtqdu709L2ezDrCllm8XfLQ5n8G81nGBYQWwNnhssPhn5gUtS00lh8K22i8hMFWzA+hFGB9D0ini4KU0VurueC2JEznen/ztn/N0RU+mbbx1BlupZTL0Aoh5A1b/MHHIOJAgninb0B29wMrnzjFkWF7gbhSZGVGKDaSwYICssZLXifuHcq5Z9ioUto53vN/alObk5zlpBZx5cs4UGElt4eoTYA//PGNhkzDsYtr+FprhEVNUxUQQ+8sxPPMRNVNT9x4rMrBc8Q1wLcxeL4rKbbWnwPJPkjd8FwoUQOvI4F+/FxB6c8qGYmLXhlqc5Oi/tBmNoX0No/tCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgvs3P20EJpK5dhoStMKdbaX/aBAm++DWxaYs4ta4E8=;
 b=ANCFPwjua9z78b4aQ3ho5nUd6o9mPVGZG70KQBPgFeJ+XKyxzcLA/c8kMGyqmpTQGMNU2v3dNHEhnZHalTmnr6O7iVSODCQC0uVc9vSOvcLJpQORPeCmCh9sHEzqdS2j0rlmZSedqAABiEWHcrCAK9aguI0XjiiFU3lTQvF9Uf9OJtP/XhstRx5fGoq4rzL03RVl9pNB+v1Np8zvsJl25CHopwA3OgOPnJAWFp+vyUT/UOAyF6SQf9+2LEC6AX4augcCTLT1QxVYvXxwLWSS1XywjshDuu0pE5UaZR54KKE2l+01f6+/CghqzdoAC+Xmp0RTvZ171I4kKH2dZT6RAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgvs3P20EJpK5dhoStMKdbaX/aBAm++DWxaYs4ta4E8=;
 b=TNHtc3gfVGnHtKjYEs6dYBbSf27elFnlOHeZ+xWfSmFpCImnH47sVwJ811EYeQtiYO22GaG4W14mTt2zwvjtO0Ys0nXqEMxdnXBJPZ8aNS6hUULar/k7LNNcUQ17eGZx81IOsZcpL3oA4kHD+ibvWZHQd0tuCDcOmRp0juNcE2s=
Received: from SJ0PR03CA0124.namprd03.prod.outlook.com (2603:10b6:a03:33c::9)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 22:45:41 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::b7) by SJ0PR03CA0124.outlook.office365.com
 (2603:10b6:a03:33c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 22:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 22:45:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 17:45:39 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v3 0/4] selftests/resctrl: Enable MBM and MBA tests on AMD
Date: Wed, 5 Jun 2024 17:45:30 -0500
Message-ID: <cover.1717626661.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df15990-cc7d-47fd-447a-08dc85b13a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWNswvymv2I5n1DfBoF1fBwYNPLI94T7xlsyJ6Haw+V8dQuoYgBi1NmFiwq/?=
 =?us-ascii?Q?gPu/j6uZsnkGINLojCnTW9SDixa7INmcgBHG9MK8lrwD66JSx7co8+tlqMhr?=
 =?us-ascii?Q?xonBQ8x0Br13LJyOLzGrJNY5jJbwoWkpFBpsLpfFnOeDGTUS+bRntu9paXSh?=
 =?us-ascii?Q?75eqTRxON41VkYHl05NOXfuGnOwCCuw4Uf7SJQTM5SUZ6JXvUdFU8MflnT12?=
 =?us-ascii?Q?FsWa0wFBxIqHvFjoOlG+tvZcjZTpZt6heaHOZ0eK2bVPiXK1J3wC+YFX5bOW?=
 =?us-ascii?Q?g9M57sgzHMDQsXoXlCiLABqFxZRb6ApMrPmHTpZhbCcLENQOkSospNSMTOcF?=
 =?us-ascii?Q?rE9bhaLi1pIb1JgJBPNjN9nWRR9wViwM+F0FIVpIv48I6+DulxzE9NLtJvsH?=
 =?us-ascii?Q?nL18mBkFnf4u17fqdJy11lfa4U2zZwsYhTFPgrv4uHforYCNv49SQkg5j5tU?=
 =?us-ascii?Q?sZ7vddpJukat2kU3zR3iWmLu3G7REimRHMskPobCTaoOXh0O7JgSr+aufyBW?=
 =?us-ascii?Q?WhLOo9/WhiZ8Hrdup2F4eBUNq3vX5Ifm96X78wLGf7KNeISpXxbjOU3W45t9?=
 =?us-ascii?Q?68f/3lC0GqUxZuLnlLqWbPJRYn9dPUO5qgnltNxmLX9egecgT6rYxQVChfXL?=
 =?us-ascii?Q?J+gtHH2TrJuFzYKBsSqeHVEt2MEMQJJE+92JMMafB8eb6pm5XuTLfw46o0gY?=
 =?us-ascii?Q?pkt3A/EpRrGhpwazk0Br+ZPj/B7o/jHqYYTbhKhPRQ6hTBHtzjzC6KditBxA?=
 =?us-ascii?Q?WrXfCgZIbcEchYDg9hXSGUu5MB1J3kZQbjpzZvG4edFRN9ZTRi/aSOLE+BCa?=
 =?us-ascii?Q?690+4bUZkSxyX/5nk3oWEzmK19O+aHORulEwPtAhqSQFwZlotv+fVmR0VbzU?=
 =?us-ascii?Q?rIHJKY/XJDERBTIq0dV5ePFV5pQCwtE9812X4z+HzieTzigTV6qzEx0bglSN?=
 =?us-ascii?Q?IpI/g8YtGxVtDJi+eNYl/8mmayYeSSX3Rs0WLYJndmBF9dGPC2TLr7czKsiD?=
 =?us-ascii?Q?qZTO7FW29kSqgCpBocJsDWOMwAMbcIWAgFSPCoNIXpOd/o1OH1OSJ7oRe+no?=
 =?us-ascii?Q?Y3n60m2JA9chYTq4L5fDq6yFKjEegsmcMqvo1qP02TkcbJCpO2xWOHqztuQ9?=
 =?us-ascii?Q?JURfttGIKT40RGDAnSPwF7cIgDjrJ5AItXXt86+G0gAOB+YxUo0FpAviS98U?=
 =?us-ascii?Q?yni9TvqrERa2aYc8Bt5ov6imTkClDoY7QJoKUGrd5KoSm1DEHLlflWwC6cpN?=
 =?us-ascii?Q?ALhk5wb3t44SUQ6m5c6U4Q1t/VK7mu05zYdb/BViVjeBsuXkkYa7rl3Y1OeU?=
 =?us-ascii?Q?IGU21822t/E2s5QibhoT/wbZya/m9YZcpINqaJnZ4GnXd9a2794bwmH2RHtA?=
 =?us-ascii?Q?I95lGOsXIhtp1FF6jKDJa20bgKyc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:45:40.8776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df15990-cc7d-47fd-447a-08dc85b13a1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451


The MBM (Memory Bandwidth Monitoring) and MBA (Memory Bandwidth Allocation)
features are not enabled for AMD systems. The reason was lack of perf
counters to compare the resctrl test results.

Starting with the commit
25e56847821f ("perf/x86/amd/uncore: Add memory controller support"), AMD
now supports the UMC (Unified Memory Controller) perf events. These events
can be used to compare the test results.

This series adds the support to detect the UMC events and enable MBM/MBA
tests for AMD systems.

v3: 
    Note: Based the series on top of latest kselftests/master 
    1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0 (tag: v6.10-rc1).

    Also applied the patches from the series
    https://lore.kernel.org/lkml/20240531131142.1716-1-ilpo.jarvinen@linux.intel.com/

    Separated the fix patch.
    Renamed the imc to just mc to make it generic.
    Changed the search string "uncore_imc_" and "amd_umc_"  
    Changes related rebase to latest kselftest tree.

v2: Changes.
    a. Rebased on top of tip/master (Apr 25, 2024)
    b. Addressed Ilpo comments except the one about close call.
       It seems more clear to keep READ and WRITE separate.
       https://lore.kernel.org/lkml/8e4badb7-6cc5-61f1-e041-d902209a90d5@linux.intel.com/
    c. Used ksft_perror call when applicable.
    d. Added vendor check for non contiguous CBM check.
  
v1: https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/


Babu Moger (4):
  selftests/resctrl: Rename variables and functions to generic names
  selftests/resctrl: Pass sysfs controller name of the vendor
  selftests/resctrl: Add support for MBM and MBA tests on AMD
  selftests/resctrl: Enable MBA/MBA tests on AMD

 tools/testing/selftests/resctrl/mba_test.c    |  25 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  23 +-
 tools/testing/selftests/resctrl/resctrl.h     |   2 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 305 ++++++++++--------
 tools/testing/selftests/resctrl/resctrlfs.c   |   2 +-
 5 files changed, 191 insertions(+), 166 deletions(-)

-- 
2.34.1


