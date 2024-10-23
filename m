Return-Path: <linux-kselftest+bounces-20461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3145E9ACE44
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9511C210C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587D1D2707;
	Wed, 23 Oct 2024 15:05:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD81D0403
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695929; cv=none; b=hQlM9Ecm0rgLeqo9QYSVP+/As4MwLodX1HOfeOxwKWPTK1BSGMRCn26cUk7JYV98PKzxSpzliKPjY0fv2+GJM6L7UTK4LXV5/wyrnt+31yWapcdlp88e7uplQLhB8ZgeiCG6h/IhBatPlw1e4iLj6siPwrcxA8UNr6OhWH8WI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695929; c=relaxed/simple;
	bh=fH5Vd339/GcA6QRc553L+yvDV+sOHx5wp38PY9TnC7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPRhnJkqCh7pXfcEiaWNks6u/K2eRQDW+loLUv0erVYzegBqFX0FeWHgBTiD1qmEAGZJtPhPiwIZU9y7w4H8yPuXIxyNcTXqhxH13uaJFq+3DyraSlaFhJDYAKqw9GfxghWnWU7w1T8X/jIjPl871Ditd8aTcfqqUCvA+cy0Y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F6C339;
	Wed, 23 Oct 2024 08:05:56 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A79D63F528;
	Wed, 23 Oct 2024 08:05:24 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	dave.martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 0/5] Improve arm64 pkeys handling in signal delivery
Date: Wed, 23 Oct 2024 16:05:06 +0100
Message-ID: <20241023150511.3923558-1-kevin.brodsky@arm.com>
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
is not reset before the uaccess operations. See patch 3 for more details
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
kselftests to allow running them on arm64 (patch 4-5).

Finally patch 2 is a clean-up following feedback on Joey's series [5].

I have tested this series on arm64 and x86_64 (booting and running the
protection_keys and pkey_sighandler_tests mm kselftests).

v1..v2:
* In setup_rt_frame(), ensured that POR_EL0 is reset to its original
  value if we fail to deliver the signal (addresses Catalin's concern [6]).
* Renamed *unpriv_access* to *user_access* in patch 3 (suggestion from
  Dave).
* Made what patch 1-2 do explicit in the commit message body (suggestion
  from Dave).

- Kevin

[1] https://lore.kernel.org/linux-arm-kernel/20240822151113.1479789-1-joey.gouly@arm.com/
[2] https://lore.kernel.org/lkml/20240802061318.2140081-1-aruna.ramakrishna@oracle.com/
[3] https://lore.kernel.org/lkml/CABi2SkWxNkP2O7ipkP67WKz0-LV33e5brReevTTtba6oKUfHRw@mail.gmail.com/
[4] https://lore.kernel.org/linux-arm-kernel/87plns8owh.fsf@arm.com/
[5] https://lore.kernel.org/linux-arm-kernel/20241015114116.GA19334@willie-the-truck/
[6] https://lore.kernel.org/linux-arm-kernel/Zw6D2waVyIwYE7wd@arm.com/

Cc: akpm@linux-foundation.org
Cc: anshuman.khandual@arm.com
Cc: aruna.ramakrishna@oracle.com
Cc: broonie@kernel.org
Cc: catalin.marinas@arm.com
Cc: dave.hansen@linux.intel.com
Cc: dave.martin@arm.com
Cc: jeffxu@chromium.org
Cc: joey.gouly@arm.com
Cc: pierre.langlois@arm.com
Cc: shuah@kernel.org
Cc: sroettger@google.com
Cc: will@kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: x86@kernel.org


Kevin Brodsky (5):
  arm64: signal: Remove unused macro
  arm64: signal: Remove unnecessary check when saving POE state
  arm64: signal: Improve POR_EL0 handling to avoid uaccess failures
  selftests/mm: Use generic pkey register manipulation
  selftests/mm: Enable pkey_sighandler_tests on arm64

 arch/arm64/kernel/signal.c                    |  95 +++++++++++++---
 tools/testing/selftests/mm/Makefile           |   8 +-
 tools/testing/selftests/mm/pkey-arm64.h       |   1 +
 tools/testing/selftests/mm/pkey-x86.h         |   2 +
 .../selftests/mm/pkey_sighandler_tests.c      | 101 +++++++++++++-----
 5 files changed, 162 insertions(+), 45 deletions(-)

-- 
2.43.0


