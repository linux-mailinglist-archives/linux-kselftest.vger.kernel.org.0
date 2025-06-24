Return-Path: <linux-kselftest+bounces-35698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39230AE6E02
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 20:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BF53AF125
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 18:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1A2E62AD;
	Tue, 24 Jun 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OI9+R2Vl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755622E62B4;
	Tue, 24 Jun 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788081; cv=fail; b=VmWtWfyJXEUFtaUAwcT0DGf/ETimQ5y864JZpr3zB/m2SNUJPZHvc2VaBxRxUAxpKzKyRGseIj9PtJpIEibHH0/3KHvmNV1NNT2VNYTY1BXJfvTO8qc9yLqIQ4Tm0gHXhUDAWugEqleUTCbgAnGSPUR9MkuYTRB92aFGD8vZYXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788081; c=relaxed/simple;
	bh=NDrWzYLs/sVpu0wpMVhBQgK0rVuNLLymyqfGLVymFK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtzKxK1x//ipuq342xhYznX3xa7saDLj8QyLldnO2nKQHiqOSyUFEF2VbrDIfEhWUu0UBtgegikpzuxzfME61uf+gYH9Nx1u5RyeV0+YcEslaC3fBjdYIgz89zV6os2Sq3fIm99bcgpZ1mbPbDLydYih5cnfPsriZZjt+Y8A/2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OI9+R2Vl; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb1PJ1fDbg7/ZBUsuiW2lCNLL5NEwfWl+VYPgs0uw8QTRZ8LKDKx+qzIJH2dzcTB2F9k/UIOXi59exFV/1eE30u/3scKMLz1AeDP1rXHDSZ7WexUT4kOHYRWnhJgcE+IHEeXNSTAQKesO58paCeCcPzlh8JpHp7tej+bBRP6dHgJ7qqo89fZs5RjQ/WvULtVcM4/brFoD3RHRFOgldEjt/VlcsdxIHM9S8gA5cQXN+SfdoaZzN0Ycka55QrlMNOZ42LsW72W4dTSeCbgZK/lsIin23aWLLVyoFyz66AB1WEyB1HFzKpFRDgRmzGNSDEDRDIDuhNj2HmF5snTXQWv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zrbr380aOF0gMA7Rpl3Ua7BP0p/6lIPL/9qDHPyL0s=;
 b=YwK5imCSgbxkRF1F0OXXA/qVaXfrRl8HwKH6Pi65sKbGgYPV887F63Q6HzgW94CeU+GJaFtOePgSvQjuBUrs8zLkexxX6FdJDzh431mwW85WslySJ0Jl+2F5Qur7Asm/VBF07LLUOor23s6inlDriWxmzbBC6Am53+B/Xnu5wq/vSv0u0eFDwxihV5lbju4q9Ha89CLsn5mTSFabI0/zJzR75djiUS+sRbexrxeKH8bO+FVlQewHdctCzKcpqFUeU4+RkMsitsZOjs3VBvOGOT8OguYllp9OMwi3nINbbX7A4HvLjxPFKA6SAycG5Ed3XG8LuJXbGpnUZZnQvbD8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zrbr380aOF0gMA7Rpl3Ua7BP0p/6lIPL/9qDHPyL0s=;
 b=OI9+R2VlKmVaOLUSnA+8GhBP1QbqVIqJAe6YFyoV1zphonVa6tNaCnQhV2Jy9GcomBBDhCekDlaXYCuM7wErH4arJhfSD7PW3zdiyYwf+fTMcbFzERGC36TmQLStflnwslcWj0BbH5bO8MUoi1KhtdLJ64DTOqK5Ik/mxpW68/QN9EY9bIg2qDHIkrjC0OFXxyOKN5Fqu6Z+HxAUipB5rPwDRQJwTmDJZT9dZE2YppUoBqG6lUY9BRZFr1JvjUU5gKY5QtoDlfp6io514JVmqVM/hq/N/mnhMQWiRMu6HhNXYhREc30hDTTMgXi8+PnE+M9YQ3O6dhd9ACnjBJH1Bg==
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 24 Jun
 2025 18:01:16 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::d9) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 18:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 18:01:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 11:00:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 11:00:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 24 Jun 2025 11:00:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc v2 4/4] iommufd/selftest: Fix build warnings due to uninitialized mfd
