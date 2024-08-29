Return-Path: <linux-kselftest+bounces-16680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED8964641
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11287B22AB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297751A76D2;
	Thu, 29 Aug 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjeFMe7R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FFF1946C4;
	Thu, 29 Aug 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937460; cv=none; b=G6Xi/6QLprpgIWzZnIEd0rN8yg4AzMHQIztHKNPfksMP7pFE2GsjTHokITQz7tl40buPznhOYU+8iPLYx7ZSA56FlS12b1iCLoH6gSLpRh/Q5p1vn+OM+uQNAybFhOKu+Pok8BLdCmoIaPPVuCVVkrt5Vt9K0JKr3OWrBKJVweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937460; c=relaxed/simple;
	bh=vd4hmH7m4TRltyAYl86p9WBSPwN5Pa4yCsqfc0W/Wr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eR+IDXvTQnlmYDmxEYbFAjQNh+hl8h5iLltFvYpy3yAgUxMgQPUlu02l10mkAUYK4AyxHC5r0+CPpuN3+aik0+coCsE3SIPfF8IWRdLAGCX8fTG90xPWAc5ZVMH7jn2wnhza8u2mvoUw+u92GqEa7140omwVF7/ZV4+YpG/hByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjeFMe7R; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724937458; x=1756473458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vd4hmH7m4TRltyAYl86p9WBSPwN5Pa4yCsqfc0W/Wr8=;
  b=kjeFMe7Rdqx5RFSrkxcOgxs8lBcBnRL+Yf5+nQnPE/jJaap5WAz7xExE
   Ht0WS1vEE3N4LG2vyHdYakxt+YtcHds5w5V2A5A+lMkyW+BVfqdD0v0T9
   vvNIMcQXey/xXy1BiWm/ALZgvReS0iAQ8ERsEow4ISHCd7fb1bGg3Xz9/
   MyeL9dH8Fptp0sKLH33XeD1eN6EnPnoJgImxl7ECDZVK6VbtTczXDUhQB
   HoO/f72L+xN4L18LkMnp2NTftPxBCgjvn6ncX4fuFYN0PuDRqjWpfWU8y
   gUO+/+Xb78m0JWucv8i/HZUVizcWtQmreIrsZBi7iO9bL78zf1x9tkKdI
   w==;
X-CSE-ConnectionGUID: bMEs7/HJSs+Elxk3YGkKJw==
X-CSE-MsgGUID: PJ29d5GWRSaVFg5QV+2ODw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23656536"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23656536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:17:38 -0700
X-CSE-ConnectionGUID: +a2GMF3LRYaVi/zc5uxDxQ==
X-CSE-MsgGUID: GuomcuL3RgCGTy5MDc07Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68461099"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:17:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 3/3] kselftest: Provide __cpuid_count() stub on non-x86 archs
Date: Thu, 29 Aug 2024 16:16:57 +0300
Message-Id: <20240829131657.1917-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829131657.1917-1-ilpo.jarvinen@linux.intel.com>
References: <20240829131657.1917-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building resctrl selftest fails on ARM because it uses __cpuid_count()
that fails the build with error:

  CC       resctrl_tests
In file included from resctrl.h:24,
                 from cat_test.c:11:
In function 'arch_supports_noncont_cat',
    inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
../kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"       \
      |         ^~~~~~~
cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
  301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~
../kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"       \
      |         ^~~~~~~
cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
  303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~

The resctrl selftest would run that code only on Intel CPUs but as is,
the code cannot be build at all.

Define HAVE_CPUID in lib.mk based on ARCH (x86 or x86_64). If ARCH is
not set, acquire it using uname -m.

Provide a stub for __cpuid_count() if HAVE_CPUID is not present to
allow build to succeed. The stub casts its arguments to void to avoid
causing "unused variable" or "set but not used" warnings.

Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v3:
- Remove "empty" wording
- Also cast input parameters to void
- Initialize ARCH from uname -m if not set (this might allow cleaning
  up some other makefiles but that is left as future work)
v2:
- Removed RFC & added Fixes and Tested-by
- Fixed the error message's line splits
- Noted down the reason for void casts in the stub
---
 tools/testing/selftests/kselftest.h | 6 ++++++
 tools/testing/selftests/lib.mk      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index b8967b6e29d5..9c4bfbf107f1 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -70,10 +70,16 @@
  * have __cpuid_count().
  */
 #ifndef __cpuid_count
+#ifdef HAVE_CPUID
 #define __cpuid_count(level, count, a, b, c, d)				\
 	__asm__ __volatile__ ("cpuid\n\t"				\
 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
 			      : "0" (level), "2" (count))
+#else
+#define __cpuid_count(level, count, a, b, c, d)	do {			\
+	(void)level; (void)count; (void)a; (void)b; (void)c; (void)d;	\
+} while (0)
+#endif
 #endif
 
 /* define kselftest exit codes */
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be8..8e3069926153 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -23,6 +23,8 @@ CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
 
 # Default to host architecture if ARCH is not explicitly given.
 ifeq ($(ARCH),)
+ARCH := $(shell uname -m 2>/dev/null || echo not)
+ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/)
 CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
 else
 CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
@@ -199,6 +201,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 # Build with _GNU_SOURCE by default
 CFLAGS += -D_GNU_SOURCE=
 
+ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
+CFLAGS += -DHAVE_CPUID=
+endif
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.39.2


