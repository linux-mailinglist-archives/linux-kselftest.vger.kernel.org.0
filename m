Return-Path: <linux-kselftest+bounces-43335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15036BE3FF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC350587446
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9FC346A10;
	Thu, 16 Oct 2025 14:47:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88216345749
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626031; cv=none; b=B7CJR9wbb4gEArtQozTqKrYaFEaE8gSBNpb1B42+6UAk6sBjXyUx6yrcrVfKMx1OuCzeLUR6xRPjbn/m1Sge+GFER+666zs+CUInTfHwu7OR50fTh7rjMnuqtltJFqAXw7CJAzFJKSWU97R0nzHRvlm2pdqDd664O280EMeH+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626031; c=relaxed/simple;
	bh=4PkymEnoVdRtepOzzfqNBr9XSbvC+t1sAFB6PLtH3vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6U5DWbBCvKAQG1btMLmtiif9wPHHmLCilb9xPHqTf9ezVMdRaaFi8IFvyzFxTrIzNRK5vUvz8aMcEOGuK+lcYdQMd/ljheATwd29ejI4LzszE47896567iOEp+/ukklHA75k2M6X0wJ7UJApAUn1ID9pFcsj9JJnvC90b1j3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-43f802f8571so248768b6e.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 07:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626027; x=1761230827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ur3B9LnadG5KKvwOBpgGnRJ5DQSqBj6YAeCWZFDvocU=;
        b=U8E4PooXhmcF55FoUuI+w7w99PbnDNLUKmyMLAnKGST5rRjsAh33O4n7cj20Pdhcca
         4T8U/IhTKDWqXy1oewjvFWkS9P4JtPQIWez6YfjTVgc1P49Ou5JwbsqMLeH67RHZsxkY
         G0GspM49ui/MmtDROR73YzWhIuQQ0UePZoOq3skR1W4VUVEtR+Ocsv53mD8RCLHCXBBa
         rgbS4vKhMx5EX0+f6F0IjljXYK0IdOjWk2LlSR14GFjWfGM8ngsx4exVQJ6qzpf3iEO6
         EPPpn4a7MCtNBkR+ftd8h4GKlj76+Qg+UxZFSKaVt0Xv+SLnhKxhsTjkRcApVjEBhMO9
         DJJA==
X-Gm-Message-State: AOJu0YwtSuOXULjm4gLfJ/Zbi2LQ336i/H9fCmEVsor4GbWyhirQRT0a
	nsU9oTOCkIHs6B6oBJzwzJk3SEdLl510ALekOgC6i1hvsbI2odvsIlqW
X-Gm-Gg: ASbGncsNvQ0WNrALVnE1agXwdVlMLxqrQStrArPSlD70t+gHkyUYKHGs8N7P3rkKyIt
	jZPrME1wFv9PMPEZvrH7WOdk2qrtB21MntvvRyCWsmYZqHuAZ6ZDEW3BohH7EThkWeQkCDuHNQT
	RwaZfYxBgcxrr1G+nOx0lqdq93QmX4Zeo3SkzFpnK0qak2eJiUEdxDmsqBj9TOEyGka41+5hffB
	anVyRqDQs2JN1pqt3J6GmqioTfiiCgD91uHOsFCuIq3mWTOrkzTdgnthJC4hEnLveJ51E2UxwZR
	+IeYiOTVzz/MgHWxnwto6kEUlinq3NfqxsS/8Ip9G0nDVG4czR3CtkiawF5hQwwuSb33rQK/4JW
	idO3j9QOcHUtTQGfxWjAvi0dS2n+xoI2QOz7ExxquuKF7AIJWn+k1tm4gYCce1cnH9O6wqSndAu
	Iex4c4at12OuBIKHhuPnTOrJfnxrkw5eTP1ynbgiW1L4H9yHFTA8t//1oTXcXkzL49Hu0=
X-Google-Smtp-Source: AGHT+IH6p3EoDt2Q2OjQfChqhrM9XWfpgsCGhAglt0qBiNiKR3HS881D+1RpYhTtN0m0f3G7oz8JfQ==
X-Received: by 2002:a05:6808:18a7:b0:438:8ad:16b9 with SMTP id 5614622812f47-443a30d1062mr72092b6e.32.1760626027423;
        Thu, 16 Oct 2025 07:47:07 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:07 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	James Morse <james.morse@arm.com>,
	Roman Storozhenko <romeusmeister@gmail.com>,
	Jonathan Perry <yonch@yonch.com>
