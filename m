Return-Path: <linux-kselftest+bounces-44655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFDC2D006
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 17:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02586188276A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D8314B97;
	Mon,  3 Nov 2025 16:04:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC8227FB28
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185877; cv=none; b=S1WYDmb4nLGqlpxr/EPjLX1v7+843OWxRMfUsCW84M+2dVp0ZHYQi+4tIVEdPSauNL9W1XHIORQ+0M1NwI3GwEoP71AEZd3LVDk5WmGB2cyanoTZtshztl5R3pjNrnwBOON1fHYKqZtGgpg+mqD26mCLo8JiIFnz4rrwtNA/01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185877; c=relaxed/simple;
	bh=W9Bt/AmsRN75NCm5kq1SoP4obRWQswPFKzwMFLX7P/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Or7X/yhV0KaOdednCMUKOtVuMUYg86OuT4njfR7C549UQ0PI7qzTlcxvwcEp3vAyv1t9/ctqHa60gSXg0r4miVCu0wZX4NQQiORVHc7ECXw0YLRHjm3f9cJEyw8f0Bh1XUX8MLI/4f9FHaNGk5lndRdI7/raikMtfy6n5V5ERpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C051D14;
	Mon,  3 Nov 2025 08:04:27 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 961063F694;
	Mon,  3 Nov 2025 08:04:33 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	linux-kselftest@vger.kernel.org,
	mark.rutland@arm.com,
	shuah@kernel.org,
	will@kernel.org
Subject: [PATCH] kselftest/arm64: Align zt-test register dumps
Date: Mon,  3 Nov 2025 16:04:17 +0000
Message-Id: <20251103160417.1023545-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zt-test output is awkward to read, as the 'Expected' value isn't
dumped on its own line and isn't aligned with the 'Got' value beneath.
For example:

  Mismatch: PID=5281, iteration=3270249   Expected [00a1146901a1146902a1146903a1146904a1146905a1146906a1146907a1146908a1146909a114690aa114690ba114690ca114690da114690ea114690fa11469]
          Got      [00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000]
          SVCR: 2

Add a newline, matching the other FPSIMD/SVE/SME tests, so that we get
output that can be read more easily:

  Mismatch: PID=5281, iteration=3270249
          Expected [00a1146901a1146902a1146903a1146904a1146905a1146906a1146907a1146908a1146909a114690aa114690ba114690ca114690da114690ea114690fa11469]
          Got      [00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000]
          SVCR: 2

Admittedly this isn't all that important when the 'Got' value is all
zeroes, but otherwise this would be a major help for identifying which
portion of the 'Got' value is not as expected.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/arm64/fp/zt-test.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index 38080f3c32804..a8df057716707 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -276,7 +276,7 @@ function barf
 	bl	putdec
 	puts	", iteration="
 	mov	x0, x22
-	bl	putdec
+	bl	putdecn
 	puts	"\tExpected ["
 	mov	x0, x10
 	mov	x1, x12
-- 
2.30.2


