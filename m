Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A16CAD2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjC0Siu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjC0Sin (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:38:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEBD4480;
        Mon, 27 Mar 2023 11:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdQRgqSkKZtkFWg7sGZWjkWwnAn59E/c2XYYY5S6jAmGb4Y9wPmlNLY6edBTOEx/zhiBIE3JYTW+YkxvEQjp/uBPJKrK2v2Vs//0zDVG2/Sy+oMBlhI5xt3B2j0wQ3hotGphu/ohW86fEFAhtrC+dTSw7tx12LKxZ5ZeaA6tD9J4ccXt7Buoy74h+OY5hUnLqt4bcf77kYB6xtFzi+9TTMhhbi2vNLrKvqfZZhJ49ixaqOC9xkvYC9oxyvDC9BrZZYahNGesPlyXCaDFOq7EbNHVLH6m8Z3vLgXvh1/vfO5S4ba/kBlfRP1SDp9L1GFMiinNLdjFa2nSsCNm/fX5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpEHs9fKeNh95f/0/goNyHkftAxd/LJsiY50q4cKulw=;
 b=j7BXGqzSBaKutSR9PAKEDm+s0gmzRWYwpbHqP1y1vNSzWLSz2x0TU608iLbOHziegVGxGAT7nVxLmpqsPiWOLMMAE71iJEfezfWlivOdiTI/pOjzWTvO/0emMJc1/oRFuuft1cVJmKNncpYUhtza0Lh0FErCGsLLvKcR1io6HH+jV+XKy2IygEjEJ2x8xVFSXQdvjEcS5gk65SzZlpSGA5sKAmmmE/jBv4ifr/k8o8xyi/CRa+yrT86jQENTPgb3LTHuHTm+4Y+CeSgJqQiLalvBmlr1coKA+TMZt3Ow44MbV+1saaWYmhvJ4iwnL6So8XBNlZCigWhoG75757Ymbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpEHs9fKeNh95f/0/goNyHkftAxd/LJsiY50q4cKulw=;
 b=b6LSIRNZmhb+XXLyPwHm1RY92Iajpr9SyP1iHQAGMVDPh5kHRUCc917B7T1OuytlAOWWglwiukLZh5t/erC+bfTPyOCX7M7UnmUBcYxakFPKSZXjOj2aN9Xe0Bgr4Tqqi466ocg3oaR3m4ifOPE1gW2ygP658gujf+vsebyCr6VK0TOgSuk66aF/Ntj3c9NuyYDSZLAdkVRmWEuaTaqab7rPtBSJS0YLU5X9iGh79dIcZUX411K410Fl3DsCOwgFcFSulrKpLdR9ankYrPemcByB1KM6iQckwcoXc/E0vh6HbaS1a6WnCNP479pLJx9svTflZ+x8Y/OlwDhKXma1KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:13 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 05/17] iommufd: Keep track of each device's reserved regions instead of groups
