Return-Path: <linux-kselftest+bounces-31420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651AEA98FA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3868E1FBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120828CF65;
	Wed, 23 Apr 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fF1wNh8n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wENAKAFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DE28B51A;
	Wed, 23 Apr 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420510; cv=none; b=Uz3Y3lXzUYZJPXP9L170pNqdoPldec5uKF90iMMkrT9vibXv/3XkRprPMKnawXCDk0Gxuzv6AxbbGgOq77DszwqwjMEc5Twf/qo/bs63jGuj1qBK2VWcqFFiOryDQUmIrIeHt59UuzdGYa2Vi1X9YOoGIOlagod8KnP48Y/VdTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420510; c=relaxed/simple;
	bh=st5xfWnHhMqzFYyPpI3LZRF3yasUPhWHSGvOc/RLkFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STLyh23DqQkuM5rRDJiBMQFw9IB7oPtRnWdnJnXiml7YDZKCeNeUdJGLjoMLG7lvL6J1l9jnCxR4oNWdifUrV8PvkF/sGR6aucS4+6d0hgWX2CtSOTKjWC4y2oF//h7/b3XxdQiAiZBCMn1ocweHL9cKvrJNrPf1iIU3q/Rc0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fF1wNh8n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wENAKAFU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qfk0SOkNJJSXcGWn4KkI774z2CZgjpLKyw1BvZF8y/I=;
	b=fF1wNh8nHwvm4JTS30FiOp26wa6UlCv1ExCXGr88OGBN3gO3IXzuJ+L3pOcwepejWcVJc9
	8qBuiAaz/kZbA7BDYKO+0aOPIGT4BGOF+CLlc33Bw2TV+UNweekSnng/Hyt78xhCgkyGRO
	wpFw6nDixEfVFkUkJIJzJWdtHDlicmWL7iyQg3bZSBR+DTL6mwJ8cVsg6603r29hZmAxEi
	34Idl9/NJfSkgQ+6bX9cmYfxV0oDwYQc2YoflcfNJKhYFuav/bz3ECAPuT56grAfugWqTA
	joO1vNNtKeJZ8YVvsZZDlXBrfrKomcZzfgXaJkLxw+099Y2LFTIm559rK/JE3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qfk0SOkNJJSXcGWn4KkI774z2CZgjpLKyw1BvZF8y/I=;
	b=wENAKAFUc0NKbwd/rcakPQOxOTCsmSxMpFoOM6BNQG7LB+KWDzg2DLA28bVBoFQdxhLG/w
	1E5eSHdtQNfDPFAA==
Date: Wed, 23 Apr 2025 17:01:45 +0200
Subject: [PATCH 15/15] tools/nolibc: implement wait() in terms of waitpid()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-15-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=1274;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=st5xfWnHhMqzFYyPpI3LZRF3yasUPhWHSGvOc/RLkFs=;
 b=jN8k7wucSHbEul0z0ct8HmdWRbjItqd9lvsQYOw1TgeSC136qeYbE0rLkoSc9JxwuI1hJ+Qny
 vnVmTMJQoqIBvazDrtj2OqjhU1yyDI/NNBt7qdzX7eQ1tZcl54gvPkv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Newer architectures like riscv 32-bit are missing sys_wait4().
Make use of the fact that wait(&status) is defined to be equivalent to
waitpid(-1, status, 0) to implment it on all architectures.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys/wait.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/sys/wait.h b/tools/include/nolibc/sys/wait.h
index 9a68e6a6b1df8f938225007eb0de0574257ccf00..9783632a80bc20e0175a8842e7a7aea27defeb27 100644
--- a/tools/include/nolibc/sys/wait.h
+++ b/tools/include/nolibc/sys/wait.h
@@ -28,12 +28,6 @@ pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 #endif
 }
 
-static __attribute__((unused))
-pid_t wait(int *status)
-{
-	return __sysret(sys_wait4(-1, status, 0, NULL));
-}
-
 static __attribute__((unused))
 pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 {
@@ -110,6 +104,12 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	return info.si_pid;
 }
 
+static __attribute__((unused))
+pid_t wait(int *status)
+{
+	return waitpid(-1, status, 0);
+}
+
 
 /* make sure to include all global symbols */
 #include "../nolibc.h"

-- 
2.49.0


