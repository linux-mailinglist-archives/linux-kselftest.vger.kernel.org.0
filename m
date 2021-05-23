Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C064D38D975
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 May 2021 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhEWHdu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 May 2021 03:33:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:38567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhEWHdt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 May 2021 03:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621755103;
        bh=eEvoPzUKKDAusOW/Ow5cN9nihfVkpEkN3+SSzfVyau8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fr0kMU3bS6ef5nnDzpiT0rstMl+QpTk2+TtBd6y88VSE5l9W3HsMT3U6GAfWjffqt
         csFav+a61W7cwHnlFPsoZhGb3jm2EoziowalkrMPJWtLU7xfE9+X1j/6NzV6c+BDTs
         r+woH8jhH76x5WffFCv7rGxN1htplw31oOoc0N/8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.228.41]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17UQ-1lHowO2j5G-012U34; Sun, 23
 May 2021 09:31:42 +0200
Date:   Sun, 23 May 2021 09:31:24 +0200
From:   John Wood <john.wood@gmx.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v7 0/7] Fork brute force attack mitigation
Message-ID: <20210523073124.GA3762@ubuntu>
References: <20210521172414.69456-1-john.wood@gmx.com>
 <19903478-52e0-3829-0515-3e17669108f7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19903478-52e0-3829-0515-3e17669108f7@linux.intel.com>
X-Provags-ID: V03:K1:xGdrTJqW5jUbvCt0cYnj0WGdWQuK8aFsEq+/1qXjQEjk7ZcUNh8
 TbuhgQTiujT/xJvMJxMz3yYR2sLH9oGSRba9o+xI8QCMQKvuJAHYL9yTETwmZgWXH/JkTNG
 hEIudoiLn0Lt3KbW5k5uK5AzLmA+iWqsXTL7OOSAXSDFdwSsqMoY8j+AZobhiV+PbJzDesq
 GxpEOICGeaE/vptwz4WTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kN+bt8ib7gc=:kYckXckHhMmCyO9KUeoHdW
 BoAuQhF52m+KarZtNWH9fHRyuCGiXqzThx928TdrIReC2EGJj2kPxk97ZIIA2lTLHCVfKD8zO
 dKiU5bR6hFRveU1DS6VZXcR+nd/lZNNLNs/kbF8Qr2VfWzHPY6dU7upzSA7O5AJHj4fCmE9Of
 vUBDzOX/aA0sNtSnpHoAm30fM3OwXkHDIys50t6whkhVFIQBPm28yRky2rx2uswocQGlHVk26
 wadk50rgGwsSTBkAITdEC2Azr+Md+PQ8zAElqhgYgpHWVhSp1bjjWrGz2ofHEu4VBrfsWpwiu
 wnwGSZN/4pi1PHVa9B/0A8vAEHbqWJ5u0yE6wiHnPbB6Q/6TYTwx44esHiXmqKpw7o+u0KCQd
 /JZblqD503AkdBd6oAvEVr6Acpl1G8X0gn3cSOAkTvllNmSC44j1BRGJiQrroPVs4LHdP3BUS
 fJ57fN7UMMif2SK+gUvLwsvrVzXeZf2loEr1TQLTbPqjrVo1jMdJ6STK6yz7I05YWkBc/+rq1
 0TmXNkScd63fyDIqFR3L69vfHNWWtM/5MhELHeYtTQ7h1bz8wu+c+CtTLuuCgw8zyuF5LXm/O
 otC8YH2RhWkcuj4KGm6mPDK6Iwk+ehPLQUcpU+/Gwdj2C71OTt3TGAHdqborFEef9zWzDpoJn
 8l4edbpC1YQHnDxHdUdsdMkgjj3xqOjY/DAa/HO2k33IlYhIHewX5LFP9ELRvPKIghDA7TMJD
 MRDAbgiToviG1fDHfiYOr8haCPybGDoBIv6JNL+mrOHwzX4NddruvRZL/HsTsRhR5eySg/BFb
 BUrGXoYkCuy2S7YypaZCoZWgt2xtkLXXYqxxgBO3Xow8fvi2MnBrV24wTO2NB2ijR9eZ8ROzk
 joqx/yr6mYL8gSFnbrFUJsyU91XtM/Ozjg9/QGP8Gl2+VxpcpOM7Z/pjmj63alq6BxxGM3OUA
 tSXsc1HEYM4/fnNMS1qBmsiYFWuxDiaMKa9zOtUoF6CROA+uJp4IKnOUvrQJkT8bgG7HGHKG8
 ScjFy9pXNlGr7W1jk9C+G6icYpjLONlWOrn4BxDFYbwSbq+vR73ihJGvC3y8/UTpLrBm9K/+s
 7tWS0rJbZjenCgdxQ5yE6jkGMKgaV1xe9uEtCVa0WH7qeFWianANWX1O3u+9es7m5xB6zTdmw
 xeIiZLa1hz9E6kQAkLXxbhkALy1yAdgH5/irv0kKNqWDVhtcbpLji/0beSHHgZpcje/AQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Fri, May 21, 2021 at 11:02:14AM -0700, Andi Kleen wrote:
