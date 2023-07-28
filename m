Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD976642D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjG1GeZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjG1GeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:23 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D2E30ED;
        Thu, 27 Jul 2023 23:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3fqLlEWu5R2xIZtBZeo/RRyI8VrYKuNcFtVsgqM7cvzAvbwRNYa1NpZaKCRIKHdYwFJDf5TApAFTz7rmRimkQnVnGoNM6wtGbloSsMcUJaeEg/UyHE3M4RED61WNUe87YQUuX2swwY+irusw42PmHF9bFafsOcQWEH/N50GrRVd4Cky/1d8L42jWyYZuaB0zBfYgXZ08d768isUGM+jCXq9T1fsx3iaEtIqIQccop/frW5DdLPdlt6HsGJj1dr24Ap/gxeBcsEaGhUNq5MnG2IwuthQfx8iug2Rk1fwLWvUoO8x7k03+EsIMpQjaysYIDdTFjLtlCR/ew3x6FisZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV0JrjUUwrn1J/lFH9ZY9xyoo1mCpvdd0c+a5ZoWLOg=;
 b=F7FKJD3Wk8TC1cmrawKNQ5SFeUSqsJIVm1/IgXuX9Iia2drmDLzK6QsamhB+cZwTRiAbQ984TjO9rvzYupGAbfcNhJHiZTk2ul4ZpPMHgDja+p0nJM9daW+PnS6/MQ4QIh0CXHDhoM43HxclNvBPSBN9h2ARk5N58DS0Hmshacjs6Loo/O+Ky5wxEKSYPCz4so2dAe4flBwpgRMKeii0eCbTl7cxCDMxOM0c/3O3UP3ueJPeGTAV6F6MQZDo7GqcA30VIg7S8AMJ14dratir58Z5EQyCugq9Vy9pVWjbrC1FD3ZPZG7Qgxo32cXVt4sxfTx1cz7D3mri9SflsQqAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV0JrjUUwrn1J/lFH9ZY9xyoo1mCpvdd0c+a5ZoWLOg=;
 b=Wvm6ZOb2IncEik44+URc6bfTb8EgJ9VM6WCJAW0AIryZ5qJi9nfijBFkfq1s2pUmN05pleHKJGYMKir244AJsReMVikwzh0+LyDGsqtts+iBAWbLakM3MvcT7WuSKmcy5m+c424KVpfPsyc5+QDa4enphcIxoT/aj9/PbWQT7ibCkSfzBfuV2/7B/6oIKqw9H4XJcEsuRDQ5FfZ8OK1ir4oUJXHzM4di/GpFazxW4A0/JcrEzfP8DaCLKAH+vOvgFKr0WLagcsM/qmc4QyjejqzaUYn9vxuc8R5IXJZB0HwAe/oJe1IppYbH4w5PGeKzP/vn8ixQhwmmex/YmA4CXg==
Received: from DS7PR05CA0061.namprd05.prod.outlook.com (2603:10b6:8:57::15) by
 CH0PR12MB5076.namprd12.prod.outlook.com (2603:10b6:610:e3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 06:34:08 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::64) by DS7PR05CA0061.outlook.office365.com
 (2603:10b6:8:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Fri, 28 Jul 2023 06:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 06:34:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 23:33:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 23:33:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 23:33:53 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v11 2/7] iommufd: Allow passing in iopt_access_list_id to iopt_remove_access()
