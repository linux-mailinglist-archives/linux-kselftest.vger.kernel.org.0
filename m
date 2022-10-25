Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3870E60D335
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiJYSMs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiJYSMn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F822B7ED0;
        Tue, 25 Oct 2022 11:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOOjn0QwX1ipJpKGYFn1X6lN/wqjNeRJlpTtrFyDf27O7yPMnIuntBhG+/Hyn4oyi10yyrCw38WlFOOlaDDAjb6CJRIy47TLV4aJmaEvSNQOn983+hnlzh3VHury9Ytfr+szCGZ4YUccWufLiBU7515yCEU+FynwrWzIQJjmlzIOYC/c8dB3PPIPh1Q8AJsXclmWS1s0VpRmTrCG1LolP+UPpgjaiXk0IC874ppdo1dakkjnZg5eTLwNoPivR+4Z3IEAizrJp7BiCs4YevJx+VUl99OEslsZhR3aRNkTpK01u6c1Acpv6zZeiKcJACFn7BAaEW6EminQ8OUc7oGZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i/P1q03QfnoK4kiUL8HgfSbsunbv30zQ7EeRDcqoMQ=;
 b=h55OaCTOym+blc5+ZJOJsGhXYHIA2IbpjANQAHSu90Bab3f8fQALGX6EI67GbIhj7nsPWjYJ4EIgsvL2TRggnL26ETSSLmwPFqsL2DG7g7qkonS2NduAArH9vz0121M2kQnRpmx9a+vSyEbwdBxk9BYiADS9v75486J2T6yHmX1IjOB8w4qwnOF4rwlzw/8j7Xtr0Ohsrig29ngum6AbLlj92CuzJr4ANoAXqwBojSWHrlJ8vlWSTHT9pb4ZZUm3AcPOT4JZA6qGnCMiM66h5xsvvchQgD/E9CP6WWtNIqOqMNwqBWqkpiip5FNGrR9qKHHPlzIiWGTH8q2Qj72AMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i/P1q03QfnoK4kiUL8HgfSbsunbv30zQ7EeRDcqoMQ=;
 b=Gy+1PnTltwVUDfWNUrWSfTjI2ukGBtEmilp1UqxNxON2Lj+Ce5LJXlitT0aH2ltkP5J1eznQA3GKaJKNN4tIVLjN17qs4BukGY6X0x/RclCjI1pajOx9tjCjPOiaSvLY7xvhHlwJEcklJ1YtPtY30y7uyDZ1brtHbQGkflTO8d3eklO6xM0mZMlfP7RYtLWtD9IKDOJnu5HXy2pH9DHAskDbFzF/mFr3fpKkd7K+3esClAOV4w2tKWOOInWEjinkES3phgnYY5lf10mHpsWp4dshS8Z4eF33CnaqaNv/5QMOUlUDw56BoU7XDpZbPt73ST4BgpuRjCPMWd4DvKi2Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 18:12:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v3 02/15] iommu: Add device-centric DMA ownership interfaces
