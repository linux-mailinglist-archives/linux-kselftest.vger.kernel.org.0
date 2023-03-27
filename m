Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D26CAD31
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjC0Siv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjC0Sir (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:38:47 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DAE448A;
        Mon, 27 Mar 2023 11:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJzik+79MxRzQowuGLMBCUEP+yxjW1mlGEY9mWmDUdGLWGPUEqh04a6wsmGPdobIeoFugGi8lXAoHbFluP4vhsFcKtcEUfjptEUmA+kiVYGaYSpe6rsBsWGsUv4go3xqjzxEE/A1tQDkAsjkvPxZcNlvHXfeRPODwC1P71p13ohQRquOweEocTXOalKhB0j/X6M1jRqXwcRtVut18Mr7AenA9KssZeRZoLJyHyVfyUrDm9Qog0/8puQcZ6kby8FAbh8uNuiMgTiWky3lxzZDCiAiUBHvcNbHaHU7E7aI7OvVnrhFBXU5y+Xp/bvt9vW1KnjoHXcuVNvi+khUBgPukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZKnolzfT66UVjhCW5P9kzq/7vlXczbFBSK46RGNX3A=;
 b=bWvNfGN8yUXm97754uRrnaoaM7ZehKzRw1LX4WRP15qXPidEIk0tlpN/6ZbP00JPFCSSPxr9s5O3V1/3GQF9aTKW52/TLnyKCrcv/eV9WFle6TqlYFq9FPM7CTCAw5ZGAMhgPs2JSCR7v2E3Z/cVBWMPXFU30i/KxTp5nZ6V1CWizwqg1BT3POJPirmvAl54TBCOlUghImSCDZ9eLeCEoLxjxqMSy4EEXGW0+X+nyrCOqiFD8B7UbnQIgb1MzKdtvPgsurO8SLYWdgG1d0ocBKLb6tSrPmtv3vpCds2S4qgn+McqC7dBc2kN8mBnvrfGpJOFE36imy9RGobLrhS91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZKnolzfT66UVjhCW5P9kzq/7vlXczbFBSK46RGNX3A=;
 b=bb/bkronb8bkV0yb+MaEFu0fOeGO+xmbtNTnlR2m1b76weEccimZJCrQF9CmIhTjqR5LQAG5mf0paSnCjIQY7eEzsLXeNEc9TmpBKUDrcYeZVznS3eGoJRPW27tH41MLdBZrfYmDeq4c0xmEJNDSBPChvfKFehPMnfppk20aUmq2z7GqjET3YyE0uUmx8jgBJsZZLCZJ6Ud2+uwIBieHdpfjrrbpW8/itTw3WlPdB9924Ew2GtmbXmWCSBJfY0XXbOke45R7YWRt8B6+RwsEgJesXQinR3k0NVhp6a+n9gS8D3MpDFwnibjKiOyvXRAc3SvKvbfQGcPNVR+ySakQ6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:14 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 02/17] iommufd: Add iommufd_group
