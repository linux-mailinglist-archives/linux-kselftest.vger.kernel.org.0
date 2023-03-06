Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1F6ACEF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCFUMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCFULs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:11:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A34E5FC
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 12:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678133373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DOL1Xn5BRvEVzQbK0JT1QOBJzRVq//5ngfgMzTUxGY=;
        b=X7dbByQHviXSfvCs8M/M64K2RV/eMj2xJk30EzAF71WZ5pW5Tm4IbCSPPyV5aGShkfVLdv
        mezmloEf36pqiC0r4Re3A+xPvzUpu3jYId+20gUx6o492ztvx0WSyyyhKctl+OUxYyFdpI
        Mz/JukujCQgTUELpCSnAjNbGR5ln2eM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-8Nd4UDtXP3uOUYxmG6HB6A-1; Mon, 06 Mar 2023 15:09:28 -0500
X-MC-Unique: 8Nd4UDtXP3uOUYxmG6HB6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5301D885625;
        Mon,  6 Mar 2023 20:09:27 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE9E400DFA1;
        Mon,  6 Mar 2023 20:09:27 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] cgroup/cpuset: Add CONFIG_DEBUG_CPUSETS config for cpuset testing
Date:   Mon,  6 Mar 2023 15:08:48 -0500
Message-Id: <20230306200849.376804-5-longman@redhat.com>
In-Reply-To: <20230306200849.376804-1-longman@redhat.com>
References: <20230306200849.376804-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since commit 431c69fac05b ("cpuset: Honour task_cpu_possible_mask()
in guarantee_online_cpus()"), task_cpu_possible_mask() is used within
the cpuset code. However, it is hard to find a arm64 system that can
actually makes task_cpu_possible_mask() return different cpu mask. As a
result, it is hard to exercise the correctness of the code that handle
exception cases due to task_cpu_possible_mask().

To help in exercising those code paths, we need a way to force
task_cpu_possible_mask() to return a different cpu mask. This patch adds
a new CONFIG_DEBUG_CPUSETS config option to enable some debug code to do
just that. The idea is to create a debugfs file "debug_cpu_possible_mask"
that holds the cpumask to be returned by task_cpu_possible_mask() when
a task with name started with the special prefix "cstest" is used as
the input argument. Userspace testing code is then able to exercise
the different code that is affected by task_cpu_possible_mask().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 init/Kconfig           |  5 +++
 kernel/cgroup/cpuset.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 18f0bf50c468..2abaa830aff0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1140,6 +1140,11 @@ config PROC_PID_CPUSET
 	depends on CPUSETS
 	default y
 
+config DEBUG_CPUSETS
+	bool "Enable cpuset debugging"
+	depends on CPUSETS && DEBUG_FS
+	default n
+
 config CGROUP_DEVICE
 	bool "Device controller"
 	help
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index aa8225daf1d3..45051ebb6606 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -220,6 +220,29 @@ static inline bool is_prs_invalid(int prs_state)
 	return prs_state < 0;
 }
 
+#ifdef CONFIG_DEBUG_CPUSETS
+static struct cpumask debug_cpu_possible_mask;
+
+/*
+ * Debugging code for testing code involving task_cpu_possible_mask()
+ */
+static inline const struct cpumask *
+__task_cpu_possible_mask(struct task_struct *p)
+{
+	const struct cpumask *mask = task_cpu_possible_mask(p);
+
+	if (mask != cpu_possible_mask)
+		return mask;
+	else if (!strncmp(p->comm, "cstest", 6))
+		return &debug_cpu_possible_mask;
+	else
+		return cpu_possible_mask;
+}
+
+#undef  task_cpu_possible_mask
+#define task_cpu_possible_mask(p)	__task_cpu_possible_mask(p)
+#endif /* CONFIG_DEBUG_CPUSETS */
+
 /*
  * Temporary cpumasks for working with partitions that are passed among
  * functions to avoid memory allocation in inner functions.
@@ -4139,3 +4162,56 @@ void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
 	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
 		   nodemask_pr_args(&task->mems_allowed));
 }
+
+#ifdef CONFIG_DEBUG_CPUSETS
+#include <linux/debugfs.h>
+
+/*
+ * Add a debugfs file "debug_cpu_possible_mask" that allows user to set
+ * a debug mask for testing.
+ */
+static ssize_t read_debug_mask(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	char buf[80];
+	int len;
+
+	len = snprintf(buf, sizeof(buf) - 1, "%*pbl\n",
+		       cpumask_pr_args(&debug_cpu_possible_mask));
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t write_debug_mask(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	unsigned int len;
+	char buf[80];
+	int retval = 0;
+
+	len = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, len))
+		return -EFAULT;
+
+	if (!*buf)
+		cpumask_clear(&debug_cpu_possible_mask);
+	else
+		retval = cpulist_parse(buf, &debug_cpu_possible_mask);
+
+	return (retval < 0) ? retval : count;
+}
+
+static const struct file_operations fops_debug_mask = {
+	.read = read_debug_mask,
+	.write = write_debug_mask,
+	.llseek = default_llseek,
+};
+
+static int __init create_debug_cpu_possible_mask(void)
+{
+	cpumask_copy(&debug_cpu_possible_mask, cpu_possible_mask);
+	debugfs_create_file("debug_cpu_possible_mask", 0600, NULL, NULL,
+			    &fops_debug_mask);
+	return 0;
+}
+late_initcall(create_debug_cpu_possible_mask);
+#endif /* CONFIG_DEBUG_CPUSETS */
-- 
2.31.1

