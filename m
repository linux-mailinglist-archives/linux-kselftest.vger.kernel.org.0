Return-Path: <linux-kselftest+bounces-31539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5756A9AC58
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4251B6672F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEAC226CEB;
	Thu, 24 Apr 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJt2WH76";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycWBSJAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7932701B2;
	Thu, 24 Apr 2025 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495299; cv=none; b=cPOOeAGB0+DthJj41Z6WUnyTw1ljWhFSsMlTZnxoA1F8cK3lVDcgMmCM+euFeGGdFq+sb4Kj+C+TDCAiABUSzpSLi3Qr8tKvUC1HV7UHuoPqwEp7fvd3Oeg0avJ/j7ZuHi4UiCQ9ZH04Hlw/DXbkq5O6e8XVWShbWdvQ0aY4hzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495299; c=relaxed/simple;
	bh=kSorqPSavc4iZtIeCw0TRCKBKtK4V92gpzBqgR+dE4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dq6XWxgGK8tS20iJN92GV2VQUDpiaolCa5mbP3FGZg9IjYzvLNuJgdwCg4WP7XIJH63UV2NI16qmjyXxyAqqTOHV7l4jvy2HMTN7WQupnA9oYHXknUoLdnupsFFhnXa80WXhupDGt6Vlv4wAUMv3cakIlItjfmy7a3Z+K7IL4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJt2WH76; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ycWBSJAV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745495295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRZV+0kC9YmkssdcQ3Hgc6CUeu9WsfgqL8ZT0sTbROc=;
	b=HJt2WH76P+zqN7V3n39G8vjo3AERBPBmyHThgeczjp0K42vk85ReMJn3PLnnbXl8HQLr7Y
	1x4lxqk5/8mYoEcUTBsAkBbC7lVpUYe1WIg1xLAmVAjE43lgz43bsqwDjaLP3Ovf1QphfD
	wrT7DGoh1YoCDZ6GScFyVf7+h5QxZ39Bf1o9aEy5JyKVf6mmKboBQ1BL5L6TMahg30ZVYu
	aylNy1wStAiGgxVubzNrhFKhO1/bUEiaJfFwaXdLfbLApUIpHfEwPfhyyykqA7f52nURm2
	ZUgNFjf2LYez3mXXHufFJJuP1/zTBW/35uG5RoszjrZM5SCk40dDYuSNrJteeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745495295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRZV+0kC9YmkssdcQ3Hgc6CUeu9WsfgqL8ZT0sTbROc=;
	b=ycWBSJAV0E6dcf5k09hRRKlpmOoAEKVDfFRleGhLCI/XcOukzLAs40w7RJyvhcMHMKwHXA
	ec/912u7kgqvBVDA==
Date: Thu, 24 Apr 2025 13:48:11 +0200
Subject: [PATCH 1/3] tools/nolibc: add target to check header usability
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250424-nolibc-header-check-v1-1-011576b6ed6f@linutronix.de>
References: <20250424-nolibc-header-check-v1-0-011576b6ed6f@linutronix.de>
In-Reply-To: <20250424-nolibc-header-check-v1-0-011576b6ed6f@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745495292; l=1315;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kSorqPSavc4iZtIeCw0TRCKBKtK4V92gpzBqgR+dE4s=;
 b=N0LLRDm35OqAxMjzv/9cpPBi2FPmFCj8+xRldAYmixxio+Hj5n8Vq5f7+EoWY/7nPscdppYSb
 IfVNbw0SwnGAqy33qS8LrWoTT0ii3BdEoJzScb1lneiyjQv7PIApmyp
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Each nolibc header should be valid for inclusion irrespective of any
special ordering requirements.

Add a new make target, based on the old kbuild "make header_check" target
to validate this requirement.

For now the check fails, but the following commits will fix the issues.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index e05862cd08051685112f067d6eb45716613dd43c..41ef18872a7e9435a5efec9c0b32b9e29fcd4ce8 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -101,5 +101,14 @@ headers_standalone: headers
 	$(Q)$(MAKE) -C $(srctree) headers
 	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)sysroot
 
+# GCC uses "s390", clang "systemz"
+CLANG_CROSS_FLAGS := $(subst --target=s390-linux,--target=systemz-linux,$(CLANG_CROSS_FLAGS))
+
+headers_check: headers_standalone
+	for header in $(all_files); do \
+		$(CC) $(CLANG_CROSS_FLAGS) -Wall -Werror -nostdinc -fsyntax-only -x c /dev/null \
+			-I$(OUTPUT)sysroot/include -include $$header -include $$header; \
+	done
+
 clean:
 	$(call QUIET_CLEAN, nolibc) rm -rf "$(OUTPUT)sysroot"

-- 
2.49.0


