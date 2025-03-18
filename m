Return-Path: <linux-kselftest+bounces-29376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA63A67B39
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEE33A8D0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D49211A11;
	Tue, 18 Mar 2025 17:43:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659E2211711
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319839; cv=none; b=g+uYh0eCMxId2sWONKJmAhI9EFClazJp0qIZ1sQsj7o0p1sK6NVg3a4rKXgaD6BpNDgBIymDOWcX+u0mTZMfZS8OBneNiFUu1zuXb5MOwV1YQ0wneGtHV7r8IkUfTZZ6VCllRDKg8lOzXNd9Nkqusg3LzN5xlq7g1vycKWinS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319839; c=relaxed/simple;
	bh=toDgPx2SC6G+ZUON7pSGCU1sqABTKdjGpQi5Z1JvH+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga6CHd0FwN0OBuF06o2QpFCF8sWZuLK+N4VbKxGYqEhdEvlwzwvvugnb9c/uO1ruoFSAITPiEMVKcSRbAKZfMzRSTzQNTX+RSOCNTbBOXqwuudBMqABxhK0lePVkR29DpbGmER5V4NFpusMZ7Qeq1Hm43YVPsu1aC7dFnMiBj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B5C71516;
	Tue, 18 Mar 2025 10:44:05 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAC283F673;
	Tue, 18 Mar 2025 10:43:55 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 2/3] selftests/mm: uffd-unit-tests support for hugepages > 2M
Date: Tue, 18 Mar 2025 17:43:40 +0000
Message-ID: <20250318174343.243631-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318174343.243631-1-ryan.roberts@arm.com>
References: <20250318174343.243631-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uffd-unit-tests uses a memory area with a fixed 32M size. Then it
calculates the number of pages by dividing by page_size, which itself is
either the base page size or the PMD huge page size depending on the
test config. For the latter, we end up with nr_pages=1 for arm64 16K
base pages, and nr_pages=0 for 64K base pages. This doesn't end well.

So let's make the 32M size a floor and also ensure that we have at least
2 pages given the PMD size. With this change, the tests pass on arm64
64K base page size configuration.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 74c8bc02b506..6973e57b227a 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -26,6 +26,8 @@
 #define ALIGN_UP(x, align_to) \
 	((__typeof__(x))((((unsigned long)(x)) + ((align_to)-1)) & ~((align_to)-1)))
 
+#define MAX(a, b) (((a) > (b)) ? (a) : (b))
+
 struct mem_type {
 	const char *name;
 	unsigned int mem_flag;
@@ -196,7 +198,8 @@ uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
 	else
 		page_size = psize();
 
-	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
+	/* Ensure we have at least 2 pages */
+	nr_pages = MAX(UFFD_TEST_MEM_SIZE, page_size * 2) / page_size;
 	/* TODO: remove this global var.. it's so ugly */
 	nr_cpus = 1;
 
-- 
2.43.0


