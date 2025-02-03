Return-Path: <linux-kselftest+bounces-25550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6FA25564
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671271886960
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671DF20102D;
	Mon,  3 Feb 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yjmAtgMY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qk+5JP6m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8B20011B;
	Mon,  3 Feb 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573529; cv=none; b=lk1Htp63PZrfAG18wRFLhB2cQtajkIW1OrivpP3MpWgmgqAlcv85FYRHacEXIG04HdRnDoECtn2PUXGy57Ym0umgfmH8j9kYKKVLVhPe96vhZ83XNm06iW3cnnl6O87Py5ag+cT/VLXiDurHdgWG8XcrPXTXx+X1y7jtVgURpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573529; c=relaxed/simple;
	bh=WWyAjd0lBF4CXtwQtc/ysMPL9nKJJ2TfKtJWs4lpBX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEtMFEmcrNqYtHp7BTi/8aw8mefukaCanVuXhWgLY3gaTMQ5n2VUdgV3RrLkk3vMsbDFtfmKT47VVU1Hy9bOcT3fbT5dwg2Qkg/lAUSL0gyxdCzKc19tnIRXiEFF1dnS9d5lJvSM30APqdSlkczMLgVpCp4Uo8xXBWe25JIUB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yjmAtgMY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qk+5JP6m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmfOckZ/ezvQbsI8oO+Ny3Ym1fUd+U8v8PjgJTjlhxI=;
	b=yjmAtgMYGYfBdpksBGL3fLj3qyPKzWWYn9LYLPNuZ48cP7fMNj2UUfTat6YJOWkmEUT+vR
	UHTsI4zn8oh+peO1dvBPkvsvUICpuqld/b/0da5ylPAMpltqhNSqXWOVu5fwnZ3b5QGQM3
	eoYOD6yyEDikifawdsoHk40vO5ieyjDGlRD+u3cuy4IkfAa3WMScUnZrQ9YRHzU/yD4AHq
	IIqqMSZ3H4utDJ8Bt2Qy+2ueNbkA/Dx/T0PTHmtPjkkzYcGsYCYqwdJRYwE+ofpbD5tE6s
	Fv4SAl7sIVAmqRN5VLws6Rsn7sl3wEO7DGNlCdGY0qNFVlw10copD9nFdUFN5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmfOckZ/ezvQbsI8oO+Ny3Ym1fUd+U8v8PjgJTjlhxI=;
	b=Qk+5JP6mxxwppOPLgoax+Q7V36u+yZMdh/As+saJE+SWTU+amwMyzjwngOwgQ//NXRieeG
	QofsWTBRfOJfO1Aw==
Date: Mon, 03 Feb 2025 10:05:15 +0100
Subject: [PATCH 14/16] selftests: vDSO: vdso_test_gettimeofday: Clean up
 includes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-14-9cb6268d77be@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=803;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WWyAjd0lBF4CXtwQtc/ysMPL9nKJJ2TfKtJWs4lpBX4=;
 b=Wx5hqx8BLX3nyiwjknii3zPUhoiOo1txrGf9MQx5F49M1A8vApW5O5bGzPPmgJKo1eAaOt0mk
 eQyNUERgj8dCiDDbUeShmbJ3c0NvGokZun7HHe6yXdmDHodqA/P5NGJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some unnecessary headers are included, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index e31b18ffae338c1576449b54ca7f84d9816d2ecb..636a56ccf8e4e7943ca446fe3fad6897598ca77f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -10,8 +10,6 @@
  * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, too.
  */
 
-#include <stdint.h>
-#include <elf.h>
 #include <stdio.h>
 #include <sys/auxv.h>
 #include <sys/time.h>

-- 
2.48.1


