Return-Path: <linux-kselftest+bounces-32202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11419AA7520
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779C5983992
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C2833987;
	Fri,  2 May 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxbNa01E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160D255F40;
	Fri,  2 May 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196687; cv=none; b=mykD1N4CpMgh7lM4zizKNlpG7pa0c5/qIzqzYpwOJr/Xl5Aj9WXyUdIMHlFb2oSJ+D5od9s/EnqpnGW642D88UsjUFDcxweMqNABHMUBQUvdnzrcZgGCBj8RM8m/pitE409LsFWaCbuDzJflMdGEozXxwr2FnC8g/bW7245a8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196687; c=relaxed/simple;
	bh=Dis97faY8WwuXxl1lwxU+T2h8FG9qhydxJlqdcT+d2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QdYXXdZvxY/UiB7Is+DczDRwPHZxAitHS/F4XFrTmiTQ8LLFetYQvNdNKtd2eVQMRwa4mzYVxQpF6VkOTagbzq/4E4YQQyUWIDk6VgLtMFFQ5VSOaH97e8IBMlMh671SyM9VLiZt+eICseDiDBHSMss9YPJqjHZRk3cfvc6QJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxbNa01E; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39129fc51f8so1336032f8f.0;
        Fri, 02 May 2025 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746196684; x=1746801484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIXwDCSt3R/Kba0wXWByslmMSnWGYOxoD+XvPPBaI7g=;
        b=hxbNa01EluSEy468AS+oxWDumTaZc628/G16HkDdhnE7TcykaAoMcHR6au/CjsUNvY
         6aoOE0vf10LZABrjD5rpKox0EfwPbHSSXFbcH2z6RXmNKnxxqJBEqZvJDwP9iwMnmHeg
         l5Q/XB7Qv3cS5Lpeq3SpLE0zMs844Eq0+h80Y0zNVjHq37cVARnAn+hUBFu8+X55Mj+J
         L8wrosaBgYjPs43mRMqprZTVnv79S1d5aVClBvPJs0qILlyfmupor0+P+/ZPVeajAgrp
         c9+ttVX8GpNmLxzYuxJO1puDDmz4wRtVyObzdjGst8DsgRD/1TemxtfUypjRo47GN9Ad
         QUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746196684; x=1746801484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIXwDCSt3R/Kba0wXWByslmMSnWGYOxoD+XvPPBaI7g=;
        b=F5QoXlTLMFpUS7KUY7jQTwmEmCfafDTk0Eq7PjswPeXx+usAwk2QHfkrzwyS6TCtHf
         97cMOUOICahIfiuD5q90G6IjhESLzmOYgblF2zlziuldMvZu3OACj/IQGKfpBTCToh3R
         SMJMBc9nFOn3jOJ/Z+/JIoa6jah1S7hTIjbiTZzcJ+swpZWdWcflPJ95qyO7IWziFUss
         0Ao8B16QrSc55EEL766OsAN69JeAOAls8Dy5YziGMKv1tUGaT6IKOEXO5istGn+m83NE
         pWDZ2RbxI6PBkIi7x4c8h5UfqFgYliuvaK6kbi8mzdBtrjQZEqW67s4N88T6JqfbIjBQ
         arWA==
X-Forwarded-Encrypted: i=1; AJvYcCVD9bihmRu8c72PBx+6HWN62q3U5shFKbikzLSFIwGNBSZmhyPXHgD9yurkKjsyG0Wl1mITDy8WfIG5180=@vger.kernel.org, AJvYcCWnH1+2YzR6QecmN1B0CbkgYsiXv4jCzwCOOB50iwYXcVZDXpAxCB5x8QSoY7kktnJgFvmiNzee/f1WrUIQWQRl@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGFnon+VpbRyni7QlFk4mrnZfPk9widnbmXkqVhBnHPTgG3Or
	bF+FXRP6RGQF7ZPQLipOVn1pPDUBAi6YcSweoHT2/hzmLQZtkHP3
X-Gm-Gg: ASbGncu4oO9hUA164OU4HlmtVlYv1oCm36RIlu4ln0xD9OGnAycDe54XafZe34Kq52j
	qYqwGCB6iM468OyrsZjd5Da90E2VSzrG0QENLlb+Xjr5d0+8I+kb4uGxylKrKzO2L0ZA/HPKzPE
	kF0cIQTe738A0TDdaoT3sdZK7VXklhAFs0T5XyMQA+Q/em7rXoCXIgK7yXma4xalN+Cw6GQwXFz
	h7T46D5bDTMnj5yVhq0SQMco/drxLAr4dfXQEgOVA4yd9rfkJhDJGUKjJI8Bzt0bWr8PrZnPRbm
	Avdw9CTPnKMAOlUZlnVErQPmfPQDLxNSg7A7R0qOIwzBLvZ8In7T7iCzI5kP5DTv8WE2ZFrPfA4
	ybROE
X-Google-Smtp-Source: AGHT+IEE7Z3tHdAEmRGKRO5wmPUH8u75ETV8QIuGOp+ArZBYxVNck1mW9J5i5wrBbPQltVCQnoXtXg==
X-Received: by 2002:a5d:5f87:0:b0:39e:cbe1:8d68 with SMTP id ffacd0b85a97d-3a099ad3677mr2553778f8f.6.1746196683477;
        Fri, 02 May 2025 07:38:03 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c48sm2318660f8f.8.2025.05.02.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 07:38:03 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
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
Subject: [PATCH v2] kunit: fix longest symbol length test
Date: Fri,  2 May 2025 16:37:58 +0200
Message-Id: <20250502143758.23135-1-sergio.collado@gmail.com>
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
warnings in some pilelines when symbol prefixes are used [2]. The test
is adjunsted to depend on !PREFIX_SYMBOLS and !CFI_CLANG as sujested in [3]

[1] https://lore.kernel.org/rust-for-linux/CABVgOSm=5Q0fM6neBhxSbOUHBgNzmwf2V22vsYC10YRBT=kN1g@mail.gmail.com/T/#t
[2] https://lore.kernel.org/all/20250328112156.2614513-1-arnd@kernel.org/T/#u
[3] https://lore.kernel.org/linux-kselftest/20250427200916.GA1661412@ax162/T/#t

Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
V1 -> V2: added dependency on !CFI_CLANG as suggested in [3], removed
	CONFIG_ prefix
---
 lib/Kconfig.debug                | 2 +-
 lib/tests/longest_symbol_kunit.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f9051ab610d5..5b33673d82da 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2885,7 +2885,7 @@ config FORTIFY_KUNIT_TEST
 
 config LONGEST_SYM_KUNIT_TEST
 	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
-	depends on KUNIT && KPROBES
+	depends on KUNIT && KPROBES && !PREFIX_SYMBOLS && !CFI_CLANG
 	default KUNIT_ALL_TESTS
 	help
 	  Tests the longest symbol possible
diff --git a/lib/tests/longest_symbol_kunit.c b/lib/tests/longest_symbol_kunit.c
index e3c28ff1807f..b183fb92d1b2 100644
--- a/lib/tests/longest_symbol_kunit.c
+++ b/lib/tests/longest_symbol_kunit.c
@@ -3,8 +3,7 @@
  * Test the longest symbol length. Execute with:
  *  ./tools/testing/kunit/kunit.py run longest-symbol
  *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
- *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
- *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
+ *  --kconfig_add CONFIG_CPU_MITIGATIONS=n
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
-- 
2.39.2


