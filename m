Return-Path: <linux-kselftest+bounces-25537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8DA25547
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844C11884028
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0CC1E0B9C;
	Mon,  3 Feb 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zoNsH168";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQiCh/Sg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841CD35966;
	Mon,  3 Feb 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573522; cv=none; b=QrY3WhCaHLFfPEyI835BkPCWmrck6IWguqLZgGTbopYBrvUK4hWT9+WR7maBhUgsSu2ZloCCBkAPpSsU7J3+MZBeBrBPdnfA09/pPITt0JcBNTyVzvsKt0MJeekfWYVWzo348z0Zzqb8DyHjskK6g7cwmqQPT5TCTkHHQqbkg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573522; c=relaxed/simple;
	bh=s3dkTBDXdzo+I16hjaEXfC4T5xD6NlAF4J47urRaCBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfeKn3Ok/LIcWHKlmx+qxu4ABsxEMomixjA8c7tD90pqw9lr+JCvoKB81VQ49IKQTIAzWvV7BuBemz3aFRW95MP3QQmtgn7xHZbXOXAu9CarQfbwTdNvHijYlTFmhe4gGNkbrID0cgLRegUHzeMfjTBA3f8fUT9/c/T7b+uE6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zoNsH168; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQiCh/Sg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mc60C8g9Fb1tmdPaCWjP2wsKb3/BHTAaOKy7dD4Q/9Y=;
	b=zoNsH1681N9Eilu+jpmlrd6H67exHHx840NRersYZZonixk2yo38qyL4oJzXRTX0CCBhDg
	8qsZAYQm+27bS/AWWuprXH5VXYiVwLmJRJJm5sQFRsASggh6N2yOkwuh8Nnkr9MJlVh6qv
	VDp3mT/vLL3kFYuWN2aEdEmvGKgu5MpkjwUirsu7Ip2cnGxCazy9Q9qscaaFlaIGwr0FXT
	xTMnIlYR/hBkXE5BB+Eezd2gm1xSrB27mHjk0qTbd8hhNVTu94zx/3WsojVY1B/GaPPPxm
	8oZjn5V6ifOvI6aWVXB8FtsceC7rNdVDMh+6WIMSQYQQN5nI0UbD183zqGlMDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mc60C8g9Fb1tmdPaCWjP2wsKb3/BHTAaOKy7dD4Q/9Y=;
	b=dQiCh/SgsPSRfDY6f/63PUhuYw/gLJsoDUfFCeBf7DmsRsV3NxAs/BfNh8PSR2PukMip5g
	G0WGODwQHG6PlNAA==
Date: Mon, 03 Feb 2025 10:05:02 +0100
Subject: [PATCH 01/16] MAINTAINERS: Add vDSO selftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-1-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=675;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=s3dkTBDXdzo+I16hjaEXfC4T5xD6NlAF4J47urRaCBo=;
 b=uYr9YEYfr4f5M2OlWjkTyacCJaqcjW8RwNjmPn99DBIa+vugRIRyNAt3CNSRblw+rHiZsR9YQ
 JnikGKZzAkFByb1eYxgRSoAJV30as8oY0tGYFXPa57Za4PGFtNNzWww
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These currently have no maintainer besides the default kselftest ones.
Add the general vDSO maintainers, too.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa06545e2861abe46ea7029f9b4d3628e..959c8a86844eb1e5c6218e8fdbde6c3ebf68e25d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9777,6 +9777,7 @@ F:	include/asm-generic/vdso/vsyscall.h
 F:	include/vdso/
 F:	kernel/time/vsyscall.c
 F:	lib/vdso/
+F:	tools/testing/selftests/vDSO/
 
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>

-- 
2.48.1


