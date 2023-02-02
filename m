Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82CE687631
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 08:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjBBHF6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 02:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBBHFw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 02:05:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D268349A;
        Wed,  1 Feb 2023 23:05:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJEtUCR/iXDYKT0vVgJm8MqeSDCOwKFpr0wK4y6nXyJ0C9VbrWFcVrffUmb+kkX1Ua9lAUfQgAeWeylHm9yacmdaKhuBNax87kldzw9AJItGAOlDnhd3EpFQrBN5Obnl0cypPc5EyVYF7iRJNAy+l+P9pdYZP3NGUWgqR/GZ5U63mI8hMAv4CrJYPRikrRI7XMvJWATmbPdwG+j3dlXrxDQ8uVAVZNOV4OHBS1GJ3BLFg1Trs1tyTWjQpTeQtiXr+JGfgodftRZlvJED6olfytDNbXOA/SaOLvjeSg7qchNF/TknfRXqm8rCwF9JfmIGrPejjDLYrwRU1QN3JONraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHXZ1wkOfg4JQkH5cj6SdQs5cAJhTa/jEO7HpB38QC8=;
 b=COrFsIRsQnpN6yCVWpjDsxd/tIyz643iSfuDfOxpYMgs31n0jPeHAhvTLfNeEVYNFv5CP/eu4otU2OoUmBXc3SsMZxiXglqpfEihbW/u4LrVOlHaaE5aB+r5IF2q8D0KiKg66PTAV5DKJukepRIVjbBf0WS+46dHE0gQM+hSWuu+u4P2UilQYwIhIRkcPDQn4Us0tXbi0KhWoYwYzYKC0BPAj+HzLchy9LGh/DDcdmTmr9uv+x949G/oqBPjMxiBWl0evjup+Dhr6sK1WIkp0FFS/HcbNAtcn0P2Zb4sD3qVgAc27q5phQniVHca/Hzp0Jbvn1CkA7Qjf6mJaK1EKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHXZ1wkOfg4JQkH5cj6SdQs5cAJhTa/jEO7HpB38QC8=;
 b=WBqkkDcUGiSqyPZxqdSk0j421FUejXAvbbBkCqRjpJWpu+TVpsrb5RXdkhNSiUgfgV8SGUzalaOp7n+4Rbz63iDWlFEopvmbemyPAsc6x4rkezZErSPlTiRTGBg4/u9gmEPKd/SzFLBpGhHMBFUGdWwO+Ie49Hfo7qntt2SOqS3rNtl0DxdaN/EIZSOTkU4WAOS+EQIEvwXDg3vfPFmbeLxjOMtM3d9Sdnnp3bcpitUjv3tF2fNX75N6CosNc4aS4jiqa91crhdlx3voCGBJuXbfjqTHqTB5TwOjdS3VmJOA3tcf0pA0NUORbDgtPKp9QXhnKxKL9VStkutEIYdA+A==
Received: from MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 07:05:38 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::be) by MW3PR05CA0017.outlook.office365.com
 (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.6 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 07:05:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:25 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:23 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 3/8] iommufd: Create access in vfio_iommufd_emulated_bind()
