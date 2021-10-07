Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17868425605
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbhJGPHC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 11:07:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:26555 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242289AbhJGPHB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 11:07:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="249590777"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="249590777"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 08:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="484548000"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2021 08:03:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EFB35B7; Thu,  7 Oct 2021 18:03:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v3 1/7] kernel.h: Drop unneeded <linux/kernel.h> inclusion from other headers
Date:   Thu,  7 Oct 2021 18:03:33 +0300
Message-Id: <20211007150339.28910-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007150339.28910-1-andriy.shevchenko@linux.intel.com>
References: <20211007150339.28910-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no evidence we need kernel.h inclusion in certain headers.
Drop unneeded <linux/kernel.h> inclusion from other headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/rwsem.h    | 1 -
 include/linux/spinlock.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 352c6127cb90..f9348769e558 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -11,7 +11,6 @@
 #include <linux/linkage.h>
 
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 76a855b3ecde..c04e99edfe92 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -57,7 +57,6 @@
 #include <linux/compiler.h>
 #include <linux/irqflags.h>
 #include <linux/thread_info.h>
-#include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
-- 
2.33.0

