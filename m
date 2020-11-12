Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068FB2B0C48
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 19:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgKLSHi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 13:07:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:20332 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgKLSHi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 13:07:38 -0500
IronPort-SDR: ynKitZSUIHKbghyDEfZWGsE+h7/VTLt3FI4uWvm1nFc5EBLheZh1QnHWqitFEA1TjnMosCEyE5
 qRyj/A/YbZ/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="231973759"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="231973759"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 10:07:36 -0800
IronPort-SDR: 8YRo+HwXeDHVswQLGl5iwYH16F2lPRymuDJv2jDz1T6I+ldu99F7hZRaFdkEWV5DgPf9oi+D0n
 K05GCZGcKuTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="308919371"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2020 10:07:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9A0941C2; Thu, 12 Nov 2020 20:07:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/6] lib/bits_kunit: Follow new file name convention for KUnit tests
Date:   Thu, 12 Nov 2020 20:07:29 +0200
Message-Id: <20201112180732.75589-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Follow new file name convention for the KUnit tests.
Since we have lib/*test*.c in a few variations,
use 'kunit' suffix to distinguish usual test cases
with KUnit-based ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
---
v4: added tag (Brendan)

 lib/Makefile                      | 2 +-
 lib/{test_bits.c => bits_kunit.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename lib/{test_bits.c => bits_kunit.c} (100%)

diff --git a/lib/Makefile b/lib/Makefile
index ef25cd94f34d..dc76e7d8a453 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -349,6 +349,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
+obj-$(CONFIG_BITS_TEST) += bits_kunit.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += linear_ranges_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list_kunit.o
-obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/test_bits.c b/lib/bits_kunit.c
similarity index 100%
rename from lib/test_bits.c
rename to lib/bits_kunit.c
-- 
2.28.0

