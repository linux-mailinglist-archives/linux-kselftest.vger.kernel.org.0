Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CDB6FBE57
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 06:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjEIEo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 00:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjEIEo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 00:44:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02EC76BF;
        Mon,  8 May 2023 21:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLf4W7lW5kgI7CiJGsu7fTduVSSICIkadV6vIEErJKANbvxh1hInyFpFT9p/HCZgcY1GQzn7WZya4VJFVFfJ/xT37fNRBAA7zg4eITPnXMglDUC37BA4BdmMPoxfCUE6DMlJp2REwxYvh7tZZ+OyzqyCPHrTQHZLTcSMGODEp7qMQtE6zAp+4gyawyDrmOjfuUUVp3M8n/CWxfuljJviWJb6I5qA/EBe5lLeTUFkfeNsqgdfdhSeQMBiyMgrjhTVfuNIUt7Bs7NgNQXFmXsF9B9H3l0ije5HhrQymq6mR7C3oRPGn0+lyD0Xb/eUtXYp/Kms1mrx7bQ86mhRp4oljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0pfVkk+cS/b2HlV4J+2taPjCRGkf8aumGCPtHh3Zjc=;
 b=j2C/32TlgPwvQgcrEXCLpvBIABQ3c+WI+w/e3v7TO29kCEegDheO7IJYj2uk2e8cTx/3XQ0QKJOyOv/rbTVxgFaQs2oGWsqfl9V7ZTm5Ru56AzItsBWS527dMIwjVVCBGlUBJT1NTBgYxLBg5SwpkP1FI0v/G4R/MFENZsCGykE5hkxx0tuD1TwSd5aszoDfk9fwmftLnOYZRAPC5DGtBg6F4zXSLCrqPM5B3KYZgeyek1KY2ndWNWhSHKrKONN1jwtZzRR5BWXj2ekMZMasOwqj6Br1zC0F/dDhGPZFNroTSiIgnyTIO6bMwDEKbLPps+iBOcHqRuKLMFoamD+13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0pfVkk+cS/b2HlV4J+2taPjCRGkf8aumGCPtHh3Zjc=;
 b=QTbJ4nylDxmKud6PcoDFyFGfaDsT8aPcEuEPMzELzgFMK/5BoX0TOkk40bkyWkSTMKTCaDfDgJitD1jsoy2CJqB8Ld1tJu8mWvE49K+yHGmeT8plZ12yNQybO0G2czSD0lQW1QB5GgxzxP0S4zfj4V5pDGeYjQQNgalTwlmqQXV70POZrRutWKTijcYaH19mxDLf6d2HEpVnDdtRh5jDlKXif95JRP236HYYLacqI72Nk2MmOcVxzFtCvCHT7gTFKWee5Tfi5dumKkxwZ61A1f53eEyEAcCijeDGUsxkiary42CCx034UtjaCysBVQQ7N1UBU6ZVr5FRtfCYlAaGzA==
Received: from BN9PR03CA0065.namprd03.prod.outlook.com (2603:10b6:408:fc::10)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 04:44:54 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::45) by BN9PR03CA0065.outlook.office365.com
 (2603:10b6:408:fc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 04:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:44:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:44:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 8 May 2023 21:44:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:44:41 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v7 1/4] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Mon, 8 May 2023 21:44:11 -0700
Message-ID: <ee6a889339cb02dc3eb964000f2a951880c864cd.1683593831.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683593831.git.nicolinc@nvidia.com>
References: <cover.1683593831.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb5eba7-b36a-4322-e68f-08db50482233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLbkGcBYN3iif/AoHNG+ZR4cCrwnwmR5Pd/3cSpDBaIKvWKQ09isOI1WcvYwhkcPjBl2pvZ6B6aTsyCQ7uc1D0f8lcN3JS1qzkoPG/rhPuJeEWj3vUaaa8M//QuzW10BQHSyBrAyfVDjaifLwU5dOrmCaN95FjrnFjh9yAPErNJGqQ9HrewPIS/IHL+49jaFipjxSq+BWlKSP8W2M6R/tRlW+QMze7fbpb7878twNqnBk1JZJlXjd4ObLdvgu095QXKpb/OCK/X/dBXk+q4Quh5A+XGRxm0PkIfA3sR4RK6HM9s8ZZALMI1XDNZ30qOUTzs5RtvmIFtg73wIQ5jOht9Xagqs7vaZm6RU2PgmM0Virtt4dVbfUkn+pyVVEZc2HzC8j/ET/jD1Gc3FZpL7Z/0kxp8uEufG8iAz1VcohFFrRGu1OlR+T2bE9SGHz9DpooGpiGBdfe6D3dR9um3wz0UqjYwHmy9KPnGGf6+2AXHgm+CzR/bMVsM9ScibCrA/cTyUlWObgGXD0Xl3Ec/IUnUliFavNEtdkrv4qg3KHslmpQdN6zV2++3UXFHQaEtW1IWQWQ7ZHNSP3/dCvfiXviXgHIpoj3qTXtX03h4Q/pM4VqFQGNEHSdFi/z34Ab8oOQATXmfPLEqB7WxMq25nayrATzbMlBkkRriro82qe5UKqApu51X3XJiIIqENENAJ8EfNnjv3PNoOsypgrBoJlw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(186003)(26005)(40460700003)(2906002)(86362001)(82310400005)(2616005)(40480700001)(83380400001)(47076005)(336012)(426003)(7636003)(82740400003)(356005)(36756003)(36860700001)(316002)(6666004)(110136005)(41300700001)(7696005)(54906003)(8936002)(8676002)(478600001)(70206006)(70586007)(4326008)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:44:54.2720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb5eba7-b36a-4322-e68f-08db50482233
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 3b046023ac15..b1e69b389e31 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1454,6 +1454,8 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
 	/* group->container cannot change while a vfio device is open */
 	if (!pages || !npage || WARN_ON(!vfio_assert_device_open(device)))
 		return -EINVAL;
+	if (!device->ops->dma_unmap)
+		return -EINVAL;
 	if (vfio_device_has_container(device))
 		return vfio_device_container_pin_pages(device, iova,
 						       npage, prot, pages);
@@ -1491,6 +1493,8 @@ void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage)
 {
 	if (WARN_ON(!vfio_assert_device_open(device)))
 		return;
+	if (WARN_ON(!device->ops->dma_unmap))
+		return;
 
 	if (vfio_device_has_container(device)) {
 		vfio_device_container_unpin_pages(device, iova, npage);
-- 
2.40.1

