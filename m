Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DC755771
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 23:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGPVwx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jul 2023 17:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGPVww (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jul 2023 17:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C3E40;
        Sun, 16 Jul 2023 14:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92BC060D57;
        Sun, 16 Jul 2023 21:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0354AC433C8;
        Sun, 16 Jul 2023 21:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544369;
        bh=iLZeICxUt0l/H4aRyXNb6O+JnIBpoDT4vsePdBYm9ps=;
        h=From:Subject:Date:To:Cc:From;
        b=o8x/i3VAnSd5IMSLI+t4VlZaN3qdrjdey4yA2WO8emCjPou7ZEksQBM3klLYpLNcQ
         2/liLMxKb4pvSASUdBvvVFQffErmh80uUOnN/32qYd8SWCWm4WQgNnks00gGqHff0O
         tdgRbH5qGcCny+jfXcbTdaihLPGZP5Ugk9M2w4DblOJDWl6Vc8Yybi/RoVj9Ys8+/8
         PyUhAdQ2uhv/fWSZblljRBJPOE52KdU4mjvM3jP2Cwv3qxGATJsHBnHK0R+2s93ETX
         Npdovt0nULB6+9N6WZ7kj/9SwN7RmE8y6n448W6/DwsvtIxSxPpejYRX0Prz5pkoi3
         mwf4vSXeso20Q==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 00/35] arm64/gcs: Provide support for GCS at EL0
Date:   Sun, 16 Jul 2023 22:50:56 +0100
Message-Id: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEFmtGQC/x2NwQqDQAxEf0VyNrC7Fm39Fekhu0bNwVWSUgriv
 3eVOb3hDXOAsQob9NUByl8x2XIBX1eQFsozo4yFIbjQuBIkXdsHzsmQG+8puvHZhRcUP5IxRqW
 clmvxWfer3ZUn+d0Pw/s8/zFr139xAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=9675; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iLZeICxUt0l/H4aRyXNb6O+JnIBpoDT4vsePdBYm9ps=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGaPOxNM17eFb4z37ZSAxRZ+c5F75q0zWrhNZMD1
 4PvjC1eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmjwAKCRAk1otyXVSH0MdVB/
 448MmTjXIsxgXt1RwOLmDEC/4ZKydyt4nxlUMLmBfLSrXBR17M694vUugDqTUVy6DSbB3olJgft+tV
 tQtIGvnbQOkYeS257kBHKX/OYFEshyE5jrcL7pliQg9ZHSqd2hQ0jUrthPldDbga1Aj4xGsTm2Qqyi
 hKyPWauLZYKgcy8PGg6J4/YfZZzFPlUbMbQF4uzkD14Try1LNyBDLWD8DI/R8jdrQ5dY0R0ltueNdP
 /WQN/pJ9zaW05GbNVPR4Bqg6fLwDC94fm7Gm+/+LuSTSyVIrIead9+06sZRTHMPdvYmE8Pyd8aYHGQ
 kU6aFmPfP79KzQAQubDtlaPly2fCYu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The arm64 Guarded Control Stack (GCS) feature provides support for
hardware protected stacks of return addresses, intended to provide
hardening against return oriented programming (ROP) attacks and to make
it easier to gather call stacks for applications such as profiling.

When GCS is active a secondary stack called the Guarded Control Stack is
maintained, protected with a memory attribute which means that it can
only be written with specific GCS operations.  When a BL is executed the
value stored in LR is also pushed onto the GCS, and when a RET is
executed the top of the GCS is popped and compared to LR with a fault
being raised if the values do not match.  GCS operations may only be
performed on GCS pages, a data abort is generated if they are not.

This series implements support for use of GCS by EL0, along with support
for use of GCS within KVM guests.  It does not enable use of GCS by
either EL1 or EL2.  Executables are started without GCS and must use a
prctl() to enable it, it is expected that this will be done very early
in application execution by the dynamic linker or other startup code.

