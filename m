Return-Path: <linux-kselftest+bounces-35465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9BAE242E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AAF17F9FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 21:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DEB23A9BF;
	Fri, 20 Jun 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C9SVEg7/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB8238178;
	Fri, 20 Jun 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455589; cv=none; b=GMtm+HGt3S9rXntEAHF7tliPVJgu1Bhc9WHrHkJ3Hr1JOYGYkYDP3DzQoAbMAZtAb+AfTGgjqCwUP/deIn6Kf4NaKA3Pwj/sQ3KOXPPp1Tb01ndT9z96c26xDr/r5rLrXa1XGZcGZsdNqm4tjQoj/UqHpyyUyDf7O6Pf5NMhEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455589; c=relaxed/simple;
	bh=6ml43yk9vOCtPWikBGN5ZCduTpE8kt0rfUh8lqsvMj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sewlcLRw2juxO49xn32aDCNWpcemL++JPJvc4whyhknZN6wnn9uoGR+nBI05WNs82NYgePY3gyyWGjA1cWzHinf+RC5NoQf+U5mqrv72VoBH/aGrwQ+/Py+u/LoTR420WPEPM5D7UDkMQ9WAl1SG1dgAhTJoiSkSFYdNRs0zc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=C9SVEg7/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750455579;
	bh=6ml43yk9vOCtPWikBGN5ZCduTpE8kt0rfUh8lqsvMj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C9SVEg7/3edLKq9BxGqCoKi0TK9ulapsfcg1kxaMk+5t3AhgQ5xQokAHL3s+rKb/1
	 OsLuQgL+sHpKfqa2C9dtVSm+/VGnE8XSVVphqCrA6ga2QWHsaeWb6rHRV5L9MoOwzD
	 CJIUmLT9icjfHRpnIZcFQ/dizL0uXY8eO5Yt6mwM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 20 Jun 2025 23:39:31 +0200
Subject: [PATCH 2/4] selftests/nolibc: split out CFLAGS logic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250620-nolibc-selftests-v1-2-f6b2ce7c5071@weissschuh.net>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
In-Reply-To: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750455578; l=2577;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6ml43yk9vOCtPWikBGN5ZCduTpE8kt0rfUh8lqsvMj4=;
 b=kya2WzdcUMU0j+ht31ZZrJE3DWAcrPDj7HtBvA5GOekBCkyTZWKRtDDacqSfOdHCalFOHbEqh
 hUTeSvMwJtaAS4zXFjLLv7+ylaYexs0LmIXK1+ZnB+x0/mk+F69X9l/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Some upcoming changes will reuse the CFLAGS.

Split the computation into a reusable Makefile.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile         | 12 ++++--------
 tools/testing/selftests/nolibc/Makefile.include | 10 ++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 41b97dfd02bff3fb57f4d2b73b718f5c389d25e9..6d62f350d0c16405785a8aabc7f5741b82e55370 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -195,14 +195,10 @@ CFLAGS_sparc32 = $(call cc-option,-m32)
 ifeq ($(origin XARCH),command line)
 CFLAGS_XARCH = $(CFLAGS_$(XARCH))
 endif
-_CFLAGS_STACKPROTECTOR = $(call cc-option,-fstack-protector-all) $(call cc-option,-mstack-protector-guard=global)
-CFLAGS_STACKPROTECTOR ?= $(call try-run, \
-	echo 'void foo(void) {}' | $(CC) -x c - -o - -S $(CLANG_CROSS_FLAGS) $(_CFLAGS_STACKPROTECTOR) | grep -q __stack_chk_guard, \
-	$(_CFLAGS_STACKPROTECTOR))
-CFLAGS_SANITIZER ?= $(call cc-option,-fsanitize=undefined -fsanitize-trap=all)
-CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
-		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
-		$(CFLAGS_XARCH) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_SANITIZER) $(CFLAGS_EXTRA)
+
+include Makefile.include
+
+CFLAGS  ?= $(CFLAGS_NOLIBC_TEST) $(CFLAGS_XARCH) $(CFLAGS_EXTRA)
 LDFLAGS :=
 
 LIBGCC := -lgcc
diff --git a/tools/testing/selftests/nolibc/Makefile.include b/tools/testing/selftests/nolibc/Makefile.include
new file mode 100644
index 0000000000000000000000000000000000000000..66287fafbbe07e1750e31c3b2388ac4be1e7f8ae
--- /dev/null
+++ b/tools/testing/selftests/nolibc/Makefile.include
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+__CFLAGS_STACKPROTECTOR = $(call cc-option,-fstack-protector-all) $(call cc-option,-mstack-protector-guard=global)
+_CFLAGS_STACKPROTECTOR ?= $(call try-run, \
+	echo 'void foo(void) {}' | $(CC) -x c - -o - -S $(CLANG_CROSS_FLAGS) $(__CFLAGS_STACKPROTECTOR) | grep -q __stack_chk_guard, \
+	$(__CFLAGS_STACKPROTECTOR))
+_CFLAGS_SANITIZER ?= $(call cc-option,-fsanitize=undefined -fsanitize-trap=all)
+CFLAGS_NOLIBC_TEST  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
+		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
+		$(_CFLAGS_STACKPROTECTOR) $(_CFLAGS_SANITIZER)

-- 
2.50.0


