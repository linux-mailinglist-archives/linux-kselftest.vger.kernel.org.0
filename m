Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7702D6E9BF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjDTSvq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjDTSvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3AD1FDF;
        Thu, 20 Apr 2023 11:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9H+gCY/HU1PhUq7e4+aBdXEfOIDzEPSkpktPuYLNbIhlZCZBU6LteUUfauopBCoB4y2v6d3l3OAfqB0acncCUylbCVKUSDovMtKbmAVP6WoDSSLUyPd4+lQxfgMVxzx96kNvgLLxL637G8l2qeasfZ9vRUCLzZrwYxFMTLanmbbCdNa5A3ArSvwtfF6LwhdgPZSlBuEPTu+W8c+Dm2/MGJ07O/Sj2gFzCRZdr5Z6tcjuSVMoXz1tq/XlopuXL54bKKN0MWeV77o5YU8vFTKThc4pQGSiugFWk339apJdGQQ6B6E3nYsY7CHsOYlz6BsDvgDFFiCZMc/FmhNg1c4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVb9jVnApTzhMvdMF6c8aV0Rw+U9o6GiqOq2QCvA+w4=;
 b=jXc+XeXkC4//s/eiZ9Rl4BMMTa62skSOoeaVI9M+uzOF/qkh/n5OK4rzTrwuloF7ta0/oVLib1NxYOrX7WcS30f6cO4gzOhF4Vij0+ECIX/qMutwEYHwWpVIlKPaDIYxmJ9mUNxb5af8STeG3d1bf2HUdy0/NOMtZXlAVVh12sr/776JHkzKC8ma7kGnc6H5KotyBCzPkkCF0koea3jIVY2exmzhxrTn/CoE0AzmDA9EAqB32CxQs39AReCMYGxyNrRBY6CdGgjr9slP5MqbGJkqhJpqwH5YJ/gsF9W/m8y9SY3ipJ+SRjefhmRRxq69Z0kulBZvsOln2TpEL5vdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVb9jVnApTzhMvdMF6c8aV0Rw+U9o6GiqOq2QCvA+w4=;
 b=N9MurN+xrfTJCspkz52hSKhBcYXbUtSukUafmHX9gPPZ7ceGkS1ureSq/AmtGzCOfwdHwyAEzA6Lr6ogDUWIXgIqmTm1XnlBmhBxCivjMsuqi6BECxSedFB65wlVu73WEU7WgiN8+bgvTm/XKMuAR8izAtkPa4CJWWSQ9mgK3VrUfbRdgVjxYP301lpLuyMSUxlj8KtPR0txZW+ztxLU9Dkwu94g/eNfU3FWe0bKnHbUK9tpEEo/AvrD97jJ5ERByKXHbXRGyLl30541gUhRGtwzW1AmNy3V93fxIJMrPSI2TFel+46DoqpsLsGQ6ONnNMxyDnr6cLI9BV04qH15tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:38 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 10/19] iommufd: Allow a hwpt to be aborted after allocation
