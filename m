Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90A8756B7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGQSNg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGQSNd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:33 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007CE1725;
        Mon, 17 Jul 2023 11:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLpfK5T6znm50Yk6cNUSz0rT0NGRHfshg4qUdJVmG3nAG5WYe6cN0lRq/MWkm+d/Arz8G4qB4SnMzAJ2RtCuGY90UMvMf/dxVlN1NfElYn+ZRWHKJ65/YiHeEarN5ca5aVTx7pYF1zPwVV79A6yTAbnKnUbw6DShE8tFgbX4WjtEJEyw6tiLkmjjOsCcBYpbpyMGotoU+Rir4f6fV/v4cqnvR34LFi/bIHvJToPJI9wQCkt2yjZ/ISOUZKXlIgzs5VE1I7hTtdI6E95TbEngnRHYy2itB1c2NUUaL6Won5P12qnJaznESZs6hUlvlGzctyTa3Cp0uut+APQS8okVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUZiQxZj61NoJJo30CvAa+GoDn8iIdPqmROF3I7g6d4=;
 b=fae4Oe8LeFjiqAx4XGKj4Smkid1lF9gIhzDYibjqjfRj2RBAQZzp+DxtniF9xcoRmQ7TB+61gU97K+jYAJm8E5x0anFWOCteU8Utmh30aGI8pkLOcJHrPVOfK0WEgHkoEigCDMhJD+W2FNZtCU0dZduXnvaJYwoJ0DA+nuj+s3exe8cw4HTQU9NjrUdSHnVupklGXvrs0eu4I7pU/zKAbXuIm54Ljh474EpPfn9jVL0m6OjrK1Shgoc0umqvbaYjlUQ2jsu9hIJTE0IuRRQ7YULEkimfYwiWQJuUcdCvsC1Sgl6TPW1RYRdkzLizuAar89sHfXBMNec6vf4guwlUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUZiQxZj61NoJJo30CvAa+GoDn8iIdPqmROF3I7g6d4=;
 b=sB/NlVwc17qZ/AV9+P9dsCrargVuBoNx8pohiVJQHp/57lRDcTegoNHEVPQKjlTIPg5XI/2iCEHpc/0IcAnBRWJTVB3/4XKIhWrJrzDtTMC10N+3ndHNIRkwQ1sDeZ52MDXfOJJ62028obHzNQFATxeIa5Nm0rON6JB/WnH8eRgYoId5Rf7I0JMCqKrQCwIYPUWyB0tCWZJQXHO74XogWWdR4sTSj7TkjaArXZqRZ8KiuUvr56ESzUs9+JFobGYRu4bae/zaYMWpw46BBs9pADf22lPktdFcZko9KDgLJtFajxpC4yxDTFZg+F9r7d2I43L8BEDVAtWKamx8u1969g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:21 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 08/19] iommufd: Move putting a hwpt to a helper function
