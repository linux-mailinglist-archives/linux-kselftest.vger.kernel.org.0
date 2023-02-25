Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CBB6A26AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBYBwu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBYBwq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:52:46 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0A69AFD;
        Fri, 24 Feb 2023 17:52:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPpMC30LdPAxQCHfRB/S6oe9x5SYOIc+fCTCiWTZAVecogSaSUCBKxaVPXh0B5uxAmCnb+D2sM++d0WHPrr8cTa3+j29p5iXRwNJ8TFU+AehthfldDKy9j/0RWqSzhsF7BwGQAxFZ0dY7DX4/UbVDRExhYFh8gemdafve8Bg0Ud5km74YrtN1ecgaYEzZtGj5r3xRYGlkuNtXIEiCjIpdC90nCN1bdvRWGMOBxysMpVgHGjuAHpTb5jifr3T3IrDXzLim0V+/sPssXKNZauVYut/7Atgu+vbRiVbTr6keKc1nuCWx9n4eq+5DCBd8NX7LfF6PeQ+6j/h6gyNNNx81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56u10PqBJ++w6Z58ni2qLDMKss2u5jHMFcdwHToOJQU=;
 b=kACFHcHa4tw1m+WVTIeKNTV4e1ykRpM9+LrsWbd/Bx/JmjPDnX3FaJy2jXhHToiCfmghMW0gQ971ndaHCwxMcGWTfU820RgE+nS2hUbDHZi6GmjncAmCV0RVyR6MMQlA7si8Rt1FiEQoDllWwcfOiC4f6E9eSLRmM4a1QXrmHOGiPPJa7BJqqHEsCoRd/8AMEsNwG3QMug7eLcfJ5h+I/wBx3ZVeM6CaC5EHR4Q4MnlduVqcTi07ElLxUtLX772tN0BHOsb2hO92vRroLqtfGd5HzV9K7pf+m415r7VC9coAqnY+DV5T5m719H04k9VKlHWbf1VmzN5JJcO5+HQNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56u10PqBJ++w6Z58ni2qLDMKss2u5jHMFcdwHToOJQU=;
 b=ILXMNHRGcu0z6dLwAHexwvCnkKRynBAmRUKnqmaeEx8jH8lO4azIE2cp1FfUJIq912naRpnHMYzzctzGBqckEytCzMYRkF0Bp4gchxsSlnvkaVKNNU++4b1xpWfI5MtyJ8E546Ec5LLammDo3wR32SkzFjGSVYfhToJqtsG7AgR8uC0zQx1WT6e6GIDsS519+uV8wA2oDC6q6TbmDkgOPoYFSndZ67BomamxT35k/m2+W/mxZAThyaH+0x5/eInKYzYF4zGomparyEPlRBbIX5GLrdZLUVW7IXJd12a6yTopBIG+LfcCKcsxLg2Q9JNlYg33KbgA0E84LwdwL27WIQ==
Received: from DS7PR03CA0145.namprd03.prod.outlook.com (2603:10b6:5:3b4::30)
 by DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 01:52:41 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::85) by DS7PR03CA0145.outlook.office365.com
 (2603:10b6:5:3b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Sat, 25 Feb 2023 01:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Sat, 25 Feb 2023 01:52:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:30 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:30 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 17:52:29 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v3 3/5] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
Date:   Fri, 24 Feb 2023 17:51:40 -0800
Message-ID: <b23a6b5d1ed715023259408a7014989533e94691.1677288789.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677288789.git.nicolinc@nvidia.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|DM6PR12MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6a4c23-c22c-4e5a-f6d5-08db16d2fb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: On7nu4PKQFELCz9VCoMCy7FQKkBJG74bv7TkClXFMkqyVUP0JcW6HvBKRAz6wK/+Fi1AiivptXrq3SyzALBupsod6xIuZ0D1z+9HpnCve22ORP39UUFloyhDx3BZVk5w07+n5Ro3WvJl/I6ezDP2KljyDvahCfoVGr/dA5KGOsZmFdZ9KKl5rKOT7ERxoRG+UvIJAAZpp3pKOP+uwyZAjbycJPVJzMcoonRZuLWahAHdGlhj9nxh/Q6cWVQxaI57tpy8HnXiYEsgUraV/IfpNe35irltJ7q4vUtsuLe3UnsJYZeqoeAk21k9/JRjgvrlp6HgL5cnsJzwYk5JWDclYG1tO/GdEGHZTBRxUE7mUGk1VfQiNqE71Kk28p/5FKEqiaSY2lgz5qt2F4pZuPAdjmXcnBttUD73kqWt2uiYd1jdUR1BwuJWHKmUi//fZAHulMJ99EFVIgIJM+wKqtWVhPcXQFn3PIO26yFczvFtQcPVBRiJ42yl60jPI3fHO6TK+dNIVKNDNarSvb0CL6xUuQLiNOTkOm6UXvZY/n7MDn8DzLK6f5cX7jDnO9MV+AeXLE0JloFKv3hazCiL0vEMJOT7n5VDEGewKlKsncvzOuFB1z8fa+rG7MYLahbw1g6gUdwKPhsimnALL0v3U2FXXzyh7HTtgE65sXd9XV4XXe7H9P/UUz1M2mWfQymTZVjZMEOedyDhnOdSV0P3CHeL3/dSF9nT8S/tkEE8XLxP9R4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(86362001)(41300700001)(7416002)(8936002)(5660300002)(2906002)(356005)(7636003)(82740400003)(36860700001)(34020700004)(83380400001)(478600001)(70586007)(110136005)(7696005)(70206006)(186003)(26005)(40480700001)(82310400005)(40460700003)(4326008)(8676002)(54906003)(316002)(336012)(2616005)(6666004)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 01:52:41.2066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6a4c23-c22c-4e5a-f6d5-08db16d2fb05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
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

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 drivers/iommu/iommufd/selftest.c              | 26 +++++++++++++++----
 tools/testing/selftests/iommu/iommufd_utils.h | 22 ++++++++++++++--
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index d35620158c8b..5ff1fe6524e9 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -18,6 +18,7 @@ enum {
 	IOMMU_TEST_OP_ACCESS_RW,
 	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
 	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
+	IOMMU_TEST_OP_ACCESS_SET_IOAS,
 };
 
 enum {
@@ -92,6 +93,9 @@ struct iommu_test_cmd {
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
index dacd1f67957d..80d966b8f689 100644
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
@@ -763,9 +763,6 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 		rc = PTR_ERR(access);
 		goto out_put_fdno;
 	}
-	rc = iommufd_access_set_ioas(access, ioas_id);
-	if (rc)
-		goto out_destroy;
 	cmd->create_access.out_access_fd = fdno;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
@@ -784,6 +781,22 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
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
@@ -997,8 +1010,11 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index bc0ca8973e79..1333dc85fdab 100644
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