Subject: [PATCH 6/8] resctrl/pmu: Introduce skeleton PMU and selftests
Date: Thu, 16 Oct 2025 09:46:54 -0500
Message-ID: <20251016144656.74928-7-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251016144656.74928-1-yonch@yonch.com>
References: <20251016144656.74928-1-yonch@yonch.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register a read-only "resctrl" PMU and implement minimal perf hooks
(event_init, add, del, start, stop, read, destroy). The PMU accepts a
resctrl monitoring file descriptor via attr.config, resolves the
rdtgroup, and pins it for the event's lifetime.

Call PMU init/exit in resctrl_init()/resctrl_exit().

Add a selftest to exercise PMU registration and verify that only
allowed monitoring files can be opened via perf.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/Makefile                           |   2 +-
 fs/resctrl/internal.h                         |  12 ++
 fs/resctrl/pmu.c                              | 139 ++++++++++++
 fs/resctrl/rdtgroup.c                         |  53 +++++
 tools/testing/selftests/resctrl/pmu_test.c    | 202 ++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h     |   1 +
 .../testing/selftests/resctrl/resctrl_tests.c |   1 +
 7 files changed, 409 insertions(+), 1 deletion(-)
 create mode 100644 fs/resctrl/pmu.c
 create mode 100644 tools/testing/selftests/resctrl/pmu_test.c

diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
index e67f34d2236a..f738b0165ccc 100644
--- a/fs/resctrl/Makefile
+++ b/fs/resctrl/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
+obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o pmu.o
 obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
 
 # To allow define_trace.h's recursive include:
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 486cbca8d0ec..b42c625569a8 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -4,6 +4,7 @@
 
 #include <linux/resctrl.h>
 #include <linux/kernfs.h>
+#include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/tick.h>
 
@@ -362,6 +363,17 @@ void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 int rdtgroup_mondata_open(struct kernfs_open_file *of);
 void rdtgroup_mondata_release(struct kernfs_open_file *of);
