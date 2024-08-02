Return-Path: <linux-kselftest+bounces-14741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31B49464FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9569C2814EA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA36BFD2;
	Fri,  2 Aug 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H6IqNMES"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17149658;
	Fri,  2 Aug 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633858; cv=fail; b=P8uiKsDwUGgT/rDgsA+QjYDljiDPJnpBKDSB4aUY/kHugeMsTbBIKEZ7jxbNomrnCHZ4YQGsL9mhnPXlso8uY1ZMv3FDJIvZH0lpLym71GAQ01O8ue67W7Tv3HN5vpXDbt1cjMz6/j400kTgIXuo0AtlsxS8A4m5tuyuHULdwoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633858; c=relaxed/simple;
	bh=F2+zpI359Nn51duoBDfuQS369GkNkqGWoyT7hPThwhI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hmAKwoAeRydpyT/f0yn/1lyjTLMItn0qKAkxcXHa1x+zHPjhnTTxll+HXlSE1JvcZPhmdPTs6tpTNb0QeneAlpKdgnW/Fkl+1G7EyoptR5N2y/k+/OKpydG1m8ZFC6cckEtlT+q1CtdBSTV4kANSO2YBtLEsK9qvj98yz8Ch0v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H6IqNMES; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXXBh9hjDFAO4mZNdXaaZzGa/mGGA9tfHiMUyTAYnoHTakaq63DaVbiNZ9EU5p9+mFcoL/hEcGqoODUtbyUaDA0hqK1hSXMsnPbNwfjnYy9Nzjzi1GljPH5KndenmRBR/hITLLKqom0A/IIlVDJ+ROLe1gxGhymgOrQWEq+8HAEmakyP923oVQ4XjmsA2XOnLMKhWvXGvuzpXpPqY4hcOmZ+VXCexvsDMFwB366WL3EAHzk9f4naqekbH+KbHuB0hOLpfBu4xGsuRGqg/LhBCkB0pb39qk7cjgVcRrsy/PZVHUrpviUdm2+MxaceHFLayoXc6jppE5tdD8KR0RczhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMaiPw17zw2a+L6QZ1aihZannvNM+ViH6sZ/89cuKDk=;
 b=fU2fQB5fPogYK+rKMrLuUYLuh2rz1aTfkEgv2zoryZTAzaqmSHqo0Zn1Mjy4EasfQy5TFDR/Ebm3IbogTQ11Swow83dTrTOddQPe55d818V23SBT1rTiOx/0XoGNXEa4AstRQddG9Eb3VxAOEgj62Jqw2+p1cplRp+bVVCHBIbMrr1J8en5NCwBdz0v+jB06diLr3rTZG5dM7WxjGduYNrl5QVUxugT4Ygv2+ISju8YQ/yni/khuBlZYwrAWe36O6Zt8Aj469kLMuxm4tXj4bvFddTUtCs0eO+1EHjEkh6ZozAyfoJcHv6qqRwPJjeKETzTc+/7mXwxnP2bRJ212ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMaiPw17zw2a+L6QZ1aihZannvNM+ViH6sZ/89cuKDk=;
 b=H6IqNMESb7zanyKio1LragkzC9QC6ivV7+Wzv4dLEyoYZ1a6z0e5ogN730tV8AkTRZw7WCT0ixWewkHcYXmsKTke0Um6TT6IPHU0Ca46CUsyBfbFt+iL5TX8B23dVieAcxaZCnzfiyLzZ2XqGQVcxu4wNvxf9BGQYjXs2TbUgdtZC/l5IIiiAn99RjaO8ouKdioPXr95BqPHpoBy2rdasyOJODkS5vN0JmnG1GXHpAlnkDoTHjb9QviXpfUlTxLXmfQvC+zTG/7H3StPG9SPkQz/kuJSmQ0dHPjzz8B4Mr4Id4sTJvrDRhLm0BgYFlWCTmll4iU/FI1dWlM7knHEtw==
Received: from BN9PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:fb::6)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 2 Aug
 2024 21:24:12 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::8b) by BN9PR03CA0031.outlook.office365.com
 (2603:10b6:408:fb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Fri, 2 Aug 2024 21:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 21:24:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:24:01 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:24:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 14:24:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH 0/3] iommufd: Add selftest coverage for reserved IOVAs
