Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4639A62050C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiKHAt3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiKHAtY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102C25E87;
        Mon,  7 Nov 2022 16:49:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmotd4ppVaF1SoFKIAexDBHvEVr1qEV12xnHKtsVLUjs/605v+fc19KVNQy8jXf+ETehCYXUYQbEHuBPaAfb4fkk14y4EMqlq2SW2IQNQNsT3ugbU+ryy65Wp1q+9b2d0jekmDfbaZTrWyWUi+aTqPffGp/Nq5yf6tl1C9l+0XIQkrRV430Me6NyxCVRdzbIO2HAGi2a9eI5O9UGAAJR+1lnjoGKVKzFYxz6kb+ZDYrKXVMHmaTg3a91wqhX16QWWL7SvZII31RTcJju23JFi1sOELZiF0xMtMroJ7/YFZYJVDWvOT6B03LRXm6eLnJ4fFZrXuH2WlzFtm89n+PSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I55hq546h8LNmDOD1Kz2PIYrxvrsGov+vOh2QE/plY=;
 b=kB+Y+lj18RwA8FxybXLsYWP+kAq8LHG1bqI4SIGtDNe0xcWTqIeZBgOlcRXqFFipy87O53rgByPbNRKDV3WZFVKhsr/CptiLSesHZuIEwjeRhzeYVSc/VvvVi6F8uuuzsMLIz25iijMwl0wvoKOsEdiI2T7AvZz+yN5OpF9K8b7lRf01NTsVA7wDT04TtC/YPT01a00xFZ7i5pWMdlHHrrjM3TpSlOWZbo2d3WdGh6uZB2ajQKegllTEmjxkvxw16eVMZXsY99SsR4j47HLJwAFimrBTXVd8LRdOOI7hTgx75VU4UZur96iDBlrhzXJ81vJTq0FmnavjK9bqiYZILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I55hq546h8LNmDOD1Kz2PIYrxvrsGov+vOh2QE/plY=;
 b=ISZJj/cvQDiQwjZ8shs9GJiVhishMKEO7ThF9w3c+eLEqB81cA4u9/LGPgOkJ+nyklnC18CKDZr10zbwDayH/i5C6bBbTkBJht7lqNYHkDksOAa7yx7a12XUlj+79Db3Xk9XHPWPSZLYOTnsUrjhWYkNZIyz+uxT67vrgb8YytwST+Q+VP6lBKm2IknLNW3Ov5+Ma9eEamateo6cijCrogBHRgXR3bmp6N0eHWOsgBcBgJR9pOLPo3JXA7JjRs20Yhkl1f8tWLw2RFxNGFk8Xs3nqnRf89xJ9pD7yN5WI0/2yxjfXjOUmJ0zGjXxe47X9bYXbWJAZY3wDYucBwYhPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:17 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v4 02/17] iommu: Add device-centric DMA ownership interfaces
