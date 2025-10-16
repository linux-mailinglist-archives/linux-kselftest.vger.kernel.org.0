Return-Path: <linux-kselftest+bounces-43336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCABE3FF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E5C1A657FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853334AAE2;
	Thu, 16 Oct 2025 14:47:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541C3469E4
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626031; cv=none; b=gXx2uRIa2fIrdFsSB0Slo0audW7dZlrU7YGCxoMOeFSbAO5dqQSonkh5W8tHzLGAi5zCneuTvH6Vx/sM0p4ct/es9fMr2cJWequBmTYNCuWvV2kr/PFh+oX/fPqTzmR772/KGiTUTnnir4WKUiJoXMRoBkoo9fqX0j92bWebPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626031; c=relaxed/simple;
	bh=kcz2Za79jyB/wIwvQCRpYXCOBX9SihfQEP++MwdUQKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+Ds9H2xTePc5oiCmOzmESRWFU4na2pD2RVMaWxXXsZAgpi3VhAVyMhLM1ef+zylK+t6HW/BpieCpWvymNpyIUFNT6UiSBgzLFCl1NZ8OCwQkjNeu/oJx78flg+S18Dad6TEexGteC5dnJIKbHpS2yvKLFY8KaXBQND1WSpzHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43f935f7d14so333947b6e.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 07:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626028; x=1761230828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKKw+1FOvuGpZeJoYuJP4D2T/0Igapy6n2jKP9t0Gf4=;
        b=HUI2r3jhoGQmr4W5p30PxBuQGR17f3ndwnbEasoaHdu/OtVKCNRmRICPOHUNEShTT5
         bHkuSouXic4wgJPQAql0twKV/dpp2jwJYAtSqhfK1C/5lTLVEpHljMVlSjoVyqyIHTPl
         8UjHe1oD+XN5oqb3FzDDPcoHBT/+YMqX/ilGpun409SRhiBUhGI0U6YTKRyMkNPbhrpH
         90peCMlCCo0NSPGqSjaVXDjYWuBCoQu+qYk6oFwYqGt0a3eUWJgcVkMe2A+0hZskKibo
         CRFectonvmel9P3fC2t9zfV9bLZGgiQB2Rvf2ZrfxoGmdI4sh+0N+Tls43YrYVc+xXnI
         2thA==
X-Gm-Message-State: AOJu0YzJyuP/J8awhUKKlYymDeaDUJeE62xFa35funOS8UhS04mFRt1t
	VK9/6fRVjwCYAMpDybEYHlBGeaSpN0m/x37b+82HU9BqaPbcHmfqDjxa
X-Gm-Gg: ASbGncsYqEr2NyNnWOiUiJhS3+2Iq9/urQ8KwXcrHr59vN2lGw+Zv4ks+LdvwoENcOt
	CCWgLX+jQ6RQ4u9qY+Ov+DH8WQzaqQd45pVFO6tmGg5Li/WkD5Z9WEsb3KitEKbK/VkadpPSn9R
	m/gM2bpcUbAQBtbztSed6UuonwrIJ/cFOh+or4wgK0g7pfKL+SyUYezrFUFU+esaHQUvfPKoJ4X
	2Wh2T8zp8rYacAWC9+KgRoltQqWaaOBqREiGtXwFC4eLDYkbEZ3NFD9G6xU4R04fi/rMSui9L7E
	xsUaPJl2Qv24FWT0/HTsoJvcEcePJJljt6TpTG07LO3BrDGEiyVGWMwRjpWffjKCduAW87YXoA2
	XbbnyqyRas7vtohPkoH1Mqz4Xts/jTQ7EFNG24vOxYrWLWUWtqEAhsPuEeMNa89crzPzh9tlOL3
	NuOlAixmHFawUBycss3TGmIEYoJ2AO7lm2cdw0it9C+UBOzvrKMPfSv08LwMl0tBwug4M=
