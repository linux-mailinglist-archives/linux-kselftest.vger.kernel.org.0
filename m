Return-Path: <linux-kselftest+bounces-43337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D704BE4002
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523E6587E9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818AE34AAFB;
	Thu, 16 Oct 2025 14:47:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF2346A01
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626033; cv=none; b=SLPucB+DqPfg0/tkspP1PUHC6bk17bDCF2ZDPnD28xZoXhDqa90PwAjv1TLFLL1lmOent7PFTFvLjUI83hiuWIWqR822Bf/WXdFwj3okh4MBUU4KlZbry1PHPT2P5bPE1wR6I+9AKHFtO2s/qa18zR1KK5JNOrhB93HANTOKYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626033; c=relaxed/simple;
	bh=YGEk3Vxt0xAsLuoBTBKmO6oTHhcJNPGtkDPzHjbgv8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSxPbkQ8pYNMmGZEfSKC7MVeb/cMUO0CHFY48s0kRrrH4WWpa6ILmwOrL3qu48Zrq+KI9kbxSVvvr80rUQheZME/7/yCO9lhNFJvOLqHsdBwE4KpnCjvglNQHfNzhHSGimkFydDaLt2Q3eRznF6V7j/gOWahfk2atTV9c9gSAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43f86ddb3f4so286428b6e.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 07:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626029; x=1761230829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PBE8tsArPgVuwR9rYRWZy1yTOJeVVE4k+vcOQXANQY=;
        b=pwZ/NtIwD+MH+b4GHNNmF2GBNX1EbvshHNS42mk4WeHf+UJcx+/Lh9JdcMdPQfbVio
         eLIN5yHu+y/ZkUFUYDiuhJa0+hQv85j4HMv/y7GqxvV38xbR76E978d7Q99jiAAdQe+q
         Jc9aYmLz7m3QZI00zCq+P6g2brMjpNyVujUviq1iPyEWm/At/DNTrYKWlnLwBcbWAGBy
         ajH0GHbFqwRA6zUwWpi1LoH1OShqPaD6kbN478T1VjSbpv1OInveSr540t1uQ5duc4I+
         HrV5jQSNxjadbKxRlE1ETGldWZHSaDD0L2SqZQ0qj+AVsgyLv/mYXpEOI9gPVPMitz2R
         6dhA==
X-Gm-Message-State: AOJu0YxWrVHY9Lg2QMmAU9y4y3PeNwCeZIOx5HR9aUoVi+0ZOPxRxoKJ
	xj8ww5MgZKTH5YrOc9mJw6pjoCQHaAZMR+W3Ycw/edGFywlhFI/i66Sa
X-Gm-Gg: ASbGncsux7xiR+sdIme87vHDNaBvxDuJu1owoVNn4aSLPe8MDK+2QpL4gy8McRNmU+e
	9sHq/9r5QvjnOZM+7Vr/kGlJgXmx17SHpf+hTuG74HXmoqqt2Pxk4pGNrqYaHxGHCB3Dvw4umYV
	o7BN1CLZUdp8/Is1inIS+GdnzJkRd9kRFnQ17CDozwxAwUPd0XWW5FtoDX8pvIrBT9xooOufzOH
	Y2ffLX568H5OZC9Y4C7wvHrYgLRSS4w7tJbh/dL816iCl8Jt0w4HjI1mtwbU/hFT3xDmuSbhMHa
	NoFpDuD1BXlLXrzcj+d2HGzANEgI9TKNMp6X4mQ2cIZH3bI6gd9Fl3Ovgk9+aMuOfgKeoRrPCuv
	W+wYn0Kyk/w2avzfR5U3vLi6PTweY88uC/VW3vj2FXezF3ExPP6jHW2NFYHjvhWvSnFSBaEp23t
	Q6gi6ourd+22LmrwatLdS8A27nX4nVQgiShnTTFiSohpdRSdMnNO8n9mvy
