Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA696A26B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBYBww (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjBYBwt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:52:49 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8916B14E;
        Fri, 24 Feb 2023 17:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0/G9BhvqFAoqHYIZwK8Bte8oRUxwQuS4v1h4niYgr33n0O9nLpTH/8OvADyU7I2P8Fqxn2iraKHKW65cEJeHi/UCz6AVk9jTu9ArCULfp+YAU44DIG4RJzdpKgKxf78B9tukKWrHAOsGwcuFoKHybpfaweTaPAYg1KB0RYt0X8rLZn61/LSOurDwPTJhIkddqHY6isG8B4GDYlGoBi8oJO8gMCuc7If/h7Pob4/nuO+kxJ5GD06D3LOdvEnHmDPaV5+krpdwTVfoQZNm3cj6I/Ij8SYra/Hhha8xN6IxHu5ShEPYHhKzUFq5Lgxbcx38WpFQMaOjEaALzZDphOWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaSyaVzZs2lVCmYLMcd0ObZOL1Sxy+iHfnY83IU/0hk=;
 b=SKo7WWnmtnqlA27Wr5IwVLrlnfDJBipQl1/kbcfKWKTcrzY8bYih2GaRq8v7WAulMGvaXx76kfQfTcdxq7D+5V4uV5sEns6N8UP2bQ0S826NlWC52z0RxDaR+8GQiQkmRrgfCgTBSsKaM+MbMMxO5kWSntKYPxIBjQeSjSj4B6GzDcOxp1WOOLEEhGfDx8C+EOFXR7KWIl+//bma7DXh9mH0wanyUdlPRiOQwFTEBywwBIDzNmDGQ3Fm4BOy62a6clfVsLgXGX6nowDuHcukLI8Gge+X2KfAo+NeK+laZl+LdaOt0Ac5xWZnYanfy53+/g7zXA3OpU7Mpg/mJ1Rzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaSyaVzZs2lVCmYLMcd0ObZOL1Sxy+iHfnY83IU/0hk=;
 b=autvsx9+7wkU0CvKaKAqEgBM76d9MsPyaRdb/HziD7AFWIivSWX8rSD0xL2wlq3VXJi8PDaweJatauNUSCEaZ8ZvNYE3lnwVsL8rm4pmOnsTfjPUfMWci37U3QFQ9fycdu1BgeOhFd15NQuwQh9n1x+admbmxkxFty8eJ50JcCEooxl+YTu7LUFNyxE6/sN14lFVCYP4IGW7EoRTTjzkpqoUKSazXeVgdF0YPf1nUfYcW9lVGFKa1GegJ8q+pyaJ2RKw2vA7AWzo7pPVnRVB3WMIZBhgD9qLX/5t71aNK33C5Rt6lgNYkEueCIYV1wVm1q41p6OyPUasuoGz0Qc5FA==
Received: from MW4PR04CA0330.namprd04.prod.outlook.com (2603:10b6:303:82::35)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Sat, 25 Feb
 2023 01:52:42 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82::4) by MW4PR04CA0330.outlook.office365.com
 (2603:10b6:303:82::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Sat, 25 Feb 2023 01:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Sat, 25 Feb 2023 01:52:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 17:52:26 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v3 1/5] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Fri, 24 Feb 2023 17:51:38 -0800
Message-ID: <0f8d110eabc40e71fd2c37f63b1bc8888c67414f.1677288789.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677288789.git.nicolinc@nvidia.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9099a5-b6de-4d03-b8fe-08db16d2fb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvJ04IqQ88rZHtFdTtBXHqYv01ANAKgf3L5Nc3++NJyW9SYhSUcKK3wNamwocuz4Ln9/+kpJ9j7Lban6kpd6gy0GhWqPCsBnkJPcIe96y3OwUsasKSHGgevCphVGxbZdj/sc+0YzW7DEGKvwmDJavdz3L1fVST5l9278TGKUFaNVPVqL2AY2AHwvMaqr3RIcFfsxQH5Kjc0GR6hXh0yiF2RSJAeleCasR3FcqQLprhh4ctUmC0fNL98DaRZZmG9bHA9P5dV8FLiOmw8urugAONpJhREg/zH5WQrmdN3cYTsJuMpshbDm8rcR1wdiPSi6BpBLUdBqSu10X8UAkvIPVACcPQuC5yJWr8Dc0XweBDYazUCZmu5SKc6kVFtjv90xQHcnMfCAJVeI3LAKIMQc1/4gojFSxQMmBehpTYLeTVvT/5svcc/U76NOuOXISp+6nyf58VCRU50/CewtByPGS0o1BHr2Ic9pEWhOkJ5zXTgSMavFpktyxuABlyDax6yUaEM+PVFY5V5VAqWHaCfM7I/VlQQAB4iCnBcy1ePIje+j7HA18BpErDCeFXt4cGhCtlIhwTGmgjjTNya1howqRLU51g7MM3k+O6XYLiLVccOctF6MD6vRYxOTdtCVC2xCc9qX0dOo8PLPF1POn0uy9xQROORZ9C8pLVswjzPv1XKKV14OPqpZfd/XGae+ckPMWX6WFplnRkTz3qgSiVHPwx7JcVtrQJZPWNGq+Nwl1bI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(2616005)(41300700001)(34020700004)(36860700001)(83380400001)(54906003)(478600001)(5660300002)(8936002)(4326008)(7416002)(110136005)(26005)(186003)(86362001)(356005)(8676002)(82310400005)(40480700001)(426003)(70206006)(70586007)(47076005)(40460700003)(7636003)(316002)(82740400003)(36756003)(336012)(2906002)(7696005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 01:52:41.5367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9099a5-b6de-4d03-b8fe-08db16d2fb3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A driver that doesn't implement ops->dma_unmap shouldn't be allowed to do
vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 43bd6b76e2b6..0381f6e7f4e6 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1292,6 +1292,8 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
 	/* group->container cannot change while a vfio device is open */
 	if (!pages || !npage || WARN_ON(!vfio_assert_device_open(device)))
 		return -EINVAL;
+	if (!device->ops->dma_unmap)
+		return -EINVAL;
 	if (vfio_device_has_container(device))
 		return vfio_device_container_pin_pages(device, iova,
 						       npage, prot, pages);
@@ -1329,6 +1331,8 @@ void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage)
 {
 	if (WARN_ON(!vfio_assert_device_open(device)))
 		return;
+	if (WARN_ON(!device->ops->dma_unmap))
+		return;
 
 	if (vfio_device_has_container(device)) {
 		vfio_device_container_unpin_pages(device, iova, npage);
-- 
2.39.2

