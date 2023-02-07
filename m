Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9B68E2C5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBGVUg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBGVUf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:35 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68E34022;
        Tue,  7 Feb 2023 13:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5zi+hnHRNpfht6ev1WcBu6Dz1u1UQ2b5w0PZz06XxE/8UjisCot/90dbX6mJlGCjZRUZy+K9qlJSin6yCOhBYwo65Da48+dDr089LjG9ZsUO7C8Lsdc88+kZJ39lQieIG6oG47wFxEn7b3b4hYoLt0qiKuSkGVNIgmPrhCTI+hqGdgP1h+bBgyUpVXhes4N8YcCqxZuCG0mMLBf94KoJlhvF9l3njv49rNRuG88D5tJaSoy6g/p2XFH7OHJYHcroVqkampl0+1jtVHY4npKzHXl94MJ37ES11oft1v0NqTUydBgOXOrxKrJWIc8qwaj9kJNz6eK3eQMv48A8yQoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV2XSDEIXApMbPuXz9ghwKmgvmd7R2MJVbmpG9mKA1s=;
 b=eS//LVCVSMq9Z3FmNxh1c2gWeSJ8m4wJZjgZvs4qfAGGFv1HNvqwxRvXK8gxduJcRO8/1kBukkepwV07F3+JXh6rBjePIteV/gnZJyQI+IxDwBty1fSj+oZuLIEs/E6G1VwmrPvmw7kbsRBO0gTsD74PLCaWqNhdMJg6JNH2Yn0/urq7c5Mj1HhEl2vVTA+fPhNml5JM3Y3FpXv+nNrepWjtTfDHl/fZZnnbMT9Bo79eNn1077G2ccHIaoUNBPO5oYr7X22/a2cbYfgmEF3wqRaQZJgfY42nlCURS7cWWFt+XZMvQTgXxUEgj66NR1iZghk3waiRE66H2fRA3ZuPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV2XSDEIXApMbPuXz9ghwKmgvmd7R2MJVbmpG9mKA1s=;
 b=CNN0YruCGdN73TKV16syWJyv78hHkVaII29ci2vnl/TsLfsVK7wGVoP1Ijz4vZAfW6hJON9a74FIVVQ01gBevuq5s9ZlZl8nfRW24qCU8YNKYEydUUK89Zvv40ADlzNeU78l9++/4Giwba5T718T4BKM0a/Ee/iE3/EFrTdMza+8/tbedqui7Kl9iWmqSvxjtvAaZNQ3pVGKmA7ybGL3SwcYb6ENGawFutZkahQA/gAwVk/2Wd/Vi9HeupJU0sJWwSC6jhRsbnSXfj7ikemzZBVYEUfYVNezjnWyXPbk6Fi6auBV+AdTOUx8zy7CNa2xKmo3syy9OEOTsj+kSzJO2A==
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 21:20:31 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::42) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Tue, 7 Feb 2023 21:20:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:21 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:21 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 03/10] iommufd: Create access in vfio_iommufd_emulated_bind()
Date:   Tue, 7 Feb 2023 13:17:55 -0800
Message-ID: <6083ba9a3c1d92baf1f324d4748333d80d3de830.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b0ae63-2dea-4e32-0841-08db09512462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9b7OYAuB444f1UbMQOGKF0oqjYRnrZzJHtNS1ThgIi7bN1jN56p9pbC5zPi6YjhlCPPyAQXFXqJDs2GL5TCrGprld/Ksuaa4DqUYrvRZWLW0395LO1tC7uqoaVUvtsvtcBLUowjj9S5Le277n+ycuxr2XAx95ljkRI371wOVUNap3EkTliXF5YN+ij5wgbjThQsz0FW1AIgMc9htG5jmLP1a9dBv3XFc2mYNAmKkMC1HRy3DRAkmarrd84iKdsQ3BqxeuzqnSo2XLYiXqrDsH3hYdta+CIyUpzhczbmL/OD2WnQMGdT3F/QORYTSsi+XR83KzCom0fHcYLY84jE3yYZ0Am16YNP4U8yL1JWPtucBwtVVxXrwT9yOBMmW9DD899mrvA3HFnsdoC+pheo9fEIwF7ySKVafIF8nEfjgNtU7pVQ1yrRgRXEI7vsIF6uCCaJwJ7kAiiz5LO2WDJ0wEcDnyWuKqOJ3RzsWN7kqdpDblhO03TFZLwOXma0C6mbOJmB+V/XjARusGEvLlwdum2VsqWDqs3G3ctEVjHV196WUbQ1VhhDgFJggomsR1pzggWfSDUxTbP9TQx1WefpJ2WJ9NuDjCR0tVrzfWi1BrLEmdOa2k/PQNZLOlTP32lJeC88Kmwi+dpbTjG5UEn9qK7CEa5gPwcFU2m5Psupp2ZYLLW0yN4gBiZzRnAisprOWXVXCYMCkmcfSHbQwbWjpg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(86362001)(7696005)(54906003)(6666004)(316002)(30864003)(70586007)(8676002)(7416002)(2906002)(5660300002)(70206006)(4326008)(8936002)(41300700001)(110136005)(36860700001)(82740400003)(7636003)(40480700001)(26005)(356005)(426003)(83380400001)(336012)(478600001)(2616005)(186003)(47076005)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:30.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b0ae63-2dea-4e32-0841-08db09512462
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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
 drivers/vfio/iommufd.c                  |  27 ++++---
 include/linux/iommufd.h                 |   3 +-
 5 files changed, 97 insertions(+), 39 deletions(-)

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
index 026f81a87dd7..dc9feab73db7 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -141,10 +141,19 @@ static const struct iommufd_access_ops vfio_user_ops = {
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
@@ -168,22 +177,14 @@ EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_unbind);
 
 int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 {
-	struct iommufd_access *user;
-
 	lockdep_assert_held(&vdev->dev_set->lock);
 
 	if (!vdev->iommufd_ictx)
 		return -EINVAL;
+	if (!vdev->iommufd_access)
+		return -ENOENT;
 
-	if (vdev->iommufd_access)
-		return -EBUSY;
-
-	user = iommufd_access_create(vdev->iommufd_ictx, *pt_id, &vfio_user_ops,
-				     vdev);
-	if (IS_ERR(user))
-		return PTR_ERR(user);
-	vdev->iommufd_access = user;
-	return 0;
+	return iommufd_access_set_ioas(vdev->iommufd_access, *pt_id);
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_attach_ioas);
 
@@ -194,6 +195,6 @@ void vfio_iommufd_emulated_detach_ioas(struct vfio_device *vdev)
 	if (!vdev->iommufd_ictx || !vdev->iommufd_access)
 		return;
 
-	__vfio_iommufd_access_destroy(vdev);
+	iommufd_access_set_ioas(vdev->iommufd_access, 0);
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_emulated_detach_ioas);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 9672cf839687..f9bac6f9db2e 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -46,9 +46,10 @@ enum {
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

