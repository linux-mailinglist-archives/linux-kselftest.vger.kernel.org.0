Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFF1341BEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 13:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCSMBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 08:01:47 -0400
Received: from foss.arm.com ([217.140.110.172]:47836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCSMBg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 08:01:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA86ED1;
        Fri, 19 Mar 2021 05:01:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831BA3F70D;
        Fri, 19 Mar 2021 05:01:34 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Dave Martin <dave.martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftest/arm64: sve: Do not use non-canonical FFR register value
Date:   Fri, 19 Mar 2021 12:01:28 +0000
Message-Id: <20210319120128.29452-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "First Fault Register" (FFR) is an SVE register that mimics a
predicate register, but clears bits when a load or store fails to handle
an element of a vector. The supposed usage scenario is to initialise
this register (using SETFFR), then *read* it later on to learn about
elements that failed to load or store. Explicit writes to this register
using the WRFFR instruction are only supposed to *restore* values
previously read from the register (for context-switching only).
As the manual describes, this register holds only certain values, it:
"... contains a monotonic predicate value, in which starting from bit 0
there are zero or more 1 bits, followed only by 0 bits in any remaining
bit positions."
Any other value is UNPREDICTABLE and is not supposed to be "restored"
into the register.

The SVE test currently tries to write a signature pattern into the
register, which is *not* a canonical FFR value. Apparently the existing
setups treat UNPREDICTABLE as "read-as-written", but a new
implementation actually only stores canonical values. As a consequence,
the sve-test fails immediately when comparing the FFR value:
-----------
 # ./sve-test
Vector length:  128 bits
PID:    207
Mismatch: PID=207, iteration=0, reg=48
        Expected [cf00]
        Got      [0f00]
Aborted
-----------

Fix this by only populating the FFR with proper canonical values.
Effectively the requirement described above limits us to 17 unique
values over 16 bits worth of FFR, so we condense our signature down to 4
bits (2 bits from the PID, 2 bits from the generation) and generate the
canonical pattern from it. Any bits describing elements above the
minimum 128 bit are set to 0.

This aligns the FFR usage to the architecture and fixes the test on
microarchitectures implementing FFR in a more restricted way.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/fp/sve-test.S | 22 ++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index 9210691aa998..e3e08d9c7020 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -284,16 +284,28 @@ endfunction
 // Set up test pattern in the FFR
 // x0: pid
 // x2: generation
+//
+// We need to generate a canonical FFR value, which consists of a number of
+// low "1" bits, followed by a number of zeros. This gives us 17 unique values
+// per 16 bits of FFR, so we create a 4 bit signature out of the PID and
+// generation, and use that as the initial number of ones in the pattern.
+// We fill the upper lanes of FFR with zeros.
 // Beware: corrupts P0.
 function setup_ffr
 	mov	x4, x30
 
-	bl	pattern
+	and	w0, w0, #0x3
+	bfi	w0, w2, #2, #2
+	mov	w1, #1
+	lsl	w1, w1, w0
+	sub	w1, w1, #1
+
 	ldr	x0, =ffrref
-	ldr	x1, =scratch
-	rdvl	x2, #1
-	lsr	x2, x2, #3
-	bl	memcpy
+	strh	w1, [x0], 2
+	rdvl	x1, #1
+	lsr	x1, x1, #3
+	sub	x1, x1, #2
+	bl	memclr
 
 	mov	x0, #0
 	ldr	x1, =ffrref
-- 
2.25.1

