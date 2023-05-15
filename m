Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E75702EFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbjEOOAn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjEOOAl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548041BC6;
        Mon, 15 May 2023 07:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvkCccrk0u/Jb4vcdzd2n5a56WRVWYWNKTWBAIlbh1UNkf24XlaiMJyS0hucT3pRU6Abt7+OaOdQ8cv8vhi90ueyuhCSgq9FwyoaOFPMQ+gDAogZYVQbBlzqR2KXFoI+axhB7s4RMWkblSUvdnVoT4JKkL81AWPrAQue5lwK/D624KCtXAKM/Nkt/Cs4PyayuUtoW95sWv0nvHjnO7obU+3+rVCcqyRHsCevWzSsZz8kkXjBAyXvLIb4I8ozEiyfaauOs4OYbaGfhXj+bra5QWEX2NZia3Ix+QJbbyI8pXVbcIBAUQbSer7VMD/eMFVZb2tIw+bUntDKUdtN9RS3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dhkBX3NGQPMFkppRP0PeyMsWOEl5rAoWp3gs2Gl7tY=;
 b=E3I7+DyrnEByae4nsxJ4UB1s2aKYiFzrEs9AIQoX3XZq/xMVRqEhRg/bvHL2VuyKc5Vfa+Pvv1j8YAmKPAoupW99jm51YpUVbOc+1uixdeCAXN8Ii44LOVE7Ighgae1ErH/9TB2RbEtct+CZFcLY5pXAbnrT14uBrUPrNszZbSqZkeXWbPmROzGv7sgW9Q+Woemy0kALiGkMiJGdciqx4AZutRlv3q15K4RofhHJJk8CpSvBNNJxWomRUCDZu1uqu6qBURSWayrxAAxtXK/1gIxyjuxTI7E/m7xJgSl1n3UnO4zhSYZ4AIUsyAlMUVEDRKuDicYSqmX8LBMp49iXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dhkBX3NGQPMFkppRP0PeyMsWOEl5rAoWp3gs2Gl7tY=;
 b=MYh7+y5Ve7w80SXtGYPf0baluiZrMEff3wWPHH20LW82l9mbwnCfkhapjQw+QafdlyP0SRDcdCGIBUYwPMTX4887IBN40fl5HCuAXtE3LymclrZRDB6gugdqgdgmmweqFEFzf9sa7ufLV4qUiZ+kqQIaeivytn45lTDPuFgTV89A+TB+IlOqMzqVzW1PS2XPX20ppUpOAurH/aGJmTtyD5VXJ9Ibc15cQ+O5HlmlhrLWE0AQuDpDGLickmbGLPvwmIDW2T0aWxeL71lArDXm1C3UdYVFHAKijA5qiFGipuhqaR54D2I7SsYNqt3Rea4sN/eyCLiA0pQtA6tBnCIEqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:36 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with iommufd_group
