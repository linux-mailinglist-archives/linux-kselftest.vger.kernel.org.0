Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8622765D38
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjG0UZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjG0UZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:25:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AADD272B;
        Thu, 27 Jul 2023 13:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXCN+7A9M3DuYtq4ER3FffyHRKWHE6NqhV5t+kg6k28uhnr4umXcfFnQkRAPj5wBwvqmYf34sCgChcpaJevR8bgZJ5ygTN+omU8p8XWVye9VCmXA8DrQHHKcUFpZZzw7Tvfe2eYIjqav2DbjXcCAZ+OmLeIHNg4dn4hhQYDd6VrX6LDG3mUAbp34/EyzG821IzrVd091OBE5b/55Dhb4E0L/rrT+GprZM25iZr0rpBuMOaPtIYbA95Gm61chtxQWHZkcb20qnPAHB/RKxaigdDuPKyFiOv7q4cWvJ09/NK2aNkX9wrDSXBw+I4IRdZ5c33ad97xXQ5xg02Q3lP8LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZYDw7d4hrp0hCVXIirdg00pXN2Sgkz4tDdwzRwGfdU=;
 b=Nk2BywFSb4PWoVZylKoiyVDLyK2aBDHEGptf7hzAi95QRi8Xn1JfBAi7RQe5/Gm28SeodzINOe4zuGWU9rg8L+cASP3hEskWi8mMaYalBnWx1E9xOcxzAwxVKCN0u+ZwD8toBijkzjVqBpPd4iJXqHFqrcViYVGKPq1VbFuenZYKoeTcyqBqLGNJu7IvlkHd/p/w959TQePlBSXLC1XhtqZ1JGbOydVILnb0hBXBPciNEJqi8g2zw5X421I17SvVyxEkhMRa2hjm/P14mzceaGDWYMIApHznJ+418PRgSxzTlAw1wC+gjgktlaJQgr+2y5lQja2dlAFj8SnU6MOLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZYDw7d4hrp0hCVXIirdg00pXN2Sgkz4tDdwzRwGfdU=;
 b=oEgASsxtIUERFKoFT4dsAvtm60VhhSzDc5O2Q493G4mRZ2RRAWFK9464dgsOvmgBVLD1vFVSOg0gjRVLzCh+j2gGQ1aMxguuSEXb33p7TZv1MQFuioVWWxIgB3ABp7j2SjjY0VdbpX8CNRqtMO2yGpkCO7YPHlwrJ7hxXcShRE72suJwwsybF/Pbc4v5OIOEcPpPuG09EfL0n0xdtSOEXB17lFlTE3E06UW3m0QwscJYwfhYn0/QSXGnSZrD7GQ50bYnxDg5Zih4/V1ECJHHJIcobjNj+hZ2O+m1OgpUKEYHSx6VBC5GyzQtnIwvKPbB4oef3eiyYwkS20dGkevU4w==
Received: from BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) by
 CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:25:07 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:94:cafe::11) by BYAPR01CA0043.outlook.office365.com
 (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 20:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 20:25:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 13:24:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 13:24:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 13:24:49 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v10 2/6] iommufd: Allow passing in iopt_access_list_id to iopt_remove_access()
Date:   Thu, 27 Jul 2023 13:24:33 -0700
Message-ID: <9cf230e73d40b1458dcbb116d1fcfe8c62058bfe.1690488745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690488745.git.nicolinc@nvidia.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4fe828-79e2-4e2b-f76d-08db8edf914f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jV/i7qUFFTldIVpx5MJuYUmgs4UGxtCfmA16e8Z1dO7SissVEk2jSAbBpEuyGNMQlJ4fMb/9U3VujAdKD9g3oBnjh2gklQbO7LfKi9zS5UGaYGZZoH+8DpU5PBAiEfU3qJRQr1wJ42Ii3N7qmhjxmatpUfZaz8I1G+dh1hUauatDyBRFSua/68w029M+o37nZjFbfEi8mW/NO4Kuk98jtIiy3EKz+9917hYLCsUL8f9eOB1JWND3aShC2echJesNklRdJeHwrCcuwtG5yFlQjg9OVwwS9g98IU1epbNtCpGJ4fEXb7TlunG5ju/Y+eCd6ITVVcNJJrNKZk8RtQz14JEEo3dH25mjTc9anFdNKtu2vupYf+cTvylTKeIqCE2/VEnL+AiP2nnelnvuYEJA7Es4tyYkdrUZklvVuNip3oznxWdiXv/Iu/jfBmpDUPohBCrtSqzRRpjkutYmzUyQ7Mfoz4Oa/NrP5LBq5My1GiZ87ikzkI83FBBeVhTD52fPqgJjPE+WhmKwJK9aJZnEaDxjzn9nRl1F+3Se8+lqLSPXJ75JMBKU2u5OA13QgXR/s3AqUlbJl3QNsDZOe0tPeyieuOamKh3JpkAg1JAYpXhX95ertmmSbb+jDdHV8gRPg6HWW07Q6ObbiU/vn7g5L/R3csQEOJIq2cUPPn5MhJeorXDQFCzQuYCtxcfUpu3gAQcj0Z+PfXnpR85tOu62XnVZ1h13qPcDZJh9GL/5yh5tIwNgk8lWqwW2yhfx0xhO
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(7416002)(70206006)(4326008)(70586007)(316002)(2906002)(478600001)(110136005)(54906003)(8676002)(41300700001)(8936002)(7696005)(6666004)(40460700003)(86362001)(82740400003)(26005)(40480700001)(186003)(36756003)(336012)(83380400001)(47076005)(426003)(36860700001)(2616005)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:25:06.8439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4fe828-79e2-4e2b-f76d-08db8edf914f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

