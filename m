Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683D24C1689
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiBWPWG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbiBWPV4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:21:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEB9A9A40;
        Wed, 23 Feb 2022 07:21:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63742B8207F;
        Wed, 23 Feb 2022 15:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17639C340EB;
        Wed, 23 Feb 2022 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645629684;
        bh=CMZYAfHo/pm0gfAUqpz+mRUPmEAA3uM6BGCVatUyxDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rl9Dx+/EM2d6TCfQjTLHYyqZETp5CE7v2AEk2metIdByevVoiAgzMu1ZNraxlTFcZ
         wmij2d7t/H5mw9hfj6g0wtdtjyux9QZVPXIwPRQNjY4H2pLQnF5oEuqO2k7Xf6RQiQ
         6fNCe2R3O1EgBi8FVxTawTVOuUFtNwUlMokKTSyGdlf1GLiwHDNKeYadUet4Lg4b+X
         KXr8Vyq+0RtxCUs+IlmkHoH9I4KkoHUYyfFNZO52fTxxneioE6zrn3oivTLsgpeTih
         mDjLFJgh1wRDaXkrZf3YRgWfMEBjxn7qxRIBRPdTKCyYW9QwAkDrNvd90N7rh1E2Tj
         MLIPz6N//SHyQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 03/12] mm/damon: Implement a minimal stub for sysfs-based DAMON interface
Date:   Wed, 23 Feb 2022 15:20:42 +0000
Message-Id: <20220223152051.22936-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223152051.22936-1-sj@kernel.org>
References: <20220223152051.22936-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DAMON's debugfs-based user interface served very well, so far.  However,
it unnecessarily depends on debugfs, while DAMON is not aimed to be used
for only debugging.  Also, the interface receives multiple values via
one file.  For example, schemes file receives 18 values separated by
white spaces.  As a result, it is ineffient, hard to be used, and
difficult to be extended.  Especially, keeping backward compatibility of
user space tools is getting only challenging.  It would be better to
implement another reliable and flexible interface and deprecate the
debugfs interface in long term.

To this end, this commit implements a stub of a part of the new user
interface of DAMON using sysfs.  Specifically, this commit implements
the sysfs control parts for virtual address space monitoring.

More specifically, the idea of the new interface is, using directory
hierarchies and making one file for one value.  The hierarchy that this
commit is introducing is as below.  In the below figure,
parents-children relations are represented with indentations, each
directory is having ``/`` suffix, and files in each directory are
separated by comma (",").

    /sys/kernel/mm/damon/admin
    │ kdamonds/nr
    │ │ 0/state,pid
    │ │ │ contexts/nr
    │ │ │ │ 0/operations
    │ │ │ │ │ monitoring_attrs/
    │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ targets/nr
    │ │ │ │ │ │ 0/pid
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

Writing a number <N> to each 'nr' file makes directories of name <0> to
<N-1> in the directory of the 'nr' file.  That's all this commit does.
Writing proper values to relevant files will construct the DAMON
contexts, and writing a special keyword, 'on', to 'state' files for each
kdamond will ask DAMON to start the constructed contexts.

For a short example, using below commands for
monitoring virtual address spaces of a given workload is imaginable:

    # cd /sys/kernel/mm/damon/admin/
    # echo 1 > kdamonds/nr
    # echo 1 > kdamonds/0/contexts/nr
    # echo vaddr > kdamonds/0/contexts/0/damon_type
    # echo 1 > kdamonds/0/contexts/0/targets/nr
    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
    # echo on > kdamonds/0/state

Please note that this commit is implementing only the sysfs part stub as
abovely mentioned.  This commit doesn't implement the special keywords
for 'state' files.  Following commits will do that.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig  |    7 +
 mm/damon/Makefile |    1 +
 mm/damon/sysfs.c  | 1059 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1067 insertions(+)
 create mode 100644 mm/damon/sysfs.c

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 01bad77ad7ae..9b559c76d6dd 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -52,6 +52,13 @@ config DAMON_VADDR_KUNIT_TEST
 
 	  If unsure, say N.
 
+config DAMON_SYSFS
+	bool "DAMON sysfs interface"
+	depends on DAMON && SYSFS
+	help
+	  This builds the sysfs interface for DAMON.  The user space can use
+	  the interface for arbitrary data access monitoring.
+
 config DAMON_DBGFS
 	bool "DAMON debugfs interface"
 	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index aebbf6c14c51..dbf7190b4144 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -3,5 +3,6 @@
 obj-y				:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
