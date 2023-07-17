Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF4756B81
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjGQSNp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGQSNo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5CBE;
        Mon, 17 Jul 2023 11:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUHL4d1k3Sy6WjXIJanfwg6IHLFCAyRRj2wqf4pUeG+i8E2ao7JmEx5mUyjp/uZiWwKS6a4ffBQb9VyvfqyA5vGxdq9SyuM6CQ11JKxCLJ/LvfgUEL60kG3Iy9Dn4NPhoFy9z7wUpgRmgGN68PCNBnO0POWWfHIcq6W3mx5JcXCk6bV4/L7WAwqXAqh9HlGzuT83uEssfMamJz058Us3P6XUqlmb9GBHK435YM6cTTltLVMgyk0cf444YfslHsSB6zEuUVKtlEL5IVYdHWqKmhfHE0q2DhPA1dEhD6szzDTxu4cErKfuthlvPuDgD5PU6grzZ18fqPD0Z72n7k/AEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIFJCw18jV6oAN5RmGtWFp3dTVEA00yQpg3MSokBEv0=;
 b=VT8CZp52zDVgrkbowVlq0H47KsJTBotmUb2GG/R3u9gOXlKLeR7/mdtxbUZj2Y5i6v+WLjJyJeKKCWyEriGeXQ11HKnYX4UyX3TfYZ8QIaKCNnr9pk4rX3Kd/wQ3OD8lzYUTXGvAtoufaJx6J3sqU3USvPrhAiaV0tSP1lA6hnSzg6032yIyYkHdqbikWdW70LYDrDpo9Y9KjAR2Sp0OZtVXhEbYCTLBcsM/GvgzPstR5t55Rdlq3jOyKxWPVE4gPUfUjYcNi55bf86huClwuX2rBf+QfK8BWSz4eIpScS2iNGl0yMXQEFgkOg42nVgWFfKq6l1wlgfLx2C12y9lFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIFJCw18jV6oAN5RmGtWFp3dTVEA00yQpg3MSokBEv0=;
 b=bw6iN2TwkIjq/UhvErTGjMXscUchHL+IIM404OocsXQj3CyYn95yASjj0ztqt6XdPdj09Xgy/mux0xn1xmolV3LJ1zcvEFS4psSlECaTf6Ys2oTN0gqq/b94FE2D7kQKdTBTzwkDr241bljl2fVdfehPMUpTXgxw1tVngpHJqTR9+UevZB2i+oFdJWvzH2gPFV1b/rqHwgaE/cXzjuhATqliv3qCc1vsI4lqWZlllCzU+9tqP3TF6nZhQ2xIBrad+w5rkn4v1OM18pUWiRK0KCwuKP/iWNs/Dj3bUmVXI+eLN9DiVzLPcebDuqa6Uo+g9mDg8FBGR6j0w2spM/KK0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:22 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 18/19] iommufd/selftest: Return the real idev id from selftest mock_domain
