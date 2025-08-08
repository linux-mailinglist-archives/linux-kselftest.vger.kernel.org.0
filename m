Return-Path: <linux-kselftest+bounces-38576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0274B1EB46
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A922B18C3DDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F8283FD4;
	Fri,  8 Aug 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nzek6cnj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C018283FD6
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665950; cv=none; b=r4o6NQ+6LBCVQJdlRxFASojZj8NPbrtvXQS49RpmVXZ5mN2HvCdIkNys00+hQu+PwE0wBGooBs2GZkzUEvTaBr3sX27L9dYt8EzxyR6CP1azJUiwDO2V9S2CAGY9gLCe2ojfDGQYk2+ftEZPAkHxCPyswpBsYOxyfY4ZwZAUkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665950; c=relaxed/simple;
	bh=FgjIWfU+qvY0l477cECYpRJobxSzgSfnhfM0BHAM+Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6Lk1XTvjGeqRYdyvwZPb/AczWRAieuVRXAJm+cXxiPaiCwl1RBFk9PCnNXXLOnSQxlMEuOBm0rwkjyRrA7275yRh2mzWcIfRBdJTy6N9CehsIp9pmE9NbQW5HDp0HAhI4E74mHLTCtRt8wUBhDeCwOtaIPCIitSPAzz0DNlKic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nzek6cnj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3YmjVs5UGHP5zKmSwFLIwmnWgiM9jmDjv5kWmHyuwI=;
	b=Nzek6cnjQYWdHWpsc2ibTnASB4l0rc6wnrYlCe2HNeKiFnMNMiD4x1zOagcyaG2wBSUJYZ
	L968Y36BNh9NFjDs419NnB3K1vbgtX1gRTuhDnoEkqNvxkcR3JZNll4BVfcHLlnwDnyTAB
	s472p+y0NjmAk9lMmoM6XGJ8n8/rqyE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-nlGtU5NvMkaxGDR46lIxJw-1; Fri,
 08 Aug 2025 11:12:26 -0400
X-MC-Unique: nlGtU5NvMkaxGDR46lIxJw-1
X-Mimecast-MFC-AGG-ID: nlGtU5NvMkaxGDR46lIxJw_1754665942
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17C241800371;
	Fri,  8 Aug 2025 15:12:22 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D90541954199;
	Fri,  8 Aug 2025 15:12:14 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 05/18] cpu/hotplug: Add a new cpuhp_offline_cb() API
Date: Fri,  8 Aug 2025 11:10:49 -0400
Message-ID: <20250808151053.19777-6-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a new cpuhp_offline_cb() API that allows us to offline a set of
CPUs one-by-one, run the given callback function and then bring those
CPUs back online again while inhibiting any concurrent CPU hotplug
operations from happening.

This new API can be used to enable runtime adjustment of nohz_full and
isolcpus boot command line options. A new cpuhp_offline_cb_mode flag
is also added to signal that the system is in this offline callback
transient state so that some hotplug operations can be optimized out
if we choose to.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cpuhplock.h |  9 ++++++++
 kernel/cpu.c              | 47 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/cpuhplock.h b/include/linux/cpuhplock.h
index f7aa20f62b87..b42b81361abc 100644
--- a/include/linux/cpuhplock.h
+++ b/include/linux/cpuhplock.h
@@ -9,7 +9,9 @@
 
 #include <linux/cleanup.h>
 #include <linux/errno.h>
+#include <linux/cpumask_types.h>
 
+typedef int (*cpuhp_cb_t)(void *arg);
 struct device;
 
 extern int lockdep_is_cpus_held(void);
@@ -28,6 +30,8 @@ void clear_tasks_mm_cpumask(int cpu);
 int remove_cpu(unsigned int cpu);
 int cpu_device_down(struct device *dev);
 void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
+int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg);
+extern bool cpuhp_offline_cb_mode;
 
 #else /* CONFIG_HOTPLUG_CPU */
 
@@ -42,6 +46,11 @@ static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
 static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
 static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
+static inline int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg)
+{
+	return -EPERM;
+}
+#define cpuhp_offline_cb_mode	false
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
 DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
diff --git a/kernel/cpu.c b/kernel/cpu.c
index faf0f23fc5d8..b6364a1950b1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1534,6 +1534,53 @@ int remove_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(remove_cpu);
 
+bool cpuhp_offline_cb_mode;
+
+/**
+ * cpuhp_offline_cb - offline CPUs, invoke callback function & online CPUs afterward
+ * @mask: A mask of CPUs to be taken offline and then online
+ * @func: A callback function to be invoked while the given CPUs are offline
+ * @arg:  Argument to be passed back to the callback function
+ * Return: 0 if successful, an error code otherwise
+ */
+int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg)
+{
+	int cpu, ret, ret2 = 0;
+
+	if (WARN_ON_ONCE(cpumask_empty(mask)))
+		return -EINVAL;
+
+	lock_device_hotplug();
+	cpuhp_offline_cb_mode = true;
+	for_each_cpu(cpu, mask) {
+		ret = device_offline(get_cpu_device(cpu));
+		if (unlikely(ret)) {
+			int cpu2;
+
+			/* Online the offline CPUs before returning */
+			for_each_cpu(cpu2, mask) {
+				if (cpu2 == cpu)
+					break;
+				device_online(get_cpu_device(cpu2));
+			}
+			goto out;
+		}
+	}
+	ret = func(arg);
+
+	/* Bring CPUs back online */
+	for_each_cpu(cpu, mask) {
+		int ret3 = device_online(get_cpu_device(cpu));
+
+		if (ret3 && !ret2)
+			ret2 = ret3;
+	}
+out:
+	cpuhp_offline_cb_mode = false;
+	unlock_device_hotplug();
+	return ret ? ret : (ret2 ? ret2 : 0);
+}
+
 void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 {
 	unsigned int cpu;
-- 
2.50.0


