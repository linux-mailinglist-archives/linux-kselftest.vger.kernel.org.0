Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547536AFB4B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCHAg3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCHAgV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961ECA1885;
        Tue,  7 Mar 2023 16:36:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6qZ8IWjoRe/N5l6Vko5Y3g9mx/BM2jRqH900FBTRgUjEqtkPAnyxK8F48yjhaq6nOmN4/Kf2dj0DLxyl6OnLyOr+UDumnlOsxaJTMTDmeja0sgbZFGOVu7tpef8sglGzFihqQd50r0Kr0B7QoBu9dBg5UvG4aZVbU0Wqby+QWRXiWhmUCF4YNJPfCrDJMplzedVfT1tVbHOousrMbZCdA55FXA3mOQWdcT0MtH5H0DDkm1aUz8BERsXo6yIzwXwU2/6TMFbsi77klfIrbzrya7MrApi1ROzxbCpCKa1yDBeXaNjAEOUmr6PeTlIrLm0WNmfQ1ogCQ69BAg3Sgo1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCrnwdJ/fchIkiEu4BbW6TZ+vXYWyS87+T9zrb7TGcU=;
 b=gj+iI5XdU5IdXjH2fYNEb0nsjK5Qth3NRhm1CLEXFjSuNTpB2XoLfBd9K32H4/1AFhY8RSWC7LHfb2tuOCaq3TxBLNHO8xLCVeYYkPLsC8UYOEjS1phKwWg7z41c0yRz+fKcc6yiRMn7c8bldU3wDRj8y4iV3sCvjpDqZ7aazssJk66wF8CWCifQziq6YRhO3jL/zsR8xdNiW9iIV8CxCAClPoQ7GaOSAIzUA94hXjZqtcSRtbXS3apYWfhcmy+R1xSuD34wyd/f2Wq6NaxAExEm6RkXsM75cEkxSv6HxRZdqhUnaNIR/ZNOkRilqBUtE+E32X3Luy/5ZqiwAQALhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCrnwdJ/fchIkiEu4BbW6TZ+vXYWyS87+T9zrb7TGcU=;
 b=E3lCphvjJxtH1xthvDmcP73OtmhSdWbKX4xrPpvwrr/6HL2XDs0Klw9plPO9SupMrIs289f+wS7mXSsDG8pCPHW84gZ39TBdRftXPOCGOaba9ozTbHk8c8MCwgEP8V5IULdYo5+RHcvvoxEr6UfvKzVjf7AcsBNE1Q8VBTvIKjaLICLMoVj3RVi0Zy96e58tD1KgoPdGpdt0Vu+ki0eYGrfqQztIYTghzSCbW80S68KkrC/JznqwgZx3MU5j2wN/LGNjLcb5zgl0fb3yFqyhN33doecoiG1aamhMsrZa+GRfySo1h3LF1bBA5zhkbwV4VdxNtjtESuenP4kFsygU+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:35:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:35:58 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 05/17] iommufd: Keep track of each device's reserved regions instead of groups
