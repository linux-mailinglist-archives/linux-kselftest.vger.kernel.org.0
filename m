Return-Path: <linux-kselftest+bounces-19364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A229971E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE44A1F24D7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E238489;
	Wed,  9 Oct 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TIH+/Erm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919B1A2C21;
	Wed,  9 Oct 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491944; cv=fail; b=bP4+nFLFNDfL5NZICr1BzoKgWNzYkc5ViVNWBA3pI4D5fYRGw5SRLo5T2m1JG7sMc7Y4wnF4Uz120jrFcAJglvICo5qOsjVVa2HRnsqEHE3IuIhjxvjcCoWuHzAK/GC3/phiVs/YTW25jXBmSzj1NJUZz0Xj8M2rrRAu9jsrx64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491944; c=relaxed/simple;
	bh=SXPXRsx2MSV5rE9SgSXfTfuHKCi5Qd65TR9g0K4CW20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPHDWh2lZjH/IYBc9EHGliI9YxzmhFeFtf2YvmnU7+/iLnxa9VTAVEdeMIhAf037mkXf7YiAJ+3Mcb+VqqX7MVw6haWD2R3ZU0vF8+YrGvrp80CnIzvJYYVBmBiGAEdPh0Awrg9/EwVGRa6jaTgUUa7J4ZtC6d0F1+xV4jiiKMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TIH+/Erm; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMTFRMEc/f4mLBNo582+hz+vI5d7mXOfIOadkkXzjdWLp8vRRThlhj0GGRXaxdDhoZaAXn/DB4cMlLTLJJl0bWPAAqJmoATIIsY9z1EVJ+zZwbaQGVROTxe10VdIg/WPGjQIJ4QVHfoXJq2v7qBnTzh1vFiNxthlvT1/IIex+XunVbZy0xzykW0AuaeL29wUXmo/38ImY9VKBYqCRZyXXwYc0GEhCv0tbx0hy1EC3TTjzYHzMGKh+dDPegqSgQhrNmqnLgzAFft4Su9XIQnvzjkNFjTISIk2sqjkmigJ2xbC8/nL0EUF177SRfh3io9RdNR4B+IGmb1zA7nhls2gGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsHM+y5yHrmE68dMy9y1tTeFHHLQwjAH/JnKO2adIhM=;
 b=NfXz4xJR4c6/DiOS+XzSBOy3lquV+2v8OU9X2sOuXvsIi3/48ZvZTyiR5LIjSP7C18VVSfVvrYRE0mcNYAVzACQf8rb612787ogSo1lgMPHRyNLUNUa+mgtRiXof9Q8E9kZHYCXSoxlczKWfeAprNKn1SHt6RSuKVxW0bDrYsvLbhW/Fv0YFjCoX3qLBQIcdp+Cx4V97nK9eTHkphEf2h8hUzs1L8gkLQu4bmSK0QeoTiGQd9nOQEOdxc+DS3L/t3C/UouQM8L7jhXpXaL8laWa89suHgozxlJ2iVXqfioqFqwTNJkOOXUTS7AEJewzvmag/GUHEAVKAYqXGEwnRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsHM+y5yHrmE68dMy9y1tTeFHHLQwjAH/JnKO2adIhM=;
 b=TIH+/ErmsKGekUcy/NG1AWb7FtzY9LGYQy5tKP3oxqU8Wq6Slrev+QVoPHC8BjE4SSmI4l9p4ZMw/7pyWat6QLg/dNRAkteB4zqRmI6jql1tta36l4dBJgE1BXFjQPWIv7s8tpvg0GQhgNJw4tSSxxhW2CFgdsSPPtWIutMt2zoCnAs4x7NJ9tgD8GtpvcqrPYFU3WGQIP6gJOdUbsKlRBxufpVbcLsnVseGe2Oa0p8e+I4PntAygc3/evlDd4U8PvmRsV1HbkeHLrKuEw4RSpj8+zAu8sNwVnYQgfrHqXEOBETuuT0jyQyFaIyHnwdiqajUjDKfio7Uxbpr1hbYnQ==
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Wed, 9 Oct
 2024 16:38:51 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::60) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
