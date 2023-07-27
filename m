Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8386765D34
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjG0UZK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjG0UZJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:25:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD02688;
        Thu, 27 Jul 2023 13:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBqTn31NYP5zyDmVy7sHJxxbxCBcfCiylutNyVGdwHl0ZQTzLNs755P36n+vHF/DsXgEm0QjdPIBHI4qrukC77yAGTd+X6+eQb4u59ip3xUXWYepzyIsnrEkVadpEGsD5o3C+xKDGSNFTTJbGY/xhU0pZEc0JEIp3HyL4/nK6gsZd2TvlNmBWXDC0qkUBJ/tFc5JduWtvKeGU1qdJYM6qihNH//bsRVUZ3I0Fu28JI5HNbzdqlNmkEq/nisJ4ORUL6ShxgoybVGL1G91iZA8M4Q6WIiE371JqgV4Xl3r71gcs4tIMUa00Sgxio4eU0ywwgONV1vB/g+dtB3PI5Q3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUc06e5xx4kTwBKEnoGTOSehjX6v5imRbufbXUgPcoU=;
 b=j+9xxVsWZQ9Og6dfpE1LffT4SNNK2fz+kZV2zqwHUHlD8f3pJw9eSwez5/28h6SfCBsVInxyHmD+j8I1C50AIZR3l6wsbJ699biy0UCzTxlDmf/jAIKvuNIPurFvzMhSEwvuX87yoVM7YiXXEVJqmEBneFGAHtqVVh3+LCx2SWV+2g5Sv6bhGEBbl5r+pqt+sH9MUjMSHqVyXzvlvdaU4yo0KlobVExZeYDAfmUA4hHyLHQRDO4rkeCTjPg1A1g1bI6ZDb7AH+qH9acp1Uxcy9dvTWs3s3DGNSkID7G5K6f+Z9kOVTizTFozD0EtdTzyH1XQjpoHjEyEfxLat2Hwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUc06e5xx4kTwBKEnoGTOSehjX6v5imRbufbXUgPcoU=;
 b=HMAvO2WimyySL6ACQ8QeYZ6YCg9rOXVOyjZcG81hGIuMtxNGraGLwnvlB4YYrJsyerL7JsqVvQH3tONg8ag567oIKMzzNIBG9dU6s+at9kUIMf3Eko9qoIj3MmWeaOxUZP6mcVBAxsMDdOK5XQpzOWmzSLgzI849cBfynfGi00rtXlYSixqnIkDq+3yg/pbpPRg4p5CHgHdW3cTX/IaPJ2xqkiWJWvain1CbtrQJcHjUXV0F0TalUnu2NDhtoNVfhKPciz7Qz4ist6KDogF5wLzSism/pGsqjBNI7j+vmIcysX5qICq90/DQGLQiyjbjRmm+TIvNWdY+99MjGY6Ygg==
Received: from DM6PR02CA0045.namprd02.prod.outlook.com (2603:10b6:5:177::22)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:25:06 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::74) by DM6PR02CA0045.outlook.office365.com
 (2603:10b6:5:177::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 20:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 20:25:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 13:24:49 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 13:24:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 13:24:47 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v10 1/6] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Thu, 27 Jul 2023 13:24:32 -0700
Message-ID: <85d622729d8f2334b35d42f1c568df1ededb9171.1690488745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690488745.git.nicolinc@nvidia.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a4fe6d-af71-4ac9-1d1a-08db8edf90a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3TVDUsm9Cvvb5fY03/qivz5KhcM02XQgTaolmfv1LvaOnNtWaIwO5QyeM+ulohizXXlnNwx0kc1ZUrMOE0JDP+Q7yF8kfoTbUYohlq9cFeO/Ejtq46HVq2gShEUEpTDSihdbybbZkoWblXZVCx3G1m1TJpD9G2p+FzMkBA7s+NN+9aMNhgnoKPktudhMPgVjkdOVcNCrZY2EOIlI8L9lF9tonYpYjGA88gwgg/brsof/gr45uB3wtWpxM/uIJh8AHAw3l5w3rXJLoy+qkcLu7Ets30BKK7u9iQWJkoVc9PaJDfecwO5RIw6UREY9dUlVuRAHkNvigTGdn4jiOqSW1Jv0aZydedzkQIvOfbA/E5l7NL2OUAkoKWG5mkLaC1+gWOU4wPKgqoprWhf8a8pc87mebX8CAmpAHpPmBhICAmGxMEBYvtKlkCOjb3uTgu3MB36tZz8q9xEZG1+W/HNDUtj2YdCq4Z9xuCCj0z6se9Q+g9Y314qpkY2D0cXDS0Z11Sx+pLMUl7otO3/elnQTwm2kdBK+o+sFZn2DHUYGuYu4Y3uUYcVqXUdPrVxx0Z6ooHhqcHv+SBgx8j4jTJutGYQ4xYSp4P+35t0QDwD1Ke+dQqwW7hbmprKdpxQdN5zZFDr9y7i9y/dM143UUOmjb2bcK6vCcdwyYEO9CBYlFcDw0ahwDOTnLvjNMz5U7e+mX7F1bzWm6JHys9nGN5bBAAJvMMvFY+/6ijz83n/9GP0slFgP1AZsweCFIrXncy1
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(316002)(8936002)(8676002)(7416002)(40460700003)(5660300002)(41300700001)(36756003)(86362001)(40480700001)(426003)(7696005)(6666004)(54906003)(478600001)(82740400003)(7636003)(356005)(26005)(186003)(336012)(110136005)(2616005)(83380400001)(70586007)(70206006)(36860700001)(47076005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:25:05.7045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a4fe6d-af71-4ac9-1d1a-08db8edf90a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A driver that doesn't implement ops->dma_unmap shouldn't be allowed to do
vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 902f06e52c48..0da8ed81a97d 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1483,6 +1483,8 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
 	/* group->container cannot change while a vfio device is open */
 	if (!pages || !npage || WARN_ON(!vfio_assert_device_open(device)))
 		return -EINVAL;
+	if (!device->ops->dma_unmap)
+		return -EINVAL;
 	if (vfio_device_has_container(device))
 		return vfio_device_container_pin_pages(device, iova,
 						       npage, prot, pages);
@@ -1520,6 +1522,8 @@ void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage)
 {
 	if (WARN_ON(!vfio_assert_device_open(device)))
 		return;
+	if (WARN_ON(!device->ops->dma_unmap))
+		return;
 
 	if (vfio_device_has_container(device)) {
 		vfio_device_container_unpin_pages(device, iova, npage);
-- 
2.41.0