>
> > Moreover, I think this solves another problem pointed out by Andi Klee=
n
> > during the v5 review [2] related to the possibility that a supervisor
> > respawns processes killed by the Brute LSM. He suggested adding some w=
ay so
> > a supervisor can know that a process has been killed by Brute and then
> > decide to respawn or not. So, now, the supervisor can read the brute x=
attr
> > of one executable and know if it is blocked by Brute and why (using th=
e
> > statistical data).
>
> It looks better now, Thank.
>
> One potential problem is that the supervisor might see the executable
> directly, but run it through some wrapper. In fact I suspect that will b=
e
> fairly common with complex daemons. So it couldn't directly look at the
> xattr. Might be useful to also pass this information through the wait*
> chain, so that the supervisor can directly collect it. That would need s=
ome
> extension to these system calls.
>
Could something like this help? (not tested)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_comp=
at.c
index 0e5d0a7e203b..409c9c4c40c0 100644
=2D-- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -30,7 +30,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGSEGV !=3D 9);
 	BUILD_BUG_ON(NSIGBUS  !=3D 5);
 	BUILD_BUG_ON(NSIGTRAP !=3D 6);
-	BUILD_BUG_ON(NSIGCHLD !=3D 6);
+	BUILD_BUG_ON(NSIGCHLD !=3D 7);
 	BUILD_BUG_ON(NSIGSYS  !=3D 2);

 	/* This is part of the ABI and can never change in size: */
diff --git a/include/brute/brute.h b/include/brute/brute.h
new file mode 100644
index 000000000000..1569bd495f94
=2D-- /dev/null
+++ b/include/brute/brute.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BRUTE_H_
+#define _BRUTE_H_
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_SECURITY_FORK_BRUTE
+bool brute_task_killed(struct task_struct *task);
+#else
+static inline bool brute_task_killed(struct task_struct *task) { return f=
alse; }
+#endif
+
+#endif /* _BRUTE_H_ */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic=
/siginfo.h
index 03d6f6d2c1fe..488abfdc7b0d 100644
=2D-- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -273,7 +273,8 @@ typedef struct siginfo {
 #define CLD_TRAPPED	4	/* traced child has trapped */
 #define CLD_STOPPED	5	/* child has stopped */
 #define CLD_CONTINUED	6	/* stopped child has continued */
-#define NSIGCHLD	6
+#define CLD_BRUTE	7	/* child was killed by brute LSM */
+#define NSIGCHLD	7

 /*
  * SIGPOLL (or any other signal without signal specific si_codes) si_code=
s
diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..69bcbd00d277 100644
=2D-- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -69,6 +69,8 @@
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>

+#include <brute/brute.h>
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
@@ -1001,6 +1003,7 @@ static int wait_task_zombie(struct wait_opts *wo, st=
ruct task_struct *p)
 	pid_t pid =3D task_pid_vnr(p);
 	uid_t uid =3D from_kuid_munged(current_user_ns(), task_uid(p));
 	struct waitid_info *infop;
+	bool killed_by_brute =3D brute_task_killed(p);

 	if (!likely(wo->wo_flags & WEXITED))
 		return 0;
@@ -1114,7 +1117,8 @@ static int wait_task_zombie(struct wait_opts *wo, st=
ruct task_struct *p)
 			infop->cause =3D CLD_EXITED;
 			infop->status =3D status >> 8;
 		} else {
-			infop->cause =3D (status & 0x80) ? CLD_DUMPED : CLD_KILLED;
+			infop->cause =3D (status & 0x80) ? CLD_DUMPED :
+				killed_by_brute ? CLD_BRUTE : CLD_KILLED;
 			infop->status =3D status & 0x7f;
 		}
 		infop->pid =3D pid;
diff --git a/kernel/signal.c b/kernel/signal.c
index 62625ad98b14..f6c062b19563 100644
=2D-- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -55,6 +55,8 @@
 #include <asm/siginfo.h>
 #include <asm/cacheflush.h>

+#include <brute/brute.h>
+
 /*
  * SLAB caches for signal bits.
  */
@@ -1996,7 +1998,7 @@ bool do_notify_parent(struct task_struct *tsk, int s=
ig)
 	if (tsk->exit_code & 0x80)
 		info.si_code =3D CLD_DUMPED;
 	else if (tsk->exit_code & 0x7f)
-		info.si_code =3D CLD_KILLED;
+		info.si_code =3D brute_task_killed(tsk) ? CLD_BRUTE : CLD_KILLED;
 	else {
 		info.si_code =3D CLD_EXITED;
 		info.si_status =3D tsk->exit_code >> 8;

Thanks,
John Wood
