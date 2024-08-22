Return-Path: <linux-kselftest+bounces-15942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175995A967
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 03:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530CC1C2278B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 01:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB5A79F2;
	Thu, 22 Aug 2024 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1+dgI1i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07B3C00;
	Thu, 22 Aug 2024 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289360; cv=none; b=QPiPoaHBL8OTWgy6ra5Jgf0NFywqLgwFm1smWoiHf+RJxeGquMJhrirCWDNDL9Kj3mMEu6W9Cb4aMJ+Ov58M3PeuWF8HtHGtlXgdHElPOb2LgYPqZOQerpVlGeD0OdvEWQiCsk349X2TBoUDtnwhYNM5dj1LqyD3cJj1ZdYlpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289360; c=relaxed/simple;
	bh=3lsEIVGLUL+vfrdoSt9mLqcxu6D2kKD1lSiuPgxxZAo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jutWqAGSQUJJZ6G0/Bglq3+W/kM6kvqY+UVc7x/0x25NnBNe+PH8Ob7DYdSXVJNu0LBuCwJY1j/YH0Cu1sPbeC8QwPzGlxKAivePbg+i4EUs3GQvkoE0bNShba6yxzrR84VDmx6vUgggdKW0KCs4zIIcTIvCAqOXpzLrqNIft0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1+dgI1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8009FC32781;
	Thu, 22 Aug 2024 01:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289360;
	bh=3lsEIVGLUL+vfrdoSt9mLqcxu6D2kKD1lSiuPgxxZAo=;
	h=From:Subject:Date:To:Cc:From;
	b=J1+dgI1i/oqzor0Bl+EEXcm0KuibSzSHHq54vIVWmTsZS9UllF7BNStDKQrAJSq6L
	 xR70X1Usfz85k4cVObLqJy4emEe+enuFxa4kNQN4ilhyMQ0NkFyoSaW5WbrBVcHQSP
	 xLTNw8oA40uTuHuEcydJhTGwR66dN7AWGUAb+A/I+pE37Bk0SB0mATw9RTWsk5m1JC
	 QgMv5UQyoIKHeHPvLtoccUnFXh69SXORAL3aP043UuxxWT7flaTh9QoRzAOANEMYz4
	 jOFs6Y+0a9nmZCMXihvTCwjKLHQ2TwrxuDS7ceyIKgBux78rF0MR5xMYyuA16GBicq
	 qoM69kSg7s7IQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v11 00/39] arm64/gcs: Provide support for GCS in userspace
Date: Thu, 22 Aug 2024 02:15:03 +0100
Message-Id: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiRxmYC/2XRzU7DMAwA4FeZeqbIdtL8cOI9EIf8OFsF66Z0q
 kDT3p10CJopyslWPtuyr93MeeS5e9ldu8zLOI+nqQSIT7suHNy0536MJdERkIDyepePSvb7MPc
 sEJ2HaDTZrvz3bubeZzeFwyoux/OaPWdO49e9xdt7iQ/jfDnl73vHBdfsb22Nqqq9YA+9T4PSy
 QrvnXr94Dzx5/Mp77u1zEIVJVlTKjQGChilDMS+oaKiAmsqCg0xJpusgWhNQ+VGDeiaykKVCcm
 JMjIo29ChokQ1HQq1nNBgjEqQbKj6pwhga6oK1YaHIbJzMsaG6o3iY1ddKAEGaYSPWg8NNX9UA
 j0cfjHrmmzioLXSglND7UYVDTW1hUJSQkplvUnQUITNGni4DsK6Y2uZfCS08HjZ2+32A8lUEBb
 PAgAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>, 
 David Hildenbrand <david@redhat.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=15916; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3lsEIVGLUL+vfrdoSt9mLqcxu6D2kKD1lSiuPgxxZAo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEjfy4SuyrAJis80ZVjuEXPX37oi0KlHHUCV3h9
 FZMFWO2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRIwAKCRAk1otyXVSH0LdiB/
 98iRYISnP8ctLPzKhF/nTRetolFsmgq4Qz34cyYtmZvkil1+mq8F1iKDhwrgn9hsMFKt0hkRspB4Aa
 57OPEFtSvH6eaI0XuolZwyJ5uMCJxEvW4EdXFfJ0HckSzxjCNf+JUvV3WdXjpppxN9fMaKfpPKhKwC
 fohO9iHba3s5cWTS23QNVUA4NK3am0XPPZanlYe6LaS6DOcE0pDr3mKK/OdIEzGwL6w6Kpw2U69Ei/
 UIyhEPHRIQGj7+Nj2nPzeV3UGNHWelwc30A7IN6Dbkh2pFXSb83mfePX91hNB0qlgOsSt19+p4NFjh
 Aw8Do/EJ6DElDblgt0Lx6uc9ZOC+w5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The arm64 Guarded Control Stack (GCS) feature provides support for
