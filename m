Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8557C4D0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 10:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjJKIZF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 04:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJKIZE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 04:25:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EA69E;
        Wed, 11 Oct 2023 01:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697012701; x=1728548701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w0rSpTX77wKswH6vd54/bHP7hpBLDH5K7yc41Vt6tdc=;
  b=ESeywBeHDuJOHIgbLifPUxVooB/BocWj/67TGLjOdAkea9icBDuUBVZY
   p9UkyHd2tmIHjJJNrGRZa8O0/HReTFS5GrCvYi81tZWeDs5laaG3QBpBI
   mSr63Lk0Djgw9o9sJ4hSaDm4NmlOMK8PNQYgG+wVzvIz6tNMB3p86PL0c
   z82eKf9A9lCrBwHNNzW5oY55RwIweOxUJR7XC04Av4DSzVPvMYwxE6DhY
   6+MJM3RP0Uv/MtIjfrM2/qnoMgwrd3K1DbBGgbjdrHA0JK+WiaEKBiyxt
   zRciq2W4VRzpBoMaW01N0QSrTJtLWclEPnOGbLxApEkw0K6VFIBJYhPNF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3200857"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3200857"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730411725"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730411725"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.17.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:24:57 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] selftests/kvm: Replace attribute with macro
Date:   Wed, 11 Oct 2023 10:24:02 +0200
Message-ID: <539c482b506bee15242e12d308ecf722bc5a7de8.1697012398.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
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

The __printf() macro is used in many tools in the linux kernel to
validate the format specifiers in functions that use printf. The kvm
selftest uses it without putting it in a macro definition while it
also imports the kselftests.h header.

Use __printf() from kselftests.h instead of the full attribute.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
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

