Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C67D7339
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjJYS05 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 14:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJYS0z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 14:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF926129
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Oct 2023 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698258367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o30jOeo/WQQg6wKK8GuWTO/lSHgiQ6CI09+8wfOexsQ=;
        b=jKaegWT/9TRU7NjdwiqK6msTvuwxOrJ2ogzscSXzG+riENcvr1YDBFBRSLTGo1W3JNGKlN
        uFCfT/ASW0ZZfe8iU07K2zvZGj6Qfmod5SmR0Hp+e/zJCnKOEJp3NBAF/mV4QpwrYxcvEv
        FTfSjWrWRT5jJAisi+yOZNKpXoPKWGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-5-uiHFP8NwC7dZaHJ9NS-w-1; Wed, 25 Oct 2023 14:26:02 -0400
X-MC-Unique: 5-uiHFP8NwC7dZaHJ9NS-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BF45185A786;
        Wed, 25 Oct 2023 18:26:02 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B020492BFA;
        Wed, 25 Oct 2023 18:26:01 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Hunt <pehunt@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/4] workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask
Date:   Wed, 25 Oct 2023 14:25:52 -0400
Message-Id: <20231025182555.4155614-2-longman@redhat.com>
In-Reply-To: <20231025182555.4155614-1-longman@redhat.com>
References: <20231025182555.4155614-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the "isolcpus" boot command line option is used to add a set
of isolated CPUs, those CPUs will be excluded automatically from
wq_unbound_cpumask to avoid running work functions from unbound
workqueues.

Recently cpuset has been extended to allow the creation of partitions
of isolated CPUs dynamically. To make it closer to the "isolcpus"
in functionality, the CPUs in those isolated cpuset partitions should be
excluded from wq_unbound_cpumask as well. This can be done currently by
explicitly writing to the workqueue's cpumask sysfs file after creating
the isolated partitions. However, this process can be error prone.

Ideally, the cpuset code should be allowed to request the workqueue code
to exclude those isolated CPUs from wq_unbound_cpumask so that this
operation can be done automatically and the isolated CPUs will be returned
back to wq_unbound_cpumask after the destructions of the isolated
cpuset partitions.

This patch adds a new workqueue_unbound_exclude_cpumask() function to
enable that. This new function will exclude the specified isolated
CPUs from wq_unbound_cpumask. To be able to restore those isolated
CPUs back after the destruction of isolated cpuset partitions, a new
wq_requested_unbound_cpumask is added to store the user provided unbound
cpumask either from the boot command line options or from writing to
the cpumask sysfs file. This new cpumask provides the basis for CPU
exclusion.

To enable users to understand how the wq_unbound_cpumask is being
modified internally, this patch also exposes the newly introduced
wq_requested_unbound_cpumask as well as a wq_isolated_cpumask to
store the cpumask to be excluded from wq_unbound_cpumask as read-only
sysfs files.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/workqueue.h |  2 +-
 kernel/workqueue.c        | 91 +++++++++++++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 1c1d06804d45..a936460ccc7e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -483,7 +483,7 @@ struct workqueue_attrs *alloc_workqueue_attrs(void);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
 int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs);
-int workqueue_set_unbound_cpumask(cpumask_var_t cpumask);
+extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 010b674b02a7..ce20080751bd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -381,6 +381,12 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 /* PL&A: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
+/* PL: user requested unbound cpumask via sysfs */
+static cpumask_var_t wq_requested_unbound_cpumask;
+
+/* PL: isolated cpumask to be excluded from unbound cpumask */
+static cpumask_var_t wq_isolated_cpumask;
+
 /* for further constrain wq_unbound_cpumask by cmdline parameter*/
 static struct cpumask wq_cmdline_cpumask __initdata;
 
@@ -5825,7 +5831,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
  *  		-EINVAL	- Invalid @cpumask
  *  		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
  */
