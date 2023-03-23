Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441756C61C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjCWIeK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCWIdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:33:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F26E39C;
        Thu, 23 Mar 2023 01:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxjDQtJFi3CVtA4ELS9Th0p7Zs8Savf9VrrfS4fxOMp1QMm/cgwseH0PWO8QW+rZwmQNuGpUoZ+cBV+Fio27818Yu3AL2ka5ncSSM9r/ZIeD5rZHY4TUtM4i1uYUTi1GfYqXM1jhHjfL14S7f8vxs+CEOOlkIkwDEF3YbKqyoEI3/kvwQoqtXbAB6LViO/aKegNqmI5Un8w6ZC/rMV8YtgpKnQGSEhfDX4ozqtLnC59UwO91cV72XHOMvR6lrTtC74XiUD37GdJ90x4vRfc1fUZ38RU8V/koKx1tX+RwC+28qTwveqdHBk+bKXlp3mz/sn0sSSiEYfa906MA16/Hfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPC1QRJtNYeYfwMILSbEoejTgiHZH9D/NLYMZO1NuWo=;
 b=C4xMivCWDR+T8DP7qMzRNkCk83QsasgMwv0+m2MNV2/WwLfT7niQ3brxbFkObjDXUBkniRCgMHOg4yNcnjwtXjZKbU0feVa0YWN4D9MMOjKOpznKK2cGKKLMz00ozWsytWTSqk+O8fiRLE2udDnzZjEDlnC0v/SgcaBS9KdAzsdmT49odpZgvqkyTj6zKsuRgSZInMo7LGgxszVInzLI3WAwEFoKymo4pjFhow8uMk5/BIUmvAZkuMyToiiHMZo8SbPD/6WdUc3gs6V3ZjAsxnBK2VT7VQd+Ijd/C5MdKbloEMmEx4PgA9pu5GYrTd7NTTbvV/oUT/wQD1xotT0zHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPC1QRJtNYeYfwMILSbEoejTgiHZH9D/NLYMZO1NuWo=;
 b=gBx8oR1nXGdpT38b4X2hZi8YoQFdgt00miSPRCX9ZpTg4Rj0SzfB4/nNBdlPpBp3WwR5QsinTMXyGQ6IaJ6RSIIPbcfuYbE0SWhvm8qaWTm7ihKoPfovEX7IeHRaKI506tSoSfC5aFF34uTss1yfH2CttDijYrs2RpvMkYBWhOOlS4Ip2rHeA9E4WEk4Kkmzy0DEg+N2LD8Wcj97JYqVdh1/U54gtbzQIEvo8FAHsEZuFaHRNK9p3+5W4MOoZw9Df7D74hO/JB3+0MTojvMbWZIdHeFIjVeOU33JOcwEyHvKMX+nuQKnOiYahUFmOZti+1CxvJff3O2Mk4PPJwvFBA==
Received: from BN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:ee::34)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:33:40 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::82) by BN0PR04CA0029.outlook.office365.com
 (2603:10b6:408:ee::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 08:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 08:33:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 01:33:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 01:33:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Thu, 23 Mar 2023 01:33:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v5 2/4] iommufd: Add iommufd_access_replace() API
Date:   Thu, 23 Mar 2023 01:33:03 -0700
Message-ID: <2c3fa7a21373ee10af7cc9f8c370945a08341930.1679559476.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1679559476.git.nicolinc@nvidia.com>
References: <cover.1679559476.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca4b91d-4cc0-4782-7157-08db2b794ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMkGEi7ut4fo4tUukxjqjxWH4q1oWnCKVixJ1kxDT8yvlXKeaCyAXVxjtPl2lBYn6BkMzt6wjdRTZ4TdevD5xkQKsUf301SsO3BPK06yP3Eoi/TndWjAYujLSe0IAEFKOIN2VrMdjEla1wjoaHlPBcHiTDiwTELQKVuK5Wtq16Dx10JnkpQx5BRM2aJEFfCuGKt3MP1jwS00UmKf1fKDt0VdgvlkVf39HvbWuYELleKQP7PADG+63jA5RIdEkkk3DR1a1NBUtgsdyrECPPxu+o4ksqyM6sYpbbejm+7i++hqXxB1FpR0edDXEhzbw39PEDXqnDvWAxNlAGaHeRGK4nQjm5ORIj4ulSmxjoAZJmpHz4UY15HDpHKcfE/111vM/6XAP+/fijHxpDw93otqNbA9T7rDCkxadN6idVBi5N7acVjTDGKXkk4SCAfnl9eutqXkTmdJNNJbrCTE9BnjR7LJdc7LYhx4w66zNw1RFSJFuw87vcmR+6w4FbbGG/7qDy23rOw2hGf2ruLmSTgPUEKGM36XdnLdfeY9kys6yjmx1sW/fpbXFWpGu+ckAr/PyWKWCsxDUKxvCVZ/clIAw4EZymy8ueNcTAtgd8ojI1ci82lfWdG5CxlVGhBguFPgMd5RnBrl5Bh5f8d/N1i+e+9zRPwflXioFHpTZhomcDFwkhCTuwm04s+VV+9iOIefNNp0SGHjvcSpChjLDpe3JORzsuk8QJOSt7OoOU3C3XilBoHce7fhwAWPs6ODmeRe
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(426003)(186003)(6666004)(7696005)(336012)(478600001)(26005)(83380400001)(8676002)(2616005)(110136005)(316002)(70586007)(70206006)(54906003)(7636003)(8936002)(5660300002)(40480700001)(41300700001)(7416002)(82740400003)(36860700001)(4326008)(2906002)(40460700003)(356005)(86362001)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:33:39.7640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca4b91d-4cc0-4782-7157-08db2b794ddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 60 ++++++++++++++++++++-----
 include/linux/iommufd.h                 |  1 +
 tools/testing/selftests/iommu/iommfd*.c |  0
 3 files changed, 50 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/iommu/iommfd*.c

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 012e85fc6d77..3b39b76fbc3b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -746,39 +746,77 @@ void iommufd_access_detach(struct iommufd_access *access)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_detach, IOMMUFD);
 
