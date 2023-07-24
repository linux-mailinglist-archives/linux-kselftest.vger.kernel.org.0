Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6F75FFF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 21:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGXTrd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 15:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjGXTrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 15:47:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A035171B;
        Mon, 24 Jul 2023 12:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNiXxPzzkSc1hV8uiONYxJ3M114u5aAiWpYm3xiWkGQ5ncfeZMmO17Vx4cYq0szHXUj5akmvtnJY8chPLa2W/kKalMuKYBd+1uvA7OJpZLroov7xE5+k8fWrW+nsEAmZZ+L9SwFOgVEq9KmPtDkp3M3MtSu0GK/e7siLXJGhXjwMw6WJWJFB+bDnHIZOWL7xHaVKEi94YeTV9wjZ0ac2s/GAMTBB8CwlGsNbExH/57ekytSOUWDY3ILhn6xUrIidNST/7MtKkMvkwOccOG2Sin04zaf0CWvzUVjNpJVKJ1Q8X7YzPa/mvCNU9kLxhcDurrTpes4cTUrLqW166HBb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nMiFNc17QaihtpaDB0awKleAE69A9p/ShiAMzml/iQ=;
 b=TI0TsjEuShq+Dl7wegIewfP+rBPQpZWvGPNIS7FvdVoXGfLVBhI96WUwOnkl4TZF1Yza3eLy/zslq5usl8yUY21v5LrKyhjCbcbzstBEEEjKgo9qh3mYdrHtjAFLN/y+ckwGhz0Peo98b2G9+faNnAz8nC5BVxXXc+qUEifuFGzkiNpA9jAPHmzkGFxSpprUrD1nBFc+N4VQdxllSbBjoohfLsELZ3DLOFMHX/O73whZwgzFoj1AKHSb6g+TLluQPiP9KPLXO4WFuocsTYvxo9cbJDBM0vJGAsi4LND1cI79de8PwGKLxD5U2XTFSfcBUtQNMxIrCVZVQp/e+MKXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nMiFNc17QaihtpaDB0awKleAE69A9p/ShiAMzml/iQ=;
 b=G1qCVc268CvxqRgKNp9cCVVyeD5ArBKh14d0K41zehdt2xcS8JA+oKr8Tm8BEE+Fzfcj9Amng2L9QFuEOX+J8+I+1FwOPJXWjlMgvQ//49E7iLJwVt9uJpLiRL8w4ogfKaDi4AHav6NEQn+NGxBqmLXoCYc5gNz46K7zG7Z9xrwqRfCLyj8u3MzQ0z9Vs+w0sS2KwNeXbtzCiga/Pr1g4IdRBySvxZu8q0GhnoajpIehDJN6AAw80ZqwRgHoRQA8KwLR8f56Ij80GJ42kXGkW+SH2gSk9Cq2YzlPsISKANTeGcCv83BKYvVmkasUwAEhnI0eYD9BD94Wiri7NgaGdg==
Received: from DS7PR03CA0113.namprd03.prod.outlook.com (2603:10b6:5:3b7::28)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 19:47:26 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::a0) by DS7PR03CA0113.outlook.office365.com
 (2603:10b6:5:3b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 19:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:47:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Jul 2023
 12:47:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Jul 2023 12:47:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Jul 2023 12:47:14 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v8 3/4] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