Date:   Mon, 27 Mar 2023 15:37:56 -0300
Message-Id: <2-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0459.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e574cd8-e3d0-45ce-3aa4-08db2ef26b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gzy98e0GFPDZGgRSu+PTVDBHI8ceebWHGCHiSvHcx5RniTiDnYcuSolg5aBRTxgcrLq5oI+zJkTNWBMXNbD3IOv6R6R59MkyreIdH3Ab/9jghzHEUy3mfSghh1Il1uLkIaCCmcdOP8iHus4hKvb4OHj7nJuGCNWr2RNMAWQqHW8DSoQNvRysQvjBnN9goG/1lK6R50kDN7o36mMXexu/UqNqG36SxYb0TN4O46qwtHrGQ4Qfjx1j4IN9r3PO27VXDzd/FrSrXu6gHmlBUdlfxLtzX3V0wnz2el8/LFtZ0eaYVAy9xdVC+DdbHdfXEkOzCNkArAcFxDZCEyhpUMOmyOhPnta/sYUQm5lSxZwPW4Hqv+I+uviLtxbYz5h9Ro4UrcDwSb9fu3qTHj3FKzIGQzc5IagXGcXig1dHPQJKm0LFUtKSzT0d+F2xwjc9QhUBMPGqTEJJDtvRquE0Q1U4xj/2Ry0/m9B6X+0Ji1W+VbTlXrF+tskf8AY9NDkzzjbSCGvnoM2t2Hgf/dKsTFt4Hd5rRi74S1T2pfuH1jdOduGDAZDIzZ7au8bULQsdsZudh2zJfNyu4Fwn2RUWRepVG2/yTVRU/pQkMUIFJz20dec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0GMOh9FqE3CKJ+y/8B+UGL2UaGxbRGSAKlHzsHoadZ0HEbxqLL3M5S+Fk8c?=
 =?us-ascii?Q?2IOutIQABcxApRm98dy/78XfMJ69HLE5+X74hMi40Cuu/lue67XnQJU7opDs?=
 =?us-ascii?Q?QVu2edDgBKEb1TLFgguMr3xHWP+wlWymfBKfbphoZ7d0pee7FqbQeNinPc8i?=
 =?us-ascii?Q?Mfc/5CxlMlzrB1KEt7M5k7Dlj1AIVTBLjKNKcnJ/qrgstkKuHU7zX3hXRukn?=
 =?us-ascii?Q?2B3jRe8k0dZ8FW2Fgs//jvVdnKZv/l6T4CcSDoVx8x0ytPVI89/LmiC6IpU/?=
 =?us-ascii?Q?v6LkWi/WYtms5/rJnrCInUzm5ENMmlyu35hxYVY3hG4aq3AH2gz8HaoZwvql?=
 =?us-ascii?Q?MzDiZ3IUYYrqbD99G0bGizrii0vZgJNmF3Sccpi3kLEAY1OTekh04pI03dsW?=
 =?us-ascii?Q?xobeWmEPIORuWW899UO/yhYGJ058CqTHAPIF68lUYqM6qePdphGU6Ruq+//6?=
 =?us-ascii?Q?E5p2HYaOH/9zdj+q0sYLdYn3y37+DR37W62enzRqdEsEJqteLmbPjspByEZ0?=
 =?us-ascii?Q?7/Uq+h0qcPa/I3ziMo24ESbLKc3b4HkRvkdil5fKddMupU16cIuu9fMnZOpp?=
 =?us-ascii?Q?XaGdxXVe3NGHj3tUGoOKqiavRNR5ZjpCMgNYFhvnGOP3pr41c7uwb7SAOFis?=
 =?us-ascii?Q?sZc+CoI+PVtI6gDM/rwm6U60oOtDshegMAKnCteAK43sZ1BuhJkt7smll7TX?=
 =?us-ascii?Q?AC+z8Q8Flwc6pLSM82Clt2fVQN/jCNvulG4dOO/N+ResoeeFjq/r9MHHVX2H?=
 =?us-ascii?Q?yzhdIFdPCAo1BpTUvuYOrJXxz1A8mDxU1MW8NyGF71kPF74guvYPO+nPIMuk?=
 =?us-ascii?Q?pxtH0sMQwIgFOBXxJOTvRGcBrcm/uxxAA1easCaYB/tvcxv1vTwwjtAmlDRU?=
 =?us-ascii?Q?jq3Jc3nOv5HuBebzMlGHC6IwgNSb3St0h7l9IY1aJkRrF7kA9GM/bqAh9m8o?=
 =?us-ascii?Q?r7PdHCiv+3k8AkBu4D53BT/obXx85/xCWzpUa13HyBMFAN3+CqYJ7crsyDIC?=
 =?us-ascii?Q?VP6Sj6Wp61HEHFM7TfL8PrZ/ET1RzNvdtjfHhkp6R/YlNvefZgFAjpYfk03v?=
 =?us-ascii?Q?Nc3/P6hZZ94TckfN/+subq7InompARAyKHdbe5MebSI7ERdjSp60nai1FR+z?=
 =?us-ascii?Q?27yG5cRkvAbEg6wvfQoW6DlICAgNsxwtMWLmMVv8SQFuJ1u0XzjLHLK4MljA?=
 =?us-ascii?Q?zweY+PLULFqSRyP5g9U5XDCjCgqZZZu61ADQPXu8Ly9sElZlY+ofZBO4LVW8?=
 =?us-ascii?Q?YLnDfaUfDMpXVaiG1dO9c+2B/+d2n72rQxRnnSkks8ptNQTkU1Zi4Wo9jDHd?=
 =?us-ascii?Q?T+rMesDi7TQp4+zDGZpZW3ZLHRPflDp+d1Z8nSuwtB8ek7GccGUjC9FOoKyw?=
 =?us-ascii?Q?o9Xq9uOOYuHtapPisv1gOHLnHSN13WY8xyKYCtF6dbT5CPYFVIRvavoCYQH4?=
 =?us-ascii?Q?6eV39daKE1oVMqRQeGkcgO7wqpfsP/6hneo0SNMhud8KOk5yCMNEHHghb+6y?=
 =?us-ascii?Q?WlOIW/9IuFotnbGZ9EU9AnnTSplfDCv8nWhzPXEoejPR0yjHywMnn7asiJ13?=
 =?us-ascii?Q?Fb8Gk/iQW1H7CbUKM1k/pLILHZ5uk4PA0rtsqqFK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e574cd8-e3d0-45ce-3aa4-08db2ef26b70
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:12.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+YurZomimIF1olYqs6gE6t4XpDI1mLobNnLOqYK/9imlQDOV8Hrh14zuESONaEd
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

