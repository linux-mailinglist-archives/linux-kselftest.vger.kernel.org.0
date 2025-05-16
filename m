Return-Path: <linux-kselftest+bounces-33222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39874ABA3AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA532507D25
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EF0283154;
	Fri, 16 May 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muzAEcx3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0B283C86
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423210; cv=none; b=dDH3+UTEd17Bl7iU6CrzbJcdUyO+aPx3g6Gi6n7YH2my6Cp0y9N4LG5X3UIs1gT0Q09IwklPaDm2vuCopvbnvNiBcnW5NwsUI7iE+2m+3AFMtMC+DoNQvejCNeeFI/sI5SEz9o8Ilv+k1RoiFM6yqhpIeoTUNZiPqizDg3bg4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423210; c=relaxed/simple;
	bh=286azteypIeGDNxuuOVgHebViNvaqsxBRbBpJ41BQWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a6/gFLqmOEkDslk46QhvCT9N9cTrsQfQ1F/b27Y8GKRcE3Mc7TdHTG2o+WvX+ntNlrchL+tQBvAlYPN48hcs0ErEOvq+gX1ZC0DVw0uY4Iji/ggdsCFUPJLfFfK2QIVRQyvOlyynDAr/03zRRUlMcOOha/gAboojQh+PHnp8bzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muzAEcx3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7391d68617cso2776867b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423208; x=1748028008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/DXUzrkv3zGlmZlSMCdLZe68HkBWyu2pzyjcV2UND4=;
        b=muzAEcx35/+br5ctE1QZqiCykknGmCfP7lXVwzcZCervlpEGX5UzDr+8cKlr7NI/MS
         nzJegQPu/xGt8X0pJsvQjg/pVEsAb502R6432/4gxRRAZ6CH6nwv/ymWNvQIQssfIPOq
         SzyDIJ8YZbjeI7YKyrUOmeZN+RYy1sWEOYvT3LDWapdo38MHQQ7zrhvq0mjYn77y/Ffe
         Je2qwLcEdqrAb44tKotAPUCGOi++kUlg80FDp9WDHoTM535vD47VyzN6xmOBzHdP9C6a
         0eXqJuvDtkilH5xyfg709qdO7TdW6roYniRQstRBFWvp9paHoclMD8iHX7NbOSqeFmBy
         fUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423208; x=1748028008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/DXUzrkv3zGlmZlSMCdLZe68HkBWyu2pzyjcV2UND4=;
        b=qXwQZR+1GkLpSsLrM/mtWFiHptlLOM2ClPLAjBtmzkNy474TqoG77xEdLmQHap2RF4
         SyiPp03hd1SqAfqfZGgAk1FamRYgR9l0xDheJOSnmee3bx8VyYO9jiuR2Qie12wCUfHa
         7DWsUaXat0OdjPOYf/ZdhWLmIuM86Z1zQZSsFO/Fot7uX9xKk9DC5CudivAfZd/WlvC5
         W0aScYuhRQwwhQYNGPADhICJP3RJMYkBK2HNnU7ghg2S9pm5VEQ7ADJrYiQ1KEov2/ts
         N/4WSze+x31Tya526T51svFYwfW8kW20/H4jYloC4JfSu3a5NsFRRVdce+DSPtshD4oW
         7vRw==
X-Forwarded-Encrypted: i=1; AJvYcCXa7ufYwyCFf6G/8+rV9VeayFKPH5jbazIGLemSaHM8EsyQWHf4Y9yyoXMPS/jqQLDsy3FWNGKUGZ0aqpt8vGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uu+CItA6PHwcIgxHSkqZvnYzdb3B8bo3lZtK6KzWkGT9Vugf
	+3VXN73/QakwBjks8/2aIr3bFr6x/7Xc6k6Hi4oM49kKmnJJfuYhXPtQ3Pifee+EDzEosvB9OPN
	SipIhsWDDFg==
X-Google-Smtp-Source: AGHT+IELettSJSAjPN0ajEgghq8cce8mY33OF/qwq78Jwt00Tyez7vqBw2SJQ3LE86dpcucnhoMJmApM4i8D
X-Received: from pfdf22.prod.google.com ([2002:aa7:8b16:0:b0:740:63b6:1826])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f96:b0:1f3:26ae:7792
 with SMTP id adf61e73a8af0-2165f87234fmr5820413637.18.1747423207727; Fri, 16
 May 2025 12:20:07 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:33 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <4310b9291b9662c1059ebcf50e267760bc8e1c6f.1747368093.git.afranji@google.com>
Subject: [RFC PATCH v2 13/13] KVM: selftests: Add tests for migration of
 private mem
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Tests that private mem (in guest_mem files) can be migrated. Also
demonstrates the migration flow.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../kvm/x86/private_mem_migrate_tests.c       | 56 ++++++++++---------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f62b0a5aba35..e9d53ea6c6c8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -85,6 +85,7 @@ TEST_GEN_PROGS_x86 += x86/platform_info_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
+TEST_GEN_PROGS_x86 += x86/private_mem_migrate_tests
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
diff --git a/tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c b/tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c
index 4226de3ebd41..4ad94ea04b66 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c
@@ -1,32 +1,32 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "kvm_util_base.h"
+#include "kvm_util.h"
 #include "test_util.h"
 #include "ucall_common.h"
 #include <linux/kvm.h>
 #include <linux/sizes.h>
 
