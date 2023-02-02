Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D500C68762D
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 08:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjBBHFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 02:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBBHFv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 02:05:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048118326C;
        Wed,  1 Feb 2023 23:05:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOLCpYnEFSRFWjkfoMIi9hpU2gzOFKziErXm7i5Uj72uCrklTMl2NQsTg809LDYPgr2tduOnMKE1KY9cmEKmJ22RKic+IwB9GukXN2z6Xpe+iW+Bc/IxYwNvRDI5o0FMkZvXBcmBVG3+dDuAQOMWsO/slmqqqH1caj7gnAz4bd5kqJMTGT8Z8SORrqrxuKPBA5JhHTz4cGQTG9GG3L2wHwAkobovBv+C10LVx9W1L2LKCYub7D6mro/QEbpE+3btr+BBb/y0AW6EfPgypWWUGsTa+Bv5rsErNxI4s5U0QTZJdK8+/xVHMl0bXXae6FTfKUI9j8Rk415ymJqbL9Qqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trqPQuSL508hbjLZkTsHtmMpbS6mglzaGKaP6bKXVsE=;
 b=gxS2GZo3RVJhGdHIeiGxsEwhFMvz5ECkD/e3FSZXdFwTGtNmfToaJzzKXctkm4k+1fcvNqmdXr85OCOXYcrIsJmxA0Ou7D2coIYM2T+eTxPWXjwQ/L4/cN7huLSZ604ZDyBM6akubx0kuMuCkS3Ah/rROTpS0T01XwbHT9Fh//BmQs6vycEBCZg+qfWcxWFk4hZTHOAUtv1y/WTY5RMbwnxE31e6QCtXLxCdIImC/Jq2isFJPU3M9XnUPQVcks0TJrffatOHdD4onTqyfer1akqLWubmU6UimtmqLBRgNK+0Doyaho53oTd7EECz5YUdHG/OTq5ll2WAMRIbP/02Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trqPQuSL508hbjLZkTsHtmMpbS6mglzaGKaP6bKXVsE=;
 b=CrvQ0kMK0FPfyzHPw5Zo2AoQKLrWNQ2VNBP+KnZ+xxYBAxoKraeSsGyzvhlWatqItU/fvse+tz3007fqz4CMGhi93S+R56PmIOGjZ0lR1ULEekHQ1GDWk8Cg8lvCOcyI+qbIjK+2fKKps2Et6uiJ9qoDg3e9VXn4Q3Z0mIAcWi+B9G57UuDlSMlLX8CXDcmScfegGfBwYnBXBQaCtFtisOadBn+30AmBedjQwwHgIqc7jIS0JlqP164ciEDgXnLHVfUYwaQojhITFmmaZVN9+Y+FgAMvdBEMz/fLMRJUV1dHS+m/s3GISKg7bUo2vM32LtmDKUs0+vM2jm1euxXHmg==
Received: from MW3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:303:2b::24)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:05:38 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::59) by MW3PR05CA0019.outlook.office365.com
 (2603:10b6:303:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 07:05:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:26 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:25 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:25 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 4/8] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
