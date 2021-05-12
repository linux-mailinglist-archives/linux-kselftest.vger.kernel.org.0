Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E664D37EF45
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 01:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbhELXDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 19:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388316AbhELVtR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 17:49:17 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A7C061257
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:08 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t12-20020a170902dcccb02900ed4648d0f9so10051755pll.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dsZRmacMS6KM7zL6VioeEOgTKaLma8ZGBhS/giKTJdU=;
        b=eg8ku46+dEOGYq0sMq9kRhyoEZR8wLo/LkK/PHISXJba6ZWp90a+oTa2Zmf44FUdCu
         QYumBp6pQdiXTHsMt//WJ/sbXj1mH40QMd5YXHvAYBe7BnrTHHcfSWDUywhyGXQwc5HD
         bgeIY0By9ibXUyB2DtLL3Qyjm1rS4rdAKFAlGksh9ckZlPjC2SaQJsVLmOcPFCBhkWWk
         dDG/8nPE5IvMhDyjHYrczCg1Iah/pfa3gm0jhh//4ICrRThO9tvqL5Medbimjohfom5Y
         GcimKBjoFIUPfD2m1ZjdI9zQRYJ1p4s4l+DG357O4J96st68HVlhnKvf7rKOOMNo1fgp
         SZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dsZRmacMS6KM7zL6VioeEOgTKaLma8ZGBhS/giKTJdU=;
        b=XF5WKzj9ZjK665oQgaPXmrVmSEuPlefZWBp20xf6TdO1KaBXpt892hyIssCCqFxamd
         U++akiFAvaYKtZjaMPwj9LeYx/jLFI0DYtn431mvxsy62yNtIaTIbryC6Y5MMat8NDUo
         eZC7/DqyNbje2xyeBNhy5WSRbuehAjqSWjpZVAdOuYn7iFjRx77LPbNmZkGuNavT31xs
         75EUPrQ3DWwvSJGx32RTRlVXZ8epwIk57Idyad0wfo6J46N6mD2PtWZFDRndSTNCWiKf
         czGp+TVEkvoYH+ExKCO7c4GUHHf45YdbNSk9iPWdfGB7RUVraG0b/NHtJBrD4WMdBvah
         vzLw==
X-Gm-Message-State: AOAM533psQnRkiUTTGBcCvkNXAhkUvt3ZZctJEk/82c2x/LgFbwykzGp
        JIJ7GRoU31xZGHDwG/KVM4Fgt/5n+l7I7R3U+ikS
X-Google-Smtp-Source: ABdhPJyswNHOW1PP+QOxNH6b+qDviBQKkHwncNUAmYrXswvR5b7LxW2U/DVYPrwXHf+eUMvpaaOnuyZ8ix1pI+iqGJxl
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:29e5:10fc:1128:b0c0])
 (user=axelrasmussen job=sendgmr) by 2002:a17:902:b406:b029:ec:fbf2:4114 with
 SMTP id x6-20020a170902b406b02900ecfbf24114mr37698704plr.32.1620855907823;
 Wed, 12 May 2021 14:45:07 -0700 (PDT)
Date:   Wed, 12 May 2021 14:44:58 -0700
In-Reply-To: <20210512214502.2047008-1-axelrasmussen@google.com>
Message-Id: <20210512214502.2047008-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 1/5] KVM: selftests: allow different backing memory types for
 demand paging
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add an argument which lets us specify a different backing memory type
for the test. The default is just to use anonymous, matching existing
behavior (if the argument is omitted).

This is in preparation for testing UFFD minor faults. For that, we need
to use a new backing memory type which is setup with MAP_SHARED.

This notably requires one other change. Perhaps counter-intuitively,
perf_test_args.host_page_size is the host's *native* page size, not the
size of the pages the host is using to back the guest. This means, if we
try to run the test with e.g. VM_MEM_SRC_ANONYMOUS_HUGETLB, we'll try to
do demand paging with 4k pages instead of 2M hugepages.

So, convert everything to use a new demand_paging_size, computed based
on the backing memory type.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 5f7a229c3af1..10c7ba76a9c6 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -38,6 +38,7 @@
 
 static int nr_vcpus = 1;
 static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
+static size_t demand_paging_size;
 static char *guest_data_prototype;
 
 static void *vcpu_worker(void *data)
@@ -83,7 +84,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 
 	copy.src = (uint64_t)guest_data_prototype;
 	copy.dst = addr;
-	copy.len = perf_test_args.host_page_size;
+	copy.len = demand_paging_size;
 	copy.mode = 0;
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
@@ -100,7 +101,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 	PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
 		       timespec_to_ns(ts_diff));
 	PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
-		       perf_test_args.host_page_size, addr, tid);
+		       demand_paging_size, addr, tid);
 
 	return 0;
 }
@@ -250,6 +251,7 @@ static int setup_demand_paging(struct kvm_vm *vm,
 struct test_params {
 	bool use_uffd;
 	useconds_t uffd_delay;
+	enum vm_mem_backing_src_type src_type;
 	bool partition_vcpu_memory_access;
 };
 
@@ -267,14 +269,16 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	int r;
 
 	vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
-				 VM_MEM_SRC_ANONYMOUS);
+				 p->src_type);
 
 	perf_test_args.wr_fract = 1;
 
-	guest_data_prototype = malloc(perf_test_args.host_page_size);
+	demand_paging_size = get_backing_src_pagesz(p->src_type);
+
+	guest_data_prototype = malloc(demand_paging_size);
 	TEST_ASSERT(guest_data_prototype,
 		    "Failed to allocate buffer for guest data pattern");
-	memset(guest_data_prototype, 0xAB, perf_test_args.host_page_size);
+	memset(guest_data_prototype, 0xAB, demand_paging_size);
 
 	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
 	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
@@ -388,7 +392,7 @@ static void help(char *name)
 {
 	puts("");
 	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
-	       "          [-b memory] [-v vcpus] [-o]\n", name);
+	       "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
 	guest_modes_help();
 	printf(" -u: use User Fault FD to handle vCPU page\n"
 	       "     faults.\n");
@@ -398,6 +402,8 @@ static void help(char *name)
 	printf(" -b: specify the size of the memory region which should be\n"
 	       "     demand paged by each vCPU. e.g. 10M or 3G.\n"
 	       "     Default: 1G\n");
+	printf(" -t: The type of backing memory to use. Default: anonymous\n");
+	backing_src_help();
 	printf(" -v: specify the number of vCPUs to run.\n");
 	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
 	       "     them into a separate region of memory for each vCPU.\n");
@@ -409,13 +415,14 @@ int main(int argc, char *argv[])
 {
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
 	struct test_params p = {
+		.src_type = VM_MEM_SRC_ANONYMOUS,
 		.partition_vcpu_memory_access = true,
 	};
 	int opt;
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hm:ud:b:v:o")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:ud:b:t:v:o")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -430,6 +437,9 @@ int main(int argc, char *argv[])
 		case 'b':
 			guest_percpu_mem_size = parse_size(optarg);
 			break;
+		case 't':
+			p.src_type = parse_backing_src_type(optarg);
+			break;
 		case 'v':
 			nr_vcpus = atoi(optarg);
 			TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
-- 
2.31.1.607.g51e8a6a459-goog