X-Google-Smtp-Source: AGHT+IEl+McCmwNj5n5UABPh5EXtH7pj4NhPOnj1CYi5KF1wA0afnYHvrsjxYZpRFSVlVKKD3j3GHQ==
X-Received: by 2002:a05:6808:16a4:b0:441:8f74:fcd with SMTP id 5614622812f47-443a309882cmr102090b6e.58.1760626028347;
        Thu, 16 Oct 2025 07:47:08 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.07
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
Subject: [PATCH 7/8] resctrl/pmu: Use mon_event_setup_read() and validate CPU
Date: Thu, 16 Oct 2025 09:46:55 -0500
Message-ID: <20251016144656.74928-8-yonch@yonch.com>
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

During event_init, extract mon_data from the monitoring file and call
mon_event_setup_read() to prepare rmid_read and the valid CPU mask for
that file. Require a CPU-bound event and verify the bound CPU is in
the mask.

Store the prepared rmid_read and CPU mask in the event private data
along with the pinned rdtgroup.

Split the helper that gets the pinned rdtgroup in two, so event_init
can get the mon_data from kernfs_open_file:
- rdtgroup_get_mondata_open_file() gets kernfs_open_file from file
- rdtgroup_get_from_mondata_file() gets pinned rdtgroup from
  kernfs_open_file

Extend the selftest to test CPU validation and verify that pid-bound
events are rejected.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/internal.h                      |   2 +
 fs/resctrl/pmu.c                           |  59 +++++++-
 fs/resctrl/rdtgroup.c                      |  24 ++-
 tools/testing/selftests/resctrl/pmu_test.c | 164 ++++++++++++++++++---
 4 files changed, 214 insertions(+), 35 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index b42c625569a8..8cc3a3747c2f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -365,6 +365,8 @@ int rdtgroup_mondata_open(struct kernfs_open_file *of);
 void rdtgroup_mondata_release(struct kernfs_open_file *of);
 void rdtgroup_get(struct rdtgroup *rdtgrp);
 void rdtgroup_put(struct rdtgroup *rdtgrp);
+struct kernfs_open_file *rdtgroup_get_mondata_open_file(struct file *file);
+struct rdtgroup *rdtgroup_get_from_mondata_file(struct kernfs_open_file *of);
 
 /* PMU support */
 /*
diff --git a/fs/resctrl/pmu.c b/fs/resctrl/pmu.c
index e7915a0a3520..bdca0b3a5b0b 100644
--- a/fs/resctrl/pmu.c
+++ b/fs/resctrl/pmu.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/seq_file.h>
+#include <linux/cpu.h>
 #include "internal.h"
 
 static struct pmu resctrl_pmu;
@@ -21,6 +22,8 @@ static struct pmu resctrl_pmu;
  */
 struct resctrl_pmu_event {
 	struct rdtgroup *rdtgrp;	/* Reference to rdtgroup being monitored */
+	struct rmid_read rr;		/* RMID read setup for monitoring */
+	cpumask_t *cpumask;		/* Valid CPUs for this monitoring file */
 };
 
 static void resctrl_event_destroy(struct perf_event *event);
@@ -34,9 +37,16 @@ static int resctrl_event_init(struct perf_event *event)
 	struct resctrl_pmu_event *resctrl_event;
 	struct file *file;
 	struct rdtgroup *rdtgrp;
+	struct kernfs_open_file *of;
+	struct mon_data *md;
+	struct rmid_read rr = {0};
+	cpumask_t *cpumask;
 	int fd;
 	int ret;
 
+	if (event->cpu < 0)
+		return -EINVAL;
+
 	fd = (int)event->attr.config;
 	if (fd < 0)
 		return -EINVAL;
@@ -45,11 +55,46 @@ static int resctrl_event_init(struct perf_event *event)
 	if (!file)
 		return -EBADF;
 
