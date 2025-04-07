Return-Path: <linux-kselftest+bounces-30199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D69A7D4A5
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9523C168811
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5622A4C9;
	Mon,  7 Apr 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4Q40ZmC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7/AcDJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEEF2288F7;
	Mon,  7 Apr 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008790; cv=none; b=MKFm6B8Umk435IH+1SKi3O+7d6sV7g4C1zIcMGNLTaZhuw+6lkMwhkXWguPYz1tCeqFxrwGfJPzP1k8+c3nT9LmE6/yGY3R7ZYbawY341O8zesRpv/bAFCs4Yj/4tvjgbxz0fbBZb8omlLJSWlzzujZGGC4Fnt7haPkWhDT81RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008790; c=relaxed/simple;
	bh=6pkon7Kh5/SE7q0KZvHsGJsIG9RSM3sGqKstS7SVzkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlKrXq4cPTkfNpLEZINJiq6/EwmPaLPO9w0lf7fykKhILCuzG6p4vTBGXU0qMpwezWV7hbBcEAkdCalK31W3Yi1daBscb7ChrVJoQzoKYa+7gqRt8O92hCOCfdOtUILRJMPLmTFwWnlLatc0Ffk2naC8CmJpjV+ZIYJi67lfiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4Q40ZmC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7/AcDJ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pv+09698FZpTal/X+RrmmE1s8VEJjIksZePhFfpyAqw=;
	b=s4Q40ZmCDmMS99Bvi3ruXx74WDA9/OcvqlbJMORgCLvxpkgBOHxpNGHEG6zV9cCifkeeQY
	4Bx6ngKLvG5JcaFeIx5PK8cLy3OO6kZV7ZY8BUuWwCsmfZVHltDihrj/EKNXOV3eq/V3Rp
	M//GDbtJ8rgSmiK5f2Ph6itPZNXg901DfFwT8IfJQoIAwpVweavvtOzZv0zZ40SPYRnjm5
	k6u78Mp5zPa/hYERU7bAc15pBbTU4DgMbeSA8jrMTs0J6Qm5/8ToLqQhiowHyg7dGos15M
	pvuseuo2pePWPkq+8XOcexD2Jx6kEonQhxF0logXmYn2p7LlKpILjq1H6Lc2HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pv+09698FZpTal/X+RrmmE1s8VEJjIksZePhFfpyAqw=;
	b=z7/AcDJ79d+veISA8eq1r4KuA1t5O8e6Gg/a2cb8i55V/lwfDNAyBW2bRWzOxKIkpf9T3E
	dz9qlLLSAcerIuDQ==
Date: Mon, 07 Apr 2025 08:52:36 +0200
Subject: [PATCH v2 13/32] selftests: harness: Guard includes on nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-13-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1082;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6pkon7Kh5/SE7q0KZvHsGJsIG9RSM3sGqKstS7SVzkM=;
 b=VUPqGH/CqJ9c693gGeDTP7kUCmYVU8ZWXB22zgFfEiIKJzrfQMonkwuEUySAtx2zUB1pX+O8e
 98fvlOy6u52Dd+j64ddlPZ8Z6lJC6E/xL7Pa2dK+clfPIHycwDwHpuo
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc doesn't provide all normal header files.

Don't try to include these non-existent header files, as the symbols are
available unconditionally anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 1e584f39a42023c400988dea96f0274d4dc3645b..4247c67b3060fbe9d224c1171f3ec998ae6b1080 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -57,16 +57,19 @@
 #include <ctype.h>
 #include <errno.h>
 #include <linux/unistd.h>
-#include <poll.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
+
+#ifndef NOLIBC
+#include <poll.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <unistd.h>
+#endif
 
 #include "kselftest.h"
 

-- 
2.49.0


