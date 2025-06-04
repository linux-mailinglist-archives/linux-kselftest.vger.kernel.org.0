Return-Path: <linux-kselftest+bounces-34289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F96ACD99B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 10:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940AB1711B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422A27CB31;
	Wed,  4 Jun 2025 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK1QogDZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62685269898
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025325; cv=none; b=MhgwbrFPl1pbqJMs3rn3zy6kwByuIGwburNNJEbNFhJoVWwulXqljBhksiBBvjob2cDvT7ePgg6CLgS7vmdL+0lYSl1HFhEJdN5DKkHZhSaucqm1eicYDc/pzrVfAAPqa20YY8aHS3RpfL3q4O8HxroN3dwN3+Ff3zs68WrapMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025325; c=relaxed/simple;
	bh=Fcg/6dq0fnwrfZX8HSSsogUIqV05Sur3FNUHHDt71rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gT1+XzwQhNZDXFei+qjV/jduMdZflnz1dWrZa7QMJEk8duUk7a03MxcwvhQ2/Sh+5G5YOfuL3IIrBMDfBPSeeWGqqlDDMThsca/8ELt1OS3W+Lo92BDTc6VlD85kWtrRutfc0JIHmpBWyRJ7YQUAZ1/jgC9SwIwo8y0bnSg4tVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK1QogDZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad51ef2424bso1250223066b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749025320; x=1749630120; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QE8vdP8hSc3Jzn2TfzhjI7QNIR3JFcIZuJNht/87/2g=;
        b=QK1QogDZWtHwDrAQ7DkbxRJgB0W6XFCnRkUW0YlcVcu2al9lfsPRccMEG82fPH4lck
         3BlBFMpckq95WAV4LlD72I4sm+7LPlu3XK9/nwsoe65aVc6QgFpulMdGNsucGXtiAa4Y
         iHnoZOEHqru9q5nSaViNDsNTC2OOfbQVu0wub+NduxeFzoHMH1vc5gp206gXUFtx+Dwb
         QesvrHajUJO9d8qmfnpJzFSMAOYMI9j1ggQ1PwVQznvTDod4KFv7mkAU4rgO4TzljYa/
         NlOaVTMSm8tYwK5NdxQz/Bu6PHVFVt0NjEEjnFDXlcglDCFKdd5swGxxJQMgn3mA6ZHc
         1MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025320; x=1749630120;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE8vdP8hSc3Jzn2TfzhjI7QNIR3JFcIZuJNht/87/2g=;
        b=AhQaYcR3P1R38/zSSaUkEJvJxR38/f2ke4qnwxBR86B1GgbQrRg80PUFCkjgEO0yCN
         TMvp35T5SItIAKzvTdsRRwfi3Lxgte7R4xFMRz9qpS8yb0AFXTeVQYwMogdhYZrg19+u
         BPCyhXcUvVU1fvqjFztxiiQAWi32bDjdFgEGRP5RR2Qb3uFq73GFNsjVLGbZSexef17W
         PahnnG3a/b1hcvU9tTuymz8mwbyjsVi/N3OrTASn9CGp5NLYBWbmVAxozfbH9fIbyJKs
         WS/KsO5QZZ3UKopsNx29wYuYefs/wsfY+fMp+Y4V8lnqs5pSgHdZqmdWxaoJDbC2j96o
         6b1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvuCkI2XOYLqaka9WOfmJve76LzaYoD1CrYEOtkImOz69rez8zfcgEKAQCn6uOwWj8pu33YMCwuoCTyUIzIGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKTZKWm5gor2YWMle78EFNaUz7ZZw347LK13EikzheHpPceOi
	XBwj5+4TDDwZnbkqiXC1kxoJ0qOxrZXAp3f7EXrA6rRDosR9933fqnfH
X-Gm-Gg: ASbGncu5HsV2LI6g8spt1H3F+leOQWOrxvbs3XyCCTr41pt13Tf8sIRlPmfU7moOkA3
	rI2Kc+QNvZSGuigb7eg5a1rANzOto5jnc+A0ZWNltTYvvdBpjErOT+dNbqu1mk4GR6qDgMMiUpx
	ehr5AQwhJlW8pUCFJ8BqCjrjYBqX7TjlwjP/fN3fk+3eByraUkf1L8k+D+IvY6DqR84NQn2fD/w
	dXyVD+GTNen95Cc4IOiQXmCFdHyR4lFWiuZ/pM41uL6L6c1GVpNlHMW3n7FQmgoedMoDN7qMqmQ
	vOXaF/jNmG+pCOkZLrwCpXYrlCL/r5AVMO1vRds26VhaDXnVPkI=
