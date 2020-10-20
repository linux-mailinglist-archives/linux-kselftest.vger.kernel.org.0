Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47855294584
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410705AbgJTXva (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:63667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410704AbgJTXv3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:29 -0400
IronPort-SDR: mi8NZ77TT/Tk1SmggqCiXCuu0PieNYKc4IGYhbz4mIjk45bQZ8k2dOdjE/MXNWICY5/4dQaut8
 hqyvUUJRFWkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="184942254"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="184942254"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:29 -0700
IronPort-SDR: nEs4TcPqvAsVzoU7gLOU76mQKDtHTBJUPauQ4XCcyu/cYjEILn+ucS6anEdYnXJFRFYWRM/HnC
 aUk1RIfnD1jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833801"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 00/21] Miscellaneous fixes for resctrl selftests
Date:   Tue, 20 Oct 2020 23:51:05 +0000
Message-Id: <20201020235126.1871815-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch set has several miscellaneous fixes to resctrl selftest tool
that are easily visible to user. V1 had fixes to CAT test and CMT test
but they were dropped in V2 because having them here made the patchset
humongous. So, changes to CAT test and CMT test will be posted in another
patchset.

Change Log:
v3:
Address various comments (commit messages, return value on test failure,
print failure info on test failure etc) from Reinette and Tony.
[v2: https://lore.kernel.org/linux-kselftest/cover.1589835155.git.sai.praneeth.prakhya@intel.com/]

v2:
1. Dropped changes to CAT test and CMT test as they will be posted in a later
   series.
2. Added several other fixes
[v1: https://lore.kernel.org/linux-kselftest/cover.1583657204.git.sai.praneeth.prakhya@intel.com/]

Fenghua Yu (18):
  selftests/resctrl: Rename CQM test as CMT test
  selftests/resctrl: Declare global variables as extern
  selftests/resctrl: Return if resctrl file system is not supported
  selftests/resctrl: Check for resctrl mount point only if resctrl FS is
    supported
  selftests/resctrl: Use resctrl/info for feature detection
  selftests/resctrl: Fix missing options "-n" and "-p"
  selftests/resctrl: Fix MBA/MBM results reporting format
  selftests/resctrl: Abort running tests if not root user
  selftests/resctrl: Enable gcc checks to detect buffer overflows
  selftests/resctrl: Don't hard code value of "no_of_bits" variable
  selftests/resctrl: Modularize resctrl test suite main() function
  selftests/resctrl: Skip the test if requested resctrl feature is not
    supported
  selftests/resctrl: Umount resctrl FS only if mounted
  selftests/resctrl: Unmount resctrl FS after running all tests
  selftests/resctrl: Fix incorrect parsing of iMC counters
  selftests/resctrl: Fix checking for < 0 for unsigned values
  selftests/resctrl: Fix unnecessary usage of global variables
  selftests/resctrl: Don't use global variable for capacity bitmask
    (CBM)

Reinette Chatre (3):
  selftests/resctrl: Fix typo
  selftests/resctrl: Fix typo in help text
  selftests/resctrl: Ensure sibling CPU is not same as original CPU

 tools/testing/selftests/resctrl/Makefile      |   2 +-
 tools/testing/selftests/resctrl/README        |   4 +-
 tools/testing/selftests/resctrl/cache.c       |   4 +-
 tools/testing/selftests/resctrl/cat_test.c    |  20 +--
 .../resctrl/{cqm_test.c => cmt_test.c}        |  34 ++--
 tools/testing/selftests/resctrl/mba_test.c    |  23 ++-
 tools/testing/selftests/resctrl/mbm_test.c    |  16 +-
 tools/testing/selftests/resctrl/resctrl.h     |  20 ++-
 .../testing/selftests/resctrl/resctrl_tests.c | 156 ++++++++++++------
 tools/testing/selftests/resctrl/resctrl_val.c |  75 ++++++---
 tools/testing/selftests/resctrl/resctrlfs.c   |  79 ++++++---
 11 files changed, 272 insertions(+), 161 deletions(-)
 rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (85%)

-- 
2.29.0