-	/* Resolve rdtgroup from the monitoring file and take a reference */
-	rdtgrp = rdtgroup_get_from_file(file);
+	of = rdtgroup_get_mondata_open_file(file);
+	if (IS_ERR(of)) {
+		ret = PTR_ERR(of);
+		goto out_fput;
+	}
+
+	/* Extract mon_data which specifies which resource to measure */
+	if (!of->kn || !of->kn->priv) {
+		ret = -EIO;
+		goto out_fput;
+	}
+	md = of->kn->priv;
+
+	rdtgrp = rdtgroup_get_from_mondata_file(of);
+	if (IS_ERR(rdtgrp)) {
+		ret = PTR_ERR(rdtgrp);
+		goto out_fput;
+	}
+
 	fput(file);
-	if (IS_ERR(rdtgrp))
-		return PTR_ERR(rdtgrp);
+	file = NULL;
+
+	cpus_read_lock();
+
+	ret = mon_event_setup_read(&rr, &cpumask, md, rdtgrp);
+	if (ret) {
+		cpus_read_unlock();
+		rdtgroup_put(rdtgrp);
+		return ret;
+	}
+
+	/* Validate that the requested CPU is in the valid CPU mask for this monitoring file */
+	if (!cpumask_test_cpu(event->cpu, cpumask)) {
+		ret = -EINVAL;
+		cpus_read_unlock();
+		rdtgroup_put(rdtgrp);
+		return ret;
+	}
+
+	cpus_read_unlock();
 
 	resctrl_event = kzalloc(sizeof(*resctrl_event), GFP_KERNEL);
 	if (!resctrl_event) {
@@ -58,10 +103,16 @@ static int resctrl_event_init(struct perf_event *event)
 	}
 
 	resctrl_event->rdtgrp = rdtgrp;
+	resctrl_event->rr = rr;
+	resctrl_event->cpumask = cpumask;
 	event->pmu_private = resctrl_event;
 	event->destroy = resctrl_event_destroy;
 
 	return 0;
+
+out_fput:
+	fput(file);
+	return ret;
 }
 
 static void resctrl_event_destroy(struct perf_event *event)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 4f4139edafbf..ed7d9feccd94 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3429,19 +3429,16 @@ void rdtgroup_mondata_release(struct kernfs_open_file *of)
 }
 
 /*
- * rdtgroup_get_from_file - Resolve rdtgroup from a resctrl mon data file
+ * Resolve kernfs_open_file from a resctrl mon data file.
  * @file: struct file opened on a resctrl monitoring data file
  *
  * Validate that @file belongs to resctrl and refers to a monitoring data
- * file (kf_mondata_ops). Then, using the kernfs_open_file stored in the
- * seq_file, safely fetch the rdtgroup that was pinned at open time and take
- * an additional rdtgroup reference for the caller under rdtgroup_mutex.
+ * file (kf_mondata_ops).
  *
- * Returns: rdtgroup* with an extra reference on success; ERR_PTR on failure.
+ * Returns: kernfs_open_file* on success; ERR_PTR on failure.
  */
