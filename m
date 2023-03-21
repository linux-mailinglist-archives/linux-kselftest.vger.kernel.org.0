Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DEF6C3A2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCUTQR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCUTQP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:16:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701C2E0C9;
        Tue, 21 Mar 2023 12:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2Vun2XEdL/Q4DZ/GpnjhDCbMu7ls+CyGwawvk2bLx1CjJXpDL1vxw14Ws4S6Iny6j3MeBHzNIyqLqlwzPHqMRI3aMURZgj1VPzW/ZG6I/JGPYdgOrWHMH361Y/l4W9YN7VWlsW5UFEHPFaJtcZR2SxzXtEebJozvJ1GKtqcb8c7Z1YUkN0V/YbChAXCegEZk+n43aWuFSdRjVv/b1n7KsrbtJDzQP0//00QrBf0wR5oFYFjrjxxwDWH7MBvPC36svD83pyfK1SZRIFnrnsPZw/O+eZKBj4LaucCmdmhc7p8FPRMRJOhVlE4iyc75gbU1zxWMq/PaVsw/J6JO66cTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOcG539MMnqjzoKFpxZxHxg5clbTg/iq33gdBZ/41zc=;
 b=QJWptBtBTaF0LWSGNcHEindjLOS8hoxZiJJxw5uR4x7o8KrnUJHjj2jcr97pLR1simGQvyk5yO1789+vT+yOW792GZ3IN79JdCEg1btrFxCNQ+rWMWE9pwOf5t3eFtgehEjGy7a3A++u/NJdzVpsVIZh5BYMFBGIA+vjMqvGrQ6aIQct9N+Pbn/nfRO00sAQWmZL2qhRjs+3OXjisVlIV5IOElaAWCtxGc1G1xRIO0hN0KgEPzxIzPonepOznsSU5xIYO68EVTrScg5Ra3j+JXLaa9fGuHxBx3bGPQO7Fns7CzqR6/alsuMxhLsLJJgRWIEAJvYGzY5f77EfvaesYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOcG539MMnqjzoKFpxZxHxg5clbTg/iq33gdBZ/41zc=;
 b=GlzTI4S+jlWVvweWbnSbDDdE0M9pVml9dViQm/gatwI6K/8D3vXSAy9qSK+y7mmlJqFefZelyetgVHLy+JsJ7M+gYqVFFvpTphon9E7LLaNkdo25DaGSTj9ZU/tIyYA4srVOJVD0570s2KDsBcX5wVSXMJF+/Qdqeexc+JxcmU53MpJzt95JlOqPEwxSJLCSpBwJNJTmfjVFDMT/PdvhlnU51E7ztPPrpk6UdY6S81lCBu9w/aH7bPs0FwgibV5u/JbBvMy8jGsTljzMJzltEoEidOwXX2X7BXSFcjF5G59mqN3pbe+HJe40j53mXgxwM+QgqXHfZliUVvc2YRzEkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:15:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:15:00 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 16/17] iommufd/selftest: Return the real idev id from selftest mock_domain
