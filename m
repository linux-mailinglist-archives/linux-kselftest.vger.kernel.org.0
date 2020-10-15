Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC128F421
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgJON7N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 09:59:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:1435 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729930AbgJON7M (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 09:59:12 -0400
IronPort-SDR: 3szwI2BwOHJr5/9Z/6ceqUesXt/WYzdJXG0pGmgA5VccffbuEyIZO17uce6tkhQnZ8GBoTuUHi
 j0Qk56W2Ivtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="162885697"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="162885697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 06:59:12 -0700
IronPort-SDR: kbuXbelmblFd9vM2S/tHMAwClthUfDK4OxYSr3LOD2YFdADVzUXsZEjRfCaLuqWjESgKwFf/Zh
 6gbczUOe/Bag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="319027226"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2020 06:59:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 94038FC; Thu, 15 Oct 2020 16:59:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lib/test_list: Follow existing pattern for a file name
Date:   Thu, 15 Oct 2020 16:59:08 +0300
Message-Id: <20201015135908.36628-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test in lib/ either KUnit or not are named in the same pattern,
i.e. test_*.c, except few ones. Rename list-test.c to test_list.c
to follow this pattern.

Note, current documentation doesn't specify any file name conventions,
and we glad to stick with a current one in the subsystem.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/Makefile                     | 4 ++--
 lib/{list-test.c => test_list.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename lib/{list-test.c => test_list.c} (100%)

diff --git a/lib/Makefile b/lib/Makefile
index 5ca03ba6ee45..e71abeea4a3e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -350,6 +350,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
-obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
-obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
+obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_LIST_KUNIT_TEST) += test_list.o
diff --git a/lib/list-test.c b/lib/test_list.c
similarity index 100%
rename from lib/list-test.c
rename to lib/test_list.c
-- 
2.28.0

