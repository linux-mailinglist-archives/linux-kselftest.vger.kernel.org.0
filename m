Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B96C61CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjCWIeM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjCWIdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:33:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894BDBCA;
        Thu, 23 Mar 2023 01:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njNIiG/WVP/JIRyJyvMtBU4Eq/GWUYHoaXPuMlLhSiI1DSp9K4HSkq9HLeA1BmWBdjIDUwxnQ0auUmvfdUrsXOqIjz0KRZVdaMWXf61pES1sRdI6K39+xL9DeGIGKqwSvJA+0eIOLjUZbzNsSwL6v3GnbWy1nk1lRnA7LFuK1zzUyVxSAzNswmogtrYiIx4q0sx7xVnkFJdJSEW8OpvP4nyFjYlJHoZvCv8ZWu70gEt6jrL4dZlhjUd+Bul46NjTLG4E1C1TBRXpCSzeIA5gAc/3A2iVT9DMa6K0z2Lef7b4+DyksDAFYkjNt4LBNEXHl3745UZ/1Md7In0dLJ72jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTtPnU9JqaC3rKvfFPnLIqJbP/9m+qfwOArqTsKitCg=;
 b=ICw45cYQu+AaeGLtqgTSU1V5m04+oiKovvIB8J/Z3wpj3T67AbsyUXgYlOgOrVrCrL20ZhGF2x2gdN9kyyv3Tbqol4Ma7yPWLVnHx03O7apa+t9x7gDZF28ebVADZjRIDSV5EhQsojRTxes0dnEcDIfOzZA8UF7qHY6iH61shrcqI4ZCbrw0iYXA72JzgQjvDyStli3TMnP3p+BC1x1XI9/9xlnHcDM4AowecMgKPnxezLrYInsE5BqMvgP/OgBTa7RumgcsaGMdePZN6hy0AlfA4QoEthg0wAKNSqRmcnKE7CHP9a7gE060M8MVJcEsXYjDniyII8uJD841KehCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTtPnU9JqaC3rKvfFPnLIqJbP/9m+qfwOArqTsKitCg=;
 b=eYJS5XGpLdzS2JQF3jfmcWKJKJHDgFCzCwrapVzKLoSSbclTqOb9gSlwI1dVKosz3Y5KvlEvRaAjAhorSbPTl3Afw01gUbJFVRxfuOcsbNxgm3ncN0WnJxW5/pyIvcyliJNSlIocX5VyTeVS7bv7fB69gIy0ZeEmxEOFuSwPJeQsFC/yKY7wzCoYoLjzsYbA5xi98+Fqs/ZP0NYU6g5oBf4YIoySAA6rSx8F8892tp/pKeOPybf3CNfzcTGyGvEZE9sIzzfTXiPT/FlBKAyKNeHzihvJqY8YE50DHzxIXTbL8ZZviPM34Q8AxiSPM+OfPjdCKU0nZ20uUFA102CXMQ==
Received: from BL1PR13CA0075.namprd13.prod.outlook.com (2603:10b6:208:2b8::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:33:39 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::46) by BL1PR13CA0075.outlook.office365.com
 (2603:10b6:208:2b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.4 via Frontend
 Transport; Thu, 23 Mar 2023 08:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 08:33:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 01:33:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 01:33:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Thu, 23 Mar 2023 01:33:23 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v5 1/4] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Thu, 23 Mar 2023 01:33:02 -0700
Message-ID: <3fbeb9bda2b297806e991017dd975aa512670033.1679559476.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1679559476.git.nicolinc@nvidia.com>
References: <cover.1679559476.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe3a221-149c-4fe2-d379-08db2b794d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/K98s2OiWlirkkzOnOOQugQXnqqc1dEvP1q6hM7Cb7qe+FlMNSBqojqxW/IDwbDB/IjZOloMrMmta9EyDFUBTJlHlc3h+ABGc4QXhUU3rnUR8uaBADIKjDwQNGuyag0TpgBQcHqzyisGJ+SLvgtyHwq54wZlmLC54djwwC7cybJjmw+mYbGen3BYSZkmfQEZVvGkV9JYNEp9jYnD2SXf5MY4mup+cdd2VRP6FNCB+H60A8fVtbEzDDCloJiMFjzkozuku84Mwg+NHJaBvBK/3AWgA9aWk8laG3W+MBfxa8zFBCsPHPfxHmq3txPptIEIS+1/mYt/BXKk5s2InbxgUzqvP3i8exsKI1UMjDJL//z1ZPorRVICVkysZzdTF5OZTvSWDbseHb4bQBsoeB+x7z8TcWY9TCqvHmE4JQTms/ntU85euVkgNLgqZSxCm6R44BC3ISRPqXJhe0XPQUwEp4vGh0xVd121AsNpL/vOdkbWThxkbQlXYTGYHgZfjtk9k9jHrzvV1R+VVdje7T6GMySNtJ1dLaXwqaq8PQGFg/x3xGndHkkGyeidCt/fP5NTk0UaCQ6gEqqa1959EaJLvqbcAc4nJg/QPnhlz6qEu7xKPq07B7KWoR9UIuqLu1yhy7pEhberqBY9+dwXs9RiUNkCyJ7CcmT8zTvsQOIYJeELSIGShcUzwinp458gnsGSc50wO59+Yn2VO1BSQhv72rEmpLhxThmkxstV6FAkqeBslvNpbhmE5jse06st9IK
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(82310400005)(36756003)(40480700001)(4326008)(54906003)(70206006)(83380400001)(478600001)(8676002)(186003)(26005)(336012)(2616005)(426003)(110136005)(6666004)(47076005)(70586007)(7696005)(356005)(316002)(5660300002)(7416002)(82740400003)(8936002)(41300700001)(7636003)(36860700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:33:39.0844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe3a221-149c-4fe2-d379-08db2b794d69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 426ebfc0ee1c..546e1fc8d8e1 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1482,6 +1482,8 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
 	/* group->container cannot change while a vfio device is open */
 	if (!pages || !npage || WARN_ON(!vfio_assert_device_open(device)))
 		return -EINVAL;
+	if (!device->ops->dma_unmap)
+		return -EINVAL;
 	if (vfio_device_has_container(device))
 		return vfio_device_container_pin_pages(device, iova,
 						       npage, prot, pages);
@@ -1519,6 +1521,8 @@ void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage)
 {
 	if (WARN_ON(!vfio_assert_device_open(device)))
 		return;
+	if (WARN_ON(!device->ops->dma_unmap))
+		return;
 
 	if (vfio_device_has_container(device)) {
 		vfio_device_container_unpin_pages(device, iova, npage);
-- 
2.40.0

