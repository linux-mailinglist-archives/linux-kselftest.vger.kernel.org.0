Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3966C591
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjAPQHf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjAPQHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:07:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9EE23DB8;
        Mon, 16 Jan 2023 08:05:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45456B81065;
        Mon, 16 Jan 2023 16:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC8EC433F0;
        Mon, 16 Jan 2023 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885113;
        bh=Q3wktHXCI86PXr4+9EjWx1HljepbsTWh5wqI8kTDtCk=;
        h=From:Subject:Date:To:Cc:From;
        b=jvKaj8xJ34Z7shux/o6XMVFvIIV5o5M2TBaYFj2UUEiXq2DCFNPbUYzIt38nlPuWt
         MWAH9CFGclQ6XbIZu4aB4zuyCi9czfDeN+U6IOABCp7dwAf9/spRmGFX+Wd4Xtq+yU
         ff7mMtyWXjPot7sniFN3pS8+drd/NrFVPJLYWCEuXsUOf2lsejWlgx1syC1Ww6aXMY
         Owx5CsOh0aOcnBh+nyIkB2Un5Tx7Ed5oDwOVOkXmusgG/CyxBB4/Ql54tICIk6uU4V
         TU7yV8M61W/Ip4xV8IW2W8LM73Ecvj/3ROz25kUOeWCvpoKAJWPFeRA1qirnrWldgR
         U/rKLJfhortsA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 00/21] arm64/sme: Support SME 2 and SME 2.1
Date:   Mon, 16 Jan 2023 16:04:36 +0000
Message-Id: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJV1xWMC/0WOTQ6CMBCFr2K6tkinCMSV9zAuCg50ou2YKTEaw
 t1t3fh2X17ez6oSCmFSp92qBF+UiGOGZr9To3dxRk23zApqAAN1r52EttEpIGjb2hE6gM5ZUDk
 wuIR6EBdHXyIsNFM8BJcWlOI/BSd6/8Yu18yTcNCLF3T/iSwwxxraqjfWNr02uZE5Ep7vKBEfF
 ctcyjylheVTjm/b9gUC7wQuyAAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=6123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Q3wktHXCI86PXr4+9EjWx1HljepbsTWh5wqI8kTDtCk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWh0+2OzptKAnHSt3axZTyIsKBsrLaFSjuZUWB9
 2sxec32JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1oQAKCRAk1otyXVSH0MGUB/
 4/lmDcnV/trsUSXY+Sbr6erD7a1ZpFEvvHjM6KBNDvuOaA/fnKAKd9LJzw5+xd+AMAkOs4RTdZ3b3e
 FILKaXD7qIFL/hdPaWnaWckzxURpDk2jU2b8zik+jo6MFJuOdhtR/ewGeq2H8jmlhdIfX8FVF5EsQ8
 wmq0x4d3UEqG4Ii9WCzI437P7spMLQ/K1dTFoL9Orfua4k5fxU9BggFFObOlwZFYNjKwY8abvaiJjg
 DeALM2vMAKXrRXDTzvYA9BHmev5kPGKgRNBbe3hfhluIjC0Omz3eXpkq+tkdG1GlgPFWPV54Ghg7IA
 NKiB+31RkzrIyewmTGq0MiLypGDwq6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Arm have recently released versions 2 and 2.1 of the SME extension.
Among the features introduced by SME 2 is some new architectural state,
the ZT0 register. This series adds support for this and all the other
features of the new SME versions.

Since the architecture has been designed with the possibility of adding
further ZTn registers in mind the interfaces added for ZT0 are done with
this possibility in mind. As ZT0 is a simple fixed size register these
interfaces are all fairly simple, the main complication is that ZT0 is
only accessible when PSTATE.ZA is enabled. The memory allocation that we
already do for PSTATE.ZA is extended to include space for ZT0.

Due to textual collisions especially around the addition of hwcaps this
is based on the recently merged series "arm64: Support for 2022 data
processing instructions" but there is no meaningful interaction.  There
will be collisions with "arm64/signal: Signal handling cleanups" if that
is applied but again not super substantial.

v4:
 - Rebase onto v6.2-rc3.
 - Add SME2 value to ID_AA64PFR1_EL1.SME and move cpufeature to key off
   it.
 - Fix cut'n'paste errors and missing capability in hwcap table.
 - Fix bitrot in za-test program.
 - Typo and cut'n'paste fixes.
v3:
 - Rebase onto merged series for the 2022 architectur extensions.
 - Clarifications and typo fixes in the ABI documentation.
