Return-Path: <linux-kselftest+bounces-21796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D893E9C4500
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D11B284067
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440CE1A2645;
	Mon, 11 Nov 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB7PRkM0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD014F117;
	Mon, 11 Nov 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349990; cv=none; b=XmwjRStXXU0g/ooNpGrw1VsMBEW3xD2pZqlSU2ur7aJHYXGNB2i4JDZ8yqEt0IKPEoL3IKBoh/jIUL0vEvfPJ4HUbzpLOcWlYPZjaXHiWK4+Zds6BABEwjeUwsksIY6Xx00Q/g+6gESwgNrZN/Uds44N/E0q76qQGeZqlfnhXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349990; c=relaxed/simple;
	bh=3B/5kUYL8W4cwhJZ8ncK+YOGBwMwcZd5A7SQVXdUjpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KbNlUprHqnAD/nErWq01iqCYhG3EYZNar1fxgp9IzOY4sAJ7G0V9FSeNT1CCnmDHdO+yBeFJF69UgW1BVid2m6ljDnWOCbzVLs/ulM4RTdlYCgqT+4uPIp98tKOdWGTPk74DRhz4+Typf+yD8eoCAAxJUHeN4DosLjYbP+1H54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB7PRkM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2FFC4CECF;
	Mon, 11 Nov 2024 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731349989;
	bh=3B/5kUYL8W4cwhJZ8ncK+YOGBwMwcZd5A7SQVXdUjpo=;
	h=From:Date:Subject:To:Cc:From;
	b=eB7PRkM0tXHORqfiHIBcRDu5y+IkUJbJfzKwEJ51BPQxCfXaLr7PUbHsy/n+6kYcP
	 5sVWVtULEnSeAcTbFuxHYZ1BFlZ1sN3In6ADELGEEwFModnm/K58IXO6Jeqlldk9f2
	 Stj7iOodNoR2rhClQEOVXy1AaZXUqM5HlvcfnD23mIACZPvlJXYxi6zlxo6b7u5EeP
	 6oWok625A3KZ9fOmrSMEcAELv3GfTCGHPDjdfnH7dKfHKFnVkuqp4HoHQmQys3XYvP
	 fe3EYWXp/9bkK5vHxlBugJhtEojgvodqfdF+QzvSDG2rYmt5WCpC8/VDYAI63tavnb
	 ZXnveMeQwOy0w==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:32:58 +0000
Subject: [PATCH] kselftest/arm64: Enable build of PAC tests with LLVM=1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-arm64-selftest-pac-clang-v1-1-08599ceee418@kernel.org>
X-B4-Tracking: v=1; b=H4sIANlNMmcC/x2MSwqAMAwFryJZG2hF/F1FXNSaasAfjYhQvLvB2
 Q3MewmEIpNAlyWIdLPwsavYPAO/uH0m5EkdClOUVkEXt6pEoTVcJBeezqNfNUQ/NmYiU7e2akH
 nZ6TAz3/dD+/7AYmktUhqAAAA
X-Change-ID: 20241111-arm64-selftest-pac-clang-cb80de079169
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3B/5kUYL8W4cwhJZ8ncK+YOGBwMwcZd5A7SQVXdUjpo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMk3iGC0+I1ctBJ6Drd9vqX4HeZ5w93WHhdwde
 gKKAdXgreOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJN4gAKCRAk1otyXVSH
 0N9zB/sGxMPQGy1POFWcAZb/Bw9nz1cJKiFiWxfYnMrZeE4DTxzQXvwgAD0ZdwJKBL+WdWubUrq
 HxP9lpgZywM/WlPVh8UvOkn8aOwYfeLwzqGtw6GmDwT3ZLywgSZXYgB+/LHewyuLLxwheKgOQhK
 29iy0o4kd9SiKG2mdU2IUD2o/ODaA5aqPzE29iICx6prBe2HerBZcCk5wERHaKPlZwgq/juprJE
 zkBWNyF116RLWExxgAviOGGQuE9owohxbgteEyxkwpN6d4G+nvT7qCjvirFxsKyOTfVem0AJ2fG
 Pmr064U/ore/bqcfF0pQ4DqzlJE2jBqaKHqsHShaYsuGXdva
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we don't build the PAC selftests when building with LLVM=1 since
we attempt to test for PAC support in the toolchain before we've set up the
build system to point at LLVM in lib.mk, which has to be one of the last
things in the Makefile.

Since all versions of LLVM supported for use with the kernel have PAC
support we can just sidestep the issue by just assuming PAC is there when
doing a LLVM=1 build.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/pauth/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
index 72e290b0b10c1ea5bf1b84232f70844a601b8129..b5a1c80e0ead6932d2441a192b9758a049e3b3f8 100644
--- a/tools/testing/selftests/arm64/pauth/Makefile
+++ b/tools/testing/selftests/arm64/pauth/Makefile
@@ -7,8 +7,14 @@ CC := $(CROSS_COMPILE)gcc
 endif
 
 CFLAGS += -mbranch-protection=pac-ret
+
+# All supported LLVMs have PAC, test for GCC
+ifeq ($(LLVM),1)
+pauth_cc_support := 1
+else
 # check if the compiler supports ARMv8.3 and branch protection with PAuth
 pauth_cc_support := $(shell if ($(CC) $(CFLAGS) -march=armv8.3-a -E -x c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
+endif
 
 ifeq ($(pauth_cc_support),1)
 TEST_GEN_PROGS := pac

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241111-arm64-selftest-pac-clang-cb80de079169

Best regards,
-- 
Mark Brown <broonie@kernel.org>


