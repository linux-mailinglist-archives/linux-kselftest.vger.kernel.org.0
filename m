Return-Path: <linux-kselftest+bounces-30975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E5A90B77
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 20:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5827AF496
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048E224250;
	Wed, 16 Apr 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rfqPuIb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428A217730;
	Wed, 16 Apr 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828848; cv=none; b=TH09djL1if72jmSH7aWhYw3bsUt0F4vavYxRa15EuQXT6NNjlE1AE6IBqa3adZu3oXZxMj2RG6iLfXTVUXQPTA+3jlpErI/VyMx1OWPOvtM2x2S6dRqOp7xvjCspcayx/SQXr98+sJGzmJNB6xsPJCfUHwpA6POnwKBMvBqjf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828848; c=relaxed/simple;
	bh=K8/JOiUEC1Un4wIBEvmCV0tkDDsaFdfktVZkJJkwMeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqmVl7A532dRkQLqLR1qegOs5wwEVQY2qQPOLtPWL5GysVNsbGQJkRlJpc5uheaOUK4p6TO8logQWovMsqgfXKoTzncx7lkimpp8TPHWyszlauNAixQniqIPqekbiwKo/tDta6Q48XNemnIjI4rEJDBgHbdIUZ5FM+vzb0vprek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rfqPuIb0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1744828842;
	bh=K8/JOiUEC1Un4wIBEvmCV0tkDDsaFdfktVZkJJkwMeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rfqPuIb0D4yU+wUtObsycCZDc9iIX797EolB6/TGWPNIJI1X9uMkDbzO+mu9Sf+7o
	 2CkfkcBtTxFnIS6TVCJQKG8Rr+6xqTXGZceZ7+H4Xv7p14/mLFb0/DOFYUL4yypSvb
	 b9Nvkf/jt8/6QAWBP1wcWJ1UJePIZcHSqtoGA+AE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 16 Apr 2025 20:40:17 +0200
Subject: [PATCH 2/6] tools/nolibc: disable function sanitizer for
 _start_c()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-nolibc-ubsan-v1-2-c4704bb23da7@weissschuh.net>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
In-Reply-To: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744828842; l=1091;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K8/JOiUEC1Un4wIBEvmCV0tkDDsaFdfktVZkJJkwMeM=;
 b=QQ2N2cTjuYwo64KAWqUYjrhMZS4I5cCA2+yNoDM31oFpHsCL0OJGFdaU5QFFiCCHVG1zoPv6m
 +M3tYhlBO0kDo77cnZ+czLaxufKfkTB+30XbNpVAlXReYzNZdUJrPW0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Both constructors and main() may be executed with different function
signatures than they are actually using.
This is intentional but trips up UBSAN.

Disable the function sanitizer of UBSAN in _start_c().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/crt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index c4b10103bbec50f1a3a0a4562e34fdbd1b43ce6f..961cfe777c3564e705dfdd581de828b374d05b0b 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_CRT_H
 #define _NOLIBC_CRT_H
 
+#include "compiler.h"
+
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
@@ -25,6 +27,9 @@ extern void (*const __fini_array_end[])(void) __attribute__((weak));
 
 void _start_c(long *sp);
 __attribute__((weak,used))
+#if __nolibc_has_feature(undefined_behavior_sanitizer)
+	__attribute__((no_sanitize("function")))
+#endif
 void _start_c(long *sp)
 {
 	long argc;

-- 
2.49.0


