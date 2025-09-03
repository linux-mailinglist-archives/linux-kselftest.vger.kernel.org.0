Return-Path: <linux-kselftest+bounces-40670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21407B4113D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 02:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A541B61B6C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4413AA2F;
	Wed,  3 Sep 2025 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuzvoBjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E50134BD;
	Wed,  3 Sep 2025 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858682; cv=none; b=Eb2wdmjWl2W4wfIp9quUup/UEw4I6/BWlo7EVeBwiSb+Q8zrm28966RmC1i+ni8/RJG2WhEzrPz8EizpXqH/OltlEB5xKHwe+Ng5wyrcWHQ9CiIQrlj9n6QfNawB1ZPar43QV3El6aK5qVFggoR3OueXRhKsRevyYxXmv5y0N3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858682; c=relaxed/simple;
	bh=5DsJBMp3wAX9AEWlY0wpjQ9N36iw1OYQPdCuD1Na+CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B6BsXtEoMKPxylzW+MhJ21y81DMATAdXxfKpgl7rfEervWzqppNZMPoCZPfI31hxYsgj9KE73b9D2koTvH3HV4wELMpnnhsIJ2FmqqfxYqImHtSrWBOkCmEnjw05hsFcC2SJ10WYSzFjRCFFm6QY0afVgRn/EsaL+IeuUJ+YZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuzvoBjl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4717543ed9so3799443a12.3;
        Tue, 02 Sep 2025 17:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756858680; x=1757463480; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYIRRUAh/Fowgng+KZ9bkO/wfTtQF6OUBOshwbubYKs=;
        b=BuzvoBjldjQG1EqlWVTiaSvwfw4GtJWoa3p5LrGp/K8belap7EzXB81tgeccXN3++O
         AjgTzUxmmnUIDzIkGyGCpFu0UTE+ldpJiLtiKCVz84NUEaZ7hxgrzvaYwyLLUNgXMYgw
         Q2bPDf1C2r62oJuvHsoXe5df0PWOyacCdNTGIIng3SCzBq9Ndjr7bn8Wl3nEvy4SFxdQ
         RnGbdV7qNxOsrwpZwIeKfLjTVfEjabVrZGW+L+GIojKd0YYu1xsVfFL4lo8I29rVqXs6
         VpbrfGwcGOUyLOwlHaBjPLbVLpBxMi+V4QxlZbGj3utzTW6+R4AxJUOWJfDpNya3U4zg
         p9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756858680; x=1757463480;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYIRRUAh/Fowgng+KZ9bkO/wfTtQF6OUBOshwbubYKs=;
        b=SQ+qD0GTSPILUusHJxFIL24PmfgM75FLlS13ZudJ5pvtMDA7Ca7cOfIh/4t/FdUkeB
         RIgDchLJ/uXHdX8ZhpcNQ1iRk1HrSZIx/PnMb9Y2//arPNXXng/qrepM0J5n9Og5j1Pi
         OVrs7UZ9G/VjjR88onsctYjoPz8wkhlhuuWlrk6SEtxsQIMJF81jAm9gsCSPXa59PYF8
         hj1fALhaF/I6g2v9OQzZYsV/XlhBXvowA7ITo00qqZ6fontk6tHcHFWcyHe+RjU9zZsv
         5R0Uuv94h4CrDnYz7nYqj/H8bot8lEDD592sl2QS3S6jYlw6CkoKqmRmx8EH5Z4Lw/aQ
         5gZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUhOC1Jm2+iF/jpi+Bx8ULXKu/fD2gt1ZInMhcIMWsI9/EWTYDwgjIdiZS6Z4d2TVYqtl5tB6ny3OiY9FuIyo=@vger.kernel.org, AJvYcCWTEZdE+Df20VGpkBIYg5ia9gs0bJ3UHLkM5NECK7OvDgA1ZVYGIbvDG0odftHyLtEnSUEjYujXamcJJCb+NPVk@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUsveb7NZe2WtbdknHjbF9Sn4Fz77NBRXDcg9kNHrKrw5K8Gw
	fp2HyrafZIsCoZSrFRXCLkTvQivbu3EVQB2ljaAuUXHv6oPUaBsYEWGLicPj9Col
