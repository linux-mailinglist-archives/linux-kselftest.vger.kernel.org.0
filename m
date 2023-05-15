Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B82702F05
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbjEOOAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbjEOOAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BFE6E;
        Mon, 15 May 2023 07:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+CxnPZ1PKD26mOUhkITuPXgPxHDkStrbyFzphvw3+n76ANwNkYuk/Ze0yCCZyi9IHfMmr6TrfzlMSupxqqwNFqz5Iov0pQuAagNox7ol1ry5pt+Q7D8J9Ro5WZm3LIzHa3EvcAVNW9iLqywRNnJ3hWoohKgaQ1Ry7IkMYHg19/1XgrsxIi+y61hVzZx9EJNpiQzt4TzwIH/ePiBMD4cKCbfnHeUBBw/0uakwxgbJ4txhfd0iBfuujU+5zN0D5Mpn7/piCnlQEd194OBypQiqvP1Yil9CX53RGd3SUMvvwBzZ5l0RhtX0VEsCGF4+Sbwb+jAZ+sq2Sda6XRt06rT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0R9bFyMosiv3kaHwBNp2ckP7QZk5LUDP25hz7C1jAc=;
 b=BDOXvXenFvyD/egLM6KWVl+WNNYWiy/qenw//lpvP0IGuMd0QjeOhnM5rpqH0mystGrRbgsucRRw3u222QwizKpxq8+sD18H4ZVAZdQmwVOr34Bd2sk7wHZfWsIA9RpdUhC3W4Oa9YZS4CSGSSEfUWRjkVeAueSPxYPUncLtLdQadk0QyAJ2Th44YfQ09PybRoKoxaM3SxqlhTCKcpCqCpcgVo0RQFBS7AYXIybgPKDcLnp+tWZTTmuNk2I1n0Pv6TWJGC+GnxT+TcKdAGISc21BakFUR0JbYGGWNvjMEbPaozvkTqB60JatYp83puDv05OfP+hFSHp4Rv1URfKOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0R9bFyMosiv3kaHwBNp2ckP7QZk5LUDP25hz7C1jAc=;
 b=lmPs/q57CWWVfJyiSSGP1DGl6HmxJsHePLT7QBAQ2J0RzVBbcztU+A15SdsCFqG9MiYkEjEFvn3nTHG/n/z4sb8NMwe1KJ5yfBwO3e6xnxtZPLfMLL0WRIdDhH4CMLD7EVZ9yTSrmd6A36l+oXTEzWuILwlwJanryiRxh6gwQwR3+g+tKeJzCIs8A+ftteZF70bbn/OiCzi00/WYPkuTnoyYQP+UmEdT8CQpj0IMUJ6JeDjgAFc1OBKrd/cz7dsGBHv5iZZ2uK6psYQr8p/ferCcbVmlwThU22vqpAc+WLbKbjPTMDDspIc8TwbFBhbkZmf9sqiSyOGEhJR+dp+8kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:38 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 10/19] iommufd: Allow a hwpt to be aborted after allocation
