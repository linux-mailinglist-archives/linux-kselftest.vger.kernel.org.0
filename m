Return-Path: <linux-kselftest+bounces-28147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCCDA4D44F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0CF1890A6E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3B1F584D;
	Tue,  4 Mar 2025 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sDccCfcm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+DLIzqm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA188194080;
	Tue,  4 Mar 2025 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072271; cv=none; b=MYeNPeUmwaAVv9gpER0uUtU/SgKzSqprlbJynQWiIQ8sMlI0rfbKyZx69gdUmBUXJkenDceb5ebhY9K+kzw2Ind0RI/Q8GOEnBIbddyoYM6f8qDL10W0XiCA6p/XdsZxTLzqChH2TZoGJltd3sgSOv+UsKH+ROZOkY7hUfWYoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072271; c=relaxed/simple;
	bh=9BZRy+5vhR0k9E5hu4nHa3WvY8X1DyYhT4019eDtksg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FqZ+FHMLMBIUimtxwi3mtSNDywiRhKUHfTIe92pxsPpAHHfDJbe51IXsmTlV8KqnvNMik8CKA3qhJYIPRWPaxuKb6ONFQRP6YfEJdJFXHB9gLPs9etRPdlKDUMYPwIT/yxWn2ptjoUi91G8EO1XMKgCdZz5y//Db2nTXiM2n+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sDccCfcm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+DLIzqm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2EGve4RALbbWdqA7d4p2oAYR48tfNyRhJejvj7f0jSw=;
	b=sDccCfcmXAdKFw1pw3d6uRIlMH6o8xaP+/+NpuHdZalsomwlkpShMAan5+s9lsLPrv/t6/
	xTgvAUseiLv0NQHEHAwPiGtoJ3KGXlpuNul88i/IyTNPoabrmNvShKUv8Yi/s6yzFppASV
	ZBWZ7Wchd6EISKOl2u3K1KsE6KIZM6k02FJmEiconyXedrqnbRPZ1EjliTl6YO8olbZMUl
	Xa6YPoQ78OXvtxM4IY6Qj+2WjTuXhV58vWYbMb83SmtYg6Y36ECTOd2pi8Cma9wl0Ak4Dq
	tjk47V9uPREHVoh/0gHmSr3zk1I7km9JMHCj4OgroHOTw3TH1qWwIGSUjM4qLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2EGve4RALbbWdqA7d4p2oAYR48tfNyRhJejvj7f0jSw=;
	b=F+DLIzqmsmhx97H06McR1T9whr1rs03P4ssN8YRpk0s11GTi5WWcpBAQm3cIOSEjWnw2OS
	3KPrtnt5PShFBNCw==
Subject: [PATCH 00/32] kselftest harness and nolibc compatibility
Date: Tue, 04 Mar 2025 08:10:30 +0100
Message-Id: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGanxmcC/3WNyw6CMBBFf4V07Zg+QIkr/8OwoGUqE0lrOpVgC
 P9uxbXLc5J77ioYEyGLS7WKhDMxxVBAHSrhxj7cEWgoLLTUjVRGQogTWQcPxsln5AxjnwIyQ2u
 1a13vamO9KPNnQk/Lnr51hUfiHNN7f5rV1/6iWpn/0VmBBIPYnur6bBvprxOFV04x0HIcUHTbt
 n0AYO2NhsQAAAA=
X-Change-ID: 20250130-nolibc-kselftest-harness-8b2c8cac43bf
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=4103;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9BZRy+5vhR0k9E5hu4nHa3WvY8X1DyYhT4019eDtksg=;
 b=E78+QPdhiRpSgYt3Yti9F1IMio4uToIiNUirkeChqPa3SZEmmhWJRHdAEYJRadJ+loqt3PSEn
 2hpfWrieGiMADotP2xbHUpVM0bb6nHqt1zO1x6hcGm+4O+cyUlFcd9z
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc is useful for selftests as the test programs can be very small,
and compiled with just a kernel crosscompiler, without userspace support.
Currently nolibc is only usable with kselftest.h, not the more
convenient to use kselftest_harness.h
This series provides this compatibility by adding new features to nolibc
and removing the usage of problematic features from the harness.

The first half of the series are changes to the harness, the second one
are for nolibc. Both parts are very independent and can go through
different trees.
The last patch is not meant to be applied and serves as test that
everything works correctly.

Based on the next branch of the nolibc tree:
https://web.git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/log/?h=next

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (32):
      selftests: harness: Add harness selftest
      selftests: harness: Use C89 comment style
      selftests: harness: Ignore unused variant argument warning
      selftests: harness: Mark functions without prototypes static
      selftests: harness: Remove inline qualifier for wrappers
      selftests: harness: Guard includes on nolibc
      selftests: harness: Remove dependency on libatomic
      selftests: harness: Implement test timeouts through pidfd
      selftests: harness: Don't set setup_completed for fixtureless tests
      selftests: harness: Always provide "self" and "variant"
      selftests: harness: Move teardown conditional into test metadata
      selftests: harness: Add teardown callback to test metadata
      selftests: harness: Stop using setjmp()/longjmp()
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
 tools/include/nolibc/getopt.h                      |  105 ++
 tools/include/nolibc/nolibc.h                      |    1 +
 tools/include/nolibc/stdint.h                      |    4 +-
 tools/include/nolibc/stdio.h                       |  127 +-
 tools/include/nolibc/string.h                      |   17 +
 tools/include/nolibc/sys.h                         |  102 +-
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/kselftest/.gitignore       |    1 +
 tools/testing/selftests/kselftest/Makefile         |    6 +
 .../testing/selftests/kselftest/harness-selftest.c |  129 ++
 .../selftests/kselftest/harness-selftest.expected  |   62 +
 .../selftests/kselftest/harness-selftest.sh        |   14 +
 tools/testing/selftests/kselftest_harness.h        |  188 +--
 tools/testing/selftests/nolibc/Makefile            |   17 +-
 tools/testing/selftests/nolibc/harness-selftest.c  |    1 +
 tools/testing/selftests/nolibc/nolibc-test.c       | 1712 +-------------------
 tools/testing/selftests/nolibc/run-tests.sh        |    2 +-
 18 files changed, 639 insertions(+), 1851 deletions(-)
---
base-commit: cb839e0cc881b4abd4a2e64cd06c2e313987a189
change-id: 20250130-nolibc-kselftest-harness-8b2c8cac43bf

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


