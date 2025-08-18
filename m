Return-Path: <linux-kselftest+bounces-39185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4017B2970A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 04:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6563A189D6EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 02:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2025394B;
	Mon, 18 Aug 2025 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc3R2R7z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704C2356BA
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484169; cv=none; b=sbcAT1k8/6zbZDseAgA88BYIndCqIB/veb7V7pLaA8Gni+J/wYzUjn3Iv7R3/jRYYKvvo2nfRlR5wsCothkmvqH8qWZydGeHgK7N4aJlRVUsJn4HIxYEKFzKLLyqewApAUxhu3spLq6fIqyscts7FerSlz17+3OFAUIS2oc91Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484169; c=relaxed/simple;
	bh=C2PKYYUVZVQtHWyZy22myhhFtA3k8g2ohyG0Us3q13s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EOfbVShPD1RbsgMbvHfr723ZxxJJEKWRkEVFjq9/dP6E3R9Yt4ZPAdt1irbhgG3JHb+ZbBzcFuHM2q+3vRBeftjKM2ZhAuj/LjWEU3q/Rk+wLWXO0/qJc8G3kUdzHFbattQLfE6HXYGO8SPmyECaq4E2OGzHI2Aum6LeMJLFvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc3R2R7z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6197efa570eso3142390a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755484165; x=1756088965; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qwo4EvSaKVtxWlwvzyu407UTggYXnJoPLedJSXgskLw=;
        b=Mc3R2R7zb+xB5GW8ggWDPJZnY/GYKWW4tXdMsDhhTyre1c6Fe5iC0GIHkXhc2blRHi
         mxwAPW0GlZcBW3bz5pjruvG1a7uVGq6h98CrPqH3rjR/HZL7xknVL9Z3R5gUH1wgG4tk
         130ptkf+0gzVw8fgmFWKho+PVrd0GVWx3pZCS1Hek4pyrwqyoNuP3qE0NVYhPlTG06DY
         HfjE8pJA6+ZkllMYIzWJc9f4MG7ee/JGks5HbQ1NI5/KEMjs5gpLz1GspuXeZ8EQdydZ
         NLaUqkh8SiDrCcxsy/UFIPcm90LQGEur2TZ1kCzBOEGIyBv/5h06MXdFpVVbweseHCg3
         stbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755484165; x=1756088965;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwo4EvSaKVtxWlwvzyu407UTggYXnJoPLedJSXgskLw=;
        b=uoe/agzVOd96d9vSkhlEvKYcdDR7IKxIDO3a5Bamagaa944afjkItJr89JI0vZCfuE
         VWeEjTgKvfp6F4bORYekBuWd7CHavZdaDvgEGaSZcQT6nXhEKlksJTWY/gQfuobM0xi7
         GFQP4PsFWmSdtZOhG+ewLMKM3A3/vbqZjWDInHQjMLKphWDCvptrSIQfo3rnUD1mq2jG
         I+Luyckuks/twyp89HxGjvrIylZ7qRt9BlkpkfgKebwt75qkDs7Krxabk6Knwt2gGSTw
         vm772RxNfSoMTrgJ9qe0Olxg8ygf7uDkvTpj+IGS4JiiOhxYhYaqWt6lqgwm5LdfJSAX
         GqFg==
X-Forwarded-Encrypted: i=1; AJvYcCV7E5neSpJQxPVV9G9N4+oR8THUq8Nl2ep7LA8oCmBzzgNwVea3JaXRv9bRlHuWdZ8fTBYzw3TnnI9NaHyQ6ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXobQA6NVBano8gVgCrXZ8KNgIFPupCIltRnkKqbMwY/E8aHI
	e0zHIZrpTV54SMONs+9+7yFSUKB+nJlQyTKn88rhuI2QxuqL8whSw9gV
X-Gm-Gg: ASbGncvidx5DwgSr7fDuudZgYNXPubDQsSRgYp/lUswqbVYISwZkkoMQXGeOuZNHTTo
	EjR7m4whB8ddJiZqZ26bOsS3IMxAHmi9IbRp5z05NBGNIGbqAF7OPHihT2iF9S3pdy1L+1beRVP
	20qExCLNxYV1s1J7puEDCCbaDwKA8899OkVd+25uQhTQrh8TbN+EMOAbBE6gAE7UO4DSd8v8k9w
	YidAz71Gi37kf+Nvzq9srGU1fbxH5lFF14Zq7lK4etNBCzrE8z6qNX6/3vhh+0WuZLYbjtjvy8H
	jujIWpbQVr4Ba4qEjS6tHJPsTkj30UodtAMtI1yDoluVszFtpfAk/0n1T1l2xEg/AChhC/kn+QG
	ou7TQGdjrlG5wGTY/Ck6ASA==
