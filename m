Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5157C8CDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 20:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjJMSMm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMSMm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 14:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7B7CA
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697220713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nolWi3aqBikqVy187I9lW2xbSl+2rIWALGYPILniGBo=;
        b=cOHryA/eIb1Nf5W7UK9/hlmAu4lqIxaHUytSoEHDoV14rwfKVNefdbqMB+1GgPEI5rZuFR
        F2VRlxDwCzOUxtUDe7l9Fa8wVzuHn39Ltp8D0auFr+oteCh8sMzeiIEEZ3/SfaVlQgqqHR
        NUY5WE5qUNrZxXZHRf7GoiNDHotzqC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-Ar3Y8fhFM3iF4CHeOZYpwQ-1; Fri, 13 Oct 2023 14:11:49 -0400
X-MC-Unique: Ar3Y8fhFM3iF4CHeOZYpwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C94FC862DFD;
        Fri, 13 Oct 2023 18:11:48 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46A3020296DB;
        Fri, 13 Oct 2023 18:11:48 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 1/4] workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask
Date:   Fri, 13 Oct 2023 14:11:19 -0400
Message-Id: <20231013181122.3518610-2-longman@redhat.com>
In-Reply-To: <20231013181122.3518610-1-longman@redhat.com>
References: <20231013181122.3518610-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

This patch adds a new workqueue_unbound_exclude_cpumask() to enable
that. This new function will exclude the specified isolated CPUs
from wq_unbound_cpumask. To be able to restore those isolated CPUs
back after the destruction of isolated cpuset partitions, a new
wq_user_unbound_cpumask is added to store the user provided unbound
cpumask either from the boot command line options or from writing to
the cpumask sysfs file. This new cpumask provides the basis for CPU
exclusion.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/workqueue.h |  2 +-
 kernel/workqueue.c        | 42 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

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
index 010b674b02a7..19d403aa41b0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -381,6 +381,9 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 /* PL&A: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
+/* PL: user-provided unbound cpumask via sysfs */
+static cpumask_var_t wq_user_unbound_cpumask;
+
 /* for further constrain wq_unbound_cpumask by cmdline parameter*/
 static struct cpumask wq_cmdline_cpumask __initdata;
 
@@ -5825,7 +5828,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
  *  		-EINVAL	- Invalid @cpumask
  *  		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
  */
-int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
+static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 {
 	int ret = -EINVAL;
 
@@ -5836,6 +5839,7 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	cpumask_and(cpumask, cpumask, cpu_possible_mask);
 	if (!cpumask_empty(cpumask)) {
 		apply_wqattrs_lock();
+		cpumask_copy(wq_user_unbound_cpumask, cpumask);
 		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
 			ret = 0;
 			goto out_unlock;
@@ -5850,6 +5854,40 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	return ret;
 }
 
+/**
+ * workqueue_unbound_exclude_cpumask - Exclude given CPUs from unbound cpumask
+ * @exclude_cpumask: the cpumask to be excluded from wq_unbound_cpumask
+ *
+ * This function can be called from cpuset code to provide a set of isolated
+ * CPUs that should be excluded from wq_unbound_cpumask.
+ */
+int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
+{
+	cpumask_var_t cpumask;
+	int ret = 0;
+
+	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	/*
+	 * The caller of this function may have called cpus_read_lock(),
+	 * use cpus_read_trylock() to avoid potential deadlock.
+	 */
+	if (!cpus_read_trylock())
+		return -EBUSY;
+	mutex_lock(&wq_pool_mutex);
+
+	if (!cpumask_andnot(cpumask, wq_user_unbound_cpumask, exclude_cpumask))
+		ret = -EINVAL;	/* The new cpumask can't be empty */
+	else if (!cpumask_equal(cpumask, wq_unbound_cpumask))
+		ret = workqueue_apply_unbound_cpumask(cpumask);
+
+	mutex_unlock(&wq_pool_mutex);
+	cpus_read_unlock();
+	free_cpumask_var(cpumask);
+	return ret;
+}
+
 static int parse_affn_scope(const char *val)
 {
 	int i;
@@ -6520,11 +6558,13 @@ void __init workqueue_init_early(void)
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&wq_user_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 	if (!cpumask_empty(&wq_cmdline_cpumask))
 		cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, &wq_cmdline_cpumask);
+	cpumask_copy(wq_user_unbound_cpumask, wq_unbound_cpumask);
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-- 
2.39.3