Date:   Thu, 27 Jul 2023 23:33:24 -0700
Message-ID: <7bb939b9e0102da0c099572bb3de78ab7622221e.1690523699.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690523699.git.nicolinc@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|CH0PR12MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 52379ce6-1a3c-46e6-b8bb-08db8f34a569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDpQ7LsrPz6f+AaeDmpIrC2oSJkaH6k3T1zqGHObOeERlVgj9L2R9MN4eB7L6Uu6mPY2zJ0wTy/v1IhjK05oxIMHyj0UCE3jGVHmqAictfujlyO6HcMcvwmNPHqWnnpCQE17kHNj0QGor28dr6TDohXFLFi7FiaFFtnt2duTSqHRXf3cAuAZ+q6C4t4/H7uMkkmrLKiD1iohMWttJYH2Wlx9apK6KXpc2LAoU88x6uwYKIaqVuHmSAoQqsv+2NvI0anSbMJZxhTtj4DHAMhoCwHVANIxZ5DYHuCx3Nl+jg26cKvpNe05CeB+Skp64IM+1Ygd2g9PGM0EjgyM4pXMOwfJaokIomUFF16a63AAmXtgSYABFLmKkrbMdD497TrVCGhNye3/z0HbU0FwqWs5zgelG+4m8q8AZBBAHbpwty2U163lj/Int3sS+/Etpx6gByUJPu9Fgf+VJKEoOUhz8fXtQMYKqkJdrmoAOdSSi2TLLP25p3MpLo7nrX6aInSZ4e5mJFn1HwUyOVgGZj/ZkMpMjzUdPVpLr8eTipPRod8Bg2UIufcTh/XRTQFNGl2AQ1GtgaBPXcXc85+t7+5CA8pvHjY0nzXOq4KCWxIil9K2ZT6+5nHYCjPA00cHCoLCBt59Mr3xI5KgFn8pUR0b46rSCn3CrBL23Ahm5DPp6Kg5ygpJW1waD72Pwt0CCz2Nv7OUrVFkYIjIE+H2AykjHFWcXiHe/D52J/QYeEXRnXvpceFSpOAKWqWY+jTARqOm
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(7636003)(336012)(41300700001)(26005)(36860700001)(86362001)(478600001)(36756003)(4326008)(8676002)(8936002)(70206006)(70586007)(82740400003)(316002)(186003)(40460700003)(2906002)(110136005)(47076005)(2616005)(356005)(83380400001)(54906003)(7416002)(7696005)(426003)(40480700001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:34:07.7735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52379ce6-1a3c-46e6-b8bb-08db8f34a569
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5076
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

This is a preparatory change for ioas replacement support for access.
The replacement routine does an iopt_add_access() at a new IOAS first
and then iopt_remove_access() at the old IOAS upon the success of the
first call. However, the first call overrides the iopt_access_list_id
in the access struct, resulting in that id un-erased in the xarray.

Add an iopt_access_list_id in iopt_remove_access, so the replacement
routine can save the id before it gets overwritten, and pass the id
in iopt_remove_access() for a proper cleanup.

The existing callers should just pass in access->iopt_access_list_id.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 6 ++++--
 drivers/iommu/iommufd/io_pagetable.c    | 6 +++---
 drivers/iommu/iommufd/iommufd_private.h | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 57c0e81f5073..7a3e8660b902 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -690,7 +690,8 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_access, obj);
 
 	if (access->ioas) {
-		iopt_remove_access(&access->ioas->iopt, access);
+		iopt_remove_access(&access->ioas->iopt, access,
+				   access->iopt_access_list_id);
 		refcount_dec(&access->ioas->obj.users);
 		access->ioas = NULL;
 	}
@@ -776,7 +777,8 @@ void iommufd_access_detach(struct iommufd_access *access)
 		access->ops->unmap(access->data, 0, ULONG_MAX);
 		mutex_lock(&access->ioas_lock);
 	}
-	iopt_remove_access(&cur_ioas->iopt, access);
+	iopt_remove_access(&cur_ioas->iopt, access,
+			   access->iopt_access_list_id);
 	refcount_dec(&cur_ioas->obj.users);
 out:
 	access->ioas_unpin = NULL;
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4d095115c2d0..3a598182b761 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1158,12 +1158,12 @@ int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access)
 }
 
 void iopt_remove_access(struct io_pagetable *iopt,
-			struct iommufd_access *access)
+			struct iommufd_access *access,
+			u32 iopt_access_list_id)
 {
 	down_write(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
-	WARN_ON(xa_erase(&iopt->access_list, access->iopt_access_list_id) !=
-		access);
+	WARN_ON(xa_erase(&iopt->access_list, iopt_access_list_id) != access);
 	WARN_ON(iopt_calculate_iova_alignment(iopt));
 	up_write(&iopt->iova_rwsem);
 	up_write(&iopt->domains_rwsem);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dba730129b8c..8ba786bc95ff 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -323,7 +323,8 @@ struct iommufd_access {
 
 int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access);
 void iopt_remove_access(struct io_pagetable *iopt,
-			struct iommufd_access *access);
+			struct iommufd_access *access,
+			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
-- 
2.41.0

