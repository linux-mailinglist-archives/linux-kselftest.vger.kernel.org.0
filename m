Return-Path: <linux-kselftest+bounces-8884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8918B298E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FEF2820B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDEC153834;
	Thu, 25 Apr 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wzcPx2gP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DAA1534F9;
	Thu, 25 Apr 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076242; cv=fail; b=UGNGlt4Z909Dyy0jb0cF32TxKm7fvMIFXQG56+A6MzvQDV12l2ZtgEOF9qt4N+oSxbqwAo5FidamhvDtk+Ab8m9uz4g8QUI4JvEm7UbTiR9oq57rQhv2NhW1QEXk7UxyAFgkwZrtnOoO7vfrksFl2nPEXcDTVJIOWB974H7OyPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076242; c=relaxed/simple;
	bh=F3f5h8reMschUPK3e7+c9iNVgk51YiBeqhXLlyouEII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuxBvTiSJ1YIQD19WGt0Sq917lLyIRLO5S04+R8H4OArWIBPylMEh4k3VrDDlCS9v5yWpd8eWXx8Urd1we73PPOznT7AoFLhxlrB4ugZW6S1UAhcVY9Eo5Ehz0nbwhNrCKCKPCxRyBbKYO5bEy7gGudmsWc/KdX5gdDwXHzN+Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wzcPx2gP; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZAZ3PgwYt79+8Ur5bSIXy5CYO80NBe2ug4x+tqrop3CsmztN/tvanfckGPPDmX3z4hyP+KzJ4koPfFexTLUK+7XfLnfXNjCdCLeNMVaFEjbItr4EaL9XmjJIg4++e3FzbmL+Z+KFgEQ7D+Kz3vpFqWgyukw/lOi/nlkV8v/i2YEQUlS5vrsBgosDJAmGZ9gKUdJfg7JQMrGNGmQKO0rP9LEa0+z+6/TGVA9OtClzOh58ruRl+KvMOLJMlFXUer+UOw3pD+0kVe20RwrAN1looDVtzgoHLiqwh49/g8SVFB3K9XgpqNYNWf7Pcw7yPm9nbpfnwXwJuvLGDpmYxCDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcNahZo6O+lTVlvaqJ9+d5hSn+Kru65CFHHZoEggtC4=;
 b=Ji+i5xYedR4PDFnoo8oJf0r92iGV8O6fi12+7jAxUeTcJ08NftfEdJzfviLHu3mmESjUe8cJgoCVodk5duyY55El9qWKFHJcejERSL4zkuyJZ93jDwxWv0bEUhnD75BYIjO15Oi1T8bJqjIrvkJiF/W3dKKXhW8BwhJGhrZICs/+0TP33hrin0+m7gCmoXw2dzRc+PQgNKtP1xoVM8nEMCZXAVRk+RDAaAFOnhD5hPP19Dm1gjM7GWMP99T8S2hqjWm1gJQpnpQ0W/7aQttfOXfztSMzGNqydi6RZv8Iwz9NnV9KoA5bmKiUUekD60XNStzPL0Rfzrelswte19ZN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcNahZo6O+lTVlvaqJ9+d5hSn+Kru65CFHHZoEggtC4=;
 b=wzcPx2gP2fEqavnJJr2b7Q/DQ8G+2VHVvUTHuTZq7W/MB3e9Wjknyk1Q4SccpmXku1eBcnSvOOUJxa+RzKM+/kt9hnGmtJeDkGKZDRHgwcjMqQ8MibCN/YrZlgzjb3ITJAw/fy7nA8/Omt1k273Oh3p4UVGyRxuARkzyNStd3sM=
Received: from MN2PR19CA0060.namprd19.prod.outlook.com (2603:10b6:208:19b::37)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:17:16 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::9c) by MN2PR19CA0060.outlook.office365.com
 (2603:10b6:208:19b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Thu, 25 Apr 2024 20:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 20:17:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 15:17:16 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v2 0/4] selftests/resctrl: Enable MBM and MBA tests on AMD
