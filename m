Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09133E6CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhCQCY6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:24:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:55651 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhCQCYe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:34 -0400
IronPort-SDR: rMLWNmSwmZLNnuqrKOPV+zpTLK+E4+zAm3+QY+nsm842ZGL7nVr0Fdo7cy05mO+eThC67S3GGH
 ZmXEy0XsHuuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328702"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328702"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:33 -0700
IronPort-SDR: PjKH3Ym4H4FvhOz8sW+kORrDMfKFqCx5gtVOnRIvuPbYbNvZfpQQQpNAVTl84TvZj+wr684Gqm
 VNaheigjNTvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290234"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2021 19:24:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 00/21] Miscellaneous fixes for resctrl selftests
Date:   Wed, 17 Mar 2021 02:22:34 +0000
Message-Id: <20210317022255.2536745-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
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
v6:
- Add Tested-by: Babu Moger <babu.moger@amd.com>.
- Replace "cat" by CAT_STR etc (Babu).
- Capitalize the first letter of printed message (Babu).

v5:
- Address various comments from Shuah Khan:
  1. Move a few fixing patches before cleaning patches.
  2. Call kselftest APIs to log test results instead of printf().
  3. Add .gitignore to ignore resctrl_tests.
  4. Share show_cache_info() in CAT and CMT tests.
  5. Define long_mask, cbm_mask, count_of_bits etc as static variables.

v4:
- Address various comments from Shuah Khan:
  1. Combine a few patches e.g. a couple of fixing typos patches into one
     and a couple of unmounting patches into one etc.
  2. Add config file.
  3. Remove "Fixes" tags.
  4. Change strcmp() to strncmp().
  5. Move the global variable fixing patch to the patch 1 so that the
     compilation issue is fixed first.

Please note:
- I didn't move the patch of renaming CQM to CMT to the end of the series
  because code and commit messages in a few other patches depend on the
  new term of "CMT". If move the renaming patch to the end, the previous
  patches use the old "CQM" term and code which will be changed soon at
  the end of series and will cause more code and explanations.
[v3: https://lkml.org/lkml/2020/10/28/137]

v3:
Address various comments (commit messages, return value on test failure,
print failure info on test failure etc) from Reinette and Tony.
[v2: https://lore.kernel.org/linux-kselftest/cover.1589835155.git.sai.praneeth.prakhya@intel.com/]

v2:
1. Dropped changes to CAT test and CMT test as they will be posted in a later
   series.
2. Added several other fixes
[v1: https://lore.kernel.org/linux-kselftest/cover.1583657204.git.sai.praneeth.prakhya@intel.com/]

Fenghua Yu (19):
  selftests/resctrl: Enable gcc checks to detect buffer overflows
  selftests/resctrl: Fix compilation issues for global variables
  selftests/resctrl: Fix compilation issues for other global variables
  selftests/resctrl: Clean up resctrl features check
  selftests/resctrl: Fix missing options "-n" and "-p"
  selftests/resctrl: Rename CQM test as CMT test
  selftests/resctrl: Call kselftest APIs to log test results
  selftests/resctrl: Share show_cache_info() by CAT and CMT tests
  selftests/resctrl: Add config dependencies
  selftests/resctrl: Check for resctrl mount point only if resctrl FS is
    supported
  selftests/resctrl: Use resctrl/info for feature detection
  selftests/resctrl: Fix MBA/MBM results reporting format
  selftests/resctrl: Don't hard code value of "no_of_bits" variable
  selftests/resctrl: Modularize resctrl test suite main() function
  selftests/resctrl: Skip the test if requested resctrl feature is not
    supported
  selftests/resctrl: Fix unmount resctrl FS
  selftests/resctrl: Fix incorrect parsing of iMC counters
  selftests/resctrl: Fix checking for < 0 for unsigned values
  selftests/resctrl: Create .gitignore to include resctrl_tests

Reinette Chatre (2):
  selftests/resctrl: Ensure sibling CPU is not same as original CPU
  selftests/resctrl: Fix a printed message

 tools/testing/selftests/resctrl/.gitignore    |   2 +
 tools/testing/selftests/resctrl/Makefile      |   2 +-
 tools/testing/selftests/resctrl/README        |   4 +-
 tools/testing/selftests/resctrl/cache.c       |  52 +++++-
 tools/testing/selftests/resctrl/cat_test.c    |  57 ++----
 .../resctrl/{cqm_test.c => cmt_test.c}        |  75 +++-----
 tools/testing/selftests/resctrl/config        |   2 +
 tools/testing/selftests/resctrl/fill_buf.c    |   4 +-
 tools/testing/selftests/resctrl/mba_test.c    |  43 ++---
 tools/testing/selftests/resctrl/mbm_test.c    |  42 ++---
 tools/testing/selftests/resctrl/resctrl.h     |  29 +++-
 .../testing/selftests/resctrl/resctrl_tests.c | 163 ++++++++++++------
 tools/testing/selftests/resctrl/resctrl_val.c |  95 ++++++----
 tools/testing/selftests/resctrl/resctrlfs.c   | 134 ++++++++------
 14 files changed, 408 insertions(+), 296 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/.gitignore
 rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (56%)
 create mode 100644 tools/testing/selftests/resctrl/config

-- 
2.31.0