-struct rdtgroup *rdtgroup_get_from_file(struct file *file)
+struct kernfs_open_file *rdtgroup_get_mondata_open_file(struct file *file)
 {
-	struct rdtgroup *rdtgrp = NULL;
 	struct kernfs_open_file *of;
 	struct seq_file *seq;
 	struct inode *inode;
@@ -3464,6 +3461,19 @@ struct rdtgroup *rdtgroup_get_from_file(struct file *file)
 	if (!of || !of->kn || of->kn->attr.ops != &kf_mondata_ops)
 		return ERR_PTR(-EINVAL);
 
+	return of;
+}
+
+/*
+ * Get rdtgroup from a resctrl mon data open file.
+ * @of: kernfs_open_file opened on a resctrl monitoring data file
+ *
+ * Returns: rdtgroup* with an extra reference on success; ERR_PTR on failure.
+ */
+struct rdtgroup *rdtgroup_get_from_mondata_file(struct kernfs_open_file *of)
+{
+	struct rdtgroup *rdtgrp = NULL;
+
 	/* Hold rdtgroup_mutex to prevent race with release callback */
 	guard(mutex)(&rdtgroup_mutex);
 
diff --git a/tools/testing/selftests/resctrl/pmu_test.c b/tools/testing/selftests/resctrl/pmu_test.c
index 29a0ac329619..fb3eec721e43 100644
--- a/tools/testing/selftests/resctrl/pmu_test.c
+++ b/tools/testing/selftests/resctrl/pmu_test.c
@@ -3,13 +3,16 @@
  * Resctrl PMU test
  *
  * Test program to verify the resctrl PMU functionality.
- * Walks resctrl filesystem and verifies only allowed files can be
- * used with the resctrl PMU via perf_event_open.
+ * Walks resctrl filesystem and verifies only allowed monitoring files
+ * can be used with the resctrl PMU via perf_event_open when pinned to
+ * CPUs in the correct L3 domain. Also validates that PID-bound events
+ * are rejected for all files.
  */
 
 #include "resctrl.h"
 #include <fcntl.h>
 #include <dirent.h>
+#include <unistd.h>
 
 #define RESCTRL_PMU_NAME "resctrl"
 
@@ -52,11 +55,51 @@ static bool is_allowed_file(const char *filename)
 		!strcmp(base, "mbm_local_bytes"));
 }
 
+/* Extract base filename from a path */
+static const char *base_name(const char *path)
+{
+	const char *slash = strrchr(path, '/');
+
+	return slash ? slash + 1 : path;
+}
+
+/* Parse mon_L3_XX ID from a monitoring path. Returns true on success. */
+static bool parse_l3_id_from_path(const char *path, int *l3_id)
+{
+	const char *needle = "mon_data/mon_L3_";
+	const char *p = strstr(path, needle);
+	char *endptr;
+	long id;
+
+	if (!p)
+		return false;
+
+	p += strlen(needle);
+
+	if (!isdigit((unsigned char)*p))
+		return false;
+
+	errno = 0;
+	id = strtol(p, &endptr, 10);
+	if (errno || endptr == p)
+		return false;
+
+	/* Accept only non-negative IDs */
+	if (id < 0)
+		return false;
+
+	*l3_id = (int)id;
+	return true;
+}
+
 static int test_file_safety(int pmu_type, const char *filepath)
 {
 	struct perf_event_attr pe = { 0 };
 	int fd, perf_fd;
-	bool should_succeed;
+	bool is_monitoring = false;
+	int file_l3_id = -1;
+	int ret = 0;
+	const char *fname = base_name(filepath);
 
 	/* Try to open the file */
 	fd = open(filepath, O_RDONLY);
@@ -65,7 +108,8 @@ static int test_file_safety(int pmu_type, const char *filepath)
 		return 0;
 	}
 
-	should_succeed = is_allowed_file(filepath);
+	/* Determine if this is a monitoring file under mon_L3_XX and allowed */
+	is_monitoring = (is_allowed_file(fname) && parse_l3_id_from_path(filepath, &file_l3_id));
 
 	/* Setup perf event attributes */
 	pe.type = pmu_type;
@@ -75,34 +119,106 @@ static int test_file_safety(int pmu_type, const char *filepath)
 	pe.exclude_kernel = 0;
 	pe.exclude_hv = 0;
 
