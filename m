Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277DB79176A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjIDMpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjIDMpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 08:45:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE92ECD7;
        Mon,  4 Sep 2023 05:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831531; x=1725367531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+h9NKb/dDqcVeQhkPiBsyE57V5ftPJHDQ5ZLYh4Jqdc=;
  b=KKmXT9jUFcvUjbr/+0aPsEEvT1Xk8gfoJMzSyTAYSPLGvptZbwNp4Rnz
   Di2hkMVFIJ/Fos+AnHZhcThPh09FwZr9qiHXow+6OqDf84Jeq+M9SWtKJ
   bRVJqOZdZ2bnFIhoigHpa6PRKC7NuBf3OrK0r8kvVuqZd6PMaVmm7Kc5g
   1XcFSxr8Kzbszdlf+glx12h8TP6ejrV7Idd0A6V5e1IzuYmY2fLB0rFuq
   bmSmD0umtrTcyDTWot4e7CFolH6EIc8CQrxdjBJxxX0vAufBQ/keqvpue
   KeL6M8L+eqgTFGdxhTB6n9NMPApwEPRnTH8yXgeoFw9Uk4XnUfTMYbjfx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440555376"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440555376"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914497761"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914497761"
Received: from mfederki-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.15.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:22 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] selftests: Add printf attribute to ksefltest prints
Date:   Mon,  4 Sep 2023 14:44:24 +0200
Message-ID: <4a5bf486de7420019ea946bf814579909460ebbb.1693829810.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
References: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kselftest header defines multiple variadic functions that use printf
along with other logic.

There is no format checking for the variadic functions that use
printing inside kselftest.h. Because of this the compiler won't
be able to catch instances of mismatched printf formats and debugging
tests might be more difficult.

Add the common __printf attribute macro to kselftest.h.

Add __printf attribute to every function using formatted printing with
variadic arguments.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/kselftest.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 829be379545a..ff47ed711879 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -77,6 +77,8 @@
 #define KSFT_XPASS 3
 #define KSFT_SKIP  4
 
+#define __printf(a, b)   __attribute__((format(printf, a, b)))
+
 /* counters */
 struct ksft_count {
 	unsigned int ksft_pass;
@@ -134,7 +136,7 @@ static inline void ksft_print_cnts(void)
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
 }
 
-static inline void ksft_print_msg(const char *msg, ...)
+static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -146,7 +148,7 @@ static inline void ksft_print_msg(const char *msg, ...)
 	va_end(args);
 }
 
-static inline void ksft_test_result_pass(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -160,7 +162,7 @@ static inline void ksft_test_result_pass(const char *msg, ...)
 	va_end(args);
 }
 
-static inline void ksft_test_result_fail(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_fail(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -186,7 +188,7 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
 	} while (0)
 
-static inline void ksft_test_result_xfail(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_xfail(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -200,7 +202,7 @@ static inline void ksft_test_result_xfail(const char *msg, ...)
 	va_end(args);
 }
 
-static inline void ksft_test_result_skip(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -215,7 +217,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 }
 
 /* TODO: how does "error" differ from "fail" or "skip"? */
-static inline void ksft_test_result_error(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_error(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -262,7 +264,7 @@ static inline int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline int ksft_exit_fail_msg(const char *msg, ...)
+static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -289,7 +291,7 @@ static inline int ksft_exit_xpass(void)
 	exit(KSFT_XPASS);
 }
 
-static inline int ksft_exit_skip(const char *msg, ...)
+static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
-- 
2.42.0

