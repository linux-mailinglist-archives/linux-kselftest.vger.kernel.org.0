Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183F2E9AAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 12:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJ3LVS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 07:21:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39042 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726065AbfJ3LVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 07:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572434476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tGhGu7p5l4Jg5WUP1EoXs/pnsE4ygK0Noe6XcN9W1HY=;
        b=hW48Lc0b2Zgcso+nJMIm07U5vfiVOfFkCwvfV1XQ93+zj48kILzK/k4HRSoF1pS/OCxpwj
        DFelQwDDwBSWqnvObuUOmVutZNGoeQnYfnfE2zqE2BCU6BBDNTwvosxP+OXxjV1E8Q/D7M
        jx13Oznm92XZuBZWaJSoKfISe8eW+GU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-28URAv_aPe-98OsF77jZ3A-1; Wed, 30 Oct 2019 07:21:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 601381800D56;
        Wed, 30 Oct 2019 11:21:12 +0000 (UTC)
Received: from dcbz.redhat.com (unknown [10.36.118.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 600AF5D6D0;
        Wed, 30 Oct 2019 11:21:08 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Adrian Reber <areber@redhat.com>
Subject: [PATCH] selftests: add tests for clone3()
Date:   Wed, 30 Oct 2019 12:21:00 +0100
Message-Id: <20191030112100.700087-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 28URAv_aPe-98OsF77jZ3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds tests for clone3() with different values and sizes
of struct clone_args.

This selftest was initially part of of the clone3() with PID selftest.
After that patch was almost merged Eugene sent out a couple of patches
to fix problems with these test.

This commit now only contains the clone3() selftest after the LPC
decision to rework clone3() with PID to allow setting the PID in
multiple PID namespaces including all of Eugene's patches.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Adrian Reber <areber@redhat.com>
---
 MAINTAINERS                               |   1 +
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/clone3/.gitignore |   1 +
 tools/testing/selftests/clone3/Makefile   |   7 +
 tools/testing/selftests/clone3/clone3.c   | 195 ++++++++++++++++++++++
 5 files changed, 205 insertions(+)
 create mode 100644 tools/testing/selftests/clone3/.gitignore
 create mode 100644 tools/testing/selftests/clone3/Makefile
 create mode 100644 tools/testing/selftests/clone3/clone3.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..d9426de8fb38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12830,6 +12830,7 @@ S:=09Maintained
 T:=09git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
 F:=09samples/pidfd/
 F:=09tools/testing/selftests/pidfd/
+F:=09tools/testing/selftests/clone3/
 K:=09(?i)pidfd
 K:=09(?i)clone3
 K:=09\b(clone_args|kernel_clone_args)\b
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index 4cdbae6f4e61..ad442364218a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -4,6 +4,7 @@ TARGETS +=3D bpf
 TARGETS +=3D breakpoints
 TARGETS +=3D capabilities
 TARGETS +=3D cgroup
+TARGETS +=3D clone3
 TARGETS +=3D cpufreq
 TARGETS +=3D cpu-hotplug
 TARGETS +=3D drivers/dma-buf
diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/self=
tests/clone3/.gitignore
new file mode 100644
index 000000000000..85d9d3ba2524
--- /dev/null
+++ b/tools/testing/selftests/clone3/.gitignore
@@ -0,0 +1 @@
+clone3
diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selfte=
sts/clone3/Makefile
new file mode 100644
index 000000000000..ea922c014ae4
--- /dev/null
+++ b/tools/testing/selftests/clone3/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS +=3D -I../../../../usr/include/
+
+TEST_GEN_PROGS :=3D clone3
+
+include ../lib.mk
diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selfte=
sts/clone3/clone3.c
new file mode 100644
index 000000000000..a5a1ed91e550
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Based on Christian Brauner's clone3() example */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "../kselftest.h"
+
+/*
+ * Different sizes of struct clone_args
+ */
+#define CLONE3_ARGS_SIZE_V0 64
+
+enum test_mode {
+=09CLONE3_ARGS_NO_TEST,
+=09CLONE3_ARGS_ALL_0,
+=09CLONE3_ARGS_ALL_1,
+=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG,
+=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
+=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
+=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
+};
+
+static pid_t raw_clone(struct clone_args *args, size_t size)
+{
+=09return syscall(__NR_clone3, args, size);
+}
+
+static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mo=
de)
+{
+=09struct clone_args args =3D {0};
+=09pid_t ppid =3D -1;
+=09pid_t pid =3D -1;
+=09int status;
+
+=09args.flags =3D flags;
+=09args.exit_signal =3D SIGCHLD;
+
+=09if (size =3D=3D 0)
+=09=09size =3D sizeof(struct clone_args);
+
+=09switch (test_mode) {
+=09case CLONE3_ARGS_ALL_0:
+=09=09args.flags =3D 0;
+=09=09args.pidfd =3D 0;
+=09=09args.child_tid =3D 0;
+=09=09args.parent_tid =3D 0;
+=09=09args.exit_signal =3D 0;
+=09=09args.stack =3D 0;
+=09=09args. stack_size =3D 0;
+=09=09args.tls =3D 0;
+=09=09break;
+
+=09case CLONE3_ARGS_ALL_1:
+=09=09args.flags =3D 1;
+=09=09args.pidfd =3D 1;
+=09=09args.child_tid =3D 1;
+=09=09args.parent_tid =3D 1;
+=09=09args.exit_signal =3D 1;
+=09=09args.stack =3D 1;
+=09=09args. stack_size =3D 1;
+=09=09args.tls =3D 1;
+=09=09break;
+
+=09case CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG:
+=09=09args.exit_signal =3D 0xbadc0ded00000000ULL;
+=09=09break;
+
+=09case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG:
+=09=09args.exit_signal =3D 0x0000000080000000ULL;
+=09=09break;
+
+=09case CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG:
+=09=09args.exit_signal =3D 0x0000000000000100ULL;
+=09=09break;
+
+=09case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
+=09=09args.exit_signal =3D 0x00000000000000f0ULL;
+=09=09break;
+=09}
+
+=09pid =3D raw_clone(&args, size);
+=09if (pid < 0) {
+=09=09ksft_print_msg("%s - Failed to create new process\n",
+=09=09=09=09strerror(errno));
+=09=09return -errno;
+=09}
+
+=09if (pid =3D=3D 0) {
+=09=09ksft_print_msg("I am the child, my PID is %d\n", getpid());
+=09=09_exit(EXIT_SUCCESS);
+=09}
+
+=09ppid =3D getpid();
+=09ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
+=09=09=09ppid, pid);
+
+=09(void)wait(&status);
+=09if (WEXITSTATUS(status))
+=09=09return WEXITSTATUS(status);
+
+=09return 0;
+}
+
+static void test_clone3(uint64_t flags, size_t size, int expected,
+=09=09       enum test_mode test_mode)
+{
+=09int ret;
+
+=09ksft_print_msg(
+=09=09"[%d] Trying clone3() with flags %#" PRIx64 " (size %zu)\n",
+=09=09getpid(), flags, size);
+=09ret =3D call_clone3(flags, size, test_mode);
+=09ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
+=09=09=09getpid(), ret, expected);
+=09if (ret !=3D expected)
+=09=09ksft_test_result_fail(
+=09=09=09"[%d] Result (%d) is different than expected (%d)\n",
+=09=09=09getpid(), ret, expected);
+=09else
+=09=09ksft_test_result_pass(
+=09=09=09"[%d] Result (%d) matches expectation (%d)\n",
+=09=09=09getpid(), ret, expected);
+}
+int main(int argc, char *argv[])
+{
+=09pid_t pid;
+
+=09ksft_print_header();
+=09ksft_set_plan(17);
+
+=09/* Just a simple clone3() should return 0.*/
+=09test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() in a new PID NS.*/
+=09test_clone3(CLONE_NEWPID, 0, 0, CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() with CLONE3_ARGS_SIZE_V0. */
+=09test_clone3(0, CLONE3_ARGS_SIZE_V0, 0, CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() with CLONE3_ARGS_SIZE_V0 - 8 */
+=09test_clone3(0, CLONE3_ARGS_SIZE_V0 - 8, -EINVAL, CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() with sizeof(struct clone_args) + 8 */
+=09test_clone3(0, sizeof(struct clone_args) + 8, 0, CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() with all members set to 1 */
+=09test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL, CLONE3_ARGS_ALL_1);
+=09/* Do a clone3() with exit_signal having highest 32 bits non-zero */
+=09test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+=09=09=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG);
+=09/* Do a clone3() with negative 32-bit exit_signal */
+=09test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+=09=09=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG);
+=09/* Do a clone3() with exit_signal not fitting into CSIGNAL mask */
+=09test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+=09=09=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG);
+=09/* Do a clone3() with NSIG < exit_signal < CSIG */
+=09test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+=09=09=09CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG);
+=09/*
+=09 * Do a clone3() with sizeof(struct clone_args) + 8
+=09 * and all members set to 0.
+=09 */
+=09test_clone3(0, sizeof(struct clone_args) + 8, 0, CLONE3_ARGS_ALL_0);
+=09/*
+=09 * Do a clone3() with sizeof(struct clone_args) + 8
+=09 * and all members set to 0.
+=09 */
+=09test_clone3(0, sizeof(struct clone_args) + 8, -EINVAL,
+=09=09=09=09CLONE3_ARGS_ALL_1);
+=09/* Do a clone3() with > page size */
+=09test_clone3(0, getpagesize() + 8, -E2BIG, CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() with CLONE3_ARGS_SIZE_V0 in a new PID NS. */
+=09test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0, 0, CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() with CLONE3_ARGS_SIZE_V0 - 8 in a new PID NS */
+=09test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0 - 8, -EINVAL,
+=09=09=09=09CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() with sizeof(struct clone_args) + 8 in a new PID NS */
+=09test_clone3(CLONE_NEWPID, sizeof(struct clone_args) + 8, 0,
+=09=09=09=09CLONE3_ARGS_NO_TEST);
+=09/* Do a clone3() with > page size in a new PID NS */
+=09test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
+=09=09=09=09CLONE3_ARGS_NO_TEST);
+
+=09return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
+}
--=20
2.23.0