Date:   Mon, 17 Jul 2023 15:12:04 -0300
Message-ID: <8-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: d10d9043-77c7-49a7-11ad-08db86f15b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP8QJK0DvbfcM8nh0c1yczfklJqwUQx/j8S1QByWsE4xxcl4b8hPm//2Bf620pRdWDxuTVoudUfAaZmSQ9+KMOx0NrU4H7H8b+TP7YMYdZW0cBstz6XqaMbLmFk+9jS7HyL+kYvJ4x7PuBuNXDtQl6YFDOgvwkqBHEZsKlLiVP+bB6xWgK425irklIvGgCLifLoZtIrnKhN4h0vul89qGUA40SCMKBN8zQPl4NcjLxFnrZDsN9RXwKkTPWUHWeL/PAuLGJuTKF9onIz+w73NUmiCMFDPO0uA7DyD8L2ZQ4HnS9IUMXS4QrTFdy6XVi3azg49C86BIelptr/8sO7C5noahUB5fFOxLk4cwwt6fDpP07P65EkYyiLuKXvC3tlqZGYHvYs8KBhS/dFzSLjcS59t81cL3AASYxJdSr8VXis1mKsXwDWX9gCacPisLBopBJ8pB3DB5ypHbPiFGdR6G6wAO8c6a2HiRtTiICt2EEnjqOVuQqYeMN2qPlZBo1/NJF5/HP8VA/nNQWxSEbNoDHIGFl5KIy8RJayEUJ6OvAhgU3FXHBQLjZPwFsom8thvKJ1qW/StDJLVz7DrYLE3vBa+Ld+2D+fatWq/jOAyGuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(6512007)(186003)(83380400001)(6506007)(26005)(38100700002)(6666004)(6486002)(54906003)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BrhOTk8do0e7Jck8W0uPovWTbFUOMnXBsmYgN8ZK69UIm5PUEg0nKbAraIIY?=
 =?us-ascii?Q?lRoklCYodAiQUE2VHyfQl9AIBLP0JwE0J+EAo6s+YyQNVuxYaz78oBpI7JmW?=
 =?us-ascii?Q?gVZYgNFqcChHkIswaAjoZ1PIuhjgwTPsW7XXm1OHx7giccLLxjvUuHE/ai8U?=
 =?us-ascii?Q?ri7+U39MMBZqBLhpf7R7DFFvnZFRjIdJ6iqgAv6FEK/rheIRNjWQ9jZBBIyl?=
 =?us-ascii?Q?cLgiieUY+5O8lKIIEWfGujjTGWe01CykxVqjEY1MMEBVKaAeYCpSDiNG4nHF?=
 =?us-ascii?Q?jM2S6o9EClNijG6YF4vTZN5YZKj1QJ5aa0XBxS78xsKW38pJINcHUEZPNkUv?=
 =?us-ascii?Q?T9rxXth73vQMF2r5x5ZtY/ls8AXyj4R2+ZgIkGuDf1S4jbyDSbLf17knD/aI?=
 =?us-ascii?Q?XqTtHou+5sLa0MnKLOAhWtnU3prYLJRgiZ8/Rp3W8Wpj7QqmA92PLWVeAQai?=
 =?us-ascii?Q?e0Ac2p/VGiWh6m1vcoXilrrWtCSHk3gfip3nToJaFW/TJjgOcSaJ9MUiqBo9?=
 =?us-ascii?Q?2dzHVFJLbJAB6wtoPb2iozmldBLgudIcdlBBqJxNT8Mha57Kq+DBHO7hIh59?=
 =?us-ascii?Q?l80ShnNyzJmV7YYVceMRnbhqZGcu4E45hcakub8Wqpta32e74NqxaPx7hOTk?=
 =?us-ascii?Q?TIp1nk6mgewUzET95j9OPBqCrH+K9lpZqRaV9wOYURmXefy1DD8L/4eLFPTn?=
 =?us-ascii?Q?l8Kh3DRBV9RfT2v66uV0nayNCf5SodU4xIQc/19ne2JPUIggqQc+YB9Gw7bU?=
 =?us-ascii?Q?IO2NToXYzJeUWoI7pQLfcC7nlMlDf+bXxbR1yQ/enHKCBQcAlOWYgmye+SBF?=
 =?us-ascii?Q?WvNNwPSpoatlGkA/EVVuWaCP3SiZhUzlJ7BXb3/GLf2cJK5eq8XCfZduIaT9?=
 =?us-ascii?Q?IsaklZpfc8+Yib5A1Ex5WnecYn6GYD8XoEEafpVtYFnGlRFgd1ROFld8nKjG?=
 =?us-ascii?Q?uz2KNPW97/jNGpODRX4fBpa2hTH1aqCfXFccV2mxGz5I7dxm9CqDc8oX6qvU?=
 =?us-ascii?Q?OWRrP3AFcrmvvX98SctOa/gCGqbgWOwMNbiHa13Ejcl+GCD53pBKYurN40HE?=
 =?us-ascii?Q?0IpsoVS6uh/hV4/1D6I3Ft3krku4/Pv50KcFV3UV0MDxi78JgQqjzNmaLJdq?=
 =?us-ascii?Q?vPcKd2J9sqb8WJKdGCZCgAWNITG0CkMM9X6mgQTRBwvpexblujMeAbex+X27?=
 =?us-ascii?Q?Oj70CpeVsTdAcn5+ZBMJ5TLxvAlUhzS8P+VH98yrb40TvNooSJ1TTen6+BBH?=
 =?us-ascii?Q?VxKZC0yMVdHqs3Mg3pBwsF1WLASk9dLcZZHIkjE453/Y5rXqCXkeDbiD1vSq?=
 =?us-ascii?Q?YVleyj6b1OIGAfYZ64KSCs9gZhtrzcVel1b5FEfd9NVJoQm+0dshi6VdTaY1?=
 =?us-ascii?Q?/yYFP0aj6nBwzOzP+av7UdF7qvZDgBXFfCqyqLKpg9O7Nw7BMi0PDgFc8bxW?=
 =?us-ascii?Q?UC5DT6Z/Q289meJxNNk/RZMTtIWW5ht58+NXEAWpcscK8tPMLxOH4kvZptoq?=
 =?us-ascii?Q?mGA6dje3n1xLi2JaXkS3vEBVqTLEssaEs3P0Nn06ibc8k9PCY/NJ5AGzHRg3?=
 =?us-ascii?Q?OCdNJa0xrP2tRtPHAEx4j3hSlxQmVyrYAM0SaS9f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10d9043-77c7-49a7-11ad-08db86f15b78
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSQAZfYDkM3mOUQVEoFvM5Ty66oG54aaFRt+3bcKhosDLyISL/wcqJTd8IP+Ph4c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Next patch will need to call this from two places.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  6 +-----
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0ca9fdab07dfdc..7db5df11ad9be3 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -483,11 +483,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	struct iommufd_hw_pagetable *hwpt;
 
 	hwpt = iommufd_hw_pagetable_detach(idev);
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
index 9ede238908e7b3..63b2587a37f23d 100644
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
2.41.0

