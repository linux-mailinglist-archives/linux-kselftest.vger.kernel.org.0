Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB66326D81
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Feb 2021 16:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhB0PMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Feb 2021 10:12:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:53947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhB0PM3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Feb 2021 10:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614438619;
        bh=e+NzEQ0zUqFHpSiO6bYhm/QEn9aj/OszjJyG6A3hpJo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Dk5GBllLvbfhkEUcK/ofWBH8eKcQ3rBr9gKQqSyih1p5DUMl4KveCghi0qbvOfyV9
         2lAWq6ET3V6jP+RlQEi6iJJCx80sYdMrb3NGfutO0W/g4xBv0quM/F79qh+p+w2zbD
         F8vBpgmgksK8EcZF7bZvTy6QZ8TPP+NjdZXgJXxo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MvK4Z-1m79x40AyH-00rFK1; Sat, 27 Feb 2021 16:10:19 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v4 0/8] Fork brute force attack mitigation
Date:   Sat, 27 Feb 2021 16:09:48 +0100
Message-Id: <20210227150956.6022-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JUDWVnh+062iEY4yBjLXziakNvl1rxXf20M4ttvZZLbM8Fh8LzW
 7Z1lgLNMD2zhexjJUex72ZQDux/N6pbSie9AHjJ6fFjLrgKVDGuK79Ym/Bgebxq0HFWW54x
 /MzwRP/2sndoF4DJz9GWplztRp+uxp2U7N47EzXMjYbuYo4QFiQFX/GnBDVhae4EJHf8Q64
 iFT5IusG50HN+0pOsQBxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M2qAs66kCN0=:6UREdrllMK1XmD2NwllGwg
 n4GTD9SFTibaAH47paVJ/BPBydQasPzXcdNg1ciyy/E1Z9N0gsfQ17WYsK5gk668XR5FuPmyK
 kt9HWgIK9zZTRkwGj0Y2lPxiu/4KRHS8VuJgLbFrl86eNKeaozvIkV+NGRsKVYQSpHH/1PJx+
 gF8k8VtDb7yslEvbvSP/wIjNS3LvzyGUswLAFCQC/fLsg7TX62R5u9BoBSI9cWHZefp9JOglS
 ICV5BMm+QQR4tCcIwR/dpyCza7EET4VqkgDBMlL26syVd3fbhjg+ZYyjAtSxQdUIgkEAjHUXY
 mv6JyC1pZmD+uXKriRm5OinDc1oTk0Npg4v1jsyAa+4EcZwiRMQxm8w9rEYCTqg1JMwi7gvgT
 lVt5Femwg/hFr/8AIQaT3+COmecsHukN0xuQbJOT5Nhdl6rm6bpVDlwHmh8qVqsYJvwYidNZO
 fp3Tg/7xlfxTi3vgmOGC6wwss6PQovkbfrOuZ1voOYQ468syHKCVMXD4CUsA7Nv72K3jsFCCM
 jALkNWWSpWmUem7cVdltcU7pmFE4MrEInPWlavmuf4T+eJuiefZ5N34Prdw5x2DO+mbI5BGBr
 V9tGHrOzUQdnxlGI32EwUSckfmiXxLwHWIL0SHDCamqAbT9kkrOJGIcB0L1Bx4LgyBKuO5rxV
 VeKKmh3cUp9iAbuyWt8gOygV1nw2YrmWaTH2CHQMVeRS1ug9FRHLPwlQvmANKGzmEQ+X+YV8K
 EqHgXhuYRKxn3BTNPAxnyvFK/M/dYZDCKRZ9lII9vJJC+Q04BYcGAGRGuFB3g+RbWFhf8DzVI
 5V8fOYL47VjJKfX3oFB41qlxXWlyJC53S8MIkejk3DR3+vl+OoKuvrQhhwSE9bxLb/AoLrQfV
 hn6IxJwmOPY5SH2PLOig==
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

This v4 version has changed a lot from the v2. Basically the application
crash period is now compute on an on-going basis using an exponential
moving average (EMA), a detection of a brute force attack through the
"execve" system call has been added and the crossing of the commented
privilege bounds are taken into account. Also, the fine tune has also been
removed and now, all this kind of attacks are detected without
administrator intervention.

In the v2 version Kees Cook suggested to study if the statistical data
shared by all the fork hierarchy processes can be tracked in some other
way. Specifically the question was if this info can be hold by the family
hierarchy of the mm struct. After studying this hierarchy I think it is no=
t
suitable for the Brute LSM since they are totally copied on fork() and in
this case we want that they are shared. So I leave this road.

So, knowing all this information I will explain now the different patches:

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
github tree [2] in the "brute_v4" branch.

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

 Documentation/admin-guide/LSM/Brute.rst  |  224 +++++
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
 security/brute/brute.c                   | 1102 ++++++++++++++++++++++
 security/security.c                      |    5 +
 tools/testing/selftests/Makefile         |    1 +
 tools/testing/selftests/brute/.gitignore |    2 +
 tools/testing/selftests/brute/Makefile   |    5 +
 tools/testing/selftests/brute/config     |    1 +
 tools/testing/selftests/brute/exec.c     |   44 +
 tools/testing/selftests/brute/test.c     |  507 ++++++++++
 tools/testing/selftests/brute/test.sh    |  226 +++++
 20 files changed, 2160 insertions(+), 5 deletions(-)
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

