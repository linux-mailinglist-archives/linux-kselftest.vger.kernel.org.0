Return-Path: <linux-kselftest+bounces-35042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA6ADA75E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F020D168751
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 05:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76D1AC88A;
	Mon, 16 Jun 2025 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ghnfkWtR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313E1863E;
	Mon, 16 Jun 2025 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050416; cv=none; b=QpAxdvqtr9bFDaIJfz/Xg9HFQuiGXPG8C4ElGWM9+/hBWSMe5UFgP7PIyS0tZUnA9+Ox4KLWjwkIl9cWsYsW7tSLD0Yqq0BVqa+MCADZqwUT9yTHTSFp+rbDpTQNDZhkhx5MF/hbR69XDB1c2Vdkugpsc460G1znyFeHSXOq1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050416; c=relaxed/simple;
	bh=cA3SwmYgYeSIyOV2poq56YF76ctfNib2sQffxNFTYNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2WKfV3aWqCJ1GyrO1Xu28JYJK6LM/W+XLfAvEDUI2ABxOhhCMbVcLkJkOLekAWjFFJWZyVPSWYnrcAWTy3sf2pg8hIlOV8n8cMaRfPRgH5+OoZyR9A4K4z/Ggu0LhfMGGMZN4j4GPVg+ro0GFz7ZQ01GeTu7F8UNkr6yzFT+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ghnfkWtR; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750050410; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R5GJYlkXT0vSw2Kc0ay2ukzCBmnnFXXk54xXv2Y6mic=;
	b=ghnfkWtRBN2py6eYOj+JEYDUA5ZtoozP4y6ILy4Rc4yRuqyE93ZN6Zoj2y8FTsuGKJQz4jHs5m2hHrMyxW/Iwi7IgZcZKU92RzqYztzSSpRR5ckTAnLGfYvZnE3vUiBWF3xRxdGrUJB0NUCq1Hfv2u54vItfjl7Jaumcw0aZcmo=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WdrrnGW_1750050408 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Jun 2025 13:06:49 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: brauner@kernel.org,
	shuah@kernel.org,
	will@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Subject: [RESEND PATCH] selftests/pidfd: align stack to fix SP alignment exception
Date: Mon, 16 Jun 2025 13:06:48 +0800
Message-ID: <20250616050648.58716-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pidfd_test fails on the ARM64 platform with the following error:

    Bail out! pidfd_poll check for premature notification on child thread exec test: Failed

When exception-trace is enabled, the kernel logs the details:

    #echo 1 > /proc/sys/debug/exception-trace
    #dmesg | tail -n 20
    [48628.713023] pidfd_test[1082142]: unhandled exception: SP Alignment, ESR 0x000000009a000000, SP/PC alignment exception in pidfd_test[400000+4000]
    [48628.713049] CPU: 21 PID: 1082142 Comm: pidfd_test Kdump: loaded Tainted: G        W   E      6.6.71-3_rc1.al8.aarch64 #1
    [48628.713051] Hardware name: AlibabaCloud AliServer-Xuanwu2.0AM-1UC1P-5B/AS1111MG1, BIOS 1.2.M1.AL.P.157.00 07/29/2023
    [48628.713053] pstate: 60001800 (nZCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=-c)
    [48628.713055] pc : 0000000000402100
    [48628.713056] lr : 0000ffff98288f9c
    [48628.713056] sp : 0000ffffde49daa8
    [48628.713057] x29: 0000000000000000 x28: 0000000000000000 x27: 0000000000000000
    [48628.713060] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
    [48628.713062] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000400e80
    [48628.713065] x20: 0000000000000000 x19: 0000000000402650 x18: 0000000000000000
    [48628.713067] x17: 00000000004200d8 x16: 0000ffff98288f40 x15: 0000ffffde49b92c
    [48628.713070] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
    [48628.713072] x11: 0000000000001011 x10: 0000000000402100 x9 : 0000000000000010
    [48628.713074] x8 : 00000000000000dc x7 : 3861616239346564 x6 : 000000000000000a
    [48628.713077] x5 : 0000ffffde49daa8 x4 : 000000000000000a x3 : 0000ffffde49daa8
    [48628.713079] x2 : 0000ffffde49dadc x1 : 0000ffffde49daa8 x0 : 0000000000000000

According to ARM ARM D1.3.10.2 SP alignment checking:

> When the SP is used as the base address of a calculation, regardless of
> any offset applied by the instruction, if bits [3:0] of the SP are not
> 0b0000, there is a misaligned SP.

To fix it, align the stack with 16 bytes.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/testing/selftests/pidfd/pidfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index c081ae91313a..ec161a7c3ff9 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -33,7 +33,7 @@ static bool have_pidfd_send_signal;
 static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 {
 	size_t stack_size = 1024;
-	char *stack[1024] = { 0 };
+	char *stack[1024] __attribute__((aligned(16))) = {0};
 
 #ifdef __ia64__
 	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
-- 
2.39.3


