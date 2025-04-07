Return-Path: <linux-kselftest+bounces-30221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B27A7D67B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B97A18927A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A390225791;
	Mon,  7 Apr 2025 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ucdcRbct";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2khz0E8N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5F221F35;
	Mon,  7 Apr 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011781; cv=none; b=UfsN44k26m8rbV5gBRa7N4OGxX3tNyaoo50Sq826C+z1OQXxxYaXT5lxNSniMe3Yxxb87VFwALf9kt0BH4OeSWiscH/mHbCRqOFsntWsPMqpdWMe6yGLuRh4yy0VbRT2j+vFUZOhs+ezFP0/dmKFiFciBFdYGdpsdR+HWsy1Gws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011781; c=relaxed/simple;
	bh=NU4zTfsIhDkeZ8jV1sNodObhXaZ3SlU84vlL6QLNpvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c24nys3RiAuoCxV87a9mP3pE2C7VSsruvCvlVTQgmaiO7A2ERal/xg8Ysg09idG2jpFG2oEf9lQ0JjbEanQyvkN+Ubx8ytGn/lZ8qu+knX3UklYTSQD0fIqgOYT6l/GFmp9X/deabnruUBk2x6ng/lulbeFXZjpppK4AFSskbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ucdcRbct; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2khz0E8N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0xGajJMC5c92kaY7xSvHKftkdfUja6PcIjFaBuEhrRo=;
	b=ucdcRbctyQ5hYxRWncM3rIbw9/z3gEW3F4t+1SC6+hkp/rGZTDcUEMZzsKcGQuLSyp0x8G
	Nm24skSOzivMfpmnOofzbtVC8lpwjJSo7gmqm8I79XshELzMsosETHcczDI9QNgSEx8N+w
	aIDX7QLe/wJEHkdqUWE2JmTRJqaLwH7buXR2G+71D8KDsxjlTQwvEhSkzhB9Ik5XfsRzeF
	P4kwXS/aSa95TCC82N3D58V0xy+aoh+8ylAFMUfbjb9Io3bn3suJXGxFFGnW6eQ2SUDyxU
	RcXywW18+f88qY4Oi1MOCwtBpCpwth1uWvr/cHr0hOJvYoU7AQBa4N9lpXDg8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0xGajJMC5c92kaY7xSvHKftkdfUja6PcIjFaBuEhrRo=;
	b=2khz0E8NweJt3qr+88Nw+o/6xiSQEj3aHyeQb2CB8fRVSv6eX+tQ3KlEkMS6qpXT9bBh1j
	y+7ANy2EHOKj+gBA==
Subject: [PATCH v2 00/11] kunit: Introduce UAPI testing framework
Date: Mon, 07 Apr 2025 09:42:37 +0200
Message-Id: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO2B82cC/3WNwQ6CMBAFf4X0bE27bcV48j8MhxZW2UCKaQvBE
 P7dQjxpPM5LZt7CIgbCyC7FwgJOFGnwGeBQsLq1/oGcmswMBGgppOHd6CnxLmJ/TxhT5OYEpXK
 1FloDy9oz4J3mPXmrMrcU0xBe+8Mkt3WLGQFS/cYmyQW3TpXq3BhrJF578mMKg6f52ODW/8jlH
 1mD0wZ0rZywX3K1rusbDUxmffEAAAA=
X-Change-ID: 20241015-kunit-kselftests-56273bc40442
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=6746;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NU4zTfsIhDkeZ8jV1sNodObhXaZ3SlU84vlL6QLNpvw=;
 b=9pMWmzwqgpRxfVCMe7pj87t6ztsCUaTyxBiSmoS8M1htnt/1uLv9LaoCH6fnUWZtUzkImZ8iF
 37637bHnLlMBD8i8uT20xL/wKFA3RdThNX4kRB1207P4Bb+Djj/H/r4
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

Based on v6.15-rc1.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase onto v6.15-rc1
- Add documentation and kernel docs
- Resolve invalid kconfig breakages
- Drop already applied patch "kbuild: implement CONFIG_HEADERS_INSTALL for Usermode Linux"
- Drop userprogs CONFIG_WERROR integration, it doesn't need to be part of this series
- Replace patch prefix "kconfig" with "kbuild"
- Rename kunit_uapi_run_executable() to kunit_uapi_run_kselftest()
- Generate private, conflict-free symbols in the blob framework
- Handle kselftest exit codes
- Handle SIGABRT
- Forward output also to kunit debugfs log
- Install a fd=0 stdin filedescriptor
- Link to v1: https://lore.kernel.org/r/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de

---
Thomas Weißschuh (11):
      kbuild: userprogs: add nolibc support
      kbuild: introduce CONFIG_ARCH_HAS_NOLIBC
      kbuild: doc: add label for userprogs section
      kbuild: introduce blob framework
      kunit: tool: Add test for nested test result reporting
      kunit: tool: Don't overwrite test status based on subtest counts
      kunit: tool: Parse skipped tests from kselftest.h
      kunit: Introduce UAPI testing framework
      kunit: uapi: Add example for UAPI tests
      kunit: uapi: Introduce preinit executable
      kunit: uapi: Validate usability of /proc

 Documentation/dev-tools/kunit/api/index.rst        |   5 +
 Documentation/dev-tools/kunit/api/uapi.rst         |  12 +
 Documentation/kbuild/makefiles.rst                 |  37 ++-
 MAINTAINERS                                        |   2 +
 include/kunit/uapi.h                               |  24 ++
 include/linux/blob.h                               |  32 +++
 init/Kconfig                                       |   2 +
 lib/kunit/.kunitconfig                             |   2 +
 lib/kunit/Kconfig                                  |  11 +
 lib/kunit/Makefile                                 |  18 +-
 lib/kunit/kunit-example-test.c                     |  15 ++
 lib/kunit/kunit-example-uapi.c                     |  56 ++++
 lib/kunit/uapi-preinit.c                           |  65 +++++
 lib/kunit/uapi.c                                   | 294 +++++++++++++++++++++
 scripts/Makefile.blobs                             |  19 ++
 scripts/Makefile.build                             |   6 +
 scripts/Makefile.clean                             |   2 +-
 scripts/Makefile.userprogs                         |  16 +-
 scripts/blob-wrap.c                                |  27 ++
 tools/include/nolibc/Kconfig.nolibc                |  13 +
 tools/testing/kunit/kunit_parser.py                |  13 +-
 tools/testing/kunit/kunit_tool_test.py             |   9 +
 .../test_is_test_passed-failure-nested.log         |  10 +
 .../test_data/test_is_test_passed-kselftest.log    |   3 +-
 24 files changed, 682 insertions(+), 11 deletions(-)
---
base-commit: bf9962cc9ec3ac1dae2bf81b126657c1c49c348a
change-id: 20241015-kunit-kselftests-56273bc40442

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


