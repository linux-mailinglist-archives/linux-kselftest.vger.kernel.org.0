Return-Path: <linux-kselftest+bounces-36579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02BAF9631
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53004A37DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673551D54FA;
	Fri,  4 Jul 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="edkvmXx7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F31547C9;
	Fri,  4 Jul 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641532; cv=none; b=a5sFRMExCce+KUGtURcWN/PWsL4KDcsOZDtHp4B+iVpt7oxWdkDBOZCZXYb7p5GozO/ktCBg5y/SgufcYWetEAqCY7paxrT2bOfc6G355tSUAt9pPpWb56PE2PPFcXIWKB5zpUzb7Ys85JlQio+ilAhausisQ44wa8NYW+qDhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641532; c=relaxed/simple;
	bh=wqK0JPxhmJexva4WqH4OB13T2ITRRYsp1xevp4tjymY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sDcNqleOa8prCK/DFYm16bmsnLdF+DwVcq+Sx1bsE0KadxuIjJBfslsEUyhdJW44QKtRQfFEB2Ww4t9efGIGAx1mL8MmDw3smq90hlUl+BQRtMTGtS7jkzR7vRA9RXXwmR4OcuoPc8uveIcMFv7WXzbQX6enicio93SUGIELFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=edkvmXx7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4hUTN+IeM3RcKZzOKzsDhjVvkr+6G1fO5nxeQ0hao04=; b=edkvmXx7Np+KkyeKWhI9D6eG4n
	fgn+SUMdIT68fjAcaRnelXeFuUce5wcGPfJtGtqXDgZZe9FuHS+9DVLXAvr9asmTTzoCLOxJxEsX0
	gTzWChwFhky7/4N6qqxU+9sQNwsYAfMbteQgBVRhYFKyxyHVsHVzwcEqoO0oWG59Bw/uIY0YngKPg
	vA7sFrQNObKo8Gb8utPVihTxkfC0iNjVM1xhaUVPoGa1iomH9gFpoxZhb7U9bJkTvu7tln3kmG2RM
	MMdgD6M5XViF5rPxvcvEpFxIFPPduu8MVytjUKs7ka1yplM8uw0kSfM2/6II4mNVZb9QccJRkw4MA
	RwRWoVpA==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhyf-00CTWt-7Q; Fri, 04 Jul 2025 17:05:25 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 00/15] selftests/futex: Refactor tests to use
 kselftest_harness.h
Date: Fri, 04 Jul 2025 12:05:04 -0300
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-0-c0ff4f24c4e1@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKDtZ2gC/x2M0QpAMBRAf0X32WrMiF+RxHZxo03biOTfLS+nz
 sM5D3h0hB6a5AGHJ3myJkqWJqCWwczISEeHnOeSV1ywYM29MmfHw4c+YITacDDHznQ2iYKXopS
 6htjvDie6/nfbve8HGelP32sAAAA=
X-Change-ID: 20250703-tonyk-robust_test_cleanup-d1f3406365d9
To: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

This patch series refactors all futex selftests to use
kselftest_harness.h instead of futex's logging.h, as discussed here [1].

This allows to remove a lot of boilerplate code and to simplify some
parts of the test logic, mainly when the test needs to exit early. The
result of this is more than 500 lines removed from
tools/testing/selftests/futex/. Also, this enables new tests to use
kselftest.h features like ASSERT_s and such.

There are some caveats around this refactor:
 - logging.h had verbosity levels, while kselftest_harness.h doesn't. I
   created a new print function called ksft_print_dbg_msg() that prints
   the message if the user uses the -d flag, so now there's an
   equivalent of this feature.
 - futex_requeue_pi test accepted command line arguments to be used as
   test parameters (e.g. ./futex_requeue_pi -b -l -t 500000). This
   doesn't work with kselftest_harness.h because there's no
   straightforward way to send command line arguments to the test.
   I used FIXTURE_VARIANT() to achieve the same result, but now the
   parameters live inside of the test file, instead of on
   functional/run.sh. This increased a little bit the number of test
   cases for futex_requeue_pi, from 22 to 24.
 - test_harness_run() calls mmap(MAP_SHARED) before running the test and
   this has caused a side effect on test futex_numa_mpol.c. This test
   also calls mmap() and then try to access an address out of
   boundaries of this mapped memory for a "Memory out of range" subtest,
   where the kernel should return -EACCESS. After the refactor, the test
   address might be fall inside the first memory mapped region, thus
   being a valid address and succeeding the syscall, making the test
   fail. To fix that, I created a small "buffer zone" with
   mmap(PROT_NONE) between both mmaps.

I have compared the results of run.sh before and after this patchset and
didn't find any regression from the test results.

Thanks,
	André

[1] https://lore.kernel.org/lkml/87ecv6p364.ffs@tglx/

---
André Almeida (15):
      selftests: kselftest: Create ksft_print_dbg_msg()
      selftests/futex: Refactor futex_requeue_pi with kselftest_harness.h
      selftests/futex: Refactor futex_requeue_pi_mismatched_ops with kselftest_harness.h
      selftests/futex: Refactor futex_requeue_pi_signal_restart with kselftest_harness.h
      selftests/futex: Refactor futex_wait_timeout with kselftest_harness.h
      selftests/futex: Refactor futex_wait_wouldblock with kselftest_harness.h
      selftests/futex: Refactor futex_wait_unitialized_heap with kselftest_harness.h
      selftests/futex: Refactor futex_wait_private_mapped_file with kselftest_harness.h
      selftests/futex: Refactor futex_wait with kselftest_harness.h
      selftests/futex: Refactor futex_requeue with kselftest_harness.h
      selftests/futex: Refactor futex_waitv with kselftest_harness.h
      selftests/futex: Refactor futex_priv_hash with kselftest_harness.h
      selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h
      selftests/futex: Drop logging.h include from futex_numa
      selftests/futex: Remove logging.h file

 tools/testing/selftests/futex/functional/Makefile  |   3 +-
 .../selftests/futex/functional/futex_numa.c        |   3 +-
 .../selftests/futex/functional/futex_numa_mpol.c   |  57 ++---
 .../selftests/futex/functional/futex_priv_hash.c   |  79 +++----
 .../selftests/futex/functional/futex_requeue.c     |  76 ++----
 .../selftests/futex/functional/futex_requeue_pi.c  | 261 ++++++++++-----------
 .../functional/futex_requeue_pi_mismatched_ops.c   |  80 ++-----
 .../functional/futex_requeue_pi_signal_restart.c   | 129 +++-------
 .../selftests/futex/functional/futex_wait.c        | 103 +++-----
 .../functional/futex_wait_private_mapped_file.c    |  83 ++-----
 .../futex/functional/futex_wait_timeout.c          | 139 +++++------
 .../functional/futex_wait_uninitialized_heap.c     |  76 ++----
 .../futex/functional/futex_wait_wouldblock.c       |  75 ++----
 .../selftests/futex/functional/futex_waitv.c       |  98 ++++----
 tools/testing/selftests/futex/functional/run.sh    |  62 +----
 tools/testing/selftests/futex/include/logging.h    | 148 ------------
 tools/testing/selftests/kselftest.h                |  13 +
 tools/testing/selftests/kselftest_harness.h        |  13 +-
 18 files changed, 491 insertions(+), 1007 deletions(-)
---
base-commit: a24cc6ce1933eade12aa2b9859de0fcd2dac2c06
change-id: 20250703-tonyk-robust_test_cleanup-d1f3406365d9

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


