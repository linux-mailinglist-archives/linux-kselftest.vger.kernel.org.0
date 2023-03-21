Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192FB6C3A16
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCUTPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCUTPM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C7E26CE0;
        Tue, 21 Mar 2023 12:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdtATZLH2A1qDs3xLaRhQXGgUFyXusa408pfs2lAo3RakSaLukyMhMKLR/ficwfYMJxsxk382lBotBHrF5vZDkUF0yGXyFZEbSEXXetfSFcL1kpSzg+qbYE2tFyQmlQSuo7dA1zw7d7mSIdvw8cxDtv63PO9EW7bkplVtk512rCDIbJdrqczctnLJM2MR1YihkoeXhsN7JgVZCxxVtiIQQmgJZC2f2ZBcttxOIYXzh44iIQobM+wSG8k85H+Apym2vGzT7Wkio+2N62AhLGJ+9ziATnJBdWqhdTgP8B8xKtW9pfCUdMlKBWCXppDJ7ZQuGqandosD8cP39bqsOXjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZKnolzfT66UVjhCW5P9kzq/7vlXczbFBSK46RGNX3A=;
 b=W73EBIFyeHJKqtKWwGhkNIDTmWfY428saBJT+5H1lTQLul7FV3lkUNu9+7yFOA45BeDJVXMWmfUQdLt4ar1wiZ2LiFQBFy71xYHOHweEHzwtZbY10qui8NCSMxLPru5Y2oL1AI4EREBEf1oiq0CP6mjh9fjQ6nUNzrjvHTfLud8ss959bToP+3z4hmeDaK/l21q040wJF0BXIp1A5ejBIuo8HPA8SA/x3G13FWCiU9GQR04NMYFjiFTZNvYigd33p95+IJ/ycVgwlGQnhCzL88oWd3KzJWmXotdbD3lI73jJO/8sNGhrcyiZ8cpE0HALArN3G9bkSnlvNeDqEToZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZKnolzfT66UVjhCW5P9kzq/7vlXczbFBSK46RGNX3A=;
 b=l+uLvGpiyB9lgl7sPAMX/a7tvI4usyLZNCq3gbBsnn1wtEapxKdx4dek5goowhydWk70wITIVBcDHx+lxXR6sKgDD+Z8o9ka5bPisFNotDGBasm/9cuXrWwtjDdzgsSMgnxSQMTQ5jgkj09ZNjIweM0uprZ7AeNDVuJ752vBml9RzG/Wq8lGnaO/pFNAQSArxFPeLjBKTzbd3FruMM9a3T/d/IGaMM7G033hNIcLNV9DGLbtn5mGz880xe2Fz+tW0dmWdTbEIgpOdBhkOkLfpgVN+/Rju4vC8TGX2xB0CfcdTwHkn1z1cMa4thuP9qCAcCXLB3BTLgr4NYGuW5I5oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:55 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 02/17] iommufd: Add iommufd_group
