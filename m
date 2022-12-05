Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70D3643970
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 00:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiLEXYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 18:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiLEXX7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 18:23:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0698F19C15
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 15:23:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id v23-20020aa78097000000b005748c087db1so11749293pff.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 15:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqXKZ4E65tt+0gB12B8IM8OBWtCBSAUOaS4vLSjHWmQ=;
        b=Iq42erPv3wxZ/KdNQCI0oMc/S0ufjxXagKz1JdDQeVDt5fQcLmFZnJu1571ly/SMiu
         M+Rf+F425uATne3x07ftXKfE2uNMPVXg4+PRUJlz9euVtTvSBLgbi0JT+Q58x9W0p1RS
         Nm6xS4df5gmD4wFTyghY5ZbY/+uoUhXlA9CP4ZkC8F/eD52yEaU9Ej7cQmf0ewzq+bAM
         yC2MXabIVhE5921WXYLQqHqGcuNVhHD/l6vUzdzd4NoWTvUBHAi86F6D7KlcfpK6l2Hn
         AXuDtDE6RkTcXh9N2VN4mynq8nFrJJOnqWLIE8PxhVP9dxMwA/nV1UWNvHUF3IuOwnBh
         uNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqXKZ4E65tt+0gB12B8IM8OBWtCBSAUOaS4vLSjHWmQ=;
        b=mAUFoWIi7Pb0v75xdh58ZRNjGsCJw+Rl9OlJXc2/pKGvg8cHdyk/hP4bW6Gra/PV5Q
         S3woywi9qSbWXeClY/m7knWXzyAWZIRbN8iUXYkVrWPBfM+XxsHDj0s4urgppZBcMJH9
         titSehMfdjosaVOPJATcgxUVpmkeDN/3jCFw1RhkeXlAs55Sa0zOxjjokq8kycqWLid2
         G1byZbmGy2hszxeVkCwWC/JqruQNjUF1rXEQ09y2bim5NCb84X20j3128cZxsxzG0szW
         lL35o3cK89Pilfz6qmEyPOw24chBRaHRjeH5ZndxUFM3++Dzo5IU0x4dkZkeNLSSgl09
         S0XA==
X-Gm-Message-State: ANoB5pkLHXb1p8ajcYok3kHlE7G0USSVPMyNkkeorYjGp61T0L+AXcEy
        Lr7nsfAT5bOJW++VElnb/h3cbPtKUTsZHlV/
X-Google-Smtp-Source: AA0mqf7iJ0XUuIO47OI4BEWWSu+Cqg2FaGB1yW1qwkMtCXa3sPJx9TZL8N3yL8ixH+1PHnYl9W5zYkaq+SyWuVon
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:f643:b0:187:3c62:5837 with SMTP
 id m3-20020a170902f64300b001873c625837mr69398615plg.123.1670282636651; Mon,
 05 Dec 2022 15:23:56 -0800 (PST)
Date:   Mon,  5 Dec 2022 23:23:39 +0000
In-Reply-To: <20221205232341.4131240-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205232341.4131240-5-vannapurve@google.com>
Subject: [V2 PATCH 4/6] KVM: selftests: x86: Add helpers to execute VMs with
 private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a set of APIs to execute VM with private memslots.

Host userspace APIs for:
1) Executing a vcpu run loop that handles MAPGPA hypercall
2) Backing/unbacking guest private memory

Guest APIs for:
1) Changing memory mapping type

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/include/x86_64/private_mem.h          |  24 +++
 .../selftests/kvm/lib/x86_64/private_mem.c    | 139 ++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 2275ba861e0e..97f7d52c553b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -55,6 +55,7 @@ LIBKVM_x86_64 += lib/x86_64/apic.c
 LIBKVM_x86_64 += lib/x86_64/handlers.S
 LIBKVM_x86_64 += lib/x86_64/hyperv.c
 LIBKVM_x86_64 += lib/x86_64/memstress.c
+LIBKVM_x86_64 += lib/x86_64/private_mem.c
 LIBKVM_x86_64 += lib/x86_64/processor.c
 LIBKVM_x86_64 += lib/x86_64/svm.c
 LIBKVM_x86_64 += lib/x86_64/ucall.c
