Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6376E9BF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDTSvn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDTSvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063041FDF;
        Thu, 20 Apr 2023 11:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3yr9BdlyYOJFeoMhOO9Jbi56ggeNxMwRxonCQY9yuWwE/aOZ/x/xB/0PUjxUBe4TqJ9PIJQyuf/aNuwihPNaaSnmDVrQNx9FpUkZaiujMe6HWv9ixVfBaTPEQ0kEjsFh0persdZEOkCR7GkTESCb5R+4g2Z2/ii382DFhsNVvZLE64OKHeyDrfXm3lRKwaxSVDzynXL06+X0BVvLNWShRhZkgJfmKKrgDoJE6hdQDlRcgHSjL4RJiybHKjj1BFFmOC6E8S26swwm/D7vMjLRNdZuox6smGQqRJ9nHhWpDvDGKVmXf9sdEwHwaJd95atUMM1hT5jVK9PLbiemUCBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpUjdFJhp/ugSaQa350FQf2O5qvC42/xKzJjR5Z/+Ls=;
 b=ekZNbo7K3BbomFdH6P4rdyZH8utgHbBteLpI8husd7RLS5jo/dbkfaIjjndhxNefMh86EX58qg3Ar7yr4NCEEbZwlSz5kV7zWzshyW1ZazbiIqRR4Q4Wb1Or1RlHNEXoD+YHXC1brvCGDTk4UWS30tE+0PAOW5T96/BhTWE++tIbWnR5qcXGT9bZFrAvbNOAvsPEQoriosnNBVG2cCmr3BgYxhzLlIfdzJ7v6z8YvS4k3cMca2q/XL5F9heNHUncCfFNWnMgAxchAFK6W3dHKdmW0/q774+E+l9K+Keqmxq7uK62uzrHE6TmYZNEjXKxieQ7wMW+AZcMsIs8MJpPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpUjdFJhp/ugSaQa350FQf2O5qvC42/xKzJjR5Z/+Ls=;
 b=XRTouO0jYuJhZMsWfzYmfhpcc+Js4rgmioNYy7Zc1wPtYc1bNSswIeyMlRlq7cB1sMmnQAtOxSs3q0JqVB3wjiIaedLFcc6zIUHfP0s4r/ztf2xSLNECjOoJl1rFc3iwPHGTp3W5IYaGrZo5spUD+veWva9nPz8uarYIWWkgPZcsq06SV6CDmcsX80xdoUMUuZ/irxzX/dq2iElwYtpK+P/Tnw0TI5QdXG8dWM6bKnExfrbcMOnNRhWJtsOkomBwT4GFFVqgf4kmymAA0UVGwdzrEKkCOxa3uJzqUHOtCVgRbwJ2QPzTYhtct28d6NhXnhvdr7gCOwx4RFb22Zu1bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:36 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 00/19] Add iommufd physical device operations for replace and alloc hwpt
