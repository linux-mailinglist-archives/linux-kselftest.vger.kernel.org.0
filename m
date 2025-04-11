Return-Path: <linux-kselftest+bounces-30502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F5EA85437
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9704A495B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333127CCD3;
	Fri, 11 Apr 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KcFY8lKN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789E1EDA05;
	Fri, 11 Apr 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353500; cv=fail; b=hPDEF7lnFFSf/k0gq+GqzQUwr3ltnM9a7IlpUAJZ26memC4Lzr5jNAbCvevVfVgUS+Sri578SlIqqedtf+mPLEbGTW80G8Z0hUmA2KOzS/ptM7vTIDUQ+9foFr3aqpDFVU5o6dFW7LEDZaazuA44VVoH6WgyYUDkZf1LXtiEaf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353500; c=relaxed/simple;
	bh=3taw+vqw4FIv/sa7gR9/c2olNkrwm9cHuMtWpOjWTGo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kkgBkLwzN2uAwC+OJvatIRDL5+KjF3N9sF+MnkEItzHdRENuZkehBdgVIW3cLQm14qAuANQKVKba8KGhcSbLUw2szF1L5S6JC1yxU2bgvUi6NpSIHmeWd3cPwsiT60FUGVcXILSQxIfpv6hLIaQpANA4S5e3atHLtWN+farvprU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KcFY8lKN; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhnN+oT4fUvFjp66AYCAc8s6NvbLsgZhLW5X0AAtLfuiCH8V9QgF1ADsH9VjBN4fsebDdUGZSvvSvNynkMeUfEDjLI1LK2XDpJkdfBGIK/0Pm5opIY52AEpi1erWquHis8PENYiBrXXksOaDGsnrJOkr/vyr2S/KAUL0uDEDseBx5jlhBcbnzRy0/+Ep/ma5q7pzYvi/XWuQ8l/6K3W91Sa1MSYmDeO+66uRsD6A7loJUmMXsu1pfhIGOc5NdaZA1LPbQfz8ySbqsF3nlUEWKSyNJ0lnfO0ziDqJ36ljGr4XB4DAIfojxmHM408LgX2e4OF6TW3dDPD1HTYiq6YzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMhB7gXHdGv9w0H4J8wdzy41Ggxa42e4FT710QF4YTM=;
 b=NpwhM9LBmHHdcYrcxjbtpJEA6PgA3KgH+xKigcYjEqbv45jsfrcAspix8tBTOrvarQStjp4sKrY2pmq/c8udqE/2wD86teNMiUS4PtnvZgZ1V+8lHXciV7mxhVXvZoQESSVZXT+vSlKn5+4jRHxvJLLsD8HoHMCldOa/+ix8LTWH1lPCNON81FLIeuAVC9A76F0LxCwgFqAzlv+xrOo2W30hi7yAr44A2Py856FTzQOMqcd5Zutn7ryUZS7+stxRF/auHaDWSgoTFf21aiLA7Pnjtcnq7LCDqxBAuv+6WeQJTAfsT1TcJbutIozhlk5WgKRJSLeTJeUeEHjsOew4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMhB7gXHdGv9w0H4J8wdzy41Ggxa42e4FT710QF4YTM=;
 b=KcFY8lKNmLUuT9g/Sls1CKlF8TegGTbRUv/TJem017F4xt0Bt2cX0TGT964mzEJBCsQpcClfBm690JATS0XOKDIyzUQg/xxSRO6aQfGiWDNuQ0nBU8vtpGxrJbaQKScw6N1mJlUYLzrMzxRsDVP3gnHl20OsZ8tQlR2XxopmUkI09/TA5+u7IX6Dd1sd8lIl8QBW8Wmu5xwiXYgQ8HB68js3RpFTcha9aXFtNy4puSN6kQvyc17/GtwwYsjOpslmvDcsFx+IVbEJY5TrbOwGLZ2PwNVvpb0Q37eq8ELPiTW2vbAgipCRVg9sNzZqLiYsr0HqEUHS+/JVVO392oy7Yw==
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 06:38:13 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1e) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 06:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 00/16] iommufd: Add vIOMMU infrastructure (Part-4 vCMDQ)
Date: Thu, 10 Apr 2025 23:37:39 -0700
Message-ID: <cover.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: edd79054-fa67-4062-02ce-08dd78c36ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PUfUPJcFqBFbkB+zjygpWY2gaWLkyNWCBCgAd/uMF14Q9lwjIP4eU4LAQbvS?=
 =?us-ascii?Q?N9gFzuZbnvEgb1CbJgXT32WUMZAHtfzxhKKNR1VOl0qt6CCTsM2BnXu4H+jm?=
 =?us-ascii?Q?O6JtLDzm1IBZPUVF5bagjfoko/AfZM6dXF+jYFCHk/qLyL0sEJF9/Ivycxvh?=
 =?us-ascii?Q?imyhwXw/RdSaMV5KM4ULY6wOwnejCxi0ge1mNSh1PJmq8dxr2Og3Jip3zFeF?=
 =?us-ascii?Q?GVsk5wOd8tFBgbhWBbTCrNMQxMAT+yiV+ulhtMaXu2CcJLfz+UAjDgyJBrua?=
 =?us-ascii?Q?EpVVJB88hfRDv286I53cA0Q+4hnx65MnmBvbFm3ussImWNa/Y8sYRcDlePyR?=
 =?us-ascii?Q?lC+TG4hJeZEXyyRJ09JZtyRo5gaX9TthDGRrEyZCF624L+ObXYSkYXEIh88r?=
 =?us-ascii?Q?Tjq8deAGvn9NVV0WuJAFbmdPbtc3JYc5IpbccI9v+mPgAcLwnq5ztvLlGKiO?=
 =?us-ascii?Q?YeIZyxRL0cUM8D/XFJfZqKMdloXi2XRD4JXvRsHS3sHya6uLJaFBSlYfHypV?=
 =?us-ascii?Q?VTQxpnqMIQH9Hme7y4Z7TJ772rDbv0Wq7f+cQBwo6Yuji9gM4Bw/YRfQMiyj?=
 =?us-ascii?Q?HzdoFE+o1ZTeR+eFfY4d5R578JVoRxrHQAf596KdYU6tPj7nCIMJUkYiJ2Hg?=
 =?us-ascii?Q?NsLqSoQ0d246GugPwdsLvzB4/TU4B5FKlpD3fa0fC9+lgGemxmIfxDTyasfh?=
 =?us-ascii?Q?izJ3GyeFLCi/dFRL3lRpFl0mu/rr0veIlEUoVstxtdqMd8MCmOKBOxc4Cp3+?=
 =?us-ascii?Q?kw47/w3a/89Mm/IbUZYX6zbdzjcausHL8Gj00va2Nx3vr4wcKHk+hAXbx1W7?=
 =?us-ascii?Q?LkyVO022cncZuiAVHNcwOl7MzpoGSdkxVgsKO6SFCf9HsFk/TqZEMJlPv/LT?=
 =?us-ascii?Q?4k8PqxdhRQD+nbip5Fa+MTLSPjPcDvpYXLozmfiHR+z78ObWOek3u/ztE6JE?=
 =?us-ascii?Q?2Arre/f9pV1ngw5b1WAym+yxZ7XjbfyUNafmGHKwm9MDka/e78PLGza+lfdu?=
 =?us-ascii?Q?6lIFk1g5L77qaVx7VfXnIg7qQmKbWTeMY/XIpqXeARJIovTG3l7bJnBSQ4mO?=
 =?us-ascii?Q?GPPlIkZHbA8j7flHV4miCy2qhn19YLxNIvzLAB625za6Tfrstv0nfPPzoVMZ?=
 =?us-ascii?Q?rc9xHYOXM2U7DZs4mamVNyjjQohbzIJ52Fh+PY9zCws+OAhtYTob064MK+/a?=
 =?us-ascii?Q?rPrxANqRj3IFeT48/JpQhi9Kbm15J+71hiTknxYbONySa9hu3kHtD7Pe7Anj?=
 =?us-ascii?Q?4DEPmLpOl4OjifHFWUQgv+1Xt14xZNB5pYzSinO3hSV1pyd8DJ2aRbOBmNXH?=
 =?us-ascii?Q?2A9LovUjijE2bpOtdC8drp4EEfjTIAw0eNfRLaib2DyoDow5/1sGhxQ29jXl?=
 =?us-ascii?Q?ReOOTf+iG8Z/R5uz06DR8Lld0F6nkLgbH6FcYeH/avqSle7BTRwLmQkMZIZa?=
 =?us-ascii?Q?LAFaVExwOcEU8AAR4hFkIZBPG1sDFt0Mdzs2Qbo/oIIjWiEvzdLkONzgeeSA?=
 =?us-ascii?Q?lfc1U+rH6XOckQZQ5ASEonvR9F36MhDVeJ/ZT3wSbnKGLv1t/q7SHVGkIw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:13.1607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd79054-fa67-4062-02ce-08dd78c36ef4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087

