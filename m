Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2B68E2C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBGVUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBGVUg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:36 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8837B4A;
        Tue,  7 Feb 2023 13:20:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLyKk6ScAjqtDzScsdblo+ZIExQaLUvx+Dh2ysu2EjrpOXcgEEEWqpRrjg13j/Hx5dlU3IWpoFpdIiJRcwb/4fZSZ5voMnxhO1QhY5QRaNG71h7pbGv7zB/mggo1Xe97zcgESbjmA4TAbgUWEk5p7OcsEoJyFWv7y4C20hkp6loQZBdafSVq98RsAC1qdR2LsxTuvfyJplUkl02duvJU8xHIPEiNN1H10hxUQSGgTxSfgm6oofjTHW+fJqAcC2VMhl5FHeJyP0OZZQ49sPy5Zp2TuQvXJyW7X94n50VoSCN+q8QwSCQ6+Ey5T4ioifDXqbbmIjDR6CXvNuVyhJJ2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trqPQuSL508hbjLZkTsHtmMpbS6mglzaGKaP6bKXVsE=;
 b=HnbG1gjNB0p6NvXNJjhs8NNdEeAcP+xE2+QlEAaKIXqWSVv6qIUrbcG6sDuFAT2QbSRws2gIssADr3Y9ifFdI/EphHg0HZuOb0oWHJC0E68XKeJnZTP6oQYbaO4fCcelzVJq0ZmHakDooWDLHT8rhd4M2E1y7W5h9Q5h29TIKy/oQd8kzQ67vK/Fxm0MoPCTj073ACDcxP4DBaIiwh5kRdi3HG/L0verSZtOQaqJvaqZltKtadazhh0tKpGilrM4H/jQQHtinUR69GbvtTqHAms5l/3ExBbKSSIDFaKZf0bWfu8RO45wQ48XIj+rSTX3KaZbRVTmArrxgQZ0/dke9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trqPQuSL508hbjLZkTsHtmMpbS6mglzaGKaP6bKXVsE=;
 b=brWgHRewcG3Du/d4Ww+JjglO+6ZZk2q9HKp+bKIcK9wBtojHJC46EbtZ/4fEkjLYZvszmxkemJCZiJiX20afkiJEbHtsRIJ2HeCy+AI353nAK0TuGsHPyhSInz3E3S/lkz0qcKWPaU3lqE9i7bNFLALcj02rDSbGOY5FUeJtWVJKPmxAESmNGy2amKxPIJOmrzmgFNCFq3tmYTumqmSlUwrvRPyD4WXR3zNgDvss57fZWWkI1KiWhgO/8MDZAXTOHSM3uKlP2wGkXVNMhV/Ab9BJMBbEIUNSduvk6/j/CJLpLKYRCDhwvK/AeaOaxoIoBgx/lg+OK6xtf9UTImyUzQ==
Received: from BN9PR03CA0482.namprd03.prod.outlook.com (2603:10b6:408:130::7)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 21:20:33 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::e) by BN9PR03CA0482.outlook.office365.com
 (2603:10b6:408:130::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 21:20:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:23 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:22 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 04/10] iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
Date:   Tue, 7 Feb 2023 13:17:56 -0800
Message-ID: <c1f31b7fa35a33af41478e39acd9dad81ef7aa3a.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 010e7beb-c4c1-4d62-6dd1-08db095125a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JwZpjTlxBIxU2sAHcAwYIIHz9wrrGiBo1EC8j0/EUjCR+CZ3ONY4Uu9LGWq07cIYnzzJAak7/9od1UAKnayGnOsFuMoe4t4TodmcPdBgBDs7tarAidu0DeLaSygGKPBMMylsRkKuG+cXrn63s5j8h2UG6V1vwESEO1OT0cALVUdl3uvTQ9wdhoakH9z7LKSxTas1pZ+FbmuYljKZX9jv8me60RKYcQlloijEO98b9pTi0HPlIybubntvF8Zdh42Etsc52oNtXMQjHtjBG92pK6sWfB7sp8Ya3o2xhUJNaajfZ5wYZVJQWmPZLuUFUHJ+4lnyvdpzkD/RaWIGOPxgpQJSKw/0K+NacNQ51lzTetgG+3pIAmyxEh1oxoaqvW43njP20WA0PI46KFYm59Htnmle7+4ZJMV006jJ05rxFCwJ3EaTjqclC/nNgASCTNdzD6LRLMMP6CHfxrK7TZOAK2uRc+qZInh6aLwdcCQsilkBoSQGXRCfPWZ+ymkaiPjDjpsvqikNJJD0Qb7YxKAd2TwVWWa1h49vji3R2DPB/DSsgcL7FVo0c8gcT3lqjHkeJGJuv2tfkpI9PGiu4V1y9NEgndAYvmL2hyjGQ9z1TTaL4By/MPRB9Tm60JwKU1mVYiss74DMcczZr0SWIPNGW2Fyz+lLrIRakVyyQKf6+jc1sYV4E6RCLWtudpLqWdKyotCKZ7PINcME1pJIGaekQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(6666004)(8936002)(41300700001)(8676002)(4326008)(5660300002)(7416002)(2906002)(70586007)(70206006)(186003)(316002)(83380400001)(54906003)(110136005)(478600001)(47076005)(7696005)(40460700003)(26005)(2616005)(426003)(36860700001)(82310400005)(336012)(40480700001)(82740400003)(7636003)(36756003)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:32.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010e7beb-c4c1-4d62-6dd1-08db095125a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
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