X-Gm-Gg: ASbGncuABYThn6fuHqtfxqYpup+yLEZI4YkK3lHuAKJ2nU0MzoZ1Khbtmxq/j1eDR/e
	2QbVBVcoXmXd0VHezMFOJLVDuept1YJSOdTcbwmUEkxbHhF7JTAjgkVttB1aTxTAAVUK2sF+dyY
	3ZaTOLfVO6ebLWpKdIYNGKaUdneMheC6koda+Iybm51nHyh4J0hCIbIdJ9nAwCerjyA2w/0USAr
	jcQy6+aVzZxxR5A/c7wNjJ07W297Z0rl4E28IS2ELPSJm5qPWOXvPyAD+UhgZ0b9jZJr4/KCJxL
	+69xuxOJnAanQ+ewhMrTjz5DjNQkCkeF6DH29AUV9rFr0mYTSSGEzh4DZjkS9xaPBD2N7e3ufgg
	CEEbB6PdzYuhOYsDgIk1NBpgDxrfY3jk=
X-Google-Smtp-Source: AGHT+IGA3OO0i3AxIO79wtYpY3nRkQZcFDuEQrkQn6DbfbsdC1DCfRG3BW53rbTOmdL/sWIE6ZEN6g==
X-Received: by 2002:a17:902:cf08:b0:249:2d84:f406 with SMTP id d9443c01a7336-24944870965mr204024705ad.3.1756858679669;
        Tue, 02 Sep 2025 17:17:59 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067de9f1sm141877305ad.151.2025.09.02.17.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 17:17:58 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Tue, 02 Sep 2025 18:17:56 -0600
Subject: [PATCH v4] selftests/tty: add TIOCSTI test suite
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250902-toicsti-bug-v4-1-e5c960e0b3d6@gmail.com>
X-B4-Tracking: v=1; b=H4sIADOJt2gC/2XNTWrDMBCG4asErasgzdgduavcI3Shn7Ez0MTFc
 kxK8N0rp4Ta7fIbeN65q8yDcFZvu7saeJIs/aWM6mWn4slfOtaSylZgoDav1umxl5hH0eHaaXI
 AwXFTeQRVxOfArdweteN72SfJYz98PeKTXa7PTrPpTFYbzQYioa/rENOhO3v52Mf+vGR/DMB/0
 yJVSBhMFWBllt8T/P4ji1sL2upgHZIjZg/NX4sri2ZrsdiUIPnYUAvk13ae528YRZKdUgEAAA=
 =
X-Change-ID: 20250618-toicsti-bug-7822b8e94a32
To: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756858678; l=24236;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=5DsJBMp3wAX9AEWlY0wpjQ9N36iw1OYQPdCuD1Na+CM=;
 b=JTrE3oZ/yNhRlTIq0fNwqxsaJzKDtwCx3BJxMmNpaM+TAXFGXj5OUfcMfZ3/Rr0k9BvMF5vL/
 Kg1yKiRbALxCeSTWw73J8LGp4EFxa+uF791s/9cVnBO6nU9LbJFgT4T
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

TIOCSTI is a TTY ioctl command that allows inserting characters into
the terminal input queue, making it appear as if the user typed those
characters. This functionality has behavior that varies based on system
configuration and process credentials.

The dev.tty.legacy_tiocsti sysctl introduced in commit 83efeeeb3d04
("tty: Allow TIOCSTI to be disabled") controls TIOCSTI usage. When
disabled, TIOCSTI requires CAP_SYS_ADMIN capability.

The current implementation checks the current process's credentials via
capable(CAP_SYS_ADMIN), but does not validate against the file opener's
credentials stored in file->f_cred. This creates different behavior when
file descriptors are passed between processes via SCM_RIGHTS.

Add a test suite with 16 test variants using fixture variants to verify
TIOCSTI behavior when dev.tty.legacy_tiocsti is enabled/disabled:

- Basic TIOCSTI tests (8 variants): Direct testing with different
  capability and controlling terminal combinations
- FD passing tests (8 variants): Test behavior when file descriptors
  are passed between processes with different capabilities

The FD passing tests document this behavior - some tests show different
results than expected based on file opener credentials, demonstrating
that TIOCSTI uses current process credentials rather than file opener
credentials.

