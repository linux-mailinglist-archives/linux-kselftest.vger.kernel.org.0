Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2968E2D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBGVUv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjBGVUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077603BD8A;
        Tue,  7 Feb 2023 13:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjCbtw77OMifqnvOFqP25HNSEupzmAJxJZ+KVeSy/2Dj/QS1KVWh5jyCTIfAPkQUomlFc4KEY613icfZ1eZ/gh39GbDzktn1Dsb5P0XG37A9tLYYtGGJIyk5P5MUkntHtpwlloHXycgm0p4MFSTZSVj3wChpY2wlW1n6wsWt6rM6n+0IuHXaiGTnQPZidlziv5zJ/QpOxKyEEEs6uwYUYHqH6afHHajJMvgF5/EMVUgwtrYQQ/TUI5+eGMf/BYiaMMpwduzbfddP2Lw12hLaPnY9zjtUSBMx+tPLLlnPfIW+uVyzc/Blda2b80BPpVezfG4tgc1p3HKfPvrAbY4Ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M7iekfihGGncrRbOBERG3QeRSGUe0DStydbRWS41RI=;
 b=GL7qwddgoKWLWxCQrrjSekuX+bVqLnq532SiBUq12KFspR9xy9mXOGiT27SyxNrWpHO/jCy9iQdc7tTipXKULYlO7TLvK3ROkpkXf59HHak781O0+Z24WDh6QbqAzYCUIKlvunBHkddVy1ZdbN0HGU4WOm7lqBpVSioRBEFLtzhyll+PSWmMTfcmc864Vy+KUTnezaeDKNeZ5C8/9SmMjmtsT62wIYjYDFciw1k83AOLN+BkN01NDw8jDGF2ISASJp4UBhwzJQ4QzW36Cwewk40YW8PpPvg1ib0wuYcv6IXtEEOW7c/HyR3iEy05W2f0daiUnaGh1hh+tjyr2DjsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M7iekfihGGncrRbOBERG3QeRSGUe0DStydbRWS41RI=;
 b=h8Rl9hTYB7CQEcUq4rEv9mgSJJalPWmzZg7Aa9aEMPQwegCuLp2a8BAAUNKwGSGuRoDEgs32OIxuuQ/IPYGXkLrsVjZ7qm4SlSbSnzenlGTuQNp5TlGbGrMdmuKFBV8NGg4pmW7FviwCjnKMQvlENlMVrxHMOnRyBAl/vDgnQ9bXhTdmO/MtQmBCNfWa7jySk0EqP+H3ZZvloZhBOr/n1wMNfod/V4jjidHk75FAmXYSxquR6KoZH4ukGRrUCU2kl/Aj4ZDlkSEygCBWcgQ6JORBW7Bwdc7ZNcAalRgG9++x2rGfbVDDaeYYON1OAdbx7tbdJ93QZ1IQxrIFPv8BKA==
Received: from DS7PR07CA0019.namprd07.prod.outlook.com (2603:10b6:5:3af::7) by
 IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.36; Tue, 7 Feb 2023 21:20:32 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::e6) by DS7PR07CA0019.outlook.office365.com
 (2603:10b6:5:3af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Tue, 7 Feb 2023 21:20:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:25 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:24 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 06/10] iommufd/selftest: Add coverage for access->ioas replacement
Date:   Tue, 7 Feb 2023 13:17:58 -0800
Message-ID: <f84abf4c53b04a150b7823f5e5a53e41e78f972c.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a10cfe-c5e7-4e72-45ff-08db09512568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btITJS+q1qOiFQkPoIqJteKx3sJ6No2kMH3pmAQWuBllhI2nvEMA0L8zJnRo8xx4H/hB/+1gqwO9L0550ov3HnljnPADWl95/rvFEn6S/rF1U189TpV/Jl/mBdW5ggbd0zr8vUSrRVj5Hnp8iYGOHJzdcrTL+6h2qL3OhZQwYGSucDOpsU/8foGUJcpjeujtJZ9c0q+YOs8aEyXXaFgjrcReLyx/FjrQ1haUWCvB38txK5evPyOWzJL/PP2J7HMVMslsUMn2NFXTHgypzFQGH89xAWtuO4ejCmjryzNJdEbrpKQGiM0uW1Xc7G63M6DmR1bPF7ynZ/z5BYsw01Qxnbra9rOKh7Yk7pSGr+i+e5mJwK6WVfiaL4Y2lqJwUuK2kOsmcVg6CnTM94xezME3ejSg3VfXrkTzWaV6FN6VSfGHwjrDCu2TocTnBqyqKfN6G9fesNRj5TOw0E5uaCwXSt0EXvbw8Yv4MdCllyxKgiEQh6Byw4Fv23ty2oqQaEpTpmCJlHFKJQObDAn5uBLvev9t5VRtQU4x7pl3zyYfnWq2Fb19Upxq4pA+TuF/KL9pLIJAS0JwcdSbwofPCijka+v9eM4DyVo6cchtsgRZBwfj1xXKKQliZGWRAFNBKYTjNxy+MWN+6ptRpsctbKCFV1GZ6moJdI0+vWTLFItjuKIEPgiGbYW4/yluZJdntC+F82D7cZDd1QkGuSWmGGlh0g==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(54906003)(110136005)(186003)(82310400005)(86362001)(47076005)(336012)(426003)(40480700001)(7696005)(36756003)(2906002)(8676002)(40460700003)(7416002)(36860700001)(5660300002)(70586007)(8936002)(4326008)(41300700001)(478600001)(26005)(2616005)(6666004)(82740400003)(83380400001)(316002)(356005)(70206006)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:32.6242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a10cfe-c5e7-4e72-45ff-08db09512568
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add replace coverage as a part of user_copy test case. It basically
repeats the copy test after replacing the old ioas with a new one.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 29 +++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index fa08209268c4..1e293950ac88 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1239,7 +1239,13 @@ TEST_F(iommufd_mock_domain, user_copy)
 		.dst_iova = MOCK_APERTURE_START,
 		.length = BUFFER_SIZE,
 	};
-	unsigned int ioas_id;
+	struct iommu_ioas_unmap unmap_cmd = {
+		.size = sizeof(unmap_cmd),
+		.ioas_id = self->ioas_id,
+		.iova = MOCK_APERTURE_START,
+		.length = BUFFER_SIZE,
+	};
+	unsigned int new_ioas_id, ioas_id;
 
 	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
 	test_ioctl_ioas_alloc(&ioas_id);
@@ -1257,11 +1263,30 @@ TEST_F(iommufd_mock_domain, user_copy)
 	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
 	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
 
+	/* Now replace the ioas with a new one */
+	test_ioctl_ioas_alloc(&new_ioas_id);
+	test_ioctl_ioas_map_id(new_ioas_id, buffer, BUFFER_SIZE,
+			       &copy_cmd.src_iova);
+	test_cmd_access_set_ioas(access_cmd.id, new_ioas_id);
+
+	/* Destroy the old ioas and cleanup copied mapping */
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_UNMAP, &unmap_cmd));
+	test_ioctl_destroy(ioas_id);
+
+	/* Then run the same test again with the new ioas */
+	access_cmd.access_pages.iova = copy_cmd.src_iova;
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	copy_cmd.src_ioas_id = new_ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
+
 	test_cmd_destroy_access_pages(
 		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
 	test_cmd_destroy_access(access_cmd.id);
 
-	test_ioctl_destroy(ioas_id);
+	test_ioctl_destroy(new_ioas_id);
 }
 
 /* VFIO compatibility IOCTLs */
-- 
2.39.1

