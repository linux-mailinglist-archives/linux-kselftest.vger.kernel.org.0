Return-Path: <linux-kselftest+bounces-26762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D088A3810F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94A07A6582
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3D218AB2;
	Mon, 17 Feb 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYODbpZY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8rOM/uJn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9133217646;
	Mon, 17 Feb 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790039; cv=none; b=WZLrzzIT2nyKZZZaWhdrTOfgVSfbfiDnc9KYZGMShPdggghR2aDH6SNTb9fjd0yuVpIJg7Grw+qpF7pxzbQbQ8vYACq/VFwPy1oD62lwHG8ZLGhwHoF4ieUAxbEuN6u2YcWDs6b2c3a+BXH9aHCO7QXTIZkMopXgoES3thrRznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790039; c=relaxed/simple;
	bh=TfZ1KJVQujR/HT3oPEKNiSlDL6xZc4H3LPnzgMSMjm0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ArLlCo4IbxveCRlKSgT/qXOWA/QciRJqu8wFNjxBIu3tRoYIKV1X7RJbtzsUUqFetKmVMJ2ccdIoy7bjIKIIGdAD4a+X8RCgmzDbzUsfw27ooS7WEcXudX+pr7aYgUcTr7PfvcWHcfTsJYIaPx1F7HDE1Fdx0H/WFOM78M60gsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYODbpZY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8rOM/uJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GvuUwG+qIwvHRQItyyno7DxWnJaEqQNA725TKi+5rlw=;
	b=DYODbpZYeTzdI8EJRFJtmEi9rvrde+4pFhE8mZWSkxL9FMJuj9lyXKpqVAkkqbnsK3UfnO
	3hcxLC07lfeViBvXddUfi7UsaK2REhuhl1blC+NdzbVtFfJv4M+9ZiCKQ1fb/c9LTQvQEb
	K89aYBy49bZnabYfU8ue1p5wCM23tjZJ8ZiHxYCtYJFSoSrwKH9iqlmhc1XowRkM8wyGAG
	LQFCpOMiTEUqKPh+QMojDL8uDudK2a4mEqEUgcPj0+m5hjbK9ssG6q9Y95JT+DwN2af6Z8
	E+7drRGpPg2Cyud4X398fIuvBvYLdhgRKLWathA3q09YlO26s/8wtjkjui4KlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GvuUwG+qIwvHRQItyyno7DxWnJaEqQNA725TKi+5rlw=;
	b=8rOM/uJnix25mKPK2Db7m1FvxNrrNnpagv0Ue45mykqVbz+9VoGUlXPOHJZeJGcEHIJMLZ
	rT6gw67A9tzPQyCg==
Subject: [PATCH 00/12] kunit: Introduce UAPI testing framework
Date: Mon, 17 Feb 2025 11:59:20 +0100
Message-Id: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIgWs2cC/2WNyw6CMBBFf4XM2po+xbjyPwyLAoNMIMV0CsEQ/
 t3C1uU5yT13A8ZIyPAoNoi4ENMUMqhLAU3vwxsFtZlBS22VVE4Mc6AkBsaxS8iJhbvp0tSNldZ
 qyLNPxI7WM/mqMvfEaYrf82FRhz1iTmpl/mOLElL42pTm3jrvFD5HCnOKU6D12iJU+77/AIrUM
 9+0AAAA
X-Change-ID: 20241015-kunit-kselftests-56273bc40442
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=6312;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TfZ1KJVQujR/HT3oPEKNiSlDL6xZc4H3LPnzgMSMjm0=;
 b=ZQpQ0jJup/+DiUt2j1A80eoAA/RKqdnloh7ln/bzlNAjcHcTzXhYPfOV9Um/nbEaIka9ti3VE
 EbUkeD6fpAfDKtPAs3YPH4aLf+Hp686bgjnWsk0zfFLiB/G3GDXF/wA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently testing of userspace and in-kernel API use two different
frameworks. kselftests for the userspace ones and Kunit for the
in-kernel ones. Besides their different scopes, both have different
strengths and limitations:

Kunit:
* Tests are normal kernel code.
* They use the regular kernel toolchain.
* They can be packaged and distributed as modules conveniently.

Kselftests:
* Tests are normal userspace code
* They need a userspace toolchain.
  A kernel cross toolchain is likely not enough.
* A fair amout of userland is required to run the tests,
  which means a full distro or handcrafted rootfs.
* There is no way to conveniently package and run kselftests with a
  given kernel image.
* The kselftests makefiles are not as powerful as regular kbuild.
  For example they are missing proper header dependency tracking or more
  complex compiler option modifications.

Therefore kunit is much easier to run against different kernel
configurations and architectures.
This series aims to combine kselftests and kunit, avoiding both their
limitations. It works by compiling the userspace kselftests as part of
the regular kernel build, embedding them into the kunit kernel or module
and executing them from there. If the kernel toolchain is not fit to
produce userspace because of a missing libc, the kernel's own nolibc can
be used instead.
The structured TAP output from the kselftest is integrated into the
kunit KTAP output transparently, the kunit parser can parse the combined
logs together.

