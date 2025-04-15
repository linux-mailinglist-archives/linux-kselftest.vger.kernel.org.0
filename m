Return-Path: <linux-kselftest+bounces-30824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F4A89475
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BED1892890
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4F279799;
	Tue, 15 Apr 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUbou5o2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTUchqFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794E1C75E2;
	Tue, 15 Apr 2025 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701023; cv=none; b=AJ6k9CJGQVcLZEFfYNOBcufVaAo+B8WeuaMgRWdhGWrZn+qE8Dl4uVg0963hTWi7u7/yqoEASghEcBckP9sQ7iforjWYnS6Zq/5JF40c5AMdMYr2LleYDdQ7kYI5aPFgUsr/K4LMlmWFYnE8wTyI/zuT/3Pvdy26ghqY30+SkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701023; c=relaxed/simple;
	bh=fkJPcXJit+W3qIQd6VMMhI3vY+EbDB0ZevWFrZ/+KB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dE8mLKGiR08Pu2o7aCX2Nr2RWB14a+Q/4GpdfiSAfghhpM4d+tCvpDgcbEkjzruLVOCatL9wtPCGqKyqHogcIa8SAMrUoSVyIPB6Glh7lTReaHYGg1RSzR13EwNZ/N0wt4c4Vx9hQwQZO1jY//0KaC5OIKOXg64zHEwfKmK9M6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUbou5o2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTUchqFe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744701019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epjuZfJroOLO9xJ2KiENqWwUAD3mubdM2Vd3hLojwFo=;
	b=bUbou5o27DjSjO8LZaErGnofYMEf8CCQC7LvHe3EwW7waBmZyus/zxW4n+/0AJpbau6S8O
	a0xpV/D7mAsju4JYsm56Nx7aTKmXWLW0Oc/dQo8OhjeXbBogIuJLjGFZEp+n2LG16KLpVh
	IfSGaYaVBybXXX9L5DTGjPQSY05+xITHHg3k2iIxKNY1dUz07x/94F7NebK57Z+m5Vmm4d
	oRkmJ+Ry+irgvpsn5pfcM6WVA4IO8V1JrmtqVImHMkmMMnUB/xCsKA5rExIWLCt4HP1hwE
	mlAya+uLcK6bqopFlper5rrAtF3786RSSNmAgpINEg6AR+mMdkWlt6+jYNPc8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744701019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epjuZfJroOLO9xJ2KiENqWwUAD3mubdM2Vd3hLojwFo=;
	b=aTUchqFeljQr+SL9csTDQOhx+ft+I4K7GnYudvZhWTYB1Mbsrse9p33cTgvsqetWFMOGxH
	9fz3JxuJDnck0ADQ==
Date: Tue, 15 Apr 2025 09:10:06 +0200
Subject: [PATCH v3 1/2] MIPS: Don't crash in stack_top() for tasks without
 ABI or vDSO
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-kunit-mips-v3-1-4ec2461b5a7e@linutronix.de>
References: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de>
In-Reply-To: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744701019; l=1899;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fkJPcXJit+W3qIQd6VMMhI3vY+EbDB0ZevWFrZ/+KB8=;
 b=dKWINiEZ+W1g8lHBxU+Rc2cIfxVVf30pIo48wkWPmSqxAaIiywN4PDcLyivticda4Bok+4mAe
 HBxX1FfaTcNBTsV9AAJITJ2GzkxXBU0v/jR8stnBbhrMo3IyZnkY78/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Not all tasks have an ABI associated or vDSO mapped,
for example kthreads never do.
If such a task ever ends up calling stack_top(), it will derefence the
NULL ABI pointer and crash.

This can for example happen when using kunit:

    mips_stack_top+0x28/0xc0
    arch_pick_mmap_layout+0x190/0x220
    kunit_vm_mmap_init+0xf8/0x138
    __kunit_add_resource+0x40/0xa8
    kunit_vm_mmap+0x88/0xd8
    usercopy_test_init+0xb8/0x240
    kunit_try_run_case+0x5c/0x1a8
    kunit_generic_run_threadfn_adapter+0x28/0x50
    kthread+0x118/0x240
    ret_from_kernel_thread+0x14/0x1c

Only dereference the ABI point if it is set.

Also move the randomization adjustment into the same conditional.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/kernel/process.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index b630604c577f9ff3f2493b0f254363e499c8318c..02aa6a04a21da437909eeac4f149155cc298f5b5 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -690,18 +690,20 @@ unsigned long mips_stack_top(void)
 	}
 
 	/* Space for the VDSO, data page & GIC user page */
-	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
-	top -= PAGE_SIZE;
-	top -= mips_gic_present() ? PAGE_SIZE : 0;
+	if (current->thread.abi) {
+		top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+		top -= PAGE_SIZE;
+		top -= mips_gic_present() ? PAGE_SIZE : 0;
+
+		/* Space to randomize the VDSO base */
+		if (current->flags & PF_RANDOMIZE)
+			top -= VDSO_RANDOMIZE_SIZE;
+	}
 
 	/* Space for cache colour alignment */
 	if (cpu_has_dc_aliases)
 		top -= shm_align_mask + 1;
 
-	/* Space to randomize the VDSO base */
-	if (current->flags & PF_RANDOMIZE)
-		top -= VDSO_RANDOMIZE_SIZE;
-
 	return top;
 }
 

-- 
2.49.0


