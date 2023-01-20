Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE77674E4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 08:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjATHm2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 02:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjATHm2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 02:42:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157480B8E;
        Thu, 19 Jan 2023 23:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoCIkcMiC9iakOD9LyAH7ongxdHe7Y/0LvB4x7sfpHxx8grQImyj1YjXy6yIeXltUDJY/YJSK2X9cjDFbWy4EUL7609nUH+so7YcPX2ydtZtvNs0PZz7qekEtDKZ0GSzjz8IMvwnpwjuQkbUuadLULI30ca0XLTLwfnjI2SAkoxRzKaEeYTjIfpAzdejWgEFL+BLaTRtrJUsaB9cbRnDUXQQCpOvkRtGHue8C/F1qWGu3BpCQgiVH9uDBTHcIb7HQi6fafqmv/gTtzY2fVuIQNGYjVu0f1cO9BT/A/zq9G6rXXhWx+G9WFdCyXXzIotxAOy7WRv4qpDVX4PymLeNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9cyfqyI3yQPjcquVeFXfhWyI2YC9MgYuy3ohsTXTYI=;
 b=lD+Z6DoCQjb3q3BfjNTrb7Zn6m1iqLefq1XLbu6sy5+9y3xgClX4PV9PgYohh2qrXdaWAxyaZg5s22iqk2nri3MtaG3MKEgtD55hgmpQxD+m0nUHmF7u8Bs+dIYHyvIIQVMWFR39jaS56kv+o027I0W5FnU+dPajVNMM356laT8iy2vPKNXWoZGqL+2mQDqIkH0VFQokZ2U4jj4iBrU+X/ohFDg4sR1Eo5wRQ0LZPE3uHZjcCLCm8O4h8VWF7xZOMbWBKX8xENigV4pxNB9TAlkGyQIgCxVb8ylqQ8gpEiJyPsCuqIWb9grXsh7YDoq7dY0/IzUyFhwwNCB8EFjJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9cyfqyI3yQPjcquVeFXfhWyI2YC9MgYuy3ohsTXTYI=;
 b=VG2lkgW20awY4tjcVUMf5Mnk/MSonAp95zKMwwrWAoVwoCQksKvyXEOcok8+eZOeGIpeUj0qTp9Lf2lYh85LNo3LmbH7L6ux5S4GNX7Z4rD/vkaTjMYG3HLyRcUBBy4wFCvBTI/FfIlT4Bthuddq4naaZ4UY82aICChC0kQ+ojNy3/QSDQT1QGqVUs7xh+kZyQXCHLUG/DGZNx5cUnEzCqj1h9iRO5xrT9THvLZc3rTJZC6x2lCRc51urHedrfAvFt+Kc44PRpr4NySO5NO83xB9zXRBTlJ5uLN8krAYucsTHCTs41YLJmXf2n800gh/oIGrcFolEJpVOe2pv+B3IA==
Received: from DM6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:100::49)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 07:42:23 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::1f) by DM6PR03CA0072.outlook.office365.com
 (2603:10b6:5:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 07:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 07:42:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 23:42:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 23:42:10 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 19 Jan 2023 23:42:09 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <shuah@kernel.org>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests: iommu: Fix test_cmd_destroy_access() call in user_copy
Date:   Thu, 19 Jan 2023 23:42:04 -0800
Message-ID: <20230120074204.1368-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a79776-a3d9-41d7-8a33-08dafab9ddff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7x2c5/T8TZicKSYCuXm/vODdyFb7kw8pESK3cMITF9fntmeyVvZ4CNeXxELWipTTNhbST0TDpfJ1wle3fCgNguJCiTJOPrzXPI0NcEU2pkLwbDG7VK8n+nPzcDDM3nrdh2BtIoeex2LdiCZ+8O55U5/TT71PCyusF2G5Lg2bOXepM/Ms0v+pVRThnIGPkdTaeQwMbJJap2DMgVYp5YqA7XGFFG72brgH09qx1Chcq5h6+yJViqXpU/44ODqgA9OSHxg18f793XFjHFSjqhB6JAIETXcnpASAuybkAv9/cQFAmlkSFo8tCPs0QSwrjUHDa0js8lDewZ7Vhhhd1wHgL+JXbYzxNd9sMOtATAhjGPYXcnFrj42Xink1ml84BuMn9UgxhqSyk5fC69cccn6bEx2lAOQme4Kxa3wDGFan72xyr2Zr/EHXhOGwIMo3flaUau/HCsgbgeqD+xfT+KYVveGj7IC+AciVtCEzs5COqyuwS7q3E+Q4L7nZlt00J8JwRZeAMsuNTl8JK/64Rj1XDx+S4Jlg9imJyN6XE9AtyQa6ZcL3LI7Rf+eIoYRKYQ/eJ9QNtBw70rl0qI6xq4o/sdg6Pw3+1n8t2jad8TZQIiavBDleA3FGeAF5EXiehSf66iCw/MlJQgQpwmqvoISpRq7EvUJzlG8/YZO/qkK+gShhWAzczvrWm7xvK85U6Le0hlZzHUldvST2sdMMqqq5g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(7636003)(6636002)(316002)(478600001)(37006003)(1076003)(41300700001)(82740400003)(82310400005)(54906003)(40480700001)(83380400001)(7696005)(36756003)(4744005)(40460700003)(8936002)(86362001)(6862004)(336012)(5660300002)(186003)(36860700001)(356005)(26005)(6666004)(47076005)(2616005)(2906002)(4326008)(8676002)(426003)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 07:42:22.5189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a79776-a3d9-41d7-8a33-08dafab9ddff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test_cmd_destroy_access() should end with a semicolon, so add one.
There is a test_ioctl_destroy(ioas_id) following already, so drop one.

Fixes: 57f0988706fe ("iommufd: Add a selftest")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 8aa8a346cf22..fa08209268c4 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1259,7 +1259,7 @@ TEST_F(iommufd_mock_domain, user_copy)
 
 	test_cmd_destroy_access_pages(
 		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
-	test_cmd_destroy_access(access_cmd.id) test_ioctl_destroy(ioas_id);
+	test_cmd_destroy_access(access_cmd.id);
 
 	test_ioctl_destroy(ioas_id);
 }
-- 
2.39.0