X-Google-Smtp-Source: AGHT+IHVh8tue+C1eIwBRg7SjuJPzgsjaqMdL1emRsyOkClQe9r5Z04vQX1onMb5dw8yd3T+j0YkSg==
X-Received: by 2002:a05:6402:848:b0:615:d142:70 with SMTP id 4fb4d7f45d1cf-619b707d164mr6191239a12.11.1755484165057;
        Sun, 17 Aug 2025 19:29:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9da5d9sm6127914a12.16.2025.08.17.19.29.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Aug 2025 19:29:24 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	riel@surriel.com,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3 2/2] selftests/mm: assert rmap behave as expected
Date: Mon, 18 Aug 2025 02:29:05 +0000
Message-Id: <20250818022905.15428-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250818022905.15428-1-richard.weiyang@gmail.com>
References: <20250818022905.15428-1-richard.weiyang@gmail.com>
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
v3:
  * handle ksm failure in worker
v2:
  * skip instead of assert if numa not available
  * check ksm sys file before continue
  * use private anonymous map instead of shared map
  * check pfn instead of content
  * retry migrate
  * fault in region for each process by FORCE_READ()
  * behave -> behaves
v1: fault in region by just accessing it instead of print it
---
 MAINTAINERS                               |   1 +
 tools/testing/selftests/mm/.gitignore     |   1 +
 tools/testing/selftests/mm/Makefile       |   3 +
 tools/testing/selftests/mm/rmap.c         | 433 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   4 +
 5 files changed, 442 insertions(+)
 create mode 100644 tools/testing/selftests/mm/rmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 390829ae9803..c0a4bda39f8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16192,6 +16192,7 @@ S:	Maintained
 F:	include/linux/rmap.h
 F:	mm/page_vma_mapped.c
 F:	mm/rmap.c
+F:	tools/testing/selftests/mm/rmap.c
 
 MEMORY MANAGEMENT - SECRETMEM
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index e7b23a8a05fe..92af0ae0fa7f 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -58,3 +58,4 @@ pkey_sighandler_tests_32
 pkey_sighandler_tests_64
 guard-regions
 merge
+rmap
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index d75f1effcb79..1a156637207f 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -102,6 +102,7 @@ TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
 TEST_GEN_FILES += guard-regions
 TEST_GEN_FILES += merge
+TEST_GEN_FILES += rmap
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
@@ -229,6 +230,8 @@ $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
 
 $(OUTPUT)/migration: LDLIBS += -lnuma
 
+$(OUTPUT)/rmap: LDLIBS += -lnuma
+
 local_config.mk local_config.h: check_config.sh
 	/bin/sh ./check_config.sh $(CC)
 
