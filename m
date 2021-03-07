Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70C433004E
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCGLcs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 06:32:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:37789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhCGLcU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 06:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615116696;
        bh=jt/X9cLhN7PaSOxGeYmAIHl/YTR5+wDbsz099pbQ9nk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dEQ8D6wgA/5zqmk+kovy0tmdOj/Aak6CQmhz2gBoHY2c9k+zAKAZe6Fhjizm/QC3f
         nUhpeTwspm870wTfwHshIQ3BXsLFzmFE3RHjODUPcgDfP1rgUP9OxlsBJxbVwnEdMk
         dKt9C4AnA1tBCkzphC7SL0086Ke4MVQb11AucOY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MysVs-1lfKQX3rbW-00w0j8; Sun, 07 Mar 2021 12:31:36 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v6 0/8] Fork brute force attack mitigation
Date:   Sun,  7 Mar 2021 12:30:23 +0100
Message-Id: <20210307113031.11671-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYB4VfZjO1qGcIfXFiipYg7Vx2luA6qiLAE4meb296nXyztakPa
 X6XAjMFHlXzR0rJdhWYSrN80VMMmz1sdsxBqmz0PrYLx5HjGw6i0PruMZDl/ZoNMSS8XOD0
 Go8W/rew9DfVdvUEgwGTHZzEqSHBBLcT1QM2DdmqK05wuYpQ/O6tXMZxgiVBZqT6a1/FDxV
 Opq5QbLF+E5QNj+c3BZgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qXWIMn8oDdk=:qYgpdZolU+UaDDDWs/aUKb
 +2zXmrISwk9kWDlK5eiNp5CHfbsqVKaJpnszeWBppvNIK5YWEvYF4juu0obb/IJiaIU/yY61O
 Ac8BEJW8Hf2XBOgeP8VjM4hkoRTcCG9aTqANsU0F10/NE4O2S5k9mSgITopNmHnZVTWvzvIYr
 yUVGzvhMIwKs4455QGYvWBEDV6m/dFeocs8c/O9QnQt2bb9WuTObSZS93uI4lO+rKSfP/t6FN
 0CuZJCdlx3JsrcD1lfQZoIgGennr2HBAHkE89/krLron8wm8oTPs+bvlFZhTvYqV5Obo34Trs
 yb7iJX+1W1mLYr1DJq2870hiRfda4xDdkbpFwMJam6ue3EeM5w4ZWYFN3zrOxne6sm0BwQC21
 0VT0m241C4GofhLkp2WGt3RU6pvdAEAEi+qanqyU2DaGKlRuc9RCnmOY3yIrLe85lqLJ+yXdl
 +0Zgc3fKikc6+CUZoAQFB9hDRJAJKwVS095jjrug3Wp/Rfr62pELhXm3W97vw5YmJ6iXrON0s
 g3h91/+1dzXS5Lww0E+phPFn/mCpA7y1J45awrGQpRZ7CE+7CsG770E+EDkHaxyqAIaM0slxn
 E2lrGwQ3WhRFMJRy2JkC2o7vUSIfvea5OXjKzS+l6ty6oNHPmSiAp7hRKMYfzmxW9d/GgAvGz
 59UVqxUy1HuxibyALGWL8mKr3rRE3ixc86lxcsqKc+ObMkr1pSZ9RLYgvNESnBZYXt82Ctl1y
 nsZNfphjOUjgAuwcdn7l5/PHNw/xpICFbrEKmJUPp4u9hReRPByLsmbGeDhxYPBV4tAOWRt4D
 JDohyRxdcXhMklHLsSQYVsVjOMSEOKDWGIBdAM1u5Wz4IKQz+/p6GInCAcYd0kfWFcJe2vzUq
 4WfxbYeD6LC3AyGw2UPA==
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

Knowing all this information I will explain now the different patches:

The 1/8 patch defines a new LSM hook to get the fatal signal of a task.
This will be useful during the attack detection phase.

The 2/8 patch defines a new LSM and manages the statistical data shared by
all the fork hierarchy processes.

The 3/8 patch detects a fork/exec brute force attack.

The 4/8 patch narrows the detection taken into account the privilege
boundary crossing.

The 5/8 patch mitigates a brute force attack.

The 6/8 patch adds self-tests to validate the Brute LSM expectations.

The 7/8 patch adds the documentation to explain this implementation.

The 8/8 patch updates the maintainers file.

This patch serie is a task of the KSPP [1] and can also be accessed from m=
y
github tree [2] in the "brute_v6" branch.

[1] https://github.com/KSPP/linux/issues/39
[2] https://github.com/johwood/linux/

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

Any constructive comments are welcome.
Thanks.

John Wood (8):
  security: Add LSM hook at the point where a task gets a fatal signal
  security/brute: Define a LSM and manage statistical data
  securtiy/brute: Detect a brute force attack
  security/brute: Fine tuning the attack detection
  security/brute: Mitigate a brute force attack
  selftests/brute: Add tests for the Brute LSM
  Documentation: Add documentation for the Brute LSM
  MAINTAINERS: Add a new entry for the Brute LSM

 Documentation/admin-guide/LSM/Brute.rst  |  278 ++++++
 Documentation/admin-guide/LSM/index.rst  |    1 +
 MAINTAINERS                              |    7 +
 include/linux/lsm_hook_defs.h            |    1 +
 include/linux/lsm_hooks.h                |    4 +
 include/linux/security.h                 |    4 +
 kernel/signal.c                          |    1 +
 security/Kconfig                         |   11 +-
 security/Makefile                        |    4 +
 security/brute/Kconfig                   |   13 +
 security/brute/Makefile                  |    2 +
 security/brute/brute.c                   | 1107 ++++++++++++++++++++++
 security/security.c                      |    5 +
 tools/testing/selftests/Makefile         |    1 +
 tools/testing/selftests/brute/.gitignore |    2 +
 tools/testing/selftests/brute/Makefile   |    5 +
 tools/testing/selftests/brute/config     |    1 +
 tools/testing/selftests/brute/exec.c     |   44 +
 tools/testing/selftests/brute/test.c     |  507 ++++++++++
 tools/testing/selftests/brute/test.sh    |  226 +++++
 20 files changed, 2219 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/Brute.rst
 create mode 100644 security/brute/Kconfig
 create mode 100644 security/brute/Makefile
 create mode 100644 security/brute/brute.c
 create mode 100644 tools/testing/selftests/brute/.gitignore
 create mode 100644 tools/testing/selftests/brute/Makefile
 create mode 100644 tools/testing/selftests/brute/config
 create mode 100644 tools/testing/selftests/brute/exec.c
 create mode 100644 tools/testing/selftests/brute/test.c
 create mode 100755 tools/testing/selftests/brute/test.sh

=2D-
2.25.1

