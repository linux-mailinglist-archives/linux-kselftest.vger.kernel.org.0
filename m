Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF80F4C1674
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiBWPWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbiBWPWF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:22:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B36ACF;
        Wed, 23 Feb 2022 07:21:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D40C9B8207B;
        Wed, 23 Feb 2022 15:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9606FC340FC;
        Wed, 23 Feb 2022 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645629687;
        bh=ZGMpJwl2wn458uReV1jkJhAfqxpRPeF4jgkB4IQOVlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQ04KSteGlVPPBiAKYH+TmAtI1qYK2xtXYZaXaUS4ALnn1iGb9QPxVa8Sb6kJ2dyt
         UnaoiU+GG2RzURlgLcUSJta9sotP/5Pped60oPlQ4UdqW/5o8cKo9gTOJRh1DPfw3W
         VqyXP96ztAFp18RkFGVhGdQZCbXCJcsBFw/8IBmFKal7d0pDkN93tztf4BJLiFDZOI
         SVoOiOwGONV2gftjOc55Bx7g+ZFf90vXEnGVTGiOLLYANl/GI+QQu3fWGZE5YIY7On
         xMxaKpxQedZncWQf47rEGfDVKMZ8XrFB/N5MsXrpHfQZojV43v+l6QQ3bprTUjv1ma
         egnQnfh42lIXw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 06/12] mm/damon/sysfs: Support DAMON-based Operation Schemes
Date:   Wed, 23 Feb 2022 15:20:45 +0000
Message-Id: <20220223152051.22936-7-sj@kernel.org>
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

This commit makes DAMON sysfs interface supports the DAMON-based
operation schemes (DAMOS) feature.  Specifically, this commit adds
'schemes' directory under each context direcotry, and makes kdamond
'state' file writing respects the contents in the directory.

Note that this commit doesn't support all features of DAMOS but only the
target access pattern and action feature.  Supports for quotas,
prioritization, watermarks will follow.

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
    │ │ │ │ │ schemes/nr    <- NEW DIRECTORY
    │ │ │ │ │ │ 0/action
    │ │ │ │ │ │ │ access_pattern/
    │ │ │ │ │ │ │ │ sz/min,max
    │ │ │ │ │ │ │ │ nr_accesses/min,max
    │ │ │ │ │ │ │ │ age/min,max
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 418 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 418 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c9ad3808077e..2350a637e662 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -115,6 +115,349 @@ static struct kobj_type damon_sysfs_ul_range_ktype = {
 	.default_groups = damon_sysfs_ul_range_groups,
 };
 
