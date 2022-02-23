Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03034C1679
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbiBWPWP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241936AbiBWPWG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:22:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C962DEA9;
        Wed, 23 Feb 2022 07:21:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BE51B82079;
        Wed, 23 Feb 2022 15:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240C3C340E7;
        Wed, 23 Feb 2022 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645629692;
        bh=gLwbxRDPJci2RQJi57SUtINNwpIigC9Ki6uR66Ic+V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/KfEI8fQPNqx5ZqOlKX0qZKH+VJZmBLYrHgAgj5/u2PGeLFagTBVmzN4uLekj8uq
         kNQwTDpFjL2fHQR1b2v0YNtINx8WCPk84PMcNWXHlzCYIEPzmLqvYWUkpQPonuBin2
         IOA7a80QRBU+OJv+IVnV77ypiNaX+DEBRQgATLx8DuWYijT/73R/Q17QU+9FF2qPuz
         jWeS5lub/eKvuwzxB8nSRoOqwq9vlEs/4r+rHKNH/jGM4uq8a7cBYaGK7d6PYxWyJg
         LoCLXAexLRdBLjo7PpuaDft1MDomLtGWRG231cvCUDKryQFEmwRvJcBkA56RiPXw/R
         GwdPvB2t2S/Ow==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 10/12] mm/damon/sysfs: Support DAMOS stats
Date:   Wed, 23 Feb 2022 15:20:49 +0000
Message-Id: <20220223152051.22936-11-sj@kernel.org>
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

This commit makes DAMON sysfs interface supports the DAMOS stats
feature.  Specifically, this commit adds 'stats' directory under each
scheme directory, and makes kdamond 'state' file writing
('update_schemes_stats') to update the contents of the files under the
'stats' directory.

As a result, the files hierarchy becomes as below:

    /sys/kernel/mm/damon/admin
    │ kdamonds/nr
    │ │ 0/state,pid
    │ │ │ contexts/nr
    │ │ │ │ 0/operations
    │ │ │ │ │ monitoring_attrs/intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ targets/nr
    │ │ │ │ │ │ 0/pid
    │ │ │ │ │ │ │ regions/nr
    │ │ │ │ │ │ │ │ 0/start,end
    │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ │ schemes/nr
    │ │ │ │ │ │ 0/action
    │ │ │ │ │ │ │ access_pattern/
    │ │ │ │ │ │ │ │ sz/min,max
    │ │ │ │ │ │ │ │ nr_accesses/min,max
    │ │ │ │ │ │ │ │ age/min,max
    │ │ │ │ │ │ │ quotas/ms,sz,reset_interval_ms
    │ │ │ │ │ │ │ │ weights/sz,nr_accesses,age
    │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
    │ │ │ │ │ │ │ stats/    <- NEW DIRECTORY
    │ │ │ │ │ │ │ │ nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 215 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 9e54ed7316c6..a4ad6b473b0a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -115,6 +115,170 @@ static struct kobj_type damon_sysfs_ul_range_ktype = {
 	.default_groups = damon_sysfs_ul_range_groups,
 };
 