The tests validate proper enforcement of the legacy_tiocsti sysctl. Test
implementation uses openpty(3) with TIOCSCTTY for isolated PTY
environments. See tty_ioctl(4) for details on TIOCSTI behavior and
security requirements.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
Changes in v4:
- Moved skip conditions and sysctl setup from TEST_F to FIXTURE_SETUP (Kees Cook)
- Fixed fclose() error handling in set_legacy_tiocsti_setting (Kees Cook)
- Extracted run_basic_tiocsti_test() and run_fdpass_tiocsti_test functions (Kees Cook)
- Removed redundant sysctl restore logic from TEST_F (Kees Cook)
- Simplified FIXTURE_TEARDOWN (Kees Cook)
- Replace drop_to_nobody() to drop_all_privs() which should be more portable (Justin Stitt)
- Link to v3: https://lore.kernel.org/r/20250730-toicsti-bug-v3-1-dd2dac97f27a@gmail.com

Add selftests for TIOCSTI ioctl

To run all tests:
$ sudo ./tools/testing/selftests/tty/tty_tiocsti_test

Test Results:
- PASSED: 13/16 tests
- Different behavior: 3/16 tests (documenting credential checking behavior)

All tests validated using:
- scripts/checkpatch.pl --strict (clean output)
- Functional testing on kernel v6.16-rc2

Changes in v3:
- Replaced all printf() calls with TH_LOG() for proper test logging (Kees Cook)
- Added struct __test_metadata parameter to helper functions
- Moved common legacy_tiocsti availability check to FIXTURE_SETUP()
- Implemented sysctl modification/restoration in FIXTURE_SETUP/TEARDOWN
- Used openpty() with TIOCSCTTY for reliable PTY testing environment
- Fixed child/parent synchronization in FD passing tests
- Replaced manual _exit(1) handling with proper ASSERT statements
- Switched // comments to /* */ format throughout
- Expanded to 16 test variants using fixture variants
- Enhanced error handling and test reliability
- Link to v2: https://lore.kernel.org/r/20250713-toicsti-bug-v2-1-b183787eea29@gmail.com
- Link to v1: https://lore.kernel.org/r/20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com

References:
- tty_ioctl(4) - documents TIOCSTI ioctl and capability requirements
- openpty(3) - pseudo-terminal creation and management
- commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
- Documentation/security/credentials.rst
- https://github.com/KSPP/linux/issues/156
- https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad/
- drivers/tty/Kconfig
- Documentation/driver-api/tty/
---
 tools/testing/selftests/tty/Makefile           |   6 +-
 tools/testing/selftests/tty/config             |   1 +
 tools/testing/selftests/tty/tty_tiocsti_test.c | 650 +++++++++++++++++++++++++
 3 files changed, 656 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tty/Makefile b/tools/testing/selftests/tty/Makefile
index 50d7027b2ae3fb495dd1c0684363fa8f426be42c..7f6fbe5a0cd5663310e334d9d068b21dab9136ec 100644
--- a/tools/testing/selftests/tty/Makefile
+++ b/tools/testing/selftests/tty/Makefile
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -O2 -Wall
-TEST_GEN_PROGS := tty_tstamp_update
+TEST_GEN_PROGS := tty_tstamp_update tty_tiocsti_test
+LDLIBS += -lcap
 
 include ../lib.mk
