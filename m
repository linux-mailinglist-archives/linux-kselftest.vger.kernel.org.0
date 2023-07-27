Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D377648B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjG0Hed (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjG0HeF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:34:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D209EEE;
        Thu, 27 Jul 2023 00:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JepxWdGO2yPomhsisjjnzrr+bOf//+4Bizda7Oo/ttMQHThSrULbN2sfIgWGN6nZF4hxCNZrQpkSyf8txxrLVRh1AjzONi1Kxo9L78O6ZTcwuYrN7aS0EXZLappceg8SDJQ9LjefB9cLxgZudzczuMzaZaS4/5Ty4pV8vrlR20frkTGQq5nNaUtNIC0Jxj7d+lPuxMJaquxzbO1bHFOoiWOUPw4OCixhAk8I/nCnaDUyS1w3fVNC+KE2e+7mT167IBxam2ETHn8ghpMA/1sB0ikLkKvSmPCxBhGnNVaXNy4XHEPkxkJQUyKY1P0W49eXUTSi85WZB+s7muvGtZZz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iirMKJG1l4d932PYYOqkXDT5WydmhkNOrAq8wo1jKiw=;
 b=Bqai0eqMMUNPBZtqz7EQhBMIZN2WmER09ssxaK8Law/IxY7y1xvmCIU7fnyKewIJH77+LZIBHJUVkswYJixF92BCowG3zJqj3ULnLtCVKvHXvt/ptVjb2wYunrh6JddEn/FGrUFVMqTVfLH3YytJLxfzMxjygPGjws7rCYBMbwaHXRNLoabEB2HpuBnR7vY7o9GStY/k+IzartZ5YvtQWJy0D6JjGtWKyQYF5+fOIL6EuhOe9ftj1aLzYbGY1NyjQms79+9WrZkShm/g7AoyBljLiHRWjBue52jVcKCVocrGcayK0SfQX7heEW31nUeFjzhfz3Lj8KVIQFFFQPsSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iirMKJG1l4d932PYYOqkXDT5WydmhkNOrAq8wo1jKiw=;
 b=e26Ktn/dxIPEwtqruHJw/sJKgyFKRiS3rPqkC7I+UIE8EYqTPZzRQyjXDCwxmQLXuH++7gym7wZzGzqDoKCW3YMKBSBB/QgDyPDCgPRKgZOdVjabWHy8B/BODEoE6EwjsqCCFRgJWfvDkFFv1d66ihP6wX0ne4XLfLkjaP9MZUnKZRbEBPEMrjtf6yNQ1pRmwTClZjz3FsoT782NY+kgkElEf51o9DPIhlVa1lAjzNhoOrE8Gy54SwA4Wy4BouKJoDOJtbTd3Iczegebe/YGAAn2IqLxrGZpCr5l40jGc4r+AYv+gPeh1CTT9IN/i9ByjErsKYlYxd8wGwO4dgBhXw==
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 27 Jul
 2023 07:23:45 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::12) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:23:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:23:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:23:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 00:23:32 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v9 5/6] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
Date:   Thu, 27 Jul 2023 00:23:10 -0700
Message-ID: <3168353d5c77140c5a8d3845ef06f34bac57eada.1690440730.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690440730.git.nicolinc@nvidia.com>
References: <cover.1690440730.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbb8a56-762c-423b-367f-08db8e7269f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2LcpgPWEcKCf2gIw1ZXeSe2cyZiR5/fKJxuFDNI/CKNgCi99MrJxCv5TcEp6TleoJq4zXrwiPqVT2Ve9rlSBWIut1NdtbtxrO/Gfdkq6ItH4rRD5++7PHnVK14BLM5iKIG13QXlEdXTdW0HZ3kHFJLidASwwxCSG8JrvvwdOM7ZDbDa1ldkSUvXN/UjyWPR5fY+CLQxpKDVqjIQ5F2wsM/NtsrFJxMcXDLGu1aF25tDZ6o6j5qW3UgrG2AAbuavgJOh3okm5IlfI22CMTS+uSqeGjlV/YtZgyT4rvdHk0T2GtClh6C3GYVzvt/hiJdi6vmCPOr9XjPuDOoe9SADCMf13c+zmN6VlxOa7Ws7kM2jLESVpBLCL/iex8LIatQ9WpMOcvQpXyY1ip5wCRhgAa1Zs+JSQRLwixAeuXEADQNJTxjedHAZjnUNAPdsJ99vyxgt4Ndh0ayzpA7zmn8USZFSRPYzg1L+hW2IWQptKOoiNSlL+PEMkhADMD4VCLQYTYLrzN1pIWXSkKSPx211zmnPtWIIA8csJTcsCQvmJTL0Fy01E5OCqVCD1iM64vlWB68sWw2z34Tmnrt2tuCKpwDq+Kd4joWY6fp0kMEx/8ifyBX14vlWrUdt2upR0PA7+VW3sE3444a9E0cXsYV1vt/z7AmXdkd87yny8FO2GJZqHD+Aua7HfpS5g6wLg3vcfhAA3ZgG63h0wrDAmhWvLrSxINO4sYHlJIdcDN8R7ZU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(54906003)(36756003)(6666004)(356005)(110136005)(478600001)(7696005)(86362001)(40480700001)(186003)(336012)(26005)(7636003)(40460700003)(316002)(8936002)(70206006)(4326008)(70586007)(8676002)(5660300002)(7416002)(82740400003)(2616005)(47076005)(2906002)(426003)(41300700001)(36860700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:23:45.7213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbb8a56-762c-423b-367f-08db8e7269f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

