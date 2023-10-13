Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA37C8490
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjJMLiJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjJMLh6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:37:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852A3FC;
        Fri, 13 Oct 2023 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197075; x=1728733075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/gVC9ZBcqpamFqERfM3Iy1qjZmLaNjWknhhTFyG1+Q=;
  b=Bi4gxo6ujiWMQOyhQn/CzdQjnIf2WW0k/v9OfHe4xnd/GjbiUhcMZRp0
   DU8fX29ymcObL8jlH9MQFqn4H467QjqfXVC2hWXYG7HRMbsN+ga9/5+qc
   iUMM/eGQkGBhd3EKRLKhzoaEg7UFnDZT/odqHSdrLAAK90sdlsDpPKQkV
   WxTTx4tUItDeb97e5z5i+KLU2FwADyEpKdOF2fRl7aCQkb6/F9tbD2tS7
   rlr2JIxN4E/Ay8Vif7e3CEAGTcouiCh/lJfrXJ5NqZYraCEx4ixTEa87V
   L9c6uCKnO9PdFjr2rp0Leaxv62ThvMzO2wEom4Eppq2fEb9Jc9z39aI0Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449353353"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="449353353"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754675807"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754675807"
Received: from bsankiew-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:37:51 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] selftests/kvm: Replace attribute with macro
Date:   Fri, 13 Oct 2023 13:36:30 +0200
Message-ID: <e05d7b658c4685957152074d4090e8527da718e1.1697196663.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
References: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
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

The __printf() macro is used in many tools in the linux kernel to
validate the format specifiers in functions that use printf. The kvm
selftest uses it without putting it in a macro definition while it
also imports the kselftests.h header where the macro attribute is
defined.

Use __printf() from kselftests.h instead of the full attribute.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v6:
- Make the motivation behind the patch more explicit in the patch
  message.

Changelog v2:
- Reword patch message.
- Use __printf() on test_assert().

 tools/testing/selftests/kvm/include/test_util.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 7e614adc6cf4..8e5f413a593d 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -33,7 +33,7 @@ static inline int _no_printf(const char *format, ...) { return 0; }
 #define pr_info(...) _no_printf(__VA_ARGS__)
 #endif
 
-void print_skip(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
+void __printf(1, 2) print_skip(const char *fmt, ...);
 #define __TEST_REQUIRE(f, fmt, ...)				\
 do {								\
 	if (!(f))						\
@@ -46,9 +46,9 @@ ssize_t test_write(int fd, const void *buf, size_t count);
 ssize_t test_read(int fd, void *buf, size_t count);
 int test_seq_read(const char *path, char **bufp, size_t *sizep);
 
-void test_assert(bool exp, const char *exp_str,
-		 const char *file, unsigned int line, const char *fmt, ...)
-		__attribute__((format(printf, 5, 6)));
+void __printf(5, 6) test_assert(bool exp, const char *exp_str,
+				const char *file, unsigned int line,
+				const char *fmt, ...);
 
 #define TEST_ASSERT(e, fmt, ...) \
 	test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
-- 
2.42.0

