Return-Path: <linux-kselftest+bounces-24145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F00A07EFB
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9BC188D1B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A961B0412;
	Thu,  9 Jan 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="A35ZxRJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE771AF4EF;
	Thu,  9 Jan 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444385; cv=pass; b=vBSEB/t7+sThpZVAlXUuyAM9igiYrZDc6fmI2MHcgQk0XFmjbs1CC0P0fP0EcmTQoch+G50IgfkPz5UAbvtAEho9Esz/xtTU52xZNy4CrvpQudhyGnDXJ+veJPOQV35sgFyAuGgJ5Yc4/uZgx5hvoPOuh9KOowj+p6HWGdOul8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444385; c=relaxed/simple;
	bh=ocYABR+J/Nnl5HTuNTMR3+D0IlJO0HuAcPjpuCnGo/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kh+xyJa+ilHcqzCirbh1LIwzuYqbw2DHNqZ65e/qnzGWXlgTZlulUsaSaYvAq9gNHZ7WMZtwGMb/6ddV/f5O8SC1nVLKJ5+IQqv3J88LhmDMpXRFXGrY0IQCgBkcyC6YZO3ttJTz0Vq0920s8iYGYtx+yhLX6FTHcy9ymMkwemo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=A35ZxRJp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444359; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V6WhZ1235fCUlH1yWZPtPmxICpHAgv0DtL9N4Ez7GYG6urRZm4P28QEEcjtPEYWzuEcsam2faHAUPU4g+LOFxwxeYxJUzlyXcAg9WTRAkRET6MVprE9zdWDOzO7a+VurEWDt4UpPT6TBq+/wrDArsE06fCDPgYot9Z+Uehf4vQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444359; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uB7d7cJEDiC0mfsDNRFgeWBfbQ3rX6PW8t4akxqZYn4=; 
	b=E70OIudC6kPSaCUlYutnjGL8ZEm7oesyAoO6JNDdSACc5o5edMZ3R/Hbf9MFfX/d/mT2QEyR5nbEurCqggF/Ol+jQpSfOrJUc9vUMR2tHJwplL3fX4gVthuKcivXhI86JLR7abPL66SYqeaBx3zdrySpY9NiCkRO3KoWVSWrU4A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444359;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=uB7d7cJEDiC0mfsDNRFgeWBfbQ3rX6PW8t4akxqZYn4=;
	b=A35ZxRJpXC6uwKe+6hO0cF93zmH6F9UdJSZOA1d+7FC3QYhIUdIqDJdqBltvMeNV
	zlIGgSewv1HMOBh028S/kxWO71x51jpEOaAqdtQcyEt917zjUS4wZXwDzZo/5VlwkWe
	h6hgs+dJoPT1oEAxrw8Bz/9vZX/jLh6gUogubzeA=
Received: by mx.zohomail.com with SMTPS id 1736444357047582.4071763448949;
	Thu, 9 Jan 2025 09:39:17 -0800 (PST)
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
Subject: [PATCH 06/16] selftests/mm: cow: remove unused variables and fix type mismatch errors
Date: Thu,  9 Jan 2025 22:38:32 +0500
Message-Id: <20250109173842.1142376-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix following warnings:
- Remove unused variables
- Use __attribute__(unused) with unused variables which aren't being
  used and cannot be removed because of function pointer declaration
- Fix type mismatches

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/cow.c | 46 +++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index ea00c85c76caa..e37eb863e66cd 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -84,7 +84,7 @@ static void detect_huge_zeropage(void)
 		return;
 
 	ret = pread(fd, buf, sizeof(buf), 0);
-	if (ret > 0 && ret < sizeof(buf)) {
+	if (ret > 0 && (unsigned int)ret < sizeof(buf)) {
 		buf[ret] = 0;
 
 		enabled = strtoul(buf, NULL, 10);
@@ -263,12 +263,14 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
 	close_comm_pipes(&comm_pipes);
 }
 
-static void test_cow_in_parent(char *mem, size_t size, bool is_hugetlb)
+static void test_cow_in_parent(char *mem, size_t size,
+			       bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_cow_in_parent(mem, size, false, child_memcmp_fn, false);
 }
 
-static void test_cow_in_parent_mprotect(char *mem, size_t size, bool is_hugetlb)
+static void test_cow_in_parent_mprotect(char *mem, size_t size,
+					bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_cow_in_parent(mem, size, true, child_memcmp_fn, false);
 }
@@ -408,10 +410,11 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 	struct io_uring_cqe *cqe;
 	struct io_uring_sqe *sqe;
 	struct io_uring ring;
-	ssize_t cur, total;
 	struct iovec iov;
 	char *buf, *tmp;
+	size_t total;
 	int ret, fd;
+	ssize_t cur;
 	FILE *file;
 
 	ret = setup_comm_pipes(&comm_pipes);
@@ -515,7 +518,7 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 		goto quit_child;
 	}
 
