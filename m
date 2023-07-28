Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5055A76642A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjG1GeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjG1GeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E9C30E2;
        Thu, 27 Jul 2023 23:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFl7sQSNIqEez84Ur7oXUGCSEa8hS2hV4vBxHXXZxdCWDp2TQ5wVYpvTGCOHBsgnpTQkxSoeHopdw/iNbEMh5kCisIeQVuXVEKvW5NyR5Xr9yDeK2uvYvUfY2Og7p5IsM+YGnBTikyyEyn3y3Fm9ILCZDfl5PvXeYIl2QsfclcVXRfOQBErId/1103VALlUu26nJ/NjdYGjihBGMfQgMTr+Z6SNTwrBO2YeFTjFBv8MNN716TylMzTaX2t6XhvW1sKfnRigJKy4QXQ2jbaCNC0pumok4QiZFfRKQWOOiT9nhl2BeBbOYvmQyKC1skh1vmjZQrATSQ6acLs+6yNXHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed2umQe9J9l+UY7+AMoVlnRwH+qHkld/m2lP+FIIOtk=;
 b=VrBS3FAJW7nroufH62j5DuqktmgHshAa31+TxkFXbLJNIOH/iIZ9ToYDPA8UAVh9YR4ZqSc/RGknFbotwijVq1PoGLLyp7axiejokHZ3N5fczv55grluhZKOVyKWkkva9+yjuy8te1bnUW164PibqbQcH/aw/9V4AsFNVi7Xsac8z9ZXlWHBlGrSLm4AhHui1DdHPEykqHNTHt7Gov4nZTVnFpG+qX3cZXil3Pm3FmaTVJTTuQTXRq1hJReYm3P9OjN1JpCHob0oN0+lrK4CfkeTDbJMMeWtlIcdoQPkcp4Rak1WOtY3y0SnOSDcLXJym+UqcLUU8vxXCiH6/DchDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed2umQe9J9l+UY7+AMoVlnRwH+qHkld/m2lP+FIIOtk=;
 b=XwPh524J+i11IxG9Ia0vYiRuUvT5R9paWlanl6wh8EaTB7kd4Cs9A+9t8pHLa5ElFbZIqcmijH+3IjFSTL6SQW6l7ePXLUghu6onL4UFmp32scpW4sw4oKjoSDCJdh18vXOmVFWCfxeBToVya+bYoiWLRL9qjxVrKMb8yEXCvQFpa0uD9jtc2jb6HKdV4dGPdooMMP97T26zSzxKIfn4V4f6bR7UObVKSRluNJEkk78M5IRIqmShBLqbutzBWegoQ/lAtqculd60UulwjTF+qDKD/c2d8Hjju8B26OWL61Ir4REhc+dmkr7ibksXtC5BLmYpcyTjPQ20CGHb/VU39Q==
Received: from SJ0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:a03:33e::23)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:34:09 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33e:cafe::8) by SJ0PR03CA0048.outlook.office365.com
 (2603:10b6:a03:33e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 06:34:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 23:33:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 23:33:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 23:33:56 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v11 5/7] iommufd: Add iommufd_access_replace() API
Date:   Thu, 27 Jul 2023 23:33:27 -0700
Message-ID: <a3267b924fd5f45e0d3a1dd13a9237e923563862.1690523699.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690523699.git.nicolinc@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db99757-2772-4a8d-a82e-08db8f34a619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7tErble0CzgxcC3GxovEe3tcnkOChx3q1QO9f30OD+umrSgGEIIlV23AE77/35v0vki25aZnwlm2+yzAw96Dt96T3Kqn2PpGWxER9kwufqIoTFRsnhKrfQu/YQ1vFkHXBk4j0S3aIVZpeR0xxDeU/MOanB9Nb/SkS/gAK8MI7hhHnWo5CKVKoLqmlALiVthBlAzqCQEvzlFbccZpyjmzbDwrihEQyjvgDF3ONXuSItb/ORUx+0BXJDv0tjsb+FypdDE9UKiPD/NtNEMJujhB2Z7FRXzdW5BfMCXJytoTPjcxfapEjRTT2Xbu2CD85RCGRCRUObqVVaTlFIsnHi75zuKK1KSt0WyLIrn5AQ0oDw9i1NzSWY/9OU6TcNTcaDCDwySl0X3ZuKVJc+qkLNgP1qCqtQLDlyLOo354dZurL6VsqJ+XPwy7YJBXiW90Amw1ZF+m2vioQSjUWdeoMufwM7aieQujl75Wi0HQt7PwrGOrTe5fFQltPNMBW8vBC6gDjbgaAMLzbwNrJR7FGPGneW9gxhYsgnsJBI1JgRTwD8BZaaxcvI9gkdT/AvH736aXCr4pLo1tqm0rrXNkRzebpEC0bM1Jntmc7gGgnC7gszwHp1pQP6FLWujEQkZ/qD76zA4HaSrdNLuWgi+9ficQyaKzxuKVV4exFjGgk++s5sbSBTm/vrJOHOkfjHn/1xl6mqtF0bSttzrjjHZf/UaMUDRkQn52rKOjzGbg2ceq0Mbg5xReqCG8k7TvAImNZZw
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(86362001)(316002)(41300700001)(2906002)(7416002)(40460700003)(5660300002)(8676002)(8936002)(36756003)(40480700001)(478600001)(26005)(356005)(6666004)(82740400003)(7696005)(83380400001)(47076005)(36860700001)(186003)(336012)(2616005)(426003)(4326008)(70206006)(70586007)(110136005)(7636003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:34:09.0046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db99757-2772-4a8d-a82e-08db8f34a619
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
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

Taking advantage of the new iommufd_access_change_ioas_id helper, add an
iommufd_access_replace() API for VFIO emulated pathway to use.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 15 +++++++++++++++
 include/linux/iommufd.h        |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c0b9cd97ec58..4c37eeea2bcd 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -849,6 +849,21 @@ int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
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

