Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108584DA052
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 17:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350163AbiCOQqF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350154AbiCOQqB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 12:46:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9296657156;
        Tue, 15 Mar 2022 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647362689; x=1678898689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SeWxfoZUyeB9jd+Hr40U7lkC0m5/LPMDnFxW0rI9ucY=;
  b=UBP3EmK9f29dn79uwEliAPUzGDoV7xZupd3xDxWtlGX42/JYT8RjIhG4
   yttXbpmVPG19NCagXBYOS45UPn54BtIZ0+AGIvvRsJiY/KwiJxUO6tIiL
   YHeeZ5kVuMl/xHeZuarW+H2K3rhxYsy4tXY3oxLyhkMHcCAHurF6mkJLl
   yXKua6s8sNbCnvMJLaA6/dFJVNZaCu6/+byIztWeX59ZMby43M/9UGK/d
   bXUjSMFBTca510rOH32hvZebwe+GeZc0iqaabEFdkdNi2oNA6k/69PZWh
   eYHjehopVfzdL4sh8mXwFzC0DcqO96v5cQRSR9nxrSJ/2G2wJtZmZEtY2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342782289"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="342782289"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="714236349"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sandipan@linux.ibm.com, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, luto@kernel.org
Subject: [PATCH V2 1/4] selftests: Provide local define of __cpuid_count()
Date:   Tue, 15 Mar 2022 09:44:25 -0700
Message-Id: <7c49dbfe5bab04389ed84c516fcbfe31d66df880.1647360971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647360971.git.reinette.chatre@intel.com>
References: <cover.1647360971.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some selftests depend on information provided by the CPUID instruction.
To support this dependency the selftests implement private wrappers for
CPUID.

Duplication of the CPUID wrappers should be avoided.

Both gcc and clang/LLVM provide __cpuid_count() macros but neither
the macro nor its header file are available in all the compiler
versions that need to be supported by the selftests. __cpuid_count()
as provided by gcc is available starting with gcc v4.4, so it is
not available if the latest tests need to be run in all the
environments required to support kernels v4.9 and v4.14 that
have the minimal required gcc v3.2.

Provide a centrally defined macro for __cpuid_count() to help
eliminate the duplicate CPUID wrappers while continuing to
compile in older environments.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Note to maintainers:
- Macro is identical to the one provided by gcc, but not liked by
  checkpatch.pl with message "Macros with complex values should
  be enclosed in parentheses". Similar style is used in kernel,
  for example in arch/x86/kernel/fpu/xstate.h.

 tools/testing/selftests/kselftest.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index f1180987492c..898d7b2fac6c 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -52,6 +52,21 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+/*
+ * gcc cpuid.h provides __cpuid_count() since v4.4.
+ * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
+ *
+ * Provide local define for tests needing __cpuid_count() because
+ * selftests need to work in older environments that do not yet
+ * have __cpuid_count().
+ */
+#ifndef __cpuid_count
+#define __cpuid_count(level, count, a, b, c, d)				\
+	__asm__ __volatile__ ("cpuid\n\t"				\
+			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
+			      : "0" (level), "2" (count))
+#endif
+
 /* define kselftest exit codes */
 #define KSFT_PASS  0
 #define KSFT_FAIL  1
-- 
2.25.1

