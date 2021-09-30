Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BDD41E351
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 23:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349820AbhI3VZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349843AbhI3VZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 17:25:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F992C06176E
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 14:23:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso10593991ybj.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UjO0qfZl4lNdUd4h5vIafSHB+z3WAy5EBdv+I+4Y+ZY=;
        b=NwuarFTQoOfHoDeTi+T72vz5pPPePDKc9XoOvHlF3UtqrcWcq/q4zZpM9lyS9Dlvzs
         TDWAzKLsIqRyzDiC80gjehJ1c3jkH0Rp/76tPNGNrRsROUR6aItI+jWag7kVz2hf8lXM
         89gjvFOzpkmUhKvmIGNiD2lX1alvv/LXDEXmnfI6zmACXz8tr6d5xocMf6/fg+7IZUI6
         YJynVNW1ymb1mMfmCCim0mtKOP13wyRX1K+fJGasZWuTRBl86+XRyoqzjbaxOw6/W4ZA
         LpsFDih4sVtkpTTF7XcBvYGehyRz6yQI2ZdZw9TzhNXiofpVcpK/m/7kKXKkDHk0je3N
         MYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UjO0qfZl4lNdUd4h5vIafSHB+z3WAy5EBdv+I+4Y+ZY=;
        b=QgmJJPL06kMrnE80oL1LE/lmMKpFT1NgujUP7a803/Yp7mWH4bkq284W8BPRsXHKDs
         L2jCr3YqGXMO6cQPb7tFFwokXjFY5k5O6GitxylD9t1OaEr8acAVVTozSARtW6bmQ2li
         relwMT054Of3BsCa8xEwHh8xoBuVINMkR5Q5EHf/HWVqwLwcceD+FF6cNcMCyi60uFeA
         CvCauzICH5UKc3m+dikUFWGYTVWcTYSp+3VVC7Lcn6mwEz4vK0FUNK9NGMA3xyZMXK9Q
         dUgzizSX5U3/plnFMU+a04G9mwKccKUsOQHpUlgUomVif2ny+Ve8aURd5+37AsIWHrW1
         pJlg==
X-Gm-Message-State: AOAM5308KBVyK1yS8svrPyzGjjZXVssPplI5OsYAcTSK8g+hKMkkmyZ/
        AXDPEMrPP3ctpxMbpxKmnropHx/lwUxuUQhlWvHW
X-Google-Smtp-Source: ABdhPJwUW2K57dvjts7mcKwjlfEPksJiGD50c7w8aBNiDKCiLJOXQKw/OsBEXOhZjEve/HLM7Ff5UwDrF+MYno8HeNIG
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:fa06:3b29:d3c:37e6])
 (user=axelrasmussen job=sendgmr) by 2002:a25:47d6:: with SMTP id
 u205mr766836yba.193.1633037003842; Thu, 30 Sep 2021 14:23:23 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:23:09 -0700
In-Reply-To: <20210930212309.4001967-1-axelrasmussen@google.com>
Message-Id: <20210930212309.4001967-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210930212309.4001967-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 3/3] userfaultfd/selftests: fix calculation of expected ioctls
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Today, we assert that the ioctls the kernel reports as supported for a
registration match a precomputed list. We decide which ioctls are
supported by examining the memory type. Then, in several locations we
"fix up" this list by adding or removing things this initial decision
got wrong.

What ioctls the kernel reports is actually a function of several things:
- The memory type
- Kernel feature support (e.g., no writeprotect on aarch64)
- The registration type (e.g., CONTINUE only supported for MINOR mode)

So, we can't fully compute this at the start, in set_test_type. It
varies per test, depending on what registration mode(s) those tests use.

Instead, introduce a new function which computes the correct list. This
centralizes the add/remove of ioctls depending on these function inputs
in one place, so we don't have to repeat ourselves in various tests.

Not only is the resulting code a bit shorter, but it fixes a real bug in
the existing code: previously, we would incorrectly require the
writeprotect ioctl to be present on aarch64, where it isn't actually
supported.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 77 ++++++++++++------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 00d1b7555865..2348b6371ec8 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -308,37 +308,24 @@ static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 }
 
 struct uffd_test_ops {
-	unsigned long expected_ioctls;
 	void (*allocate_area)(void **alloc_area);
 	void (*release_pages)(char *rel_area);
 	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
 };
 
-#define SHMEM_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
-					 (1 << _UFFDIO_COPY) | \
-					 (1 << _UFFDIO_ZEROPAGE))
-
-#define ANON_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
-					 (1 << _UFFDIO_COPY) | \
-					 (1 << _UFFDIO_ZEROPAGE) | \
-					 (1 << _UFFDIO_WRITEPROTECT))
-
 static struct uffd_test_ops anon_uffd_test_ops = {
-	.expected_ioctls = ANON_EXPECTED_IOCTLS,
 	.allocate_area	= anon_allocate_area,
 	.release_pages	= anon_release_pages,
 	.alias_mapping = noop_alias_mapping,
 };
 
 static struct uffd_test_ops shmem_uffd_test_ops = {
-	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
 	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-	.expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC & ~(1 << _UFFDIO_CONTINUE),
 	.allocate_area	= hugetlb_allocate_area,
 	.release_pages	= hugetlb_release_pages,
 	.alias_mapping = hugetlb_alias_mapping,
@@ -356,6 +343,33 @@ static inline uint64_t uffd_minor_feature(void)
 		return 0;
 }
 
