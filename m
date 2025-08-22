Return-Path: <linux-kselftest+bounces-39666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04CB311C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD690A258F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01772ECD37;
	Fri, 22 Aug 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aLiHlr7y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE692EBB9F;
	Fri, 22 Aug 2025 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851009; cv=none; b=Kc4nIvjtlyWkCOOCVNyNG81LHhI8tAeJHHWZal+yONPz5Sgh93Ol5lJ6dPlJ/GMan61+H4Mqm5iXn4SUjMFCGlksgcI7U0uYhfkkhc/e+8VSZKAOIh2wWGyA4kTXAZySDg5DLuss/NfcMxMph1aTsk7Zw3cKICC+IzPc3We2EkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851009; c=relaxed/simple;
	bh=a5UE+pImjGxYNd7vPvGSvbIoUcbPZrmvcLKnaYtTnQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldGnBn9PrUYB89CBVVjPhp4o3QgLJ+kfBjWPpP+ylHVcocCdD815W7nKwJm/KtmhIcxgE+DR+vAf3e9bOcsmNHXRbOK37sia5RjS9HMf6OfsvCGJ9elSAVvhifh4vrzXHv/mfWQk67gGrV7XeFO+xmmMqXah1/1JhwBqKq/IQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aLiHlr7y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755851006;
	bh=a5UE+pImjGxYNd7vPvGSvbIoUcbPZrmvcLKnaYtTnQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLiHlr7yOB77l4M5/FWrsuLfngueLhplsq9hVGF/cnoYI6RVbZr6MGPiKM031EtFp
	 IR2lBVECBod0Or/+3ocW2HVOHxfsYDHZx5F98NCx2x7F9KXv9rx6eTF9+evMhF3j1t
	 /sByzeXybMWJF7lNDNTeOvvRt8dFSF6Kfbxn7+eI/qurYaGTFJswm3Ny3GQ2RE6vjb
	 clYjanlmOtSfe5gJCBG8sx7QSZmrcDg0PrzEU1FHfrUtwHfQp97qzwsmBCdBUOGy55
	 dIP3dRCrfYObZG6HHwBXUrftPtmy3yZvc8vBUkVLvUsCC/AIcv60k8X3/cX+Iq0Z4y
	 GHluESMdGlBTQ==
Received: from mt.tail9873f4.ts.net (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C730717E05F0;
	Fri, 22 Aug 2025 10:23:20 +0200 (CEST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	kevin.brodsky@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v3 5/8] selftests/mm: Remove unused parameters
Date: Fri, 22 Aug 2025 13:21:02 +0500
Message-ID: <20250822082145.4145617-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822082145.4145617-1-usama.anjum@collabora.com>
References: <20250822082145.4145617-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup code and remove the unused arguments

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/ksm_tests.c       | 17 +++++++----------
 tools/testing/selftests/mm/soft-dirty.c      |  4 ++--
 tools/testing/selftests/mm/uffd-common.c     |  4 ++--
 tools/testing/selftests/mm/uffd-common.h     |  2 +-
 tools/testing/selftests/mm/uffd-stress.c     |  2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c |  8 ++++----
 6 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index b77462b5c240b..f5dabb513ed7f 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -238,8 +238,7 @@ static int ksm_merge_pages(int merge_type, void *addr, size_t size,
 	return 0;
 }
 
-static int ksm_unmerge_pages(void *addr, size_t size,
-			     struct timespec start_time, int timeout)
+static int ksm_unmerge_pages(void *addr, size_t size)
 {
 	if (madvise(addr, size, MADV_UNMERGEABLE)) {
 		perror("madvise");
@@ -456,7 +455,7 @@ static int get_first_mem_node(void)
 	return get_next_mem_node(numa_max_node());
 }
 
-static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeout,
+static int check_ksm_numa_merge(int merge_type, int timeout,
 				bool merge_across_nodes, size_t page_size)
 {
 	void *numa1_map_ptr, *numa2_map_ptr;
@@ -520,8 +519,7 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
 	return KSFT_FAIL;
 }
 
-static int ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
-				int timeout, size_t map_size)
+static int ksm_merge_hugepages_time(int merge_type, int timeout, size_t map_size)
 {
 	void *map_ptr, *map_ptr_orig;
 	struct timespec start_time, end_time;
@@ -656,7 +654,7 @@ static int ksm_unmerge_time(int merge_type, int mapping, int prot, int timeout,
 		perror("clock_gettime");
 		goto err_out;
 	}
-	if (ksm_unmerge_pages(map_ptr, map_size, start_time, timeout))
+	if (ksm_unmerge_pages(map_ptr, map_size))
 		goto err_out;
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
 		perror("clock_gettime");
@@ -884,8 +882,8 @@ int main(int argc, char *argv[])
 						page_size);
 		break;
 	case CHECK_KSM_NUMA_MERGE:
-		ret = check_ksm_numa_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-					ksm_scan_limit_sec, merge_across_nodes, page_size);
+		ret = check_ksm_numa_merge(merge_type, ksm_scan_limit_sec, merge_across_nodes,
+					   page_size);
 		break;
 	case KSM_MERGE_TIME:
 		if (size_MB == 0) {
@@ -900,8 +898,7 @@ int main(int argc, char *argv[])
 			printf("Option '-s' is required.\n");
 			return KSFT_FAIL;
 		}