X-Google-Smtp-Source: AGHT+IG5UTBXBR0mcF3hbn7sH8I5dAxaCZxah8MRjFva13+8nwHEh6GWtPkvzNt+eztgSnV1vDranQ==
X-Received: by 2002:a05:6808:8953:b0:43f:4f34:dd52 with SMTP id 5614622812f47-443a2dd8953mr141131b6e.3.1760626029452;
        Thu, 16 Oct 2025 07:47:09 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:08 -0700 (PDT)
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
Subject: [PATCH 8/8] resctrl/pmu: Implement .read via direct RMID read; add LLC selftest
Date: Thu, 16 Oct 2025 09:46:56 -0500
Message-ID: <20251016144656.74928-9-yonch@yonch.com>
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

Implement reads of monitored values in resctrl_event_update().

If the rdtgroup was deleted, read zero. On RMID read errors, emit a
WARN_ONCE and read zero.

Introduce mon_event_read_this_cpu() to call mon_event_count() directly,
with no IPI, as perf infra would ensure .read runs on the bound CPU.

Augment the existing LLC occupancy selftest to also test the PMU.

Document PMU usage in resctrl.rst.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 Documentation/filesystems/resctrl.rst       | 64 ++++++++++++++
 fs/resctrl/ctrlmondata.c                    | 17 ++++
 fs/resctrl/internal.h                       |  1 +
 fs/resctrl/pmu.c                            | 31 ++++++-
 tools/testing/selftests/resctrl/cache.c     | 94 ++++++++++++++++++++-
 tools/testing/selftests/resctrl/cmt_test.c  | 17 +++-
 tools/testing/selftests/resctrl/pmu_test.c  | 28 +-----
 tools/testing/selftests/resctrl/pmu_utils.c | 32 +++++++
 tools/testing/selftests/resctrl/resctrl.h   |  3 +
 9 files changed, 253 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/pmu_utils.c

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index b7f35b07876a..8f91ba7d622b 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -628,6 +628,70 @@ Resource monitoring rules
    "mon_data" group.
 
 
+Perf PMU access (resctrl PMU)
+=============================
+
+resctrl registers a perf PMU named "resctrl", which provides read-only access
+to the same monitoring values exposed via the "mon_data" files. The PMU
+enables access from eBPF and allows parallelizing reads as it does not lock
+the system-wide `rdtgroup_mutex`.
+
+Selection and usage
+-------------------
+- Event selection is performed by passing the file descriptor of a
+  resctrl monitoring file, for example
+  "mon_data/mon_L3_00/llc_occupancy", in the `perf_event_attr.config`
+  field when calling perf_event_open().
+- The perf event must be CPU-bound (pid = -1 and cpu >= 0).
+- The chosen CPU must be valid for the domain represented by the
+  monitoring file:
+
+  - For a domain-specific file such as "mon_L3_00/...", choose a CPU that
+    belongs to that domain.
+  - For files that provide a sum across domains that share the same L3
+    cache instance (for example on SNC systems), choose a CPU that
+    shares that L3 cache instance. See the "Cache IDs" section for the
+    concepts and mapping.
+- Exclude flags must be zero. perf_event_open() fails if any exclude
+  flags are set.
+
+Semantics
+---------
+- The values from the resctrl PMU match the values what would be
+  read from the corresponding "mon_data" file at the time of the read.
+- Sampling is not supported. The PMU provides counts that can be read
+  on demand; there are no periodic interrupts or per-context filtering
+  semantics.
+- It is safe to read a perf event whose underlying resctrl group has been
+  deleted. However, the returned values are unspecified: the current
+  implementation returns zeros, but this may change in the future.
+
+Discovering the PMU and example
+-------------------------------
+- The PMU type is exposed at
+  "/sys/bus/event_source/devices/resctrl/type" and must be placed in
+  `perf_event_attr.type`.
+- A minimal example of opening a resctrl PMU event by passing a
+  monitoring file descriptor in `config`::
+
+      int pmu_type = read_int("/sys/bus/event_source/devices/resctrl/type");
+      int mon_fd = open("/sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy", O_RDONLY);
+      struct perf_event_attr pe = { 0 };
+
+      pe.type = pmu_type;
+      pe.size = sizeof(pe);
+      pe.config = mon_fd;  /* select event via resctrl file descriptor */
+      pe.disabled = 1;
+
+      int cpu = /* a CPU in the L3_00 domain (see Cache IDs) */;
+      int fd = perf_event_open(&pe, -1 /* pid */, cpu /* cpu */, -1, 0);
+
+      ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+      uint64_t val;
+      read(fd, &val, sizeof(val));
+      ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+
+
 Notes on cache occupancy monitoring and control
 ===============================================
 When moving a task from one group to another you should remember that
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index d1e4cf6f2128..02f8f256c680 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -594,6 +594,23 @@ void mon_event_read(struct rmid_read *rr, cpumask_t *cpumask)
 		resctrl_arch_mon_ctx_free(rr->r, rr->evtid, rr->arch_mon_ctx);
 }
 
