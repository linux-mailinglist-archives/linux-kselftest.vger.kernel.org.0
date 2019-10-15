Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAC46D7C7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbfJOQzs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 12:55:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388396AbfJOQzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 12:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571158545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evrRH/7Cb3iwj/sIsHfP6N1ujE5REFtpGbjAchThxEI=;
        b=SzzuXVsrs4TDHrhAiAl6as232C82xROUcHn4sREozbV2pJMSgA8gfVGmMmeLoN9fuVL4K3
        Uk9Suyw5HWnqXLJuxvWf6kT/2QBvBfalYYKnO08Dxu6Y8VAN4aTARwFChfI6/vzbDpX7+a
        iaVBMRQDkKoECrHV0qNCLTPhr83qElw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-Nq0nzZ_sN1eCEOH__FjEFg-1; Tue, 15 Oct 2019 12:55:44 -0400
Received: by mail-ed1-f71.google.com with SMTP id n12so12497860edr.22
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2019 09:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3qaIkOTipftLe8AfzJDidtHctRZS4qNtfpx4+nUFnk=;
        b=SGn9FG/rLRmpFT8yEHMF0yiuNZ4FdI2bwRBjIER6nKEJU05lH0ayWht95uERVILwg3
         eKF/Vq3dFrjzEywwhnk7R70y/XoYNSiNhMk0GXZ4IvwiI7dYIebo7fjS5GO1WQpK+4OZ
         zfLvkYgV+WM13yoiyoIeZMudy07H7jBBOPCB7F3/If1Wj36YKBu5VyqGHzN7Fa2AdAe1
         x7Wf/y8m/ByD71A8FFB1LLFLu3f23UB6ieSiVcYM/s3CySReprFmHB/wGLUesK5ogQCb
         UbjBMqKp724EuE2SMWcqhe2gAM1rdnslJ8jAKe6z6I0xf4iQ2q8WpYEDBPYGs6TuYuCA
         srBA==
X-Gm-Message-State: APjAAAU/FkC1Wysy+hDKflPtKh81b3aJa4RjEJgwEhQM1kTojnyLTM3a
        fh8rbpMZeAm/F7buzUe/f1ozwlonA+KB3NRg6LkF7mZeL9lkUNqDcnphMF3lIxN9Ps+mmaRrPo7
        qX6lvr9dHfZrCKU8Z/+tx9N8Qju6o
X-Received: by 2002:a17:906:3e50:: with SMTP id t16mr35467802eji.177.1571158542242;
        Tue, 15 Oct 2019 09:55:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTCro8ljeXP1eV4SBXZ3Qz/WE6zxPoADmqJRwNRA/SRr+pp8aHDbBUi11Ld6d8Spt8uDcHvA==
X-Received: by 2002:a17:906:3e50:: with SMTP id t16mr35467782eji.177.1571158541930;
        Tue, 15 Oct 2019 09:55:41 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id d24sm1568455edp.27.2019.10.15.09.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:55:41 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] pidfd: avoid linux/wait.h and sys/wait.h name clashes
Date:   Tue, 15 Oct 2019 18:55:30 +0200
Message-Id: <20191015165531.27469-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011163811.8607-1-ckellner@redhat.com>
References: <20191011163811.8607-1-ckellner@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Nq0nzZ_sN1eCEOH__FjEFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

Both linux/wait.h and sys/wait.h contain values for the first argument
of 'waitid' (P_ALL, P_PID, ...).  While the former uses defines the
latter uses an enum. When linux/wait.h is included before sys/wait.h
this will lead to an error, because P_ALL, P_PID, ... will already
have been substituted to 0, 1, ... respectively and this the resulting
code will be 'typedef enum {0, 1, ...'.
Remove 'linux/wait.h' and rename P_PIDFD to avoid a future clash, in
case P_PIDFD gets added to the idtype_t enum in sys/wait.h.

Signed-off-by: Christian Kellner <christian@kellner.me>
---
 tools/testing/selftests/pidfd/pidfd.h           |  4 ++--
 tools/testing/selftests/pidfd/pidfd_open_test.c |  1 -
 tools/testing/selftests/pidfd/pidfd_poll_test.c |  1 -
 tools/testing/selftests/pidfd/pidfd_wait.c      | 14 +++++++-------
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftest=
s/pidfd/pidfd.h
index c6bc68329f4b..9d5e76bd5466 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,8 +16,8 @@
=20
 #include "../kselftest.h"
