Return-Path: <linux-kselftest+bounces-25548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE6CA2555E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBD716681E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6323200BBF;
	Mon,  3 Feb 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fgkPYkL9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bauLXxZ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C501FF7A1;
	Mon,  3 Feb 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573528; cv=none; b=jqDrIFklXNsWuDV0j2mFaKqiWSZ/OtYLmiXX2UNWGQxkMpU+TJVdjDy6dxd4n2yI0Jy3vMKQVrDwBpsK7bNgJqoceRtL5h4OpuzIptswLjjB+9LNqQZRECK+6fBD9QUQbZo8rOSAsehHj+MjtZ1yu6r9ZzqrLPnAVo097CzwzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573528; c=relaxed/simple;
	bh=ugBwqhNadfgaJrsWyUX/2beQ4czEKoozrpKImBBUGps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/zyy7djundoAnx4hp1bgMTJbCypCptaQXKWDzsRLMkk1pyb/zJQh6kE+b+ZbgLJsJFBiW0dM+YnMs8da9vqCVA5aNM5DicPeuLlO0WQFCnbFb6XNmJ2djuZEVd9QeNBtBTNENNab9x39O4K//ec+BuaVmUeSCdgB7K/eIQ/Qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fgkPYkL9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bauLXxZ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OHpPSU9A8rMw65GpV2i5kAnHrOB7dGDB0rMnM6cdCQ=;
	b=fgkPYkL9gMRnyDkH2RMIwKuOFSQ+y+KO7EHHtpv7Wngciwo89WNxP728ntzAAt1JUW/UTn
	H0Fg8D33X4l/QIWJNe8JWTaU+Ye8fCjdrKywWuLyM5LxlLUAf0cXPmW/KclM+oPE8MgmES
	SJxYKqlLzN9IFqngaxWPLyRMbdzTXVOlgsgxW1MMzSDfGd9ToBldiUJv+znD8Ata5DzkeW
	16oJosV2UUPRuK44RefC2ea9AihINCjdN7H8QaAWloooA2RbrDzBXUi8qpytymNSUJOZN/
	Du9GAHro/3MRHoIWBh2PlninlkPOMx13+WpEdCj2EeOl2q7MK7SKnY13MKj69w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OHpPSU9A8rMw65GpV2i5kAnHrOB7dGDB0rMnM6cdCQ=;
	b=bauLXxZ18S9/378dg+A3yudnEpxzalp2Z99jMwwAW+rGiU96hjqw7z8Ig05lE1UMox2dou
	t+dLKA5NVDkybmBw==
Date: Mon, 03 Feb 2025 10:05:11 +0100
Subject: [PATCH 10/16] selftests: vDSO: parse_vdso: Drop
 vdso_init_from_auxv()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-10-9cb6268d77be@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=1524;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ugBwqhNadfgaJrsWyUX/2beQ4czEKoozrpKImBBUGps=;
 b=14j5KAr756dMld/affOvFMwsnE3RfqI6n9MkPXjBS3SeQCSJnmZpBsFXGJMIC6BfEE+NqoqNB
 JEIjSpeFEuyDorQqPFhp9++Vl+WbXqyyJu8KIzXICUkV9cX7C9/zdR0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There are no users left.

Also remove the usage of ElfXX_auxv_t, which is not formally
standardized.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 14 --------------
 tools/testing/selftests/vDSO/parse_vdso.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 2fe5e983cb22f1ed066d0310a54f6aef2ed77ed8..3638fe605e80ca41b29d43c6ac452964eef35d56 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -297,17 +297,3 @@ void *vdso_sym(const char *version, const char *name)
 
 	return 0;
 }
-
-void vdso_init_from_auxv(void *auxv)
-{
-	ELF(auxv_t) *elf_auxv = auxv;
-	for (int i = 0; elf_auxv[i].a_type != AT_NULL; i++)
-	{
-		if (elf_auxv[i].a_type == AT_SYSINFO_EHDR) {
-			vdso_init_from_sysinfo_ehdr(elf_auxv[i].a_un.a_val);
-			return;
-		}
-	}
-
-	vdso_info.valid = false;
-}
diff --git a/tools/testing/selftests/vDSO/parse_vdso.h b/tools/testing/selftests/vDSO/parse_vdso.h
index de0453067d7cd0d8b63f7d3738842f60370db813..09d068ed11f97f0c5c8f4e7b341f08fa261c9735 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.h
+++ b/tools/testing/selftests/vDSO/parse_vdso.h
@@ -26,6 +26,5 @@
  */
 void *vdso_sym(const char *version, const char *name);
 void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-void vdso_init_from_auxv(void *auxv);
 
 #endif

-- 
2.48.1


