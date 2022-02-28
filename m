Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78084C6485
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiB1IOH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 03:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiB1IOG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 03:14:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B92E3A735;
        Mon, 28 Feb 2022 00:13:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9E86113D;
        Mon, 28 Feb 2022 08:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5253EC36AE5;
        Mon, 28 Feb 2022 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646036007;
        bh=gy7a+rbxsqAtXGvFj8lJRy3faq2q3d+XiqclILKcfZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxeE4A+ez/E9K16exwc6BCRyxobeFgMScBswslVs2FFlp5jA8RrgCZh0pU2LqnW8H
         WOElUDWgffQ5DsN4A0BrVu5g0cbuxxaEtRqjqDiJ9Mc+SZFw8TbwJcvpSHOrJs9Gdg
         FsvMdf1oNFpxDyFMTfoi+dvVdpcgF0JXVVs9cPzV5Du/aaBUoI5Fhrv15idg8EBMOa
         1QlAJeMDWU0r9whhdj90eG50lg81xZZD7j0ukPkiBb5ajGGhNkjkkD7BdIO/mEfbCb
         HF9orF8gHUQR8wqWxI8dp4xg82fFQKD7ob05MYhDQg8BtCuwGrg4VIA+YEdaZi3AJe
         xtQwNMOAPT4/A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, gregkh@linuxfoundation.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 05/13] mm/damon/sysfs: Support the physical address space monitoring
Date:   Mon, 28 Feb 2022 08:13:06 +0000
Message-Id: <20220228081314.5770-6-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228081314.5770-1-sj@kernel.org>
References: <20220228081314.5770-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit makes DAMON sysfs interface supports the physical address
space monitoring.  Specifically, this commit adds support of the initial
monitoring regions set feature by adding 'regions' directory under each
target directory and makes context operations file to receive 'paddr' in
addition to 'vaddr'.

As a result, the files hierarchy becomes as below:

    /sys/kernel/mm/damon/admin
    │ kdamonds/nr_kdamonds
    │ │ 0/state,pid
    │ │ │ contexts/nr_contexts
    │ │ │ │ 0/operations
    │ │ │ │ │ monitoring_attrs/
    │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ targets/nr_targets
    │ │ │ │ │ │ 0/pid_target
    │ │ │ │ │ │ │ regions/nr_regions    <- NEW DIRECTORY
    │ │ │ │ │ │ │ │ 0/start,end
    │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 276 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 271 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 9221c93db6cc..968a4ba8e81b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -113,12 +113,220 @@ static struct kobj_type damon_sysfs_ul_range_ktype = {
 	.default_groups = damon_sysfs_ul_range_groups,
 };
 
+/*
+ * init region directory
+ */
+
+struct damon_sysfs_region {
+	struct kobject kobj;
+	unsigned long start;
+	unsigned long end;
+};
+
+static struct damon_sysfs_region *damon_sysfs_region_alloc(
+		unsigned long start,
+		unsigned long end)
+{
+	struct damon_sysfs_region *region = kmalloc(sizeof(*region),
+			GFP_KERNEL);
+
+	if (!region)
+		return NULL;
+	region->kobj = (struct kobject){};
+	region->start = start;
+	region->end = end;
+	return region;
+}
+
+static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_region *region = container_of(kobj,
+			struct damon_sysfs_region, kobj);
+
+	return sysfs_emit(buf, "%lu\n", region->start);
+}
+
+static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_region *region = container_of(kobj,
+			struct damon_sysfs_region, kobj);
+	int err = kstrtoul(buf, 0, &region->start);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_region *region = container_of(kobj,
+			struct damon_sysfs_region, kobj);
+
+	return sysfs_emit(buf, "%lu\n", region->end);
+}
+
+static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_region *region = container_of(kobj,
+			struct damon_sysfs_region, kobj);
+	int err = kstrtoul(buf, 0, &region->end);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_region_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_region, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_region_start_attr =
+		__ATTR_RW_MODE(start, 0600);
+
+static struct kobj_attribute damon_sysfs_region_end_attr =
+		__ATTR_RW_MODE(end, 0600);
+
+static struct attribute *damon_sysfs_region_attrs[] = {
+	&damon_sysfs_region_start_attr.attr,
+	&damon_sysfs_region_end_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_region);
+
+static struct kobj_type damon_sysfs_region_ktype = {
+	.release = damon_sysfs_region_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_region_groups,
+};
+
+/*
+ * init_regions directory
+ */
+
+struct damon_sysfs_regions {
+	struct kobject kobj;
+	struct damon_sysfs_region **regions_arr;
+	int nr;
+};
+
+static struct damon_sysfs_regions *damon_sysfs_regions_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_regions), GFP_KERNEL);
+}
+
+static void damon_sysfs_regions_rm_dirs(struct damon_sysfs_regions *regions)
+{
+	struct damon_sysfs_region **regions_arr = regions->regions_arr;
+	int i;
+
+	for (i = 0; i < regions->nr; i++)
+		kobject_put(&regions_arr[i]->kobj);
+	regions->nr = 0;
+	kfree(regions_arr);
+	regions->regions_arr = NULL;
+}
+
+static int damon_sysfs_regions_add_dirs(struct damon_sysfs_regions *regions,
+		int nr_regions)
+{
+	struct damon_sysfs_region **regions_arr, *region;
+	int err, i;
+
+	damon_sysfs_regions_rm_dirs(regions);
+	if (!nr_regions)
+		return 0;
+
+	regions_arr = kmalloc_array(nr_regions, sizeof(*regions_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!regions_arr)
+		return -ENOMEM;
+	regions->regions_arr = regions_arr;
+
+	for (i = 0; i < nr_regions; i++) {
+		region = damon_sysfs_region_alloc(0, 0);
+		if (!region) {
+			damon_sysfs_regions_rm_dirs(regions);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&region->kobj,
+				&damon_sysfs_region_ktype, &regions->kobj,
+				"%d", i);
+		if (err) {
+			kobject_put(&region->kobj);
+			damon_sysfs_regions_rm_dirs(regions);
+			return err;
+		}
+
+		regions_arr[i] = region;
+		regions->nr++;
+	}
+	return 0;
+}
+
+static ssize_t nr_regions_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_regions *regions = container_of(kobj,
+			struct damon_sysfs_regions, kobj);
+
+	return sysfs_emit(buf, "%d\n", regions->nr);
+}
+
+static ssize_t nr_regions_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_regions *regions = container_of(kobj,
+			struct damon_sysfs_regions, kobj);
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_regions_add_dirs(regions, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_regions_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_regions, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_regions_nr_attr =
+		__ATTR_RW_MODE(nr_regions, 0600);
+
+static struct attribute *damon_sysfs_regions_attrs[] = {
+	&damon_sysfs_regions_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_regions);
+
+static struct kobj_type damon_sysfs_regions_ktype = {
+	.release = damon_sysfs_regions_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_regions_groups,
+};
+
 /*
  * target directory
  */
 
 struct damon_sysfs_target {
 	struct kobject kobj;
+	struct damon_sysfs_regions *regions;
 	int pid;
 };
 
@@ -127,6 +335,29 @@ static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
 	return kzalloc(sizeof(struct damon_sysfs_target), GFP_KERNEL);
 }
 
