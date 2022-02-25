Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E284E4C456A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiBYNIt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 08:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbiBYNIq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 08:08:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E07222BD59;
        Fri, 25 Feb 2022 05:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3575CB830AE;
        Fri, 25 Feb 2022 13:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D317FC340E7;
        Fri, 25 Feb 2022 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645794476;
        bh=NHWnpdjCDQ/qZCpS5wGhWJGIYUliNqhg7XIUolzmOkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdHOu5Wqe4G4KL5V+y6eFqhBgar+Jb5VQztvQbjRPk++B2yUAWq8wxHPCT5e8c645
         YjVtx7wEJZ5NBAnoi41y2wkmUXDpe8Ck2tebL62zZS7Vb+7xDewHlse/9uxawfAD2V
         CCTQaG4lPBmbQI1z154gEIEXs2lEkgTIwAxNZ2Q9b8/GmuUEGa81MoaGHRwuOp1IH9
         AgDG31jQUA//y/nfQuVJlfvVn4pGu4Ou7dGfD5eLIseGNzKWpZLzq07ZyB84CCiOOC
         8mlvrbfY2zzmOtITuwpQLrvh5RzgMkJE1/WjPVvJukgO4GSehd4vl68vaeNCetbbQQ
         nQfHMEY/G549g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 09/13] mm/damon/sysfs: Support DAMOS watermarks
Date:   Fri, 25 Feb 2022 13:07:08 +0000
Message-Id: <20220225130712.12682-10-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225130712.12682-1-sj@kernel.org>
References: <20220225130712.12682-1-sj@kernel.org>
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

This commit makes DAMON sysfs interface supports the DAMOS watermarks
feature.  Specifically, this commit adds 'watermarks' directory under
each scheme directory and makes kdamond 'state' file writing respects
the contents in the directory.

As a result, the files hierarchy becomes as below:

    /sys/kernel/mm/damon/admin
    │ kdamonds/nr_kdamonds
    │ │ 0/state,pid
    │ │ │ contexts/nr_contexts
    │ │ │ │ 0/operations
    │ │ │ │ │ monitoring_attrs/intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ targets/nr_targets
    │ │ │ │ │ │ 0/pid_target
    │ │ │ │ │ │ │ regions/nr_regions
    │ │ │ │ │ │ │ │ 0/start,end
    │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ │ schemes/nr_schemes
    │ │ │ │ │ │ 0/action
    │ │ │ │ │ │ │ access_pattern/
    │ │ │ │ │ │ │ │ sz/min,max
    │ │ │ │ │ │ │ │ nr_accesses/min,max
    │ │ │ │ │ │ │ │ age/min,max
    │ │ │ │ │ │ │ quotas/ms,sz,reset_interval_ms
    │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
    │ │ │ │ │ │ │ watermarks/    <- NEW DIRECTORY
    │ │ │ │ │ │ │ │ metric,interval_us,high,mid,lo
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 220 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 215 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index fb1c39eabc31..2e09ed36f666 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -113,6 +113,189 @@ static struct kobj_type damon_sysfs_ul_range_ktype = {
 	.default_groups = damon_sysfs_ul_range_groups,
 };
 
