Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BADF76641F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjG1GeI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjG1GeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7170730E2;
        Thu, 27 Jul 2023 23:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvzsYlrB9RBM59Ycw/oio11ZDn7HF9rW1t+AFKnyutkKXeu59tz92CI2nRsb/szDQACsf57QeP3/q4IiHCgat3gnUvSYNZZsSGcJypb/TUmU9c5aU7O35Bhm3L0GA+X/koq9xdrVI3ickldCh4RhyQETIUwEuP2OP37AZmHYYau+UouMKIjxoJOYiFM5afuVg9xEVyIbL/uavtD6dmOKqDBj1GgolZie3YxGQowYPhJMzk6qkXRjP6Z9wrefdFnKNiuCpL68BdnbkaEYIXC01aYyNGH/Q91QlEe/PeVimITSVQ06VLGL1VWD2Iw7Ec216vQBmLFsnyj+O8xogFVxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUc06e5xx4kTwBKEnoGTOSehjX6v5imRbufbXUgPcoU=;
 b=IxoVStPp/+jMMExBcesolYX+VPOAIthNIv++Ikwviqra8oJJMCmN+KA9WPrz4UvTQxmCL6z49eWvdoU8Bog9z+6dYBdvF4hT0EJDakMLhuWIY2GY7nSVIcdlZletsBSDvVCKys2WNe9z8Wt8yCMfeNv/8RvhSlZexFQLdGx2R2a9+rDWd8xxb2xNMcIwqmFjp2vT2SBkCjdEZ2BP4L5s7aAJqPBBxJflUevRvZ4dlTwR0msVojBYsPxUE7TesK1l3qxn0mdpxCyKGMOYe2AbA/LxIcJpk8nXk7vvlsawY1sdr5iekUNt3uCBpCcMzO37n6pQh7ZuHIAZSDsVf/dyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUc06e5xx4kTwBKEnoGTOSehjX6v5imRbufbXUgPcoU=;
 b=TtBFUokru634ZMkm5NbYjIyQK5SgInuyvMURDrA44cec0wmH/XuHJrxwIw1VhlpNf5ks94/GTJ9HXisQN9tDgU7Texdjd/8ngzKYsZ2qnEpOWVyKZHOF1Cf8TshBlm4tsThKrDNc+XAazIkXPhdXgwQzFdQFk7k6acssvqtZGr+5JSZWcQyT0tGYAZ2v7tJ3HjyYrJEQ+VY1IWQmTA0WhnCZDMQsY2qhrY7qnaS2H8WhAQ+URtou+42poTBjkXJ2irRRYCDeQS+PH3ULY5f6xU72aSnrVadRCuI91Cy28mrIt3qlvB3xhORsUh4oicZDYXcJrLHztZm8GkDOg2Mp1g==
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:34:04 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33e:cafe::a) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 06:34:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 23:33:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 23:33:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 23:33:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v11 1/7] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Thu, 27 Jul 2023 23:33:23 -0700
Message-ID: <85d622729d8f2334b35d42f1c568df1ededb9171.1690523699.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690523699.git.nicolinc@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe39433-052a-4fd5-e6b1-08db8f34a319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rTD5V1AYD65uEggi31YfYGHYtbuex/PVomchV0rFt+3yzaTVNzwGodtJK3Mz6161EcoqBwfaBgVYtz4384A1lJT0oAvVxrmo4G02bYo3H1+oyF3yxQCRytZi/+z9pQr2mWEk02wdWk8StQq0dQuX7hDc0rVwk46kAcoFHAnfBSkGfKXJ1VKr9NL5DZDS1C+tD7GVATWXR5o+3SKrWbGGpbGUVX4oOFGJjRXTZR7y/kX7VgqXutsg1T9lM+EZQBUMN6+uxlgEZ+k2uCrNJzlPwzN7zqw0R5atKZRrOVFhvbkij8G10HMOD/kXCwqVbY56Vg5U0E72ymuKO1hMuUFKnSSgmWs2oYrZrcvQEsOpggoykhc8vRX91ShoUBlsrweKbW82Un05+10v2Yk+pt2FlS6GOXTwJLk+2tDuKQOnYQA5/pA7I5/WwOFaMKXLmIY19Ot/88Y8I+2Y0bGT0U1FLBPll1BAKspMzhKCS0JufYn/c7LL67jSNy5junRRRLtUNgBw+LHHRu8xEZzvnkzOyPZPIT2uuffkgqXsk/tK+sPIFaUZHYtduaS/D3idnpCuk8DgGLITispbGrkNhdMu1hJ+LsfTfGHWPMhdp7aCt9+L2WAJKEXNFeKhwllK2VQLkOj+X3aELz+895jV+RxrrWg2tJkDLbCgaQPHgzpFcdtiLsnIoBqUw2Nl4ex4bq0BdDrvJ/6UHq1prOr9crrXVQ0MRQsWsC+Z48J2ftGdOQXRHiom7IElNGIfZ4HwA33
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(2616005)(40480700001)(47076005)(426003)(83380400001)(7636003)(356005)(86362001)(36860700001)(82740400003)(36756003)(5660300002)(7416002)(316002)(40460700003)(4326008)(41300700001)(8676002)(8936002)(6666004)(186003)(70206006)(336012)(70586007)(26005)(478600001)(54906003)(110136005)(7696005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:34:03.9574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe39433-052a-4fd5-e6b1-08db8f34a319
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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