diff --git a/tools/testing/selftests/mm/rmap.c b/tools/testing/selftests/mm/rmap.c
new file mode 100644
index 000000000000..13f7bccfd0a9
--- /dev/null
+++ b/tools/testing/selftests/mm/rmap.c
@@ -0,0 +1,433 @@
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
+	"_file",
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
+void propagate_children(struct __test_metadata *_metadata, struct global_data *data)
+{
+	pid_t root_pid, pid;
+	unsigned int num_child;
+	int status;
+	int ret = 0;
+	int curr_child, worker_child;
+	int curr_level = 1;
+	bool is_worker = true;
+
+	root_pid = getpid();
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
+FIXTURE(migrate)
+{
+	struct global_data data;
+};
+
+FIXTURE_SETUP(migrate)
+{
+	struct global_data *data = &self->data;
+
+	if (numa_available() < 0)
+		SKIP(return, "NUMA not available");
+	if (numa_bitmask_weight(numa_all_nodes_ptr) <= 1)
+		SKIP(return, "Not enough NUMA nodes available");
+
+	data->mapsize = getpagesize();
+
+	data->expected_pfn = mmap(0, sizeof(unsigned long),
+				PROT_READ | PROT_WRITE,
+				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(data->expected_pfn, MAP_FAILED);
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
+void access_region(struct global_data *data)
+{
+	/*
+	 * Force read "region" to make sure page fault in.
+	 */
+	FORCE_READ(*data->region);
+}
+
+int try_to_move_page(char *region)
+{
+	int ret;
+	int node;
+	int status = 0;
+	int failures = 0;
+
+	ret = move_pages(0, 1, (void **)&region, NULL, &status, MPOL_MF_MOVE_ALL);
+	if (ret != 0) {
+		perror("Failed to get original numa");
+		return FAIL_ON_WORK;
+	}
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
+	while (1) {
+		ret = move_pages(0, 1, (void **)&region, &node, &status, MPOL_MF_MOVE_ALL);
+
+		/* migrate successfully */
+		if (!ret)
+			break;
+
+		/* error happened */
+		if (ret < 0) {
+			ksft_perror("Failed to move pages");
+			return FAIL_ON_WORK;
+		}
+
+		/* migration is best effort; try again */
+		if (++failures >= 100)
+			return FAIL_ON_WORK;
+	}
+
+	return 0;
+}
+
+int move_region(struct global_data *data)
+{
+	int ret;
+	int pagemap_fd;
+
+	ret = try_to_move_page(data->region);
+	if (ret != 0)
+		return ret;
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd == -1)
+		return FAIL_ON_WORK;
+	*data->expected_pfn = pagemap_get_pfn(pagemap_fd, data->region);
+
+	return 0;
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
+TEST_F(migrate, anon)
+{
+	struct global_data *data = &self->data;
+
+	/* Map an area and fault in */
+	data->region = mmap(0, data->mapsize, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(data->region, MAP_FAILED);
+	memset(data->region, 0xcf, data->mapsize);
+
+	data->do_prepare = access_region;
+	data->do_work = move_region;
+	data->do_check = has_same_pfn;
+
+	propagate_children(_metadata, data);
+}
+
+TEST_F(migrate, shm)
+{
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
+	memset(data->region, 0xcf, data->mapsize);
+	close(shm_fd);
+
+	data->do_prepare = access_region;
+	data->do_work = move_region;
+	data->do_check = has_same_pfn;
+
+	propagate_children(_metadata, data);
+}
+
+TEST_F(migrate, file)
+{
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
+	memset(data->region, 0xcf, data->mapsize);
+	close(fd);
+
+	data->do_prepare = access_region;
+	data->do_work = move_region;
+	data->do_check = has_same_pfn;
+
+	propagate_children(_metadata, data);
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
+	int pagemap_fd;
+	int ret = 0;
+
+	if (data->region == MAP_FAILED)
+		return FAIL_ON_WORK;
+
+	if (ksm_start() < 0)
+		return FAIL_ON_WORK;
+
+	ret = try_to_move_page(data->region);
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd == -1)
+		return FAIL_ON_WORK;
+	*data->expected_pfn = pagemap_get_pfn(pagemap_fd, data->region);
+
+	return ret;
+}
+
+TEST_F(migrate, ksm)
+{
+	int ret;
+	struct global_data *data = &self->data;
+
+	if (ksm_stop() < 0)
+		SKIP(return, "accessing \"/sys/kernel/mm/ksm/run\") failed");
+	if (ksm_get_full_scans() < 0)
+		SKIP(return, "accessing \"/sys/kernel/mm/ksm/full_scan\") failed");
+
+	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
+	if (ret < 0 && errno == EINVAL)
+		SKIP(return, "PR_SET_MEMORY_MERGE not supported");
+	else if (ret)
+		ksft_exit_fail_perror("PR_SET_MEMORY_MERGE=1 failed");
+
+	data->do_prepare = prepare_local_region;
+	data->do_work = merge_and_migrate;
+	data->do_check = has_same_pfn;
+
+	propagate_children(_metadata, data);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 471e539d82b8..75b94fdc915f 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -85,6 +85,8 @@ separated by spaces:
 	test handling of page fragment allocation and freeing
 - vma_merge
 	test VMA merge cases behave as expected
+- rmap
+	test rmap behaves as expected
 
 example: ./run_vmtests.sh -t "hmm mmap ksm"
 EOF
@@ -532,6 +534,8 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
 
 CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
 
+CATEGORY="rmap" run_test ./rmap
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
 echo "1..${count_total}" | tap_output
 
-- 
2.34.1