hardware protected stacks of return addresses, intended to provide
hardening against return oriented programming (ROP) attacks and to make
it easier to gather call stacks for applications such as profiling.

When GCS is active a secondary stack called the Guarded Control Stack is
maintained, protected with a memory attribute which means that it can
only be written with specific GCS operations.  The current GCS pointer
can not be directly written to by userspace.  When a BL is executed the
value stored in LR is also pushed onto the GCS, and when a RET is
executed the top of the GCS is popped and compared to LR with a fault
being raised if the values do not match.  GCS operations may only be
performed on GCS pages, a data abort is generated if they are not.

The combination of hardware enforcement and lack of extra instructions
in the function entry and exit paths should result in something which
has less overhead and is more difficult to attack than a purely software
implementation like clang's shadow stacks.

This series implements support for use of GCS by userspace, along with
support for use of GCS within KVM guests.  It does not enable use of GCS
by either EL1 or EL2, this will be implemented separately.  Executables
are started without GCS and must use a prctl() to enable it, it is
expected that this will be done very early in application execution by
the dynamic linker or other startup code.  For dynamic linking this will
be done by checking that everything in the executable is marked as GCS
compatible.

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
patch set for the equivalent RISC-V Zicfiss feature which I initially
adopted fairly directly but following review feedback has been revised
quite a bit.

We currently maintain the x86 pattern of implicitly allocating a shadow
stack for threads started with shadow stack enabled, there has been some
discussion of removing this support and requiring the use of clone3()
with explicit allocation of shadow stacks instead.  I have no strong
feelings either way, implicit allocation is not really consistent with
anything else we do and creates the potential for errors around thread
exit but on the other hand it is existing ABI on x86 and minimises the
changes needed in userspace code.

glibc and bionic changes using this ABI have been implemented and
tested.  Headless Android systems have been validated and Ross Burton
has used this code has been used to bring up a Yocto system with GCS
enabed as standard, a test implementation of V8 support has also been
done.

There is an open issue with support for CRIU, on x86 this required the
ability to set the GCS mode via ptrace.  This series supports
configuring mode bits other than enable/disable via ptrace but it needs
to be confirmed if this is sufficient.

It is likely that we could relax some of the barriers added here with
some more targeted placements, this is left for further study.

There is an in process series adding clone3() support for shadow stacks:

   https://lore.kernel.org/r/20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org

Previous versions of this series depended on that, this dependency has
been removed in order to make merging easier.

[1] https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v11:
- Remove the dependency on the addition of clone3() support for shadow
  stacks, rebasing onto v6.11-rc3.
- Make ID_AA64PFR1_EL1.GCS writeable in KVM.
- Hide GCS registers when GCS is not enabled for KVM guests.
- Require HCRX_EL2.GCSEn if booting at EL1.
- Require that GCSCR_EL1 and GCSCRE0_EL1 be initialised regardless of
  if we boot at EL2 or EL1.
- Remove some stray use of bit 63 in signal cap tokens.
- Warn if we see a GCS with VM_SHARED.
- Remove rdundant check for VM_WRITE in fault handling.
- Cleanups and clarifications in the ABI document.
- Clean up and improve documentation of some sync placement.
- Only set the EL0 GCS mode if it's actually changed.
- Various minor fixes and tweaks.
- Link to v10: https://lore.kernel.org/r/20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org

Changes in v10:
- Fix issues with THP.
- Tighten up requirements for initialising GCSCR*.
- Only generate GCS signal frames for threads using GCS.
- Only context switch EL1 GCS registers if S1PIE is enabled.
- Move context switch of GCSCRE0_EL1 to EL0 context switch.
- Make GCS registers unconditionally visible to userspace.
- Use FHU infrastructure.
- Don't change writability of ID_AA64PFR1_EL1 for KVM.
- Remove unused arguments from alloc_gcs().
- Typo fixes.
- Link to v9: https://lore.kernel.org/r/20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org

