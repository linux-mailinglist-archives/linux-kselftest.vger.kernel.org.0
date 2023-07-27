Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0117648AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjG0Hec (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjG0HeF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:34:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8A9EED;
        Thu, 27 Jul 2023 00:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgiBwmFleE5Tm4zglnB4+AWfoAGE2tMZPAZL0vOWHeRhLQTACEh8V9D+F9QOB0emn+YczHfsb7DpFUg0IFzBEobMz4QEDGZ8WoLMgK6g5I3vynm7TUUlkvK2cdJzxCKTr81r2ZrECthQeOl2Xdn7Ie8ns9SRUrxdEvZEOU5yryOSNzUQZPr5vdOdhLi9m0uWr5rMbleje8/bZ5PfgufBs/VcdnObG0q1aSCcIDvkRsY9E8B3PRD4z44CCLoWlhNf0rjMXrYRFpjJF/CXS2UA5EbMa0sCQePbRckCtOMG8X/Q2Dks5tUfJy7LQjPS5eARSSOuz5o64tutQHR78NWVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUc06e5xx4kTwBKEnoGTOSehjX6v5imRbufbXUgPcoU=;
 b=EmAKUh0TlT26Vm3kRWYIi3JBbWbfbvMPDemgzS47rwU9M7ttS+Saxni+I55K78hdQBqIsm2me/UJKnL3HrQKVDUubyquupWmIUWty5GEwkDHoCf1bBXIHJ21B97ZDxfmb38MNpiFkS6/5Cj7uajM4kdDSUKoZQkOBjnx3NMy/2vDSdAFO+vknJfBBcARKnP4bsBF7QBjsGp6DtsB6eQm4z5tH8ot8ZCiDP1jF9zBNBtjxZSJi6CO0NqphZu2Pyk/9ekeVTfPuQxsha+XitEyhBV78A7YmTrGV/N3gzL4Y8/u4Vydyat/puKCTE60dVKa7SGK0I66BSxqwB6ZWJdNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUc06e5xx4kTwBKEnoGTOSehjX6v5imRbufbXUgPcoU=;
 b=fWYP2iIaz0UTtQb+rR/sfQeuZHS+q+di1lRMUpj3Uq2FphTipsoL2UEwWv74gXY1LYASLtJNHpQ8Fitlv0MWRPU44tv7CKSw5f7iwbQrneCOAOWF+BXJQ6P3xCAtEDUn25twBwdejJslJGnJnuaFauxmZcoTSeWydPX88wuzGhGCNVTO6dyA7oViQQrwyAoWDimdRncRcKTztHjx5dH4Ktka+XT8D5ZrukAN0EgfJxB5x5GqZF7t+ZhuyEz+FEDIzRXUX219dlWizJ1LDB2iYAkMM7GvWkNUZcVIry7pUeVnswBghuIbHSDqd3EnN3ObryKDs77no4uTltdw0O/+3w==
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:23:45 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::df) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:23:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:23:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:23:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 00:23:28 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v9 1/6] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Thu, 27 Jul 2023 00:23:06 -0700
Message-ID: <85d622729d8f2334b35d42f1c568df1ededb9171.1690440730.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690440730.git.nicolinc@nvidia.com>
References: <cover.1690440730.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|BY5PR12MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf4324a-d679-4e35-eccb-08db8e72696a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkCXyBpGgqTszVEdrtSMMvxTklDjn7gyplA2OqVClicqlcTMSTRYyMjuqPp00FYVlLst1N+5GkbsOky4NaNORdrE3SpfX1I+hfgAft7+x125fX+5Ed7w71LGb2liKdNPB3r2Fnw4hVu42V8CtGxcT5TTXl2WXovPaLa1ivfU5LWwVKyBIUYYYChTPPSOnE4z9a6goXab5zGlMll4LaInAae06dECgV24kDbSWtRsJjKpIqHM7Rabx6lgPRUiFMI/aVtt5omHr/Lj20mCaymE9Vvdl9rK8x8blgvshJ8+xNX2Hglhyb57AiPmtO4ukJy0Q646JnBYmq50YLcIW8kmaWA/LXERnOHrQcaE/7DTJFNmo8ymTht/oMDlBRehNbV42V8J4s9yO0CXl5/KxvOfO5dD8Hg1+u+UgOxp5eUkrMzTocmz0M4KEf5JHjjoYuO8Er2y28HpDobGAqvIo50b67crZ1YEPRtU14PN1PRxW5l2kY9KGLwC4qubsqpX62WEuHW6FP5ZVLFgT96Q52qrFmH8qVpDkX/+DmV0QEHKzAf6LBaQleQGWq4TNwLvL0V++hCBGJiW0DxrpDjBOI2x4RyOxgaT9WB+biUPvoHmMwZ+rFr0g9WVGWlyyzHpZTk96oF8+RV8ykHOPFSKM+OcB0WT+BHpQBostbdFErdW2vUn/vidAMFh1FTVxz+dlBClUiPQMA9bFfdfIKdnC/BupensY4pr5xneoAoAb/lUDvgt+n62VAa/rMePZX1rBje5
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(2906002)(426003)(6666004)(7696005)(2616005)(36756003)(336012)(186003)(7416002)(5660300002)(86362001)(83380400001)(36860700001)(47076005)(40460700003)(41300700001)(8676002)(316002)(8936002)(26005)(70206006)(356005)(4326008)(70586007)(478600001)(7636003)(40480700001)(54906003)(110136005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:23:44.8150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf4324a-d679-4e35-eccb-08db8e72696a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
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

