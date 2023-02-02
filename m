Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07C68762A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 08:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjBBHFv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 02:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjBBHFt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 02:05:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7583493;
        Wed,  1 Feb 2023 23:05:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMwMqfmwRSjvgDPHcJ28fNKjuVceBjLrBiUUyxcBKCXO4Dc2Vmniuz6NWVthPwsWaR3FXByZ7ZLflrs6pId44BRrFJXq7bavSyfNpfeJZHoR7showLNf7z9mpCAzugfyOKCgFqQ7XreEl9NhnLCzraEfb4LSyUF1wY4k58pcadQk11LdWH9tTMcySmYW1xo6p9IIy0ZXLu3K230i2vwT9aKrdgnrjvEipSWkS+EncxQUwR96sQ0vBNFgK2sMFi+cH2gQSBq/pY8WXbJfRx8YfQTAvkeZgA1kadgRD1dYRru7Gqwvle7sVNYs0V3aY6ZYJLsJzOWWPby/pIp+ebViJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSXopJtgzfG+ksXEKGP9eCOmabLw6Vz9mNSanSl1ntQ=;
 b=KIrDRodF6DX9TYzo10QD2CasEpLUsT3oSfhko/DmlCySwNkdmplzJUm6/21/FnnR/HwR/nWKDPx5JlInU6M/jcR99aEAoI1gX2/Aae4e4gizd4UnKndW2+FFipd5easzhPoL/EUu59VkIxUxNBBkzslQWSLj3b3ZxaQbz0JhWuSDcwpiBe8hecVmzLN2zX6WVk5g9aMorlZ1LUdtqYBQfI4CD1010FVc+ja1Ijn4gCdoH9sQvo6gLChP3Cz2vlanincbkVp0s9h1y3WmDC/54SNWdI+1E0PIYh9GBNzkxEKmpmL7Q3DyVsDjLO7KiD7NERameURF82h2q3V0+8G69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSXopJtgzfG+ksXEKGP9eCOmabLw6Vz9mNSanSl1ntQ=;
 b=Asfw5JsLuavfVuN76soQEbG2I4hvnte0UN4Zs++8iA0+hSI1Zj4CRM+6Gi5EC8+nukMSMyzeZh1medRc/6yBJSo8MdjX0QUwQnCnCD7fdoC/nBNSYHHS75bzc1UkvHQsgKUsRay2eki8U0MJs9BSa18RqoUbg64fXUXmyK4/pkFRkMYj+idTNwpOvgHoH9c2t6rtpWPsDg+9S5SLDlUCAbgM4fPHNrpBZ8Q6GDjPwa0XoU1ZeAnX7JXtvnv8J+yQQUfHRjeWokZTC7dXGZ381/kvy6NrVmFrjbgUvGFx+e39yPISuFl1LIQRzTweng1bplwj64if2uEC9tW5o+p4/g==
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:05:37 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::38) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 07:05:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:23 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:22 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 2/8] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Wed, 1 Feb 2023 23:05:06 -0800
Message-ID: <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: be078dbb-72de-47e7-224c-08db04ebe2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7+k6zhoEvSTt8gk0y4EKA93Bhz9WmxO5aYmoksbmPZ8zV2aufVSMvxnppSic37ocuOfQKKuieS3H9l0lmW8Vw3MHnTtj/GQOsp5roEAfpy4+vWW28QYQmZWWkcoDUEhMGZp7wMCwib6XAOUaavYbO/WlZV+uqe3qx6nf0Zq7TC4WI7ggTmwN+geQDpzAXNi9rhL0+XU9lJL83K9M5AkWZKGeJGjtAapEP9P/fMjikETcPpeG8fcH9Vn1hR+N+A4n7EWYhNx8Lm0/UuUX3uce07+dYZL5y4h70wfYTt0/3GiUHFXhUrA227Dxqs8dmVvNcI280bJxm893AJinuNAiDSWnEgtY0Tg+tojMXFzzMX9zNyO8Q6LIJVc0/5ZSQshtf84VXtoCGGfYGPpgb4L5xrfobtviVSRh5KRlndQEezZ8j8kgNxAq+FkZQ0LT21oqk5hxgt7tfDvSnR8PQ2YCQ1ClW4PrVsEzM3JWCFn6yQtzOk70y00RcvBXDtxd8i+GN3EADevT69/cKwAqhJV8FOaS788duAMZMGJeK3dauZKPbQPhFQQ2mUoUEFzuKa2D54t7hRTBlGaSvky+D9EMDY3GaMsaAUoJhREMOk4mbe4OlE93uKpfoXagfAVoIjs+Iem7GUkIdh9dDjAOGSvE1sAS5x0t1mdQsPMNylwI1mgmweNvW0uYk58TrURsprcQRZ2RXutXGMqCJwXnTip8w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(46966006)(36840700001)(40470700004)(82740400003)(7636003)(40460700003)(26005)(336012)(83380400001)(2616005)(186003)(478600001)(6666004)(70586007)(4326008)(316002)(110136005)(7416002)(54906003)(426003)(2906002)(7696005)(8676002)(41300700001)(86362001)(5660300002)(8936002)(70206006)(40480700001)(36756003)(82310400005)(47076005)(36860700001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:36.8710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be078dbb-72de-47e7-224c-08db04ebe2b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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
 drivers/iommu/iommu.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
index a18b7f1a4e6e..c35da7a5c0d4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2151,6 +2151,36 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
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
+ * If the attached domain is a core domain (e.g. a default_domain), it will act
+ * just like the iommu_attach_group().
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
+	if (ret) {
+		if (__iommu_group_set_domain(group, group->domain))
+			__iommu_group_set_core_domain(group);
+	}
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

