Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC0E6E9BF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjDTSvt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjDTSvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC33C31;
        Thu, 20 Apr 2023 11:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay6qb2YA/ESu5dYk+Ulr47A5vCiVtzhV9OyrMWs8cm4+47N6HUtXnFs4lqa9Rt+HsMHR3QPRXKTwxjJB29B+m8i7TL5XGD4ZyS9FLvi5FqrKPVW2iP5sViFtrDKGMsqLoV20kxWOF/v+Ai0y7hLY4wBc7ybdaP8VFwT8U7YQnHPXZDxiCw7cwY7iw2lT4VOG0JVx76M0Yc+AIgW3/CYMZflIYiXLQE/Zm97E6DKInoiYSLkaQgz5xBvJN9DjBLMDurO/sF1lN/jGjJlmAhTNH0ClZo99dQta3iIMUsD0alX/9fgoiU56n3EJPkJPTbdiwXZjbDtjLAMFbwTqGGdDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+913O9G4ulLwvk+m50ADYtqHPLOTp0dqAaNi68zgDug=;
 b=MaisVIL61eo13RlpncUwvzCgI7TQpfOZj+iE6L/AinI4qDAo1BUqafv8fFPsK5uSv6u6dcQVZanvNOyOJ6PgQ0cAoEFkNybT/fayhYhBHROKZxnWd8jzPg09oBuu0Go9lL9TwTBc/Br7da2ZaMBjEbep1C65wLj9BSnQx1pgFwLdkq0/mrlliOTjBGfEfmu4XJSj4zHxzr4ve7N85SsDor5CqWNyiMlOLFpP6Kw1u3r8tNlEDiSeQ1ZKC0WMpcSN5Uy7P31SbwSc7AGES/mto9Oyp62yqFKH+fxdWvQ8wn23q1b/RIzN1f1AZvsFo5CrUvdpgmY4BFBk43mwrqYRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+913O9G4ulLwvk+m50ADYtqHPLOTp0dqAaNi68zgDug=;
 b=UXp18yPQ0bRz5v+9/4J/HK5p3B85LcGF+A0e63oBtV8/GT19pJK9ObyPQQxHaWUIQRRw6yXH1PbPThlWt/g0Ba98T0q6HPouGU1QSc1aaqDJJxUWv/xUOMIWhxECrngxDlMgTog7Z/fMwUDcX9ZYuVl6R1axl+b3f0blCh2P1VuUNDieDupiX9Bd2VEoWH1i3kJHUmSVMv35Jng/3gAyndbT3TVrGpHh/C04lMlbYai7vkKN67s1YVnP+Gzsxorz0bWuZs1H8cGiG2AvR3WOCNuONgW+DkoTyLQQ+hH1bj5Z5wEZc9YWEA/RlKPwK/pDPZ7FdU2hSus4PdauSgZF8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:39 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 18/19] iommufd/selftest: Return the real idev id from selftest mock_domain
