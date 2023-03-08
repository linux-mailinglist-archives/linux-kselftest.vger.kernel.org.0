Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BDD6B0B0B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 15:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjCHO0r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 09:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjCHO0o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 09:26:44 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AFFC709C;
        Wed,  8 Mar 2023 06:26:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3AyGtZn7S5r7/Kps6HY6f48rGQUMqn2F4N2kqWTmlcWFVMCJd9+8tGtEycxxd+PWqcUKbBt9+qSGV/WvL6zZI6tAk3o3w7w8wPRh0PpjVdY9O8bF72I5yYumbe8l2PjLTd/B+FmEHdiYk5bD05yLylXT4ARyg8M5sY57SfBJmjy0u97/sMPLhO+/OcYvvdCkaNhWUTtD7ATQMm2mhDZB63b1vQhVfUX71yBmQrJVx/nMawZoT6zqHQB+1wMq5w0u3wbkUzbP+LoV1G4ZTDzd/K+wvY/YgpPZdIGNyw28CJTWEWD+9qPofaAbByKgstXz8G4QeAI5+qZwRMr1jxwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBpMSN1XdXWnRLypdOscjNZjW9V51VxbSHPDW1MqkvM=;
 b=WhLlBVPfAPgQJRC36wGXkYWaTId2EIjlpUVPuO42hoAMlP4HwePFdui6ZNcNDEQYw1PrG1BGIMEg5xtYOdBKLx/a86SzUNayZN6u6Mp5mfQmlUarXSypNLPCsq/t2tMK2KGelLulV6B+xfxUKbn6ZEEjJq8q0AZ+ByuYKhqBCf7E667QGg2JXV322xcfKgXr71fh8HELwncnFBATDpiVtiPgPJPMWmjXxwIcjkGDdmAL2PvJSyYoNo0PKUghkD61OXNQdYP1vrrWnP5DGl1GOzyz8jehtk5AdQol4+fOAlFgs6cnl6ebUcKdY9jNWZYEIPNQiqBfLun+Ne3eFRNAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBpMSN1XdXWnRLypdOscjNZjW9V51VxbSHPDW1MqkvM=;
 b=P8+DDQSi+cp9ccnUSBtU4oAuOQQmsGte2tQgCUQZ/aXXoHf1ozS7sqHNyTsZsytkxY1UagwcCCNM7bwyTx5cQbX/cr28Opdt7yibhYX3DDa3EVXuTTtna28ECDQP3mWDqJ1X5Qa3pypeSBojyvA1cuumlLyyKU9uxhYOKLiugOfdvlycWU5/0W/D2VN7CFono5xGKrBbHb4gBk7HQX9LiOMAhTdTaFur7BXZmc19X8SA7LhP3oMHbx1zOXg/ogb9MYeG4kdJWgVEuPlggQuSDELCGSdDD2WJz6f9kmajapsm5uC+eAub/zyYz9FnrFLZZeRvMsj5Q3pWynmjOOjITQ==
Received: from BN9PR03CA0390.namprd03.prod.outlook.com (2603:10b6:408:f7::35)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 14:26:36 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::4e) by BN9PR03CA0390.outlook.office365.com
 (2603:10b6:408:f7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18 via Frontend
 Transport; Wed, 8 Mar 2023 14:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Wed, 8 Mar 2023 14:26:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 06:26:23 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 8 Mar 2023 06:26:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 8 Mar 2023 06:26:22 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v4 4/5] iommufd/selftest: Add coverage for access->ioas replacement
Date:   Wed, 8 Mar 2023 06:26:01 -0800
Message-ID: <4d2431e62910002feadd9bfaba0f397629aa4cc7.1678284812.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678284812.git.nicolinc@nvidia.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcfcd80-775e-43fb-9ade-08db1fe11f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buSauBUjbUkDm0l0ENncMTfSuMBsdye7n/kyFU9Bf0GGDWeQZvTKlSUtsjR6TjJ40wKi31+fxFhW3/bzIe5p2T3Nz6tXXTh5WDuUeb6lzlGWvoEAdtySKNVr8zzbaB7xMHqIDy6NESWtlOGPRncCzAU63ST4wZqwAGaULltTff5sZuMWp69fSs9ktXOrYZTRnlAyTa/4vRJlFUQLgqXXaGXGoilGlD8ZweXcwx+B0YmE8ryKsNALyezn72T+GdGJ67p4pCbTPazRb3nPSxSfueQ3viJm13tsw+ZZQeneC5LhH9gAGu7s1Qd1x/bJmzi3C7Ar2xNbyvyf6Z0XrIExDo+o6yI3VSTnm4vTVkTWV3mvk2JkxXkGANaWUoG23xZaiSURAu1mw2NxQFmFp6J0E33o1EHX3+xn9rer4EpbYyvTH2/k+pLX1OWF4FVJ+hUFm4KHIC65/WG0P4dBHjYXRkubpLDUQo6L8FlSwD9mqH6x1C4j/QLTs7Pc0EpZozySnXi9BqS4LDdjE9G6loRT0wPzSc8aJ9gJE9vcPNpBLXfTPazZ29mb61lFTeWUDETbY4ditIdPgeEil+wnk1uGS1XqijQEovmZ8OGRWfB/mqyIPsOIgDUPtO/zA2xtOROvj1w0oRvWHI5YidNzszC1JS/OUnM7v38IlmywDfSkQ1S/cx08JRwWPRmlXpytFLPzNtIpaw0I/RdOlbY1mbaIbQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(82310400005)(336012)(2616005)(47076005)(426003)(2906002)(5660300002)(4326008)(70586007)(7416002)(36860700001)(26005)(186003)(70206006)(8676002)(41300700001)(36756003)(7636003)(6666004)(82740400003)(40460700003)(8936002)(86362001)(478600001)(356005)(40480700001)(7696005)(54906003)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:26:35.9616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcfcd80-775e-43fb-9ade-08db1fe11f9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add replace coverage as a part of user_copy test case. It basically
repeats the copy test after replacing the old ioas with a new one.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 29 +++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index c07252dbf62d..5c33b6b52c65 100644
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

