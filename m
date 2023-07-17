Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D0756B8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGQSOR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjGQSOM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:14:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859301986;
        Mon, 17 Jul 2023 11:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4DoImQMgGxJoixeuajf1wEmKED5v1+nqeP6DNDbhLrYCQH6F8Er2pVn9NJhSC4Hex5cnSV5iYgYGySFmfg7zrucfDHecjG/mMFCMyTJWYLeDKt23LODGjDeYp6mL1rmqZ+ijbmyTHy1HZiymIMTXFcp+lSdFvrEylMJ45OZo2p/merSeSDQbeDiXaH2I+wIwkTkEjWawO7IRZziBgUJYdnII996cDe8xr1NcD+vToaJ0DlKRGujtiyWbwQCnkDDLr1gos1FzJyoxyS/Hl6lfunOdWHrprJ6wAPbLI3tzA4iOI8NO7tOg6U6KAPH2xqtD84BfUXAXQNunyihABuKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1vpWodbIhaTwTUGrA968Gp8kCDO6ddJqInRs8uVdsQ=;
 b=DYTugerxyBa/frCNRDC3tedd6OtahfULe2sl0FwDr0mKnOhNCYq2/b4B1VRqlkuW9kQa72Itu5tLVsZvs1TUjgabtKIGGKxKMftu2SAHWZF2ILXAQvSKVqdSD76rPv/Tfig55rjivtpFRsEmMzvhfuJbc5+DHTxEBB0G+EoqDYbzBTkeE9tGJlmFTxk/ef9f3Ba1jyQNr0xgkhvE4NXlpfy5HJ7T9E6o8xbhz/dOMOQif2CI7UUdY3YXs6ZnNTpKNpBMuPKA1rBkupbUdzYZA8oDYkv3eAp1iENbbMLA+oQuZxj9J/bXpoJ+TFZAKhJAlwAKivxFtxGv22sGFUIl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1vpWodbIhaTwTUGrA968Gp8kCDO6ddJqInRs8uVdsQ=;
 b=KiLrp+y1TODSGqu99Okic+irnKWfo/Z8aA9/lahJbo+R3AQkog0Ga1zJfKMIMsGoXeOcS41vKsoBJRkBGBDU4DQg0kQmVoxIaQSDoydVnL6IkVe5ojr9BQ84w6T8IKYcCtyTcjdAgbq7/x30gJXabeNq3w0RN0JmyEmKaUUOLOMM9E3l5mqbdvjZttvqvOLmrepzFlAcIMzVNYlpBRk4i9u9T/a8dfAeN8W8X8VzahQJZcb9nCHC/iKeMVpYzz8p1CsLZmEXEXO2srUMlowscb4fkxPt2or+D7tkqwDc1GxharzHercq9YFdsqx7TJcklpJmWQww/OgnqC8JNqUrww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 10/19] iommufd: Allow a hwpt to be aborted after allocation
