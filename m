Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063B6C61CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjCWIeM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCWIdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:33:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8944227;
        Thu, 23 Mar 2023 01:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrajgAIFgzIgu46aq/FoU9S3newxYoc++C8ANvhtzXf5XIgruT80vgmOKkO29+eODx/eLxnBU17rFbLiUcMqrmIdfnAKTuOaDXTg1IcCrel+f7p86lthouAcNWCSBZiushlUmRafbyBWKSwS2j4sjsa7TpUN9jgEAxzHb4Zz3fF4ZBhhFCWRbFFERFcrsbcNgdJSdV0xVDv5fFO0g3PD10KBWG+raqmSU3UNcWfxWLlFRwnEphSeMm6GNVpkbSa/laM6EkMzDT1COtm/oksfwuw8UxQPdHp86y/k5iRxLTn1ucAO+jkBQPW7jWgBu54E2KAcUFwex6JBeAfPtcifhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRlPS1nvMhiSDecvNOXKaOh/AfENj67Efp6e+8Plco0=;
 b=ODrUu8exaklSoHmKQS2BSqg586ezyo1eQkj+45s/HN6/p5sUv5nQnAlMj5lDc1OYZYcYFF54ZFmbMdoNllWH3OXrOSbFO9Gx/nyaLHuPJ5OxSBxa6xpqqoc0aF8o0wxGsB86DXX0c6AqcwERP4cVbLqSPSh3BJ0Z2x1BIhRpuWqcktUtJPd4qnJtrC6Iu8mvb1dvQ8Bc0del8YqgB+qKdPgPeqj9pP0n6iDUcNtoRd7uMXIMh9GZBtlNtYeqirhnHpymb4oUoP2egQ/Jtf/cb/BfNkab0q/ZjLjvlC9ieM2uB49KJRcMnmyeP6OLHBjyc6NhGkHwV106BpVJ9V21KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRlPS1nvMhiSDecvNOXKaOh/AfENj67Efp6e+8Plco0=;
 b=G5cIXxqY5yIxGt9hexiT9bPe5cfz29f/8BhQAuO82ylvuQdu75f8NEFmgrQtZcNY9w8h17MQCkBG8DYyWoq9dYgTubfhGhk8B7I9oy9nRiil6eS/YSe+9TSJajC5t9z5kIQBMow9h93jfl8B8HVDTbLPVLuwsgwUXRncbtcM3qcS1uX6eXBMl7NBkPTL2TFMtnKAeJBvPeSsuNv5MwCqljBKMdwvC4amvwLWuIUhYU6UNeV/VSWgt1s0h9FTRyibOmYg36ps1goRYLYG92I3c2sZ3HpSfQcxQ/KtRHGFm8KCKAJawKAtMbhdSbVQODAiD5RjROXzP2tSrp78QG0O1Q==
Received: from MN2PR20CA0006.namprd20.prod.outlook.com (2603:10b6:208:e8::19)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:33:43 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:e8:cafe::54) by MN2PR20CA0006.outlook.office365.com
 (2603:10b6:208:e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 08:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 08:33:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 01:33:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 01:33:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Thu, 23 Mar 2023 01:33:25 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v5 3/4] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
Date:   Thu, 23 Mar 2023 01:33:04 -0700
Message-ID: <370c59332690cecc62b95f69313ffe772c8d91c7.1679559476.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1679559476.git.nicolinc@nvidia.com>
References: <cover.1679559476.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: d18b1a61-4d52-446c-743e-08db2b794f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gu6QBZDfvjMtFr2XHD3wrHCPkzv1P+K0o6nQNp7cPzgv4LfLZFE4TQmFTD3uLadMuG4/SlnBLYHxj+b01L8DZ+/nUplG4WPwNmir17QPlpafGeVgR0ZKsGa4fko4fv/Iu/5WROjZScviCq0s8JrRJGUYGadhsk93cEMxr/x6SHtDU7+fg19zb5injIV69pk9j5xstb97/BaZftyIAro2BtD8UNKwEBdeft3fCif7DGykliiB4nAhqM/Y49Rnh9OEaOZsy+z+QiCBkHZ4iZryRR9xRlneNhQ4MT+K92YnVuaTQXTNssuzL4Jex4C6mA4llyqJ0M8UszGOiIEcmc9FWs4irtneL3SYUr55KTsUqcRwsJgvSm9CU8COF2i0nn96EyUQdMdxxUF6Xms5kiy1vcGOy5sq/SyWSsILiXTbRNpkB3wcZPUs88Qm+ghl2sTPteqsazzEKGJ0P5kAZaqqsVzFTIfXPy9K9r/O7mSjnpz79WJY8qls8KxX+B90jFFNXUu8WbGfmEYlr8peT+b4j4AfocJEb1vsYgfjuGEnhX9SqMgQlewe6VOjJYIk17P+9rcjXeRWbZ+Ie1qes5Yy6K4skgvZoMPeaJ2nzzn6yHk2xX2m9upTTh6vaWYduO/tXG+kUWa7q9znLj3U+0N5gtVgYUah4zUyD/hPAmISDv1tLVKMxxQK6uKbbWvsfxD4kIYas9u28VsJfz8Hq1JI4XKOjzv3jZif2ZZup5nnSw3mRyt/ClwA9oGBW2SNsMv9
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(41300700001)(8676002)(7416002)(5660300002)(4326008)(2906002)(40460700003)(36860700001)(356005)(7636003)(82740400003)(86362001)(36756003)(7696005)(26005)(6666004)(110136005)(478600001)(70586007)(316002)(70206006)(8936002)(82310400005)(40480700001)(83380400001)(47076005)(54906003)(426003)(336012)(2616005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:33:42.6037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18b1a61-4d52-446c-743e-08db2b794f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index ff4fc88640a0..9f6b2d71bc87 100644
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
index c07252dbf62d..3c8cb9d6c22b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1252,7 +1252,13 @@ TEST_F(iommufd_mock_domain, user_copy)
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
@@ -1270,11 +1276,30 @@ TEST_F(iommufd_mock_domain, user_copy)
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
index 9b6dcb921750..c31e75607355 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -117,6 +117,25 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
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
2.40.0

