Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF65756B96
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjGQSOn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjGQSO0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:14:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705221BC5;
        Mon, 17 Jul 2023 11:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfL+zcJQvck3KFm3i9XPuS6RoYg+iYU3y+3UYipX637anneid6IJRbhUXGQk0MIn8HrXtr5ss6nOXRPtmHEr98pwUgB/oWN5oQ6fUF+K60o80VizgkMUN55IqGLchexNWe0z83T0Pdm9cCuMBbghleiKH/V9P2/M+eiieTtMAiTsWzghQwZv6vmS+mSq2RsIuXo8Cgqne4dgbjKmVZypMlCIjZBDccODwhdfgR2cu/EdpPqh2RMH9T2197g4VG0MqFEtYSarYalGhb+fbXmvh7I3iklvpQP0E9bNJbe7Uw4tRUVZ57Mtnp28txmVAlfqN1/kXNyy8f3sJbIj2DlEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKnB8ekxC+tZlDdOl69cWSqcA8pG1G9adkpwa6jo2Rk=;
 b=JCFkxmeYGajNiYilij9h40BUR0jd1EI1itX/r/xo114ZFexcM+9czJf8g8p4RaX7ZB5gTLVAHMbfEyrKlMS607Hu2ED9AXUPW1Yu++GwIBzDTqDm8Z9Cl5ABQM0kB2BFFESVBnvx7zZr8+foychW1qXmuMOAkuIpQ/OmPk14I0ZrVVuC0YfCOjNUZ3fHP6JdUhtBw1mOpnSPHqhtwN/mNSNHKOfdnXlDPKkYk0C0qT+BbVWY613Vry+TFJX9G/A/oXrgiwhpbjdkzWGemmxrbZfMW/ZAAdgkWiMUphi0JcPte1TaQ/MR8IQ7ZPORE9d2nYNWWSXWpF0cD9pdfDfmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKnB8ekxC+tZlDdOl69cWSqcA8pG1G9adkpwa6jo2Rk=;
 b=sEhmzKzOJXS+ElMx7wgdVkcHn5o3X3lYSDNRf2PMwmUj6bVpamdBIMmpxeJVMUUqdXm2UtVLPCiN7H5Wj/1b2moGWR6zzNsNqFwqimmcW5sYz3QUg1KdcbUjoL95N8Hch+NFr3yFNv3k+SfBBThC0dxTPdkap00bzGvxgSWKGztWPFTSxPc8o7L49ha7ucpNNROt2bA9fEGBP2VXm0kk4HKg3REfs9aLhIirK8hrBz4XzpQQo4EMrqqgzl18uUAOyTsX3O5O/WvRaH8FWJqyU161iy1jFvFrkG1OEEyGs/WV0HMvVztpuuyU/FHR5cs9HIC9M7fKQR1RPtLu/yPgow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:30 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 02/19] iommufd: Add iommufd_group
