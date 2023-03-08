Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A1D6AFB3B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCHAgS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCHAgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:09 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6216A0B1C;
        Tue,  7 Mar 2023 16:36:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajvjv22Y4xzQ9W58t2w1GcikEm5fAED5Ind82jZsl+Dek+vkAQNOMOPObcq4+NQ5+fWTHgAwYAKxo3v/MENcGH8dz3MGMRrELKGdMi7mkQHs27EGI6M+SInOu1L4OV1Wr7rbQzgI4thhVK1Y5h/rBEN2wkAUe+GUxmoYtE15vk76fT4PYR4TSlAAMcbgTV3kqokoRIAvMSCTfwg1n/F8cN0E3gquTCa/ykuuRMpRWIxLLvIP4+2jvbrZjBZ/atShMrj1VyJ/iecFbmNKIwGrMHOQzrZ6NZyaZ1CgTtbyP70dnWnV4FIZQ38Ef6kDoHklhVF53j0kJVUfzdoE+7Cupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2uSXyjzMKj8RobrWyTGtXixO/W/4Bi+rTaNKYRG4bU=;
 b=ShXZs8YN60ZW7ThFhq9A9e246zraCTZAKvb4Q2Ua9AcY+1Q+ffNB2+rMl2pWnX7n4+U/SFKzizcS+/oie3lMtpKwC6YPef9TmCBR26gW84rUrywYKi8tN++Ayzu4RzLSHq5A3CFlHa8SeXwcZhoRhKf/KQWDL88AbcGJxWUPFDMf3ay+5Q8e2qOHj6mUM7hqcOZ4fbWtY8euFOPLqUNscYXb2LOULRZENOR7JWMCR0pfsLB9Td1zAsGbzX0NlsbkpLxmeeGTicnv+79O5t3TFDr1oS8CbfL28O9IjGarGtrBZNDiWOWxBcybDumPtA6Ne9B8tOojHCI/rXn0pNhCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2uSXyjzMKj8RobrWyTGtXixO/W/4Bi+rTaNKYRG4bU=;
 b=djzi37TKbgzZjt5F+Seli0N2zWBd3oHKIpNd96Uqqx08+FwgCVALHZKUa66hLvRVq0m5S3TcysLFngyboetaurzSdstprJgyELsqrdMearnDlpWzcNoyRD7vjZEpaAcN4rCgsTsUz1oQI7rS/zhiHDXe2WrpZeJwFmLMw+5R7X9Z0ej9LRUIS49VMVHIc1uYvS++ZA1xNyME2Ep37yzfKffTZUsceaWYfMmxXqKc1uBSc7X8qkiQRxAgxt7FP3z7rRZXb/Rt++YDnn1U+9YgY5loxmZ5iFN+w/mTWOQ3p56b5Fb2ImE70cFxTBeqLMVE01i0Xo78WlJb7TNqSLqatA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:00 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 08/17] iommufd: Move putting a hwpt to a helper function
