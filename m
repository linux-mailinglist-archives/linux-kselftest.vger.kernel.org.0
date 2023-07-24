Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B727775FFF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGXTrn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGXTre (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 15:47:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E3170E;
        Mon, 24 Jul 2023 12:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcwxfM8PqYQuhw9Wa276pJAgOTxw9VRwzNe5L4fqqbSxchrKUZ5S+5Wu2/T0dZp2gVOOfWJ1g9BCxu9P4aT2IiSgJLU/O2WLxdCC8ixthr5mCt18ENCF6qMM9JPd4YCWjBqfLGZvyGL8fDxMersvjc8L7gYyJryIdRZMoR4G+wI/bxnVc3w08dLit/cFf7WkjeFMbsRD7YcxHhCZu9izRUrOGFwvPdzTeTnH0xhZS/IlY7eHqnjn6kA6RKJJ2wMBUJFUqTyrYcQfO1mXmv+fssBf3O7/SS/I2CeJP891IT+7ZweB9D+I0g89Ibkn9ESI6E9jV1+XG+02QMu38PNH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OJyh4P0FAosTE/a5BOS8AoYsr74+gh9D11uBxGJmJA=;
 b=Fl7YTeSOLLeq2nD+ME6DNtGUzIp0ET7f1cNjqnobssn3A/gdJRXpxOs2iLjsNWdXYOyGD9Eq5IzkmhDuiYhMVz54Jtw/+T7tqc2Q5+RpJJDmNu5tcf/9l27cSI1xQ+LQ7kVWjiPe90UKeeGOne122OY0X0kytvQsLtlg5ijUJwhxK7ojkEfTC1OTmH6t+F7ft2ogqWUG9ZgIeacVSjX/Qf2Zy0tFxVcoP3t/hfYjTCGalYPYuf578r1FBjwCp+8RZoPBpu4p+UGgyaqV5JudVsb6u5KX2koszFd1d5GRV9ZP81FrQpys61PLsrw5Ye/yTondIzU2lVLn3tjaoSOMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OJyh4P0FAosTE/a5BOS8AoYsr74+gh9D11uBxGJmJA=;
 b=Tp7t7Sbns7MZ8QbGxFQG9FjRDz4o8PpJUsZOD8p58R3NVNf/oz2w/qC3rSPQOJTA1vhWIE2caw7My4UftUDzhaBOCOXc7J+Q6AaRpxwfRyHPUgVnbyCqg/fAWvDaFrSYbwMcDCuQQ8X9sdaasHxdR7pd1Dln7YsihyEukuJmp3qIF8F6uK4GUmBsLqDK+RDd+lw3TI6PaYf3o1kJcCTrDIXU1Od8jEBihJJoj4KLJipzfAxEWJxgk5NUvwYS95Eh20K2bQMIbc1YVSdkrfXDWdYzGzqABLKaO7t641mMErPNdWise/8FSj0wfRxrD61Nn7JwLQB3DfpsrNxfWa8wfA==
Received: from BN9PR03CA0475.namprd03.prod.outlook.com (2603:10b6:408:139::30)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Mon, 24 Jul
 2023 19:47:27 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::18) by BN9PR03CA0475.outlook.office365.com
 (2603:10b6:408:139::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 19:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:47:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Jul 2023
 12:47:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Jul 2023 12:47:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Jul 2023 12:47:13 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Date:   Mon, 24 Jul 2023 12:47:05 -0700
Message-ID: <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690226015.git.nicolinc@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 65444b85-4f92-47d1-04c0-08db8c7ecf23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJQ5oVZT+Yn6ESpSG9ARiR4nKFVi9NReNsm6AHDrXzSwU93WPoN08wRgKrq/h/aO4VUxUQBchWNsw2OsS63G05WlqPvXcYudq/nf0MULJgoJRdfyr8gf87py7M4BYk4TeCjUDvnKEOOVaB8BY9ey483s5qOjnstdxKBgBp1f4l/QmluMUvva/4+P2u1pZewzj/Dd7Rb1GTp/ybNG7pJzl1utys1cuAI1lDwLo7L8F8W6wyhb5WCHabE81jxjD4NzheLd8DOWMDQxae+hmcHXDZrWIUG856SK9GbRZNO2/G3aag4mLto1Jj2B6edH9zA+PPTlPOonYODcADZTJxcxw63aHI03OPwhrFoFHt8x7WCMvYUdsjO2+T/en85khtGnmWvpT0INuVyr7L4EtjIU8nSkTx0wbXS3j0Z2/zKta31AQ85MtNcyTAcAl1HE1KpEwpEX7dUH5bFhAg4VKC3OJG3M7wqWlsUgWNmA4F+bQVhNCgX5ge+XxPhWHFFepkK/+NRnVPgJ9ZM52qGx8tyUdTbC1ANN03DwJXypQ+KCxsVQs/tkogJtKKm3O1NyhFuMHnROE7DunMdvLYOlJgy9rKyQAuCTosMCCpHr/bUbeq3n7ob3Aa7qS2LmgXTvT3gDlpcQX3g1rR/xqcSNyBBXN3kaiDXNnEo4KZc3rycvYeAFSLcfvb97Zzl/EKREy/wGxNWdm4nP4tvXQ3qeNfXNOf1ZuTMXbCikF2xt3JqRviFjUXOjs+rd2JRXpz0VQR9F
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(426003)(2616005)(316002)(86362001)(26005)(4326008)(47076005)(82740400003)(83380400001)(7696005)(6666004)(7636003)(336012)(186003)(356005)(40460700003)(54906003)(2906002)(478600001)(110136005)(41300700001)(5660300002)(70206006)(70586007)(40480700001)(8936002)(8676002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:47:27.0128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65444b85-4f92-47d1-04c0-08db8c7ecf23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extract all common procedure, between the iommufd_access_attach API and a
new iommufd_access_replace API, to an iommufd_access_change_pt helper. And
separate an unlocked __iommufd_access_detach to use it in the helper too.

This adds a new iommufd_access_replace() for VFIO emulated pathway to use.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 72 ++++++++++++++++++++++++++--------
 include/linux/iommufd.h        |  1 +
 2 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 072912d87f53..1015d6c42e2b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -757,13 +757,11 @@ void iommufd_access_destroy(struct iommufd_access *access)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
 
-void iommufd_access_detach(struct iommufd_access *access)
+static void __iommufd_access_detach(struct iommufd_access *access)
 {
 	struct iommufd_ioas *cur_ioas = access->ioas;
 
-	mutex_lock(&access->ioas_lock);
-	if (WARN_ON(!access->ioas))
-		goto out;
+	lockdep_assert_held(&access->ioas_lock);
 	/*
 	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
 	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
@@ -777,44 +775,86 @@ void iommufd_access_detach(struct iommufd_access *access)
 	}
 	iopt_remove_access(&cur_ioas->iopt, access);
 	refcount_dec(&cur_ioas->obj.users);
+}
+
+void iommufd_access_detach(struct iommufd_access *access)
+{
+	mutex_lock(&access->ioas_lock);
+	if (WARN_ON(!access->ioas))
+		goto out;
+	__iommufd_access_detach(access);
 out:
 	access->ioas_unpin = NULL;
 	mutex_unlock(&access->ioas_lock);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_detach, IOMMUFD);
 
-int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
+static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
 {
+	struct iommufd_ioas *cur_ioas = access->ioas;
 	struct iommufd_ioas *new_ioas;
-	int rc = 0;
+	int rc;
 
-	mutex_lock(&access->ioas_lock);
-	if (WARN_ON(access->ioas || access->ioas_unpin)) {
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
+
+	if (cur_ioas)
+		__iommufd_access_detach(access);
 
 	rc = iopt_add_access(&new_ioas->iopt, access);
 	if (rc) {
-		mutex_unlock(&access->ioas_lock);
 		iommufd_put_object(&new_ioas->obj);
+		if (cur_ioas)
+			WARN_ON(iommufd_access_change_pt(access,
+							 cur_ioas->obj.id));
 		return rc;
 	}
 	iommufd_ref_to_users(&new_ioas->obj);
 
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
+	if (WARN_ON(access->ioas || access->ioas_unpin)) {
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

