Return-Path: <linux-kselftest+bounces-30539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8348A85738
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9883A168844
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1542989A9;
	Fri, 11 Apr 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FYZOVChL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oa6ijuqA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714451E9B1C;
	Fri, 11 Apr 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362110; cv=none; b=RDsaOai0NY1ysaEQPEkRga1syNCU4VGqkAWdtfzmDR+D4tlpYj4GItfn5Rehk5vmvMJQLdRZvL225vXOyxgxYqvJ0NFDYUzd6AKpU7VwJsq8DErhcxH/ga7YYf42C+AHqdkF4D4jDUKU5+YIzjCjD6l4SqkdLAjhsT4xtxYJW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362110; c=relaxed/simple;
	bh=lRkAuH+ixrkqkfK/VRhE4n+cub7VR8SqmZpgfUJ9N5E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fb9QqIKdvHlUvx92cSdzAmKOdQU/PQW2rW0sxQn9Ip5sWXFWoBcAEO9RoAbySQ1wKYniITvIPccTvRLOoMvzbuQiakRRSAJiazst06IDJsmgZc7V6CToTVfCeVUve2naHKJa1UZ3B2OhuHZRw0XLXQmgzYZ+6vXlPnPeGg6HwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FYZOVChL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oa6ijuqA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jAClCqXSRP7WmfE1GfZ8JkrCWutEBW13P1Lg6794lWQ=;
	b=FYZOVChLOPvYNZB6iq68H7oEmF17K6K5pGdJ3/SaG+4VP7sTHNdE7KXuuN2jLmgIzDYn6H
	Jy8E3a3FgiVDpYRZHgaTq/S8MahWcWqNhxXXGVwvO75rb28N1eDfgRdwDQlgA5wns1huCR
	ltlAoD7l7brHUabOMC3idfbXj1WNO51ug5zAOEGYFwGSjHri1eQTj41HkpXsTT8ANFX5wm
	bVzDsNe2B42rXhCV5MKDHLrrdx/2NFsea2W34MZw9hE5Bysb3xv/nM594uheIWjcZC/aOf
	ms7RsCdgAkyKaF75j0t/s12JORV85R9P6aNYRJibXZgsD7EfZar4dKeMlQNggA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jAClCqXSRP7WmfE1GfZ8JkrCWutEBW13P1Lg6794lWQ=;
	b=oa6ijuqAvtq0XUEm3UonuAvnttSoycYTzZtMIV6wYf28cBmzJM7wxtMxjuADfaBU/ujmFo
	IQv55Q01YErBXZCg==
Subject: [PATCH v3 00/32] kselftest harness and nolibc compatibility
Date: Fri, 11 Apr 2025 11:00:24 +0200
Message-Id: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACja+GcC/4XOQQrCMBAF0KtI1kaSSWqjK+8hLtJ0YgdLKkkti
 vTupnUhFNTlH5j3/5MljISJ7VdPFnGgRF3IQa1XzDU2nJFTnTMDAYWQSvDQtVQ5fknY+h5Tzxs
 bA6bETQXOOOu0qjzL79eInu4zfTzl3FDqu/iYmwY5Xd8oSPUdHSQXXCGardZlVQh/aCnc+tgFu
 m9qnHpmRAn9B7G1s6WrQUmEBTKtG+CzSIvyBwYZ88ZI8OUWd0ossXEcXy3P3rpWAQAA
X-Change-ID: 20250130-nolibc-kselftest-harness-8b2c8cac43bf
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=4852;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lRkAuH+ixrkqkfK/VRhE4n+cub7VR8SqmZpgfUJ9N5E=;
 b=cBL8/CkLkpBsTrIXqxxaIyUJo4Fbg/iV4BnQ/Kke7DyXJY4xIL3HTnqaknjsxKIYFqaZCa5or
 3iBfwmrNlYmCNkbj3DObFH/Fw/OS5KcUcfE4bMqtOu+GDnmZDkWyOpQ
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
Changes in v3:
- Send patches to correct kselftest harness maintainers
- Move harness selftest to dedicated directory
- Add harness selftest to MAINTAINERS
- Integrate harness selftest cleanup with the selftest framework
- Consistently use "kselftest harness" in commit messages
- Properly propagate kselftest harness failure
- Link to v2: https://lore.kernel.org/r/20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de

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
      selftests: harness: Add kselftest harness selftest
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

 MAINTAINERS                                        |    1 +
 tools/include/nolibc/Makefile                      |    1 +
 tools/include/nolibc/getopt.h                      |  101 ++
 tools/include/nolibc/nolibc.h                      |    1 +
 tools/include/nolibc/stdint.h                      |    4 +-
 tools/include/nolibc/stdio.h                       |  127 +-
 tools/include/nolibc/string.h                      |   17 +
 tools/include/nolibc/sys.h                         |  105 +-
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/kselftest_harness.h        |  181 +-
 .../testing/selftests/kselftest_harness/.gitignore |    2 +
 tools/testing/selftests/kselftest_harness/Makefile |    7 +
 .../selftests/kselftest_harness/harness-selftest.c |  129 ++
 .../kselftest_harness/harness-selftest.expected    |   62 +
 .../kselftest_harness/harness-selftest.sh          |   13 +
 tools/testing/selftests/nolibc/Makefile            |   13 +-
 tools/testing/selftests/nolibc/harness-selftest.c  |    1 +
 tools/testing/selftests/nolibc/nolibc-test.c       | 1729 +-------------------
 tools/testing/selftests/nolibc/run-tests.sh        |    2 +-
 19 files changed, 637 insertions(+), 1860 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250130-nolibc-kselftest-harness-8b2c8cac43bf

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


