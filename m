Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDB5320B8F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Feb 2021 16:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhBUPwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Feb 2021 10:52:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:60717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUPwG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Feb 2021 10:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613922599;
        bh=Bbi8D9zimrBxrToyY2cmCuzduWBv7NSyYLuDnJH9sAo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=e2CQYgvDFsIWTTa+5nOrljkJjJ/IaUUr7dfBxKEewpRP273HL5xLU7zbBWXg9H/Kh
         CyWbeg7tkUMr0A/6COgWTvAGMpFtM/NSjdYAyrWQGb0XVhlpYX4Eccgvrjb04C/ROG
         hzGlZkAbFJCbKoBvq/Zby2HrDMCuW2HEaWURAudc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MQ5vc-1lR8go2wUq-00M85s; Sun, 21 Feb 2021 16:49:58 +0100
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
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/8] Fork brute force attack mitigation
Date:   Sun, 21 Feb 2021 16:49:11 +0100
Message-Id: <20210221154919.68050-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OhAf9XvO+sZYfuIy60MlI1jlL30B6+bmI4NFG9TAaaqwkmcMkdm
 S3GLYv+QOvuXyVkf27DRvsH+0L8iMQdmmtTYTm3YCB5QBxRXZ51pO08O9H7ag3UfDOgmhxs
 IKTQrbdPt1J6Ca8Uqmud3O6KRKpsioYXmE7tG7P6U337GlPI8tpFTHs7ctEiS+Kzhs5fI4X
 kzn5Dnhj6EPNPxLhkyvJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DZMiibCW060=:3tj82Nk20Etv0D/iyR3ot3
 Ij4L9Afd6/Z4dbMrhEqAb82q0cldoS4PnhesJ4zzUbOORCq1H5U+P26FnE5fr0Fk4uKecjIFY
 7QTOAGkvMQHdpttSU4RPLnDnBwgGbBZ0Rcifx4wpByLGbxeX9MNCT4eicDsnl676moQpHu0OZ
 JKw63APKRIz1J+VY3o4w7OGW3RfBykrNpO4An2VtE7EP17HKu3YrxfOADM7ZzcoRKdfPmk1Mf
 0QPo57td9WDYsSZBG+KETxZy4mSP9vGr5sz4y1mIaqjp1RG4419UzZB8dC7uRiV7c6gE2D9f0
 LWlIcyl2O/7QDXM41kmq6J8JfAWWm1UxuV7g03YwHS6J5hBYAQTlr9iAq6FxuHsHZx5KS4Eas
 8v0OdUj66xNlD0pwk43GqhkrNR45atmCujXatdMZwPMMlkppDKeVOKrx+ae7YY09tKMOWyECx
 rqCVvIrQT3ZImcuhvljPthHBYsoMyByoze4XlSe4MNxxKvtF8u5+X81UCabTD+FLrMUUB+mcy
 EDmKSmyta7Ef5mjmMXce0Rd03fNgB/CGTqB4bMS+MtFnUHZ+UeQ1Up7jyinvwY3zD7lbdJEYf
 mb6nNbYJhTQhZ6/LdDpeqn1QhNNJL621aYCwQu91Ynhi4pJXjlWCMvcjXyLs2p8QaByyUlnhx
 F8+F379ioZsagDTRIiD6/lYfCt1z1uXRD3RLbWxPGwSiT90CuyuLsArfnqofmCZc/KUFB7wZ2
 Re6Qv/5XG3gOy6sgjH8bjqQ+rSb9xo7LjnTHcIVwjbikLcuBLYCmasZymYVw6erUSZgZDyitf
 WVIJU6VaYKRiuUjYxInIcm2ElNZcfA0+EZAHQ/1yV4MtBRZpl2pmg0evacOInmHI9hT6qgNr2
 hx9uxBCh66IrW+ZR9xqQ==
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

This v3 version has changed a lot from the v2. Basically the application
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
github tree [2] in the "brute_v3" branch.

[1] https://github.com/KSPP/linux/issues/39
[2] https://github.com/johwood/linux/

The previous versions can be found in:

https://lore.kernel.org/kernel-hardening/20200910202107.3799376-1-keescook=
@chromium.org/
https://lore.kernel.org/kernel-hardening/20201025134540.3770-1-john.wood@g=
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

