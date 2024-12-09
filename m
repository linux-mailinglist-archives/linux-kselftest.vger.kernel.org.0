Return-Path: <linux-kselftest+bounces-23062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F4F9E9EB9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F50D163844
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF91990A7;
	Mon,  9 Dec 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="jU/hGAvy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26281A4F09;
	Mon,  9 Dec 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770621; cv=pass; b=W34GeqpiXSjjoRbNyVXdDpZmOv+rHRGOEV5G0ahpHOpGdUvxJO5cVpA9h/HLClPDuQS9T2D53oCdBzMPD43+aRF40OKZx/gHmdNgcyWc7w/VbjQr/9r4yJ+ufN4x5ChRk/CndtThlVEE538nrwN9Ct1+AMQMZUM0ivnpB4OOYG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770621; c=relaxed/simple;
	bh=6mdN1fbVqo2QWHmtlXQA3EN2b/wbW7NAaFcG1t76tgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c305NqJH5E6JaEchCCPm+OlbJIUAsCBPPpJnTN73lqUH3cCzglJD7K+2/gzN2F9KzU5NkYixED79uCHvCD837XWc+vhAHGAF21pGoxXH+yJwtGsKkZqXL2O1ryft1nOn1FHBTJ9MFlXTCk/KzkTmXy64edS9joDtjx0x6XYlBXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=jU/hGAvy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733770601; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J1b3J2MBW2s5pQ0sdLlOCraSJOvBRS+BSy9kqQYqjxN+1EcmZg167vj5AuBVGCPcbFQ564GuHMeZdryOYu8K4Fm+QIDerIvXarTBobsJ6O9c7XzUqjX80muDWw56L3RJK19MhjbyDDrip6ZCL1IA4UsDk5fMIreZrs0+MYOrqlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733770601; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RP+RJMd3ZtnBxFIpa2C1GgSta2qA552hwg7OkTPrM7M=; 
	b=VyH0pYocNjSUNPgcx7XMBTuiHBAL6FkyuZ13qc7m1+t4/DL5fgw+TGWlWhnLvXTysKfjSxrJYpkCJZVkd7a+mT1GyB1sM2qTeCoHqM6e7NTEqglU4ntXpLPhBpNY83g709UTPR7DvAfX5+lDm9Yu7qaatuhungnhPMBzb0AJCdw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733770601;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RP+RJMd3ZtnBxFIpa2C1GgSta2qA552hwg7OkTPrM7M=;
	b=jU/hGAvyJw7K4UuMi0PGCYaLQ+l0fjDgYZBaWrtSIITwIbuxJhjJi6IxRtZjyTdq
	Mzs3ojJ3fpUmWNUmhTo6Vq00fAB7nZrW+wSYfP1/VnqBWFsdR/QPZaM4eo6aHB2hPAG
	HbkC2jp24YrGzCI+ESxIRt27Em++BUkMKgj9Qq8E=
Received: by mx.zohomail.com with SMTPS id 1733770599930283.09919285178967;
	Mon, 9 Dec 2024 10:56:39 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 4/4] selftests/mm: mremap_test: Remove unused variable and type mismatches
Date: Mon,  9 Dec 2024 23:56:24 +0500
Message-Id: <20241209185624.2245158-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185624.2245158-1-usama.anjum@collabora.com>
References: <20241209185624.2245158-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Remove unused variable and fix type mismatches.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mremap_test.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5a3a9bcba6404..d207a52f2b5be 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -34,7 +34,7 @@ struct config {
 	unsigned long long dest_alignment;
 	unsigned long long region_size;
 	int overlapping;
-	int dest_preamble_size;
+	unsigned int dest_preamble_size;
 };
 
 struct test {
@@ -328,7 +328,7 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 {
 	char *test_name = "mremap mremap move within range";
 	void *src, *dest;
-	int i, success = 1;
+	unsigned int i, success = 1;
 
 	size_t size = SIZE_MB(20);
 	void *ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
@@ -569,7 +569,7 @@ static void mremap_move_1mb_from_start(unsigned int pattern_seed,
 {
 	char *test_name = "mremap move 1mb from start at 1MB+256KB aligned src";
 	void *src = NULL, *dest = NULL;
-	int i, success = 1;
+	unsigned int i, success = 1;
 
 	/* Config to reuse get_source_mapping() to do an aligned mmap. */
 	struct config c = {
@@ -636,7 +636,7 @@ static void mremap_move_1mb_from_start(unsigned int pattern_seed,
 
 static void run_mremap_test_case(struct test test_case, int *failures,
 				 unsigned int threshold_mb,
-				 unsigned int pattern_seed, char *rand_addr)
+				 char *rand_addr)
 {
 	long long remap_time = remap_region(test_case.config, threshold_mb,
 					    rand_addr);
@@ -708,7 +708,8 @@ static int parse_args(int argc, char **argv, unsigned int *threshold_mb,
 int main(int argc, char **argv)
 {
 	int failures = 0;
-	int i, run_perf_tests;
+	unsigned int i;
+	int run_perf_tests;
 	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
 
 	/* hard-coded test configs */
@@ -831,7 +832,7 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
 		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
-				     pattern_seed, rand_addr);
+				     rand_addr);
 
 	maps_fp = fopen("/proc/self/maps", "r");
 
@@ -853,7 +854,7 @@ int main(int argc, char **argv)
 		 "mremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:");
 		for (i = 0; i < ARRAY_SIZE(perf_test_cases); i++)
 			run_mremap_test_case(perf_test_cases[i], &failures,
-					     threshold_mb, pattern_seed,
+					     threshold_mb,
 					     rand_addr);
 	}
 
-- 
2.39.5


