Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78E702F06
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbjEOOAs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbjEOOAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC19E77;
        Mon, 15 May 2023 07:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJdwEVlNRQ24eUbfzGzJ1LE6RL1eiBpL1fRxMN76JLilR5SetxSZ9pAXU1qTHyyyv5DRiEtVHnbQ7fkm+7kLec9p6pFfg+jGrCQ1vE23LIM70GsUb8evGhhE4FLQDOZ7oTR24JDJCrZisWxyJgt8cDsvYk5GKyCRueEVy4gTSpb31fTERbScJUq+AoTbpUCFWS+6OPUUUGgjLfFeaAMhxo08UJGrMBSF9uT2xROshuaKNVCpgQVYYtG6mTdYi/RO7f+lJHi9GOa4lTKxYvUZFoRbRTjbaEkVttSi70480nNZ+ALrUZX3woCni3nsCmLf5tkgNAvkv4nbIYHkDImv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns2MTbNcbfvDnJ4GIVxIgIUBBMOWFMFWeAaG2juq7K0=;
 b=m9s2JDqdZ6981+pA9yKhyhDS1hFLgNlDFTAvElRSnivL5DoGCwzmFu9L0dTafqD6eZpa5JsJDxQwp/igKqJFefCiwvDd89biOwdycq/r+ttL8xYtL1fEXPq575Mn1lKD6QZDk5J4cAOQpzkNED/QkTqVWeqrIYuh5pnfYX9gTRKbFLulaMjozbqkqRxpsxx9zT6wFdi8Gcwu3WdJAWk7NU5PeGbmlbidowltQRdzFIvEeIlNE9XE1tY6dG7X6f4tmJCEjc/j3eKbOggJBPF000mpAppRcVSCRGrHAprZy0LjgQkYFiLiJxLDsRhai2YRM7AT4KRIAUeL87IDSLTsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns2MTbNcbfvDnJ4GIVxIgIUBBMOWFMFWeAaG2juq7K0=;
 b=Um0huJtv9nSGqeLfxuqxK5d7voJnnHnX/3eLrAut5+SO++4vO9L2T3vrhdQOtKCy/ZbdMYP+cqFIgZgQNVgke4AIEtBuobWEGGwIJvn1w3xR+9apQEhpMUQkTR5o0WyYgaLVSXaxLG6OkghmGXJAaebTfz18Bd5bxU4Vgxx1ed+oK5gHr0g7sg1i6S+UKOmjyxGtTV/gSRR3nV74DY364KrvFUlZr6ODD9sG/uolgvDuYaP06uKKHKQ6dy7kwmmiPmFLcV9PWnM5r8sMekD4ligX/Tqk5LKw8+Sn/0nwr3JgafEmjxf+xLrSjHyDRKgvOVCqPPv5tv6Dq0wUeGlTtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:39 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 02/19] iommufd: Add iommufd_group
