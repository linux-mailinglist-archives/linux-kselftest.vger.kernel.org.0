Return-Path: <linux-kselftest+bounces-32367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84741AA9719
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC56F16DA25
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736525C81A;
	Mon,  5 May 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2wlMvBYe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMmOiMna"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784C1F540F;
	Mon,  5 May 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458175; cv=none; b=fOV3N4USwQNWMhW2rvL4bVL2UA+e96qN3sDM8qXEBTGSrVzZJd1+/oTwZdv2KHvGI8A50TgdXBr5m+O8t+o4ktYSR+wUY8Xag6XHiFyO6aIIOGNWtXKYzOtQtV/nI3MJ709wT43/8Ht5zGwjEjl8YSAHjcCZnNYRPqEYBxdxvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458175; c=relaxed/simple;
	bh=dBJ+kjSojaZBWuRgrqVpCDJvef04qbVQ19xoJvSt7WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAXD7Kf3tfisrNCDHI93Fhkk2/gk+JQ4vMDDbgzI1WSb7Q045lDlaYbStBxinxEfnTGNYNE8zJ9YSLguaBgli/T2QDteOqLMYQzBEKdBNtYcCwNcecnJjP5PE8UDi3oACD2oec0rvI9YiQtCgd6nJBrxEe04gQyeh8LxMlV9dZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2wlMvBYe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMmOiMna; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rv8ssy8vQy9aS7DK21TTvdS2wQYdRPZo3tH/3whiiF4=;
	b=2wlMvBYeYqIOEwa34x4yf9wV8iKNsJ1M8ixbmGquK79KBVLimdSQFca/60ojgJhXg9Ik0e
	25bTQe/9ZKhhPIOmkV5h2IZH+Y5KkcRbRdvO5wtjTeNp9Q0B66ArUPEDhqUUiO+WvAiZO+
	BOaCVN8svImfh3yy3Wcd3V7Ebjkhj3PF/KKpNUOQW/wk+kPe8BjZabSVTl25Ky/2Y/PTU5
	Som8C21WqEvwIZP10iFPhEqsNPKMqAs9H0kgsN1lL62F+JgjUfXkpL/oqP9AlHNn2gnTl5
	CFkXwNU1/uti0VpZL4IfiKIaLyZcNLmY39M7k9cKqmTbEvxi/7DmfXOBqHdRnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rv8ssy8vQy9aS7DK21TTvdS2wQYdRPZo3tH/3whiiF4=;
	b=RMmOiMnaRTgZP3GzPepl5QWLJILaSMuC54tVTAXFZuMR0DLZfQJnnc99K8lrxy9jDy0Eob
	xFHA+yYc7nHIQBBw==
Date: Mon, 05 May 2025 17:15:20 +0200
Subject: [PATCH v4 02/14] selftests: harness: Use C89 comment style
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-2-ee4dd5257135@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Mark Brown <broonie@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=892;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dBJ+kjSojaZBWuRgrqVpCDJvef04qbVQ19xoJvSt7WM=;
 b=xoFfdCynlPDtlHtZ7abHaSUqOSdrjj1cHd5jzBh8LoHcXX5oHYMlaWZHL3B3DPYTwPVoy0Lvc
 P4dS44uJrBLCVjBKm+s12+0qFq4PKYYMT8jarHDqnV830IqI3++b3y3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All comments in this file use C89 comment style.
Except for this one. Change it to get one step closer to C89
compatibility.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 666c9fde76da9d25fe6e248a7f2143c113473fe1..bac4327775ea65dbe977e9b22ee548bedcbd33ff 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -983,7 +983,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	}
 
 	t->timed_out = true;
-	// signal process group
+	/* signal process group */
 	kill(-(t->pid), SIGKILL);
 }
 

-- 
2.49.0


