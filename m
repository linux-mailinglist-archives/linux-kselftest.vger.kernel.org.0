Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD51138CC12
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 May 2021 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhEUR0m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 May 2021 13:26:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:38059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhEUR0m (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 May 2021 13:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621617872;
        bh=u+DjcBUSFrMBsPRclxwqs6ADRrff0+A/rQb8jJJEJSw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PV6PTX8RYvovA1ZVUXGtpujoNWgdjaCW+Klq46UytN6Zh/5HFSgXZnxn2naMF1vef
         f5peRB00TNj84Xlmk26Zo22mf1reCujFKfjVula5QXWRD9nexMvrDwUuYgNKrDl1qn
         /adeH0WKc+sRzgLcbZ00WzeY+dJ60K8ZpvzizoBI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mo6qp-1l7l8m3Dlz-00pbOV; Fri, 21 May 2021 19:24:31 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v7 0/7] Fork brute force attack mitigation
Date:   Fri, 21 May 2021 19:24:07 +0200
Message-Id: <20210521172414.69456-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mCfhzEf/UclKJ0ujI32wnnFHL89X6cU+ChoOGytmN6KJ0pdPWIZ
 xr+ecvHzj54L58p9VkKDQg+usxFokyLTfEmAQj3w6V3r0Bu3v7ZKHXGquwOee9ZiYiYluWC
 g8vfRRgeUv8kBM4a+W0d9V6oFANLrLv5iXK30aVtCSwWV3E5W+ZPQ5a80S9ufZQCu3PYGGY
 MUgeLU/DGiLsS3stdTMCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dncgkbGSxBI=:39+/+gs4b80Q+b7WxdJEU0
 zaxsFZjWbgM/ugl+3UzS499c40f6RUj6LaECXglW6J879ivgWkKeRP6OrJEXP61bxOaHmagBJ
 QWxkJdZFwmE99aLDtN7OU9n2jT8AGhKWSLWn/j+waCbo3ssNyE97/TDFDOQ3N++psyjmfK5RS
 bmbiGyys7pHTHVoCHev3Bxu098Mnp6d5WDON03NvF0tCm2na/zUrIUZkGZH/txJgeBgeG2eyX
 Knp6QFdLoSTNykZuk2AvDIXObhkpVh4RkIxQlHdh5q0pBQssXo3jl2KlpzaUbhbBCP46dfmyw
 Fbxp2MsKIfsNJAZ2ZSGavvG8yvbPeSX8JNTFyUF8jzSkfSZ/kUVvIDRrU5EWvktyxC7Zkzatv
 52dTG4VohxIeGT/5ZTtu3qe6FyYVMOwN+RYOe3WbQiLLzERVizsrosCaN9QOmF4mXZywl28HK
 uqCHcfmqHTF8raHngeS5BoaQZZL82BFlzRRc4pc6+z8UkWk5t8BTQloi2rEFvHeCGK/u3y3VS
 QMoPvKvZR/pc84P8BqSUbaEu1QLEBTIDFR0a7r8zcSyQ7n6ZkqeYVmfqiqtX4gzEvyS7BqXBI
 +b0JuzAuS6KSULnEAeaMQSNxXgXdQKvX0fBhdL7LUAksEQE4kM7T+PFO6bJeJ7LOcHhUqrN4H
 oyACzcXzVSX84/rBmgADqP6KwkAWee2hey06ffV72arNLqLtSvwLPW5XaZ8gX/z1kOL2P9Hue
 iQywQ61Mm0FQtk10BZtiwE4htwHMtFIahzSicbYJ2e1gjW8kGjXKOb0TZ6GAuf/Kb32AG0WV5
 kVNpUmcHmbiaEpa17RUJBlfISlR8wIIkhSsoCcM67k57W/pWVvmRKidJMZmwuTrTrhlmnNhNa
 alcpVXpe3fbj3RF5ZcxcJMg4kPEjgci9l0zgPn8LJxPK6qO5vf+EAE7bFbTM9OE/jKkUpny+I
 OkdIxTsAljphhTNpP6SLVyL3Ugm+sXTxKZ8lsPOG3Y7KDLFRmr0X/V/9g/sMrU1078HDc5OSv
 aTTgHO7Gs9MphimTLI1ie1VK7cE4tO7CC6NcKeU4yUrIdtFP3rG8K728XeegdMkSq3fT51I25
 QKcXz2Kotzdvd1yYCPJbwBbzNkijfEHYGE4
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Attacks against vulnerable userspace applications with the purpose to brea=
k
ASLR or bypass canaries traditionally use some level of brute force with
the help of the fork system call. This is possible since when creating a
new process using fork its memory contents are the same as those of the
parent process (the process that called the fork system call). So, the
attacker can test the memory infinite times to find the correct memory
values or the correct memory addresses without worrying about crashing the
application.