Date:   Mon, 15 May 2023 11:00:18 -0300
Message-Id: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:208:120::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: d0697ab8-1bf8-4afc-fa81-08db554cc11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/kwa4yWPSv4OfghTYuixkUcfnadFiQP3Pxi7cPJZlPUcFPuDW+RpS5Ftgtv675HIg3f1bsKtudeH+ury97cacsptYabyiAPmMjaFTut+jbTCSfey9yX4sBCYkVepjG3jK3M/ggCA5FGNtmMJDspKNt05VtC5n1446XFK0BE02bI53thKcUAV9fIXp9qQjCY1DGT6zjnMMOVVFs4io+G1miyj17dWnYNGNZSCSY/t99pNZ5GUk5Je2rLA4kkAQ3EGrt3IQz8WPa5z8VIVggp9MmEukVW/cSYLfub6hd1Ma84LJD2S6+GICaAoGW6pI8ZfSwskmaO2C5J5aoaJM+NzCbDRTl32OkFWm7S96YWNBWysuf4k54c3XAp9xx8hmxGgEtaxcT+fpjBXvzu2HA1BY7K3Cn+/f/jnomp5enLcXsLEFQR+tIskVR8HQTQcu8mEKpeBZT6020Tx76pdTOMa3D+r0UGWSZvILZ87hw5663AZkUFOh8JFNSKI3bsCuSuasy1KFWkpK/ZaxO3uI/fxmChI+ls3GVoATHyfaZWEBg2CwpKBI3j55GOcV2rpk1yKaLk0l5I8J3bEkPzrz/rMwa6m83g+h3fWwj/DBSYBeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(30864003)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?del+cPCu0H81MgcGAEs3Q8q9Yeo2JWhWM/fsAUX5wVVX5ALAqZNTnIIfrEtF?=
 =?us-ascii?Q?yhfV3o6i1tfxXXvtVw+rV0GViwNPqpz+q0DJm1p2LrGbuwcPZuy2d4a3iiL3?=
 =?us-ascii?Q?CfN+HFL0rwyO0P1Adj9UHsL7WzKNxpGoZk0kphaEtD8K0fCp/gjNRBL1sIWx?=
 =?us-ascii?Q?6HsHs5KE9xvAPSSMs4j8SlG+D0lfuuE7tS2id8tYUU/Iet7es6gdW9crp8tM?=
 =?us-ascii?Q?Ten3kLR1cPDR0z4tcVjrhbV/VDN0j2WkeyDuZrGEUzFGzslyBOYAActaprQ8?=
 =?us-ascii?Q?hQubWyWdiCXJdouL2S+DTWtsE9qNQMY5WXTrWVYvoeSgvPcoHlTcpVfPhYlP?=
 =?us-ascii?Q?HXKMmENVjVgEH/wPzkQm+0ZZn8yfa6oVqIOYrKz0ydzjuXD1M6TUVzYbRi13?=
 =?us-ascii?Q?9i/6nd0ivTGypCMzJPi2TGZxgc8UrVDxb4v65dO3An8Qp93RdcHvJRdKxHLf?=
 =?us-ascii?Q?k3PgNrTztrt4AWsoXMYB/vb38K8w0vJyoIyt2PdEKrL/sUXM2B+JxBeZt/Ny?=
 =?us-ascii?Q?NwQyLTJS8uf9mMekeuUc8ekygWSnsKrGYm0r1tN6cHIBb0olYogCBmTj9N+l?=
 =?us-ascii?Q?vKEGvkPvtOfmIS3KgQqak9aUABBDrIRDgHuxeqQFNNzMiegtbWpVjqYwHpqL?=
 =?us-ascii?Q?ljKJvnNjT5W7ljh6ODq1ohr4PeEJZ6yERicLpoI5+Lho+DfdNp0N8gQdcIms?=
 =?us-ascii?Q?xRTpvpInYmAvWrWQvyLPoJF8dtd1rIvhVWReMSg77WKchNkaw3JuCvek2pTX?=
 =?us-ascii?Q?fQTlM7roHnVG2Z5HaEukjLQZjfY1T90WTaJk5sh+XdAfgUWEv4jzvCqQ8+2S?=
 =?us-ascii?Q?CJYSCFgwu7wgi0tM39Zi+agGSOuTVIZG5ln3YRFjeRyoBns2IOkWQgOW1ne3?=
 =?us-ascii?Q?HDkwocE7J5fmTp9rmVUFiybKoU+WUNW3sqkh/pXZz2Ok9x9xXCsO96mJzYnf?=
 =?us-ascii?Q?ByKS+S7OQg6JnjQOOY8u1edPNPTIfk/q6Nq8uv1rHda3PpPXhfhI2RX7y4+W?=
 =?us-ascii?Q?tFU+lb3ya/7jkLJ0KM1ArjCTrTmqb/Ss668fUWXeamf0F2X0rj0cXJeObFUy?=
 =?us-ascii?Q?r7OJ0hS+luJasTnjuG+10nasOpJ+LFKXoa5eAJzwfLdcCCGXfLTYylWnxBwZ?=
 =?us-ascii?Q?QktoSb+yd0CR0fs9z6exQc/GgVGmwanlpWX75ngRxBzS4WNcRP3Mb1yAhmaE?=
 =?us-ascii?Q?TaZqYCBlGT8MgpSIoyhr2knSUx5V23/RdhGhXtrRRT3S/sGuP2FdEHOfMvsJ?=
 =?us-ascii?Q?5E3NeGN5+xmgBYJgl/+WGAl/xEDa9XMl0s2jzxhs9L16I3of+jXiypjy0mDm?=
 =?us-ascii?Q?Qkl6iSo6xTNi9TmWjjO78aQoD++C0IzJEUDITxIq9ss8bPoj6Y8tqhsw9eJF?=
 =?us-ascii?Q?OCJTv4LEv81tpbpbxG39CIb/fMNvRBZ3t/hQoB7Z7CRNIDC0sqfNd5l98OMK?=
 =?us-ascii?Q?i5IrBDbX8V7XehyF0T4T3pHPXkY/SAG4cwOaf1wmVwdCPw+3F1SDT/B806yr?=
 =?us-ascii?Q?ls6/DisnEQtBycBJTzv+XJ3X7OX75W+bJ5ZGQVHrCsMIrnzxLfaEjsz96Eat?=
 =?us-ascii?Q?ofdweuQcNZtAN1OCiUMkmOa1AdzhFH69MlhLPE2g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0697ab8-1bf8-4afc-fa81-08db554cc11f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCZtxLjL54SXFftY2o5nSuHDSEvtVqyiF5H0507HHNxVzPbX+rzYHgDZ/EAEKWbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The devices list was used as a simple way to avoid having per-group
