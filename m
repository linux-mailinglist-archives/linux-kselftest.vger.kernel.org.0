Return-Path: <linux-kselftest+bounces-35697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D5AE6E00
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 20:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7CA3A2717
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117AE2222D2;
	Tue, 24 Jun 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m6PmJ5MH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEA26CE08;
	Tue, 24 Jun 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788078; cv=fail; b=sKd4SFuXEHX7L1rG7/GL+VqfOgg2q50B+RLD9rtKXN0AwUQpWQqQq7MFcp1LsfI2sL7KVOF9QZMxb6OWRosUV7zxjPJlvqu0tf5GIIv1L15E4k3j7mz4QwgFuCjsKo3UKzINvCsKqVqO8XCUQeYFXT0TAtTOQ6wlPMMu86RkFQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788078; c=relaxed/simple;
	bh=7SC05j4vNhHHGFnDqBLjR4d9g5gA73Ovtf+cuw/7s/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jv7kvciZKMwU6IeaB5LdiAwpilFfLhJvOfuL7SuBzUgOQFe8oQTHGAXuT8H+5vzZ96EsyRWq61SUagqSUtvr1aB0geYugF8QvLL2vmMyH6h2oqO78dinj0CwumrJ2tem0uaqSIqInRq+HI5uY75afByjusF6TbQx+2gQZKEvXRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m6PmJ5MH; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRWWVO+zQIWf+qbcv0mLWYYRrm9iCtQoRVdWvmTiAllPKJKjrmaUmlDTW6qZCOj4MNXzPQUeHDO9xrXpGwP1lZp7cThgjb/tXf4IVzrYyty5bmqhe0gP6vmAozR4GJ2buMypdZZTARrZ63bpEUmK6TwIY27Z0o7+l3Zo8q93FmQ3ZhtE/bnkrn/lWAAn6D22P4yggalrrmNjXB1ZTwv7d8VIVKNA3G2lONKOsbB0CW0Gp/x4zydVjiVmkQDRgeoLUuN1GRNe1z9YHI9oCHNrIpvRX0prS+alTn4+EPobLrg0+OvDdKn7UE9tvzPXbpqKtoGgy6htBeg5A9v4uG7nJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4JbvucI+Bqo7L25H3hKzHyJjlmqc6kvcuE9mwKQcrc=;
 b=p1K5bRbaq3KgAHuPDLBZC9xFJqNZk8zGtYKQlhk+yuaXTxg/ZAmtTSD0xAzf5d+5gBnyNArx8fqyhEWfxpyk5PaRCMhbe53l7h5wi97KdGYdm30e84wg7f0QHuGcn13KWpg4m0+sMDxFckpXUtIGl0FY+8ToOoQaYSSSF8DBTJL56rSKuLCG1J0xJYu2LPGQjRwhxyYNmeUkYqncEwgWvUPWg/8Xno3I+sA7kVf95r4zFUANt1BYVAOWkq7tOcHi8rp/gG6B/3FfTFPs/hkzMN4KoOsow88vexFGIpXqrROUDvzROBGgvBsomjJNseVyZSy5a/hrFwlmYt7Knz/4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4JbvucI+Bqo7L25H3hKzHyJjlmqc6kvcuE9mwKQcrc=;
 b=m6PmJ5MH8XlObtIw2eIdh15heXMdueJjUmpSWJKFNk+VbSRjHg58MBUMbTIQjuyrKOLP2dOZCjgc8KbDClsVZ3X6poQiqKkphg0RdKTMkwcTqz9iWIAIpPiPZXBDnGE0e8uhWqkDs6Y3T9rpY9/a/1pfITgJV3rHfI/mjB6ppB21S5Fharwu3Uow6K5ts7Pa/yXI3J0+M44ciXWeAJwM9IvPGK/a+bYZGiTMzHrUYGNBK7/BVlOMgEpqmssDFZoh78dmW700RA9m4MRmz4aIEMde2gZtx91hyGe+6pUCzCQ/ElQ2k8VU2qN+RmmhECgD41mNa8HFC7luvh5zn9t61A==