Date:   Thu, 20 Apr 2023 15:51:15 -0300
Message-Id: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:208:32a::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 898a009d-d67b-45b7-ce9e-08db41d044ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yC5rkvaQ7Yvr4h2/n+cVD+17N46KXpnL0GEwFJJMkXf48ax2NAe0STVeHd+MOrLuF3PiSmUgPeGDWuir71lvHDkKWPCdjp46ymPdQlp4K+TkcMOvkw91+6JzbLWiVBk5Z5rXskek+tJNuXWJl1xQJLEjJgLkVAB4ako+rSGGz8CAwKLczTr7X2NyTxRYCpeyC5wU7dBlMJE3Zw/JTW8hNio2U8eM1Fyz22yWvvqUj23exyrJsa6+pNjL0pMHRiZnymY9Yubfar/Sdbyz1gNLjMOt/GwMSFmn1PBVEuyraKuht4pffe5GlH/7AwA6qYfvj9xA7fvx6GUbfq7xddzIPcMmvBso2B0ZLBM7jZX8AxGx5+HQwv2tOHJvuK/+muSmueJLuO1EaBTc8nB/eyb0yNHPs0+oCuD+XKaZcC92eC3A6O1O0J4GtxnPuc/u/fBAwyODc6nsEbD7MuH5KougJAW8k+cH+YRpcZa8bwmZfiYIBahCj8eMY6RhYNomRwgOe6YtI7CgS69GQFcRuA5zWfuBizqqpX6Tg2KbIRlT94QfjxSrIIagwwLkL86v2GfKMIP4SahBiiWFZtdG6P3hsNwP/xFHmqPtzdazKw0LkBZE1QZSXvt65cBE0TaAnSRSXtT/5PC2gh2iRlJd4O0XnBiwUjRjPMQB9fzwK/LDUY9UoSRdX/mE2Iics7acz0Ht
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(966005)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(30864003)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IV/27vT07i+zrdsEfKX4s3A2Xp09XqoX4RzN72RS+IjAeMvsRN7+I3Z6WHBO?=
 =?us-ascii?Q?tk9uFtXFnEkUubfYgYE9k1/ilDcb8v8WVjfBPKP4GHvquj68J/lTbaJ6Byik?=
 =?us-ascii?Q?PNel3O+JjRIaEFJoRlzBnH1tHM9GUPCVflyCO4OFKokf3lJo0lwGHxxCtJGH?=
 =?us-ascii?Q?tfJyq4AUMteT1qi8bqmPE91S2JsmhHNvVY2gbFuvJhDEkYUln7pUggjCMIQX?=
 =?us-ascii?Q?HJ4wLcWbsRRBnSb2li+JrbD57TPQWng8id6FEkcPZ7NxaZn0PXB/4CTXg8wB?=
 =?us-ascii?Q?+dxx+LZJnTK32iLXzILPEAPjjbDikECl5GJ0RQCP+LhuXcPMA56bWkPcCjRQ?=
 =?us-ascii?Q?XsBYfG1NCvFDhY8MrQg4UjE5yfy1unBtBcduseIG3HCPQrVf60Y4FBNptF9h?=
 =?us-ascii?Q?lYbYNzixRfuz6z4E1fbr5H0xsjInV577PCPzPQk7z+5ucLyKjw+JeR21qN+X?=
 =?us-ascii?Q?bAdOFKmQi5d1sQH5ZgUwDeQbto10SAgicQApzR3i1uTQVstdwpti43zT8eoX?=
 =?us-ascii?Q?zDtrYvqS16xKI5gKFsWQ8UP7Bs2LyRRCoLVToltizcE9gT2mnIX+aH7T01Oq?=
 =?us-ascii?Q?HU1l1w3xtAjEQy8KsACaX2+RjUdsHQj+dUb73cdIudUsEFuJT1nGh+Agfoho?=
 =?us-ascii?Q?CEbZADcFT8sPtJvWoQ8BcGuAtiHUMEz1FWz9Giw8ggVHW9xjKKV0MNUYbQaK?=
 =?us-ascii?Q?NQ+eYlTKZLdGZAU0dC5hOzk94Oek8F284tO95Gqwn5feJFosJHbekRQ46kXT?=
 =?us-ascii?Q?55lVu9rDJeU9kQFALFbLzsUUNouTuG08ZB5NGhyEy2LlGL5fwagViho57oYw?=
 =?us-ascii?Q?/5EQYNqdxP6qOQa/fEOfU7vzuCNhxETEBqrp9DkNuEuQTA6acbVmd3xHSi99?=
 =?us-ascii?Q?yixG94VfQGaDS47oX7LhpQQ7dDe6kCkmBAKJXC8Pb6rtfVoX2w7QkV6/j3Og?=
 =?us-ascii?Q?DtPklhx2FNwUo1ggM2rVeDNKvPRR+oTMMk/vk8Gd28v7Xz/bbp8TAW87/mIK?=
 =?us-ascii?Q?J/EvjZhbNCSoWr+gpr7iPUH5crLBCGUYc/5FLpoIjXXiwOnRCpYMPsoYfnHR?=
 =?us-ascii?Q?sYpebXXUfupovJtuePD4cHrKlVqyM18FYAW7ftvGrdy3Fa4G8cfUmx3Ln8ie?=
 =?us-ascii?Q?CYMqF4DSeIjeuR1kOCd4ewfeAqC3lZaAQO0rVmAxwujD7DDLti9YUVpiweXO?=
 =?us-ascii?Q?AWGIPocfxhXBQr8ocWlHxtwEg8Dk0dmrFU7nl0UKFsanVLw54qNqBQ4upqIf?=
 =?us-ascii?Q?wEscJVpeadfXc5M8Csnn9T8o9VZIPsX/JwSw+7lH5SCNiWxuTKtPUbFoDDl8?=
 =?us-ascii?Q?yFOu7uld8LbPc/DTms7HrpBhfw42C8QIiLs02l43s8gW9qWSiaeRhYPTrjO0?=
 =?us-ascii?Q?mUlbeCJh/HBtyoy9dQmulhg9z3K2XnOAti8E1OYK7CXsl+tytUpeOjwxx/cS?=
 =?us-ascii?Q?7FJhCzBKqmeemWSpvHT3uNACPIoGg2+0vlWimHn68pPr1bYyes9WPuNptydl?=
 =?us-ascii?Q?T18USczhzBicstcNKR0rrVscNd9ABQxaEitaGkfdY4XxLl8lpwHht9H1d52/?=
 =?us-ascii?Q?27iDgS9Eg0vRwbxNbdY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898a009d-d67b-45b7-ce9e-08db41d044ad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:36.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJnhYfQUIaUUw4roCJ62URYgHjlTm+pwMRwEADck93ziKLEXQSpfM378xS1bjjoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is the basic functionality for iommufd to support