Date:   Mon, 15 May 2023 11:00:17 -0300
Message-Id: <2-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:208:15e::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: d8eb6471-8239-49f7-41f8-08db554cc16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UwLy0UM39vPsVpNzzCS77CxXsmMKQpWWa04dG1WawvpLyvfLsOpx19DYhpuDcSAil9nGGhNBfTMLl0Js/28jpIhN3LRC7Yhz6279hUz5prC8Ex0RHoyDo5gPTX5uUt6TqFnL0uHi3/q0URi9Oewv65AMZxGJnT2EAvTXhjpaI82/OP3Z5VJUsj89Wz/ljYrIF+4VZkkX9dQmCPrnTk5CgE/Im22b6i44qoYrWXvMpSU6rBnwSzne3SQRrq3tRbwLmYUxUiwOoQ2rWPZ5n3UCtac/1GATibybowFMuy92S58mcRsnYUXu6TWaQOoZ1imJHom9mE5gHW+vtIFHNK4BobXhm2XLCAgAapVSPMew2/HFsrJRum19Mq25CvZwvNbKXOQGXlZ1Kv7gyQb0wcR1nCOSGxGSev8wLq5OttyWBsw2oEd7JNV+Zsjh5dEUlK9jl0KRlQbbD/Jl/048h1nkly4eYQberkVPKang+LqU1OQaQiiqtxS01ETb5qYSCOafxemDAtasw6Zd0jR2otW6U8meHAb1ZkDGRg1gt9+44Cfgln4ZKs/TA6ewQcMdrEBI9PUcrbnlTPFzakEUkE1WNfFQl6j0tEsJnVg9E/fFBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XP9FJJWw/hrqf38mcyE8n9X/5nZrhc+cHb6fzmbjQxXDqjAQgInIid260VRg?=
 =?us-ascii?Q?hN0JHDbyu1asplc4EXXTzixknTYYNpQubuIIYYk3gxErK4lMzWxth8PH40bO?=
 =?us-ascii?Q?nTMfQu8PSYO3eDoO/UTiaosUjUh0b3uC4zQCcRz5qaqm7N09x9jjnQsULYO2?=
 =?us-ascii?Q?ewCnVohYeJblZlWwKygbnqhOrYonwR7YlsAuGCifzzBolcg1M/mnJfIo3h1w?=
 =?us-ascii?Q?12eya+HWoa2gc3oRYPlKTf+shYPoGMxfu4at18irTkCn1Z/NxRc27eY0NDvA?=
 =?us-ascii?Q?drdFzozT8XDRLe7oNJrwXY202/ePNwjjdeYOXH+PPLNhUGrk7bHALiRJqD5B?=
 =?us-ascii?Q?MHGTWBLA6U6u/zSr+rBOjlzlp2qgmMF7wDlm0b/EPVNhrPyrLBomnSEe2YOh?=
 =?us-ascii?Q?N5crC2WMeyaL2u1STsy0NajmY3CpWtZvwvz9koJ5QuWVjNImAbcH3qC/8uVM?=
 =?us-ascii?Q?Kuq1v4Q22DOCf8JnNfzPMmSClpZ+hI/54601lpu3C2ENt36kgzGImr/2D+82?=
 =?us-ascii?Q?MjriQF7Dz4oniTi81enj5q6VuhZgeyjsSLDa1Qvq2WMkproeUKH2gVvOldcD?=
 =?us-ascii?Q?tnL+/OEEpJwQZ9CyXBe1W6wZnVaqH9pk4322qIqHtar4c1abArYVVTSo+0Lh?=
 =?us-ascii?Q?6mNKlkbI4DwHGA191YESZqEW29n9a4sY2G8nGRYSV5UBTJZ340VbvX93O6VL?=
 =?us-ascii?Q?lLnluSLmNCPZEMSK8qPVc273brgo5Pt+iVV6hn8AsucC3MgwRrZFh2P0vO9h?=
 =?us-ascii?Q?6MnZDwKUK61n79+eoF1JohIJfgypcXTxlQyKrvbHjCUw/AKLT5re9mkqibji?=
 =?us-ascii?Q?bp4VS0h7ddCyBLzDgCEapugKZpQ8i+bTsYz2nVcZwh0zc16iEgQcYHv0euvm?=
 =?us-ascii?Q?33223a9CmrocwWEuaWfNH3acZfKKWQL5kfDKy5BlGAQfFF0ijZOzKZ25/2ai?=
 =?us-ascii?Q?6hUWVISAZpfzqldhqcgfxt0rR7pEtTOf4IBOnNIfNL0JTrjpcQDBl4lMfE7O?=
 =?us-ascii?Q?czy34zopRGwAImRvq9Vm703Zxzn82FfHGvBgTtxHMWFHZigL+oSO9STCMeD8?=
 =?us-ascii?Q?+1XV0CpNuTMUxhDxwWcuzXIDPrc+kHceDag6uOqQtLOzW4z4IBVPbvmEbzVS?=
 =?us-ascii?Q?9w/tQEAXfvFmDNxRtsPzUziKwQUebQDcmwKf9/EgmAZMp5MNTVg34446Y58b?=
 =?us-ascii?Q?r0dyNb9OYeQbgecZ0cTciyPv316t0za+r9LsZ4TBF/SF2omTG0P+RAJAunWE?=
 =?us-ascii?Q?mMG78GzlblFPjSa91bt5Xfu0LaO3FyjpaIEUZ6c1ptzl2b346GhAi4xdEt2M?=
 =?us-ascii?Q?xXhNo/5FwOnjddBUc9QTJ+F3p26uRj9f+8QFu/BcsJwy5UeT60+ZIRv3IO01?=
 =?us-ascii?Q?BirV/pNzevjsRtu+h9+/PaEXIXfkDkl5ipvNnJQt9VYDUzr3waon3vaE8E6l?=
 =?us-ascii?Q?JW7FUJZa33L+ql6k/Q2Wpm3W2A6ZwiEVlk+CLW4rH/IeZPPSib8zmqHKzmxf?=
 =?us-ascii?Q?oKwKAoYtEa7GMhp39y0nvHk72nKSsTXb7zTD+UhuWnLI5saqS87Qh7JBDgkM?=
 =?us-ascii?Q?2BtT+DMaY1U8JCb+7ZdudOFsaVOVNwDTYgYNhs0u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8eb6471-8239-49f7-41f8-08db554cc16c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcaeJ2IbxaprmBSHreYIwBkAJFTWXCNgc+P6YzG71Oz8qBmjSIC8nVZzP13id2El
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
index 927f2051715f64..8c27f6901446e8 100644
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
2.40.1

