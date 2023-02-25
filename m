Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13D6A26B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBYBw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBYBwv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:52:51 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276DB40D9;
        Fri, 24 Feb 2023 17:52:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+pW39Pl26zuwL9eZBShNo9yBOEuWr3t7iik+uBEvN/MUUFbx0A+Va5/74TzCVVcK6RIEdIEXLaYKJMcgPFp38YyxhFYNLDnSchcHCFBSlF1t5iPmX7rwPmsHAKVHCoR3YWVc4DWYiQIAdNCMe+J3EEQQjFPVFaHvm3jav2gPkMrbSa5ZPTd51pu5g2As9ByMW9mLUml73ooxdTzKp5twmvxeTbv+Dj6iBckC9P9+NiSkRbUb+I+2ybcGN1FVl40CSKv+zOhZ2CwkUNQVkgeDs0DheKOBX2WWphTuS7tTjbgHVIX8a9DH9bxTaWlbV4OEtAUQ+mhEsttDOUMWA5ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5s1jf6ea1wA0fPeiaXnc1s7nqCL56nNg7YPhq8BV1+Y=;
 b=N8kboPGQxgRG/mxcUClDKVWsv1+nmh7Y32Ysma3SWDtZtKLUzG/3XZXgoeHaPl2vbLbMxyuwbqaFCEpnUC7YpTzIZUk78k4kl6PqxQ5M00SR9c4DYXjs8rvyioOlx6IktCKV49SykayddNyVZL3U/C9ldJDdZsSWEjO+lmB/VEtFGKtEWyYTgwYCxbnf8bON4vLorGtao9GaavjlXJ3HZlG+UYcfVQoIEajUfyB5MJr7eoagKwPHsOtGgV2fYyJI5KjzR43bbBmgsRh3HxyzuKnfl3asMHybxmWwMG6+/myNv7aiVEy5s6GSHDNANx0WpkXkMaeiFbpfaTVHPSlF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s1jf6ea1wA0fPeiaXnc1s7nqCL56nNg7YPhq8BV1+Y=;
 b=WMSyESYd88IvJbTpds5j+kZyYik9/lTejmoXyJ+juEwFcM29uz0OU05YFYcOFKIzOA9NL68K9Hl+G8Uuq3GY7hsKOtUif/5GDgVoJrcHWRgmW02VJZtICPReU6DWdivqCPBUrWdBkxqhOCNrQajiKBB/t7Hze+D8vG0KkuJXJdC1EaL9x8VlYV0tk/y5255NrBxaiCQoj5QlxdCeFfkKNF4AHTaunK0r7v6ARskzPWbNBv/N+ThUBbexGMZHOX1YApo+tTQB8g8M9wJFXTwSy9cx6/SGF7Tnr7Nlr7AOfTOQE/Tpcm5kszN1nS8CEQkOoKnpIIJioPcZnnICFwC37g==
Received: from MW4PR03CA0219.namprd03.prod.outlook.com (2603:10b6:303:b9::14)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Sat, 25 Feb
 2023 01:52:47 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::91) by MW4PR03CA0219.outlook.office365.com
 (2603:10b6:303:b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25 via Frontend
 Transport; Sat, 25 Feb 2023 01:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.11 via Frontend Transport; Sat, 25 Feb 2023 01:52:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 17:52:32 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v3 5/5] iommufd/selftest: Add coverage for access->ioas replacement
Date:   Fri, 24 Feb 2023 17:51:42 -0800
Message-ID: <4d371c99faf55baa771a0cb00f90338145af0c8d.1677288789.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677288789.git.nicolinc@nvidia.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a21842-4bfb-4fa2-e9b0-08db16d2fed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RE70/s2C40QRw1g3URwZ5Dfe7+xedMJnkBeztt/5kykBGtO4IBrD8F556b3v8937+xfxQRE4Pp7qR3LfcBggPctAo6G/esQ6JF8QK+P3GxIRzXLLiaBdCP6q67qkZZjCoVsHqd848gL2x9rojmKE6/w4+L6J8HUI5Y/M3jM/u7rMM0uGEtz7gYCVQixYFYWl91cuK33Cw6vm/34oBucVvJ3p4LWL33rE7Aj6PDZBtCLbSciyjTmwWAglMMQq930t4hn6nD2yF7QpFedXNZQZrOH0jDUbPrIzqN+VB57IsfWJmsOPm6EQlLcM8Zje3JOxfnHS90dCZPQWU9q6ot9wYoVbAuU5+6AFkpUn1JrNwk7ng17pPgoaPyCSoHjic+zSsiL/ohWMLJX4KBJzB7xtTAmsVKf++R6l2sFo+4FhmOof5oyuyedMbaIDX1jt48CHoNBi/T3u9bUm5UETJOCgZcKNKQwPt2dZrcvY5nO1bcoM+KtgGDfqxzimEPflfopmSkCvePExaxD+28LU5zJBJFAHtDn1fFxZTPIfZEnil5Oyb7p0McImOptRYx8UvEsJ9/b5XSy2W1NnmzNLjkjA9F2XE0igbqz9D/lbJAzbYedhUHLwMMevAyXIt7/Zs7LLp8ZrhKsarVoeAsZ3qvFZutZREtkn5mgp5EQon8syF04XXE1q98uxnRalKey99X4iNFisAJUmtxG3fqSEfHUUIVeshR+ORVUZIEqri0GIo64=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(82740400003)(47076005)(2616005)(426003)(7636003)(336012)(34020700004)(82310400005)(36860700001)(110136005)(7696005)(356005)(54906003)(316002)(40460700003)(2906002)(36756003)(6666004)(26005)(186003)(478600001)(40480700001)(86362001)(7416002)(41300700001)(8936002)(5660300002)(4326008)(8676002)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 01:52:47.5607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a21842-4bfb-4fa2-e9b0-08db16d2fed1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add replace coverage as a part of user_copy test case. It basically
repeats the copy test after replacing the old ioas with a new one.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 29 +++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 65f1847de5a5..76f2ac73bb45 100644
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
+	test_cmd_access_set_ioas(access_cmd.id, new_ioas_id);
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
-- 
2.39.2