+/*
+ * schemes/stats directory
+ */
+
+struct damon_sysfs_stats {
+	struct kobject kobj;
+	unsigned long nr_tried;
+	unsigned long sz_tried;
+	unsigned long nr_applied;
+	unsigned long sz_applied;
+	unsigned long qt_exceeds;
+};
+
+static struct damon_sysfs_stats *damon_sysfs_stats_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_stats), GFP_KERNEL);
+}
+
+static ssize_t damon_sysfs_stats_nr_tried_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->nr_tried);
+}
+
+static ssize_t damon_sysfs_stats_nr_tried_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+	int err = kstrtoul(buf, 0, &stats->nr_tried);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t damon_sysfs_stats_sz_tried_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->sz_tried);
+}
+
+static ssize_t damon_sysfs_stats_sz_tried_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+	int err = kstrtoul(buf, 0, &stats->sz_tried);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t damon_sysfs_stats_nr_applied_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->nr_applied);
+}
+
+static ssize_t damon_sysfs_stats_nr_applied_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+	int err = kstrtoul(buf, 0, &stats->nr_applied);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t damon_sysfs_stats_sz_applied_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
+}
+
+static ssize_t damon_sysfs_stats_sz_applied_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+	int err = kstrtoul(buf, 0, &stats->sz_applied);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t damon_sysfs_stats_qt_exceeds_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->qt_exceeds);
+}
+
+static ssize_t damon_sysfs_stats_qt_exceeds_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+	int err = kstrtoul(buf, 0, &stats->qt_exceeds);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_stats_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_stats, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_stats_nr_tried_attr =
+		__ATTR(nr_tried, 0400, damon_sysfs_stats_nr_tried_show,
+				damon_sysfs_stats_nr_tried_store);
+
+static struct kobj_attribute damon_sysfs_stats_sz_tried_attr =
+		__ATTR(sz_tried, 0400, damon_sysfs_stats_sz_tried_show,
+				damon_sysfs_stats_sz_tried_store);
+
+static struct kobj_attribute damon_sysfs_stats_nr_applied_attr =
+		__ATTR(nr_applied, 0400, damon_sysfs_stats_nr_applied_show,
+				damon_sysfs_stats_nr_applied_store);
+
+static struct kobj_attribute damon_sysfs_stats_sz_applied_attr =
+		__ATTR(sz_applied, 0400, damon_sysfs_stats_sz_applied_show,
+				damon_sysfs_stats_sz_applied_store);
+
+static struct kobj_attribute damon_sysfs_stats_qt_exceeds_attr =
+		__ATTR(qt_exceeds, 0400, damon_sysfs_stats_qt_exceeds_show,
+				damon_sysfs_stats_qt_exceeds_store);
+
+static struct attribute *damon_sysfs_stats_attrs[] = {
+	&damon_sysfs_stats_nr_tried_attr.attr,
+	&damon_sysfs_stats_sz_tried_attr.attr,
+	&damon_sysfs_stats_nr_applied_attr.attr,
+	&damon_sysfs_stats_sz_applied_attr.attr,
+	&damon_sysfs_stats_qt_exceeds_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_stats);
+
+static struct kobj_type damon_sysfs_stats_ktype = {
+	.release = damon_sysfs_stats_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_stats_groups,
+};
+
 /*
  * watermarks directory
  */
@@ -666,6 +830,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_access_pattern *access_pattern;
 	struct damon_sysfs_quotas *quotas;
 	struct damon_sysfs_watermarks *watermarks;
+	struct damon_sysfs_stats *stats;
 };
 
 /* This should match with enum damos_action */
@@ -756,6 +921,22 @@ static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
 	return err;
 }
 
+static int damon_sysfs_scheme_set_stats(struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_stats *stats = damon_sysfs_stats_alloc();
+	int err;
+
+	if (!stats)
+		return -ENOMEM;
+	err = kobject_init_and_add(&stats->kobj, &damon_sysfs_stats_ktype,
+			&scheme->kobj, "stats");
+	if (err)
+		kobject_put(&stats->kobj);
+	else
+		scheme->stats = stats;
+	return err;
+}
+
 static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 {
 	int err;
@@ -769,8 +950,14 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
+	err = damon_sysfs_scheme_set_stats(scheme);
+	if (err)
+		goto put_watermarks_quotas_access_pattern_out;
 	return 0;
 
+put_watermarks_quotas_access_pattern_out:
+	kobject_put(&scheme->watermarks->kobj);
+	scheme->watermarks = NULL;
 put_quotas_access_pattern_out:
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
@@ -787,6 +974,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);
+	kobject_put(&scheme->stats->kobj);
 }
 
 static ssize_t damon_sysfs_scheme_action_show(struct kobject *kobj,
@@ -2163,6 +2351,31 @@ static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
 	 */
 }
 
+static int damon_sysfs_update_schemes_stats(struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct damos *scheme;
+	int schemes_idx = 0;
+
+	if (!ctx)
+		return -EINVAL;
+	mutex_lock(&ctx->kdamond_lock);
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_schemes *sysfs_schemes;
+		struct damon_sysfs_stats *sysfs_stats;
+
+		sysfs_schemes = kdamond->contexts->contexts_arr[0]->schemes;
+		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
+		sysfs_stats->nr_tried = scheme->stat.nr_tried;
+		sysfs_stats->sz_tried = scheme->stat.sz_tried;
+		sysfs_stats->nr_applied = scheme->stat.nr_applied;
+		sysfs_stats->sz_applied = scheme->stat.sz_applied;
+		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+	return 0;
+}
+
 static ssize_t damon_sysfs_kdamond_state_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
@@ -2176,6 +2389,8 @@ static ssize_t damon_sysfs_kdamond_state_store(struct kobject *kobj,
 		ret = damon_sysfs_turn_damon_on(kdamond);
 	else if (sysfs_streq(buf, "off"))
 		ret = damon_sysfs_turn_damon_off(kdamond);
+	else if (sysfs_streq(buf, "update_schemes_stats"))
+		ret = damon_sysfs_update_schemes_stats(kdamond);
 	else
 		ret = -EINVAL;
 	mutex_unlock(&damon_sysfs_lock);
-- 
2.17.1

