Return-Path: <linux-kselftest+bounces-7254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07946899871
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2571C20C08
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0714515F319;
	Fri,  5 Apr 2024 08:49:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853E3145B15;
	Fri,  5 Apr 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306988; cv=none; b=XFDUpOfcsYdpxywIUzvMXdvBrtfrrQv4+hgPQPDU/gyKwrL6vtQ0OUqQ5VehXxFH6O+AFvz8VwC1xMtXWQKkrcX8mKBFsVKdWHxnO+eSXJOjbAB0UOITmuLJrx8dvve3zMzbdCC5zeAyw3Bzw6y9jHuVin08JHhrimauxNm41bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306988; c=relaxed/simple;
	bh=vcqVHlwn7VRmRqz58IVnuSiGZzLv3I+cL/EHCDTSX7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bHYQ1huMTQu6McY2nziuJQFLzSdb7WXu7bl6SqFj+bpjuesxZ5Ri1hJlRlfqOLuXuIO9mtKJ9hvyOo7njb2yMnlJRUmUFV/2vzscnEDGi9AOY61l8SexXc4Fowg8VZ2eRX/+mCmqZlKeWWV2sRa/YNE0LKYk/0tHJD/d/0M+o/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5817BFEC;
	Fri,  5 Apr 2024 01:50:16 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34A6F3F64C;
	Fri,  5 Apr 2024 01:49:40 -0700 (PDT)
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
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 0/4] A new selftests/ directory for arm compatibility testing
Date: Fri,  5 Apr 2024 14:14:06 +0530
Message-Id: <20240405084410.256788-1-dev.jain@arm.com>
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

The series has been tested on 6.9.0-rc2, on Aarch64 platform. Testing remains
to be done on Aaarch32.

Dev Jain (4):
  selftests/arm: Add mm test
  selftests/arm: Add signal tests
  selftests/arm: Add elf test
  selftests: Add build infrastructure along with README

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/arm/Makefile          |  57 ++++
 tools/testing/selftests/arm/README            |  31 +++
 tools/testing/selftests/arm/elf/Makefile      |   6 +
 tools/testing/selftests/arm/elf/parse_elf.c   |  75 +++++
 tools/testing/selftests/arm/mm/Makefile       |   6 +
 tools/testing/selftests/arm/mm/compat_va.c    |  94 +++++++
 tools/testing/selftests/arm/signal/Makefile   |  30 ++
 .../selftests/arm/signal/test_signals.c       |  27 ++
 .../selftests/arm/signal/test_signals.h       |  74 +++++
 .../selftests/arm/signal/test_signals_utils.c | 257 ++++++++++++++++++
 .../selftests/arm/signal/test_signals_utils.h | 128 +++++++++
 .../signal/testcases/mangle_cpsr_aif_bits.c   |  33 +++
 .../mangle_cpsr_invalid_compat_toggle.c       |  29 ++
 14 files changed, 848 insertions(+)
 create mode 100644 tools/testing/selftests/arm/Makefile
 create mode 100644 tools/testing/selftests/arm/README
 create mode 100644 tools/testing/selftests/arm/elf/Makefile
 create mode 100644 tools/testing/selftests/arm/elf/parse_elf.c
 create mode 100644 tools/testing/selftests/arm/mm/Makefile
 create mode 100644 tools/testing/selftests/arm/mm/compat_va.c
 create mode 100644 tools/testing/selftests/arm/signal/Makefile
 create mode 100644 tools/testing/selftests/arm/signal/test_signals.c
 create mode 100644 tools/testing/selftests/arm/signal/test_signals.h
 create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.c
 create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.h
 create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_aif_bits.c
 create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c

-- 
2.39.2