x86 has an equivalent feature called shadow stacks, this series depends
on the x86 patches for generic memory management support for the new
guarded/shadow stack page type and shares APIs as much as possible.  As
there has been extensive discussion with the wider community around the
ABI for shadow stacks I have as far as practical kept implementation
decisions close to those for x86, anticipating that review would lead to
similar conclusions in the absence of strong reasoning for divergence.

The main divergence I am concious of is that x86 allows shadow stack to
be enabled and disabled repeatedly, freeing the shadow stack for the
thread whenever disabled, while this implementation keeps the GCS
allocated after disable but refuses to reenable it.  This is to avoid
races with things actively walking the GCS during a disable, we do
anticipate that some systems will wish to disable GCS at runtime but are
not aware of any demand for subsequently reenabling it.

x86 uses an arch_prctl() to manage enable and disable, since only x86
and S/390 use arch_prctl() a generic prctl() was proposed[1] as part of a
patch set for the equivalent RISC-V zisslpcfi feature which is adopted
with some enhancements here.

There's a few bits where I'm not convinced with where I've placed
things, in particular the GCS write operation is in the GCS header not
in uaccess.h, I wasn't sure what was clearest there and am probably too
close to the code to have a clear opinion.

The series depends on the x86 shadow stack support:

   https://lore.kernel.org/lkml/20230227222957.24501-1-rick.p.edgecombe@intel.com/

I've rebased this onto v6.5-rc1 but not included it in the series in
order to avoid confusion with Rick's work and cut down the size of the
series, you can see the branch at:

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-gcs

[1] https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Deepak Gupta (1):
      prctl: arch-agnostic prctl for shadow stack

