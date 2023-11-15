Return-Path: <linux-kselftest+bounces-163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9C7EC935
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A451C20B3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D3A3EA8E;
	Wed, 15 Nov 2023 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPvKiP1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD223BB3A
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 17:04:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259A198
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 09:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700067857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt/uc3/sS3+KPK27UtScw6ZAU1P5p5ewZLM2SZmBAtw=;
	b=SPvKiP1Z/EnSefwS1+YzIe21X4MWtkF1JdSfkqHIEz5DGh4byCBjuy0W3lIrVNUpCAbXL0
	KXHspIcT1sMMJo7+HfdzvKZ15FQE0NQFUGVMFj+nbsMwdoL3uITBOHANnT+aw3+dq4wrtj
	v1naGTNFSdD8c1qsaIcC0a0Fvwvq9DQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-oDVOxx06MfCUcXt8xdUJZg-1; Wed, 15 Nov 2023 12:04:15 -0500
X-MC-Unique: oDVOxx06MfCUcXt8xdUJZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABD0385A58C;
	Wed, 15 Nov 2023 17:04:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B6201121306;
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
Subject: [PATCH v3 1/5] workqueue: Make workqueue_set_unbound_cpumask() static
Date: Wed, 15 Nov 2023 12:03:55 -0500
Message-Id: <20231115170359.163299-2-longman@redhat.com>
In-Reply-To: <20231115170359.163299-1-longman@redhat.com>
References: <20231115170359.163299-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The workqueue_set_unbound_cpumask() function is only used inside
workqueue.c with CONFIG_SYSFS. Make it static and move it down to within
the ifdef CONFIG_SYSFS block. Also mark workqueue_apply_unbound_cpumask()
as __maybe_unused for now as it will be used by another function
introduced in a later commit. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/workqueue.h |  1 -
 kernel/workqueue.c        | 76 +++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 24b1e5070f4d..cf49b467bd57 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -491,7 +491,6 @@ struct workqueue_attrs *alloc_workqueue_attrs(void);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
 int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs);
-int workqueue_set_unbound_cpumask(cpumask_var_t cpumask);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6e578f576a6f..8996cdba8f07 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5784,7 +5784,7 @@ void thaw_workqueues(void)
 }
 #endif /* CONFIG_FREEZER */
 
-static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
+static int __maybe_unused workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 {
 	LIST_HEAD(ctxs);
 	int ret = 0;
@@ -5827,43 +5827,6 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	return ret;
 }
 
-/**
- *  workqueue_set_unbound_cpumask - Set the low-level unbound cpumask
- *  @cpumask: the cpumask to set
- *
- *  The low-level workqueues cpumask is a global cpumask that limits
- *  the affinity of all unbound workqueues.  This function check the @cpumask
- *  and apply it to all unbound workqueues and updates all pwqs of them.
- *
- *  Return:	0	- Success
- *  		-EINVAL	- Invalid @cpumask
- *  		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
- */
-int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
-{
-	int ret = -EINVAL;
-
-	/*
-	 * Not excluding isolated cpus on purpose.
-	 * If the user wishes to include them, we allow that.
-	 */
-	cpumask_and(cpumask, cpumask, cpu_possible_mask);
-	if (!cpumask_empty(cpumask)) {
-		apply_wqattrs_lock();
-		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
-			ret = 0;
-			goto out_unlock;
-		}
-
-		ret = workqueue_apply_unbound_cpumask(cpumask);
-
-out_unlock:
-		apply_wqattrs_unlock();
-	}
-
-	return ret;
-}
-
 static int parse_affn_scope(const char *val)
 {
 	int i;
@@ -6158,6 +6121,43 @@ static struct bus_type wq_subsys = {
 	.dev_groups			= wq_sysfs_groups,
 };
 
+/**
+ *  workqueue_set_unbound_cpumask - Set the low-level unbound cpumask
+ *  @cpumask: the cpumask to set
+ *
+ *  The low-level workqueues cpumask is a global cpumask that limits
+ *  the affinity of all unbound workqueues.  This function check the @cpumask
+ *  and apply it to all unbound workqueues and updates all pwqs of them.
+ *
+ *  Return:	0	- Success
+ *		-EINVAL	- Invalid @cpumask
+ *		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
+ */
+static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
+{
+	int ret = -EINVAL;
+
+	/*
+	 * Not excluding isolated cpus on purpose.
+	 * If the user wishes to include them, we allow that.
+	 */
+	cpumask_and(cpumask, cpumask, cpu_possible_mask);
+	if (!cpumask_empty(cpumask)) {
+		apply_wqattrs_lock();
+		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
+			ret = 0;
+			goto out_unlock;
+		}
+
+		ret = workqueue_apply_unbound_cpumask(cpumask);
+
+out_unlock:
+		apply_wqattrs_unlock();
+	}
+
+	return ret;
+}
+
 static ssize_t wq_unbound_cpumask_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-- 
2.39.3


