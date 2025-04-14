Return-Path: <linux-kselftest+bounces-30658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D4A87A62
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 10:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120651892FF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCB25A62C;
	Mon, 14 Apr 2025 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="41OAV4c5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/H68LJo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811C2036E8;
	Mon, 14 Apr 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619198; cv=none; b=e7BNeXNY8AVkyTIerGa7Ehlov7MAAisIsdQCPmohZ5Z7SLjgAAAbNPP67nLHaSyxgWKBXFsG++ZD0Rx8aN0RY/jesW8NZRDwLE911qtF1mDpYquhXJHnNDMiadeH4jU2mx7UxPO2MksAOfvAJgl7/z6xB4rKYLxYOJg8hfMVAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619198; c=relaxed/simple;
	bh=+v9O42/jKIW7CTIjv9DwE8PnTyR58tTR0EOo533umeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S720tzPekkT+UeidTSlyXYo+rJeA6OGzTa++pv37CjJfF/NGvWDqj2RZ4DU5ajQJjqSRwNV1gDvtgviudJXTRFC5xtFBKE5dXKLpx0ONZndsFsvQTEJE5Ge4FdvFz8tg6dfWdSSEUWnf8Mngm1LqS5xHNTJlqfRDjtqbNA9lLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=41OAV4c5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/H68LJo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WJSvov+Yo8g8l96RelJpS4hHhCjdzXvb7xveVYD2cY=;
	b=41OAV4c5Q7sgdEGtW8e+vUGsF7S4XfbuiBFGepFO7v5mxp/zOjc11q7eJnUGoE6mAlB/5o
	mFKleEhnfrSS6VEzehSuEhwzkY23unqT25QV0MruLjcdt8qn/6ZJuaoPQNNYgpONf+QawV
	PWAd5mDKSuVzRo7IPiIQPj1AmW+6fZCm3gEawD7T45E5RdSs7zEYg1FKF0+zxmWnz+1iP9
	TK/XyeYI8EL+z7JcYbp5n2/CWIoC+cKGsGvwA6mqu1DE9kDikXBb625bMIZIFloA75bWqy
	qLafwHrDP7K4cChk/t1YsEsBNrwLzF+85QxsYEhpfygUYN7QbZjqKE+nKkTDfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WJSvov+Yo8g8l96RelJpS4hHhCjdzXvb7xveVYD2cY=;
	b=N/H68LJoqZ1KJ2TtIgG6NYO8Zw94RzBA/fzRWZo+BsfUtvie7oiLPYwO79jNmxD7ge3ANm
	bWl7mIoOHiHzQ4BQ==
Date: Mon, 14 Apr 2025 10:26:21 +0200
Subject: [PATCH v2 1/2] MIPS: Don't crash in stack_top() for tasks without
 ABI or vDSO
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-kunit-mips-v2-1-4cf01e1a29e6@linutronix.de>
References: <20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de>
In-Reply-To: <20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619194; l=1484;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+v9O42/jKIW7CTIjv9DwE8PnTyR58tTR0EOo533umeg=;
 b=DKi1waXZObrUy4j8gK6IvY17CZA6OAWQNI+q6wdd7F5IU8FzJnEfHf8i0h3p9Ra6BnX/AspHt
 Tbf0D+GVakXBDqwzehcmtPUCUISUtM0OULDa1yfIyHqxGCYpBtTQ96Y
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Not all tasks have an ABI associated or vDSO mapped,
for example kthreads never do.
If such a task ever ends up calling stack_top(), it will derefence the
NULL vdso pointer and crash.

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

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/kernel/process.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index b630604c577f9ff3f2493b0f254363e499c8318c..66343cb6c1737c4217ddd8a2c3ca244fac0ef8a5 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -690,9 +690,11 @@ unsigned long mips_stack_top(void)
 	}
 
 	/* Space for the VDSO, data page & GIC user page */
-	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
-	top -= PAGE_SIZE;
-	top -= mips_gic_present() ? PAGE_SIZE : 0;
+	if (current->thread.abi) {
+		top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+		top -= PAGE_SIZE;
+		top -= mips_gic_present() ? PAGE_SIZE : 0;
+	}
 
 	/* Space for cache colour alignment */
 	if (cpu_has_dc_aliases)

-- 
2.49.0


