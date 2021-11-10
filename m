Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D52244BEC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhKJKip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 05:38:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:17230 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230515AbhKJKip (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 05:38:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="212671770"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="212671770"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 02:35:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="534006532"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2021 02:35:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2BC8E155; Wed, 10 Nov 2021 12:35:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v1 1/1] kunit: Replace kernel.h with the necessary inclusions
Date:   Wed, 10 Nov 2021 12:35:52 +0200
Message-Id: <20211110103552.60181-1-andriy.shevchenko@linux.intel.com>
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