diff --git a/tools/testing/selftests/kvm/include/x86_64/private_mem.h b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
new file mode 100644
index 000000000000..3aa6b4d11b28
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_PRIVATE_MEM_H
+#define SELFTEST_KVM_PRIVATE_MEM_H
+
+#include <stdint.h>
+#include <kvm_util.h>
+
+void kvm_hypercall_map_shared(uint64_t gpa, uint64_t size);
+void kvm_hypercall_map_private(uint64_t gpa, uint64_t size);
+
+void vm_unback_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size);
+
+void vm_allocate_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size);
+
+void handle_vm_exit_map_gpa_hypercall(struct kvm_vm *vm, uint64_t gpa,
+	uint64_t npages, uint64_t attrs);
+
+void vcpu_run_and_handle_mapgpa(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
+
+#endif /* SELFTEST_KVM_PRIVATE_MEM_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
new file mode 100644
index 000000000000..2b97fc34ec4a
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+#define _GNU_SOURCE /* for program_invocation_name */
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <private_mem.h>
+#include <processor.h>
+
+static inline uint64_t __kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
+	uint64_t flags)
+{
+	return kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> PAGE_SHIFT, flags, 0);
+}
+
+static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
+	uint64_t flags)
+{
+	uint64_t ret;
+
+	GUEST_ASSERT_2(IS_PAGE_ALIGNED(gpa) && IS_PAGE_ALIGNED(size), gpa, size);
+
+	ret = __kvm_hypercall_map_gpa_range(gpa, size, flags);
+	GUEST_ASSERT_1(!ret, ret);
+}
+
+void kvm_hypercall_map_shared(uint64_t gpa, uint64_t size)
+{
+	kvm_hypercall_map_gpa_range(gpa, size, KVM_MAP_GPA_RANGE_DECRYPTED);
+}
+
+void kvm_hypercall_map_private(uint64_t gpa, uint64_t size)
+{
+	kvm_hypercall_map_gpa_range(gpa, size, KVM_MAP_GPA_RANGE_ENCRYPTED);
+}
+
+static void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+	bool unback_mem)
+{
+	int restricted_fd;
+	uint64_t restricted_fd_offset, guest_phys_base, fd_offset;
+	struct kvm_memory_attributes attr;
+	struct kvm_userspace_memory_region_ext *region_ext;
+	struct kvm_userspace_memory_region *region;
+	int fallocate_mode = 0;
+	int ret;
+
+	region_ext = kvm_userspace_memory_region_ext_find(vm, gpa, gpa + size);
+	TEST_ASSERT(region_ext != NULL, "Region not found");
+	region = &region_ext->region;
+	TEST_ASSERT(region->flags & KVM_MEM_PRIVATE,
+		"Can not update private memfd for non-private memslot\n");
+	restricted_fd = region_ext->restricted_fd;
+	restricted_fd_offset = region_ext->restricted_offset;
+	guest_phys_base = region->guest_phys_addr;
+	fd_offset = restricted_fd_offset + (gpa - guest_phys_base);
+
+	if (unback_mem)
+		fallocate_mode = (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
+
+	printf("restricted_fd %d fallocate_mode 0x%x for offset 0x%lx size 0x%lx\n",
+		restricted_fd, fallocate_mode, fd_offset, size);
+	ret = fallocate(restricted_fd, fallocate_mode, fd_offset, size);
+	TEST_ASSERT(ret == 0, "fallocate failed\n");
+	attr.attributes = unback_mem ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+	attr.address = gpa;
+	attr.size = size;
+	attr.flags = 0;
+	if (unback_mem)
+		printf("undoing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
+	else
+		printf("doing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
+
+	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+}
+
+void vm_unback_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size)
+{
+	vm_update_private_mem(vm, gpa, size, true);
+}
+
+void vm_allocate_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size)
+{
+	vm_update_private_mem(vm, gpa, size, false);
+}
+
+void handle_vm_exit_map_gpa_hypercall(struct kvm_vm *vm, uint64_t gpa,
+	uint64_t npages, uint64_t attrs)
+{
+	uint64_t size;
+
+	size = npages << MIN_PAGE_SHIFT;
+	pr_info("Explicit conversion off 0x%lx size 0x%lx to %s\n", gpa, size,
+		(attrs & KVM_MAP_GPA_RANGE_ENCRYPTED) ? "private" : "shared");
+
+	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED)
+		vm_allocate_private_mem(vm, gpa, size);
+	else
+		vm_unback_private_mem(vm, gpa, size);
+}
+
+void vcpu_run_and_handle_mapgpa(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Loop until the guest exits with any reason other than
+	 * KVM_HC_MAP_GPA_RANGE hypercall.
+	 */
+
+	while (true) {
+		vcpu_run(vcpu);
+
+		if ((vcpu->run->exit_reason == KVM_EXIT_HYPERCALL) &&
+			(vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)) {
+			uint64_t gpa = vcpu->run->hypercall.args[0];
+			uint64_t npages = vcpu->run->hypercall.args[1];
+			uint64_t attrs = vcpu->run->hypercall.args[2];
+
+			handle_vm_exit_map_gpa_hypercall(vm, gpa, npages, attrs);
+			vcpu->run->hypercall.ret = 0;
+			continue;
+		}
+
+		return;
+	}
+}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

