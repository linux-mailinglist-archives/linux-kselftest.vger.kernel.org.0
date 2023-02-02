Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CB68763A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 08:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBBHGK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 02:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjBBHGB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 02:06:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0983247;
        Wed,  1 Feb 2023 23:05:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLswzXG4CIiDs8AS9hlpKderOV1y9MWeLRq9siT1dvzp34yvvYqnhXyDQ54t+obwI0WT+phA1X72UJ4ssr7yyzKmbn3imeExlLdeuUt2bLzRTB5/92Hcu9cVOXrInbZ0ntpVH9pnEFb8dnNvMJTuGCvNWgP8alDlO02O4JVj/ia5+QzfCf9nMDuuIBDp8k+82sWkymouo+HVo9cJEQQ4niWx8HbP/M2XNN9pTc+qkenn3gaHI5eNdPGckg0O7+gJpMmyf079fXn45w/0vMSJAKDRU9gXkJzl3+oNSqIiBmT/Q8vj9SlNajr8YId3UCFey5TQxEkmN3TpBy5z+ZYXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSnb3seOfXhaHtUGd2lpRQOZXaxLwCLlFKCIaNVwaKE=;
 b=lD2Z7ceBgYPJ6y6Om8b4sa8Qe/tRBew/Mrijx4ZAEV5msh/1h72XD/C1J+L1zMj9skeCE5xcpwpIoLNcoA5GaDJPhOdaXOCTdawI+cADjNU5x/JL4FqlFV0n474Pi7LlbqQuwZn2FDBDHXfhaX/fZ+TS/m+/cgZxOjPYbug9mc81K76FBSzCm5oPRAjPxuv9gbEsgEuKS3R421Fxu0TgiqRV+nfSWB5GQziLTyM19V/0cN5/SQ7FqD4SJICgsdRo0EMaPhQQyz5keAsQno4UGpCAqEiwQ2LjkAaULSSOMnfBsZm29nb1KRUWvNAt5iSWfZPp6hyQp9JK1aEeUl8iKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSnb3seOfXhaHtUGd2lpRQOZXaxLwCLlFKCIaNVwaKE=;
 b=NLPhKY+ZZXL5B9/CqQun+IX/5pejfoRW4ybs0qy2gM5RP9MOfh37grkf4M9FwFhTgHlDxGTBKXlNMT+/VKYyc71Inpcf+jJh+33jU7cuYpfHY1J4iSBb4tdTxGKdI6QyVNonBkMdbxvowGuURk/Q9NQpUXU+a2K9RiiSywd6ULUhE2Czi0SJEYq0VbDrZZ/1Ohbx7+ymkxmfQJsHD3a8tEIKxGZ38GXF0vh9M+MG34/ryiIP7ks1Ag95EGCRLFybBpNBOo7fsYIcXaCWyoUPng+sOKA9VrHxLKX8gwPZXOnvjyFu5XcTRU5oAsvsMu2yGHJ+YaHhTLd27MR+mFaDtQ==
Received: from MW4PR03CA0252.namprd03.prod.outlook.com (2603:10b6:303:b4::17)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:05:47 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::e1) by MW4PR03CA0252.outlook.office365.com
 (2603:10b6:303:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 07:05:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:31 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:30 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 8/8] vfio-iommufd: Support IO page table replacement
Date:   Wed, 1 Feb 2023 23:05:12 -0800
Message-ID: <a85ebe54c2fff9ca134a33cdf8744a7c1d66feef.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7595f6-d48a-4fb5-bdcf-08db04ebe815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Gnh3SUWum0fnbUcSxaqsQQ8zYvirFe/OGILMgL7zo7DpppV5BmQo+9ozBjK0gNFq9c1sGTLkPP4t8qvJOgLSh4/a/YJiEhXjat+JuqPvMlRaxZgE47m9pM7eihoHMam+8OYcyKHLfPcqk4R6Su+3Zr+VFLhL1L0xcG3YGEzTcIO/qqTynCAZVH+182TAeDdWiSerB5oTvtLhlifu5U5KozBT3wvXUZwooorWtXc0NcakDbxt2yMXie0yleDjRnVoSUslxPM38ZCD8kCkue8Mz6W7tOPaldet03+SKNUF1YD+Bf1qlFN3RVbu/UkOKHP3WG7AIu1N42d3afJFcjxCa6xR625RbwgP41rypoZDciPsD9O2VFLcu1QR5y8n0Leu2MhEmP9k73LcRf28t7QZs8eAJfN0HOMDdAX9HetvqncYEGLa0Y37R73cWUU4KBTCogUkpGyIAna9ZVxgy1YVxoPSjfvphWLj1GkzKPmyEG3VEOvpXda75YlzOv5nRigDtNm7hUlT6r9/pxyDmGI59BI0/GKLAv4N+xUgqDUVBJUvGIe3oTvk76M+oDuls5A35ybgFWTyApDuPGP7c+1U/WfcUSSjCv5qsrUqUVsdg5Ku9/DuAkTREqb2uegLRw8IBjmZ4bhFPlD+9KFcOe5xMrT4OfIWfp/EC+wTE6jj/78FKaAhd0Ivf8J6cFP6D+ppFxRLE++SvA90OYrAzs4Bg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(2906002)(478600001)(36756003)(70586007)(4744005)(40460700003)(7416002)(6666004)(26005)(186003)(2616005)(7696005)(8936002)(336012)(40480700001)(47076005)(5660300002)(356005)(426003)(41300700001)(8676002)(82310400005)(4326008)(83380400001)(70206006)(316002)(82740400003)(36860700001)(110136005)(7636003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:45.9528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7595f6-d48a-4fb5-bdcf-08db04ebe815
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove the vdev->iommufd_attached check, since the kernel can internally
handle a replacement of the IO page table now.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/iommufd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 7e09defbcffe..f9e89b3eef69 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -111,9 +111,6 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 		return 0;
 	}
 
-	if (vdev->iommufd_attached)
-		return -EBUSY;
-
 	rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
 	if (rc)
 		return rc;
-- 
2.39.1