Date:   Mon, 17 Jul 2023 15:11:58 -0300
Message-ID: <2-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 57871668-c2fb-4452-74b7-08db86f15de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBrzg1dRpzCUCciAHp+8eAMUVBFgw/ts7Og/gWR9rqXFEzJXfQ+hVP1mz/rbwzh3KGQbV+3FcuId9wNeH5GXhQt4sS3Eo4Ulog+Z11CdFsEr4RzI0iPTVLaNPP4P3ii71np9xIjLRUFSldQis481OXmT5f6+mr/sWzRlS/tWTO2XmBSXJsrAd7tmQQRnG2zU3jS87jS3y8rOkJIsy8JPraBxvYNG/YhHfLFptnxqv7+GBGFKsTx/d/GtWoo0YgssiE1fYAHicYtvq/n76tcjLZDFHRSsNtEBFE8MmU9QOrQuOR1LPQ5oOG59ExxDo7eRllD/LhF/3Q6OcLahxKkAryRF1eqWgw1NzzRfO6MjSLR38b9wIMgeIjYrE6etfblevg60bJzaxubNl05u0Uivyk+vuNFYQh9d4kQCB5fG1pwSZJ9hFURbTsqzq8k2JUs0v+lp4mTWeUpKUDyTzBg1J1XfjZ8TAd88Q2PH/tNMmTIQRsdHHXepr00GlLiVTHR8pHhEN8cUb5tRChc+XbJvChINdM1QvQugwtV3qA4GSGplLgXPBZSYfeKCPt8kc5/cSno2k5ibD6WYi4DiRmsQdBQ0qq10QrriS/sj5nXbwvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(2906002)(54906003)(478600001)(6486002)(6666004)(8936002)(36756003)(8676002)(66556008)(41300700001)(66476007)(316002)(4326008)(66946007)(83380400001)(38100700002)(86362001)(6512007)(5660300002)(26005)(2616005)(186003)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?huE3dAGu06H1olPXtuWPxLyTZ5eN1qQGnXhmP6/JMMaiS0XXPD7Hylt1zJ/m?=
 =?us-ascii?Q?wcO07oTz36WlI4jNaNQoe7UMdG8XGNcwA2Du2pZoXVnvmCQ5xWjx/tLweFEk?=
 =?us-ascii?Q?IlVWkuBs0NJuOB+x7s2ZhxC1OGOowjRKAed7xBu8nrpJE1ZBNljR3MR48iHw?=
 =?us-ascii?Q?k/9qCRYfjT8Z7+zabTJjUphgfd5xyXqBJpkY6lhyU0zowVv1nFFc6b14InaC?=
 =?us-ascii?Q?Va7GHVQmfFpO4rqXN2ZLFjsQqG/+bZLghCAi4wuAzLjQmcrZVBXp+KjKIV1O?=
 =?us-ascii?Q?nK91nvj4GS8Qi5DTVYiRPDkZMWBqLmjOhJS+DH+qbWN9xHkFeOPgWje9xHVF?=
 =?us-ascii?Q?H7m6Bn+96HsKNbptfE/sxG0ZeQN8kMVkxE9Sw1dLbCZi4U3GxrySaVQTiHm1?=
 =?us-ascii?Q?6TOhctYaHoURcgSaGycOtO/e1IRHv48+VwQXfL2rAUkPDoul1/ngJD8ZJDCi?=
 =?us-ascii?Q?jGvDAGH885ncj/yCxgiBv5YkRyHC3TbbWtEaT+UwgckBmkE8oixAbxtxBI4w?=
 =?us-ascii?Q?n1OYDfaLAzjmWNnb6jDPtKHvpJFC74VRP3G7t+HxESZSE5RVrl5+iIuBdhcL?=
 =?us-ascii?Q?DSguG9S+VaQIftXdAiC3QXUqf9EChEOSJGGzL90pUJE5NFQn1FdZzk63O080?=
 =?us-ascii?Q?5RYad3xeHmPw7tMNMcOT5Z+eu2oOhY1paT/FgQco8JI1j44oP4fcrzkJJj51?=
 =?us-ascii?Q?7oPiPzabfg+WKtYVPQVHivvQ9+umpGkAzaVYJNsrdl6yXtbgY5omjACpYIdu?=
 =?us-ascii?Q?BRZJLWUy9NNGqS5NWDIM7YH1G7zMGaQZlPfRxaXnoJf4qHwQJ5h1uCZskW31?=
 =?us-ascii?Q?bTMhtkrSOGxqRXN40jYSqubmjrNKKXmcYFqrnOtv3npp1EBKyMvKbpcbMAc3?=
 =?us-ascii?Q?izcQgtnZjQIYz1FUZfb0u4g+xVN6VKjnfnmRSpbq3ghXt2bZcBm2zIUeSAI2?=
 =?us-ascii?Q?0r/kSDp6bQmCb0c9vZnFEtCvlQhmSVyHLvErqFCboewPGEt8BFr6lvf6UlOm?=
 =?us-ascii?Q?hx9Ay3/W6YG+mukgCm3/VP67GoYM6M5FPinjcl1mx4OfuSDKOF3P9neaHKau?=
 =?us-ascii?Q?dO5ufcQs6EWZypgmp2axhhlkbyOGUgg4XLgSO4LYjwiLnemET3YlxtwXBhDO?=
 =?us-ascii?Q?H+47ndrKjkFmJozHo5mne05bjVxhMefB+G6NEyT0nq+LgJmySTpkBUSOsl16?=
 =?us-ascii?Q?ORJu2umrXD1RRMZQseTPtrZHF2cBnc7Ai78sb2PwDvP0mdiTmh90EZ99JYzD?=
 =?us-ascii?Q?p6RdLvJC5UzV7MPzTZ4SOUmfIpInEbn1KDN67NHMfX9ry7pVold4ixP75zYy?=
 =?us-ascii?Q?TN3UAHKyjkJpH9fcxeXIup2cFd782PGfPLc4gIOB+J5qdAqUa+NTgrAuh39b?=
 =?us-ascii?Q?drk/TK3x4Q+cnb6297x7FPPUFM4gg67nSohTpQI/SVN+5nlW4hAYKsB669mL?=
 =?us-ascii?Q?PvC06zvmrPoTeMZPDk+9R5kWAy+LLH9TW+UP+pf9ROJcx8bSglQoYiSoQu+K?=
 =?us-ascii?Q?dlMivvZlchA6dQxOaLSJkK7OiaNyveOUYPfnhLAnJsWq+rJ9uxKLJeFgE3LX?=
 =?us-ascii?Q?oHKe4EQnSvMK4x1btAs09uidIIXjmOIkZzzD2Ild?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57871668-c2fb-4452-74b7-08db86f15de1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:22.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v96l/EPYPb9TQGTgCjj2Uk7fU3QmdOeQGfmeFs0FjsN6/fBCK+nvJDqkhYcVsMdf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the hwpt to device attachment is fairly static we could get away with
