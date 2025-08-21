Return-Path: <linux-kselftest+bounces-39486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F1DB2FACF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292CD1CE76B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAA2DF6F8;
	Thu, 21 Aug 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBMcGnCG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A535A2AE;
	Thu, 21 Aug 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783135; cv=none; b=ags1BBj/k71bGrcUFHYeOvzuDetH5iIgwDqZ4h16fZ5U7PKNftgFK5W/sdU5E0rFUgsGiGTS8stZtiwD2Fr6zS9whBOUZo0WDCeo+cR1oOxz8D/9T6zHcghyZKOQrLLjY56pquhBOWXiggCd7n8imKIkcS2E0417SCCRJTwwrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783135; c=relaxed/simple;
	bh=l7haChJ78imCpKftjoInXbwL2PEsUuJWzy/NxujNchU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNMuZPIHh/AFpq0YrF5fV8d1tsYwuouo7z8kPZ2oyBnJyQDWpvCVOH8a5jIkV9DmW+Mi9cFK0ONus0560WEWKJjWw0woOZMvnlS+Ou+DW9HtXexyYN2kYLKohBq4h+3HUKsdyX5oHYUwv1x4r+26x/8mnrj21fOUrvUgkfaZLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBMcGnCG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755783134; x=1787319134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l7haChJ78imCpKftjoInXbwL2PEsUuJWzy/NxujNchU=;
  b=EBMcGnCGjwgkpNqU9qbNBv+Px4b9vGOjVWxBDol22+MzstbDxSOWvEIt
   H3QtsI8HmzodBzYur3z3Ij+gAvA1B9tGzDqgRm5UGv9XcKVeLLeOVPOeU
   ymDw8k3hcLr9/rVxMnU6Kx+VmhofBrNKN0tk6b6oaI/7EdRd6tRwDDWsf
   9igRDCXf+7++ZGFLsBKixzw+HOh9q6hk+o94dbw9C6QBy43dLzqJOLckm
   QfBXKFYuD1hTOU+B8a5FoAegJBefvSfU9iNhR7dLA8KihD143htQ7L+eZ
   9jFIzolliBMcrMmhAUf9POT6qu7kwvLCqQP1fgYgAaBbMK8UC1f0RJKR4
   Q==;
X-CSE-ConnectionGUID: mW890sw+T3CviqsXrA0P7w==
X-CSE-MsgGUID: 3mb9j+YUS+Wg3NLccqnd8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69446246"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69446246"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:32:04 -0700
X-CSE-ConnectionGUID: GorXoETKRbqosfJGfk3OXg==
X-CSE-MsgGUID: M78ceGyDQLOd/yONsp4fCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199285455"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:32:03 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: chao.gao@intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	john.allen@amd.com,
	mingo@redhat.com,
	minipli@grsecurity.net,
	mlevitsk@redhat.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	seanjc@google.com,
	tglx@linutronix.de,
	weijiang.yang@intel.com,
	x86@kernel.org,
	xin@zytor.com,
	Shuah Khan <shuah@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	"Pratik R. Sampat" <prsampat@amd.com>
Subject: [PATCH v13 21/21] KVM: selftest: Add tests for KVM_{GET,SET}_ONE_REG
Date: Thu, 21 Aug 2025 06:30:55 -0700
Message-ID: <20250821133132.72322-22-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821133132.72322-1-chao.gao@intel.com>
References: <20250821133132.72322-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for newly added KVM_{GET,SET}_ONE_REG support for x86. Verify the
new ioctls can read and write real MSRs and synthetic MSRs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h         | 24 +++++++++++++
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/x86/get_set_one_reg.c       | 35 +++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/get_set_one_reg.c

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 6f3499507c5e..590762820a61 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -411,6 +411,30 @@ struct kvm_xcrs {
 	__u64 padding[16];
 };
 
+#define KVM_X86_REG_TYPE_MSR		2
+#define KVM_X86_REG_TYPE_SYNTHETIC_MSR	3
+
+#define KVM_X86_REG_TYPE_SIZE(type)						\
+({										\
+	__u64 type_size = (__u64)type << 32;					\
+										\
+	type_size |= type == KVM_X86_REG_TYPE_MSR ? KVM_REG_SIZE_U64 :		\
+		     type == KVM_X86_REG_TYPE_SYNTHETIC_MSR ? KVM_REG_SIZE_U64 :\
+		     0;								\
+	type_size;								\
+})
+
+#define KVM_X86_REG_ENCODE(type, index)				\
+	(KVM_REG_X86 | KVM_X86_REG_TYPE_SIZE(type) | index)
+
+#define KVM_X86_REG_MSR(index)					\
+	KVM_X86_REG_ENCODE(KVM_X86_REG_TYPE_MSR, index)
+#define KVM_X86_REG_SYNTHETIC_MSR(index)			\
+	KVM_X86_REG_ENCODE(KVM_X86_REG_TYPE_SYNTHETIC_MSR, index)
+
+/* KVM synthetic MSR index staring from 0 */
+#define KVM_SYNTHETIC_GUEST_SSP 0
+
 #define KVM_SYNC_X86_REGS      (1UL << 0)
 #define KVM_SYNC_X86_SREGS     (1UL << 1)
 #define KVM_SYNC_X86_EVENTS    (1UL << 2)
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f6fe7a07a0a2..9a375d5faf1c 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -136,6 +136,7 @@ TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
+TEST_GEN_PROGS_x86 += x86/get_set_one_reg
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/get_set_one_reg.c b/tools/testing/selftests/kvm/x86/get_set_one_reg.c
new file mode 100644
index 000000000000..8b069155ddc7
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/get_set_one_reg.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 data;
+	int r;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ONE_REG));
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+
+	TEST_ASSERT_EQ(__vcpu_get_reg(vcpu, KVM_X86_REG_MSR(MSR_EFER), &data), 0);
+	TEST_ASSERT_EQ(__vcpu_set_reg(vcpu, KVM_X86_REG_MSR(MSR_EFER), data), 0);
+
+	if (kvm_cpu_has(X86_FEATURE_SHSTK)) {
+		r = __vcpu_get_reg(vcpu, KVM_X86_REG_SYNTHETIC_MSR(KVM_SYNTHETIC_GUEST_SSP),
+				   &data);
+		TEST_ASSERT_EQ(r, 0);
+		r = __vcpu_set_reg(vcpu, KVM_X86_REG_SYNTHETIC_MSR(KVM_SYNTHETIC_GUEST_SSP),
+				   data);
+		TEST_ASSERT_EQ(r, 0);
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.47.3


