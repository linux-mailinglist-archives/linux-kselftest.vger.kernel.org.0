Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7C13FB49
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbgAPVWI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:38728 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbgAPVWI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870921"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2020 13:22:07 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "linux-kselftest" <linux-kselftest@vger.kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RESEND PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
Date:   Thu, 16 Jan 2020 13:32:33 -0800
Message-Id: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[Resend the v9 patch set to Shuah Khan and linux-kselftest mailing list.
No code and commit message change.]

With more and more resctrl features are being added by Intel, AMD
and ARM, a test tool is becoming more and more useful to validate
that both hardware and software functionalities work as expected.

We introduce resctrl selftest to cover resctrl features on X86, AMD
and ARM architectures. It first implements MBM (Memory Bandwidth
Monitoring), MBA (Memory Bandwidth Allocation), L3 CAT (Cache Allocation
Technology), and CQM (Cache QoS Monitoring)  tests. We will enhance
the selftest tool to include more functionality tests in the future.

The tool has been tested on Intel RDT, AMD QoS and ARM MPAM and is
in tools/testing/selftests/resctrl in order to have generic test code
base for all architectures.

The selftest tool we are introducing here provides a convenient
tool which does automatic resctrl testing, is easily available in kernel
tree, and covers Intel RDT, AMD QoS and ARM MPAM.

There is an existing resctrl test suite 'intel_cmt_cat'. But its major
purpose is to test Intel RDT hardware via writing and reading MSR
registers. It does access resctrl file system; but the functionalities
are very limited. And it doesn't support automatic test and a lot of
manual verifications are involved.

Changelog:
v9:
- Per Boris suggestion, add Co-developed-by in each patch to make it
  clear who contributed to the patch set.

v8:
Update code per comments from Andre Przywara from ARM:
- Change Makefile and remove inline assembly code to build and test the
  tool on ARM
- Change the output to TAP format because the format is both readable by
  human and other test tools.
- Detect resctrl feature from /proc/cpuinfo instead of dmesg to support
  generic detection on all architectures.
- Fix a few coding issues.

v7:
- Fix a few warnings when compiling patches separately, pointed by Babu 

v6:
- Fix a benchmark reading optimized out issue in newer GCC.
- Fix a few coding style issues.
- Re-arrange code among patches to make cleaner code. No change in patches
structure.

v5:
- Based the v4 patches submitted by Fenghua Yu and added changes to support
  AMD.
- Changed the function name get_sock_num to get_resource_id. Intel uses
  socket number for schemata and AMD uses l3 index id. To generalize,
  changed the function name to get_resource_id.
- Added the code to detect vendor.
- Disabled the few tests for AMD where the test results are not clear.
  Also AMD does not have IMC.
- Fixed few compile issues.
- Some cleanup to make each patch independent.
- Tested the patches on AMD system. Fenghua, Need your help to test on
  Intel box. Please feel free to change and resubmit if something
   broken.

v4:
- address comments from Balu and Randy
- Add CAT and CQM tests

v3:
- Change code based on comments from Babu Moger
- Remove some unnessary code and use pipe to communicate b/w processes

v2:
- Change code based on comments from Babu Moger
- Clean up other places.

Babu Moger (3):
  selftests/resctrl: Add vendor detection mechanism
  selftests/resctrl: Use cache index3 id for AMD schemata masks
  selftests/resctrl: Disable MBA and MBM tests for AMD

Fenghua Yu (6):
  selftests/resctrl: Add README for resctrl tests
  selftests/resctrl: Add MBM test
  selftests/resctrl: Add MBA test
  selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest
  selftests/resctrl: Add Cache Allocation Technology (CAT) selftest
  selftests/resctrl: Add the test in MAINTAINERS

Sai Praneeth Prakhya (4):
  selftests/resctrl: Add basic resctrl file system operations and data
  selftests/resctrl: Read memory bandwidth from perf IMC counter and
    from resctrl file system
  selftests/resctrl: Add callback to start a benchmark
  selftests/resctrl: Add built in benchmark

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/resctrl/Makefile      |  17 +
 tools/testing/selftests/resctrl/README        |  53 ++
 tools/testing/selftests/resctrl/cache.c       | 272 +++++++
 tools/testing/selftests/resctrl/cat_test.c    | 250 ++++++
 tools/testing/selftests/resctrl/cqm_test.c    | 176 +++++
 tools/testing/selftests/resctrl/fill_buf.c    | 213 +++++
 tools/testing/selftests/resctrl/mba_test.c    | 171 ++++
 tools/testing/selftests/resctrl/mbm_test.c    | 145 ++++
 tools/testing/selftests/resctrl/resctrl.h     | 107 +++
 .../testing/selftests/resctrl/resctrl_tests.c | 202 +++++
 tools/testing/selftests/resctrl/resctrl_val.c | 744 ++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 722 +++++++++++++++++
 13 files changed, 3073 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/README
 create mode 100644 tools/testing/selftests/resctrl/cache.c
 create mode 100644 tools/testing/selftests/resctrl/cat_test.c
 create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c
 create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

-- 
2.19.1

