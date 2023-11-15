Return-Path: <linux-kselftest+bounces-168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3BD7EC943
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB081C20BD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB494177B;
	Wed, 15 Nov 2023 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJSAFY4z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501741757
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 17:04:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04515D46
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700067861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9+nFcngRUhsFFyuELFDF13uerbRBIggncaC5RluKd0=;
	b=bJSAFY4zpCjvYF7v3UIHxh7fUzjMs2cXavCCCdvelhyKkjn1XZfSjl/c7GLI1UWP7E07x2
	0/qF1bnc66B24CFLwWBRRse43yCMA6zww+bGblC5W4hW2SPIprzvSWP38/IEFxDhRrhlHQ
	8LEjFDC0xppT4OPIVQOxidVgxFkKmVc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-ThNv2jRrMoO4RNTlMRbEHA-1; Wed, 15 Nov 2023 12:04:15 -0500
X-MC-Unique: ThNv2jRrMoO4RNTlMRbEHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F98E101AA68;
	Wed, 15 Nov 2023 17:04:15 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B3B6D1121307;
	Wed, 15 Nov 2023 17:04:14 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Peter Hunt <pehunt@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/5] workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask
Date: Wed, 15 Nov 2023 12:03:56 -0500
Message-Id: <20231115170359.163299-3-longman@redhat.com>
In-Reply-To: <20231115170359.163299-1-longman@redhat.com>
References: <20231115170359.163299-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 91 +++++++++++++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index cf49b467bd57..b0b9604b76b8 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -491,6 +491,7 @@ struct workqueue_attrs *alloc_workqueue_attrs(void);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
 int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs);
+extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8996cdba8f07..367a93d4a5e4 100644
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
 
@@ -5784,7 +5790,7 @@ void thaw_workqueues(void)
 }
 #endif /* CONFIG_FREEZER */
 
-static int __maybe_unused workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
+static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 {
 	LIST_HEAD(ctxs);
 	int ret = 0;
@@ -5827,6 +5833,44 @@ static int __maybe_unused workqueue_apply_unbound_cpumask(const cpumask_var_t un
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
@@ -6144,6 +6188,7 @@ static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	cpumask_and(cpumask, cpumask, cpu_possible_mask);
 	if (!cpumask_empty(cpumask)) {
 		apply_wqattrs_lock();
+		cpumask_copy(wq_requested_unbound_cpumask, cpumask);
 		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
 			ret = 0;
 			goto out_unlock;
@@ -6158,19 +6203,36 @@ static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	return ret;
 }
 
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
@@ -6188,9 +6250,13 @@ static ssize_t wq_unbound_cpumask_store(struct device *dev,
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
@@ -6203,7 +6269,13 @@ static int __init wq_sysfs_init(void)
 
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
@@ -6534,11 +6606,14 @@ void __init workqueue_init_early(void)
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