-	if (cqe->res != size) {
+	if ((unsigned int) cqe->res != size) {
 		ksft_test_result_fail("write_fixed failed\n");
 		goto quit_child;
 	}
@@ -529,7 +532,7 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 			ksft_test_result_fail("pread() failed\n");
 			goto quit_child;
 		}
-		total += cur;
+		total += (size_t)cur;
 	}
 
 	/* Finally, check if we read what we expected. */
@@ -553,12 +556,14 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 	close_comm_pipes(&comm_pipes);
 }
 
-static void test_iouring_ro(char *mem, size_t size, bool is_hugetlb)
+static void test_iouring_ro(char *mem, size_t size,
+			    bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_iouring(mem, size, false);
 }
 
-static void test_iouring_fork(char *mem, size_t size, bool is_hugetlb)
+static void test_iouring_fork(char *mem, size_t size,
+			      bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_iouring(mem, size, true);
 }
@@ -702,36 +707,38 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	free(tmp);
 }
 
-static void test_ro_pin_on_shared(char *mem, size_t size, bool is_hugetlb)
+static void test_ro_pin_on_shared(char *mem, size_t size,
+				  bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_SHARED, false);
 }
 
-static void test_ro_fast_pin_on_shared(char *mem, size_t size, bool is_hugetlb)
+static void test_ro_fast_pin_on_shared(char *mem, size_t size,
+				       bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_SHARED, true);
 }
 
 static void test_ro_pin_on_ro_previously_shared(char *mem, size_t size,
-		bool is_hugetlb)
+						bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_PREVIOUSLY_SHARED, false);
 }
 
 static void test_ro_fast_pin_on_ro_previously_shared(char *mem, size_t size,
-		bool is_hugetlb)
+						     bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_PREVIOUSLY_SHARED, true);
 }
 
 static void test_ro_pin_on_ro_exclusive(char *mem, size_t size,
-		bool is_hugetlb)
+					bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_RO_EXCLUSIVE, false);
 }
 
 static void test_ro_fast_pin_on_ro_exclusive(char *mem, size_t size,
-		bool is_hugetlb)
+					     bool __attribute__((unused)) is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_RO_EXCLUSIVE, true);
 }
@@ -1192,7 +1199,7 @@ static void run_anon_test_case(struct test_case const *test_case)
 
 static void run_anon_test_cases(void)
 {
-	int i;
+	unsigned int i;
 
 	ksft_print_msg("[INFO] Anonymous memory tests in private mappings\n");
 
@@ -1420,7 +1427,7 @@ static const struct test_case anon_thp_test_cases[] = {
 
 static void run_anon_thp_test_cases(void)
 {
-	int i;
+	unsigned int i;
 
 	if (!pmdsize)
 		return;
@@ -1457,13 +1464,14 @@ static void test_cow(char *mem, const char *smem, size_t size)
 			 "Other mapping not modified\n");
 	free(old);
 }
+//typedef void (*non_anon_test_fn)(char *mem, const char *smem, size_t size);
 
-static void test_ro_pin(char *mem, const char *smem, size_t size)
+static void test_ro_pin(char *mem, const char __attribute__((unused)) *smem, size_t size)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST, false);
 }
 
-static void test_ro_fast_pin(char *mem, const char *smem, size_t size)
+static void test_ro_fast_pin(char *mem, const char __attribute__((unused)) *smem, size_t size)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST, true);
 }
@@ -1752,7 +1760,7 @@ static void run_non_anon_test_case(struct non_anon_test_case const *test_case)
 
 static void run_non_anon_test_cases(void)
 {
-	int i;
+	unsigned int i;
 
 	ksft_print_msg("[RUN] Non-anonymous memory tests in private mappings\n");
 
-- 
2.39.5


