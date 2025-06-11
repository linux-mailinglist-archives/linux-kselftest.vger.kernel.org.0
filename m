Return-Path: <linux-kselftest+bounces-34691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC9AD53E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 13:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681351794C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD725BF0E;
	Wed, 11 Jun 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MAuQdRZ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGEvyC0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660F52E610C;
	Wed, 11 Jun 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641321; cv=none; b=K1aDIWlsRc4t9V4GmFO1wrd18NgSCBHRVe8ieBQ24csnAopVpMwUROJuD0HVWCn/A5XYYdG6e2CFTkfwJGZEmvlBV+sfdd4/xord1JBsiGcU0Ir53PZg5vddh9zrhIb7VekZzsIpql8ceVGR/aw9Mm/LbH9aq9r3wLHlMWL+Qv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641321; c=relaxed/simple;
	bh=T6q2yFdgakZEOZU9u/ytjbTNL39PdbxoVInLilVt3Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O540z5O6Dt6+kydF8CaoNWEVsYJfjWO3tskybkY3mLDn5szW33YI8wdmuzgLRqiCT2PIRJ0ELVxqh10QDXWiL3nChCWMJk49At4D1CyGAQKNgHDRJ7LevPFIBV7iFf6Q7CrZkXziSRm/uXD6ycZo9WRo2D1JicsYH6q2ha2t8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MAuQdRZ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGEvyC0y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749641313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDlH5v3YZBlYQycy/xaWrBQqMKOpqx8ipedaJ9Lxiv0=;
	b=MAuQdRZ4ySpgmDxn4Nbu4Bo0PmR+n5zbw7gzAz3EikdcOMy0sR+YHgTbKIVRpO+e15N0PP
	7edbzU29I46glFDKx0OYXVtwPzskcCLTHlgEokGN+Sk36Pbnzu2di2Evjzyn2rj/CLdzQ3
	R3oST2pLL4bo7mOODqf8Hvt0zHxEQw8ocsa5TuXIFKDQMIs5AmC3MxYcBtjqwIXd39c0i3
	FRqzJBUHqSUfPf19V+/oOf9FuaboHz92TJSM/Sg86Q4lWH+eJa9Fwghe5nE+LnKFs41v7B
	HVcmSlRtp7rDOq1MtkLah5lHsXApzHOkdWtRITaWOXhdk9cnR64PeSCwQI7qng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749641313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDlH5v3YZBlYQycy/xaWrBQqMKOpqx8ipedaJ9Lxiv0=;
	b=ZGEvyC0yhbww7Vhljaf2eg4e3eDPYnNXVNZcP0d0nDSYJwx5H6PSyWELizEJmeYtn5hmXy
	L1clTV7xnmQUdaBA==
Date: Wed, 11 Jun 2025 13:28:26 +0200
Subject: [PATCH v4 1/2] MIPS: Don't crash in stack_top() for tasks without
 ABI or vDSO
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-mips-v4-1-1d8997fb2ae4@linutronix.de>
References: <20250611-kunit-mips-v4-0-1d8997fb2ae4@linutronix.de>
In-Reply-To: <20250611-kunit-mips-v4-0-1d8997fb2ae4@linutronix.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749641311; l=2007;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=T6q2yFdgakZEOZU9u/ytjbTNL39PdbxoVInLilVt3Ic=;
 b=8tsInK9oDBoh5sQZKdthSd6ffDG12OWMcob31jETTgzZUtW6tOAyKacr9caidH41w02DFwLXi
 Tlv8gDhZZMnCgeSE1JUKcghO3heyvj1W0cEXn2yBfxKk4gYOY3vjg1U
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

The GIC page is also included as it is specific to the vDSO.
Also move the randomization adjustment into the same conditional.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
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