Date: Wed, 9 Oct 2024 09:38:03 -0700
Message-ID: <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 481e04e9-6b95-4ab1-f98a-08dce880db73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OaDlFuN84Yojg8zyjibnICVUcvA+UEpNHztKl8TIBTNlO6eUewBiYsfwVwZ/?=
 =?us-ascii?Q?YP9cqFA6na8irFjJlp7I6PDqcBk5w/GIiGjpEs9QeTKXs8b77AS5EXsufn3Z?=
 =?us-ascii?Q?5G0Nik5YSqi9dNbBH5BEuAatBl3AjAhtsWLuAIjXBiBsppXq7LWaBIAjf9p5?=
 =?us-ascii?Q?BrjWZrRzuYnH7OfIcuf7E7k2Mf73fdvrlTeu0F/ElwDowri0DkaCmgwO2lwI?=
 =?us-ascii?Q?NNL546MdwuTsgK4jhlpomr/M+B026G8R8beR6sTWxlMIhLZO4qpN1BUNmiLr?=
 =?us-ascii?Q?wybf+U3NBNTmo1zespjbsxdkUONa+PDk+R4reC5nr2ypCpI1/HUjcfKA0Krj?=
 =?us-ascii?Q?jePtUKG3L+2Z87eodFubyRN6VLNx28BKd31pBChySHJO0hYjIEPqDaSYrFui?=
 =?us-ascii?Q?uGg+qPgpeiZXvS0FZzvM+I1+Mbztne+Hz3U8fvqxrgiJVBosS8h2qH27yBnD?=
 =?us-ascii?Q?g/ZYyVeSSOY1nv/CRfdrnQT5wu/FD43oaS9sIdI5GmZW+J6h4PvxUUfp3v0q?=
 =?us-ascii?Q?f0iJj90FQvmFzcT2mNh6MU+BGjnYp5poQfKlorLJlNJTbFXWlk50eJofXy+Y?=
 =?us-ascii?Q?GHCc3Az2PqnQfeMX4FQrWS2Lj3Lxa3dho1asRVAidWUqA/Hv/i6sdRmvlkPK?=
 =?us-ascii?Q?xg5538ArlFriJzpguhvt8oS1XlVwpPjWJU73lq2JwNykVBJQMfED56zqoSUM?=
 =?us-ascii?Q?s4ERxCKnTdnHCdKcyk82hPms1bs8I/2rRZ8md9ukhN6ty9FRu7FBmltVUrz+?=
 =?us-ascii?Q?12bSW81WptrSNThywFOnZE6Q8EwnyqhJmD4hgybJN7SjCRIpR8s3uosiN9DX?=
 =?us-ascii?Q?bbp5H8BsfMJlWJA+G1bb/6u7H2yU96lh6c50nc3I8QTeDlx1Jwcae/JAY0hO?=
 =?us-ascii?Q?W0cEouxrEJkHb35UvbdIp0Zz8Gdnny+LlUWmrxrIIirRSXpAcVrD53nsfnjP?=
 =?us-ascii?Q?R5ch0uvwa+X1+qD9wr4b5jzwfl6t02lennONsaItjntWi6uB1rm/7YOg9BB/?=
 =?us-ascii?Q?7AAjwNrFRkhOt7OlPycsL5VbyZw7icgGgsnUuU27xiyTg8gG6hFjMi1yd3Bo?=
 =?us-ascii?Q?ugsgZBBB7xtZmTm9bS3REih4smWZNrDR+amDOscD/jNcPS08fT0vhZTWvSWk?=
 =?us-ascii?Q?kcG7+2uTEYqW/KpblrxOTQn2yBaaO70lJcquyBfibAUUlaRRCM7OieKrdePV?=
 =?us-ascii?Q?+EvOZQYdtW8Tro92NUQoTuWC4G0lAk5towGx/lUiVdOQ/a3vV8vMu/UKZgp0?=
 =?us-ascii?Q?4kOvmiGbAYNTxEdiPVCIlagMvB8HUqI8cPiYqVmJf4V5ymcMBS+XEZ4ZoF8u?=
 =?us-ascii?Q?44L1/Uq0HiNuJAbdgtkpqd3fZxvlsy+7B0+DToyMoGBmgchSEVqspGZORmtH?=
 =?us-ascii?Q?xX6hOM8m5L0n+oowY1v3XIqbtXZn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:51.3630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481e04e9-6b95-4ab1-f98a-08dce880db73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

