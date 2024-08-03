Return-Path: <linux-kselftest+bounces-14754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5DB94667D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 02:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D421F21D41
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 00:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680179D1;
	Sat,  3 Aug 2024 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EMjZ1XJ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7EF5C99;
	Sat,  3 Aug 2024 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645153; cv=fail; b=kJBUc3DClkVqt+GsvZuxxdmxotueP/cmd+1RsChPqMntFakCd2/IMNjVpKS/xxUoGHz5TmvHcGMk6i6NTu8HAERDskVpK/kV4AVSXgJU/jgEn7dYXLd7LK+68BRPtVXQgZ8XMJRKJLPh/RZV/voRcdBypAM1kfD4qBta7h3ZNYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645153; c=relaxed/simple;
	bh=6+XReBlopmj6QsSx+6ozqKsbJaADascqQHGu+FI+RnA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rmxYl24YGldf3G9Sd5oJCTp0dOAgrm+uB3usrBf5t+CuBmC3iy65t5r5oA+ahwzvnZfVZ1gEyBrmX/fE17/jqbaUc3qZKIw+c/m/N6XEuU6GK2p2OEg5ncmSB9MP+1lkCsdQrCU4Ahb8fr+WJEqSRAyrkAOhkgB/2x3qfWPe1Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EMjZ1XJ8; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIrl3KVKKxmw0G8/aZFNxBrSaYP9raEaKFATxMco37/zzNQn21lVU/5eHGw6d1DlwJ5t7iDzl5I+XPT1dDVC9u0S1LkPCyd67IZjddpeS0NU+fTSld6OtYcUPVLBTdWnNtN0pC0wCZjAhgW1BAqk7cY+XCjuQh+mVr0XalByTKDKydSaA1YUNvfNTodtIBLXzdP8u4p2u5v8X5VC5+V3PKijJf8xjJTEicc4lEaUr5qvatdmqHgdT4BUVswcA5MzgrE2byz4+Z0p/wFVcgPA8w2RPTMS4wbVK233pdDLe9L/Sc3piZEmIhzYY6UpCltL0aL74WWyQ1n9ZbSh/R5S+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcAWs2GQrL3sP95cCqd3fTKRCr+EPdcw8q+YAhZor8M=;
 b=FUivpaMz2icmQejdB2zvIDXV4ndef7+G0V+Bkakg9BIi22SQAjswPqr17ENz8uWf1Z1iVcfKyLLg7UNGkon2rwShgfL61hLBV8f8ZYfsM8+eSsIeXdU+j10o8wc/9Z7/2TJLyApSkFsUndwR8I7RVLFuHqPMDaJ+gd/Pb1Yu9Q2Z2arV6+JCWwuSXD6HuJsFfHmJCNwBazSd9IqF3Z2/GeuQVQr7+cRZ9HJbeeiAweg4UwK6/MZjMT31/4aZUMQ4+G/k8l7KqBAb90+O/IKIHmew5Cmyi3ijyGWwdeoqL1RWRXgWMzyT9aVLmMezByj+xPz8MXFnj7KJbbyEK5e32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcAWs2GQrL3sP95cCqd3fTKRCr+EPdcw8q+YAhZor8M=;
 b=EMjZ1XJ8GZBlxj0bPBQ95MT4znpes67ZRdowjYHb0BJntwZ1xibzu+7UWVOXkshOR3Ddem3UT+3dgrLfqdeJXd0JKD5dYF69RnTyRquDMc0i//vFOxc50wB8kE/YvkC7g8sqifI39tZJb+m4illhYOmVeXPyCbP2yuk6+CskySvrkRFa+Td4oGdi98VKM8UTKRJFr/Um37kBXlLS5VfO/cQwITVUl/rvWtJyXDF7FbZ4gJ1bez7v/xh7VJGT7GeM2qVua28JywbsftET2cABRIdRqvQ8BpaTNbYYYza99LbM7mOpQAjTcteIRz9pSqe1HRdaAj7o+xtu8BqrDzIkZw==
Received: from BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sat, 3 Aug
 2024 00:32:27 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::34) by BL0PR02CA0003.outlook.office365.com
 (2603:10b6:207:3c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Sat, 3 Aug 2024 00:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Sat, 3 Aug 2024 00:32:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 17:32:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 17:32:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 17:32:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 0/3] iommufd: Add selftest coverage for reserved IOVAs
