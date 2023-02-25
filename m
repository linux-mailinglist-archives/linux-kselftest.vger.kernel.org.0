Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4BC6A26A9
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBYBwm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBYBwl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:52:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF09688DE;
        Fri, 24 Feb 2023 17:52:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP7f80lHlyXaWwVlb6mU3CrW32FVpWQ4Zd/5mVt3j8nUraLlvCGdUH4H+y9dwstpEjgMUKpqw8Zg85I0MAOdXJbyfcUzBpYM3LqJpKmYOnnfbUAXoJj6ImlHIzUdAEJvrSYX96GYTywuR9qGDi1VZcYdh2uC1aN06HjxVXSai7Z4i5R/jdTE6SraxxACXUlDNQzlFeataVgzaPPzMWQYpiAcBhK7m+uses6fQiF+eirj38WUUlZJnRaH8eQnWg817KHk0R0UPHZQQWlPf0utPQ56U6iILgLHrG0l9oSSVFDGei+P6aUK7PrbLqf4RCjwRU6iSjJk5dy8jsgZ53Dl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ1UXfj7UI+YLClJDPr6cgJaKqeaXWFcbRbQboMnQ6I=;
 b=N62A3fJLA5+HnL40lnX0r4NTod9DeDfdJ3gQTKAVTjfGeCFvommiUlEBvKeCLw20VPLwJECgSPVMqGcLffTYPFPHuYOn53fvvMWXixmhrTKdQm1exmSecJoTZV1MVdprJ5qsI6WJTJxrYunaQOZ40WqvMK4GaHHtiY4Oj9L7TI/1Yjw5mLjq5gecerlua2qg6s6AufszedWDv4BQXQqvaJYcaJuNCPxDkUUpQk/09jMgo892gxAbcQQiATpTb+omjwH/8quvJF4zk0fYUewVrld/V2XkSH0RjyvzBdwootryE1+oTf5RtZmOumHF1uG5H4It+Bq8+GXjUAxbFBtDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ1UXfj7UI+YLClJDPr6cgJaKqeaXWFcbRbQboMnQ6I=;
 b=rSU06pGUKSLiQfAOH+5wpJH8/1HRNtAM8qEX0YHYKSO4ATRVGktgsLGl/cmy18bxiEYM28bZdM+VmPF+HqkwWNiQbZgL5EccXqhwabAEskcelaWJw6Yjm5NCW3MVo9oFy5WMVOkB3krqT+XS6P8kNz3Gl32hZ9pDjMds1wdLzmjxeem+18+ad1OlfLDhkZM8CBLqzzizQIEy2ewbIzlh4NO+iJIMjtEGdd90g3snplZZwVVllIIX0M6xeirEku2IAg8/3fAYqwvZKM4teH2P3+x1ibhra34O2XK9yXgaeipl3fHpLh0ZfJCYsS8VL6aJKy0o/hn+OEiLBAL4NCWFOA==
Received: from DS7PR03CA0150.namprd03.prod.outlook.com (2603:10b6:5:3b4::35)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Sat, 25 Feb
 2023 01:52:36 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::28) by DS7PR03CA0150.outlook.office365.com
 (2603:10b6:5:3b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25 via Frontend
 Transport; Sat, 25 Feb 2023 01:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Sat, 25 Feb 2023 01:52:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:29 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 17:52:28 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v3 2/5] iommufd: Create access in vfio_iommufd_emulated_bind()
