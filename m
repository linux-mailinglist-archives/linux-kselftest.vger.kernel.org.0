Return-Path: <linux-kselftest+bounces-30186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B75A7D485
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2D016FAE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5622425E;
	Mon,  7 Apr 2025 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vPnMC/9q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/z3q4XOh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5F79F2;
	Mon,  7 Apr 2025 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008782; cv=none; b=UNBlJNIXK0uDmOoO/RymH9daHGdGgtndo8Clk2dv0HEyYYsWlddXvnKlkBdee5eLCia5WhQf8FD8rXiA0RP24EtpI2An+lLrS6rmuyMrgG8zP1NSMcWCo9xcLebzn1t9bl0hy9BfNJa34XEuo6RpNW/Ml0Icw0DfqZSl5K2bAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008782; c=relaxed/simple;
	bh=823hn4kF+TmT6mhyvYDlHv6Q2PBnPjxDFSElLhmSbSA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sCHbmT9P0e4nFoakA2uH7VRnJURBLf4GSC56bY6gq6Z/CH290EQOLcfDc1bMwE4P3zVRrB3gjAKZBQKdGije3lLasdACZa+Su/IPc0HemeMs26rPkMKxyDfgv3TtJ8Lv90Zi+onpqL6B+gzBHs8DdAxsoxG/qDdPy8e7RxCscsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vPnMC/9q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/z3q4XOh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0n+MQkWCoxXIU++myAQD9Cw9NTJxgIiaTF0JdVnLQYg=;
	b=vPnMC/9qgmEgqsWDAf2usmc59ePw8/glFsSkz57Dg1QxCXTHIwCDizhfYq8LngnSK8KwMd
	toSLUo83ifm8du28HrHVHj5UlLeIvtbEfXXASxLz8ErsZdYjYi6kXVcrjLV4KYXBEd+xum
	NPeJdJfnDj7ktjqD5FsrHEgLvswkvc8oZlGzcOcT28YbmEo2cGpeQ9dmbsRaKPu8WG7T2Q
	qly4m9i9bP+cOvpXjiQnbO2db6OLwIBCgZOyYlT+juBNSdaxl6rv+4cG+2kfJpj3qKFD6A
	qM8QEKe02qbOa14C8QjxpaHmsFSImxV6OomApNk0rlD3NH6zGZ3mTZCbAwHltg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0n+MQkWCoxXIU++myAQD9Cw9NTJxgIiaTF0JdVnLQYg=;
	b=/z3q4XOhOguJbo5DrNNLB+vWjR6zrxaEcT2GDdTi5UOJUUVWz0T/yIvfIIxzsA+rVnfsGh
	598Vjis7NrH47jCQ==
Subject: [PATCH v2 00/32] kselftest harness and nolibc compatibility
Date: Mon, 07 Apr 2025 08:52:23 +0200
Message-Id: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACd282cC/4XNywrCMBCF4VcpWRvJrba48j2ki1wmdrCkksRSK
 X1307oTxOU/MN9ZSIKIkMi5WkiECROOoYQ4VMT2OtyAoitNBBM145LRMA5oLL0nGHyGlGmvY4C
 UaGuEba22ShpPyvsjgsd5p69d6R5THuNrX5r4dv2ggsvf6MQpoxKgPSnVmJr5y4DhmeMYcD462
 HZ2RDL1B9HO6sY6ITmIL6Rb1/UNpAZJuwkBAAA=
X-Change-ID: 20250130-nolibc-kselftest-harness-8b2c8cac43bf
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=4338;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=823hn4kF+TmT6mhyvYDlHv6Q2PBnPjxDFSElLhmSbSA=;
 b=5oTYwn4cicS9k4jt5RNgna82VOM1mHhhIkB7gPg6abgFXFk+1MfUEtvvEpp11aSDKHpwkDr8S
 ZgYf+ismBSoAVwjTXe5PA96O9rJGeorMm/mnF80QhR5TR8zYZ2seWlJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc is useful for selftests as the test programs can be very small,
