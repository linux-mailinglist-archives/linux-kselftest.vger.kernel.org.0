Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF282614CCA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiKAOjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiKAOjR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C77C12AFF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D038615ED
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC8FC4347C;
        Tue,  1 Nov 2022 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313554;
        bh=ok3wYYqC7asNixuLaykmjB8Ko0NgKTtAQ/Cl83MNXzs=;
        h=From:To:Cc:Subject:Date:From;
        b=p70KkQJL1Tuut1cUOZsPQ8Tt6mZgcRl1gqxM8etcuDMdO1ls/HLihveotxXrCmck4
         T3e8SNX+2ziwlDHi8WGmHo/rIuJOHH/jkKV9NZ4bjyy8vk2tjK04qHY/MQ+DjrF4Q5
         ij+qyOFzGoRmQvT3O2AKw0WmP5kq1O/kOlV12B98jEm4IafrsZIoeia889LopBkr98
         pMztVkZGTh7QXCqo71wyLXDcLO7dsCIENHyEIakciDQ8Oukv9h3rvKH72MZn8aikVQ
         SkKSvGWHTF5JI98ZmipOLyuKDo+ckkbNpNjp0R0OKkC1YSxZi3zHw3EvA3+RsbwlOM
         ryg/vKdfb9tqA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 00/21] arm64/sme: Support SME 2 and SME 2.1
Date:   Tue,  1 Nov 2022 14:33:15 +0000
Message-Id: <20221101143336.254445-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4829; i=broonie@kernel.org; h=from:subject; bh=ok3wYYqC7asNixuLaykmjB8Ko0NgKTtAQ/Cl83MNXzs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4oWoIMjR2dfXV7XDAG9hSn5Yrn7uSgd+w/U/jI pQ2ax4uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuKAAKCRAk1otyXVSH0FI+CA CFYT4Bz/DVqkCRLsQrJTIN41XjAmI3GO9XMlQmO8pz9byCih3FyvXY/HjWNRf+Y6hdEpGuAiI1uNSl LbyslB2Pa7K6MqI06K1M4YtDDNHf91SHgJYo6xNGd/pJ5hUV7PHmZR8AyhQCm+JmFDM3DYbqgX6Odk yeQa9eXvUVD5Lxk0HCUoo73YkgIeeqHo1gUznrOp6aRqhaQ+JgQVOOyb7Oa5pg+GSVB3XDGlym5cPP lRtQH/lNKKy2lgSKnVF1cLelqg+sFqUnGo0JtAFNEnxlYa62jmD6sBpFTGW2mSUFl6mowVlIcUAGrr 7WhSeolE1289KkUxIRy8rhTae+Q2mH
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
is based on the concurrently sent series "arm64: Support for 2022 data
processing instructions" but there is no meaningful interaction.

v2:
 - Add missing initialisation of user->zt in signal context parsing.
 - Change the magic for ZT signal frames to 0x5a544e01 (ZTN0).

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

 Documentation/arm64/booting.rst               |  10 +
 Documentation/arm64/elf_hwcaps.rst            |  18 +
 Documentation/arm64/sme.rst                   |  52 ++-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/esr.h                  |   1 +
 arch/arm64/include/asm/fpsimd.h               |  28 +-
 arch/arm64/include/asm/fpsimdmacros.h         |  22 ++
 arch/arm64/include/asm/hwcap.h                |   6 +
 arch/arm64/include/asm/processor.h            |   2 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   6 +
 arch/arm64/include/uapi/asm/sigcontext.h      |  19 +
 arch/arm64/kernel/cpufeature.c                |  27 ++
 arch/arm64/kernel/cpuinfo.c                   |   6 +
 arch/arm64/kernel/entry-fpsimd.S              |  30 +-
 arch/arm64/kernel/fpsimd.c                    |  53 ++-
 arch/arm64/kernel/hyp-stub.S                  |   6 +
 arch/arm64/kernel/idreg-override.c            |   1 +
 arch/arm64/kernel/process.c                   |  21 +-
 arch/arm64/kernel/ptrace.c                    |  60 ++-
 arch/arm64/kernel/signal.c                    | 113 +++++-
 arch/arm64/tools/cpucaps                      |   1 +
 arch/arm64/tools/sysreg                       |  26 +-
 include/uapi/linux/elf.h                      |   1 +
 tools/testing/selftests/arm64/abi/hwcap.c     | 115 ++++++
 .../selftests/arm64/abi/syscall-abi-asm.S     |  43 ++-
 .../testing/selftests/arm64/abi/syscall-abi.c |  40 +-
 tools/testing/selftests/arm64/fp/.gitignore   |   2 +
 tools/testing/selftests/arm64/fp/Makefile     |   5 +
 tools/testing/selftests/arm64/fp/fp-stress.c  |  29 +-
 tools/testing/selftests/arm64/fp/sme-inst.h   |  20 +
 tools/testing/selftests/arm64/fp/zt-ptrace.c  | 365 ++++++++++++++++++
 tools/testing/selftests/arm64/fp/zt-test.S    | 324 ++++++++++++++++
 .../testing/selftests/arm64/signal/.gitignore |   1 +
 .../selftests/arm64/signal/test_signals.h     |   2 +
 .../arm64/signal/test_signals_utils.c         |   3 +
 .../arm64/signal/testcases/testcases.c        |  36 ++
 .../arm64/signal/testcases/testcases.h        |   1 +
 .../arm64/signal/testcases/zt_no_regs.c       |  51 +++
 .../arm64/signal/testcases/zt_regs.c          |  85 ++++
 39 files changed, 1564 insertions(+), 73 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/fp/zt-ptrace.c
 create mode 100644 tools/testing/selftests/arm64/fp/zt-test.S
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/zt_no_regs.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/zt_regs.c


base-commit: ab0aff0601c29dc7b5cb2ecf42135dccbed6750a
-- 
2.30.2