Mark Brown (34):
      prctl: Add flag for shadow stack writeability and push/pop
      arm64: Document boot requirements for Guarded Control Stacks
      arm64/gcs: Document the ABI for Guarded Control Stacks
      arm64/sysreg: Add new system registers for GCS
      arm64/sysreg: Add definitions for architected GCS caps
      arm64/gcs: Add manual encodings of GCS instructions
      arm64/gcs: Provide copy_to_user_gcs()
      arm64/cpufeature: Runtime detection of Guarded Control Stack (GCS)
      arm64/mm: Allocate PIE slots for EL0 guarded control stack
      mm: Define VM_SHADOW_STACK for arm64 when we support GCS
      arm64/mm: Map pages for guarded control stack
      KVM: arm64: Manage GCS registers for guests
      arm64: Disable traps for GCS usage at EL0 and EL1
      arm64/idreg: Add overrride for GCS
      arm64/hwcap: Add hwcap for GCS
      arm64/traps: Handle GCS exceptions
      arm64/mm: Handle GCS data aborts
      arm64/gcs: Context switch GCS registers for EL0
      arm64/gcs: Allocate a new GCS for threads with GCS enabled
      arm64/gcs: Implement shadow stack prctl() interface
      arm64/mm: Implement map_shadow_stack()
      arm64/signal: Set up and restore the GCS context for signal handlers
      arm64/signal: Expose GCS state in signal frames
      arm64/ptrace: Expose GCS via ptrace and core files
      arm64: Add Kconfig for Guarded Control Stack (GCS)
      kselftest/arm64: Verify the GCS hwcap
      kselftest/arm64: Add GCS as a detected feature in the signal tests
      kselftest/arm64: Add framework support for GCS to signal handling tests
      kselftest/arm64: Allow signals tests to specify an expected si_code
      kselftest/arm64: Always run signals tests with GCS enabled
      kselftest/arm64: Add very basic GCS test program
      kselftest/arm64: Add a GCS test program built with the system libc
      selftests/arm64: Add GCS signal tests
      kselftest/arm64: Enable GCS for the FP stress tests

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/arch/arm64/booting.rst               |  22 ++
 Documentation/arch/arm64/elf_hwcaps.rst            |   3 +
 Documentation/arch/arm64/gcs.rst                   | 216 +++++++++++++
 Documentation/arch/arm64/index.rst                 |   1 +
 Documentation/filesystems/proc.rst                 |   2 +-
 arch/arm64/Kconfig                                 |  19 ++
 arch/arm64/include/asm/cpufeature.h                |   6 +
 arch/arm64/include/asm/el2_setup.h                 |   9 +
 arch/arm64/include/asm/esr.h                       |  26 +-
 arch/arm64/include/asm/exception.h                 |   2 +
 arch/arm64/include/asm/gcs.h                       |  88 ++++++
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/kvm_host.h                  |  12 +
 arch/arm64/include/asm/pgtable-prot.h              |  14 +-
 arch/arm64/include/asm/processor.h                 |   6 +
 arch/arm64/include/asm/sysreg.h                    |  20 ++
 arch/arm64/include/asm/uaccess.h                   |  42 +++
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/include/uapi/asm/ptrace.h               |   7 +
 arch/arm64/include/uapi/asm/sigcontext.h           |   9 +
 arch/arm64/kernel/cpufeature.c                     |  23 ++
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/entry-common.c                   |  23 ++
 arch/arm64/kernel/idreg-override.c                 |   2 +
 arch/arm64/kernel/process.c                        |  77 +++++
 arch/arm64/kernel/ptrace.c                         |  50 +++
 arch/arm64/kernel/signal.c                         | 240 +++++++++++++-
 arch/arm64/kernel/traps.c                          |  11 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  17 +
 arch/arm64/kvm/sys_regs.c                          |  22 ++
 arch/arm64/mm/Makefile                             |   1 +
 arch/arm64/mm/fault.c                              |  75 ++++-
 arch/arm64/mm/gcs.c                                | 202 ++++++++++++
 arch/arm64/mm/mmap.c                               |  17 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            |  55 ++++
 fs/proc/task_mmu.c                                 |   3 +
 include/linux/mm.h                                 |  15 +-
 include/linux/syscalls.h                           |   1 +
 include/uapi/asm-generic/unistd.h                  |   5 +-
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  19 ++
 kernel/sys.c                                       |  20 ++
 kernel/sys_ni.c                                    |   1 +
 tools/testing/selftests/arm64/Makefile             |   2 +-
 tools/testing/selftests/arm64/abi/hwcap.c          |  19 ++
 tools/testing/selftests/arm64/fp/assembler.h       |  15 +
 tools/testing/selftests/arm64/fp/fpsimd-test.S     |   2 +
 tools/testing/selftests/arm64/fp/sve-test.S        |   2 +
 tools/testing/selftests/arm64/fp/za-test.S         |   2 +
 tools/testing/selftests/arm64/fp/zt-test.S         |   2 +
 tools/testing/selftests/arm64/gcs/.gitignore       |   2 +
 tools/testing/selftests/arm64/gcs/Makefile         |  19 ++
 tools/testing/selftests/arm64/gcs/basic-gcs.c      | 350 +++++++++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-util.h       |  65 ++++
 tools/testing/selftests/arm64/gcs/libc-gcs.c       | 217 +++++++++++++
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 .../testing/selftests/arm64/signal/test_signals.c  |  17 +-
 .../testing/selftests/arm64/signal/test_signals.h  |   6 +
 .../selftests/arm64/signal/test_signals_utils.c    |  32 +-
 .../selftests/arm64/signal/test_signals_utils.h    |  39 +++
 .../arm64/signal/testcases/gcs_exception_fault.c   |  59 ++++
 .../selftests/arm64/signal/testcases/gcs_frame.c   |  78 +++++
 .../arm64/signal/testcases/gcs_write_fault.c       |  67 ++++
 .../selftests/arm64/signal/testcases/testcases.c   |   7 +
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 67 files changed, 2363 insertions(+), 32 deletions(-)
---
base-commit: 023ee2d672f3d7c2d15acf62bcfc4bc49c3677e5
change-id: 20230303-arm64-gcs-e311ab0d8729

Best regards,
-- 
Mark Brown <broonie@kernel.org>