information. Now that this seems to be unavoidable, just commit to
per-group information fully and remove the devices list from the HWPT.

The iommufd_group stores the currently assigned HWPT for the entire group
and we can manage the per-device attach/detach with a list in the
iommufd_group.

For destruction the flow is organized to make the following patches
easier, the actual call to iommufd_object_destroy_user() is done at the
top of the call chain without holding any locks. The HWPT to be destroyed
is returned out from the locked region to make this possible. Later
patches create locking that requires this.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 100 +++++++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    |  22 +-----
 drivers/iommu/iommufd/iommufd_private.h |  13 ++-
 3 files changed, 54 insertions(+), 81 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 8c27f6901446e8..23ebf2065e20de 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -20,9 +20,12 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
+	WARN_ON(igroup->hwpt || !list_empty(&igroup->device_list));
+
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
 	iommu_group_put(igroup->group);
+	mutex_destroy(&igroup->lock);
 	kfree(igroup);
 }
 
@@ -83,6 +86,8 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 
 	kref_init(&new_igroup->ref);
+	mutex_init(&new_igroup->lock);
+	INIT_LIST_HEAD(&new_igroup->device_list);
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -277,29 +282,18 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 	return 0;
 }
 
-static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
-					   struct iommufd_group *igroup)
-{
-	struct iommufd_device *cur_dev;
-
-	lockdep_assert_held(&hwpt->devices_lock);
-
-	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
-		if (cur_dev->igroup->group == igroup->group)
-			return true;
-	return false;
-}
-
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
-	lockdep_assert_held(&hwpt->devices_lock);
+	mutex_lock(&idev->igroup->lock);
 
-	if (WARN_ON(idev->hwpt))
-		return -EINVAL;
+	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
 
 	/*
 	 * Try to upgrade the domain we have, it is an iommu driver bug to
@@ -313,8 +307,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				hwpt->domain->ops->enforce_cache_coherency(
 					hwpt->domain);
 		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&hwpt->devices));
-			return -EINVAL;
+			WARN_ON(list_empty(&idev->igroup->device_list));
+			rc = -EINVAL;
+			goto err_unlock;
 		}
 	}
 
@@ -322,51 +317,52 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 						   idev->igroup->group,
 						   &sw_msi_start);
 	if (rc)
-		return rc;
+		goto err_unlock;
 
 	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
 	if (rc)
 		goto err_unresv;
 
 	/*
-	 * FIXME: Hack around missing a device-centric iommu api, only attach to
-	 * the group once for the first device that is in the group.
+	 * Only attach to the group once for the first device that is in the
+	 * group. All the other devices will follow this attachment. The user
+	 * should attach every device individually to the hwpt as the per-device
+	 * reserved regions are only updated during individual device
+	 * attachment.
 	 */
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup)) {
+	if (list_empty(&idev->igroup->device_list)) {
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
+		idev->igroup->hwpt = hwpt;
 	}
+	refcount_inc(&hwpt->obj.users);
+	list_add_tail(&idev->group_item, &idev->igroup->device_list);
+	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+err_unlock:
+	mutex_unlock(&idev->igroup->lock);
 	return rc;
 }
 
-void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
-				 struct iommufd_device *idev)
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 {
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
+	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
+
+	mutex_lock(&idev->igroup->lock);
+	list_del(&idev->group_item);
+	if (list_empty(&idev->igroup->device_list)) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		idev->igroup->hwpt = NULL;
+	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
-}
+	mutex_unlock(&idev->igroup->lock);
 