Date:   Mon, 15 May 2023 11:00:25 -0300
Message-Id: <10-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eca01ad-aa18-4e64-a44b-08db554cc16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2vzbozBn/lWJlQTmW1Jhwyp43XUUwAqoVplgMf+m6TKkKDdgzwcFeLiSo6zjQJbfx0Mxttru/q7CcwNbnwZK19zKMM5EwFhU4/zs3BYT7nsIC4VKJRSe2v78KaMjxgP6PrIRJCJW0TtD2GQzlOaMZl93viCb/qIoFTRky1b7Jqguhokw3yUpuw0u/vocfyBX+5LNzcuqhZHlrU2gnMhR5YscHr8Nb0YlJX8bElHEo/Rj4HuznTWUqlRqglEcRiYrVeWLRI0HiZQa0bSQKJhse1oiK8n/hfGiiXpAxA4Z19QqZoHQt2qLAZTrYKg2j+YHbMoWhb6rS/hxgq4q4nx0DnW2DsfGOe4CAnjjfoVHmUAceq14It5I8dEQ8NhYrcpmzQKyucsFd/8F+m1EqnZxBh67XWVntP0wfMuu+hy+GFSb4ceAz9hNLtwZ6BW0C9vAg+00wT+DWhHSnaM8x/LufrvL7n24dcG0srdZkAg6umLeiJafVvXqSN1gmJaxFEX9Y66dFsBAGhj8egS3KH97RNVk5O6J+2JQtyXOhTXIUrka3D6mfkgpTNXK3Pn2OES
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7CUYomWcKugNHLkCovnNuPs3/Kl0d0ch5nTtQRjSfhpuzDJ17H2ahQQo8zT?=
 =?us-ascii?Q?GAVRdZcOijOIxBKS7RDieP50XoGj7WG5H/UmMe84+g6edMx/w9E88VYB5skz?=
 =?us-ascii?Q?IHR3d6H/3pRYVgbVQsGl2Ct5BVY5OWj6Ehv5Dex+NZYZ7FboQBYkZDGNRC/g?=
 =?us-ascii?Q?/Ce16l4BkPmYofEGN/pWNQHHozrhsJJU3d3mBSiecKq0KzK6LGVwsLVqr/eY?=
 =?us-ascii?Q?9pJ0vo+wnqfVSDMn4vdeAl7uQJslwwOtMM4nfspaY1eimCflJ2NYDypTdqAO?=
 =?us-ascii?Q?KlzVhubco0fo71QTtTolg22zgG0nWY+Ctdrk+Z2wpYeXKLhjf+gsf/PHQ5qc?=
 =?us-ascii?Q?ZamHwoxXNdDiWpf/VNnaqJMUnmHKwkOXL8iVjhSJaXGaGz22Xrp3377G0YXL?=
 =?us-ascii?Q?qG90ceIRTD2xaiDq4gFi48Dgj190YJGL8KVLvp3Umjjjcw/eYU4l7jQKvr/5?=
 =?us-ascii?Q?Z3E5vu81YY9F+vPuKJ5SKeZ+SozMQfygktXbmoGOMYBa8oVlcD7yvmW4d/P5?=
 =?us-ascii?Q?ANU+Edydcqkxdb3VDXcwmMITuq5MYooIL3I7cvkf0QeDybIPgjS4tcEHWsxS?=
 =?us-ascii?Q?Q85tPBXvxRSZkoBgULg/XJqC0XKY2dh0Zl8DArLDyztjZbzGUtpuGqu3hK5L?=
 =?us-ascii?Q?Tg0kliud/0srwrV3wRElr4MWScxDHszPz3X2oBqy8rY44h3e5MFsXDoa3wAg?=
 =?us-ascii?Q?aDKPfZW/iz01jtLJWPJX8nkQxz8DNoyws3vbYRqymTd8Wq9dUpRUx5GCVfQ6?=
 =?us-ascii?Q?sFj1v4QjaTrehLretEb28JPIYKIs9zAuiEYzYIFNzpBJ3ZzBMNshsZ/naUnQ?=
 =?us-ascii?Q?PoZtUP0V9B0aocPMBsJU1KhqXjcDTvn87gkOB9nZLvA8ltnHsFiGxWCXU3fs?=
 =?us-ascii?Q?UZ7LBHkM89+V2EEU1T5l20jTJnsrwjvXBJ42nRjjfV3lXntRME9yYjVosw2n?=
 =?us-ascii?Q?pOCjS7jx9Cs6ZEfI3PDYowgvDWePP9jIwrEsu2t1RziCEkXtG35udNIcOxYN?=
 =?us-ascii?Q?pI2lGYnd8N+NRQ72DhJ98HXDKrHtB5LR7lgg9NaYlb4LApb22Q3L3p0Tqa9I?=
 =?us-ascii?Q?9i6vqFeu6PlAFovdEncWkGEcZOQ9lRAN33YLFTHu5Y3QbMPsBMYOcHYdZCZm?=
 =?us-ascii?Q?c9rqwOYszseyHd0hEO8G6/8+xUz6MRlH5GWQoXFNjl4ai9EZCOFvBf9Lkj9a?=
 =?us-ascii?Q?cke36XIvRQgaBu3c2xtaorAGpSDz0bMVXSSy19TeS1qqkIjhhhFiHXFVfB23?=
 =?us-ascii?Q?N+E099NTcO8gRmf+jug4kFhFDhY45MDFomY5gMJGpVzaqx3GPb4PQyItqa2p?=
 =?us-ascii?Q?pAi+Uxe2dViqt1AOGTUCE/ZU/7o18WPLma9rMSKLha7/xb6iuHegKVRym2tq?=
 =?us-ascii?Q?P6/2x7JyZzOwhBiHCGSbfzYAi3D6bTJeNtmCXXod0DmLq6/nvWM56Ta0FtfQ?=
 =?us-ascii?Q?QwmDiTg4gKzfz9U7O+wphrm0mWWHHAEi8GLFRFITPMyQlFEGi0hVpuic6ZEK?=
 =?us-ascii?Q?Zb8tgiPS6US6nty1rSVh1mVgxdHFzcEiVRycPBPWEuvOaVmSJJ0rdSY7MiAM?=
 =?us-ascii?Q?KFhpAFYBJSG9HEbgRddIqLu/EpeDVAlNhMs43umY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eca01ad-aa18-4e64-a44b-08db554cc16e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/4vmm8XlfJL7aX8n1MiJocM2YkTpE+wO4kHM+Vi/KfV2U9zXnxx4rDNKB4IF8AJ
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
2.40.1

