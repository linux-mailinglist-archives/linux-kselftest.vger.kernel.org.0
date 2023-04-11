Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932376DE142
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDKQnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDKQns (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E565526C;
        Tue, 11 Apr 2023 09:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONRGkcB3D2JDc+eLIhMITRSWtgWzA7G0t19zQ84pOWDBmVb01Ft99tCsfWR90In/jWBbL1fjlyyO3/DWPuZnOefUV9WKK80qZeN4eZoIarZWgR5f1imyyjGqjXcYzc3LAKeUXnyFGvpRjY1j+RK45rONHvS8Ox/R18z82DP/9r1XglhP28dhsTihKixKzElRLmoWQIOJd2n6Y4oYfSS1WWYp1gzFBdkJcRshf82e3S2q9e5nj6Ph0DYVw6OcKPm1NewF2bkQUjiJZn0U4SFFtwAlluJcS66EVPm5yQ4/toVwLzEy91ipjkmAIfbiT26AkaWUc1FpUZ1FCG8KZnETfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZKnolzfT66UVjhCW5P9kzq/7vlXczbFBSK46RGNX3A=;
 b=RqFaqhpKG/tDRJy/u/xsyBBa8GzLFRq1XcuZjSNfSd95E05k1TW7vnQQzaR3DkAOtZt9RITFNcXausWvICcxNjrrlJt/rt3kE93zPjCwyTm/5tIV+tgXt1KLvCF4BkQRW4A7nc5DwGod0UkaU7cMGlW5oKQfum5l+a/HzIXHf2/pcizT0fsU4PiDFMYwpAnB78l99GlMwq68bXPtVGNdbhhk5iW6UvdT8ljkOQYf5JrrKVd/hUZiUGF2lf1SqeOIUxaW7MvHz1f9jr7nMHGB3LRip3ehaaRr/6aJwZb+fxPlFo85dQeA6jgOLwo69F1dmXuI0cb47N5LvlMYlBacHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZKnolzfT66UVjhCW5P9kzq/7vlXczbFBSK46RGNX3A=;
 b=WiFhodRLXZ9skqEHkF+6tEcMykjk182FfgK3WfBJ/QQ6xakwqPhBtRqiGDEpXQS1YaNhMqdHuUwAftCTG/7Ss95w+RsD0AlWUTqwMi3jcp0zZNThtlefpFf5/zXESd88zXOtDLcXS8ACKOGQAj/buzG2HnX7amCrJb/oa+gsWN102McZpohqKTKUkYTfwGv+ungDn8klx2VxP3mSCPA8FQSW/krq7qJ4fIPP1mmkmkiOgH30RDodDhVkt9R8xel2yN/gmImBFyC/7ZBeT7lDFGVGpEiDID6XVuDoVJceXeV1NwRcr7p5Tg6/Il8j68IsCwsvMAEhU8EN5tiW6hNljA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:23 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 02/17] iommufd: Add iommufd_group
