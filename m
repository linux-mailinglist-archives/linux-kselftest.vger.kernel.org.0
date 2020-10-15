Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38828F8D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbgJOSoW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 14:44:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:59310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389644AbgJOSoV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 14:44:21 -0400
IronPort-SDR: V/lNwlnGu0eRL05ilA+X9mAGJRJhDu91d0Nsp08g6ooe/h/FtKXrv2EYaDoFVqxCf1TtYZ0yRH
 NdqbsCyMKudA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="153355665"
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="153355665"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 11:44:21 -0700
IronPort-SDR: nar9uvyy0HqcxBtNP3+mlux/IYCMaUOtlIQ5Q3u7QStQsHKdK61IGY5B+YWir9hNDuNty2t0En
 YhYCWWXz4Vgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="300400764"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Oct 2020 11:44:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DEA21163; Thu, 15 Oct 2020 21:44:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] lib/bits_kunit: Follow new file name convention for KUnit tests
Date:   Thu, 15 Oct 2020 21:44:16 +0300
Message-Id: <20201015184416.38999-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
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
---
v2: new patch
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

