Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339BF2903C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405622AbgJPLIm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 07:08:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:31867 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405493AbgJPLIm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 07:08:42 -0400
IronPort-SDR: bFKPbdiXzb3830HP9aUYAKHhWAvv+D44PlNFP+HIehADxSQIM1pPK+4QS2WjOlhR/IyUAEJjQH
 xMhKJBWEwO9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="154382040"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="154382040"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 04:08:41 -0700
IronPort-SDR: 97od3SZS82BBarFQZnAX5f1NE8gIIVWSEXNyU8mepRZPT5V1RuWjTvyej5tdC5RJJe5AEgLsn2
 DLyMwEpoTskw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="352160260"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2020 04:08:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BFE96163; Fri, 16 Oct 2020 14:08:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        David Gow <davidgow@google.com>
Subject: [PATCH v3 1/3] lib/list_kunit: Follow new file name convention for KUnit tests
Date:   Fri, 16 Oct 2020 14:08:34 +0300
Message-Id: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com>
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

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v3: added Rb (David), expanded Cc (Mark)
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

