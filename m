Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC540CDF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhIOUcd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:13811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhIOUcd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109357"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109357"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092769"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:12 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] selftests/sgx: Oversubscription, page permission, thread entry
Date:   Wed, 15 Sep 2021 13:30:50 -0700
Message-Id: <cover.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Everybody,

This series consists out of outstanding SGX selftests changes, rebased
and gathered in a single series that is more easily merged for testing
and development, and a few more changes added to expand the existing tests.

The outstanding SGX selftest changes included in this series that have already
been submitted separately are:

* An almost two year old patch fixing a benign linker warning that is still
  present today:
  https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.christopherson@intel.com/
  The original patch is added intact and not all email addresses
  within are valid.

* Latest (v4) of Jarkko Sakkinen's series to add an oversubscription test:
  https://lore.kernel.org/linux-sgx/20210809093127.76264-1-jarkko@kernel.org/

* Latest (v2) of Jarkko Sakkinen's patch that provides provide per-op
  parameter structs for the test enclave:
  https://lore.kernel.org/linux-sgx/20210812224645.90280-1-jarkko@kernel.org/

The reason why most of these patches are outstanding is that they depend
on a kernel change that is still under discussion. Decision to wait in:
https://lore.kernel.org/linux-sgx/f8674dac5579a8a424de1565f7ffa2b5bf2f8e36.camel@kernel.org/
The original patch for this kernel dependency continues to be included in
this series as a placeholder until the ongoing discussions are concluded.

The new changes introduced in this series builds on Jarkko's outstanding
SGX selftest changes and adds new tests for page permissions, exception
handling, and thread entry.

Reinette

Jarkko Sakkinen (9):
  x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
  selftests/sgx: Assign source for each segment
  selftests/sgx: Make data measurement for an enclave segment optional
  selftests/sgx: Create a heap for the test enclave
  selftests/sgx: Dump segments and /proc/self/maps only on failure
  selftests/sgx: Encpsulate the test enclave creation
  selftests/sgx: Move setup_test_encl() to each TEST_F()
  selftests/sgx: Add a new kselftest: unclobbered_vdso_oversubscribed
  selftests/sgx: Provide per-op parameter structs for the test enclave

Reinette Chatre (4):
  selftests/sgx: Rename test properties in preparation for more enclave
    tests
  selftests/sgx: Add page permission and exception test
  selftests/sgx: Enable multiple thread support
  selftests/sgx: Add test for multiple TCS entry

Sean Christopherson (1):
  selftests/x86/sgx: Fix a benign linker warning

 Documentation/x86/sgx.rst                     |   6 +
 arch/x86/kernel/cpu/sgx/main.c                |  10 +-
 tools/testing/selftests/sgx/Makefile          |   2 +-
 tools/testing/selftests/sgx/defines.h         |  33 +-
 tools/testing/selftests/sgx/load.c            |  40 +-
 tools/testing/selftests/sgx/main.c            | 341 +++++++++++++++---
 tools/testing/selftests/sgx/main.h            |   7 +-
 tools/testing/selftests/sgx/sigstruct.c       |  12 +-
 tools/testing/selftests/sgx/test_encl.c       |  60 ++-
 .../selftests/sgx/test_encl_bootstrap.S       |  21 +-
 10 files changed, 445 insertions(+), 87 deletions(-)

-- 
2.25.1

