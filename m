Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7151F6C3A31
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCUTQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCUTQb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:16:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDBB2799B;
        Tue, 21 Mar 2023 12:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwuxpZnqUJD9Xyefr3XlO+2vFGdhjsjXk6VZPX674aYg6bq0vLs0tmT+A/VhYnodUUAxSdlBBO2ResQ1jPAV21AGDF2VUcczxodhizC2v7nL7r+akNybKs61yQUM61dWAi/oFxKRExioXK0dfO9Ts/VFSpCKgqRxQ76keqKvnFgdaGndce7G2s46rKl0syftqq1ltW7Z9/zqBUNuwl/l3fdW5A/jK7jfEyVeQmZXD36pOGByi9fmPHzH1vwDHFuMF+55hsdRpRp60Z5odrozqxPE88XVkEIPk+pV2JREeyka9aCmto6bq9ekZ/qGS2T6ee6qJjgNNuojQwURG9+SDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnKh2jqsbuNQqA2uWKqUE/DGDLNe4KLoor4xOnDLO10=;
 b=g7UUKl84xlat4GMOq97P6wd2V7CEYRfoSm/kCG+U8DZ87Xfz/vcmBr2nzoUsLWMn62JDy/hxjDdCm3zzHQT+iRJEmBK0HbUlxSwsiY/Q0w9bt0MEU8mmd0SGc+T5dj9uHwxW6YN/vrAqZoUorFvRt8BkhFOA5RuecqAwjEwK/ErC9aU5gHv1Xj2b936nSZXoVoedfEglPUtwhzlj1DqsTgyVy8bZwFOF9QMYYTd3EvVx2U1d+p3R3uvOBPjRN5W8f7Wb6X3zK5LUmAI4lvBRm28qxKTgWOdTgfj4fNH5yuno010/yR5cp3sLa4vKEkPCYrzSJsCvWheJk8i/JuyhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnKh2jqsbuNQqA2uWKqUE/DGDLNe4KLoor4xOnDLO10=;
 b=hqm1UiY9cjNWRrwjLaCdc8YkrehhXt8IgIqVtGWcLs6rBw4gbvWsNOkaLtMrWm5Bveg5bOjTKp1Tz6tfP5861c/BF8+L9Jp+M5N86VxNHT1AyjLPsaOS9CeoVKA7r9Y6hB1ph0NaOdwFvWYz5wJaAlWwDoF515bGcTw9Kta9ew00lPQ2h+f2U0GuAZntxJNSQBDiqjIXzxFz5Fanl6+Lk8d3LUfrp2co8qcE7g1Vn3FgGeN4I0yZ5Mo2NrH/ImXyS5+zLnIcF9CaXpwLtMEvA4mULY/+PCLzWXB0RilMS3guRFPsf9iAEbB8jlYLi0YugaYBBFJ+Ho5MBXy22VcsEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:59 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 07/17] iommufd: Make sw_msi_start a group global