Based on the above scenario it would be nice to have this detected and
mitigated, and this is the goal of this patch serie. Specifically the
following attacks are expected to be detected:

1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until a
    desirable memory layout is got (e.g. Stack Clash).
2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly
    until a desirable memory layout is got (e.g. what CTFs do for simple
    network service).
3.- Launching processes without exec() (e.g. Android Zygote) and exposing
    state to attack a sibling.
4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly unti=
l
    the previously shared memory layout of all the other children is
    exposed (e.g. kind of related to HeartBleed).

In each case, a privilege boundary has been crossed:

Case 1: setuid/setgid process
Case 2: network to local
Case 3: privilege changes
Case 4: network to local

So, what will really be detected are fork/exec brute force attacks that
cross any of the commented bounds.

The implementation details and comparison against other existing
implementations can be found in the "Documentation" patch.

It is important to mention that this version has changed the method used t=
o
track the information related to the application crashes. Prior this
version, a pointer per process (in the task_struct structure) held a
reference to the shared statistical data. Or in other words, these stats
were shared by all the fork hierarchy processes. But this has an important
drawback: a brute force attack that happens through the execve system call
losts the faults info since these statistics are freed when the fork
hierarchy disappears. So, the solution adopted in the v6 version was to us=
e
an upper fork hierarchy to track the info for this attack type. But, as
Valdis Kletnieks pointed out during this discussion [1], this method can
be easily bypassed using a double exec (well, this was the method used in
the kselftest to avoid the detection ;) ). So, in this version, to track
all the statistical data (info related with application crashes), the
extended attributes feature for the executable files are used. The xattr i=
s
also used to mark the executables as "not allowed" when an attack is
detected. Then, the execve system call rely on this flag to avoid followin=
g
executions of this file.

[1] https://lore.kernel.org/kernelnewbies/20210330173459.GA3163@ubuntu/

Moreover, I think this solves another problem pointed out by Andi Kleen
during the v5 review [2] related to the possibility that a supervisor
respawns processes killed by the Brute LSM. He suggested adding some way s=
o
a supervisor can know that a process has been killed by Brute and then
decide to respawn or not. So, now, the supervisor can read the brute xattr
of one executable and know if it is blocked by Brute and why (using the
statistical data).

[2] https://lore.kernel.org/kernel-hardening/878s78dnrm.fsf@linux.intel.co=
m/

Knowing all this information I will explain now the different patches:

The 1/7 patch defines a new LSM hook to get the fatal signal of a task.
This will be useful during the attack detection phase.

The 2/7 patch defines a new LSM and the necessary sysctl attributes to fin=
e
tuning the attack detection.

The 3/7 patch detects a fork/exec brute force attack and narrows the
possible cases taken into account the privilege boundary crossing.

The 4/7 patch mitigates a brute force attack.

The 5/7 patch adds self-tests to validate the Brute LSM expectations.

The 6/7 patch adds the documentation to explain this implementation.

The 7/7 patch updates the maintainers file.

This patch serie is a task of the KSPP [3] and can also be accessed from m=
y
github tree [4] in the "brute_v7" branch.

[3] https://github.com/KSPP/linux/issues/39
[4] https://github.com/johwood/linux/

When I ran the "checkpatch" script I got the following errors, but I think
they are false positives as I follow the same coding style for the others
extended attributes suffixes.

=2D-----------------------------------------------------------------------=
----
../patches/brute_v7/v7-0003-security-brute-Detect-a-brute-force-attack.pat=
ch
=2D-----------------------------------------------------------------------=
----
ERROR: Macros with complex values should be enclosed in parentheses
89: FILE: include/uapi/linux/xattr.h:80:
+#define XATTR_NAME_BRUTE XATTR_SECURITY_PREFIX XATTR_BRUTE_SUFFIX

=2D-----------------------------------------------------------------------=
-----
../patches/brute_v7/v7-0005-selftests-brute-Add-tests-for-the-Brute-LSM.pa=
tch
=2D-----------------------------------------------------------------------=
-----
ERROR: Macros with complex values should be enclosed in parentheses
100: FILE: tools/testing/selftests/brute/rmxattr.c:18:
+#define XATTR_NAME_BRUTE XATTR_SECURITY_PREFIX XATTR_BRUTE_SUFFIX

When I ran the "kernel-doc" script with the following parameters:

./scripts/kernel-doc --none -v security/brute/brute.c

I got the following warning:

security/brute/brute.c:65: warning: contents before sections

But I don't understand why it is complaining. Could it be a false positive=
?

The previous versions can be found in:

RFC
https://lore.kernel.org/kernel-hardening/20200910202107.3799376-1-keescook=
@chromium.org/

Version 2
https://lore.kernel.org/kernel-hardening/20201025134540.3770-1-john.wood@g=
mx.com/

Version 3
https://lore.kernel.org/lkml/20210221154919.68050-1-john.wood@gmx.com/

