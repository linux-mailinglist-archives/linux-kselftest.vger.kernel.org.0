Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8B28F8D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 20:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbgJOSoW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 14:44:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:42904 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731154AbgJOSoV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 14:44:21 -0400
IronPort-SDR: AmY4jIAgLN7+JZVS6EfI9lTCYhto2I42XqzWPo/yPTierlvQ1lI8X3fRkbUXpYjLTuqtgSwfGL
 scz38Vl0a8jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="165648063"
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="165648063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 11:44:20 -0700
IronPort-SDR: hcbaVwtbgh5FVabeWqNe1O3FB0PhO6mr5xhPd+J4rW5rRlK478eL65i2jxytMt2wGyLDiMULAG
 f21yNYLhnm2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="346943941"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2020 11:44:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C912BFC; Thu, 15 Oct 2020 21:44:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH v2 1/3] lib/list_kunit: Follow new file name convention for KUnit tests
Date:   Thu, 15 Oct 2020 21:44:14 +0300
Message-Id: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
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

Cc: David Gow <davidgow@google.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: followed new convention
 MAINTAINERS                       | 2 +-
 lib/Makefile                      | 2 +-
 lib/{list-test.c => list_kunit.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename lib/{list-test.c => list_kunit.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4538378de6f5..20facbca9388 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10188,7 +10188,7 @@ M:	David Gow <davidgow@google.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
-F:	lib/list-test.c
+F:	lib/list_kunit.c
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
diff --git a/lib/Makefile b/lib/Makefile
index 5ca03ba6ee45..1a5e6a6ebe8d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -350,6 +350,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 
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