Date:   Mon, 17 Jul 2023 15:12:14 -0300
Message-ID: <18-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0073.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 490f4a91-06b5-43e1-73e0-08db86f15b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAPn5AjB/5xIwrh8bSdnbm3enD+hdozi3EUTxepvFpyYm0ku54DI6idrVmpC7pN0+9Ou1uxWDMh6SCPuZ+apOqmwirKPPk5Vnlhm1kKvS+98bZkwuGXlfLSLojsU8e6ZzJqo+qNITQYPNE/DEteEROVGfAUtbC/npxQdCF3GbbLZQxPdRheKpv9wVlICSghBxIRjWC9bMi6POj3N7Q4zXxf3e3RrycE1ELL0Esr7vqkin5/3Wev9qHLELwc0yGpvqvYeNIfrHlKrg3zE8EcJeuIBOlX6SXrgGAYKtZnDs1i2IFTHOsDlDS/AiGxNZ+XTtubqMST/FvvB8pK9uWRaA3zPkUSfqBZFPsv18qoU69+CDuByj3gBqe8SPrZusIf6DWK8NVDS2FQPPMjoVuJyMiK7ZmLauWONZ+juIqH/kMZv5tpLK5ccA/WpsDFvSmkJRmU3M8vlxKVmDhMw8oOd9zRYmxf0SIOX7zLpYJANpg45qQic5LxtYBmYribyD3aHPmGlxShuRlkhopnG1qR4AqhdNLPEEcvhtXusDCDpAnvIftYalRyo74IMfU6oBbHy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6666004)(478600001)(83380400001)(186003)(2616005)(26005)(6506007)(6512007)(8936002)(41300700001)(8676002)(4326008)(2906002)(5660300002)(316002)(86362001)(6486002)(66556008)(66946007)(36756003)(54906003)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfIxuVh3RqsxjNFaIs6CKl5kwCmk2W3ZHYl7eFiclAm0Yj8lL/wv4+Veg3JW?=
 =?us-ascii?Q?NhH+VsdG7kVAgQT+aRNYMjHDPV3OooRHIjzdK0IkjpDJfi9g++w9OBkuS4Kw?=
 =?us-ascii?Q?ZejtztQsfhneqvZq8MYCOKJaWXMAX+aqMW6G78ipp+o1JOE307xj2UUA16Bj?=
 =?us-ascii?Q?JzKqgbuicTJOGwz+MOp6Y+O0i/yIrI5/GI6jdhsBF+lw1bSQFiwhMqNhX/lm?=
 =?us-ascii?Q?ryV9umjIm2M/+9g6H79HGyvNEvzANLVp/QkLzE4XoTxpFP6AcqhNLwkDAL+C?=
 =?us-ascii?Q?ivh/LzeH0a1sI+YOphTFDmWonea9UWXgC2eY/Z2pjHPIVPFkZjbCNA8O1NcE?=
 =?us-ascii?Q?5H3NvX0iUi9nJ2CglMfJz7VWzUi5EGj0auHQIgLFhx0V9zMJmEWb96i/83CL?=
 =?us-ascii?Q?pju+ojWYvO/FpmKT9v11YaY5buuvoPcnUmwp96pd8EXKVwv6Hjrz1qG4IfsM?=
 =?us-ascii?Q?eqQQ62oMuiwvP7SLCIatT7uq7ydf3TgcSGkJDlJ/nKsWHDwJrb7u2BeQGK2F?=
 =?us-ascii?Q?vOzNOLNyCQTmKIKcBdB8kTLBDO3sgURMXPWHavdaOkYamry0LQFHs1aW3iN0?=
 =?us-ascii?Q?OYoNDepBGtNILNILmaHoRdpvPbqD2R3Ag5WoNw8jH9uEHQ9Ro97Ip4Oo4stl?=
 =?us-ascii?Q?L4BH2xk05q5lB5rgD7GA07de/kesNrNpWvapNRr81pKpKrttE7kYmTjmZ2Ot?=
 =?us-ascii?Q?jIhL7HjGZKF3M47CW1Yf0zgL6zYPw1/O6ljz8DdYhMTvq4JD3A8/LAi3GkQl?=
 =?us-ascii?Q?wi6mN2UD+v8RqoF3EVuqlT1IBVcJ5yJsF1TpJpiehPMmwfv2Tlx6h9F50q49?=
 =?us-ascii?Q?B/MjofBZ6NS6B0CXBG9nIPH/S7CqUZG0ooFav9b7hyc+Tkon0Ea488uhp3K7?=
 =?us-ascii?Q?o14GWRgBTslNmwvA0+YMWy+DbPUL9T6U0kno7OYBZzAsMSovx8mQgHy6TrED?=
 =?us-ascii?Q?6GC0/NJgpM6fJvnMMRrrzH6AWeQDXfdmysIRard3bTKU715vtSd2xc9ePo0c?=
 =?us-ascii?Q?ZtIbJlFIXRVd9nUCzyRLXdZXDu6JTBqUFukK23WAVZEeptDKojpuCtXg3kCP?=
 =?us-ascii?Q?NG7iwC9ztI/4NvBIxBQk5jsstWdRmG8mpO3zkwGYHEoq6e+WYYXs8nxKJ3o6?=
 =?us-ascii?Q?Su9xmx7kB1ZVXsQ4Oy9fZi1tZ091lezb/O3xdLWZuOd7po5lFMMEQTLQwhZK?=
 =?us-ascii?Q?+8esXITnSr5Td0RsfbiJmiGPXj53VpNsHKhY/tXkWt9BSj7DDT3uSgaphJn5?=
 =?us-ascii?Q?3EbTAD/kKRJ7pLVpTAzVEOTlLJEEz89kmXbfnSwtPIIq8Wqo/qirUxMsLxmv?=
 =?us-ascii?Q?W9GW6iMh/4K2F5EDRaKftjEoko9fsX+mFm2NEsiC16ZlRtvHht3WzOxuG8Q1?=
 =?us-ascii?Q?2sIctiFU3dgWUzBa7rt57rgj62xIHgTdd9ATsCtbWgH3tEWEdzNHB0o/Y3xw?=
 =?us-ascii?Q?UXMlYkkuPt8BxQLMpAIW124Y5gg1SqpkJSFxA+ZqSHxF6PsPHCt4Ao8RLP5K?=
 =?us-ascii?Q?f8hHTJaGEvB28eTjEVA/T4HKULU98Qf/8CvQ5nxQZ4oTtUWu9QiCgOHzUm5c?=
 =?us-ascii?Q?OnMXg0d9QGJMK3JaJPy1Y8ULCLF3eBKhaAm4VTB/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490f4a91-06b5-43e1-73e0-08db86f15b7a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mT4//Ikm+tVTNweW1tgxiitbbjTkCAhar76YwxeaQGPRMdpCc/XjoU0iGOetoP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that we actually call iommufd_device_bind() we can return the
idev_id from that function to userspace for use in other APIs.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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
index eb33dffb955dcf..9d43334e4faf16 100644
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
index 96881ecca5c757..78841aba47d038 100644
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
@@ -681,7 +681,7 @@ TEST_F(iommufd_ioas, access_pin)
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-				     &mock_hwpt_id);
+				     &mock_hwpt_id, NULL);
 		check_map_cmd.id = mock_hwpt_id;
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
@@ -836,7 +836,7 @@ TEST_F(iommufd_ioas, fork_gone)
 		 * If a domain already existed then everything was pinned within
 		 * the fork, so this copies from one domain to another.
 		 */
-		test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+		test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 		check_access_rw(_metadata, self->fd, access_id,
 				MOCK_APERTURE_START, 0);
 
@@ -885,7 +885,7 @@ TEST_F(iommufd_ioas, fork_present)
 	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
 
 	/* Read pages from the remote process */
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
 
 	ASSERT_EQ(0, close(pipefds[1]));
@@ -1033,6 +1033,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
 	uint32_t stdev_ids[2];
+	uint32_t idev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1055,7 +1056,7 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
 	for (i = 0; i != variant->mock_domains; i++)
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
-				     &self->hwpt_ids[i]);
+				     &self->hwpt_ids[i], &self->idev_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1249,7 +1250,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
 			test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-					     &self->hwpt_ids[1]);
+					     &self->hwpt_ids[1], NULL);
 
 			check_mock_iova(buf + start, iova, length);
 			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
@@ -1458,7 +1459,7 @@ FIXTURE_SETUP(vfio_compat_mock_domain)
 
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
2.41.0