Date: Tue, 24 Jun 2025 11:00:48 -0700
Message-ID: <6951d85d5cd34cbf22abab7714542654e63ecc44.1750787928.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750787928.git.nicolinc@nvidia.com>
References: <cover.1750787928.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 06411a2e-576d-4401-cd60-08ddb3491d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmxtTDVIczN6V3ZJcWFOcnhzQnlJU3hhRHB4VWJZR3lLWU02a2tvNEpwRS9o?=
 =?utf-8?B?aVhsMDB4eWUrRjZMYlRUbVllWXJjc1pna2pacHFPNnZ3Nm9nUHFaRUp6c1dM?=
 =?utf-8?B?ejkyc0xjZ2Y2bGFBSFM5UEJ0R1habEJBamZqNlRWWjEyZ25rNEdSdGl1RzhF?=
 =?utf-8?B?bWdhdlRQdlhIajRQL2o0aitERDN3cXAxMHVDa2pXNHdNN3NyeWgzcFdxMWkv?=
 =?utf-8?B?YzZ2Z2VYT1V2NTZhYlN2dkFqUE5HQWpFNHdSNjNlSTdZWW4xTkE0eWJqbmdT?=
 =?utf-8?B?ZzBtbzV3dE02TDZWWjVqTW90Q2w1ZURnYnlRU0NDVlFLc0hMVlhjRCtCNXFP?=
 =?utf-8?B?bWdUNDkrUVR6YUtvV0dVUFM0ZTFtUFJSYnp0SzBVTmtkL0wwV2Fma2pJcFR4?=
 =?utf-8?B?STdHZzdzZnd5Nks0RU5wYnBlR0thWFBldmI2TUlteDc0M0JEdlg5U0ZnSCtQ?=
 =?utf-8?B?aWFxTlZ4U1hQYVBzOVdwZE1YWWxCMzl4WGRFR3JRN0UyeGxkMkNTZ0dQcXo0?=
 =?utf-8?B?emNpbU5kMkJTL0o1VHpEQm9KTVBnMm5NYk1pa1hnRWt5WWJyNnZZY0tpeDg0?=
 =?utf-8?B?U3BKanQ0Z1NRMC94V0doWXpTSCtORk15R3hlZzRVYkVFQi9oamxFanFhQm5R?=
 =?utf-8?B?L1U5SU05VElMWjl5NXlKd09RU0NFd29mNjM5bDlCM1BWVmhVVnMzNGNGVmM3?=
 =?utf-8?B?cW1FNk5RT3pFTmMxeEZsS1ZvRG1Rdnowc3BTcDZOUmk1NkFUTm9sSUNTWHA5?=
 =?utf-8?B?QUM0NS90Szk1QTBrSkQ5VFVFL2tXS1E3b1hZWVg2akVGVFVoSGY4VldGUzFP?=
 =?utf-8?B?eVpYY0Fic3NYRG1zVmxZUll3c25mMHVSNWFFNkJCdWQyY1c1TWRWcGRkMFBx?=
 =?utf-8?B?azkvSHhJYktrOXljVlkxUHdzektkVExKUzJCaWRnejR3NlNxTFRGREMyeENL?=
 =?utf-8?B?ZExBWkNVU3FUWGxCbjh4SjRGMzRWRlJMVlRlcG4vVzh0ZDE3SkhtOVFiV24x?=
 =?utf-8?B?WVp1Snpsc0V4TDhqVEdLUFIrMWppV0tkTVhZN0dtUGtXQlVKeWc0WUlRWTRr?=
 =?utf-8?B?R28yVDRmL0NFenlRWUl6b3hiWlEyNUtTNzJhcXd5NFJTSG4rNG91QVBEaThH?=
 =?utf-8?B?K2lrZjNGcUl2TVdvb21xd0NZVmNMUjZpQmwvQS8wK05xRWtlb0JpZ3BUR2hF?=
 =?utf-8?B?R2tpL1NqSVlDN25MMjJBQUdLQ3ZXWGRsZjA3WVdMWmp5VkNIaUwrRTRwR1RC?=
 =?utf-8?B?cUhycmpPeEVwQ0tiZlNxR3BkQ0txMXZZVFBEZmJGTGNTUXQ2L0E4UE0ySExP?=
 =?utf-8?B?ZG8wREVHeHdzWjZwQWlRK1RJTmVMeWFLRU9LV0hCelVsbWgvdkRvSDVLNmhS?=
 =?utf-8?B?a3hTbituZDhUUGtvaVd0L1ZnN1lpdXZDT3N6N2RGVHlQeW5RTVVLZHVtcEdD?=
 =?utf-8?B?SldDa042bHI3di9FS3BhYUpqVUs3NXd0eFVnamErU1FjR0YzZVZobkVhbG1X?=
 =?utf-8?B?cHhqRldmUXY0UzhoL1ZQV0toV0VrQXNCNW5GRVBqbnNJOFFWZ2xpUU4rT1ox?=
 =?utf-8?B?WnZ1SVU1M0loQ3hnZFdsdy90ZnZZZGpSL1NrSjRKS0hremV2eWZvazNmZlQ5?=
 =?utf-8?B?SHA2c3RiTkI5V2hYUUlvZGdQZnJsa0ExZ2QwS0NwUkNmRUU0eVI4NWRHUVdu?=
 =?utf-8?B?ZGJWV2NrcjQwQk1USmVOY2daUGt3MmVGQTIvREFmd1dSUG5BUUlRVXhxUU5D?=
 =?utf-8?B?WDRPY0lPbGx3cUVZb2lJY2p6ZFpsa2JGazIwL2Zta2RQWDBPOVJ1T2ZKY0F4?=
 =?utf-8?B?M2FIT3BqNmJjSEhJZ1VnZjNoWDk3VENBZzlFN0Njd0JGbzgxcVUxbUxKaGFW?=
 =?utf-8?B?NDlNY1BnbllyaEg1b1V4cGUvN3o0blEzd0txazlBN0ZOdDIxSFFTcEd6aTg3?=
 =?utf-8?B?ZnBxeEVjZkJwUUR3SlUxdXYzNTVRUFlWcWZuUjd1Tm0zd21wVm5YUVdvVlJM?=
 =?utf-8?B?dURDMWtHN2FWOTQrVEVCZFRjU1pFQkxwak5VQXNNREpoU2VzRm9UY3FuUzdl?=
 =?utf-8?B?QlAvVVBEN25ORkYyNmhmMllHcTJDaVNnM0VDUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:01:16.2021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06411a2e-576d-4401-cd60-08ddb3491d57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70

