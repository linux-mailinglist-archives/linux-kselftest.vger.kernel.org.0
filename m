Return-Path: <linux-kselftest+bounces-15207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6089502C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6562B286610
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5719A294;
	Tue, 13 Aug 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7oeg30Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649E19412F;
	Tue, 13 Aug 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545956; cv=none; b=mdH134eUMRojZHGjh2O3WwTuqtE9hX4DE8/vIlcavScaF2aahtJHI0fJcgeS+sG4lXB5yacmbB+35l+V1npibFgaqLyQMSQOkkcvJ/2rDVMzD86NARagjJfxIcMnKIDk7LUBInwds05a7IrjIt1d+yONgpsm8gkhKJofnYK3Eng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545956; c=relaxed/simple;
	bh=v81MhE6xDXgDZOFXo+ZC17F/It7tvKtBSbnCvwss14Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEwLCmapSYZw9KoAhamo1h6MKvxD6rkEG01MSF7KBUfwY1KBd9o7TsbyYEEle2ZQYsp5xb5XQJL30PEIviadXbEUR/pXt6PfdykaLtXnvxjAnQU7R5MLhPzj0q9h8EV8Q1ibvxLKjxBBZeXqE8jiTP8aLlASt4UZkTWPEJlclj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7oeg30Q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723545954; x=1755081954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v81MhE6xDXgDZOFXo+ZC17F/It7tvKtBSbnCvwss14Y=;
  b=M7oeg30QnaExdZm9e67V5ihPXT3g56xFrcs9FNjH3Fp3a7sh/5MY3J1O
   uXlTARuxkLArUVDIVqP+191HS5oKmfpoOEAZzWFb1qyagoIzZnIgw0sKW
   un94584DuqGmUICKbHNoYvcwfK5Yr33h9MeILHwQqa6mJ2qDUiUSn0ghu
   Brdi/NnuHhS108FWvwrxuJ3pm6AotRWg7S7YysX0V2X2/FTty0IF5HFH+
   FgHQRtPUBUfYWTuUnyc5FnSnaKDC561mxX7wa9uS7OL1bUcjzGmygKDCc
   wNIETn+AP1xrfX/7cs2Tj894LRozlGEf4PbrGRtFB4EJLk6wD9VWMttwd
   g==;
X-CSE-ConnectionGUID: JleBrvYgTYi2n4GLcBdsxA==
X-CSE-MsgGUID: 4I5f5SLOT96bgsaKw8s+Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39148404"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="39148404"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:45:54 -0700
X-CSE-ConnectionGUID: vMHT6o2AS5SnzpzhOdOgKg==
X-CSE-MsgGUID: /nl3434FS8Wc/mvNuYIfAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="62786989"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:45:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH 3/3] kselftest: Provide __cpuid_count() stub on non-x86 archs
Date: Tue, 13 Aug 2024 13:45:15 +0300
Message-Id: <20240813104515.19152-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
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
   74 |         __asm__ __volatile__ ("cpuid\n\t"
       \
      |         ^~~~~~~
cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
  301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~
../kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"
       \
      |         ^~~~~~~
cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
  303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~

The resctrl selftest would run that code only on Intel CPUs but
as is, the code cannot be build at all.

Provide an empty stub for __cpuid_count() if it is not supported
to allow build to succeed.

Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/kselftest.h | 6 ++++++
 tools/testing/selftests/lib.mk      | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index b8967b6e29d5..71593add1b39 100644
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
+	(void)a; (void)b; (void)c; (void)d;				\
+} while (0)
+#endif
 #endif
 
 /* define kselftest exit codes */
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be8..236db9b24037 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -199,6 +199,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
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