iommufd_device_replace() and IOMMU_HWPT_ALLOC for physical devices.

iommufd_device_replace() allows changing the HWPT associated with the
device to a new IOAS or HWPT. Replace does this in way that failure leaves
things unchanged, and utilizes the iommu iommu_group_replace_domain() API
to allow the iommu driver to perform an optional non-disruptive change.

IOMMU_HWPT_ALLOC allows HWPTs to be explicitly allocated by the user and
used by attach or replace. At this point it isn't very useful since the
HWPT is the same as the automatically managed HWPT from the IOAS. However
a following series will allow userspace to customize the created HWPT.

The implementation is complicated because we have to introduce some
per-iommu_group memory in iommufd and redo how we think about multi-device
groups to be more explicit. This solves all the locking problems in the
prior attempts.

This series is infrastructure work for the following series which:
 - Add replace for attach
 - Expose replace through VFIO APIs
 - Implement driver parameters for HWPT creation (nesting)

Once review of this is complete I will keep it on a side branch and
accumulate the following series when they are ready so we can have a
stable base and make more incremental progress. When we have all the parts
together to get a full implementation it can go to Linus.

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

v6:
 - Go back to the v4 locking arragnment with now both the attach/detach
   igroup->locks inside the functions, Kevin says he needs this for a
   followup series. This still fixes the syzkaller bug
 - Fix two more error unwind locking bugs where
   iommufd_object_abort_and_destroy(hwpt) would deadlock or be mislocked.
   Make sure fail_nth will catch these mistakes
 - Add a patch allowing objects to have different abort than destroy
   function, it allows hwpt abort to require the caller to continue
   to hold the lock and enforces this with lockdep.
v5: https://lore.kernel.org/r/0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com
 - Go back to the v3 version of the code, keep the comment changes from
   v4. Syzkaller says the group lock change in v4 didn't work.
 - Adjust the fail_nth test to cover the path syzkaller found. We need to
   have an ioas with a mapped page installed to inject a failure during
   domain attachment.
v4: https://lore.kernel.org/r/0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com
 - Refine comments and commit messages
 - Move the group lock into iommufd_hw_pagetable_attach()
 - Fix error unwind in iommufd_device_do_replace()
v3: https://lore.kernel.org/r/0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com
 - Refine comments and commit messages
 - Adjust the flow in iommufd_device_auto_get_domain() so pt_id is only
   set on success
 - Reject replace on non-attached devices
 - Add missing __reserved check for IOMMU_HWPT_ALLOC
v2: https://lore.kernel.org/r/0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com
 - Use WARN_ON for the igroup->group test and move that logic to a
   function iommufd_group_try_get()
 - Change igroup->devices to igroup->device list
   Replace will need to iterate over all attached idevs
 - Rename to iommufd_group_setup_msi()
 - New patch to export iommu_get_resv_regions()
 - New patch to use per-device reserved regions instead of per-group
   regions
 - Split out the reorganizing of iommufd_device_change_pt() from the
   replace patch
 - Replace uses the per-dev reserved regions
 - Use stdev_id in a few more places in the selftest
 - Fix error handling in IOMMU_HWPT_ALLOC
 - Clarify comments
 - Rebase on v6.3-rc1
