Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAC255B2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Aug 2020 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgH1NYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Aug 2020 09:24:32 -0400
Received: from foss.arm.com ([217.140.110.172]:49352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgH1NY0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Aug 2020 09:24:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC4AA1FB;
        Fri, 28 Aug 2020 06:16:22 -0700 (PDT)
Received: from e124572.arm.com (unknown [10.57.13.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B1983F66B;
        Fri, 28 Aug 2020 06:16:20 -0700 (PDT)
From:   Boyan Karatotev <boyan.karatotev@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, amit.kachhap@arm.com,
        boian4o1@gmail.com, Boyan Karatotev <boyan.karatotev@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 0/4] kselftests/arm64: add PAuth tests
Date:   Fri, 28 Aug 2020 14:16:02 +0100
Message-Id: <20200828131606.7946-1-boyan.karatotev@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Pointer Authentication (PAuth) is a security feature introduced in ARMv8.3.
It introduces instructions to sign addresses and later check for potential
corruption using a second modifier value and one of a set of keys. The
signature, in the form of the Pointer Authentication Code (PAC), is stored
in some of the top unused bits of the virtual address (e.g. [54: 49] if
TBID0 is enabled and TnSZ is set to use a 48 bit VA space). A set of
controls are present to enable/disable groups of instructions (which use
certain keys) for compatibility with libraries that do not utilize the
feature. PAuth is used to verify the integrity of return addresses on the
stack with less memory than the stack canary.

This patchset adds kselftests to verify the kernel's configuration of the
feature and its runtime behaviour. There are 7 tests which verify that:
	* an authentication failure leads to a SIGSEGV
	* the data/instruction instruction groups are enabled
	* the generic instructions are enabled
	* all 5 keys are unique for a single thread
	* exec() changes all keys to new unique ones
	* context switching preserves the 4 data/instruction keys
	* context switching preserves the generic keys

The tests have been verified to work on qemu without a working PAUTH
Implementation and on ARM's FVP with a full or partial PAuth
implementation.

Note: This patchset is only verified for ARMv8.3 and there will be some
changes required for ARMv8.6. More details can be found here [1]. Once
ARMv8.6 PAuth is merged the first test in this series will required to be
updated.

[1] https://lore.kernel.org/linux-arm-kernel/1597734671-23407-1-git-send-email-amit.kachhap@arm.com/

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>

Boyan Karatotev (4):
  kselftests/arm64: add a basic Pointer Authentication test
  kselftests/arm64: add nop checks for PAuth tests
  kselftests/arm64: add PAuth test for whether exec() changes keys
  kselftests/arm64: add PAuth tests for single threaded consistency and
    key uniqueness

 tools/testing/selftests/arm64/Makefile        |   2 +-
 .../testing/selftests/arm64/pauth/.gitignore  |   2 +
 tools/testing/selftests/arm64/pauth/Makefile  |  29 ++
 .../selftests/arm64/pauth/exec_target.c       |  35 ++
 tools/testing/selftests/arm64/pauth/helper.c  |  41 +++
 tools/testing/selftests/arm64/pauth/helper.h  |  30 ++
 tools/testing/selftests/arm64/pauth/pac.c     | 347 ++++++++++++++++++
 .../selftests/arm64/pauth/pac_corruptor.S     |  36 ++
 8 files changed, 521 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/pauth/.gitignore
 create mode 100644 tools/testing/selftests/arm64/pauth/Makefile
 create mode 100644 tools/testing/selftests/arm64/pauth/exec_target.c
 create mode 100644 tools/testing/selftests/arm64/pauth/helper.c
 create mode 100644 tools/testing/selftests/arm64/pauth/helper.h
 create mode 100644 tools/testing/selftests/arm64/pauth/pac.c
 create mode 100644 tools/testing/selftests/arm64/pauth/pac_corruptor.S

--
2.17.1

