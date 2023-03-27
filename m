Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634676CAD48
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjC0Sjy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjC0Sju (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836444B0;
        Mon, 27 Mar 2023 11:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3HRFr9y7+7v+4/SLmYoWJifszhEeATRSFI/6iTxXbrESOZFgvug2zaElj8/MOjd13ML2zCJqD4gJa0aZW/A0mpj3B9CogbNf3qiVlH9rnOr3R3DMgkmS1ijuKL8r2qBcinyVC+bG+zXlX+bKVYGO/qyl8hdIChER1bC/XGcHES69kXu7Ae4uxxQ0XJIhje8/g+hLuiHTKkhn4sok4S4lzF2QenKfp/cScahkfOTzKETwit01GCNV+Uk+Z0SWZVn3vtZK+8bvvMsUKGPZQApghH537/uIuPEMkD6DLRpKmvK8REK6VfUrLqEJlJXYCB5Yyhnss5uo4j/94tN+krPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOCHnjvnEOfCJHUxzahLBw9ida6GQFd0G5kWiFXbXtQ=;
 b=LbHIhn5fmpmq84txhRn2ruTVq4Bb8OHGhnZ79deqzPm9TekmH75XzOzGMPWk5f+TqJnosGStwoZ52igusXVh47Ben/Vjhx7Y5YzlHXZcF/jHCBkuolVrnliKvLFhnSVF7jy2lV5M+a6rloruU1fUUStivPsYKkkeU5mS2PPKlfmhFED+r+KinxbNxXiOlzorRPk4atF4OkTdO9VLN9aWgeeQi0Y9w5sl05BKZDkbQou2rY9+/lI4H4dbF1gVUKLWLJqxiPKl6iZWD9wRRtBh6ef9uWEjWMWvDWgpf1CpnA+HKGQzogZY07Nd/w05jjrSFEPvaRoCzkVsEFVVN61gGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOCHnjvnEOfCJHUxzahLBw9ida6GQFd0G5kWiFXbXtQ=;
 b=MCshqETPTZisGayM37d7fyrL00dw8QHOuBxy/6oySgahqm5TE4qivYftfotYRykZeDQwRXkhi1yr+7F8bDvZB4jH5yCEdIRMWQyZkN2BD2wsj6HqSAa7zGC4gh6vQ7BjX0vYfLzUwGkqCkjtr471fJTyTN/rKlTKakIlP97hBBQNCQJ4KanDEjVitAUt+Ai9QjjJfyg0niTptQbBgoTVAeh22x4zDhvZs6f2XwxiIaF2/atI4PUNFAHGGeAaoNKHm/wvPqjV55Xpcanqfsfyb/Q82hQTbalzIms+1aGxuf/PLF76jnNmyTS+o5JizqNy8AhURBgL1jr5NncI7rGvKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:22 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 08/17] iommufd: Move putting a hwpt to a helper function
