Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99C6263CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKKVuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKKVuy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:50:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928D26B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3169262101
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD26C433C1;
        Fri, 11 Nov 2022 21:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203452;
        bh=wC5rIXwXyylf9Tv2pi978ygG4zhXBTcxhQev0+pCowM=;
        h=From:To:Cc:Subject:Date:From;
        b=FLkJt/bEP/BsXwRbGNkin1X4qW6Fhi9nJrobNRe3JEEISqCMOyYXykp/YAh3AcPV/
         BZ+2uoyyEp2o5PSong98TJytukCx70jBACjVL91AJ33AZRyLMc+2BnMG4+joovw9Cp
         Z7m0UYAUw8coQ6TzhebU5UmSarl7WX62Kyfz8LN90KcytOHto1A/SlFNIz8nT0fonD
         008GIaED4zhCE9msoVN6wNYoV6/aAKI3pbS+VNAWLLxoXY3dwxZaeOnL7yNeaJBP3W
         I7uhAVYvg/e7mPScnXiUWHGuYjLVbd6WB8u0c1gwJI0OjFRlPQSEAZNRqMHsYFQvab
         62n0U6V8EFECg==
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
Subject: [PATCH v3 00/21] arm64/sme: Support SME 2 and SME 2.1
Date:   Fri, 11 Nov 2022 21:50:05 +0000
Message-Id: <20221111215026.813348-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4959; i=broonie@kernel.org; h=from:subject; bh=wC5rIXwXyylf9Tv2pi978ygG4zhXBTcxhQev0+pCowM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsONxQWdRyyO3u5SmsA4FRdrm08A3F5vTgWYB2v9 RLQ5QvKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DjQAKCRAk1otyXVSH0FF6B/ 9+80eqY1db4H/SdIMd+09JJ1SxQo8rWXiKQ7ejqxgUHVTkIwiNdNiQ3SBoOVPkOl7CfaYiW8BwfMdP MkI9PRxkSJD7SJLwU3WmEcWNhUrA+thz5ErN/viob4PuTHM7RjuobU7Zj46eQk4DsC7IfTmU8UnrRh GrsHY5Eo5fokK52JEBp6Pm45cs1b8iq/4/8+bYmob+j6nTVQTox2qkxkwAyQL16Eijtvm0FqpGRcKv T33DxcAJxsxY1/mKRhu5SRrPa1vWfKKwZ5yR7WQjSqYlsfvcFpZtdXzmK0DFQM9dCpTWzVGLfrACRU La7ZYqHzOToMWoa804ctTp7cFTZi3Q
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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
processing instructions" but there is no meaningful interaction.

v3:
 - Rebase onto merged series for the 2022 architectur extensions.
 - Clarifications and typo fixes in the ABI documentation.
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


base-commit: c5195b027d29bbaae0c9668704ab996773788d23
-- 
2.30.2