+void mon_event_read_this_cpu(struct rmid_read *rr)
+{
+	/* Ensure we're not in a CPU hotplug race */
+	lockdep_assert_cpus_held();
+
+	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr->r, rr->evtid);
+	if (IS_ERR(rr->arch_mon_ctx)) {
+		rr->err = -EINVAL;
+		return;
+	}
+
+	/* Direct call on current CPU - no IPI needed */
+	mon_event_count(rr);
+
+	resctrl_arch_mon_ctx_free(rr->r, rr->evtid, rr->arch_mon_ctx);
+}
+
 int mon_event_setup_read(struct rmid_read *rr, cpumask_t **cpumask,
 			 struct mon_data *md, struct rdtgroup *rdtgrp)
 {
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 8cc3a3747c2f..c4adb6eaf101 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -383,6 +383,7 @@ void rmid_read_init(struct rmid_read *rr, struct rdt_resource *r,
 int mon_event_setup_read(struct rmid_read *rr, cpumask_t **cpumask,
 			 struct mon_data *md, struct rdtgroup *rdtgrp);
 void mon_event_read(struct rmid_read *rr, cpumask_t *cpumask);
+void mon_event_read_this_cpu(struct rmid_read *rr);
 
 int resctrl_mon_resource_init(void);
 
diff --git a/fs/resctrl/pmu.c b/fs/resctrl/pmu.c
index bdca0b3a5b0b..e6f5f13f29d2 100644
--- a/fs/resctrl/pmu.c
+++ b/fs/resctrl/pmu.c
@@ -132,8 +132,35 @@ static void resctrl_event_destroy(struct perf_event *event)
 
 static void resctrl_event_update(struct perf_event *event)
 {
-	/* Currently just a stub - would read actual cache occupancy here */
-	local64_set(&event->hw.prev_count, 0);
+	struct resctrl_pmu_event *resctrl_event = event->pmu_private;
+	struct rdtgroup *rdtgrp = resctrl_event->rdtgrp;
+	struct rmid_read rr;
+	u64 value = 0;
+
+	/* Check if rdtgroup has been deleted */
+	if (rdtgrp->flags & RDT_DELETED) {
+		local64_set(&event->count, 0);
+		return;
+	}
+
+	/* Setup rmid_read structure with current parameters */
+	rr = resctrl_event->rr;
+	rr.val = 0;
+	rr.err = 0;
+
+	/* Take cpus read lock only around the actual RMID read */
+	cpus_read_lock();
+	mon_event_read_this_cpu(&rr);
+	cpus_read_unlock();
+
+	/* Update counter value based on read result */
+	if (!rr.err)
+		value = rr.val;
+	else
+		WARN_ONCE(1, "resctrl PMU: RMID read error (err=%d) for closid=%u, rmid=%u, evtid=%d\n",
+			  rr.err, rdtgrp->closid, rdtgrp->mon.rmid, rr.evtid);
+
+	local64_set(&event->count, value);
 }
 
 static void resctrl_event_start(struct perf_event *event, int flags)
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 1ff1104e6575..826c11589d34 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stdint.h>
+#include <fcntl.h>
 #include "resctrl.h"
 
 char llc_occup_path[1024];
@@ -92,12 +93,62 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
 	return 0;
 }
 
+/*
+ * get_llc_occu_resctrl_pmu - Read LLC occupancy via resctrl PMU
+ *
+ * Uses the PMU to read LLC occupancy from the monitored resource given by the
+ * global variable llc_occup_path.
+ *
+ * Return: =0 on success. <0 on failure.
+ */
+static int get_llc_occu_resctrl_pmu(unsigned long *llc_occupancy_pmu)
+{
+	int pmu_type, mon_fd = -1, perf_fd = -1;
+	struct perf_event_attr pe = { 0 };
+	__u64 value = 0;
+
+	if (!llc_occup_path[0])
+		return -1;
+
+	pmu_type = resctrl_find_pmu_type("resctrl");
+	if (pmu_type < 0)
+		return -1;
+
+	mon_fd = open(llc_occup_path, O_RDONLY);
+	if (mon_fd < 0)
+		return -1;
+
+	memset(&pe, 0, sizeof(pe));
+	pe.type = pmu_type;
+	pe.config = mon_fd; /* Pass the monitoring fd */
+	pe.size = sizeof(pe);
+	pe.disabled = 0; /* Start enabled */
+
+	perf_fd = perf_event_open(&pe, -1, 0, -1, 0);
+	if (perf_fd < 0)
+		goto out_close_mon;
+
+	if (read(perf_fd, &value, sizeof(value)) != sizeof(value))
+		goto out_close_all;
+
+	*llc_occupancy_pmu = (unsigned long)value;
+
+	close(perf_fd);
+	close(mon_fd);
+	return 0;
+
+out_close_all:
+	close(perf_fd);
+out_close_mon:
+	close(mon_fd);
+	return -1;
+}
+
 /*
  * print_results_cache:	the cache results are stored in a file
  * @filename:		file that stores the results
  * @bm_pid:		child pid that runs benchmark
- * @llc_value:		perf miss value /
- *			llc occupancy value reported by resctrl FS
+ * @llc_value:		perf miss value
  *
  * Return:		0 on success, < 0 on error.
  */
@@ -121,6 +172,37 @@ static int print_results_cache(const char *filename, pid_t bm_pid, __u64 llc_val
 	return 0;
 }
 
+/*
+ * print_results_llc:	prints LLC measurements to a file
+ * @filename:		file that stores the results
+ * @bm_pid:		child pid that runs benchmark
+ * @fs_value:		llc occupancy value reported by resctrl FS
+ * @pmu_value:		llc occupancy value reported by resctrl PMU
+ *
+ * Return:		0 on success, < 0 on error.
+ */
+static int print_results_llc(const char *filename, pid_t bm_pid,
+			     unsigned long fs_value, unsigned long pmu_value)
+{
+	FILE *fp;
+
+	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
+		printf("Pid: %d \t llc_value: %lu\t pmu_value: %lu\n",
+		       (int)bm_pid, fs_value, pmu_value);
+	} else {
+		fp = fopen(filename, "a");
+		if (!fp) {
+			ksft_perror("Cannot open results file");
+			return -1;
+		}
+		fprintf(fp, "Pid: %d \t llc_value: %lu\t pmu_value: %lu\n",
+			(int)bm_pid, fs_value, pmu_value);
+		fclose(fp);
+	}
+
+	return 0;
+}
+
 /*
  * perf_event_measure - Measure perf events
  * @filename:	Filename for writing the results
@@ -164,13 +246,19 @@ int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
 int measure_llc_resctrl(const char *filename, pid_t bm_pid)
 {
 	unsigned long llc_occu_resc = 0;
+	unsigned long llc_occu_pmu = 0;
 	int ret;
 
 	ret = get_llc_occu_resctrl(&llc_occu_resc);
 	if (ret < 0)
 		return ret;
 
-	return print_results_cache(filename, bm_pid, llc_occu_resc);
+	/* Try to get PMU value as well */
+	ret = get_llc_occu_resctrl_pmu(&llc_occu_pmu);
+	if (ret < 0)
+		return ret;
+
+	return print_results_llc(filename, bm_pid, llc_occu_resc, llc_occu_pmu);
 }
 
 /*
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index d09e693dc739..28250903bbf0 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -78,6 +78,7 @@ static int check_results(struct resctrl_val_param *param, size_t span, int no_of
 {
 	char *token_array[8], temp[512];
 	unsigned long sum_llc_occu_resc = 0;
+	unsigned long sum_llc_occu_pmu = 0;
 	int runs = 0;
 	FILE *fp;
 
@@ -100,12 +101,24 @@ static int check_results(struct resctrl_val_param *param, size_t span, int no_of
 
 		/* Field 3 is llc occ resc value */
 		sum_llc_occu_resc += strtoul(token_array[3], NULL, 0);
