Return-Path: <linux-kselftest+bounces-32963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F94AAB75D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDBA863D85
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60328EA72;
	Wed, 14 May 2025 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O40zK9QH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4F28C863;
	Wed, 14 May 2025 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747250678; cv=none; b=V5B4Y2XgoCs24HkztA6QVLWKXaWvkUgf6Fy756Uwb+bvqQC0t143H2MK5uPOruO3e22dAanj5FNYwahsWvl2r9dWtGgP9JRBWTI73WuAeRKoSNubGWs31aGMqbK0qE8ZczQQFP4xVyg05EFHeYoCweSVY/SE1Cne51NMEzZ89ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747250678; c=relaxed/simple;
	bh=sya+8JjGJHbFscoxWgUm22pBcbKnQ+x9xicjbxzjARs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u17HLKpRi1nk7r7diZ6924pSi+3YPV1Wzl8a8bFxD3CyZfroKNpMCxS56/kZxQRRMFHzc21jPMw7YI+H10lIM90iD887nPJsgFkvkoNrXOBwlBHEbij1HysbRs8TVK3cAP+Zuuk3VCo/IhVHY/nWo9JygyGqJDSZpa2w1dmYUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O40zK9QH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so84788f8f.1;
        Wed, 14 May 2025 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747250674; x=1747855474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ym2VjItfmlQR+4MFTtDnGlE59abfrw+zWC9kBxVcBU=;
        b=O40zK9QHF9j4t8YbnbiJRVeG3mCNhTa5R8WDom7MGZ7KdQl41i4LiGQVpnIYNUZGW9
         NlSrBxhuveBjpMOODADz0qdJRng6d3zQA7UDL1jqv8iZNPfDGfJTMy4Kv9qcyQaEwPw7
         NCUqeRuULdInHuHj0P/zJs5CQTbUSyTJNOlH0rPJBr4B5dP5p1JSza3ukXw6u0vcYYmS
         Lj0ZfZvUJHJufA22xwZUo2LUuSOIUC6XaQE6Kpxg/NC++HGPn9BwO/C3z6U3pIb9wjIg
         QKhY2mZogsxzXgQcN9RYR4+ABxEab3oP7/ovCEvb2NXhyIM9TuyPlKPhPallDtBacY8Q
         Be9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747250674; x=1747855474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Ym2VjItfmlQR+4MFTtDnGlE59abfrw+zWC9kBxVcBU=;
        b=UxN2+etvyp29/pHKNMBEmfxlkza+kJusx+GMUvpyeREZdkpS55yBX1mceZliQ8yHyb
         G5YMXM8xAzs6cjOfkcX6M+V/qxZFhv15jMLM1JH5Lic4v8ly+80Nwr+6fBjRYPsFh3Q5
         AHxNP/Yiysm2eSIQpOkX3T0HK+BD/VZMBRb1zaNw9zIbqzThvi7x8KzZdpJTE3JM/71s
         8m99JKXN8vszm3dBzETxcuE0Ap+NQu8K9E3TzuBpp4cEJe334rrEkHXmIuVzthNOf+XN
         gzpMBFweIi8u2llU3CSs5/Tix3kOqfPvslFpaXWwewEcoaBnJt7Zouwct1YxgRAAy7JS
         cXGA==
X-Forwarded-Encrypted: i=1; AJvYcCUt8LZ06nYYJuS2kx7UC2bYB1ZxDEvOkGSgfwfjIDSpf/Q7CCkmic1U7l0anJU1om7DOoG9P7/L5Vrb2+o=@vger.kernel.org, AJvYcCVyXJl+kvIOqaA2x5o/zOODzrO8cZ5VeD0wCJgfJw8glE3d68mdu5PN1MgGVs+OcU465QnU2B09MjlfFpkuMgmM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eQ/1+nDLGtjU3bVDkoqWocJmNcXgbWLTj2Vxr9HdRaF+9Kal
	phYdM4TC+WgZ7On+3QZ8J66WX7cZfkax6Lh9LVBWsM+V/dGa4ffY
X-Gm-Gg: ASbGncsrsw2l/czyaQE5hqTH34TS99VXvbHz/lqVxy40Tzdo+IvaHeJ2Eyy1RaSJr+L
	1urdbTiB7h5Ru2R9A/d3LIgFHmWRPqu149MrEpzj1gUbinr/4ONz0sNpnU3LIERkLj+a1ir1P5Y
	QiM+GKXVCYHV9/cSd9hTw/VywlFGr8dcK5+d3km1cCRnV9MWCWyedSfTKQldthiedmQhsDPHOVX
	krmLEcuIQM6UbSTjrZQLwmE9s6NMqjGY6vUgrkPgjYPVxljRcGaIhvqTz4HeU9Knw6W4Hcm18KR
	U6uK43e/F+0WXnseVHX/mBJz/Xcp3hZB221R8M4XdOs+cKKlOMfU/LQPepZKN577lDvYh0Ss/jt
	rYst3TseKJHn9Uas=
X-Google-Smtp-Source: AGHT+IHtyTAbb12nHg9iq1Qfx2ymhpqGsQF2bMASvRtPni01++HQHUO/z+Hi7IH3R0Q7InFaI68IdA==
X-Received: by 2002:a05:6000:40dc:b0:3a0:bcb0:f69c with SMTP id ffacd0b85a97d-3a34969ac5amr4163564f8f.3.1747250674296;
        Wed, 14 May 2025 12:24:34 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5d6sm20341715f8f.83.2025.05.14.12.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 12:24:33 -0700 (PDT)
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
Subject: [PATCH v3] kunit: fix longest symbol length test
Date: Wed, 14 May 2025 21:24:16 +0200
Message-Id: <20250514192416.12635-1-sergio.collado@gmail.com>
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
---
v2 -> v3: added dependency on !GCOV_KERNEL (to avoid __gcov_ prefix)
---
v1 -> v2: added dependency on !CFI_CLANG as suggested in [3], removed
	CONFIG_ prefix
---
 lib/Kconfig.debug                | 1 +
 lib/tests/longest_symbol_kunit.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f9051ab610d5..e55c761eae20 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2886,6 +2886,7 @@ config FORTIFY_KUNIT_TEST
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

base-commit: 1a80a098c606b285fb0a13aa992af4f86da1ff06
-- 
2.39.2


