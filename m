Return-Path: <linux-kselftest+bounces-38575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56AEB1EB40
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D165876E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C802820D5;
	Fri,  8 Aug 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZ2Hdb+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA5283CB5
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665948; cv=none; b=qADlaoNYpNUXHB/PNXajkyrqwoKbA6dpGaiJEy+l8a4JxYwrpHZXAV75m0W1LjYgHRrAuI16vV+cP0dgba53x4W2iSmP3QvLSIr2yQEEwSNRhiL124sQnPra230lZhDO+eEM8GgZ7R3J4btLfmLvxmpi6fjwCBL1NzoI37O/Q4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665948; c=relaxed/simple;
	bh=E5C5hX5eN0f29firekyx2hBKs492l3eG/OpZn3r3C/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By8LE7NokrifSzV1u40yv/uIkoukBONZf885uPOpts5HGySKLxv4Np7gSpbU2lNAnzoXgnTvbPJmRz0CPTfvaMFhcE+k4tA80B2N+rxjlIYElmD94tTcrX1GWUN+kn19joRnzCwk4HTaYhFPicoL3kPQDgNj2ilpfA30ZD9ZmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZ2Hdb+Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roaCs6aaTpSLNP30noSwdjwLN929rnnIEU4sqPWHpnk=;
	b=ZZ2Hdb+YhAFiexr/tcoM78Xv5UD08keRLRcyV8PVOCA/hASdVR8V5VXdQ7r+lT7x2KVOBM
	CWtstosnYCfP6TQu+QiTVCSXiCDtkGk+Ia84Z6M48+neFKAceYbTBZ1ofd5DPP/0QEzHSy
	MQVGdykHBMXYhaKXwSwMkWdk/V2Q3Ro=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-02rJ4c0cMIWbuNa0oT-s6w-1; Fri,
 08 Aug 2025 11:12:18 -0400
X-MC-Unique: 02rJ4c0cMIWbuNa0oT-s6w-1
X-Mimecast-MFC-AGG-ID: 02rJ4c0cMIWbuNa0oT-s6w_1754665935
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92B1A180028D;
	Fri,  8 Aug 2025 15:12:14 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 505F71954196;
	Fri,  8 Aug 2025 15:12:08 +0000 (UTC)
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
Subject: [RFC PATCH 04/18] sched/isolation: Add a debugfs file to dump housekeeping cpumasks
Date: Fri,  8 Aug 2025 11:10:48 -0400
Message-ID: <20250808151053.19777-5-longman@redhat.com>
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

As housekeeping cpumasks can now be modified at run time, we need a way
to examine the their current values to see if they meet our expectation.
Add a new sched debugfs file "housekeeping_cpumasks" to dump out the
current values.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/debug.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f..ba8f0334c15e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -490,6 +490,35 @@ static void debugfs_fair_server_init(void)
 	}
 }
 
+#ifdef CONFIG_CPU_ISOLATION
+static int hk_cpumasks_show(struct seq_file *m, void *v)
+{
+	static const char * const hk_type_name[HK_TYPE_MAX] = {
+		[HK_TYPE_DOMAIN]	= "domain",
+		[HK_TYPE_MANAGED_IRQ]	= "managed_irq",
+		[HK_TYPE_KERNEL_NOISE]	= "nohz_full"
+	};
+	int type;
+
+	for (type = 0; type < HK_TYPE_MAX; type++)
+		seq_printf(m, "%s: %*pbl\n", hk_type_name[type],
+			   cpumask_pr_args(housekeeping_cpumask(type)));
+	return 0;
+}
+
+static int hk_cpumasks_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hk_cpumasks_show, NULL);
+}
+
+static const struct file_operations hk_cpumasks_fops = {
+	.open		= hk_cpumasks_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+#endif
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -525,6 +554,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_CPU_ISOLATION
+	debugfs_create_file("housekeeing_cpumasks", 0444, debugfs_sched, NULL, &hk_cpumasks_fops);
+#endif
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
-- 
2.50.0


