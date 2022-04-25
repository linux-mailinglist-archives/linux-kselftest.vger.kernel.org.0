Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A550EAEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiDYVE1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 17:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245344AbiDYVE0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 17:04:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE725167C4
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650920480; x=1682456480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=amodz0QpZv9gbKyt4lmRvYPhlmutS/vrHNqvwdpUV/U=;
  b=aG1c5tVmbpdaUEgvKSsi7FrL992DrTvWctK3H7qyLN6ePCn3JBDAAhTF
   8XRwlIhAyquR6ejxSBSxmTrK3W8dYNxBbjUOkzLEM4+rxbEnN6MhMErDh
   i4xj35Y3szvEWRw53aKoulpjQ2nMOBr3xzKcFqurVa8358lOZZG5msYTR
   J0pm9QAEeVI4REJWw7D2A3z/fuh42zqX3kgyl3wlryUeX5MfKuTKRjdXl
   nYg8j+KTP4wpMTN37NZnlzP4xMun7djX0dtWvVNT/WItVJfUFKEnYL+n/
   Y7iZagzrlZpqfBSd700isnHg2/+HczloPOVSwGcKUNNkFXew08BJCZiTH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290502304"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="290502304"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:01:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="579499491"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:01:19 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, sandipan@linux.ibm.com,
        fweimer@redhat.com, desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@kernel.org, x86@kernel.org
Subject: [PATCH V3 1/4] selftests: Provide local define of __cpuid_count()
Date:   Mon, 25 Apr 2022 14:01:11 -0700
Message-Id: <c6c0aaf08f6ef541c33c8b40e422fcd618b4d817.1650918160.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650918160.git.reinette.chatre@intel.com>
References: <cover.1650918160.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Duplicate gcc's __cpuid_count() macro to provide a centrally defined
macro for __cpuid_count() to help eliminate the duplicate CPUID wrappers
while continuing to compile in older environments.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Note to maintainers:
- Macro is identical to the one provided by gcc, but not liked by
  checkpatch.pl with message "Macros with complex values should
  be enclosed in parentheses". Similar style is used in kernel,
  for example in arch/x86/kernel/fpu/xstate.h.

Changes since V2:
- Highlight in changelog that macro is copied from gcc.

 tools/testing/selftests/kselftest.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index b8f248018174..33a0dbd26bd3 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -53,6 +53,21 @@
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

