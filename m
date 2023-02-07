Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4493968E2C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBGVUi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBGVUg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9DF212B3;
        Tue,  7 Feb 2023 13:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1ndj4mPDnOQUqHrzn2jDPyXlf3eeHZok10Q83mTw+8gxnErGM8gRs6phktqs51T8ggA76KzJajHVM8ejh3TCzS2qFJ75ueaCblaq26tmMUkHuoJvtqtWf1HptIYB5IfT4Iwyodvtqf1AMqtnAdg60rNsH8q8irhzWIoknk3Pc0HrM5vPBBXOEy0cp85lw0/vhsfB+KB7XmPj/Py+j/f4Qt6QRqD8m11tfJzCYUP6t7UlizgLthyPALYFQsNylx9omJFC3sRw947hk3CRgWF/WNjLtLEtGx3vTVL8jWRRjy8S8UPRMq01GNEOkJaTDN4iaN46LmJ9E9Vt2oEfIaKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nln0/WgL7WQQAkV7xiFgY+npSCsqkLH4Jcn2MZedE2g=;
 b=HJwtO1kNnxBg1RWyGwCp4GkJ6Zwhd9VIwn1aalsb3sBH0JC2eYJalVBijhYukiVwShJnJJZMb6HUY9foxppIfXHPRekEC+Yx6aLrKMMzpB/Nqakcf09NLmAKkvdn30xAGSf4wxIkb1qfoqEMy6qjOGXFIaAszcP3bSHc6uI6d+YPGRon1fI3NgLL1Z5mVxUQbeMITLrfelhRgarx8DUC2Oq7KK4Mfp9U6iVkNpbd49flXQ8uli0U6wg31zHYpCsvssuFbEq//5MMJA3ngVIuxXOIGQDWqBfnQLG8E8FpXZCKrEK7WOhU2o51w5f+YlRoSMxwYmEUgWvtAwwxDA4g+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nln0/WgL7WQQAkV7xiFgY+npSCsqkLH4Jcn2MZedE2g=;
 b=JJCgebO9JOX38atArtVmIsF3gw6+JCrKEgz/hVG73EkSvmzSdnpquubvlimIyROXB4gK/QvyixbFqNHuQfYaa1D7O4YCOcbgfDWxnoOPtQ6mJs4uQjwO+fdgq4EFCyVCIBH7dF2+R1/DwA/pya0YiHy2s8ECKkfS70SfpDaiwZg93EiOp9b/0el1sus5EWRm7JT+qJpsCnRK/glOCcLskfqB1r2HYpAdh8SlBC9n81uqhDwbiEnM9m9MwM7x34HQ8++4QC0iq0wc2i3Nq7Fnj7HA6/3xvMHoQBenmil48SaQ18OjRjVnhLGSs4E2oyQFd2qbHIO/ONib3/fINKMO7g==
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 21:20:31 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::ba) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 21:20:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:20 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:20 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 02/10] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Tue, 7 Feb 2023 13:17:54 -0800
Message-ID: <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: dae29bc6-7503-426e-0908-08db09512493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG+rICLKXisN7SLlf2kZgVhTPnqOWEPtWq5IOngd9d5y6j9cvduVaG0r3JnGhR6HDE4n1XZH3n8VSKrKkOcH0dZ1br/hGIqvEl6Ssi/V2ZK1OJKjxXMw6qUjplaA+K8ZFCU1VeEGI4vbWxo4rnbDQSoGeX4ed4hPM2weFJCsG/nAFQEo0VHDnTBy4bdV80VGXowmaPXxWT4tSbO3jinkOPeRvLs0S6T/N0DWEaPIIf14V8SYtK0v9Tmi9Hm7oqrHPZ1mcwezke7cKRuqY3dZBr8cW2m+kevAtQFuGTElioRLg9L9B9NhXzs6FBY+4dDFX3d1ZX1oLpghHuNIVNeV/SFlQiYR3dD0JOvi+i1n0CpWpRxaanPC0tdV5Q2urieT1V1cbZHktk97wqG82RZCn4MiJw6tTrjbk+vHAQZigB39icpWp/t6c4ePMsVBBIn+BMUz15NXVCcwesv2vGwK3Fgo1By+rlJn6WwfcoOl6p8MrlLLfg/ec4jDAgiPK4MHt3ytWUayWCIPlQp4noTI5S1GCvt8SD/Gq4RjF0dmxgtoor/1uSaKCqYFJwSk49EVcKODSXyYj6wL6I7Fxbic0na4V4Mz0IbuH0ns6mzCN4naEVRulUXSYDBeW+FhL4UGlYyMWEP7QXXexmqQo4ur18Z6/PPd0Krv6LqS5zeHysrRjUEfD3XX0Jm2tC1yc5GxEOutJLj3qMYhKvcsgI4ZHQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(5660300002)(7416002)(70586007)(70206006)(316002)(82310400005)(54906003)(4326008)(110136005)(8936002)(41300700001)(8676002)(356005)(86362001)(36756003)(82740400003)(36860700001)(7636003)(7696005)(6666004)(26005)(186003)(2906002)(47076005)(40460700003)(426003)(40480700001)(478600001)(83380400001)(2616005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:31.1486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae29bc6-7503-426e-0908-08db09512493
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

qemu has a need to replace the translations associated with a domain
when the guest does large-scale operations like switching between an
IDENTITY domain and, say, dma-iommu.c.

Currently, it does this by replacing all the mappings in a single
domain, but this is very inefficient and means that domains have to be
per-device rather than per-translation.

Provide a high-level API to allow replacements of one domain with
another. This is similar to a detach/attach cycle except it doesn't
force the group to go to the blocking domain in-between.

By removing this forced blocking domain the iommu driver has the
opportunity to implement an atomic replacement of the domains to the
greatest extent its hardware allows.

It could be possible to adderss this by simply removing the protection
from the iommu_attach_group(), but it is not so clear if that is safe
for the few users. Thus, add a new API to serve this new purpose.

Atomic replacement allows the qemu emulation of the viommu to be more
complete, as real hardware has this ability.

All drivers are already required to support changing between active
UNMANAGED domains when using their attach_dev ops.

This API is expected to be used by IOMMUFD, so add to the iommu-priv
header and mark it as IOMMUFD_INTERNAL.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu-priv.h |  4 ++++
 drivers/iommu/iommu.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 9e1497027cff..b546795a7e49 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -15,4 +15,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	 */
 	return dev->iommu->iommu_dev->ops;
 }
+
+extern int iommu_group_replace_domain(struct iommu_group *group,
+				      struct iommu_domain *new_domain);
+
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a18b7f1a4e6e..15e07d39cd8d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2151,6 +2151,34 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
+/**
+ * iommu_group_replace_domain - replace the domain that a group is attached to
+ * @new_domain: new IOMMU domain to replace with
+ * @group: IOMMU group that will be attached to the new domain
+ *
+ * This API allows the group to switch domains without being forced to go to
+ * the blocking domain in-between.
+ *
+ * If the currently attached domain is a core domain (e.g. a default_domain),
+ * it will act just like the iommu_attach_group().
+ */
+int iommu_group_replace_domain(struct iommu_group *group,
+			       struct iommu_domain *new_domain)
+{
+	int ret;
+
+	if (!new_domain)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_group_set_domain(group, new_domain);
+	if (ret)
+		__iommu_group_set_domain(group, group->domain);
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, IOMMUFD_INTERNAL);
+
 static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
-- 
2.39.1

