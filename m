Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2435D6E9BF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjDTSvs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjDTSvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D5B3C2D;
        Thu, 20 Apr 2023 11:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJMuDBfnWCpPtDCq8YvuOouw2vhzCU2LU3YM4yH48N02W2H3E2OsdmU7GVmhGAjZf0gACBVlvDXuwpSc5mZjsyEBQlYpzxhMz2qMab8IaIj5GNXLsXiV4n4IonvVWZBFOSG1OqmhZllddYlKU0pHtmOZ2/4lHsjHMZ2+HMUQdBShh7FGi/6GIVxMntcNH69Y+xkNf0S+txtZO3S6pXDeBjk9At43bAtmVh+eT7cJmwZfQa+Gt8RdS7U1TcdYB8yAftwrduFxS4+SiI9n5HaVXRy/QFS7PVWj6XEIa0YQ/epyoGWgZUTO+uJ8jfepFR7IepFd3KC1jRlnma88Qi5lYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoCOaFExvw3O5LLUrcIrAH+TF+1XtgS69/Ev4knJS64=;
 b=HJqG/1uukBH2I6qpHIrE25R6kr2QUAil9g7gOtlrxaS4M+nNs3gdH6o88aE/0N5P9oPB8WD65ac3RmVzOULc9QHrYwY00CC4H/pEWP5Wkj04pqo45c8JYmUwKhhI5Gh4Sq/MjynFl+mQhaybZk+t1/PRT0CBjaKNO1/SungJBQ4Gi4PkZ07ncCEuMFu/9tQLFnYlkhqTWTcsb/OzPzrJWs7q8Se5OpUwSdTFlTrwvQ7rDb/fix5Icv7DGH/s//affkODu8GpdLdmCzWtqMEYY1JrWprM3Pfw0GHB+4bgIQhzLp/nvbF95vSvCR7s417kVyQKWVjlPJi6Isor6M1IYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoCOaFExvw3O5LLUrcIrAH+TF+1XtgS69/Ev4knJS64=;
 b=p5Ii+cVpF7FX2HEI1k/btGy43Aru6Jr0FPgAh6hKOqbDzND5rcadCefuTOUflpgY9Lju34mVK/DH2BkXd8ORom+m39l2KHI62phVdNsaWuaUGy9r5sbMy085UDWLQbG3Bvtx0fyJjrN/3gMqV8CXI9hrLklGaSuv65aGfybz5zTHoQqmSJ1+GndrQSYI/z8cWwOPeEu8qx3SxRL6TPn97XdKIavJCsDSEd4ccRhpqN1oX+F3tAcoZXTwS/KnzZ1kDg0bEnLx0yRYrfEVyeLsmENx2+Y4Oa7ugsOvAdGnOOW7vX3svftfk/HNADNvBHNQIrrLk9xIBZpUdaTZM7KXQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:40 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 15/19] iommufd: Make destroy_rwsem use a lock class per object type
