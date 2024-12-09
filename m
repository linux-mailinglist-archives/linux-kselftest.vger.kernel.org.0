Return-Path: <linux-kselftest+bounces-23000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF39E8F35
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A252824A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ACC216619;
	Mon,  9 Dec 2024 09:50:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A242C21660A;
	Mon,  9 Dec 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737846; cv=none; b=prRsjcTzXA4W6xpP0TGVak6XyuDdxnOCbsqC5nmggrTaO/Sebzer7bqeeUtvaKguqLzUvOAmxh79sRrfJ5dx2yGueoD/FkDRrO4AM8n/u5n/xv4f79b1M6N6dcSjGjfVElxZUPE1X6V+H+iMxLoSdE1dpmkxzQppCuJxJMtOGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737846; c=relaxed/simple;
	bh=6PBb5x8Xqk20KMWnZkn7tQGRp5tlKGQHX4x3DnnZnKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thxSTYmiQXB1iiUM0YWfJKmnbA6jLRY3t9vz7ccqMYoVENRgnjVYJnuZeg90xUdO0d+BlgO1TXf/8SEjFd5kppMXxm7FUxa/Xcli/qZoiN5MSO43hw9XGgns5iIcI+18g3RtNbAT01JPkJgH+RZGWAmfTJ59BbA1kwLd2N2Qljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3C21113E;
	Mon,  9 Dec 2024 01:51:11 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0E13F720;
	Mon,  9 Dec 2024 01:50:41 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 02/14] selftests/mm: Fix -Wmaybe-uninitialized warnings
Date: Mon,  9 Dec 2024 09:50:07 +0000
Message-ID: <20241209095019.1732120-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-1-kevin.brodsky@arm.com>
References: <20241209095019.1732120-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few -Wmaybe-uninitialized warnings show up when building the mm
tests with -O2. None of them looks worrying; silence them by
initialising the problematic variables.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/ksm_tests.c       | 2 +-
 tools/testing/selftests/mm/mremap_test.c     | 2 +-
 tools/testing/selftests/mm/soft-dirty.c      | 2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index b748c48908d9..dcdd5bb20f3d 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -776,7 +776,7 @@ static int ksm_cow_time(int merge_type, int mapping, int prot, int timeout, size
 
 int main(int argc, char *argv[])
 {
-	int ret, opt;
+	int ret = 0, opt;
 	int prot = 0;
 	int ksm_scan_limit_sec = KSM_SCAN_LIMIT_SEC_DEFAULT;
 	int merge_type = KSM_MERGE_TYPE_DEFAULT;
diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5a3a9bcba640..056b227f4a30 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -384,7 +384,7 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
 {
-	void *addr, *src_addr, *dest_addr, *dest_preamble_addr;
+	void *addr, *src_addr, *dest_addr, *dest_preamble_addr = NULL;
 	unsigned long long t, d;
 	struct timespec t_start = {0, 0}, t_end = {0, 0};
 	long long  start_ns, end_ns, align_mask, ret, offset;
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index bdfa5d085f00..8e1462ce0532 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -128,7 +128,7 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
 {
 	const char *type[] = {"file", "anon"};
 	const char *fname = "./soft-dirty-test-file";
-	int test_fd;
+	int test_fd = 0;
 	char *map;
 
 	if (anon) {
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 74c884713bf7..9ff71fa1f9bf 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1122,7 +1122,7 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 	char c;
 	unsigned long long count;
 	struct uffd_args args = { 0 };
-	char *orig_area_src, *orig_area_dst;
+	char *orig_area_src = NULL, *orig_area_dst = NULL;
 	unsigned long step_size, step_count;
 	unsigned long src_offs = 0;
 	unsigned long dst_offs = 0;
-- 
2.47.0


