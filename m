Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73E14255FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbhJGPGp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 11:06:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:18349 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233341AbhJGPGo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 11:06:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226171660"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="226171660"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 08:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="458820311"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 07 Oct 2021 08:03:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E4CB4159; Thu,  7 Oct 2021 18:03:42 +0300 (EEST)
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
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH v3 0/7] kernel.h further split
Date:   Thu,  7 Oct 2021 18:03:32 +0300
Message-Id: <20211007150339.28910-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2: https://lore.kernel.org/linux-media/20211007095129.22037-1-andriy.shevchenko@linux.intel.com/T/#u

The kernel.h is a set of something which is not related to each other
and often used in non-crossed compilation units, especially when drivers
need only one or two macro definitions from it.

Here is the split of container_of(). The goals are the following:
- untwist the dependency hell a bit
- drop kernel.h inclusion where it's only used for container_of()
- speed up C preprocessing.

In v3:
- split patch 2 to more patches (Greg)
- exclude C changes (Herbert, Greg)
- measure with kcbench, see below (Greg)

Cc: Thorsten Leemhuis <regressions@leemhuis.info>

People, like Greg KH and Miguel Ojeda, were asking about the latter.
My methodology an testing has been provided in cover letter for v2
(see above) and here is what Greg KH insisted to have which is speedup
of the kernel build.

$ kcbench -i 3 -j 64 -o $O -s $PWD --no-download -m
Processor:           Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz [88 CPUs]
Cpufreq; Memory:     powersave [intel_pstate]; 128823 MiB
Linux running:       5.6.0-2-amd64 [x86_64]
Compiler:            gcc (Debian 10.3.0-11) 10.3.0
Linux compiled:      5.15.0-rc4
Config; Environment: allmodconfig; CCACHE_DISABLE="1"
Build command:       make vmlinux modules
Filling caches:      This might take a while... Done
Run 1 (-j 64):       464.07 seconds / 7.76 kernels/hour [P:6001%]
Run 2 (-j 64):       464.64 seconds / 7.75 kernels/hour [P:6000%]
Run 3 (-j 64):       486.41 seconds / 7.40 kernels/hour [P:5727%]

$ kcbench -i 3 -j 64 -o $O -s $PWD --no-download -m
Processor:           Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz [88 CPUs]
Cpufreq; Memory:     powersave [intel_pstate]; 128823 MiB
Linux running:       5.6.0-2-amd64 [x86_64]
Compiler:            gcc (Debian 10.3.0-11) 10.3.0
Linux compiled:      5.15.0-rc4
Config; Environment: allmodconfig; CCACHE_DISABLE="1"
Build command:       make vmlinux modules
Filling caches:      This might take a while... Done
Run 1 (-j 64):       462.32 seconds / 7.79 kernels/hour [P:6009%]
Run 2 (-j 64):       462.33 seconds / 7.79 kernels/hour [P:6006%]
Run 3 (-j 64):       465.45 seconds / 7.73 kernels/hour [P:5999%]

Median values
	464.64	before
	462.33	after

Speedup: +0.5%

This supports and in align with my own approach, but shows lower numbers
due to additional big take in the measurements (compilation without ccache).

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
 include/linux/kobject.h      |  1 +
 include/linux/list.h         |  6 ++++--
 include/linux/llist.h        |  4 +++-
 include/linux/plist.h        |  5 ++++-
 include/linux/rwsem.h        |  1 -
 include/linux/spinlock.h     |  1 -
 include/media/media-entity.h |  3 ++-
 10 files changed, 64 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/container_of.h

-- 
2.33.0

