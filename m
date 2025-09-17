Return-Path: <linux-kselftest+bounces-41766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07422B81F0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0601523087
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3DA304963;
	Wed, 17 Sep 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CWKpb6zf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F89286D57;
	Wed, 17 Sep 2025 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144189; cv=none; b=uXfWPRiHR5aqXIqslThbCB5FXbcJGeqNOJj0g0nkAJ4aTFBpvydWSXDLJhRWFHzDKcBn0gbs6innM0tyi8tngNUZB9DIoCspnVI724FtH7BKt/NO3ZP3SwpwBPMkJXLnV1oQjuYR0XrH/Zb9XbjTOJUWj46rzZHRDMui6bhXk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144189; c=relaxed/simple;
	bh=M9SdNmZ7sf3/7agXW2nsU1LwEsflHfYP4Tck0MDm+0U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OFvWd7zQ4y28JGcRGH9lZkVcjJBDbLAAUlixb2ejsG3tRRcVEP5QTJbHQM4guBsNibUyKgdjQ/MiXFDehL0b1nE0O6lkKvtz0sMnLpJAs93zU5lKddzlTLY2h3fK+J9fjCY5WFAVib2oVvHQb+V2x0GAzkENgVfJbo4hBn2G194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CWKpb6zf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EqTdjLcj6gBchcuEdKrZwAtJtZokHrURM25ZvOOpHJk=; b=CWKpb6zf72GJ1Nn6dEFE7kZ4Wx
	RZewnfDmJdXBklL75qsvLwA5g+jAwRbx/eHjOh796DAUbByhy2ZO59htbpmgRZlUXb+kAKXOXFQmJ
	9OlqtgDoYrvu8xdXwS2hcm1aFJlLjM5GUniwGtVLfxTFP+Cdji3KDgsBNXIjdfn+wZXpIC4dnczl9
	H1+8snTAKzZ/3tw+dpgq6L4cqn9IffKPl2V8ljNOnNwUtePhzKMsPw2qRds4F0meO6UP7n4q1bXo5
	ekBtIAX8gyECxYyRhOVu6AhSKW0k5PdWobatWYe5nm9RLlUb1WUfUioW4Uk92pK7rb3JZ61OJyFXv
	P30DkvVQ==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzc6-00CsMq-08; Wed, 17 Sep 2025 23:22:54 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 00/15] selftests/futex: Refactor tests to use
 kselftest_harness.h
Date: Wed, 17 Sep 2025 18:21:39 -0300
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-0-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGQmy2gC/33N3QqDIBTA8VcJr+fwq6Jd7T3GGGpasqahJovo3
 WfBYLvp5sD/wPmdBQTljQrgUizAq2SCcTYHPRVA9tx2Cpo2NyCIlKhGFEZn5yf0TkwhPqLKQw6
 K22mELdaUoYpWZduAfD96pc17t2/33L0J0fl5f5Xwtv2q7EBNGCIokdZMEyaZwlfT8cHws3Qvs
 LGJ/FAEHVEkU1g3QopS1KRhf9S6rh+kaHt0DgEAAA==
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

Although there are a lot of patches, they follow a simple pattern:
 - The usage() function, options parsing, kseftest setup
   (ksft_print_header(), ksft_set_plan(), ksft_print_cnts()), are all
   gone
 - info() is replaced with ksft_print_dbg_msg()
 - Exit on error paths are replaced with ksft_exit_fail_msg()
 - fail/pass replaced with their ksft_ equivalents.

I have compared the results of run.sh before and after this patchset and
didn't find any regression from the test results.

Thanks,
	André

[1] https://lore.kernel.org/lkml/87ecv6p364.ffs@tglx/

---
Changes in v3:
- Rebased on top of tip/locking/futex
- Link to v2: https://lore.kernel.org/r/20250720-tonyk-robust_test_cleanup-v2-0-1f9bcb5b7294@igalia.com

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
 .../selftests/futex/functional/futex_numa_mpol.c   |  39 +--
 .../selftests/futex/functional/futex_priv_hash.c   |  48 +---
 .../selftests/futex/functional/futex_requeue.c     |  76 ++----
 .../selftests/futex/functional/futex_requeue_pi.c  | 261 ++++++++++-----------
 .../functional/futex_requeue_pi_mismatched_ops.c   |  86 ++-----
 .../functional/futex_requeue_pi_signal_restart.c   | 129 +++-------
 .../selftests/futex/functional/futex_wait.c        | 103 +++-----
 .../functional/futex_wait_private_mapped_file.c    |  83 ++-----
 .../futex/functional/futex_wait_timeout.c          | 139 +++++------
 .../functional/futex_wait_uninitialized_heap.c     |  76 ++----
 .../futex/functional/futex_wait_wouldblock.c       |  75 ++----
 .../selftests/futex/functional/futex_waitv.c       |  98 ++++----
 tools/testing/selftests/futex/functional/run.sh    |  61 +----
 tools/testing/selftests/futex/include/logging.h    | 148 ------------
 tools/testing/selftests/kselftest.h                |  14 ++
 tools/testing/selftests/kselftest_harness.h        |  13 +-
 18 files changed, 456 insertions(+), 999 deletions(-)
---
base-commit: ed323aeda5e09fa1ab95946673939c8c425c329c
change-id: 20250703-tonyk-robust_test_cleanup-d1f3406365d9

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