Date:   Tue, 25 Oct 2022 15:12:11 -0300
Message-Id: <2-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d869c03-30f9-43e4-ba3e-08dab6b478dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27jknOMBuHrikbPBvWzztW3ffSe543JgFfjEx56HVHfBf8eotvYnY2c7Od0A5XA3yyWHONrFlB6+NGTxEYHviFVKmJ8T0bVF2ioqJ2eB4FJA0Xz67kL/IfXDRPDSzIAC07se5MrCe3cpUCpxMib6bliWlRyCMKKZeAi07Kw2+dMGlvMHPgN/NEJ1Lan+/IeBYmyMgvQBJIkP8Q/24xpmaulbk8zmLDZn5Jrtvyjg+WS1ws1osZeO4rPC00oaNmJ2O5+wqgOsApk7ypK/cwWtss3Uf4Iz3I16MWdaCGZM4XvIPLh5/sPTdtR9Udm6XPHBh1u2DcKKcXmgOlW/0097zI0N3NiCv9gGNE1DDRAbtNHwW5MveFevms6CTDdB3tYaX7r3hBFNGag9vUpa4TFnb7MnMHJdezsCg2TTCM0v/fGkWa/heQbYT4IBt6eCkRLs/MGXrgq1dr70VN8wxSGMZv7PeT46Hh+6Z7VDZpD+rbyjb9foyq1sc1QxPFj8EIqQhjX4GYCl+DNVu/P00KsYZlgTpI9o4LQTpUKM/XfiGPcrS/eXUTDK0RaGeRM3auvYprUy2yix1K+YT+jZZI7FMimSRNzE0GrrgK2Kd3bi5mGqpCZHumG3ZR4S5/UQlqMxa1Tp4f+zchvs5NqdC5lkS5MbT+KdpOGeMi12fhhSbyWgTYNYIW8tLnX8M7WYUiYGW0kf73pVhk0a4+PDiy9B8SlUBBCEmx5gLlQ/2AT+t8wowupND42XSUbHAjmaBAFLO2GV/wUGh9y39bdHd1Z1CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(7406005)(7416002)(41300700001)(5660300002)(8936002)(66476007)(6506007)(110136005)(66946007)(36756003)(4326008)(8676002)(6512007)(66556008)(6666004)(316002)(26005)(2616005)(921005)(38100700002)(186003)(2906002)(54906003)(86362001)(83380400001)(6486002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewzDS1knclkL8KVY1ewB2FPMnv0fTE5MOBWVBp1oNn40QnLBs+ZKpxLvnC51?=
 =?us-ascii?Q?SvkKjnMREuwdSuvxUxafHKrgdwYauICwoPIKSdFcRu+ZQj5BKUURy9sR9O5T?=
 =?us-ascii?Q?Bo20uDDNAWzHaCuHKd1kcisUD9ZS8QVzqxO2wz+wvg5XodYH2dmPOswenNmH?=
 =?us-ascii?Q?u+DIq1V7KVjEUgyBj97Kcts+G3UJrcIfERUsFnURwb7JeIXAhaYi0AKqaDOX?=
 =?us-ascii?Q?zdwtbAhq1pHJpRmGmPaGtfAxnMbYpx2JrXnD+CzzcjpqlqBDr7x/3kP2JgUL?=
 =?us-ascii?Q?siizx9IkZN82KT0iwEiGG/ySLsrGhdUx0L5zKbEGuNAvA8lVkICYSSm2MKxG?=
 =?us-ascii?Q?4OYrrjujMOHvRoJ4OoAoOQAgpMDzdd6UKxxbXVHAs48XKAkkspNNPMMrzkJm?=
 =?us-ascii?Q?ComBaqdoRZbrJlk//4EhanzOOWLqRqRb56M9YyYnzDKzEszP82Jk8L79HMhZ?=
 =?us-ascii?Q?i7LjDiOmu93B4rbmyi+O5sZDlPuDk8x8p7ybLCNf6RjZfUdMUWpsJMUGo301?=
 =?us-ascii?Q?X/sbLxaT73uWDk75TceHIXOSOCIJymrhkilxb+8trZ8v4FeA6W/rRLQODYm7?=
 =?us-ascii?Q?iLiJSfTwB61m2lWDUiUSKx67oXeVEA9vayZxqtj60feDK521ejOJ6mpNZc0h?=
 =?us-ascii?Q?R3JJrlV+JWLX7I5ms+fA7bHA7Tg7QPovct6fHko7YIgBnAUMYo/gA7WIWG0+?=
 =?us-ascii?Q?NBHQXmCJvLWvkifhLnPubegBQgLOxe6fI0NLLZjf+ULtZ6FsYSkeg9jH4qJv?=
 =?us-ascii?Q?c1Nw+J1V0YARY3Mwp7W22u8Z0tEuoW+MrYt/7wrsdTjo4aOr24FPoy8+Sxf9?=
 =?us-ascii?Q?8a7UQN7TEU+Sddxg+1nrl1hjiQUGOEcqeOT6ySOg2LUaPxBzJgKfFMuzOQd6?=
 =?us-ascii?Q?BIbSWZ/6bUX3IMDYkZ1cI4ewDBOMTg6C1HZrccweZxuJ4Xuocj0V4NXZUfNH?=
 =?us-ascii?Q?ew5zI86eHRaXdrZrMrTu74onLIx8mGJK6hQXq+ojsD6BSaPcy+NpAopjEb28?=
 =?us-ascii?Q?BOrXk24v8gN0vSYyjAIBp2GlotqhTgzkRWPXow8XqiukeWWWwKAv48cKp5ng?=
 =?us-ascii?Q?jFjxatwiMWk1qJ1J93ujT9tGF/inXCEwHIyWQ902QSVqLlInKG8wvRmIjMeR?=
 =?us-ascii?Q?K9n/98onyzuWc2qznx/e50dxTiVflJ04YpRgdlNXzBvoRx04BVa2aQNq5Xag?=
 =?us-ascii?Q?NeYYRKssaykbiSvmQH3pjImuLTMb9wYIs6Lhi7vwkucdSZbYeV++A/nXln0P?=
 =?us-ascii?Q?mfEXGL3JNiHGL39qEgx/MKYPo0tzjLZsTci9lJu3cY4O/YKyQb8iLNJSMw63?=
 =?us-ascii?Q?ZIGab6jC/WS80c/3TlNrHioYGxxCdoP4/avFJ9LBuNuFmcTjLCXMw8zYZQsS?=
 =?us-ascii?Q?2C+idSQCjMG4PzE2P+PZNok9CXwIS0Zb0qdsmVH2p9uNshNAEYjZZFcw1A/y?=
 =?us-ascii?Q?lrfgmPhW3d3YPi4xMji5fd3PIA6j7iEXJcKmO4lywvbbui5biedJpW5NDiGr?=
 =?us-ascii?Q?afsLpYK5Z7P4N0eGB75J0HR5tnNZUC9Dm32sqbu8czBA7QK/rIArpNiSF2S5?=
 =?us-ascii?Q?etpal6J65g1NV6886uM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d869c03-30f9-43e4-ba3e-08dab6b478dc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:26.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 765rXkg5RaJq2VZkda9TJRwM74bn84OuAySDDMfyhmPp0gUrDedOtxQ2yh0nLvIE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

These complement the group interfaces and are for use by VFIO. The main
difference is that multiple devices in the same group can all share the
ownership by passing the same ownership pointer.

Move the common code into shared functions.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 116 +++++++++++++++++++++++++++++++++---------
 include/linux/iommu.h |  13 +++++
 2 files changed, 104 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 65a3b3d886dc00..e34dde68ae2b0d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3148,14 +3148,33 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 	return 0;
 }
 
+static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
+{
+	int ret;
+
+	if (group->domain && group->domain != group->default_domain)
+		return  -EBUSY;
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
@@ -3165,23 +3184,9 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 	if (group->owner_cnt) {
 		ret = -EPERM;
 		goto unlock_out;
-	} else {
-		if (group->domain && group->domain != group->default_domain) {
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
 
@@ -3190,29 +3195,90 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
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
-	if (WARN_ON(!group->owner_cnt || !group->owner))
+	if (group->owner_cnt) {
+		if (group->owner != owner) {
+			ret = -EPERM;
+			goto unlock_out;
+		}
+		group->owner_cnt++;
 		goto unlock_out;
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
+	if (WARN_ON(!group->owner_cnt || !group->owner))
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
index 40cf2d8393465f..b33c962d7b851b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -681,6 +681,9 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+int iommu_device_claim_dma_owner(struct device *dev, void *owner);
+void iommu_device_release_dma_owner(struct device *dev);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1043,6 +1046,16 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int
+iommu_device_claim_dma_owner(struct device *dev, void *owner)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_device_release_dma_owner(struct device *dev)
+{
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
-- 
2.38.0

