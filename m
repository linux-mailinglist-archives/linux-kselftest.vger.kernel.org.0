Return-Path: <linux-kselftest+bounces-19642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C699C913
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 13:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB0F1F23089
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB5718B49A;
	Mon, 14 Oct 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e8b2Ltvn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vn6R1vmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB6197A7F;
	Mon, 14 Oct 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905818; cv=none; b=mLwL837eTp6S8jUQ0mgu7kXXM3TmXLmqnOH0P5eQ0ih+DpYLdwK1BXCO94uaMg8E2C9MheGld28Wqtri2YV/YwlFT9Ty/Xs9mNCLhV/i42YmCdKwPunP2jSM3Eeh1lUWmlgyRZVsaWv6wGfSjN/tQXE9NN8eMAiXC8WMDo0TrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905818; c=relaxed/simple;
	bh=kSJZarY2z94X+3xL5Dh3VLdVKOYPHcJphuWhWCcRZ9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHO+RUMiPiWxaHibHKZ2sAzt1uKvrlv3AhwcyNf/+vWsJ/UWThInNlxF4Vfa5FKrmEHYSaDnLnSIKXqqgy/O/2xAZWt1F+ENBBNP+kxgPCRB9Or+snayqNNbtOzooZuSmauDJgTMfCq/n7084HN0zrhkqMhqWG8Jk4c1/0kon4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e8b2Ltvn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vn6R1vmr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728905815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1+jZEqucYiU1F2rEs1tJbHqPXnN7gfk5dJrwm4cXRU=;
	b=e8b2LtvnIPlQNKvndj4Eu/qNiWl60X/4jzRlIs7ARJ8gZOG0cZEYySmq+15901RaCs6uOZ
	c7fS1IaCXF4T1dRk+G+nQdicxvF8sgPwvm0w4dQmzhjPc29UZtZJ41Oy64Ah9iapQpkYVv
	XR9uP6x9h7cJOqv4pbC0WxeaxwuYPXLiYuR2ocjQMEbDAyGxddtgXeCGz/SSjeXs+c6jkS
	pgVqsbCRBVJaoxJU8LRcbCWtjT5ozcNH4SLec+Yyqm67m/zzY/UjTXtJMslMu6AchO1F3R
	S+AqtnnzIyIqGLKbr3s+fm0JgsvD+hBLspXUJotlwS0ExOCyBsS9kxDmCe3G4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728905815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1+jZEqucYiU1F2rEs1tJbHqPXnN7gfk5dJrwm4cXRU=;
	b=Vn6R1vmrNroEp0fnkH67IQ2vJVD73wbv0C8JkuntWzXcp2zsldxWOHs7oTfFX++IYnQFmW
	ZI1Qx0qKxJdheqBA==
Date: Mon, 14 Oct 2024 13:36:42 +0200
Subject: [PATCH 1/4] LoongArch: Don't crash in stack_top() for tasks
 without vDSO
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241014-kunit-loongarch-v1-1-1699b2ad6099@linutronix.de>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
In-Reply-To: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728905811; l=1878;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kSJZarY2z94X+3xL5Dh3VLdVKOYPHcJphuWhWCcRZ9A=;
 b=wW/i4s60xhVIYXXE3HBqscJ+MQg3YWy/nOdbmhVNj6ec07TysLo1111FKSVmBn+BSRNOtnXjV
 XAi28MJhxSWAA/KqBKJ0qNG8JLKzNPyJPXYISTIJS0oaG37P6lmza80
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Not all tasks have a vDSO mapped, for example kthreads never do.
If such a task ever ends up calling stack_top(), it will derefence the
NULL vdso pointer and crash.

This can for example happen when using kunit:

	[<9000000000203874>] stack_top+0x58/0xa8
	[<90000000002956cc>] arch_pick_mmap_layout+0x164/0x220
	[<90000000003c284c>] kunit_vm_mmap_init+0x108/0x12c
	[<90000000003c1fbc>] __kunit_add_resource+0x38/0x8c
	[<90000000003c2704>] kunit_vm_mmap+0x88/0xc8
	[<9000000000410b14>] usercopy_test_init+0xbc/0x25c
	[<90000000003c1db4>] kunit_try_run_case+0x5c/0x184
	[<90000000003c3d54>] kunit_generic_run_threadfn_adapter+0x24/0x48
	[<900000000022e4bc>] kthread+0xc8/0xd4
	[<9000000000200ce8>] ret_from_kernel_thread+0xc/0xa4

Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/kernel/process.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index f2ff8b5d591e4fd638109d2c98d75543c01a112c..6e58f65455c7ca3eae2e88ed852c8655a6701e5c 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -293,13 +293,15 @@ unsigned long stack_top(void)
 {
 	unsigned long top = TASK_SIZE & PAGE_MASK;
 
-	/* Space for the VDSO & data page */
-	top -= PAGE_ALIGN(current->thread.vdso->size);
-	top -= VVAR_SIZE;
-
-	/* Space to randomize the VDSO base */
-	if (current->flags & PF_RANDOMIZE)
-		top -= VDSO_RANDOMIZE_SIZE;
+	if (current->thread.vdso) {
+		/* Space for the VDSO & data page */
+		top -= PAGE_ALIGN(current->thread.vdso->size);
+		top -= VVAR_SIZE;
+
+		/* Space to randomize the VDSO base */
+		if (current->flags & PF_RANDOMIZE)
+			top -= VDSO_RANDOMIZE_SIZE;
+	}
 
 	return top;
 }

-- 
2.47.0