+
+# Add libcap for TIOCSTI test
+$(OUTPUT)/tty_tiocsti_test: LDLIBS += -lcap
diff --git a/tools/testing/selftests/tty/config b/tools/testing/selftests/tty/config
new file mode 100644
index 0000000000000000000000000000000000000000..c6373aba66366c82435bb26c019eb360eb6310eb
--- /dev/null
+++ b/tools/testing/selftests/tty/config
@@ -0,0 +1 @@
+CONFIG_LEGACY_TIOCSTI=y
diff --git a/tools/testing/selftests/tty/tty_tiocsti_test.c b/tools/testing/selftests/tty/tty_tiocsti_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..5e767e6cb3ef8f05c5430eb0fcc792064c446c03
--- /dev/null
+++ b/tools/testing/selftests/tty/tty_tiocsti_test.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TTY Tests - TIOCSTI
+ *
+ * Copyright © 2025 Abhinav Saxena <xandfury@gmail.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <pwd.h>
+#include <termios.h>
+#include <grp.h>
+#include <sys/capability.h>
+#include <sys/prctl.h>
+#include <pty.h>
+#include <utmp.h>
+
+#include "../kselftest_harness.h"
+
+enum test_type {
+	TEST_PTY_TIOCSTI_BASIC,
+	TEST_PTY_TIOCSTI_FD_PASSING,
+	/* other tests cases such as serial may be added. */
+};
+
+/*
+ * Test Strategy:
+ * - Basic tests: Use PTY with/without TIOCSCTTY (controlling terminal for
+ *   current process)
+ * - FD passing tests: Child creates PTY, parent receives FD (demonstrates
+ *   security issue)
+ *
+ * SECURITY VULNERABILITY DEMONSTRATION:
+ * FD passing tests show that TIOCSTI uses CURRENT process credentials, not
+ * opener credentials. This means privileged processes can be given FDs from
+ * unprivileged processes and successfully perform TIOCSTI operations that the
+ * unprivileged process couldn't do directly.
+ *
+ * Attack scenario:
+ * 1. Unprivileged process opens TTY (direct TIOCSTI fails due to lack of
+ *    privileges)
+ * 2. Unprivileged process passes FD to privileged process via SCM_RIGHTS
+ * 3. Privileged process can use TIOCSTI on the FD (succeeds due to its
+ *    privileges)
+ * 4. Result: Effective privilege escalation via file descriptor passing
+ *
+ * This matches the kernel logic in tiocsti():
+ * 1. if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN)) return -EIO;
+ * 2. if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
+ *        return -EPERM;
+ * Note: Both checks use capable() on CURRENT process, not FD opener!
+ *
+ * If the file credentials were also checked along with the capable() checks
+ * then the results for FD pass tests would be consistent with the basic tests.
+ */
+
+FIXTURE(tiocsti)
+{
+	int pty_master_fd; /* PTY - for basic tests */
+	int pty_slave_fd;
+	bool has_pty;
+	bool initial_cap_sys_admin;
+	int original_legacy_tiocsti_setting;
+	bool can_modify_sysctl;
+};
+
+FIXTURE_VARIANT(tiocsti)
+{
+	const enum test_type test_type;
+	const bool controlling_tty; /* true=current->signal->tty == tty */
+	const int legacy_tiocsti; /* 0=restricted, 1=permissive */
+	const bool requires_cap; /* true=with CAP_SYS_ADMIN, false=without */
+	const int expected_success; /* 0=success, -EIO/-EPERM=specific error */
+};
+
+/*
+ * Tests Controlling Terminal Variants (current->signal->tty == tty)
+ *
+ * TIOCSTI Test Matrix:
+ *
+ * | legacy_tiocsti | CAP_SYS_ADMIN | Expected Result | Error |
+ * |----------------|---------------|-----------------|-------|
+ * | 1 (permissive) | true          | SUCCESS         | -     |
+ * | 1 (permissive) | false         | SUCCESS         | -     |
+ * | 0 (restricted) | true          | SUCCESS         | -     |
+ * | 0 (restricted) | false         | FAILURE         | -EIO  |
+ */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(tiocsti, basic_pty_permissive_withcap) {
+	.test_type = TEST_PTY_TIOCSTI_BASIC,
+	.controlling_tty = true,
+	.legacy_tiocsti = 1,
+	.requires_cap = true,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, basic_pty_permissive_nocap) {
+	.test_type = TEST_PTY_TIOCSTI_BASIC,
+	.controlling_tty = true,
+	.legacy_tiocsti = 1,
+	.requires_cap = false,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, basic_pty_restricted_withcap) {
+	.test_type = TEST_PTY_TIOCSTI_BASIC,
+	.controlling_tty = true,
+	.legacy_tiocsti = 0,
+	.requires_cap = true,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, basic_pty_restricted_nocap) {
+	.test_type = TEST_PTY_TIOCSTI_BASIC,
+	.controlling_tty = true,
+	.legacy_tiocsti = 0,
+	.requires_cap = false,
+	.expected_success = -EIO, /* FAILURE: legacy restriction */
+}; /* clang-format on */
+
+/*
+ * Note for FD Passing Test Variants
+ * Since we're testing the scenario where an unprivileged process pass an FD
+ * to a privileged one, .requires_cap here means the caps of the child process.
+ * Not the parent; parent would always be privileged.
+ */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_permissive_withcap) {
+	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
+	.controlling_tty = true,
+	.legacy_tiocsti = 1,
+	.requires_cap = true,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_permissive_nocap) {
+	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
+	.controlling_tty = true,
+	.legacy_tiocsti = 1,
+	.requires_cap = false,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_restricted_withcap) {
+	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
+	.controlling_tty = true,
+	.legacy_tiocsti = 0,
+	.requires_cap = true,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_restricted_nocap) {
+	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
+	.controlling_tty = true,
+	.legacy_tiocsti = 0,
+	.requires_cap = false,
+	.expected_success = -EIO,
+}; /* clang-format on */
+
+/*
+ * Non-Controlling Terminal Variants (current->signal->tty != tty)
+ *
+ * TIOCSTI Test Matrix:
+ *
+ * | legacy_tiocsti | CAP_SYS_ADMIN | Expected Result | Error |
+ * |----------------|---------------|-----------------|-------|
+ * | 1 (permissive) | true          | SUCCESS         | -     |
+ * | 1 (permissive) | false         | FAILURE         | -EPERM|
+ * | 0 (restricted) | true          | SUCCESS         | -     |
+ * | 0 (restricted) | false         | FAILURE         | -EIO  |
+ */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_permissive_withcap) {
+	.test_type = TEST_PTY_TIOCSTI_BASIC,
+	.controlling_tty = false,
+	.legacy_tiocsti = 1,
+	.requires_cap = true,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_permissive_nocap) {
+	.test_type = TEST_PTY_TIOCSTI_BASIC,
+	.controlling_tty = false,
+	.legacy_tiocsti = 1,
+	.requires_cap = false,
+	.expected_success = -EPERM,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_restricted_withcap) {
+	.test_type = TEST_PTY_TIOCSTI_BASIC,
+	.controlling_tty = false,
+	.legacy_tiocsti = 0,
+	.requires_cap = true,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_restricted_nocap) {
+	.test_type = TEST_PTY_TIOCSTI_BASIC,
+	.controlling_tty = false,
+	.legacy_tiocsti = 0,
+	.requires_cap = false,
+	.expected_success = -EIO,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_permissive_withcap) {
+	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
+	.controlling_tty = false,
+	.legacy_tiocsti = 1,
+	.requires_cap = true,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_permissive_nocap) {
+	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
+	.controlling_tty = false,
+	.legacy_tiocsti = 1,
+	.requires_cap = false,
+	.expected_success = -EPERM,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_restricted_withcap) {
+	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
+	.controlling_tty = false,
+	.legacy_tiocsti = 0,
+	.requires_cap = true,
+	.expected_success = 0,
+};
+
+FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_restricted_nocap) {
+	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
+	.controlling_tty = false,
+	.legacy_tiocsti = 0,
+	.requires_cap = false,
+	.expected_success = -EIO,
+}; /* clang-format on */
+
+/* Helper function to send FD via SCM_RIGHTS */
+static int send_fd_via_socket(int socket_fd, int fd_to_send)
+{
+	struct msghdr msg = { 0 };
+	struct cmsghdr *cmsg;
+	char cmsg_buf[CMSG_SPACE(sizeof(int))];
+	char dummy_data = 'F';
+	struct iovec iov = { .iov_base = &dummy_data, .iov_len = 1 };
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+
+	memcpy(CMSG_DATA(cmsg), &fd_to_send, sizeof(int));
+
+	return sendmsg(socket_fd, &msg, 0) < 0 ? -1 : 0;
+}
+
+/* Helper function to receive FD via SCM_RIGHTS */
+static int recv_fd_via_socket(int socket_fd)
+{
+	struct msghdr msg = { 0 };
+	struct cmsghdr *cmsg;
+	char cmsg_buf[CMSG_SPACE(sizeof(int))];
+	char dummy_data;
+	struct iovec iov = { .iov_base = &dummy_data, .iov_len = 1 };
+	int received_fd = -1;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	if (recvmsg(socket_fd, &msg, 0) < 0)
+		return -1;
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+		    cmsg->cmsg_type == SCM_RIGHTS) {
+			memcpy(&received_fd, CMSG_DATA(cmsg), sizeof(int));
+			break;
+		}
+	}
+
+	return received_fd;
+}
+
+static inline bool has_cap_sys_admin(void)
+{
+	cap_t caps = cap_get_proc();
+
+	if (!caps)
+		return false;
+
+	cap_flag_value_t cap_val;
+	bool has_cap = (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE,
+				     &cap_val) == 0) &&
+		       (cap_val == CAP_SET);
+
+	cap_free(caps);
+	return has_cap;
+}
+
+/*
+ * Switch to non-root user and clear all capabilities
+ */
+static inline bool drop_all_privs(struct __test_metadata *_metadata)
+{
+	/* Drop supplementary groups */
+	ASSERT_EQ(setgroups(0, NULL), 0);
+
+	/* Switch to non-root user */
+	ASSERT_EQ(setgid(1000), 0);
+	ASSERT_EQ(setuid(1000), 0);
+
+	/* Clear all capabilities */
+	cap_t empty = cap_init();
+
+	ASSERT_NE(empty, NULL);
+	ASSERT_EQ(cap_set_proc(empty), 0);
+	cap_free(empty);
+
+	/* Prevent privilege regain */
+	ASSERT_EQ(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0), 0);
+
+	/* Verify privilege drop */
+	ASSERT_FALSE(has_cap_sys_admin());
+	return true;
+}
+
+static inline int get_legacy_tiocsti_setting(struct __test_metadata *_metadata)
+{
+	FILE *fp;
+	int value = -1;
+
+	fp = fopen("/proc/sys/dev/tty/legacy_tiocsti", "r");
+	if (!fp) {
+		/* legacy_tiocsti sysctl not available (kernel < 6.2) */
+		return -1;
+	}
+
+	if (fscanf(fp, "%d", &value) == 1 && fclose(fp) == 0) {
+		if (value < 0 || value > 1)
+			value = -1; /* Invalid value */
+	} else {
+		value = -1; /* Failed to parse */
+	}
+
+	return value;
+}
+
+static inline bool set_legacy_tiocsti_setting(struct __test_metadata *_metadata,
+					      int value)
+{
+	FILE *fp;
+	bool success = false;
+
+	/* Sanity-check the value */
+	ASSERT_GE(value, 0);
+	ASSERT_LE(value, 1);
+
+	/*
+	 * Try to open for writing; if we lack permission, return false so
+	 * the test harness will skip variants that need to change it
+	 */
+	fp = fopen("/proc/sys/dev/tty/legacy_tiocsti", "w");
+	if (!fp)
+		return false;
+
+	/* Write the new setting */
+	if (fprintf(fp, "%d\n", value) > 0 && fclose(fp) == 0)
+		success = true;
+	else
+		TH_LOG("Failed to write legacy_tiocsti: %s", strerror(errno));
+
+	return success;
+}
+
+/*
+ * TIOCSTI injection test function
+ * @tty_fd: TTY slave file descriptor to test TIOCSTI on
+ * Returns: 0 on success, -errno on failure
+ */
+static inline int test_tiocsti_injection(struct __test_metadata *_metadata,
+					 int tty_fd)
+{
+	int ret;
+	char inject_char = 'V';
+
+	errno = 0;
+	ret = ioctl(tty_fd, TIOCSTI, &inject_char);
+	return ret == 0 ? 0 : -errno;
+}
+
+/*
+ * Child process: test TIOCSTI directly with capability/controlling
+ * terminal setup
+ */
+static void run_basic_tiocsti_test(struct __test_metadata *_metadata,
+				   FIXTURE_DATA(tiocsti) * self,
+				   const FIXTURE_VARIANT(tiocsti) * variant)
+{
+	/* Handle capability requirements */
+	if (self->initial_cap_sys_admin && !variant->requires_cap)
+		ASSERT_TRUE(drop_all_privs(_metadata));
+
+	if (variant->controlling_tty) {
+		/*
+		 * Create new session and set PTY as
+		 * controlling terminal
+		 */
+		pid_t sid = setsid();
+
+		ASSERT_GE(sid, 0);
+		ASSERT_EQ(ioctl(self->pty_slave_fd, TIOCSCTTY, 0), 0);
+	}
+
+	/*
+	 * Validate test environment setup and verify final
+	 * capability state matches expectation
+	 * after potential drop.
+	 */
+	ASSERT_TRUE(self->has_pty);
+	ASSERT_EQ(has_cap_sys_admin(), variant->requires_cap);
+
+	/* Test TIOCSTI and validate result */
+	int result = test_tiocsti_injection(_metadata, self->pty_slave_fd);
+
+	/* Check against expected result from variant */
+	EXPECT_EQ(result, variant->expected_success);
+	_exit(0);
+}
+
+/*
+ * Child process: create PTY and then pass FD to parent via SCM_RIGHTS
+ */
+static void run_fdpass_tiocsti_test(struct __test_metadata *_metadata,
+				    const FIXTURE_VARIANT(tiocsti) * variant,
+				    int sockfd)
+{
+	signal(SIGHUP, SIG_IGN);
+
+	/* Handle privilege dropping */
+	if (!variant->requires_cap && has_cap_sys_admin())
+		ASSERT_TRUE(drop_all_privs(_metadata));
+
+	/* Create child's PTY */
+	int child_master_fd, child_slave_fd;
+
+	ASSERT_EQ(openpty(&child_master_fd, &child_slave_fd, NULL, NULL, NULL),
+		  0);
+
+	if (variant->controlling_tty) {
+		pid_t sid = setsid();
+
+		ASSERT_GE(sid, 0);
+		ASSERT_EQ(ioctl(child_slave_fd, TIOCSCTTY, 0), 0);
+	}
+
+	/* Test child's direct TIOCSTI for reference */
+	int direct_result = test_tiocsti_injection(_metadata, child_slave_fd);
+
+	EXPECT_EQ(direct_result, variant->expected_success);
+
+	/* Send FD to parent */
+	ASSERT_EQ(send_fd_via_socket(sockfd, child_slave_fd), 0);
+
+	/* Wait for parent completion signal */
+	char sync_byte;
+	ssize_t bytes_read = read(sockfd, &sync_byte, 1);
+
+	ASSERT_EQ(bytes_read, 1);
+
+	close(child_master_fd);
+	close(child_slave_fd);
+	close(sockfd);
+	_exit(0);
+}
+
+FIXTURE_SETUP(tiocsti)
+{
+	/* Create PTY pair for basic tests */
+	self->has_pty = (openpty(&self->pty_master_fd, &self->pty_slave_fd,
+				 NULL, NULL, NULL) == 0);
+	if (!self->has_pty) {
+		self->pty_master_fd = -1;
+		self->pty_slave_fd = -1;
+	}
+
+	self->initial_cap_sys_admin = has_cap_sys_admin();
+	self->original_legacy_tiocsti_setting =
+		get_legacy_tiocsti_setting(_metadata);
+
+	if (self->original_legacy_tiocsti_setting < 0)
+		SKIP(return,
+			   "legacy_tiocsti sysctl not available (kernel < 6.2)");
+
+	/* Common skip conditions */
+	if (variant->test_type == TEST_PTY_TIOCSTI_BASIC && !self->has_pty)
+		SKIP(return, "PTY not available for controlling terminal test");
+
+	if (variant->test_type == TEST_PTY_TIOCSTI_FD_PASSING &&
+	    !self->initial_cap_sys_admin)
+		SKIP(return, "FD Pass tests require CAP_SYS_ADMIN");
+
+	if (variant->requires_cap && !self->initial_cap_sys_admin)
+		SKIP(return, "Test requires initial CAP_SYS_ADMIN");
+
+	/* Test if we can modify the sysctl (requires appropriate privileges) */
+	self->can_modify_sysctl = set_legacy_tiocsti_setting(
+		_metadata, self->original_legacy_tiocsti_setting);
+
+	/* Sysctl setup based on variant */
+	if (self->can_modify_sysctl &&
+	    self->original_legacy_tiocsti_setting != variant->legacy_tiocsti) {
+		if (!set_legacy_tiocsti_setting(_metadata,
+						variant->legacy_tiocsti))
+			SKIP(return, "Failed to set legacy_tiocsti sysctl");
+
+	} else if (!self->can_modify_sysctl &&
+		   self->original_legacy_tiocsti_setting !=
+			   variant->legacy_tiocsti)
+		SKIP(return, "legacy_tiocsti setting mismatch");
+}
+
+FIXTURE_TEARDOWN(tiocsti)
+{
+	/*
+	 * Backup restoration -
+	 * each test should restore its own sysctl changes
+	 */
+	if (self->can_modify_sysctl) {
+		int current_value = get_legacy_tiocsti_setting(_metadata);
+
+		if (current_value != self->original_legacy_tiocsti_setting) {
+			TH_LOG("Backup: Restoring legacy_tiocsti from %d to %d",
+			       current_value,
+			       self->original_legacy_tiocsti_setting);
+			set_legacy_tiocsti_setting(
+				_metadata,
+				self->original_legacy_tiocsti_setting);
+		}
+	}
+
+	if (self->has_pty) {
+		if (self->pty_master_fd >= 0)
+			close(self->pty_master_fd);
+		if (self->pty_slave_fd >= 0)
+			close(self->pty_slave_fd);
+	}
+}
+
+TEST_F(tiocsti, test)
+{
+	int status;
+	pid_t child_pid;
+
+	if (variant->test_type == TEST_PTY_TIOCSTI_BASIC) {
+		/* ===== BASIC TIOCSTI TEST ===== */
+		child_pid = fork();
+		ASSERT_GE(child_pid, 0);
+
+		/* Perform the actual test in the child process */
+		if (child_pid == 0)
+			run_basic_tiocsti_test(_metadata, self, variant);
+
+	} else {
+		/* ===== FD PASSING SECURITY TEST ===== */
+		int sockpair[2];
+
+		ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sockpair), 0);
+
+		child_pid = fork();
+		ASSERT_GE(child_pid, 0);
+
+		if (child_pid == 0) {
+			/* Child process - create PTY and send FD */
+			close(sockpair[0]);
+			run_fdpass_tiocsti_test(_metadata, variant,
+						sockpair[1]);
+		}
+
+		/* Parent process - receive FD and test TIOCSTI */
+		close(sockpair[1]);
+
+		int received_fd = recv_fd_via_socket(sockpair[0]);
+
+		ASSERT_GE(received_fd, 0);
+
+		bool parent_has_cap = self->initial_cap_sys_admin;
+
+		TH_LOG("=== TIOCSTI FD Passing Test Context ===");
+		TH_LOG("legacy_tiocsti: %d, Parent CAP_SYS_ADMIN: %s, Child: %s",
+		       variant->legacy_tiocsti, parent_has_cap ? "yes" : "no",
+		       variant->requires_cap ? "kept" : "dropped");
+
+		/* SECURITY TEST: Try TIOCSTI with FD opened by child */
+		int result = test_tiocsti_injection(_metadata, received_fd);
+
+		/* Log security concern if demonstrated */
+		if (result == 0 && !variant->requires_cap) {
+			TH_LOG("*** SECURITY CONCERN DEMONSTRATED ***");
+			TH_LOG("Privileged parent can use TIOCSTI on FD from unprivileged child");
+			TH_LOG("This shows current process credentials are used, not opener credentials");
+		}
+
+		EXPECT_EQ(result, variant->expected_success)
+		{
+			TH_LOG("FD passing: expected error %d, got %d",
+			       variant->expected_success, result);
+		}
+
+		/* Signal child completion */
+		char sync_byte = 'D';
+		ssize_t bytes_written = write(sockpair[0], &sync_byte, 1);
+
+		ASSERT_EQ(bytes_written, 1);
+
+		close(received_fd);
+		close(sockpair[0]);
+	}
+
+	/* Common child process cleanup for both test types */
+	ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
+
+	if (WIFSIGNALED(status)) {
+		TH_LOG("Child terminated by signal %d", WTERMSIG(status));
+		ASSERT_FALSE(WIFSIGNALED(status))
+		{
+			TH_LOG("Child process failed assertion");
+		}
+	} else {
+		EXPECT_EQ(WEXITSTATUS(status), 0);
+	}
+}
+
+TEST_HARNESS_MAIN

---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250618-toicsti-bug-7822b8e94a32

Best regards,
-- 
Abhinav Saxena <xandfury@gmail.com>


