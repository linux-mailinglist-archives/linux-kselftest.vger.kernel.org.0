Return-Path: <linux-kselftest+bounces-26763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC6A38110
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8477A67E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC8217727;
	Mon, 17 Feb 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hFwqtFfW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sBAv6n/s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37263217F35;
	Mon, 17 Feb 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790039; cv=none; b=XZSyNVbBW7ExSkx4HOwC4cwfAqc0pZfhtE3VrscJFjbNSF4N0P5TvgqKNydtuZA6AmvrV73TkxEKO9vxHnE6Ziu+X7uLyOk0KkyRkt/YzSc4exTIJA/PBONEHRPXQXl2zL3wR4hqLYpCLuT14OAyvdO5UuNrk5x6EpIqE5StCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790039; c=relaxed/simple;
	bh=vHbfeta7IxciYW4Gk1YYlAClVvaYyP5NoHWOvnhRaSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjOq9UQEOA4gau6OhEWaDZ+wl+Mfuow8Fcbtxf9262PyyIubHNTM2x9sbAqFFZHM4jJQESl5kMCCiiNy/jLXc80b3PoXfG8t0rgLYizW9VkcxUQ1gCrb/oSP2BC+Xzv0OmzDuv7mbDWn/hGnCy4jgNXfwmHAY0EbSI6T/8P36Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hFwqtFfW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sBAv6n/s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckM1+WXE+7gs1LersRHMnMHDoWMSArmyGjQ9a5ribjA=;
	b=hFwqtFfWJlY2KZmNcWtfC8wUvTcrAKzs+3l9wK6Kgow1NNvcMIJ/583LxTPiKM25ylwQkA
	8F+HJzCHk6vIcEcIXt8YOzq9Q9FMjVtiwldg9rCvKdXSOYJGJFltDkVi3OuExBa3fXtwy4
	wTfn1dAFueTpHg5pPqGk743fRxSuy59fCnmCvzQ8KWNt7t+gjMv9ktIocpeMj88q0yxRmM
	PUAiydWIj3qpG1J1d5Q+0TGgYm0ppvBD7aRMkhJhI/vZOrTxuUY44mub2QKJHUKweGyilm
	u4F/8Tsh3v1ehu+n+28BGlQh+oAAkL+r2S7yzNmVlOuQB5Xha/mJyILXvwXfVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckM1+WXE+7gs1LersRHMnMHDoWMSArmyGjQ9a5ribjA=;
	b=sBAv6n/skv+Ld2LQo+R32eLiWcf/Nqp4D4q5MXB44BiT6/GDkgxWEXhsiQXmRn1okM3y51
	/zMOTSZwym3A7wBg==
Date: Mon, 17 Feb 2025 11:59:22 +0100
Subject: [PATCH 02/12] kconfig: introduce CONFIG_ARCH_HAS_NOLIBC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-2-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=1938;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vHbfeta7IxciYW4Gk1YYlAClVvaYyP5NoHWOvnhRaSo=;
 b=TYupduN4jqDaLPgynjWEwIt+VNHnPl47OPAiGp3TQhDqymup3oDcXXNFc47o8KeDZHof4n0mF
 Mzwecc/lc5nA7CsVubD7N5RdvPCDozJMyHkd8UFFwS9ACJe9O+93cO3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc does not support all architectures.
Add a kconfig option, so users can know where it is available.

The new option is maintained inside tools/include/nolibc/ as only that
directory is responsible for nolibc's availability.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 init/Kconfig                        |  2 ++
 tools/include/nolibc/Kconfig.nolibc | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b3da5576421b4e1c63baf6c8afc09..794c9516d461ef7a3c5d399d982d3031199f0442 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -92,6 +92,8 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
 
+source "tools/include/nolibc/Kconfig.nolibc"
+
 # Fixed in GCC 14, 13.3, 12.4 and 11.5
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
 config GCC_ASM_GOTO_OUTPUT_BROKEN
diff --git a/tools/include/nolibc/Kconfig.nolibc b/tools/include/nolibc/Kconfig.nolibc
new file mode 100644
index 0000000000000000000000000000000000000000..a29825869d9b49a5502ae32d265b6f9c076f5713
--- /dev/null
+++ b/tools/include/nolibc/Kconfig.nolibc
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ARCH_HAS_NOLIBC
+	def_bool n
+	help
+	  Enabled if nolibc supports the current kernel architecture
+
+config ENABLE_ARCH_HAS_NOLIBC
+	def_bool y
+	select ARCH_HAS_NOLIBC if X86
+	select ARCH_HAS_NOLIBC if ARM
+	select ARCH_HAS_NOLIBC if ARM64
+	select ARCH_HAS_NOLIBC if PPC
+	select ARCH_HAS_NOLIBC if MIPS
+	select ARCH_HAS_NOLIBC if LOONGARCH
+	select ARCH_HAS_NOLIBC if RISCV
+	select ARCH_HAS_NOLIBC if S390
+	select ARCH_HAS_NOLIBC if UML && UML_X86

-- 
2.48.1