X-Google-Smtp-Source: AGHT+IGA1vRYfxw2qJBS1JfBJz72Ul9etAVCtzIZ/k5JvEj70ONXbEZhgJVvEAs0TdM1XXfZqQbumw==
X-Received: by 2002:a17:907:7fa6:b0:adb:2e5f:faea with SMTP id a640c23a62f3a-addf8f2db75mr172091066b.41.1749025320299;
        Wed, 04 Jun 2025 01:22:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82de9bsm1053049266b.47.2025.06.04.01.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jun 2025 01:21:59 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [RFC Patch 2/2] selftests/mm: assert rmap behave as expected
Date: Wed,  4 Jun 2025 08:21:45 +0000
Message-Id: <20250604082145.13800-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250604082145.13800-1-richard.weiyang@gmail.com>
References: <20250604082145.13800-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

As David suggested, currently we don't have a high level test case to
verify the behavior of rmap. This patch introduce the verification on
rmap by migration.

The general idea is if migrate one shared page between processes, this
would be reflected in all related processes. Otherwise, we have problem
in rmap.

Currently it covers following four scenarios:

  * anonymous page
  * shmem page
  * pagecache page
  * ksm page

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>
---
 MAINTAINERS                               |   1 +
 tools/testing/selftests/mm/.gitignore     |   1 +
 tools/testing/selftests/mm/Makefile       |   3 +
 tools/testing/selftests/mm/rmap.c         | 466 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   4 +
 5 files changed, 475 insertions(+)
 create mode 100644 tools/testing/selftests/mm/rmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ecc6063b2b5..879138db85e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15664,6 +15664,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/rmap.h
 F:	mm/rmap.c
+F:	tools/testing/selftests/mm/rmap.c
 
 MEMORY MANAGEMENT - SECRETMEM
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 824266982aa3..ff4428d8bc5d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -60,3 +60,4 @@ pkey_sighandler_tests_32
 pkey_sighandler_tests_64
 guard-regions
 merge
+rmap
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index ae6f994d3add..c7e3a19b5555 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -100,6 +100,7 @@ TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
 TEST_GEN_FILES += guard-regions
 TEST_GEN_FILES += merge
+TEST_GEN_FILES += rmap
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
@@ -227,6 +228,8 @@ $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
 
 $(OUTPUT)/migration: LDLIBS += -lnuma
 
+$(OUTPUT)/rmap: LDLIBS += -lnuma
+
 local_config.mk local_config.h: check_config.sh
 	/bin/sh ./check_config.sh $(CC)
 
