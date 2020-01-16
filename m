Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579A713FB57
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbgAPVWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:38728 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbgAPVWK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870927"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2020 13:22:07 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "linux-kselftest" <linux-kselftest@vger.kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RESEND PATCH v9 02/13] selftests/resctrl: Add basic resctrl file system operations and data
Date:   Thu, 16 Jan 2020 13:32:35 -0800
Message-Id: <1579210366-55429-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The basic resctrl file system operations and data are added for future
usage by resctrl selftest tool.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Co-developed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/Makefile    |  12 +
 tools/testing/selftests/resctrl/resctrl.h   |  50 +++
 tools/testing/selftests/resctrl/resctrlfs.c | 462 ++++++++++++++++++++
 3 files changed, 524 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
new file mode 100644
index 000000000000..76bbd6d3e4a8
--- /dev/null
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -0,0 +1,12 @@
+CC = $(CROSS_COMPILE)gcc
+CFLAGS = -g -Wall
+SRCS=$(wildcard *.c)
+OBJS=$(SRCS:.c=.o)
+
+$(OBJS): $(SRCS)
+	$(CC) $(CFLAGS) -c $(SRCS)
+
+.PHONY: clean
+
+clean:
+	$(RM) $(OBJS)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
new file mode 100644
index 000000000000..ba98cd6efc64
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define _GNU_SOURCE
+#ifndef RESCTRL_H
+#define RESCTRL_H
+#include <stdio.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <dirent.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <asm/unistd.h>
+#include <linux/perf_event.h>
+
+#define RESCTRL_PATH		"/sys/fs/resctrl"
+#define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
+
+#define PARENT_EXIT(err_msg)			\
+	do {					\
+		perror(err_msg);		\
+		kill(ppid, SIGKILL);		\
+		exit(EXIT_FAILURE);		\
+	} while (0)
+
+pid_t bm_pid, ppid;
+
+int remount_resctrlfs(bool mum_resctrlfs);
+int get_resource_id(int cpu_no, int *resource_id);
+int validate_bw_report_request(char *bw_report);
+bool validate_resctrl_feature_request(char *resctrl_val);
+char *fgrep(FILE *inf, const char *str);
+int taskset_benchmark(pid_t bm_pid, int cpu_no);
+void run_benchmark(int signum, siginfo_t *info, void *ucontext);
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
+		   char *resctrl_val);
+int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
+			    char *resctrl_val);
+int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
+		    int group_fd, unsigned long flags);
+int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
+		 int op, char *resctrl_va);
+
+#endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
new file mode 100644
index 000000000000..1b125f9d8e5d
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic resctrl file system operations
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+int tests_run;
+
+static int find_resctrl_mount(char *buffer)
+{
+	FILE *mounts;
+	char line[256], *fs, *mntpoint;
+
+	mounts = fopen("/proc/mounts", "r");
+	if (!mounts) {
+		perror("/proc/mounts");
+		return -ENXIO;
+	}
+	while (!feof(mounts)) {
+		if (!fgets(line, 256, mounts))
+			break;
+		fs = strtok(line, " \t");
+		if (!fs)
+			continue;
+		mntpoint = strtok(NULL, " \t");
+		if (!mntpoint)
+			continue;
+		fs = strtok(NULL, " \t");
+		if (!fs)
+			continue;
+		if (strcmp(fs, "resctrl"))
+			continue;
+
+		fclose(mounts);
+		if (buffer)
+			strncpy(buffer, mntpoint, 256);
+
+		return 0;
+	}
+
+	fclose(mounts);
+
+	return -ENOENT;
+}
+
+/*
+ * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
+ * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ *
+ * If not mounted, mount it.
+ * If mounted and mum_resctrlfs then remount resctrl FS.
+ * If mounted and !mum_resctrlfs then noop
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int remount_resctrlfs(bool mum_resctrlfs)
+{
+	char mountpoint[256];
+	int ret;
+
+	ret = find_resctrl_mount(mountpoint);
+	if (ret)
+		strcpy(mountpoint, RESCTRL_PATH);
+
+	if (!ret && mum_resctrlfs && umount(mountpoint)) {
+		printf("not ok unmounting \"%s\"\n", mountpoint);
+		perror("# umount");
+		tests_run++;
+	}
+
+	if (!ret && !mum_resctrlfs)
+		return 0;
+
+	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
+	printf("%sok mounting resctrl to \"%s\"\n", ret ? "not " : "",
+	       RESCTRL_PATH);
+	if (ret)
+		perror("# mount");
+
+	tests_run++;
+
+	return ret;
+}
+
+int umount_resctrlfs(void)
+{
+	if (umount(RESCTRL_PATH)) {
+		perror("# Unable to umount resctrl");
+
+		return errno;
+	}
+
+	return 0;
+}
+
+/*
+ * get_resource_id - Get socket number/l3 id for a specified CPU
+ * @cpu_no:	CPU number
+ * @resource_id: Socket number or l3_id
+ *
+ * Return: >= 0 on success, < 0 on failure.
+ */
+int get_resource_id(int cpu_no, int *resource_id)
+{
+	char phys_pkg_path[1024];
+	FILE *fp;
+
+	sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
+		PHYS_ID_PATH, cpu_no);
+	fp = fopen(phys_pkg_path, "r");
+	if (!fp) {
+		perror("Failed to open physical_package_id");
+
+		return -1;
+	}
+	if (fscanf(fp, "%d", resource_id) <= 0) {
+		perror("Could not get socket number or l3 id");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
+ * @bm_pid:	PID that should be binded
+ * @cpu_no:	CPU number at which the PID would be binded
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int taskset_benchmark(pid_t bm_pid, int cpu_no)
+{
+	cpu_set_t my_set;
+
+	CPU_ZERO(&my_set);
+	CPU_SET(cpu_no, &my_set);
+
+	if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
+		perror("Unable to taskset benchmark");
+
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
+ *		   in specified signal. Direct benchmark stdio to /dev/null.
+ * @signum:	signal number
+ * @info:	signal info
+ * @ucontext:	user context in signal handling
+ *
+ * Return: void
+ */
+void run_benchmark(int signum, siginfo_t *info, void *ucontext)
+{
+	unsigned long span;
+	int operation, ret;
+	char **benchmark_cmd;
+	FILE *fp;
+
+	benchmark_cmd = info->si_ptr;
+
+	/*
+	 * Direct stdio of child to /dev/null, so that only parent writes to
+	 * stdio (console)
+	 */
+	fp = freopen("/dev/null", "w", stdout);
+	if (!fp)
+		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
+
+	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
+		/* Execute default fill_buf benchmark */
+		span = strtoul(benchmark_cmd[1], NULL, 10);
+		operation = atoi(benchmark_cmd[4]);
+		if (run_fill_buf(span, 1, 1, operation, NULL))
+			fprintf(stderr, "Error in running fill buffer\n");
+	} else {
+		/* Execute specified benchmark */
+		ret = execvp(benchmark_cmd[0], benchmark_cmd);
+		if (ret)
+			perror("wrong\n");
+	}
+
+	fclose(stdout);
+	PARENT_EXIT("Unable to run specified benchmark");
+}
+
+/*
+ * create_grp - Create a group only if one doesn't exist
+ * @grp_name:	Name of the group
+ * @grp:	Full path and name of the group
+ * @parent_grp:	Full path and name of the parent group
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
+{
+	int found_grp = 0;
+	struct dirent *ep;
+	DIR *dp;
+
+	/* Check if requested grp exists or not */
+	dp = opendir(parent_grp);
+	if (dp) {
+		while ((ep = readdir(dp)) != NULL) {
+			if (strcmp(ep->d_name, grp_name) == 0)
+				found_grp = 1;
+		}
+		closedir(dp);
+	} else {
+		perror("Unable to open resctrl for group");
+
+		return -1;
+	}
+
+	/* Requested grp doesn't exist, hence create it */
+	if (found_grp == 0) {
+		if (mkdir(grp, 0) == -1) {
+			perror("Unable to create group");
+
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int write_pid_to_tasks(char *tasks, pid_t pid)
+{
+	FILE *fp;
+
+	fp = fopen(tasks, "w");
+	if (!fp) {
+		perror("Failed to open tasks file");
+
+		return -1;
+	}
+	if (fprintf(fp, "%d\n", pid) < 0) {
+		perror("Failed to wr pid to tasks file");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * write_bm_pid_to_resctrl - Write a PID (i.e. benchmark) to resctrl FS
+ * @bm_pid:		PID that should be written
+ * @ctrlgrp:		Name of the control monitor group (con_mon grp)
+ * @mongrp:		Name of the monitor group (mon grp)
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ *
+ * If a con_mon grp is requested, create it and write pid to it, otherwise
+ * write pid to root con_mon grp.
+ * If a mon grp is requested, create it and write pid to it, otherwise
+ * pid is not written, this means that pid is in con_mon grp and hence
+ * should consult con_mon grp's mon_data directory for results.
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
+			    char *resctrl_val)
+{
+	char controlgroup[128], monitorgroup[512], monitorgroup_p[256];
+	char tasks[1024];
+	int ret = 0;
+
+	if (strlen(ctrlgrp))
+		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
+	else
+		sprintf(controlgroup, "%s", RESCTRL_PATH);
+
+	/* Create control and monitoring group and write pid into it */
+	ret = create_grp(ctrlgrp, controlgroup, RESCTRL_PATH);
+	if (ret)
+		goto out;
+	sprintf(tasks, "%s/tasks", controlgroup);
+	ret = write_pid_to_tasks(tasks, bm_pid);
+	if (ret)
+		goto out;
+
+	/* Create mon grp and write pid into it for "mbm" test */
+	if ((strcmp(resctrl_val, "mbm") == 0)) {
+		if (mongrp) {
+			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
+			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
+			ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
+			if (ret)
+				goto out;
+
+			sprintf(tasks, "%s/mon_groups/%s/tasks",
+				controlgroup, mongrp);
+			ret = write_pid_to_tasks(tasks, bm_pid);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	printf("%sok writing benchmark parameters to resctrl FS\n",
+	       ret ? "not " : "");
+	if (ret)
+		perror("# writing to resctrlfs");
+
+	tests_run++;
+
+	return ret;
+}
+
+/*
+ * write_schemata - Update schemata of a con_mon grp
+ * @ctrlgrp:		Name of the con_mon grp
+ * @schemata:		Schemata that should be updated to
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ *
+ * Update schemata of a con_mon grp *only* if requested resctrl feature is
+ * allocation type
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
+{
+	char controlgroup[1024], schema[1024], reason[64];
+	int resource_id, ret = 0;
+	FILE *fp;
+
+	if (strcmp(resctrl_val, "mba") != 0)
+		return -ENOENT;
+
+	if (!schemata) {
+		printf("# Skipping empty schemata update\n");
+
+		return -1;
+	}
+
+	if (get_resource_id(cpu_no, &resource_id) < 0) {
+		sprintf(reason, "Failed to get resource id");
+		ret = -1;
+
+		goto out;
+	}
+
+	if (strlen(ctrlgrp) != 0)
+		sprintf(controlgroup, "%s/%s/schemata", RESCTRL_PATH, ctrlgrp);
+	else
+		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
+
+	sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
+
+	fp = fopen(controlgroup, "w");
+	if (!fp) {
+		sprintf(reason, "Failed to open control group");
+		ret = -1;
+
+		goto out;
+	}
+
+	if (fprintf(fp, "%s\n", schema) < 0) {
+		sprintf(reason, "Failed to write schemata in control group");
+		fclose(fp);
+		ret = -1;
+
+		goto out;
+	}
+	fclose(fp);
+
+out:
+	printf("%sok Write schema \"%s\" to resctrl FS%s%s\n",
+	       ret ? "not " : "", schema, ret ? " # " : "",
+	       ret ? reason : "");
+	tests_run++;
+
+	return ret;
+}
+
+char *fgrep(FILE *inf, const char *str)
+{
+	char line[256];
+	int slen = strlen(str);
+
+	while (!feof(inf)) {
+		if (!fgets(line, 256, inf))
+			break;
+		if (strncmp(line, str, slen))
+			continue;
+
+		return strdup(line);
+	}
+
+	return NULL;
+}
+
+/*
+ * validate_resctrl_feature_request - Check if requested feature is valid.
+ * @resctrl_val:	Requested feature
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+bool validate_resctrl_feature_request(char *resctrl_val)
+{
+	FILE *inf = fopen("/proc/cpuinfo", "r");
+	bool found = false;
+	char *res;
+
+	if (!inf)
+		return false;
+
+	res = fgrep(inf, "flags");
+
+	if (res) {
+		char *s = strchr(res, ':');
+
+		found = s && !strstr(s, resctrl_val);
+		free(res);
+	}
+	fclose(inf);
+
+	return found;
+}
+
+int validate_bw_report_request(char *bw_report)
+{
+	if (strcmp(bw_report, "reads") == 0)
+		return 0;
+	if (strcmp(bw_report, "writes") == 0)
+		return 0;
+	if (strcmp(bw_report, "nt-writes") == 0) {
+		strcpy(bw_report, "writes");
+		return 0;
+	}
+	if (strcmp(bw_report, "total") == 0)
+		return 0;
+
+	fprintf(stderr, "Requested iMC B/W report type unavailable\n");
+
+	return -1;
+}
+
+int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
+		    int group_fd, unsigned long flags)
+{
+	int ret;
+
+	ret = syscall(__NR_perf_event_open, hw_event, pid, cpu,
+		      group_fd, flags);
+	return ret;
+}
-- 
2.19.1

