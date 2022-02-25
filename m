Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021D64C4562
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 14:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiBYNIM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 08:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiBYNH6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 08:07:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E2120E781;
        Fri, 25 Feb 2022 05:07:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C046E61C99;
        Fri, 25 Feb 2022 13:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC2FC340E7;
        Fri, 25 Feb 2022 13:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645794445;
        bh=eIxa0pUPO6TwcE0sGdfKLgNjUfSzHpTb/0ESBrWvFUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rywcizEbu4dw1+Cjgd8QZRVHIFNsVKE9uxAiC3Q8f71DVB9mLcEUyItMhBgzA/IDv
         suKSVACS9qvmcaA0JPoXLHxe0x+9rGi+ViSJ7h9TtiUEOgyozUNVloVFEJfTZjyzNZ
         9a4agL/RQ99IxFU05KbKvYU3EBvEeYK7sBCblbQfXDcGJGBj6LCGqyouuj+XAAcRqm
         +uIYOZb2e5854VLGwoSXHq6VjnDpmx5Ll8gr5F9wGHSp4C0l9PaS+DghZFXqCtJIH3
         c1rCdgJIGsMRJwjcyLEeCDHY2teSdGCJROmFcF7pxGLPtWMybSfu0VA1Ttl7iAM6H4
         sbg2U1L2GmT7Q==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 01/13] mm/damon/core: Allow non-exclusive DAMON start/stop
Date:   Fri, 25 Feb 2022 13:07:00 +0000
Message-Id: <20220225130712.12682-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225130712.12682-1-sj@kernel.org>
References: <20220225130712.12682-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid interference between DAMON contexts monitoring overlapping
memory regions, damon_start() works in an exclusive manner.  That is,
damon_start() does nothing bug fails if any context that started by
another instance of the function is still running.   This makes its
usage a little bit restrictive.  However, admins could aware each DAMON
usage and address such interferences on their own in some cases.

This commit hence implements non-exclusive mode of the function and
allows the callers to select the mode.  Note that the exclusive groups
and non-exclusive groups of contexts will respect each other in a manner
similar to that of reader-writer locks.  Therefore, this commit will not
cause any behavioral change to the exclusive groups.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 +-
 mm/damon/core.c       | 23 +++++++++++++++--------
 mm/damon/dbgfs.c      |  2 +-
 mm/damon/reclaim.c    |  2 +-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 49c4a11ecf20..f8e99e47d747 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -508,7 +508,7 @@ int damon_nr_running_ctxs(void);
 int damon_register_ops(struct damon_operations *ops);
 int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
 
-int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
 #endif	/* CONFIG_DAMON */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 82e0a4620c4f..c1e0fed4e877 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -24,6 +24,7 @@
 
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
+static bool running_exclusive_ctxs;
 
 static DEFINE_MUTEX(damon_ops_lock);
 static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
@@ -434,22 +435,25 @@ static int __damon_start(struct damon_ctx *ctx)
  * damon_start() - Starts the monitorings for a given group of contexts.
  * @ctxs:	an array of the pointers for contexts to start monitoring
  * @nr_ctxs:	size of @ctxs
+ * @exclusive:	exclusiveness of this contexts group
  *
  * This function starts a group of monitoring threads for a group of monitoring
  * contexts.  One thread per each context is created and run in parallel.  The
- * caller should handle synchronization between the threads by itself.  If a
- * group of threads that created by other 'damon_start()' call is currently
- * running, this function does nothing but returns -EBUSY.
+ * caller should handle synchronization between the threads by itself.  If
+ * @exclusive is true and a group of threads that created by other
+ * 'damon_start()' call is currently running, this function does nothing but
+ * returns -EBUSY.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
+int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 {
 	int i;
 	int err = 0;
 
 	mutex_lock(&damon_lock);
-	if (nr_running_ctxs) {
+	if ((exclusive && nr_running_ctxs) ||
+			(!exclusive && running_exclusive_ctxs)) {
 		mutex_unlock(&damon_lock);
 		return -EBUSY;
 	}
@@ -460,13 +464,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
 			break;
 		nr_running_ctxs++;
 	}
+	if (exclusive && nr_running_ctxs)
+		running_exclusive_ctxs = true;
 	mutex_unlock(&damon_lock);
 
 	return err;
 }
 
 /*
- * __damon_stop() - Stops monitoring of given context.
+ * __damon_stop() - Stops monitoring of a given context.
  * @ctx:	monitoring context
  *
  * Return: 0 on success, negative error code otherwise.
@@ -504,9 +510,8 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 		/* nr_running_ctxs is decremented in kdamond_fn */
 		err = __damon_stop(ctxs[i]);
 		if (err)
-			return err;
+			break;
 	}
-
 	return err;
 }
 
@@ -1102,6 +1107,8 @@ static int kdamond_fn(void *data)
 
 	mutex_lock(&damon_lock);
 	nr_running_ctxs--;
+	if (!nr_running_ctxs && running_exclusive_ctxs)
+		running_exclusive_ctxs = false;
 	mutex_unlock(&damon_lock);
 
 	return 0;
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 05b574cbcea8..a0dab8b5e45f 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -967,7 +967,7 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 				return -EINVAL;
 			}
 		}
-		ret = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
+		ret = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs, true);
 	} else if (!strncmp(kbuf, "off", count)) {
 		ret = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
 	} else {
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index b53d9c22fad1..e34c4d0c4d93 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -330,7 +330,7 @@ static int damon_reclaim_turn(bool on)
 	if (err)
 		goto free_scheme_out;
 
-	err = damon_start(&ctx, 1);
+	err = damon_start(&ctx, 1, true);
 	if (!err) {
 		kdamond_pid = ctx->kdamond->pid;
 		return 0;
-- 
2.17.1