Date:   Mon,  7 Nov 2022 20:48:55 -0400
Message-Id: <2-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:208:234::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba5baad-25ef-4580-ff73-08dac1230d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSbPZOvgxA9WhOyw9iaKQeyzXr4dH0jDi6vPwB+WODks1pQDwyFLDCo2LqSyDKE+VJW3tpZ98Cm7nqh7evu5Gxsf9R+5ROX4LsUfBi3wrjwoHr9SMu2MDS4+GNJErqxwceNwnHye7Z8go/5Vk51Azxpk3jP3Re8ZSYX0oNuGPJkP2B/Mcaq5e/SAAvuROoAAZ3xbZDxYwvlTMAS5MChYOW0ct4VMZlV8luMZFIBJy5WRYAple/R5YLyS9lOQEg27nr0hggEJQugXerTXHTgurRcFpdy98OJL1ujaahD2ohXBaei4nEK+AwF87lUZ5R7QYt2PaBAlBq1JH++OGPUTf8ynXai1OIDlsB5qWfjRRMN7bQcP/h5eA6fzjYVtiBiWe/dSNoMZRmyFwZjiXKgkJi+2CSW65b/2qIPh9zwVxtYDeKaUhjLKy79l75OpQ+7YD/fKgAKA+kGV1cHBDvQLc5lnOuoch1TJYvRIlhNlmQIp4eup3kQyZpTqC9A2KHNAVHzVBE8Wqc+nIEZLycR//1iGO6qF3szSQ3RW8uhKRnZIVuCWgI5xZU6e/pNukoMRxYL2IuWWm6bT+6No35DUydh5ws50bKJ1QO5NOS9+RsQZlhmplwAoVMPkDooYcqYSU5JLsBa8ucWsrZ1e4q1k8NDBwaNhGzj1dVjknnNN2u0F3kO4uZSR7n+SkP3iWMzrR3jYo2b4gLsUq6QBmfItlO4oMTdFRAcfRbJlfoYiGUsmdjvoOA4FJ86YtBpDXFNK2tLP4rSRTtdI4RU2WSDGTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XV+eNbuGXC+VkOX/C3Kc4SYVUc2ECav66jzqra3sbmFvfmHYvJDxBSXbz96n?=
 =?us-ascii?Q?Ujto4WWFzl4rCEtrLfn8JziZdZl1UXSuOzMLZ4l909l8e1Ej30L4oMasOI+q?=
 =?us-ascii?Q?S/T+4aGkZkLu1s1PbBHTvyew+vugomEoiO0F17q/CRLzzGxKeXr27JM/khBC?=
 =?us-ascii?Q?1jNae5WhP9lbdFR0H5FvS4RrZ2dnAqY5CpzCSJnm2cdVraHBc4+UVKZjQc+x?=
 =?us-ascii?Q?UBXDVFYCs97s/ZBqWhY85atdfCzZIIbbaPUtL+P/YT4sp/RbRncgnCnL56L+?=
 =?us-ascii?Q?LJfm7eLuzrR7SVU4eoCkI7oTw7GxBLzpM5ddp9m08sgHpkF7krLPrSfXaDAs?=
 =?us-ascii?Q?MbZqswT2hcTF2GVajQOG9ea2EsFnMT74YJaH2GPb8cI8bZPbDH4QCupZNd74?=
 =?us-ascii?Q?J+VUbtfUpbtwL98/m+dy/j27iMO/hGcuWzRnmxDL+R/xPXKAUimftAWZieeg?=
 =?us-ascii?Q?ldL3ZkkOqOfIsBsA6whgx3yDTcZESmAatEiVotPW4yQifYvbgDheEgocNXT3?=
 =?us-ascii?Q?HpU33U5GYqOyl/q7jdUTJHH4bCIvCF/xQxrAJIk2FofXp09oOgxkkl7cvssB?=
 =?us-ascii?Q?dXSlYqBBG3lPWGx/XOMicg1BMLqN1s3IHEDkg0ZM+e8fGiCGWA3nm3UoDCcf?=
 =?us-ascii?Q?s80HK1ZafWLttD9rKPQr/9+xD/Ejc/2kfqSKNfJvpD9GKIqciXg6NahPNYZA?=
 =?us-ascii?Q?5pCtP1tETa6TojWJbJntUCBNiMTkENnae6TMr3eBkly5s4mEbPBB1B6gYLqY?=
 =?us-ascii?Q?Zc0JmwXHjugbrqM4INssmgdiPIzobOgRQkssB1lZjXUzHYtgY80WPhPei4hj?=
 =?us-ascii?Q?xDjFQ01pfdDhpSuHgrZ9+WnNYBnzcGOCNwuVr1D3rJelpAb9vPD4icB6v1zi?=
 =?us-ascii?Q?gJUnZrNramXR4GtsTTnrvZW2eVi2/G0V+Y0m6dadjsJxNCbt1fMXqjHjZT+T?=
 =?us-ascii?Q?ZPtOaWIe2C3Jj2iTgJTHk1ruRuaRwTAKwUwM3zdFHtfLLPB41NhXEBN8ZyRy?=
 =?us-ascii?Q?5X0K/xUqyh1HxRcA7q41pCuYsjRtLhHc87sOyhdiO9g+3zDWdCuk2wCe+0zk?=
 =?us-ascii?Q?GXm8xQBrEt6QsfjTY843iSCqQbcFBrebQjef5FMoaJvlTmIiPuoIpfsfrCC9?=
 =?us-ascii?Q?tz+6OhZIwLBSyB/C+Ofn8fL19Z5QmUwuWy81uTwJiiOUoYRvayizRuPyc7ab?=
 =?us-ascii?Q?/LvOh35UN1i/vl/eLzx/PNw1/K+h+eQr1CbrBnNOm7ICij2O3RjEc3W56J0j?=
 =?us-ascii?Q?OzB9JRXopoe5/wS/8WD8DUnAyxcpBElBCd817WthuIvpwYl79H/mYxha6piV?=
 =?us-ascii?Q?4gchijgMeIvU+mkfsgGm0rvQXQxx8XDwFLtfVxfsT8EkB/py/5ewRnXqOjrv?=
 =?us-ascii?Q?IZU3yIcZ+WiJnV0dUnxxasa3a2fu2B66DtAYmnM9VJ5yvv1xa4p+hGpsiwKv?=
 =?us-ascii?Q?7pogkEpWXr+O2xrTBvf+918lgbGHlNi/T+RJJ9CFo3Gr6INnzBHUQHNGtpRa?=
 =?us-ascii?Q?zEMX5M6z26W9msVc2GpV+Ug/hdfqRDiUu78IIb++ULFFJGukzdLKjYvGhp/Z?=
 =?us-ascii?Q?c0P44d2UCTXvnf7ZnTA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba5baad-25ef-4580-ff73-08dac1230d87
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:12.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWiOwuWoJauXGBulf2sntssvRaOwbhz/JB1q9baCCTaam/nCPHFns/+cPnj8c5gy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

