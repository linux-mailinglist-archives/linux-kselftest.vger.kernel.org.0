Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48586DE137
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDKQnf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDKQnd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BC527A;
        Tue, 11 Apr 2023 09:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvNvJ5Sgs4u5geT0fX19WyPHiDqYHqNCMnOuH8dMM3O9yAnZtaM3OVdStuyhal1W8zmKhmiBIq8O9VqT77IqA2PWjSClrM3PDpSHRn56R/pNh+RMyEpUwBhJRgEkrBkfm23sMZMZX7l1ykYd0tF/Uwy+6eC6Juy74lo8GZ261N8PRay32uHFtXXTuGvcW+z6fWut4K2+n/TawqcY8Ch/1zVf+DWezWr7JtwT47mZEw5wNaqIjE/i2zuczl6U/WYGo9J+yYy8/iJ9WGOiP+8FN66Gf+LtpsgsgwOY6ZYZhQE7akyuWvHDaHhUHGh+qDZ95uHN8BsYXkgTNK1ioiOyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKMU0vR/J+JJk06Oju6VPCk8ixOBR44n/ZgfU9EoO0U=;
 b=SsQEhCY6mPa961tBbzfzFPCDVehSe/nLgoRrj78pXtxK2Z+O1EJEDIdBoLXGwy1ZXRhBjhpU2u+lVw+LMHy9/VNQQv2Vdlsz2BMQk3KdTHqW5X16myWXAv/sUB6wKcmEPnlQMedpsl7biId6LHS1BuOb7ZeRCnHvqdUpmwOn36H8jAbq5NP8oEPN9SrlnCv5bbut55XJ69gNEihNhoPVBAi5n5Fov3wzGwtpygbPHB/vWR8Y0UB16eRd+6UOfyy6rOoMtSVNTcvkqsxJfQO5+dpZ60ANw4iP3Gy/Dff/aeIVIvmvRWALuc/BdoSr++7WJA4mmPX94sdPhppIG/P69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKMU0vR/J+JJk06Oju6VPCk8ixOBR44n/ZgfU9EoO0U=;
 b=NKsL7IUghyh4hQ1BL9A/gwA1YF3C9/CsMSuhxamCxnBE7TGw+wRRbrcSNV2yLbFcu1W0iQnuPAU4EU87F7G8cde4iporbW4sV7ouT4SeYIT7gYSIJ16Efyk1OzvmHlcIe5MEpSchRRjuQQ2FwiwJYgSdeyhrNZls8aU45tw0rgx04ib6kOTB2wojMGC2F3u0HU7ehlTf8voeCJ/Tms/2KYSWaq4Xgg1j+aZ30nT713OObuDoI7wVW8mdcgGkbXADrnF2SRnwkvUVfzYt8GXMy/xZBGms9UmZsI2h92qKn+wgSUQ+gOSx7iZeGw28eZ7w11+/vWzMjShIaol/cPZ5lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 16:43:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:26 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 05/17] iommufd: Keep track of each device's reserved regions instead of groups
