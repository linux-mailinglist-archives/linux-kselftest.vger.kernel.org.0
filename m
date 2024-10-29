Return-Path: <linux-kselftest+bounces-20958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB189B4C6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806E828133F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4E1865E3;
	Tue, 29 Oct 2024 14:46:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCB210F9
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213160; cv=none; b=UT8mNsU/kayCkdJAtn859Q9thmkzNAWB4EoFl4U/kZdkLZmxBPq0G/djH0iRqMppC8Hdp/M01MXhSQABz4zznZiTN4kxoGDmprcxIHvsNoqLXwSorBjQ5fyS1wWjbeqkadSYT8uwUhaPduK8PDhbi04mMBBRvljBZNItiLTkqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213160; c=relaxed/simple;
	bh=x221B/LCgNAlf7v4QOjjbTajYjUt9DP00VlKkpM4Rds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caox3Bfp+QSLjm8qbuBq46QvXk4ik3gHAT+gLJu1Lmy7o3B3kKNMrdB1acyYD5tCj9rvdmSQiXZ0OnKjooDULMHsHd3BjryD32y+5RVenNRWG1pQVIyoe7j0FeVLqxNFpqr9xiLmahjhtOdBILWMJZZitRfQ/qRuvkII3lykCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9423C113E;
	Tue, 29 Oct 2024 07:46:26 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12BC83F528;
	Tue, 29 Oct 2024 07:45:53 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	Dave.Martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	tglx@linutronix.de,
	will@kernel.org,
	yury.khrustalev@arm.com,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 0/5] Improve arm64 pkeys handling in signal delivery
Date: Tue, 29 Oct 2024 14:45:34 +0000
Message-ID: <20241029144539.111155-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow-up to Joey's Permission Overlay Extension (POE)
series [1] that recently landed on mainline. The goal is to improve the
way we handle the register that governs which pkeys/POIndex are
accessible (POR_EL0) during signal delivery. As things stand, we may
unexpectedly fail to write the signal frame on the stack because POR_EL0
is not reset before the uaccess operations. See patch 1 for more details
and the main changes this series brings.

A similar series landed recently for x86/MPK [2]; the present series
aims at aligning arm64 with x86. Worth noting: once the signal frame is
written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
only. This means that a program that sets up an alternate signal stack
with a non-zero pkey will need some assembly trampoline to set POR_EL0
before invoking the real signal handler, as discussed here [3]. This is
not ideal, but it makes experimentation with pkeys in signal handlers
possible while waiting for a potential interface to control the pkey
state when delivering a signal. See Pierre's reply [4] for more
information about use-cases and a potential interface.

The x86 series also added kselftests to ensure that no spurious SIGSEGV
occurs during signal delivery regardless of which pkey is accessible at
the point where the signal is delivered. This series adapts those
kselftests to allow running them on arm64 (patch 4-5). There is a
dependency on Yury's PKEY_UNRESTRICTED patch [7] for patch 4
specifically.

Finally patch 2 is a clean-up following feedback on Joey's series [5].

I have tested this series on arm64 and x86_64 (booting and running the
protection_keys and pkey_sighandler_tests mm kselftests).

- Kevin

---

v2..v3:
* Reordered patches (patch 1 is now the main patch).
* Patch 1: compute por_enable_all with an explicit loop, based on
  arch_max_pkey() (suggestion from Dave M).
* Patch 4: improved naming, replaced global pkey reg value with inline
  helper, made use of Yury's PKEY_UNRESTRICTED macro [7] (suggestions
  from Dave H).

v2: https://lore.kernel.org/linux-arm-kernel/20241023150511.3923558-1-kevin.brodsky@arm.com/

v1..v2:
* In setup_rt_frame(), ensured that POR_EL0 is reset to its original
  value if we fail to deliver the signal (addresses Catalin's concern [6]).
* Renamed *unpriv_access* to *user_access* in patch 3 (suggestion from
  Dave).
* Made what patch 1-2 do explicit in the commit message body (suggestion
  from Dave).

v1: https://lore.kernel.org/linux-arm-kernel/20241017133909.3837547-1-kevin.brodsky@arm.com/

[1] https://lore.kernel.org/linux-arm-kernel/20240822151113.1479789-1-joey.gouly@arm.com/
[2] https://lore.kernel.org/lkml/20240802061318.2140081-1-aruna.ramakrishna@oracle.com/
[3] https://lore.kernel.org/lkml/CABi2SkWxNkP2O7ipkP67WKz0-LV33e5brReevTTtba6oKUfHRw@mail.gmail.com/
[4] https://lore.kernel.org/linux-arm-kernel/87plns8owh.fsf@arm.com/
[5] https://lore.kernel.org/linux-arm-kernel/20241015114116.GA19334@willie-the-truck/
[6] https://lore.kernel.org/linux-arm-kernel/Zw6D2waVyIwYE7wd@arm.com/
[7] https://lore.kernel.org/all/20241028090715.509527-2-yury.khrustalev@arm.com/

Cc: akpm@linux-foundation.org
Cc: anshuman.khandual@arm.com
Cc: aruna.ramakrishna@oracle.com
Cc: broonie@kernel.org
Cc: catalin.marinas@arm.com
Cc: dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com
Cc: jeffxu@chromium.org
Cc: joey.gouly@arm.com
Cc: keith.lucas@oracle.com
Cc: pierre.langlois@arm.com
Cc: shuah@kernel.org
Cc: sroettger@google.com
Cc: tglx@linutronix.de
Cc: will@kernel.org
Cc: yury.khrustalev@arm.com
Cc: linux-kselftest@vger.kernel.org
Cc: x86@kernel.org

Kevin Brodsky (5):
  arm64: signal: Improve POR_EL0 handling to avoid uaccess failures
  arm64: signal: Remove unnecessary check when saving POE state
  arm64: signal: Remove unused macro
  selftests/mm: Use generic pkey register manipulation
  selftests/mm: Enable pkey_sighandler_tests on arm64

 arch/arm64/kernel/signal.c                    |  95 ++++++++++++---
 tools/testing/selftests/mm/Makefile           |   8 +-
 tools/testing/selftests/mm/pkey-arm64.h       |   1 +
 tools/testing/selftests/mm/pkey-x86.h         |   2 +
 .../selftests/mm/pkey_sighandler_tests.c      | 115 ++++++++++++++----
 5 files changed, 176 insertions(+), 45 deletions(-)

-- 
2.43.0