Commit 869c788909b9 ("selftests: harness: Stop using setjmp()/longjmp()")
changed the harness structure. For some unknown reason, two build warnings
occur to the iommufd selftest:

iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns’:
iommufd.c:1807:17: warning: ‘mfd’ may be used uninitialized in this function
 1807 |                 close(mfd);
      |                 ^~~~~~~~~~
iommufd.c:1767:13: note: ‘mfd’ was declared here
 1767 |         int mfd;
      |             ^~~
iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns_copy’:
iommufd.c:1870:17: warning: ‘mfd’ may be used uninitialized in this function
 1870 |                 close(mfd);
      |                 ^~~~~~~~~~
iommufd.c:1819:13: note: ‘mfd’ was declared here
 1819 |         int mfd;
      |             ^~~

All the mfd have been used in the variant->file path only, so it's likely
a false alarm.

FWIW, the commit mentioned above does not cause this, yet it might affect
gcc in a certain way that resulted in the warnings. It is also found that
ading a dummy setjmp (which doesn't make sense) could mute the warnings:
https://lore.kernel.org/all/aEi8DV+ReF3v3Rlf@nvidia.com/

The job of this selftest is to catch kernel bug, while such warnings will
unlikely disrupt its role. Mute the warning by force initializing the mfd
and add an ASSERT_GT().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index e61218c0537f..1926ef6b40ab 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1748,13 +1748,15 @@ TEST_F(iommufd_mock_domain, all_aligns)
 	unsigned int end;
 	uint8_t *buf;
 	int prot = PROT_READ | PROT_WRITE;
-	int mfd;
+	int mfd = -1;
 
 	if (variant->file)
 		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
 	else
 		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
 	ASSERT_NE(MAP_FAILED, buf);
+	if (variant->file)
+		ASSERT_GT(mfd, 0);
 	check_refs(buf, buf_size, 0);
 
 	/*
@@ -1800,13 +1802,15 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 	unsigned int end;
 	uint8_t *buf;
 	int prot = PROT_READ | PROT_WRITE;
-	int mfd;
+	int mfd = -1;
 
 	if (variant->file)
 		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
 	else
 		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
 	ASSERT_NE(MAP_FAILED, buf);
+	if (variant->file)
+		ASSERT_GT(mfd, 0);
 	check_refs(buf, buf_size, 0);
 
 	/*
-- 
2.43.0


