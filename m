Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06922903C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405493AbgJPLIm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 07:08:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:34486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405520AbgJPLIm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 07:08:42 -0400
IronPort-SDR: l2b4fZz3R+yTrIW51eVw4o5XPbrgJj2Zn5QOb53uk+6FfJ5pNOAGGU5UVrzGTY9k6DfFdMkl3O
 ntE+3HMY+yzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="166688861"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="166688861"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 04:08:40 -0700
IronPort-SDR: yXblv637jCKhpm+uilUGn7I/XQWVscXvO4rDiGu2AHWXz4SmjysrDy4obbrFqJk4HKiULYIAac
 p54rXTLauQ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="331131013"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2020 04:08:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D8B3C1A3; Fri, 16 Oct 2020 14:08:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        David Gow <davidgow@google.com>
Subject: [PATCH v3 3/3] lib/bits_kunit: Follow new file name convention for KUnit tests
Date:   Fri, 16 Oct 2020 14:08:36 +0300
Message-Id: <20201016110836.52613-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com>
References: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Follow new file name convention for the KUnit tests.
Since we have lib/*test*.c in a few variations,
use 'kunit' suffix to distinguish usual test cases
with KUnit-based ones.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v3: added Rb (David), expanded Cc (Mark)
 lib/Makefile                      | 2 +-
 lib/{test_bits.c => bits_kunit.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename lib/{test_bits.c => bits_kunit.c} (100%)

diff --git a/lib/Makefile b/lib/Makefile
index 5c18519d6733..70a4a21ff5d6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -350,6 +350,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 
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

