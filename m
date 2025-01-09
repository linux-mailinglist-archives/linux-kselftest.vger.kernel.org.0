Return-Path: <linux-kselftest+bounces-24138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF2A07EE4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1C83A6975
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D607191484;
	Thu,  9 Jan 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="gl1Q3WgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02218DF73;
	Thu,  9 Jan 2025 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444352; cv=pass; b=c72+Cn41N8f9uybbKJvWH3E0KEz9Kjk/OfGh5bbzC+ElLEibiRZiv1VVSPzgpYrBzOReCvknZmwfTvLhhUfast9Vxildf2SJPPNx9qZsWfG1zez7TbE2t9AJRyv7BHz1bzHj3oKkZ37Kl5RC6gRhnCtAI75RAfnDWOsri3HN1iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444352; c=relaxed/simple;
	bh=bFLV6Ot3C3ebwBtAJz3dRZHLj/g5QE8DOuamij2Ywe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRYO8MSwVfazLg33YQgBeXyQF1vJ2A4PfZGS+B4MYCkrF9nuoHCBLSatLbKLOXMafb/RS3BYGAPiOc7Fcvc4V33eYw00QLoY8r4hArBqDwzpimhJaAIUU8S5suWAWEHpLdek8nnEuUU2KyyyQr2UEVxWHg4jvLXgcWp6oy8NYX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=gl1Q3WgO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444333; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=apwhxndeqDHgaqQNLHJKVCQ+hxYR+oI6HYu05Pigyw566JaI7zAYmypd6lIL+zDGvg9tPrhxR8FDXx3tauPDnt9Piu0+TL4vM4zXM6uZr1JQjHEKtCy0F5SkT9QgL6Vqoc5wdQc82uPhA9kNCl1v965T+bwn+iELGYc1MiSx8Xs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444333; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JeU06unvxMwqmD+RVXrBS+6nxgmgOdhK5Xdrp6nR3mU=; 
	b=IsCUZ8XTcOqw4KrCcDJZgc0MWXtgHxSkxUo3c/ko1ameuAqSr9QSe3t4aPn/nzrJOMUVa5WlHxsJR9MHrUX5QFp47p7F+qSRKAZY73M93/pJtV4zjlJjbJ9ch1YfRl97iV/JuPLaa0ggT3QPMOvd5AU5gFE+OItsYgWY0uget3o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444333;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=JeU06unvxMwqmD+RVXrBS+6nxgmgOdhK5Xdrp6nR3mU=;
	b=gl1Q3WgOuNZzLoBblXAbbFsZoNjLVNka14ePbrpJXrwL1v5frHyboOAJv6BPNt5C
	FHIh0oFDBvaBnXnIV50BZvEwb16zyISMYJHYson+jnsjxwq9IR+bRpyST3PHAsvIo8x
	Lg1gjw2FDFC5SiY+FhBqIyClXOSl3r4/6VDl2DdA=
Received: by mx.zohomail.com with SMTPS id 1736444332163303.84388479702955;
	Thu, 9 Jan 2025 09:38:52 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 01/16] selftests/mm: remove argc and argv unused parameters
Date: Thu,  9 Jan 2025 22:38:27 +0500
Message-Id: <20250109173842.1142376-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Remove the following warnings by removing unused argc and argv
parameters:
In function ‘main’:
  warning: unused parameter ‘argc’ [-Wunused-parameter]
    158 | int main(int argc, char *argv[])
        |          ~~~~^~~~
  warning: unused parameter ‘argv’ [-Wunused-parameter]
    158 | int main(int argc, char *argv[])
        |                    ~~~~~~^~~~~~

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
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
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 2c3a0eb6b22d3..8d23b698ce9db 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -194,7 +194,7 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
 	return ret;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	struct rlimit lim;
 	struct map_list *list = NULL, *entry;
diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 1238e1c5aae15..ea00c85c76caa 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1769,7 +1769,7 @@ static int tests_per_non_anon_test_case(void)
 	return tests;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int err;
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
index 9423ad439a614..03a31dcb57577 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -444,7 +444,7 @@ static int tests_per_test_case(void)
 	return 3 + nr_hugetlbsizes;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int i, err;
 
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
index e74107185324f..43f16c12c8e9a 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -58,7 +58,7 @@ void read_fault_pages(void *addr, unsigned long nr_pages)
 	}
 }
 
-int main(int argc, char **argv)
+int main(int __attribute__((unused)) argc, char **argv)
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
index ef7d911da13e0..c6a3ee56a54a9 100644
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
index 5c8a53869b1bd..0dd849b4affa6 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -74,7 +74,7 @@ static int child_f(int sock, unsigned long *smap, int fd)
 	return ksft_cnt.ksft_pass;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int sock[2], child, ret;
 	FILE *ftmp;
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 74c911aa3aea9..b9659fa357371 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -297,7 +297,7 @@ static void prepare(void)
 
 #define NUM_TESTS 6
 
-int main(int argc, char *argv[])
+int main(void)
 {
 	int fd;
 
diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index 1cd80b0f76c33..0d95d630d0450 100644
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
index 7f0d50fa361dc..358711e8191f7 100644
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
index 1ac8c88098807..249989f8b7a2a 100644
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
index 8e1462ce05326..7286c90fff1a3 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -187,7 +187,7 @@ static void test_mprotect_file(int pagemap_fd, int pagesize)
 	test_mprotect(pagemap_fd, pagesize, false);
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	int pagemap_fd;
 	int pagesize;
diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 2c4f984bd73ca..f548b1e1f197c 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -331,7 +331,7 @@ static const struct testcase testcases[] = {
 	},
 };
 
-int main(int argc, char **argv)
+int main(void)
 {
 	struct thp_settings settings;
 	int i, j, plan = 0;
diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 4042fd878acd7..7993583450766 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -158,7 +158,7 @@ static int validate_complete_va_space(void)
 	return 0;
 }
 
-int main(int argc, char *argv[])
+int main(void)
 {
 	char *ptr[NR_CHUNKS_LOW];
 	char **hptr;
-- 
2.39.5


