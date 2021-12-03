Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB1346729F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 08:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378895AbhLCHf0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 02:35:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:9200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378867AbhLCHf0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 02:35:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236740504"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="236740504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 23:32:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="513607745"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 23:32:00 -0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [RFC PATCH v5 0/2]  Introduce XSAVE feature self-test
Date:   Fri,  3 Dec 2021 15:32:44 +0800
Message-Id: <cover.1638513720.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The XSAVE feature set supports the saving and restoring of xstate components,
which is used for process context switching. The state components include
x87 state for FPU execution environment, SSE state, AVX state and so on.
In order to ensure that XSAVE works correctly, add XSAVE basic test for XSAVE
architecture functionality.

This patch set tests and verifies the basic functions of XSAVE in user
space; it tests "FPU, AVX2, AVX512 opmask and PKRU" xstates(will call
them "above xstates" instead) with following cases:
1. In nested signal processing, the signal handling will use each signal's own
   xstates, and the xstates of the signal handling under test should not be
   changed after another nested signal handling is completed; and the above
   mentioned xstates in the process should not change after the nested signal
   handling is complete.
2. Above xstates in child process should same as parent xstates; and after
   process switch, the above xstates contents in child process should not be
   changed.

This series introduces only the most basic XSAVE tests. In the future, the
intention is to continue expanding the scope of these selftests to include
more xstates and kernel XSAVE-related functionality tests.

========
- Change from v4 to v5:
  - Moved code files into tools/testing/selftests/x86.
  - Delete xsave instruction test, becaue it's not related to kernel.
  - Improved case description.
  - Added AVX512 opmask change and related XSAVE content verification.
  - Added PKRU part xstate test into instruction and signal handling test.
  - Added XSAVE process swich test for FPU, AVX2, AVX512 opmask and PKRU part.

- Change from v3 to v4:
  - Improve the comment in patch 1.

- Change from v2 to v3:
  - Improve the description of patch 2 git log.

- Change from v1 to v2:
  - Improve the cover-letter. Thanks Dave Hansen's suggestion.

Pengfei Xu (2):
  selftests/x86: add xsave test during and after signal handling
  selftests/x86: add xsave test after process switch

 tools/testing/selftests/x86/Makefile          |   4 +-
 tools/testing/selftests/x86/xsave_common.h    | 426 ++++++++++++++++++
 tools/testing/selftests/x86/xsave_fork_test.c | 127 ++++++
 .../selftests/x86/xsave_signal_handle.c       | 192 ++++++++
 4 files changed, 747 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/x86/xsave_common.h
 create mode 100644 tools/testing/selftests/x86/xsave_fork_test.c
 create mode 100644 tools/testing/selftests/x86/xsave_signal_handle.c

-- 
2.27.0