Date:   Tue,  7 Mar 2023 20:35:44 -0400
Message-Id: <5-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0075.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: bf198648-e08d-4413-6896-08db1f6d157a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+lMWK6hB8OJ1w4iHeXkTPwXwhi6Jl/WHkSqwPco21DBqRMl6St4iI5zMZC3ysQ3OT7H0Fq4E0S94Be/IJobTlLkn3xLBYMsgMQWvAU8MOxMYNJOtCbXvDKvwVNCXeReWaDkPwJrYFxa8oUK+otcIIGsI1kjzYYTsF6U1sz5GvOzX+hUktjJVIpSFornpKjG6OGP8zXJuNVohN1fxS5zAp3T8/EZxKeQEcOvLOUuV25JBJgPqFKeCG1rGh8KqE5M5xVlSKqWxrslkVYdiPxJRgcs1IvMVZ6CCGJHqpGCFB8C7jMJODepNHDWKwvVQwhnkV87A1UF3KjgyEk0TQaOHDR1GVsQgkgcdDwthCtA3zVLGw9FcgYUjCUNj3zZHpcy73BKY4fev5ME5MQRCHIM8IUyUUxPvTON4ErTIbFzwW4GoT2O82IZEV0C+0oUtk5zGlTENKXlU7x67Gh5D6uVL31TKdb9bDU2vAgbCL9cXMSeoyDEfGekkii7dKx4C1uy+vrEyp7C9dJJ3Mlp/feIv5Sh9IUrQrXA5pRCrjYB+HCfA7qvim5gHvuxJdHoRQ6SIu7puHIxeSjsX2A2ZuC9AZ2BD9njj7vaVnYEh1/QNv0H4hFpz1B2t20wMPpQbUFyfFjknKMrQgKgjCC7K0xvEcRLLL8yJBdWWNVfniBK2FP/ZtHEQRxz1huYuH7uxmoM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(66899018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1f2Da2h+1pV6AszqW6jQV/d0yXNrVvCtYgZhtC7yKn8/IfPCCNuQs2wNMoR1?=
 =?us-ascii?Q?ltc1JuwUPstxgH9cAgeuYCTiU1J/J8DmQKvYacfGhUe2PWowDanhqWefoo+c?=
 =?us-ascii?Q?u/sxw9nssO2bUnKgH1NyJalnd4hAyEK4nPTtaRDwH6m/nlXcyBqFpEEKV/38?=
 =?us-ascii?Q?UQfMB4BpR23ad9Nv9ywd0WR2VY02q2S+sc4xHAyBB/tvGkHBBRzucumIWXyW?=
 =?us-ascii?Q?2R779sLZ7VT48uKRZh1oBQJ6Q+e0lg944FdyeTzzCYOsq6E8lsNOSO23ZeTd?=
 =?us-ascii?Q?wUINC9jAQDjLL0HEiUZVQubELBr+gtRmWCa4wzK9w5bH4BRo5/EDm9uz+X52?=
 =?us-ascii?Q?uKZMgaiHgGGuk19gNUdNvonh9jGBOy3mL8pHoAj2LKUED1VrM4nLwLQB54yc?=
 =?us-ascii?Q?fSikndv3M7Hr/bZ1NmodWxY2B80gCzEbWD7VO2OPcOvsXTD03TuEn1kre0v9?=
 =?us-ascii?Q?/9KA2k4Y6pb2Ha0IzOWmaMOrWz4sqVygR+E/r/q03oRj5stEpk7YyN1GXisy?=
 =?us-ascii?Q?bxiLQRZpnr9MZlVPnJUtL/uaKHL1PF8+CroLM+lDyjFB7rEGawUmLRqtFReu?=
 =?us-ascii?Q?qdS4eM/ydYbSgPPv29jen6DoXUOnS91bjRx3F+k7F3nGaIKDZu3r9lAhGHJz?=
 =?us-ascii?Q?Ms5vwE6o0FZ7iWCg6KutKG5jGKjUtMcfN+wn5/KuYVKK/WeBO7GedoY17C6l?=
 =?us-ascii?Q?oqckExPQ3xqAuDi8edKN2lGgE9v+ZGSCYGGjBeXPOKsS8IrZunBEacrqncGU?=
 =?us-ascii?Q?D20gJk4LzsOeyhZiI2SIZeqUPjClzAqMEYhHwT2XbFDXbL5tpxtjBn5iLvt0?=
 =?us-ascii?Q?VNE1ARWN0eaD/IOdnjSKNPdkYICSpjHClRgvLbogAk59hXkAKlahh1C8oBW2?=
 =?us-ascii?Q?26M/tFMTcyxcbxT6nzsTdh1UZUg5R1oWk9aIwk7WpP5RG0osYFpnSbRhES6C?=
 =?us-ascii?Q?vhOsK4Z8TOcA3VlMKlCn1aGgC9sdulRC+YmjGoD+l6gd1iwo4KnDyreCZ2mI?=
 =?us-ascii?Q?0nrrn1vIuXEHJIa/mrlLfJcfWwt70noPxKYk5q96+6As/Ax8OCbizgX4I+1I?=
 =?us-ascii?Q?amMk9HcnYGPtPYa3GOzPf+ggG6xaIC1p3pa7bp7E9celibtG0jwNxbT51s0s?=
 =?us-ascii?Q?jLRUEAniMHAyu2NfgI7FFNYiuMN4ltHoEMRm0HzzAqoCgmXL6I8tGFVpy8Mz?=
 =?us-ascii?Q?PM5JyXZTJ5nPjWTODnfO9XWx4gTpgXjlNKgHtWCNcwPFAzNmgJRAUINwgsen?=
 =?us-ascii?Q?Fr7K5Ud6MpF7kPPTHR6l/M73l4GlcEpkJKLriATwQFsHkjI8h6It61B85nMB?=
 =?us-ascii?Q?OiBPetPaw9AhL8ql3yvfZNCtp7WfwRy+KOQYgWLWaz825HzimuaqvtLa1k+L?=
 =?us-ascii?Q?f0escNzRgbvyo2Gk2dI5tgCoFR4YrllWn14BydF9nn8BEOth84/ooSC/W9oN?=
 =?us-ascii?Q?OLIfXEaEgrRQuu2n9JUeZYCzljTRxEvl+G1gefPcm5hOEbcDY8gGWIQ4P2Uw?=
 =?us-ascii?Q?LEFBKpnR8ty0SxgFe9UbaP8L4439IDBR1+vIcpNDToVYSD2bTRhAGgX1hr79?=
 =?us-ascii?Q?gJR5k5ZMTnFQIKYDtUpn+oOeB9t8fR+c1DIG9Zhb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf198648-e08d-4413-6896-08db1f6d157a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:57.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrDz+WBasI8vlVeUAw3OIlWrpMB50Wq7O2flv6tjpsij+igvsI+LV6EkhsP3TOLS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  5 ++---
 drivers/iommu/iommufd/io_pagetable.c    | 25 ++++++++++---------------
 drivers/iommu/iommufd/iommufd_private.h |  7 +++----
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a4bf4c5826ded2..b546250dd1e226 100644
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
index e0ae72b9e67f86..427f0cc0f07955 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1162,24 +1162,21 @@ void iopt_remove_access(struct io_pagetable *iopt,
 }
 
 /* Narrow the valid_iova_itree to include reserved ranges from a group. */
-int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
-					  struct device *device,
-					  struct iommu_group *group,
-					  phys_addr_t *sw_msi_start)
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
2.39.2

