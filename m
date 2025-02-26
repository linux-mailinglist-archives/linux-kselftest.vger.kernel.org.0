Return-Path: <linux-kselftest+bounces-27550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CBA451FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8616E6A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F819ABCE;
	Wed, 26 Feb 2025 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfmYjdG/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E712192D76;
	Wed, 26 Feb 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532065; cv=none; b=VT/ZSZIU+nQfUT6y7yfvSl7RzZE+M85aDo00hddwIrWULN0Mc0gM2/zPwVFESHpRLx9nVQ4QlRttZqws1eR8loWmt3A2JcwjtYkIuCeIpUvO3XeP4+Gqeaz8XBEqMHdpttlhlShezyQzO/1YYeklG+oEygjTpZlNeE2dkLUOtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532065; c=relaxed/simple;
	bh=QOJubvXVS/z+HN4zuJjtVNV1JTEpRBGWWqwVUZO8LIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX/xNZS7q6Rd84hZtE56ZjJBzZCcjxMyoSfyN0Exr0ZMzycqa1q7drFudtYIqCPLCS70SO/aD3OJQrgVK10mmNMhYF0gddAP0ZZLkbeXMZQ8rUKnMjNrRsBAfGggW3HT8gqD8Pt2HoPDv6I3gRSMCUHGE/A7+FMxMogHdwYsGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfmYjdG/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532063; x=1772068063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOJubvXVS/z+HN4zuJjtVNV1JTEpRBGWWqwVUZO8LIc=;
  b=lfmYjdG/Y0fLrFgsnyhinUfkiuOqjT6GiEKC8OfZp/7JMyiVEaV8c5aT
   +B9AM5HMyNgJ9qiMQ03o8sunSJfCdXg+SE7NfYb+VWl/aaeYqAqFxHGmf
   8bJcl1Eik1W2G24wvN5hfGr9lBr6yrH4+KY+CVrG+BDofwjB+xlW3LBij
   BiSVFFCSkDTPIftnS8qI/7raC30ftWLuC5IhxCWBFDmbgZ/Wux+xN5ulP
   Z0kg/RSLWZ2TIPg8o2TodhQX9Knwz8LHZ0cf1lIxyj8l75rnBFBYxOsg0
   /AMPbSki8Sxolka8WJci993uYAy1g8zXxOQR6/em4qN9vS+WYc/OhHe1s
   Q==;
X-CSE-ConnectionGUID: 5feO+N/lTQaSYXCPUNdXvg==
X-CSE-MsgGUID: 07gsZhJDSOKEeK/vQZE6rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362233"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362233"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:43 -0800
X-CSE-ConnectionGUID: hJErFlpRSMebY3lem8Horg==
X-CSE-MsgGUID: 3v3Eec9NQe2TzaXxrRCxnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467368"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:42 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	shuah@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH 9/9] selftests/x86/avx: Add AVX test
Date: Tue, 25 Feb 2025 17:07:29 -0800
Message-ID: <20250226010731.2456-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226010731.2456-1-chang.seok.bae@intel.com>
References: <20250226010731.2456-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add xstate testing specifically for those vector register states,
validating kernel's context switching and ensuring ABI compliance.
Use the established xstate testing framework.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Alternatively, this invocation could be placed directly in
xstate.c::main(). However, the current test file naming convention, which
clearly specifies the tested area, seems reasonable. Adding avx.c
considerably aligns with that convention.

The test output should be like this for ZMM_Hi256 as an example:
$ avx_64
...
[RUN]   AVX-512 ZMM_Hi256: check context switches, 10 iterations, 5 threads.
[OK]    No incorrect case was found.
[RUN]   AVX-512 ZMM_Hi256: inject xstate via ptrace().
[OK]    'xfeatures' in SW reserved area was correctly written
[OK]    xstate was correctly updated.
[RUN]   AVX-512 ZMM_Hi256: load xstate and raise SIGUSR1
[OK]    'magic1' is valid
[OK]    'xfeatures' in SW reserved area is valid
[OK]    'xfeatures' in XSAVE header is valid
[OK]    xstate delivery was successful
[OK]    'magic2' is valid
[RUN]   AVX-512 ZMM_Hi256: load new xstate from sighandler and check it after sigreturn
[OK]    xstate was restored correctly

But systems without AVX-512 will look like:
...
The kernel does not support feature number: 5
The kernel does not support feature number: 6
The kernel does not support feature number: 7
---
 tools/testing/selftests/x86/Makefile |  4 +++-
 tools/testing/selftests/x86/avx.c    | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/avx.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index f15efdc6aef7..28422c32cc8f 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -19,7 +19,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx lam test_shadow_stack
+			corrupt_xstate_header amx lam test_shadow_stack avx
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -133,4 +133,6 @@ $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
 
+$(OUTPUT)/avx_64: CFLAGS += -mno-avx -mno-avx512f
 $(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
+$(OUTPUT)/avx_64: EXTRA_FILES += xstate.c
diff --git a/tools/testing/selftests/x86/avx.c b/tools/testing/selftests/x86/avx.c
new file mode 100644
index 000000000000..11d5367c235f
--- /dev/null
+++ b/tools/testing/selftests/x86/avx.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE /* Required for inline xstate helpers */
+#include "xstate.h"
+
+int main(void)
+{
+	test_xstate(XFEATURE_YMM);
+	test_xstate(XFEATURE_OPMASK);
+	test_xstate(XFEATURE_ZMM_Hi256);
+	test_xstate(XFEATURE_Hi16_ZMM);
+}
-- 
2.45.2


