Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540DE49E75C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 17:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243605AbiA0QV6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 11:21:58 -0500
Received: from foss.arm.com ([217.140.110.172]:42096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238119AbiA0QV6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 11:21:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D00BB1063;
        Thu, 27 Jan 2022 08:21:57 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACBDD3F766;
        Thu, 27 Jan 2022 08:21:56 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        james.morse@arm.com
Subject: [PATCH 0/3] arm64: insn: Generate 64 bit mask immediates correctly
Date:   Thu, 27 Jan 2022 16:21:24 +0000
Message-Id: <20220127162127.2391947-1-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

aarch64_insn_gen_logical_immediate() is generating the wrong code if
it is handed a 64bit immediate which has a single span of 1s (i.e. a
mask), with bit 63 set, and 0s in the remaining upper 32 bits.
Clear as mud. An example always helps: 0x800000003fffffff would be wrongly
encoded, but 0x000000003fffffff is unaffected.

It would appear eBPF is unable to hit these cases, as build_insn()'s
imm value is a s32, so when used with BPF_ALU64, the sign-extended
u64 immediate would always have all-1s or all-0s in the upper 32 bits.

KVM does not generate a va_mask with any of the top bits set as these
VA wouldn't be usable with TTBR0_EL2.

Patch 3 fixes it, and doesn't depend on the rest of the series.

As the instruction encoder is a source of headaches, the first two patches
add tests to help illustrate there is a problem, and that patch 3 fixes it.

The tests generate a header file of the expected values so it can be compared
against other sources of the same information. Objdump can be used to check
the header file is generated correctly. Embedding the code in gen_logic_imm in
test_insn.c would give less confidence that the encoder is doing the right thing.

This series is based on v5.17-rc1, and can be retrieved from:
https://git.gitlab.arm.com/linux-arm/linux-jm.git insn_encoder/fls_bug/v1

Thanks,

James Morse (3):
  arm64: selftests: Generate all the possible logical immediates as a
    header
  arm64: insn: Add tests for aarch64_insn_gen_logical_immediate()
  arm64: insn: Generate 64 bit mask immediates correctly

 arch/arm64/Kconfig.debug                   |   3 +
 arch/arm64/Makefile                        |   3 +
 arch/arm64/lib/Makefile                    |   2 +
 arch/arm64/lib/insn.c                      |   5 +-
 arch/arm64/lib/test_insn.c                 |  90 ++++++++++
 arch/arm64/tools/.gitignore                |   2 +
 arch/arm64/tools/Makefile                  |  12 +-
 arch/arm64/tools/gen_logic_imm.c           | 190 +++++++++++++++++++++
 tools/testing/selftests/arm64/Makefile     |   2 +-
 tools/testing/selftests/arm64/lib/Makefile |   6 +
 tools/testing/selftests/arm64/lib/config   |   1 +
 tools/testing/selftests/arm64/lib/insn.sh  |   5 +
 12 files changed, 318 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/lib/test_insn.c
 create mode 100644 arch/arm64/tools/.gitignore
 create mode 100644 arch/arm64/tools/gen_logic_imm.c
 create mode 100644 tools/testing/selftests/arm64/lib/Makefile
 create mode 100644 tools/testing/selftests/arm64/lib/config
 create mode 100755 tools/testing/selftests/arm64/lib/insn.sh

-- 
2.30.2

