Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95171473637
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 21:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbhLMUoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 15:44:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:36849 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236136AbhLMUoi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 15:44:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302207177"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="302207177"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="517916776"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2021 12:44:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37218144; Mon, 13 Dec 2021 22:44:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/1] kunit: Replace kernel.h with the necessary inclusions
Date:   Mon, 13 Dec 2021 22:44:41 +0200
Message-Id: <20211213204441.56204-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Andrew, please take it through your tree since KUnit maintainer is non-responsive
by unknown (to me) reasons.

 include/kunit/assert.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index ad889b539ab3..ccbc36c0b02f 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -10,7 +10,7 @@
 #define _KUNIT_ASSERT_H
 
 #include <linux/err.h>
-#include <linux/kernel.h>
+#include <linux/printk.h>
 
 struct kunit;
 struct string_stream;
-- 
2.33.0