Date:   Tue, 21 Mar 2023 16:14:50 -0300
Message-Id: <16-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:208:237::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce7ba72-a238-4781-81d2-08db2a408e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDQebHLjHOF0j9+yighkI8mQoUoLmyWJlnlBSzdH+GL1iVfXkPdBuLbGSWYqIXdgCjuD8y+1YJt9JX5URfpZCHu78kKii1qlwG329GGbLUjQjYWq3XJ7g18Yn4AubcADpbkc8OWSdgvJ5fYPO87J6ZhEF5fgg5dS3eUVTTf15ryONMciSkZEY2o+3OxmeUCp78xTjGvtFjiDbs76RBL0olkd5ZtrtrKiT23Yqu7ZNLKT4MM5QzD3rGGSTXPyVP3guKqVrtrSQ9Wb0YmeoZUKZVwPPWhOtcL+Bs47xOh0mNjDquXrIDWDT4qAHONdEm6pW1ofUeeq5LpqrqvQ49Ck4iWE6pSKDVeFeodbFcR3QRtDzAT/jFMbp5J0MVZJxuKLQKQMoVuo5SVkVgzK1LPmhPqMvwwA0b87YYV7zjfErvOYuH17wKBoVkXVdMpbjjDHYoBvGwyq07zX1NkVwtNszDy9dw/f+N3YUxkYSkPv/O6NbBRbDjPfY9YLCMYNdOxN4wWgvFP6E3QB63h2xHR6Wx4CslfPd+wsOGXXJTpfWCt4F8PSiooWU2XTkBcRtEnb7TpjHp7Ov7Wa8kSQsMkuyuAyc/GPah+UnVPngjbtO/7IG8ZpZyhvhdXoDKnhYol1HUYlX81BFNt0voI5LtRC6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(478600001)(86362001)(83380400001)(26005)(186003)(54906003)(316002)(6486002)(6666004)(6512007)(8676002)(2616005)(6506007)(38100700002)(2906002)(8936002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OAptKlWVGbvxW6Mo4VilaJnmr2IklF/Sk7Cm1u1mTrCp/fo86w3/DnKVfrAU?=
 =?us-ascii?Q?o+laTn7cIHJRH1q5Az5kjSbGT5ktQSSswXd/OdlEVC1tHEFVqXevkAfviUrO?=
 =?us-ascii?Q?kC9fHLbAm9+1wzaNZ1Jtsf5DI3sdohfHkvEBB2iExug6BGFQiRkQcr7yLKoH?=
 =?us-ascii?Q?qRTAf2U1M2fVqQMRMCikYGp9aK/rGC8znZAH9ElMMQ4C8CoW3VlRtmyyDtBI?=
 =?us-ascii?Q?/CEqroMS18+DXRcmZWdJIUAV3ZFQO/S0LlyfVJImDWxBCDkyTMD6yh1e6A87?=
 =?us-ascii?Q?kr3zW2FZ/DG/itloRPxQWr2HUGlUgdSNvgfF8d9mbAsK9PR1qYBeD+1tB3a5?=
 =?us-ascii?Q?DAxliCnPF0diR9bMvBBA2bMjRjlrLnn3nNA5Hak7E6aWiHpmKcmyEyDuAyFS?=
 =?us-ascii?Q?luycOBp8Sz1Uo0nI810BzTRAmbKMrpHsQIRHptBEALhmEduPuTdsAkITFhXz?=
 =?us-ascii?Q?hB4adqimhCaWdSTVuroeiPA+q0Km++SSU/BhrwyyvI3hwtLVW5XADcfTe3PI?=
 =?us-ascii?Q?BPBubDhUHu53SVKAa5bIXQu0R7Y1Rnfwg2kXep34/OoR3iI95R8yHLCrkwW6?=
 =?us-ascii?Q?fuEB1FrcFDq2jmKIgV8cCAsZYKpwA+wWaJn8N1UvKd/cTXZdtv9BTvItsT+f?=
 =?us-ascii?Q?R9Dh5hXid+BgkmyfYphrXqu7ts7ong0oyjXsHmhwBS143THtNapYfNQkZFwe?=
 =?us-ascii?Q?303Q8oL5kD7heTVvTKnL3DV7bjLIka2wTbxSYIWWaUbz69fLfLAIhOfQl8Om?=
 =?us-ascii?Q?GejozbTts+4Ds4qTUZuffm1RlO6tIlb/UUdloG3wVl0Wnn1S51+g/wKUbB+z?=
 =?us-ascii?Q?eDAJMpUKdtJoiIBZkGc3PrUdfBOP25QMp4ACu/uCrd8c2sVe6PY4yZjYDXTZ?=
 =?us-ascii?Q?6wCvnNQ8tWOB7x1SVda9+8cuq7uJWfIiIIjG1sj3bizMCgrOlxNfI1BFiX8t?=
 =?us-ascii?Q?L7724JjrywBeWPKUMLlW14TeEmEA8tedNO6GLrSXlIs7YgNXKAf57FO+DeAx?=
 =?us-ascii?Q?R2kdpCYKyXxNvDcdD7ZtJ50OZ4AaCL+1QPyHApCHy12q40S0LW0fay9epcez?=
 =?us-ascii?Q?z4vADcgqY98+hECH7KCzRyfkgpkYhIu4w7RjyEYkpXmyqUSE9o2qiPwyun33?=
 =?us-ascii?Q?SG6hSg0BnfQo1f2MFGmp2UPzhFX0AKdQOwmRHBUcWuQMiwaDnEkxGKFgMQCa?=
 =?us-ascii?Q?699xdxdAa01z0Bii27UDZ308QNSrZeJbCvjb6MpGdKS4WAj59U1y/Gu2kYEe?=
 =?us-ascii?Q?t4SzbUjorvuvP/Z1AWrw+WgpwFNhRi5/OxM6sOhjN4LDl/8YvFQ8aTDKIn82?=
 =?us-ascii?Q?iS9U9C6nBxvVALNR/yX/udbFbE3blzRyP2DuTCavGPSVpPXHHsTEJfCAMiEg?=
 =?us-ascii?Q?nNlAij4VdM9Eb2kSlbNP1tq8XSljQ8cbsT/Jshiw31yp1jyo3SMkxWJlkTkN?=
 =?us-ascii?Q?PC9rdfnvy8GILgZRTMYkxpTj+zNnweGP61VCGBdiQVYgKZNE+ifcX+rYSrj6?=
 =?us-ascii?Q?EmN18poGgXX/kPmffvpTifNf5SaC/qxdVuma3bfk3z5fjZk+ityVXl+8QnsW?=
 =?us-ascii?Q?0pWtn2eBz5ZcZQlGW2cfPdXHnJaSNEZeobn+AgEI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce7ba72-a238-4781-81d2-08db2a408e95
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:56.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u15En11v/OucgmL6wuYutOQMWeUOIM1H4c3Yx9V683IOelpyX7rcraJ67q4dPRFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that we actually call iommufd_device_bind() we can return the
idev_id from that function to userspace for use in other APIs.

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
index 77b0601fd13a71..83c98a371f9e7a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -214,7 +214,7 @@ FIXTURE_SETUP(iommufd_ioas)
 
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id);
+				     &self->hwpt_id, NULL);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -265,7 +265,7 @@ TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
 	if (self->stdev_id) {
-		test_cmd_mock_domain(self->hwpt_id, NULL, NULL);
+		test_cmd_mock_domain(self->hwpt_id, NULL, NULL, NULL);
 	} else {
 		test_err_mock_domain(ENOENT, self->hwpt_id, NULL, NULL);
 	}
