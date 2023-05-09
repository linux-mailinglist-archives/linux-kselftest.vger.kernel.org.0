Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755B6FBE5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 06:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjEIEpC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 00:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjEIEpB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 00:45:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD776B9;
        Mon,  8 May 2023 21:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuBIOPaxwcXWLY9mnJKn6jd90EbWO1FFWcMTdxHt/jNFeP9tOgLaZdGYpmPFU37pYgFZXSJ4siVQCS/ihJnhvtHx3ZlgwonAE1NfhlsThMbeBWhLDixd6HFebsc3ZlKmhAeLHmfx0DHybN7WAVWEfRaMaaXQr+q15b2YseZSdan18Qom/Uv/RoscgDkkNXJrW/JMhGA2L4Ng5qzfFNjSqCLiNfW+ttOECLfCUBnXitwAyS2hoQJQjBUEtvqYdn6f5hCyuvvFlwPE+F+QPJdX1KPCKV2yZ/TtBD/fLhOck6fKc5OcE0x0sF9mj+Pg5ZNEv8S6/l3jJH2BRGS2zTK9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VylF40GMOWMB9o+Fkn70R7R+ggYRkXjNRln4dD5h9t4=;
 b=ah8XQR74JbF6SO1FPrlDbe6NQUN2NCZ3+N6/ZRnIoAgjc/Rxhz4vHnSyUGoeBLhrjgkPJlGf66pjTa6g988I5LajkWVJFIK/H3XP4xyVtEfcpTvRhhKd/xLyNoqNQsVQRptvnpBV/DwtCXkuEC8fJEHD3envGSJ79B0IRPb9IMwCnUY7LXwiH2LTEQLkJsWL3o7YRoVK0VCPqkPILGGmmr1N8xjV6RbJSkfiOadVoBmE9TNLveXiv4CSlbOzoaDoeJAAze1kM2DyRK7ENO4GHCYXE7mErC7/vgzsEQJeNFckoDtu9SQjb3nnPC4zNN+0+EVNuzavGlJxxpVjkeBkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VylF40GMOWMB9o+Fkn70R7R+ggYRkXjNRln4dD5h9t4=;
 b=KXmGB59ABNZwJhS+Ujj2LajE7kdX1BY3zbOuTJAxWKE+4uEk+6rH3mHfNPg3WtFgz7+SzX6IKx9FyLt46mbLwXToq6jEwK96E5H8Z0/afNXyaSmoIF+DeJpnIJUpI5BDer+V25mMLZVRghNhK80/1u7j8foocySaVYjQjVR741yPa+2I6wTNcZuXiySPLx+KY6AqBeH4/DVQeJcXvg2fusiPV2xh18snH7J6vtBjTxz/S2BBq23jzr2sYp3Uf4L/8GFFFKJ7Yhu1f7K0RC14z3l6oyQNXis9D/DpYkGN9LnfnHnPhTeRREvgWZh/8lGinHd2ZXyareExsi5IvqignA==
Received: from BN0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:e7::11)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 04:44:57 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7::4) by BN0PR03CA0036.outlook.office365.com
 (2603:10b6:408:e7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 04:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:44:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:44:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 8 May 2023 21:44:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:44:42 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v7 2/4] iommufd: Add iommufd_access_replace() API
