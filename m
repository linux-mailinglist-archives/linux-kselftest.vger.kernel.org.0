Return-Path: <linux-kselftest+bounces-39665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34DB311BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8183B82E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7F2EBB8A;
	Fri, 22 Aug 2025 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DkTLpSzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2E2EB5D5;
	Fri, 22 Aug 2025 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851004; cv=none; b=uJm5jt6rLVitsZkcYZmlvgNOWw+JWPfBd3QLIUgEe4UcRSQ3M6Db4pHiTGl/yF5bh7qZImZvyKWqW0B2Esv+2oLWlj23tMO/qpuVRnt/BPD4MgbdjNoXC5GuRX9LnjK67Eyck14Uux37ofXGyzfWzfd1bVDxbUTM2oGJfH6dgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851004; c=relaxed/simple;
	bh=KQdiZO4FyGvblVEK3SnkOMPcVQUoiPVYyqSszChuvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTUoYiTPhqph4u3kEo/P/bGo6WKoFF9ws6E07r0PfXutGDjRsg+CbRBRP3MUpjamokr/bhGavnhLJJtq+OCGMfa8fJzpjpBKVap1mA0SagClnnMpNQEUoAesEq8eGQUmPAHN03B41nt1bqqlN9im1PH3kzWyh/T5yx7LLCnzKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DkTLpSzu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755851000;
	bh=KQdiZO4FyGvblVEK3SnkOMPcVQUoiPVYyqSszChuvy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkTLpSzuLL+dJf2yVpqCArLo5Cm4ZfrywTuggIKU1BeBsqWrRQvrCrEn8MsWbEI2h
	 XCQPePV+4S9R08AtO2/AiKuPUe0IZ0+7lMhYzdFywKMc1tz98PNCJGUcCS5djqcvop
	 XC7ccTgtNhk1nvMZ9WmkqXXqItKDAOdsCxDctd745yawh22fJ6SeZDKMX9A5mUU0Gn
	 vJPWQlyG5XCX2ktjua5JbguvmLjeEDWVdfEKi/8N2OKjYJRuSRVfkHlGuQwh4yvJ6x
	 HRA7XqM9vuRhRvigU1EHTVWWKBc39U/vxB6f596TpKLbILfkTYy0tWPnMZ4Cmy7/aR
	 Cbm0L6FUA4jtQ==
Received: from mt.tail9873f4.ts.net (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F6AD17E0458;
	Fri, 22 Aug 2025 10:23:15 +0200 (CEST)
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
Subject: [PATCH v3 4/8] selftests/mm: Add -Wunused family of flags
Date: Fri, 22 Aug 2025 13:21:01 +0500
Message-ID: <20250822082145.4145617-5-usama.anjum@collabora.com>
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

Add -Wunused flags and fix all the warnings coming because of
argc and argv. Remove them if they aren't being used entirely. Use
unused compiler attribute with argc where argv is being used.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v2:
- Remove -Wunused-parameter
- Remove -Wunused-function -Wunused-label -Wunused-variable
  -Wunused-value as -Wunused mean all of these by default
---
 tools/testing/selftests/mm/Makefile                | 3 +--
 tools/testing/selftests/mm/compaction_test.c       | 2 +-
 tools/testing/selftests/mm/cow.c                   | 2 +-
 tools/testing/selftests/mm/droppable.c             | 2 +-
 tools/testing/selftests/mm/gup_longterm.c          | 2 +-
 tools/testing/selftests/mm/hugepage-vmemmap.c      | 2 +-
 tools/testing/selftests/mm/hugetlb-madvise.c       | 2 +-
 tools/testing/selftests/mm/hugetlb-soft-offline.c  | 2 +-
 tools/testing/selftests/mm/madv_populate.c         | 2 +-
 tools/testing/selftests/mm/map_populate.c          | 2 +-
 tools/testing/selftests/mm/memfd_secret.c          | 2 +-
 tools/testing/selftests/mm/mlock-random-test.c     | 2 +-
 tools/testing/selftests/mm/mlock2-tests.c          | 2 +-
 tools/testing/selftests/mm/on-fault-limit.c        | 2 +-
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
 tools/testing/selftests/mm/soft-dirty.c            | 2 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c        | 2 +-
 tools/testing/selftests/mm/virtual_address_range.c | 2 +-
 18 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 23d4bf6215465..aa98a9820d0aa 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -20,7 +20,6 @@ endif
 # thus tricking Make (and you!) into believing that All Is Well, in subsequent
 # make invocations:
 .DELETE_ON_ERROR:
-
 # Avoid accidental wrong builds, due to built-in rules working just a little
 # bit too well--but not quite as well as required for our situation here.
 #
@@ -34,7 +33,7 @@ endif
 MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
-CFLAGS += -Wunreachable-code
+CFLAGS += -Wunreachable-code -Wunused
 LDLIBS = -lrt -lpthread -lm
 
 # Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 9bc4591c7b169..4fa03679e9b07 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -203,7 +203,7 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
 	return ret;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	struct rlimit lim;
 	struct map_list *list = NULL, *entry;
diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index c744c603d688e..681f6e3752a26 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1857,7 +1857,7 @@ static int tests_per_non_anon_test_case(void)
 	return tests;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	struct thp_settings default_settings;
 
diff --git a/tools/testing/selftests/mm/droppable.c b/tools/testing/selftests/mm/droppable.c
index f3d9ecf96890a..90ea6377810c5 100644
--- a/tools/testing/selftests/mm/droppable.c
+++ b/tools/testing/selftests/mm/droppable.c
@@ -15,7 +15,7 @@
 
 #include "../kselftest.h"
 
-int main(int argc, char *argv[])
+int main(void)
 {
 	size_t alloc_size = 134217728;
 	size_t page_size = getpagesize();
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 268dadb8ce438..7fe4f94400cb6 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -504,7 +504,7 @@ static int tests_per_test_case(void)
 	return 3 + nr_hugetlbsizes;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int i;
 
diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
index df366a4d1b92d..23e97e552057d 100644
--- a/tools/testing/selftests/mm/hugepage-vmemmap.c
+++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
@@ -87,7 +87,7 @@ static int check_page_flags(unsigned long pfn)
 	return 0;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	void *addr;
 	unsigned long pfn;
diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index c5940c0595be8..26fc97366c659 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -57,7 +57,7 @@ void read_fault_pages(void *addr, unsigned long nr_pages)
 	}
 }
 
