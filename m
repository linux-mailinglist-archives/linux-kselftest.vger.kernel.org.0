Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15C7BD894
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjJIKbO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345655AbjJIKbN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:31:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4542AA3;
        Mon,  9 Oct 2023 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696847471; x=1728383471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DODJjFottlxEJu0e1tIrYsECssXJAlmKZEBekFL0/ME=;
  b=giFWtOeWicLZfxu9iLZCeNpPH0Ercp8rUmOFdOvNAgQ1RbakUpM/bYh+
   NGxoc486OVlhXW7ZZOBu7OZyFrbSqgWlHQ5yDog+RGwH8JMKq9ptYXIo2
   ex56+W91NnwUr6RuRIFxIl2VNTpKOicFPpNoiu8N4UEcRj78/HnBK8Ro6
   dJVSNuBONt51K5uoQG8/pEI6F6ZlJ1r5b/2eZWWUANDxUEmXaQduJp04R
   7+TMvhcqYpLF1Ro/dDhNqoYv+EcDm5Zb5w6ip0dQuHQ2MXMqh+NQo5io1
   ihbb7s4iI5WjdEwmnjpXFRrInTklzp33YUy1WbIXBBH6EJ0zatHrg1hbk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="363468366"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363468366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926718647"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="926718647"
Received: from kkensic-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.30.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:08 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] selftests: Add printf attribute to kselftest prints
Date:   Mon,  9 Oct 2023 12:30:35 +0200
Message-ID: <9c14b1fcc057e31fdb2e2c9438cc4e04bf218d34.1696846568.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
References: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