Date:   Thu, 20 Apr 2023 15:51:30 -0300
Message-Id: <15-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:208:32a::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1b3541-8c06-4c5f-ef76-08db41d044f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEjknz1IH5LxE1CDlv2nXfKntLlWwO7Dt1ix0qDQegxN/EFCn26qUFsUW+jfNcDx4lAUgJ0zZPF4yzdTW57Qk8pcprIvCan3oq0n8Yq3vKlXWMRLvf1h3nufqtWGvWXlq+eoZLbim/o43HUHoZo/6SSo4DcNRv5JpdtcYvmRPe99W1Cenu3vJ7QQ5/JBshcb5Il2mBRICYhuQY0nSg+AuBY9TkOFyE9pzJRdPMeZ3xZhGcKH1hgOBfwrWJp4hAuFWkPmzYl/HEazNBe4S4tQIpoddk3ODKS2iO3+NmUWn4EG22dRpQAqLTr6PtiVQqgGt3iEk/s12kpKLIEtDnuYHrfo9D+eSrE2EOqAieqcMhzhGEMc4w45xwp3UnRLbaGFkcQPM0xTYYyH5BE1gFfKHByCPibhuJ8jMA/LyOIWWqvDMa+zo9ZAlogqZXSdqqEY3ssJshYJ+iVltWOUcqDaUNDKnfS6r9NDFfMBYpUnBroh5p1Lp5IZozxp4gH6m53Uey5aEg2n52aSTf5YApmrDsfFslz1D00zyad+rCg5HHatjnz6LwPQEoQ1OJwwPdHH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YA7NqeoAe1KNAG1EqLkdfTdvp6+yteDQG0+mfENZQw9YOzxRdkNQJmeLUDD4?=
 =?us-ascii?Q?NCItfXGLq2x1dnflM7qHeqlOh/zmozj6slStKppECXK928h171PsS+GiLv3d?=
 =?us-ascii?Q?1j2IvzlciJxuIuslq5riEi9HVgzWFP7qNEdNvAavuwLWC9pZtkUsp7guxL7B?=
 =?us-ascii?Q?pNUiJLG4XPYrGKLTSpiNG9Km9OfZnUU8lSD2blBPtcpsmZp6H9Y3RNLBEtyb?=
 =?us-ascii?Q?IrME8onMQyjKJlC2gYLXilvd4djPQG88hWZr/uzCUKWZv6wYMSEyfcUXkm7/?=
 =?us-ascii?Q?/ygX2XrdVmW83TbF2lrbtHkfCB0fqptgE+HynwjEz/Zt8Uy00CKO9KHGzp80?=
 =?us-ascii?Q?/pCNUh0WyorDnKQFSl8hu96Jrdp9SaA4SFcWcrwwMLWXb2gpgN7DsHZDiezl?=
 =?us-ascii?Q?lXB3S3/NjVJNZYM8w3b8rexuGFySA51oBCNfGgOnFLXKcXy014+XMyg/80UI?=
 =?us-ascii?Q?3GMwjxGy0K8oPiz1h2HDmwgY2Ww0gfzAewEAO9f3HK38kblknuzU9nd3I2+U?=
 =?us-ascii?Q?XGdYM8msTY6IqV3GIXAEkj4vAMNx+hr67synvUQ9cyHblVIU1FxYwjZqzmdY?=
 =?us-ascii?Q?NEE+GRA4mny99R8ATiUpWPBlK889qmgMqAK7MG43s7GrJmeFJqbnz1gkLTRm?=
 =?us-ascii?Q?W175gixesCcUEh0iXbxo9qzqyTyODOsWONAiBOF3Aak8czufRwxjW3FY2UD+?=
 =?us-ascii?Q?4O6FaC/mAfjg8ZU3Jn6PMMPxqw0UBLHonN+t58EMds/u4ZcfKSboYWVE/3Gn?=
 =?us-ascii?Q?mbOGlhQJnqHlNLSTN/GHXH5rvLdj9K07AIXlvX669xyLEEDPcDkRLyHOyn80?=
 =?us-ascii?Q?+jHIE8vUDR/43tNLhdrIEWnp0gxHgaEHHgJXb+PLaeUW3TwdkF/PsJMLQ17R?=
 =?us-ascii?Q?Sp6YiwYZ624k8OPEOYIoSw0iDMKoI9BB05ezjThUWuyYBS022qjtHljDWWp4?=
 =?us-ascii?Q?u9zRRljPj89QzYRF/LWSHHHE29c2oHRiqG6v8yTCtOkoBptBTsG0BYjbT1HB?=
 =?us-ascii?Q?mzhOtVZwWPLim5wVbXlCRLw1R84Z1zqLWJe06zwXG14Di12eJKm8UGUN9oGP?=
 =?us-ascii?Q?OjIStcOC0yyGRhH0o/9ZfvVTaWWcw9axYzyY6UcAqSZXMFsSkhWL+MDhAMVU?=
 =?us-ascii?Q?vDbBj95+g7SzBkhe38TSrOB7VZ5b1bmCM5Y7iwrQoqL+KSF1V1CeCi2GvTPF?=
 =?us-ascii?Q?YBz4L06L97pPD80TXuPj+dIeDPGB79DkjWbpMAi6mnk+/6oHKttAhJt+HnCc?=
 =?us-ascii?Q?yH2Lie0myeAtt1PcYaWdKVHmTnUAvukkjeoGug4w1iAt4IXpcSBPYKfQ1+tu?=
 =?us-ascii?Q?OfdS9TvK3eOhd5h+1m3+sNtADtbct2S8Yxy7fKFWeklCj2VwHL5JJdT5iLW4?=
 =?us-ascii?Q?q8R/qK2VqUDJM6b/CPsN9mor6wEqrRLStapQYf+0kQEvBuNEyBkMYkWuW6hD?=
 =?us-ascii?Q?iDrTj5AfWjsMio3gU1Rja+t/k5iYqie4Dyr0jBd0qQrPVHI3etJ7cNERYVUo?=
 =?us-ascii?Q?IgA9kTqOH9m8zDe+iYORfPBaXfLE/ZreXtKqYUuL1LxW5IoXc8b+tL75iWDy?=
 =?us-ascii?Q?AvTjZ39ccCOWF4e9Z+InJWe5y0O5ow3z9F6suiQc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1b3541-8c06-4c5f-ef76-08db41d044f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:37.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tokXZN0SvTw0UJgTpr3RSGFoKr+6AVTVpZVA7lZrdBZyoA6JXBBDcVctE1i2JOc
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

The selftest invokes things like replace under the object lock of its
idev which protects the idev in a similar way to a real user.
Unfortunately this triggers lockdep. A lock class per type will solve the
problem.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a5d5a47641346f..d97bac38b7a41d 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -119,6 +119,7 @@ enum iommufd_object_type {
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
+	IOMMUFD_OBJ_MAX,
 };
 
 /* Base struct for all objects with a userspace ID handle. */
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 5b7f70543adb24..f219e47d882525 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -33,6 +33,7 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type)
 {
+	static struct lock_class_key obj_keys[IOMMUFD_OBJ_MAX];
 	struct iommufd_object *obj;
 	int rc;
 
@@ -40,7 +41,15 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 	if (!obj)
 		return ERR_PTR(-ENOMEM);
 	obj->type = type;
-	init_rwsem(&obj->destroy_rwsem);
+	/*
+	 * In most cases the destroy_rwsem is obtained with try so it doesn't
+	 * interact with lockdep, however on destroy we have to sleep. This
+	 * means if we have to destroy an object while holding a get on another
+	 * object it triggers lockdep. Using one locking class per object type
+	 * is a simple and reasonable way to avoid this.
+	 */
+	__init_rwsem(&obj->destroy_rwsem, "iommufd_object::destroy_rwsem",
+		     &obj_keys[type]);
 	refcount_set(&obj->users, 1);
 
 	/*
-- 
2.40.0