The vIOMMU object is designed to represent a slice of an IOMMU HW for its
virtualization features shared with or passed to user space (a VM mostly)
in a way of HW acceleration. This extended the HWPT-based design for more
advanced virtualization feature.

A vCMDQ introduced by this series as a part of the vIOMMU infrastructure
represents a HW supported queue/buffer for VM to use exclusively, e.g.
  - NVIDIA's virtual command queue
  - AMD vIOMMU's command buffer
either of which is an IOMMU HW feature to directly load and execute cache
invalidation commands issued by a guest kernel, to shoot down TLB entries
that HW cached for guest-owned stage-1 page table entries. This is a big
improvement since there is no VM Exit during an invalidation, compared to
the traditional invalidation pathway by trapping a guest-own invalidation
queue and forwarding those commands/requests to the host kernel that will
eventually fill a HW-owned queue to execute those commands.

Thus, a vCMDQ object, as an initial use case, is all about a guest-owned
HW command queue that VMM can allocate/configure depending on the request
from a guest kernel. Introduce a new IOMMUFD_OBJ_VCMDQ and its allocator
IOMMUFD_CMD_VCMDQ_ALLOC allowing VMM to forward the IOMMU-specific queue
info, such as queue base address, size, and etc.

Meanwhile, a guest-owned command queue needs the kernel (a command queue
driver) to control the queue by reading/writing its consumer and producer
indexes, which means the command queue HW allows the guest kernel to get
a direct R/W access to those registers. Introduce an mmap infrastructure
to the iommufd core so as to support pass through a piece of MMIO region
from the host physical address space to the guest physical address space.
The VMA info (vm_pgoff/size) used by an mmap must be pre-allocated during
the IOMMUFD_CMD_VCMDQ_ALLOC and given those info to the user space as an
output driver-data by the IOMMUFD_CMD_VCMDQ_ALLOC. So, this requires a
driver-specific user data support by a vIOMMU object.

