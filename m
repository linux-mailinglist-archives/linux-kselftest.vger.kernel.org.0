Return-Path: <linux-kselftest+bounces-31207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01729A942F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D4189F0EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186FE1DDA0E;
	Sat, 19 Apr 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="d+mdfVrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1BF1D7999;
	Sat, 19 Apr 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059595; cv=none; b=cU3jozcOfWUYUUs30pGGxcRJDG1JrQpKp0erm85Q1KeHqHh7yH7DM5ojKHlgFCOGOukbQOK+TGrCfB17SfKAA1jBrOTRMfAx3+VLzjRX5tuFCZukk2cUoR1Lf/gbi/7dgwV2i7TFlhi7fJN1h0IZbgGHhAg0aH9ceKbP4QN74dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059595; c=relaxed/simple;
	bh=PDaLLP/sYgP08Fp3qi+j7XEW/p3gaSCx0iAVLrHvJUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KClBwbeVscr+oHIwDP4FTEuTMdLk2OO3StzzFpQ35ihlfyXP7kfYvAwQoWCBv3oyryjcoUKSvKjCH3/DacDZL9a+6j58WRhMuwEez/rfZFLIcHOxVSMvLh/oUFGK07RvMCD5OGpz5Ug+EEkLgMrHEr0GC85sB9Pqq15jehUzuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=d+mdfVrh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745059588;
	bh=PDaLLP/sYgP08Fp3qi+j7XEW/p3gaSCx0iAVLrHvJUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d+mdfVrhTzKYz2vjWCrw75JXcNny08XnWlGveh3FzK+WWeXWKOfS8wh/JCwvLa6vi
	 N/mNlNr2dI6/vuZPdA/wasNk+h6CJRSR/cKDz3cHTjTf8BeZyQVTJKe1u0VGm8OHzq
	 MeSC5YumUusdKoJSKkPWof8Eg3g3WeKwn8fagaOY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Apr 2025 12:46:24 +0200
Subject: [PATCH v2 7/7] selftests/nolibc: enable UBSAN if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250419-nolibc-ubsan-v2-7-060b8a016917@weissschuh.net>
References: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
In-Reply-To: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745059587; l=1345;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PDaLLP/sYgP08Fp3qi+j7XEW/p3gaSCx0iAVLrHvJUk=;
 b=VrOAFef5uSOfNGE+TQ9t/522pEObkrLOAr8L8V7NEGY3EslnUabvmn4udQSryDa21is4soX+2
 JEj9D26uYkHCKvVTw7G1+KA+XAPbwy0T0jb/WF0Rs554ZqJtU51pZ6d
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

UBSAN detects undefined behaviour at runtime.
To avoid introduction of new UB, enable UBSAN for nolibc-test.

By signalling detected errors through traps no runtime dependency
is necessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index aa05c1faac20d3054b231090b939d050b0231d40..94f3e8be7a68f63ecd639c4f283b3cd10764ce74 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -189,9 +189,10 @@ ifeq ($(origin XARCH),command line)
 CFLAGS_XARCH = $(CFLAGS_$(XARCH))
 endif
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
+CFLAGS_SANITIZER ?= $(call cc-option,-fsanitize=undefined -fsanitize-trap=all)
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
-		$(CFLAGS_XARCH) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
+		$(CFLAGS_XARCH) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_SANITIZER) $(CFLAGS_EXTRA)
 LDFLAGS :=
 
 LIBGCC := -lgcc

-- 
2.49.0


