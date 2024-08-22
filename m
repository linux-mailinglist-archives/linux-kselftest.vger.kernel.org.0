Return-Path: <linux-kselftest+bounces-16024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F895AFFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 10:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE0B21744
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559FB16DEA2;
	Thu, 22 Aug 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrH1j5cM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F315CD78;
	Thu, 22 Aug 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314334; cv=none; b=Rm6NNXWsDrcelErTCHorSZ2UpGIHwXWbz3nNYUaMu1pa1+C8Yy0pawWIznIC+Q7mrBM0j4IluE0LtxF/Fp/u1nHcOQTpjuX2gM8BIsPE7HgNwlGFx71Z3Hx1B319Xa5L/L4o+7Lyx2rmu4NWI26W7aWl7CSzpbq6ZtFE/QnCViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314334; c=relaxed/simple;
	bh=0uyyOsMA2705SRIin+TTCPQthtsTFByHyyoz94vv4Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqq75OLVEyjJCuef8FCeOoVoRoqY7GniYFdjgaJBkfjbOqKJBPBgxko9VIhRM0Kc+9v7a44ukO2ZMuEKeVFmrIVyNODobXidrZnARbQs58TINBrn3tLfC0XI9XeI2NBm/CztQPdKqG+LewJb7QH7OZiuf5iQQpRqMQQstkDOdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrH1j5cM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724314333; x=1755850333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0uyyOsMA2705SRIin+TTCPQthtsTFByHyyoz94vv4Rc=;
  b=JrH1j5cMi+5lmM2907MnOTYLipNDR3XyFJG/JW+V6NpE+mmP6Kk0AZiy
   b62RQy+/frXAVRV7bF9hnhULYHJdmTh7ESA4FmrgJTD1Po3IfFCQQH7Ve
   fSwSBZI8wVVbDRqEtohZVZM5YbrXCxAg/n9ynHpmis3BvM5qJgJqhPL/w
   l0nQNzVGoQaU5Ww4U2wXeaS4/RH55Z8h/TyCH+lppht4dpB1UmPzGHzZ/
   4i78dqnWMLLZmiCapUh61zPoO4fjKCMXfXXmVXun9v3LfBeDyHvRkqD+Z
   kcC/JXVJpePJvxdVe1OEwdDqQ8xZpIC4+qdJ8jhPK4sezGI6zwIfMTa/d
   w==;
X-CSE-ConnectionGUID: RvnYnJQuQ5SUu2qArHlKQg==
X-CSE-MsgGUID: AgVFlamfTDK/I9jGu5mcpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33331717"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33331717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:12:12 -0700
X-CSE-ConnectionGUID: twN/SGSvQga6XHibzVj2mQ==
X-CSE-MsgGUID: q06YB8KpSV2e5UpjpZtqrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66182065"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:12:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/3] kselftest: Provide __cpuid_count() stub on non-x86 archs
Date: Thu, 22 Aug 2024 11:11:14 +0300
Message-Id: <20240822081114.4695-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
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

The resctrl selftest would run that code only on Intel CPUs but
as is, the code cannot be build at all.

Provide an empty stub for __cpuid_count() if it is not supported to
allow build to succeed. The stub casts its arguments to void to avoid
causing variable unused warnings.

Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---

v2:
- Removed RFC & added Fixes and Tested-by
- Fixed the error message's line splits
- Noted down the reason for void casts in the stub
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