Date:   Fri, 24 Feb 2023 17:51:39 -0800
Message-ID: <d1023a09ab3d4c69bc45095a733ad15ef000f373.1677288789.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677288789.git.nicolinc@nvidia.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: ae43e4e2-394f-4bed-bc24-08db16d2f76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqLy9DUyUh2ZMU1jydwNf/vwHTcBnIHS6aB3gRTsUnUJ98WnoxZv6WfIVVGr4wndQhKkVGllFe302ssgV+WQp1AXX3a/83WAlNrHpQpMzTFjIdVGOmGF/EYlfN2lFfpI8pDw8k8dNx3eKlxkhNrfh8AwyYVvBxgqQXJPwQv5luFcoH6CttgzYaEfiFkSa/jXiCFFmNTaJxqeFJQHQ0v+Pl/m3ckJyALUVC+md+/OBilbCft2+/WeXbZAQuWDwUDmX4fRDq6kQYiD9v8qTTZ4QTBc/4GO1ZdP1KEKmZKyvjzTONcuHfkxLbLsxZOZAuQMVqX05nIwMX/ey4FyJLLOIgWkBq6DKJPfyH5qt7UhGs8S/ojo9/pax9I62LTfERoUJ/b/6AEYtgHrBBhcJ+qn4jUQYGwLfB3EQREV0ZqF7D78HbKOBRCORlAH2mUc9dyxmma+S7M/3iVOF6m83wYwvYbcgLBixXqSttBNR9KYPfJKXL870WNu1VCC6GvfU0ol8M+iVtwm+/38efwxJ8jQjLDci6Wmy8/JAdOxvA7DqZCgsluzfGaqUpjxSC+1tFXHEdP7IPxfSyi/4/ayffgusJT8OzATPpHc9PZ6FA77UUVX/BB5uHYqbli+AGFTEVgEYD2+4H5QqxrHSyKI/s/pwW8fJFStWEhJK6wCYJwL0ifdMROqiw/OF1O3cnzw2qAWm0E4GdAZB1hc8Efc8BZNB8fkI5W6vlRSyXr8Xis6VdM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(30864003)(86362001)(2906002)(7416002)(5660300002)(82740400003)(34020700004)(41300700001)(426003)(7636003)(70206006)(4326008)(70586007)(8676002)(36860700001)(82310400005)(316002)(36756003)(336012)(83380400001)(54906003)(26005)(40480700001)(110136005)(356005)(8936002)(6666004)(2616005)(7696005)(40460700003)(47076005)(186003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 01:52:35.1758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae43e4e2-394f-4bed-bc24-08db16d2f76d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To prepare for an access->ioas replacement, move iommufd_access_create()
call into vfio_iommufd_emulated_bind(), making it symmetric with the
__vfio_iommufd_access_destroy() call in vfio_iommufd_emulated_unbind().
This means an access is created/destroyed by the bind()/unbind(), and the
vfio_iommufd_emulated_attach_ioas() only updates the access->ioas pointer.

Since there's no longer an ioas_id input for iommufd_access_create(), add
a new helper iommufd_access_set_ioas() to set access->ioas. We can later
add a "replace" feature simply to the new iommufd_access_set_ioas() too.

Leaving the access->ioas in vfio_iommufd_emulated_attach_ioas(), however,
can introduce some potential of a race condition during pin_/unpin_pages()
call where access->ioas->iopt is getting referenced. So, add an ioas_lock
to protect it.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 103 ++++++++++++++++++------
 drivers/iommu/iommufd/iommufd_private.h |   1 +
 drivers/iommu/iommufd/selftest.c        |   5 +-
 drivers/vfio/iommufd.c                  |  23 +++---
 include/linux/iommufd.h                 |   3 +-
 5 files changed, 100 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6ba8633b699d..a955ebd4bd5d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -618,9 +618,12 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	struct iommufd_access *access =
 		container_of(obj, struct iommufd_access, obj);
 
-	iopt_remove_access(&access->ioas->iopt, access);
+	if (access->ioas) {
+		iopt_remove_access(&access->ioas->iopt, access);
+		refcount_dec(&access->ioas->obj.users);
+	}
 	iommufd_ctx_put(access->ictx);
-	refcount_dec(&access->ioas->obj.users);
+	mutex_destroy(&access->ioas_lock);
 }
 
 /**
@@ -637,12 +640,10 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
  * The provided ops are required to use iommufd_access_pin_pages().
  */
 struct iommufd_access *
-iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
+iommufd_access_create(struct iommufd_ctx *ictx,
 		      const struct iommufd_access_ops *ops, void *data)
 {
 	struct iommufd_access *access;
-	struct iommufd_object *obj;
-	int rc;
 
 	/*
 	 * There is no uAPI for the access object, but to keep things symmetric
@@ -655,33 +656,18 @@ iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
 	access->data = data;
 	access->ops = ops;
 
-	obj = iommufd_get_object(ictx, ioas_id, IOMMUFD_OBJ_IOAS);
-	if (IS_ERR(obj)) {
-		rc = PTR_ERR(obj);
-		goto out_abort;
-	}
-	access->ioas = container_of(obj, struct iommufd_ioas, obj);
-	iommufd_ref_to_users(obj);
-
 	if (ops->needs_pin_pages)
 		access->iova_alignment = PAGE_SIZE;
 	else
 		access->iova_alignment = 1;
-	rc = iopt_add_access(&access->ioas->iopt, access);
-	if (rc)
-		goto out_put_ioas;
 
 	/* The calling driver is a user until iommufd_access_destroy() */
 	refcount_inc(&access->obj.users);
+	mutex_init(&access->ioas_lock);
 	access->ictx = ictx;
 	iommufd_ctx_get(ictx);
 	iommufd_object_finalize(ictx, &access->obj);
 	return access;
-out_put_ioas:
-	refcount_dec(&access->ioas->obj.users);
-out_abort:
-	iommufd_object_abort(ictx, &access->obj);
-	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_create, IOMMUFD);
 
@@ -700,6 +686,50 @@ void iommufd_access_destroy(struct iommufd_access *access)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
 