Date:   Tue, 21 Mar 2023 16:14:41 -0300
Message-Id: <7-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:208:234::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 7411335d-3350-4445-de27-08db2a408e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpF3DSuFWjp8gcIB6KAjUoNb4r5dspkdj6VbMyk0WwVkh/GJucY4l8STJxO+lE7ehesyED8XztJv9Lu/BDw35rXpVCy9Vzou9PA/Fd8P51ABrEhLRpFimWKRfTvh1q7KpioqcsJ98QBja2z2GFOJPjUAACtBxZFos9JwuSARbYlgjPPoWLFh2oo/Qs2FjEzSlc+Ev149gq4tMqzcXNvjfxe1AkXxbZ+xBizJNwiu6J9mOqC1u1VwT0fG3oCZxlnGjya77VMShlFChK0Bu4wP41rmxGCkdKyMJrIpo4dq8alKt3Z2g/kW1V7RDih1hLwrTiudI3dGNnnql5waIBYWxDEquILE/+6V97VUxpraTWbGGfZmOLem7xlYmrJLqaZZJUhEosLhK2dNEWJPSiC6BoIOyqW4stTXsm5eclpbrtcyXZnLgmG+i8kT4o82SgbwZwgFKB1UlNejdYCw8/Eht10NK82OhvRcnh0OPhepR+vQoRy7O1pw3n7OFwvcwuAOOcqrhuOWvlgWf07ih1+QR95Bz3Qx+Csait8SQkWxjPZIWQHwziYp23GGbtSLLMrkXmoR8PvlrCBvdqM9/rL7B8fTVbCmUH2+TEwI11LgmZ2zv3bqiIOZQRbTM5xfTfSRo9oH7NSJjW3xXWVtDu6ks9nQdpsqEGtABXe4w44QQQ1gLw18erDktc24I8vrosSN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9g+QnyLZrot6hE5S5QOgqSpeGBun4Mr4+tkPEN4MJA7VPOQKZxHqw89/4nY9?=
 =?us-ascii?Q?ol8l4ToSKCdwlov6TOEFZoU2Op4dksB1Nu2TQuPSwBp6/AUt6Zf5QrEaDPEL?=
 =?us-ascii?Q?5RyNqkcq9xoUJyC7NpWPm2tsHeinmhZCR+cB14JyXUbTeGTjuVyVHVe2rIAu?=
 =?us-ascii?Q?7fcbb3ruwDiyzdycS+XjLSVI4P5HcFOQUAau0HkWAWKfFp3WzAEgF3pezeBA?=
 =?us-ascii?Q?kVtoResJye/XsuHq1QntHQ94HVLEmBD8X8Uwn9gRddNbaGSNpO1oun8WrKPU?=
 =?us-ascii?Q?uALvCi1HMqOpRXp7jgYghI3ERG0RYT9wLViR5OBECc+9X95GXJAbTfZFB9+A?=
 =?us-ascii?Q?h/oFPCnQ2LxWgSl1pOrzNZcB3GFk9OUPkXkVtY6Cw0a7LleC4fgdlK7MTjnV?=
 =?us-ascii?Q?PuckGUoHMSIktctKm4IQBN/UhnnYWzomhySNGP4RqVfQB4OIq54akFfn+XAZ?=
 =?us-ascii?Q?HcJzMeKTNOxAmfRMOhMRhn5p2nJh+sRxdlsmMzsnGlVX7RGiMIKggPadztWg?=
 =?us-ascii?Q?pe9CkH1sJLPcayFNBpU4FpWikIfQBTlCBXwNz1BfXQZ39+946SyYFfHrSTcZ?=
 =?us-ascii?Q?Zctem1JhJOpFfY2audBuTwvUKJIHBGkQWKVw3wOMMg1rBoOMsA8yukyogXF7?=
 =?us-ascii?Q?CFP+fDmo6JIfqpmvcqtQVBlmoK6HOG3H9NFaVIhA0Ykv2nleBxhglr63qtU8?=
 =?us-ascii?Q?fGAfjbUZeLQFyNLvRzXdd4MSMh9X4WIrvoJMZA92Do30m1D5Q/rHz3SmBGbc?=
 =?us-ascii?Q?OOB2DW2c3Wnz6a1ACoSfXoR7dZeJfIo+Bfl5N9KTlwlHtZ4oSKjjFwNzHbjb?=
 =?us-ascii?Q?HnybbiI0u55KgjThdER2DbXqncYDR3q3/adOXEYKGMMzQNBXZFuxx87AEcwU?=
 =?us-ascii?Q?/eObNEeG268tkpYV07ljyWOUYoh/cL14LMqiXETvCl8oFYM9U8RbuX4rLWAl?=
 =?us-ascii?Q?XF0oRnmKPqoci2LAwoOWHu/Rx99tzu/ueUNCrmti+BrmGi4uInQhsD/UjJMf?=
 =?us-ascii?Q?wiqTqyAwxM/YJqvFM81cGRKyna7jFp5AtlsyxkUWTC1Fu44U05UauueZCunl?=
 =?us-ascii?Q?ZZYy8/u7tRms/7jz+zCONWVm+Wxgl7+4R0iJ4oOGzawWNkp/PureAVJyxRje?=
 =?us-ascii?Q?4/0RFkBUB9qlun3sq61ujBGBr432AjIvpa75ES01roBmsAl8kxcR886EBihj?=
 =?us-ascii?Q?ItaY2MRWyspWsQbtEW7lA+IL+YkGryfb8aGT5Q7bGhebW/+mgU6I2O7V/LYd?=
 =?us-ascii?Q?CxSgub2L0ShDfGHMDpqC6iPJ2rMMHysVfi7e4gk0qqV/CZtHT/6dOA7OFDOq?=
 =?us-ascii?Q?8x9cML0WPo2yPPQQ97U+h9hk/asq6YFHoDlCKKxURhY3EiFZOLu6v2oAg1us?=
 =?us-ascii?Q?ZbFs/J3unQ6C/8Vgi3psgTgZl15EuAtiLqOkUjxXXtuMBBXj9Nfsyl2YbSYT?=
 =?us-ascii?Q?Aqz75HBkbmyZveuGh4QbzmWdOvT743dWHcQnjDTN3nAgIp0A+iiAflVRoFsB?=
 =?us-ascii?Q?8GDjiB6nj2dYOwwmI/sUquzXLpagoKVltP0xw4gDGui2LYzDzWG9oztoOpRP?=
 =?us-ascii?Q?CosSLT0CY6d3QV8itmpnNpTgK+DirB9X7eEY7MVa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7411335d-3350-4445-de27-08db2a408e08
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:55.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVo66D0qNYh+56X9kPaXI+AdvBZZsStNqKvfsH8AdJBjEBTDXiyZFt2/ELH67C94
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sw_msi_start is only set by the ARM drivers and it is always constant.
Due to the way vfio/iommufd allow domains to be re-used between
devices we have a built in assumption that there is only one value
for sw_msi_start and it is global to the system.

To make replace simpler where we may not reparse the
iommu_get_resv_regions() move the sw_msi_start to the iommufd_group so it
is always available once any HWPT has been attached.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 14 +++++++-------
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7f063b679a24be..616a23939e968b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -88,6 +88,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	INIT_LIST_HEAD(&new_igroup->device_list);
+	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -249,10 +250,10 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
 
-static int iommufd_device_setup_msi(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt,
-				    phys_addr_t sw_msi_start)
+static int iommufd_group_setup_msi(struct iommufd_group *igroup,
+				   struct iommufd_hw_pagetable *hwpt)
 {
+	phys_addr_t sw_msi_start = igroup->sw_msi_start;
 	int rc;
 
 	/*
@@ -285,7 +286,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
-	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	lockdep_assert_held(&idev->igroup->lock);
@@ -310,8 +310,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(
-		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
+						 &idev->igroup->sw_msi_start);
 	if (rc)
 		return rc;
 
@@ -322,7 +322,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * regions are only updated during individual device attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
 		if (rc)
 			goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 22863759c3bfb0..7f4936cf537be4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -267,6 +267,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
+	phys_addr_t sw_msi_start;
 };
 
 /*
-- 
2.40.0

