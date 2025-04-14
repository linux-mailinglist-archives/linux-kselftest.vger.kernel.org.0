Return-Path: <linux-kselftest+bounces-30788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE755A88E73
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09716189B245
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25F233714;
	Mon, 14 Apr 2025 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vbb8aMrs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8192225792
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667357; cv=none; b=YB5wBamO9vxmPeet6qq56LmxJpUT1vmTTi2reN5e9E0SX/gqjfYYIb0vCC71AUWsNvsgk1hXjqrJ10a1mIBJzCNGIUJtXeawBeRzAyDU9IAwtpVe2pjrm7oh+ubqWbMUqOwekPBinjNOd0vNibwjjMRCo+r0MpADuEw2HHjPouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667357; c=relaxed/simple;
	bh=RSKU4jW8yMzfuuDsDyi+g+O1YaTiEjJySztFtqymoYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IbVZJAv6XkGrmqd3PjTDc7JDRxt3l+fBdPfPQ3l17HpxfTDiW0DqIU9yyeJ0PYY6MtRLLF/mIHLe/a0iE+cX6ZGOGoVKUXKAE3sbHfdW2VmbbXmuSH7LuiZexvTUNG1j8KqJlJSRJyFCibWtTMXsl0kXEFEvAya1ojvLSS1jpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vbb8aMrs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3082946f829so4365381a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667355; x=1745272155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZtYyL+uFsfjlp4Jj3WZJ85Loup3ELrCNm4VwnN4Wpw=;
        b=Vbb8aMrs8pXpuySXKDPP4J+gIZIykiv0leQteXkQGLyrV/5196PxuN5E9nzClbdfDB
         IVm9zeetg7OLK4BJG0T9dfEpl1ASFt9+LUqZjvnYHzR+X5Zi57dZ4ViXMzWQBCHsKP/r
         RitsQa9KWm5uTOMcIsYWNid5b1umwwhI28/x3Xa+ZunrtT+hnJWPY2T1K3lmb4SfQ67x
         zvAsyfD1c8gmU/Ob7CWgYAN848QfDNz6HX5M7Opy8Kjh+t4+p/9BioiqH9kyTrB8eJaf
         Bc80AnCC8EtRpBAD/zVm+KQ+yWeHmWyO7iin/T0+rmVWHO5WNnSA7o43o1guPGSzTIFt
         zSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667355; x=1745272155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZtYyL+uFsfjlp4Jj3WZJ85Loup3ELrCNm4VwnN4Wpw=;
        b=gfjWvU/Z71PJ/pi9Rn89mz+cIcTExGYls2/EsOXtvAVw0G5cZsL4RKq7IbryKJKQY2
         rcU5UthiqGjo2Kzgn59n4e3S3wNGx2rC5YAr+vWJH/O5a8jo7dlhzbm2Y0NlpAg3qj+l
         p+PHXj9EzkTxwfiW/TcqjkNS8EEllwVc7Q2lFjD5aNNA39BifRDstbO3HU9yiUDnsr/F
         MWb5TTCzT/m7/7afTCqTXsuADdtxw2Se3r0qyQlt0J6f7xWAHc0HvH7lNQrjH+v9av+i
         cogVOICqm8LWXd27JhZUUf2xdOB4o9fArTbNFaJKGRgdkS2fAY5zBNJmtdY+lDHZ50/+
         CHDA==
X-Gm-Message-State: AOJu0Yx5ZjsHtk5CEn0L5Ft1fYXMQ4iUxMhTp9mZ+jObhju9J6t6NrlT
	BzNzONSkmm++VeS5KJSmjuMPm1UUaudOVyUDAxQEfwErGmXXsWXNxi057OPEQP7JMw7Vqo4IzD+
	VUz+HOpgebak+i91zQ95UmnCErWjthD0Y9osKGepVEz0l7WPzXh6KRwCwh1KG4lITgugsn0c3Sj
	dhKGKTTWYt9V7SQanx0Tl67VwKBvBnONGJXEXXfzs=
X-Google-Smtp-Source: AGHT+IG6N3VIIqbFOy1VCiInzqyZNSMstT3S1WJU1Qihx4IQIF/l+S1IHVFaisjxhJFBH7CCAZp9P8tvVA==
X-Received: from pjbsf6.prod.google.com ([2002:a17:90b:51c6:b0:2ea:29de:af10])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5845:b0:2ff:6f8a:3a13
 with SMTP id 98e67ed59e1d1-30823671275mr18122389a91.25.1744667355035; Mon, 14
 Apr 2025 14:49:15 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:53 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-25-sagis@google.com>
