Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED077C984D
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 09:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJOHrG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 03:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJOHrF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 03:47:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E8D9
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 00:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6UWBpihHDJG18CMSV+R8oi9hl2mS95MvxmFbY6uWwF+To0hTUkPgebQyIt8fXz+s+guEm5Vsz0Jmh5rfRsx6aVxABW8zfMk0A7zsATDUG5Q295amKZNE8OrizYPKxrT/Mj3+FrBvtuNf5GnrQmqsE00xSTYrCnUjkhb7BHSatCpI3ta/7t72qCkg+GbOzOEYRSF93f8hv7nxf7CyVBlaZ/mauSaewtB0jKCwhgLDx2uMbE2cmNqs8S5jsAZveca2yQn/tO+ym/0HGhEUGeSz2JRogIK+awBT1xEE/TL4rWUqFYyMLT/7VQSbA0bvbpE/IRC0fR4AfJPEz2J4asKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymr9XiXjpNtyAAXuQHJmtBC3sJ3048u3Iu/Rb4Ikmx4=;
 b=lZoHByFPGpPBNPwCqF0H8VSoY9ZYxw83NBqfHu68iulRfCZowgHyDa2Y/LIXGSTmb/LdkjJsJSM/p+MipG1jVsdzBlMPxXQaLLQvOe1yg7YGG1F2uY1ZIZPhtQZdwvW3kOI6DPH/4ZX7Gm6ANAnYENGNmDpnOR7Csz6Nsq5KfvuQnrQ3HVWFCqE9DzVJaX5feLSHTClIOIhRf5sU3xvV6njuQ24ujo6NIWz5z3VjkNegWRx5JqXfmQWKAU9Y7xXxT43GC830DgDVlZCbLL0Urduq7M2gs15jqC/xJKJiOS2lvBrkjiyM+qitWndfhHZi3YVMd1vuNj4Vdv0dweHoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymr9XiXjpNtyAAXuQHJmtBC3sJ3048u3Iu/Rb4Ikmx4=;
 b=Qs5zb6eOSWoScZm3Kp7sAtQO3aF6f9J2NoQcAtXYvlc838VLsh+Lyx9tIRYnVNowprFFwG21j8jaB67sZurOlGV8vpBScHaJjOfO7EJynI2jnV7xaZMfvGJp8rknRgymtb1LQtas1y0kZ1SezKtSfDpJIn5lOi/UyqAfoM5MGOaDJBMDNveQTgq/nZGePnZbTN1KO1kjHO/+lUXS0ySz617HM2SO1AV9emlTDdO8JqxarFPv4KvuYcAn9q/onYrrV813n1gE+I+OSM1VBPMy/V1AwPF7LPLmQ33XXH4NFI8gOQCAywlNGDJnImJf9Zi5fG/WGrTql38lBMltgiErgA==
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Sun, 15 Oct
 2023 07:47:00 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::f4) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Sun, 15 Oct 2023 07:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sun, 15 Oct 2023 07:47:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 00:46:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 00:46:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 00:46:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH] iommufd/selftest: Rework TEST_LENGTH to test min_size explicitly
