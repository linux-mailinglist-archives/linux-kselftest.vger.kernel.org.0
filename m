Return-Path: <linux-kselftest+bounces-30206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64EDA7D4B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748BE16804F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9E22B581;
	Mon,  7 Apr 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B87BattH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZ4OtVuI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE922B598;
	Mon,  7 Apr 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008794; cv=none; b=mtEbpZzopj/BOlyaXtmBis2yWVDnNNGuY8DC+bEk5xPfToIemhXsG5FFpMoA/eoSQ6YsCmS5HUu/A0xd8yKUxhr1H9KGgaWkJnjEp5AxtqgOUa7cu/MSSSKX30lgDtNj+pWDdBHiOwiOKNET1UGd1mYtmGvy8kRxhtiIYZOun5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008794; c=relaxed/simple;
	bh=d5MljKKNkutS36nrGWCEFbpFryRCK+Ka8uE6LBhTqxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEcpxbbpMhK2ukLR28CnwCRsRE9shDy8iIJk1vTPyZnSRHeEwvvZuFbpLbFV9CiYt3WqRY4MMSo1D6LXQfPRe6ZqcLYytktmJATrlih9JLqx10dq2Br5AsdSQmvfk+rUd4n7+zdCM4O1txE+PamijXL+LaEJ+Lg2b7aDyC4aHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B87BattH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZ4OtVuI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGIsurDNbt9wfy1oRuJrCVBPEF2XC6rkda0U4p2igXs=;
	b=B87BattHZE4/kqunwBMNkeoq62YUJCrR9gDnMv/GOHOJxKZJMmyqz+7ARG0OUDe0+S1ShK
	mFpTqWTA4zDWsPzZgfTuSI46QS3IqaYBOV2/e0xSuMDELwjPNVNpYU42LoEjuG7BpyapTk
	fFmLU3e/bJ5AGFmIjhsBGcRkz1PaKQQkmIbsRmIbYe3EBoaluQ5mEArGeNYP/Z62a7HOln
	nmqbqoX13R0vkCSgfN7+c+9YPiChnXD8z/GguiZtpIwBS6EOXyMGfOR0fs45I3r0D3ZfB1
	50oDzZ/cYNR/I7ywBgZM27TdOBl8Us7OGYSAJ4LfqP2RrUxuKEWaY1TZ4ukpIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGIsurDNbt9wfy1oRuJrCVBPEF2XC6rkda0U4p2igXs=;
	b=rZ4OtVuIdd83FBiFXfs2jZAnW7XCbnanKjUV+F4sFDYKUDwmKg0XWL7rgl28CZwjolTcdz
	MGlidhObsWqwr1Ag==
Date: Mon, 07 Apr 2025 08:52:43 +0200
Subject: [PATCH v2 20/32] tools/nolibc: add setpgrp()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-20-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=772;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=d5MljKKNkutS36nrGWCEFbpFryRCK+Ka8uE6LBhTqxg=;
 b=Bc0Hb8IsKvO1wptKLJ2rsDtL2BQKr9/hIqQtXo2eJB8dz7oLQ0ozBfK2R+7YS5TpFkr/SpWAO
 A4u/WXG+cW5CRC/oIgta82s0tOqJyQDdYKQCJs5gzsZzEDQibho2ViP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

setpgrp() is defined to be identical to setpgid(0, 0).

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index f52e1953020945fb2902d47ad5f7a8e7c2c1c290..5c71a2f65c7bd93f6f516a54f7e63244466fad47 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1073,6 +1073,16 @@ int setpgid(pid_t pid, pid_t pgid)
 	return __sysret(sys_setpgid(pid, pgid));
 }
 
+/*
+ * pid_t setpgrp(void)
+ */
+
+static __attribute__((unused))
+pid_t setpgrp(void)
+{
+	return setpgid(0, 0);
+}
+
 
 /*
  * pid_t setsid(void);

-- 
2.49.0


