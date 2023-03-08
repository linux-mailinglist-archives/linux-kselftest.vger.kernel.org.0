Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC7D6B0B06
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 15:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCHO0k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 09:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjCHO0i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 09:26:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D89FC5607;
        Wed,  8 Mar 2023 06:26:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNlLMHuRpJxqw1jKc91VGxlaO37n9XLzaorOutcNUYa2p78/EgU68vjmCsVd6XcBtCKMHFY4xZSkxuoWNKlpVmMiMc9kyEPGEJfLaZI++ohmikVVO3CPvgM9z5GMvEzUY54xfUf0EbZyYuFPwQK6fAl+W7s35ECo/wVIKc4SUS4EWAssdspnSNYoWVhNtdm0XcSTbGs3zgFhSfz6pnE4cmr7RDLmIaZR5Co7JAE7J5+X/Cr0mJybhqpOgtl3orVZoY6J4KuWwiwxvno602upzUwOzUApZurcXg3OvbeKk53NXhqa5NOegIrVxezK/4YDjhlc2RC44DesVk8W9p0DKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzbPeHexKIf3PE+bJGFCFDeSpY8S/7mrVS5Vct/ECOE=;
 b=V3LMYf4dNG869loRKQnAsv1GTqCgVBwsVnIR9bNJs+tm4TRUMF5tAxPNN7TVj5q8Ky99aas8W/LmjCozJwnEdToPCS16ARBzuCDpgiloVaWcRsX2ctwXBAuBhgFkmOAQY9AlJxiRT/azZE9lbduasM6l+BKZfL38JypCWtOpOA64yZug+vli4fjeHIjXODzflMEwBjaPITDX2eDv9BE0jgrv97z0FXZqxODT0kvzsGPK5ooXmUPNwMDnKPkD6oSUqUm5/Up8vs7Gv3PI4nSxyqPdHrbWnMxSF4STtxbX8GPtkmBkxob7bvM62+p7KGDxVMEDNFYu2P1+mru3tZqLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzbPeHexKIf3PE+bJGFCFDeSpY8S/7mrVS5Vct/ECOE=;
 b=E2Af0WqfcrGSqc+evPt3KnFGJ/hH31Qyji2fFEMW81MvU1V9xuooYP9jRpsQ4dkYhtuDLBmY6p/a3/9Irl5O8JWMz5P8j1KUK4NtjJFjY5LTcPcroPwIh/t+wf7uBxE+1ulwkJtAMSyj0PtPZleSaXWqsfi0CAn7VsVi3ZHh92UQYoF6jYjk3nPAhY8rUvBvF5r9AZkWMYTVl2yO3+nthV0LVj6OpClQ/dTRhiMZnNYtK62+QGSjz1mXxaitNY+NLJVdsdOpAeqdPsv2fHRuBS+B4t8cgs7/pE5Mh14NJ01M99dbZ1fJY78bOwEQ5PW7O1v/wtC5qeIXH18p+p1W+A==
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 14:26:32 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::19) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18 via Frontend
 Transport; Wed, 8 Mar 2023 14:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Wed, 8 Mar 2023 14:26:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 06:26:21 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 8 Mar 2023 06:26:21 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 8 Mar 2023 06:26:20 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v4 2/5] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