Changes in v9:
- Rebase onto v6.10-rc3.
- Restructure and clarify memory management fault handling.
- Fix up basic-gcs for the latest clone3() changes.
- Convert to newly merged KVM ID register based feature configuration.
- Fixes for NV traps.
- Link to v8: https://lore.kernel.org/r/20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org

Changes in v8:
- Invalidate signal cap token on stack when consuming.
- Typo and other trivial fixes.
- Don't try to use process_vm_write() on GCS, it intentionally does not
  work.
- Fix leak of thread GCSs.
- Rebase onto latest clone3() series.
- Link to v7: https://lore.kernel.org/r/20231122-arm64-gcs-v7-0-201c483bd775@kernel.org

Changes in v7:
- Rebase onto v6.7-rc2 via the clone3() patch series.
- Change the token used to cap the stack during signal handling to be
  compatible with GCSPOPM.
- Fix flags for new page types.
- Fold in support for clone3().
- Replace copy_to_user_gcs() with put_user_gcs().
- Link to v6: https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org

Changes in v6:
- Rebase onto v6.6-rc3.
- Add some more gcsb_dsync() barriers following spec clarifications.
- Due to ongoing discussion around clone()/clone3() I've not updated
  anything there, the behaviour is the same as on previous versions.
- Link to v5: https://lore.kernel.org/r/20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org

Changes in v5:
- Don't map any permissions for user GCSs, we always use EL0 accessors
  or use a separate mapping of the page.
- Reduce the standard size of the GCS to RLIMIT_STACK/2.
- Enforce a PAGE_SIZE alignment requirement on map_shadow_stack().
- Clarifications and fixes to documentation.
- More tests.
- Link to v4: https://lore.kernel.org/r/20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org

Changes in v4:
- Implement flags for map_shadow_stack() allowing the cap and end of
  stack marker to be enabled independently or not at all.
- Relax size and alignment requirements for map_shadow_stack().
- Add more blurb explaining the advantages of hardware enforcement.
- Link to v3: https://lore.kernel.org/r/20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org

