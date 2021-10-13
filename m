Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8329E42C730
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhJMRG2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 13:06:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:17602 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237682AbhJMRG0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 13:06:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="250904586"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="250904586"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 10:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="592250528"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Oct 2021 10:04:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD8E837B; Wed, 13 Oct 2021 20:04:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        jic23@kernel.org, linux@rasmusvillemoes.dk,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH v5 4/7] list: Replace kernel.h with the necessary inclusions
Date:   Wed, 13 Oct 2021 20:04:14 +0300
Message-Id: <20211013170417.87909-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013170417.87909-1-andriy.shevchenko@linux.intel.com>
References: <20211013170417.87909-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/list.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index f2af4b4aa4e9..6636fc07f918 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -2,11 +2,13 @@
 #ifndef _LINUX_LIST_H
 #define _LINUX_LIST_H
 
+#include <linux/container_of.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/poison.h>
 #include <linux/const.h>
-#include <linux/kernel.h>
+
+#include <asm/barrier.h>
 
 /*
  * Circular doubly linked list implementation.
-- 
2.33.0

