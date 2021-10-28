Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4139443E9A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhJ1Uj7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:39:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:25707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhJ1Uj6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:39:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230775396"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="230775396"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498562989"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:29 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/15] selftests/sgx: Oversubscription, page permission, thread entry
Date:   Thu, 28 Oct 2021 13:37:25 -0700
Message-Id: <cover.1635447301.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

The reason why most of these patches are outstanding is that they depend
on a kernel change that is still under discussion. Decision to wait in:
https://lore.kernel.org/linux-sgx/f8674dac5579a8a424de1565f7ffa2b5bf2f8e36.camel@kernel.org/
The latest patches (v8) for this dependency is included in
this series as a placeholder until the ongoing discussions are concluded:
https://lore.kernel.org/lkml/20211018135744.45527-1-jarkko@kernel.org/
https://lore.kernel.org/lkml/20211018135744.45527-2-jarkko@kernel.org/

The new changes introduced in this series builds on Jarkko's outstanding
SGX selftest changes and adds new tests for page permissions, exception
handling, and thread entry.

Building and running enclaves is painful and traditionally requires a
big software stack. This adds features like threads to the SGX selftests
which are traditionally implemented in that big software stack. This
helps test SGX kernel support with only code from the kernel tree.

Reinette

Jarkko Sakkinen (10):
  x86/sgx: Rename fallback labels in sgx_init()
  x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node
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

 Documentation/ABI/stable/sysfs-devices-node   |   7 +
 arch/x86/kernel/cpu/sgx/main.c                |  97 ++++-
 arch/x86/kernel/cpu/sgx/sgx.h                 |   2 +
 tools/testing/selftests/sgx/Makefile          |   2 +-
 tools/testing/selftests/sgx/defines.h         |  33 +-
 tools/testing/selftests/sgx/load.c            |  40 +-
 tools/testing/selftests/sgx/main.c            | 396 ++++++++++++++++--
 tools/testing/selftests/sgx/main.h            |   7 +-
 tools/testing/selftests/sgx/sigstruct.c       |  12 +-
 tools/testing/selftests/sgx/test_encl.c       |  60 ++-
 .../selftests/sgx/test_encl_bootstrap.S       |  21 +-
 11 files changed, 585 insertions(+), 92 deletions(-)

base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f

-- 
2.25.1

