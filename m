Return-Path: <linux-kselftest+bounces-41606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C927FB59E64
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 18:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566C43ACFF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801031E8B9;
	Tue, 16 Sep 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dfX7/PBY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55B3016F4;
	Tue, 16 Sep 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041520; cv=none; b=TVLp0TTKUCaUVNwK23/g4+hSqVtuhuTpcPM9fvbbPUsHOFZJnt/tWM/qXPGhW+5g/KUDTHsSpSku+TLM20ZKPg5c9EFq8KbK9JdfYZdr4k5rVSXHFRpyekiniJrz/sDf3Xm1cLo5Q5Y0ZlPpgW3YdCOJX9fOIr0pBzORA8SFrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041520; c=relaxed/simple;
	bh=lBF3mDXzti9+laxIzr4FHTuLqFzaAZ5MHcHfIKkRgqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MLSzNZ7I6ZcXnlQAjsKC5yOc+SbwTX+svJ9cAWRaYSlholfAX3eX9PdEW9wzc2CfOST9vqqEIziuGGIhs2ICbaEyKY5hkVkOT6U9KvnagX3XUEH+eddOxIZ62BTDGy/HxclWfH8/1ul0v9SAlQTDGOffY2t7tcxXr58sVZSfT20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dfX7/PBY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758041508;
	bh=lBF3mDXzti9+laxIzr4FHTuLqFzaAZ5MHcHfIKkRgqE=;
	h=From:Date:Subject:To:Cc:From;
	b=dfX7/PBYX9o6OmQQ5mVCPe1wVbVQoZ1oMUaQF+ooFBmySRUtb0+p3IeOSXqi02FSm
	 utNVgiZS4SE4lAQvG70jNzpiwxY6GxcVRurvy7w/5tQGebavlbjK1c7z17g+qTfnOk
	 rvkM5uJJlKrCdQGHCb12UuMrCQ5pty3EzcU32HJY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 16 Sep 2025 18:51:35 +0200
Subject: [PATCH] kselftest/arm64/gcs/basic-gcs: Respect parent directory
 CFLAGS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250916-arm64-gcs-nolibc-v1-1-ee54aa65fc26@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJaVyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3cSiXDMT3fTkYt28/JzMpGRd8xTDNAPjRKNE4+Q0JaC2gqLUtMw
 KsJHRsbW1ALPe7+ZiAAAA
X-Change-ID: 20250916-arm64-gcs-nolibc-7d1f03a2a3cf
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758041507; l=2128;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lBF3mDXzti9+laxIzr4FHTuLqFzaAZ5MHcHfIKkRgqE=;
 b=k/GviUbM+MEMtaxixr3f1Or6Y88ToYlCi3Dv8wXkzwS729fUzQxmaGGkpeUfsWF8zi6QA6j/Q
 s2SOuEGp+WcDRb8GXPEQ0KPh6IS/WlK77QYakGkAydZD48tzEcrHQ0a
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

basic-gcs has it's own make rule to handle the special compiler
invocation to build against nolibc. This rule does not respect the
$(CFLAGS) passed by the Makefile from the parent directory.
However these $(CFLAGS) set up the include path to include the UAPI
headers from the current kernel.
Due to this the asm/hwcap.h header is used from the toolchain instead of
the UAPI and the definition of HWCAP_GCS is not found.

Restructure the rule for basic-gcs to respect the $(CFLAGS).
Also drop those options which are already provided by $(CFLAGS).

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/lkml/CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com/
Fixes: a985fe638344 ("kselftest/arm64/gcs: Use nolibc's getauxval()")
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/arm64/gcs/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
index d2f3497a9103fc12ebc90c7f4e33ab9b846c6c8a..1fbbf0ca1f0291d00882920eb2d1efbf99882ec1 100644
--- a/tools/testing/selftests/arm64/gcs/Makefile
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -14,11 +14,11 @@ LDLIBS+=-lpthread
 include ../../lib.mk
 
 $(OUTPUT)/basic-gcs: basic-gcs.c
-	$(CC) -g -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
-		-static -include ../../../../include/nolibc/nolibc.h \
+	$(CC) $(CFLAGS) -fno-asynchronous-unwind-tables -fno-ident -s -nostdlib -nostdinc \
+		-static -I../../../../include/nolibc -include ../../../../include/nolibc/nolibc.h \
 		-I../../../../../usr/include \
 		-std=gnu99 -I../.. -g \
-		-ffreestanding -Wall $^ -o $@ -lgcc
+		-ffreestanding $^ -o $@ -lgcc
 
 $(OUTPUT)/gcs-stress-thread: gcs-stress-thread.S
 	$(CC) -nostdlib $^ -o $@

---
base-commit: 14a41628c470f4aa069075cdcf6ec0138b6cf1da
change-id: 20250916-arm64-gcs-nolibc-7d1f03a2a3cf

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