v1: https://lore.kernel.org/all/0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com/

Compared to v3 the diff for the whole series looks like:

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 024ed8ee9939cd..2770087059ba73 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -341,14 +341,15 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
 
-	lockdep_assert_held(&idev->igroup->lock);
-
+	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	mutex_unlock(&idev->igroup->lock);
+
 	/* Caller must destroy hwpt */
 	return hwpt;
 }
@@ -515,8 +516,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt->auto_domain = true;
 	*pt_id = hwpt->obj.id;
 
-	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
+	mutex_unlock(&ioas->mutex);
 	return destroy_hwpt;
 
 out_abort:
@@ -610,7 +611,6 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  * This is the same as
  *   iommufd_device_detach();
  *   iommufd_device_attach();
- *
  * If it fails then no change is made to the attachment. The iommu driver may
  * implement this so there is no disruption in translation. This can only be
  * called if iommufd_device_attach() has already succeeded.
@@ -633,10 +633,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	mutex_lock(&idev->igroup->lock);
 	hwpt = iommufd_hw_pagetable_detach(idev);
-	mutex_unlock(&idev->igroup->lock);
-
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 8aa9ac130b5960..655ed32144f62e 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -26,6 +26,21 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
+void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
+{
+	struct iommufd_hw_pagetable *hwpt =
+		container_of(obj, struct iommufd_hw_pagetable, obj);
+
+	/* The ioas->mutex must be held until finalize is called. */
+	lockdep_assert_held(&hwpt->ioas->mutex);
+
+	if (!list_empty(&hwpt->hwpt_item)) {
+		list_del_init(&hwpt->hwpt_item);
+		iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	}
+	iommufd_hw_pagetable_destroy(obj);
+}
+
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 {
 	if (hwpt->enforce_cache_coherency)
@@ -50,6 +65,10 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
  * will be linked to the given ioas and upon return the underlying iommu_domain
  * is fully popoulated.
+ *
+ * The caller must hold the ioas->mutex until after
+ * iommufd_object_abort_and_destroy() or iommufd_object_finalize() is called on
+ * the returned hwpt.
  */
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
@@ -93,9 +112,6 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	 * directly allocate a domain. These drivers do not finish creating the
 	 * domain until attach is completed. Thus we must have this call
 	 * sequence. Once those drivers are fixed this should be removed.
-	 *
-	 * Note we hold the igroup->lock here which prevents any other thread
-	 * from observing igroup->hwpt until we finish setting it up.
 	 */
 	if (immediate_attach) {
 		rc = iommufd_hw_pagetable_attach(hwpt, idev);
@@ -140,10 +156,9 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 
 	mutex_lock(&ioas->mutex);
 	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
-	mutex_unlock(&ioas->mutex);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
-		goto out_put_ioas;
+		goto out_unlock;
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
@@ -151,11 +166,12 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	if (rc)
 		goto out_hwpt;
 	iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
-	goto out_put_ioas;
+	goto out_unlock;
 
 out_hwpt:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
-out_put_ioas:
+out_unlock:
+	mutex_unlock(&ioas->mutex);
 	iommufd_put_object(&ioas->obj);
 out_put_idev:
 	iommufd_put_object(&idev->obj);
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index f842768b2e250b..21052f64f95649 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1172,6 +1172,9 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	unsigned int num_sw_msi = 0;
 	int rc;
 
+	if (iommufd_should_fail())
+		return -EINVAL;
+
 	down_write(&iopt->iova_rwsem);
 	/* FIXME: drivers allocate memory but there is no failure propogated */
 	iommu_get_resv_regions(dev, &resv_regions);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index cb693190bf51c5..ba50eb4661e217 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -261,6 +261,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
+void iommufd_hw_pagetable_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 694da191e4b155..73a91e96896252 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -24,6 +24,7 @@
 
 struct iommufd_object_ops {
 	void (*destroy)(struct iommufd_object *obj);
+	void (*abort)(struct iommufd_object *obj);
 };
 static const struct iommufd_object_ops iommufd_object_ops[];
 static struct miscdevice vfio_misc_dev;
@@ -104,7 +105,10 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj)
 {
-	iommufd_object_ops[obj->type].destroy(obj);
+	if (iommufd_object_ops[obj->type].abort)
+		iommufd_object_ops[obj->type].abort(obj);
+	else
+		iommufd_object_ops[obj->type].destroy(obj);
 	iommufd_object_abort(ictx, obj);
 }
 
@@ -413,6 +417,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_HW_PAGETABLE] = {
 		.destroy = iommufd_hw_pagetable_destroy,
+		.abort = iommufd_hw_pagetable_abort,
 	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index c07252dbf62d72..8b2c18ac6a2864 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -9,9 +9,6 @@
 
 #include "iommufd_utils.h"
 
-static void *buffer;
-
-static unsigned long PAGE_SIZE;
 static unsigned long HUGEPAGE_SIZE;
 
 #define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 7e1afb6ff9bd8d..d4c552e5694812 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -41,6 +41,8 @@ static int writeat(int dfd, const char *fn, const char *val)
 
 static __attribute__((constructor)) void setup_buffer(void)
 {
+	PAGE_SIZE = sysconf(_SC_PAGE_SIZE);
+
 	BUFFER_SIZE = 2*1024*1024;
 
 	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
@@ -579,6 +581,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t stdev_id;
 	uint32_t idev_id;
 	uint32_t hwpt_id;
+	__u64 iova;
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
@@ -590,6 +593,18 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id2))
 		return -1;
 