+
+		/* Field 5: llc occupancy from PMU */
+		sum_llc_occu_pmu += strtoul(token_array[5], NULL, 0);
 		runs++;
 	}
 	fclose(fp);
 
-	return show_results_info(sum_llc_occu_resc, no_of_bits, span,
-				 MAX_DIFF, MAX_DIFF_PERCENT, runs, true);
+	/* Filesystem-based results */
+	ksft_print_msg("CMT (resctrl fs):\n");
+	int ret_fs = show_results_info(sum_llc_occu_resc, no_of_bits, span,
+				       MAX_DIFF, MAX_DIFF_PERCENT, runs, true);
+
+	/* PMU-based results */
+	ksft_print_msg("CMT (PMU):\n");
+	int ret_pmu = show_results_info(sum_llc_occu_pmu, no_of_bits, span,
+					MAX_DIFF, MAX_DIFF_PERCENT, runs, true);
+
+	return ret_fs || ret_pmu;
 }
 
 static void cmt_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/pmu_test.c b/tools/testing/selftests/resctrl/pmu_test.c
index fb3eec721e43..e4d75a8c0a6c 100644
--- a/tools/testing/selftests/resctrl/pmu_test.c
+++ b/tools/testing/selftests/resctrl/pmu_test.c
@@ -16,32 +16,6 @@
 
 #define RESCTRL_PMU_NAME "resctrl"
 