Date:   Tue, 11 Apr 2023 13:43:03 -0300
Message-Id: <2-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 661b45a8-44d2-4efe-cdf3-08db3aabdc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eehLm5lnsBzOGWYVaezJgpenm+sWNFHJwwZ6K2JDmNKpfB495zrOq5RY4ylFTJAvfwUtKvfbWxpFWlT//q/tbUWN3NsnlZyN70ZYLF5jewQ9M6H8hJ7sNf/QTswhOQhzEYAOpcTN1T59MGMaaqNF8CRSzPk2psdJZXEc6kar2rqFAYyfbbDxXQ1Y16MgPI+dl2pMGhSLwA+LOBZvXyGtVbvk6FHv2dpVuKeWEfTmhrtuQVLXi7GyxIkBAbA15jy3OZgBrwY0v/UT4pbfz7srpHRNhz7V7j5O6X0Wi5Zyjh1AepUbsG4rgtCZiFpPOaHSpWm1IUY6XZ/nwhbE7PQa3Sb2SbeUnxFlvX2/0/TPqMCWQL+73Q1bznlMh74PGwSo/5M1MlpGul50wCMePacZv9Mz8PBzmjfTOMEZdplzlp6b67FxXNr/SV4Ef7726NDYCMQL4BEhkADfNL7BN6SVeBpg5voXuaCJAFsmTOt8bwoFnOyctzf+bscVM1LN+32as8XiRpTxdZ/uvHWnQK9Vsxope8ZlxxFkuxUk2P8NLVQ2fI5Zc8CcEqTbrjRbF+0PgxH+ibtjPRtDfu5r3EntUIT5FCeAjw4/O8bmOZG/+Wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vatV5KZQsx2BGP2gwDs6D164tQJvmE6H/B3tWJr/RUvf6TxwMydPhNibvU4Q?=
 =?us-ascii?Q?FmvS61CF7SMAPZ9bPk+5sYmurV/NLXapwUv+0m5qgEAYiiNYGDkPs+MqX2Il?=
 =?us-ascii?Q?rVxldiyQnyRIxWpMLUXK/mD1xuMcQY0TRCahVRjjdgr4woVRFvl4rRjYq4Ey?=
 =?us-ascii?Q?PZ3h80oH7yDZy4pRR2qDPEZY/4Zn2exBPEMfDc7gzPsIRRYHrvGhKnoFktsl?=
 =?us-ascii?Q?hOesDfs9iAv8EVR23U4XJrJI1piwDS2yX5m3oJERzUZ6qLf4koanMBfxuHMh?=
 =?us-ascii?Q?S48ZQof2Ifr1l+DwYBdCZ1bF2l80PEAR5uxFWjUjBxCIH3VW2Qk4ZJSDvetI?=
 =?us-ascii?Q?HgjqIeqFim28l+0LHDGO55GOPvgvb7F8aTJaJTh3+VRgceL5LYiKWqM0s4L9?=
 =?us-ascii?Q?WUCcN+tdjJqfmyDn2JLy1TtnQLwkkgffYFlELpbN3n28HCWlsodOGNKcLXHA?=
 =?us-ascii?Q?Bu0NdFDDAIfRQ19IYisQuCE0MH2S/QWmqjM/ooA6AXAZIw5xnXNZ+fuUU9Uz?=
 =?us-ascii?Q?vPNDqwMnTKHOeTk9g/8ei4chzmHa2QSoloVINrUAsXQgpio4v2vUiryAd5sp?=
 =?us-ascii?Q?zI/AgBipjq9ezwHTohSQdSMQRm8V2hKP9WUx2cKqAi50CzwTa6lDrFUFSISx?=
 =?us-ascii?Q?a5CiWTfB7yhoFXQCt/RApvlFDcoRlogIZDxd4YOxWad8buV2J6Yac60M7CXv?=
 =?us-ascii?Q?Un6ubDZ9WSmhp5mSDhlNNoqd70MnkCy+lNVKGWtLCbE7nARvw0JkhCJP9039?=
 =?us-ascii?Q?MoMAgnzmqG2bkD5yBvobrRnrMTeBl9VXJzAgQ5CcLhsdQ8pxMvOxH7Pl1vfs?=
 =?us-ascii?Q?tNtw12AbXzedjP2k4Rd97F8H840iyH+8ZlsMoSq2thn1JVD80qSy/8G2OEIQ?=
 =?us-ascii?Q?l/mhWSlJlCOMx5eMQHF0PCyVh4wN3KFo+g9s1uf6pZ2e+DTXhH5mNS81HqBZ?=
 =?us-ascii?Q?0Nh4BAlK9fuA0hUM+IgoKAGrxN/6dbfde8N4T5Ul2RWTsC9K4dcXOiTFQoQo?=
 =?us-ascii?Q?aYWlO/oX77Q8YIr12N7eqmopQUY8TB35Zg7+yEOhOUblL0HVy9clEJRFrJP5?=
 =?us-ascii?Q?ECxoUVf7nP6VYanifZQpzpURP/URS7+2jiQxGL2w2AVvQ7bx+UKi5WpXGoiI?=
 =?us-ascii?Q?q2yYTARaC7hH282s9klGIKxrSQtKaMGeRsjZsZGiz9UvNfsA4/u5/OYFhViE?=
 =?us-ascii?Q?5h00wxPqi5cl6XhNb4SV6XAb1Rbm5MvvH8TBAxYAn4L3f5J8+jxD8pZmlBJe?=
 =?us-ascii?Q?p8tMkBO7e2gPv1IMgb022GwfDpeu9am8m36TXjrfVIhvj05F/mSRy8CaMoI+?=
 =?us-ascii?Q?kD+jeFD2DSIpIYkKOydR1ohgt8j7z7NpIWW+tumra2TGL1FR03kVoxvhVQP0?=
 =?us-ascii?Q?8Z8lJXabk6Q5kEnz/1oWU/pfjTScc344Re7MydogmQdsKAiT9XNvAGFqqAeM?=
 =?us-ascii?Q?xPp04dC5LVBwkqnFJyAjra2hWJ4VnBI7pIeLEvzQ6no6i0JieF9rXFMaB2rW?=
 =?us-ascii?Q?5q5KsOBqqpoZ756P64RRY/HU1/tFtjbUteZlf0lX1UawclBT48D6KhFmtFnO?=
 =?us-ascii?Q?QlYTOXNj+vKmmgA3u+di+LwpQ4PaZk0prlO+S1Xp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661b45a8-44d2-4efe-cdf3-08db3aabdc9b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:22.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQATDTp6CjwLGTheFxtrQQEJB4nq9G82p41f1q2MooPmNwXk7+jF2ONFbzljX1uR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

