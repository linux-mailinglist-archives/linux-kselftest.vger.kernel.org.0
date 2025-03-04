Return-Path: <linux-kselftest+bounces-28164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC5A4D46F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623F6174B12
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD31FCCF9;
	Tue,  4 Mar 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZRVOMELx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhWr6W8J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA011FBEB6;
	Tue,  4 Mar 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072281; cv=none; b=PGbdI9g/Fgxc3RY3mc/rDZ+yKkQgp747PYK/YP8HSeMJIOQv13i7U27++HR7KLUPL0grVG1VRfCRlF5k7iLyvuyNirpKp+LgVfZiddNS2ofo629a/Jg+Z8mOEfwnut7Cz+kEprij32uvMjDlA0+2CroScMoBP5+qsj2V1+GwCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072281; c=relaxed/simple;
	bh=DvYCS+XpF/Y1UcDD/KTufBOFdovc2i4ISIZYldLZTCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+jIxyp76c6Xay6fpo7AyuNOK3Mw0nLMtRR5h6ouFlhpepbqKt/ikh7yjVeSjxAAETDusTZfvvb4Z/HrdYIk5IegHHwsgMXqnriV5I2lz75alEXNTxwfz/GcNmJnGkoQvh3+IUHoyHk1WXyyRexkzrx9RqMLKDyVn6xmI4x7vbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZRVOMELx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GhWr6W8J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esZ1MyoLFihoItJ0rYNhv5H/yjCSPS4o6Hrs74S1dRc=;
	b=ZRVOMELxnfjSFJMv9zvKQWnoMx0nNwnCtj4LOh5pgne+8qp2sPzFi28gYCf20gxxb7MC2P
	IYCk0sDmPJtJ9MmxYJgBILaYcy0lT6OeJFEt9zn1cwUTCgnkmOehNjbprvWUPkI65ONDo1
	PULSdJ9ZvONnpDhnkNXUARS44kS8YldUqYMGvlrOWhNBBsSNC9LUlqnEqhu+2YzdQR96+n
	ZkTWHMznNU0DaTtqWW9LgJtJ3drXrJtSBOclIEyFdmcMBYd7dEmBdZ1XBHFP3hZxU3pGDx
	h8neNFCPD0Z3QZQKF0DoYjPy6SDwmA/cDRs3+FPevoSUS3y75/thmAy0D9hHwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esZ1MyoLFihoItJ0rYNhv5H/yjCSPS4o6Hrs74S1dRc=;
	b=GhWr6W8JClAdvlU+EinOTh6dMFFv9Zq/tcNaPAUd4Q89r+rPPyymF9uYHq1nIgsX+xbnlU
	66rG/o+5m/AVtYCg==
Date: Tue, 04 Mar 2025 08:10:47 +0100
Subject: [PATCH 17/32] tools/nolibc: use ppoll_time64 if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-17-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1050;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DvYCS+XpF/Y1UcDD/KTufBOFdovc2i4ISIZYldLZTCg=;
 b=IGrmgnij8B7ekublFPUTECiIpi/SQXF7hmzuVi1HPJPcS6fyIsmuM/QZDIvk+Ax/KVhmmp6qu
 mPFakTMi2lzCztnBGP0gAyjkmYk0KOB+U6BTOzMteYjUTxs1ZqpH5YY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

riscv32 does not have any of the older poll systemcalls.
Use ppoll_time64 instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 128a11441ba1f95a4331b63ff1cdfb9507d4fb33..e28b26f9c3fe8aeb11dedce5106e52228b753e37 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -875,6 +875,14 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
 	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
+#elif defined(__NR_ppoll_time64)
+	struct __kernel_timespec t;
+
+	if (timeout >= 0) {
+		t.tv_sec  = timeout / 1000;
+		t.tv_nsec = (timeout % 1000) * 1000000;
+	}
+	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else

-- 
2.48.1