-		ret = ksm_merge_hugepages_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
-				ksm_scan_limit_sec, size_MB);
+		ret = ksm_merge_hugepages_time(merge_type, ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_UNMERGE_TIME:
 		if (size_MB == 0) {
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index e62be4136f69e..751fbc52857ea 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -76,7 +76,7 @@ static void test_vma_reuse(int pagemap_fd, int pagesize)
 	munmap(map2, pagesize);
 }
 
-static void test_hugepage(int pagemap_fd, int pagesize)
+static void test_hugepage(int pagemap_fd)
 {
 	char *map;
 	int i, ret;
@@ -210,7 +210,7 @@ int main(void)
 
 	test_simple(pagemap_fd, pagesize);
 	test_vma_reuse(pagemap_fd, pagesize);
-	test_hugepage(pagemap_fd, pagesize);
+	test_hugepage(pagemap_fd);
 	test_mprotect_anon(pagemap_fd, pagesize);
 	test_mprotect_file(pagemap_fd, pagesize);
 
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index a37088a23ffef..815c22114b57e 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -416,7 +416,7 @@ static void continue_range(int ufd, __u64 start, __u64 len, bool wp)
 		    ret, (int64_t) req.mapped);
 }
 
-int uffd_read_msg(int ufd, struct uffd_msg *msg)
+int uffd_read_msg(struct uffd_msg *msg)
 {
 	int ret = read(uffd, msg, sizeof(*msg));
 
@@ -537,7 +537,7 @@ void *uffd_poll_thread(void *arg)
 		}
 		if (!(pollfd[0].revents & POLLIN))
 			err("pollfd[0].revents %d", pollfd[0].revents);
-		if (uffd_read_msg(uffd, &msg))
+		if (uffd_read_msg(&msg))
 			continue;
 		switch (msg.event) {
 		default:
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7700cbfa39756..2e7066d69103d 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -117,7 +117,7 @@ void uffd_stats_report(struct uffd_args *args, int n_cpus);
 int uffd_test_ctx_init(uint64_t features, const char **errmsg);
 void uffd_test_ctx_clear(void);
 int userfaultfd_open(uint64_t *features);
-int uffd_read_msg(int ufd, struct uffd_msg *msg);
+int uffd_read_msg(struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index c0f64df5085c4..24aac0ae96c6c 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -137,7 +137,7 @@ static void *uffd_read_thread(void *arg)
 	/* from here cancellation is ok */
 
 	for (;;) {
-		if (uffd_read_msg(uffd, &msg))
+		if (uffd_read_msg(&msg))
 			continue;
 		uffd_handle_page_fault(&msg, args);
 	}
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 50501b38e34e7..df7b82bbebaad 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -248,7 +248,7 @@ static void *fork_event_consumer(void *data)
 	ready_for_fork = true;
 
 	/* Read until a full msg received */
-	while (uffd_read_msg(args->parent_uffd, &msg));
+	while (uffd_read_msg(&msg));
 
 	if (msg.event != UFFD_EVENT_FORK)
 		err("wrong message: %u\n", msg.event);
@@ -1352,11 +1352,11 @@ static void *uffd_mmap_changing_thread(void *opaque)
 	return NULL;
 }
 
-static void uffd_consume_message(int fd)
+static void uffd_consume_message(void)
 {
 	struct uffd_msg msg = { 0 };
 
-	while (uffd_read_msg(fd, &msg));
+	while (uffd_read_msg(&msg));
 }
 
 static void uffd_mmap_changing_test(uffd_test_args_t *targs)
@@ -1407,7 +1407,7 @@ static void uffd_mmap_changing_test(uffd_test_args_t *targs)
 	 * All succeeded above!  Recycle everything.  Start by reading the
 	 * event so as to kick the thread roll again..
 	 */
-	uffd_consume_message(uffd);
+	uffd_consume_message();
 
 	ret = pthread_join(tid, NULL);
 	assert(ret == 0);
-- 
2.47.2


