Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28FCE00CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 11:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfJVJcQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 05:32:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33745 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVJcQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 05:32:16 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iMqWT-0004c2-Uv; Tue, 22 Oct 2019 09:32:14 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     kernel-team@lists.ubuntu.com
Cc:     stefan.bader@canonical.com, stgraber@ubuntu.com,
        seth.forshee@canonical.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kernel test robot <rong.a.chen@intel.com>,
        linux-kselftest@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 2/2][SRU][DISCO][EOAN] UBUNTU: SAUCE: seccomp: fix SECCOMP_USER_NOTIF_FLAG_CONTINUE test
Date:   Tue, 22 Oct 2019 11:32:10 +0200
Message-Id: <20191022093210.26663-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022093210.26663-1-christian.brauner@ubuntu.com>
References: <20191022093210.26663-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

BugLink: https://bugs.launchpad.net/bugs/1849281

The ifndef for SECCOMP_USER_NOTIF_FLAG_CONTINUE was placed under the
ifndef for the SECCOMP_FILTER_FLAG_NEW_LISTENER feature. This will not
work on systems that do support SECCOMP_FILTER_FLAG_NEW_LISTENER but do not
support SECCOMP_USER_NOTIF_FLAG_CONTINUE. So move the latter ifndef out of
the former ifndef's scope.

2019-10-20 11:14:01 make run_tests -C seccomp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-0eebfed2954f152259cae0ad57b91d3ea92968e8/tools/testing/selftests/seccomp'
gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
seccomp_bpf.c: In function ‘user_notification_continue’:
seccomp_bpf.c:3562:15: error: ‘SECCOMP_USER_NOTIF_FLAG_CONTINUE’ undeclared (first use in this function)
  resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
seccomp_bpf.c:3562:15: note: each undeclared identifier is reported only once for each function it appears in
Makefile:12: recipe for target 'seccomp_bpf' failed
make: *** [seccomp_bpf] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-0eebfed2954f152259cae0ad57b91d3ea92968e8/tools/testing/selftests/seccomp'

Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: 0eebfed2954f ("seccomp: test SECCOMP_USER_NOTIF_FLAG_CONTINUE")
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Link: https://lore.kernel.org/r/20191021091055.4644-1-christian.brauner@ubuntu.com
Signed-off-by: Kees Cook <keescook@chromium.org>
(cherry picked from commit 2aa8d8d04ca29c3269154e1d48855e498be8882f
 https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git)
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6021baecb386..bf834ee02b69 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -167,10 +167,6 @@ struct seccomp_metadata {
 
 #define SECCOMP_RET_USER_NOTIF 0x7fc00000U
 
-#ifndef SECCOMP_USER_NOTIF_FLAG_CONTINUE
-#define SECCOMP_USER_NOTIF_FLAG_CONTINUE 0x00000001
-#endif
-
 #define SECCOMP_IOC_MAGIC		'!'
 #define SECCOMP_IO(nr)			_IO(SECCOMP_IOC_MAGIC, nr)
 #define SECCOMP_IOR(nr, type)		_IOR(SECCOMP_IOC_MAGIC, nr, type)
@@ -209,6 +205,10 @@ struct seccomp_notif_sizes {
 #define PTRACE_EVENTMSG_SYSCALL_EXIT	2
 #endif
 
+#ifndef SECCOMP_USER_NOTIF_FLAG_CONTINUE
+#define SECCOMP_USER_NOTIF_FLAG_CONTINUE 0x00000001
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
-- 
2.23.0