Date:   Tue, 11 Apr 2023 13:43:06 -0300
Message-Id: <5-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd7240d-fa09-4bf4-c53e-08db3aabde8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PX8nHCM6kQfWy7g8y1/ncB1SI6/HlXotH/251E0idHCDkvWuH4mWcCQnONuPykacCMDOOnKzfOda9d5Ftr3CBn4+NWrbavoPbWqyBiX5SxQCLAWPm3yTfFs932quuZfNzYuRfE960YfSx6QTpySsqKL4oe+UAMHAiv2cxBkajK1yCWGkY9xPPY+OZIWmKrno6kpbfgsGLiDrKPVbpgPX4+ihfB7DiB5vypkBKYAWIoUTOmFm8c6FPSekicE2y4e/EsbgOVhK8wYOhh9+CapX90lMmSw89kSCjcCPqa7Jw/wVBF65QcsX7CkoPP0xuQ5T1Xl7QPo/i+z8qiUSHw3e9xtc2Nliq3etf7XluoVZpwWvUquhhWiP8zs8oL+pjZUmylI5zfBXwwB3D6QXP4FZ23QK1tE3EGa7b2cjU9Y0nDjmcNyCJxLr/DHK4l6PmqI+YolU7alYAGv+pd/euXfR82+B007Xrvb/fg22wELoaAYj8+gXLhnR08AH3RAvf2SlflgMaIfKXxg0lLqDTe9UmR0uMF3dzuhANXmTUVJWtsrBtpXInUf+vL3d5fp3insymnKo4UM3yK+rwSuCBOx4iKUTzxHzE1wBbxt/3l6pufY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(478600001)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6666004)(66476007)(6486002)(41300700001)(8936002)(66556008)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(66899021)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W7mFRUDdNSJmvCPOpnEKM6Z/OMuIYKYkZriHzPk07uVdNxK+GfjVjolVfX/A?=
 =?us-ascii?Q?MVHrseNq1iRSucAKCYIVmw2diYUakFsZTcXG80iKvi37cOL5Xr2EEeZf3npn?=
 =?us-ascii?Q?+j9ydh93LPW1GomaAO504QMINL7wOtSyiUQCxmU6/QIus7ubV1B8ugtWLk0X?=
 =?us-ascii?Q?n/1Teuz1vHOl89gV+eDxLD8+FrEx2gfgqYZe5QGdhR19MNXZ+e3U2UpgvqDn?=
 =?us-ascii?Q?ET5X4oxVwOLbOWXM/+YERkdH7C393aNThHt1g1OM1c6kdMCZG2mBaG36sXKh?=
 =?us-ascii?Q?dXF/5QViytxbvVCQKKhhRsYJWKqbH+LmJu2tFAnnhDakspLEP+kDksnv5y3t?=
 =?us-ascii?Q?sT/NxR8wqFQwHvkf+9wUV9qLBIS83VKbuhjG5Vrw9DRA5xbJ2lsu5vhG9efm?=
 =?us-ascii?Q?/VtW4bAEj1YoaX3ll9jviVDZ+9OSi2R9XOlnL0BVERmk8ERANmsXc64Pwtph?=
 =?us-ascii?Q?RAvMPk0uGLDHUnFH/nOdFLwo9SrrMCyVZuHCZUFBfoh8IipGYgnOialWqIAc?=
 =?us-ascii?Q?3wvfAzhdi+EtNVcdXiBeJvtihepwG1lCGfPMxMqZqsY8OMcwniOzLmST6KrB?=
 =?us-ascii?Q?KLJsN9v0Az5pZVKkAHenW8uYjmz59l0ATbKiicp7obBPAir+7WbtKTA19AFE?=
 =?us-ascii?Q?ARswyAKrx25UdTYMOKqb3kIOpHa1c4A0zgoXWqnmz2M8+Pk5TaZhUN3U+UUz?=
 =?us-ascii?Q?IDMP0kQXl6qj9TSBIRac0mrxR9UXj4FDvm6YgnaA2gW5eyer+4wgb7QkBMlP?=
 =?us-ascii?Q?4twaVRVffiLkE3fxOLvI3Jn2zfMfYDBnTBbOX3A/aHm0VHQuheRqYhaWmhdu?=
 =?us-ascii?Q?0Kywd3mYBONKmdaVYsl6wGfI0qQN0BeHiCl6GE1rsIpgLardEUDzEx+TRK9X?=
 =?us-ascii?Q?d5uLiBDucn9kOj+qXtomhrPyYfSMjA2Hfrv2FZVFHepK+pbhRsgNgF2NgTwM?=
 =?us-ascii?Q?g3pmaYGyk5oHPqg1XM/ZH6QfG9Y/qvZXHmLgLeQiVOC108JgxqufYLHizw7W?=
 =?us-ascii?Q?+BpKen3jse4hrdA/i/KNTasqeNCpczeU0FiZ21culIbhPSIev3mU7RwPYlqm?=
 =?us-ascii?Q?jNOJYo0DKYdpDgHodoEZ5vAw/0bK86aNZTmTlY83o8SLH2LrXSZHbHxRdjyc?=
 =?us-ascii?Q?5rSoX6Adufjfy9g78gNFt0MiI5hmOrUmVFKEi0Z+qcn6gCubPd9q5qCLzLz3?=
 =?us-ascii?Q?K7d+0m0xNIt1RXGH4wVZHdazG+bkLpZGA3yexBcs3BpXi1FoZQBYyFpUm4EA?=
 =?us-ascii?Q?1ZTCjhqC1JAAr383WoPv4aav1kA648N3Q0rawo0jtlC09KZxRI2vEGAQ+tUY?=
 =?us-ascii?Q?Wb/VtfsXqmQvaW/dCGAgBTIMxGgWvyWKUUCxYc6/P2BT02k6gbEDV20I391a?=
 =?us-ascii?Q?upVBDCoPGEnfcJfhCz2MUeLX/2v/Y05wCuhsxrSGO7k1x9HBUp6wcrdwJidd?=
 =?us-ascii?Q?xRJIRDUQk8QjOjlkN/Sx2Bi43laJVQ2qrNZbQk5ZUyI5BW8Dn0LmffH5LQX2?=
 =?us-ascii?Q?wBFttBFIkynVK5KoVR3dk4ZZEaGIckTdyIMGXG2+IzhBmzsmRBLuP8ZkL4xF?=
 =?us-ascii?Q?uqffjEr5BanoFbnOSJmJmpo1O+kHcok1XQ3Gbl4g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd7240d-fa09-4bf4-c53e-08db3aabde8b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:25.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QngA7CqXX657NEqVX0pp2A38csfdoiRJKN1DgZxhBwC88zheQZE6kGl2RHvRrCzv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The driver facing API in the iommu core makes the reserved regions
