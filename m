Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07C75FFF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGXTra (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGXTr2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 15:47:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED7F170E;
        Mon, 24 Jul 2023 12:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXDKtCyvYc0i4VnaukFHfUnabtwiQGqWPsDCTJPxxDYDyp3bRhz5e7oSzIoKpzCIdzbErJfiPDHbYcLYV7Th7alB75AmZwVJVObOl2zY2pKnJbBvDdFrj/uoO6uIPECeZ2eBJwvazk7yymp7DvcGzfQFGK5KarLDZnuAVPnUxWOwHdtZemp+XwN6vQGNWE2qiqEHBo4f1siAahUJsriKZGCcPfA30SIGRQu33JW2rn38fYqvxx38uUy7I+8F6cqmeI4oGN2pCaJZdFYX2Ig71pmngatWMlXmLXUGISj59ZR99mCKRK/onQtimxk1v7wlR6ivYNUZZ0pS0UZTAIYm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqwEwmqk8liK1eUIkn35snjd9PInnQTvGuGEMVZzqkA=;
 b=XyFlsLGiUw9H5XrBrc2FnPBgW+/z3rZfBZ0clR0wm0CBFGHnanyBsRHCHaqCGGPwG0TKCa9m6NZpwRZOE0qYBMePjJre1rMa1PL4q5STjQp+AGBrY5Q6gRORrqcWoa0Mm1uubKA5194sHzqmmDxzGvPfK9B6dCfuR51byWe1u8puSt9f2q+3FCke+SLSLtl8Vyc6Z3wZStZ7Ad44kU706ctQqRuJRFIahaOtSfF4++mfwkQiqPa1oB6sV7PD/2HjhidrhGEAcoMLkUS96fvty229MfF9B7fHr4lu/YDMDG2CTi0/5TK2gJVWmy+6p2KdyFMltYUIf8Y9HNZHGMHT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqwEwmqk8liK1eUIkn35snjd9PInnQTvGuGEMVZzqkA=;
 b=uc8eQDVfMLQmcnGbcGOe94CmgQslaaMLQRbVaCHDv9ugzrGhDE06tC44XiluexAiSJo/oVdJ9Ik5ImdZFnYJq5BCVaZshoVDmn9CGhVzsGMIHuTc1gL1LZAoFjJM9PrqyKAvlYse/9k0SUjIrOsAHDY/3d/zTr88NxHE1WTEUtP70DNUnuXAx+1uZxiTSyCFWCEt5TwoI0Ham3QYOZP7ahIV6ZE90Ij9Vok8784cA6t2avaHVwrSjPMyrFQu/r55KsK/NfHjFcOrssBebLYXAEFHW9DOMgUZhYY87w9iujXRaDDdFwrYLnfK1Hm4PIzNRCMcCYEOY6FI5BCAB8Mmgw==
Received: from DS7PR03CA0104.namprd03.prod.outlook.com (2603:10b6:5:3b7::19)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 19:47:24 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::ab) by DS7PR03CA0104.outlook.office365.com
 (2603:10b6:5:3b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 19:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:47:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Jul 2023
 12:47:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Jul 2023 12:47:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Jul 2023 12:47:12 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v8 1/4] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Mon, 24 Jul 2023 12:47:04 -0700
Message-ID: <064227abb779063c328fd79afc7c74dabdf2489e.1690226015.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690226015.git.nicolinc@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf6cb73-73dc-47cf-d712-08db8c7ecd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhmML8qeY1Xs9CC710LdVQdProp6fFyoJ/CwFY3V+VpfhDlezMu1zJ+WPsGAZ3vLu5lzXEoTRAIcksFdjHWTt2YDgwkSAganEVTeVlE0C7sQq+/P8xh5dNzaBc4ReXg3q/WvsVP0i2ItKHzZSGNMK2tzQZZApC/fGLIFBY+s6KyT9VAOCcPW7D+ZJY82RqZ1HDqQoXTp/pmlFtDnIZ8DVwZXStEW1vx4UQ80ixTDWX5rrYuQJAkbZrIiCHKhZXk0yRCdzmaSXg2XEgecndi0mUjeV3OyxbLztEpl96ZA0xQVZZTc06wX6bT4Rn1DEyc+4WtxT10bBELyVb0UXKdtzMoL+VNYC5rMVSWLjc67a5ZaVVGUZljltOakcAm0xACj1Y6kuHA3WN6yyjcP/UfV1fzmK1llFLPKzvzGQfgGMB2YFhqak1zFYVCFtSMGzhhGPtLEOg5Knk8wXPAnJHcGthjBDx9HjPSP6PCFfxkfPVdOfbXafkR/5oxM2lhI49HYL9KyH/b7k77PKUKphRm4EM+bZau/p+uli2toU0OlgZ8ihE++xi8hRy+ZQVHxzXicEGhuTvFaef+a66DskV1mWQZCGaFcG/WhDhW3/oTzEvWOqEangDsoASAtTFSRI1NLgAi9BPEZ0dbWQow20XsQ55NX0Y5AEbFzovD5hew8yVTRcHJIbACLZYCXgXH2QsetNm/nwBUoQxOUIU8bGuM85XM9BVIDaStfmUdYyJ0hGXRUyGoT2w5gBCDUL3PWV3zw
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(47076005)(41300700001)(186003)(83380400001)(478600001)(426003)(336012)(26005)(6666004)(40480700001)(2616005)(40460700003)(2906002)(7696005)(36756003)(86362001)(7416002)(5660300002)(70206006)(70586007)(4326008)(7636003)(356005)(8936002)(8676002)(316002)(82740400003)(36860700001)(110136005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:47:23.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf6cb73-73dc-47cf-d712-08db8c7ecd32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

