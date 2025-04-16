Return-Path: <linux-kselftest+bounces-30792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E5A88E83
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BC016AB0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC3237702;
	Mon, 14 Apr 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drzEo7nZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04E2356A8
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667364; cv=none; b=aj1OA4eRocx62U3IPx+UdNIxwyYXwFseALGQyQz3nGznLrralKDMR+4fv9M0cHDiJHKdmnvgueVw3mv4Lz6rIxOVrG9Z7176gF2C2FuQwn3QSPrXhVdEd2ieVSOgFmdBPkso3YuIVhvLT7Pl6qW6TeAlboTzcjph7HvS0BnJLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667364; c=relaxed/simple;
	bh=H1EcyQu09O9vJ+7MBWKzluqZHBE/szAn5KBp3dxJ8jU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YQSaQXH5U8rn5h2nfrReJO/TEo6hrF9y+I2TURFecBgxb0m1U39j9cdZXqjWbTb2Nppy5KiaMD+JTigxHUbf78KL6yuGK9q6O75Brf//BklDowkgjoRNuUyxjkCckvROIluXPD0tBsFLp7VSv4+YHGPxVYu11gnhbE61zmVPVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drzEo7nZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b078af4b07dso960047a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667361; x=1745272161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ShYu1Ix6wRor+MKQhCjJs29qS028EQsdCGGCbn52WRw=;
        b=drzEo7nZUdAvRcUSnYyzWtdU+X4C8mZZKpvAoRP4TrY1SpIzwxGGYrS5edfY5H1Sz7
         dUk7PYlucVbyyZcqm5bGVcdxAzyOegjWSIme2B2hGu5GnPDjPmsLFrywePIFhePLF4B8
         wD8X9W3sLJ1WPUcfF1rIYrq6y1b4nAydzuR2mWyYe/5Oiqetg8/L8FtypYybL60KwOIJ
         nq3lNPWLlBPQAIq2LF9XZLw8h9ZbcaUCJt19/AMYTpXjLtHwdylyfze/m2ql5N3iaf8A
         HQi5EQGgVwEgwxwHL0X3tQxLqSvIdEi9oxG8RVibXrHYFQzG3YLDJ4b0969uIlsvPvmn
         ecLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667361; x=1745272161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShYu1Ix6wRor+MKQhCjJs29qS028EQsdCGGCbn52WRw=;
        b=XJYGHeRKU+naLhZFNLuGiimy5CNfnV45z5m3VQC9upE0jJPUa/Z9EQV4B4Xvol5SOl
         7CeP6PadSSjpP8JLG1rG0UyRC1Tol8Vy1rUxrjbSitjSeWcoqanmnWEnvVCvnFYQenVV
         jtYbZ2dz4PYzcu6bkzpYA3ueXRudbH5Bgd1kOvo+tRs+kc3K4HwwL8TRSfLfXhwNDQjj
         Vf05eUHVMBUcXD4VUYvMgtglcUVYTZyh5DyVaYPFuDJH3RRvQedkPm3dPRrmXbOnwKGa
         aDtdXNwnIOlnR4C2LkcYpRRm0zD26DwDtHcH22kntZz8a39M9xz598V3p8NIdGhOXDuw
         ZdjQ==
X-Gm-Message-State: AOJu0YythIvdY8xCAnSmXX9O0xP06Ep/7eV4tZWz+64G7Ron8a/4bdqI
	EXMp7zJACGoAGcKklaD7TC7NPMUgXf0CPkrkaE2tSvbtsFlAcAlk3YaOS9B3w4WUMGR0W75aTy2
	G52qTTPIyS1Va05ChrLzzhGiXUotNfINO1z4NyGRIJJNy04hy5g9C/gAnRhiSJyWMte78mMGj4C
	SaLmwSFKt16lLxFU78wwdkYpX5qaHZuivWcC+JnVc=
X-Google-Smtp-Source: AGHT+IGBINvUU9UrzE8xw8jzj9yOBHBVK5lRUh3vUjOhnJdIvZ/YfYjtxTZtehNauBJcfG9B5gyRKZRYNQ==
X-Received: from pfbfu7.prod.google.com ([2002:a05:6a00:6107:b0:739:8cd6:c16c])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f03:b0:1fd:f4df:9a89
 with SMTP id adf61e73a8af0-201797c367cmr18462874637.25.1744667361103; Mon, 14
 Apr 2025 14:49:21 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:57 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-29-sagis@google.com>
Subject: [PATCH v6 28/30] KVM: selftests: TDX: Add TDX UPM selftest
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

From: Ackerley Tng <ackerleytng@google.com>

This tests the use of guest memory with explicit TDG.VP.VMCALL<MapGPA>
calls.