-static int iommufd_device_do_attach(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt)
-{
-	int rc;
-
-	mutex_lock(&hwpt->devices_lock);
-	rc = iommufd_hw_pagetable_attach(hwpt, idev);
-	if (rc)
-		goto out_unlock;
-
-	idev->hwpt = hwpt;
-	refcount_inc(&hwpt->obj.users);
-	list_add(&idev->devices_item, &hwpt->devices);
-out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
-	return rc;
+	/* Caller must destroy hwpt */
+	return hwpt;
 }
 
 /*
@@ -375,7 +371,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
  * Automatic domain selection will never pick a manually created domain.
  */
 static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas)
+					  struct iommufd_ioas *ioas, u32 *pt_id)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -392,7 +388,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		rc = iommufd_device_do_attach(idev, hwpt);
+		rc = iommufd_hw_pagetable_attach(hwpt, idev);
 		iommufd_put_object(&hwpt->obj);
 
 		/*
@@ -402,6 +398,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		 */
 		if (rc == -EINVAL)
 			continue;
+		*pt_id = hwpt->obj.id;
 		goto out_unlock;
 	}
 
@@ -411,6 +408,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 	hwpt->auto_domain = true;
+	*pt_id = hwpt->obj.id;
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -446,7 +444,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_device_do_attach(idev, hwpt);
+		rc = iommufd_hw_pagetable_attach(hwpt, idev);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -455,7 +453,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas);
+		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -466,7 +464,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
-	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
 out_put_pt_obj:
@@ -484,14 +481,9 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 void iommufd_device_detach(struct iommufd_device *idev)
 {
-	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
-
-	mutex_lock(&hwpt->devices_lock);
-	list_del(&idev->devices_item);
-	idev->hwpt = NULL;
-	iommufd_hw_pagetable_detach(hwpt, idev);
-	mutex_unlock(&hwpt->devices_lock);
+	struct iommufd_hw_pagetable *hwpt;
 
+	hwpt = iommufd_hw_pagetable_detach(idev);
 	if (hwpt->auto_domain)
 		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
 	else
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 6cdb6749d359f3..bdb76cdb1dc347 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -11,8 +11,6 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	struct iommufd_hw_pagetable *hwpt =
 		container_of(obj, struct iommufd_hw_pagetable, obj);
 
-	WARN_ON(!list_empty(&hwpt->devices));
-
 	if (!list_empty(&hwpt->hwpt_item)) {
 		mutex_lock(&hwpt->ioas->mutex);
 		list_del(&hwpt->hwpt_item);
@@ -25,7 +23,6 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 		iommu_domain_free(hwpt->domain);
 
 	refcount_dec(&hwpt->ioas->obj.users);
-	mutex_destroy(&hwpt->devices_lock);
 }
 
 /**
@@ -52,9 +49,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt))
 		return hwpt;
 
-	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
-	mutex_init(&hwpt->devices_lock);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
@@ -65,8 +60,6 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
-	mutex_lock(&hwpt->devices_lock);
-
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
@@ -76,29 +69,18 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (immediate_attach) {
 		rc = iommufd_hw_pagetable_attach(hwpt, idev);
 		if (rc)
-			goto out_unlock;
+			goto out_abort;
 	}
 
 	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
 	if (rc)
 		goto out_detach;
 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-
-	if (immediate_attach) {
-		/* See iommufd_device_do_attach() */
-		refcount_inc(&hwpt->obj.users);
-		idev->hwpt = hwpt;
-		list_add(&idev->devices_item, &hwpt->devices);
-	}
-
-	mutex_unlock(&hwpt->devices_lock);
 	return hwpt;
 
 out_detach:
 	if (immediate_attach)
-		iommufd_hw_pagetable_detach(hwpt, idev);
-out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
+		iommufd_hw_pagetable_detach(idev);
 out_abort:
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f45615f19798e6..e2eb1db5f8f8ce 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -250,8 +250,6 @@ struct iommufd_hw_pagetable {
 	bool msi_cookie : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
-	struct mutex devices_lock;
-	struct list_head devices;
 };
 
 struct iommufd_hw_pagetable *
@@ -259,14 +257,17 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
-void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
-				 struct iommufd_device *idev);
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
 struct iommufd_group {
 	struct kref ref;
+	struct mutex lock;
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
+	struct iommufd_hw_pagetable *hwpt;
+	struct list_head device_list;
 };
 
 /*
@@ -278,9 +279,7 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
-	struct iommufd_hw_pagetable *hwpt;
-	/* Head at iommufd_hw_pagetable::devices */
-	struct list_head devices_item;
+	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
-- 
2.40.1