=20
-#ifndef P_PIDFD
-#define P_PIDFD 3
+#ifndef __P_PIDFD
+#define __P_PIDFD 3
 #endif
=20
 #ifndef CLONE_PIDFD
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testin=
g/selftests/pidfd/pidfd_open_test.c
index b9fe75fc3e51..8a59438ccc78 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -6,7 +6,6 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testin=
g/selftests/pidfd/pidfd_poll_test.c
index 4b115444dfe9..610811275357 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <poll.h>
 #include <signal.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/sel=
ftests/pidfd/pidfd_wait.c
index 7079f8eef792..7e9170b84b81 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -54,7 +54,7 @@ static int test_pidfd_wait_simple(void)
 =09=09ksft_exit_fail_msg("%s test: failed to open /proc/self %s\n",
 =09=09=09=09   test_name, strerror(errno));
=20
-=09pid =3D sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+=09pid =3D sys_waitid(__P_PIDFD, pidfd, &info, WEXITED, NULL);
 =09if (pid =3D=3D 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: succeeded to wait on invalid pidfd %s\n",
@@ -67,7 +67,7 @@ static int test_pidfd_wait_simple(void)
 =09=09ksft_exit_fail_msg("%s test: failed to open /dev/null %s\n",
 =09=09=09=09   test_name, strerror(errno));
=20
-=09pid =3D sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+=09pid =3D sys_waitid(__P_PIDFD, pidfd, &info, WEXITED, NULL);
 =09if (pid =3D=3D 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: succeeded to wait on invalid pidfd %s\n",
@@ -83,7 +83,7 @@ static int test_pidfd_wait_simple(void)
 =09if (pid =3D=3D 0)
 =09=09exit(EXIT_SUCCESS);
=20
-=09pid =3D sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+=09pid =3D sys_waitid(__P_PIDFD, pidfd, &info, WEXITED, NULL);
 =09if (pid < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait on process with pid %d and pidfd %d: %s\=
n",
@@ -145,7 +145,7 @@ static int test_pidfd_wait_states(void)
 =09=09exit(EXIT_SUCCESS);
 =09}
=20
-=09ret =3D sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL);
+=09ret =3D sys_waitid(__P_PIDFD, pidfd, &info, WSTOPPED, NULL);
 =09if (ret < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait on WSTOPPED process with pid %d and pidf=
d %d: %s\n",
@@ -175,7 +175,7 @@ static int test_pidfd_wait_states(void)
 =09=09=09"%s test: failed to send signal to process with pid %d and pidfd =
%d: %s\n",
 =09=09=09test_name, parent_tid, pidfd, strerror(errno));
=20
-=09ret =3D sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL);
+=09ret =3D sys_waitid(__P_PIDFD, pidfd, &info, WCONTINUED, NULL);
 =09if (ret < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait WCONTINUED on process with pid %d and pi=
dfd %d: %s\n",
@@ -199,7 +199,7 @@ static int test_pidfd_wait_states(void)
 =09=09=09test_name, info.si_pid, parent_tid, pidfd,
 =09=09=09strerror(errno));
=20
-=09ret =3D sys_waitid(P_PIDFD, pidfd, &info, WUNTRACED, NULL);
+=09ret =3D sys_waitid(__P_PIDFD, pidfd, &info, WUNTRACED, NULL);
 =09if (ret < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait on WUNTRACED process with pid %d and pid=
fd %d: %s\n",
@@ -229,7 +229,7 @@ static int test_pidfd_wait_states(void)
 =09=09=09"%s test: failed to send SIGKILL to process with pid %d and pidfd=
 %d: %s\n",
 =09=09=09test_name, parent_tid, pidfd, strerror(errno));
=20
-=09ret =3D sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+=09ret =3D sys_waitid(__P_PIDFD, pidfd, &info, WEXITED, NULL);
 =09if (ret < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait on WEXITED process with pid %d and pidfd=
 %d: %s\n",
--=20
2.21.0

