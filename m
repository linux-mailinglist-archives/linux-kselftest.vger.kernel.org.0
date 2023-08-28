Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5E78ADD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjH1Kui (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjH1KuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:50:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA8CE5;
        Mon, 28 Aug 2023 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693219791; x=1724755791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6Q0I7XLa+4hBFvEvw3+AsTn1EkARykHZ9OAimd73mM=;
  b=KQETilpXK804MKHS8u7OpMq4aMBscQYvNH2+jGFSe7XxUixHV8g7TNhm
   3JQgXzr67oTTHx+Fdji7RQW0PnwlLE7UoQsPG7KrMChGhOqaqX/Bc+WRt
   RRKUWFF9p/vLHt29vTUDTkgPk4+PsSM2C5RqXAQjiGxc7WOA56ZgRnVQy
   fl2NlGNbqJ10shCbO/3cKfHnYREsL04NAEBZdTz4pqzc2cEGfYchV0qWY
   V6TwYqTRSrW8GGG/gWisUc7PxXU/zbDQ9Bplook27r16ZrG4Lh7DvqHSY
   FKuLT2PZR4edBLVC9N4QW4pLE0tWgMwyOp9fmcKQaCBIWjSkfqZJuPjL3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="355398778"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="355398778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803658305"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803658305"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:49:40 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, reinette.chatre@intel.com,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Wieczor-Retman@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] selftests: Add printf attribute to ksefltest prints
Date:   Mon, 28 Aug 2023 12:49:05 +0200
Message-ID: <85a37a74915f9b969d179254fb4588de70a97af1.1693216959.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
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

Kselftest header defines multiple variadic function that use printf
along with other logic.

There is no format checking for the variadic functions that use
printing inside kselftest.h. Because of this the compiler won't
be able to catch instances of mismatched print formats and debugging
tests might be more difficult.

Add the common __printf attribute macro to kselftest.h.

Add __printf attribute to every function using formatted printing with
variadic arguments.

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