Date: Thu, 25 Apr 2024 15:16:58 -0500
Message-ID: <cover.1714073751.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708637563.git.babu.moger@amd.com>
References: <cover.1708637563.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b59ebf-8615-474f-d828-08dc6564b3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1Ypqb9pllalvaeoqjrKaFSWN2aZdstZenZE7tYYxrTUf9zN74WYXsFvevfZ?=
 =?us-ascii?Q?LUdsj8KSlN/0t58YNqoH5QNqRQlu1dBrARrUiKYChSR2aiBxIfv5OMq3MTbS?=
 =?us-ascii?Q?z+STI0EM4kXzmUHt1jqdhHbnGxE1CUqjNJgnR8J0Vyhhe+V8A2n1n04C0zXV?=
 =?us-ascii?Q?XZI8cgZeW2rfNUQF3N81UsQBfWRkg5dT0vytOShNDDSUsve/yA+mllhq3NwN?=
 =?us-ascii?Q?7cWPQwtbb7zIpkEg6Ijrc/D6KFfYdnF3LKqEC3ii/5KHAFPHdhS6WJUosZ4Q?=
 =?us-ascii?Q?/c2SCSdNdKB8l7FRHSHjkvVDK8IE9g0HpYWjap9fyvJcnZKVeVh8KQ/CAth6?=
 =?us-ascii?Q?9m+tqrU4UnMlOCEsDAP7XlOQsQNe7m8FgCRHw/qMQ+hFoWXKGqQGOtNSop8N?=
 =?us-ascii?Q?tHl1H4a1gpo/smy9QZuIy8/YXDt0wYXMUoI7Fu+irG6KZUjh6U3XytiWm0L/?=
 =?us-ascii?Q?xj0/6zMND8dVo0phmU1kLwgiomE3xV/FANjapEmRLqssa7xnmA/tE7thLCVM?=
 =?us-ascii?Q?jmECSLzWZruXktOZiDgJYKWD8u2pTMhAiivdC92xMg4r7CaE47ABr8+9WYKf?=
 =?us-ascii?Q?5gH20YHBuCJ5K3FyWD0Dynif/hTthXvLDRSxwkUvO+H4uE18ZLb8Eu2/IEgg?=
 =?us-ascii?Q?p6lexvehY4Kk7rSwwhKUjoSwAz37KpMqu0HhGdvIQ7mvVrlm9KSBKzfvj0OV?=
 =?us-ascii?Q?el2o8SMz33ZkvnhjPP7HkY2dJdbbZeKsaGZR4/aenqg8nH5XFE6EHrrqk8rZ?=
 =?us-ascii?Q?S2dn9juuBwxspOmvuS2icUth2UVPqXJMIllk5AnjJTAkf1iNkN+MQQmyY2xv?=
 =?us-ascii?Q?kU8toe1h6Ytf2xfOzAfJkReVvFcU/ktzfX/JesvQWnXnePqqwu7lHG50yZkS?=
 =?us-ascii?Q?rKchUH2f9nHyX8y0AQB4wGck6rfdj614mH86xbDs77Zjne4eRdjSzKwsFPCn?=
 =?us-ascii?Q?Tb5zPKbGBEMMsOf2yWA232ewtMLsn3TcxgoD3qeWwezGo2nPNcUKfsm0KMIK?=
 =?us-ascii?Q?lTXVmQmE8tK8Qxcl5EMnyBzs+ZfzmWpaX4Opgli8sonS4UPr/3mV6hGUSf6u?=
 =?us-ascii?Q?DexcxIa43UqzWsNqIqJE96p29cDB8ry1/l+DLnrxc6OsADh0R81Txz/21LDB?=
 =?us-ascii?Q?CgZL7TUIGX/gMijR+tmslJdF9wyT+CoLuP04xY+tvlto3tQe8xIZtQADJrjx?=
 =?us-ascii?Q?TXN8K35+/qm9cS9QgrUsAxJ5UMSERD8+MeiQjdC0Nyx8Tew3FMjt93Wr6Mc9?=
 =?us-ascii?Q?oQGtm0JQtMmWMPmjUmcdp6ZAMUfNfCJqeL4DI092a4BM1FCG9SPawJeREBCq?=
 =?us-ascii?Q?LqzSlgJadyl3yGku7A7dNDEVa3gPURLiTJYkxqUyOIv7RQH6I6oiyvmbSZ89?=
 =?us-ascii?Q?T5UPn4uNsniQgBXsJrMDKmg+cT+L?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:17:16.6521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b59ebf-8615-474f-d828-08dc6564b3c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023


The MBM (Memory Bandwidth Monitoring) and MBA (Memory Bandwidth Allocation)
features are not enabled for AMD systems. The reason was lack of perf
counters to compare the resctrl test results.

Starting with the commit
25e56847821f ("perf/x86/amd/uncore: Add memory controller support"), AMD
now supports the UMC (Unified Memory Controller) perf events. These events
can be used to compare the test results.

This series adds the support to detect the UMC events and enable MBM/MBA
tests for AMD systems.

v2: Changes.
    a. Rebased on top of tip/master (Apr 25, 2024)
    b. Addressed Ilpo comments except the one about close call.
       It seems more clear to keep READ and WRITE separate.
       https://lore.kernel.org/lkml/8e4badb7-6cc5-61f1-e041-d902209a90d5@linux.intel.com/
    c. Used ksft_perror call when applicable.
    d. Added vendor check for non contiguous CBM check.
  
v1: https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/

Babu Moger (4):
  selftests/resctrl: Rename variable imcs and num_of_imcs() to generic
    names
  selftests/resctrl: Pass sysfs controller name of the vendor
  selftests/resctrl: Add support for MBM and MBA tests on AMD
  selftests/resctrl: Enable MBA/MBA tests on AMD

 tools/testing/selftests/resctrl/cat_test.c    |   2 +-
 tools/testing/selftests/resctrl/mba_test.c    |   1 -
 tools/testing/selftests/resctrl/mbm_test.c    |   1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 142 +++++++++++++-----
 4 files changed, 103 insertions(+), 43 deletions(-)

-- 
2.34.1