-int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
+static struct iommufd_ioas *
+iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
 {
 	struct iommufd_ioas *new_ioas;
 	struct iommufd_object *obj;
 	int rc = 0;
 
+	lockdep_assert_held(&access->ioas_lock);
+
+	obj = iommufd_get_object(access->ictx, ioas_id, IOMMUFD_OBJ_IOAS);
+	if (IS_ERR(obj))
+		return (struct iommufd_ioas *)obj;
+	new_ioas = container_of(obj, struct iommufd_ioas, obj);
+
+	rc = iopt_add_access(&new_ioas->iopt, access);
+	if (rc) {
+		iommufd_put_object(obj);
+		return ERR_PTR(rc);
+	}
+	iommufd_ref_to_users(obj);
+	return new_ioas;
+}
+
+int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
+{
+	struct iommufd_ioas *new_ioas;
+
 	mutex_lock(&access->ioas_lock);
 	if (access->ioas != NULL && access->ioas->obj.id != ioas_id) {
 		mutex_unlock(&access->ioas_lock);
 		return -EINVAL;
 	}
 
-	obj = iommufd_get_object(access->ictx, ioas_id, IOMMUFD_OBJ_IOAS);
-	if (IS_ERR(obj)) {
+	new_ioas = iommufd_access_change_pt(access, ioas_id);
+	if (IS_ERR(new_ioas)) {
 		mutex_unlock(&access->ioas_lock);
-		return PTR_ERR(obj);
+		return PTR_ERR(new_ioas);
 	}
-	new_ioas = container_of(obj, struct iommufd_ioas, obj);
+	access->ioas = new_ioas;
+	access->ioas_unpin = new_ioas;
+	mutex_unlock(&access->ioas_lock);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, IOMMUFD);
 
-	rc = iopt_add_access(&new_ioas->iopt, access);
-	if (rc) {
+int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
+{
+	struct iommufd_ioas *new_ioas;
+
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
 		mutex_unlock(&access->ioas_lock);
-		iommufd_put_object(obj);
-		return rc;
+		return -ENOENT;
+	}
+	if (access->ioas->obj.id == ioas_id) {
+		mutex_unlock(&access->ioas_lock);
+		return 0;
 	}
-	iommufd_ref_to_users(obj);
 
+	new_ioas = iommufd_access_change_pt(access, ioas_id);
+	if (IS_ERR(new_ioas)) {
+		mutex_unlock(&access->ioas_lock);
+		return PTR_ERR(new_ioas);
+	}
+	__iommufd_access_detach(access);
 	access->ioas = new_ioas;
 	access->ioas_unpin = new_ioas;
 	mutex_unlock(&access->ioas_lock);
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, IOMMUFD);
+EXPORT_SYMBOL_NS_GPL(iommufd_access_replace, IOMMUFD);
 
 /**
  * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 7c79f9b33246..cd7ae5a625fc 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -46,6 +46,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 		      const struct iommufd_access_ops *ops, void *data, u32 *id);
 void iommufd_access_destroy(struct iommufd_access *access);
 int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id);
+int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id);
 void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
diff --git a/tools/testing/selftests/iommu/iommfd*.c b/tools/testing/selftests/iommu/iommfd*.c
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.40.0