-#define TRANSFER_PRIVATE_MEM_TEST_SLOT 10
-#define TRANSFER_PRIVATE_MEM_GPA ((uint64_t)(1ull << 32))
-#define TRANSFER_PRIVATE_MEM_GVA TRANSFER_PRIVATE_MEM_GPA
-#define TRANSFER_PRIVATE_MEM_VALUE 0xdeadbeef
+#define MIGRATE_PRIVATE_MEM_TEST_SLOT 10
+#define MIGRATE_PRIVATE_MEM_GPA ((uint64_t)(1ull << 32))
+#define MIGRATE_PRIVATE_MEM_GVA MIGRATE_PRIVATE_MEM_GPA
+#define MIGRATE_PRIVATE_MEM_VALUE 0xdeadbeef
 
-static void transfer_private_mem_guest_code_src(void)
+static void migrate_private_mem_data_guest_code_src(void)
 {
-	uint64_t volatile *const ptr = (uint64_t *)TRANSFER_PRIVATE_MEM_GVA;
+	uint64_t volatile *const ptr = (uint64_t *)MIGRATE_PRIVATE_MEM_GVA;
 
-	*ptr = TRANSFER_PRIVATE_MEM_VALUE;
+	*ptr = MIGRATE_PRIVATE_MEM_VALUE;
 
 	GUEST_SYNC1(*ptr);
 }
 
-static void transfer_private_mem_guest_code_dst(void)
+static void migrate_private_mem_guest_code_dst(void)
 {
-	uint64_t volatile *const ptr = (uint64_t *)TRANSFER_PRIVATE_MEM_GVA;
+	uint64_t volatile *const ptr = (uint64_t *)MIGRATE_PRIVATE_MEM_GVA;
 
 	GUEST_SYNC1(*ptr);
 }
 
-static void test_transfer_private_mem(void)
+static void test_migrate_private_mem_data(bool migrate)
 {
 	struct kvm_vm *src_vm, *dst_vm;
 	struct kvm_vcpu *src_vcpu, *dst_vcpu;
@@ -40,40 +40,43 @@ static void test_transfer_private_mem(void)
 
 	/* Build the source VM, use it to write to private memory */
 	src_vm = __vm_create_shape_with_one_vcpu(
-		shape, &src_vcpu, 0, transfer_private_mem_guest_code_src);
+		shape, &src_vcpu, 0, migrate_private_mem_data_guest_code_src);
 	src_memfd = vm_create_guest_memfd(src_vm, SZ_4K, 0);
 
-	vm_mem_add(src_vm, DEFAULT_VM_MEM_SRC, TRANSFER_PRIVATE_MEM_GPA,
-		   TRANSFER_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
+	vm_mem_add(src_vm, DEFAULT_VM_MEM_SRC, MIGRATE_PRIVATE_MEM_GPA,
+		   MIGRATE_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_GUEST_MEMFD,
 		   src_memfd, 0);
 
-	virt_map(src_vm, TRANSFER_PRIVATE_MEM_GVA, TRANSFER_PRIVATE_MEM_GPA, 1);
-	vm_set_memory_attributes(src_vm, TRANSFER_PRIVATE_MEM_GPA, SZ_4K,
+	virt_map(src_vm, MIGRATE_PRIVATE_MEM_GVA, MIGRATE_PRIVATE_MEM_GPA, 1);
+	vm_set_memory_attributes(src_vm, MIGRATE_PRIVATE_MEM_GPA, SZ_4K,
 				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
 	vcpu_run(src_vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(src_vcpu, KVM_EXIT_IO);
 	get_ucall(src_vcpu, &uc);
-	TEST_ASSERT(uc.args[0] == TRANSFER_PRIVATE_MEM_VALUE,
+	TEST_ASSERT(uc.args[0] == MIGRATE_PRIVATE_MEM_VALUE,
 		    "Source VM should be able to write to private memory");
 
 	/* Build the destination VM with linked fd */
 	dst_vm = __vm_create_shape_with_one_vcpu(
-		shape, &dst_vcpu, 0, transfer_private_mem_guest_code_dst);
+		shape, &dst_vcpu, 0, migrate_private_mem_guest_code_dst);
 	dst_memfd = vm_link_guest_memfd(dst_vm, src_memfd, 0);
 
-	vm_mem_add(dst_vm, DEFAULT_VM_MEM_SRC, TRANSFER_PRIVATE_MEM_GPA,
-		   TRANSFER_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
+	vm_mem_add(dst_vm, DEFAULT_VM_MEM_SRC, MIGRATE_PRIVATE_MEM_GPA,
+		   MIGRATE_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_GUEST_MEMFD,
 		   dst_memfd, 0);
 
-	virt_map(dst_vm, TRANSFER_PRIVATE_MEM_GVA, TRANSFER_PRIVATE_MEM_GPA, 1);
-	vm_set_memory_attributes(dst_vm, TRANSFER_PRIVATE_MEM_GPA, SZ_4K,
-				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	virt_map(dst_vm, MIGRATE_PRIVATE_MEM_GVA, MIGRATE_PRIVATE_MEM_GPA, 1);
+	if (migrate)
+		vm_migrate_from(dst_vm, src_vm);
+	else
+		vm_set_memory_attributes(dst_vm, MIGRATE_PRIVATE_MEM_GPA, SZ_4K,
+					 KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
 	vcpu_run(dst_vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(dst_vcpu, KVM_EXIT_IO);
 	get_ucall(dst_vcpu, &uc);
-	TEST_ASSERT(uc.args[0] == TRANSFER_PRIVATE_MEM_VALUE,
+	TEST_ASSERT(uc.args[0] == MIGRATE_PRIVATE_MEM_VALUE,
 		    "Destination VM should be able to read value transferred");
 }
 
@@ -81,7 +84,10 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
 
-	test_transfer_private_mem();
+	test_migrate_private_mem_data(false);
+
+	if (kvm_check_cap(KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM))
+		test_migrate_private_mem_data(true);
 
 	return 0;
 }
-- 
2.49.0.1101.gccaa498523-goog


