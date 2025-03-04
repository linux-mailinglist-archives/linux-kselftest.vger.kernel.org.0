Return-Path: <linux-kselftest+bounces-28165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB84A4D478
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16F73A86C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA91FCF7D;
	Tue,  4 Mar 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="teF/QjWn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvxCq6jV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA01F8720;
	Tue,  4 Mar 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072281; cv=none; b=VL8CWJjg3stPZ6sHtXU7knCNKw2xDZY2zkXFHC+Wh3JOqbSQzRQZYHaqM1aEb15fGXH8Sm0jdRZb8RPLus4j7gREnLHa/ZzavsTcypmAX7rfI3d4ORG9H0aaQRLZ57kmc0bm004QPBME2WBOJuDSuzCpL+fDh0vtBizLSyLYX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072281; c=relaxed/simple;
	bh=8+RqOFJGL5cz7AAujjiHnuVFywVFVqxIPT/M7fdAUws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QttZ7ce85jD+bt/400AdgP3qk3OAg4ZsRnVOiuxQZZn5pOkKxXHwcwqolLjAQWKx87zpOiHKPyIKQpBGNHtyzuNnEOmbXkHX/flZ0M+EZQ6bBbREPxV465EYgy/YWtU2y1rHgzIkFcCSKgPYfS24Y9tXizQ7ghCcX+hLBNI24DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=teF/QjWn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gvxCq6jV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyP/IwmSyZFvgqCx5+4kPj6SHLUCA+u1ApL68En+wVE=;
	b=teF/QjWnpmKION2sMKPtOBx1vDMZn7yLvYMQgk40e0irg4my2OYQ0LOwOadlQhBUTrg5Yq
	Gur2Gi6cxHEMeRBcp0Zhzswo//7oWCE8sEhrt5j1v695KIN870xk98QdvrHSog3/PGS6+t
	9E4BtCPzI0uhkGH5PBkn0R9oLIVofI1rj/fiFAXnYPoUH3GGApYcxn0CAlPAfJuGpLglMB
	UbHn9WNR9ddITQFaPedn9YQYsGXxyhQdrB4kqtnClFun76UjAAMaCe0J+MDHBLddHnqlEw
	NSA5919Qj2DMptiy1H0kK+jV6sFt4vJ9sOufAKFKhFwWMmLT/Qg7kgYCDBWVFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyP/IwmSyZFvgqCx5+4kPj6SHLUCA+u1ApL68En+wVE=;
	b=gvxCq6jVOG09+zQe9DeJl3N35AE8z2Zod7PckmRqkDIP3pmXOVD8g0Kl0+n34+eVXyke/p
	Mv8nLowSvh7KPVAQ==
Date: Tue, 04 Mar 2025 08:10:49 +0100
Subject: [PATCH 19/32] tools/nolibc: add _exit()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-19-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=876;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8+RqOFJGL5cz7AAujjiHnuVFywVFVqxIPT/M7fdAUws=;
 b=Y6dXJi22suTWXyRYf7I53yqhch7Y+vtATlLO6WZ2EsFoIkVxLPYAsyks1WDol3D0HuYHB6REc
 M5lEVA39COhBgjKuB+ZWLontiehoJW9GXTHHghFqY+ibngjlhdd9+Ac
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

_exit() is the faster variant of exit(), skipping all cleanup actions.
As nolibc does not perform any cleanup anyways, the implementation is
trivial.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index e28b26f9c3fe8aeb11dedce5106e52228b753e37..d98515120785223aaf74d1848a0ad68e308d6893 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -302,11 +302,17 @@ void sys_exit(int status)
 }
 
 static __attribute__((noreturn,unused))
-void exit(int status)
+void _exit(int status)
 {
 	sys_exit(status);
 }
 
+static __attribute__((noreturn,unused))
+void exit(int status)
+{
+	_exit(status);
+}
+
 
 /*
  * pid_t fork(void);

-- 
2.48.1


