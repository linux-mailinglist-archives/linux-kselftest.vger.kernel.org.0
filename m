Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69C4C648F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 09:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiB1IOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 03:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiB1IOL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 03:14:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E340A12;
        Mon, 28 Feb 2022 00:13:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D26CAB80E69;
        Mon, 28 Feb 2022 08:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A193EC36AE9;
        Mon, 28 Feb 2022 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646036009;
        bh=slykdD1jprQ6eyVszdKeShsGpKZN8r1mPzUBS/DOvEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cz0XtDBDE+UEf6iY1z45beiD2pOYudd6YvvWnxFZ/ObY2C8v+MjTMzChcmNOwByPg
         4OxunLfLZru3B7o6QdotPkTFlqMempUDbOqRKKK/GQKFggWbvfNeBlmMVeMybx85xm
         Xo+DDJBbuf3dRBKzSSxVRaGhTWlYuE7IXAL8OGVqVhi+ZO87QObDb3pTN8UzReFFXq
         sCxrgPNMY65G43Zk3hkoYGkgS8Vs7LBaFMU4zBjvzbev53/DGmrJBCltpdBgp7xIFc
         tsDEQsDN6bznneTldKexN1QWJ9FGH9ZJg6KAFEQ0H72zEHNphViB6E9hzSgdMR552R
         9qhPubKj3EKMg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, gregkh@linuxfoundation.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 07/13] mm/damon/sysfs: Support DAMOS quotas
Date:   Mon, 28 Feb 2022 08:13:08 +0000
Message-Id: <20220228081314.5770-8-sj@kernel.org>
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

This commit makes DAMON sysfs interface supports the DAMOS quotas
feature.  Specifically, this commit adds 'quotas' directory under each
scheme directory and makes kdamond 'state' file writing respects the
contents in the directory.

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
    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms    <- NEW DIRECTORY
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 4f593f0bf16c..36540bdf6442 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -113,6 +113,113 @@ static struct kobj_type damon_sysfs_ul_range_ktype = {
 	.default_groups = damon_sysfs_ul_range_groups,
 };
 
+/*
+ * quotas directory
+ */
+
+struct damon_sysfs_quotas {
+	struct kobject kobj;
+	unsigned long ms;
+	unsigned long sz;
+	unsigned long reset_interval_ms;
+};
+
+static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_quotas), GFP_KERNEL);
+}
+
+static ssize_t ms_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%lu\n", quotas->ms);
+}
+
+static ssize_t ms_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int err = kstrtoul(buf, 0, &quotas->ms);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t bytes_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%lu\n", quotas->sz);
+}
+
+static ssize_t bytes_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int err = kstrtoul(buf, 0, &quotas->sz);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t reset_interval_ms_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%lu\n", quotas->reset_interval_ms);
+}
+
+static ssize_t reset_interval_ms_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int err = kstrtoul(buf, 0, &quotas->reset_interval_ms);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_quotas_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_quotas, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_quotas_ms_attr =
+		__ATTR_RW_MODE(ms, 0600);
+
+static struct kobj_attribute damon_sysfs_quotas_sz_attr =
+		__ATTR_RW_MODE(bytes, 0600);
+
+static struct kobj_attribute damon_sysfs_quotas_reset_interval_ms_attr =
+		__ATTR_RW_MODE(reset_interval_ms, 0600);
+
+static struct attribute *damon_sysfs_quotas_attrs[] = {
+	&damon_sysfs_quotas_ms_attr.attr,
+	&damon_sysfs_quotas_sz_attr.attr,
+	&damon_sysfs_quotas_reset_interval_ms_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_quotas);
+
+static struct kobj_type damon_sysfs_quotas_ktype = {
+	.release = damon_sysfs_quotas_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_quotas_groups,
+};
+
 /*
  * access_pattern directory
  */
@@ -220,6 +327,7 @@ struct damon_sysfs_scheme {
 	struct kobject kobj;
 	enum damos_action action;
 	struct damon_sysfs_access_pattern *access_pattern;
+	struct damon_sysfs_quotas *quotas;
 };
 
 /* This should match with enum damos_action */
@@ -270,6 +378,25 @@ static int damon_sysfs_scheme_set_access_pattern(
 	return err;
 }
 
+static int damon_sysfs_scheme_set_quotas(struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_quotas *quotas = damon_sysfs_quotas_alloc();
+	int err;
+
+	if (!quotas)
+		return -ENOMEM;
+	err = kobject_init_and_add(&quotas->kobj, &damon_sysfs_quotas_ktype,
+			&scheme->kobj, "quotas");
+	if (err)
+		goto out;
+	scheme->quotas = quotas;
+	return 0;
+
+out:
+	kobject_put(&quotas->kobj);
+	return err;
+}
+
 static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 {
 	int err;
@@ -277,13 +404,22 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_access_pattern(scheme);
 	if (err)
 		return err;
+	err = damon_sysfs_scheme_set_quotas(scheme);
+	if (err)
+		goto put_access_pattern_out;
 	return 0;
+
+put_access_pattern_out:
+	kobject_put(&scheme->access_pattern->kobj);
+	scheme->access_pattern = NULL;
+	return err;
 }
 
 static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 {
 	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
+	kobject_put(&scheme->quotas->kobj);
 }
 
 static ssize_t action_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1520,7 +1656,15 @@ static struct damos *damon_sysfs_mk_scheme(
 {
 	struct damon_sysfs_access_pattern *pattern =
 		sysfs_scheme->access_pattern;
-	struct damos_quota quota = (struct damos_quota){};
+	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
+	struct damos_quota quota = {
+		.ms = sysfs_quotas->ms,
+		.sz = sysfs_quotas->sz,
+		.reset_interval = sysfs_quotas->reset_interval_ms,
+		.weight_sz = 1000,
+		.weight_nr_accesses = 1000,
+		.weight_age = 1000,
+	};
 	struct damos_watermarks wmarks = {
 		.metric = DAMOS_WMARK_NONE,
 		.interval = 0,
-- 
2.17.1

