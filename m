Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069A6C3A23
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCUTPc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCUTPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8437328E80;
        Tue, 21 Mar 2023 12:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dry082sR05ZLLXcjMpGW9Fai3/wLVn941nujmAuQjSpbP9w3Wxg7M+415YjyGTIcCuusDQZVbwiS0OwuR0Xcx148YLrlUndDBxk+6W0uevlKKTR3Jcf65K/oGDcPrsPRAkzXh7b2BFoCcrSl04GAkrKyJiwsqV6gCeSzrMBrOxqQtUnr4PcKPTn6gpKWxe8/HGSZ/z4T5tBUxlkvzLkLVlk9KmJ/J5q1WBA5dGXuIsfjdNAsrfXrswkPuQ0hpchtpsCIZEz2gFFY6P+dEGok5H7ZjkJ8NVKMCmckYaarZD8MNlJ7mw8qBks5ksQ7WTP3KOA2jG0eKg8Zsd3uql4dSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xypDS+fWL+QwOX1nn84bHtzcNWNlLcLZqKhHnGD4/N4=;
 b=Bxwn8PNgU8EanwLNTWbVAvwXbnCbb3kcSrRef4D9cSrNF/WGfF8SqGEg9ci2LkPxCwGHPVk710DZelX1nZOyNjbYcQf3GRbtfYjFA8un7n2Q1RhKX6k209Vmna3bTkNW6GBJEFrHhbTZM1xDrrb5l47hloeVvBUpiyheOW18om7Cv5WoCGqrbvSuK8kl2dgBVJq3a0jr5d+1MRtCCU4H99WAtefdRgO9OUj3VCqeJEHN2Ykk7ZsMg8vMcjG1HydkyZkh81TU+RNiaHAYjeRLVf77QE8Go/GpZHrcsbhoX3CG/I3mlaPsE9NzKdLg4ddYGbsF1Y4ESEs0xMF6obU4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xypDS+fWL+QwOX1nn84bHtzcNWNlLcLZqKhHnGD4/N4=;
 b=VioMr57u0ei9zNoNTs2Me9G8dm78kFTvh1b8J85ctrEStEujw3ytoqo3InfndY8L+GZFnig0uAYY3dZfXzQ9PfnHR5n0+5yBDEQ8Fca+fNZ+Hs+XiYgq9Vu0sT+4xvZGalbF7aK90GdQAs/E3ZLVfCcwtHPDXf38vpPy+EsLZalR/s8SSb1majORuXC/VTQsxR/vxvNMjntq0OZilGliJ+N/MAlRCtaJ2PcTZY0JKZonHXNM1rYpYtMay/4gyVRIUePbV+DJhQBhRe4BKo+AZaF14cvvmdt/iXjnDWsr2DmzHijIyZiAwZSM5POw+gmuKBHY8pk7qjZhaOZ/5CETGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:56 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 08/17] iommufd: Move putting a hwpt to a helper function
