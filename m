Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6355277333D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjHGXBz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjHGXBr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5C10F3
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:36 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bc4abfca29so31349325ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449296; x=1692054096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc0bDe1Q5+nbJUU+pVaB9FCp2PCsV5hV6cNG49jJHNg=;
        b=GrSgTtJgL52TnT/uTWzmQ2rNlZPMbNRraizKQo1lbsrgS8zwcyUDm/ibZ0i0T0QYEI
         yNGDLdTinm9lF/7glMsZWObw9+hcPz72q1jY6CwmSxTTdKkZON2YroHaQrrQXbAHzbQo
         heRRBKsGOWIDPIqYmgci7pKiKPglMpS6h9iRl8awq8Lyaj9f+vpI1RSUwe1evQmeQxeA
         yljxtZt0T+nuOX1tF6nEDUnR3GksjVD7fY4jPs/3Rs3LnZFfDyMDuDHLL3u5JxtDAq1V
         xs0gZDjgwhRYUB/gtHhjLT5AK2LTUatS5+kQJVwvaYLLe2SctFNprHtCwE+H/4e8eSf+
         djuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449296; x=1692054096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc0bDe1Q5+nbJUU+pVaB9FCp2PCsV5hV6cNG49jJHNg=;
        b=NrvB4w/qTccG6P8z5l4grVZ6Zh5+i7fu+edsMHgQza8U3yvLJOqNs+bhbTHYwKDlxN
         cOpPWkELkQXreOC0nVJZA2D/hUmOxzluv2gHqHXwiMXk8IeQGdwR2F2HbfhSjrsMm2Kv
         QzTBytEDy4+w8sQPYLD7vNV9VztVuGgOSjXFwJFVXgUtlbSM0jRrQm67b7kcctFM3zfd
         tFLiPhu31wSG9lU1TvTD/6x7ieH2j662retjET/lwzni+1fWsjDFlnk0RWCcxKHU+Wm5
         3XOVaZALpIw7LaQnDuGgEvjgu+YmRlfY/uMH4TnJ1gMBOZpJqXp08pxSi8fiFIoYbiQb
         te8w==
X-Gm-Message-State: AOJu0YzUEAocepzi1Chlgx234Fr/SnEeLLy7QtNQpvQKMMJJNpUHyuod
        YcFT3r9o/o515DB0zfWIRywkwDvbUsedrj9GYg==
X-Google-Smtp-Source: AGHT+IEsBZifLl0MXUJYmHs+o0Sd8bVj+Mb8G+Oni/9He6IpfqCSyYz//gy84XV6WPfUm4O1N2BM29fLaYhVypmzPQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:903:1ce:b0:1b9:df8f:888c with SMTP
 id e14-20020a17090301ce00b001b9df8f888cmr40364plh.8.1691449296351; Mon, 07
 Aug 2023 16:01:36 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:07 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <a4692b4772ac71d4f1551cf58fe5333d6ea15796.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 04/11] KVM: selftests: Test transferring private memory to
 another VM
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, ackerleytng@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../kvm/x86_64/private_mem_migrate_tests.c    | 87 +++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_migrate_tests.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index cb9450022302..d348ff56c92b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -82,6 +82,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
 TEST_GEN_PROGS_x86_64 += x86_64/private_mem_conversions_test
 TEST_GEN_PROGS_x86_64 += x86_64/private_mem_kvm_exits_test
+TEST_GEN_PROGS_x86_64 += x86_64/private_mem_migrate_tests
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/private_mem_migrate_tests.c
new file mode 100644
index 000000000000..4226de3ebd41
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_migrate_tests.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util_base.h"
+#include "test_util.h"
+#include "ucall_common.h"
+#include <linux/kvm.h>
+#include <linux/sizes.h>
+
+#define TRANSFER_PRIVATE_MEM_TEST_SLOT 10
+#define TRANSFER_PRIVATE_MEM_GPA ((uint64_t)(1ull << 32))
+#define TRANSFER_PRIVATE_MEM_GVA TRANSFER_PRIVATE_MEM_GPA
+#define TRANSFER_PRIVATE_MEM_VALUE 0xdeadbeef
+
+static void transfer_private_mem_guest_code_src(void)
+{
+	uint64_t volatile *const ptr = (uint64_t *)TRANSFER_PRIVATE_MEM_GVA;
+
+	*ptr = TRANSFER_PRIVATE_MEM_VALUE;
+
+	GUEST_SYNC1(*ptr);
+}
+
+static void transfer_private_mem_guest_code_dst(void)
+{
+	uint64_t volatile *const ptr = (uint64_t *)TRANSFER_PRIVATE_MEM_GVA;
+
+	GUEST_SYNC1(*ptr);
+}
+
+static void test_transfer_private_mem(void)
+{
+	struct kvm_vm *src_vm, *dst_vm;
+	struct kvm_vcpu *src_vcpu, *dst_vcpu;
+	int src_memfd, dst_memfd;
+	struct ucall uc;
+
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+
+	/* Build the source VM, use it to write to private memory */
+	src_vm = __vm_create_shape_with_one_vcpu(
+		shape, &src_vcpu, 0, transfer_private_mem_guest_code_src);
+	src_memfd = vm_create_guest_memfd(src_vm, SZ_4K, 0);
+
+	vm_mem_add(src_vm, DEFAULT_VM_MEM_SRC, TRANSFER_PRIVATE_MEM_GPA,
+		   TRANSFER_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
+		   src_memfd, 0);
+
+	virt_map(src_vm, TRANSFER_PRIVATE_MEM_GVA, TRANSFER_PRIVATE_MEM_GPA, 1);
+	vm_set_memory_attributes(src_vm, TRANSFER_PRIVATE_MEM_GPA, SZ_4K,
+				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
+	vcpu_run(src_vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(src_vcpu, KVM_EXIT_IO);
+	get_ucall(src_vcpu, &uc);
+	TEST_ASSERT(uc.args[0] == TRANSFER_PRIVATE_MEM_VALUE,
+		    "Source VM should be able to write to private memory");
+
+	/* Build the destination VM with linked fd */
+	dst_vm = __vm_create_shape_with_one_vcpu(
+		shape, &dst_vcpu, 0, transfer_private_mem_guest_code_dst);
+	dst_memfd = vm_link_guest_memfd(dst_vm, src_memfd, 0);
+
+	vm_mem_add(dst_vm, DEFAULT_VM_MEM_SRC, TRANSFER_PRIVATE_MEM_GPA,
+		   TRANSFER_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
+		   dst_memfd, 0);
+
+	virt_map(dst_vm, TRANSFER_PRIVATE_MEM_GVA, TRANSFER_PRIVATE_MEM_GPA, 1);
+	vm_set_memory_attributes(dst_vm, TRANSFER_PRIVATE_MEM_GPA, SZ_4K,
+				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
+	vcpu_run(dst_vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(dst_vcpu, KVM_EXIT_IO);
+	get_ucall(dst_vcpu, &uc);
+	TEST_ASSERT(uc.args[0] == TRANSFER_PRIVATE_MEM_VALUE,
+		    "Destination VM should be able to read value transferred");
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	test_transfer_private_mem();
+
+	return 0;
+}
-- 
2.41.0.640.ga95def55d0-goog

