Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B577DE77B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 11:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfJUJM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 05:12:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUJM7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 05:12:59 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iMTkH-00074w-D8; Mon, 21 Oct 2019 09:12:57 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, keescook@chromium.org
Cc:     rong.a.chen@intel.com, ast@kernel.org,
        christian.brauner@ubuntu.com, daniel@iogearbox.net, kafai@fb.com,
        lkp@lists.01.org, luto@amacapital.net, shuah@kernel.org,
        songliubraving@fb.com, tycho@tycho.ws, tyhicks@canonical.com,
        wad@chromium.org, yhs@fb.com, linux-kselftest@vger.kernel.org
Subject: [PATCH] seccomp: fix SECCOMP_USER_NOTIF_FLAG_CONTINUE test
Date:   Mon, 21 Oct 2019 11:10:55 +0200
Message-Id: <20191021091055.4644-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021084157.GG9296@shao2-debian>
References: <20191021084157.GG9296@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 2519377ebda3..9669b81086cf 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -168,10 +168,6 @@ struct seccomp_metadata {
 
 #define SECCOMP_RET_USER_NOTIF 0x7fc00000U
 
-#ifndef SECCOMP_USER_NOTIF_FLAG_CONTINUE
-#define SECCOMP_USER_NOTIF_FLAG_CONTINUE 0x00000001
-#endif
-
 #define SECCOMP_IOC_MAGIC		'!'
 #define SECCOMP_IO(nr)			_IO(SECCOMP_IOC_MAGIC, nr)
 #define SECCOMP_IOR(nr, type)		_IOR(SECCOMP_IOC_MAGIC, nr, type)
@@ -205,6 +201,10 @@ struct seccomp_notif_sizes {
 };
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

