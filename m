Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993D075F6A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGXMrE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 08:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjGXMrC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 08:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAECFE4E;
        Mon, 24 Jul 2023 05:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DF4B61152;
        Mon, 24 Jul 2023 12:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886FBC433CA;
        Mon, 24 Jul 2023 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690202819;
        bh=B4RAoMseNkNIkWpPj2Wehxnn95Jmf+et0Sq3Zsx0vLk=;
        h=From:Subject:Date:To:Cc:From;
        b=CQYZH07E6ymenUNN4D1vCSxUL8I9WvC6pdJqjzTO9RR38uHtOmxbVj/sMXqZyhIVM
         /3qYQyjqeHfEp6QTjMF57gEHsjgyLmtsPvOycSB1oNudF80kVdWAvxfjkdmIGeCzQ2
         dxregEaNimjlzjmhlxzzstm2Unzlovu9iBHofrLxXVn2U71Tf33zaiBNXHLtlNRhcy
         Up+L/DfLx7d515YohwfxwPfwjgMSArCZoOzl0U1R4hqfAbuLeRdz18/sq5EyrGThAl
         w5BphZQYa/V7K2nMA8/Lb1bDTtgN0tmFzpU9O4Sbr938zpdqWZSEtXT1CUaiKsDE8i
         +RPEi3PCMXyBQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 00/35] arm64/gcs: Provide support for GCS in userspace
Date:   Mon, 24 Jul 2023 13:45:47 +0100
Message-Id: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5yvmQC/02NTQ6CMBCFr0Jm7Zi2aBFW3sOwaGGARmnJlBAN4
 e4W3Ji3+l7ezwqR2FGEKluBaXHRBZ9AnTJoBuN7QtcmBiVULpLQ8Kgv2DcRKZfSWNHeClVCyls
 TCS0b3wx7Yx6n3Z2YOvc+Hh514sHFOfDnOFzk7v62C6n/theJAm131UVX5tYafX8Se3qdA/dQb
 9v2BWAZ14i5AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10572; i=broonie@kernel.org;
 h=from:subject:message-id; bh=B4RAoMseNkNIkWpPj2Wehxnn95Jmf+et0Sq3Zsx0vLk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvnKF2/vK2LFgpivVm/wXBYXr0rid/c5qZErjCdjG
 CsGaFWOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZL5yhQAKCRAk1otyXVSH0EpbB/
 9IPPzitXSWGuusofJcvz3ZR37Wj2+8VVR3Ulrg5FHrdqwwlvdXDZ//rGR8+WRrOKKWwghmnt5RLpmW
 7oW6DA7eaLcdG6pdsLMH+hyi3Pa9D0fkCVCK4UDdgd3CcSBSFz7lvc5Oc1Gj2hpHZBkydXnQn1WioZ
 7wJVLUSs+kOLZ9ZsyI319a2YpIRF44Yf5xtL+z/cXdSEvVCCd3YvVPToRgWTxgOvBYM0bcRTGSGI+F
 p5IYjBNErAGtnW575hjzOFvBowKUrTOr0q5rybhUHtmaNAzeUytefgxzyGxQ8Rh4xhrp1EDNN8eSQF
 dtmOFg4tV7NO08j1etd5tTxiqbDSCH
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

This series implements support for use of GCS by userspace, along with
support for use of GCS within KVM guests.  It does not enable use of GCS
by either EL1 or EL2.  Executables are started without GCS and must use
a prctl() to enable it, it is expected that this will be done very early
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
patch set for the equivalent RISC-V zisslpcfi feature which I initially
adopted fairly directly but following review feedback has been reviewed
quite a bit.

There is an open issue with support for CRIU, on x86 this required the
ability to set the GCS mode via ptrace.  This series supports
configuring mode bits other than enable/disable via ptrace but it needs
to be confirmed if this is sufficient.

There's a few bits where I'm not convinced with where I've placed
things, in particular the GCS write operation is in the GCS header not
in uaccess.h, I wasn't sure what was clearest there and am probably too
close to the code to have a clear opinion.  The reporting of GCS in
/proc/PID/smaps is also a bit awkward.

The series depends on the x86 shadow stack support:

   https://lore.kernel.org/lkml/20230227222957.24501-1-rick.p.edgecombe@intel.com/

I've rebased this onto v6.5-rc3 but not included it in the series in
order to avoid confusion with Rick's work and cut down the size of the
series, you can see the branch at:

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-gcs

