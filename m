Return-Path: <linux-kselftest+bounces-34446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEAAD191B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB3A167921
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3326280017;
	Mon,  9 Jun 2025 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nqV36Ytf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D93155342;
	Mon,  9 Jun 2025 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454767; cv=none; b=LDNr3uZcqQQDqLmecDTXf6Zcj0+DW4AYEd7G3B/ykBRS+pfXznCzQLFaOck2u50bctsFqavnVhyPCWxBzKCUWxjojRhgL7CyxlaLu7WKSxx2fXU8Y67UDRg7Hyi0+hvSW3slJfO0gXOyqae6S0U9hHSKybvdfjZdrm9OBD27gRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454767; c=relaxed/simple;
	bh=H7hDZq77HAh1Y55r0jDQ6rp5vMmxTjQKStTpiBMCdPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tKO1c2ap2mdENq5BTUQYIL+EqajSKwxP7KJ+t+mXKRBIis5zBQZD4rgGOLECck+ql1FWE8+ThwJQL0Uxv9yMYqkO8oSvHonjgs6FjcMucnFeiAx5q4A7AViYKwJjdzZoS04ABj22gD92ylO6iGyvUzButhE7hMvKVKJXfUhL4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nqV36Ytf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749454762;
	bh=H7hDZq77HAh1Y55r0jDQ6rp5vMmxTjQKStTpiBMCdPc=;
	h=From:Date:Subject:To:Cc:From;
	b=nqV36Ytf4vYzOiVhWKmmuhvEV47uDitWQakTjpPOVUgmIjyrNqw8ZQ+97J7ryDtMz
	 SJXD0Rv9nlpmMwV5XUYY3cJnFGU8glpYmQQrBmcSr1IZR1emyURq95rnpvOyL3pAvQ
	 0TMrQSAlZO2PEOALcHfxo0Na5AssuQULgDlUYC5E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 09 Jun 2025 09:39:16 +0200
Subject: [PATCH] selftests/nolibc: make stackprotector probing more robust
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-nolibc-stackprotector-robust-v1-1-a1cfc92a568a@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKOPRmgC/x3MwQqDMAwA0F+RnBeolSLuV8YONYsaNhpJujEQ/
 31lx3d5BzibsMO1O8D4Iy5aGvpLB7TlsjLKoxliiCmkIWDRl8yEXjM9d9PKVNXQdH57xXGkaUk
 pD1PsoRW78SLff3+7n+cPlhqsF24AAAA=
X-Change-ID: 20250530-nolibc-stackprotector-robust-77c9f55a3921
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749454762; l=2141;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=H7hDZq77HAh1Y55r0jDQ6rp5vMmxTjQKStTpiBMCdPc=;
 b=q5L+PaMurUR4F/A+zymz8S43QNVgEvP0TFCeq3erVVR/uzBgpqgBj2X5l0O+Lmb+mLkGP9te0
 0N/VgFJuZIgCWwlhJGWQGmtjbgCy9tLuKvwsR9PzhIbtlGsMVIKRE8i
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

nolibc only supports symbol-based stackprotectors, based on the global
variable __stack_chk_guard. Support for this differs between
architectures and toolchains. Some use the symbol mode by default, some
require a flag to enable it and some don't support it at all.

Before the nolibc test Makefile required the availability of
"-mstack-protector-guard=global" to enable stackprotectors.
While this flag makes sure that the correct mode is available it doesn't
work where the correct mode is the only supported one and therefore the
flag is not implemented.

Switch to a more dynamic probing mechanism.
This correctly enables stack protectors for mips, loongarch and m68k.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 94176ffe46463548cc9bc787933b6cefa83d6502..853f3a846d4c0fb187922d3063ec3d1a9a30ae46 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -195,7 +195,10 @@ CFLAGS_sparc32 = $(call cc-option,-m32)
 ifeq ($(origin XARCH),command line)
 CFLAGS_XARCH = $(CFLAGS_$(XARCH))
 endif
-CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
+_CFLAGS_STACKPROTECTOR = $(call cc-option,-fstack-protector-all) $(call cc-option,-mstack-protector-guard=global)
+CFLAGS_STACKPROTECTOR ?= $(call try-run, \
+	echo 'void foo(void) {}' | $(CC) -x c - -o - -S $(_CFLAGS_STACKPROTECTOR) | grep -q __stack_chk_guard, \
+	$(_CFLAGS_STACKPROTECTOR))
 CFLAGS_SANITIZER ?= $(call cc-option,-fsanitize=undefined -fsanitize-trap=all)
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250530-nolibc-stackprotector-robust-77c9f55a3921

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


