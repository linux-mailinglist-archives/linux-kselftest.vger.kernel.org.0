Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4193D7AAD63
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 11:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjIVJHH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 05:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIVJHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 05:07:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10001C2;
        Fri, 22 Sep 2023 02:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695373620; x=1726909620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+bd+QBscp0NY6rRNQqvwBPLTBFFQn+H/2YyOTsEGJGY=;
  b=Di8dTY3fzyFEfjMpsUqNliSZUktVeYqKsStwcd0X6B2k28SoMo1NmdWb
   nZeuVpC6LVpKfgBOxHmFDLNl6kQ6kqGcC1K550ei/xOPnn1UWDl/X4i2E
   bSuC/pS/NR7tajbpHIg8HhATXn+NEvQnbPiq8CX+/HD6GcZmQwPP2npGU
   UrjbQW2is8WQ7HdEXbFg0OkpBFBAp9efPCwlmtGAgGLRb66a0p5Ba0536
   rIxYMPBxiSfJ92mM7LjZgl9pScTup4O28p8N28K02UexVcDbvWahWqgbW
   KUxYht28yaTlJqwhvLhR4UwWDfrQN9rExkfqtSIy5e9QfaUxgpXCrk0Vp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="378070737"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378070737"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="837663632"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="837663632"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:06:57 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] selftests: Add printf attribute to ksefltest prints
Date:   Fri, 22 Sep 2023 11:06:37 +0200
Message-ID: <c6031eeffeb5d5e3b0b639f4b2aaf7fefd75fde2.1695373131.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
References: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/kselftest.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 529d29a35900..f4c677b5d68f 100644
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
@@ -143,7 +145,7 @@ static inline void ksft_print_cnts(void)
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
 }
 
-static inline void ksft_print_msg(const char *msg, ...)
+static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -155,7 +157,7 @@ static inline void ksft_print_msg(const char *msg, ...)
 	va_end(args);
 }
 
-static inline void ksft_test_result_pass(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -169,7 +171,7 @@ static inline void ksft_test_result_pass(const char *msg, ...)
 	va_end(args);
 }
 
-static inline void ksft_test_result_fail(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_fail(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -195,7 +197,7 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
 	} while (0)
 
-static inline void ksft_test_result_xfail(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_xfail(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -209,7 +211,7 @@ static inline void ksft_test_result_xfail(const char *msg, ...)
 	va_end(args);
 }
 
-static inline void ksft_test_result_skip(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -224,7 +226,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 }
 
 /* TODO: how does "error" differ from "fail" or "skip"? */
-static inline void ksft_test_result_error(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_error(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -271,7 +273,7 @@ static inline int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline int ksft_exit_fail_msg(const char *msg, ...)
+static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -298,7 +300,7 @@ static inline int ksft_exit_xpass(void)
 	exit(KSFT_XPASS);
 }
 
-static inline int ksft_exit_skip(const char *msg, ...)
+static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
-- 
2.42.0

