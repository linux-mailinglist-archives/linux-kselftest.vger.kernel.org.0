Return-Path: <linux-kselftest+bounces-3159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16541830B34
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F49F28D333
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50F022EEC;
	Wed, 17 Jan 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxJj1sgc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03492224E1
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509379; cv=none; b=Toz3IU+BEi+fYrpDl2wIF3KX/NT+kQQ1BocGIfyua7rfv1BGJ+Z4QLjR2ajd4Sfpr84kKc4ODuTIzc29KQrmJOGCkxP1uDBNbaPB6T0inaHxthlKzYzRLUslspzMG+3oWk2cGQc8ZhhDKIYXQjaWd+YET1FMJCd1Lw2rdU1EFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509379; c=relaxed/simple;
	bh=8QWtVc8UZZD0QE6DxocDuZo346g6BcMbcuc1gxx+sDM=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=WlvzdwYmyJttBCPuWoKByIhijqJdtcXIIhq3wRUOKwtxUl3Dfvoal21BAUWRG9yG6cguyoTeOVHMtVoz50q5bOZQ+iAnOG92ShCO1TTXd8xkLpTYA1LfVSZ0iLWVqf2QRlZBXCihxHeuRi/wKmfM5Y+roiK+SAzdSkBicyyVhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxJj1sgc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOAtVa5plf2y0/XGqN0I4sCFdII80MtXXh53ltOWBp4=;
	b=LxJj1sgcQRTreRe8Yxy3OqspBorTYxmiMjA2S7mN+BF6YHyWddQX3uer5y7BSI3/uVmMTr
	aKErRtcaFnPBEYDgrBGXupk/eIz4exGfrxrlYEkDY1pmNsG+3jLqa9HQsCxcg4QsNXB5Hs
	jDueMmKN292bbgK95KOH17f+/TKaoMw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-idE8Qwz3MPmcTh9apb_XGw-1; Wed, 17 Jan 2024 11:36:14 -0500
X-MC-Unique: idE8Qwz3MPmcTh9apb_XGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1452E85A58C;
	Wed, 17 Jan 2024 16:36:13 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7791B1121306;
	Wed, 17 Jan 2024 16:36:11 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 5/8] cgroup/cpuset: Add cpuset.cpus.isolation_full
Date: Wed, 17 Jan 2024 11:35:08 -0500
Message-Id: <20240117163511.88173-6-longman@redhat.com>
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This patch adds a new root only cpuset.cpus.isolation_full control file
for enabling or disabling full CPU isolation mode where additional CPU
isolation methods available to be used by cpuset will be turned on or
off for all the isolated CPUs within isolated partitions.

On write, cpuset.cpus.isolation_full accepts any integer. A zero value
will disable full CPU isolation while a non-zero value will enable it.
On read, cpuset.cpus.isolation_full will return either "0" (disabled)
or "1" (enabled) followed by a comma separated list of additional
CPU isolation methods that are enabled. The list of these available
isolation methods will depend on kernel configuration options used as
well as the presence of some pre-conditions for some of them.

This patch only provides the infrastructure code. The various isolation
methods will be added later on.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 88 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0479af76a5dc..d1d4ce213979 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -218,6 +218,30 @@ enum isolated_cpus_modifiers {
  */
 static cpumask_var_t	isolated_cpus;
 
+/*
+ * Enable full CPU isolation in isolated partitions, if set.
+ */
+static bool isolation_full;
+
+/*
+ * A flag indicating what cpuset full isolation modes can be enabled.
+ */
+static int isolation_flags;
+
+enum cpuset_isolation_types {
+	ISOL_TYPE_MAX,
+};
+
+static const char * const isolation_type_names[ISOL_TYPE_MAX] = {
+};
+
+/* Detect the cpuset isolation modes that can be enabled */
+static __init int set_isolation_flags(void)
+{
+	return 0;
+}
+late_initcall(set_isolation_flags);
+
 /* List of remote partition root children */
 static struct list_head remote_children;
 
@@ -1524,6 +1548,8 @@ static int partition_xcpus_del(int old_prs, struct cpuset *parent,
  * state and the whole isolated_cpus is passed. Repeated calls with the same
  * isolated_cpus will not cause further action other than a wasted mutex
  * lock/unlock.
+ *
+ * The other isolation modes will only be activated when isolation_full is set.
  */
 static int update_isolation_cpumasks(struct cpumask *mask, int modifier)
 {
@@ -1536,6 +1562,13 @@ static int update_isolation_cpumasks(struct cpumask *mask, int modifier)
 
 	err = workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(err);
+
+	if (!isolation_flags || !isolation_full)
+		return err;
+
+	if (WARN_ON_ONCE(cpumask_empty(mask)))
+		return -EINVAL;
+
 	return err;
 }
 
@@ -3514,6 +3547,7 @@ typedef enum {
 	FILE_EXCLUSIVE_CPULIST,
 	FILE_EFFECTIVE_XCPULIST,
 	FILE_ISOLATED_CPULIST,
+	FILE_ISOLATION_FULL,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
 	FILE_MEM_HARDWALL,
@@ -3713,6 +3747,25 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_ISOLATED_CPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(isolated_cpus));
 		break;
+	case FILE_ISOLATION_FULL:
+		if (isolation_full) {
+			int i, cnt;
+
+			/* Also print the isolation modes that are enabled */
+			seq_puts(sf, "1");
+			for (i = cnt = 0; i < ISOL_TYPE_MAX; i++) {
+				if (!(isolation_flags & BIT(i)))
+					continue;
+
+				seq_printf(sf, "%c%s", cnt ? ',' : ' ',
+					   isolation_type_names[i]);
+				cnt++;
+			}
+			seq_puts(sf, "\n");
+		} else {
+			seq_puts(sf, "0\n");
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -3833,6 +3886,33 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	return retval ?: nbytes;
 }
 
+/*
+ * cpuset_write_isolfull - enable/disable cpuset isolation full mode
+ */
+static int cpuset_write_isolfull(struct cgroup_subsys_state *css,
+				 struct cftype *cft, u64 val)
+{
+	struct cpuset *cs = css_cs(css);
+	int retval = 0;
+
+	cpus_read_lock();
+	mutex_lock(&cpuset_mutex);
+	if (!is_cpuset_online(cs)) {
+		retval = -ENODEV;
+	} else if (isolation_full != !!val) {
+		isolation_full = !!val;
+		if (!cpumask_empty(isolated_cpus)) {
+			int mod = isolation_full
+				  ? ISOL_CPUS_ADD : ISOL_CPUS_DELETE;
+
+			retval = update_isolation_cpumasks(isolated_cpus, mod);
+		}
+	}
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+	return retval;
+}
+
 /*
  * for the common functions, 'private' gives the type of file
  */
@@ -4013,6 +4093,14 @@ static struct cftype dfl_files[] = {
 		.flags = CFTYPE_ONLY_ON_ROOT,
 	},
 
+	{
+		.name = "cpus.isolation_full",
+		.seq_show = cpuset_common_seq_show,
+		.write_u64 = cpuset_write_isolfull,
+		.private = FILE_ISOLATION_FULL,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
 	{ }	/* terminate */
 };
 
-- 
2.39.3


