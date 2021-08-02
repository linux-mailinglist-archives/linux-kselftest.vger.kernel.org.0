Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF563DCF0D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 06:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhHBEBF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 00:01:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:8832 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhHBEBF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 00:01:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="193660633"
X-IronPort-AV: E=Sophos;i="5.84,287,1620716400"; 
   d="scan'208";a="193660633"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 21:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,287,1620716400"; 
   d="scan'208";a="668971385"
Received: from fedora29.sh.intel.com ([10.239.182.87])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2021 21:00:53 -0700
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        Yu Yu-cheng <yu-cheng.yu@intel.com>,
        Yu Fenghua <fenghua.yu@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>
Subject: [RFC PATCH v2 0/2] Introduce XSAVE/XRSTOR self-test
Date:   Mon,  2 Aug 2021 12:00:02 +0800
Message-Id: <cover.1627457824.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The XSAVE feature set supports the saving and restoring of state components,
and XSAVE feature is used for process context switching. The XSAVE state
components include x87 state for FPU execution environment, SSE state, AVX
state and so on. In order to ensure that XSAVE works correctly, add XSAVE
basic test for XSAVE architecture functionality.

This patch set tests and verifies the basic functions of XSAVE/XRSTOR in
user space; during and after signal processing on the x86 platform, the
XSAVE contents of the process should not be changed.

This series introduces only the most basic XSAVE tests.  In the
future, the intention is to continue expanding the scope of
these selftests to include more kernel XSAVE-related functionality
and XSAVE-managed features like AMX and shadow stacks.

Pengfei Xu (2):
  selftests/xsave: test basic XSAVE architecture functionality
  selftests/xsave: add xsave test during and after signal handling

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/xsave/.gitignore      |   3 +
 tools/testing/selftests/xsave/Makefile        |   6 +
 tools/testing/selftests/xsave/xsave_common.h  | 246 ++++++++++++++++++
 .../selftests/xsave/xsave_instruction.c       |  83 ++++++
 .../selftests/xsave/xsave_signal_handle.c     | 184 +++++++++++++
 6 files changed, 523 insertions(+)
 create mode 100644 tools/testing/selftests/xsave/.gitignore
 create mode 100644 tools/testing/selftests/xsave/Makefile
 create mode 100644 tools/testing/selftests/xsave/xsave_common.h
 create mode 100644 tools/testing/selftests/xsave/xsave_instruction.c
 create mode 100644 tools/testing/selftests/xsave/xsave_signal_handle.c

-- 
2.20.1

