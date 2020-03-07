Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAFC17CB92
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 04:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCGDqJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 22:46:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:57577 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCGDqJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 22:46:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 19:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="235035981"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2020 19:46:08 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V1 00/13] Miscellaneous fixes for resctrl selftests
Date:   Fri,  6 Mar 2020 19:40:41 -0800
Message-Id: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch set has several miscellaneous fixes to resctrl selftest tool. Some
fixes are minor in nature while other are major fixes.

The minor fixes are
1. Typos, comment format
2. Fix MBA feature detection
3. Fix a bug while selecting sibling cpu
4. Remove unnecessary use of variable arguments
5. Change MBM/MBA results reporting format from absolute values to percentage

The major fixes are changing CAT and CQM test cases. CAT test wasn't testing
CAT as it isn't using the cache it's allocated, hence, change the test case to
test noisy neighbor use case. CAT guarantees a user specified amount of cache
for a process or a group of processes, hence test this use case. The updated
test case checks if critical process is impacted by noisy neighbor or not. If
it's impacted the test fails.

The present CQM test assumes that all the allocated memory (size less than LLC
size) for a process will fit into cache and there won't be any overlappings.
While this is mostly true, it cannot be *always* true by the nature of how cache
works i.e. two addresses could index into same cache line. Hence, change CQM
test such that it now uses CAT. Allocate a specific amount of cache using CAT
and check if CQM reports more than what CAT has allocated.

Fenghua Yu (1):
  selftests/resctrl: Fix missing options "-n" and "-p"

Reinette Chatre (4):
  selftests/resctrl: Fix feature detection
  selftests/resctrl: Fix typo
  selftests/resctrl: Fix typo in help text
  selftests/resctrl: Ensure sibling CPU is not same as original CPU

Sai Praneeth Prakhya (8):
  selftests/resctrl: Fix MBA/MBM results reporting format
  selftests/resctrl: Don't use variable argument list for setup function
  selftests/resctrl: Fix typos
  selftests/resctrl: Modularize fill_buf for new CAT test case
  selftests/resctrl: Change Cache Allocation Technology (CAT) test
  selftests/resctrl: Change Cache Quality Monitoring (CQM) test
  selftests/resctrl: Dynamically select buffer size for CAT test
  selftests/resctrl: Cleanup fill_buff after changing CAT test

 tools/testing/selftests/resctrl/cache.c         | 179 ++++++++-----
 tools/testing/selftests/resctrl/cat_test.c      | 322 +++++++++++++-----------
 tools/testing/selftests/resctrl/cqm_test.c      | 210 +++++++++-------
 tools/testing/selftests/resctrl/fill_buf.c      | 113 ++++++---
 tools/testing/selftests/resctrl/mba_test.c      |  32 ++-
 tools/testing/selftests/resctrl/mbm_test.c      |  33 ++-
 tools/testing/selftests/resctrl/resctrl.h       |  19 +-
 tools/testing/selftests/resctrl/resctrl_tests.c |  26 +-
 tools/testing/selftests/resctrl/resctrl_val.c   |  22 +-
 tools/testing/selftests/resctrl/resctrlfs.c     |  52 +++-
 10 files changed, 592 insertions(+), 416 deletions(-)

-- 
2.7.4