Date:   Thu, 20 Apr 2023 15:51:33 -0300
Message-Id: <18-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0338.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 14968afa-e3af-4620-b6c1-08db41d044d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3uErnx77akByO8HnNE/DUqIu3LQdA1PltYvVxahXi+BZjyMwHLzCszsUOvCMZ/+Ga+AJWry3aGAWHPCb7eDzKhbuUjX4QezpGWdmKAUc1yZFZ1wpr0XKgaXh064zuJtQjl7pL5Tdwh32J/9anM6gaD3WijSUFZ/gIMxaJN+hGizA2SLvLbxoyLy8vGjqJPPREQa99fsL+ScrvXCM5G+ZSHnGSXov43ETiDaPxTB02FvY0ZYSaJf69UfL9xyYt7btMz/RavfRcwSKw3xxQc1DWR8qQa2bxrx+n/P6nH9u2wGcpnoqbOMMtRRVgh+qtoBEJVqKt7/xNfnow+wMy4xcd60pOteVdgf/0DB5TJPtB2JgqzYrLxHpnqbyhXpKAix6FQJu2Yv0nEPOM80K69iUf3gQ+lvQu5n8LDF3AlNZykmcqImBAYY7sySWjooT+eagLCCKhT+spwUfefZu2fJvJc+OphmwA5Ju7J0tz+g2Z0uftc1Pfz9cAuSsRG1KwIX1Dsc8P70Nvz8Uyiv7LeNV91cg9ZE0nVzg1qsLlhdXPrQ1ckxrkYlBpdj9kBYzUnQ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z9rylqqRrRZ9IxA2PoVzAvgDXPdaxhanlNnGK3gPQJi3XD6in7OwgB0MG/nh?=
 =?us-ascii?Q?3qpq+J/M8ljtv1Nyxfra9PiXP8m0DzHSja0vYEJ4tESZXWnimHNDcFCpRVty?=
 =?us-ascii?Q?6BRSrfvRFar1wl9uREVMVctf5SD0phZaeuzx5WlQkgwL9rXu1EC95CoomXlF?=
 =?us-ascii?Q?1h5Ju9NKg2ZpLVM0Wb5Muejr/2I0LnmFSW7219GyrmgH64yqTCPuou8ht2/8?=
 =?us-ascii?Q?HCAHLTAvCrO4Bh8kHQAnd11W6/aQSJmhEiJ+PAMnkbdax8R9oqaUHJN8v7+3?=
 =?us-ascii?Q?QEXLER+zkMwH/sHYcvtFSgSb1cVNmj/m38jv7aVF0p6kQyYjkYYXXEtk4PQk?=
 =?us-ascii?Q?c6/9AtyLku1xo40DbRfnyogsLWyYTxuhdahqeUTWFseDygfFQK/hu8AlhMXx?=
 =?us-ascii?Q?XzSAQtIgBzCogUHln4ZWb5M6uHeRDwrIqx8mp2cieEgkrdRWUUpi++I1Ykd9?=
 =?us-ascii?Q?kYj0uIxh2BCx88tmjRAUn+fX7LqyNHpbGe1oJi4O5YkaZ64LLU4ni3o96Ee6?=
 =?us-ascii?Q?DXE6mNBn0LX3tdYPo4LV2lPOpBu3jACUD37mRYTEIniljH6CHJZEnqREDvrj?=
 =?us-ascii?Q?axepQBLQ3FaQ7SAU4evJoI9Aj1JpWh/PbopzMl2iEYyEGkTUmlqr41kKGYbg?=
 =?us-ascii?Q?YDdaiPdfy7Lz0Gv5YwBiA+TPgy/znzCJGfdPLwaB2K3CCGIX8xxGgwY7dc/E?=
 =?us-ascii?Q?2bEeAKFy5Hb/sDYFIeRZvwKV6SnljizvZqf0Na/az08OSFS92CBZ4XaWuXTb?=
 =?us-ascii?Q?8r6soxFeHKjjX6KhYL4YH/vobCpXli3lWWtTOxxr8tXN3LpKZkLYPxIorX1r?=
 =?us-ascii?Q?RhEIRY+2eFevHJkJjIdJbQjuw17ZTgEPFS3z11C/O64ZAy8K+oMfoXP162BF?=
 =?us-ascii?Q?ddLWW9aoqcHqdXCOaHoIQhfYHg9DASuKU8zmbmWSVsQMpE9p7BJ1gdvQ36dC?=
 =?us-ascii?Q?dF7NNPdgYCOgRvhjQFFBbQgmUPTVm9z25EEVTa3q22uaLfh2685l2FzeYBOY?=
 =?us-ascii?Q?UWHgJhhQ3x2nAVMdXVXcgOoNJpx9mhcWPWyfJnBhIqvJPYbw54U8SupuPJbv?=
 =?us-ascii?Q?VEtcDRHrUjDXsSJ89ctqRpO49SDqODWmfREOs92qIZH4ZRZEWM+6jfrLXqhd?=
 =?us-ascii?Q?JbVzYyP2uGymjoIlNKblBxSt8kgoZdVJiucZZYLVTmKSQgRkAXhk73JVwOXt?=
 =?us-ascii?Q?hyBrTTNHCulPFQctAn+xRyyryNu42ahUjlLGnH2qixycJkCS1bbyYWVAVPwR?=
 =?us-ascii?Q?EppqCq0+atZmBcScbeB2Ku6OcHPOT4/kR8y6OASWAYcQhJxkD9lVAQoD5YDz?=
 =?us-ascii?Q?9jmUjwG//Ad5r7qmoZG8Ry7jG94xQaad/pAeB1STViBuvkbevKmLmwpbXKd8?=
 =?us-ascii?Q?ucA6kveIvqZBX/cFCF0j4jYkDb9bCZLB3bIc/DmKGFM1vX6N3Dtq9EoqDdva?=
 =?us-ascii?Q?KSD6j3IFwcTxyhPGYn454EyB7qOBQt2N9YVELwrIftTR9QcKACowHyrtlCVZ?=
 =?us-ascii?Q?yLoeAixx5X+c+gdGEZblmSzQGjbTCo+Mp2lKt85Xv3go9Sl5CEVT3Jr/kwXw?=
 =?us-ascii?Q?WLhAzXXP+Seg4pK1VUxFOzvYu5RDBJALk3XKVQ1S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14968afa-e3af-4620-b6c1-08db41d044d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:36.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icZtNpZymvWDSIfG3b/+DLpT0TlwT1hTLfpkgmLtvOLHdh74wNa1HvCnmVhQcmpE
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

