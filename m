Return-Path: <linux-kselftest+bounces-31741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC059A9E455
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3913B09FF
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 19:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5AF1DED76;
	Sun, 27 Apr 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4EL4f0o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03B1F941;
	Sun, 27 Apr 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745781020; cv=none; b=kxrz1CgN3Vkk0/b3hHlDF4A7Wv4/Z97lTucyghe2u1V2JXRptGu41FBf+25qse2+4SZDEHtnxlrza76RYrC8enyRUrGWDicfOiVqx7e5S++abFvpF/faIthTzF3mB1oZ/oNdmjAuf7CkkUuUoI0wp9KkD4JHVthelmkfXCRnKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745781020; c=relaxed/simple;
	bh=BwsmqjxOlvgtajxUa3AChnITszm6K7uhQQ7nCyUt5eE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PbCHJVHkZ6jYoJAn79xKUsTSUPmpvKPNr1Lz5M5Rf+xG+gk/vdfrjnuyjNVisEajw7o0EBjfNCjxaeeE3fxZ9SyVjMNLk4VMw4ARwzvUYrhcOjobnhZ7Twui6QMz5r+BOuqbRxm2isbxG2nR7I5w665PX3/4AZrphEE9pKZgVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4EL4f0o; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso2975696f8f.2;
        Sun, 27 Apr 2025 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745781016; x=1746385816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ge9820yXbI8wZgZKp/xwgv/LaEDKz9rsK7fzu5fyAQg=;
        b=k4EL4f0oDBNrEqmX3N+ToWKwvr8hxU2GkfRZPZ8tJSPsidXsVmrj9cEd2cnw35mp0S
         sQhq92OAK8vo2f70qRQ2CV+Yyejl7se8ZVyhDQt7NKnSNr6JXacNV+z3X535gAQ/nfhH
         Aif06eQsq5WLqwBWwz6QxrA2GTaiGTol4uq2nAwoyEC7qlXQuTvaeFoup+zs4EwCDtHk
         ya0ELrUdqQ1HjEj2lwKLkq/3pVjy5i1pw8XBJm3WtEK1i68XmK9/PbxPx+88XMNtA+r8
         Ok6hhIDW8TAp8hnXAOX96hGFMp49mWq5NCuVXjVt106MsKbrpRh+K8yQZWkUs+1H28R4
         OgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745781016; x=1746385816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ge9820yXbI8wZgZKp/xwgv/LaEDKz9rsK7fzu5fyAQg=;
        b=wvpFoLo32aQR0lyMPNtv8H4fD8EJikiAb5lbyG9PRta8TdcsHe3+r1BMLkXGfHaAf2
         boS3PON/jTeTRoEjnXLUTVaZn9CRg3NZ5WajZe6JGg8X36ytsEUK1b/yh75+l0uVr4nj
         wIvo1DYQ/RYokvY13/syhYp+vU6Az1WBFmhvJTcfQWTubSio5FvvBbl+1/7OknSv+eZr
         aPg29hwTsNERt+mdIGtKY9o5YTjnZWava3apuW3iAR562NA1/B+YV2ye7H5KY+vd6O6A
         H6Yn4T27OEDOrqQyxrd4JQYTS/1vdau3wWPmdVXpaTe3SvajxgG/lJNiHtf52JHJzT79
         uJJw==
X-Forwarded-Encrypted: i=1; AJvYcCU1xgDBzckQqxrGViiT9Ab/Ey4h/sPF1rjMOeh+d/rjR/njhCQ2UwLpiOVmv500QLE1zx+QjxqjPDwGu+A=@vger.kernel.org, AJvYcCVPxELkb6vzXsdP1tJ6A0nBbmO7B0oywn2aHRgIXYUi/KE02jho/9IDkkkEwYx/876usm5RZMm/DA7fXJa8XKYG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7dgPqzV/rZ74zEraGxERb1mLmeY7UtsE0kQ0WUQS/GxEF3rL
	1vciVTAaX+6T0ZojDX3m4/xykSo5U3sDObfe9yyq2F3UYfO5Rv95
X-Gm-Gg: ASbGncsCZZOjTerexDDmpvGdNtv/F5QMRe8/4F5QnbP0AUkR64Z8kZRTimTy2QepJrw
	80+Yj40UCM4jszpRt4y1fh0OxGcoDz+kytLIyoWJDYeTsxKsP1WT4ipHc28xWn0NkEnsFyBbRf/
	jao5+SVNX3Yds2qpmnxL3Ye00RHCmSWvczesZU4v/+AKIYdghBk6BoD3rlmhyLphPJmjwAzEqTw
	x2Ym5z8bxcnuGkzTayxXEXeGN80nPWwov0LCsSU2WgaKpoxuQMQb7EgqNXxTmLhazpQJDXX2SbO
	1GdQ7/x+mW1LuMcUrutAl6Gj235VZS3PvqNbUwVIxqzrLx0e3J/kLP1uy1N2QR7d6bA6t+umpes
	IlePL
X-Google-Smtp-Source: AGHT+IFf4wn52xiTif+kCYGVJr/DZ7FRSj4LmCvUmksx5eL9aVasDuzMIC/IU43O23aqVbZHbgXhtA==
X-Received: by 2002:a5d:59a7:0:b0:39f:efb:c2f6 with SMTP id ffacd0b85a97d-3a074e3e6a8mr8904034f8f.33.1745781016088;
        Sun, 27 Apr 2025 12:10:16 -0700 (PDT)
Received: from laptop.home (14.177.223.87.dynamic.jazztel.es. [87.223.177.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8c95dsm8861714f8f.3.2025.04.27.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 12:10:15 -0700 (PDT)
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
Subject: [PATCH] kunit: fix longest symbol length test
Date: Sun, 27 Apr 2025 21:10:09 +0200
Message-Id: <20250427191009.6179-1-sergio.collado@gmail.com>
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
warnings in some CI pilelines when symbol prefixes are used [2]. The test
is adjusted to depend on !CONFIG_PREFIX_SYMBOLS as sujested in [3].

[1] https://lore.kernel.org/rust-for-linux/CABVgOSm=5Q0fM6neBhxSbOUHBgNzmwf2V22vsYC10YRBT=kN1g@mail.gmail.com/T/#t
[2] https://lore.kernel.org/all/20250328112156.2614513-1-arnd@kernel.org/T/#u
[3] https://lore.kernel.org/all/ycgbf7jcq7nc62ndqiynogt6hkabgl3hld4uyelgo7rksylf32@oysq7jpchtp4/

Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
 lib/Kconfig.debug                | 2 +-
 lib/tests/longest_symbol_kunit.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f9051ab610d5..6937dedce04d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2885,7 +2885,7 @@ config FORTIFY_KUNIT_TEST
 
 config LONGEST_SYM_KUNIT_TEST
 	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
-	depends on KUNIT && KPROBES
+	depends on KUNIT && KPROBES && !CONFIG_PREFIX_SYMBOLS
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

base-commit: f1a3944c860b0615d0513110d8cf62bb94adbb41
-- 
2.39.2