These complement the group interfaces used by VFIO and are for use by
iommufd. The main difference is that multiple devices in the same group
can all share the ownership by passing the same ownership pointer.

Move the common code into shared functions.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 124 +++++++++++++++++++++++++++++++++---------
 include/linux/iommu.h |  12 ++++
 2 files changed, 110 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6ca377f4fbf9e9..4cb14e44e40f83 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3108,41 +3108,52 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 	return 0;
 }
 
+static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
+{
+	int ret;
+
+	if (WARN_ON(!owner))
+		return -EINVAL;
+
+	if ((group->domain && group->domain != group->default_domain) ||
+	    !xa_empty(&group->pasid_array))
+		return -EBUSY;
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		return ret;
+	ret = __iommu_group_set_domain(group, group->blocking_domain);
+	if (ret)
+		return ret;
+
+	group->owner = owner;
+	group->owner_cnt++;
+	return 0;
+}
+
 /**
  * iommu_group_claim_dma_owner() - Set DMA ownership of a group
  * @group: The group.
  * @owner: Caller specified pointer. Used for exclusive ownership.
  *
- * This is to support backward compatibility for vfio which manages
- * the dma ownership in iommu_group level. New invocations on this
- * interface should be prohibited.
+ * This is to support backward compatibility for vfio which manages the dma
+ * ownership in iommu_group level. New invocations on this interface should be
+ * prohibited. Only a single owner may exist for a group.
  */
 int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 {
 	int ret = 0;
 
+	if (WARN_ON(!owner))
+		return -EINVAL;
+
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
 		ret = -EPERM;
 		goto unlock_out;
-	} else {
-		if ((group->domain && group->domain != group->default_domain) ||
-		    !xa_empty(&group->pasid_array)) {
-			ret = -EBUSY;
-			goto unlock_out;
-		}
-
-		ret = __iommu_group_alloc_blocking_domain(group);
-		if (ret)
-			goto unlock_out;
-
-		ret = __iommu_group_set_domain(group, group->blocking_domain);
-		if (ret)
-			goto unlock_out;
-		group->owner = owner;
 	}
 
