Return-Path: <linux-kselftest+bounces-17049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191596A111
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFF828B0CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E1188921;
	Tue,  3 Sep 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDXlRrEA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA9153BE4;
	Tue,  3 Sep 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374778; cv=none; b=iLQ95GrfRM+//BHa2CVjFu0NG9Lm5QnYH7KGD7xyjavN6NmHyWSyuWGpVG3acNTJQeCOWr3ezqlRuPnxGWQD4IuXm7yogR1kDCGEKlCOspqINEYpjSPQkjTZIuVgxqSW1OBBwjPCcWO2sQAnvW+pHlsuASOzadmu9DGTo1wKp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374778; c=relaxed/simple;
	bh=LUoij1ccctcrHN5PWV8R3XWhlyhZ6J0cEf6JBISm754=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxcLtG9rLwXqbl2CULu4BgNtyTHUGk9Qsi/tgTEr7J/kkchdGSD7tYSrX5ZKvn1sIrBl0io4l9fu/rR69d3d2oNxm/yAHv3JLk+M+YPL4V0GP1J8soDrOPxQ6RA02xAI6O7FxhqXdCioyKNyUA888UzBoGaXWzBjwZTY5ZOfXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDXlRrEA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374777; x=1756910777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LUoij1ccctcrHN5PWV8R3XWhlyhZ6J0cEf6JBISm754=;
  b=gDXlRrEA5ijHLji+xA1yUsbJxQVLISpHbdlzKZvGv8eRDIUWjdmTgLXG
   vBW8Cf80MUCuNVsLQW1VVxmfxuYtnp60FYCDsApYQ3Wewi/CLnYTBIXxu
   n91DIUc3RU4wbakzcBytemf9Ra9EkrF4xXNfm0TYlE8jGTGvx8spQYTLz
   hDCmy317GY6cjoey7xITCeS+GLWGpc9PwPU5huNEck8Tu8l6lsW0846tE
   gibixruttQUzv7p++qhoGgnIpKnXGdqiK4NVLn/hLhR8CZIIYvHnByDbx
   6GupOrbjF8u1+pNSvDdLjyVT2Jduqn5wY5rC6V/9halul997C7x+XCkMI
   A==;
X-CSE-ConnectionGUID: 6NTMZWZzRYO00xsmedw0Ew==
X-CSE-MsgGUID: qE/XUX52QxSp7Tm+f2RNXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="49384137"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="49384137"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:46:16 -0700
X-CSE-ConnectionGUID: y569VU89SuOHLxLIURFrQw==
X-CSE-MsgGUID: t9vgbS2kSwKYi3Of+0CrMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64610741"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:46:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 4/4] kselftest: Provide __cpuid_count() stub on non-x86 archs
Date: Tue,  3 Sep 2024 17:45:28 +0300
Message-Id: <20240903144528.46811-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
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
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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


