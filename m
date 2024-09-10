Return-Path: <linux-kselftest+bounces-17684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E873E9746C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC96288A02
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE4B1BDAB7;
	Tue, 10 Sep 2024 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZe6vWTE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7D1BF330
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011910; cv=none; b=luOi7AAGoisAhb13z352eIuZzye5M3m0y+7M6QFaa4Cm5dScOddyaWpcZ5cFlqFhx6fWBsYt6eR2q1pvNp18Q0oJ8g1dOgevwPGy/v5lWC2ljY5IBho6Xz04VT2Le5Al68o/sqGvIBZivCOVF/rlvN0bVPhSxu07AJYGB43X/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011910; c=relaxed/simple;
	bh=oLEF7a9OeLIv2Dj0t9zeehek0UM2JWB4c4mv/k82pDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XNkcJHTjgA55UTSN5RLEA0XR1qVNQUxLKqgt6PHX7fN9H90CwrwrHF5mH8kOFfKLimRxZCoibkZo5VZIQqy3xcgCNiZnExsSSdtdL3WWkAhMzPhGPdSlP3iDwVjn1no1oEeZ7TVmIgxC9neKJ6dUqt5PJIKbWadutZOznxKxXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZe6vWTE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-205425b7e27so70566055ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011908; x=1726616708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qKZmcmtlvLxUiaB9mxVA7dCbtHF2c/ntC+IAYmWTbE=;
        b=XZe6vWTEE//x1bMalKbaiud1Ku36Qr9hcS6J/Dh7mCTuzDIsizCkezzRDR5ZpEWUjd
         2QrVvf1j2jK0ncSN8Y6Nu4hKXhT1wATxoKsJ642TUb7pxZ8qV3XQK+4gIiUOqZxsgmDX
         /uIUFaoVZZ+w+Vsauh95ShLhHuvizy+edJa+F89szDZNPBonbiXqTTjevS1DI/XeVblb
         BJq9zWH461flnbP9QjVGeVPLjACCWYIYjjwL4pft7cdgCsOuBiaPHYs47eTW75W43wxn
         un6V5V3FY4+VrXSvtXj/7O79BW//kAZRVCy2yBHaV/Xwdndec9SYcrt27/t+eryybfCq
         MsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011908; x=1726616708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qKZmcmtlvLxUiaB9mxVA7dCbtHF2c/ntC+IAYmWTbE=;
        b=a+aw+J+HhgjuyMfPYqutQXqOdJbjnueFO8xkA7arQPZCSrFy9yCXX2qXHd//t6olC8
         DhUaTz0UwBVGW+ChrJiEBOJuU1Ov/VnMASxvuIlaNsTzL7CTUEVumxMxJBgijiAU4cn2
         7RhMxTSEtiPOcFKxauxtl6Qo81frkHiGIh78Qfu5aYi+FQxm5uLqjK5oYWjvvlka3W4t
         bWgn5D8jh9xOvU/fuBuBmj70bf9o12FRcI8/OlGPDRzyd1YhCmsBEOCYcWel9eCKDYtk
         JA1VQaT9ALZoAp22/sc0zz4w/OUiZq0PxiyMtz6cYxOV7W8sQeOLo9+g52YHKJDc+Njs
         cHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYeHbaHKSDNJ6TShmBtC8nlOUIYNAXAylBFdcUf8cCxkf6UKF2L4iE3DHIWMwNqO5rZM1BwiYfFjyjOT/f1sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/IzsnHsub6ExLOadG96Ioyp+CI8Nn3ZGtZp3PoA4NBpgQNYo
	DzjV6EP9hSA9oabmLV8tB/RqmyWXTAleesGooDpHv2PVX793wJrlI3ElVCezFXoxmBYJn5oDB5k
	PRfhtSif7jfTO9hd1oJCKrA==
