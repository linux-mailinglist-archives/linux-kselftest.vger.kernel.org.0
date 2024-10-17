Return-Path: <linux-kselftest+bounces-19955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A789A2420
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5208F1C20906
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B791DD864;
	Thu, 17 Oct 2024 13:40:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E42C1DDC21
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172416; cv=none; b=aGecj7CpsR4KoI5WCMFAiPB2fZnCWrNHQ16YLFeM+EBfhrIFPB/Pxf1qJuikDoG2KtqjB6jEiQxfA5k6wz6B6Or7To6UYuMXJEk9MD9Cub5Oev1NPJOCbkhECwL1aPeKM4uRW5phMV5XXLy77GdnG19inJGCa2DSE8D7a+8dWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172416; c=relaxed/simple;
	bh=uPjgpFRn6PK4z83ZkSc7DFdlQhgX101XgPRDHGljUA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kw6369lKHCh8r4s2MjeEm25Y+fUlpb7RnUwbggS13jkDJqba8n15qu0suq7aBISmBg3PzG2Mf4Fl7QNhNpOZvSCE3zOhHaAwylM4iRM7N1zYHt4auNsgpOEwc6U3SCclQk/wIFR+/DrgW7dl2LEWFWWtyph2hXC80ZxC60O0vbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BD68DA7;
	Thu, 17 Oct 2024 06:40:41 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6C973F71E;
	Thu, 17 Oct 2024 06:40:08 -0700 (PDT)
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
	shuah@kernel.org,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
Date: Thu, 17 Oct 2024 14:39:04 +0100
Message-ID: <20241017133909.3837547-1-kevin.brodsky@arm.com>
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
before invoking the real signal handler, as discussed here [3].

The x86 series also added kselftests to ensure that no spurious SIGSEGV
occurs during signal delivery regardless of which pkey is accessible at
the point where the signal is delivered. This series adapts those
kselftests to allow running them on arm64 (patch 4-5).

Finally patch 2 is a clean-up following feedback on Joey's series [4].

I have tested this series on arm64 and x86_64 (booting and running the
protection_keys and pkey_sighandler_tests mm kselftests).

- Kevin

[1] https://lore.kernel.org/linux-arm-kernel/20240822151113.1479789-1-joey.gouly@arm.com/
[2] https://lore.kernel.org/lkml/20240802061318.2140081-1-aruna.ramakrishna@oracle.com/
[3] https://lore.kernel.org/lkml/CABi2SkWxNkP2O7ipkP67WKz0-LV33e5brReevTTtba6oKUfHRw@mail.gmail.com/
[4] https://lore.kernel.org/linux-arm-kernel/20241015114116.GA19334@willie-the-truck/

Cc: akpm@linux-foundation.org
Cc: anshuman.khandual@arm.com
Cc: aruna.ramakrishna@oracle.com
Cc: broonie@kernel.org
Cc: catalin.marinas@arm.com
Cc: dave.hansen@linux.intel.com
Cc: dave.martin@arm.com
Cc: jeffxu@chromium.org
Cc: joey.gouly@arm.com
Cc: shuah@kernel.org
Cc: will@kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: x86@kernel.org

Kevin Brodsky (5):
  arm64: signal: Remove unused macro
  arm64: signal: Remove unnecessary check when saving POE state
  arm64: signal: Improve POR_EL0 handling to avoid uaccess failures
  selftests/mm: Use generic pkey register manipulation
  selftests/mm: Enable pkey_sighandler_tests on arm64

 arch/arm64/kernel/signal.c                    |  92 +++++++++++++---
 tools/testing/selftests/mm/Makefile           |   8 +-
 tools/testing/selftests/mm/pkey-arm64.h       |   1 +
 tools/testing/selftests/mm/pkey-x86.h         |   2 +
 .../selftests/mm/pkey_sighandler_tests.c      | 101 +++++++++++++-----
 5 files changed, 159 insertions(+), 45 deletions(-)

-- 
2.43.0