the simple approach of keeping track of the groups via a device list. But
with replace this is infeasible.

Add an automatically managed struct that is 1:1 with the iommu_group
per-ictx so we can store the necessary tracking information there.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 141 +++++++++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |   9 +-
 drivers/iommu/iommufd/main.c            |   2 +
 3 files changed, 135 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 39dcbb5cda7e23..327057c5461715 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -15,13 +15,121 @@ MODULE_PARM_DESC(
 	"Allow IOMMUFD to bind to devices even if the platform cannot isolate "
 	"the MSI interrupt window. Enabling this is a security weakness.");
 
+static void iommufd_group_release(struct kref *kref)
+{
+	struct iommufd_group *igroup =
+		container_of(kref, struct iommufd_group, ref);
+
+	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
+		   NULL, GFP_KERNEL);
+	iommu_group_put(igroup->group);
+	kfree(igroup);
+}
+
+static void iommufd_put_group(struct iommufd_group *group)
+{
+	kref_put(&group->ref, iommufd_group_release);
+}
+
+static bool iommufd_group_try_get(struct iommufd_group *igroup,
+				  struct iommu_group *group)
+{
+	if (!igroup)
+		return false;
+	/*
+	 * group ID's cannot be re-used until the group is put back which does
+	 * not happen if we could get an igroup pointer under the xa_lock.
+	 */
+	if (WARN_ON(igroup->group != group))
+		return false;
+	return kref_get_unless_zero(&igroup->ref);
+}
+
+/*
+ * iommufd needs to store some more data for each iommu_group, we keep a
+ * parallel xarray indexed by iommu_group id to hold this instead of putting it
+ * in the core structure. To keep things simple the iommufd_group memory is
+ * unique within the iommufd_ctx. This makes it easy to check there are no
+ * memory leaks.
+ */
+static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
+					       struct device *dev)
+{
+	struct iommufd_group *new_igroup;
+	struct iommufd_group *cur_igroup;
+	struct iommufd_group *igroup;
+	struct iommu_group *group;
+	unsigned int id;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
+	id = iommu_group_id(group);
+
+	xa_lock(&ictx->groups);
+	igroup = xa_load(&ictx->groups, id);
+	if (iommufd_group_try_get(igroup, group)) {
+		xa_unlock(&ictx->groups);
+		iommu_group_put(group);
+		return igroup;
+	}
+	xa_unlock(&ictx->groups);
+
+	new_igroup = kzalloc(sizeof(*new_igroup), GFP_KERNEL);
+	if (!new_igroup) {
+		iommu_group_put(group);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	kref_init(&new_igroup->ref);
+	/* group reference moves into new_igroup */
+	new_igroup->group = group;
+
+	/*
+	 * The ictx is not additionally refcounted here becase all objects using
+	 * an igroup must put it before their destroy completes.
+	 */
+	new_igroup->ictx = ictx;
+
+	/*
+	 * We dropped the lock so igroup is invalid. NULL is a safe and likely
+	 * value to assume for the xa_cmpxchg algorithm.
+	 */
+	cur_igroup = NULL;
+	xa_lock(&ictx->groups);
+	while (true) {
+		igroup = __xa_cmpxchg(&ictx->groups, id, cur_igroup, new_igroup,
+				      GFP_KERNEL);
+		if (xa_is_err(igroup)) {
+			xa_unlock(&ictx->groups);
+			iommufd_put_group(new_igroup);
+			return ERR_PTR(xa_err(igroup));
+		}
+
+		/* new_group was successfully installed */
+		if (cur_igroup == igroup) {
+			xa_unlock(&ictx->groups);
+			return new_igroup;
+		}
+
+		/* Check again if the current group is any good */
+		if (iommufd_group_try_get(igroup, group)) {
+			xa_unlock(&ictx->groups);
+			iommufd_put_group(new_igroup);
+			return igroup;
+		}
+		cur_igroup = igroup;
+	}
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
 	iommu_device_release_dma_owner(idev->dev);
-	iommu_group_put(idev->group);
+	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
 		iommufd_ctx_put(idev->ictx);
 }
@@ -46,7 +154,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id)
 {
 	struct iommufd_device *idev;
-	struct iommu_group *group;
+	struct iommufd_group *igroup;
 	int rc;
 
 	/*
@@ -56,9 +164,9 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
 		return ERR_PTR(-EINVAL);
 
-	group = iommu_group_get(dev);
-	if (!group)
-		return ERR_PTR(-ENODEV);
+	igroup = iommufd_get_group(ictx, dev);
+	if (IS_ERR(igroup))
+		return ERR_CAST(igroup);
 
 	/*
 	 * For historical compat with VFIO the insecure interrupt path is
@@ -67,7 +175,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	 * interrupt outside this iommufd context.
 	 */
 	if (!iommufd_selftest_is_mock_dev(dev) &&
-	    !iommu_group_has_isolated_msi(group)) {
+	    !iommu_group_has_isolated_msi(igroup->group)) {
 		if (!allow_unsafe_interrupts) {
 			rc = -EPERM;
 			goto out_group_put;
@@ -97,8 +205,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
 	/* The calling driver is a user until iommufd_device_unbind() */
 	refcount_inc(&idev->obj.users);
-	/* group refcount moves into iommufd_device */
-	idev->group = group;
+	/* igroup refcount moves into iommufd_device */
+	idev->igroup = igroup;
 
 	/*
 	 * If the caller fails after this success it must call
@@ -113,7 +221,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 out_release_owner:
 	iommu_device_release_dma_owner(dev);
 out_group_put:
-	iommu_group_put(group);
+	iommufd_put_group(igroup);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
@@ -170,14 +278,14 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 }
 
 static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
-					   struct iommu_group *group)
+					   struct iommufd_group *igroup)
 {
 	struct iommufd_device *cur_dev;
 
 	lockdep_assert_held(&hwpt->devices_lock);
 
 	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
-		if (cur_dev->group == group)
+		if (cur_dev->igroup->group == igroup->group)
 			return true;
 	return false;
 }
@@ -211,7 +319,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->group, &sw_msi_start);
+						   idev->igroup->group,
+						   &sw_msi_start);
 	if (rc)
 		return rc;
 
@@ -223,8 +332,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * FIXME: Hack around missing a device-centric iommu api, only attach to
 	 * the group once for the first device that is in the group.
 	 */
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		rc = iommu_attach_group(hwpt->domain, idev->group);
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup)) {
+		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
 	}
@@ -237,8 +346,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
 				 struct iommufd_device *idev)
 {
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
-		iommu_detach_group(hwpt->domain, idev->group);
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
+		iommu_detach_group(hwpt->domain, idev->igroup->group);
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b38e67d1988bdb..f45615f19798e6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -17,6 +17,7 @@ struct iommufd_device;
 struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
+	struct xarray groups;
 
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
@@ -262,6 +263,12 @@ void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
 				 struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+struct iommufd_group {
+	struct kref ref;
+	struct iommufd_ctx *ictx;
+	struct iommu_group *group;
+};
+
 /*
  * A iommufd_device object represents the binding relationship between a
  * consuming driver and the iommufd. These objects are created/destroyed by
@@ -270,12 +277,12 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
+	struct iommufd_group *igroup;
 	struct iommufd_hw_pagetable *hwpt;
 	/* Head at iommufd_hw_pagetable::devices */
 	struct list_head devices_item;
 	/* always the physical device */
 	struct device *dev;
-	struct iommu_group *group;
 	bool enforce_cache_coherency;
 };
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3fbe636c3d8a69..e5ed5dfa91a0b5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -183,6 +183,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	}
 
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
+	xa_init(&ictx->groups);
 	ictx->file = filp;
 	filp->private_data = ictx;
 	return 0;
@@ -218,6 +219,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 		if (WARN_ON(!destroyed))
 			break;
 	}
+	WARN_ON(!xa_empty(&ictx->groups));
 	kfree(ictx);
 	return 0;
 }
-- 
2.41.0