v2:
 - Add missing initialisation of user->zt in signal context parsing.
 - Change the magic for ZT signal frames to 0x5a544e01 (ZTN0).

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
To: Marc Zyngier <maz@kernel.org>
To: James Morse <james.morse@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Alan Hayward <alan.hayward@arm.com>
Cc: Luis Machado <luis.machado@arm.com>,
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.linux.dev
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org

---
Mark Brown (21):
      arm64/sme: Rename za_state to sme_state
      arm64: Document boot requirements for SME 2
      arm64/sysreg: Update system registers for SME 2 and 2.1
      arm64/sme: Document SME 2 and SME 2.1 ABI
      arm64/esr: Document ISS for ZT0 being disabled
      arm64/sme: Manually encode ZT0 load and store instructions
      arm64/sme: Enable host kernel to access ZT0
      arm64/sme: Add basic enumeration for SME2
      arm64/sme: Provide storage for ZT0
      arm64/sme: Implement context switching for ZT0
      arm64/sme: Implement signal handling for ZT
      arm64/sme: Implement ZT0 ptrace support
      arm64/sme: Add hwcaps for SME 2 and 2.1 features
      kselftest/arm64: Add a stress test program for ZT0
      kselftest/arm64: Cover ZT in the FP stress test
      kselftest/arm64: Enumerate SME2 in the signal test utility code
      kselftest/arm64: Teach the generic signal context validation about ZT
      kselftest/arm64: Add test coverage for ZT register signal frames
      kselftest/arm64: Add SME2 coverage to syscall-abi
      kselftest/arm64: Add coverage of the ZT ptrace regset
      kselftest/arm64: Add coverage of SME 2 and 2.1 hwcaps

 Documentation/arm64/booting.rst                    |  10 +
 Documentation/arm64/elf_hwcaps.rst                 |  18 +
 Documentation/arm64/sme.rst                        |  52 ++-
 arch/arm64/include/asm/cpufeature.h                |   6 +
 arch/arm64/include/asm/esr.h                       |   1 +
 arch/arm64/include/asm/fpsimd.h                    |  30 +-
 arch/arm64/include/asm/fpsimdmacros.h              |  22 ++
 arch/arm64/include/asm/hwcap.h                     |   6 +
 arch/arm64/include/asm/processor.h                 |   2 +-
 arch/arm64/include/uapi/asm/hwcap.h                |   6 +
 arch/arm64/include/uapi/asm/sigcontext.h           |  19 ++
 arch/arm64/kernel/cpufeature.c                     |  28 ++
 arch/arm64/kernel/cpuinfo.c                        |   6 +
 arch/arm64/kernel/entry-fpsimd.S                   |  30 +-
 arch/arm64/kernel/fpsimd.c                         |  47 ++-
 arch/arm64/kernel/hyp-stub.S                       |   6 +
 arch/arm64/kernel/idreg-override.c                 |   1 +
 arch/arm64/kernel/process.c                        |  21 +-
 arch/arm64/kernel/ptrace.c                         |  60 +++-
 arch/arm64/kernel/signal.c                         | 113 ++++++-
 arch/arm64/kvm/fpsimd.c                            |   2 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            |  27 +-
 include/uapi/linux/elf.h                           |   1 +
 tools/testing/selftests/arm64/abi/hwcap.c          | 115 +++++++
 .../testing/selftests/arm64/abi/syscall-abi-asm.S  |  43 ++-
 tools/testing/selftests/arm64/abi/syscall-abi.c    |  40 ++-
 tools/testing/selftests/arm64/fp/.gitignore        |   2 +
 tools/testing/selftests/arm64/fp/Makefile          |   5 +
 tools/testing/selftests/arm64/fp/fp-stress.c       |  29 +-
 tools/testing/selftests/arm64/fp/sme-inst.h        |  20 ++
 tools/testing/selftests/arm64/fp/zt-ptrace.c       | 365 +++++++++++++++++++++
 tools/testing/selftests/arm64/fp/zt-test.S         | 317 ++++++++++++++++++
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 .../testing/selftests/arm64/signal/test_signals.h  |   2 +
 .../selftests/arm64/signal/test_signals_utils.c    |   3 +
 .../selftests/arm64/signal/testcases/testcases.c   |  36 ++
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 .../selftests/arm64/signal/testcases/zt_no_regs.c  |  51 +++
 .../selftests/arm64/signal/testcases/zt_regs.c     |  85 +++++
 40 files changed, 1558 insertions(+), 72 deletions(-)
---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20221208-arm64-sme2-363c27227a32

Best regards,
-- 
Mark Brown <broonie@kernel.org>