-static int find_pmu_type(const char *pmu_name)
-{
-	char path[256];
-	FILE *file;
-	int type;
-
-	snprintf(path, sizeof(path), "/sys/bus/event_source/devices/%s/type",
-		 pmu_name);
-
-	file = fopen(path, "r");
-	if (!file) {
-		ksft_print_msg("Failed to open %s: %s\n", path,
-			       strerror(errno));
-		return -1;
-	}
-
-	if (fscanf(file, "%d", &type) != 1) {
-		ksft_print_msg("Failed to read PMU type from %s\n", path);
-		fclose(file);
-		return -1;
-	}
-
-	fclose(file);
-	return type;
-}
-
 static bool is_allowed_file(const char *filename)
 {
 	const char *base;
@@ -288,7 +262,7 @@ static int pmu_run_test(const struct resctrl_test *test,
 	ksft_print_msg("Testing resctrl PMU file access safety\n");
 
 	/* Find the resctrl PMU type */
-	pmu_type = find_pmu_type(RESCTRL_PMU_NAME);
+	pmu_type = resctrl_find_pmu_type(RESCTRL_PMU_NAME);
 	if (pmu_type < 0) {
 		ksft_print_msg("Resctrl PMU not found - PMU is not registered?\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/pmu_utils.c b/tools/testing/selftests/resctrl/pmu_utils.c
new file mode 100644
index 000000000000..2d65d8b6e9e3
--- /dev/null
+++ b/tools/testing/selftests/resctrl/pmu_utils.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "resctrl.h"
+#include <stdio.h>
+
+int resctrl_find_pmu_type(const char *pmu_name)
+{
+	char path[256];
+	FILE *file;
+	int type;
+
+	if (!pmu_name)
+		return -1;
+
+	snprintf(path, sizeof(path), "/sys/bus/event_source/devices/%s/type",
+		 pmu_name);
+
+	file = fopen(path, "r");
+	if (!file) {
+		ksft_print_msg("Failed to open %s: %s\n", path, strerror(errno));
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
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 5b0e6074eaba..d1d2891081cf 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -205,6 +205,9 @@ void signal_handler_unregister(void);
 unsigned int count_bits(unsigned long n);
 int snc_kernel_support(void);
 
+/* PMU utilities */
+int resctrl_find_pmu_type(const char *pmu_name);
+
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
 int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);

