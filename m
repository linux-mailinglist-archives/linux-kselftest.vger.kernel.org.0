Return-Path: <linux-kselftest+bounces-30550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F17A8574E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F201BA8540
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E89D29C33E;
	Fri, 11 Apr 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0iKOsu1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlF/havO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22929AAFE;
	Fri, 11 Apr 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362116; cv=none; b=RXimBsWyVBx+mpZBkDj1gxFn1ZJ6uCMsE7u80+CeB0umEDbEXYhWBMo5tpAqrqD97T98nimgmHhOLxgUtpExx3fvKZqYjkPDe0Bh3gUjhgFBmmpi0UwWuQTcDVI3/XuHwbMBIXEc/ml5UotQY7fYCORUTh0KKfu4fK7UeFugwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362116; c=relaxed/simple;
	bh=6pkon7Kh5/SE7q0KZvHsGJsIG9RSM3sGqKstS7SVzkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nzLH3YXfvYPqhd7mugnPs7qjdyKofhZm8j4Xgd0iM1PKpsLgB0jkg1MytXI3gmf6cLypu4axoymjS62Ug1b8poS6kjf31POUz7/s8UtV/opyjGaPIuvZXsdbCCstAvsN14WhuhtRuSoPHtPBNJFHj1LjcsGZbdcFOBFZCWTnoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0iKOsu1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlF/havO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pv+09698FZpTal/X+RrmmE1s8VEJjIksZePhFfpyAqw=;
	b=j0iKOsu18oiEUNgNOE8CVIsb0H9sim8pETp6mzxBXQ3f4vqffu9nGARXhmOnm851ieq+vy
	RMQgR98SohJanuy1CRRHRbIY5lUCZvMYoPhKVFNiEZTTAYkTxXtzBkdC1jNPxTLBHRyNWB
	g6lLcz+56a6b7QGxo2L6lsBq9kufFTRYqVsIH+sCjgQUQFL1edfmXBqG3W31hkbkOlB79I
	1AgcFY1+rhiYQBWhjcTFaqXv7melegvl0nj0zYjpAskrDdQka1MRfj/XIRZba4gbfjtH/K
	kDKEbDOqGLK0KlTJcqqnYdr8znovtj+jlf7bzjGDpIJ+pwbqZtlMs6+EAAVFSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pv+09698FZpTal/X+RrmmE1s8VEJjIksZePhFfpyAqw=;
	b=qlF/havOm+ShT0iGjIKdYWaYEQCTm1uNPlv9w+EjrOEoP5+5mebyYqMww7Saa7rV4MMHHH
	mfAKPRblecQN7vBw==
Date: Fri, 11 Apr 2025 11:00:37 +0200
Subject: [PATCH v3 13/32] selftests: harness: Guard includes on nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-13-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1082;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6pkon7Kh5/SE7q0KZvHsGJsIG9RSM3sGqKstS7SVzkM=;
 b=nkmvSPwyAfvw3Pmbz00BOtB0EXSLxcrIheXUDR3XoctIlWrjySQNDF2oYWyqVeWSfwZoXzS74
 YB2vstKp4UhBAxH7uKy1wWn2jj/xooSkabPEX1ImpuEsVMqr4/wrmtX
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