Date: Fri, 2 Aug 2024 14:23:45 -0700
Message-ID: <cover.1722633199.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 900f24a0-1364-44db-1805-08dcb33973d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v+G70+FB26eKxko2J6rfE1pp/iIkqLHNyuxa1o8Zow8sQk8TCr0aCIaBU0RZ?=
 =?us-ascii?Q?PHFTORKoRSbvbewGnnX6Tl0CVQemOIOKRiFblEEJR2oi6EZTGsCUp8sGuma0?=
 =?us-ascii?Q?cIIqdde2ozxDCphCVWlY0B4pwOeqtMOABJblokEvnN0BqKVIAxd6hUi6fZl8?=
 =?us-ascii?Q?v9zqvBgXTclDjyHgS+06UjUkqF7RPvs65hsHl8UhXX5ySoKL6SA96dkUL5pJ?=
 =?us-ascii?Q?1MkKw60uD8EFE8kw8gEe6eGXULVF7CZ/epSIhn4iI7EOF+pET6t9P44HLPFT?=
 =?us-ascii?Q?xDsE9Ys0uX3bFj11Efo9sb6HhSbj+b+FCiXLUufPa87mvjb040IuhruQEHun?=
 =?us-ascii?Q?7F6giCt87vd6WpYzGDAxP+alPdf+ouVchu3Ppdhj4GuNIFKqLhzyeKdpDmNI?=
 =?us-ascii?Q?iEqtUrbCD9SQfCebLYh1RWS9Slh7Z/MQ3MQThwamR4jhHbvlNwjBaV046ZaW?=
 =?us-ascii?Q?gO48qPtt+iiH+vIGfYP64JYJ1FiIsOi4NgwaSy/8MK5RniIsE1bxjbL8wFLm?=
 =?us-ascii?Q?mVQ+kof5lXlNlaqXexgRrW+PLs1vFjiObxq42JAWVfmHaLyBeiOepgbhi/46?=
 =?us-ascii?Q?aYPH+PEw9tvx0kpOxFK2rjPmIt2aCgsQJSB4QSvvYqaTj7DBo3IJBVpRuWfL?=
 =?us-ascii?Q?05k1GJKxhMZPWTnj9ahW7KdmjCWxvEhwpUfdIQ2oW0Ox0nnKR93qNdcPxF9+?=
 =?us-ascii?Q?JkwjHxL29qSLHG6r/ZiWOLphpEu8vrldkioAqfc8ooDAY8aIfHICtwkgoOYy?=
 =?us-ascii?Q?aS5h4JJInlDW5BnvBaxe1gafjz7EqNCFekmTOfb3uuRfhgLY+ZHR+NSvFr7S?=
 =?us-ascii?Q?AKwPiQUTD/gK45IRrYcBCTPX3yIBVNCxyucuqKRqSNXt/pLGy+MLvgoe51o2?=
 =?us-ascii?Q?T7y5Zd9/pVojUsMVuLe/J3eV+Yt17I/x+vLvD5e3PPEi1yhhRY9soQe3sbh1?=
 =?us-ascii?Q?eXP3HOyvwk/G0DBa695ljm1u3x8JQ9OPkB0B9uLU/yT8nTlw3QDbn/DZ6uuu?=
 =?us-ascii?Q?s++RbXQw2VUAAdI0cTPwu2/JOyGlxxRPT/q/kEJo39sbAP2y0W13IQGru43s?=
 =?us-ascii?Q?OxALVrceslKkg9ALOrZ/bCEotSkGNrmjYRR2MyQHGZSTKp7O5QQ8qU45fsmn?=
 =?us-ascii?Q?JLCe2zraeewswR6u6zDK/b/6DoyUVfd4ZVdRDnH58Ec9TQUnkwdVoItYQH1r?=
 =?us-ascii?Q?gbSVqJ+YgXoUSXpJGU243PKrHEvm00bgde5b4c5Jgg1zwskJGfElkITOLj4P?=
 =?us-ascii?Q?sos131h5gjZohjqOQwBcSB2SjPm/BygKrPsGw7jS3vdBTtI1uRSp+SQ3hBot?=
 =?us-ascii?Q?V80Xeku1OtZzPqWsZKJznKod725g4zn+QYe+wbv5eUc8eC3RbCPzWAaExXf5?=
 =?us-ascii?Q?H1Hax6haOhYyvB5zcB9QQ9lEna4wrAG/ofIT0B2yrMbyvjww+Wsu+fm9/HG6?=
 =?us-ascii?Q?vK2yPKOKZsh9ovHzMvcWu7TnZRpNUDu/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 21:24:11.6411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f24a0-1364-44db-1805-08dcb33973d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

This adds a small series to cover the reserved-IOVA change:
https://lore.kernel.org/all/20240802053458.2754673-1-nicolinc@nvidia.com/

PATCH-1 is an optional cleanup. PATCH-2 is an essential infrastructure
for PATCH-3 to verify the loopback for IOMMU_RESV_SW_MSI.

You can find this series applied on the other two earlier patches here:
https://github.com/nicolinc/iommufd/commits/iommufd_selftest_sw_msi/

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
 drivers/iommu/iommufd/pages.c                 | 10 +--
 drivers/iommu/iommufd/selftest.c              | 86 ++++++++++++++++++-
 include/linux/iommu.h                         |  4 +
 include/linux/iommufd.h                       |  4 +-
 include/uapi/linux/iommufd.h                  |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  9 ++
 16 files changed, 144 insertions(+), 34 deletions(-)

-- 
2.43.0


