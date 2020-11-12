Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758742B0C49
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 19:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgKLSHi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 13:07:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:14029 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgKLSHh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 13:07:37 -0500
IronPort-SDR: r6XWrqZsRu0/bQOH3Oyf7hOcnvqi/Jic15qgKTs3AzqRSCUKJMlEl05bezQndbzCS5h3Sawf4l
 ziKn9iszETew==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="169570596"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="169570596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 10:07:37 -0800
IronPort-SDR: 9/lV0UeTa8F/auMHg5+OZYXgUik4GXOThhUbAsxs0GP/OJclx+Rth6YIXWcnOlztyCHe71y5Mk
 Dnbk4abdFwBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="339495514"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 12 Nov 2020 10:07:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8DF9EA7; Thu, 12 Nov 2020 20:07:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v4 2/6] lib/linear_ranges_kunit: Follow new file name convention for KUnit tests
Date:   Thu, 12 Nov 2020 20:07:28 +0200
Message-Id: <20201112180732.75589-2-andriy.shevchenko@linux.intel.com>
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

Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
v4: added tag (Mark)

 MAINTAINERS                                         | 3 +--
 lib/Makefile                                        | 2 +-
 lib/{test_linear_ranges.c => linear_ranges_kunit.c} | 0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename lib/{test_linear_ranges.c => linear_ranges_kunit.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5901b817d0bc..9a314e618705 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10103,8 +10103,7 @@ F:	include/uapi/linux/lightnvm.h
 LINEAR RANGES HELPERS
 M:	Mark Brown <broonie@kernel.org>
 R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
-F:	lib/linear_ranges.c
-F:	lib/test_linear_ranges.c
+F:	lib/linear_ranges*.c
 F:	include/linux/linear_range.h
 
 LINUX FOR POWER MACINTOSH
diff --git a/lib/Makefile b/lib/Makefile
index 9d78ef73d6ed..ef25cd94f34d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -349,6 +349,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
+obj-$(CONFIG_LINEAR_RANGES_TEST) += linear_ranges_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list_kunit.o
-obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/test_linear_ranges.c b/lib/linear_ranges_kunit.c
similarity index 100%
rename from lib/test_linear_ranges.c
rename to lib/linear_ranges_kunit.c
-- 
2.28.0

