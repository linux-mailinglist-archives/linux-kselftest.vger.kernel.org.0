Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF02B0C47
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 19:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKLSHi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 13:07:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:20332 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgKLSHh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 13:07:37 -0500
IronPort-SDR: gRjVopDRjOU7lZ31rYyQ8ZU1huST6gYGZtrTRIyrusKurs+j5Iie6EeZ0M2zB5Da7/LQkB8LsQ
 XqT5Rt+FJDdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="231973758"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="231973758"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 10:07:36 -0800
IronPort-SDR: Dk7/kHYG/57BQA7UZ4IpiePPgDyoO6723TOWdUeiCbNZ0mvdoNMu9c3Vvhw0HyV/RXBIJcH1w4
 xKhvu7A4EO0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="366439608"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2020 10:07:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84851D2; Thu, 12 Nov 2020 20:07:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/6] lib/list_kunit: Follow new file name convention for KUnit tests
Date:   Thu, 12 Nov 2020 20:07:27 +0200
Message-Id: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
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
 MAINTAINERS                       | 2 +-
 lib/Makefile                      | 2 +-
 lib/{list-test.c => list_kunit.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename lib/{list-test.c => list_kunit.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1f088a29bc2..5901b817d0bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10222,7 +10222,7 @@ M:	David Gow <davidgow@google.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
-F:	lib/list-test.c
+F:	lib/list_kunit.c
 
 LITEX PLATFORM
 M:	Karol Gugala <kgugala@antmicro.com>
diff --git a/lib/Makefile b/lib/Makefile
index ce45af50983a..9d78ef73d6ed 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -349,6 +349,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
-obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+obj-$(CONFIG_LIST_KUNIT_TEST) += list_kunit.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/list-test.c b/lib/list_kunit.c
similarity index 100%
rename from lib/list-test.c
rename to lib/list_kunit.c
-- 
2.28.0

