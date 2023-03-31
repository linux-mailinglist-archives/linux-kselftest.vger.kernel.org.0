Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F196D2414
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjCaPdI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjCaPdH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 11:33:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BBF1DFB1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 08:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbX3YiocthXIPmVdvCviJB6FU3Kg2JnhvDr1xXN79F9blbAymtYWCH38VSGw0pEXrNh9iKnx/4DpUkjdyr5doKJ6ubnRhNyKBqiEZ2EYiMwrUNvGv1F8QIPmpBGQZdtdh1MbzpZ07VcQnXOlOJOd3lhruZtO0IFwaNgus4OuyQSycwY0lqTWAN98yWAb/O/stKfB2S2eI8yV7OgvuiMI9YVpJLKzYCBVI0n5sfFInsTvwM6ubXqAJwjZhdmTprlUnu0IHQnjL4/EyccJnn/c4Hd9MUDx3WSJBbTUuv0veoZd4sGRkQHQdGeXDDu5O3UuSCvuZri7kzOIlkPD0YnUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0591Fjy4KnKEslRRJa5GGfGNMMZezw8EwTcBf25l8Q=;
 b=gLWajSUi5yzKzzXXWthuoOJ3eEshSCPIgR51ng5EJPx3fWpn+cTJxDBxu4Ahy9HKUs+HmxSIzrSGO4Hpz4TZortucbJyiK3GKOrX8UagZBrFC+JpwD/w+r/vEkS0uYl52ccyA6Qd0RsVEEmwL+9DNehzQUU3qkqotefisz58MGLJVJ0j3YL3YBytVyg5WgZZkp5rYPnFzf6dH4mKgBPESpKihqObv50EBsYTHulu4WZuSVfU/ET1Q91Eooz6ryQIIunimrvwgF3bQ9R9/XXpx7R5ENsHzG2kZiBoEPkGWXJ3lZaaALaqlRknKLN6a56ADYMgU9g8Hww71rqKI80fDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0591Fjy4KnKEslRRJa5GGfGNMMZezw8EwTcBf25l8Q=;
 b=gU9UK+GtAKQ2hZI4GqI7p1FNhuxpC67VYnpEnBs+7TyTn/oa1DVCt01WV+Y6CvShqiKeQK78mJNYvkWtXhxRwOJUzGmdMkYNGiy02trrLdJIFPAJlf+w6E3lIVMzkMsroVQx3/ISWju03ZskBVKb01eDI8W9a7nXOt9pRCZgUvSA9wkKXSdxX+D0c4c0/hd3jUpAJWQfuTxF+hF91vskqQufwNj6xZnDGTKfdKMNljEAkANwtr460AUA8bfLbvKb7ViOGhgRk6aCE5dO1Jvo6knDbWRr1X0ppyXUkJW+xd8jgiB4EoVhdFj4ijKULaniNVAVfsfmsPwi5i6pSPYyYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:32:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 15:32:29 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Pengfei Xu <pengfei.xu@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 4/4] iommufd/selftest: Cover domain unmap with huge pages and access
