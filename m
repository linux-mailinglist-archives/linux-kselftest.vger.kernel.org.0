Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277AB4C167D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbiBWPWI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241918AbiBWPWC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:22:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07961A9A58;
        Wed, 23 Feb 2022 07:21:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8804FB82079;
        Wed, 23 Feb 2022 15:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53529C340F3;
        Wed, 23 Feb 2022 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645629685;
        bh=SXlY2rIQIfyC12oX9CrfTYaNsYomBJuHE1ab+YEdV8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcXuKn1U33dff9QrdG+AL7dr9ScHVWHn00MiqiYxmJ58KCiC/id2/0qIQ0ClUXA48
         h8wBVmzOfl29mAvYaMYDaBxh+boa0sUjvzB/84CaD9gTOa5BeMDZ6PHwDnobXkb/wq
         1nsYXyGooAJLTDvdl4qzaxLXITQzN+jgWoao7IXxkz61lFCqxDc31gQYB0ZpXU7fXm
         qH4LUjYdjAhUsdMhmd+J1J3PhA+7ooO5Zx6iubYEAyT0gv4nWhGMOiHDw2FKDqhw5e
         r/VQBZmhV3FXqsKTBY5kSOGsdEx3k9jxlfVHXZSkh9ftOUGGFDmi7ewP3Btk+jjvPV
         AC0gzzddzw03Q==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 04/12] mm/damon/sysfs: Link DAMON for virtual address spaces monitoring
Date:   Wed, 23 Feb 2022 15:20:43 +0000
Message-Id: <20220223152051.22936-5-sj@kernel.org>
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

This commit links the DAMON sysfs interface to DAMON so that users can
control DAMON via the interface.  In detail, this commit makes writing
'on' to 'state' file constructs DAMON contexts based on values that
users have written to relevant sysfs files and start the context.  It
supports only virtual address spaces monitoring at the moment, though.

The files hierarchy of DAMON sysfs interface after this commit is shown
below.  In the below figure, parents-children relations are represented
with indentations, each directory is having ``/`` suffix, and files in
each directory are separated by comma (",").

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

The usage is straightforward.  Writing a number ('N') to each 'nr' file
makes directories named '0' to 'N-1'.  Users can construct DAMON
contexts by writing proper values to the files in the straightforward
manner and start each kdamond by writing 'on' to 'kdamonds/<N>/state'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e8087ffd924c..be0bc5e745cf 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -775,6 +775,7 @@ static struct kobj_type damon_sysfs_contexts_ktype = {
 struct damon_sysfs_kdamond {
 	struct kobject kobj;
 	struct damon_sysfs_contexts *contexts;
+	struct damon_ctx *damon_ctx;
 };
 
 static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
@@ -809,26 +810,217 @@ static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
 	kobject_put(&kdamond->contexts->kobj);
 }
 