+static int damon_sysfs_target_add_dirs(struct damon_sysfs_target *target)
+{
+	struct damon_sysfs_regions *regions = damon_sysfs_regions_alloc();
+	int err;
+
+	if (!regions)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&regions->kobj, &damon_sysfs_regions_ktype,
+			&target->kobj, "regions");
+	if (err)
+		kobject_put(&regions->kobj);
+	else
+		target->regions = regions;
+	return err;
+}
+
+static void damon_sysfs_target_rm_dirs(struct damon_sysfs_target *target)
+{
+	damon_sysfs_regions_rm_dirs(target->regions);
+	kobject_put(&target->regions->kobj);
+}
+
 static ssize_t pid_target_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -188,8 +419,10 @@ static void damon_sysfs_targets_rm_dirs(struct damon_sysfs_targets *targets)
 	struct damon_sysfs_target **targets_arr = targets->targets_arr;
 	int i;
 
-	for (i = 0; i < targets->nr; i++)
+	for (i = 0; i < targets->nr; i++) {
+		damon_sysfs_target_rm_dirs(targets_arr[i]);
 		kobject_put(&targets_arr[i]->kobj);
+	}
 	targets->nr = 0;
 	kfree(targets_arr);
 	targets->targets_arr = NULL;
@@ -224,6 +457,10 @@ static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,
 		if (err)
 			goto out;
 
+		err = damon_sysfs_target_add_dirs(target);
+		if (err)
+			goto out;
+
 		targets_arr[i] = target;
 		targets->nr++;
 	}
@@ -608,9 +845,6 @@ static ssize_t operations_store(struct kobject *kobj,
 
 	for (id = 0; id < NR_DAMON_OPS; id++) {
 		if (sysfs_streq(buf, damon_sysfs_ops_strs[id])) {
-			/* Support only vaddr */
-			if (id != DAMON_OPS_VADDR)
-				return -EINVAL;
 			context->ops_id = id;
 			return count;
 		}
@@ -855,10 +1089,37 @@ static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 	}
 }
 
+static int damon_sysfs_set_regions(struct damon_target *t,
+		struct damon_sysfs_regions *sysfs_regions)
+{
+	int i;
+
+	for (i = 0; i < sysfs_regions->nr; i++) {
+		struct damon_sysfs_region *sys_region =
+			sysfs_regions->regions_arr[i];
+		struct damon_region *prev, *r;
+
+		if (sys_region->start > sys_region->end)
+			return -EINVAL;
+		r = damon_new_region(sys_region->start, sys_region->end);
+		if (!r)
+			return -ENOMEM;
+		damon_add_region(r, t);
+		if (damon_nr_regions(t) > 1) {
+			prev = damon_prev_region(r);
+			if (prev->ar.end > r->ar.start) {
+				damon_destroy_region(r, t);
+				return -EINVAL;
+			}
+		}
+	}
+	return 0;
+}
+
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
-	int i;
+	int i, err;
 
 	for (i = 0; i < sysfs_targets->nr; i++) {
 		struct damon_sysfs_target *sys_target =
@@ -877,6 +1138,11 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 			}
 		}
 		damon_add_target(ctx, t);
+		err = damon_sysfs_set_regions(t, sys_target->regions);
+		if (err) {
+			damon_sysfs_destroy_targets(ctx);
+			return err;
+		}
 	}
 	return 0;
 }
-- 
2.17.1