per-device. An algorithm in the core code consolidates the regions of all
the devices in a group to return the group view.

To allow for devices to be hotplugged into the group iommufd would re-load
the entire group's reserved regions for each device, just in case they
changed.

Further iommufd already has to deal with duplicated/overlapping reserved
regions as it must union all the groups together.

Thus simplify all of this to just use the device reserved regions
interface directly from the iommu driver.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  5 ++---
 drivers/iommu/iommufd/io_pagetable.c    | 27 ++++++++++---------------
 drivers/iommu/iommufd/iommufd_private.h |  7 +++----
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 366df246d4d1f6..d2bcea7d9da815 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -310,9 +310,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->igroup->group,
-						   &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(
+		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
 	if (rc)
 		return rc;
 
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index e0ae72b9e67f86..f842768b2e250b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1161,25 +1161,22 @@ void iopt_remove_access(struct io_pagetable *iopt,
 	up_write(&iopt->domains_rwsem);
 }
 
-/* Narrow the valid_iova_itree to include reserved ranges from a group. */
-int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
-					  struct device *device,
-					  struct iommu_group *group,
-					  phys_addr_t *sw_msi_start)
+/* Narrow the valid_iova_itree to include reserved ranges from a device. */
+int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
+					struct device *dev,
+					phys_addr_t *sw_msi_start)
 {
 	struct iommu_resv_region *resv;
-	struct iommu_resv_region *tmp;
-	LIST_HEAD(group_resv_regions);
+	LIST_HEAD(resv_regions);
 	unsigned int num_hw_msi = 0;
 	unsigned int num_sw_msi = 0;
 	int rc;
 
 	down_write(&iopt->iova_rwsem);
-	rc = iommu_get_group_resv_regions(group, &group_resv_regions);
-	if (rc)
-		goto out_unlock;
+	/* FIXME: drivers allocate memory but there is no failure propogated */
+	iommu_get_resv_regions(dev, &resv_regions);
 
-	list_for_each_entry(resv, &group_resv_regions, list) {
+	list_for_each_entry(resv, &resv_regions, list) {
 		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
@@ -1191,7 +1188,7 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 		}
 
 		rc = iopt_reserve_iova(iopt, resv->start,
-				       resv->length - 1 + resv->start, device);
+				       resv->length - 1 + resv->start, dev);
 		if (rc)
 			goto out_reserved;
 	}
@@ -1206,11 +1203,9 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 	goto out_free_resv;
 
 out_reserved:
-	__iopt_remove_reserved_iova(iopt, device);
+	__iopt_remove_reserved_iova(iopt, dev);
 out_free_resv:
-	list_for_each_entry_safe(resv, tmp, &group_resv_regions, list)
-		kfree(resv);
-out_unlock:
+	iommu_put_resv_regions(dev, &resv_regions);
 	up_write(&iopt->iova_rwsem);
 	return rc;
 }
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2ff192777f27d3..22863759c3bfb0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -76,10 +76,9 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
 			  struct iommu_domain *domain);
 void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
-int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
-					  struct device *device,
-					  struct iommu_group *group,
-					  phys_addr_t *sw_msi_start);
+int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
+					struct device *dev,
+					phys_addr_t *sw_msi_start);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
 			struct rb_root_cached *allowed_iova);
 int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
-- 
2.40.0