Date:   Tue,  7 Mar 2023 20:35:47 -0400
Message-Id: <8-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0031.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 93957e39-7d8e-4ef1-65bd-08db1f6d1666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQ4nuoOHqcRA2b5lE/rFWxxMQCH8Tj6RY+Lejv3Kba8JPbV8O4ppV8UV01+Q/p34NDT4AWcK1X14cNT0dtQU5RBl/Ip3ZYcGlMuXniDjGk0og7u9qyw7uoI4IggmvFDwXbrdjBdF32WbtV2dQtEKkXK/eRt/HqlkkE+dJfHRNsbGIBpu2Y+uX8Uuumz0P9rG10GP5EL6H1tNdGpGhIRQEmSr84v/YwFcGYPr534JV3Alv2x/wg8XMLXcUCHY3s8HMWHqZ8bKyG5dTMzlUGGbyh0JQYzfAGsFENCV4LJG5ZehBQENtpN9nmbA81fTdYEPWFTnf61gEQwsIzUyuTG5IH9I/xuQs5J7BVz9EF/2atN+dRPFrZFHQ86adcSK0pjRaKpCx7UqFMXZbcrnsHoQhz5ckQuOmnhklETaMunF9tAt+eG6U6COKdebRA6qFFRPWB1smcZNmIZYhAgxHg5f/p7YYcQJEf/UjS4M+JlUAzEGsukvVZ896UXF3OypZJnUwY9PHzvRLU5xiY/sdhmO1MVvnfnfVW/FEYQcxkxBrSe18myyTRYbLFLPv+9r6B6KdVtVYZIYITp7OhjtCVsM7E83ZHnzdUa1n0/CzPxkQetD3zIcSkZxo1ehk2CMVXM9QEFYomTpRXo0NZdLO3Krb2V3uP9ATIxazr2KprORyLQ608MSZvy89kCBZD1wu7Sk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kx/AUsCcp/VLziSxZHBV4wYKldp4z92DhMmS5BJH4Se2rIiXFA7epjx4bxJe?=
 =?us-ascii?Q?PMV6tA7YdWE4xwnkUf2MdjmNs2abKqCQrc86wEo+mO80OBqB4b8W8X7qSkms?=
 =?us-ascii?Q?1DH0PfpUjuY/iC0sh2eZkaTooW7IoENx2+AzbP+z1f5FyKnJDzh5OQpys1qt?=
 =?us-ascii?Q?+JeItmihjKAs/C4p6g8gJonvOp3rPM9xxHvaNEllasLRZf4jYDmpTV9NE9YY?=
 =?us-ascii?Q?S1oX11oVP4X6VrGX/4OflHbamf/XlMnPjlChAPWmPXHr+RvOIiilLEHn9Vdv?=
 =?us-ascii?Q?DUVZpRU6ykNPpEr4EOBa0wSxFvIZ5uSYZdsq+wI3YpM9CE9Vu9uDtUozN0uT?=
 =?us-ascii?Q?Uw9qqC39SHsRvl9U0rmGapUFN5J5P7Wux220XbyhYFviAhNL6ThNNL4WpIce?=
 =?us-ascii?Q?oign9to5lZEG8lqHcmuy+Ph4baB0D1nixLMorcFBJkGKUiIB+YJSJN55JyLG?=
 =?us-ascii?Q?jPIJkgwfHeOuY3cNbm0a4NSJsLjO8GXS931tYQtw17Y+CoTJOIyJ84Z5tUMG?=
 =?us-ascii?Q?aazBA/BVoJ9zljWeZqcpTDEbTlWDQbA1VXywTyOPhXDK+y+iyjnxTeBuNux1?=
 =?us-ascii?Q?lJ7iANaPpVQjYKKA+jz2UbwecJc7YW8GPzbKPMhWx0HQXjclvv4y3BawEGmj?=
 =?us-ascii?Q?w2WpqqKNkWYOQoASJf5IB/fnxDWwujEZO57PI3ua/TYjpwQcYLgMGTaLNZMf?=
 =?us-ascii?Q?n9hqbHDs4TMK/IVe23NWIsprm3UNoLXqZRJ2wOjKADaHCBfL2EUJuxB5D79+?=
 =?us-ascii?Q?3WDGjDnRKqN7k+DMmXqJerWXU0fxLnjGXB4mQWTlxIhhujOdVzm3QN5bN/l/?=
 =?us-ascii?Q?GD4KOkpSqj7qoXFR+PaNOKyDX7AvoeV+PWa21EAixDghZQMDt0aVlMrjonjX?=
 =?us-ascii?Q?eC10OvUZfiLyZZF8aJkA8j4UI9PeEyOy/d2oj0tSykiwq14uyUewjw6A8r15?=
 =?us-ascii?Q?8BfZACw0hCLkHxqVbaH3xA0PGIQP0EI3JY6HBwWk9+U3S2lIGbcDiPk5kQ+T?=
 =?us-ascii?Q?XGwjwa04o50yxKzMI2tpvUvhBA177nFC6O9p9659SKfSoYQav06PLbHZxDUY?=
 =?us-ascii?Q?714opS3cpgwPaKqeupFruunOLF46jIFTsDv5XH9xewSikOson4XvPOGhKLgk?=
 =?us-ascii?Q?z6EPD2JAv40QOk3ozgwX5yx0C4ZmRIr8Aqb4akEAp5hXya0e/HV6Y2aY42cU?=
 =?us-ascii?Q?0V9KZWHpo/QxVZRE/T7YEpNqWQYRmc1tRFGF6YQGjvIyf0SA8UtAzasfEE8A?=
 =?us-ascii?Q?PDFzf+YLV7QT0hZrqw+BUyxMDwxcscnsQ6Z9GJMqXm7aeOzvAOqfEOJXEg5O?=
 =?us-ascii?Q?DLGygT/vAtAo7l+gFsqJEHxZbqwy4W0IT924E1t5eSFLMoQdyJ69UuwRjosw?=
 =?us-ascii?Q?PptsLeZLVw+rYpPGoZNaedZszX0n7JrLnZkV7VLeZrlCXSz/xy7NpYY4di8j?=
 =?us-ascii?Q?gwUUwXQ4Jd3LMJNUlsHzIkJ6a+FDODK6AfLKibE7gtTBHvP95ZjDkYK0ivxv?=
 =?us-ascii?Q?aSbJ9tYWQZcz2Xis9LSEjXFLVvjhwg8g02tvxRJEMkxo3vvu8HDXGO+7u2++?=
 =?us-ascii?Q?47aqhPe43orW08yJiOjA3NGPyRuqeHJrGcGziueE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93957e39-7d8e-4ef1-65bd-08db1f6d1666
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:59.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLXAaRJpS7XXWXwCZ84+KP7s4I8Y84QbqTUab76LV8yvQN4k84YBE5EIGnHWZizx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Next patch will need to call this from two places.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  6 +-----
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ba84d314127ba6..d6d5c2fcc33889 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -488,11 +488,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
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
2.39.2

