Return-Path: <linux-kselftest+bounces-36652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3CAFA7A7
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4D7174A84
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F140F29E105;
	Sun,  6 Jul 2025 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcSpOKEi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD27081C;
	Sun,  6 Jul 2025 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751833154; cv=none; b=ETI8o2PQnX13lpfxC/Kv8NeWRrZWTJ2yly0+OsCQXlssCKkxv71usY2LCH6sI1z7uYdHYG5NT3EsMvGA9YK3GGf9NCdso+yWs6EayE59dJ61SLImYrWjKlNsSSebD6FoY+HJ0oWhdTu8nWsYp4mfFAyblazASVii8rEYKWaAZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751833154; c=relaxed/simple;
	bh=7CmSw2auQCB10/mhzVBpiCG+kBblK5JiB07agEKo0gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sDPyKWatjzR4vOosy0frzlE0F3IajHr7xY7UOJS9OoD7rNxsfNb+hHNUdyOiXrDXfedWyJgXSsSv7HdZLwKNY2CNYPrpq7z0nOfS+WWUa0//2AYEZtPa7GuDIaIHSU052uimlBezwGo7600+MfUvoWMUmu+y2it6lM2LRd9HCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcSpOKEi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1303313f8f.2;
        Sun, 06 Jul 2025 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751833150; x=1752437950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb5fqW52Sf50dad6R6Edoqvi+sp46QqlVYM4k2DPVNI=;
        b=lcSpOKEiD17ajIWpzTg5OiZHg6VTT5zTg17F/IUXtSq6byuRqZ07/JMDC6UK5QEBcq
         9LnalCz6dCl88xNPzeOBsW+uxeFOUGI8hm0ytsfaF7UrvWPuoq+12tiHmm4MGqbTVskM
         jCBp4qoiMTbZ1GM8TdnO5EtxG7uck+Mp63LhFiKPEcdJopWLUal6CTat0ud+oTiHLvhw
         nYZ3mWEnikZXNssbLYrtudiqcuI0Oyh0hmaqKli+IynkPniiFS+HsqFmbxO9BzBsivBa
         neiyGMS6a0itxXLcNlNcjWme/Hf+aUAaBYgT3GhC8iVD7xHfiqA9cTuvXF7adMfdO+5L
         QT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751833150; x=1752437950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vb5fqW52Sf50dad6R6Edoqvi+sp46QqlVYM4k2DPVNI=;
        b=XA5FrkUxkgqeKKgjqG81PzekK7h/Wz/qXWA2mDNd3GjMAzK49pI7AU2CCAuQm4XrsF
         UX8+vn3MaOKU7yeEKtoIVFV1ayKepLi1JnOLU39tPYOdqYK/igvQ+5NYk2BrWzoNuYFA
         kg6PVyrWeIODLYi57fffAxK4MQogg7NwpmNRarO4rikRA4x+9eP9Oz4GsdqH4iaT6Goe
         8s1nlyNgy8H2Cm2yMMdrzLCXocUF1wFCkJJPwjX+OiVu/DgKRvrmZepsr4lakfAbub/b
         FxfGzwec3l7m8AzIS+olL7hDsSdgHYzRfmhfSEzzTvHv9pP1xxb3RzgPDIl5hMb8LLLN
         4cow==
X-Forwarded-Encrypted: i=1; AJvYcCU0G0jephDOkCKUfgTC2Q1cur33ZDua1yHJ8+ql+sJKqH/acY49M2xniN+/MIERuxkjL02pqqZH/EYpxLg=@vger.kernel.org, AJvYcCUKWWcEjrTTgUoRQh7ROqBYl81GLPlS/mX5gxH0Zl2CghFUE41E3AfO5dq9zbEG4a3vc6U/fs7W6hpj3RE3PndE@vger.kernel.org
X-Gm-Message-State: AOJu0YxSjbF78zrOkHfs3BhRL8iR2G9i+aMwG3Ca0vxxnt+sSMktiHV7
	7jLAZrbpGkRW1n4ygkEfHMTB23CWtpplMKdiAUNm4NTKvcnw1FZJa/Tk
