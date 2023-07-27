Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F72C765D3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjG0UZO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjG0UZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:25:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB426BB;
        Thu, 27 Jul 2023 13:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1v8TmRkgu0PWYbirConEIUWTnsL3dEW6dqfZGH3TGN/31n7xhim3YhOe08Ez+/VnH1oI2wx0qHmwG1DttYeJ7/8lu77QPaSSwtvOH1/BUu/Et4MT1CDg2+++abL+fq8f4swRBjfceLgi04QVxd3ZZxqsMnoffCHUGlhuUrjxf6nO9oY4g0NVNIwsd8zR36G1mH94L0o8VpRqYcIUbhWLc9WWu2bJEUDUUc7GsRh0K/XXf8Kv7sitmPz+89tdDsk4X6NShar4HLeMe6gYFbYefDgHP6DJyPn+yA+NnzwG72TnXXDCWvE0EJ8oXwevRxUZtY7YxoYuqGq/QlsU/MUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U990fYf0Hw3SvVRrGVhQXCO0f1RQgDu6SqzDq2bdnoU=;
 b=gSynDAfpS6PyVEvXk9IHI2V3Xw3vo20T1eBDk+GH16bhOH3OOb1VnGIxhAQNRPPVslXmQiv/jM+sTEKTsix7PUWmTN66MiLI2T7BBybmLZP69V7mO9GcDbXVVRjKiaUqEb1U5Y8S8a+Hmqt1YX5656yPjUm8TQfyo97eKjtvqF44ffowwVZO/debXNwGkwp3EvIVUwWWs8voSCiydLKTHu6aqsaLFtcSJLd4/AlZ3vSyEV1eDSsGOi8Fb5X5Np+8uFm23yq24gNdwdJG7JqGbe1Dfg86rLUIgAE+Tle3jw+wiO3KWcNjYk+4ziR1b+0VsU9iKwe/2l2f917WkpicIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U990fYf0Hw3SvVRrGVhQXCO0f1RQgDu6SqzDq2bdnoU=;
 b=m2RiFApaRz3PYAgOvzgY0AhB+FIbg/S2LLmosd3Md3jM3vjXgMH9vZb2gIXPsIe1ZdsSEv/pfn4C9PKEIOnVyG3c/f2zqjZr9efHz2tV42ECGTsUQB3rV8lk5hL6opfXdgfyCiCtGLzWczIsWyP7BWtvx/xojCvHtrbE/T1uX/o5jR9ooSYc18X2Xu6mfGypGYfX0MV5hOFgJheptz5EFiVy4RenNVrbNSI14uwYZNGAHTEhoIfKwJTLq1gIWHwQQKYCM13yBcapSFXqP/AAE81pPKBiHC9GUkcRAcTd+Tpx5RUHLijbNZyt9Hr61CmKfeEjvzB6ebfsiMZV7PU3tQ==
Received: from MW4P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::17)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 20:25:07 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2a) by MW4P221CA0012.outlook.office365.com
 (2603:10b6:303:8b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 20:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 20:25:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 13:24:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 13:24:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 13:24:50 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v10 3/6] iommufd: Add iommufd_access_change_ioas(_id) helpers