Add a new IOMMUFD_OBJ_VIOMMU with an iommufd_viommu structure to represent
a slice of physical IOMMU device passed to or shared with a user space VM.
This slice, now a vIOMMU object, is a group of virtualization resources of
a physical IOMMU's, such as:
 - Security namespace for guest owned ID, e.g. guest-controlled cache tags
 - Access to a sharable nesting parent pagetable across physical IOMMUs
 - Virtualization of various platforms IDs, e.g. RIDs and others
 - Delivery of paravirtualized invalidation
 - Direct assigned invalidation queues
 - Direct assigned interrupts
 - Non-affiliated event reporting

Add a new viommu_alloc op in iommu_ops, for drivers to allocate their own
vIOMMU structures. And this allocation also needs a free(), so add struct
iommufd_viommu_ops.

To simplify a vIOMMU allocation, provide a iommufd_viommu_alloc() helper.
It's suggested that a driver should embed a core-level viommu structure in
its driver-level viommu struct and call the iommufd_viommu_alloc() helper,
meanwhile the driver can also implement a viommu ops:
    struct my_driver_viommu {
        struct iommufd_viommu core;
        /* driver-owned properties/features */
        ....
    };

    static const struct iommufd_viommu_ops my_driver_viommu_ops = {
        .free = my_driver_viommu_free,
        /* future ops for virtualization features */
        ....
    };

    static struct iommufd_viommu my_driver_viommu_alloc(...)
    {
        struct my_driver_viommu *my_viommu =
                iommufd_viommu_alloc(ictx, my_driver_viommu, core,
                                     my_driver_viommu_ops);
        /* Init my_viommu and related HW feature */
        ....
        return &my_viommu->core;
    }

    static struct iommu_domain_ops my_driver_domain_ops = {
        ....
        .viommu_alloc = my_driver_viommu_alloc,
    };

To make the Kernel config work between a driver and the iommufd core, put
the for-driver allocation helpers into a new viommu_api file building with
CONFIG_IOMMUFD_DRIVER.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  2 +-
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/linux/iommu.h                   | 14 ++++++
 include/linux/iommufd.h                 | 43 +++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 32 --------------
 drivers/iommu/iommufd/viommu_api.c      | 57 +++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 33 deletions(-)
 create mode 100644 drivers/iommu/iommufd/viommu_api.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cf4605962bea..93daedd7e5c8 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -12,4 +12,4 @@ iommufd-y := \
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
-obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
+obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o viommu_api.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f2f3a906eac9..6a364073f699 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -131,6 +131,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
+	IOMMUFD_OBJ_VIOMMU,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c8d18f5f644e..3a50f57b0861 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,8 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
+struct iommufd_ctx;
+struct iommufd_viommu;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -542,6 +544,13 @@ static inline int __iommu_copy_struct_from_user_array(
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @viommu_alloc: Allocate an iommufd_viommu on an @iommu_dev as the group of
+ *                virtualization resources shared/passed to user space IOMMU
+ *                instance. Associate it with a nesting parent @domain. The
+ *                @viommu_type must be defined in include/uapi/linux/iommufd.h
+ *                It is suggested to call iommufd_viommu_alloc() helper for
+ *                a bundled allocation of the core and the driver structures,
+ *                using the given @ictx pointer.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
@@ -591,6 +600,11 @@ struct iommu_ops {
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
 				 struct iommu_domain *domain);
 
+	struct iommufd_viommu *(*viommu_alloc)(struct iommu_device *iommu_dev,
+					       struct iommu_domain *domain,
+					       struct iommufd_ctx *ictx,
+					       unsigned int viommu_type);
+
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6b9d46981870..069a38999cdd 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -17,6 +17,7 @@ struct iommu_group;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
+struct iommufd_viommu_ops;
 struct page;
 
 /* Base struct for all objects with a userspace ID handle. */
@@ -63,6 +64,26 @@ void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommu_device *iommu_dev;
+	struct iommufd_hwpt_paging *hwpt;
+
+	const struct iommufd_viommu_ops *ops;
+
+	unsigned int type;
+};
+
+/**
+ * struct iommufd_viommu_ops - vIOMMU specific operations
+ * @free: Free all driver-specific parts of an iommufd_viommu. The memory of the
+ *        vIOMMU will be free-ed by iommufd core after calling this free op.
+ */
+struct iommufd_viommu_ops {
+	void (*free)(struct iommufd_viommu *viommu);
+};
+
 #if IS_ENABLED(CONFIG_IOMMUFD)
 struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
 struct iommufd_ctx *iommufd_ctx_from_fd(int fd);
