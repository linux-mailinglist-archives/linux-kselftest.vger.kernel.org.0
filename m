Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597F333DF16
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Mar 2021 21:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhCPUnS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 16:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhCPUm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 16:42:57 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD3C061756
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Mar 2021 13:42:57 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F0QGR2VzZzMq189;
        Tue, 16 Mar 2021 21:42:55 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4F0QGM5LNwzlppyg;
        Tue, 16 Mar 2021 21:42:51 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v30 00/12] Landlock LSM
Date:   Tue, 16 Mar 2021 21:42:40 +0100
Message-Id: <20210316204252.427806-1-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This patch series is mainly a rebase on top of v5.12-rc3 and a
synchronization with the new mount_setattr(2).  A light cleanup of
hook_sb_delete() and new tests are also included.

The SLOC count is 1329 for security/landlock/ and 2556 for
tools/testing/selftest/landlock/ .  Test coverage for security/landlock/
is 93.6% of lines.  The code not covered only deals with internal kernel
errors (e.g. memory allocation) and race conditions.  This series is
being fuzzed by syzkaller (which may cover internal kernel errors), and
patches are on their way: https://github.com/google/syzkaller/pull/2380

The compiled documentation is available here:
https://landlock.io/linux-doc/landlock-v30/userspace-api/landlock.html

This series can be applied on top of v5.12-rc3 .  This can be tested with
CONFIG_SECURITY_LANDLOCK, CONFIG_SAMPLE_LANDLOCK and by prepending
"landlock," to CONFIG_LSM.  This patch series can be found in a Git
repository here:
https://github.com/landlock-lsm/linux/commits/landlock-v30
This patch series seems ready for upstream and I would really appreciate
final reviews.


Landlock LSM
------------

The goal of Landlock is to enable to restrict ambient rights (e.g.
global filesystem access) for a set of processes.  Because Landlock is a
stackable LSM [1], it makes possible to create safe security sandboxes
as new security layers in addition to the existing system-wide
access-controls. This kind of sandbox is expected to help mitigate the
security impact of bugs or unexpected/malicious behaviors in user-space
applications. Landlock empowers any process, including unprivileged
ones, to securely restrict themselves.

Landlock is inspired by seccomp-bpf but instead of filtering syscalls
and their raw arguments, a Landlock rule can restrict the use of kernel
objects like file hierarchies, according to the kernel semantic.
Landlock also takes inspiration from other OS sandbox mechanisms: XNU
Sandbox, FreeBSD Capsicum or OpenBSD Pledge/Unveil.

In this current form, Landlock misses some access-control features.
This enables to minimize this patch series and ease review.  This series
still addresses multiple use cases, especially with the combined use of
seccomp-bpf: applications with built-in sandboxing, init systems,
security sandbox tools and security-oriented APIs [2].

[1] https://lore.kernel.org/lkml/50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com/
[2] https://lore.kernel.org/lkml/f646e1c7-33cf-333f-070c-0a40ad0468cd@digikod.net/

Previous versions:
v29: https://lore.kernel.org/lkml/20210225190614.2181147-1-mic@digikod.net/
v28: https://lore.kernel.org/lkml/20210202162710.657398-1-mic@digikod.net/
v27: https://lore.kernel.org/lkml/20210121205119.793296-1-mic@digikod.net/
v26: https://lore.kernel.org/lkml/20201209192839.1396820-1-mic@digikod.net/
v25: https://lore.kernel.org/lkml/20201201192322.213239-1-mic@digikod.net/
v24: https://lore.kernel.org/lkml/20201112205141.775752-1-mic@digikod.net/
v23: https://lore.kernel.org/lkml/20201103182109.1014179-1-mic@digikod.net/
v22: https://lore.kernel.org/lkml/20201027200358.557003-1-mic@digikod.net/
v21: https://lore.kernel.org/lkml/20201008153103.1155388-1-mic@digikod.net/
v20: https://lore.kernel.org/lkml/20200802215903.91936-1-mic@digikod.net/
v19: https://lore.kernel.org/lkml/20200707180955.53024-1-mic@digikod.net/
v18: https://lore.kernel.org/lkml/20200526205322.23465-1-mic@digikod.net/
v17: https://lore.kernel.org/lkml/20200511192156.1618284-1-mic@digikod.net/
v16: https://lore.kernel.org/lkml/20200416103955.145757-1-mic@digikod.net/
v15: https://lore.kernel.org/lkml/20200326202731.693608-1-mic@digikod.net/
v14: https://lore.kernel.org/lkml/20200224160215.4136-1-mic@digikod.net/
v13: https://lore.kernel.org/lkml/20191104172146.30797-1-mic@digikod.net/
v12: https://lore.kernel.org/lkml/20191031164445.29426-1-mic@digikod.net/
v11: https://lore.kernel.org/lkml/20191029171505.6650-1-mic@digikod.net/
v10: https://lore.kernel.org/lkml/20190721213116.23476-1-mic@digikod.net/
v9: https://lore.kernel.org/lkml/20190625215239.11136-1-mic@digikod.net/
v8: https://lore.kernel.org/lkml/20180227004121.3633-1-mic@digikod.net/
v7: https://lore.kernel.org/lkml/20170821000933.13024-1-mic@digikod.net/
v6: https://lore.kernel.org/lkml/20170328234650.19695-1-mic@digikod.net/
v5: https://lore.kernel.org/lkml/20170222012632.4196-1-mic@digikod.net/
v4: https://lore.kernel.org/lkml/20161026065654.19166-1-mic@digikod.net/
v3: https://lore.kernel.org/lkml/20160914072415.26021-1-mic@digikod.net/
v2: https://lore.kernel.org/lkml/1472121165-29071-1-git-send-email-mic@digikod.net/
v1: https://lore.kernel.org/kernel-hardening/1458784008-16277-1-git-send-email-mic@digikod.net/