Date:   Tue, 21 Mar 2023 16:14:42 -0300
Message-Id: <8-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:208:237::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: f237ffa1-e3a8-4fcc-109f-08db2a408d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHRCslcYyvB2PRMyUxjfYQDc+PyaEZPYt42rUHbNtt6M3lNrc7hqe7xwC4iWwsOynkRlFp8SI+mcc+swNogIz9ODIA9gzMs0WUV5idj84S2algEWZ6dQqvEsd46jNohbweliM3se+AmHGCkS5bIKniCeKsM2vUtoiEp2Pd5GMw2qVtzKyOgZgHpIpTSqvTwiIyQx6g8GEYz/FeMjLbviYYfDKMx+DloVKWvDqFuKeZ1qMOb10bV01dO5/cejMDA7c4V28Q+ociB49K8dng10HCC+ZzGxNxrUg82MIDEkbiy9i8QxZ7mCmP5E98qzDJMj8PJ5GkmsOg3eRPscTENmhO3hDhbExUGIYXADUBSxn/NE3vBgL477U7OW+U0aiqVks6xuOVV94xKi/CEkGk1FvvUr6rclKEcn7Ho0jrS/uxBtmepT2KYRIwsTX/fhqpkwMJ05hB75zu80DdsyoFR3WLq+OE8G+cCiZdQS6mxQ89XJoG89gxQbjV1YKt3oVP4F5ogyUCp00HknLN1H/NNMdIa9u/SrgCxvHxErcKhzvZAHmwk+zd2ddpVWeXqMZB/cS/fkl5ta6lB7JehQ2EleRK31RMxgJNmQqcMLD+a4dFU5GCVgvCrfyGYDW0sDxgKRfbqYAgtLUpcjepee+o4a3GgcSIm4s2u44ZMegFkRomK/XmynGTmXtVDt+38jedAH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQ/oQemMcbkkCg1ZsUes+1HBLaQV9YeOXWdmiVTkRXIhXEkfXE9iWWfKqLeb?=
 =?us-ascii?Q?yPSZ8Zjn3omiWodMurl50QGeZO9kaNXtUG9bdNcAbhjGG/w4sCL75bi0eG2B?=
 =?us-ascii?Q?VLLx4F0iGlPjrHJemUDl1pcXZNSxrZY7f1s0IYL/MrwzhNcuw/eht/0qEQfR?=
 =?us-ascii?Q?BfgL9Oq6KbjkFbEdj09eGhgJwnGkC3h3rMagzbAVlVN8OfNgc6XMTAU6MQiN?=
 =?us-ascii?Q?41FFC6pNUehqxKFOwG91aBl9HStVqmaiz6b2Sx2FdgbPYSbxFW3l/zI0fAVE?=
 =?us-ascii?Q?DK2qiQqFDTgtpPVqGeE/jRAd6/8x+rW/xJGVK/PgeneYejRfvCYa3o1mFlE3?=
 =?us-ascii?Q?e2AkuAtWyVTz8vBMFe8W5EqL1XTN6dh//BuZH71VMEsZ/9ZHeE/cxt2xWD9b?=
 =?us-ascii?Q?NhNsAkoSEc7zTsJEmEgMh6MWIMFvfQvTJ8MCkOXU5EbGGbl3ZlNsrf8gOOI2?=
 =?us-ascii?Q?p+MbVKrfJr26gdl7HVYPq1InJOMS/pdsMGVJAnWRKE5alIu/in4wemNUkayR?=
 =?us-ascii?Q?yrowemuQmgg5+Xx15X2/kSvEdYc5Eponrltxj0IoH7iN2fdeDidJusvzmGXA?=
 =?us-ascii?Q?f+8wfEDW38GCQMXN3k9bZlwxQXcDBAUlPWnLw3yxvJ5GZBVIo6XwIeopSPH+?=
 =?us-ascii?Q?zgH4ht0Vz9jb1MWBIBvVVrsPTLswo7ryDJ3AtNWL/GZyPYGqT3Yb0kXp4wJ+?=
 =?us-ascii?Q?zdBbClvFFnClor9oRZWzPfgY3UN44J0FnnONTtv135W+X6BolCI0a9K72Y+L?=
 =?us-ascii?Q?MIjUDLsQYstrt9exC+PBsniXZR9IyCIVrfN9znoDNhKZkgx3iYMhuUy7QBeu?=
 =?us-ascii?Q?eXnkGC0Cdj0142e+sPO6v7DzaBWIHBAggpVaHVfFU49Hbg7F/8cYjVe9Dv5W?=
 =?us-ascii?Q?yWQz0CBSgE3ilzc+p9wsciwwSJu1uWJBryHgxeRZpTHfsQoFLX7klmxsQA9p?=
 =?us-ascii?Q?LPTyO9fZqM7Er86GngUUTVcar4oAUIAB1nm8BxULHtoznNz0h69jcDDvA0Qf?=
 =?us-ascii?Q?85rdaqn3F+qyn/97NYsuzNQm5/rqenpIa/wOoKlh0Opr7zAvvJVPblOxjBFN?=
 =?us-ascii?Q?WixKMWgI5hivT6XJY+G2+z+7E6g1jGfBhh7POwV4IE8VLbrsNVELmo2CFYph?=
 =?us-ascii?Q?2ym0LEfMWl730kQ5uw+q/IE2+IJRD5C+/mHYWdIf+xV3TDGe3hu6qARH4sAj?=
 =?us-ascii?Q?YpsQlhskLr/wN5Giz9r8FUGhHIMhxwTOCL8Y5fNg0ddtjE9zPrIi4RaiJVzv?=
 =?us-ascii?Q?YavHkaL8oEySRSRp8RDR0Xq3/ICxc9WJNIP/DKgKD4Ob5vtbt9MxxkADuFvB?=
 =?us-ascii?Q?gIJUjHcRICFXYT4dWpsBrN1rxtVdPib9HJ7HAMsVtV7VIqf+iy12vop+MLMT?=
 =?us-ascii?Q?zxU4yW86oiF/upPWpQLXWwDBgaw7XWaNZk2kkkKO4Zvf/vXuFXE1u4C7IbSt?=
 =?us-ascii?Q?6vWpJOHRWsG92XqGRFML8ReXdEADixqy88+2kJSxcPHAkyVok5+ywnKOXv05?=
 =?us-ascii?Q?pK5pL96jJ5Jc5oJMk86U0EJY++3ekfFBltjaCt/YEIDrwKAw6T6NccJwP7wn?=
 =?us-ascii?Q?0jZSwSlZrwvc7vo/LJzkwFgkj6CEsIamZt48zmht?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f237ffa1-e3a8-4fcc-109f-08db2a408d70
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:54.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mY+hHtRYOlLMInX2fl23YMmvYpTsjT+h+M6Et/FkATZ7OFE//R479Af4ffK6i5KP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Next patch will need to call this from two places.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  6 +-----
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 616a23939e968b..8946de73660ece 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -489,11 +489,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	hwpt = iommufd_hw_pagetable_detach(idev);
 	mutex_unlock(&idev->igroup->lock);
 
-	if (hwpt->auto_domain)
-		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
-	else
-		refcount_dec(&hwpt->obj.users);
-
+	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 7f4936cf537be4..8bf053f4d4a9ce 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -260,6 +260,16 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
+					    struct iommufd_hw_pagetable *hwpt)
+{
+	lockdep_assert_not_held(&hwpt->ioas->mutex);
+	if (hwpt->auto_domain)
+		iommufd_object_destroy_user(ictx, &hwpt->obj);
+	else
+		refcount_dec(&hwpt->obj.users);
+}
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
-- 
2.40.0