Date:   Thu, 27 Jul 2023 13:24:34 -0700
Message-ID: <ad75a1f7f0b4d5b6d35238b4ae7b41db1410110c.1690488745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690488745.git.nicolinc@nvidia.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: b804c77b-0b56-4574-e2e7-08db8edf91b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aA5GDSldGyUkisf1TDtph7eazgFOfdBH10L9MZLF93BXvtePYs8vPLsFAvfLk0XDZQ7lv67BaY64iMaQVpndgbEdjTRShLptL6jf+wkcHI7zBdfYOErL9y9PJv5AupDfXM/pLhFlEPtMA/XkP/1ur/BZw6YXXjJovODp9PP8CwQbZDBFDoLF0BprJ8XUdBc2P3UBsmdsGGKJKx8emHErQfBVQUrspBOuJrCk0QhacrtCaRrnnknJ5CzvRLCFqVvcL54cSu+1ucClKmFT+xuWJVTx9VAqVKkjRWfWiFWBeq0MZl0L8+RFkoHLUX+o4b3N8/7BADC59S4igctS/Utb+5WQaFi60Q/qAvizrYZugCibhPHnTv2HjkshH234RpaCUL3lIiSaycX7rp7efIfqc4va/XA0i/fL74Bq0FZDlBpeQMaMZw+x5SEpMP0vSjegcVh5VZuO/j8ovnkEum07ifbJGBgx++qixunin1jYSAVZ5Ut1wy7PI+1DqKy4DT7Qt9wBWjPr6JqWP4ucG27tv/u1soFXBe8GLPL/iugcqdnZ58xbC19kzJSJ+hYm5lJRugJMZYep4MsUT0UYXyoPfa06nvRVTgt79dNytxwKC6dJy7ZgQL3IQN5u4tck1bnX6DRU+0g4PbDZp6yq7g7H3vRSfWGE1d59mLRsaArpvEGE7oH4eVk//knMS1lss3sm8idchMo4b4ublRA8dhwVkgZngdn/G3kmHL2xSPJisXRXznpBiIuG15wMmKYoMSKj
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(86362001)(316002)(41300700001)(2906002)(7416002)(40460700003)(5660300002)(8676002)(8936002)(36756003)(40480700001)(26005)(478600001)(356005)(82740400003)(6666004)(7696005)(83380400001)(47076005)(36860700001)(186003)(336012)(2616005)(426003)(4326008)(70206006)(70586007)(110136005)(7636003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:25:07.4765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b804c77b-0b56-4574-e2e7-08db8edf91b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The complication of the mutex and refcount will be amplified after we
introduce the replace support for access. So, add a preparatory change
of a constitutive helper iommufd_access_change_ioas() and its wrapper
iommufd_access_change_ioas_id(). They can simply take care of existing
iommufd_access_attach() and iommufd_access_detach(), with a less risk
of race condition.

Also, update the unprotect routine in iommufd_access_destroy_object()
to calling the new iommufd_access_change_ioas() helper.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 123 +++++++++++++++++++++------------
 1 file changed, 80 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7a3e8660b902..e79cbedd8626 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -684,17 +684,82 @@ void iommufd_device_detach(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
 
+/*
+ * On success, it will refcount_inc() at a valid new_ioas and refcount_dec() at
+ * a valid cur_ioas (access->ioas). A caller passing in a valid new_ioas should
+ * call iommufd_put_object() if it does an iommufd_get_object() for a new_ioas.
+ */
+static int iommufd_access_change_ioas(struct iommufd_access *access,
+				      struct iommufd_ioas *new_ioas)
+{
+	u32 iopt_access_list_id = access->iopt_access_list_id;
+	struct iommufd_ioas *cur_ioas = access->ioas;
+	int rc;
+
+	lockdep_assert_held(&access->ioas_lock);
+
+	/* We are racing with a concurrent detach, bail */
+	if (cur_ioas != access->ioas_unpin)
+		return -EBUSY;
+
+	if (IS_ERR(new_ioas))
+		return PTR_ERR(new_ioas);
+
+	if (cur_ioas == new_ioas)
+		return 0;
+
+	/*
+	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
+	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
+	 */
+	access->ioas = NULL;
+
+	if (new_ioas) {
+		rc = iopt_add_access(&new_ioas->iopt, access);
+		if (rc) {
+			access->ioas = cur_ioas;
+			return rc;
+		}
+		refcount_inc(&new_ioas->obj.users);
+	}
+
+	if (cur_ioas) {
+		if (access->ops->unmap) {
+			mutex_unlock(&access->ioas_lock);
+			access->ops->unmap(access->data, 0, ULONG_MAX);
+			mutex_lock(&access->ioas_lock);
+		}
+		iopt_remove_access(&cur_ioas->iopt, access, iopt_access_list_id);
+		refcount_dec(&cur_ioas->obj.users);
+	}
+
+	access->ioas = new_ioas;
+	access->ioas_unpin = new_ioas;
+
+	return 0;
+}
+
+static int iommufd_access_change_ioas_id(struct iommufd_access *access, u32 id)
+{
+	struct iommufd_ioas *ioas = iommufd_get_ioas(access->ictx, id);
+	int rc;
+
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+	rc = iommufd_access_change_ioas(access, ioas);
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
 void iommufd_access_destroy_object(struct iommufd_object *obj)
 {
 	struct iommufd_access *access =
 		container_of(obj, struct iommufd_access, obj);
 
-	if (access->ioas) {
-		iopt_remove_access(&access->ioas->iopt, access,
-				   access->iopt_access_list_id);
-		refcount_dec(&access->ioas->obj.users);
-		access->ioas = NULL;
-	}
+	mutex_lock(&access->ioas_lock);
+	if (access->ioas)
+		WARN_ON(iommufd_access_change_ioas(access, NULL));
+	mutex_unlock(&access->ioas_lock);
 	iommufd_ctx_put(access->ictx);
 }
 
@@ -761,60 +826,32 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
 
 void iommufd_access_detach(struct iommufd_access *access)
 {
-	struct iommufd_ioas *cur_ioas = access->ioas;
+	int rc;
 
 	mutex_lock(&access->ioas_lock);
-	if (WARN_ON(!access->ioas))
-		goto out;
-	/*
-	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
-	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
-	 */
-	access->ioas = NULL;
-
-	if (access->ops->unmap) {
+	if (WARN_ON(!access->ioas)) {
 		mutex_unlock(&access->ioas_lock);
-		access->ops->unmap(access->data, 0, ULONG_MAX);
-		mutex_lock(&access->ioas_lock);
+		return;
 	}
-	iopt_remove_access(&cur_ioas->iopt, access,
-			   access->iopt_access_list_id);
-	refcount_dec(&cur_ioas->obj.users);
-out:
-	access->ioas_unpin = NULL;
+	rc = iommufd_access_change_ioas(access, NULL);
+	WARN_ON(rc);
 	mutex_unlock(&access->ioas_lock);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_detach, IOMMUFD);
 
 int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
 {
-	struct iommufd_ioas *new_ioas;
-	int rc = 0;
+	int rc;
 
 	mutex_lock(&access->ioas_lock);
-	if (WARN_ON(access->ioas || access->ioas_unpin)) {
+	if (WARN_ON(access->ioas)) {
 		mutex_unlock(&access->ioas_lock);
 		return -EINVAL;
 	}
 
-	new_ioas = iommufd_get_ioas(access->ictx, ioas_id);
-	if (IS_ERR(new_ioas)) {
-		mutex_unlock(&access->ioas_lock);
-		return PTR_ERR(new_ioas);
-	}
-
-	rc = iopt_add_access(&new_ioas->iopt, access);
-	if (rc) {
-		mutex_unlock(&access->ioas_lock);
-		iommufd_put_object(&new_ioas->obj);
-		return rc;
-	}
-	iommufd_ref_to_users(&new_ioas->obj);
-
-	access->ioas = new_ioas;
-	access->ioas_unpin = new_ioas;
+	rc = iommufd_access_change_ioas_id(access, ioas_id);
 	mutex_unlock(&access->ioas_lock);
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, IOMMUFD);
 
-- 
2.41.0

