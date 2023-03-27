Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEB6CACA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjC0SFg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjC0SFd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:05:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8635A1;
        Mon, 27 Mar 2023 11:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbE8POiWwF7a/l9myPHtLZvSktOya1ZIMnkiEUycM5mjOGuG3mRXx90qkQtwohiEbc2DuRDEhwLpLtU+MeUmaUqqcvIWpbMBNPEFla1hp+drR2UrTxjxQDAMtvB4QlrZQhyInIKDEWzQGaGhTa7K+os2uOXoiNdbZpriPCl6e0JiWi24ap8lV+NRxh86X+JwcQ5fBUsVmcNSTdOB1lHWAO4xs33xNbu5C5rWZCGE13TqsREi6v5D7Su7nTzrJ5W6XsffMJyL2+sRwOiCcmPUqKcjs5MEA3rSxbTqDOIITOwzZmUwm1H/DQBlG/N7ygHRhJUjukabrw0hg83U1cg9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSPe+tjLHzxQWVI7DcLOpIVRWSdFYoe1dYjXnksZ574=;
 b=HcWPN48UsYj/Ai06OsO7jbTzBNVzZq6EO480b3olTbtt7OMme7WtqmBdEKxY6CcRw+So7d/nXshisu2pEUpnQd1IHF6Cvil7C+lIPOWC+nwXLc1QXGPeKultVHdqe7miVkZA71F0ruRixagmFh9qZvBSuC2v87wAJpFeAB8JPoqPBE3Es/DiHA9KSEXPInkV5GVXgcsCXpbb/4FbsIUBIs249CXWH6OuR/7JRKrGkHZ87Q2XSVWekO+34TkVD4aXIybbQY7HUEnfK9ndbaHvd2QrdtBVWu5AIaOl1HCBtNM6CeVv5XEdKhVaQ0qVF4shZNPVoSj9q3qTFbjOZuk5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSPe+tjLHzxQWVI7DcLOpIVRWSdFYoe1dYjXnksZ574=;
 b=nFZsTSfZJ3Syb5AUsjZU9WMU106oQsC/tU3e89rcfci7vqMIPWJ/Xd8uL+TleTNjaO066jp+/6sl2oLDEf54tT5GF/gq9nWk6WYktillVMVlxOa+C07lwV480QB3pKOMxEoWA+/Wk8qtIpQixn3C3OxNjJGaW/VkmC7wZra0H4JPK3TaiQwyrPsmGCexTL8nudZcWv+Qxcyw16xcCIkzzgDdnNmNMyuZMDtd3bYZmBd+ZqviVyqlWLiSXHcfNaaV5lHK66km4JkfOm7f5t74mrI/dQSu5/yZ64xq+bJMuf5ukc1VteMENWziddx6CaHCyqrc4a/AVQZgJGai7rV84Q==
Received: from DM6PR02CA0119.namprd02.prod.outlook.com (2603:10b6:5:1b4::21)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 18:05:29 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::59) by DM6PR02CA0119.outlook.office365.com
 (2603:10b6:5:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 18:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.9 via Frontend Transport; Mon, 27 Mar 2023 18:05:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 11:05:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 11:05:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 27 Mar 2023 11:05:15 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v6 3/4] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
Date:   Mon, 27 Mar 2023 11:05:04 -0700
Message-ID: <cf9985939ced0f15c7c6f1cdddbbedefc6c97ff0.1679939952.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1679939952.git.nicolinc@nvidia.com>
References: <cover.1679939952.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e36edc7-7911-48ab-3c47-08db2eedd938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aADICFbbBGiZzndSsHIWlnsJh4hRrOsyXdyGksCczgxmkGHbICHg1t3Gd8yqgFmBZ0lbwnYrC6Srsl2ucDt7tuJkLeVGZ+x9+8TvGx43FFcZ0JijtxjQgRVcF0QiYIGxgToGRtQwUHLtssCVbqpZwVJaEOYJL5g0BjFleK5zq7ZGt1qXPjFOSaf1zUIdi3w+M3XDwSSAhQ8HDQjAxWLJ253R12PACfQEw9ME3geppzczzYqiCulnUvc1T0MoFUZZgmGrkZ3pCJIMd4sUxU3kVg5AXs2jBfO27+deH2lBXbdhoJu0IKBsTgBlyyA0rD5lHUAoQX848Fs8kEx95g/ZfKG3BVQiS2dXJZ866iNLNJI2hqyezK9odw+rhn7J/pX8LXEiBSe00AbaNyCpimiaro5snWg1QDBaOjT3U/Mc94uXXiwbX82ny9k87YnnblkJFvzTUyXxNvtjmE47dOf4NQpCBtQHNn2LeI9+8OFuSRscmAi7Rsf01Z3l2MJn8k3ZdNr5J6g7EQD5Dq1b/JPf5tJP/EGnDCdh+keCF9dqDVBrt5CNb+DPcsVQH0OfUFDc++ZUW6DQNXaW50KqhsKtQru25gkoO4mVDf7ZBe66+mejFGcKil8o671jsyKAK/rCaJ0bXrlsEOY55nQxyX/PSD+Pf/Wm/AQclDlCU1C6c7gsycI6LpjfnrVH9SMRr/p/B3w06VjSvD7TEMgpNSNJsugMg+Vy5fa31nuLR9eadyKa6i5P9vWcUqneqISKB8315KJitLG6pqX6sHXNMmbOMg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(34020700004)(478600001)(316002)(54906003)(110136005)(7636003)(82310400005)(8936002)(5660300002)(86362001)(36756003)(2906002)(7416002)(356005)(70206006)(70586007)(8676002)(40480700001)(41300700001)(4326008)(336012)(186003)(2616005)(426003)(26005)(83380400001)(82740400003)(6666004)(7696005)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:05:28.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e36edc7-7911-48ab-3c47-08db2eedd938
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
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
index 2deda489a934..7714d8f53603 100644
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

