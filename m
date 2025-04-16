Return-Path: <linux-kselftest+bounces-30979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE9FA90B7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 20:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73483188BB82
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823DB22576C;
	Wed, 16 Apr 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FKGY49PY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2722538F;
	Wed, 16 Apr 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828851; cv=none; b=PiuQgxbQAf7tVxEMOIFQNMWuQ+MslzknIMss9s/bwlBS8+FIEH1tKHKKytALA4rknowQHZag1r8v3unZ1fANJKx91bOfVihglhiBnIrQqdJ9l+49q4bxq/tEP83vaYbgvwKzy3aRnsCfVYJp/nudEmGKqVld79WvBODxwXTjc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828851; c=relaxed/simple;
	bh=Z1bcOwaEL8wb4h1D5AwFZlAHw44W8YDLCsN003ABHao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y2rLRGc7h+Fsxi371rScBBBM0Uj7LGfZ7JvM9R1/u06hEpqZvFk63BLaXjuNmwrN3sPS5WFsO9i8qR1MX4VHJOVpVSC6AevGxzRnbT/2o3U/aZTtjxQVGlP5d6Ngch0pYyiyZ4bqNL50lNq1SBMse1swV+LrhQVoiT40XjY0uok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FKGY49PY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1744828843;
	bh=Z1bcOwaEL8wb4h1D5AwFZlAHw44W8YDLCsN003ABHao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FKGY49PY+aJD3Zk9hYaJNGqTL2b9kWh9V1zAiApB9zkBxrWyO3gG6xRhOW6I/XLqK
	 /iXWjsAJd5Q2zeMam5O8wgV935eLlRa3tIYVbcezzjGX/SHGTIpzWR4WYa9LieOXEd
	 /FyhLfrguBiArRLUK2mIiCozc8sr8E2Ug24bshww=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 16 Apr 2025 20:40:21 +0200
Subject: [PATCH 6/6] selftests/nolibc: enable UBSAN if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-nolibc-ubsan-v1-6-c4704bb23da7@weissschuh.net>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
In-Reply-To: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744828842; l=1309;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Z1bcOwaEL8wb4h1D5AwFZlAHw44W8YDLCsN003ABHao=;
 b=5uH7BCyiQnYSwYc4OPAZ5rlK+ma+NvCLUa/EsmPXvEDEVpsBANvQVnSAT2W8GTzRrxn7DeLBf
 3v9YgXN0OrpBa5Jz7H7j0pHw/+rzfFAa2mVIp4bg9e5dOmFRf4pAdX/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

UBSAN detects undefined behaviour at runtime.
To avoid introduction of new UB, enable UBSAN for nolibc-test.

By signalling detected errors through traps no runtime dependency
is necessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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


