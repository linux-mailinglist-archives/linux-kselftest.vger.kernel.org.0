Return-Path: <linux-kselftest+bounces-20094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC09A32BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CA4B22C9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE4187322;
	Fri, 18 Oct 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtWQTLnP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095D181D00;
	Fri, 18 Oct 2024 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218165; cv=none; b=FhlHvZOadxoM4QlQtWdkezE71MB32h5WVqJOTkQHJYF8lL8OesH2+0eOvPpZ2Xny27qb/x8vDX2K+EqP/X3Pjb1V5RohY2JQbLaF547M9dGAyKFReqMhSnjR/b4lLOG7uk33AMYR32U8AvWur6o3pjhtm4CsL2/k93FfUDCi3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218165; c=relaxed/simple;
	bh=S7bbGjsCsnLvdIa2S2fp7sRvKgZS8ax6fpv4SxjDnig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWpDZfb0aXGoJAurLVs6h1qE03v0omEtnGC3OT0B0lZtIpyiQDXeNjvf84/JUg45vQv9FOyuCFbXOyezgnZI/fvETvOnYpP7zNZoslGPXvNseRfH+yWaQZWnGrNLRh/5qHE2ghhkL0/Xg1YBtvPFqlluRxxCIdi/HBgFJ0CcKow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtWQTLnP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218163; x=1760754163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S7bbGjsCsnLvdIa2S2fp7sRvKgZS8ax6fpv4SxjDnig=;
  b=RtWQTLnPdrjzynI10G38qwNv0GhcB46+Y1/eaVcKINY6THrkIN8nDcGw
   dJcJ/CR4REAast4yeupNS8uADjVXpeO1d0B/3g4v8yEzoaLj6gu3S2Yia
   zovJZhYHpeEg6RZpG0KzGc2ld8tDZX63D3rfdBVOGy3tV5Zjp5c265f6S
   bjXXYKOp2yUAZwK1lzUcwnmWzY9cXO1A+bqMvAWp42R43/CuwcXFixs0y
   z3tex9Vk/PSVOGtWIySwz+sSt8hMTKANa1Sk+pB0GIeR0w5QEO7YAO4Fj
   3ocL9TgAO9A/wUht9mLf/QxdTwAZkwXWjfnlr63Ok6Xz8BqJU3ST0p/37
   g==;
X-CSE-ConnectionGUID: zTityY8DQDOPq3e0odhUtg==
X-CSE-MsgGUID: FclgbYNsR1mcf76zvzS6Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149713"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149713"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:38 -0700
X-CSE-ConnectionGUID: y7BlBC1ZRHe3ZsHJQWuJFA==
X-CSE-MsgGUID: lst87ACoTc6GzX2E2o1IFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697725"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 09/15] selftests/resctrl: Remove unused measurement code
Date: Thu, 17 Oct 2024 19:33:24 -0700
Message-ID: <2f3c4a34fa0dcf8902823f292c921c36062517b0.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MBM and MBA resctrl selftests run a benchmark during which
it takes measurements of read memory bandwidth via perf.
Code exists to support measurements of write memory bandwidth
but there exists no path with which this code can execute.

While code exists for write memory bandwidth measurement
there has not yet been a use case for it. Remove this unused code.
Rename relevant functions to include "read" so that it is clear
that it relates only to memory bandwidth reads, while renaming
the functions also add consistency by changing the "membw"
instances to more prevalent "mem_bw".

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V2:
- Add Ilpo's Reviewed-by tag.

