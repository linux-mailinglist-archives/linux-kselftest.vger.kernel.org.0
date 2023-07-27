Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1F4765D3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjG0UZQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjG0UZN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:25:13 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB42D71;
        Thu, 27 Jul 2023 13:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIDKK53D293JBK/9f152A4St9+zE1H2s9EJsANrXiOcRF9oXxDAUVaTOPTwfM9b5WNeFgotacrLBhkSm6AKZ6jsx3cIXhNNu9NKOlCY8q4sXQKhCwcigdJbhbYJFGltINXNMlJ2HS1BbfUJBv6ZfHz0/oXlX8ppSo76P9Cf/r9spW0imp3BQq018QDUDtIGwH4cQ0RrjlMudiIG7sRamhPjMy+2dAe8A3zH48c9d2cNoFoT4EOsren+XY/pv3ab3qaWeH2FS/rnpl0++07sXuTllfZDBDh9r1YBcTOJb3fhjGkld34vfkDwMy8PMfJDJPhFbNcWPOMYoe5COZ5s8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4159wIImCNgUuFmUXgR4VRJCiyMerOaaf0nbuuC/iBM=;
 b=Rgsf+MV406ijO8FtZwPi0d0AOipw0HSF/q5VT6+LIusRQa5tQyxa1Do2GVNaGSYkhdAAx+DPEu1ZuttdxynEVkkiXnOX4dbGGM27v2qWc/3WPWI9q8lJE7PIX103v+fg1cJl1EVNkHfS9ucFpoqLvLDm0+a/tJ0ayxMyaMW4WRAXuXDsijJYjFbCh+afGREr0ZAT4hIo5XFN+PCH/c4XYiWfabgmVnYyBWY09yiIBsiu230T+ZvOq4IKRDs7Q014ncV4GrsWrRM3mFHJCXdkBgaeLzI3qaSzf1tzyf/2l03x0ApT7pP3xTJRkemjaTZqg3o7oM1KPwBfOb0u9MHq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4159wIImCNgUuFmUXgR4VRJCiyMerOaaf0nbuuC/iBM=;
 b=fi3FJ/YKITJq4YX0hNPajjzWNKWoceHi4JDapED8R3oriA2LQu9s3RhQ/KIzeiv2NOEi5MRTEfEuvAR6Qo/ICklMjtH4YJfOP+I9YOcyXXITBjKlgpCdYXruKf2YXfOw1gzUyLxJDaBl71YuTpa2IDiXytcG7fYBq0fnHw7fgUmLUE6jAnGHNBtKFjVR9yB4SZqrSBmOzG/z6Io/8KNTBpZkjOcnyZGEsMbqP1X/0uf9yqXNKRnEy7ge3T04P4G0qHEcYBK0As4CaUjZSszxLOcSWim/+Tvywpnwdp/SwP+Cprx5dW3b3rV1NuuBHBT8Okt8GlIPecmYR/rZgwhj2g==
Received: from DM6PR02CA0051.namprd02.prod.outlook.com (2603:10b6:5:177::28)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:25:09 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::e2) by DM6PR02CA0051.outlook.office365.com
 (2603:10b6:5:177::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 20:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 20:25:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 13:24:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 13:24:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 13:24:51 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v10 4/6] iommufd: Add iommufd_access_replace() API
Date:   Thu, 27 Jul 2023 13:24:35 -0700
Message-ID: <50da1150e2a4b7bfb51db91f72db9a4dacd4f918.1690488745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690488745.git.nicolinc@nvidia.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 711075ff-3563-43ad-3481-08db8edf92cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7owPDcO5pDoxI/dRPac/21wmIxDg4zmgVmtuMDxTtT0CjPPjLPrufyiz8sstxU7xivbOYH9Z1FASHos3dQ8Za1D4rRiwh2wnpotr09dyrummukXxFRBZUrRUoSSN7lDbVY4I15liP+IfezBo1XT/Lh5P5ww6pkum4pAyp4wm56tzj1hHzRPWLAB/MEhBjcEelJ2ui7sZREojp9RKK3NNr0LJdiybDKSLwA9HJ1AIIX0nW4SECGw2v85hRK+QOLrzqfR3hgohZbb8/4IoqHSotI6eK5XLXvwbnGc4ud77CZlg2FZxq2aFeRjt2keLURm/h53Pzp+x5z20i/2w+yE/MWdZmdWEpHuNzr8ehcFxNKZ6BrPDrwY1eLtj2JaLKyC9wXzruZ+kxDsRl5Htw8m5gK0zwBBxZ7z+QRq7J8ReKio1C9nrS/I8NWdhbKeYYVI00yooCelFUWkZZFHMQqKBffoL+XQKCAO9+J24skiiBJtPCwB9fGQGyCc9gYKAFqz81LhLXERNUDelqhoXKAnO4WprCc+XVtnibh9enqdxzBSkVKhaG0dRCVmb2a7WIiKM8kirDJkjSvg9MH1ICj7zm5KPjA9iYoE6qGi6XatoPnThD51sL4LDfWEwCjF/SqfURTU6YwxnzmiaYXHvWtnDD17hzJN2aeovwKyelctR1jrX6Dz/Xr9Em4HCCOfq7wIJ1+XcJwqBaLUWy2zHs0MKpcqygzps79bkuAfKg9aWFpev4+Tf+2ywL9pfHGFpIu+
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(356005)(7636003)(36756003)(40460700003)(2906002)(40480700001)(110136005)(54906003)(478600001)(82740400003)(36860700001)(336012)(26005)(2616005)(426003)(186003)(47076005)(41300700001)(7416002)(8676002)(6666004)(7696005)(316002)(83380400001)(4326008)(70206006)(70586007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:25:09.3292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711075ff-3563-43ad-3481-08db8edf92cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Taking advantage of the new iommufd_access_change_ioas_id helper, add an
iommufd_access_replace() API for VFIO emulated pathway to use.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 15 +++++++++++++++
 include/linux/iommufd.h        |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e79cbedd8626..7a35503b0123 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -855,6 +855,21 @@ int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, IOMMUFD);
 
+int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
+{
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return -ENOENT;
+	}
+	rc = iommufd_access_change_ioas_id(access, ioas_id);
+	mutex_unlock(&access->ioas_lock);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_replace, IOMMUFD);
+
 /**
  * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
  * @iopt: iopt to work on
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0ac60256b659..ffc3a949f837 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -49,6 +49,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 		      const struct iommufd_access_ops *ops, void *data, u32 *id);
 void iommufd_access_destroy(struct iommufd_access *access);
 int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id);
+int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id);
 void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
-- 
2.41.0