Date:   Wed, 8 Mar 2023 06:25:59 -0800
Message-ID: <08a875b83daf7047c3cc67ed0da23045b6dc6fb9.1678284812.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678284812.git.nicolinc@nvidia.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5611f9-f536-474e-a869-08db1fe11d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AohzTo6cZ+bS2wujbT7IXhMTHz/TB5dX1GQFjQ+CV/FX2FmhH7j7t8YsjuuHx7Ago5GwSJjW4oMj4Mot9VW02X7IxJMuLpoFwS2Y7cbjwqEp8+NX+1WKtkiKb+VH1U27JbjIgHdtG6Q7v4/g7VXgMf8nI2DDmBcJYfkylklY6qHMUBTgZ5Jx4+KlqjPaeSyRljnziqWBsLR9bjGsgLd91BxZoxyYMO0q9VKVD4YjbMLD7icNDNFxJYCCQ1nA4ne3cZwCvEJ8+prxOuFGheGE8J4xMBJysMgGiM0p88oJrxAiEVrEZLf9mZ5+RfAyjdEKLq4wsixJxYG+RD0A3ZKLSqtm327NUjjARwMkJcdO8VMOJe6QoGxG0p8QUyCHE/ZeGegJ4wCYCGzFvj2U+Fhn2QmhCO+Shqdv9k53bA0QlyBW6SwWt0tJB7I0ijts7+gxBlRvnX6aVbdI7iz2vJ5acfbizPIo7pecWKVOlUlnNwndJoNj7eyxTP/Ty0ivoazxMSxDxirOARgi9x5UojiKPq5KhR9XxoBXhLDyTPVhOvMfzriIIicjSKJ86aTT8f6ej/EOuzJ6YRHkrrn1nzl2VkVyUv9lZjFXEiEX/Jgc+isJs51r2iukQ7UPj18zOMqnlDlOodhNcPrPQWCaCgbsqN8BeBjcbdb+gAvZbxMsBci+1/iIW5q93XqvjCFQBNr9xjVLM20AbXS5SI/lQcuQhA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(6666004)(36756003)(426003)(47076005)(86362001)(40460700003)(82310400005)(83380400001)(82740400003)(40480700001)(336012)(186003)(26005)(2616005)(7636003)(356005)(41300700001)(70206006)(70586007)(4326008)(8676002)(2906002)(8936002)(7416002)(5660300002)(7696005)(316002)(110136005)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:26:32.6025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5611f9-f536-474e-a869-08db1fe11d9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new IOMMU_TEST_OP_ACCESS_SET_IOAS to allow setting access->ioas
individually, corresponding to the iommufd_access_set_ioas() helper.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 drivers/iommu/iommufd/selftest.c              | 26 +++++++++++++++----
 tools/testing/selftests/iommu/iommufd_utils.h | 22 ++++++++++++++--
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index dd9168a20ddf..da1898a9128f 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -18,6 +18,7 @@ enum {
 	IOMMU_TEST_OP_ACCESS_RW,
 	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
 	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
+	IOMMU_TEST_OP_ACCESS_SET_IOAS,
 };
 
 enum {
@@ -91,6 +92,9 @@ struct iommu_test_cmd {
 		struct {
 			__u32 limit;
 		} memory_limit;
+		struct {
+			__u32 ioas_id;
+		} access_set_ioas;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 60f21bb3f3d4..d7832ffc3aa6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -732,7 +732,7 @@ static struct selftest_access *iommufd_test_alloc_access(void)
 }
 
 static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
-				      unsigned int ioas_id, unsigned int flags)
+				      unsigned int flags)
 {
 	struct iommu_test_cmd *cmd = ucmd->cmd;
 	struct selftest_access *staccess;
@@ -764,9 +764,6 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 		rc = PTR_ERR(access);
 		goto out_put_fdno;
 	}
-	rc = iommufd_access_set_ioas(access, ioas_id);
-	if (rc)
-		goto out_destroy;
 	cmd->create_access.out_access_fd = fdno;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
@@ -785,6 +782,22 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+static int iommufd_test_access_set_ioas(struct iommufd_ucmd *ucmd,
+					unsigned int access_id,
+					unsigned int ioas_id)
+{
+	struct selftest_access *staccess;
+	int rc;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	rc = iommufd_access_set_ioas(staccess->access, ioas_id);
+	fput(staccess->file);
+	return rc;
+}
+
 /* Check that the pages in a page array match the pages in the user VA */
 static int iommufd_test_check_pages(void __user *uptr, struct page **pages,
 				    size_t npages)
@@ -998,8 +1011,11 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 			ucmd, u64_to_user_ptr(cmd->check_refs.uptr),
 			cmd->check_refs.length, cmd->check_refs.refs);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
-		return iommufd_test_create_access(ucmd, cmd->id,
+		return iommufd_test_create_access(ucmd,
 						  cmd->create_access.flags);
+	case IOMMU_TEST_OP_ACCESS_SET_IOAS:
+		return iommufd_test_access_set_ioas(
+			ucmd, cmd->id, cmd->access_set_ioas.ioas_id);
 	case IOMMU_TEST_OP_ACCESS_PAGES:
 		return iommufd_test_access_pages(
 			ucmd, cmd->id, cmd->access_pages.iova,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 9b6dcb921750..399779acce23 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -117,13 +117,31 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 #define test_cmd_hwpt_alloc(device_id, pt_id, hwpt_id) \
 	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, hwpt_id))
 
+static int _test_cmd_access_set_ioas(int fd, __u32 access_id,
+				     unsigned int ioas_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_ACCESS_SET_IOAS,
+		.id = access_id,
+		.access_set_ioas = { .ioas_id = ioas_id },
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+#define test_cmd_access_set_ioas(access_id, ioas_id) \
+	ASSERT_EQ(0, _test_cmd_access_set_ioas(self->fd, access_id, ioas_id))
+
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
 		.op = IOMMU_TEST_OP_CREATE_ACCESS,
-		.id = ioas_id,
 		.create_access = { .flags = flags },
 	};
 	int ret;
@@ -132,7 +150,7 @@ static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 	if (ret)
 		return ret;
 	*access_id = cmd.create_access.out_access_fd;
-	return 0;
+	return _test_cmd_access_set_ioas(fd, *access_id, ioas_id);
 }
 #define test_cmd_create_access(ioas_id, access_id, flags)                  \
 	ASSERT_EQ(0, _test_cmd_create_access(self->fd, ioas_id, access_id, \
-- 
2.39.2