Date:   Mon, 27 Mar 2023 15:37:59 -0300
Message-Id: <5-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0386.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af7718d-01a7-4040-761d-08db2ef26b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzoaH7QJfjIQ7DPwdm3am1VMf6JJC3w0iv5GKObcQd6FwRut0vb6domZdYYwqGnsrLCFdkbOuZkI19ig/DmlexU/aHCx6xJyMSZ/qLkIIEF7gOlbLm3dECipssIETMnizoV2GNBNOWqBGcF5oQqUmYAsDypaLTWDdrs1ueMMTCDndXfw4RqmeGqd7Yio+3mX8WFKMOHlirZX1GoAJe4ZhuPaj6ZdKceDcDUxITUDqGF93r5w/KKNYRnI0JMt0fJjnGw7ICHoUfdJ9jzoT0NbWdaXHzwSZDnyBgOOpFy8wJrhygu95HK3Nj9uFWVVDsRRB7xkPMyuy3a4KVuhPRIs0FJ5ckPZnl4lixGcH2ifjS3GI9eG1ZR35S7fzizKetJldbr9VTJQW8110hzsaO3D8HYa13XW0HfmWHZ1jTVfvlpj8JviuaBMZpHs51OxIt9Ty+k8EdZQp6zbG14EG8xPcu57C7DA3HppAi40DTmVBLCaH1eBJb0tAZH1ev4Nqecce4D/aXrnXlm0Rh1YTpt07L0FiUyoDHreSKD++eEQlzq6B1avGl3vFeKu17/gLgGobMJBTCEmlPOV1cmAA8Uym8+JM0jJL3qEc7CKpqzuP+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002)(66899021)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awsxuQYpTZDeEmWK1P5TAu5XH7uuPGRa1Pkjge0M9kc5lysrOmr+iVQ3xpzh?=
 =?us-ascii?Q?62aMX/ptulYvbBAro7fb2TULLPIi7WeozOmFnM/s7JsPgxFZYKwVGvkgfiYx?=
 =?us-ascii?Q?3yhqF5xndfh5QAurntufxaoPPBz1DtqyOCHPo2YIStRPz6lpOxY9XrL6oIh5?=
 =?us-ascii?Q?Xy2JXbLPKJDJqWLMETFbc4ykss8g2qwKSJ+NzqkDRfDEhyp/ZXmADyM3yCNB?=
 =?us-ascii?Q?pTLjzFppTYnGhAfjmnhxPop3P91QMUkyIrldzzFZJKRIxrVciZAE+h5wkRC5?=
 =?us-ascii?Q?TdWtaG6kvJq13j8CvVtbVQd4ON1NbT/x3pSKJE6b8jeS7xqObSbdujstwxpo?=
 =?us-ascii?Q?2wKWpRekkRo0g6og78ojyb9y/8EHBtukzBB0Xea1QOL9TYy03qGVT2t0VTI1?=
 =?us-ascii?Q?Cy+L7jn+AnmbytSQfW647sBNmalSBaeBPHGu3sKHgm52yZW/K0peBPQapKjD?=
 =?us-ascii?Q?VBC4RJ6upXVQTKTk490VB+mMelXGKWDx+7KQsSuSGK6fiTPtuTKHiOFMfWl7?=
 =?us-ascii?Q?JsK8YDnJS+UMkE6qxS+RNCZn05vyQEApy27aqiPWF+ecoNewbRdHuS6TITCe?=
 =?us-ascii?Q?zKk9sOTfjDMpTKdsUGvss6pVHVCXv2x1ba7wSpVP6GeNk1swF8yUylSfuKmT?=
 =?us-ascii?Q?kLAgAqgGXW//f5ubuPBc0m/8Tvu7gdf0dS+EzNuU5gtwHHdX2JkgYvCHMGYI?=
 =?us-ascii?Q?c2Anwzyq29qhGrA+BdF40mFXzjhxGrc0hkfEdwMJzwFJHDtjqR+F0H0jLu8Y?=
 =?us-ascii?Q?LD/f5tcF3ItVTmx6Y0QH+E0wJ6tXAC+CYA8zMutvrdvYZwCvqOAMdimJciVR?=
 =?us-ascii?Q?yylBMvu23E5GhMoXpkR+E6JjFSaCM0qFfA/EZ8fTeyTE8yDg1CxhqPep+loM?=
 =?us-ascii?Q?IJMGGneGQVpSohXyLkGicnOnV2bg+cL4Ugr3mxLGmFq8e2VI2Ti23O4mFf9M?=
 =?us-ascii?Q?P33NKHaWJnj1mjfGumcdvnPtOTxLpeelelJWPmkeD/7AUZlInKXI25FgErwF?=
 =?us-ascii?Q?wGDZ+ToeCNVD3ykHseKQAylytfwg1pMNbt5AHEVvpK5KIXzqzAMFXdDeglsk?=
 =?us-ascii?Q?3n1itVvmK6fOEqOYQepolZ9qEKUCoK6+3nYQD1kM8nmOznEWBW37YyT8Kf6Q?=
 =?us-ascii?Q?U5PBt1KQav4TZ9Rs82KjMYihXoX0SrGgHE2JlOXqJ9wey/mEDRF1gDHJ7/jS?=
 =?us-ascii?Q?9n1ib1VmQGjvkiOCNCPQDxupX6c6/R83npjONaH46kuM/lU09aBo+tF+6uaG?=
 =?us-ascii?Q?/XtsRCOaMWJYRhwMWCNZ9O89Bfv/jlvClkweJyH1UJ8CLysKs7rD2WiffeDr?=
 =?us-ascii?Q?8K15pgA45G42hj+QiM1QeK6qw2TlZjmvdRsY0ooeDrtEPI2uw/t4ize2BPQP?=
 =?us-ascii?Q?njYqvINgoWH78JnRJSc6N+EnF49hBX1AGrFKBumkWTxfXjeM/BhPpDrCqg7M?=
 =?us-ascii?Q?8guv+R0K0fDlHgXx4nSnQJ0LfrfHi9WC5SBwqBdT1R8lTIpg+s8R2/xO0daM?=
 =?us-ascii?Q?pXdq9rTJjHSKmTbAtrnhszgPcQuOVgcBqO1TWa4jeeSzacJUwzHSriWJtwCR?=
 =?us-ascii?Q?RtcvhZXVYvKSXWs53lnJdbUN3VhI7jf4cev6AajR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af7718d-01a7-4040-761d-08db2ef26b6b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:12.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWl+M0/mL6n8K8/uj8ws+twdi+ufUmrRayY2gSZoF8Q9LbLnpfCKPoZo7z0qTANZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 58ad98de1914dd..112b6c541c47e4 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -313,9 +313,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->igroup->group,
-						   &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(
+		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
 	if (rc)
 		goto err_unlock;
 
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

