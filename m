Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30016451044
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 19:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbhKOSpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 13:45:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:59273 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242654AbhKOSnP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 13:43:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220713089"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="220713089"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 10:35:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="454130649"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 10:35:37 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 00/13] selftests/sgx: Oversubscription, page permission, thread entry
Date:   Mon, 15 Nov 2021 10:35:13 -0800
Message-Id: <cover.1636997631.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

V2 available at:
https://lore.kernel.org/lkml/cover.1635447301.git.reinette.chatre@intel.com/

Changes since V2:
- Remove the non-kselftest placeholder patches while also removing their
  usage within the SGX selftests. Instead, the SGX selftests obtain needed
  data from CPUID directly (Dave).
- Rewrite commit message of "selftests/x86/sgx: Fix a benign linker
  warning" (Dave).
- Add Jarkko's signature to "selftests/sgx: Add page permission and
  exception test" (Jarkko).

V1 available at:
https://lore.kernel.org/lkml/cover.1631731214.git.reinette.chatre@intel.com/

Changes since V1:

- Biggest change: The non-kselftest placeholder patches included in this series
  that the kselftest work depends on are still being discussed elsewhere
  (link below) but has changed significantly since the first submission,
  warranting an update to the kselftest patches that depend on it.
  Jarkko: I made significant modifications to your
  "selftests/sgx: Add a new kselftest: unclobbered_vdso_oversubscribed"
  that you may want to look at.
- Improve cover letter and changelogs (Dave).
- Add Jarkko and Dave's signatures where obtained (Jarkko and Dave).
- Fix Cedric's signature in patch 1 (Jarkko and Cedric).
- Improve the loop locating the data segment (Jarkko).
- Update placeholder patches that makes the amount of SGX memory available to
  latest version (v8). Previously this dependency consisted out of one
  patch, now it spans two.

Hi Everybody,

This series consists out of outstanding SGX selftests changes, rebased
and gathered in a single series that can easily be merged for testing
and development, and a few more changes added to expand the existing tests.

The outstanding SGX selftest changes included in this series that have already
been submitted separately are:

* A more than two year old patch fixing a benign linker warning that is still
  present today:
  https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.christopherson@intel.com/
  The original patch is added intact and not all email addresses
  within are valid.

* Latest (v4) of Jarkko Sakkinen's series to add an oversubscription test:
  https://lore.kernel.org/linux-sgx/20210809093127.76264-1-jarkko@kernel.org/

* Latest (v2) of Jarkko Sakkinen's patch that provides per-op
  parameter structs for the test enclave:
  https://lore.kernel.org/linux-sgx/20210812224645.90280-1-jarkko@kernel.org/

The new changes introduced in this series builds on Jarkko's outstanding
SGX selftest changes and adds new tests for page permissions, exception
handling, and thread entry.

Building and running enclaves is painful and traditionally requires a
big software stack. This adds features like threads to the SGX selftests
which are traditionally implemented in that big software stack. This
helps test SGX kernel support with only code from the kernel tree.

Reinette

Jarkko Sakkinen (8):
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

 tools/testing/selftests/sgx/Makefile          |   2 +-
 tools/testing/selftests/sgx/defines.h         |  33 +-
 tools/testing/selftests/sgx/load.c            |  40 +-
 tools/testing/selftests/sgx/main.c            | 357 +++++++++++++++---
 tools/testing/selftests/sgx/main.h            |   6 +-
 tools/testing/selftests/sgx/sigstruct.c       |  12 +-
 tools/testing/selftests/sgx/test_encl.c       |  60 ++-
 .../selftests/sgx/test_encl_bootstrap.S       |  21 +-
 8 files changed, 445 insertions(+), 86 deletions(-)

-- 
2.25.1