Date:   Thu, 20 Apr 2023 15:51:25 -0300
Message-Id: <10-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:2d::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 639f4dbe-2d17-4612-b9c0-08db41d044b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4s06YzF63trhJ/hFNVa1t7Ra8RzHtLW7RGWsMNCwtR7TFiF/+WhqR1HpKSFdyIYlqQuLJewCN/jgR8xxgi+5csy2ohY/s1LsiUgVbsQ/8QO2tb/YQ+DVQfZTieU/XDwfLCeMEVyQQ9UpHGNuxNxnJ6QA9gvlQef4CgeXVGYqVoScxxb2W75d7DizzONLbYZ1goWx8Vl4SYSykg0Igk8/LCZVFJdmW+G+cqBaRTBmAl0A6oNXTC4zwFxb9RcJNxsExdw70ElaoZLMEDjk+RMukCVQlJHdmIgrvjvvgZnvnPLubtmiHBuaY/YjC9J9zYawk/eTESWoMEKnHVDg5VPAskS6yX6CEvrwE528+CZjp4vK4E8iu0NJKLFmWoD9SISviLhSKHwtYz+PwuMoJ5uSsdftqSERSXX564ShbJO7AISjmZa1v7tFZMgOc3nVYzvbrlTFCcG/qYMa1zeS2MSaCHgL3KN1+orobEH/GEMNW+n6BJ53qrWIX0cR7rQnqVKQfU7CrmbsG6nzNqwarUTYP7GFxi7RHCynAaRhqWvLmUsNNvznUeHACz6QAxZuxVrr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdvuEaq6Qj9nRVF1JnJilFxQqlOemEhLAxJPSenv82U1AWhQImXEFi6NIIh1?=
 =?us-ascii?Q?z7UQUr2siJh1YUJbnwBRXbHfeQBjdrSO9xql1u/lZYtK5Ln/mxa8VY5Zz3nR?=
 =?us-ascii?Q?JdTlx3KRu7yRtTh6waMSkVG6ddXgz+Cls3iLpsWWW+vC55Gx1XKCbTk0ar+v?=
 =?us-ascii?Q?gI+shAgSc3cIpK3Ef/mTiJD0NckguvkCvdhZI6Eu9EXfAFA1C++7E4R/o0nb?=
 =?us-ascii?Q?yRsChqBinzEQS8C+tePbEch3NPkHFT8NLvTE4+69kQZ6Z0VDqOP42o3Br8gg?=
 =?us-ascii?Q?K4GiiFCmJFSM6yY/aLoMHryDraWzfNX2KjY5+PJJ9m99rAXn4ui3NKqvFAFS?=
 =?us-ascii?Q?/e4CIf2KEV8Jxnwnv1YZzZBAchL+WjVQzCb6zjOPARDMizHU7tXPNT2XtIZm?=
 =?us-ascii?Q?Darh3ET39D6MGeOspr02BhXDlpBQrujTZ2B+pJt46mleb8QTP/McmgUY9RaL?=
 =?us-ascii?Q?YJexFxHWL34T9WtTqtT33M08lI7d8QukCRgrtWW0GqlgG9Bo0C9jvDPMscW8?=
 =?us-ascii?Q?nd9vjDZZ7WfNb24xngrtioHELRTtHM2Aeh/8g/nQuZR5Qa4JR/GJhrp6kLIr?=
 =?us-ascii?Q?p3TnYijUtyoQ/bhou+8rOy/Ep3fDY+BLXfkYCZ1POvsZh6sJhXOIxy3Mwfad?=
 =?us-ascii?Q?Xxtz44kKGfAofq0dsQmgctlEnU4HMW9CjWh/fj9ATx9y5bXW1zu11IDB4j3I?=
 =?us-ascii?Q?3SSrBgGo3l2A2yMZoavrww1ykMiPsgVIiNkgVsV2WQfDif5rDVcah4EXEGuZ?=
 =?us-ascii?Q?3hPHVIGWuBozsWvBOWA9a4H26nZCsAM/eBjmlqvVX4cMF4D+wliywZE9dWWF?=
 =?us-ascii?Q?+wWWbawuR1IXPQWndbC4hh/hU91J/ZS5aS7U5EU1/DaeeqBRGMD3PJMO6rDx?=
 =?us-ascii?Q?4C0f80NW5skgL3dldBOq7Kr6ENOaGzAKKQ8qNJPWj7tpgdeM+SaRIAlcF+GR?=
 =?us-ascii?Q?gT5Wswjy1UJ6R3yB6LObvA3px4oN5zoadTM/ulhGzxfHV0Hl8znGjs/JT8pU?=
 =?us-ascii?Q?tQW5HRxsayPI+EnQvh2GnNMKSPIth4pHSw+Vr0eCndm1JyBibQyh/moCeMdE?=
 =?us-ascii?Q?zx6XeLPydhqeN73oNVU6PIHa1TDbdYDs9gddzZQ3hK2UikQL+DEjt6kxwxfL?=
 =?us-ascii?Q?E6lbJmt00j+jGWLW8Pc9TjqHlbAe/Wkl1Sx/fNvqkY1TCCOcSlnXwUMBxmNc?=
 =?us-ascii?Q?s20Smt/KpalxZBYtbmiIIagduBYKN9cDvsUWTyq0VB1kvweVWDDkfqkKLQIB?=
 =?us-ascii?Q?7Fn0m73kAMpXZ3xkWHqqn00nRcAro56Jqu08bvrW/ZprDSAnfq2sgdzmAYpB?=
 =?us-ascii?Q?b9V0D4tGHvrGBI4Q/DyDT7xhPCiVcvxseJczB1ZKcQWnFb3TN6aXiN1uodTv?=
 =?us-ascii?Q?/Cz8A6hmISUsNe8yIr3Om6XqwRs33IypXyl54WTb3/6Ss4sztG5hTuJANLn0?=
 =?us-ascii?Q?fIojwJ1r4uQzROwLe8I01CYCBD0rVQmbA0Os4UglPVq9nkNC4ekhPRD7pW/J?=
 =?us-ascii?Q?k9ps8Hkc3hRcmXfFqIcsPbspq1Qcu13kwEQMVz1zOIIDdh/wPNRbQjC1yVd7?=
 =?us-ascii?Q?/zT7UaCyYLSuSmKleebXePoDR+ts3qTpPDc8OJHq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639f4dbe-2d17-4612-b9c0-08db41d044b9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:36.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1Y1d6P5hOjlCiRoBbOxoAlGN/9prG3SG2T/NhCrSE8HsBuV3TYEKufk59sueJJY
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

During creation the hwpt must have the ioas->mutex held until the object
is finalized. This means we need to be able to call
iommufd_object_abort_and_destroy() while holding the mutex.

Since iommufd_hw_pagetable_destroy() also needs the mutex this is
problematic.

Fix it by creating a special abort op for the object that can assume the
caller is holding the lock, as required by the contract.

The next patch will add another iommufd_object_abort_and_destroy() for a
hwpt.

Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for physical devices")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 19 +++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  7 ++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index e0699d7f4c64af..2087b51d9807ad 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -25,6 +25,21 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
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
@@ -49,6 +64,10 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
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
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 471a3fdff1e0b6..a5d5a47641346f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -260,6 +260,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
+void iommufd_hw_pagetable_abort(struct iommufd_object *obj);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e5ed5dfa91a0b5..24f30f384df6f9 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -24,6 +24,7 @@
 
 struct iommufd_object_ops {
 	void (*destroy)(struct iommufd_object *obj);
+	void (*abort)(struct iommufd_object *obj);
 };
 static const struct iommufd_object_ops iommufd_object_ops[];
 static struct miscdevice vfio_misc_dev;
@@ -95,7 +96,10 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
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
 
@@ -401,6 +405,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_HW_PAGETABLE] = {
 		.destroy = iommufd_hw_pagetable_destroy,
+		.abort = iommufd_hw_pagetable_abort,
 	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
-- 
2.40.0

