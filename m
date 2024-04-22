Return-Path: <linux-kselftest+bounces-8595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35948AC4BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 09:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D54B1F21E38
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A3F487A7;
	Mon, 22 Apr 2024 07:08:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5048787;
	Mon, 22 Apr 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769732; cv=none; b=Qdmx8XExlr72QMH5qtg/u/JAEgIjTbukkdMX4lCVqjXd8ARzk4+lch0wSDDMalNUv57VhUARbD3tId5+X2L1tbXDoZEH5scKngpA/pf3+JviJ2kbNLrKR3s48BI4cvpWyQ+FA48Lfm7bXWo+BpUux79jwfHhd028VoM4FcJASzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769732; c=relaxed/simple;
	bh=mOE8EdBV6YspiQJow9uP5iTbIrLKoWnuomt0yvOUewY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gjIDv+mCIFYqo5cEataHfq1+cTpZfwu0JuyfUsRVktJR/oqIUd1omPgM6EdSygCn8hz4AwiGkFsw6p9NfxPOdiIh0ZNMxaTe2jUrDOVlk0/+DcGU9YkPuqBGHjsRau8A/6UK8FqhUf9iNyrft3Lv+jTiSLSuqloiHxpiRLuPJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA92C339;
	Mon, 22 Apr 2024 00:09:13 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C55AA3F7BD;
	Mon, 22 Apr 2024 00:08:40 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	suzuki.poulose@arm.com,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	Catalin.Marinas@arm.com,
	broonie@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 0/4] A new selftests/ directory for arm compatibility testing
Date: Mon, 22 Apr 2024 12:37:13 +0530
Message-Id: <20240422070717.2194201-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the selftests/arm directory, which tests 32 and 64-bit
kernel compatibility with 32-bit ELFs running on the Aarch platform.
The need for this bucket of tests is that 32 bit applications built on legacy
ARM architecture must not break on the new Aarch64 platforms and the 64-bit
kernel. The kernel must emulate the data structures, system calls and the
registers according to Aarch32, when running a 32-bit process; this directory
fills that testing requirement.

One may find similarity between this directory and selftests/arm64; it is
advisable to refer to that since a lot has been copied from there itself.

The mm directory includes a test for checking 4GB limit of the virtual
address space of a process.

The signal directory contains two tests, following a common theme: mangle
with arm_cpsr, dumped by the kernel to user space while invoking the signal
handler; kernel must spot this illegal attempt and terminate the program by
SEGV.

The elf directory includes a test for checking the 32-bit status of the ELF.

The series has been tested on 6.9-rc5, on Aarch64 platform. Testing remains
to be done on Aaarch32.

Changes in v2:
- Formatting changes
- Add .gitignore files and config file

Dev Jain (4):
  selftests/arm: Add mm test
  selftests/arm: Add signal tests
  selftests/arm: Add elf test
  selftests: Add build infrastructure along with README

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/arm/Makefile          |  57 ++++
 tools/testing/selftests/arm/README            |  31 +++
 tools/testing/selftests/arm/config            |   1 +
 tools/testing/selftests/arm/elf/.gitignore    |   2 +
 tools/testing/selftests/arm/elf/Makefile      |   6 +
 tools/testing/selftests/arm/elf/parse_elf.c   |  74 +++++
 tools/testing/selftests/arm/mm/.gitignore     |   2 +
 tools/testing/selftests/arm/mm/Makefile       |   6 +
 tools/testing/selftests/arm/mm/compat_va.c    |  92 +++++++
 tools/testing/selftests/arm/signal/.gitignore |   3 +
 tools/testing/selftests/arm/signal/Makefile   |  30 ++
 .../selftests/arm/signal/test_signals.c       |  27 ++
 .../selftests/arm/signal/test_signals.h       |  74 +++++
 .../selftests/arm/signal/test_signals_utils.c | 257 ++++++++++++++++++
 .../selftests/arm/signal/test_signals_utils.h | 128 +++++++++
 .../signal/testcases/mangle_cpsr_aif_bits.c   |  33 +++
 .../mangle_cpsr_invalid_compat_toggle.c       |  29 ++
 18 files changed, 853 insertions(+)
 create mode 100644 tools/testing/selftests/arm/Makefile
 create mode 100644 tools/testing/selftests/arm/README
 create mode 100644 tools/testing/selftests/arm/config
 create mode 100644 tools/testing/selftests/arm/elf/.gitignore
 create mode 100644 tools/testing/selftests/arm/elf/Makefile
 create mode 100644 tools/testing/selftests/arm/elf/parse_elf.c
 create mode 100644 tools/testing/selftests/arm/mm/.gitignore
 create mode 100644 tools/testing/selftests/arm/mm/Makefile
 create mode 100644 tools/testing/selftests/arm/mm/compat_va.c
 create mode 100644 tools/testing/selftests/arm/signal/.gitignore
 create mode 100644 tools/testing/selftests/arm/signal/Makefile
 create mode 100644 tools/testing/selftests/arm/signal/test_signals.c
 create mode 100644 tools/testing/selftests/arm/signal/test_signals.h
 create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.c
 create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.h
 create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_aif_bits.c
 create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c

-- 
2.39.2