+static uint64_t get_expected_ioctls(uint64_t mode)
+{
+	uint64_t ioctls = UFFD_API_RANGE_IOCTLS;
+
+	if (test_type == TEST_HUGETLB)
+		ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
+
+	if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
+		ioctls &= ~(1 << _UFFDIO_WRITEPROTECT);
+
+	if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && test_uffdio_minor))
+		ioctls &= ~(1 << _UFFDIO_CONTINUE);
+
+	return ioctls;
+}
+
+static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
+{
+	uint64_t expected = get_expected_ioctls(mode);
+	uint64_t actual = ioctls & expected;
+
+	if (actual != expected) {
+		err("missing ioctl(s): expected %"PRIx64" actual: %"PRIx64,
+		    expected, actual);
+	}
+}
+
 static void userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
@@ -1000,11 +1014,9 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 {
 	struct uffdio_zeropage uffdio_zeropage;
 	int ret;
-	unsigned long has_zeropage;
+	bool has_zeropage = get_expected_ioctls(0) & (1 << _UFFDIO_ZEROPAGE);
 	__s64 res;
 
-	has_zeropage = uffd_test_ops->expected_ioctls & (1 << _UFFDIO_ZEROPAGE);
-
 	if (offset >= nr_pages * page_size)
 		err("unexpected offset %lu", offset);
 	uffdio_zeropage.range.start = (unsigned long) area_dst + offset;
@@ -1044,7 +1056,6 @@ static int uffdio_zeropage(int ufd, unsigned long offset)
 static int userfaultfd_zeropage_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
@@ -1059,9 +1070,8 @@ static int userfaultfd_zeropage_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
-		err("unexpected missing ioctl for anon memory");
+	assert_expected_ioctls_present(
+		uffdio_register.mode, uffdio_register.ioctls);
 
 	if (uffdio_zeropage(uffd, 0))
 		if (my_bcmp(area_dst, zeropage, page_size))
@@ -1074,7 +1084,6 @@ static int userfaultfd_zeropage_test(void)
 static int userfaultfd_events_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	pthread_t uffd_mon;
 	int err, features;
 	pid_t pid;
@@ -1098,9 +1107,8 @@ static int userfaultfd_events_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
-		err("unexpected missing ioctl for anon memory");
+	assert_expected_ioctls_present(
+		uffdio_register.mode, uffdio_register.ioctls);
 
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
 		err("uffd_poll_thread create");
@@ -1128,7 +1136,6 @@ static int userfaultfd_events_test(void)
 static int userfaultfd_sig_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	unsigned long userfaults;
 	pthread_t uffd_mon;
 	int err, features;
@@ -1152,9 +1159,8 @@ static int userfaultfd_sig_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
-		err("unexpected missing ioctl for anon memory");
+	assert_expected_ioctls_present(
+		uffdio_register.mode, uffdio_register.ioctls);
 
 	if (faulting_process(1))
 		err("faulting process failed");
@@ -1189,7 +1195,6 @@ static int userfaultfd_sig_test(void)
 static int userfaultfd_minor_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	unsigned long p;
 	pthread_t uffd_mon;
 	uint8_t expected_byte;
@@ -1211,10 +1216,8 @@ static int userfaultfd_minor_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	expected_ioctls |= 1 << _UFFDIO_CONTINUE;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
-		err("unexpected missing ioctl(s)");
+	assert_expected_ioctls_present(
+		uffdio_register.mode, uffdio_register.ioctls);
 
 	/*
 	 * After registering with UFFD, populate the non-UFFD-registered side of
@@ -1411,8 +1414,6 @@ static int userfaultfd_stress(void)
 	pthread_attr_setstacksize(&attr, 16*1024*1024);
 
 	while (bounces--) {
-		unsigned long expected_ioctls;
-
 		printf("bounces: %d, mode:", bounces);
 		if (bounces & BOUNCE_RANDOM)
 			printf(" rnd");
@@ -1440,10 +1441,8 @@ static int userfaultfd_stress(void)
 			uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 			err("register failure");
-		expected_ioctls = uffd_test_ops->expected_ioctls;
-		if ((uffdio_register.ioctls & expected_ioctls) !=
-		    expected_ioctls)
-			err("unexpected missing ioctl for anon memory");
+		assert_expected_ioctls_present(
+			uffdio_register.mode, uffdio_register.ioctls);
 
 		if (area_dst_alias) {
 			uffdio_register.range.start = (unsigned long)
-- 
2.33.0.800.g4c38ced690-goog