X-Google-Smtp-Source: AGHT+IFg8OuONbuLb/Y7bD7B++eP0JBBTd74fUtN+JQ8GVPvsqKbJU+z/AbwfH4duxwkO4C0+G16tdQi6/1xEgA62w==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:c946:b0:206:a858:40d0 with
 SMTP id d9443c01a7336-2074c7cb495mr2763305ad.9.1726011907972; Tue, 10 Sep
 2024 16:45:07 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:52 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <405825c1c3924ca534da3016dda812df17d6c233.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 21/39] KVM: selftests: Test that guest_memfd usage is
 reported via hugetlb
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Using HugeTLB as the huge page allocator for guest_memfd allows reuse
of HugeTLB's reporting mechanism.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/guest_memfd_hugetlb_reporting_test.c  | 222 ++++++++++++++++++
 2 files changed, 223 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 48d32c5aa3eb..b3b7e83f39fc 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -134,6 +134,7 @@ TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
 TEST_GEN_PROGS_x86_64 += guest_memfd_test
+TEST_GEN_PROGS_x86_64 += guest_memfd_hugetlb_reporting_test
 TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c b/tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c
new file mode 100644
index 000000000000..cb9fdf0d4ec8
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c
@@ -0,0 +1,222 @@
+#include <fcntl.h>
+#include <linux/falloc.h>
+#include <linux/kvm.h>
+#include <linux/limits.h>
+#include <linux/memfd.h>
+#include <string.h>
+#include <sys/mman.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "processor.h"
+
+static int read_int(const char *file_name)
+{
+	FILE *fp;
+	int num;
+
+	fp = fopen(file_name, "r");
+	TEST_ASSERT(fp != NULL, "Error opening file %s!\n", file_name);
+
+	TEST_ASSERT_EQ(fscanf(fp, "%d", &num), 1);
+
+	fclose(fp);
+
+	return num;
+}
+
+enum hugetlb_statistic {
+	FREE_HUGEPAGES,
+	NR_HUGEPAGES,
+	NR_OVERCOMMIT_HUGEPAGES,
+	RESV_HUGEPAGES,
+	SURPLUS_HUGEPAGES,
+	NR_TESTED_HUGETLB_STATISTICS,
+};
+
+static const char *hugetlb_statistics[NR_TESTED_HUGETLB_STATISTICS] = {
+	[FREE_HUGEPAGES] = "free_hugepages",
+	[NR_HUGEPAGES] = "nr_hugepages",
+	[NR_OVERCOMMIT_HUGEPAGES] = "nr_overcommit_hugepages",
+	[RESV_HUGEPAGES] = "resv_hugepages",
+	[SURPLUS_HUGEPAGES] = "surplus_hugepages",
+};
+
+enum test_page_size {
+	TEST_SZ_2M,
+	TEST_SZ_1G,
+	NR_TEST_SIZES,
+};
+
+struct test_param {
+	size_t page_size;
+	int memfd_create_flags;
+	int guest_memfd_flags;
+	char *path_suffix;
+};
+
+const struct test_param *test_params(enum test_page_size size)
+{
+	static const struct test_param params[] = {
+		[TEST_SZ_2M] = {
+			.page_size = PG_SIZE_2M,
+			.memfd_create_flags = MFD_HUGETLB | MFD_HUGE_2MB,
+			.guest_memfd_flags = KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_2MB,
+			.path_suffix = "2048kB",
+		},
+		[TEST_SZ_1G] = {
+			.page_size = PG_SIZE_1G,
+			.memfd_create_flags = MFD_HUGETLB | MFD_HUGE_1GB,
+			.guest_memfd_flags = KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_1GB,
+			.path_suffix = "1048576kB",
+		},
+	};
+
+	return &params[size];
+}
+
+static int read_statistic(enum test_page_size size, enum hugetlb_statistic statistic)
+{
+	char path[PATH_MAX] = "/sys/kernel/mm/hugepages/hugepages-";
+
+	strcat(path, test_params(size)->path_suffix);
+	strcat(path, "/");
+	strcat(path, hugetlb_statistics[statistic]);
+
+	return read_int(path);
+}
+
+static int baseline[NR_TEST_SIZES][NR_TESTED_HUGETLB_STATISTICS];
+
+static void establish_baseline(void)
+{
+	int i, j;
+
+	for (i = 0; i < NR_TEST_SIZES; ++i)
+		for (j = 0; j < NR_TESTED_HUGETLB_STATISTICS; ++j)
+			baseline[i][j] = read_statistic(i, j);
+}
+
+static void assert_stats_at_baseline(void)
+{
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_2M, FREE_HUGEPAGES),
+		       baseline[TEST_SZ_2M][FREE_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_2M, NR_HUGEPAGES),
+		       baseline[TEST_SZ_2M][NR_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_2M, NR_OVERCOMMIT_HUGEPAGES),
+		       baseline[TEST_SZ_2M][NR_OVERCOMMIT_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_2M, RESV_HUGEPAGES),
+		       baseline[TEST_SZ_2M][RESV_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_2M, SURPLUS_HUGEPAGES),
+		       baseline[TEST_SZ_2M][SURPLUS_HUGEPAGES]);
+
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_1G, FREE_HUGEPAGES),
+		       baseline[TEST_SZ_1G][FREE_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_1G, NR_HUGEPAGES),
+		       baseline[TEST_SZ_1G][NR_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_1G, NR_OVERCOMMIT_HUGEPAGES),
+		       baseline[TEST_SZ_1G][NR_OVERCOMMIT_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_1G, RESV_HUGEPAGES),
+		       baseline[TEST_SZ_1G][RESV_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(TEST_SZ_1G, SURPLUS_HUGEPAGES),
+		       baseline[TEST_SZ_1G][SURPLUS_HUGEPAGES]);
+}
+
+static void assert_stats(enum test_page_size size, int num_reserved, int num_faulted)
+{
+	TEST_ASSERT_EQ(read_statistic(size, FREE_HUGEPAGES),
+		       baseline[size][FREE_HUGEPAGES] - num_faulted);
+	TEST_ASSERT_EQ(read_statistic(size, NR_HUGEPAGES),
+		       baseline[size][NR_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(size, NR_OVERCOMMIT_HUGEPAGES),
+		       baseline[size][NR_OVERCOMMIT_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_statistic(size, RESV_HUGEPAGES),
+		       baseline[size][RESV_HUGEPAGES] + num_reserved - num_faulted);
+	TEST_ASSERT_EQ(read_statistic(size, SURPLUS_HUGEPAGES),
+		       baseline[size][SURPLUS_HUGEPAGES]);
+}
+
+/* Use hugetlb behavior as a baseline. guest_memfd should have comparable behavior. */
+static void test_hugetlb_behavior(enum test_page_size test_size)
+{
+	const struct test_param *param;
+	char *mem;
+	int memfd;
+
+	param = test_params(test_size);
+
+	assert_stats_at_baseline();
+
+	memfd = memfd_create("guest_memfd_hugetlb_reporting_test",
+			     param->memfd_create_flags);
+
+	mem = mmap(NULL, param->page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_HUGETLB, memfd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "Couldn't mmap()");
+
+	assert_stats(test_size, 1, 0);
+
+	*mem = 'A';
+
+	assert_stats(test_size, 1, 1);
+
+	munmap(mem, param->page_size);
+
+	assert_stats(test_size, 1, 1);
+
+	madvise(mem, param->page_size, MADV_DONTNEED);
+
+	assert_stats(test_size, 1, 1);
+
+	madvise(mem, param->page_size, MADV_REMOVE);
+
+	assert_stats(test_size, 1, 1);
+
+	close(memfd);
+
+	assert_stats_at_baseline();
+}
+
+static void test_guest_memfd_behavior(enum test_page_size test_size)
+{
+	const struct test_param *param;
+	struct kvm_vm *vm;
+	int guest_memfd;
+
+	param = test_params(test_size);
+
+	assert_stats_at_baseline();
+
+	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
+
+	guest_memfd = vm_create_guest_memfd(vm, param->page_size,
+					    param->guest_memfd_flags);
+
+	assert_stats(test_size, 1, 0);
+
+	fallocate(guest_memfd, FALLOC_FL_KEEP_SIZE, 0, param->page_size);
+
+	assert_stats(test_size, 1, 1);
+
+	fallocate(guest_memfd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0,
+		  param->page_size);
+
+	assert_stats(test_size, 1, 0);
+
+	close(guest_memfd);
+
+	assert_stats_at_baseline();
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	establish_baseline();
+
+	test_hugetlb_behavior(TEST_SZ_2M);
+	test_hugetlb_behavior(TEST_SZ_1G);
+
+	test_guest_memfd_behavior(TEST_SZ_2M);
+	test_guest_memfd_behavior(TEST_SZ_1G);
+}
-- 
2.46.0.598.g6f2099f65c-goog


