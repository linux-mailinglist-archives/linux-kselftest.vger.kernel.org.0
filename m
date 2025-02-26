Return-Path: <linux-kselftest+bounces-27593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 155DFA45D78
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DA416B329
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648E21B9D1;
	Wed, 26 Feb 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sGtF7KMC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZKemhK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E322192FF;
	Wed, 26 Feb 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570317; cv=none; b=IpvHzQ9Xm32eLBhuYFIs3DjNC/4iPEYfUzXExwiliDykddR5uJm58nW7EsshCkXkVIxB4OBIoCI06yeBhlMAI9LIJ0qkIh/aQPU32s7P3I58v1d+g5SdGo5UzSrhgnNl3EmCUCeJyAxSKlOdSuuL34NQ7UgZNvUej516wnKnpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570317; c=relaxed/simple;
	bh=0OYIxTlpnbjEhvswabtZg49j38hT3MAFwMnYXuy7rHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxFkHUWSz4Id/+L/lmKDqVuqrEhve2hgAAPuAbz8lnUIQd7YR8ityfxd0YT1F9K36eAuEYeGe8eQCZEk0NiF+WGYYg9cp3TO2+UK+3RVqE5g3mlJojLNvxYOgxhk3TtiIwP8osNMPPYdL5AyonFsvqVOODZuZNPFoak1jp3Av28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sGtF7KMC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZKemhK5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG/oZgAVhh6ntwQfY2W+UbeC4PlDV/c3H2R+4urGbL8=;
	b=sGtF7KMCAQ1TvopA8uWGZS7Jr8BlLkn4jH/P+pv9EwksFOAspMcaHeDJ4XAvbbQQjURP4c
	5quj2rJOclA+XKXJd2baA7HLBZ6KySWoEqp1IA78xPmci9Cz4rt35yf5IrzjbnNNCaBQdm
	78NTJCtSCvyS6HqSnvxbzBPu+ePLE8unuTz+4Uv6YJwhCVQNNo96c/vGzm3PnP4zMs+ouz
	lf2DB7UA5RGVxjR+DFcLBLJQidqZVF40GaOrHi4PPmkn076UKaQ8QzTU9BA+fbXWX2XHjZ
	mO3hWkdqO/7QjUBgtYU4OG2UPXR8G5MNWMWZVyU7aA8GG5LQu5A5WK1zSM4E9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG/oZgAVhh6ntwQfY2W+UbeC4PlDV/c3H2R+4urGbL8=;
	b=mZKemhK5sXcz5nItTnlWQThIGKk6Tokjf6a4LsC1TribORFIB9aWMsMtW4SRNv9/ZnQHnu
	MXUeg9i2JMw9QhAw==
Date: Wed, 26 Feb 2025 12:44:47 +0100
Subject: [PATCH v2 08/16] selftests: Add headers target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-8-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=1095;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0OYIxTlpnbjEhvswabtZg49j38hT3MAFwMnYXuy7rHo=;
 b=70NDE/pRn3le1NMHe3LrCBOiX+f7D386oBjP6T/OyPf/pLocQs+xFeCw0bF2tCXNqPPRTjmGC
 VOhManwhUDWAzhRWxDEu2+K2YxvamCPDPR43TlyYLYGwKlwwpjYa6am
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some selftests need access to a full UAPI headers tree, for example when
building with nolibc which heavily relies on UAPI headers.
A reference to such a tree is available in the KHDR_INCLUDES variable,
but there is currently no way to populate such a tree automatically.

Provide a target that the tests can depend on to get access to usable
UAPI headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/lib.mk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be832ddee4c3d34b5ad221e9295f878..5303900339292e618dee4fd7ff8a7c2fa3209a68 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -228,4 +228,7 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
-.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
+headers:
+	$(Q)$(MAKE) -C $(top_srcdir) headers
+
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir headers

-- 
2.48.1