+/*
+ * access_pattern directory
+ */
+
+struct damon_sysfs_access_pattern {
+	struct kobject kobj;
+	struct damon_sysfs_ul_range *sz;
+	struct damon_sysfs_ul_range *nr_accesses;
+	struct damon_sysfs_ul_range *age;
+};
+
+static
+struct damon_sysfs_access_pattern *damon_sysfs_access_pattern_alloc(void)
+{
+	struct damon_sysfs_access_pattern *access_pattern =
+		kmalloc(sizeof(*access_pattern), GFP_KERNEL);
+
+	if (!access_pattern)
+		return NULL;
+	access_pattern->kobj = (struct kobject){};
+	return access_pattern;
+}
+
+static int damon_sysfs_access_pattern_add_range_dir(
+		struct damon_sysfs_access_pattern *access_pattern,
+		struct damon_sysfs_ul_range **range_dir_ptr,
+		char *name)
+{
+	struct damon_sysfs_ul_range *range = damon_sysfs_ul_range_alloc(0, 0);
+	int err;
+
+	if (!range)
+		return -ENOMEM;
+	err = kobject_init_and_add(&range->kobj, &damon_sysfs_ul_range_ktype,
+			&access_pattern->kobj, name);
+	if (err)
+		kobject_put(&range->kobj);
+	else
+		*range_dir_ptr = range;
+	return err;
+}
+
+static int damon_sysfs_access_pattern_add_dirs(
+		struct damon_sysfs_access_pattern *access_pattern)
+{
+	int err;
+
+	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
+			&access_pattern->sz, "sz");
+	if (err)
+		goto put_sz_out;
+
+	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
+			&access_pattern->nr_accesses, "nr_accesses");
+	if (err)
+		goto put_nr_accesses_sz_out;
+
+	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
+			&access_pattern->age, "age");
+	if (err)
+		goto put_age_nr_accesses_sz_out;
+	return 0;
+
+put_age_nr_accesses_sz_out:
+	kobject_put(&access_pattern->age->kobj);
+	access_pattern->age = NULL;
+put_nr_accesses_sz_out:
+	kobject_put(&access_pattern->nr_accesses->kobj);
+	access_pattern->nr_accesses = NULL;
+put_sz_out:
+	kobject_put(&access_pattern->sz->kobj);
+	access_pattern->sz = NULL;
+	return err;
+}
+
+static void damon_sysfs_access_pattern_rm_dirs(
+		struct damon_sysfs_access_pattern *access_pattern)
+{
+	kobject_put(&access_pattern->sz->kobj);
+	kobject_put(&access_pattern->nr_accesses->kobj);
+	kobject_put(&access_pattern->age->kobj);
+}
+
+static void damon_sysfs_access_pattern_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_access_pattern, kobj));
+}
+
+static struct attribute *damon_sysfs_access_pattern_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_access_pattern);
+
+static struct kobj_type damon_sysfs_access_pattern_ktype = {
+	.release = damon_sysfs_access_pattern_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_access_pattern_groups,
+};
+
+/*
+ * scheme directory
+ */
+
+struct damon_sysfs_scheme {
+	struct kobject kobj;
+	enum damos_action action;
+	struct damon_sysfs_access_pattern *access_pattern;
+};
+
+/* This should match with enum damos_action */
+static const char * const damon_sysfs_damos_action_strs[] = {
+	"willneed",
+	"cold",
+	"pageout",
+	"hugepage",
+	"nohugepage",
+	"stat",
+};
+
+static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
+		enum damos_action action)
+{
+	struct damon_sysfs_scheme *scheme = kmalloc(sizeof(*scheme),
+				GFP_KERNEL);
+
+	if (!scheme)
+		return NULL;
+	scheme->kobj = (struct kobject){};
+	scheme->action = action;
+	return scheme;
+}
+
+static int damon_sysfs_scheme_set_access_pattern(
+		struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_access_pattern *access_pattern;
+	int err;
+
+	access_pattern = damon_sysfs_access_pattern_alloc();
+	if (!access_pattern)
+		return -ENOMEM;
+	err = kobject_init_and_add(&access_pattern->kobj,
+			&damon_sysfs_access_pattern_ktype, &scheme->kobj,
+			"access_pattern");
+	if (err)
+		goto out;
+	err = damon_sysfs_access_pattern_add_dirs(access_pattern);
+	if (err)
+		goto out;
+	scheme->access_pattern = access_pattern;
+	return 0;
+
+out:
+	kobject_put(&access_pattern->kobj);
+	return err;
+}
+
+static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
+{
+	int err;
+
+	err = damon_sysfs_scheme_set_access_pattern(scheme);
+	if (err)
+		return err;
+	return 0;
+}
+
+static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
+{
+	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
+	kobject_put(&scheme->access_pattern->kobj);
+}
+
+static ssize_t damon_sysfs_scheme_action_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			damon_sysfs_damos_action_strs[scheme->action]);
+}
+
+static ssize_t damon_sysfs_scheme_action_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	enum damos_action action;
+
+	for (action = 0; action < NR_DAMOS_ACTIONS; action++) {
+		if (sysfs_streq(buf, damon_sysfs_damos_action_strs[action])) {
+			scheme->action = action;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
+static void damon_sysfs_scheme_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_scheme_action_attr = __ATTR(
+		action, 0600, damon_sysfs_scheme_action_show,
+		damon_sysfs_scheme_action_store);
+
+
+static struct attribute *damon_sysfs_scheme_attrs[] = {
+	&damon_sysfs_scheme_action_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_scheme);
+
+static struct kobj_type damon_sysfs_scheme_ktype = {
+	.release = damon_sysfs_scheme_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_scheme_groups,
+};
+
+/*
+ * schemes directory
+ */
+
+struct damon_sysfs_schemes {
+	struct kobject kobj;
+	struct damon_sysfs_scheme **schemes_arr;
+	int nr;
+};
+
+static struct damon_sysfs_schemes *damon_sysfs_schemes_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_schemes), GFP_KERNEL);
+}
+
+static void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
+{
+	struct damon_sysfs_scheme **schemes_arr = schemes->schemes_arr;
+	int i;
+
+	for (i = 0; i < schemes->nr; i++) {
+		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
+		kobject_put(&schemes_arr[i]->kobj);
+	}
+	schemes->nr = 0;
+	kfree(schemes_arr);
+	schemes->schemes_arr = NULL;
+}
+
+static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
+		int nr_schemes)
+{
+	struct damon_sysfs_scheme **schemes_arr, *scheme;
+	int err, i;
+
+	damon_sysfs_schemes_rm_dirs(schemes);
+	if (!nr_schemes)
+		return 0;
+
+	schemes_arr = kmalloc_array(nr_schemes, sizeof(*schemes_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!schemes_arr)
+		return -ENOMEM;
+	schemes->schemes_arr = schemes_arr;
+
+	for (i = 0; i < nr_schemes; i++) {
+		scheme = damon_sysfs_scheme_alloc(DAMOS_STAT);
+		if (!scheme) {
+			damon_sysfs_schemes_rm_dirs(schemes);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&scheme->kobj,
+				&damon_sysfs_scheme_ktype, &schemes->kobj,
+				"%d", i);
+		if (err)
+			goto out;
+		err = damon_sysfs_scheme_add_dirs(scheme);
+		if (err)
+			goto out;
+
+		schemes_arr[i] = scheme;
+		schemes->nr++;
+	}
+	return 0;
+
+out:
+	damon_sysfs_schemes_rm_dirs(schemes);
+	kobject_put(&scheme->kobj);
+	return err;
+}
+
+static ssize_t damon_sysfs_schemes_nr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_schemes *schemes = container_of(kobj,
+			struct damon_sysfs_schemes, kobj);
+
+	return sysfs_emit(buf, "%d\n", schemes->nr);
+}
+
+static ssize_t damon_sysfs_schemes_nr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_schemes *schemes = container_of(kobj,
+			struct damon_sysfs_schemes, kobj);
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_schemes_add_dirs(schemes, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+	return count;
+}
+
+static void damon_sysfs_schemes_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_schemes, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_schemes_nr_attr = __ATTR(nr, 0600,
+		damon_sysfs_schemes_nr_show, damon_sysfs_schemes_nr_store);
+
+static struct attribute *damon_sysfs_schemes_attrs[] = {
+	&damon_sysfs_schemes_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_schemes);
+
+static struct kobj_type damon_sysfs_schemes_ktype = {
+	.release = damon_sysfs_schemes_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_schemes_groups,
+};
+
 /*
  * init region directory
  */
