Return-Path: <linux-kselftest+bounces-34643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD31AD4D0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63BB1BC115D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC14231854;
	Wed, 11 Jun 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ztIvbMWq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9TOXAu3T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C83A2206BE;
	Wed, 11 Jun 2025 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627514; cv=none; b=p6wQG3OCH1gMuLQPxMfUvGa590OBLAKHgJRcVTAJhQXmRWSUoUPNmRKPAoUGMFp29taz9E/zO+JbuF1F6l7bQUfo8IwSvOi1nwk2T/j+vDD/ElvqAIrX1egYEajhvc3ZtlK4sK9IU4+peSZQrzs9WQKqCGv5p9xCc0Bm0F0kV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627514; c=relaxed/simple;
	bh=6UMiXcyoIq9M4FKEOo43nM5aQWsXH6QWlxEFJpS01j4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pvNjKDwsDYmlRGQiXDiZDzDN1qxf2yZp4heN2a1jIzm/UdKY27XFe8xfdkCmicQiqMfyryd15wVN9UkvAKbtde4PrZE6qhby6CjvW5LGGb4oMn+qaNh6JoKhINtufVcFGmktSvh6W5L6+hj7LkgA4Gx4fskU56jYA9M9jxWboTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ztIvbMWq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9TOXAu3T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8zSLyZYo3ihzjC5JPibnrIQcHyWB1lKmlNba6ZPoZzI=;
	b=ztIvbMWqVWSgNjkbrJXoKdI7hUTZHor6f97gBCi+H/iLxBYg6JO5/BI+B9zcvIxRoLLOPX
	T2Y1WucFoQST4fiqptCky6bLHPiI8E0NbFHetjwuMDWTdJZZwdmKynlkOW48xg717w+SSO
	e8aOiFRHgVpaArBdBObvDiAsFEiS++JST7XvcQk47x9zVLgiWFB+e4kfm9NXuFDxQuu2uW
	9q7ChHh7VRWwY1fXeH5hhw7h+WPSlwCsgoPh9/nLnuiFhI3DvBqRJqbAugrRop9qZL2OOx
	YHCsUkG2Z4iHUcZuMNgwzoVMO+GzxY+IDLFVKJMN549xFv9beiqoeMPm52i6Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8zSLyZYo3ihzjC5JPibnrIQcHyWB1lKmlNba6ZPoZzI=;
	b=9TOXAu3TR8e8oxSGMK/Ns27pNDTHuN31oWDLNtT93C0RhlkuzZlo2KJQF2HU70uk+Sk6og
	5xG+toq8rpm3sgDQ==
Subject: [PATCH v3 00/16] kunit: Introduce UAPI testing framework
Date: Wed, 11 Jun 2025 09:38:06 +0200
Message-Id: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF4ySWgC/3WOzQrCMBAGX0VyNpJsNlY8+R7ioT9buyipJGmpl
 L67TRGEqsdZmNlvFIE8UxDHzSg89Ry4dTOY7UaUTe6uJLmaWYAC1EpbeescR3kLdK8jhRik3UN
 mihIVIohZe3iqeViS58vMDYfY+ufyodfpmmJWgTbfsV5LJfPCZOZQ2dxqOt3ZddG3joddRan/l
 rM/MkKBFrA0hcpXclrTw2cBql8RSBGLWiPBIaurdWSaphdQFecDNgEAAA==
X-Change-ID: 20241015-kunit-kselftests-56273bc40442
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=7808;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6UMiXcyoIq9M4FKEOo43nM5aQWsXH6QWlxEFJpS01j4=;
 b=18VMEmLrljDcRsOhGwao/W03s2JLnOkTRGlPyVZ2UXmujK255AvlJ9B3925MhMULIPUW4p0IV
 /2I5SrvLM4wD37E6h3AQ96/aSnhCRr/PmR9v2JjFVANaPos3sCpuTZf
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
Changes in v3:
- Reintroduce CONFIG_CC_CAN_LINK_STATIC
- Enable CONFIG_ARCH_HAS_NOLIBC for m68k and SPARC
- Properly handle 'clean' target for userprogs
- Use ramfs over tmpfs to reduce dependencies
- Inherit userprogs byte order and ABI from kernel
- Drop now unnecessary "#ifndef NOLIBC"
- Pick up review tags
- Drop usage of __private in blob.h,
  sparse complains and it is not really necessary
- Fix execution on loongarch when using clang
- Drop userprogs libgcc handling, it was ugly and is not yet necessary
- Link to v2: https://lore.kernel.org/r/20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de

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
Thomas Weißschuh (16):
      kbuild: userprogs: avoid duplicating of flags inherited from kernel
      kbuild: userprogs: also inherit byte order and ABI from kernel
      init: re-add CONFIG_CC_CAN_LINK_STATIC
      kbuild: userprogs: add nolibc support
      kbuild: introduce CONFIG_ARCH_HAS_NOLIBC
      kbuild: doc: add label for userprogs section
      kbuild: introduce blob framework
      kunit: tool: Add test for nested test result reporting
      kunit: tool: Don't overwrite test status based on subtest counts
      kunit: tool: Parse skipped tests from kselftest.h
      kunit: Always descend into kunit directory during build
      kunit: qemu_configs: loongarch: Enable LSX/LSAX
      kunit: Introduce UAPI testing framework
      kunit: uapi: Add example for UAPI tests
      kunit: uapi: Introduce preinit executable
      kunit: uapi: Validate usability of /proc

 Documentation/dev-tools/kunit/api/index.rst        |   5 +
 Documentation/dev-tools/kunit/api/uapi.rst         |  12 +
 Documentation/kbuild/makefiles.rst                 |  38 ++-
 MAINTAINERS                                        |   2 +
 Makefile                                           |   7 +-
 include/kunit/uapi.h                               |  24 ++
 include/linux/blob.h                               |  31 +++
 init/Kconfig                                       |   7 +
 lib/Makefile                                       |   4 -
 lib/kunit/Kconfig                                  |  10 +
 lib/kunit/Makefile                                 |  20 +-
 lib/kunit/kunit-example-test.c                     |  15 ++
 lib/kunit/kunit-example-uapi.c                     |  54 ++++
 lib/kunit/uapi-preinit.c                           |  63 +++++
 lib/kunit/uapi.c                                   | 294 +++++++++++++++++++++
 scripts/Makefile.blobs                             |  19 ++
 scripts/Makefile.build                             |   6 +
 scripts/Makefile.clean                             |   2 +-
 scripts/Makefile.userprogs                         |  13 +-
 scripts/blob-wrap.c                                |  27 ++
 tools/include/nolibc/Kconfig.nolibc                |  15 ++
 tools/testing/kunit/kunit_parser.py                |  13 +-
 tools/testing/kunit/kunit_tool_test.py             |   9 +
 tools/testing/kunit/qemu_configs/loongarch.py      |   2 +
 .../test_is_test_passed-failure-nested.log         |  10 +
 .../test_data/test_is_test_passed-kselftest.log    |   3 +-
 26 files changed, 686 insertions(+), 19 deletions(-)
---
base-commit: f07a3558c4a5d76f3fea004075e5151c4516d055
change-id: 20241015-kunit-kselftests-56273bc40442

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