Date:   Wed, 1 Feb 2023 23:05:07 -0800
Message-ID: <f86e468509886c8fe59d2326f83bbf95254e0913.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 487f62dd-64d4-46ca-abe9-08db04ebe30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iS+ORsfEMzLlMxoOy0/Mqyg3ZAygSmyEf5syd468Y8XWldaEwwGJHBiIR/TJKQ6BMnja15LDyx9G3b5xRrO4/cjhvOeqEVz6/CApbranbL17HrVFrMhQVO97TCu7AlskT/2w1OL1J1RaX99ftPRkwjL+hdrYGCT8Nw5ZEhusx+Dd4Olzkl25G2AM7/ViyxRNKFtX7Yd4vvj/Gforb7oxED3Z40MgRDoZs3cFWMOh3sDtkq9p4KCuCKAVFUuMHqy8GJjGWm6mKjMsS+JgpkhyPFsLRsj3z96RDRf0lEiZF7LUBJlU8Ms35Q/+mi/2eTSPqAaLAJkMfCYZgocrIq9BKwIuW5FJ1WNi/vqkkyTGGCoswuKnd9KFL3h0FBd8OmmZ8jpbuR3XKuFuV4XeJJuCAAn2SWdZYOAhYLIByV1QYzefDiVR4mvBxeSkd/vdCIse0B4NH+dCKzNkkGlULhr0U6HTU4+M+LoxCTEEzw5+/uVx/n1BDbAVkLCpJUF7VyIifliTRmc0LG88hXJ8r/7FNPMNjacA8ikJZbV+AO8McNBCup0vHwpkG63C2rJP2WUvJSChW39Eq6SZSJQGbbpygn/Wz2+PGcFx/UT5zMSNsgTcp4nFPYjFvmGiu+YUmPiLgwljAuTLZd5hu2k1m6ixBEqM6S60F9kSPK8rQKjqOnJiUgxDjiradeyDSpXOvhxUwKwifnzNSWVJu5n9f849w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(83380400001)(110136005)(54906003)(47076005)(316002)(70586007)(41300700001)(70206006)(4326008)(8936002)(8676002)(6666004)(26005)(186003)(478600001)(2616005)(7696005)(336012)(86362001)(82310400005)(426003)(36756003)(356005)(2906002)(40480700001)(30864003)(36860700001)(5660300002)(7636003)(7416002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:37.5138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487f62dd-64d4-46ca-abe9-08db04ebe30b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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

Note that the "refcount_dec(&access->ioas->obj.users)" line is also moved
to the new iommufd_access_set_ioas() from iommufd_access_destroy_object()
for symmetry. Without this change, the old_ioas would also lose the track
of its refcount when the replace support is added.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 100 ++++++++++++++++++------
 drivers/iommu/iommufd/iommufd_private.h |   1 +
 drivers/iommu/iommufd/selftest.c        |   5 +-
 drivers/vfio/iommufd.c                  |  30 +++----
 include/linux/iommufd.h                 |   3 +-
 5 files changed, 96 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d81f93a321af..f4bd6f532a90 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -418,9 +418,9 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	struct iommufd_access *access =
 		container_of(obj, struct iommufd_access, obj);
 
-	iopt_remove_access(&access->ioas->iopt, access);
+	iommufd_access_set_ioas(access, 0);
 	iommufd_ctx_put(access->ictx);
-	refcount_dec(&access->ioas->obj.users);
+	mutex_destroy(&access->ioas_lock);
 }
 
 /**
@@ -437,12 +437,10 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
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
@@ -455,33 +453,18 @@ iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
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
 
@@ -500,6 +483,50 @@ void iommufd_access_destroy(struct iommufd_access *access)
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
@@ -550,8 +577,8 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length)
 {
-	struct io_pagetable *iopt = &access->ioas->iopt;
 	struct iopt_area_contig_iter iter;
+	struct io_pagetable *iopt;
 	unsigned long last_iova;
 	struct iopt_area *area;
 
@@ -559,6 +586,13 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
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
@@ -568,6 +602,7 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 				min(last_iova, iopt_area_last_iova(area))));
 	up_read(&iopt->iova_rwsem);
 	WARN_ON(!iopt_area_contig_done(&iter));
+	mutex_unlock(&access->ioas_lock);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_unpin_pages, IOMMUFD);
 
@@ -613,8 +648,8 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 			     unsigned long length, struct page **out_pages,
 			     unsigned int flags)
 {
-	struct io_pagetable *iopt = &access->ioas->iopt;
 	struct iopt_area_contig_iter iter;
+	struct io_pagetable *iopt;
 	unsigned long last_iova;
 	struct iopt_area *area;
 	int rc;
@@ -629,6 +664,13 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
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
@@ -659,6 +701,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 	}
 
 	up_read(&iopt->iova_rwsem);
+	mutex_unlock(&access->ioas_lock);
 	return 0;
 
 err_remove:
@@ -673,6 +716,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 						  iopt_area_last_iova(area))));
 	}
 	up_read(&iopt->iova_rwsem);
+	mutex_unlock(&access->ioas_lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, IOMMUFD);
@@ -692,8 +736,8 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, IOMMUFD);
 int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 		      void *data, size_t length, unsigned int flags)
 {
-	struct io_pagetable *iopt = &access->ioas->iopt;
 	struct iopt_area_contig_iter iter;
+	struct io_pagetable *iopt;
 	struct iopt_area *area;
 	unsigned long last_iova;
 	int rc;
@@ -703,6 +747,13 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
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
@@ -729,6 +780,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 		rc = -ENOENT;
 err_out:
 	up_read(&iopt->iova_rwsem);
+	mutex_unlock(&access->ioas_lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 222e86591f8a..2f4bb106bac6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -261,6 +261,7 @@ struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_ioas *ioas;
+	struct mutex ioas_lock;
 	const struct iommufd_access_ops *ops;
 	void *data;
 	unsigned long iova_alignment;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index cfb5fe9a5e0e..db4011bdc8a9 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -571,7 +571,7 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 	}
 
 	access = iommufd_access_create(
-		ucmd->ictx, ioas_id,
+		ucmd->ictx,
 		(flags & MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES) ?
 			&selftest_access_ops_pin :
 			&selftest_access_ops,
@@ -580,6 +580,9 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
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
index 412644fdbf16..78a8e4641cbf 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -144,10 +144,19 @@ static const struct iommufd_access_ops vfio_user_ops = {
 int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
 			       struct iommufd_ctx *ictx, u32 *out_device_id)
 {
+	struct iommufd_access *user;
+
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	vdev->iommufd_ictx = ictx;
 	iommufd_ctx_get(ictx);
+	user = iommufd_access_create(vdev->iommufd_ictx, &vfio_user_ops, vdev);
+	if (IS_ERR(user)) {
+		iommufd_ctx_put(vdev->iommufd_ictx);
+		return PTR_ERR(user);
+	}
+	iommufd_access_set_ioas(user, 0);
+	vdev->iommufd_access = user;
+	vdev->iommufd_ictx = ictx;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_bind);
@@ -171,27 +180,14 @@ EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_unbind);
 
 int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 {
-	struct iommufd_access *user;
-
 	lockdep_assert_held(&vdev->dev_set->lock);
 
 	if (!vdev->iommufd_ictx)
 		return -EINVAL;
+	if (!vdev->iommufd_access)
+		return -ENOENT;
 
-	if (!pt_id) {
-		if (vdev->iommufd_access)
-			__vfio_iommufd_access_destroy(vdev);
-		return 0;
-	}
-
-	if (vdev->iommufd_access)
-		return -EBUSY;
-
-	user = iommufd_access_create(vdev->iommufd_ictx, *pt_id, &vfio_user_ops,
-				     vdev);
-	if (IS_ERR(user))
-		return PTR_ERR(user);
-	vdev->iommufd_access = user;
+	iommufd_access_set_ioas(vdev->iommufd_access, *pt_id);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_attach_ioas);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 650d45629647..0e30f2ce27cd 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -40,9 +40,10 @@ enum {
 };
 
 struct iommufd_access *
-iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
+iommufd_access_create(struct iommufd_ctx *ictx,
 		      const struct iommufd_access_ops *ops, void *data);
 void iommufd_access_destroy(struct iommufd_access *access);
+int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
-- 
2.39.1

