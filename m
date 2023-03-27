Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841166CACAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjC0SFj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjC0SFf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:05:35 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B393A99;
        Mon, 27 Mar 2023 11:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT6+m7kbGuixaJu2WVOjs1FbleSTl8q66jwBeY+MosHxcD5pN+wJsWaBRUV/605VVqAoiY2AWjYcI7r9gCytDdDzZHrGeZghsYx8r3ZYZhF8EbtVBdSm/X+dPAhevcaDAzwB7yffugOh5MR0mVs2TNL+frTiV8YMkSKx1SdI2EvQwQWTxcfJBh02/w3Lo48TPN1Tmv5/BR/N5R40ppgxuC2KZSwcOoyzOJLDfRBnVPjzO1JUvHUSC/G/3sBxcVyi5f3HKR5NJHPjv0TZh/ILlgcsPgqXWyTIcnVa1gcy4AbeMcCG2FE4mX7wX87mjnkAjCQI+FCUeI1lp0o66I5RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NowpQxnwrx6PH8/RJtJ9gNozlYcnvudGcfIdWOhv+w=;
 b=gYfHItmga+NLSCVBtA3YKPaVl2v5R9XckqKPbyFjqjEqlwipElSeFe2z3rgFNUXcqHXKdKl1xHkPkPsUBv+zBYNcdAr6313XfQJ8WzHkXN69N6/bzbyqs/+/E91EvywytTa79A9HnhPWkGFScCULhKofioqCvj5RRw4wtb/DIXgyN6wv8dTLPhmNU+Rij7a/cvdz/Di0pDKc1o4nKvN8JhKsih33qzAvm/iEwFq0VrXZ8aBD0iT6kBNbkNcu4J296IUt8ns2hovLLpjLu3Hc+jnIKeu9LsQ5bsgJ2Y0+U2qp7n68UTQBQM6S5Uiq8m6kDeaWq7gJieBWAFYeCkAdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NowpQxnwrx6PH8/RJtJ9gNozlYcnvudGcfIdWOhv+w=;
 b=Z0FDfmuZD9+mLUrlmggwvitBAcv5iOxI1Zudqx+RmYGRdzTEB3Rn98GRzpZQcupyohtHsV8eZgORM2JDFPGlV2Hue8DP2sbbsWtE8k7sTOcwNL+St3vlN7X1lsRhdaev/S1d07vnpzUOW63TBZ/tm2r0SklgIFVCHpUoU0QynnaaRVZkOAK6o5DbIMRTsK6zu6+SGkghlrTl+VmnANgsexGM4NOIjLp2ffDQJs+VbAEAq0B6PT9JKmaff4gVnU5wHegUmqusoxKGyf32RvNoGyLpKRgCTh3a8oDxoKzQ6wbMiGkesmNDnI3N6L7DjCun8dkfrdqNVr+3CXu0hCZ1Pw==
Received: from DM6PR18CA0029.namprd18.prod.outlook.com (2603:10b6:5:15b::42)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 18:05:28 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::50) by DM6PR18CA0029.outlook.office365.com
 (2603:10b6:5:15b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 18:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 18:05:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 11:05:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 11:05:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 27 Mar 2023 11:05:14 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v6 2/4] iommufd: Add iommufd_access_replace() API
Date:   Mon, 27 Mar 2023 11:05:03 -0700
Message-ID: <955f7464fafc72984f3ec441671f37948f01d714.1679939952.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1679939952.git.nicolinc@nvidia.com>
References: <cover.1679939952.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: de52682c-92be-4f14-87dc-08db2eedd8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukVYYLH7OsB24f3MJyVVeuTBxJskD/Dy+Hxcz3JJ8qcwD0Wi5iNpBQ7euwwSV73AssXxGd9vwD0lT9h18eebHI+qqafM3CeawYq5TVJGxaV+Sh41Fqz3t2xK3LVbq81eHseDDMOOXuNbCtv0Mjn/Xf1besdKpMDai75TT1Cyrso2YNjA28Hx50W0flL25v1IfcldTpJ5u/6v5jcDDCTvsxN4lSjhR0rFZUNUpH/Ica1KpbsgsGy/t4PKHIaBeGgbiYNnMXWTKRuHbvpc7Fpu57RUh2lLA/qhivR4MiVrOvWhl9oG9iqKVXd97nbQfgjxm8ZpsnZn2msybzDog0DvHyogsKlN4o/5S61tppDI50x7Dh/60+CsuZ5fdQIjhZsw/h+ldP9DMrduev2h85rpEqYzTQRm+xNn/ZNXe01QEZaERgsju+3P+mGph3un/wb9JmpTmHBLx3g0PviKcflGElXICLQ3uKLe5sb/vZ19K7ZblzN/37y5PYs7r6koO6q+o4B2lPkHTacHSpSehrWKludLfo2tfadCDLQ9F0ivfFC87rRRJivz+cPyB/VuIvGX7HUc2ca/KcoP8MOo+q636bVsXC8FqFifHj4JTdixgHSSRLYPUUZdseY46gWVHSZceXHsXbPakCavOY3biTGpdHHzj+kTqLWQuFqiJQFLaMHXL4hfqJiRG//WzSTqlejcTnPu9KQIP2m7VCoFofMwX5qtwJ9aqsh+pvsY/iqCaJqfrXm08ZZetA1PGV4+tgXzIgKOxtFiJK6okuJdMBuwEL+sOTpQ4vOHTxPXlOoWx4Q=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(356005)(83380400001)(54906003)(7696005)(34020700004)(186003)(110136005)(478600001)(40460700003)(40480700001)(6666004)(26005)(336012)(70586007)(36860700001)(8676002)(2616005)(70206006)(86362001)(82310400005)(82740400003)(2906002)(316002)(7416002)(41300700001)(5660300002)(36756003)(7636003)(426003)(8936002)(4326008)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:05:27.8701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de52682c-92be-4f14-87dc-08db2eedd8a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
 drivers/iommu/iommufd/device.c          | 53 +++++++++++++++++++------
 include/linux/iommufd.h                 |  1 +
 tools/testing/selftests/iommu/iommfd*.c |  0
 3 files changed, 42 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/iommu/iommfd*.c

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6f7b349ba8f5..b6d61e886fbb 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -752,38 +752,67 @@ void iommufd_access_detach(struct iommufd_access *access)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_detach, IOMMUFD);
 
-int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
+static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
 {
 	struct iommufd_ioas *new_ioas;
-	int rc = 0;
+	int rc;
 
-	mutex_lock(&access->ioas_lock);
-	if (access->ioas != NULL && access->ioas->obj.id != ioas_id) {
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
+	if (access->ioas != NULL && access->ioas->obj.id != ioas_id) {
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
index 135dc2a28156..6752c58226d1 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -48,6 +48,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
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