Changes in v3:
- Rebase onto v6.5-rc4.
- Add a GCS barrier on context switch.
- Add a GCS stress test.
- Link to v2: https://lore.kernel.org/r/20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org

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
Mark Brown (39):
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK
      arm64/mm: Restructure arch_validate_flags() for extensibility
      prctl: arch-agnostic prctl for shadow stack
      mman: Add map_shadow_stack() flags
      arm64: Document boot requirements for Guarded Control Stacks
      arm64/gcs: Document the ABI for Guarded Control Stacks
      arm64/sysreg: Add definitions for architected GCS caps
      arm64/gcs: Add manual encodings of GCS instructions
      arm64/gcs: Provide put_user_gcs()
      arm64/gcs: Provide basic EL2 setup to allow GCS usage at EL0 and EL1
      arm64/cpufeature: Runtime detection of Guarded Control Stack (GCS)
      arm64/mm: Allocate PIE slots for EL0 guarded control stack
      mm: Define VM_SHADOW_STACK for arm64 when we support GCS
      arm64/mm: Map pages for guarded control stack
      KVM: arm64: Manage GCS access and registers for guests
      arm64/idreg: Add overrride for GCS
      arm64/hwcap: Add hwcap for GCS
      arm64/traps: Handle GCS exceptions
      arm64/mm: Handle GCS data aborts
      arm64/gcs: Context switch GCS state for EL0
      arm64/gcs: Ensure that new threads have a GCS
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
      kselftest/arm64: Add GCS signal tests
      kselftest/arm64: Add a GCS stress test
      kselftest/arm64: Enable GCS for the FP stress tests
      KVM: selftests: arm64: Add GCS registers to get-reg-list

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/arch/arm64/booting.rst               |  32 +
 Documentation/arch/arm64/elf_hwcaps.rst            |   2 +
 Documentation/arch/arm64/gcs.rst                   | 230 +++++++
 Documentation/arch/arm64/index.rst                 |   1 +
 Documentation/filesystems/proc.rst                 |   2 +-
 arch/arm64/Kconfig                                 |  20 +
 arch/arm64/include/asm/cpufeature.h                |   6 +
 arch/arm64/include/asm/el2_setup.h                 |  29 +
 arch/arm64/include/asm/esr.h                       |  28 +-
 arch/arm64/include/asm/exception.h                 |   2 +
 arch/arm64/include/asm/gcs.h                       | 107 +++
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/kvm_host.h                  |  12 +
 arch/arm64/include/asm/mman.h                      |  23 +-
 arch/arm64/include/asm/pgtable-prot.h              |  14 +-
 arch/arm64/include/asm/processor.h                 |   7 +
 arch/arm64/include/asm/sysreg.h                    |  20 +
 arch/arm64/include/asm/uaccess.h                   |  40 ++
 arch/arm64/include/asm/vncr_mapping.h              |   2 +
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/include/uapi/asm/ptrace.h               |   8 +
 arch/arm64/include/uapi/asm/sigcontext.h           |   9 +
 arch/arm64/kernel/cpufeature.c                     |  12 +
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/entry-common.c                   |  23 +
 arch/arm64/kernel/pi/idreg-override.c              |   2 +
 arch/arm64/kernel/process.c                        |  88 +++
 arch/arm64/kernel/ptrace.c                         |  54 ++
 arch/arm64/kernel/signal.c                         | 225 ++++++-
 arch/arm64/kernel/traps.c                          |  11 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  49 +-
 arch/arm64/kvm/sys_regs.c                          |  27 +-
 arch/arm64/mm/Makefile                             |   1 +
 arch/arm64/mm/fault.c                              |  40 ++
 arch/arm64/mm/gcs.c                                | 252 +++++++
 arch/arm64/mm/mmap.c                               |  10 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/uapi/asm/mman.h                   |   3 -
 fs/proc/task_mmu.c                                 |   2 +-
 include/linux/mm.h                                 |  18 +-
 include/uapi/asm-generic/mman.h                    |   4 +
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  22 +
 kernel/sys.c                                       |  30 +
 mm/Kconfig                                         |   6 +
 tools/testing/selftests/arm64/Makefile             |   2 +-
 tools/testing/selftests/arm64/abi/hwcap.c          |  19 +
 tools/testing/selftests/arm64/fp/assembler.h       |  15 +
 tools/testing/selftests/arm64/fp/fpsimd-test.S     |   2 +
 tools/testing/selftests/arm64/fp/sve-test.S        |   2 +
 tools/testing/selftests/arm64/fp/za-test.S         |   2 +
 tools/testing/selftests/arm64/fp/zt-test.S         |   2 +
 tools/testing/selftests/arm64/gcs/.gitignore       |   5 +
 tools/testing/selftests/arm64/gcs/Makefile         |  24 +
 tools/testing/selftests/arm64/gcs/asm-offsets.h    |   0
 tools/testing/selftests/arm64/gcs/basic-gcs.c      | 357 ++++++++++
 tools/testing/selftests/arm64/gcs/gcs-locking.c    | 200 ++++++
 .../selftests/arm64/gcs/gcs-stress-thread.S        | 311 +++++++++
 tools/testing/selftests/arm64/gcs/gcs-stress.c     | 530 +++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-util.h       | 100 +++
 tools/testing/selftests/arm64/gcs/libc-gcs.c       | 728 +++++++++++++++++++++
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 .../testing/selftests/arm64/signal/test_signals.c  |  17 +-
 .../testing/selftests/arm64/signal/test_signals.h  |   6 +
 .../selftests/arm64/signal/test_signals_utils.c    |  32 +-
 .../selftests/arm64/signal/test_signals_utils.h    |  39 ++
 .../arm64/signal/testcases/gcs_exception_fault.c   |  62 ++
 .../selftests/arm64/signal/testcases/gcs_frame.c   |  88 +++
 .../arm64/signal/testcases/gcs_write_fault.c       |  67 ++
 .../selftests/arm64/signal/testcases/testcases.c   |   7 +
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  28 +
 74 files changed, 4086 insertions(+), 43 deletions(-)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20230303-arm64-gcs-e311ab0d8729

Best regards,
-- 
Mark Brown <broonie@kernel.org>


