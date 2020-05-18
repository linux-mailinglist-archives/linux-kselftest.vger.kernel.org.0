Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E051D8A71
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgERWNx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:13:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgERWNx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:13:53 -0400
IronPort-SDR: RbIH7+kWadAbPlFHAVuEH5camefOHM/lGgs9ZAPg1yAY6PdBX+CkNyBQHrhknUihiyf8h4m9Ci
 lSuMgWi7rmrw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:52 -0700
IronPort-SDR: dOWp7UyjeA/yWpYHvWScgzWBmGfSQaAenxZpm+NGQm1hQDar771S+7Q/NekZLvnufGBhsJMhsq
 gDLxfpXsvhwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420328"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:51 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 00/19] Miscellaneous fixes for resctrl selftests
Date:   Mon, 18 May 2020 15:08:20 -0700
Message-Id: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch set has several miscellaneous fixes to resctrl selftest tool that are
easily visible to user. V1 had fixes to CAT test and CMT test but they were
dropped in V2 because having them here made the patchset humongous. So, changes
to CAT test and CMT test will be posted in another patchset.

Some warnings reported by sparse tool were fixed in this patchset but some are
not yet fixed. They will be fixed in another patchset.

Patches 1 to 14, 18 and 19 are independent fixes.
Patches 15 and 16 are preparatory patches for patch 17.

Thanks to Dan and David for reporting couple of issues.

V1 can be found at: https://lkml.org/lkml/2020/3/6/1249

Based on v5.7-rc6.

Changes from V1:
================
1. Dropped changes to CAT test and CMT test as they will be posted in a later
   series.
2. Added several other fixes

Fenghua Yu (1):
  selftests/resctrl: Fix missing options "-n" and "-p"

Reinette Chatre (3):
  selftests/resctrl: Fix typo
  selftests/resctrl: Fix typo in help text
  selftests/resctrl: Ensure sibling CPU is not same as original CPU

Sai Praneeth Prakhya (15):
  selftests/resctrl: Rename CQM test as CMT test
  selftests/resctrl: Declare global variables as extern
  selftests/resctrl: Return if resctrl file system is not supported
  selftests/resctrl: Check for resctrl mount point only if resctrl FS is
    supported
  selftests/resctrl: Use resctrl/info for feature detection
  selftests/resctrl: Fix MBA/MBM results reporting format
  selftests/resctrl: Abort running tests if not root user
  selftests/resctrl: Enable gcc checks to detect buffer overflows
  selftests/resctrl: Dynamically select buffer size for CAT test
  selftests/resctrl: Skip the test if requested resctrl feature is not
    supported
  selftests/resctrl: Change return type of umount_resctrlfs() to void
  selftests/resctrl: Umount resctrl FS only if mounted
  selftests/resctrl: Unmount resctrl FS after running all tests
  selftests/resctrl: Fix incorrect parsing of iMC counters
  selftests/resctrl: Fix checking for < 0 for unsigned values

 tools/testing/selftests/resctrl/Makefile      |  2 +-
 tools/testing/selftests/resctrl/README        |  4 +-
 tools/testing/selftests/resctrl/cache.c       |  4 +-
 tools/testing/selftests/resctrl/cat_test.c    |  8 +-
 .../resctrl/{cqm_test.c => cmt_test.c}        | 23 +++---
 tools/testing/selftests/resctrl/mba_test.c    | 23 +++---
 tools/testing/selftests/resctrl/mbm_test.c    | 16 ++--
 tools/testing/selftests/resctrl/resctrl.h     | 20 +++--
 .../testing/selftests/resctrl/resctrl_tests.c | 69 ++++++++++++-----
 tools/testing/selftests/resctrl/resctrl_val.c | 67 ++++++++++------
 tools/testing/selftests/resctrl/resctrlfs.c   | 77 +++++++++++++------
 11 files changed, 195 insertions(+), 118 deletions(-)
 rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (88%)

-- 
2.19.1