-int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
+static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 {
 	int ret = -EINVAL;
 
@@ -5836,6 +5842,7 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	cpumask_and(cpumask, cpumask, cpu_possible_mask);
 	if (!cpumask_empty(cpumask)) {
 		apply_wqattrs_lock();
+		cpumask_copy(wq_requested_unbound_cpumask, cpumask);
 		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
 			ret = 0;
 			goto out_unlock;
@@ -5850,6 +5857,44 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	return ret;
 }
 
+/**
+ * workqueue_unbound_exclude_cpumask - Exclude given CPUs from unbound cpumask
+ * @exclude_cpumask: the cpumask to be excluded from wq_unbound_cpumask
+ *
+ * This function can be called from cpuset code to provide a set of isolated
+ * CPUs that should be excluded from wq_unbound_cpumask. The caller must hold
+ * either cpus_read_lock or cpus_write_lock.
+ */
+int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
+{
+	cpumask_var_t cpumask;
+	int ret = 0;
+
+	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	lockdep_assert_cpus_held();
+	mutex_lock(&wq_pool_mutex);
+
+	/* Save the current isolated cpumask & export it via sysfs */
+	cpumask_copy(wq_isolated_cpumask, exclude_cpumask);
+
+	/*
+	 * If the operation fails, it will fall back to
+	 * wq_requested_unbound_cpumask which is initially set to
+	 * (HK_TYPE_WQ ∩ HK_TYPE_DOMAIN) house keeping mask and rewritten
+	 * by any subsequent write to workqueue/cpumask sysfs file.
+	 */
+	if (!cpumask_andnot(cpumask, wq_requested_unbound_cpumask, exclude_cpumask))
+		cpumask_copy(cpumask, wq_requested_unbound_cpumask);
+	if (!cpumask_equal(cpumask, wq_unbound_cpumask))
+		ret = workqueue_apply_unbound_cpumask(cpumask);
+
+	mutex_unlock(&wq_pool_mutex);
+	free_cpumask_var(cpumask);
+	return ret;
+}
+
 static int parse_affn_scope(const char *val)
 {
 	int i;
@@ -6144,19 +6189,36 @@ static struct bus_type wq_subsys = {
 	.dev_groups			= wq_sysfs_groups,
 };
 
-static ssize_t wq_unbound_cpumask_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t __wq_cpumask_show(struct device *dev,
+		struct device_attribute *attr, char *buf, cpumask_var_t mask)
 {
 	int written;
 
 	mutex_lock(&wq_pool_mutex);
-	written = scnprintf(buf, PAGE_SIZE, "%*pb\n",
-			    cpumask_pr_args(wq_unbound_cpumask));
+	written = scnprintf(buf, PAGE_SIZE, "%*pb\n", cpumask_pr_args(mask));
 	mutex_unlock(&wq_pool_mutex);
 
 	return written;
 }
 
+static ssize_t wq_unbound_cpumask_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return __wq_cpumask_show(dev, attr, buf, wq_unbound_cpumask);
+}
+
+static ssize_t wq_requested_cpumask_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return __wq_cpumask_show(dev, attr, buf, wq_requested_unbound_cpumask);
+}
+
+static ssize_t wq_isolated_cpumask_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return __wq_cpumask_show(dev, attr, buf, wq_isolated_cpumask);
+}
+
 static ssize_t wq_unbound_cpumask_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -6174,9 +6236,13 @@ static ssize_t wq_unbound_cpumask_store(struct device *dev,
 	return ret ? ret : count;
 }
 
-static struct device_attribute wq_sysfs_cpumask_attr =
+static struct device_attribute wq_sysfs_cpumask_attrs[] = {
 	__ATTR(cpumask, 0644, wq_unbound_cpumask_show,
-	       wq_unbound_cpumask_store);
+	       wq_unbound_cpumask_store),
+	__ATTR(cpumask_requested, 0444, wq_requested_cpumask_show, NULL),
+	__ATTR(cpumask_isolated, 0444, wq_isolated_cpumask_show, NULL),
+	__ATTR_NULL,
+};
 
 static int __init wq_sysfs_init(void)
 {
@@ -6189,7 +6255,13 @@ static int __init wq_sysfs_init(void)
 
 	dev_root = bus_get_dev_root(&wq_subsys);
 	if (dev_root) {
-		err = device_create_file(dev_root, &wq_sysfs_cpumask_attr);
+		struct device_attribute *attr;
+
+		for (attr = wq_sysfs_cpumask_attrs; attr->attr.name; attr++) {
+			err = device_create_file(dev_root, attr);
+			if (err)
+				break;
+		}
 		put_device(dev_root);
 	}
 	return err;
@@ -6520,11 +6592,14 @@ void __init workqueue_init_early(void)
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&wq_requested_unbound_cpumask, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&wq_isolated_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 	if (!cpumask_empty(&wq_cmdline_cpumask))
 		cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, &wq_cmdline_cpumask);
+	cpumask_copy(wq_requested_unbound_cpumask, wq_unbound_cpumask);
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-- 
2.39.3

