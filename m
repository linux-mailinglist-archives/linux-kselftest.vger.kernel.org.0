Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C453F7C4D02
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjJKIYk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjJKIYk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 04:24:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7BD93;
        Wed, 11 Oct 2023 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697012678; x=1728548678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DODJjFottlxEJu0e1tIrYsECssXJAlmKZEBekFL0/ME=;
  b=VUSvqqpetOYSh100vMYFNrQW+PR5VadePHTwFfqAOYJOyDgV5YVgKYd4
   MjBc9ik3VMhGRa05RCnbvEESFl6Nr/aYKuI4ZjJb5gMo6So/5hYpd0MnW
   BmCxbmeqKRFoCDUjXSfnOTqzBh1GWXGY7Tfk0b/85BgsLF12hBMijcK+U
   UTng9DGuFMdaUsoF4FMGGL+jvAcaOXiWpbQ1QzIXtIbdwRmZt/hIGXtCN
   fn6YWeOkJt5SAvj+qkmXqbmOZY5TH7Sq8f2BSjI1SzeITgE7uylrgbduR
   Q6NaB72egmrHXoPRzvhPLH2lOXV4Y1cMXUogS4WTTDa3a6OjTDPw4T9aS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3200696"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3200696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730411561"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730411561"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.17.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:24:26 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] selftests: Add printf attribute to kselftest prints
Date:   Wed, 11 Oct 2023 10:23:57 +0200
Message-ID: <13a47130763d109aa40de153ecbee9ede22d8356.1697012398.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v4:
- Fix typo in patch subject. (Reinette)
- Add Reinette's reviewed-by tag.

 tools/testing/selftests/kselftest.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index af9f1202d423..5696199c16f9 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -78,6 +78,8 @@
 #define KSFT_XPASS 3
 #define KSFT_SKIP  4
 
+#define __printf(a, b)   __attribute__((format(printf, a, b)))
+
 /* counters */
 struct ksft_count {
 	unsigned int ksft_pass;
@@ -144,7 +146,7 @@ static inline void ksft_print_cnts(void)
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
 }
 
-static inline void ksft_print_msg(const char *msg, ...)
+static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -169,7 +171,7 @@ static inline void ksft_perror(const char *msg)
 #endif
 }
 
-static inline void ksft_test_result_pass(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -183,7 +185,7 @@ static inline void ksft_test_result_pass(const char *msg, ...)
 	va_end(args);
 }
 
-static inline void ksft_test_result_fail(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_fail(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -209,7 +211,7 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
 	} while (0)
 
-static inline void ksft_test_result_xfail(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_xfail(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -223,7 +225,7 @@ static inline void ksft_test_result_xfail(const char *msg, ...)
 	va_end(args);
 }
 
-static inline void ksft_test_result_skip(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -238,7 +240,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 }
 
 /* TODO: how does "error" differ from "fail" or "skip"? */
-static inline void ksft_test_result_error(const char *msg, ...)
+static inline __printf(1, 2) void ksft_test_result_error(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -285,7 +287,7 @@ static inline int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline int ksft_exit_fail_msg(const char *msg, ...)
+static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -312,7 +314,7 @@ static inline int ksft_exit_xpass(void)
 	exit(KSFT_XPASS);
 }
 
-static inline int ksft_exit_skip(const char *msg, ...)
+static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
-- 
2.42.0

