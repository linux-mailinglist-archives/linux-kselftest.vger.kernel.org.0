Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5824256D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbhJGPqC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 11:46:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:40735 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242389AbhJGPqC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 11:46:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="289784186"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="289784186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 08:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="624303794"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2021 08:44:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36214159; Thu,  7 Oct 2021 18:44:09 +0300 (EEST)
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
Subject: [PATCH v4 0/7] kernel.h further split
Date:   Thu,  7 Oct 2021 18:44:00 +0300
Message-Id: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v3: https://lore.kernel.org/linux-media/20211007150339.28910-1-andriy.shevchenko@linux.intel.com/T/#u
v2: https://lore.kernel.org/linux-media/20211007095129.22037-1-andriy.shevchenko@linux.intel.com/T/#u

The kernel.h is a set of something which is not related to each other
and often used in non-crossed compilation units, especially when drivers
need only one or two macro definitions from it.

Here is the split of container_of(). The goals are the following:
- untwist the dependency hell a bit
- drop kernel.h inclusion where it's only used for container_of()
- speed up C preprocessing.

The build speedup is
	1.83% (ccache approach, see v2 cover letter for the details)
	0.5%  (kcbench approach, see v3 cover letter for the details)

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
  list.h: Replace kernel.h with the necessary inclusions
  llist: Replace kernel.h with the necessary inclusions
  plist: Replace kernel.h with the necessary inclusions
  media: entity: Replace kernel.h with the necessary inclusions

 include/kunit/test.h         | 14 ++++++++++++--
 include/linux/container_of.h | 37 ++++++++++++++++++++++++++++++++++++
 include/linux/kernel.h       | 31 +-----------------------------
 include/linux/list.h         |  6 ++++--
 include/linux/llist.h        |  4 +++-
 include/linux/plist.h        |  5 ++++-
 include/linux/rwsem.h        |  1 -
 include/linux/spinlock.h     |  1 -
 include/media/media-entity.h |  3 ++-
 9 files changed, 63 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/container_of.h

-- 
2.33.0

