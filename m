Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43249E75F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbiA0QWF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 11:22:05 -0500
Received: from foss.arm.com ([217.140.110.172]:42126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238119AbiA0QWE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 11:22:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94762113E;
        Thu, 27 Jan 2022 08:22:04 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A9EE3F766;
        Thu, 27 Jan 2022 08:22:03 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        james.morse@arm.com
Subject: [PATCH 3/3] arm64: insn: Generate 64 bit mask immediates correctly
Date:   Thu, 27 Jan 2022 16:21:27 +0000
Message-Id: <20220127162127.2391947-4-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127162127.2391947-1-james.morse@arm.com>
References: <20220127162127.2391947-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the insn framework is used to encode an AND/ORR/EOR instruction,
aarch64_encode_immediate() is used to pick the immr imms values.

If the immediate is a 64bit mask, with bit 63 set, and zeros in any
of the upper 32 bits, the immr value is incorrectly calculated meaning
the wrong mask is generated.
For example, 0x8000000000000001 should have an immr of 1, but 32 is used,
meaning the resulting mask is 0x0000000300000000.

It would appear eBPF is unable to hit these cases, as build_insn()'s
imm value is a s32, so when used with BPF_ALU64, the sign-extended
u64 immediate would always have all-1s or all-0s in the upper 32 bits.

KVM does not generate a va_mask with any of the top bits set as these
VA wouldn't be usable with TTBR0_EL2.

This happens because the rotation is calculated from fls(~imm), which
takes an unsigned int, but the immediate may be 64bit.

Use fls64() so the 64bit mask doesn't get truncated to a u32.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/lib/insn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 8888e407032f..90253af7e294 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -1381,7 +1381,7 @@ static u32 aarch64_encode_immediate(u64 imm,
 		 * Compute the rotation to get a continuous set of
 		 * ones, with the first bit set at position 0
 		 */
-		ror = fls(~imm);
+		ror = fls64(~imm);
 	}
 
 	/*
-- 
2.30.2