Subject: [PATCH v6 24/30] KVM: selftests: TDX: Add shared memory test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ryan Afranji <afranji@google.com>

Test that host and guest can exchange data via shared memory.

Set up shared memory by first allocating as private and then mapping
the same GPA as shared. The guest starts with a request to map a
page of memory to shared. This request is done via a hypercall
(TDG.VP.VMCALL<MapGPA>) from the guest that the kernel converts to
KVM_EXIT_HYPERCALL with KVM_HC_MAP_GPA_RANGE that is sent back to the
test for handling.  Handle the guest's request using the
KVM_SET_MEMORY_ATTRIBUTES ioctl().

After the shared memory is set up the guest writes to it and notifies the
host from where the data is verified. In return, the host writes to the
same memory that is verified by the guest.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/tdx/tdx.h       |   4 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |   2 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  26 ++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  32 +++++
 .../selftests/kvm/x86/tdx_shared_mem_test.c   | 129 ++++++++++++++++++
 6 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index e98d5413991a..9f660f913715 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -145,6 +145,7 @@ TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
 TEST_GEN_PROGS_x86 += x86/tdx_vm_test
+TEST_GEN_PROGS_x86 += x86/tdx_shared_mem_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 801ca879664e..88f3571df16f 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -9,6 +9,7 @@
 #define TDG_VP_INFO 1
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
+#define TDG_VP_VMCALL_MAP_GPA 0x10001
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
 #define TDG_VP_VMCALL_INSTRUCTION_CPUID 10
@@ -18,6 +19,8 @@
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
 #define TDG_VP_VMCALL_VE_REQUEST_MMIO 48
 
+void handle_userspace_map_gpa(struct kvm_vcpu *vcpu);
+
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
 void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
@@ -36,5 +39,6 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
 uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		     uint64_t *r8, uint64_t *r9,
 		     uint64_t *r10, uint64_t *r11);
+uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index c942aec7ad26..ae39b78aa4af 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -17,5 +17,7 @@ void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		   uint64_t attributes);
 void td_finalize(struct kvm_vm *vm);
 void td_vcpu_run(struct kvm_vcpu *vcpu);
+void handle_memory_conversion(struct kvm_vm *vm, uint32_t vcpu_id, uint64_t gpa,
+			      uint64_t size, bool shared_to_private);
 
 #endif // SELFTESTS_TDX_KVM_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index ab6fd3d7ae4b..bae84c34c19e 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -1,11 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/kvm_para.h>
 #include <string.h>
 
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
 
+void handle_userspace_map_gpa(struct kvm_vcpu *vcpu)
+{
+	handle_memory_conversion(vcpu->vm, vcpu->id, vcpu->run->hypercall.args[0],
+				 vcpu->run->hypercall.args[1] << 12,
+				 vcpu->run->hypercall.args[2] & KVM_MAP_GPA_RANGE_ENCRYPTED);
+	vcpu->run->hypercall.ret = 0;
+}
+
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data)
 {
@@ -189,3 +199,19 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 
 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_MAP_GPA,
+		.r12 = address,
+		.r13 = size
+	};
+	uint64_t ret;
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (data_out)
+		*data_out = args.r11;
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 5e4455be828a..c5bee67099c5 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -608,4 +608,36 @@ void td_finalize(struct kvm_vm *vm)
 void td_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	vcpu_run(vcpu);
+
+	/* Handle TD VMCALLs that require userspace handling. */
+	if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL &&
+	    vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE) {
+		handle_userspace_map_gpa(vcpu);
+	}
+}
+
+/*
+ * Handle conversion of memory with @size beginning @gpa for @vm. Set
+ * @shared_to_private to true for shared to private conversions and false
+ * otherwise.
+ *
+ * Since this is just for selftests, just keep both pieces of backing
+ * memory allocated and not deallocate/allocate memory; just do the
+ * minimum of calling KVM_MEMORY_ENCRYPT_REG_REGION and
+ * KVM_MEMORY_ENCRYPT_UNREG_REGION.
+ */
+void handle_memory_conversion(struct kvm_vm *vm, uint32_t vcpu_id, uint64_t gpa,
+			      uint64_t size, bool shared_to_private)
+{
+	struct kvm_memory_attributes range;
+
+	range.address = gpa;
+	range.size = size;
+	range.attributes = shared_to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
+	range.flags = 0;
+
+	pr_debug("\t... call KVM_SET_MEMORY_ATTRIBUTES ioctl from vCPU %u with gpa=%#lx, size=%#lx, attributes=%#llx\n",
+		 vcpu_id, gpa, size, range.attributes);
+
+	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &range);
 }