Casey Schaufler (1):
  LSM: Infrastructure management of the superblock

Mickaël Salaün (11):
  landlock: Add object management
  landlock: Add ruleset and domain management
  landlock: Set up the security framework and manage credentials
  landlock: Add ptrace restrictions
  fs,security: Add sb_delete hook
  landlock: Support filesystem access-control
  landlock: Add syscall implementations
  arch: Wire up Landlock syscalls
  selftests/landlock: Add user space tests
  samples/landlock: Add a sandbox manager example
  landlock: Add user and kernel documentation

 Documentation/security/index.rst              |    1 +
 Documentation/security/landlock.rst           |   79 +
 Documentation/userspace-api/index.rst         |    1 +
 Documentation/userspace-api/landlock.rst      |  307 ++
 MAINTAINERS                                   |   15 +
 arch/Kconfig                                  |    7 +
 arch/alpha/kernel/syscalls/syscall.tbl        |    3 +
 arch/arm/tools/syscall.tbl                    |    3 +
 arch/arm64/include/asm/unistd.h               |    2 +-
 arch/arm64/include/asm/unistd32.h             |    6 +
 arch/ia64/kernel/syscalls/syscall.tbl         |    3 +
 arch/m68k/kernel/syscalls/syscall.tbl         |    3 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |    3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |    3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |    3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |    3 +
 arch/parisc/kernel/syscalls/syscall.tbl       |    3 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |    3 +
 arch/s390/kernel/syscalls/syscall.tbl         |    3 +
 arch/sh/kernel/syscalls/syscall.tbl           |    3 +
 arch/sparc/kernel/syscalls/syscall.tbl        |    3 +
 arch/um/Kconfig                               |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl        |    3 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |    3 +
 fs/super.c                                    |    1 +
 include/linux/lsm_hook_defs.h                 |    1 +
 include/linux/lsm_hooks.h                     |    4 +
 include/linux/security.h                      |    4 +
 include/linux/syscalls.h                      |    7 +
 include/uapi/asm-generic/unistd.h             |    8 +-
 include/uapi/linux/landlock.h                 |  128 +
 kernel/sys_ni.c                               |    5 +
 samples/Kconfig                               |    7 +
 samples/Makefile                              |    1 +
 samples/landlock/.gitignore                   |    1 +
 samples/landlock/Makefile                     |   13 +
 samples/landlock/sandboxer.c                  |  238 ++
 security/Kconfig                              |   11 +-
 security/Makefile                             |    2 +
 security/landlock/Kconfig                     |   21 +
 security/landlock/Makefile                    |    4 +
 security/landlock/common.h                    |   20 +
 security/landlock/cred.c                      |   46 +
 security/landlock/cred.h                      |   58 +
 security/landlock/fs.c                        |  687 ++++
 security/landlock/fs.h                        |   56 +
 security/landlock/limits.h                    |   21 +
 security/landlock/object.c                    |   67 +
 security/landlock/object.h                    |   91 +
 security/landlock/ptrace.c                    |  120 +
 security/landlock/ptrace.h                    |   14 +
 security/landlock/ruleset.c                   |  473 +++
 security/landlock/ruleset.h                   |  165 +
 security/landlock/setup.c                     |   40 +
 security/landlock/setup.h                     |   18 +
 security/landlock/syscalls.c                  |  445 +++
 security/security.c                           |   51 +-
 security/selinux/hooks.c                      |   58 +-
 security/selinux/include/objsec.h             |    6 +
 security/selinux/ss/services.c                |    3 +-
 security/smack/smack.h                        |    6 +
 security/smack/smack_lsm.c                    |   35 +-
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    2 +
 tools/testing/selftests/landlock/Makefile     |   24 +
 tools/testing/selftests/landlock/base_test.c  |  219 ++
 tools/testing/selftests/landlock/common.h     |  183 ++
 tools/testing/selftests/landlock/config       |    7 +
 tools/testing/selftests/landlock/fs_test.c    | 2792 +++++++++++++++++
 .../testing/selftests/landlock/ptrace_test.c  |  337 ++
 tools/testing/selftests/landlock/true.c       |    5 +
 72 files changed, 6896 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/security/landlock.rst
 create mode 100644 Documentation/userspace-api/landlock.rst
 create mode 100644 include/uapi/linux/landlock.h
 create mode 100644 samples/landlock/.gitignore
 create mode 100644 samples/landlock/Makefile
 create mode 100644 samples/landlock/sandboxer.c
 create mode 100644 security/landlock/Kconfig
 create mode 100644 security/landlock/Makefile
 create mode 100644 security/landlock/common.h
 create mode 100644 security/landlock/cred.c
 create mode 100644 security/landlock/cred.h
 create mode 100644 security/landlock/fs.c
 create mode 100644 security/landlock/fs.h
 create mode 100644 security/landlock/limits.h
 create mode 100644 security/landlock/object.c
 create mode 100644 security/landlock/object.h
 create mode 100644 security/landlock/ptrace.c
 create mode 100644 security/landlock/ptrace.h
 create mode 100644 security/landlock/ruleset.c
 create mode 100644 security/landlock/ruleset.h
 create mode 100644 security/landlock/setup.c
 create mode 100644 security/landlock/setup.h
 create mode 100644 security/landlock/syscalls.c
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/base_test.c
 create mode 100644 tools/testing/selftests/landlock/common.h
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/fs_test.c
 create mode 100644 tools/testing/selftests/landlock/ptrace_test.c
 create mode 100644 tools/testing/selftests/landlock/true.c


base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.30.2