X-Gm-Gg: ASbGnctOhDKL6wgbvYSC+LT1kUarowBnGLaP1AP/s+pg2tlHelfV+BCuWO3n+DmLNmq
	IXdTvtl2FUhWd4B3yfDupPY3ig6KfJkuHynm4o7Wh3JHPZQsJS7CF/yfvwYFvG/AuN9YHO4EZjm
	55tCtEtx2nQPOl+8bWx5BU0y/YpZ4ITQirdIRbfk2JfQLm7o0rrlKHC/2b/faaDqpLmBW8m9+O5
	FX/vSso0twNKp8HJoqMdMoFu9LfuiPUL2RrFUS5adHpx8QphRb4b3HWtqRYmSTmqK2mNoi90rpl
	LPcld2fkVAboCXnY3ijQp2D/PR+3jnhvxHTBtwLCgFjg5sYvGbqnTj/5Dch7HF/j+w/uVghh51x
	gnLBEngXsqw4imHUum/vAczNw3w==
X-Google-Smtp-Source: AGHT+IF9tRcHbsiXHX1mXnkP5vOa5cQNCDmYicadBI7LcIlNp1bkMinCpjotSPqiqqP4iKR4uU5glw==
X-Received: by 2002:a5d:5f49:0:b0:3a4:cfbf:51a0 with SMTP id ffacd0b85a97d-3b49aa1ff91mr4653344f8f.21.1751833150204;
        Sun, 06 Jul 2025 13:19:10 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0ed9sm8412728f8f.38.2025.07.06.13.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 13:19:09 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: rust-for-linux@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	x86@kernel.org,
	linux-kbuild@vger.kernel.org,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH v3 RESEND] kunit: fix longest symbol length test
Date: Sun,  6 Jul 2025 22:18:55 +0200
Message-Id: <20250706201855.232451-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kunit test that checks the longests symbol length [1], has triggered
warnings in some pilelines when symbol prefixes are used [2][3]. The test
will to depend on !PREFIX_SYMBOLS and !CFI_CLANG as sujested in [4] and
on !GCOV_KERNEL.

[1] https://lore.kernel.org/rust-for-linux/CABVgOSm=5Q0fM6neBhxSbOUHBgNzmwf2V22vsYC10YRBT=kN1g@mail.gmail.com/T/#t
[2] https://lore.kernel.org/all/20250328112156.2614513-1-arnd@kernel.org/T/#u
[3] https://lore.kernel.org/rust-for-linux/bbd03b37-c4d9-4a92-9be2-75aaf8c19815@infradead.org/T/#t
[4] https://lore.kernel.org/linux-kselftest/20250427200916.GA1661412@ax162/T/#t

Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug                | 1 +
 lib/tests/longest_symbol_kunit.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..4a75a52803b6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2885,6 +2885,7 @@ config FORTIFY_KUNIT_TEST
 config LONGEST_SYM_KUNIT_TEST
 	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
 	depends on KUNIT && KPROBES
+	depends on !PREFIX_SYMBOLS && !CFI_CLANG && !GCOV_KERNEL
 	default KUNIT_ALL_TESTS
 	help
 	  Tests the longest symbol possible
diff --git a/lib/tests/longest_symbol_kunit.c b/lib/tests/longest_symbol_kunit.c
index e3c28ff1807f..9b4de3050ba7 100644
--- a/lib/tests/longest_symbol_kunit.c
+++ b/lib/tests/longest_symbol_kunit.c
@@ -3,8 +3,7 @@
  * Test the longest symbol length. Execute with:
  *  ./tools/testing/kunit/kunit.py run longest-symbol
  *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
- *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
- *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
+ *  --kconfig_add CONFIG_CPU_MITIGATIONS=n --kconfig_add CONFIG_GCOV_KERNEL=n
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

base-commit: 772b78c2abd85586bb90b23adff89f7303c704c7
-- 
2.39.2


