Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E060E766424
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjG1GeM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjG1GeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F130E2;
        Thu, 27 Jul 2023 23:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuxtOZWTzAfWm/TxTJNi41fid7yVKYC0jQcPzgeDIji/NG5V+L/AIlxg+DAX0QQc97OLXV6egwaBP2UJZS7LeUiH/eLfdr9jDOmH8taaTalIL3tIWEbIX/uglx8atYY9i5eSHq9Te3lRAMXTfbpmweyzVCQurc6RLYGAC6ftWaoHW4G/w+rIspno/H5Le6t4lyoJCCggGqDxobvYH3F9PoJGMIlBG6GaasH3E0UocLvuMLL8DYJD4t0Fp1PAcYySWz2U6GSnEoeMX48USAwnMBulfAIVOInt1uyKDinuJ2XFjN/PYLjBzNPzMbSK1PE5RzbmwcE0FMD69YiIfWVRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNd52/j9hQXL34viq7rGBWbItOz239GEoAU2sGAsvwo=;
 b=h1D9AdFmPpXLbfGkPE5vuGXxftJXhhjhof2GM6oCmkonw6C5Aj8dQp6WsIloLO6+WIKzEb+8JpL6fqnZG1Q1cmuXfn6lPnsjwb4Zia+Wc+oYavfAMgxdTljMV+uZfWMA2RcPmU6T/FeVz/bVvoConnLxHpy22IP2fl8hhxSOA07eR+Pbr+MiI+BjAfLy/8wmKC8ISP8dflsKYcrFYfgj7VDkTlyRW7PtpNLHi7hdlYVtIz5QXjjH1fRTxb4mdKeiY80a0MtNiLnvj7LnyzXUiTZqsvD1BGFOcQzBNTckFWZiCnASXbLdM+kPNFFPhGEJmE/tpiw6UuHqyGYKfz17ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNd52/j9hQXL34viq7rGBWbItOz239GEoAU2sGAsvwo=;
 b=A2fiTvIRv1QgJDVlNzNBvuj49123sHgDOveKaNJmTvmXcY81tbHw7DrRO7XdnFNkNYsYqTTzoETmUiWTXfUphos8yFK9DJ7a+lA5Rq4MlxGVSvRbD+KrOP9uoJuISzEa/3fgf9h3e21VbnuzXw8eq4eZnRteOcZT297+uMlbU9ucehDEjXoqPlvHKsoJx//glY2ONPTaVLyaQWQSnsIQNLXhCkoy8A5dtvMEL8fLe0H8ouZWDhcBubU0JZg5IZst9UpGEIMapfH2xXz1SnFSnMZVIxi7AXms3W4rfn1vpjyDQ3DxnEAWkuHEtqRWt6Sx8TGR64m4zq/bEh1PDKJJOg==
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:34:07 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::a5) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 06:34:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 23:33:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 23:33:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 23:33:54 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v11 3/7] iommufd: Add iommufd_access_change_ioas(_id) helpers
Date:   Thu, 27 Jul 2023 23:33:25 -0700
Message-ID: <da0c462532193b447329c4eb975a596f47e49b70.1690523699.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690523699.git.nicolinc@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcca52a-0a14-483d-c1d4-08db8f34a4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhdwBcGtaNhwAaXCLnPBJU2/N5nrOxmbP870BMr6R3DeWrQKmORyTwGIEpfAlJAc1F8CaNn5nam/Y7UajDWalnBcO0bVkfX1w83QoBqBRx2BznsE86t+9ef0rLTmKVM1dTjV+3uli4a4RwUXl+GEztdl1vNFS5PJpguzFlL2VZ+yUkMrsFc24JbEBFjMqAco8QxLz+llBkigEWZ3pSbl4/oJ4h7RMfAvjVL1353KOv9TtMbt/vtDNvo2Wgi2jsbqPEfS5tUZjPCc46B1POXsWGPFUahUnIbKooT153Cj/Nk7WSuquE9+h+nnkhIG5Ac6JHDSIXHsUEdadgAcJ/OPA3Bsaa0nO0O/XILittyaFTd+ogCtF5dj9vewZn3G6vi9tDsSWyKvWXS0XDzzUu2DaIjSZB7m+uMRlWcMpJufBdmH/4XVAqmeF/iSbpAtiO610EBlho63oxvnvP5aR9pLfiovSYtqXSD12y317PRDlrOxJQWLGmyjRd73XC0uzI9ZgxLTxYXtemd62ovoBtk2RTvzwdToOraolVuhY6BFi2yh+ABJqWfCiZ/70SGs4jMs42oCalrteSdCN6O+KsOriqUJmR2I70apLYc89NtWxjdR5fYPwFlq6mTamFUrmPGpjNEoxgDGXRw2y0xToOYP/PTT5uHCyF5au+JGAZy8RP0OMNdjKbuxaIjTm1RpX5pstkxlcxV+6skMnWxRzW0PMjwxVfF+bcE/9bNgfxgtbjVvlOFbWiN3akbvubmqpaCc
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(316002)(8936002)(8676002)(7416002)(5660300002)(86362001)(41300700001)(40460700003)(36756003)(40480700001)(26005)(82740400003)(478600001)(356005)(6666004)(7696005)(47076005)(83380400001)(36860700001)(336012)(426003)(186003)(2616005)(4326008)(70586007)(70206006)(110136005)(54906003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:34:07.1415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcca52a-0a14-483d-c1d4-08db8f34a4ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
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

The complication of the mutex and refcount will be amplified after we
introduce the replace support for access. So, add a preparatory change
of a constitutive helper iommufd_access_change_ioas() and its wrapper
iommufd_access_change_ioas_id(). They can simply take care of existing
iommufd_access_attach() and iommufd_access_detach(), with a less risk
of race condition.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 109 +++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7a3e8660b902..e5c408415e95 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -684,6 +684,70 @@ void iommufd_device_detach(struct iommufd_device *idev)
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
@@ -761,60 +825,29 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
 
 void iommufd_access_detach(struct iommufd_access *access)
 {
-	struct iommufd_ioas *cur_ioas = access->ioas;
-
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
+	WARN_ON(iommufd_access_change_ioas(access, NULL));
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