+void rdtgroup_get(struct rdtgroup *rdtgrp);
+void rdtgroup_put(struct rdtgroup *rdtgrp);
+
+/* PMU support */
+/*
+ * Get rdtgroup from a resctrl monitoring file and take a reference.
+ * Returns a valid pointer with an extra reference on success, or ERR_PTR on failure.
+ */
+struct rdtgroup *rdtgroup_get_from_file(struct file *file);
+int resctrl_pmu_init(void);
+void resctrl_pmu_exit(void);
 
 void rmid_read_init(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
diff --git a/fs/resctrl/pmu.c b/fs/resctrl/pmu.c
new file mode 100644
index 000000000000..e7915a0a3520
--- /dev/null
+++ b/fs/resctrl/pmu.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Perf event access to resctrl monitoring (cache occupancy, memory bandwidth)
+ */
+
+#define pr_fmt(fmt) "resctrl_pmu: " fmt
+
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/seq_file.h>
+#include "internal.h"
+
+static struct pmu resctrl_pmu;
+
+/*
+ * Event private data - stores information about the monitored resctrl group
+ */
+struct resctrl_pmu_event {
+	struct rdtgroup *rdtgrp;	/* Reference to rdtgroup being monitored */
+};
+
+static void resctrl_event_destroy(struct perf_event *event);
+
+/*
+ * Initialize a new resctrl perf event
+ * The config field contains the file descriptor of the monitoring file
+ */
+static int resctrl_event_init(struct perf_event *event)
+{
+	struct resctrl_pmu_event *resctrl_event;
+	struct file *file;
+	struct rdtgroup *rdtgrp;
+	int fd;
+	int ret;
+
+	fd = (int)event->attr.config;
+	if (fd < 0)
+		return -EINVAL;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	/* Resolve rdtgroup from the monitoring file and take a reference */
+	rdtgrp = rdtgroup_get_from_file(file);
+	fput(file);
+	if (IS_ERR(rdtgrp))
+		return PTR_ERR(rdtgrp);
+
+	resctrl_event = kzalloc(sizeof(*resctrl_event), GFP_KERNEL);
+	if (!resctrl_event) {
+		rdtgroup_put(rdtgrp);
+		return -ENOMEM;
+	}
+
+	resctrl_event->rdtgrp = rdtgrp;
+	event->pmu_private = resctrl_event;
+	event->destroy = resctrl_event_destroy;
+
+	return 0;
+}
+
+static void resctrl_event_destroy(struct perf_event *event)
+{
+	struct resctrl_pmu_event *resctrl_event = event->pmu_private;
+
+	if (resctrl_event) {
+		struct rdtgroup *rdtgrp = resctrl_event->rdtgrp;
+
+		if (rdtgrp)
+			rdtgroup_put(rdtgrp);
+
+		kfree(resctrl_event);
+		event->pmu_private = NULL;
+	}
+}
+
+static void resctrl_event_update(struct perf_event *event)
+{
+	/* Currently just a stub - would read actual cache occupancy here */
+	local64_set(&event->hw.prev_count, 0);
+}
+
+static void resctrl_event_start(struct perf_event *event, int flags)
+{
+	resctrl_event_update(event);
+}
+
+static void resctrl_event_stop(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_UPDATE)
+		resctrl_event_update(event);
+}
+
+static int resctrl_event_add(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_START)
+		resctrl_event_start(event, flags);
+
+	return 0;
+}
+
+static void resctrl_event_del(struct perf_event *event, int flags)
+{
+	resctrl_event_stop(event, PERF_EF_UPDATE);
+}
+
+static struct pmu resctrl_pmu = {
+	.task_ctx_nr	= perf_invalid_context,
+	.event_init	= resctrl_event_init,
+	.add		= resctrl_event_add,
+	.del		= resctrl_event_del,
+	.start		= resctrl_event_start,
+	.stop		= resctrl_event_stop,
+	.read		= resctrl_event_update,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+};
+
+int resctrl_pmu_init(void)
+{
+	int ret;
+
+	ret = perf_pmu_register(&resctrl_pmu, "resctrl", -1);
+	if (ret) {
+		pr_err("Failed to register resctrl PMU: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void resctrl_pmu_exit(void)
+{
+	perf_pmu_unregister(&resctrl_pmu);
+}
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 34337abe5345..4f4139edafbf 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3428,6 +3428,53 @@ void rdtgroup_mondata_release(struct kernfs_open_file *of)
 	}
 }
 
+/*
+ * rdtgroup_get_from_file - Resolve rdtgroup from a resctrl mon data file
+ * @file: struct file opened on a resctrl monitoring data file
+ *
+ * Validate that @file belongs to resctrl and refers to a monitoring data
+ * file (kf_mondata_ops). Then, using the kernfs_open_file stored in the
+ * seq_file, safely fetch the rdtgroup that was pinned at open time and take
+ * an additional rdtgroup reference for the caller under rdtgroup_mutex.
+ *
+ * Returns: rdtgroup* with an extra reference on success; ERR_PTR on failure.
+ */
+struct rdtgroup *rdtgroup_get_from_file(struct file *file)
+{
+	struct rdtgroup *rdtgrp = NULL;
+	struct kernfs_open_file *of;
+	struct seq_file *seq;
+	struct inode *inode;
+
+	if (!file)
+		return ERR_PTR(-EBADF);
+
+	inode = file_inode(file);
+	/* Check the file is part of the resctrl filesystem */
+	if (!inode || !inode->i_sb || inode->i_sb->s_type != &rdt_fs_type)
+		return ERR_PTR(-EINVAL);
+
+	/* kernfs monitoring files use seq_file; seq_file->private is kernfs_open_file */
+	seq = (struct seq_file *)file->private_data;
+	if (!seq)
+		return ERR_PTR(-EINVAL);
+
+	of = (struct kernfs_open_file *)seq->private;
+	/* Check this is a monitoring file */
+	if (!of || !of->kn || of->kn->attr.ops != &kf_mondata_ops)
+		return ERR_PTR(-EINVAL);
+
+	/* Hold rdtgroup_mutex to prevent race with release callback */
+	guard(mutex)(&rdtgroup_mutex);
+
+	rdtgrp = of->priv;
+	if (!rdtgrp || (rdtgrp->flags & RDT_DELETED))
+		return ERR_PTR(-ENOENT);
+
+	rdtgroup_get(rdtgrp);
+	return rdtgrp;
+}
+
 /**
  * cbm_ensure_valid - Enforce validity on provided CBM
  * @_val:	Candidate CBM
@@ -4509,6 +4556,10 @@ int resctrl_init(void)
 	 */
 	debugfs_resctrl = debugfs_create_dir("resctrl", NULL);
 
+	ret = resctrl_pmu_init();
+	if (ret)
+		pr_warn("Failed to initialize resctrl PMU: %d\n", ret);
+
 	return 0;
 
 cleanup_mountpoint:
@@ -4558,6 +4609,8 @@ static bool resctrl_online_domains_exist(void)
  */
 void resctrl_exit(void)
 {
+	resctrl_pmu_exit();
+
 	cpus_read_lock();
 	WARN_ON_ONCE(resctrl_online_domains_exist());
 
diff --git a/tools/testing/selftests/resctrl/pmu_test.c b/tools/testing/selftests/resctrl/pmu_test.c
new file mode 100644
index 000000000000..29a0ac329619
--- /dev/null
+++ b/tools/testing/selftests/resctrl/pmu_test.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resctrl PMU test
+ *
+ * Test program to verify the resctrl PMU functionality.
+ * Walks resctrl filesystem and verifies only allowed files can be
+ * used with the resctrl PMU via perf_event_open.
+ */
+
+#include "resctrl.h"
+#include <fcntl.h>
+#include <dirent.h>
+
+#define RESCTRL_PMU_NAME "resctrl"
+
+static int find_pmu_type(const char *pmu_name)
+{
+	char path[256];
+	FILE *file;
+	int type;
+
+	snprintf(path, sizeof(path), "/sys/bus/event_source/devices/%s/type",
+		 pmu_name);
+
+	file = fopen(path, "r");
+	if (!file) {
+		ksft_print_msg("Failed to open %s: %s\n", path,
+			       strerror(errno));
+		return -1;
+	}
+
+	if (fscanf(file, "%d", &type) != 1) {
+		ksft_print_msg("Failed to read PMU type from %s\n", path);
+		fclose(file);
+		return -1;
+	}
+
+	fclose(file);
+	return type;
+}
+
+static bool is_allowed_file(const char *filename)
+{
+	const char *base;
+
+	/* Only exact llc_occupancy and mbm files (no *_config) are allowed */
+	base = strrchr(filename, '/');
+	base = base ? base + 1 : filename;
+
+	return (!strcmp(base, "llc_occupancy") ||
+		!strcmp(base, "mbm_total_bytes") ||
+		!strcmp(base, "mbm_local_bytes"));
+}
+
+static int test_file_safety(int pmu_type, const char *filepath)
+{
+	struct perf_event_attr pe = { 0 };
+	int fd, perf_fd;
+	bool should_succeed;
+
+	/* Try to open the file */
+	fd = open(filepath, O_RDONLY);
+	if (fd < 0) {
+		/* File couldn't be opened, skip it */
+		return 0;
+	}
+
+	should_succeed = is_allowed_file(filepath);
+
+	/* Setup perf event attributes */
+	pe.type = pmu_type;
+	pe.config = fd;
+	pe.size = sizeof(pe);
+	pe.disabled = 1;
+	pe.exclude_kernel = 0;
+	pe.exclude_hv = 0;
+
+	/* Try to open the perf event */
+	perf_fd = perf_event_open(&pe, -1, 0, -1, 0);
+
+	if (should_succeed) {
+		if (perf_fd < 0) {
+			ksft_print_msg("FAIL: unexpected - perf_event_open failed for %s: %s\n",
+				       filepath, strerror(errno));
+			close(fd);
+			return -1;
+		}
+		ksft_print_msg("PASS: Allowed file %s successfully opened perf event\n",
+			       filepath);
+		close(perf_fd);
+	} else {
+		if (perf_fd >= 0) {
+			ksft_print_msg("FAIL: unexpected - perf_event_open succeeded for %s\n",
+				       filepath);
+			close(perf_fd);
+			close(fd);
+			return -1;
+		}
+		ksft_print_msg("PASS: Blocked file %s correctly failed perf_event_open: %s\n",
+			       filepath, strerror(errno));
+	}
+
+out:
+	close(fd);
+	return 0;
+}
+
+static int walk_directory_recursive(int pmu_type, const char *dir_path)
+{
+	DIR *dir;
+	struct dirent *entry;
+	char full_path[1024];
+	struct stat statbuf;
+	int ret = 0;
+
+	dir = opendir(dir_path);
+	if (!dir) {
+		ksft_print_msg("Failed to open directory %s: %s\n", dir_path,
+			       strerror(errno));
+		return -1;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		/* Skip . and .. */
+		if (strcmp(entry->d_name, ".") == 0 ||
+		    strcmp(entry->d_name, "..") == 0)
+			continue;
+
+		snprintf(full_path, sizeof(full_path), "%s/%s", dir_path,
+			 entry->d_name);
+
+		if (stat(full_path, &statbuf) != 0) {
+			ksft_print_msg("Failed to stat %s: %s\n", full_path,
+				       strerror(errno));
+			continue;
+		}
+
+		if (S_ISDIR(statbuf.st_mode)) {
+			/* Recursively walk subdirectories */
+			if (walk_directory_recursive(pmu_type, full_path) != 0)
+				ret = -1;
+		} else if (S_ISREG(statbuf.st_mode)) {
+			/* Test regular files */
+			if (test_file_safety(pmu_type, full_path) != 0)
+				ret = -1;
+		}
+	}
+
+	closedir(dir);
+	return ret;
+}
+
+static int test_resctrl_pmu_safety(int pmu_type)
+{
+	ksft_print_msg("Testing resctrl PMU safety - walking all files in %s\n",
+		       RESCTRL_PATH);
+
+	/* Walk through all files and directories in /sys/fs/resctrl */
+	return walk_directory_recursive(pmu_type, RESCTRL_PATH);
+}
+
+static bool pmu_feature_check(const struct resctrl_test *test)
+{
+	return resctrl_mon_feature_exists("L3_MON", "llc_occupancy");
+}
+
+static int pmu_run_test(const struct resctrl_test *test,
+			const struct user_params *uparams)
+{
+	int pmu_type, ret;
+
+	ksft_print_msg("Testing resctrl PMU file access safety\n");
+
+	/* Find the resctrl PMU type */
+	pmu_type = find_pmu_type(RESCTRL_PMU_NAME);
+	if (pmu_type < 0) {
+		ksft_print_msg("Resctrl PMU not found - PMU is not registered?\n");
+		return -1;
+	}
+
+	ksft_print_msg("Found resctrl PMU with type: %d\n", pmu_type);
+
+	/* Run the safety test to ensure only appropriate files work */
+	ret = test_resctrl_pmu_safety(pmu_type);
+
+	if (ret == 0)
+		ksft_print_msg("Resctrl PMU safety test completed successfully\n");
+	else
+		ksft_print_msg("Resctrl PMU safety test failed\n");
+
+	return ret;
+}
+
+struct resctrl_test pmu_test = {
+	.name = "PMU",
+	.group = "pmu",
+	.resource = "L3",
+	.vendor_specific = 0,
+	.feature_check = pmu_feature_check,
+	.run_test = pmu_run_test,
+	.cleanup = NULL,
+};
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index cd3adfc14969..5b0e6074eaba 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -244,5 +244,6 @@ extern struct resctrl_test cmt_test;
 extern struct resctrl_test l3_cat_test;
 extern struct resctrl_test l3_noncont_cat_test;
 extern struct resctrl_test l2_noncont_cat_test;
+extern struct resctrl_test pmu_test;
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 5154ffd821c4..11ba9000e015 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -21,6 +21,7 @@ static struct resctrl_test *resctrl_tests[] = {
 	&l3_cat_test,
 	&l3_noncont_cat_test,
 	&l2_noncont_cat_test,
+	&pmu_test,
 };
 
 static int detect_vendor(void)