Changes since V1:
- New patch.
---
 tools/testing/selftests/resctrl/mba_test.c    |   4 +-
 tools/testing/selftests/resctrl/mbm_test.c    |   4 +-
 tools/testing/selftests/resctrl/resctrl.h     |   8 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 234 ++++++------------
 tools/testing/selftests/resctrl/resctrlfs.c   |  17 --
 5 files changed, 85 insertions(+), 182 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index da40a8ed4413..be0ead73e55d 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -21,7 +21,7 @@ static int mba_init(const struct resctrl_val_param *param, int domain_id)
 {
 	int ret;
 
-	ret = initialize_mem_bw_imc();
+	ret = initialize_read_mem_bw_imc();
 	if (ret)
 		return ret;
 
@@ -68,7 +68,7 @@ static int mba_setup(const struct resctrl_test *test,
 static int mba_measure(const struct user_params *uparams,
 		       struct resctrl_val_param *param, pid_t bm_pid)
 {
-	return measure_mem_bw(uparams, param, bm_pid, "reads");
+	return measure_read_mem_bw(uparams, param, bm_pid);
 }
 
 static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 36ae29a03784..f516a2da1163 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -91,7 +91,7 @@ static int mbm_init(const struct resctrl_val_param *param, int domain_id)
 {
 	int ret;
 
-	ret = initialize_mem_bw_imc();
+	ret = initialize_read_mem_bw_imc();
 	if (ret)
 		return ret;
 
@@ -122,7 +122,7 @@ static int mbm_setup(const struct resctrl_test *test,
 static int mbm_measure(const struct user_params *uparams,
 		       struct resctrl_val_param *param, pid_t bm_pid)
 {
-	return measure_mem_bw(uparams, param, bm_pid, "reads");
+	return measure_read_mem_bw(uparams, param, bm_pid);
 }
 
 static void mbm_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ba1ce1b35699..82801245e4c1 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -126,7 +126,6 @@ int filter_dmesg(void);
 int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
-const char *get_bw_report_type(const char *bw_report);
 bool resctrl_resource_exists(const char *resource);
 bool resctrl_mon_feature_exists(const char *resource, const char *feature);
 bool resource_info_file_exists(const char *resource, const char *file);
@@ -143,10 +142,9 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush);
-int initialize_mem_bw_imc(void);
-int measure_mem_bw(const struct user_params *uparams,
-		   struct resctrl_val_param *param, pid_t bm_pid,
-		   const char *bw_report);
+int initialize_read_mem_bw_imc(void);
+int measure_read_mem_bw(const struct user_params *uparams,
+			struct resctrl_val_param *param, pid_t bm_pid);
 void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
 			       int domain_id);
 int resctrl_val(const struct resctrl_test *test,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 113ca18d67c1..c4ebf70a46ef 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -12,13 +12,10 @@
 
 #define UNCORE_IMC		"uncore_imc"
 #define READ_FILE_NAME		"events/cas_count_read"
-#define WRITE_FILE_NAME		"events/cas_count_write"
 #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
 #define SCALE			0.00006103515625
 #define MAX_IMCS		20
 #define MAX_TOKENS		5
-#define READ			0
-#define WRITE			1
 
 #define CON_MBM_LOCAL_BYTES_PATH		\
 	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
@@ -41,44 +38,43 @@ struct imc_counter_config {
 
 static char mbm_total_path[1024];
 static int imcs;
-static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
+static struct imc_counter_config imc_counters_config[MAX_IMCS];
 static const struct resctrl_test *current_test;
 
-static void membw_initialize_perf_event_attr(int i, int j)
+static void read_mem_bw_initialize_perf_event_attr(int i)
 {
-	memset(&imc_counters_config[i][j].pe, 0,
+	memset(&imc_counters_config[i].pe, 0,
 	       sizeof(struct perf_event_attr));
-	imc_counters_config[i][j].pe.type = imc_counters_config[i][j].type;
-	imc_counters_config[i][j].pe.size = sizeof(struct perf_event_attr);
-	imc_counters_config[i][j].pe.disabled = 1;
-	imc_counters_config[i][j].pe.inherit = 1;
-	imc_counters_config[i][j].pe.exclude_guest = 0;
-	imc_counters_config[i][j].pe.config =
-		imc_counters_config[i][j].umask << 8 |
-		imc_counters_config[i][j].event;
-	imc_counters_config[i][j].pe.sample_type = PERF_SAMPLE_IDENTIFIER;
-	imc_counters_config[i][j].pe.read_format =
+	imc_counters_config[i].pe.type = imc_counters_config[i].type;
+	imc_counters_config[i].pe.size = sizeof(struct perf_event_attr);
+	imc_counters_config[i].pe.disabled = 1;
+	imc_counters_config[i].pe.inherit = 1;
+	imc_counters_config[i].pe.exclude_guest = 0;
+	imc_counters_config[i].pe.config =
+		imc_counters_config[i].umask << 8 |
+		imc_counters_config[i].event;
+	imc_counters_config[i].pe.sample_type = PERF_SAMPLE_IDENTIFIER;
+	imc_counters_config[i].pe.read_format =
 		PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
 }
 
-static void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
+static void read_mem_bw_ioctl_perf_event_ioc_reset_enable(int i)
 {
-	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
-	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
+	ioctl(imc_counters_config[i].fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(imc_counters_config[i].fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static void membw_ioctl_perf_event_ioc_disable(int i, int j)
+static void read_mem_bw_ioctl_perf_event_ioc_disable(int i)
 {
-	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
+	ioctl(imc_counters_config[i].fd, PERF_EVENT_IOC_DISABLE, 0);
 }
 
 /*
- * get_event_and_umask:	Parse config into event and umask
+ * get_read_event_and_umask:	Parse config into event and umask
  * @cas_count_cfg:	Config
  * @count:		iMC number
- * @op:			Operation (read/write)
  */
-static void get_event_and_umask(char *cas_count_cfg, int count, bool op)
+static void get_read_event_and_umask(char *cas_count_cfg, int count)
 {
 	char *token[MAX_TOKENS];
 	int i = 0;
@@ -91,34 +87,22 @@ static void get_event_and_umask(char *cas_count_cfg, int count, bool op)
 	for (i = 0; i < MAX_TOKENS - 1; i++) {
 		if (!token[i])
 			break;
-		if (strcmp(token[i], "event") == 0) {
-			if (op == READ)
-				imc_counters_config[count][READ].event =
-				strtol(token[i + 1], NULL, 16);
-			else
-				imc_counters_config[count][WRITE].event =
-				strtol(token[i + 1], NULL, 16);
-		}
-		if (strcmp(token[i], "umask") == 0) {
-			if (op == READ)
-				imc_counters_config[count][READ].umask =
-				strtol(token[i + 1], NULL, 16);
-			else
-				imc_counters_config[count][WRITE].umask =
-				strtol(token[i + 1], NULL, 16);
-		}
+		if (strcmp(token[i], "event") == 0)
+			imc_counters_config[count].event = strtol(token[i + 1], NULL, 16);
+		if (strcmp(token[i], "umask") == 0)
+			imc_counters_config[count].umask = strtol(token[i + 1], NULL, 16);
 	}
 }
 
-static int open_perf_event(int i, int cpu_no, int j)
+static int open_perf_read_event(int i, int cpu_no)
 {
-	imc_counters_config[i][j].fd =
-		perf_event_open(&imc_counters_config[i][j].pe, -1, cpu_no, -1,
+	imc_counters_config[i].fd =
+		perf_event_open(&imc_counters_config[i].pe, -1, cpu_no, -1,
 				PERF_FLAG_FD_CLOEXEC);
 
-	if (imc_counters_config[i][j].fd == -1) {
+	if (imc_counters_config[i].fd == -1) {
 		fprintf(stderr, "Error opening leader %llx\n",
-			imc_counters_config[i][j].pe.config);
+			imc_counters_config[i].pe.config);
 
 		return -1;
 	}
@@ -126,7 +110,7 @@ static int open_perf_event(int i, int cpu_no, int j)
 	return 0;
 }
 
-/* Get type and config (read and write) of an iMC counter */
+/* Get type and config of an iMC counter's read event. */
 static int read_from_imc_dir(char *imc_dir, int count)
 {
 	char cas_count_cfg[1024], imc_counter_cfg[1024], imc_counter_type[1024];
@@ -140,7 +124,7 @@ static int read_from_imc_dir(char *imc_dir, int count)
 
 		return -1;
 	}
-	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
+	if (fscanf(fp, "%u", &imc_counters_config[count].type) <= 0) {
 		ksft_perror("Could not get iMC type");
 		fclose(fp);
 
@@ -148,9 +132,6 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	}
 	fclose(fp);
 
-	imc_counters_config[count][WRITE].type =
-				imc_counters_config[count][READ].type;
-
 	/* Get read config */
 	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
 	fp = fopen(imc_counter_cfg, "r");
@@ -167,34 +148,19 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	}
 	fclose(fp);
 
-	get_event_and_umask(cas_count_cfg, count, READ);
-
-	/* Get write config */
-	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
-	fp = fopen(imc_counter_cfg, "r");
-	if (!fp) {
-		ksft_perror("Failed to open iMC config file");
-
-		return -1;
-	}
-	if  (fscanf(fp, "%1023s", cas_count_cfg) <= 0) {
-		ksft_perror("Could not get iMC cas count write");
-		fclose(fp);
-
-		return -1;
-	}
-	fclose(fp);
-
-	get_event_and_umask(cas_count_cfg, count, WRITE);
+	get_read_event_and_umask(cas_count_cfg, count);
 
 	return 0;
 }
 
 /*
  * A system can have 'n' number of iMC (Integrated Memory Controller)
- * counters, get that 'n'. For each iMC counter get it's type and config.
- * Also, each counter has two configs, one for read and the other for write.
- * A config again has two parts, event and umask.
+ * counters, get that 'n'. Discover the properties of the available
+ * counters in support of needed performance measurement via perf.
+ * For each iMC counter get it's type and config. Also obtain each
+ * counter's event and umask for the memory read events that will be
+ * measured.
+ *
  * Enumerate all these details into an array of structures.
  *
  * Return: >= 0 on success. < 0 on failure.
@@ -255,55 +221,46 @@ static int num_of_imcs(void)
 	return count;
 }
 
-int initialize_mem_bw_imc(void)
+int initialize_read_mem_bw_imc(void)
 {
-	int imc, j;
+	int imc;
 
 	imcs = num_of_imcs();
 	if (imcs <= 0)
 		return imcs;
 
 	/* Initialize perf_event_attr structures for all iMC's */
-	for (imc = 0; imc < imcs; imc++) {
-		for (j = 0; j < 2; j++)
-			membw_initialize_perf_event_attr(imc, j);
-	}
+	for (imc = 0; imc < imcs; imc++)
+		read_mem_bw_initialize_perf_event_attr(imc);
 
 	return 0;
 }
 
-static void perf_close_imc_mem_bw(void)
+static void perf_close_imc_read_mem_bw(void)
 {
 	int mc;
 
 	for (mc = 0; mc < imcs; mc++) {
-		if (imc_counters_config[mc][READ].fd != -1)
-			close(imc_counters_config[mc][READ].fd);
-		if (imc_counters_config[mc][WRITE].fd != -1)
-			close(imc_counters_config[mc][WRITE].fd);
+		if (imc_counters_config[mc].fd != -1)
+			close(imc_counters_config[mc].fd);
 	}
 }
 
 /*
- * perf_open_imc_mem_bw - Open perf fds for IMCs
+ * perf_open_imc_read_mem_bw - Open perf fds for IMCs
  * @cpu_no: CPU number that the benchmark PID is bound to
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int perf_open_imc_mem_bw(int cpu_no)
+static int perf_open_imc_read_mem_bw(int cpu_no)
 {
 	int imc, ret;
 
-	for (imc = 0; imc < imcs; imc++) {
-		imc_counters_config[imc][READ].fd = -1;
-		imc_counters_config[imc][WRITE].fd = -1;
-	}
+	for (imc = 0; imc < imcs; imc++)
+		imc_counters_config[imc].fd = -1;
 
 	for (imc = 0; imc < imcs; imc++) {
-		ret = open_perf_event(imc, cpu_no, READ);
-		if (ret)
-			goto close_fds;
-		ret = open_perf_event(imc, cpu_no, WRITE);
+		ret = open_perf_read_event(imc, cpu_no);
 		if (ret)
 			goto close_fds;
 	}
@@ -311,60 +268,52 @@ static int perf_open_imc_mem_bw(int cpu_no)
 	return 0;
 
 close_fds:
-	perf_close_imc_mem_bw();
+	perf_close_imc_read_mem_bw();
 	return -1;
 }
 
 /*
- * do_mem_bw_test - Perform memory bandwidth test
+ * do_imc_read_mem_bw_test - Perform memory bandwidth test
  *
  * Runs memory bandwidth test over one second period. Also, handles starting
  * and stopping of the IMC perf counters around the test.
  */
-static void do_imc_mem_bw_test(void)
+static void do_imc_read_mem_bw_test(void)
 {
 	int imc;
 
-	for (imc = 0; imc < imcs; imc++) {
-		membw_ioctl_perf_event_ioc_reset_enable(imc, READ);
-		membw_ioctl_perf_event_ioc_reset_enable(imc, WRITE);
-	}
+	for (imc = 0; imc < imcs; imc++)
+		read_mem_bw_ioctl_perf_event_ioc_reset_enable(imc);
 
 	sleep(1);
 
-	/* Stop counters after a second to get results (both read and write) */
-	for (imc = 0; imc < imcs; imc++) {
-		membw_ioctl_perf_event_ioc_disable(imc, READ);
-		membw_ioctl_perf_event_ioc_disable(imc, WRITE);
-	}
+	/* Stop counters after a second to get results. */
+	for (imc = 0; imc < imcs; imc++)
+		read_mem_bw_ioctl_perf_event_ioc_disable(imc);
 }
 
 /*
- * get_mem_bw_imc - Memory bandwidth as reported by iMC counters
- * @bw_report: Bandwidth report type (reads, writes)
+ * get_read_mem_bw_imc - Memory read bandwidth as reported by iMC counters
  *
- * Memory bandwidth utilized by a process on a socket can be calculated
- * using iMC counters. Perf events are used to read these counters.
+ * Memory read bandwidth utilized by a process on a socket can be calculated
+ * using iMC counters' read events. Perf events are used to read these
+ * counters.
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
+static int get_read_mem_bw_imc(float *bw_imc)
 {
-	float reads, writes, of_mul_read, of_mul_write;
+	float reads = 0, of_mul_read = 1;
 	int imc;
 
-	/* Start all iMC counters to log values (both read and write) */
-	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
-
 	/*
-	 * Get results which are stored in struct type imc_counter_config
+	 * Log read event values from all iMC counters into
+	 * struct imc_counter_config.
 	 * Take overflow into consideration before calculating total bandwidth.
 	 */
 	for (imc = 0; imc < imcs; imc++) {
 		struct imc_counter_config *r =
-			&imc_counters_config[imc][READ];
-		struct imc_counter_config *w =
-			&imc_counters_config[imc][WRITE];
+			&imc_counters_config[imc];
 
 		if (read(r->fd, &r->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
@@ -372,12 +321,6 @@ static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
 			return -1;
 		}
 
-		if (read(w->fd, &w->return_value,
-			 sizeof(struct membw_read_format)) == -1) {
-			ksft_perror("Couldn't get write bandwidth through iMC");
-			return -1;
-		}
-
 		__u64 r_time_enabled = r->return_value.time_enabled;
 		__u64 r_time_running = r->return_value.time_running;
 
@@ -385,27 +328,10 @@ static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
 			of_mul_read = (float)r_time_enabled /
 					(float)r_time_running;
 
-		__u64 w_time_enabled = w->return_value.time_enabled;
-		__u64 w_time_running = w->return_value.time_running;
-
-		if (w_time_enabled != w_time_running)
-			of_mul_write = (float)w_time_enabled /
-					(float)w_time_running;
 		reads += r->return_value.value * of_mul_read * SCALE;
-		writes += w->return_value.value * of_mul_write * SCALE;
 	}
 
-	if (strcmp(bw_report, "reads") == 0) {
-		*bw_imc = reads;
-		return 0;
-	}
-
-	if (strcmp(bw_report, "writes") == 0) {
-		*bw_imc = writes;
-		return 0;
-	}
-
-	*bw_imc = reads + writes;
+	*bw_imc = reads;
 	return 0;
 }
 
@@ -551,35 +477,31 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
 }
 
 /*
- * measure_mem_bw - Measures memory bandwidth numbers while benchmark runs
+ * measure_read_mem_bw - Measures read memory bandwidth numbers while benchmark runs
  * @uparams:		User supplied parameters
  * @param:		Parameters passed to resctrl_val()
  * @bm_pid:		PID that runs the benchmark
- * @bw_report:		Bandwidth report type (reads, writes)
  *
  * Measure memory bandwidth from resctrl and from another source which is
  * perf imc value or could be something else if perf imc event is not
  * available. Compare the two values to validate resctrl value. It takes
  * 1 sec to measure the data.
+ * resctrl does not distinguish between read and write operations so
+ * its data includes all memory operations.
  */
-int measure_mem_bw(const struct user_params *uparams,
-		   struct resctrl_val_param *param, pid_t bm_pid,
-		   const char *bw_report)
+int measure_read_mem_bw(const struct user_params *uparams,
+			struct resctrl_val_param *param, pid_t bm_pid)
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
 	float bw_imc;
 	int ret;
 
-	bw_report = get_bw_report_type(bw_report);
-	if (!bw_report)
-		return -1;
-
 	mem_bw_fp = open_mem_bw_resctrl(mbm_total_path);
 	if (!mem_bw_fp)
 		return -1;
 
-	ret = perf_open_imc_mem_bw(uparams->cpu);
+	ret = perf_open_imc_read_mem_bw(uparams->cpu);
 	if (ret < 0)
 		goto close_fp;
 
@@ -589,17 +511,17 @@ int measure_mem_bw(const struct user_params *uparams,
 
 	rewind(mem_bw_fp);
 
-	do_imc_mem_bw_test();
+	do_imc_read_mem_bw_test();
 
 	ret = get_mem_bw_resctrl(mem_bw_fp, &bw_resc_end);
 	if (ret < 0)
 		goto close_imc;
 
-	ret = get_mem_bw_imc(bw_report, &bw_imc);
+	ret = get_read_mem_bw_imc(&bw_imc);
 	if (ret < 0)
 		goto close_imc;
 
-	perf_close_imc_mem_bw();
+	perf_close_imc_read_mem_bw();
 	fclose(mem_bw_fp);
 
 	bw_resc = (bw_resc_end - bw_resc_start) / MB;
@@ -607,7 +529,7 @@ int measure_mem_bw(const struct user_params *uparams,
 	return print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
 
 close_imc:
-	perf_close_imc_mem_bw();
+	perf_close_imc_read_mem_bw();
 close_fp:
 	fclose(mem_bw_fp);
 	return ret;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index a53cd1cb6e0c..d38d6dd90be4 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -831,23 +831,6 @@ int filter_dmesg(void)
 	return 0;
 }
 
-const char *get_bw_report_type(const char *bw_report)
-{
-	if (strcmp(bw_report, "reads") == 0)
-		return bw_report;
-	if (strcmp(bw_report, "writes") == 0)
-		return bw_report;
-	if (strcmp(bw_report, "nt-writes") == 0) {
-		return "writes";
-	}
-	if (strcmp(bw_report, "total") == 0)
-		return bw_report;
-
-	fprintf(stderr, "Requested iMC bandwidth report type unavailable\n");
-
-	return NULL;
-}
-
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags)
 {
-- 
2.46.2