Version 4
https://lore.kernel.org/lkml/20210227150956.6022-1-john.wood@gmx.com/

Version 5
https://lore.kernel.org/kernel-hardening/20210227153013.6747-1-john.wood@g=
mx.com/

Version 6
https://lore.kernel.org/kernel-hardening/20210307113031.11671-1-john.wood@=
gmx.com/

Changelog RFC -> v2
=2D------------------
- Rename this feature with a more suitable name (Jann Horn, Kees Cook).
- Convert the code to an LSM (Kees Cook).
- Add locking  to avoid data races (Jann Horn).
- Add a new LSM hook to get the fatal signal of a task (Jann Horn, Kees
  Cook).
- Add the last crashes timestamps list to avoid false positives in the
  attack detection (Jann Horn).
- Use "period" instead of "rate" (Jann Horn).
- Other minor changes suggested (Jann Horn, Kees Cook).

Changelog v2 -> v3
=2D-----------------
- Compute the application crash period on an on-going basis (Kees Cook).
- Detect a brute force attack through the execve system call (Kees Cook).
- Detect an slow brute force attack (Randy Dunlap).
- Fine tuning the detection taken into account privilege boundary crossing
  (Kees Cook).
- Taken into account only fatal signals delivered by the kernel (Kees
  Cook).
- Remove the sysctl attributes to fine tuning the detection (Kees Cook).
- Remove the prctls to allow per process enabling/disabling (Kees Cook).
- Improve the documentation (Kees Cook).
- Fix some typos in the documentation (Randy Dunlap).
- Add self-test to validate the expectations (Kees Cook).

Changelog v3 -> v4
=2D-----------------
- Fix all the warnings shown by the tool "scripts/kernel-doc" (Randy
  Dunlap).

Changelog v4 -> v5
=2D-----------------
- Fix some typos (Randy Dunlap).

Changelog v5 -> v6
=2D-----------------
- Fix a reported deadlock (kernel test robot).
- Add high level details to the documentation (Andi Kleen).

Changelog v6 -> v7
=2D-----------------

- Add the "Reviewed-by:" tag to the first patch.
- Rearrange the brute LSM between lockdown and yama (Kees Cook).
- Split subdir and obj in security/Makefile (Kees Cook).
- Reduce the number of header files included (Kees Cook).
- Print the pid when an attack is detected (Kees Cook).
- Use the socket_accept LSM hook instead of socket_sock_rcv_skb hook to
  avoid running a hook on every incoming network packet (Kees Cook).
- Update the documentation and fix it to render it properly (Jonathan
  Corbet).
- Manage correctly an exec brute force attack avoiding the bypass (Valdis
  Kletnieks).
- Other minor changes and cleanups.

Any constructive comments are welcome.
Thanks in advance.

John Wood (7):
  security: Add LSM hook at the point where a task gets a fatal signal
  security/brute: Define a LSM and add sysctl attributes
  security/brute: Detect a brute force attack
  security/brute: Mitigate a brute force attack
  selftests/brute: Add tests for the Brute LSM
  Documentation: Add documentation for the Brute LSM
  MAINTAINERS: Add a new entry for the Brute LSM

 Documentation/admin-guide/LSM/Brute.rst  | 334 +++++++++++
 Documentation/admin-guide/LSM/index.rst  |   1 +
 MAINTAINERS                              |   7 +
 include/linux/lsm_hook_defs.h            |   1 +
 include/linux/lsm_hooks.h                |   4 +
 include/linux/security.h                 |   4 +
 include/uapi/linux/xattr.h               |   3 +
 kernel/signal.c                          |   1 +
 security/Kconfig                         |  11 +-
 security/Makefile                        |   2 +
 security/brute/Kconfig                   |  15 +
 security/brute/Makefile                  |   2 +
 security/brute/brute.c                   | 716 +++++++++++++++++++++++
 security/security.c                      |   5 +
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/brute/.gitignore |   2 +
 tools/testing/selftests/brute/Makefile   |   5 +
 tools/testing/selftests/brute/config     |   1 +
 tools/testing/selftests/brute/rmxattr.c  |  34 ++
 tools/testing/selftests/brute/test.c     | 507 ++++++++++++++++
 tools/testing/selftests/brute/test.sh    | 256 ++++++++
 21 files changed, 1907 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/Brute.rst
 create mode 100644 security/brute/Kconfig
 create mode 100644 security/brute/Makefile
 create mode 100644 security/brute/brute.c
 create mode 100644 tools/testing/selftests/brute/.gitignore
 create mode 100644 tools/testing/selftests/brute/Makefile
 create mode 100644 tools/testing/selftests/brute/config
 create mode 100644 tools/testing/selftests/brute/rmxattr.c
 create mode 100644 tools/testing/selftests/brute/test.c
 create mode 100755 tools/testing/selftests/brute/test.sh

=2D-
2.25.1

