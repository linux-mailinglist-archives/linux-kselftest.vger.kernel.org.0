Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72FF7A9BCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjIUTEc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 15:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjIUTEI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789C62401D;
        Thu, 21 Sep 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318592; x=1726854592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B3NNfxXC9D9nYIZ82vKeSoCFdeMfCZ9IK/Gu9oTJru8=;
  b=erXvAtNd24T15ogaf90sEt4zqrx2D+rc9SAA01gbfyVpqetF7jM4SvRu
   3ShjnE9K9EMOxh+CwIgn2t72FVFGCpYUvey1XDhnzfQYWMgxoolt2gCXv
   zbjVrR+H2LyNtSmiqaXxA2WWJfiKNsye4yATmX/pOriYNTM8ax8Er6xm7
   k8WLu4Q7aWnVan5yFDfIa8ILEzn+7BLfeJ/GFS+lpHFTIe79y/uGgJd8r
   e3tQV4uZyI6LJOVdhC376Vao2KMLWPVtrkrWy6D9Wt6I9hhZ0aN5gw4Dv
   WSvQZPdhOWEgKQVfjWC/ryQjkGm6cslWpgA9Ov/JksIVitVausxbmJY5z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832872"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832872"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649536"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649536"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:12 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v4 07/17] iommufd: Add user-managed hw_pagetable support
Date:   Thu, 21 Sep 2023 00:51:28 -0700
Message-Id: <20230921075138.124099-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Add a parent hw_pagetable pointer for user-managed hw_pagetables. Similar
to the ioas->mutex, add another mutex in the kernel-managed hw_pagetable
to serialize associating user-managed hw_pagetable allocations. Then, add
user_managed flag too in the struct to ease identifying a HWPT.

Also, add a new allocator iommufd_user_managed_hwpt_alloc() and two pairs
of cleanup functions iommufd_user_managed_hwpt_destroy/abort().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 112 +++++++++++++++++++++++-
 drivers/iommu/iommufd/iommufd_private.h |   6 ++
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index b2af68776877..dc3e11a23acf 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,6 +8,17 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static void iommufd_user_managed_hwpt_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_hw_pagetable *hwpt =
+		container_of(obj, struct iommufd_hw_pagetable, obj);
+
+	if (hwpt->domain)
+		iommu_domain_free(hwpt->domain);
+
+	refcount_dec(&hwpt->parent->obj.users);
+}
+
 static void iommufd_kernel_managed_hwpt_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_hw_pagetable *hwpt =
@@ -32,6 +43,17 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	container_of(obj, struct iommufd_hw_pagetable, obj)->destroy(obj);
 }
 
+static void iommufd_user_managed_hwpt_abort(struct iommufd_object *obj)
+{
+	struct iommufd_hw_pagetable *hwpt =
+		container_of(obj, struct iommufd_hw_pagetable, obj);
+
+	/* The parent->mutex must be held until finalize is called. */
+	lockdep_assert_held(&hwpt->parent->mutex);
+
+	iommufd_hw_pagetable_destroy(obj);
+}
+
 static void iommufd_kernel_managed_hwpt_abort(struct iommufd_object *obj)
 {
 	struct iommufd_hw_pagetable *hwpt =
@@ -52,6 +74,82 @@ void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
 	container_of(obj, struct iommufd_hw_pagetable, obj)->abort(obj);
 }
 
+/**
+ * iommufd_user_managed_hwpt_alloc() - Get a user-managed hw_pagetable
+ * @ictx: iommufd context
+ * @pt_obj: Parent object to an HWPT to associate the domain with
+ * @idev: Device to get an iommu_domain for
+ * @flags: Flags from userspace
+ * @hwpt_type: Requested type of hw_pagetable
+ * @user_data: user_data pointer
+ * @dummy: never used
+ *
+ * Allocate a new iommu_domain (must be IOMMU_DOMAIN_NESTED) and return it as
+ * a user-managed hw_pagetable.
+ */
+static struct iommufd_hw_pagetable *
+iommufd_user_managed_hwpt_alloc(struct iommufd_ctx *ictx,
+				struct iommufd_object *pt_obj,
+				struct iommufd_device *idev,
+				u32 flags,
+				enum iommu_hwpt_type hwpt_type,
+				struct iommu_user_data *user_data,
+				bool dummy)
+{
+	struct iommufd_hw_pagetable *parent =
+		container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	if (!user_data)
+		return ERR_PTR(-EINVAL);
+	if (parent->auto_domain)
+		return ERR_PTR(-EINVAL);
+	if (!parent->nest_parent)
+		return ERR_PTR(-EINVAL);
+	if (hwpt_type == IOMMU_HWPT_TYPE_DEFAULT)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	lockdep_assert_held(&parent->mutex);
+
+	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
+	if (IS_ERR(hwpt))
+		return hwpt;
+
+	refcount_inc(&parent->obj.users);
+	hwpt->parent = parent;
+	hwpt->user_managed = true;
+	hwpt->abort = iommufd_user_managed_hwpt_abort;
+	hwpt->destroy = iommufd_user_managed_hwpt_destroy;
+
+	hwpt->domain = ops->domain_alloc_user(idev->dev, flags, hwpt_type,
+					      parent->domain, user_data);
+	if (IS_ERR(hwpt->domain)) {
+		rc = PTR_ERR(hwpt->domain);
+		hwpt->domain = NULL;
+		goto out_abort;
+	}
+
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+	/* Driver is buggy by missing cache_invalidate_user in domain_ops */
+	if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+	return hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
+
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 {
 	if (hwpt->enforce_cache_coherency)
@@ -112,10 +210,12 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
 	if (IS_ERR(hwpt))
 		return hwpt;
 
+	mutex_init(&hwpt->mutex);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
+	hwpt->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 	hwpt->abort = iommufd_kernel_managed_hwpt_abort;
 	hwpt->destroy = iommufd_kernel_managed_hwpt_destroy;
 
@@ -194,8 +294,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 					u32 flags, enum iommu_hwpt_type type,
 					struct iommu_user_data *user_data,
 					bool flag);
+	struct iommufd_hw_pagetable *hwpt, *parent;
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
-	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
 	struct iommufd_ioas *ioas;
@@ -221,6 +321,16 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		mutex = &ioas->mutex;
 		alloc_fn = iommufd_hw_pagetable_alloc;
 		break;
+	case IOMMUFD_OBJ_HW_PAGETABLE:
+		parent = container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+		/* No user-managed HWPT on top of an user-managed one */
+		if (parent->user_managed) {
+			rc = -EINVAL;
+			goto out_put_pt;
+		}
+		mutex = &parent->mutex;
+		alloc_fn = iommufd_user_managed_hwpt_alloc;
+		break;
 	default:
 		rc = -EINVAL;
 		goto out_put_pt;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e4d06ae6b0c5..34940596c2c2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -237,12 +237,18 @@ struct iommufd_hw_pagetable {
 	void (*abort)(struct iommufd_object *obj);
 	void (*destroy)(struct iommufd_object *obj);
 
+	bool user_managed : 1;
 	union {
+		struct { /* user-managed */
+			struct iommufd_hw_pagetable *parent;
+		};
 		struct { /* kernel-managed */
 			struct iommufd_ioas *ioas;
+			struct mutex mutex;
 			bool auto_domain : 1;
 			bool enforce_cache_coherency : 1;
 			bool msi_cookie : 1;
+			bool nest_parent : 1;
 			/* Head at iommufd_ioas::hwpt_list */
 			struct list_head hwpt_item;
 		};
-- 
2.34.1