[1] https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.5-rc3.
- Rework prctl() interface to allow each bit to be locked independently.
- map_shadow_stack() now places the cap token based on the size
  requested by the caller not the actual space allocated.
- Mode changes other than enable via ptrace are now supported.
- Expand test coverage.
- Various smaller fixes and adjustments.
- Link to v1: https://lore.kernel.org/r/20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org

---
Mark Brown (35):
      prctl: arch-agnostic prctl for shadow stack
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
      arm64/el2_setup: Allow GCS usage at EL0 and EL1
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
      kselftest/arm64: Add test coverage for GCS mode locking
      selftests/arm64: Add GCS signal tests
      kselftest/arm64: Enable GCS for the FP stress tests

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/arch/arm64/booting.rst               |  22 ++
 Documentation/arch/arm64/elf_hwcaps.rst            |   3 +
 Documentation/arch/arm64/gcs.rst                   | 225 +++++++++++++
 Documentation/arch/arm64/index.rst                 |   1 +
 Documentation/filesystems/proc.rst                 |   2 +-
 arch/arm64/Kconfig                                 |  19 ++
 arch/arm64/include/asm/cpufeature.h                |   6 +
 arch/arm64/include/asm/el2_setup.h                 |  17 +
 arch/arm64/include/asm/esr.h                       |  28 +-
 arch/arm64/include/asm/exception.h                 |   2 +
 arch/arm64/include/asm/gcs.h                       | 106 ++++++
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/kvm_host.h                  |  12 +
 arch/arm64/include/asm/pgtable-prot.h              |  14 +-
 arch/arm64/include/asm/processor.h                 |   7 +
 arch/arm64/include/asm/sysreg.h                    |  20 ++
 arch/arm64/include/asm/uaccess.h                   |  42 +++
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/include/uapi/asm/ptrace.h               |   8 +
 arch/arm64/include/uapi/asm/sigcontext.h           |   9 +
 arch/arm64/kernel/cpufeature.c                     |  19 ++
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/entry-common.c                   |  23 ++
 arch/arm64/kernel/idreg-override.c                 |   2 +
 arch/arm64/kernel/process.c                        |  78 +++++
 arch/arm64/kernel/ptrace.c                         |  59 ++++
 arch/arm64/kernel/signal.c                         | 237 ++++++++++++-
 arch/arm64/kernel/traps.c                          |  11 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  17 +
 arch/arm64/kvm/sys_regs.c                          |  22 ++
 arch/arm64/mm/Makefile                             |   1 +
 arch/arm64/mm/fault.c                              |  78 ++++-
 arch/arm64/mm/gcs.c                                | 226 +++++++++++++
 arch/arm64/mm/mmap.c                               |  17 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            |  55 +++
 fs/proc/task_mmu.c                                 |   3 +
 include/linux/mm.h                                 |  16 +-
 include/linux/syscalls.h                           |   1 +
 include/uapi/asm-generic/unistd.h                  |   5 +-
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  22 ++
 kernel/sys.c                                       |  30 ++
 kernel/sys_ni.c                                    |   1 +
 tools/testing/selftests/arm64/Makefile             |   2 +-
 tools/testing/selftests/arm64/abi/hwcap.c          |  19 ++
 tools/testing/selftests/arm64/fp/assembler.h       |  15 +
 tools/testing/selftests/arm64/fp/fpsimd-test.S     |   2 +
 tools/testing/selftests/arm64/fp/sve-test.S        |   2 +
 tools/testing/selftests/arm64/fp/za-test.S         |   2 +
 tools/testing/selftests/arm64/fp/zt-test.S         |   2 +
 tools/testing/selftests/arm64/gcs/.gitignore       |   3 +
 tools/testing/selftests/arm64/gcs/Makefile         |  19 ++
 tools/testing/selftests/arm64/gcs/basic-gcs.c      | 351 +++++++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-locking.c    | 200 +++++++++++
 tools/testing/selftests/arm64/gcs/gcs-util.h       |  87 +++++
 tools/testing/selftests/arm64/gcs/libc-gcs.c       | 372 +++++++++++++++++++++
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
 68 files changed, 2825 insertions(+), 32 deletions(-)
---
base-commit: b8f2cc1100d85456f9a48243328b33ab0ce5caff
change-id: 20230303-arm64-gcs-e311ab0d8729

Best regards,
-- 
Mark Brown <broonie@kernel.org>