@@ -79,6 +100,9 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+struct iommufd_viommu *
+__iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
+		       const struct iommufd_viommu_ops *ops);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -119,5 +143,24 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline struct iommufd_viommu *
+__iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
+		       const struct iommufd_viommu_ops *ops)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_IOMMUFD */
+
+/*
+ * Helpers for IOMMU driver to allocate driver structures that will be freed by
+ * the iommufd core. Yet, a driver is responsible for its own struct cleanup.
+ */
+#define iommufd_viommu_alloc(ictx, drv_struct, member, ops)                    \
+	container_of(__iommufd_viommu_alloc(ictx,                              \
+					    sizeof(struct drv_struct) +        \
+					    BUILD_BUG_ON_ZERO(offsetof(        \
+						struct drv_struct, member)),   \
+					    ops),                              \
+		     struct drv_struct, member)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 28e1ef5666e9..92bd075108e5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -29,38 +29,6 @@ struct iommufd_object_ops {
 static const struct iommufd_object_ops iommufd_object_ops[];
 static struct miscdevice vfio_misc_dev;
 
-struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
-						size_t size,
-						enum iommufd_object_type type)
-{
-	struct iommufd_object *obj;
-	int rc;
-
-	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
-	if (!obj)
-		return ERR_PTR(-ENOMEM);
-	obj->type = type;
-	/* Starts out bias'd by 1 until it is removed from the xarray */
-	refcount_set(&obj->shortterm_users, 1);
-	refcount_set(&obj->users, 1);
-
-	/*
-	 * Reserve an ID in the xarray but do not publish the pointer yet since
-	 * the caller hasn't initialized it yet. Once the pointer is published
-	 * in the xarray and visible to other threads we can't reliably destroy
-	 * it anymore, so the caller must complete all errorable operations
-	 * before calling iommufd_object_finalize().
-	 */
-	rc = xa_alloc(&ictx->objects, &obj->id, XA_ZERO_ENTRY,
-		      xa_limit_31b, GFP_KERNEL_ACCOUNT);
-	if (rc)
-		goto out_free;
-	return obj;
-out_free:
-	kfree(obj);
-	return ERR_PTR(rc);
-}
-
 /*
  * Allow concurrent access to the object.
  *
diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
new file mode 100644
index 000000000000..c1731f080d6b
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu_api.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include "iommufd_private.h"
+
+struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
+						size_t size,
+						enum iommufd_object_type type)
+{
+	struct iommufd_object *obj;
+	int rc;
+
+	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+	obj->type = type;
+	/* Starts out bias'd by 1 until it is removed from the xarray */
+	refcount_set(&obj->shortterm_users, 1);
+	refcount_set(&obj->users, 1);
+
+	/*
+	 * Reserve an ID in the xarray but do not publish the pointer yet since
+	 * the caller hasn't initialized it yet. Once the pointer is published
+	 * in the xarray and visible to other threads we can't reliably destroy
+	 * it anymore, so the caller must complete all errorable operations
+	 * before calling iommufd_object_finalize().
+	 */
+	rc = xa_alloc(&ictx->objects, &obj->id, XA_ZERO_ENTRY,
+		      xa_limit_31b, GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_free;
+	return obj;
+out_free:
+	kfree(obj);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_object_alloc_elm, IOMMUFD);
+
+struct iommufd_viommu *
+__iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
+		       const struct iommufd_viommu_ops *ops)
+{
+	struct iommufd_viommu *viommu;
+	struct iommufd_object *obj;
+
+	if (WARN_ON(size < sizeof(*viommu)))
+		return ERR_PTR(-EINVAL);
+	obj = iommufd_object_alloc_elm(ictx, size, IOMMUFD_OBJ_VIOMMU);
+	if (IS_ERR(obj))
+		return ERR_CAST(obj);
+	viommu = container_of(obj, struct iommufd_viommu, obj);
+	if (ops)
+		viommu->ops = ops;
+	return viommu;
+}
+EXPORT_SYMBOL_NS_GPL(__iommufd_viommu_alloc, IOMMUFD);
-- 
2.43.0


