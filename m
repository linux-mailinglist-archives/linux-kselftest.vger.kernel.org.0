Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57CD42C733
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhJMRG3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 13:06:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:30782 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhJMRG1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 13:06:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227375955"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="227375955"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 10:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="570908632"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2021 10:04:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C7B72E4; Wed, 13 Oct 2021 20:04:23 +0300 (EEST)
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
Subject: [PATCH v5 0/7] kernel.h further split
Date:   Wed, 13 Oct 2021 20:04:10 +0300
Message-Id: <20211013170417.87909-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v4: https://lore.kernel.org/linux-media/20211007154407.29746-1-andriy.shevchenko@linux.intel.com/T/#u
v3: https://lore.kernel.org/linux-media/20211007150339.28910-1-andriy.shevchenko@linux.intel.com/T/#u
v2: https://lore.kernel.org/linux-media/20211007095129.22037-1-andriy.shevchenko@linux.intel.com/T/#u

The kernel.h is a set of something which is not related to each other
and often used in non-crossed compilation units, especially when drivers
need only one or two macro definitions from it.

Here is the split of container_of(). The goals are the following:
- untwist the dependency hell a bit
- drop kernel.h inclusion where it's only used for container_of()

In v5:
- dropped code duplication (Miguel)
- added necessary includes into container_of.h (Joe)
- dropped other header shuffling in list.h (Jonathan)
- added tag (Sakari)

In v4:
- dropped kobject.h change (Greg)
- Cc'ed more people (as per v1)

In v3:
- split patch 2 to more patches (Greg)
- excluded C changes (Herbert, Greg)
- measured with kcbench, see below (Greg)

Andy Shevchenko (7):
  kernel.h: Drop unneeded <linux/kernel.h> inclusion from other headers
  kernel.h: Split out container_of() and typeof_member() macros
  kunit: Replace kernel.h with the necessary inclusions
  list: Replace kernel.h with the necessary inclusions
  llist: Replace kernel.h with the necessary inclusions
  plist: Replace kernel.h with the necessary inclusions
  media: entity: Replace kernel.h with the necessary inclusions

 include/kunit/test.h         | 13 ++++++++++--
 include/linux/container_of.h | 40 ++++++++++++++++++++++++++++++++++++
 include/linux/kernel.h       | 33 +----------------------------
 include/linux/list.h         |  4 +++-
 include/linux/llist.h        |  4 +++-
 include/linux/plist.h        |  5 ++++-
 include/linux/rwsem.h        |  1 -
 include/linux/smp.h          |  1 -
 include/linux/spinlock.h     |  1 -
 include/media/media-entity.h |  3 ++-
 10 files changed, 64 insertions(+), 41 deletions(-)
 create mode 100644 include/linux/container_of.h

-- 
2.33.0