diff --git a/tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c b/tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c
new file mode 100644
index 000000000000..79745e36ce3a
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm.h>
+#include <stdint.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
+#include "tdx/test_util.h"
+#include "test_util.h"
+
+#define TDX_SHARED_MEM_TEST_PRIVATE_GVA (0x80000000)
+#define TDX_SHARED_MEM_TEST_VADDR_SHARED_MASK BIT_ULL(30)
+#define TDX_SHARED_MEM_TEST_SHARED_GVA     \
+	(TDX_SHARED_MEM_TEST_PRIVATE_GVA | \
+	 TDX_SHARED_MEM_TEST_VADDR_SHARED_MASK)
+
+#define TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE (0xcafecafe)
+#define TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE (0xabcdabcd)
+
+#define TDX_SHARED_MEM_TEST_INFO_PORT 0x87
+
+/*
+ * Shared variable between guest and host
+ */
+static uint64_t test_mem_shared_gpa;
+
+void guest_shared_mem(void)
+{
+	uint32_t *test_mem_shared_gva =
+		(uint32_t *)TDX_SHARED_MEM_TEST_SHARED_GVA;
+
+	uint64_t placeholder;
+	uint64_t ret;
+
+	/* Map gpa as shared */
+	ret = tdg_vp_vmcall_map_gpa(test_mem_shared_gpa, PAGE_SIZE,
+				    &placeholder);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	*test_mem_shared_gva = TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE;
+
+	/* Exit so host can read shared value */
+	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+					   PORT_WRITE, &placeholder);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	/* Read value written by host and send it back out for verification */
+	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+					   PORT_WRITE,
+					   (uint64_t *)test_mem_shared_gva);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+}
+
+int verify_shared_mem(void)
+{
+	vm_vaddr_t test_mem_private_gva;
+	uint64_t test_mem_private_gpa;
+	uint32_t *test_mem_hva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_shared_mem);
+
+	/*
+	 * Set up shared memory page for testing by first allocating as private
+	 * and then mapping the same GPA again as shared. This way, the TD does
+	 * not have to remap its page tables at runtime.
+	 */
+	test_mem_private_gva = vm_vaddr_alloc(vm, vm->page_size,
+					      TDX_SHARED_MEM_TEST_PRIVATE_GVA);
+	TEST_ASSERT_EQ(test_mem_private_gva, TDX_SHARED_MEM_TEST_PRIVATE_GVA);
+
+	test_mem_hva = addr_gva2hva(vm, test_mem_private_gva);
+	TEST_ASSERT(test_mem_hva,
+		    "Guest address not found in guest memory regions\n");
+
+	test_mem_private_gpa = addr_gva2gpa(vm, test_mem_private_gva);
+	virt_map_shared(vm, TDX_SHARED_MEM_TEST_SHARED_GVA, test_mem_private_gpa, 1);
+
+	test_mem_shared_gpa = test_mem_private_gpa | vm->arch.s_bit;
+	sync_global_to_guest(vm, test_mem_shared_gpa);
+
+	td_finalize(vm);
+
+	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, BIT_ULL(KVM_HC_MAP_GPA_RANGE));
+
+	printf("Verifying shared memory accesses for TDX\n");
+
+	/* Begin guest execution; guest writes to shared memory. */
+	printf("\t ... Starting guest execution\n");
+
+	/* Handle map gpa as shared */
+	tdx_run(vcpu);
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4, PORT_WRITE);
+	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
+
+	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4, PORT_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		       TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE);
+
+	printf("\t ... PASSED\n");
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (!is_tdx_enabled()) {
+		printf("TDX is not supported by the KVM\n"
+		       "Skipping the TDX tests.\n");
+		return 0;
+	}
+
+	return verify_shared_mem();
+}
-- 
2.49.0.504.g3bcea36a83-goog


