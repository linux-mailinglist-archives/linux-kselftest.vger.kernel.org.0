Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3489843B259
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 14:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhJZM1k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 08:27:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:8643 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234359AbhJZM1i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 08:27:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="228647488"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="228647488"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 05:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="486160664"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.28.105])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2021 05:25:03 -0700
Subject: [PATCH 0/2] selftest/x86: AMX CPU state management tests
To:     dave.hansen@intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        chang.seok.bae@intel.com, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 26 Oct 2021 05:25:23 -0700
Message-Id: <20211026122523.AFB99C1F@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Intel Advanced Matrix Extensions (AMX) are a new set registers
and ISA.  They are conceptually similar to the earlier AVX and
SSE ISA.  But, the registers as a whole are *really* big: ~8k
verus 2k for AVX-512.

Those amply-sized registers present some potential problems with
task_struct and signal stack bloat.  To fix those issues, most of
the new AMX state is dynamically allocated with the help of a new
CPU feature.

This new selftest exercises the new dynamic allocation ABI and
also ensures that AMX state is properly context-switched.

Processors that support AMX (Sapphire Rapids) are not publicly
available.  The kernel support needed to run these tests is not
upstream.  This selftest was developed against this tree:

	https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/log/?h=x86/fpu

These tests were primarily written by Chang Bae.  He's busy
working on the real kernel support, so I stole these and cleaned
them up a bit.

Chang S. Bae (2):
      selftest/x86/amx: Test cases for the AMX state management
      selftest/x86/amx: Add context switch test

 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/amx.c    | 851 +++++++++++++++++++++++++++
 2 files changed, 852 insertions(+), 1 deletion(-)

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

