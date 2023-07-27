Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338A77648BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjG0Her (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjG0HeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:34:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DFE9EFA;
        Thu, 27 Jul 2023 00:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7d2JH7oDyJ5hcKSlzEfo79nLLoYFOVweL9BP5CNpTMEoYbQrpHLJ9D/KOrcgm+11aDQA94FzETGTWo93116iBgZqe1BUdS2INJIMdE1dlN3AoMGjup2OAhzqCpDeftkv9c33ECXZ/ovesOAqQyVCrkTd+cIzkw/YDajzawxlOP3tTDRaF1u0uBmrG/Ir/L6M8WtjOPY7PrFqeiaZowywJTFnxkjQ0pGKiNCGgINYjqo+E4ZrShucVnjMCZvvef49Zy07XmG9B9vczoRnEhOtgpQ8FEG5DGk7X3WWuy/y2xZr212wmlzb8SNP7IjTQHDc2p8l2DjaaA4OQiiNugrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI8W7sCuSj5bc+j+ehaE6KK4a1jR5fH0hNBwUOnbD/U=;
 b=YGIwa7WDYKmsJ96ienTSSwrxp59oDikfuJYSAN1x7FAflvwMZMqxSo5SiyuLIqJtR6aFz0eHIfBxnmMv3Pq5zTf1IN16g806TNliDpHCeZZOUAhTTve5XbZ0BslwSBrRHmTjEMIC52fhHK4ySxJgozT+rhyAIqii7DrfJey+oGJbHbD4GEUIv9chdXyLntdWaIDLo1U5ELvIOzsHVAN1wRCJym5YhZs8EOj5lBdtuaC3+ARDnchdb9GePqVc8fcIo/JEnR3TTZCftTZS8pHs+T/EMu0rucfcNiK6sVbAdWHqYEob7N4LM3HlNJUTNFv9tx2dzL81zj63DENbqALJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI8W7sCuSj5bc+j+ehaE6KK4a1jR5fH0hNBwUOnbD/U=;
 b=jJUbR9sofenRTBS0rtqresntvVLkehSD3Tm08ldKnrAgmmfp5PgXLixvot4XrCDhMDsc5GnxWOhMD6OmS6ZS3D+QT5wGCnHGOkZQhghpZ6ZnMYBdWsUnWTSSGCBOTPsvxYTAc/Mrl/XYXSahRzpriZDRuPh1o7D+EcHrtEoXqYAZ+8ioOli+W2mLt5h90Ufuws8xWLyPZ9bhAePkrqwnQppAkPIGm157fwrDn45B1Lb1XC3euCB2ig4DBTl7ob997DXSVRMli6utZku31Be2Pm5lYnN0klr4DIyDN8YsI0Ghnxt3jWo5oBYK9jDfIYkAazOYDACudGTUrr+syaQyNw==
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:23:48 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::91) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:23:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:23:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:23:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 00:23:30 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v9 3/6] iommufd: Add iommufd_access_change_ioas helper
Date:   Thu, 27 Jul 2023 00:23:08 -0700
Message-ID: <5d7d275ff12c1c991ac80392b19f1ebf5214177d.1690440730.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690440730.git.nicolinc@nvidia.com>
References: <cover.1690440730.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e2367d-5063-47f0-9c6f-08db8e726b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsNwwzPGJPWOEfSiQgT39JohCDQ4uR+IrNoM9wS+hCTT6CRGHsKAYZe4x4xOafepwOh/zHNqPEbAa9AINqMjNV02CIIV31GIg5vh3EYWWhnrenFpmxXVGMSBN+wVzeznV3O3nuaJfdES3igN9Dbey5Yme1JO5o9VLcH1GM2SLKcbKnDiRbQNrmxdpGxja5RCCjwyaCwmsYtOWXldlmI2qW5GGtPECzrhnDsx1wB6xcSpkIScqY9W7XyyqY6VqIPsiNinHxhTb0qAoUN+oOzMHItBzGZnPzThTLcExG91Au5BqjHksnsyD7oZCWklW+TlW6a0DkpMJBfFw0IrCqkYNPg253drhSzalksC2bp7pzRH6f/tycZzYAusDlZ8/0RVhOm/vBqvan0RdkwsDrosZZ/kuxCQSS1qbnDjDhkP4j0qsVeD4gsszukdFvc9dJBmJsTq6hVpb3iTtw2tHOuM9pD4BZ2Moxz6tbexvhGkKJ5OGPYMz1T4EWeFnWb+uq2EgumiSKPAHwTEU41N+cUrAgeKquNLtKrqFTaYDJ6zVF6soRCa58+QWP8SWLNLB7qaJaG3tnAT50fj4il7lv60uC2t3c80dCX33Xq8/5f9oulzODS4UNKrf2lUck8PKu4uhG68H7N7hRmu1nui1tn9CH2jsNpnOKVs6I6J4hx07ywtP/JNSPGpSxtPd42nED5e67t4h4AaX7qjcY3eFTd/uG/ncpdfi00b9ceY2yYvrZ3swr5xyIPC3yY6KCey6MQX
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(7696005)(2616005)(26005)(6666004)(478600001)(356005)(82740400003)(110136005)(54906003)(7636003)(186003)(336012)(426003)(4326008)(83380400001)(36860700001)(47076005)(70206006)(70586007)(5660300002)(8936002)(8676002)(7416002)(40460700003)(2906002)(41300700001)(316002)(86362001)(40480700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:23:47.6179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e2367d-5063-47f0-9c6f-08db8e726b16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The complication of the mutex and refcount will be amplified after we
introduce the replace support for access. So, add a preparatory change
of a constitutive helper iommufd_access_change_ioas(), to take care of
the existing iommufd_access_attach() and iommufd_access_detach().

Also, update the unprotect routine in iommufd_access_destroy_object()
to calling the new iommufd_access_change_ioas() helper.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 112 ++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7a3e8660b902..d9680a247e1c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -684,17 +684,69 @@ void iommufd_device_detach(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
 
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
+	if (cur_ioas == new_ioas) {
+		/* Do not forget to put since we allow a duplication */
+		iommufd_put_object(&new_ioas->obj);
+		return 0;
+	}
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
+			iommufd_put_object(&new_ioas->obj);
+			access->ioas = cur_ioas;
+			return rc;
+		}
+		iommufd_ref_to_users(&new_ioas->obj);
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
 
@@ -761,60 +813,34 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
 
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
+	struct iommufd_ctx *ictx = access->ictx;
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
+	rc = iommufd_access_change_ioas(access,
+					iommufd_get_ioas(ictx, ioas_id));
 	mutex_unlock(&access->ioas_lock);
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, IOMMUFD);
 
-- 
2.41.0

