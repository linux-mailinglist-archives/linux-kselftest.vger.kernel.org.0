Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DEC4C1683
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiBWPWO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiBWPWG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:22:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F638AD;
        Wed, 23 Feb 2022 07:21:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03CCDB82036;
        Wed, 23 Feb 2022 15:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D6C340F0;
        Wed, 23 Feb 2022 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645629689;
        bh=fsNReIQJFT+jC+z1p2lFuwgUrF900obWVOTKEz53GuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtViweYr5uF27MQ0RE+opEfi+4pB9vpTOFQKPFYb/6LafKH2vHF4K3RcFoTe07uY1
         O8eBY5VCsodErqMUfEz/h1Nxa/niHKsaht7Bcj0P6dw1SreWpK9u+uumgnUG1IV7io
         TdohIF1ciHx1hsbhJREheJenV+89C06neP/z9U3W3UBq9ydaJgikEPS3EpAzWOObRz
         B4S7Ks75MhELSxZ4vwyHpp2Lx3D3ianOGrjF5Ui0yJCOn0gcUGGXNsPePDeFpoAYNP
         CsOHp5XOpHDilGBP7ml8PI0+JKIZN6udgSsJkfgIgIiGAwtEhlR0pOW70d8xyFoQJt
         hHhcUus32rlxw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 08/12] mm/damon/sysfs: Support schemes prioritization weights
Date:   Wed, 23 Feb 2022 15:20:47 +0000
Message-Id: <20220223152051.22936-9-sj@kernel.org>
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

This commit makes DAMON sysfs interface supports the DAMOS' regions
prioritization weights feature under quotas limitation.  Specifically,
this commit adds 'weights' directory under each scheme directory and
makes kdamond 'state' file writing respects the contents in the
directory.

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
    │ │ │ │ │ │ │ │ weights/sz,nr_accesses,age    <- NEW DIRECTORY
    │ │ │ │ │ │ ...
    │ │ │ │ ...
    │ │ ...

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index a14caeb5b6a1..b8596908be7b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -115,12 +115,133 @@ static struct kobj_type damon_sysfs_ul_range_ktype = {
 	.default_groups = damon_sysfs_ul_range_groups,
 };
 
+/*
+ * scheme/weights directory
+ */
+
+struct damon_sysfs_weights {
+	struct kobject kobj;
+	unsigned int sz;
+	unsigned int nr_accesses;
+	unsigned int age;
+};
+
+static struct damon_sysfs_weights *damon_sysfs_weights_alloc(unsigned int sz,
+		unsigned int nr_accesses, unsigned int age)
+{
+	struct damon_sysfs_weights *weights = kmalloc(sizeof(*weights),
+			GFP_KERNEL);
+
+	if (!weights)
+		return NULL;
+	weights->kobj = (struct kobject){};
+	weights->sz = sz;
+	weights->nr_accesses = nr_accesses;
+	weights->age = age;
+	return weights;
+}
+
+static ssize_t damon_sysfs_weights_sz_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+
+	return sysfs_emit(buf, "%u\n", weights->sz);
+}
+
+static ssize_t damon_sysfs_weights_sz_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+	int err = kstrtouint(buf, 0, &weights->sz);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t damon_sysfs_weights_nr_accesses_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+
+	return sysfs_emit(buf, "%u\n", weights->nr_accesses);
+}
+
+static ssize_t damon_sysfs_weights_nr_accesses_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+	int err = kstrtouint(buf, 0, &weights->nr_accesses);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t damon_sysfs_weights_age_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+
+	return sysfs_emit(buf, "%u\n", weights->age);
+}
+
+static ssize_t damon_sysfs_weights_age_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+	int err = kstrtouint(buf, 0, &weights->age);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_weights_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_weights, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_weights_sz_attr =
+		__ATTR(sz, 0600, damon_sysfs_weights_sz_show,
+				damon_sysfs_weights_sz_store);
+
+static struct kobj_attribute damon_sysfs_weights_nr_accesses_attr =
+		__ATTR(nr_accesses, 0600, damon_sysfs_weights_nr_accesses_show,
+				damon_sysfs_weights_nr_accesses_store);
+
+static struct kobj_attribute damon_sysfs_weights_age_attr =
+		__ATTR(age, 0600, damon_sysfs_weights_age_show,
+				damon_sysfs_weights_age_store);
+
+static struct attribute *damon_sysfs_weights_attrs[] = {
+	&damon_sysfs_weights_sz_attr.attr,
+	&damon_sysfs_weights_nr_accesses_attr.attr,
+	&damon_sysfs_weights_age_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_weights);
+
+static struct kobj_type damon_sysfs_weights_ktype = {
+	.release = damon_sysfs_weights_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_weights_groups,
+};
+
 /*
  * quotas directory
  */
 
 struct damon_sysfs_quotas {
 	struct kobject kobj;
+	struct damon_sysfs_weights *weights;
 	unsigned long ms;
 	unsigned long sz;
 	unsigned long reset_interval_ms;
@@ -131,6 +252,29 @@ static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
 	return kzalloc(sizeof(struct damon_sysfs_quotas), GFP_KERNEL);
 }
 
+static int damon_sysfs_quotas_add_dirs(struct damon_sysfs_quotas *quotas)
+{
+	struct damon_sysfs_weights *weights;
+	int err;
+
+	weights = damon_sysfs_weights_alloc(0, 0, 0);
+	if (!weights)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&weights->kobj, &damon_sysfs_weights_ktype,
+			&quotas->kobj, "weights");
+	if (err)
+		kobject_put(&weights->kobj);
+	else
+		quotas->weights = weights;
+	return err;
+}
+
+static void damon_sysfs_quotas_rm_dirs(struct damon_sysfs_quotas *quotas)
+{
+	kobject_put(&quotas->weights->kobj);
+}
+
 static ssize_t damon_sysfs_quotas_ms_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -393,6 +537,10 @@ static int damon_sysfs_scheme_set_quotas(struct damon_sysfs_scheme *scheme)
 			&scheme->kobj, "quotas");
 	if (err)
 		goto out;
+	err = damon_sysfs_quotas_add_dirs(quotas);
+	if (err)
+		goto out;
+	scheme->quotas = quotas;
 	return 0;
 
 out:
@@ -422,6 +570,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 {
 	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
+	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 }
 
@@ -1671,12 +1820,14 @@ static struct damos *damon_sysfs_mk_scheme(
 	struct damon_sysfs_access_pattern *pattern =
 		sysfs_scheme->access_pattern;
 	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
+	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
 	struct damos_quota quota = {
 		.ms = sysfs_quotas->ms,
 		.sz = sysfs_quotas->sz,
-		.weight_sz = 1000,
-		.weight_nr_accesses = 1000,
-		.weight_age = 1000,
+		.reset_interval = sysfs_quotas->reset_interval_ms,
+		.weight_sz = sysfs_weights->sz,
+		.weight_nr_accesses = sysfs_weights->nr_accesses,
+		.weight_age = sysfs_weights->age,
 	};
 	struct damos_watermarks wmarks = {
 		.metric = DAMOS_WMARK_NONE,
-- 
2.17.1