+	iova = MOCK_APERTURE_START;
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, PAGE_SIZE, &iova,
+				 IOMMU_IOAS_MAP_FIXED_IOVA |
+					 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+	if (_test_ioctl_ioas_map(self->fd, ioas_id2, buffer, PAGE_SIZE, &iova,
+				 IOMMU_IOAS_MAP_FIXED_IOVA |
+					 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
 	fail_nth_enable();
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 9b6dcb921750b6..53b4d3f2d9fc6c 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -19,6 +19,8 @@
 static void *buffer;
 static unsigned long BUFFER_SIZE;
 
+static unsigned long PAGE_SIZE;
+
 /*
  * Have the kernel check the refcount on pages. I don't know why a freshly
  * mmap'd anon non-compound page starts out with a ref of 3

Jason Gunthorpe (17):
  iommufd: Move isolated msi enforcement to iommufd_device_bind()
  iommufd: Add iommufd_group
  iommufd: Replace the hwpt->devices list with iommufd_group
  iommu: Export iommu_get_resv_regions()
  iommufd: Keep track of each device's reserved regions instead of
    groups
  iommufd: Use the iommufd_group to avoid duplicate MSI setup
  iommufd: Make sw_msi_start a group global
  iommufd: Move putting a hwpt to a helper function
  iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
  iommufd: Allow a hwpt to be aborted after allocation
  iommufd: Fix locking around hwpt allocation
  iommufd: Reorganize iommufd_device_attach into
    iommufd_device_change_pt
  iommufd: Add iommufd_device_replace()
  iommufd: Make destroy_rwsem use a lock class per object type
  iommufd: Add IOMMU_HWPT_ALLOC
  iommufd/selftest: Return the real idev id from selftest mock_domain
  iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC

Nicolin Chen (2):
  iommu: Introduce a new iommu_group_replace_domain() API
  iommufd/selftest: Test iommufd_device_replace()

 drivers/iommu/iommu-priv.h                    |  10 +
 drivers/iommu/iommu.c                         |  41 +-
 drivers/iommu/iommufd/device.c                | 525 +++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          | 112 +++-
 drivers/iommu/iommufd/io_pagetable.c          |  30 +-
 drivers/iommu/iommufd/iommufd_private.h       |  52 +-
 drivers/iommu/iommufd/iommufd_test.h          |   6 +
 drivers/iommu/iommufd/main.c                  |  24 +-
 drivers/iommu/iommufd/selftest.c              |  40 ++
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/iommufd.h                  |  26 +
 tools/testing/selftests/iommu/iommufd.c       |  67 ++-
 .../selftests/iommu/iommufd_fail_nth.c        |  67 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  63 ++-
 14 files changed, 853 insertions(+), 211 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h


base-commit: fd8c1a4aee973e87d890a5861e106625a33b2c4e
-- 
2.40.0