Date:   Wed, 1 Feb 2023 23:05:08 -0800
Message-ID: <34ca3fdafa57639834ee3cb1c9c398c518249d68.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d73a65e-dbba-434f-2d23-08db04ebe391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: la7hhRiRpY9MwlYxR+qYMy8vCmMCoYHf4qf7YXA9im0sXohc3tiIdylfmd+NnECR9uZAC7sEvZPxkIcFsFCLz3xcz/o9yZnuiJM8/GObgvn8fJbDwMKZva4ZfZH2uYKkRlw9G9lpX/JpDFmqy0gFVvTXVqhDtAMtRtLFkuSrWEbTQ+wJR8qhW6h6YnaM6f1oXrHSDt4lLdKGYHsN7CsRotk+9VJfHg72BmywffMSKJO8HXfhM03WLi42xmNDY7RTGyu9TwIuhw5bkoNHVDGy/4tRAAnbbBE8UUpxCI09efRab0vtD21BtH/drB/TkhzPsdgQ1eFJbGdBQjYHGs319k9rTiCSJVeYbXfwVWiLYqPoK8ie1WmqmIQ4Umvq4hj2d+AB8D0MTwcMd4802D5RFuj1gSbURSzpmYxE9egW9XPYvkIamUtuo13J3DZ1uagjqrQxoaoyxRWHqqhrs2+zUiFc8KdENEK+YqrnYyVh0pyeejEl9fc9NTXAxqjwbKL8RuLZ0BDBhlXY3uXEco9lK7rilPPs+o2BPp2Q54G8FxoEUk0ASSqArm0dKaPn9WO3y5m4CJJcTzoo9K8M996MQbHcpROtC3huustpwYZVu/sNBG+A+EtoCDNCrm23X6yxZH+1/QPfb8P0X7V31nyeHD+n7hnMCXIN4z1ViF/SmABSTjruqgeguhcluYgfd//tJ6m08PdIIM0Fw+w5JmU05g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(356005)(7636003)(40480700001)(47076005)(426003)(83380400001)(336012)(2616005)(82740400003)(36860700001)(40460700003)(4326008)(70206006)(70586007)(8676002)(86362001)(5660300002)(2906002)(7416002)(41300700001)(8936002)(7696005)(478600001)(54906003)(6666004)(82310400005)(110136005)(316002)(186003)(36756003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:38.3887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d73a65e-dbba-434f-2d23-08db04ebe391
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new IOMMU_TEST_OP_ACCESS_SET_IOAS to allow setting access->ioas
individually, corresponding to the iommufd_access_set_ioas() helper.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 drivers/iommu/iommufd/selftest.c              | 26 +++++++++++++++----
 tools/testing/selftests/iommu/iommufd_utils.h | 22 ++++++++++++++--
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1d96a8f466fd..f2c61a9500e7 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -13,6 +13,7 @@ enum {
 	IOMMU_TEST_OP_MD_CHECK_MAP,
 	IOMMU_TEST_OP_MD_CHECK_REFS,
 	IOMMU_TEST_OP_CREATE_ACCESS,
+	IOMMU_TEST_OP_ACCESS_SET_IOAS,
 	IOMMU_TEST_OP_DESTROY_ACCESS_PAGES,
 	IOMMU_TEST_OP_ACCESS_PAGES,
 	IOMMU_TEST_OP_ACCESS_RW,
@@ -66,6 +67,9 @@ struct iommu_test_cmd {
 			__u32 out_access_fd;
 			__u32 flags;
 		} create_access;
+		struct {
+			__u32 ioas_id;
+		} access_set_ioas;
 		struct {
 			__u32 access_pages_id;
 		} destroy_access_pages;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index db4011bdc8a9..b94870f93138 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -549,7 +549,7 @@ static struct selftest_access *iommufd_test_alloc_access(void)
 }
 
 static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
-				      unsigned int ioas_id, unsigned int flags)
+				      unsigned int flags)
 {
 	struct iommu_test_cmd *cmd = ucmd->cmd;
 	struct selftest_access *staccess;
@@ -580,9 +580,6 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 		rc = PTR_ERR(access);
 		goto out_put_fdno;
 	}
-	rc = iommufd_access_set_ioas(access, ioas_id);
-	if (rc)
-		goto out_destroy;
 	cmd->create_access.out_access_fd = fdno;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
@@ -601,6 +598,22 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
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
@@ -810,8 +823,11 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index 0d1f46369c2a..67805afc620f 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -66,13 +66,31 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
 						   device_id, hwpt_id))
 
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
@@ -81,7 +99,7 @@ static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 	if (ret)
 		return ret;
 	*access_id = cmd.create_access.out_access_fd;
-	return 0;
+	return _test_cmd_access_set_ioas(fd, *access_id, ioas_id);
 }
 #define test_cmd_create_access(ioas_id, access_id, flags)                  \
 	ASSERT_EQ(0, _test_cmd_create_access(self->fd, ioas_id, access_id, \
-- 
2.39.1