Date:   Mon, 24 Jul 2023 12:47:06 -0700
Message-ID: <55016f5bccaf825c28fc0dc4fd0254812967b91e.1690226015.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690226015.git.nicolinc@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|PH0PR12MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: eb524821-4b55-4a68-8c5a-08db8c7ece2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7Gh+xOWDgTYbwMbhp5nAoT+/8Avqi274BSlyFN+gIxZYsd4qrDuCnjWXMHVNBNiBhb9RfRRvLDDAl81yzbRhxrwkcui4VM8PYKyX+4fcT5EB5gIcW3uLSjAVutSJtfyE9rLIA1LjxCqiZskeH2+I0a/64bdyHhJVaI6k6bj3O0pVprkpaYeAFqsVsbpw3UHhKiYLZLsEMreZETLaMDnpqCOrfVA2MOfnfK229PzIPiNcVnzDG5D6gq6LtN/KVPjIZzbuz2B0pGsdVh1BOG4F189Xg2ux64cZXRvOsfvT8GowJ03GT5YfLb4dQeNGHN4Zb0b9V4iGbXuZj4aptHT+xtebX91mrLUPBjynOqM7U5Mjsz9aE2G2G8nFj6r8WVZZ/cER2QAk8AIvqdkvHjJJU3v4vdzrcD5CzRfLYml7Tr/GirVbkWKAnmMy4ubGcyHllOlJF9MFUDi4MVfwzpVCRB8aLVXguqLNFflHKP8k1BE3nQoU0vZIjoNTiExY5RSXj9MLlWSDuISOjSxl1FiwmSQsourZqPGu9+l//uGk9iA6XRFx4WfI9NYlmJDJl2Sdr4kc1Jgp506XxxL+75ZEa5/T8WhR21r1uM2yasXGwIsFo80mmPo1OlPDVoejQPoEE+SmudavfJR2k1GE0mhBtqimozDNPPxVUUcVTmon5xoFUYYVSaiLI6LuzB7arJ1NUr3qjm9ah28GzUnVX5AFUoRnR1+KrGfN7dbxjzD2BA=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(316002)(41300700001)(4326008)(186003)(336012)(82740400003)(356005)(70206006)(70586007)(86362001)(7696005)(6666004)(26005)(2906002)(40460700003)(426003)(36860700001)(83380400001)(2616005)(47076005)(7636003)(478600001)(110136005)(8936002)(8676002)(54906003)(36756003)(7416002)(40480700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:47:25.4641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb524821-4b55-4a68-8c5a-08db8c7ece2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new IOMMU_TEST_OP_ACCESS_REPLACE_IOAS to allow replacing the
access->ioas, corresponding to the iommufd_access_replace() helper.

Then add a replace coverage as a part of user_copy test case, which
basically repeats the copy test after replacing the old ioas with a
new one.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 drivers/iommu/iommufd/selftest.c              | 19 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 29 +++++++++++++++++--
 tools/testing/selftests/iommu/iommufd_utils.h | 19 ++++++++++++
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index dd9168a20ddf..258de2253b61 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -18,6 +18,7 @@ enum {
 	IOMMU_TEST_OP_ACCESS_RW,
 	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
 	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
+	IOMMU_TEST_OP_ACCESS_REPLACE_IOAS,
 };
 
 enum {
@@ -91,6 +92,9 @@ struct iommu_test_cmd {
 		struct {
 			__u32 limit;
 		} memory_limit;
+		struct {
+			__u32 ioas_id;
+		} access_replace_ioas;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 9d43334e4faf..bb2cd54ca7b6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -785,6 +785,22 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+static int iommufd_test_access_replace_ioas(struct iommufd_ucmd *ucmd,
+					    unsigned int access_id,
+					    unsigned int ioas_id)
+{
+	struct selftest_access *staccess;
+	int rc;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	rc = iommufd_access_replace(staccess->access, ioas_id);
+	fput(staccess->file);
+	return rc;
+}
+
 /* Check that the pages in a page array match the pages in the user VA */
 static int iommufd_test_check_pages(void __user *uptr, struct page **pages,
 				    size_t npages)
@@ -1000,6 +1016,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
+	case IOMMU_TEST_OP_ACCESS_REPLACE_IOAS:
+		return iommufd_test_access_replace_ioas(
+			ucmd, cmd->id, cmd->access_replace_ioas.ioas_id);
 	case IOMMU_TEST_OP_ACCESS_PAGES:
 		return iommufd_test_access_pages(
 			ucmd, cmd->id, cmd->access_pages.iova,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index dc09c1de319f..8acd0af37aa5 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1283,7 +1283,13 @@ TEST_F(iommufd_mock_domain, user_copy)
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
@@ -1301,11 +1307,30 @@ TEST_F(iommufd_mock_domain, user_copy)
 	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
 	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
 
+	/* Now replace the ioas with a new one */
+	test_ioctl_ioas_alloc(&new_ioas_id);
+	test_ioctl_ioas_map_id(new_ioas_id, buffer, BUFFER_SIZE,
+			       &copy_cmd.src_iova);
+	test_cmd_access_replace_ioas(access_cmd.id, new_ioas_id);
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
 
 TEST_F(iommufd_mock_domain, replace)
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 53b4d3f2d9fc..70353e68e599 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -119,6 +119,25 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 #define test_cmd_hwpt_alloc(device_id, pt_id, hwpt_id) \
 	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, hwpt_id))
 
+static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
+					 unsigned int ioas_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_ACCESS_REPLACE_IOAS,
+		.id = access_id,
+		.access_replace_ioas = { .ioas_id = ioas_id },
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+#define test_cmd_access_replace_ioas(access_id, ioas_id) \
+	ASSERT_EQ(0, _test_cmd_access_replace_ioas(self->fd, access_id, ioas_id))
+
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
 {
-- 
2.41.0