@@ -756,6 +1099,7 @@ struct damon_sysfs_context {
 	enum damon_ops_id ops_id;
 	struct damon_sysfs_attrs *attrs;
 	struct damon_sysfs_targets *targets;
+	struct damon_sysfs_schemes *schemes;
 };
 
 static struct damon_sysfs_context *damon_sysfs_context_alloc(
@@ -810,6 +1154,23 @@ static int damon_sysfs_context_set_targets(struct damon_sysfs_context *context)
 	return 0;
 }
 
+static int damon_sysfs_context_set_schemes(struct damon_sysfs_context *context)
+{
+	struct damon_sysfs_schemes *schemes = damon_sysfs_schemes_alloc();
+	int err;
+
+	if (!schemes)
+		return -ENOMEM;
+	err = kobject_init_and_add(&schemes->kobj, &damon_sysfs_schemes_ktype,
+			&context->kobj, "schemes");
+	if (err) {
+		kobject_put(&schemes->kobj);
+		return err;
+	}
+	context->schemes = schemes;
+	return 0;
+}
+
 static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
 {
 	int err;
@@ -822,8 +1183,14 @@ static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
 	if (err)
 		goto put_attrs_out;
 
+	err = damon_sysfs_context_set_schemes(context);
+	if (err)
+		goto put_targets_attrs_out;
 	return 0;
 
+put_targets_attrs_out:
+	kobject_put(&context->targets->kobj);
+	context->targets = NULL;
 put_attrs_out:
 	kobject_put(&context->attrs->kobj);
 	context->attrs = NULL;
@@ -836,6 +1203,8 @@ static void damon_sysfs_context_rm_dirs(struct damon_sysfs_context *context)
 	kobject_put(&context->attrs->kobj);
 	damon_sysfs_targets_rm_dirs(context->targets);
 	kobject_put(&context->targets->kobj);
+	damon_sysfs_schemes_rm_dirs(context->schemes);
+	kobject_put(&context->schemes->kobj);
 }
 
 static ssize_t damon_sysfs_context_operations_show(struct kobject *kobj,
@@ -1159,6 +1528,52 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
+static struct damos *damon_sysfs_mk_scheme(
+		struct damon_sysfs_scheme *sysfs_scheme)
+{
+	struct damon_sysfs_access_pattern *pattern =
+		sysfs_scheme->access_pattern;
+	struct damos_quota quota = {
+		.ms = 0,
+		.sz = 0,
+		.reset_interval = 0,
+		.weight_sz = 1000,
+		.weight_nr_accesses = 1000,
+		.weight_age = 1000,
+	};
+	struct damos_watermarks wmarks = {
+		.metric = DAMOS_WMARK_NONE,
+		.interval = 0,
+		.high = 0,
+		.mid = 0,
+		.low = 0,
+	};
+
+	return damon_new_scheme(pattern->sz->min, pattern->sz->max,
+			pattern->nr_accesses->min, pattern->nr_accesses->max,
+			pattern->age->min, pattern->age->max,
+			sysfs_scheme->action, &quota, &wmarks);
+}
+
+static int damon_sysfs_set_schemes(struct damon_ctx *ctx,
+		struct damon_sysfs_schemes *sysfs_schemes)
+{
+	int i;
+
+	for (i = 0; i < sysfs_schemes->nr; i++) {
+		struct damos *scheme, *next;
+
+		scheme = damon_sysfs_mk_scheme(sysfs_schemes->schemes_arr[i]);
+		if (!scheme) {
+			damon_for_each_scheme_safe(scheme, next, ctx)
+				damon_destroy_scheme(scheme);
+			return -ENOMEM;
+		}
+		damon_add_scheme(ctx, scheme);
+	}
+	return 0;
+}
+
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -1190,6 +1605,9 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	if (err)
 		goto out;
 	err = damon_sysfs_set_targets(ctx, sys_ctx->targets);
+	if (err)
+		goto out;
+	err = damon_sysfs_set_schemes(ctx, sys_ctx->schemes);
 	if (err)
 		goto out;
 
-- 
2.17.1