+int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id)
+{
+	struct iommufd_ioas *new_ioas = NULL, *cur_ioas;
+	struct iommufd_ctx *ictx = access->ictx;
+	struct iommufd_object *obj;
+	int rc = 0;
+
+	if (ioas_id) {
+		obj = iommufd_get_object(ictx, ioas_id, IOMMUFD_OBJ_IOAS);
+		if (IS_ERR(obj))
+			return PTR_ERR(obj);
+		new_ioas = container_of(obj, struct iommufd_ioas, obj);
+	}
+
+	mutex_lock(&access->ioas_lock);
+	cur_ioas = access->ioas;
+	if (cur_ioas == new_ioas)
+		goto out_unlock;
+
+	if (new_ioas) {
+		rc = iopt_add_access(&new_ioas->iopt, access);
+		if (rc)
+			goto out_unlock;
+		iommufd_ref_to_users(obj);
+	}
+
+	if (cur_ioas) {
+		iopt_remove_access(&cur_ioas->iopt, access);
+		refcount_dec(&cur_ioas->obj.users);
+	}
+
+	access->ioas = new_ioas;
+	mutex_unlock(&access->ioas_lock);
+
+	return 0;
+
+out_unlock:
+	mutex_unlock(&access->ioas_lock);
+	if (new_ioas)
+		iommufd_put_object(obj);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_set_ioas, IOMMUFD);
+
 /**
  * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
  * @iopt: iopt to work on
@@ -750,8 +780,8 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length)
 {
-	struct io_pagetable *iopt = &access->ioas->iopt;
 	struct iopt_area_contig_iter iter;
+	struct io_pagetable *iopt;
 	unsigned long last_iova;
 	struct iopt_area *area;
 
@@ -759,6 +789,13 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 	    WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
 		return;
 
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return;
+	}
+	iopt = &access->ioas->iopt;
+
 	down_read(&iopt->iova_rwsem);
 	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
 		iopt_area_remove_access(
@@ -768,6 +805,7 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 				min(last_iova, iopt_area_last_iova(area))));
 	up_read(&iopt->iova_rwsem);
 	WARN_ON(!iopt_area_contig_done(&iter));
+	mutex_unlock(&access->ioas_lock);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_unpin_pages, IOMMUFD);
 
@@ -813,8 +851,8 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 			     unsigned long length, struct page **out_pages,
 			     unsigned int flags)
 {
-	struct io_pagetable *iopt = &access->ioas->iopt;
 	struct iopt_area_contig_iter iter;
+	struct io_pagetable *iopt;
 	unsigned long last_iova;
 	struct iopt_area *area;
 	int rc;
@@ -829,6 +867,13 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 	if (check_add_overflow(iova, length - 1, &last_iova))
 		return -EOVERFLOW;
 
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return -ENOENT;
+	}
+	iopt = &access->ioas->iopt;
+
 	down_read(&iopt->iova_rwsem);
 	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
 		unsigned long last = min(last_iova, iopt_area_last_iova(area));
@@ -859,6 +904,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 	}
 
 	up_read(&iopt->iova_rwsem);
+	mutex_unlock(&access->ioas_lock);
 	return 0;
 
 err_remove:
@@ -873,6 +919,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 						  iopt_area_last_iova(area))));
 	}
 	up_read(&iopt->iova_rwsem);
+	mutex_unlock(&access->ioas_lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, IOMMUFD);
@@ -892,8 +939,8 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, IOMMUFD);
 int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 		      void *data, size_t length, unsigned int flags)
 {
-	struct io_pagetable *iopt = &access->ioas->iopt;
 	struct iopt_area_contig_iter iter;
+	struct io_pagetable *iopt;
 	struct iopt_area *area;
 	unsigned long last_iova;
 	int rc;
@@ -903,6 +950,13 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 	if (check_add_overflow(iova, length - 1, &last_iova))
 		return -EOVERFLOW;
 
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return -ENOENT;
+	}
+	iopt = &access->ioas->iopt;
+
 	down_read(&iopt->iova_rwsem);
 	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
 		unsigned long last = min(last_iova, iopt_area_last_iova(area));
@@ -929,6 +983,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 		rc = -ENOENT;
 err_out:
 	up_read(&iopt->iova_rwsem);
+	mutex_unlock(&access->ioas_lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c9acc70d84f7..94e88377a7fc 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -311,6 +311,7 @@ struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_ioas *ioas;
+	struct mutex ioas_lock;
 	const struct iommufd_access_ops *ops;
 	void *data;
 	unsigned long iova_alignment;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 51ea09af5778..dacd1f67957d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -754,7 +754,7 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 	}
 
 	access = iommufd_access_create(
-		ucmd->ictx, ioas_id,
+		ucmd->ictx,
 		(flags & MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES) ?
 			&selftest_access_ops_pin :
 			&selftest_access_ops,
@@ -763,6 +763,9 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 		rc = PTR_ERR(access);
 		goto out_put_fdno;
 	}
+	rc = iommufd_access_set_ioas(access, ioas_id);
+	if (rc)
+		goto out_destroy;
 	cmd->create_access.out_access_fd = fdno;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index db4efbd56042..1f87294c1931 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -138,10 +138,18 @@ static const struct iommufd_access_ops vfio_user_ops = {
 int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
 			       struct iommufd_ctx *ictx, u32 *out_device_id)
 {
+	struct iommufd_access *user;
+
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	vdev->iommufd_ictx = ictx;
 	iommufd_ctx_get(ictx);
+	user = iommufd_access_create(ictx, &vfio_user_ops, vdev);
+	if (IS_ERR(user)) {
+		iommufd_ctx_put(ictx);
+		return PTR_ERR(user);
+	}
+	vdev->iommufd_access = user;
+	vdev->iommufd_ictx = ictx;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_bind);
@@ -161,15 +169,12 @@ EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_unbind);
 
 int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 {
-	struct iommufd_access *user;
-
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	user = iommufd_access_create(vdev->iommufd_ictx, *pt_id, &vfio_user_ops,
-				     vdev);
-	if (IS_ERR(user))
-		return PTR_ERR(user);
-	vdev->iommufd_access = user;
-	return 0;
+	if (!vdev->iommufd_ictx)
+		return -EINVAL;
+	if (!vdev->iommufd_access)
+		return -ENOENT;
+	return iommufd_access_set_ioas(vdev->iommufd_access, *pt_id);
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_attach_ioas);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3044a432a83e..f20f63e0b066 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -41,9 +41,10 @@ enum {
 };
 
 struct iommufd_access *
-iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
+iommufd_access_create(struct iommufd_ctx *ictx,
 		      const struct iommufd_access_ops *ops, void *data);
 void iommufd_access_destroy(struct iommufd_access *access);
+int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
-- 
2.39.2