Further room for improvements:
* Call each test in its completely dedicated namespace
* Handle additional test files besides the test executable through
  archives. CPIO, cramfs, etc.
* Compatibility with kselftest_harness.h (in progress)
* Expose the blobs in debugfs
* Provide some convience wrappers around compat userprogs
* Figure out a migration path/coexistence solution for
  kunit UAPI and tools/testing/selftests/

Output from the kunit example testcase, note the output of
"example_uapi_tests".

$ ./tools/testing/kunit/kunit.py run --kunitconfig lib/kunit example
...
Running tests with:
$ .kunit/linux kunit.filter_glob=example kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
[11:53:53] ================== example (10 subtests) ===================
[11:53:53] [PASSED] example_simple_test
[11:53:53] [SKIPPED] example_skip_test
[11:53:53] [SKIPPED] example_mark_skipped_test
[11:53:53] [PASSED] example_all_expect_macros_test
[11:53:53] [PASSED] example_static_stub_test
[11:53:53] [PASSED] example_static_stub_using_fn_ptr_test
[11:53:53] [PASSED] example_priv_test
[11:53:53] =================== example_params_test  ===================
[11:53:53] [SKIPPED] example value 3
[11:53:53] [PASSED] example value 2
[11:53:53] [PASSED] example value 1
[11:53:53] [SKIPPED] example value 0
[11:53:53] =============== [PASSED] example_params_test ===============
[11:53:53] [PASSED] example_slow_test
[11:53:53] ======================= (4 subtests) =======================
[11:53:53] [PASSED] procfs
[11:53:53] [PASSED] userspace test 2
[11:53:53] [SKIPPED] userspace test 3: some reason
[11:53:53] [PASSED] userspace test 4
[11:53:53] ================ [PASSED] example_uapi_test ================
[11:53:53] ===================== [PASSED] example =====================
[11:53:53] ============================================================
[11:53:53] Testing complete. Ran 16 tests: passed: 11, skipped: 5
[11:53:53] Elapsed time: 67.543s total, 1.823s configuring, 65.655s building, 0.058s running

Based on v6.14-rc1 and the series
"tools/nolibc: compatibility with -Wmissing-prototypes" [0].
For compatibility with LLVM/clang another series is needed [1].

[0] https://lore.kernel.org/lkml/20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net/
[1] https://lore.kernel.org/lkml/20250213-kbuild-userprog-fixes-v1-0-f255fb477d98@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (12):
      kconfig: implement CONFIG_HEADERS_INSTALL for Usermode Linux
      kconfig: introduce CONFIG_ARCH_HAS_NOLIBC
      kbuild: userprogs: respect CONFIG_WERROR
      kbuild: userprogs: add nolibc support
      kbuild: introduce blob framework
      kunit: tool: Add test for nested test result reporting
      kunit: tool: Don't overwrite test status based on subtest counts
      kunit: tool: Parse skipped tests from kselftest.h
      kunit: Introduce UAPI testing framework
      kunit: uapi: Add example for UAPI tests
      kunit: uapi: Introduce preinit executable
      kunit: uapi: Validate usability of /proc

 Documentation/kbuild/makefiles.rst                 |  12 +
 Makefile                                           |   5 +-
 include/kunit/uapi.h                               |  17 ++
 include/linux/blob.h                               |  21 ++
 init/Kconfig                                       |   2 +
 lib/Kconfig.debug                                  |   1 -
 lib/kunit/Kconfig                                  |   9 +
 lib/kunit/Makefile                                 |  17 +-
 lib/kunit/kunit-example-test.c                     |  17 ++
 lib/kunit/kunit-uapi-example.c                     |  58 +++++
 lib/kunit/uapi-preinit.c                           |  61 +++++
 lib/kunit/uapi.c                                   | 250 +++++++++++++++++++++
 scripts/Makefile.blobs                             |  19 ++
 scripts/Makefile.build                             |   6 +
 scripts/Makefile.clean                             |   2 +-
 scripts/Makefile.userprogs                         |  18 +-
 scripts/blob-wrap.c                                |  27 +++
 tools/include/nolibc/Kconfig.nolibc                |  18 ++
 tools/testing/kunit/kunit_parser.py                |  13 +-
 tools/testing/kunit/kunit_tool_test.py             |   9 +
 .../test_is_test_passed-failure-nested.log         |  10 +
 .../test_data/test_is_test_passed-kselftest.log    |   3 +-
 22 files changed, 584 insertions(+), 11 deletions(-)
---
base-commit: 20e952894066214a80793404c9578d72ef89c5e0
change-id: 20241015-kunit-kselftests-56273bc40442

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