-	group->owner_cnt++;
+	ret = __iommu_take_dma_ownership(group, owner);
 unlock_out:
 	mutex_unlock(&group->mutex);
 
@@ -3151,30 +3162,91 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
 
 /**
- * iommu_group_release_dma_owner() - Release DMA ownership of a group
- * @group: The group.
+ * iommu_device_claim_dma_owner() - Set DMA ownership of a device
+ * @dev: The device.
+ * @owner: Caller specified pointer. Used for exclusive ownership.
  *
- * Release the DMA ownership claimed by iommu_group_claim_dma_owner().
+ * Claim the DMA ownership of a device. Multiple devices in the same group may
+ * concurrently claim ownership if they present the same owner value. Returns 0
+ * on success and error code on failure
  */
-void iommu_group_release_dma_owner(struct iommu_group *group)
+int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 {
-	int ret;
+	struct iommu_group *group = iommu_group_get(dev);
+	int ret = 0;
+
+	if (!group)
+		return -ENODEV;
 
 	mutex_lock(&group->mutex);
+	if (group->owner_cnt) {
+		if (group->owner != owner) {
+			ret = -EPERM;
+			goto unlock_out;
+		}
+		group->owner_cnt++;
+		goto unlock_out;
+	}
+
+	ret = __iommu_take_dma_ownership(group, owner);
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
+
+static void __iommu_release_dma_ownership(struct iommu_group *group)
+{
+	int ret;
+
 	if (WARN_ON(!group->owner_cnt || !group->owner ||
 		    !xa_empty(&group->pasid_array)))
-		goto unlock_out;
+		return;
 
 	group->owner_cnt = 0;
 	group->owner = NULL;
 	ret = __iommu_group_set_domain(group, group->default_domain);
 	WARN(ret, "iommu driver failed to attach the default domain");
+}
 
-unlock_out:
+/**
+ * iommu_group_release_dma_owner() - Release DMA ownership of a group
+ * @group: The group.
+ *
+ * Release the DMA ownership claimed by iommu_group_claim_dma_owner().
+ */
+void iommu_group_release_dma_owner(struct iommu_group *group)
+{
+	mutex_lock(&group->mutex);
+	__iommu_release_dma_ownership(group);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
 
+/**
+ * iommu_device_release_dma_owner() - Release DMA ownership of a device
+ * @group: The device.
+ *
+ * Release the DMA ownership claimed by iommu_device_claim_dma_owner().
+ */
+void iommu_device_release_dma_owner(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	mutex_lock(&group->mutex);
+	if (group->owner_cnt > 1) {
+		group->owner_cnt--;
+		goto unlock_out;
+	}
+	__iommu_release_dma_ownership(group);
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_device_release_dma_owner);
+
 /**
  * iommu_group_dma_owner_claimed() - Query group dma ownership status
  * @group: The group.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a09fd32d8cc273..1690c334e51631 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -707,6 +707,9 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+int iommu_device_claim_dma_owner(struct device *dev, void *owner);
+void iommu_device_release_dma_owner(struct device *dev);
+
 struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
 int iommu_attach_device_pasid(struct iommu_domain *domain,
@@ -1064,6 +1067,15 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return false;
 }
 
+static inline void iommu_device_release_dma_owner(struct device *dev)
+{
+}
+
+static inline int iommu_device_claim_dma_owner(struct device *dev, void *owner)
+{
+	return -ENODEV;
+}
+
 static inline struct iommu_domain *
 iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
 {
-- 
2.38.1