@@ -650,7 +650,7 @@ TEST_F(iommufd_ioas, access_pin)
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-				     &mock_hwpt_id);
+				     &mock_hwpt_id, NULL);
 		check_map_cmd.id = mock_hwpt_id;
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
@@ -805,7 +805,7 @@ TEST_F(iommufd_ioas, fork_gone)
 		 * If a domain already existed then everything was pinned within
 		 * the fork, so this copies from one domain to another.
 		 */
-		test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+		test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 		check_access_rw(_metadata, self->fd, access_id,
 				MOCK_APERTURE_START, 0);
 
@@ -854,7 +854,7 @@ TEST_F(iommufd_ioas, fork_present)
 	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
 
 	/* Read pages from the remote process */
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
 
 	ASSERT_EQ(0, close(pipefds[1]));
@@ -1002,6 +1002,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
 	uint32_t stdev_ids[2];
+	uint32_t idev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1024,7 +1025,7 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
 	for (i = 0; i != variant->mock_domains; i++)
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
-				     &self->hwpt_ids[i]);
+				     &self->hwpt_ids[i], &self->idev_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1218,7 +1219,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
 			test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-					     &self->hwpt_ids[1]);
+					     &self->hwpt_ids[1], NULL);
 
 			check_mock_iova(buf + start, iova, length);
 			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
@@ -1427,7 +1428,7 @@ FIXTURE_SETUP(vfio_compat_mock_domain)
 
 	/* Create what VFIO would consider a group */
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 
 	/* Attach it to the vfio compat */
 	vfio_ioas_cmd.ioas_id = self->ioas_id;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index baaea15b355297..7a3d149019da92 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -313,7 +313,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -324,7 +324,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 	return 0;
 }
@@ -348,12 +348,13 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
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
@@ -367,9 +368,10 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
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
@@ -526,7 +528,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -588,7 +590,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL, NULL))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3222f246600422..e67a929a5c87d3 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -39,7 +39,7 @@ static unsigned long BUFFER_SIZE;
 	})
 
 static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
-				 __u32 *hwpt_id)
+				 __u32 *hwpt_id, __u32 *idev_id)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
@@ -57,14 +57,16 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
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