Provide a 2MB memory region to the TDX guest with a 40KB focus area at
offset 1MB intended to be shared between host and guest. The entire 2MB
region starts out as private with the guest filling it with a pattern and
a check from the host to ensure the host is not able to see the pattern.
The guest then requests via TDG.VP.VMCALL<MapGPA> that the 40KB focus area
be shared with checks that the host and guest has the same view of the
memory. Finally the guest requests the 40KB memory to be private again
with checks to confirm this is the case.

Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/x86/tdx_upm_test.c  | 397 ++++++++++++++++++
 2 files changed, 398 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_upm_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9f660f913715..94322d8dea88 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -146,6 +146,7 @@ TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
 TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 TEST_GEN_PROGS_x86 += x86/tdx_shared_mem_test
+TEST_GEN_PROGS_x86 += x86/tdx_upm_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/x86/tdx_upm_test.c b/tools/testing/selftests/kvm/x86/tdx_upm_test.c
new file mode 100644
index 000000000000..387258ab1a62
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_upm_test.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/kvm.h>
+#include <asm/vmx.h>
+#include <linux/kvm.h>
+#include <linux/sizes.h>
+#include <stdbool.h>
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
+/* TDX UPM test patterns */
+#define PATTERN_CONFIDENCE_CHECK (0x11)
+#define PATTERN_HOST_FOCUS (0x22)
+#define PATTERN_GUEST_GENERAL (0x33)
+#define PATTERN_GUEST_FOCUS (0x44)
+
+/*
+ * 0x80000000 is arbitrarily selected. The selected address need not be the same
+ * as TDX_UPM_TEST_AREA_GVA_PRIVATE, but it should not overlap with selftest
+ * code or boot page.
+ */
+#define TDX_UPM_TEST_AREA_GPA (0x80000000)
+/* Test area GPA is arbitrarily selected */
+#define TDX_UPM_TEST_AREA_GVA_PRIVATE (0x90000000)
+/* Select any bit that can be used as a flag */
+#define TDX_UPM_TEST_AREA_GVA_SHARED_BIT (32)
+/*
+ * TDX_UPM_TEST_AREA_GVA_SHARED is used to map the same GPA twice into the
+ * guest, once as shared and once as private
+ */
+#define TDX_UPM_TEST_AREA_GVA_SHARED				\
+	(TDX_UPM_TEST_AREA_GVA_PRIVATE |			\
+		BIT_ULL(TDX_UPM_TEST_AREA_GVA_SHARED_BIT))
+
+/* The test area is 2MB in size */
+#define TDX_UPM_TEST_AREA_SIZE SZ_2M
+/* 0th general area is 1MB in size */
+#define TDX_UPM_GENERAL_AREA_0_SIZE SZ_1M
+/* Focus area is 40KB in size */
+#define TDX_UPM_FOCUS_AREA_SIZE (SZ_32K + SZ_8K)
+/* 1st general area is the rest of the space in the test area */
+#define TDX_UPM_GENERAL_AREA_1_SIZE				\
+	(TDX_UPM_TEST_AREA_SIZE - TDX_UPM_GENERAL_AREA_0_SIZE -	\
+		TDX_UPM_FOCUS_AREA_SIZE)
+
+/*
+ * The test memory area is set up as two general areas, sandwiching a focus
+ * area.  The general areas act as control areas. After they are filled, they
+ * are not expected to change throughout the tests. The focus area is memory
+ * permissions change from private to shared and vice-versa.
+ *
+ * The focus area is intentionally small, and sandwiched to test that when the
+ * focus area's permissions change, the other areas' permissions are not
+ * affected.
+ */
+struct __packed tdx_upm_test_area {
+	uint8_t general_area_0[TDX_UPM_GENERAL_AREA_0_SIZE];
+	uint8_t focus_area[TDX_UPM_FOCUS_AREA_SIZE];
+	uint8_t general_area_1[TDX_UPM_GENERAL_AREA_1_SIZE];
+};
+
+static void fill_test_area(struct tdx_upm_test_area *test_area_base,
+			   uint8_t pattern)
+{
+	memset(test_area_base, pattern, sizeof(*test_area_base));
+}
+
+static void fill_focus_area(struct tdx_upm_test_area *test_area_base,
+			    uint8_t pattern)
+{
+	memset(test_area_base->focus_area, pattern,
+	       sizeof(test_area_base->focus_area));
+}
+
+static bool check_area(uint8_t *base, uint64_t size, uint8_t expected_pattern)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++) {
+		if (base[i] != expected_pattern)
+			return false;
+	}
+
+	return true;
+}
+
+static bool check_general_areas(struct tdx_upm_test_area *test_area_base,
+				uint8_t expected_pattern)
+{
+	return (check_area(test_area_base->general_area_0,
+			   sizeof(test_area_base->general_area_0),
+			   expected_pattern) &&
+		check_area(test_area_base->general_area_1,
+			   sizeof(test_area_base->general_area_1),
+			   expected_pattern));
+}
+
+static bool check_focus_area(struct tdx_upm_test_area *test_area_base,
+			     uint8_t expected_pattern)
+{
+	return check_area(test_area_base->focus_area,
+			  sizeof(test_area_base->focus_area), expected_pattern);
+}
+
+static bool check_test_area(struct tdx_upm_test_area *test_area_base,
+			    uint8_t expected_pattern)
+{
+	return (check_general_areas(test_area_base, expected_pattern) &&
+		check_focus_area(test_area_base, expected_pattern));
+}
+
+static bool fill_and_check(struct tdx_upm_test_area *test_area_base, uint8_t pattern)
+{
+	fill_test_area(test_area_base, pattern);
+
+	return check_test_area(test_area_base, pattern);
+}
+
+#define TDX_UPM_TEST_ASSERT(x)				\
+	do {						\
+		if (!(x))				\
+			tdx_test_fatal(__LINE__);	\
+	} while (0)
+
+/*
+ * Shared variables between guest and host
+ */
+static struct tdx_upm_test_area *test_area_gpa_private;
+static struct tdx_upm_test_area *test_area_gpa_shared;
+
+/*
+ * Test stages for syncing with host
+ */
+enum {
+	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST = 1,
+	SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST,
+	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN,
+};
+
+#define TDX_UPM_TEST_ACCEPT_PRINT_PORT 0x87
+
+/*
+ * Does vcpu_run, and also manages memory conversions if requested by the TD.
+ */
+void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
+					    struct kvm_vcpu *vcpu)
+{
+	for (;;) {
+		vcpu_run(vcpu);
+		if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL &&
+		    vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE) {
+			uint64_t gpa = vcpu->run->hypercall.args[0];
+
+			handle_memory_conversion(vm, vcpu->id, gpa,
+						 vcpu->run->hypercall.args[1] << 12,
+						 vcpu->run->hypercall.args[2] &
+						  KVM_MAP_GPA_RANGE_ENCRYPTED);
+			vcpu->run->hypercall.ret = 0;
+			continue;
+		} else if (vcpu->run->exit_reason == KVM_EXIT_IO &&
+			   vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
+			uint64_t gpa = tdx_test_read_64bit(vcpu,
+							   TDX_UPM_TEST_ACCEPT_PRINT_PORT);
+
+			printf("\t ... guest accepting 1 page at GPA: 0x%lx\n",
+			       gpa);
+			continue;
+		} else if (vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT) {
+			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n",
+				  vcpu->run->system_event.data[12],
+				  vcpu->run->system_event.data[13]);
+		}
+		break;
+	}
+}
+
+static void guest_upm_explicit(void)
+{
+	struct tdx_upm_test_area *test_area_gva_private =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
+	struct tdx_upm_test_area *test_area_gva_shared =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
+	uint64_t failed_gpa;
+	uint64_t ret = 0;
+
+	/* Check: host reading private memory does not modify guest's view */
+	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	TDX_UPM_TEST_ASSERT(check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Remap focus area as shared */
+	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_shared->focus_area,
+				    sizeof(test_area_gpa_shared->focus_area),
+				    &failed_gpa);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/*
+	 * Use memory contents to confirm that the memory allocated using mmap
+	 * is used as backing memory for shared memory - PATTERN_CONFIDENCE_CHECK
+	 * was written by the VMM at the beginning of this test.
+	 */
+	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_shared, PATTERN_CONFIDENCE_CHECK));
+
+	/* Guest can use focus area after remapping as shared */
+	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	/* Check that guest has the same view of shared memory */
+	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
+
+	/* Remap focus area back to private */
+	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_private->focus_area,
+				    sizeof(test_area_gpa_private->focus_area),
+				    &failed_gpa);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Focus area should be zeroed after remapping */
+	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_private, 0));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	/* Check that guest can use private memory after focus area is remapped as private */
+	TDX_UPM_TEST_ASSERT(fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_success();
+}
+
+static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+			 struct tdx_upm_test_area *test_area_base_hva)
+{
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+			   PORT_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		       SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	/*
+	 * Check that host sees PATTERN_CONFIDENCE_CHECK when trying to read guest
+	 * private memory. This confirms that regular memory (userspace_addr in
+	 * struct kvm_userspace_memory_region) is used to back the host's view
+	 * of private memory, since PATTERN_CONFIDENCE_CHECK was written to that
+	 * memory before starting the guest.
+	 */
+	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		    "Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
+
+	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+			   PORT_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		       SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_GUEST_FOCUS),
+		    "Host should have the same view of shared memory as guest.");
+	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		    "Host's view of private memory should still be backed by regular memory.");
+
+	/* Check that host can use shared memory */
+	fill_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS);
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
+		    "Host should be able to use shared memory.");
+
+	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+			   PORT_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		       SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		    "Host's view of private memory should be backed by regular memory.");
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
+		    "Host's view of private memory should be backed by regular memory.");
+
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	printf("\t ... PASSED\n");
+}
+
+static bool address_between(uint64_t addr, void *lo, void *hi)
+{
+	return (uint64_t)lo <= addr && addr < (uint64_t)hi;
+}
+
+static void guest_ve_handler(struct ex_regs *regs)
+{
+	struct ve_info ve;
+	uint64_t ret;
+
+	ret = tdg_vp_veinfo_get(&ve);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* For this test, we will only handle EXIT_REASON_EPT_VIOLATION */
+	TDX_UPM_TEST_ASSERT(ve.exit_reason == EXIT_REASON_EPT_VIOLATION);
+
+	/* Validate GPA in fault */
+	TDX_UPM_TEST_ASSERT(address_between(ve.gpa,
+					    test_area_gpa_private->focus_area,
+					    test_area_gpa_private->general_area_1));
+
+	tdx_test_send_64bit(TDX_UPM_TEST_ACCEPT_PRINT_PORT, ve.gpa);
+
+#define MEM_PAGE_ACCEPT_LEVEL_4K 0
+#define MEM_PAGE_ACCEPT_LEVEL_2M 1
+	ret = tdg_mem_page_accept(ve.gpa & PAGE_MASK, MEM_PAGE_ACCEPT_LEVEL_4K);
+	TDX_UPM_TEST_ASSERT(!ret);
+}
+
+static void verify_upm_test(void)
+{
+	struct tdx_upm_test_area *test_area_base_hva;
+	vm_vaddr_t test_area_gva_private;
+	uint64_t test_area_npages;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
+
+	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
+
+	/*
+	 * Set up shared memory page for testing by first allocating as private
+	 * and then mapping the same GPA again as shared. This way, the TD does
+	 * not have to remap its page tables at runtime.
+	 */
+	test_area_npages = TDX_UPM_TEST_AREA_SIZE / vm->page_size;
+	vm_userspace_mem_region_add(vm,
+				    VM_MEM_SRC_ANONYMOUS, TDX_UPM_TEST_AREA_GPA,
+				    3, test_area_npages, KVM_MEM_GUEST_MEMFD);
+	vm->memslots[MEM_REGION_TEST_DATA] = 3;
+
+	test_area_gva_private = vm_vaddr_alloc_private(vm, TDX_UPM_TEST_AREA_SIZE,
+						       TDX_UPM_TEST_AREA_GVA_PRIVATE,
+						       TDX_UPM_TEST_AREA_GPA,
+						       MEM_REGION_TEST_DATA);
+	TEST_ASSERT_EQ(test_area_gva_private, TDX_UPM_TEST_AREA_GVA_PRIVATE);
+
+	test_area_gpa_private = (struct tdx_upm_test_area *)
+		addr_gva2gpa(vm, test_area_gva_private);
+	virt_map_shared(vm, TDX_UPM_TEST_AREA_GVA_SHARED,
+			(uint64_t)test_area_gpa_private,
+			test_area_npages);
+	TEST_ASSERT_EQ(addr_gva2gpa(vm, TDX_UPM_TEST_AREA_GVA_SHARED),
+		       (vm_paddr_t)test_area_gpa_private);
+
+	test_area_base_hva = addr_gva2hva(vm, TDX_UPM_TEST_AREA_GVA_PRIVATE);
+
+	TEST_ASSERT(fill_and_check(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		    "Failed to mark memory intended as backing memory for TD shared memory");
+
+	sync_global_to_guest(vm, test_area_gpa_private);
+	test_area_gpa_shared = (struct tdx_upm_test_area *)
+		((uint64_t)test_area_gpa_private | vm->arch.s_bit);
+	sync_global_to_guest(vm, test_area_gpa_shared);
+
+	td_finalize(vm);
+
+	printf("Verifying UPM functionality: explicit MapGPA\n");
+
+	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, BIT_ULL(KVM_HC_MAP_GPA_RANGE));
+
+	run_selftest(vm, vcpu, test_area_base_hva);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+
+	if (!is_tdx_enabled())
+		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
+
+	ksft_set_plan(1);
+	ksft_test_result(!run_in_new_process(&verify_upm_test),
+			 "verify_upm_test\n");
+
+	ksft_finished();
+}
-- 
2.49.0.504.g3bcea36a83-goog


