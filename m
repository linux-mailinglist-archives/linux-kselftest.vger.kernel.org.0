Return-Path: <linux-kselftest+bounces-37713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E109B0B8B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9092B7A3584
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A822A7FC;
	Sun, 20 Jul 2025 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QZI4e7QO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBB22A4E4;
	Sun, 20 Jul 2025 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050554; cv=none; b=Hi/Px4LW/6wrJ8B0UwS84FSWr/sOPJjoA6ZXamslBaDMs4zNS4sA6wmCrkBVj8ZQUBena7Qy2BH93s3yz05fpwSV3D3QvjOdJWWFHSFo+FocNII2H0fH9MGz5wpC9pO+XHNJZLijJQNnqDYasKBKkRTeS6f0m/bebctRhQnxvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050554; c=relaxed/simple;
	bh=4fi13IptO9I7IQ2mQDhfsp+T+Sr6cBdKqgB2uRsOv3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IX/Ymz78vYaRUPOVXfY2qmXx4vBNbXy4ACTGEo6pfmlMXdoCdvyBLz6R3uOAmPouOAPbmxqToiaLNeZtmQ9sQusqaWMzpiTsCFMyqSp2BdnwJfIgL6M98+s4cb445Vnn7KlqDpYhzc1D2Vo3Nq9KTKAKz/GE5qO9rylYffxb4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QZI4e7QO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MArfY4QX9yzCgxszYchqKjhK20OrChAEgRapbpg4+Xk=; b=QZI4e7QOJohnml8io0i/lXMhkM
	E3RMaWpJnFOJH5/xGnKd44q0i2H8YVl+7o0Fura2FW8K+n0I6zTEHCJWhJOS6YX343+hxOw0AlQSB
	HoxF5FRn5beIGx9c+smdCkbIeD2cy8lNWOBIaBXyoy/oQw8iw+KYr6KRHjl3wqh5ISp9YMW6kP5H5
	dGC6VbMzEp2tM5iKsZBLk1R7LULuoz5JDWeBNwE5m9PdLq6HwoSwBbItCwGeY6aRzqPIdfwGFI/Y6
	ckb22ataEnSfFD2i5zpjPoF59OI9rkahopP5SIjIKVunecqcRt5JQpwLuh6YodsM5etyi50IrtPY0
	G0HhVVfg==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcWo-001Sqt-A2; Mon, 21 Jul 2025 00:29:06 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 00/15] selftests/futex: Refactor tests to use
 kselftest_harness.h
Date: Sun, 20 Jul 2025 19:28:58 -0300
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-0-1f9bcb5b7294@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKptfWgC/32NQQqDMBREryJ/3ZQkRku76j2KlDT+6Kc2kSRKR
 bx7U6HbbgbewLxZIWIgjHApVgg4UyTvMshDAabXrkNGbWaQXFb8xEuWvFueLPjHFNM9YQ4zoHb
 TyFphS8Xrsq7aM+T9GNDSe3ffmsw9xeTDsl/N4tv+rOqPdRaMM8OtVVYqo1BcqdMD6aPxL2i2b
 fsAKGu0X8MAAAA=
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
Changes in v2:
- Rebased on top of tip/master
- Dropped priv_hash global test variant now that this feature was
  dropped
- Added include <stdbool.h> in the first patch
- Link to v1: https://lore.kernel.org/r/20250704-tonyk-robust_test_cleanup-v1-0-c0ff4f24c4e1@igalia.com

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
 .../selftests/futex/functional/futex_priv_hash.c   |  49 +---
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
 tools/testing/selftests/kselftest.h                |  14 ++
 tools/testing/selftests/kselftest_harness.h        |  13 +-
 18 files changed, 465 insertions(+), 1004 deletions(-)
---
base-commit: ed0272f0675f31642c3d445a596b544de9db405b
change-id: 20250703-tonyk-robust_test_cleanup-d1f3406365d9

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


