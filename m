Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E520E62CC18
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbiKPVDN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiKPVBy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:01:54 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C2764D3;
        Wed, 16 Nov 2022 13:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/nliwOKzUHBcQdGGL89sZAKhO/VfGoBF5yGLnm9wa0wdJz3jSiUOmIAnlo0rQWkGEebEqK66u6R3UQ+bbmqeR0pr+Xk8jFZF5LV6k05cjIFAM0DOgdX6RU/5bLDUbh8x9CVy4XNEBbRUhYZfdkc1sBQjdpNoyHC7y4I1blwGBZBfpxOJQgBThMRXNsufLrb05kG+1NTbJLp508/64Kf2Rc6K8z0qtIcmuDQ1TxIjyyOYmg3MecBlB2lCGLZ18tvBfE4wusVdh5kJZf1OibhrroyOD4J5R4AQSXGjPU8rn/16Uf8CkVhAJNxH+0i5V1NeXwSgUzTQaRHopPw1KTVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/5IoMdzanZlihohIxZq3RVStRxJF7NBwPZO3xVT9Aw=;
 b=E+RIt2koyx1uIcE1D36njNU4Lg9bXuwwfBgMX9vyeVvjQPymnSZkns47ITr1VJq7QMlsXBIOT6GHtfpexFN5On6nKZcRUYPHUUZBW3n6VRzNimzauNQcWxCZABwHTrxa8iw1pjaNIjIe4bIVgDPlQL142XLiROSKDxuR0oL1X82hdXv2UNFlxdL56FUvThkmcXOtKRZDeekjyTm4aC3TB3IIIHhqu5e4Ov4U/CgOrGvTRRrDOoxuTvTOFAhki7PRtohPtifwyhp3+63qdSXsvPyiQikZANd0mWpRGiA/Um3WbV03ZlNm2/1zzt23WBgW+0Te/OKgYwdHkm/T0mjTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/5IoMdzanZlihohIxZq3RVStRxJF7NBwPZO3xVT9Aw=;
 b=J/Xu12puPI4+TtguG1rQOieFSPJ5B/p2XVtHM4h0C71VG7O2qrmOg2rVF3VC2sicJMmauUmsuoyMzQ/upMbyiyzbmROYU0Sil2dU55uIPQUjJpmzE5BClwhDV7lOfCOVzkbpaWkg+4y2+U6RA3sL/imV5yc6rzsOAq3xd33fi0+Zsja7F18d+zrHSAvrjLNkWCxOYcyott1tQDij4rZgkcnNlPnjuCyBQreHEwPr/g2pQhgJ4NsDZ6I2avBxoPeTCR6AtGwI6EGrCwo77LL7osSyfNJ0BkYSnVgSSK2rF0zyblznh85XEa4IyMI4bvhuDFFMHgb7ZyiwAHisayWWFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:00:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:00:56 +0000
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
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 02/19] iommu: Add device-centric DMA ownership interfaces
Date:   Wed, 16 Nov 2022 17:00:38 -0400
Message-Id: <2-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0116.namprd02.prod.outlook.com
 (2603:10b6:208:35::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1cd239-51bf-4ef1-6590-08dac815a7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqtLpxZckgvsM9KZS0iDDBHLFwvn7ytrIHPxpdOnj0mQ1tUwDR+URItxXpWh1BjYTnC1OrRqO3dhWgOy9Elouhj3yzlfN7u2LJm90fWNZ9jxIRqOHDlJSF8sTWr+cUDXYXEh8jA0Z6jyLYXBLSh80ihev75txP6trbktUXY3Fc7OqO0eZM1jjrJmwrS3C338zVQtZdlWRZ4x5EqsjlKDlmTF06KWfQNnQDMfYv0JwsrMgDXw91YxD0qM7H4Ps7znw15xJnHLBdldIjCgu6TOBaNSFsut7uMDR+zZ+nlFD3mJeI/rIGBM6hHN9AD33mtapKNybs0l+vFPsM+mODIpgWws9hZUHcCytavnnzchSdqd09IzuQH5T8OeJqIFUTzQyVes4BOwQCRAGfcVHt/60NLzxcGoskD4tIYw1/XpbrikyiZoluLHsW4xjufNGs5IiwrkcaUSA5l61jHA9/UUpzP97rbIQ9jTXNWuXDvJ3nFyyVfVhpEA0dlXrDNwwR2/AOl5AO+Clv58eLFm/qNHtEtAAVBGwMxGg+K2P6goFsnzdBQJUP9x8HTnGW8xr24zGt3XvPwoKcIxAIBZDAfEqQvhsxmZyeexgaiWYvued00gi8Vs0JDJtdKZGgZPqAI1eC4Rv84NswxfehOFzO6VBjlrLGBUdZvcdE30CtiiRgMrdD1TelXNJYvAS0IVO95JChGkafpE39q5t2sfj2jUY+p5wawQRmQqTlhQDz7m1B383Udf7I7BqxZHlsPv7Ekm1TDu3LMfqVHKNyx9jvVfhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(2616005)(86362001)(921005)(110136005)(7406005)(6666004)(478600001)(6486002)(7416002)(8936002)(66476007)(8676002)(4326008)(54906003)(66556008)(66946007)(316002)(41300700001)(83380400001)(2906002)(6506007)(186003)(5660300002)(6512007)(36756003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bfF6etGvMY6tDqd/t6iXbjw7VPCukrjkUNUQjKpNYF3z6te5niHCyCEc7jv?=
 =?us-ascii?Q?+m+m2mrBA0VCgr5mCF3m9ITgxZsV6Z8cYDwxpshzi6fTtMEGVhBoY/6UZxrT?=
 =?us-ascii?Q?JBPSeHb21kNT8XSaLql793f2K2wy5VKrriRvNF9doV1EWtPV0vwHw8A4+pzW?=
 =?us-ascii?Q?6vioNQu7bh26udhmlPBgVaXOLQVKiy9QItvKRAi+A8ZmUD6yE3jTdwvkaWG0?=
 =?us-ascii?Q?VBR4bAMtx5Z1+N2OgXaEfFwRVZbLTK7h8J3B8ix35rtwjNPbPcC3EzjxCkWj?=
 =?us-ascii?Q?83oVBOoasFjTo+EN4Ly1zmwdh2CDfZnsbJKAoz/jjjwUK68XRr/CtmWLBT7B?=
 =?us-ascii?Q?AfrfLup/JcxliIhZqg0vZm1UaoWHfTsDwBriuTfTVGjAceIamavKtbo25+uh?=
 =?us-ascii?Q?noVyysQxALhNF+ASWHT2O6tK+60X4TMoEcGrpBd9buJOICnPNIZ4r7b4SvOi?=
 =?us-ascii?Q?uwzHIcuz8VXcK2/UAWuxYs29T7uzqAoLC3bY29wTOGO8Fy007uvvYve7L9+V?=
 =?us-ascii?Q?yeg2q35dQbvCcvlVX2krqOAb3I6ORP/0ddA/atTY38aNpx2Nnytyil8aKQp2?=
 =?us-ascii?Q?8VnvSLlOtAMSw8T/GAHfJIw2yKqyYlF4V1Oyh0atqgxDDHV8PNY3alfng67z?=
 =?us-ascii?Q?3ivMLT10qsOxsYvYHMWwzgouHTzzb6ynVCiAbKyO7enARQTasC1TtPwWbJFu?=
 =?us-ascii?Q?KriJjsVaveVx/38rXATlHLnX08jilg8utLkzIZGBuXLAHAgSXHiseMrjpqo0?=
 =?us-ascii?Q?xXjRfHjpRNA2LWV0XSNkpMK/YQcRLtXV5vG9nKpuP7gHF+hZmMQ/7Agwl5y2?=
 =?us-ascii?Q?eywygOSR31CzUPgpdGTXB5TFGm4Q7rtnCSvtOQNHU0bJJOrWSDwXncE+pQI7?=
 =?us-ascii?Q?O8CrYxPjRzV0nE/H+xSoMsHSujrnezAdqEi0B+jApaMgxwgXcDDZmidrgGSL?=
 =?us-ascii?Q?E3gC4fnxa9PxfPuRHGYMd9qT501Oa5CSEMlHVQaRrP8j179USMa7FC/qaaIx?=
 =?us-ascii?Q?KUG6iOFhJ2Fr1AbSaTW5gXz7SAfrPmJbX9vpHOVv7+S6EWeKUQ2pUdUSZi1o?=
 =?us-ascii?Q?iH/WlBX0uRGIIgQXRoRWVYHxQENUV5qivD4KKInn2d6jwz190Fmhitc7mrbk?=
 =?us-ascii?Q?bnm/BkjcZGrrtRAeEWgYpNGPx9UozG5gWMHJwF/DDbYs0O+FaHZuRwIEPklb?=
 =?us-ascii?Q?Bm4Y0x8KQLEKA9QKTRQIhZ2hhCjJ8CE2NNa26INYn33FrsSsip8dI5+/KOlr?=
 =?us-ascii?Q?ube799GQiw8dRZLKkobN6FiNi9QS9XcqEFbeqODHHyMtApprMz6gDtnnuFsI?=
 =?us-ascii?Q?/yjBt604yX39YMMI+HmXZS/VUngeM++oaGEG3Zto5PiiISYrmX8VL0+9azI2?=
 =?us-ascii?Q?/bW2Qz1xuVRETsle/eaoZLAdL+zWuFG6BEjbC35Sp08FxXxE40ze2jQatuQJ?=
 =?us-ascii?Q?vZlY6KWy3QwAKOFlj/3zgneH+GDiJDKN1QfcygLGfiYVbNSWDNhbDE6ZitIs?=
 =?us-ascii?Q?Ey4Y5X3Of5kLXR7TbnMFl8ay+PY0rACl6ChMrkfDdfbHcQaTxfqb40RdRK1Y?=
 =?us-ascii?Q?2cEpAYr8jypnCn0tlVQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1cd239-51bf-4ef1-6590-08dac815a7ed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:56.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZh/onY7Q3IyZQxJKknIesshoPTQyiNNpowHXP8agmjDim5vMKSr6EorVl3iQPbn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 121 +++++++++++++++++++++++++++++++++---------
 include/linux/iommu.h |  12 +++++
 2 files changed, 107 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6ca377f4fbf9e9..d69ebba81bebd8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3108,41 +3108,49 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 	return 0;
 }
 
+static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
+{
+	int ret;
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
 
@@ -3151,30 +3159,91 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
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
+	if (WARN_ON(!owner))
+		return -EINVAL;
 
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
+ * @dev: The device
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
+	if (group->owner_cnt > 1)
+		group->owner_cnt--;
+	else
+		__iommu_release_dma_ownership(group);
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

