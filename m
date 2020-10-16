Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92F2903CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 13:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405637AbgJPLIo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 07:08:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:34486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405520AbgJPLIn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 07:08:43 -0400
IronPort-SDR: npSIgargvp+WWO/4myhLrPuJNfs+Wd5LpytP4tMc7RKwFKNWKHDxNwr/MMOlCBSTn40JzkrHes
 VLsvWvccTp0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="166688863"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="166688863"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 04:08:41 -0700
IronPort-SDR: zfR6fGPJ1Bia8WhSS9AebSegnToDN63oiHZT2fmrsWyfBQ7JxoUFA7SpZsF5eJnFCVE5dkETnC
 esHXS6lG1uWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="421460032"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2020 04:08:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D226EFC; Fri, 16 Oct 2020 14:08:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH v3 2/3] lib/linear_ranges_kunit: Follow new file name convention for KUnit tests
Date:   Fri, 16 Oct 2020 14:08:35 +0300
Message-Id: <20201016110836.52613-2-andriy.shevchenko@linux.intel.com>
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
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v3: added Rb (David)
 MAINTAINERS                                         | 3 +--
 lib/Makefile                                        | 2 +-
 lib/{test_linear_ranges.c => linear_ranges_kunit.c} | 0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename lib/{test_linear_ranges.c => linear_ranges_kunit.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20facbca9388..249417a036f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10069,8 +10069,7 @@ F:	include/uapi/linux/lightnvm.h
 LINEAR RANGES HELPERS
 M:	Mark Brown <broonie@kernel.org>
 R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
-F:	lib/linear_ranges.c
-F:	lib/test_linear_ranges.c
+F:	lib/linear_ranges*.c
 F:	include/linux/linear_range.h
 
 LINUX FOR POWER MACINTOSH
diff --git a/lib/Makefile b/lib/Makefile
index 1a5e6a6ebe8d..5c18519d6733 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -350,6 +350,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 
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

