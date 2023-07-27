Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779217648B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjG0Hee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjG0HeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:34:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10CA9EF4;
        Thu, 27 Jul 2023 00:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkGnuKQqE4qHnQ2uLihJZcV7jotw+A2fx5VRd6hGbqxdyAT/muQL5AhZOhGH9E5hK58q+Dkqb0GsejbQaRd2XNHH7IehP2wJ5v1guwFJ6ztPc0j+EMeqetZF9fhtatWKMgD6h4hxx8LS7/blQ4dhfglSBD748q+usBrT4rRW8RpDnVg+Wb9jjcCl+80dNPLlp45WozdYtoFHoapN4qeM8E/SoIdkDSZPuF/UmjwQWf93XM26O+jOz75asKljbm4omtKlpU9OkN0LIu9DXcoxghEzOAfeQ+XyoAwO1Pt4kloyrSEnptYfUBgTondAR83hUz1Bj1ymrd4HGyo7aJUcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYL3eJbt8G8CnDGcPPANlJZLEdDOJZmnWNcYEYajIsE=;
 b=QIozWAqURWk369+yycc1jy7w5nLLGJxNF7XcysBmrFXj0kLAPf3Y9FQ4pyGUqSuR7SNUI6NfvhRxia6f69XkS/AmdBofezl+sWkv0QSdMerlGrBzQlbraqEg9zfRo4xUUFyLvtg6sWSFCnjBbyeYYeacR/iokz6/9LSkWShE+DyMMT4dszqpEKt5+ygYfRzl7JFwBwXCHjCpxRAksir++gipSSA2hUmp5M/nweabGmxdUGtj1FrOavDmn/8JdB3MsTpTo0ZvOfCgqloW7Oxo3XprkyjXWYWW6tTVUH7e7/2HUrzQgWaYEtuu/xaFNzuBwE9ApQ2Zv74JkDNHWi0D4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYL3eJbt8G8CnDGcPPANlJZLEdDOJZmnWNcYEYajIsE=;
 b=Q05oFzF5YnNv9Sp1s/MNU+rMsSkT4JYdi29L0XsC64auSknNaVWdvFyw1lWWZhczziJRRD2kjQpaQ923notRvRgOA5deUgBTZglk0li8X/8cf7B6qpgyTQYiB1IVO6TWZZingCmRVfa9fFGYKEENUHX4J+ti9mr6Co6Yjr+F/w5EkFtvRIUvLno8klegM4xnp1B1ovR4kwjABgmKWhe4jQSiSxjiYMoBWq5Ygnch4PVyb+Xw+xpTlrXWgYFL70UByEUXpdlLToyE2SlAkelqAe8iQ1liIM2YYVnYnckQMtJe1nWIELwuoQGQkFdtmJ69Kx9fb2sM5G2ziZuXIgwP+Q==
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:23:44 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::ca) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:23:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:23:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:23:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 00:23:31 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v9 4/6] iommufd: Add iommufd_access_replace() API
Date:   Thu, 27 Jul 2023 00:23:09 -0700
Message-ID: <ab1aa02afc96d8cc4711870287e1cb81d7c9558e.1690440730.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690440730.git.nicolinc@nvidia.com>
References: <cover.1690440730.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb42a02-2069-43b0-fd2f-08db8e7268b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UVevKcElHe0QdPjh56wyNxCYJt5ABFXvz+QxNXwDcejTPJf9WSQN5EUzOZZH0GzHPUJqDnFrykRwfAsrYPOsc0eMySYKJ3M95E2j1R8/neze+xl0Q9J6y14q8moUCeRgPtKKxYNuQuhplqbsorbVM52gx6PR4eq1G2hpnf9a1dHpaCX+Bt+X8lkXuZUauzAsrMzeKIio9bKqncvccyBG35rKi5N/CQ4iDQYHNzSaAz4FZcbQ6R5r6uWwgv4SXoFI9QhnXtqLe8yohi1ThNHYa1/OvyY/xfaoVmTrV8EGxoxYaUe+EsjZgob84hhDPTpBNbUxyGx8XnUi8yY0/7rC1HfR1Ncs0eZhUH5i59lK1Eckd+44hxgXezsoOiY5kucOmnJw9IoxEvnYg16/3k96yzyNwN817HOLsrfZMXISDNnnYjTJwSdqVk7NMlb7xflsS40YKqfD+uMe/4v68zSuq3loet2Nec+PU2MtXqyKaL24e5YpKPESKRWBYSNjj6902lZWmtgLZFNm9eS5UcJG07aw5yV2sLBnZ4mIKZUJ+1Wic9gDD+pa0TglLT6y/xIv9+2czO0R2Qbjw0i01b52bokAk+MIF+kRnFq6SUqBoYgGRsZNuQOJZYCs8JicH0lV0/Cu+sixVMtRJdkVz8eYWeu+tsSV26hrYhacOa5U7VkXWJiBYWfqdZqlcBCOuhmOlHLZA9EX7dkUTKwOVJZC1rIJ6i7Ffr5dU+OubS8P9gxUS6le9AJF+FCbsnqK+O1
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(316002)(8676002)(8936002)(7416002)(5660300002)(40460700003)(41300700001)(36756003)(40480700001)(86362001)(426003)(7696005)(6666004)(110136005)(54906003)(82740400003)(478600001)(7636003)(356005)(26005)(336012)(186003)(2616005)(83380400001)(70206006)(70586007)(36860700001)(47076005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:23:43.5965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb42a02-2069-43b0-fd2f-08db8e7268b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Taking advantage of the new iommufd_access_change_ioas helper, add a new
iommufd_access_replace() for VFIO emulated pathway to use.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 17 +++++++++++++++++
 include/linux/iommufd.h        |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d9680a247e1c..2dfeb65c7090 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -844,6 +844,23 @@ int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, IOMMUFD);
 
+int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
+{
+	struct iommufd_ctx *ictx = access->ictx;
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return -ENOENT;
+	}
+	rc = iommufd_access_change_ioas(access,
+					iommufd_get_ioas(ictx, ioas_id));
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

