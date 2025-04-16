Return-Path: <linux-kselftest+bounces-30977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13256A90B7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 20:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991A619080E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A720E224889;
	Wed, 16 Apr 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ifJSGP5X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3087223704;
	Wed, 16 Apr 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828848; cv=none; b=t2abLh5O8DwhbNNJ/Pdzr02y5EloUQ7C4RU7B/oaqZzelPnHh+1lpbr6CY/NEX5UnLu9UvMoCczaCjcCTS5I35+AThAke+caCPaxzrB1lmofIP88vuoCptBkIxH1UOSX3hXjiDOWZ9rKPSiGBJRxbrFVV2Zu+lFrZ1/2Jn+AO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828848; c=relaxed/simple;
	bh=Fu/a9dHUfU/79QPTkLGEpbkvpxkUIMfawpy6A0iNqxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ri0vuGsKPorUovgKXPhuPk5u3gfcQL+ANfzdeAeZXsEaoWW1ESBJxvD8uxMrM0AA/zuc2P9Y/Crz5YhGy51IPENKbxfoxwucdG3rH3OxYA7eMe53Fo06FLLHiKmKcw+EEphnAYejPhh56sbZHQl9ysZLVufRtVnn87VyOUcl0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ifJSGP5X; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1744828842;
	bh=Fu/a9dHUfU/79QPTkLGEpbkvpxkUIMfawpy6A0iNqxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ifJSGP5X5Xbm/AliTmtM6wjYYntUKSAsiTdMiSNv+lZVOZWii9TLOGiNbcBJA+Yfr
	 8zFxAu/hEMTSxj0H5nqKcdCVvumfgE23L2bu9Yydzu0K6EIQTiNnQDvogivL3z4+s3
	 i5QoUL2YF4tkB4DlpPSyJnyJDrOdgSaMjkKdNLGI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 16 Apr 2025 20:40:16 +0200
Subject: [PATCH 1/6] tools/nolibc: add __nolibc_has_feature()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-nolibc-ubsan-v1-1-c4704bb23da7@weissschuh.net>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
In-Reply-To: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744828842; l=938;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Fu/a9dHUfU/79QPTkLGEpbkvpxkUIMfawpy6A0iNqxY=;
 b=6mD9EMxPbYU6B9IHPYXEzi0/duHTLc5UtlrDufYHs+4MgVdRWdOxGC9PGbscrA4KssHl6gUML
 pCdzAEiW9X+DevEZ+8lBNl6Zpp0LoiY5POuuuT7NFDaAJbkju4bM1zb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Certain compiler features are signaled via the __has_feature()
preprocessor builtin.

Add a nolibc wrapper for it, similar to __nolibc_has_attribute().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index fa1f547e7f13d151ea98b9c585b36659d2d27324..e6d6dc116e43aa69b37eca02ed1590fc09486bdb 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -12,6 +12,12 @@
 #  define __nolibc_has_attribute(attr) 0
 #endif
 
+#if defined(__has_feature)
+#  define __nolibc_has_feature(feature) __has_feature(feature)
+#else
+#  define __nolibc_has_feature(feature) 0
+#endif
+
 #if __nolibc_has_attribute(naked)
 #  define __nolibc_entrypoint __attribute__((naked))
 #  define __nolibc_entrypoint_epilogue()

-- 
2.49.0


