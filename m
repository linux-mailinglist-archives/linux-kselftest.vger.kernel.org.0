Return-Path: <linux-kselftest+bounces-30034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D9EA797D9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 23:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422B01894CCE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 21:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8F1F4162;
	Wed,  2 Apr 2025 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="k7ICMfPz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D015575B;
	Wed,  2 Apr 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630402; cv=none; b=UQaDTrwQ496OBNjRmaAmMcqPbi2H5So8vONKbozc39VYCodIoOSUVimW7ThR1LrU9q80nGxwB24CXuTImFHbDOwty6bppTh3HXMQB8TawmuSxCTbGVc5fw0JT5nmXtcE8d07yYUh3hG5XGLrSsqlsgYMT/DJpkdGqKXfz9Vucr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630402; c=relaxed/simple;
	bh=OrpOFY06YktwnFU5O13rxBuoIxGvGFPh3gIGitQWkQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUALqXzIfHviF+AizDX18JFW6sEbmpRtg6HsHLvgyQ0lOTmlatlbuN+srHQoDmm3oi2OiXTwcVlAVw+wxByYRzevHdCm8QwJxEmZDMhtbyi0JdoJcedT6KLJHxxUilvK8nGyrZxrpQdllv30L2PwLL2IraAYn0Hb/fg4DbNCsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=k7ICMfPz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1743629944;
	bh=OrpOFY06YktwnFU5O13rxBuoIxGvGFPh3gIGitQWkQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k7ICMfPz37jDyiRN8TWMTIy3ilQcJIxv9wB8QcEzO7M5LNaFTrIKYMY+mEGQjD0wu
	 tujUDu8girmF26aTZ97yaGqEIhUTuaVlt/XqBsw8UAvgMycforDQ99KUPROm/YS6N8
	 W+jG/qnvAbbtFtco3LbaKKmXbnU2sgcCfy7w25u0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 02 Apr 2025 23:39:00 +0200
Subject: [PATCH 2/2] selftests/nolibc: only consider XARCH for CFLAGS when
 requested
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250402-nolibc-nolibc-test-native-v1-2-62f2f8585220@weissschuh.net>
References: <20250402-nolibc-nolibc-test-native-v1-0-62f2f8585220@weissschuh.net>
In-Reply-To: <20250402-nolibc-nolibc-test-native-v1-0-62f2f8585220@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743629943; l=1340;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OrpOFY06YktwnFU5O13rxBuoIxGvGFPh3gIGitQWkQo=;
 b=y7rOLmC0yuFSSMk+akQoVKInkOn7cD446cYeeD3AYTnlHKJTC/XRq7zjVsQhi15uyHqRJrhhb
 /stD0fmZbHkDXBvWXIiSWId6/oCPBehMwR1OTUx4SN56w/K1+1nb0NT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

If no explicit XARCH is specified, use the toolchains default.

Suggested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Link: https://lore.kernel.org/lkml/20250326205434.bPx_kVUx@breakpoint.cc/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 34d01e473c013a1400bf6023132017a5f663f75c..89ee265f7467e2e5e32edf3eb51b4ec758e8004f 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -174,10 +174,13 @@ CFLAGS_s390x = -m64
 CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
+ifeq ($(origin XARCH),command line)
+CFLAGS_XARCH = $(CFLAGS_$(XARCH))
+endif
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
-		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
+		$(CFLAGS_XARCH) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
 LDFLAGS :=
 
 LIBGCC := -lgcc

-- 
2.49.0