+/*
+ * watermarks directory
+ */
+
+struct damon_sysfs_watermarks {
+	struct kobject kobj;
+	enum damos_wmark_metric metric;
+	unsigned long interval_us;
+	unsigned long high;
+	unsigned long mid;
+	unsigned long low;
+};
+
+static struct damon_sysfs_watermarks *damon_sysfs_watermarks_alloc(
+		enum damos_wmark_metric metric, unsigned long interval_us,
+		unsigned long high, unsigned long mid, unsigned long low)
+{
+	struct damon_sysfs_watermarks *watermarks = kmalloc(
+			sizeof(*watermarks), GFP_KERNEL);
+
+	if (!watermarks)
+		return NULL;
+	watermarks->kobj = (struct kobject){};
+	watermarks->metric = metric;
+	watermarks->interval_us = interval_us;
+	watermarks->high = high;
+	watermarks->mid = mid;
+	watermarks->low = low;
+	return watermarks;
+}
+
+/* Should match with enum damos_wmark_metric */
+static const char * const damon_sysfs_wmark_metric_strs[] = {
+	"none",
+	"free_mem_rate",
+};
+
+static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			damon_sysfs_wmark_metric_strs[watermarks->metric]);
+}
+
+static ssize_t metric_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	enum damos_wmark_metric metric;
+
+	for (metric = 0; metric <= NR_DAMOS_WMARK_METRICS; metric++) {
+		if (sysfs_streq(buf, damon_sysfs_wmark_metric_strs[metric])) {
+			watermarks->metric = metric;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
+static ssize_t interval_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%lu\n", watermarks->interval_us);
+}
+
+static ssize_t interval_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoul(buf, 0, &watermarks->interval_us);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t high_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%lu\n", watermarks->high);
+}
+
+static ssize_t high_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoul(buf, 0, &watermarks->high);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t mid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%lu\n", watermarks->mid);
+}
+
+static ssize_t mid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoul(buf, 0, &watermarks->mid);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t low_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%lu\n", watermarks->low);
+}
+
+static ssize_t low_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoul(buf, 0, &watermarks->low);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_watermarks_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_watermarks, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_watermarks_metric_attr =
+		__ATTR_RW_MODE(metric, 0600);
+
+static struct kobj_attribute damon_sysfs_watermarks_interval_us_attr =
+		__ATTR_RW_MODE(interval_us, 0600);
+
+static struct kobj_attribute damon_sysfs_watermarks_high_attr =
+		__ATTR_RW_MODE(high, 0600);
+
+static struct kobj_attribute damon_sysfs_watermarks_mid_attr =
+		__ATTR_RW_MODE(mid, 0600);
+
+static struct kobj_attribute damon_sysfs_watermarks_low_attr =
+		__ATTR_RW_MODE(low, 0600);
+
+static struct attribute *damon_sysfs_watermarks_attrs[] = {
+	&damon_sysfs_watermarks_metric_attr.attr,
+	&damon_sysfs_watermarks_interval_us_attr.attr,
+	&damon_sysfs_watermarks_high_attr.attr,
+	&damon_sysfs_watermarks_mid_attr.attr,
+	&damon_sysfs_watermarks_low_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_watermarks);
+
+static struct kobj_type damon_sysfs_watermarks_ktype = {
+	.release = damon_sysfs_watermarks_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_watermarks_groups,
+};
+
 /*
  * scheme/weights directory
  */
@@ -469,6 +652,7 @@ struct damon_sysfs_scheme {
 	enum damos_action action;
 	struct damon_sysfs_access_pattern *access_pattern;
 	struct damon_sysfs_quotas *quotas;
+	struct damon_sysfs_watermarks *watermarks;
 };
 
 /* This should match with enum damos_action */
@@ -541,6 +725,24 @@ static int damon_sysfs_scheme_set_quotas(struct damon_sysfs_scheme *scheme)
 	return err;
 }
 
+static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_watermarks *watermarks =
+		damon_sysfs_watermarks_alloc(DAMOS_WMARK_NONE, 0, 0, 0, 0);
+	int err;
+
+	if (!watermarks)
+		return -ENOMEM;
+	err = kobject_init_and_add(&watermarks->kobj,
+			&damon_sysfs_watermarks_ktype, &scheme->kobj,
+			"watermarks");
+	if (err)
+		kobject_put(&watermarks->kobj);
+	else
+		scheme->watermarks = watermarks;
+	return err;
+}
+
 static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 {
 	int err;
@@ -551,8 +753,14 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_quotas(scheme);
 	if (err)
 		goto put_access_pattern_out;
+	err = damon_sysfs_scheme_set_watermarks(scheme);
+	if (err)
+		goto put_quotas_access_pattern_out;
 	return 0;
 
+put_quotas_access_pattern_out:
+	kobject_put(&scheme->quotas->kobj);
+	scheme->quotas = NULL;
 put_access_pattern_out:
 	kobject_put(&scheme->access_pattern->kobj);
 	scheme->access_pattern = NULL;
@@ -565,6 +773,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 	kobject_put(&scheme->access_pattern->kobj);
 	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
+	kobject_put(&scheme->watermarks->kobj);
 }
 
 static ssize_t action_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1803,6 +2012,7 @@ static struct damos *damon_sysfs_mk_scheme(
 		sysfs_scheme->access_pattern;
 	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
 	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
+	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
 	struct damos_quota quota = {
 		.ms = sysfs_quotas->ms,
 		.sz = sysfs_quotas->sz,
@@ -1812,11 +2022,11 @@ static struct damos *damon_sysfs_mk_scheme(
 		.weight_age = sysfs_weights->age,
 	};
 	struct damos_watermarks wmarks = {
-		.metric = DAMOS_WMARK_NONE,
-		.interval = 0,
-		.high = 0,
-		.mid = 0,
-		.low = 0,
+		.metric = sysfs_wmarks->metric,
+		.interval = sysfs_wmarks->interval_us,
+		.high = sysfs_wmarks->high,
+		.mid = sysfs_wmarks->mid,
+		.low = sysfs_wmarks->low,
 	};
 
 	return damon_new_scheme(pattern->sz->min, pattern->sz->max,
-- 
2.17.1