As a real-world use case, this series implements a vCMDQ support to the
tegra241-cmdqv driver for the vCMDQ on NVIDIA Grace CPU. In another word,
this is also the Tegra CMDQV series Part-2 (user-space support), reworked
from Previous RFCv1:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_vcmdq-v1

Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_vcmdq-v1

Thanks
Nicolin

Nicolin Chen (16):
  iommu: Pass in a driver-level user data structure to viommu_alloc op
  iommufd/viommu: Allow driver-specific user data for a vIOMMU object
  iommu: Add iommu_copy_struct_to_user helper
  iommufd: Add iommufd_struct_destroy to revert iommufd_viommu_alloc
  iommufd/selftest: Support user_data in mock_viommu_alloc
  iommufd/selftest: Add covearge for viommu data
  iommufd/viommu: Add driver-allocated vDEVICE support
  iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and its related struct
  iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC ioctl
  iommufd: Add mmap interface
  iommufd/selftest: Add coverage for the new mmap interface
  Documentation: userspace-api: iommufd: Update vCMDQ
  iommu/tegra241-cmdqv: Use request_threaded_irq
  iommu/arm-smmu-v3: Add vsmmu_alloc impl op
  iommu/tegra241-cmdqv: Add user-space use support
  iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  24 +-
 drivers/iommu/iommufd/iommufd_private.h       |  20 +-
 drivers/iommu/iommufd/iommufd_test.h          |  17 +
 include/linux/iommu.h                         |  43 ++-
 include/linux/iommufd.h                       |  93 +++++
 include/uapi/linux/iommufd.h                  |  87 +++++
 tools/testing/selftests/iommu/iommufd_utils.h |  21 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  26 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 349 +++++++++++++++++-
 drivers/iommu/iommufd/driver.c                |  54 +++
 drivers/iommu/iommufd/main.c                  |  54 ++-
 drivers/iommu/iommufd/selftest.c              |  58 ++-
 drivers/iommu/iommufd/viommu.c                |  78 +++-
 tools/testing/selftests/iommu/iommufd.c       |  34 +-
 .../selftests/iommu/iommufd_fail_nth.c        |   5 +-
 Documentation/userspace-api/iommufd.rst       |  11 +
 16 files changed, 912 insertions(+), 62 deletions(-)

-- 
2.43.0