Date:   Sun, 15 Oct 2023 00:46:48 -0700
Message-ID: <20231015074648.24185-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 591bd4fe-8712-4cc4-094d-08dbcd52ea30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/GQiuu1o/TYZ+mXGB+uh3K0RuDw+wLr39XGbU9R/11PZ+oXDexmRHGvPkGFlaxknOn/ATyldjC7n/IMXzRTunZn7XelDXJmEuWc3zCX8t+45Me1DP3GB8XonGj+cYVSeP/WPYd+uuedtYmH+hKSw38ZolVZyXoIiupc5Rh77EGysqqEU+IoeI4GPuZeaZaMI1I3hdcVBWHsRdDT0ffL0IEVQkDcE5wC0naU5sJvhwv+hTa2s5ziWZEn/nN74+Rn65HBUaqsE3jov5QNiESqYSfzAh9s4cPQNfus2iLqXMAoFGOAhly47Ysp1rGUYWPCGUe+bjHZYdVnDPnQz0662hA7aazsi8ERFLO8i0NxVxTH+I+qemoPK94ygZr/f2QdqugYvgrGXoCr1eT7pULxQ9nZIjeT45LVnVjA6YKlcGLIRneNYqxAq6KLh/JF8OCsO1glWKSqxUbHUJD0xEz/o6+DwQyuZqI/saDiJPRITagXxIP+P+FRIfwxXbxuFl+xMK1PaY18nqJNcwV5jJA2n4HVXl9eD/0614Btz1qVUL46+iX05LtdEF7/aSbL+Zw+uG6Mz4kxJcqiFxR7etyXwXw3PVp94l54K5cWmMXXFFzgxcsmn47d79bjdPeHixhZd0ndtm+lLUZBO4PT9w/1KFmlEltS4waWty8Ngucz87Y03M/tJG423Yg/wOOkWMvKnPhobJXEUjaxxPkTVzyeX0eqB+NoIaULDfnBxmWeOWa2JcJFyUNV2utENzxBg3XyXZpe3U8jz7qDRT8vzeeF9A==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(7696005)(966005)(316002)(54906003)(70206006)(110136005)(70586007)(2616005)(478600001)(6666004)(1076003)(8676002)(8936002)(4326008)(336012)(426003)(36756003)(86362001)(2906002)(26005)(36860700001)(83380400001)(7636003)(41300700001)(5660300002)(356005)(40460700003)(40480700001)(47076005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 07:47:00.1054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 591bd4fe-8712-4cc4-094d-08dbcd52ea30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

TEST_LENGTH passing ".size = sizeof(struct _struct) - 1" expects -EINVAL
from "if (ucmd.user_size < op->min_size)" check in iommufd_fops_ioctl().
This has been working when min_size is exactly the size of the structure.

However, if the size of the structure becomes larger than min_size, i.e.
the passing size above is larger than min_size, that min_size sanity no
longer works.

Since the first test in TEST_LENGTH() was to test that min_size sanity
routine, rework it to support a min_size calculation, rather than using
the full size of the structure.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Hi Jason/Kevin,

This was a part of the nesting series. Its link in v4:
https://lore.kernel.org/linux-iommu/20230921075138.124099-13-yi.l.liu@intel.com/

I just realized that this should go in prior to the nesting series.
One of the nesting patches changes the IOMMU_HWPT_ALLOC structure,
which would break the cmd_length test without this patch.

Thanks!
Nicolin

 tools/testing/selftests/iommu/iommufd.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index c5eca2fee42c..6323153d277b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -86,12 +86,13 @@ TEST_F(iommufd, cmd_fail)
 
 TEST_F(iommufd, cmd_length)
 {
-#define TEST_LENGTH(_struct, _ioctl)                                     \
+#define TEST_LENGTH(_struct, _ioctl, _last)                              \
 	{                                                                \
+		size_t min_size = offsetofend(struct _struct, _last);    \
 		struct {                                                 \
 			struct _struct cmd;                              \
 			uint8_t extra;                                   \
-		} cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
+		} cmd = { .cmd = { .size = min_size - 1 },               \
 			  .extra = UINT8_MAX };                          \
 		int old_errno;                                           \
 		int rc;                                                  \
@@ -112,17 +113,19 @@ TEST_F(iommufd, cmd_length)
 		}                                                        \
 	}
 
-	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
-	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO);
-	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
-	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
-	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
-	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
-	TEST_LENGTH(iommu_ioas_map, IOMMU_IOAS_MAP);
-	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY);
-	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP);
-	TEST_LENGTH(iommu_option, IOMMU_OPTION);
-	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
+	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY, id);
+	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO, __reserved);
+	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC, __reserved);
+	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC, out_ioas_id);
+	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES,
+		    out_iova_alignment);
+	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS,
+		    allowed_iovas);
+	TEST_LENGTH(iommu_ioas_map, IOMMU_IOAS_MAP, iova);
+	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY, src_iova);
+	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
+	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
+	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 #undef TEST_LENGTH
 }
 
-- 
2.42.0