and compiled with just a kernel crosscompiler, without userspace support.
Currently nolibc is only usable with kselftest.h, not the more
convenient to use kselftest_harness.h
This series provides this compatibility by adding new features to nolibc
and removing the usage of problematic features from the harness.

The first half of the series are changes to the harness, the second one
are for nolibc. Both parts are very independent and should go through
different trees.
The last patch is not meant to be applied and serves as test that
everything works together correctly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase unto v6.15-rc1
- Rename internal nolibc symbols
- Handle edge case of waitpid(INT_MIN) == ESRCH
- Fix arm configurations for final testing patch
- Clean up global getopt.h variable declarations
- Add Acks from Willy
- Link to v1: https://lore.kernel.org/r/20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de

---
Thomas Weißschuh (32):
      selftests: harness: Add harness selftest
      selftests: harness: Use C89 comment style
      selftests: harness: Ignore unused variant argument warning
      selftests: harness: Mark functions without prototypes static
      selftests: harness: Remove inline qualifier for wrappers
      selftests: harness: Remove dependency on libatomic
      selftests: harness: Implement test timeouts through pidfd
      selftests: harness: Don't set setup_completed for fixtureless tests
      selftests: harness: Always provide "self" and "variant"
      selftests: harness: Move teardown conditional into test metadata
      selftests: harness: Add teardown callback to test metadata
      selftests: harness: Stop using setjmp()/longjmp()
      selftests: harness: Guard includes on nolibc
      tools/nolibc: handle intmax_t/uintmax_t in printf
      tools/nolibc: use intmax definitions from compiler
      tools/nolibc: use pselect6_time64 if available
      tools/nolibc: use ppoll_time64 if available
      tools/nolibc: add tolower() and toupper()
      tools/nolibc: add _exit()
      tools/nolibc: add setpgrp()
      tools/nolibc: implement waitpid() in terms of waitid()
      Revert "selftests/nolibc: use waitid() over waitpid()"
      tools/nolibc: add dprintf() and vdprintf()
      tools/nolibc: add getopt()
      tools/nolibc: allow different write callbacks in printf
      tools/nolibc: allow limiting of printf destination size
      tools/nolibc: add snprintf() and friends
      selftests/nolibc: use snprintf() for printf tests
      selftests/nolibc: rename vfprintf test suite
      selftests/nolibc: add test for snprintf() truncation
      tools/nolibc: implement width padding in printf()
      HACK: selftests/nolibc: demonstrate usage of the kselftest harness

 tools/include/nolibc/Makefile                      |    1 +
 tools/include/nolibc/getopt.h                      |  101 ++
 tools/include/nolibc/nolibc.h                      |    1 +
 tools/include/nolibc/stdint.h                      |    4 +-
 tools/include/nolibc/stdio.h                       |  127 +-
 tools/include/nolibc/string.h                      |   17 +
 tools/include/nolibc/sys.h                         |  105 +-
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/kselftest/.gitignore       |    1 +
 tools/testing/selftests/kselftest/Makefile         |    6 +
 .../testing/selftests/kselftest/harness-selftest.c |  129 ++
 .../selftests/kselftest/harness-selftest.expected  |   62 +
 .../selftests/kselftest/harness-selftest.sh        |   14 +
 tools/testing/selftests/kselftest_harness.h        |  181 +-
 tools/testing/selftests/nolibc/Makefile            |   13 +-
 tools/testing/selftests/nolibc/harness-selftest.c  |    1 +
 tools/testing/selftests/nolibc/nolibc-test.c       | 1729 +-------------------
 tools/testing/selftests/nolibc/run-tests.sh        |    2 +-
 18 files changed, 635 insertions(+), 1860 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250130-nolibc-kselftest-harness-8b2c8cac43bf

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


