Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16A389768
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhESUF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhESUFV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE19C061343
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o6-20020a5b06460000b02905004326697dso19340901ybq.22
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tlTQaP6r3uJCMYh9e3cNPNgqQCjX8re8AUT1/sJlsgs=;
        b=rFmQtjZe9RYFX+tPbUuHk7Z7fNZNixYSjXLsfPRlf0/fGpNcZdJATEmw0/FPJOfPoJ
         n3b204YrvYZ4PnW6zaZoAgOPvN1EhcUvDlYhNyIKE/9E/t+R79kOa/sKhal2uZP0F1+2
         a/77hmjaqxFjcsIWHfWrzCq9fZeZU4jkms28fr7Y9pSntDHcIhq8Dp4mWHPP/3a1WWS8
         0E4CCqTStU29JAvUfVddAGuj2uc9eM0bs1zXRBO4iK0F4fh/mgsOVl7v+hmKc1i9KrXt
         jKeIqsCA3M+3G8+PDzPav2K4bx4BWZ295RawYQUPAkksDIoMtzWjnATt9p/mLTnWGHej
         TiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tlTQaP6r3uJCMYh9e3cNPNgqQCjX8re8AUT1/sJlsgs=;
        b=BE+j/bXrRohXiMULPfeSk9kx/FVbNa+1JLQBSP3k6AdXE9oLpNv6h1S0X4f6gACqIC
         6oeQvdd4mFlitSehqgPNNa6HEAvCx6n8knhEu4wtShkcu9YvpK9rHqkMb5Rn7hDGC7aN
         QHoDspzCxybupU4b/e5IaCeB3ORLSFY1ID0CBSwkHtPtZA6+/M23f/FuPn/SqWMAnwNV
         T3ikOyd+5OqhSdH6UCSm1bXLXBlbKilJfBYraa2Z3P7/KraiUYuGFjXXekJkhkesDXjt
         P9Cz+cLAGMBYDGc37mHYonAj0iRwBdEi5DOt44Vjc8Go+pesY5KG8+/sKImeHBAZYWIx
         BhDA==
X-Gm-Message-State: AOAM533crOgsV7bgBkzEdmAaJLxZk57AeTkXH0ABSl3sAyoSWyq/bItR
        45cjrljHhSevyoqcJZr4JCvtxrS79z0ntj6iNl3A
X-Google-Smtp-Source: ABdhPJz9HhVlHYawgy3hnCcQ7AShRBgdTu2ZGMyQY3vViJpDbCZv6DzEjwG2iPCHDIz6QdxXKmnqatC3ojP/RGn7YsgM
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:a25:86c1:: with SMTP id
 y1mr1922580ybm.82.1621454638208; Wed, 19 May 2021 13:03:58 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:34 -0700
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Message-Id: <20210519200339.829146-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 05/10] KVM: selftests: allow different backing source types
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
behavior.

This is in preparation for testing UFFD minor faults. For that, we'll
need to use a new backing memory type which is setup with MAP_SHARED.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 94cf047358d5..01890a7b0155 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -241,6 +241,7 @@ static void setup_demand_paging(struct kvm_vm *vm,
 struct test_params {
 	bool use_uffd;
 	useconds_t uffd_delay;
+	enum vm_mem_backing_src_type src_type;
 	bool partition_vcpu_memory_access;
 };
 
@@ -258,11 +259,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	int r;
 
 	vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
-				 VM_MEM_SRC_ANONYMOUS);
+				 p->src_type);
 
 	perf_test_args.wr_fract = 1;
 
-	demand_paging_size = get_backing_src_pagesz(VM_MEM_SRC_ANONYMOUS);
+	demand_paging_size = get_backing_src_pagesz(p->src_type);
 
 	guest_data_prototype = malloc(demand_paging_size);
 	TEST_ASSERT(guest_data_prototype,
@@ -378,7 +379,7 @@ static void help(char *name)
 {
 	puts("");
 	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
-	       "          [-b memory] [-v vcpus] [-o]\n", name);
+	       "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
 	guest_modes_help();
 	printf(" -u: use User Fault FD to handle vCPU page\n"
 	       "     faults.\n");
@@ -388,6 +389,8 @@ static void help(char *name)
 	printf(" -b: specify the size of the memory region which should be\n"
 	       "     demand paged by each vCPU. e.g. 10M or 3G.\n"
 	       "     Default: 1G\n");
+	printf(" -t: The type of backing memory to use. Default: anonymous\n");
+	backing_src_help();
 	printf(" -v: specify the number of vCPUs to run.\n");
 	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
 	       "     them into a separate region of memory for each vCPU.\n");
@@ -399,13 +402,14 @@ int main(int argc, char *argv[])
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
@@ -420,6 +424,9 @@ int main(int argc, char *argv[])
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
2.31.1.751.gd2f1c929bd-goog