+static bool damon_sysfs_ctx_running(struct damon_ctx *ctx)
+{
+	bool running;
+
+	mutex_lock(&ctx->kdamond_lock);
+	running = ctx->kdamond != NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+	return running;
+}
+
 static ssize_t damon_sysfs_kdamond_state_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "off\n");
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+	bool running;
+
+	if (!ctx)
+		running = false;
+	else
+		running = damon_sysfs_ctx_running(ctx);
+
+	return sysfs_emit(buf, "%s\n", running ? "on" : "off");
+}
+
+static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
+		struct damon_sysfs_attrs *sys_attrs)
+{
+	struct damon_sysfs_intervals *sys_intervals = sys_attrs->intervals;
+	struct damon_sysfs_ul_range *sys_nr_regions =
+		sys_attrs->nr_regions_range;
+
+	return damon_set_attrs(ctx, sys_intervals->sample_us,
+			sys_intervals->aggr_us, sys_intervals->update_us,
+			sys_nr_regions->min, sys_nr_regions->max);
+}
+
+static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
+{
+	struct damon_target *t, *next;
+
+	damon_for_each_target_safe(t, next, ctx) {
+		if (ctx->ops.id == DAMON_OPS_VADDR)
+			put_pid(t->pid);
+		damon_destroy_target(t);
+	}
+}
+
+static int damon_sysfs_set_targets(struct damon_ctx *ctx,
+		struct damon_sysfs_targets *sysfs_targets)
+{
+	int i;
+
+	for (i = 0; i < sysfs_targets->nr; i++) {
+		struct damon_sysfs_target *sys_target =
+			sysfs_targets->targets_arr[i];
+		struct damon_target *t = damon_new_target();
+
+		if (!t) {
+			damon_sysfs_destroy_targets(ctx);
+			return -ENOMEM;
+		}
+		if (ctx->ops.id == DAMON_OPS_VADDR) {
+			t->pid = find_get_pid(sys_target->pid);
+			if (!t->pid) {
+				damon_sysfs_destroy_targets(ctx);
+				return -EINVAL;
+			}
+		}
+		damon_add_target(ctx, t);
+	}
+	return 0;
+}
+
+static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
+{
+	struct damon_target *t, *next;
+
+	if (ctx->ops.id != DAMON_OPS_VADDR)
+		return;
+
+	mutex_lock(&ctx->kdamond_lock);
+	damon_for_each_target_safe(t, next, ctx) {
+		put_pid(t->pid);
+		damon_destroy_target(t);
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+}
+
+static struct damon_ctx *damon_sysfs_build_ctx(
+		struct damon_sysfs_context *sys_ctx)
+{
+	struct damon_ctx *ctx = damon_new_ctx();
+	int err;
+
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	err = damon_select_ops(ctx, sys_ctx->ops_id);
+	if (err)
+		goto out;
+	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
+	if (err)
+		goto out;
+	err = damon_sysfs_set_targets(ctx, sys_ctx->targets);
+	if (err)
+		goto out;
+
+	ctx->callback.before_terminate = damon_sysfs_before_terminate;
+	return ctx;
+
+out:
+	damon_destroy_ctx(ctx);
+	return ERR_PTR(err);
+}
+
+static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx;
+	int err;
+
+	if (kdamond->damon_ctx &&
+			damon_sysfs_ctx_running(kdamond->damon_ctx))
+		return -EBUSY;
+	/* TODO: support multiple contexts per kdamond */
+	if (kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	if (kdamond->damon_ctx)
+		damon_destroy_ctx(kdamond->damon_ctx);
+	kdamond->damon_ctx = NULL;
+
+	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+	err = damon_start(&ctx, 1, false);
+	if (err) {
+		damon_destroy_ctx(ctx);
+		return err;
+	}
+	kdamond->damon_ctx = ctx;
+	return err;
+}
+
+static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
+{
+	if (!kdamond->damon_ctx)
+		return -EINVAL;
+	return damon_stop(&kdamond->damon_ctx, 1);
+	/*
+	 * To allow users show final monitoring results of already turned-off
+	 * DAMON, we free kdamond->damon_ctx in next
+	 * damon_sysfs_turn_damon_on(), or kdamonds_nr_store()
+	 */
 }
 
 static ssize_t damon_sysfs_kdamond_state_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	return count;
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	ssize_t ret;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	if (sysfs_streq(buf, "on"))
+		ret = damon_sysfs_turn_damon_on(kdamond);
+	else if (sysfs_streq(buf, "off"))
+		ret = damon_sysfs_turn_damon_off(kdamond);
+	else
+		ret = -EINVAL;
+	mutex_unlock(&damon_sysfs_lock);
+	if (!ret)
+		ret = count;
+	return ret;
 }
 
 static ssize_t damon_sysfs_kdamond_pid_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "-1\n");
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx;
+	int pid;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	ctx = kdamond->damon_ctx;
+	if (!ctx) {
+		pid = -1;
+		goto out;
+	}
+	mutex_lock(&ctx->kdamond_lock);
+	if (!ctx->kdamond)
+		pid = -1;
+	else
+		pid = ctx->kdamond->pid;
+	mutex_unlock(&ctx->kdamond_lock);
+out:
+	mutex_unlock(&damon_sysfs_lock);
+	return sysfs_emit(buf, "%d\n", pid);
 }
 
 static void damon_sysfs_kdamond_release(struct kobject *kobj)
 {
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+
+	if (kdamond->damon_ctx)
+		damon_destroy_ctx(kdamond->damon_ctx);
 	kfree(container_of(kobj, struct damon_sysfs_kdamond, kobj));
 }
 
@@ -881,12 +1073,34 @@ static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamonds)
 	kdamonds->kdamonds_arr = NULL;
 }
 
+static int damon_sysfs_nr_running_ctxs(struct damon_sysfs_kdamond **kdamonds,
+		int nr_kdamonds)
+{
+	int nr_running_ctxs = 0;
+	int i;
+
+	for (i = 0; i < nr_kdamonds; i++) {
+		struct damon_ctx *ctx = kdamonds[i]->damon_ctx;
+
+		if (!ctx)
+			continue;
+		mutex_lock(&ctx->kdamond_lock);
+		if (ctx->kdamond)
+			nr_running_ctxs++;
+		mutex_unlock(&ctx->kdamond_lock);
+	}
+	return nr_running_ctxs;
+}
+
 static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
 		int nr_kdamonds)
 {
 	struct damon_sysfs_kdamond **kdamonds_arr, *kdamond;
 	int err, i;
 
+	if (damon_sysfs_nr_running_ctxs(kdamonds->kdamonds_arr, kdamonds->nr))
+		return -EBUSY;
+
 	damon_sysfs_kdamonds_rm_dirs(kdamonds);
 	if (!nr_kdamonds)
 		return 0;
-- 
2.17.1