Date:   Tue, 21 Mar 2023 16:14:36 -0300
Message-Id: <2-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: d5164277-0f31-4052-78d3-08db2a408d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjbrgRhyDR53vrx31nuVP7lDYrUrX9/9iXrbX/v+VqQb8Tg01PLycPT0Z9inqV0Xem0qNdwA4W4D6RwKkH0VwW3ON0yE0axam5Fc1Eo41GjGzSPmesU5C6+/WwtJ2+KrnRdJYU+EBs4ziyiUok/wbmdJ31XRsoVFsBdj2ajcLDzOwhyiXhbaeLclcBlebus0kx3g1DyqgcNGA3VAagigkXj+gNHm1GFVipu0+EczXKAScszuV9BqPY19/QJ7shFPjtd6KHfzHr3CcAc2RQujhM01k33fDtwdDMW74mPUxdMKK5VFnqSLiVmoNntQ3xaSXyZ5cDpXH829KGJ/jdodJQASpZUgbERcONkFWdY+IG2Pperx7L82EpgkZpq8DWhmM8ly3EFT6om6gGukK+WrHAtkXT1vrsXYzysgAdigp0n8o9cQuOUpo+Uu7BoyCJ7QKcdFaFMUosNiO09tdeuoM62CwNLleBCSBxujugIJIzuxIepoK0mzlFoZQPCwia5sQ2vxN2JwIoObXJlljwPTzbUVUsLshm1Sz0zaapHAqKlcJxB6umXze66wPOw4g0J6/2MbipW0i3XFZkkbTAi+hsdvSZj6YD0Hqyt3oWruaCPltlvWGY4U54p02DDyEmXC0sGo9/CTNMx/nTS6dWTFYLRvWNgXUUd5XsRAH2LQEv2QiiA68WXBdR0eOoUviNoy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rtwdPerykrR/pwd7geSSoSks/ucKCsXsyeB4lXVssizj+e4mGrTPu+VWdTZZ?=
 =?us-ascii?Q?0Ghk97+2bVLelakCic45f2LQS6XncVKTzPbW1yxKrcBE9fUXjXqDbf9noe2N?=
 =?us-ascii?Q?z7BTBvzVl9kyym/3k2XPHoT5+yWS53wGAPf2IZds8MUHTLzhmW0A/rm7JZ3M?=
 =?us-ascii?Q?c4KKv+IxddglaMvzx2VmohEob0jbJArQh/AgtyWId77VHcPEaFc8pBjRYL7j?=
 =?us-ascii?Q?NByEBPTll2lPmut7R45aC+OOtcrEBC6lLSVRbRdv0j+GCGiS3mWNgsQw0w7R?=
 =?us-ascii?Q?6S2s0/v5CmXQwiJWD2/1JG+cB+6DIoeeomv1AZlHzitiZw44hBVuHG0qmsaC?=
 =?us-ascii?Q?EjH1g1QeaKlMdNUk5nms0CXS5bQf0/wmW0/hS5k/wiy56/Zp/7Y/dJfAgimO?=
 =?us-ascii?Q?gCpm2HAAyk5tQSaqsY0kBfJyr4byaFF1dpscm46zS7v/yqE4sHV1REAL639Y?=
 =?us-ascii?Q?1vKLVGJFdELHHzGnNeVbqca71AmgRr8YLkkIzB4bbu6GM2gr4CGSr/rzXgm3?=
 =?us-ascii?Q?00sNVxyzjDBAxONVDapLSYKenGA8ukjXCQvwgqvB2oexdOvSoonsxvG1sIZ0?=
 =?us-ascii?Q?ClX42GTlBZyJtzjWp60/Kk2vKSxzb0qMyf+NuOl4EpMEk/OWVFzpgXTCYSjx?=
 =?us-ascii?Q?DlS3dbuOtgHVnzol4DIyJxe+UlTU/VV/IZz1lSCZ9ZjcQFk7y3pVgcUdoZCX?=
 =?us-ascii?Q?8McRaM/yeRfyOGbxXqFuKalbTc1I6pRqVXjCVMlg6ZC9Dy3rKc3W9jfXOLjD?=
 =?us-ascii?Q?nyuzCC8ROsN45A70Ht953p418j2XTA/nwXF3mqDl1VRZyMRwEgye1Qsx5PRg?=
 =?us-ascii?Q?XVxbqxeaPHdfPXBVhTsqcBzrhFB2r63oWDwwd/cKOMA9VXObbEGuvVhWtxTy?=
 =?us-ascii?Q?rzt45om++dB+PtBlLARupIRdwyc+J+Hfytj8MejLGfLh5pTQCAGZbWQ+eVQ5?=
 =?us-ascii?Q?KCbAUxpQEvIY26NRASqtSIxFD8W6Afrs/ftNq1cnOc/UPONwG7m+sCbY4I0j?=
 =?us-ascii?Q?ddl6CJkePwbcSrSID0ZGreD7EAEX9XvFUvCCS4ttuDriLj0qMlFEO0AFgEcX?=
 =?us-ascii?Q?f3Bq9SVClXALbWkVh8UOb+DH7R4b3ifSDaHnhf7p8D2GRPt2dOZQN18yf+p4?=
 =?us-ascii?Q?lL2EB+K1mgzyL1wBzZbsH5VcfjpGhlGhWOqh1KO40o7eUphQJG3+Y8EJV0Xp?=
 =?us-ascii?Q?0f1s5gR4t7omd1bKLGrUjWIVR5I16sULFubutYhKdlqjdWevWuPSYwmx0r5I?=
 =?us-ascii?Q?+kpLWCf3ksXX3QggUnPobAB8DRn81sXCb5ArrjvIImgHN+qkbTafJCX0dJhg?=
 =?us-ascii?Q?VerbPRw6fmChstJ1Wq1/AiU3SExi5RBs5acO21rpajmfFIjBCEVCpKtLoKN8?=
 =?us-ascii?Q?gP20m+6CiQAYpE6L4fW+Pr8aTWb9A6wsr+NYp7P6BKr5QhvdBEWtKia6MHUm?=
 =?us-ascii?Q?g/nC9vrwjopnRzjVzzv73I60MZr3HWBqRSFmkv9/P9mthHKa+cfJN3zIeMFj?=
 =?us-ascii?Q?Sw4uQMt5p2RS0oen7Hi0MdfT6lH6MuO1qpV9LezpirsVWbQYgDa/mOmkgKvx?=
 =?us-ascii?Q?ydoTwKH6e+Q9zCQO1CWS2hfg3TDD4/GRYG6n80VC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5164277-0f31-4052-78d3-08db2a408d34
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:54.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0FXXKDi0Hjxj6PMbAftnIDamCuoD32zil2F186THtu64p9GdfltIT8iWqFf4Bsn
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

When the hwpt to device attachment is fairly static we could get away with
the simple approach of keeping track of the groups via a device list. But
with replace this is infeasible.

Add an automatically managed struct that is 1:1 with the iommu_group
per-ictx so we can store the necessary tracking information there.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 141 +++++++++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |   9 +-
 drivers/iommu/iommufd/main.c            |   2 +
 3 files changed, 135 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e66303c17c894c..3fd623208c691f 100644
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
index d523ef12890e1e..2544f10dae9aef 100644
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
2.40.0

