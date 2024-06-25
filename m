Return-Path: <linux-kselftest+bounces-12635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D741E9167B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073FC1C25721
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404DE158D92;
	Tue, 25 Jun 2024 12:24:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1B91667DA;
	Tue, 25 Jun 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318275; cv=none; b=iRvB8H15P3dBG5m2oejdWbKx8yPxw3WCxyzLGzqlGQvYuPv8M13UYwY9oydV9vp5VEQj02/pEfYDi2q9XaUYoBVmdXoiVDBYBdCy17S/tQsR1gqwdEFiPNuAhquQiAzUAw+pqm2bqy+m6a4feEkKjdqD4AqtedxqlOjI/j4SPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318275; c=relaxed/simple;
	bh=/rRCtskBhXeBwcbcNVT7TAc07rOolkzrAOHf7Do32aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NsB/19HSGUoDD/urinWhtucz4gLcQcftTGGM0f7+kFPWYX9vgI9c9IXTbXCiWntVEa9e0Y3qbGwYBpO3blPQTxZK6BdgCaw+NJcoRvlfmEAKf/FSWE43QoWkDnVUqrA7U+qkhRDZvlTnM8ne3ksQh3y5Zx2pbKXP4JJN1pCOqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE051339;
	Tue, 25 Jun 2024 05:24:56 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F04E83F766;
	Tue, 25 Jun 2024 05:24:26 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 0/9] A new selftests/ directory for arm compatibility testing
Date: Tue, 25 Jun 2024 17:53:59 +0530
Message-Id: <20240625122408.1439097-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the selftests/arm directory, which tests 32 and
64-bit kernel compatibility with 32-bit ELFs running on the Aarch platform.
The need for this bucket of tests is that 32 bit applications built on
legacy ARM architecture must not break on the new Aarch64 platforms and
the 64-bit kernel. The kernel must emulate the data structures, system
calls and the registers according to Aarch32, when running a 32-bit
process; this directory fills that testing requirement.

One may find similarity between this directory and selftests/arm64; it is
advisable to refer to that since a lot has been pulled from there itself.

The mm directory includes a test for checking 4GB limit of the virtual
address space of a process.

The signal directory contains two tests, following a common theme: mangle
with arm_cpsr, dumped by the kernel to user space while invoking the signal
handler; kernel must spot this illegal attempt and terminate the program by
SEGV.

The elf directory includes a test for checking the 32-bit status of the ELF.

The abi directory includes two ptrace tests, in the first, a 32-bit parent
debugs a 32-bit child, and in the second, a 64-bit parent debugs a 32-bit
child. The second test will be skipped when running on a 32-bit kernel.

Credits to Mark Brown for suggesting this work.

Testing:
The series has been tested on the Aarch64 kernel. For the Aarch32 kernel,
I used qemu-system-arm with machine 'vexpress-a15', along with a buildroot
rootfs; the individual statically built tests pass on that, but building
the entire test suite on that remains untested, due to my lack of
experience with qemu and rootfses.
Since I have done some changes in selftests/arm64, I have tested that
those tests do not break.

v2->v3:
 - mm, elf: Split into multiple testcases
 - Eliminate copying in signal/ using ifdeffery and pulling from selftests/arm64
 - Delete config file, since it does not make sense for testing a 32-bit kernel
 - Split ptrace in selftests/arm64, and pull some stuff from there
 - Add abi tests containing ptrace and ptrace_64
 - Fix build warnings in selftests/arm64 (can be applied independent of this series)

v1->v2:
 - Formatting changes
 - Add .gitignore files and config file

v1:
 - https://lore.kernel.org/all/20240405084410.256788-1-dev.jain@arm.com/

Dev Jain (9):
  selftests/arm: Add mm test
  selftests/arm: Add elf test
  selftests: arm, arm64: Use ifdeffery to pull signal infrastructure
  selftests/arm: Add signal tests
  selftests/arm64: Fix build warnings for ptrace
  selftests/arm64: Split ptrace, use ifdeffery
  selftests/arm: Add ptrace test
  selftests/arm: Add ptrace_64 test
  selftests: Add build infrastructure along with README

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/arm/Makefile          |  56 ++++++++
 tools/testing/selftests/arm/README            |  32 +++++
 tools/testing/selftests/arm/abi/.gitignore    |   4 +
 tools/testing/selftests/arm/abi/Makefile      |  26 ++++
 tools/testing/selftests/arm/abi/ptrace.c      |  82 +++++++++++
 tools/testing/selftests/arm/abi/ptrace.h      |  57 ++++++++
 tools/testing/selftests/arm/abi/ptrace_64.c   |  91 ++++++++++++
 .../selftests/arm/abi/trivial_32bit_program.c |  14 ++
 tools/testing/selftests/arm/elf/.gitignore    |   2 +
 tools/testing/selftests/arm/elf/Makefile      |   6 +
 tools/testing/selftests/arm/elf/parse_elf.c   |  77 ++++++++++
 tools/testing/selftests/arm/mm/.gitignore     |   2 +
 tools/testing/selftests/arm/mm/Makefile       |   6 +
 tools/testing/selftests/arm/mm/compat_va.c    |  89 ++++++++++++
 tools/testing/selftests/arm/signal/.gitignore |   3 +
 tools/testing/selftests/arm/signal/Makefile   |  30 ++++
 .../selftests/arm/signal/test_signals.c       |   2 +
 .../selftests/arm/signal/test_signals.h       |   2 +
 .../selftests/arm/signal/test_signals_utils.c |   2 +
 .../selftests/arm/signal/test_signals_utils.h |   2 +
 .../testcases/mangle_cpsr_invalid_aif_bits.c  |  33 +++++
 .../mangle_cpsr_invalid_compat_toggle.c       |  29 ++++
 tools/testing/selftests/arm64/abi/ptrace.c    | 121 ++--------------
 tools/testing/selftests/arm64/abi/ptrace.h    | 135 ++++++++++++++++++
 .../selftests/arm64/signal/test_signals.h     |  12 ++
 .../arm64/signal/test_signals_utils.c         |  51 +++++--
 .../arm64/signal/test_signals_utils.h         |   3 +
 28 files changed, 850 insertions(+), 120 deletions(-)
 create mode 100644 tools/testing/selftests/arm/Makefile
 create mode 100644 tools/testing/selftests/arm/README
 create mode 100644 tools/testing/selftests/arm/abi/.gitignore
 create mode 100644 tools/testing/selftests/arm/abi/Makefile
 create mode 100644 tools/testing/selftests/arm/abi/ptrace.c
 create mode 100644 tools/testing/selftests/arm/abi/ptrace.h
 create mode 100644 tools/testing/selftests/arm/abi/ptrace_64.c
 create mode 100644 tools/testing/selftests/arm/abi/trivial_32bit_program.c
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
 create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_aif_bits.c
 create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c
 create mode 100644 tools/testing/selftests/arm64/abi/ptrace.h

-- 
2.39.2