-	/* Try to open the perf event */
-	perf_fd = perf_event_open(&pe, -1, 0, -1, 0);
+	/* PID-bound negative attempt: should fail for all files */
+	perf_fd = perf_event_open(&pe, getpid(), -1, -1, 0);
+	if (perf_fd >= 0) {
+		ksft_print_msg("FAIL: pid-bound perf_event_open unexpectedly succeeded for %s\n",
+			       filepath);
+		close(perf_fd);
+		close(fd);
+		return -1;
+	}
+
+	int success_count = 0;
+	cpu_set_t mask;
+	int max_cpus, nconf;
+
+	CPU_ZERO(&mask);
+	if (sched_getaffinity(0, sizeof(mask), &mask)) {
+		ksft_perror("sched_getaffinity failed");
+		goto out;
+	}
+
+	nconf = (int)sysconf(_SC_NPROCESSORS_CONF);
+	max_cpus = (nconf > 0 && nconf < CPU_SETSIZE) ? nconf : CPU_SETSIZE;
+
+	for (int cpu = 0; cpu < max_cpus; cpu++) {
+		int cpu_l3;
+
+		if (!CPU_ISSET(cpu, &mask))
+			continue;
+
+		if (get_domain_id("L3", cpu, &cpu_l3) < 0) {
+			ksft_print_msg("Failed to get L3 domain ID for CPU %d\n", cpu);
+			ret = -1;
+			break;
+		}
 
-	if (should_succeed) {
-		if (perf_fd < 0) {
-			ksft_print_msg("FAIL: unexpected - perf_event_open failed for %s: %s\n",
-				       filepath, strerror(errno));
-			close(fd);
-			return -1;
+		perf_fd = perf_event_open(&pe, -1, cpu, -1, 0);
+
+		if (is_monitoring) {
+			bool expected_ok = (cpu_l3 == file_l3_id);
+
+			if (expected_ok) {
+				if (perf_fd < 0) {
+					ksft_print_msg("FAIL: %s CPU %d (L3=%d) expected success, got %s\n",
+						       filepath, cpu, cpu_l3, strerror(errno));
+					ret = -1;
+					break;
+				}
+				success_count++;
+				close(perf_fd);
+			} else {
+				if (perf_fd >= 0) {
+					ksft_print_msg("FAIL: %s CPU %d (L3=%d) expected EINVAL fail, but opened\n",
+						       filepath, cpu, cpu_l3);
+					close(perf_fd);
+					ret = -1;
+					break;
+				}
+				if (errno != EINVAL) {
+					ksft_print_msg("FAIL: %s CPU %d expected errno=EINVAL, got %d (%s)\n",
+						       filepath, cpu, errno, strerror(errno));
+					ret = -1;
+					break;
+				}
+			}
+		} else {
+			/* Non-monitoring files must fail on all CPUs with EINVAL */
+			if (perf_fd >= 0) {
+				ksft_print_msg("FAIL: non-monitoring file %s CPU %d unexpectedly opened\n",
+					       filepath, cpu);
+				close(perf_fd);
+				ret = -1;
+				break;
+			}
+			if (errno != EINVAL) {
+				ksft_print_msg("FAIL: non-monitoring file %s CPU %d expected errno=EINVAL, got %d (%s)\n",
+					       filepath, cpu, errno, strerror(errno));
+				ret = -1;
+				break;
+			}
 		}
-		ksft_print_msg("PASS: Allowed file %s successfully opened perf event\n",
+	}
+
+	if (!ret && is_monitoring && success_count < 1) {
+		ksft_print_msg("FAIL: monitoring file %s had no successful CPU opens\n",
 			       filepath);
-		close(perf_fd);
-	} else {
-		if (perf_fd >= 0) {
-			ksft_print_msg("FAIL: unexpected - perf_event_open succeeded for %s\n",
+		ret = -1;
+	}
+
+	if (!ret) {
+		if (is_monitoring)
+			ksft_print_msg("PASS: monitoring %s: %d CPU(s) opened in-domain, others rejected\n",
+				       filepath, success_count);
+		else
+			ksft_print_msg("PASS: non-monitoring %s: all CPU-bound opens rejected with EINVAL\n",
 				       filepath);
-			close(perf_fd);
-			close(fd);
-			return -1;
-		}
-		ksft_print_msg("PASS: Blocked file %s correctly failed perf_event_open: %s\n",
-			       filepath, strerror(errno));
 	}
 
 out:
 	close(fd);
-	return 0;
+	return ret;
 }
 
 static int walk_directory_recursive(int pmu_type, const char *dir_path)