+obj-$(CONFIG_DAMON_SYSFS)	+= sysfs.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
new file mode 100644
index 000000000000..e8087ffd924c
--- /dev/null
+++ b/mm/damon/sysfs.c
@@ -0,0 +1,1059 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON sysfs Interface
+ *
+ * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
+ */
+
+#include <linux/damon.h>
+#include <linux/kobject.h>
+#include <linux/pid.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(damon_sysfs_lock);
+
+/*
+ * unsigned long range directory
+ */
+
+struct damon_sysfs_ul_range {
+	struct kobject kobj;
+	unsigned long min;
+	unsigned long max;
+};
+
+static struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
+		unsigned long min,
+		unsigned long max)
+{
+	struct damon_sysfs_ul_range *range = kmalloc(sizeof(*range),
+			GFP_KERNEL);
+
+	if (!range)
+		return NULL;
+	range->kobj = (struct kobject){};
+	range->min = min;
+	range->max = max;
+
+	return range;
+}
+
+static ssize_t damon_sysfs_ul_range_min_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+
+	return sysfs_emit(buf, "%lu\n", range->min);
+}
+
+static ssize_t damon_sysfs_ul_range_min_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+	unsigned long min;
+	int err;
+
+	err = kstrtoul(buf, 0, &min);
+	if (err)
+		return -EINVAL;
+
+	range->min = min;
+	return count;
+}
+
+static ssize_t damon_sysfs_ul_range_max_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+
+	return sysfs_emit(buf, "%lu\n", range->max);
+}
+
+static ssize_t damon_sysfs_ul_range_max_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+	unsigned long max;
+	int err;
+
+	err = kstrtoul(buf, 0, &max);
+	if (err)
+		return -EINVAL;
+
+	range->max = max;
+	return count;
+}
+
+static void damon_sysfs_ul_range_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_ul_range, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_ul_range_min_attr =
+		__ATTR(min, 0600, damon_sysfs_ul_range_min_show,
+				damon_sysfs_ul_range_min_store);
+
+static struct kobj_attribute damon_sysfs_ul_range_max_attr =
+		__ATTR(max, 0600, damon_sysfs_ul_range_max_show,
+				damon_sysfs_ul_range_max_store);
+
+static struct attribute *damon_sysfs_ul_range_attrs[] = {
+	&damon_sysfs_ul_range_min_attr.attr,
+	&damon_sysfs_ul_range_max_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_ul_range);
+
+static struct kobj_type damon_sysfs_ul_range_ktype = {
+	.release = damon_sysfs_ul_range_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_ul_range_groups,
+};
+
+/*
+ * target directory
+ */
+
+struct damon_sysfs_target {
+	struct kobject kobj;
+	int pid;
+};
+
+static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_target), GFP_KERNEL);
+}
+
+static ssize_t damon_sysfs_target_pid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+
+	return sysfs_emit(buf, "%d\n", target->pid);
+}
+
+static ssize_t damon_sysfs_target_pid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+	int err = kstrtoint(buf, 0, &target->pid);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_target_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_target, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_target_pid_attr = __ATTR(pid, 0600,
+		damon_sysfs_target_pid_show, damon_sysfs_target_pid_store);
+
+static struct attribute *damon_sysfs_target_attrs[] = {
+	&damon_sysfs_target_pid_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_target);
+
+static struct kobj_type damon_sysfs_target_ktype = {
+	.release = damon_sysfs_target_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_target_groups,
+};
+
+/*
+ * targets directory
+ */
+
+struct damon_sysfs_targets {
+	struct kobject kobj;
+	struct damon_sysfs_target **targets_arr;
+	int nr;
+};
+
+static struct damon_sysfs_targets *damon_sysfs_targets_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_targets), GFP_KERNEL);
+}
+
+static void damon_sysfs_targets_rm_dirs(struct damon_sysfs_targets *targets)
+{
+	struct damon_sysfs_target **targets_arr = targets->targets_arr;
+	int i;
+
+	for (i = 0; i < targets->nr; i++)
+		kobject_put(&targets_arr[i]->kobj);
+	targets->nr = 0;
+	kfree(targets_arr);
+	targets->targets_arr = NULL;
+}
+
+static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,
+		int nr_targets)
+{
+	struct damon_sysfs_target **targets_arr, *target;
+	int err, i;
+
+	damon_sysfs_targets_rm_dirs(targets);
+	if (!nr_targets)
+		return 0;
+
+	targets_arr = kmalloc_array(nr_targets, sizeof(*targets_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!targets_arr)
+		return -ENOMEM;
+	targets->targets_arr = targets_arr;
+
+	for (i = 0; i < nr_targets; i++) {
+		target = damon_sysfs_target_alloc();
+		if (!target) {
+			damon_sysfs_targets_rm_dirs(targets);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&target->kobj,
+				&damon_sysfs_target_ktype, &targets->kobj,
+				"%d", i);
+		if (err)
+			goto out;
+
+		targets_arr[i] = target;
+		targets->nr++;
+	}
+	return 0;
+
+out:
+	damon_sysfs_targets_rm_dirs(targets);
+	kobject_put(&target->kobj);
+	return err;
+}
+
+static ssize_t damon_sysfs_targets_nr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_targets *targets = container_of(kobj,
+			struct damon_sysfs_targets, kobj);
+
+	return sysfs_emit(buf, "%d\n", targets->nr);
+}
+
+static ssize_t damon_sysfs_targets_nr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_targets *targets = container_of(kobj,
+			struct damon_sysfs_targets, kobj);
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_targets_add_dirs(targets, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_targets_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_targets, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_targets_nr_attr = __ATTR(nr, 0600,
+		damon_sysfs_targets_nr_show, damon_sysfs_targets_nr_store);
+
+static struct attribute *damon_sysfs_targets_attrs[] = {
+	&damon_sysfs_targets_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_targets);
+
+static struct kobj_type damon_sysfs_targets_ktype = {
+	.release = damon_sysfs_targets_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_targets_groups,
+};
+
+/*
+ * intervals directory
+ */
+
+struct damon_sysfs_intervals {
+	struct kobject kobj;
+	unsigned long sample_us;
+	unsigned long aggr_us;
+	unsigned long update_us;
+};
+
+static struct damon_sysfs_intervals *damon_sysfs_intervals_alloc(
+		unsigned long sample_us, unsigned long aggr_us,
+		unsigned long update_us)
+{
+	struct damon_sysfs_intervals *intervals = kmalloc(sizeof(*intervals),
+			GFP_KERNEL);
+
+	if (!intervals)
+		return NULL;
+
+	intervals->kobj = (struct kobject){};
+	intervals->sample_us = sample_us;
+	intervals->aggr_us = aggr_us;
+	intervals->update_us = update_us;
+	return intervals;
+}
+
+static ssize_t damon_sysfs_intervals_sample_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+
+	return sysfs_emit(buf, "%lu\n", intervals->sample_us);
+}
+
+static ssize_t damon_sysfs_intervals_sample_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+	unsigned long us;
+	int err = kstrtoul(buf, 0, &us);
+
+	if (err)
+		return -EINVAL;
+
+	intervals->sample_us = us;
+	return count;
+}
+
+static ssize_t damon_sysfs_intervals_aggr_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+
+	return sysfs_emit(buf, "%lu\n", intervals->aggr_us);
+}
+
+static ssize_t damon_sysfs_intervals_aggr_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+	unsigned long us;
+	int err = kstrtoul(buf, 0, &us);
+
+	if (err)
+		return -EINVAL;
+
+	intervals->aggr_us = us;
+	return count;
+}
+
+static ssize_t damon_sysfs_intervals_update_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+
+	return sysfs_emit(buf, "%lu\n", intervals->update_us);
+}
+
+static ssize_t damon_sysfs_intervals_update_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+	unsigned long us;
+	int err = kstrtoul(buf, 0, &us);
+
+	if (err)
+		return -EINVAL;
+
+	intervals->update_us = us;
+	return count;
+}
+
+static void damon_sysfs_intervals_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_intervals, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_intervals_sample_us_attr =
+		__ATTR(sample_us, 0600,
+				damon_sysfs_intervals_sample_us_show,
+				damon_sysfs_intervals_sample_us_store);
+
+static struct kobj_attribute damon_sysfs_intervals_aggr_us_attr =
+		__ATTR(aggr_us, 0600,
+				damon_sysfs_intervals_aggr_us_show,
+				damon_sysfs_intervals_aggr_us_store);
+
+static struct kobj_attribute damon_sysfs_intervals_update_us_attr =
+		__ATTR(update_us, 0600,
+				damon_sysfs_intervals_update_us_show,
+				damon_sysfs_intervals_update_us_store);
+
+static struct attribute *damon_sysfs_intervals_attrs[] = {
+	&damon_sysfs_intervals_sample_us_attr.attr,
+	&damon_sysfs_intervals_aggr_us_attr.attr,
+	&damon_sysfs_intervals_update_us_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_intervals);
+
+static struct kobj_type damon_sysfs_intervals_ktype = {
+	.release = damon_sysfs_intervals_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_intervals_groups,
+};
+
+/*
+ * monitoring_attrs directory
+ */
+
+struct damon_sysfs_attrs {
+	struct kobject kobj;
+	struct damon_sysfs_intervals *intervals;
+	struct damon_sysfs_ul_range *nr_regions_range;
+};
+
+static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
+{
+	struct damon_sysfs_attrs *attrs = kmalloc(sizeof(*attrs), GFP_KERNEL);
+
+	if (!attrs)
+		return NULL;
+	attrs->kobj = (struct kobject){};
+	return attrs;
+}
+
+static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
+{
+	struct damon_sysfs_intervals *intervals;
+	struct damon_sysfs_ul_range *nr_regions_range;
+	int err;
+
+	intervals = damon_sysfs_intervals_alloc(5000, 100000, 60000000);
+	if (!intervals)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&intervals->kobj,
+			&damon_sysfs_intervals_ktype, &attrs->kobj,
+			"intervals");
+	if (err)
+		goto put_intervals_out;
+	attrs->intervals = intervals;
+
+	nr_regions_range = damon_sysfs_ul_range_alloc(10, 1000);
+	if (!nr_regions_range)
+		goto put_intervals_out;
+
+	err = kobject_init_and_add(&nr_regions_range->kobj,
+			&damon_sysfs_ul_range_ktype, &attrs->kobj,
+			"nr_regions");
+	if (err)
+		goto put_nr_regions_intervals_out;
+	attrs->nr_regions_range = nr_regions_range;
+	return 0;
+
+put_nr_regions_intervals_out:
+	kobject_put(&nr_regions_range->kobj);
+	attrs->nr_regions_range = NULL;
+put_intervals_out:
+	kobject_put(&intervals->kobj);
+	attrs->intervals = NULL;
+	return err;
+}
+
+static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
+{
+	kobject_put(&attrs->nr_regions_range->kobj);
+	kobject_put(&attrs->intervals->kobj);
+}
+
+static void damon_sysfs_attrs_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_attrs, kobj));
+}
+
+static struct attribute *damon_sysfs_attrs_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_attrs);
+
+static struct kobj_type damon_sysfs_attrs_ktype = {
+	.release = damon_sysfs_attrs_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_attrs_groups,
+};
+
+/*
+ * context directory
+ */
+
+/* This should match with enum damon_ops_id */
+static const char * const damon_sysfs_ops_strs[] = {
+	"vaddr",
+	"paddr",
+};
+
+struct damon_sysfs_context {
+	struct kobject kobj;
+	enum damon_ops_id ops_id;
+	struct damon_sysfs_attrs *attrs;
+	struct damon_sysfs_targets *targets;
+};
+
+static struct damon_sysfs_context *damon_sysfs_context_alloc(
+		enum damon_ops_id ops_id)
+{
+	struct damon_sysfs_context *context = kmalloc(sizeof(*context),
+				GFP_KERNEL);
+
+	if (!context)
+		return NULL;
+	context->kobj = (struct kobject){};
+	context->ops_id = ops_id;
+	return context;
+}
+
+static int damon_sysfs_context_set_attrs(struct damon_sysfs_context *context)
+{
+	struct damon_sysfs_attrs *attrs = damon_sysfs_attrs_alloc();
+	int err;
+
+	if (!attrs)
+		return -ENOMEM;
+	err = kobject_init_and_add(&attrs->kobj, &damon_sysfs_attrs_ktype,
+			&context->kobj, "monitoring_attrs");
+	if (err)
+		goto out;
+	err = damon_sysfs_attrs_add_dirs(attrs);
+	if (err)
+		goto out;
+	context->attrs = attrs;
+	return 0;
+
+out:
+	kobject_put(&attrs->kobj);
+	return err;
+}
+
+static int damon_sysfs_context_set_targets(struct damon_sysfs_context *context)
+{
+	struct damon_sysfs_targets *targets = damon_sysfs_targets_alloc();
+	int err;
+
+	if (!targets)
+		return -ENOMEM;
+	err = kobject_init_and_add(&targets->kobj, &damon_sysfs_targets_ktype,
+			&context->kobj, "targets");
+	if (err) {
+		kobject_put(&targets->kobj);
+		return err;
+	}
+	context->targets = targets;
+	return 0;
+}
+
+static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
+{
+	int err;
+
+	err = damon_sysfs_context_set_attrs(context);
+	if (err)
+		return err;
+
+	err = damon_sysfs_context_set_targets(context);
+	if (err)
+		goto put_attrs_out;
+
+	return 0;
+
+put_attrs_out:
+	kobject_put(&context->attrs->kobj);
+	context->attrs = NULL;
+	return err;
+}
+
+static void damon_sysfs_context_rm_dirs(struct damon_sysfs_context *context)
+{
+	damon_sysfs_attrs_rm_dirs(context->attrs);
+	kobject_put(&context->attrs->kobj);
+	damon_sysfs_targets_rm_dirs(context->targets);
+	kobject_put(&context->targets->kobj);
+}
+
+static ssize_t damon_sysfs_context_operations_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+
+	return sysfs_emit(buf, "%s\n", damon_sysfs_ops_strs[context->ops_id]);
+}
+
+static ssize_t damon_sysfs_context_operations_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+
+	if (sysfs_streq(buf, damon_sysfs_ops_strs[DAMON_OPS_VADDR])) {
+		context->ops_id = DAMON_OPS_VADDR;
+		return count;
+	}
+	return -EINVAL;
+}
+
+static void damon_sysfs_context_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_context, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_context_operations_attr = __ATTR(
+		operations, 0600, damon_sysfs_context_operations_show,
+		damon_sysfs_context_operations_store);
+
+static struct attribute *damon_sysfs_context_attrs[] = {
+	&damon_sysfs_context_operations_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_context);
+
+static struct kobj_type damon_sysfs_context_ktype = {
+	.release = damon_sysfs_context_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_context_groups,
+};
+
+/*
+ * contexts directory
+ */
+
+struct damon_sysfs_contexts {
+	struct kobject kobj;
+	struct damon_sysfs_context **contexts_arr;
+	int nr;
+};
+
+static struct damon_sysfs_contexts *damon_sysfs_contexts_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_contexts), GFP_KERNEL);
+}
+
+static void damon_sysfs_contexts_rm_dirs(struct damon_sysfs_contexts *contexts)
+{
+	struct damon_sysfs_context **contexts_arr = contexts->contexts_arr;
+	int i;
+
+	for (i = 0; i < contexts->nr; i++) {
+		damon_sysfs_context_rm_dirs(contexts_arr[i]);
+		kobject_put(&contexts_arr[i]->kobj);
+	}
+	contexts->nr = 0;
+	kfree(contexts_arr);
+	contexts->contexts_arr = NULL;
+}
+
+static int damon_sysfs_contexts_add_dirs(struct damon_sysfs_contexts *contexts,
+		int nr_contexts)
+{
+	struct damon_sysfs_context **contexts_arr, *context;
+	int err, i;
+
+	damon_sysfs_contexts_rm_dirs(contexts);
+	if (!nr_contexts)
+		return 0;
+
+	contexts_arr = kmalloc_array(nr_contexts, sizeof(*contexts_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!contexts_arr)
+		return -ENOMEM;
+	contexts->contexts_arr = contexts_arr;
+
+	for (i = 0; i < nr_contexts; i++) {
+		context = damon_sysfs_context_alloc(DAMON_OPS_VADDR);
+		if (!context) {
+			damon_sysfs_contexts_rm_dirs(contexts);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&context->kobj,
+				&damon_sysfs_context_ktype, &contexts->kobj,
+				"%d", i);
+		if (err)
+			goto out;
+
+		err = damon_sysfs_context_add_dirs(context);
+		if (err)
+			goto out;
+
+		contexts_arr[i] = context;
+		contexts->nr++;
+	}
+	return 0;
+
+out:
+	damon_sysfs_contexts_rm_dirs(contexts);
+	kobject_put(&context->kobj);
+	return err;
+}
+
+static ssize_t damon_sysfs_contexts_nr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_contexts *contexts = container_of(kobj,
+			struct damon_sysfs_contexts, kobj);
+
+	return sysfs_emit(buf, "%d\n", contexts->nr);
+}
+
+static ssize_t damon_sysfs_contexts_nr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_contexts *contexts = container_of(kobj,
+			struct damon_sysfs_contexts, kobj);
+	int nr, err;
+
+	err = kstrtoint(buf, 0, &nr);
+	if (err)
+		return err;
+	/* TODO: support multiple contexts per kdamond */
+	if (nr < 0 || 1 < nr)
+		return -EINVAL;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_contexts_add_dirs(contexts, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_contexts_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_contexts, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_contexts_nr_attr = __ATTR(nr, 0600,
+		damon_sysfs_contexts_nr_show, damon_sysfs_contexts_nr_store);
+
+static struct attribute *damon_sysfs_contexts_attrs[] = {
+	&damon_sysfs_contexts_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_contexts);
+
+static struct kobj_type damon_sysfs_contexts_ktype = {
+	.release = damon_sysfs_contexts_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_contexts_groups,
+};
+
+/*
+ * kdamond directory
+ */
+
+struct damon_sysfs_kdamond {
+	struct kobject kobj;
+	struct damon_sysfs_contexts *contexts;
+};
+
+static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_kdamond), GFP_KERNEL);
+}
+
+static int damon_sysfs_kdamond_add_dirs(struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_sysfs_contexts *contexts;
+	int err;
+
+	contexts = damon_sysfs_contexts_alloc();
+	if (!contexts)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&contexts->kobj,
+			&damon_sysfs_contexts_ktype, &kdamond->kobj,
+			"contexts");
+	if (err) {
+		kobject_put(&contexts->kobj);
+		return err;
+	}
+	kdamond->contexts = contexts;
+
+	return err;
+}
+
+static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
+{
+	damon_sysfs_contexts_rm_dirs(kdamond->contexts);
+	kobject_put(&kdamond->contexts->kobj);
+}
+
+static ssize_t damon_sysfs_kdamond_state_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "off\n");
+}
+
+static ssize_t damon_sysfs_kdamond_state_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	return count;
+}
+
+static ssize_t damon_sysfs_kdamond_pid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "-1\n");
+}
+
+static void damon_sysfs_kdamond_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_kdamond, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_kdamond_state_attr =
+	__ATTR(state, 0600, damon_sysfs_kdamond_state_show,
+		damon_sysfs_kdamond_state_store);
+
+static struct kobj_attribute damon_sysfs_kdamond_pid_attr = __ATTR(pid, 0400,
+		damon_sysfs_kdamond_pid_show, NULL);
+
+static struct attribute *damon_sysfs_kdamond_attrs[] = {
+	&damon_sysfs_kdamond_state_attr.attr,
+	&damon_sysfs_kdamond_pid_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_kdamond);
+
+static struct kobj_type damon_sysfs_kdamond_ktype = {
+	.release = damon_sysfs_kdamond_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_kdamond_groups,
+};
+
+/*
+ * kdamonds directory
+ */
+
+struct damon_sysfs_kdamonds {
+	struct kobject kobj;
+	struct damon_sysfs_kdamond **kdamonds_arr;
+	int nr;
+};
+
+static struct damon_sysfs_kdamonds *damon_sysfs_kdamonds_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_kdamonds), GFP_KERNEL);
+}
+
+static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamonds)
+{
+	struct damon_sysfs_kdamond **kdamonds_arr = kdamonds->kdamonds_arr;
+	int i;
+
+	for (i = 0; i < kdamonds->nr; i++) {
+		damon_sysfs_kdamond_rm_dirs(kdamonds_arr[i]);
+		kobject_put(&kdamonds_arr[i]->kobj);
+	}
+	kdamonds->nr = 0;
+	kfree(kdamonds_arr);
+	kdamonds->kdamonds_arr = NULL;
+}
+
+static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
+		int nr_kdamonds)
+{
+	struct damon_sysfs_kdamond **kdamonds_arr, *kdamond;
+	int err, i;
+
+	damon_sysfs_kdamonds_rm_dirs(kdamonds);
+	if (!nr_kdamonds)
+		return 0;
+
+	kdamonds_arr = kmalloc_array(nr_kdamonds, sizeof(*kdamonds_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!kdamonds_arr)
+		return -ENOMEM;
+	kdamonds->kdamonds_arr = kdamonds_arr;
+
+	for (i = 0; i < nr_kdamonds; i++) {
+		kdamond = damon_sysfs_kdamond_alloc();
+		if (!kdamond) {
+			damon_sysfs_kdamonds_rm_dirs(kdamonds);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&kdamond->kobj,
+				&damon_sysfs_kdamond_ktype, &kdamonds->kobj,
+				"%d", i);
+		if (err)
+			goto out;
+
+		err = damon_sysfs_kdamond_add_dirs(kdamond);
+		if (err)
+			goto out;
+
+		kdamonds_arr[i] = kdamond;
+		kdamonds->nr++;
+	}
+	return 0;
+
+out:
+	damon_sysfs_kdamonds_rm_dirs(kdamonds);
+	kobject_put(&kdamond->kobj);
+	return err;
+}
+
+static ssize_t damon_sysfs_kdamonds_nr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
+			struct damon_sysfs_kdamonds, kobj);
+
+	return sysfs_emit(buf, "%d\n", kdamonds->nr);
+}
+
+static ssize_t damon_sysfs_kdamonds_nr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
+			struct damon_sysfs_kdamonds, kobj);
+	int nr, err;
+
+	err = kstrtoint(buf, 0, &nr);
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_kdamonds_add_dirs(kdamonds, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_kdamonds_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_kdamonds, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_kdamonds_nr_attr = __ATTR(nr, 0600,
+		damon_sysfs_kdamonds_nr_show, damon_sysfs_kdamonds_nr_store);
+
+static struct attribute *damon_sysfs_kdamonds_attrs[] = {
+	&damon_sysfs_kdamonds_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_kdamonds);
+
+static struct kobj_type damon_sysfs_kdamonds_ktype = {
+	.release = damon_sysfs_kdamonds_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_kdamonds_groups,
+};
+
+/*
+ * damon user interface directory
+ */
+
+struct damon_sysfs_ui_dir {
+	struct kobject kobj;
+	struct damon_sysfs_kdamonds *kdamonds;
+};
+
+static struct damon_sysfs_ui_dir *damon_sysfs_ui_dir_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_ui_dir), GFP_KERNEL);
+}
+
+static int damon_sysfs_ui_dir_add_dirs(struct damon_sysfs_ui_dir *ui_dir)
+{
+	struct damon_sysfs_kdamonds *kdamonds;
+	int err;
+
+	kdamonds = damon_sysfs_kdamonds_alloc();
+	if (!kdamonds)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&kdamonds->kobj,
+			&damon_sysfs_kdamonds_ktype, &ui_dir->kobj,
+			"kdamonds");
+	if (err) {
+		kobject_put(&kdamonds->kobj);
+		return err;
+	}
+	ui_dir->kdamonds = kdamonds;
+	return err;
+}
+
+static void damon_sysfs_ui_dir_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_ui_dir, kobj));
+}
+
+static struct attribute *damon_sysfs_ui_dir_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_ui_dir);
+
+static struct kobj_type damon_sysfs_ui_dir_ktype = {
+	.release = damon_sysfs_ui_dir_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_ui_dir_groups,
+};
+
+static int __init damon_sysfs_init(void)
+{
+	struct kobject *damon_sysfs_root;
+	struct damon_sysfs_ui_dir *admin;
+	int err;
+
+	damon_sysfs_root = kobject_create_and_add("damon", mm_kobj);
+	if (!damon_sysfs_root)
+		return -ENOMEM;
+
+	admin = damon_sysfs_ui_dir_alloc();
+	if (!admin) {
+		kobject_put(damon_sysfs_root);
+		return -ENOMEM;
+	}
+	err = kobject_init_and_add(&admin->kobj, &damon_sysfs_ui_dir_ktype,
+			damon_sysfs_root, "admin");
+	if (err)
+		goto out;
+	err = damon_sysfs_ui_dir_add_dirs(admin);
+	if (err)
+		goto out;
+	return 0;
+
+out:
+	kobject_put(&admin->kobj);
+	kobject_put(damon_sysfs_root);
+	return err;
+}
+subsys_initcall(damon_sysfs_init);
-- 
2.17.1