Now that we actually call iommufd_device_bind() we can return the
idev_id from that function to userspace for use in other APIs.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h           |  2 ++
 drivers/iommu/iommufd/selftest.c               |  1 +
 tools/testing/selftests/iommu/iommufd.c        | 17 +++++++++--------
 .../testing/selftests/iommu/iommufd_fail_nth.c | 18 ++++++++++--------
 tools/testing/selftests/iommu/iommufd_utils.h  | 12 +++++++-----
 5 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index e3f1035cbd6464..dd9168a20ddf4c 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -52,6 +52,8 @@ struct iommu_test_cmd {
 		struct {
 			__u32 out_stdev_id;
 			__u32 out_hwpt_id;
+			/* out_idev_id is the standard iommufd_bind object */
+			__u32 out_idev_id;
 		} mock_domain;
 		struct {
 			__u32 pt_id;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index dd792294298ffd..a9c22560f51aa9 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -443,6 +443,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	/* Userspace must destroy the device_id to destroy the object */
 	cmd->mock_domain.out_hwpt_id = pt_id;
 	cmd->mock_domain.out_stdev_id = sobj->obj.id;
+	cmd->mock_domain.out_idev_id = idev_id;
 	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
 	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 57559f60ca6486..a6bc090d4b38a9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -211,7 +211,7 @@ FIXTURE_SETUP(iommufd_ioas)
 
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id);
+				     &self->hwpt_id, NULL);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -262,7 +262,7 @@ TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
 	if (self->stdev_id) {
-		test_cmd_mock_domain(self->hwpt_id, NULL, NULL);
+		test_cmd_mock_domain(self->hwpt_id, NULL, NULL, NULL);
 	} else {
 		test_err_mock_domain(ENOENT, self->hwpt_id, NULL, NULL);
 	}
@@ -647,7 +647,7 @@ TEST_F(iommufd_ioas, access_pin)
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-				     &mock_hwpt_id);
+				     &mock_hwpt_id, NULL);
 		check_map_cmd.id = mock_hwpt_id;
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
@@ -802,7 +802,7 @@ TEST_F(iommufd_ioas, fork_gone)
 		 * If a domain already existed then everything was pinned within
 		 * the fork, so this copies from one domain to another.
 		 */
-		test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+		test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 		check_access_rw(_metadata, self->fd, access_id,
 				MOCK_APERTURE_START, 0);
 
@@ -851,7 +851,7 @@ TEST_F(iommufd_ioas, fork_present)
 	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
 
 	/* Read pages from the remote process */
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
 
 	ASSERT_EQ(0, close(pipefds[1]));
@@ -999,6 +999,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
 	uint32_t stdev_ids[2];
+	uint32_t idev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1021,7 +1022,7 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
 	for (i = 0; i != variant->mock_domains; i++)
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
-				     &self->hwpt_ids[i]);
+				     &self->hwpt_ids[i], &self->idev_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1215,7 +1216,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
 			test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-					     &self->hwpt_ids[1]);
+					     &self->hwpt_ids[1], NULL);
 
 			check_mock_iova(buf + start, iova, length);
 			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
@@ -1424,7 +1425,7 @@ FIXTURE_SETUP(vfio_compat_mock_domain)
 
 	/* Create what VFIO would consider a group */
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 
 	/* Attach it to the vfio compat */
 	vfio_ioas_cmd.ioas_id = self->ioas_id;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 96fb2f04623f23..8ab20df4edc8c7 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -315,7 +315,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -326,7 +326,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 	return 0;
 }
@@ -350,12 +350,13 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
+				  NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -369,9 +370,10 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_destroy(self->fd, stdev_id2))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
+				  NULL))
 		return -1;
 	return 0;
 }
@@ -528,7 +530,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -603,7 +605,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL, NULL))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 8b11bb70095269..62e01412a7679e 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -41,7 +41,7 @@ static unsigned long PAGE_SIZE;
 	})
 
 static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
-				 __u32 *hwpt_id)
+				 __u32 *hwpt_id, __u32 *idev_id)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
@@ -59,14 +59,16 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
 	assert(cmd.id != 0);
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain.out_hwpt_id;
+	if (idev_id)
+		*idev_id = cmd.mock_domain.out_idev_id;
 	return 0;
 }
-#define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id) \
-	ASSERT_EQ(0,                                     \
-		  _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, hwpt_id))
+#define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id, idev_id)       \
+	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, \
+					   hwpt_id, idev_id))
 #define test_err_mock_domain(_errno, ioas_id, stdev_id, hwpt_id)      \
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
-						   stdev_id, hwpt_id))
+						   stdev_id, hwpt_id, NULL))
 
 static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 					 __u32 *hwpt_id)
-- 
2.40.0