Date:   Mon, 8 May 2023 21:44:12 -0700
Message-ID: <86a2a1476dc02a0179a3f6d700910fdbf6a9c078.1683593831.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683593831.git.nicolinc@nvidia.com>
References: <cover.1683593831.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: e077b1d1-f866-4711-d003-08db50482321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRgU8CF3KUqJFr7gYPYNF+Le8/nEiMKFAbMIsghKalzPZh3g1TEPR+Y2hSkllj4IVp8xpUGQrjICP0kORNS0Z9fHSuUcE1F+JG4eTTVH1IwZOPDrj68ZGVjeFQq/1nvqLMsDco/z13Qh3PTCDv6RoxxJIZgCfr7UhuL7GDyecf7LEGof/rjv4z0ekp+dhl4/DRyUlwODcBO+rzHRrzotPQrquMX6JTfQWcT9zBnu2GzGCGfuz35wxMjtAinSAakMyinTH9NWfJ+qxaVRnl/4wMOgwGl6A6Fccz4WxwamWS2jQa7KypGsJmVWJ7OKZcvzfxImRpH3zuLA7F6AjfoLhmIQR5K9H7rr1o/NMEN0P1BJZueEQPaNax0aMXntXdDthRpcKMj/KkqBr02GxS+5qHLL3kT4Fa0Ca7sw2SQoD9jYIgbE3Ph3b6c7ysoIMQwWm0K+akFc6c3cJB9ZTE45j4FCyzTE5VSC5cT4ZJ30KPRet1VbkCSpTXrUo7AG3wmA/THABtC4p3D5PP5YnXbd5C1Xv9EbVtztmwQHWXT28CDwA0A6MSj8k1vfaoQZWuexUE5JQcsYyvJk5j3m1FJuuiTtFqMS4PHNZwyrvsE3OtonC5KRXmCnAX9zcP1yd9ua32Enn8lHk2SITqAfeDvsOpDfmsOyeOpcF+Be7fz6ZeuLIcXXS2bkRV0vxKss4z2MhUH7qcUTNus5YaYN9ygeMQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(86362001)(47076005)(54906003)(110136005)(316002)(4326008)(70586007)(478600001)(70206006)(7696005)(40480700001)(82310400005)(8676002)(41300700001)(5660300002)(8936002)(2906002)(7416002)(186003)(82740400003)(7636003)(356005)(336012)(2616005)(36860700001)(26005)(426003)(83380400001)(6666004)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:44:55.8155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e077b1d1-f866-4711-d003-08db50482321
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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

Extract all common procedure, between the iommufd_access_attach() API and
the new iommufd_access_replace() API, to an iommufd_access_change_pt()
helper.

Add iommufd_access_replace() function for VFIO emulated pathway to use.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 53 ++++++++++++++++++++++++++--------
 include/linux/iommufd.h        |  1 +
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 989bd485f92f..051bd8e99858 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -769,38 +769,67 @@ void iommufd_access_detach(struct iommufd_access *access)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_detach, IOMMUFD);
 
-int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
+static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
 {
 	struct iommufd_ioas *new_ioas;
-	int rc = 0;
+	int rc;
 
-	mutex_lock(&access->ioas_lock);
-	if (access->ioas) {
-		mutex_unlock(&access->ioas_lock);
-		return -EINVAL;
-	}
+	lockdep_assert_held(&access->ioas_lock);
 
 	new_ioas = iommufd_get_ioas(access->ictx, ioas_id);
-	if (IS_ERR(new_ioas)) {
-		mutex_unlock(&access->ioas_lock);
+	if (IS_ERR(new_ioas))
 		return PTR_ERR(new_ioas);
-	}
 
 	rc = iopt_add_access(&new_ioas->iopt, access);
 	if (rc) {
-		mutex_unlock(&access->ioas_lock);
 		iommufd_put_object(&new_ioas->obj);
 		return rc;
 	}
 	iommufd_ref_to_users(&new_ioas->obj);
 
+	if (access->ioas)
+		__iommufd_access_detach(access);
 	access->ioas = new_ioas;
 	access->ioas_unpin = new_ioas;
-	mutex_unlock(&access->ioas_lock);
 	return 0;
 }
+
+int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
+{
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return -EINVAL;
+	}
+
+	rc = iommufd_access_change_pt(access, ioas_id);
+	mutex_unlock(&access->ioas_lock);
+	return rc;
+}
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
+	if (access->ioas->obj.id == ioas_id) {
+		mutex_unlock(&access->ioas_lock);
+		return 0;
+	}
+
+	rc = iommufd_access_change_pt(access, ioas_id);
+	mutex_unlock(&access->ioas_lock);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_replace, IOMMUFD);
+
 /**
  * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
  * @iopt: iopt to work on
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index d25fbd3a80b1..ea3e704dde8d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -48,6 +48,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 		      const struct iommufd_access_ops *ops, void *data, u32 *id);
 void iommufd_access_destroy(struct iommufd_access *access);
 int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id);
+int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id);
 void iommufd_access_detach(struct iommufd_access *access);
 
 struct iommufd_ctx *iommufd_access_to_ictx(struct iommufd_access *access);
-- 
2.40.1

