Return-Path: <linux-kselftest+bounces-48289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F922CF81FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 12:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F4693040F27
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 11:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C93271E8;
	Tue,  6 Jan 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hB17b3Ct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86349327BEE;
	Tue,  6 Jan 2026 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699905; cv=none; b=YrQFtpLIKJ10WAhfxUlsuENCawMEEEwQ+zV2amX0XoECt3JjoTgdEUrgcNHX6RNl09TxrWhh0zXuTvypl7350N7l1bJ/UTK3gopfCEMiVV9stfXR1PXaUsaVmJkwoiq9trtg2oV59N1Vba+8uT/na1oqimTfMJOW6/g1lUFYMzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699905; c=relaxed/simple;
	bh=uuQlUJTqdVKbCEjW6Ip9+Luwl134KZh+iqFAkBXukCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVaRWtct3GojJgIo+ZWlMtRmgmy5kfgvsU7AxwNdBRYke9c/4XPeqUdDNijD+YfwZNjuXS0+BXK8JHUZMcx44PL53kMWJQMGuovmCr4J7lZCM+ULBDU5BvwPjooDamvpR1iPCKJRCB7y0WvHy7p0w/5ric6QEwYhxhBcIHy8n6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hB17b3Ct; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767699898;
	bh=uuQlUJTqdVKbCEjW6Ip9+Luwl134KZh+iqFAkBXukCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hB17b3Ctw+NtMresDIYwb+YwFrEhXkyyNZG0/5iiF/AEUjKJsRUDNO9+2MfDCw+FL
	 A8HCK/aEvTTeqgzFRJlbSbNDW9SlxABwgE47y0BtJ5U5hPLooC8HZrUSrRsL5JNKCm
	 thD08NCgJs5DUO3oCzgTXyEldv2NRmfMnDxWo/VM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 06 Jan 2026 12:44:59 +0100
Subject: [PATCH 3/3] selftests/nolibc: also test libc-test through regular
 selftest framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-nolibc-selftests-v1-3-f82101c2c505@weissschuh.net>
References: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>
In-Reply-To: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767699897; l=1335;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uuQlUJTqdVKbCEjW6Ip9+Luwl134KZh+iqFAkBXukCQ=;
 b=gx4k8ThN4r+9q/v9LeZEjEXMPzqi7HI+zddZWA2sg0MS7hp0ouF1YJo6DrM9EcvPQ0wi3IIdZ
 KuRWeq7PiPzA+AV6LFwJG6CkjEQgF8vZacHrXuVol6AU+LLrTju8c+0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Hook up libc-test to the regular selftest build to make sure
nolibc-test.c stays compatible with a normal libc.

As the pattern rule from lib.mk does not handle compiling a target from
a differently named source file, add an explicit rule definition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 43f0b608c796..0370489d938b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_GEN_PROGS := nolibc-test
+TEST_GEN_PROGS := nolibc-test libc-test
 
 include ../lib.mk
 include $(top_srcdir)/scripts/Makefile.compiler
@@ -15,6 +15,10 @@ $(OUTPUT)/nolibc-test: CFLAGS = -nostdlib -nostdinc -static \
 $(OUTPUT)/nolibc-test: LDLIBS = $(if $(LLVM),,-lgcc)
 $(OUTPUT)/nolibc-test: nolibc-test.c nolibc-test-linkage.c | headers
 
+$(OUTPUT)/libc-test: nolibc-test.c nolibc-test-linkage.c
+	$(call msg,CC,,$@)
+	$(Q)$(LINK.c) $^ -o $@
+
 help:
 	@echo "For the custom nolibc testsuite use '$(MAKE) -f Makefile.nolibc'; available targets:"
 	@$(MAKE) -f Makefile.nolibc help

-- 
2.52.0