Received: from CH0PR03CA0326.namprd03.prod.outlook.com (2603:10b6:610:118::9)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Tue, 24 Jun 2025 18:01:13 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::a6) by CH0PR03CA0326.outlook.office365.com
 (2603:10b6:610:118::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 18:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 18:01:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 11:00:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 11:00:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 24 Jun 2025 11:00:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc v2 0/4] Fix iommufd selftest FAIL and warnings with v6.16
Date: Tue, 24 Jun 2025 11:00:44 -0700
Message-ID: <cover.1750787928.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 3767fe25-859a-4050-409b-08ddb3491b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHFHOWsvRU83TDljSFJ2MTNaMVdRUEpOaVQ5VkhPOGs5L0srTUFIR0hBS3pZ?=
 =?utf-8?B?Mnk5dU5TMVhyUnpUSzNlMnpvZXd6L3VBY20yQU9MbTFvQzVUREdnbE41T1Ra?=
 =?utf-8?B?cEFFdXNXdkJlUjIvOFdBaVg4WE1Zc0ZaQ2FRQkg2RXQwZmhkdllLSEJBUTBB?=
 =?utf-8?B?VlJxazBRd1Q4cG81bkdqSDV0SjVOdWZNWDRtR1IrdUhUbjJhZ05EYktoSmp6?=
 =?utf-8?B?NjBnVThZak9iSkZrQVlSdk9BaHJTNTdQdi91T0k1bUdaaHJpQnZIRkx6bkFw?=
 =?utf-8?B?RXh3aThwajR6b1BENVM1V1ZDUm9haUNWd1dnbncrUUNJSEtWb3ZwU3h2R1pY?=
 =?utf-8?B?RTYvcEl0Tmp2UE96Um9MOVVMRWJWWmNXRk9ubDdaWnd5Q1ZKZWZ1cHQ1Y1M5?=
 =?utf-8?B?SG1iRFAreDJEVzZvcW1tTG9Tam1jTUY0dU9hUk1DYU9PNW1FYlNKZXcwTGlB?=
 =?utf-8?B?ZDJwamZjSXZjS0xCdUw3SDRYNjkydkt2dHY5Y01uNmQ5Qjh3RE56Rnd0djlk?=
 =?utf-8?B?NEkwSXUzV1JmejAwVS9iMGl1NDNiS3JQcWdqSGVjSllEZGhKZllVTGRFc1N5?=
 =?utf-8?B?VDNGb094VlZteGdNQnVjMzUyK2x6N0sxKzR4dnkvRjhoY1JXaWVickJmTTVl?=
 =?utf-8?B?SER2ZUN0aHo3Z3ZFa2d2TjNrZWZRQnlVRk0wTnN5ZFVpMzl3YmF3WjdaZ1Zn?=
 =?utf-8?B?S2NtUmxIL1JzeWZvbWd0ZUtscTA2K3gwbWRKa1B1U3VjTGNrTVZqQzROdERR?=
 =?utf-8?B?WG1jeENkTFpOQmpsYUxZU09NemtEckJwNTR2b1RyVyt4akdXQTRIdFdMN3ho?=
 =?utf-8?B?MHoya3V6YkM2eHVpdU14ZmFWVUo3UTBOSGp5WUd5VWpzWURBRDByK3hLNEpu?=
 =?utf-8?B?Vms3OGdjRGJEVGphQXRDcTFLR3BrbW0wVDNpbzltNTFJVVJGclBhTWRJdFh1?=
 =?utf-8?B?REhNWVpwR29oL3llZk1zaWJhWTdjSWF3UUNMY1h5VTlVOGpWMkxwcHAxbmxF?=
 =?utf-8?B?S3BCRWx1Q1VLUmtiUmdTc1ZuTE9GdUlpOGhOajkyNUNveUZkdXJIWFFtTS95?=
 =?utf-8?B?WlQxUFNFK1plV1ppTFBtNjYxUDErZnA4Ni82bW1RejVVVC9EMmlqbjI4cnZs?=
 =?utf-8?B?MXBURUlvd3dNdEJEYm9tRlJNRGFRRVN3ZExLZUtYNmYvdEM0QnJHTWNqNThG?=
 =?utf-8?B?K1Vqb2hxVW1FbXl5M1VwNXhwRFpYSURUWUdvMGNGakhPWVlGL3JRNExYeVFk?=
 =?utf-8?B?UWRBK2N3M0VXWXhLd0kySFlTd0hlSm83NmQ3N29haHJGeXlTSXpBcU9iWFd6?=
 =?utf-8?B?Mld6dEtNeUU4bTlvOVh2WXc0bkRqSGsyKzdKQjFOZnRTbUdaeVltbXVQODBx?=
 =?utf-8?B?Z3h0T3E1dnlOa3RoemIwOWUrZVVVRTA5ZSt5REVNRTluWVBuWHhBUXNzSHdp?=
 =?utf-8?B?WFFuQ0NOc21Ya25UOS9CZmZ1TTBmSmVEUlVVMzJsSHlpdmNFRk1ON0xUaHZp?=
 =?utf-8?B?c3JaNEhqRTB5aUU4UU9RQUluTk9SVmRybnFQNWQ0RlVWclh1QytUTURnSUxY?=
 =?utf-8?B?YnlyU0pwNmpZbUkwMTVuRWJ6VE1pMmtFTlhpNGFDV09xc3lXeFdMOVFnV0dR?=
 =?utf-8?B?YXlGOEl6Snh5UzEzNGFtTWxhdy9HUGJKMzJ3SUtEOEFnQVQ4alhFMDByMXNF?=
 =?utf-8?B?U0ZQWjkyQjFyT2xMRG1ETWdOT1lRQWlIaUxrYUNSaTR4cFFiSW5aU2Y1VFky?=
 =?utf-8?B?a2ZVaVdFTi92STdkZWxVVVVoNWxsaFBIelRFeEVDSG01bjFVYXdmbWE1aTRZ?=
 =?utf-8?B?ZWVtdDEvamNsQ0U2eDBOWW9Ec1lpNW8veWVuanVFZG1CajY5aURxVzFkenJx?=
 =?utf-8?B?ZFhJUjFNZGd1eGpnTUFnTnlaSjlqOWZXZmhjWlBJM1llbnpHc0hkWWc4cmsz?=
 =?utf-8?B?RDR6SkJnQUxsT3FpdjFpU05BaHFreGFvYWZlMmNRczlkd3FTNjJETjR0d3Mx?=
 =?utf-8?B?VGtRYUVaUFRnNlRud0JxNVU4UEh1ZFI0MUs2SUt1bVg4YXMzTE1GWHlNN2dG?=
 =?utf-8?Q?AFOoMC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:01:12.8528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3767fe25-859a-4050-409b-08ddb3491b67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251

A few selftest harness changes being merged to v6.16, which exposed some
bugs and vulnerabilities in the iommufd selftest code. Fix them properly.

Note that the patch fixing the build warnings at mfd is not ideal, as it
has possibly hit some corner case in the gcc:
https://lore.kernel.org/all/aEi8DV+ReF3v3Rlf@nvidia.com/

This is on github:
https://github.com/nicolinc/iommufd/commits/iommufd_selftest_fixes-v6.16

Changelog:
v2
 * Add "Reviewed-by" from Jason
 * Only use kfree() in the teardown()
 * Add an mmap_buffer_size for readability
v1
 https://lore.kernel.org/all/cover.1750049883.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (4):
  iommufd/selftest: Fix iommufd_dirty_tracking with large hugepage sizes
  iommufd/selftest: Add missing close(mfd) in memfd_mmap()
  iommufd/selftest: Add asserts testing global mfd
  iommufd/selftest: Fix build warnings due to uninitialized mfd

 tools/testing/selftests/iommu/iommufd_utils.h |  9 ++++-
 tools/testing/selftests/iommu/iommufd.c       | 40 ++++++++++++++-----
 2 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.43.0