Date:   Mon, 17 Jul 2023 15:12:06 -0300
Message-ID: <10-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7f639a-2076-4f29-76c8-08db86f15b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOeWEdYssOHYz3wNRhppTRL1XPzwvq+QdWEV8f0KKzu2OF2i/Xu/+C50cjAvFD4qtN+IQAjVoy1uM291RALVAHMDjWO7Sgoi+1WabqSNXJ1AXUTmBdVw3AGSyL7ssM2F/kuZZnrFvkqECJY3A3rDVJi2rPoYmNDI3HYGh+dHrxkUY/t3kbeaXPAjtvWjng+QA0OxvmWe9GXpBO1nqMpW3R4t2dcFM2BPnXFT55GFHhipOCaTqeKCpeV+YGqQLMqhWidb8TwsJHZp1f/Pc+eNVAXqm6+fjONX9Krv6FTz87ted/T9VjxsxTuWvxetqFPkQQxXFu1hnI1+QqPpC5dyUQjLEiwUoacsEbpUUdPeS99MaYKnV0AKC1ui2BTREKKeO3hFk9PPQ6/H7IEeaFUIspFZlmdFv2MyPsLOHgEOnsQKxRg3qYDkk+PyvZjChwwoSoHDUWDZIe4Li3SHLpDwpnpcCHLbe8nXK7BB+/mjYBqlNb/iaBhz99pnsINAoxDdOo/VnYoy2DQy/+fVwLe8JkhvFXqB1BFh70KPpwJHJegEup5S/OXHsG3KVIlzzgxZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(6512007)(186003)(83380400001)(6506007)(26005)(38100700002)(6666004)(6486002)(54906003)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hY3zPhEqrQF/zwcm2Gu8O7Gvf7SdYyi0xJWZkDoGe9WUEAqS76x5SLZ3/VPP?=
 =?us-ascii?Q?YGBPVJmr/XhN2fpIzoky30CDv6jwyIs78Rv/DmstJZDoTPuwdreZql9BP5vM?=
 =?us-ascii?Q?mt89NeaoV4Asan0pChItO5d24ElIrNeNLXh7mQNOwxDN3XS75CkU9d0zTSFC?=
 =?us-ascii?Q?+fqGY6AO+xzPsqqIuZiyMuAkDv15oZRQzWY68v3y0sD+MV155unouws7I+I+?=
 =?us-ascii?Q?U2GhUdA6fTcuDUSkaqvxAVOtQ+7klZyGGUrdN+ULrVZ9OUaSKmQWy25Octz3?=
 =?us-ascii?Q?HyU2LfelMe4qY8YhE5FGaNXrAf2Yke2xKiY1HO0pVK5V9zNDMIYlW9d/5VzW?=
 =?us-ascii?Q?kM+/zdu36B7TPaRJS98O18sqvXC6JNBD9rI4kACePFJW8Ci00iV83MRc6ahG?=
 =?us-ascii?Q?Q5J1L1J3Zqxy4kUxq7weL8RzaGLV9MHX9nzgenZOaQN0uWvn7G62GUQ997LM?=
 =?us-ascii?Q?ZfXu4LGB+ABAAJQ4yN9kXL7DIvEXe2wvEAHJKYgoPjZyDTTqMLSR8bvjmVlx?=
 =?us-ascii?Q?17q02Z/H0FLrBvzL96cjXi9MDUk0ezWqdXU/p7O58pBAU7ymoeYD15Wi87Zu?=
 =?us-ascii?Q?295HGsGNs3VRGTdGU8pxvMunnl7CUbWWp5dSJwj6a6713+NeY6Bt7/yiAi23?=
 =?us-ascii?Q?iKsMfIiPecfvlK8dsEW+YYVpDdpTCPO3gx3zEF9hse2SvbUtLCxt65ahRgsf?=
 =?us-ascii?Q?7sGYOh74Xh4y3eRulbChH1HepTYh7ZhZ9tIpjIOOu9ORzsOz8rNggBueDfNU?=
 =?us-ascii?Q?f0pHoW9xivQivmAMg+htKSgCELzyjbiJC6E8N8epIHHwu7uvVthK8Twcmyvs?=
 =?us-ascii?Q?qCZ4/3pm3OGbwLeMz5Kzzmh2EnhCDvTt0VFUvQEmmN8lmOzKfRwrO+tBBS2B?=
 =?us-ascii?Q?6K9SZjN3+dbgRx5uN5RwOx0Q/zCncFJ3sHYzepzY7Cd91YML0Uuge2L3ZNPl?=
 =?us-ascii?Q?NC6viex3XtBl5p18hreXSisSmkb2gIOz5KdCHF8xvefQ+D9MOINgbV6/LUXW?=
 =?us-ascii?Q?d6xdgyjyPc3auJRVHKKRQDPGALICbP6G/UIRpxiTxNfstGbbmjZWQ7Y34DAX?=
 =?us-ascii?Q?/ruP5V+ntiK+mgm/nzG6qCN/QZYG3ie2H+nBEhU0NerVLP95JuoFwt6j/Wtd?=
 =?us-ascii?Q?80df7EQxhFQTg3+27lNj83FP8mP41B2ocdAmNQa+kx+fR67LYkvyXkYps7uq?=
 =?us-ascii?Q?Wte921RIpU32EmfuxEOc0Nad/UbWEfAAMT7oTrHwTnudor60xOd85c12fU8B?=
 =?us-ascii?Q?iC05hPWWz5TI8aLg5JnDa6FPqpKHawTbsB9GYNN2cKdq6siMOq9YTxFsN7cC?=
 =?us-ascii?Q?7Q+mkt2NxVtaiTI+UvZkeMBXzS2mMIgSCIXV6HZlpTo/tTrhOUx74e9NloVY?=
 =?us-ascii?Q?BrUk8UKfK6Kzt9kS/e0/+kSC976l3RRLeJUd31VpJfUWNNM4VEUwFXBMLXwP?=
 =?us-ascii?Q?ETjqeU+f5GxLVwHkv0ofXdsUffreKTVhepPxClWsf1R1SbjT65/i84s2g8HJ?=
 =?us-ascii?Q?vRa/BJrBk05Z1mz4b1INKMKUqTSqsWjVaoc5iAZSjjiKFHHaWQGnQYNwxTWv?=
 =?us-ascii?Q?uS0M6lmtuDTwmUVKkAv17UAM88wDpw6OywvF0cRz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7f639a-2076-4f29-76c8-08db86f15b5b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XnE26yCAJwx3mifB+lLRIa4z29NEvMddF0Ql4NP4urJILC8dbT1n5oXqAX733Lh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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
index 5ce9eaf5fb88e3..07d60d0640fee3 100644
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
2.41.0

