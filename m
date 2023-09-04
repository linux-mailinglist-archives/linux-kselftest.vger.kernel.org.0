Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2FA791773
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352986AbjIDMp6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352965AbjIDMp4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 08:45:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C063CD0;
        Mon,  4 Sep 2023 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831549; x=1725367549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cqMx3146mlcRdEqzrqlSle1X9Tx5A2MHZVrqT4ocrfo=;
  b=ZHvu/mMs5eQMT0GXRR+c3W2Ag5L8A0zf1OPglr0ixnOPmfKATdusEGON
   MCD4KBKAIoQjLnEhTryWFQrIp9ZpjhTjx4/4duNNkyiwc1PUrLCqnWGVW
   f1EFEA5Q6Tb4toOsmCTmmkzdPo290b1Ss7NB2h9K0QWJRtnC2KdgCwNI3
   1Pi61ZT2uCRaMUZyKgjHElKYC/RqmtG7eNT9VlLNwKgpH64VS/lTfoi9K
   KcJIzdKoC7R1k17Y2SRg+Mb1uGnu/pIj8ElZl2kbRHQlXbG6QqmSWHbWP
   POPHZClt6ZY8fQdk55IQ4WQH6n2UPQCH97igeWkBK4qm3IUCx2ng2NjvA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440555421"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440555421"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914497832"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914497832"
Received: from mfederki-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.15.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:33 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] selftests/kvm: Replace attribute with macro
Date:   Mon,  4 Sep 2023 14:44:29 +0200
Message-ID: <876277d8e5c6a1defadc3758b543217947615cff.1693829810.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
References: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The __printf() macro is used in many tools in the linux kernel to
validate the format specifiers in functions that use printf. The kvm
selftest uses it without putting it in a macro definition while it
also imports the kselftests.h header.

Use __printf() from kselftests.h instead of the full attribute.

Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Reword patch message.
- Use __printf() on test_assert().

 tools/testing/selftests/kvm/include/test_util.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6e9f215ce70..357fb7d8f6b4 100644
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

