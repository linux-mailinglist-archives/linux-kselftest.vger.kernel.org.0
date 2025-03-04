Return-Path: <linux-kselftest+bounces-28163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122DA4D470
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F453AA28D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274131FC7D2;
	Tue,  4 Mar 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nynnH1XA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wr8uFBG0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385221FA165;
	Tue,  4 Mar 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072280; cv=none; b=YoiPh53wNLLkHVczszdhCT7z8wdBaWJ4HW2Ni7XArdv2R5wHldnN70ggq+AqV1kog/E2jVni3nm626ImQtz9fwqPY7HjdkAbSfIuaOAMmGLBKWpc3o4Js2doL7jjHBmh8gjYkArwAj0VDP1Ad7KMXt9HhfkNS3fTI9whhtVm2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072280; c=relaxed/simple;
	bh=LVdk5mxObbMfu6i2vClWjXlgJzMhcCXBaIxt/EeFGhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PN8P1lwdAeMXFF5N2JWDB9zWrGoZhqmLXxYVw+dIek966pC0EvGtKd1b2HOCAZweSUE5OUqdIe8hyGbd7tJ4+p5HT7P+s5aWoqmUdJgeaFGurY2TMDg7zB00RrNhTQA/p0qVDLuT4UF0nsn41apODR/QkxtoANFAUvhZ6PeXkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nynnH1XA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wr8uFBG0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6isZ852xlL9hSmHb8o3TzBvQ/BwM4VpQuLYoBOElsAw=;
	b=nynnH1XA0yPK8wN9kJK7YT6ct/7YcwJlrFV09/K4wZ6ZCggkn6lI4GW9gCp9+afjeTepG8
	ZvG0HzKyB17vJxl0rm0Sy++0mxMAcx4tQ3jbUHisqJWXtb/RyiAj0D48PfICFd4DyqUU8t
	CiADp3QfmuG7JfCqeO7UVHJC4KdJFfOYF9M3WVRflN7YnkYEnd7nEf7rdbr8Y0lXNKLl/O
	2NuuPWeLf5fVegdPBldOANoqJddCtxhxZ1F+BakFi8xDFBsTxg/Xz3gv7gtH9pwA2e1/gA
	JAaV4mc5WJcb+fTFizzZ4moPR+2BOn5aLXENZRYekaG8ac2uLJSifImCP44MiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6isZ852xlL9hSmHb8o3TzBvQ/BwM4VpQuLYoBOElsAw=;
	b=wr8uFBG0RDBozuLwdT1CTMTeMhrbsMl9x0dnNwgDfSAOIrZblipaY/fQJ+d0xrDFFQRcin
	Ha70caANi1NWD3Cg==
Date: Tue, 04 Mar 2025 08:10:46 +0100
Subject: [PATCH 16/32] tools/nolibc: use pselect6_time64 if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-16-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1128;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LVdk5mxObbMfu6i2vClWjXlgJzMhcCXBaIxt/EeFGhE=;
 b=iDl3jMwM5Bt5cFyY2aBnoGWqUBpuNKq00hHPgN3L5Se3XAxWL949V2GVaLYaAJ3EX6h/sphK1
 v0aCUbjM7a3DdxKxoWd9kWuQpSOHK9khgj8apMlevfDDVp5nHdgOISz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

riscv32 does not have any of the older select systemcalls.
Use pselect6_time64 instead.
poll() is also used to implement sleep().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8f44c33b121300e80b41c971019484007d050b17..128a11441ba1f95a4331b63ff1cdfb9507d4fb33 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1005,6 +1005,14 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
+#elif defined(__NR_pselect6_time64)
+	struct __kernel_timespec t;
+
+	if (timeout) {
+		t.tv_sec  = timeout->tv_sec;
+		t.tv_nsec = timeout->tv_usec * 1000;
+	}
+	return my_syscall6(__NR_pselect6_time64, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #else
 	return __nolibc_enosys(__func__, nfds, rfds, wfds, efds, timeout);
 #endif

-- 
2.48.1