Date: Fri, 2 Aug 2024 17:32:01 -0700
Message-ID: <cover.1722644866.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bcf61a-1a86-48bc-bffd-08dcb353c000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z57mHHgU1Nx6lgAt5ls2yj1/Uk+qKQu1pbhdTShLUndhZgmprzuIm8CIlOPN?=
 =?us-ascii?Q?9iIUrCZWMHx6TRNlrwLqKjHxC2LXICeY4L3Mms64yJ2fRISUaFT6Xt4+UHte?=
 =?us-ascii?Q?bCl0e+hDsZTYPsGXXJ53wK6RqBCdOT6xviptHoG4Jrl3fctzxQd+cBt70eCW?=
 =?us-ascii?Q?YXiTuwH7yed0uPNiQ4C0cUqnDqWloY/nu5cIyrTSZKNMBgrTWFeXF1jqJMh1?=
 =?us-ascii?Q?XeVpMV/ADmdHqO69srqXGSM1Eycm8MtZRgNbCSZC7TyZXeZV4NBmVoDz9vfL?=
 =?us-ascii?Q?3NMH6PrOtiGy3vJNat7s5ztY5yPF5y3f0HifZPlroDlkQK0ERI2C5do9Ny3U?=
 =?us-ascii?Q?FuXltvAIrrizixb6FlKT81hvq2zWayRDp+Dlif1V4hVol8d7WCoHXb3FzyMJ?=
 =?us-ascii?Q?Se34fdKqrtCvRIJGE9D/UJiB6kKtgpkNkKHXwrlOSNc9iyiyNdf3gogvQ9Ee?=
 =?us-ascii?Q?vqXOHPukXNCljrRY70ahOMyTd1KdwgVf0BrkOMMnC2tIVawxdXs/ofLk6b/X?=
 =?us-ascii?Q?Ixg0Un1htfvo7XjP4kBdjTXaCQKTUjPP7tI9YeMxAX4xZTf8XWGSD/5xmBFP?=
 =?us-ascii?Q?Za3q8dhFogsRnhT+eA0dxrOdrceZiB86QmReyMOZuKYUAK4uv8oPjlueRO1W?=
 =?us-ascii?Q?+daqW64K7jbK3f0MUa9Mgw/v/u3XxwWfQke1ZxiTSL5p0KjipwsTiTsUo7Ty?=
 =?us-ascii?Q?veMzhMGfmNhMI95YeoSbut0CHD++8/NH/7trB12U+JkCDHlIMQogSNhSYQ5e?=
 =?us-ascii?Q?ODnNzrRHIMV1Z1ctbdJX2D58FBUeCPjf63kUqdFLVCGC7Hx2cHRpqIqtfvps?=
 =?us-ascii?Q?xq163lJ424pDu3FvMKyhmF3rKRxqjsc3P1t0p3zCts7NYucdVnFlKneHfswt?=
 =?us-ascii?Q?knN3HkhmAoFE5ZgQxo7+jkVsF1PlM1x501j4XgBbKmHfHfyOZ90RmZgjz2UJ?=
 =?us-ascii?Q?NeT7dx0q7BxBk1L2oFROQkqYGLzBY6pQsQBzrmIXGjMBjiP997cTGKM0kbr4?=
 =?us-ascii?Q?9Za6p6lRRFwdgXwoVRIThVK2ut0D3AgELghH2brgCpvz2RQDpVrBfpEMQNEy?=
 =?us-ascii?Q?gFei3WWftWDUK01mlByspYZcj8f+lyLxBLG2cqIN6v+1ZtES4dXTF4d+Vwb2?=
 =?us-ascii?Q?MUelVyc4yOHI1zmXIFBodFrOhpCs7qR697MY29N11UX6YJBWOwtFEWxJtP76?=
 =?us-ascii?Q?XkGfWdRv0zG6A9CEfs80JH74NAfrSC5oUebLdDrRopSS+f1wivilkV9hdtfI?=
 =?us-ascii?Q?XYp53gdRyIaX/A5IJ03zxur+N8UsSrkwOeZupSy1SgLPoVtW5BkscoGNmtGS?=
 =?us-ascii?Q?mEqBAC8FKEsscQ1Mwgu0Ian0wpphhWvqtpa3myjdlnSxpQ8minY3NMm/A6Uy?=
 =?us-ascii?Q?gDKxUOaDFEciiiWf9cuzNMWDR2X+9z3Nvl8ydTf7IqRaCngPu3/hQmwuhdRw?=
 =?us-ascii?Q?QfvX5Ygub7xwQ9SIWB/xMK0hMQOGYjQk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 00:32:26.3137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bcf61a-1a86-48bc-bffd-08dcb353c000
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

PATCH-1 is an optional cleanup. PATCH-2 is an essential infrastructure
for PATCH-3 to verify the loopback for IOMMU_RESV_SW_MSI.

You can find this series applied on the other two earlier patches here:
https://github.com/nicolinc/iommufd/commits/iommufd_selftest_sw_msi/

[changelog]
v2:
 * Resent with a proper bug fix.

Thanks
Nicolin

Nicolin Chen (2):
  iommufd: Reorder include files
  iommufd/selftest: Add coverage for reserved IOVAs

Robin Murphy (1):
  iommu/dma: Support MSIs through nested domains

 drivers/iommu/dma-iommu.c                     | 18 +++-
 drivers/iommu/iommufd/device.c                |  4 +-
 drivers/iommu/iommufd/fault.c                 |  4 +-
 drivers/iommu/iommufd/io_pagetable.c          |  8 +-
 drivers/iommu/iommufd/io_pagetable.h          |  2 +-
 drivers/iommu/iommufd/ioas.c                  |  2 +-
 drivers/iommu/iommufd/iommufd_private.h       |  9 +-
 drivers/iommu/iommufd/iommufd_test.h          |  6 +-
 drivers/iommu/iommufd/iova_bitmap.c           |  2 +-
 drivers/iommu/iommufd/main.c                  |  8 +-
 drivers/iommu/iommufd/pages.c                 | 10 +-
 drivers/iommu/iommufd/selftest.c              | 92 ++++++++++++++++++-
 include/linux/iommu.h                         |  4 +
 include/linux/iommufd.h                       |  4 +-
 include/uapi/linux/iommufd.h                  |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  9 ++
 16 files changed, 150 insertions(+), 34 deletions(-)

-- 
2.43.0