Date:   Mon, 27 Mar 2023 15:38:02 -0300
Message-Id: <8-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0476.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f13032-d75d-4bc2-38dc-08db2ef26cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmoJ/ekZ89jSJDHhTTtrjR9BeRxYCH5661w3DSne5quoxcXYCiapZDoz1nCksPOXL4C3ZsOBQKAsoDw/MvnnOCpEMy7D0bYPgyQ0HxCZ0qvH8jfHR+cvf4G2PIiFblBbDQWw2HVpxoiCFviL9jr6Th0OPGOSlhiLSP9vZlfdxP/ITKHd0O+kJcZ6uBswKX+ibBgg3dubFahls7rOMG3BJsFYgkO2Svr2WeIzmwWVt92XxBv44WIFlUzOfqURp5OmxWn0ws9jzXOMpPSRQY+6xHTfIkATSxNOxXQTJ/yHHdTDqYqxEy0P7vkWwZOEUGr6yawCAj8g84OVjn8S7k1ppXNeedVaaPy1aSZp83sOZXVN5fkE4PGfChnNtn+RTD8JGNljTmbYo1pNCQoJhsoZKyt0RF7LS+OEOR6WfoNOF8aU9BFY7hq5s4uAyiGzuzfn2vn1MBm1iSiPuYdC5LVFrGVbUYJxgFESrKr2UNhtiDCi5KG0q89d8V6duydKzeCTMYGqHk8Hu35MHMIt+wyAbMS1zYBAqt+jMTTg9TolcKpH3cEdyZ4zMBm3XMh6ItrVFDYm+Z9Pwi05Czn9PxzEJ+QXAt8i8DiZTj6aI1GrGfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMCvlglNK/VKzQNtaUleaKDkFA4lDOcFLN5cGMkDVoVT3RrRs9rVIwinwdag?=
 =?us-ascii?Q?vRaI13BJ8J2IRLzLYss88nogwFQ0UlhrHq9YD/OnLTUIi5B9gQNiCfkt3BVD?=
 =?us-ascii?Q?2cnMy3Kz9d20ZSTth130P82mhcCoYOb2ZU6FMYQfh5eKLm6bQT95I/If92aO?=
 =?us-ascii?Q?ll2fNKXLLXBleInN8VA0DJHL3dWPJWJJK1eYCVlSGDlq9RWrjjeLvMt9yljq?=
 =?us-ascii?Q?p6RiUB50eu83C97Kd8aUMm/+ikFWfLoC7EC67BwvZbkd+BcxHukpfuaIkNOR?=
 =?us-ascii?Q?1e/IjxmeTGXyl/l7gXkaVMs2C5EJIVebuTrj+cFb/sPmeY5+BJOQs+SDlOlV?=
 =?us-ascii?Q?bC9YxAz+wIQXseDjKA/ylK+v6lYpkqf6pi+Z9DigyvotrT42Ghh9n8D1+OIv?=
 =?us-ascii?Q?Rh5q0nZo7gdO6Cx1e2AYQgv7dXvu0ClRt8XlC3X+2JeU1zXkbXuU9fM4D+Ms?=
 =?us-ascii?Q?wSFiSJ3GmtE9qYxkt5AY8c4EJRaB/impVwiW2SLuR5EFgdjhCoWxPXeqzXE9?=
 =?us-ascii?Q?BfPrTzNBqtrmPRuwyJvUU7kAu39KiQZyYePMItooJmo/EdkNOLsDJt4vCwwz?=
 =?us-ascii?Q?WYZNCMd7GW29o1LWjJ36GUltxYpon7Pmn+aB14vEvbQpXxPLa6H2Y+XK850B?=
 =?us-ascii?Q?C+K8aW0x5eqrADcrDo3thwbe2WLLySuVGZbjijnfrt34U2iWQv2ptlI64nLW?=
 =?us-ascii?Q?tAfPuwGsIX3xYn10R3lfZytR/TsdGECQpdDE7zG1OyCa/umPBDTlP+PzOMGE?=
 =?us-ascii?Q?1yg5K/yAnIt6yvVzK64N9PH/3/gpkimv08M8WOxO/aMt0wW19pIn18KaW/j9?=
 =?us-ascii?Q?1PfWv6hVTCpH8+VEY+QXOq+NmMiAsvvBd+YXRA+bJUfDwjY8r2qBP2v8mQSm?=
 =?us-ascii?Q?uCvRDECRIxSloCU1i3yKI5AuLgGt9R12YkrfD/3geD0oLasErgzryIuwnWwd?=
 =?us-ascii?Q?zRn49gLtWXxngsgJJwAbri/1t+W/s+rain2LJNR5fVy1BnjIWXp5i11qgEHW?=
 =?us-ascii?Q?QbXYyub+avvNmKshzPVscci/HwoNZsuHDFiY3RNhZGd4P302JvgvWftw9JAc?=
 =?us-ascii?Q?U4AcTFJGZF4492X46AsFEXEyqY+jl+zm4eIjpIOTx4D6qpFR/4s8HBCs4WBz?=
 =?us-ascii?Q?JxvdFmttWU2wz42eKO3OaY0zUbUva74EfqOu86JGs50zHEhAT/J2tNhVyIFm?=
 =?us-ascii?Q?CGPR6c+cd/jlPOE+Wd8W7F3Fk6Zqhr9ThTdPbwDUc3wa8FP/i5QlGsshatta?=
 =?us-ascii?Q?IL4r2wXy6uV/KwD1ymI5D7BXYixGBceAmNse7ikRFXdMlNxN8fygqXwV7kwp?=
 =?us-ascii?Q?jqz8mtqAqX2x+GLjCWIr1N7f0IpwD93azzef4I3RCvrdk5WmTDUQ7N9lkv0C?=
 =?us-ascii?Q?y1PdRHcx3Hnec6+aylzLrVCnje3nJwdBkiIZ31uePyFKOeFkhWW7WCt96qZs?=
 =?us-ascii?Q?I3a72aN6PLmJcmEfoEoOgThFGOsIu+W4WPwO+v+AdlBrj1KXln0CDG+YG0NQ?=
 =?us-ascii?Q?neT59uLEyA9u3+ILWvqNRphXSn8Wb7J0jULs+SbMT03p5s3CJ+14e+kNoXHT?=
 =?us-ascii?Q?4Fym9nQepKkD1wzG2vW779xWEzUSUqMfIz8AdFK2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f13032-d75d-4bc2-38dc-08db2ef26cca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:14.6774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rn64BqB0JqvcLYCKPkYBuPaIUrexjLOxkeqi2Uo3cSfhqlqP3Emt74eW1rTlxCiH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 866b28d24d4ee9..a77acaf8309167 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -485,11 +485,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
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

