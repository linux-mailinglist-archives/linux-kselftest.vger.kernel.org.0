Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1776642F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjG1Ge0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjG1GeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6A03A89;
        Thu, 27 Jul 2023 23:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUE4Zoo20dzakAlaqTb/VYeUWDV3FpSN6WLvz44BBA1UqmCFITo6HFLt4ppLKI5geoQs5R6ltwRDLl/6HoM5el3LjZjdO5clIm2cZQM4GhbuERNftV3HECf1jaDQ9+X5tbvvsRkqhW+VohlJ0uKkEUIXAqrObFx4y6RJhyZIXWCfqX7uGLqAi0GfsP/mUXyISBswwud9BS0MPQcQUd8Bc6znKI5ImQXGfeO+glPa53vRz/Eryv7DpnuA1IptgLNIj5r/C1J7acawrQK/1FYiTUspUOPpYT5rYcb9gRauYO8XhzmHxX/5oNXG0jFDEaY9yUQ1uft9m7cF6nD2YyDchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iirMKJG1l4d932PYYOqkXDT5WydmhkNOrAq8wo1jKiw=;
 b=fzLy7UV/a9cQbBWZrzkL9Z1U5LIsCZJ0rPqP4MC+N6J90POmkOIH/f2MVmI0z8tWfTLXavda9ZQeifzG1JehjvWuq1+DDepx1rLE3clPoi6KXytzGYBZlH0m1+1YLzPJfXvL69vtTglNAQxY4WM/hW+pVO1I1mYCOC+oKVOMJZM39HrefBtS698vwhboAY82X0D8Ig4dK71wjva8OeGQrsHNRym9G7rw4rnudjWGchQ6P0dMiyKrNIlPETm02pfw3cNeuCbj3ANZpaVSymOnkgy2a7WBlV25xO3LslB85v7lE74EB0v+x0BGfHlSnXvhU8BG7NfO1XwjBL8wrzHvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iirMKJG1l4d932PYYOqkXDT5WydmhkNOrAq8wo1jKiw=;
 b=pOEYukyASmPNx929aZl3DCKHo8NEMpkWJxfRsdvE2VgfooPe+4A7U55i27xbMAdiSUfR2d3l4wc2KiVGAf+fAKZ1cBLr/J5pAsE4i23rven83lQxUhP0K0wp5do1zRfZWY8zDYLI4BjdNq7sPXnXFbtyn7MQvaisf1dpQcY++B5JfmaHQyYTstvFJL8ZL6Pqu6aFzDZhOIaY9JA7yGfIpb1aTC60+Yxe1zsTVbNh9+K9AoFmW6yFpE6RI9Xoy+aNkKbuQ9Tte673ed3Rxy/aqZyNTERK/Wd1X17xJCfPV8bZIZD0X6f2qEG+JPx0gVAao5vu9MAriLozh7pY8hqHww==
Received: from DM6PR04CA0013.namprd04.prod.outlook.com (2603:10b6:5:334::18)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:34:12 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c5) by DM6PR04CA0013.outlook.office365.com
 (2603:10b6:5:334::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.34 via Frontend Transport; Fri, 28 Jul 2023 06:34:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 23:33:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 23:33:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 23:33:57 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v11 6/7] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
Date:   Thu, 27 Jul 2023 23:33:28 -0700
Message-ID: <a4897f93d41c34b972213243b8dbf4c3832842e4.1690523699.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690523699.git.nicolinc@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 1430facb-d187-4dc8-83f9-08db8f34a802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxvV3kXV1gSjPO69cT9Mhi3EVSJqdCAmpyfq+kIKlSDLAlmwZbsQL+5TKIYp3wFbRCy58FRH9ICsWm99ZZgYzglnji+VMBMGweNRP4YLz/mvPtpaLsU3C8T9Uu/zxA25jEO2WkkgCWGYXF+WBrUNSbZ+LhFVCQ58RceggXP41LRwRZT2tlWfdRiV141DOqKX66BRP+rGJGiXnasBriPNOutASpO5QwTwrzfXQh6Cpd92i5fZHmRlpDoO1ha6N+eJW3cHjbYyp6TAf3FWCN9T29uM9qDZ4M+jdrms4tPBhPHGgFYi8nzB8BqxP8ye8M9wlEK/tVRUPspvidBMP4t9bcZuOMl1NSVpSi2PBfrLwBOBv6qUZe4aFV+MchW0/yA5s+gVfo3NEfNrQszSTmgTAmkjrP37snyMoxq7QxZh47QB8gaS1UNDEzf8zvz7kX1EX3bJuAbRlXOlDhap0KTEg4xMba7bTlbon3d14HTRCmHNkLNyeCyb4h+ljqmCqQFw+ZnlpQwU/zLtrZcE2R/cpVOXhG8b7Upn/eTkN/oL4zF7RWUOSl+5OyMXYODhKogODGRtgrbKFRCIQeQN6vIBrOcPuG4oCBBajLTrXT5ObaBnwjd8xu7SY+GQLZEN0NFNNm5vO7+KMPZbzR86VriW4rCM3lZai3keGLDU3xMoR/p4CxchKH+udvsKBqf+WkVX0a+Q+W2WEv6OqAkqkm2lnAlMXiTPciKL/5BHxhgDDvA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(54906003)(6666004)(110136005)(7696005)(478600001)(186003)(2616005)(47076005)(336012)(426003)(70206006)(26005)(82740400003)(2906002)(70586007)(316002)(41300700001)(5660300002)(356005)(8676002)(4326008)(7416002)(8936002)(7636003)(40460700003)(86362001)(36756003)(40480700001)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:34:12.1459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1430facb-d187-4dc8-83f9-08db8f34a802
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