-int main(int argc, char **argv)
+int main(int __always_unused argc, char **argv)
 {
 	unsigned long free_hugepages;
 	void *addr, *addr2;
diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
index f086f0e04756f..cb087303f5ed3 100644
--- a/tools/testing/selftests/mm/hugetlb-soft-offline.c
+++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
@@ -216,7 +216,7 @@ static void test_soft_offline_common(int enable_soft_offline)
 			 enable_soft_offline);
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	ksft_print_header();
 	ksft_set_plan(2);
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index b6fabd5c27ed6..178e0ae0cd4a1 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -281,7 +281,7 @@ static int system_has_softdirty(void)
 #endif
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int nr_tests = 16;
 	int err;
diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 9df2636c829bf..2b240499f15c9 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -76,7 +76,7 @@ static int child_f(int sock, unsigned long *smap, int fd)
 	return ksft_cnt.ksft_pass;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int sock[2], child, ret;
 	FILE *ftmp;
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 9a0597310a765..836383f63b630 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -299,7 +299,7 @@ static void prepare(void)
 
 #define NUM_TESTS 6
 
-int main(int argc, char *argv[])
+int main(void)
 {
 	int fd;
 
diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index b8d7e966f44c6..4ff7a4cfc7331 100644
--- a/tools/testing/selftests/mm/mlock-random-test.c
+++ b/tools/testing/selftests/mm/mlock-random-test.c
@@ -236,7 +236,7 @@ static void test_mlock_outof_limit(char *p, int alloc_size)
 	ksft_test_result_pass("%s\n", __func__);
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	char *p = NULL;
 
diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 3e90ff37e336a..ce5fd5ce1f51f 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -425,7 +425,7 @@ static void test_mlockall(void)
 	munlockall();
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int ret, size = 3 * getpagesize();
 	void *map;
diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
index 431c1277d83a1..ade160966c926 100644
--- a/tools/testing/selftests/mm/on-fault-limit.c
+++ b/tools/testing/selftests/mm/on-fault-limit.c
@@ -28,7 +28,7 @@ static void test_limit(void)
 	munlockall();
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	ksft_print_header();
 	ksft_set_plan(1);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index 302fef54049c8..eb4ef8532c0bf 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -528,7 +528,7 @@ static void (*pkey_tests[])(void) = {
 	test_pkru_sigreturn
 };
 
-int main(int argc, char *argv[])
+int main(void)
 {
 	int i;
 
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 8a3f2b4b21869..e62be4136f69e 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -194,7 +194,7 @@ static void test_mprotect_file(int pagemap_fd, int pagesize)
 	test_mprotect(pagemap_fd, pagesize, false);
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int pagemap_fd;
 	int pagesize;
diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index c2ba7d46c7b45..13ceb56289701 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -334,7 +334,7 @@ static const struct testcase testcases[] = {
 	},
 };
 
-int main(int argc, char **argv)
+int main(void)
 {
 	struct thp_settings settings;
 	int i, j, plan = 0;
diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 169dbd692bf5f..3c21d136962cb 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -189,7 +189,7 @@ static int validate_complete_va_space(void)
 	return 0;
 }
 
-int main(int argc, char *argv[])
+int main(void)
 {
 	char *ptr[NR_CHUNKS_LOW];
 	char **hptr;
-- 
2.47.2