diff --git a/tools/testing/selftests/mm/rmap.c b/tools/testing/selftests/mm/rmap.c
new file mode 100644
index 000000000000..5b3ea5252d83
--- /dev/null
+++ b/tools/testing/selftests/mm/rmap.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RMAP functional tests
+ *
+ * Author(s): Wei Yang <richard.weiyang@gmail.com>
+ */
+
+#include "../kselftest_harness.h"
+#include <strings.h>
+#include <pthread.h>
+#include <numa.h>
+#include <numaif.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <signal.h>
+#include <time.h>
+#include <sys/sem.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "vm_util.h"
+
+#define TOTAL_LEVEL 5
+#define MAX_CHILDREN 3
+
+#define FAIL_ON_CHECK	(1 << 0)
+#define FAIL_ON_WORK	(1 << 1)
+
+struct sembuf sem_wait = {0, -1, 0};
+struct sembuf sem_signal = {0, 1, 0};
+
+static const char initial_data[] = "Hello, world 0!";
+static const char updated_data[] = "Hello, World 0!";
+
+enum backend_type {
+	ANON,
+	SHM,
+	NORM_FILE,
+};
+
+#define PREFIX "kst_rmap"
+#define MAX_FILENAME_LEN 256
+const char *suffixes[] = {
+	"",
+	"_shm",
+	"_norm",
+};
+
+struct global_data;
+typedef int (*work_fn)(struct global_data *data);
+typedef int (*check_fn)(struct global_data *data);
+typedef void (*prepare_fn)(struct global_data *data);
+
+struct global_data {
+	int worker_level;
+
+	int semid;
+	int pipefd[2];
+
+	unsigned int mapsize;
+	unsigned int rand_seed;
+	char *region;
+
+	prepare_fn do_prepare;
+	work_fn do_work;
+	check_fn do_check;
+
+	enum backend_type backend;
+	char filename[MAX_FILENAME_LEN];
+
+	unsigned long *expected_pfn;
+};
+
+/*
+ * Create a process tree with TOTAL_LEVEL height and at most MAX_CHILDREN
+ * children for each.
+ *
+ * It will randomly select one process as 'worker' process which will
+ * 'do_work' until all processes are created. And all other processes will
+ * wait until 'worker' finish its work.
+ */
+int propagate_children(struct global_data *data)
+{
+	pid_t pid;
+	unsigned int num_child;
+	int status;
+	int ret = 0;
+	int curr_child, worker_child;
+	int curr_level = 1;
+	bool is_worker = true;
+
+repeat:
+	num_child = rand_r(&data->rand_seed) % MAX_CHILDREN + 1;
+	worker_child = is_worker ? rand_r(&data->rand_seed) % num_child : -1;
+
+	for (curr_child = 0; curr_child < num_child; curr_child++) {
+		pid = fork();
+
+		if (pid < 0) {
+			perror("Error: fork\n");
+		} else if (pid == 0) {
+			curr_level++;
+
+			if (curr_child != worker_child)
+				is_worker = false;
+
+			if (curr_level == TOTAL_LEVEL)
+				break;
+
+			data->rand_seed += curr_child;
+			goto repeat;
+		}
+	}
+
+	if (data->do_prepare)
+		data->do_prepare(data);
+
+	close(data->pipefd[1]);
+
+	if (is_worker && curr_level == data->worker_level) {
+		/* This is the worker process, first wait last process created */
+		char buf;
+
+		while (read(data->pipefd[0], &buf, 1) > 0)
+			;
+
+		if (data->do_work)
+			ret = data->do_work(data);
+
+		/* Kick others */
+		semctl(data->semid, 0, IPC_RMID);
+	} else {
+		/* Wait worker finish */
+		semop(data->semid, &sem_wait, 1);
+		if (data->do_check)
+			ret = data->do_check(data);
+	}
+
+	/* Wait all child to quit */
+	while (wait(&status) > 0) {
+		if (WIFEXITED(status))
+			ret |= WEXITSTATUS(status);
+	}
+
+	return ret;
+}
+
+FIXTURE(migrate)
+{
+	struct global_data data;
+};
+
+FIXTURE_SETUP(migrate)
+{
+	struct global_data *data = &self->data;
+
+	ASSERT_EQ(numa_available(), 0);
+	if (numa_bitmask_weight(numa_all_nodes_ptr) <= 1)
+		SKIP(return, "Not enough NUMA nodes available");
+
+	data->mapsize = getpagesize();
+
+	/* Prepare semaphore */
+	data->semid = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
+	ASSERT_NE(data->semid, -1);
+	ASSERT_NE(semctl(data->semid, 0, SETVAL, 0), -1);
+
+	/* Prepare pipe */
+	ASSERT_NE(pipe(data->pipefd), -1);
+
+	data->rand_seed = time(NULL);
+	srand(data->rand_seed);
+
+	data->worker_level = rand() % TOTAL_LEVEL + 1;
+
+	data->do_prepare = NULL;
+	data->do_work = NULL;
+	data->do_check = NULL;
+
+	data->backend = ANON;
+};
+
+FIXTURE_TEARDOWN(migrate)
+{
+	struct global_data *data = &self->data;
+
+	if (data->region != MAP_FAILED)
+		munmap(data->region, data->mapsize);
+	data->region = MAP_FAILED;
+	if (data->expected_pfn != MAP_FAILED)
+		munmap(data->expected_pfn, sizeof(unsigned long));
+	data->expected_pfn = MAP_FAILED;
+	semctl(data->semid, 0, IPC_RMID);
+	data->semid = -1;
+
+	close(data->pipefd[0]);
+
+	data->do_work = NULL;
+	data->do_check = NULL;
+
+	switch (data->backend) {
+	case ANON:
+		break;
+	case SHM:
+		shm_unlink(data->filename);
+		break;
+	case NORM_FILE:
+		unlink(data->filename);
+		break;
+	}
+}
+
+int try_to_move_page(char *region)
+{
+	int ret;
+	int node;
+	int status = 0;
+
+	ksft_print_msg("worker %d move_pages of content: %.15s\n", getpid(), region);
+
+	ret = move_pages(0, 1, (void **)&region, NULL, &status, MPOL_MF_MOVE_ALL);
+	if (ret != 0)
+		return FAIL_ON_WORK;
+
+	/* Pick up a different target node */
+	for (node = 0; node <= numa_max_node(); node++) {
+		if (numa_bitmask_isbitset(numa_all_nodes_ptr, node) && node != status)
+			break;
+	}
+
+	if (node > numa_max_node()) {
+		ksft_print_msg("Couldn't find available numa node for testing\n");
+		return FAIL_ON_WORK;
+	}
+
+	ret = move_pages(0, 1, (void **)&region, &node, &status, MPOL_MF_MOVE_ALL);
+	if (ret != 0)
+		return FAIL_ON_WORK;
+
+	return 0;
+}
+
+int move_and_update(struct global_data *data)
+{
+	int ret;
+
+	ret = try_to_move_page(data->region);
+	if (ret != 0)
+		return ret;
+
+	/* Change the content */
+	strcpy(data->region, updated_data);
+
+	return ret;
+}
+
+int data_updated(struct global_data *data)
+{
+	if (data->region == MAP_FAILED)
+		return 0;
+
+	if (strncmp((char *)data->region, updated_data, strlen(updated_data)))
+		return FAIL_ON_CHECK;
+	return 0;
+}
+
+TEST_F(migrate, anon)
+{
+	pid_t root_pid;
+	int ret;
+	struct global_data *data = &self->data;
+
+	/* Map a shared area and fault in */
+	data->region = mmap(0, data->mapsize, PROT_READ | PROT_WRITE,
+				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(data->region, MAP_FAILED);
+	strcpy(data->region, initial_data);
+
+	data->do_work = move_and_update;
+	data->do_check = data_updated;
+
+	root_pid = getpid();
+
+	ret = propagate_children(data);
+
+	if (getpid() == root_pid) {
+		if (ret & FAIL_ON_WORK)
+			SKIP(return, "Failed on moving page");
+
+		ASSERT_EQ(ret, 0);
+	} else {
+		exit(ret);
+	}
+}
+
+TEST_F(migrate, shm)
+{
+	pid_t root_pid;
+	int ret;
+	int shm_fd;
+	struct global_data *data = &self->data;
+
+	snprintf(data->filename, MAX_FILENAME_LEN, "%s%s", PREFIX, suffixes[SHM]);
+	shm_fd = shm_open(data->filename, O_CREAT | O_RDWR, 0666);
+	ASSERT_NE(shm_fd, -1);
+	ftruncate(shm_fd, data->mapsize);
+	data->backend = SHM;
+
+	/* Map a shared area and fault in */
+	data->region = mmap(0, data->mapsize, PROT_READ | PROT_WRITE,
+				MAP_SHARED, shm_fd, 0);
+	ASSERT_NE(data->region, MAP_FAILED);
+	strcpy(data->region, initial_data);
+	close(shm_fd);
+
+	data->do_work = move_and_update;
+	data->do_check = data_updated;
+
+	root_pid = getpid();
+
+	ret = propagate_children(data);
+
+	if (getpid() == root_pid) {
+		if (ret & FAIL_ON_WORK)
+			SKIP(return, "Failed on moving page");
+
+		ASSERT_EQ(ret, 0);
+	} else {
+		exit(ret);
+	}
+}
+
+TEST_F(migrate, file)
+{
+	pid_t root_pid;
+	int ret;
+	int fd;
+	struct global_data *data = &self->data;
+
+	snprintf(data->filename, MAX_FILENAME_LEN, "%s%s", PREFIX, suffixes[NORM_FILE]);
+	fd = open(data->filename, O_CREAT | O_RDWR | O_EXCL, 0666);
+	ASSERT_NE(fd, -1);
+	ftruncate(fd, data->mapsize);
+	data->backend = NORM_FILE;
+
+	/* Map a shared area and fault in */
+	data->region = mmap(0, data->mapsize, PROT_READ | PROT_WRITE,
+				MAP_SHARED, fd, 0);
+	ASSERT_NE(data->region, MAP_FAILED);
+	strcpy(data->region, initial_data);
+	close(fd);
+
+	data->do_work = move_and_update;
+	data->do_check = data_updated;
+
+	root_pid = getpid();
+
+	ret = propagate_children(data);
+
+	if (getpid() == root_pid) {
+		if (ret & FAIL_ON_WORK)
+			SKIP(return, "Failed on moving page");
+
+		ASSERT_EQ(ret, 0);
+	} else {
+		exit(ret);
+	}
+}
+
+void prepare_local_region(struct global_data *data)
+{
+	/* Allocate range and set the same data */
+	data->region = mmap(NULL, data->mapsize, PROT_READ|PROT_WRITE,
+			   MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (data->region == MAP_FAILED)
+		return;
+
+	memset(data->region, 0xcf, data->mapsize);
+}
+
+int merge_and_migrate(struct global_data *data)
+{
+	long start_scans, end_scans;
+	int ksm_fd, ksm_full_scans_fd, pagemap_fd;
+	int ret = 0;
+
+	if (data->region == MAP_FAILED)
+		return FAIL_ON_WORK;
+
+	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
+	ksm_full_scans_fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+
+	if (ksm_fd == -1 || ksm_full_scans_fd == -1 || pagemap_fd == -1)
+		return FAIL_ON_WORK;
+
+	/* Wait for two full scans such that any possible merging happened. */
+	start_scans = ksm_get_full_scans(ksm_full_scans_fd);
+	if (start_scans < 0)
+		return FAIL_ON_WORK;
+	if (ksm_start_and_merge(ksm_fd) != 1)
+		return FAIL_ON_WORK;
+	do {
+		end_scans = ksm_get_full_scans(ksm_full_scans_fd);
+		if (end_scans < 0)
+			return FAIL_ON_WORK;
+	} while (end_scans < start_scans + 3);
+
+	ret = try_to_move_page(data->region);
+
+	*data->expected_pfn = pagemap_get_pfn(pagemap_fd, data->region);
+
+	return ret;
+}
+
+int has_same_pfn(struct global_data *data)
+{
+	unsigned long pfn;
+	int pagemap_fd;
+
+	if (data->region == MAP_FAILED)
+		return 0;
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd == -1)
+		return FAIL_ON_CHECK;
+
+	pfn = pagemap_get_pfn(pagemap_fd, data->region);
+	if (pfn != *data->expected_pfn)
+		return FAIL_ON_CHECK;
+
+	return 0;
+}
+
+TEST_F(migrate, ksm)
+{
+	pid_t root_pid;
+	int ret;
+	struct global_data *data = &self->data;
+
+	ASSERT_EQ(prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0), 0);
+	data->do_prepare = prepare_local_region;
+	data->do_work = merge_and_migrate;
+	data->do_check = has_same_pfn;
+
+	data->expected_pfn = mmap(0, sizeof(unsigned long),
+				PROT_READ | PROT_WRITE,
+				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(data->expected_pfn, MAP_FAILED);
+
+	root_pid = getpid();
+
+	ret = propagate_children(data);
+
+	if (getpid() == root_pid) {
+		if (ret & FAIL_ON_WORK)
+			SKIP(return, "Failed in worker");
+
+		ASSERT_EQ(ret, 0);
+	} else {
+		exit(ret);
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index dddd1dd8af14..652386999756 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -83,6 +83,8 @@ separated by spaces:
 	test handling of page fragment allocation and freeing
 - vma_merge
 	test VMA merge cases behave as expected
+- rmap
+	test rmap behave as expected
 
 example: ./run_vmtests.sh -t "hmm mmap ksm"
 EOF
@@ -521,6 +523,8 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
 
 CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
 
+CATEGORY="rmap" run_test ./rmap
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
 echo "1..${count_total}" | tap_output
 
-- 
2.34.1