Date:   Fri, 31 Mar 2023 12:32:27 -0300
Message-Id: <4-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
In-Reply-To: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4adff0-003b-414e-2e5b-08db31fd237f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3Yy8XVL9Mbe0111tjxwdbtHFMkhD2U4u/hz7NFQ67hbBExpFtpb40ojZuqiNj4PUTU+o17LibtM0ffePtTCLUR7Pz1P5bT46LpI+Pc0AJhMGxJ1VbjNrumI6oYpOrTkD9JcA9bXpqNH7mJwBCbkv3jveyvRN2IlJL6KZ6YnNgoFsyMrgfUn+2EJNqWWzsbbPHUo7+nxlvpxmYl2Zsp1XkCVmKxqcvqQEYmTkcua7uPgEMke1cVfemseEOk77pUQ0CpRiQzvW3Y44itq1UGFGN7ZWLMtKLK8mNF4hyUr4dhMNMFqEA7BzUgyld5qBvLL2Ghg5FsLyt0f3uXoM3pnZ7OqWl89zFmAH51NGZaWOt795jflyxBtfs5/mDJWj69F5NmYX20E39iQoTRC11UKN5rUHqnvNKnHLFJL6+UpcHKkQJ3zvoQ7pJN8GC2pUh5i7L522YeS1R9QCTBgHz1X4qTUGCwdjp6x/+LTXp8KeNcNUb92IYQcgDtlsGfbq7EztDvPnbqVf50fFSE+YDJBKAo+JdUG6/Ed5Gzt0i9ZwAIWJtRpc0bCub6Ja2iygSUsc2hntRNJHDjb/x/MF8qomNoK0PPrEGdzUR6KP4sT3yXwEiNyvyDPWRNElpzroRTm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(8676002)(54906003)(316002)(6486002)(66556008)(66946007)(66476007)(4326008)(36756003)(6512007)(6506007)(26005)(38100700002)(2616005)(186003)(83380400001)(5660300002)(41300700001)(8936002)(478600001)(86362001)(2906002)(4216001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2gpQtiGSc2rj0263P8iB+k5ebHt9zeQ7xC1zsxU6OTDRx/oXInHol8qfC3y?=
 =?us-ascii?Q?k8GNtxhFt5C0L7L/JmblBI46TdeUPHFs/tTztss+0X6AwqAV9cWxqO7bJtn4?=
 =?us-ascii?Q?7LG25PkvfNHNvHU2IHiauYFl825Ve2wowTrgr0u3fvMfWWYUPoJAvcRE0j0T?=
 =?us-ascii?Q?uMw7TbpP05F32oxUHH9arOCL7NLY7yiwVMEcbWrEXu5UU1wM10cZ4VrQDIpb?=
 =?us-ascii?Q?/GqEz0dnJ4dt5B7GNVaTxyw9vOSGgpEMZ6a14eC/m9Okye3BZnOZLvfRSuFE?=
 =?us-ascii?Q?lUDL+h+qEVmOlpRHwhjqauqezJ8BALYQXeFqvuEN9nFZXKdDWJwXOZxphuIK?=
 =?us-ascii?Q?CH65lyDpl5QwPOEyjCxMMRC0yWvN6d/rkCYRaWg7yxiqeCSGQPJyYKRPqzSR?=
 =?us-ascii?Q?OWDeX4uPTnfPS8gxjljYUcV5RyEVt0f3HnWV2G8tYUsloR1KYRac0OeVVKJ1?=
 =?us-ascii?Q?cMolYpr13bh/RuWTIWDTbZvxwfXQ6pYDwOAjb+V2nBPdSroTlaUy5L/R/D+L?=
 =?us-ascii?Q?Aeu0GtGFQaX69HJUJ9CCudFBWSQLZLC81jjjVatGt2P1VgrhHHlRiMFGY5GA?=
 =?us-ascii?Q?Xs8tMbj7rHMPsb5ixyFKNCtMwFxDgKDq3rKF87YfRJ1fgAqH5vL56UaaIM0/?=
 =?us-ascii?Q?aNeDUzeCWf+y1zw6HZru+RrZm6EDe4hEdF9OpSjgct7x0jV8t/Ig6DGy09/u?=
 =?us-ascii?Q?prvel6N5s4EUpd70WlOM+UkBlT+BhcdFdMsx9OXPb+TBE1S7b+yGkS2+cl28?=
 =?us-ascii?Q?0TCDHO/aYEot16W//dytTLlCqi0tKzveWd/5RQ19lSxckOe5tb4ECnp+jXzF?=
 =?us-ascii?Q?OlbKrBmg77UC3xh5OVLdg/4ZCzXM95S/Y7Xge304dXX3bSb8VjwyhGgeJu1w?=
 =?us-ascii?Q?2yJQINL9QMZY0lIJLOlIiJBop0Ey3jfoUox7w/iO/CYSFaMOSuIURNKdSKSs?=
 =?us-ascii?Q?c/Uq2Mwoc4nGm7ud2cx7K9aftMlKxo8XPdzoIbR/RvDSSe3Dv7t+ZLy+CShg?=
 =?us-ascii?Q?T44Hs2x2HmofxVAb9ZyQkyE+YWoNtxnEC8HJwBf8Ue8jDTjRFSD7QnXbs1N2?=
 =?us-ascii?Q?JMO4/3kGCG2p3ohv6A4RfVe7JKsZbeqYtlVVeZp/lIW/hn14gFcHhsy1v++W?=
 =?us-ascii?Q?pTeyURNcJWvT6GgFZZZ+M1ZG0Nb5YrM7Zq9kCRthzcPLuGJBo5nMJzpu+ZH3?=
 =?us-ascii?Q?ZX2+bN+XpRGQasVx/zcIkFhEeWRhCsZcafSY2FxHC4RwDrw1xjpqtnb1VqiY?=
 =?us-ascii?Q?BamigWKmQlJB1gzBJsDzDmsUNU7PrJGIM7BHvLgJjxb8QHQ2SzAyTDs3JLvX?=
 =?us-ascii?Q?MP9OLEpyhN2ijcdvJTUojBtC1CoR6SLKCn9Qj0zei5GS/p7dYRvSYWHW/0Q8?=
 =?us-ascii?Q?Q1ShZhaMr7blqTG1HQ08+FqtxI778bWJQVGCe966AvXFrXPciusDT3AK9TNU?=
 =?us-ascii?Q?YOdc6+TMT6CKH9BzOckFBjg7ITB/+Aa3gAduzwOH7uwkO8gNDK7yyH7DutFg?=
 =?us-ascii?Q?JeCeiSi2Oq1XS8mtHa2WHcc6Hfcz5PyOSeeSHAj3aJp7eVz0dTi/7JuxExhP?=
 =?us-ascii?Q?LurlOZRbeEICZuMYaC44sn6JjyuUGAtEAE19Fup3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4adff0-003b-414e-2e5b-08db31fd237f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:32:29.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l13otZJUNyOTifFF/PAhXUaunqOujfNLtyfLsp9nWmYTJacN+F1idlDtRvSnbI0k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Inspired by the syzkaller reproducer check the batch carry path with a
simple test.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index c07252dbf62d72..a2ce8f3c5040f9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -594,6 +594,40 @@ TEST_F(iommufd_ioas, iova_ranges)
 	EXPECT_EQ(0, ranges[1].last);
 }
 
+TEST_F(iommufd_ioas, access_domain_destory)
+{
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .iova = self->base_iova + PAGE_SIZE,
+				  .length = PAGE_SIZE},
+	};
+	size_t buf_size = 2 * HUGEPAGE_SIZE;
+	uint8_t *buf;
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	test_ioctl_ioas_map_fixed(buf, buf_size, self->base_iova);
+
+	test_cmd_create_access(self->ioas_id, &access_cmd.id,
+			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
+	access_cmd.access_pages.uptr = (uintptr_t)buf + PAGE_SIZE;
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+
+	/* Causes a complicated unpin across a huge page boundary */
+	if (self->stdev_id)
+		test_ioctl_destroy(self->stdev_id);
+
+	test_cmd_destroy_access_pages(
+		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
+	test_cmd_destroy_access(access_cmd.id);
+	ASSERT_EQ(0, munmap(buf, buf_size));
+}
+
 TEST_F(iommufd_ioas, access_pin)
 {
 	struct iommu_test_cmd access_cmd = {
-- 
2.40.0

