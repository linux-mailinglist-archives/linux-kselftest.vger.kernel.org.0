Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC14256E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbhJGPqJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 11:46:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:30725 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242458AbhJGPqH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 11:46:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="249602644"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="249602644"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 08:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="524708629"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2021 08:44:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 81F93561; Thu,  7 Oct 2021 18:44:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        jic23@kernel.org, linux@rasmusvillemoes.dk,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH v4 7/7] media: entity: Replace kernel.h with the necessary inclusions
Date:   Thu,  7 Oct 2021 18:44:07 +0300
Message-Id: <20211007154407.29746-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
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
 include/media/media-entity.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 09737b47881f..fea489f03d57 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -13,10 +13,11 @@
 
 #include <linux/bitmap.h>
 #include <linux/bug.h>
+#include <linux/container_of.h>
 #include <linux/fwnode.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/media.h>
+#include <linux/types.h>
 
 /* Enums used internally at the media controller to represent graphs */
 
-- 
2.33.0

