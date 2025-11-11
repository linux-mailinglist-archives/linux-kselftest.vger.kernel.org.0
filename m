Return-Path: <linux-kselftest+bounces-45299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14656C4D3B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9D44FDD1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C4354ADA;
	Tue, 11 Nov 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r72c0LL0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKCjCSwp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702635470A;
	Tue, 11 Nov 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858205; cv=none; b=ACRiOw8Zgb2iKrAG8aqzJYjpxbBjYSkxhfur0xQmVA6LKEfkZLHtB8qM0JeFni2hfHa6i48K+SUVNprOUVRHszwoQAPFzETi3XHYS8DBTnCSuoDh1kT9LuGvJfubEcrZQ5USyZrmSzG2aXkiys73OVathbZl+4nsr9aYVqUjepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858205; c=relaxed/simple;
	bh=xj97LjnkpZXwOaVKrKnQFjnvVZvSP4GS9N09KI7Aj8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqQ/JJaP2CcvhC0yKD3NzbrgD53inTmTbecDN4OILbmNfCy4wjjI+HRgwo3HyCO05uAVzitfAL0mroJyaEAqLM6u6XUb8TqFlqnQMaH0WubrPxAXB2R28XAZNWsx1iU3EW9nnnl29McsuYw4N5FAlvM4l2O3S5oBtENhIRXkeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r72c0LL0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKCjCSwp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75wyZV/JgSFGjOOw2HZQaIX8t+5lodFpKe8oY/EEK3o=;
	b=r72c0LL0o4jpfXtGhN17ap4a2vv+9YYspOhmVEGSdk5D69wV8ByTFMEI4Psjce7QI+VZSW
	BdLwIDsZCJm8Tp9BPc6M4MqiyTOTwDPFsCW+tc3rCOsU32CZx2rrBaBFrQD00UeBEmvkX7
	cNQraZjlfzfpGCJVZDN8gBM8YO2sQrHsDdl17PwpWXLhGNdEjD6MslGkql4hqcVEP2NH/j
	RZvmN/JkmjLPP0lpAGjCqWDeK6a7GWPtoMQUb1uBj+Vczc4WELBIXwai054Mm3tmXDwo/F
	Tam8KP+9WvnT7pMHO/oc59TcGVhwrCx+ArwX+xNvk+A7LpbDqtjN1A+1PRERoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75wyZV/JgSFGjOOw2HZQaIX8t+5lodFpKe8oY/EEK3o=;
	b=LKCjCSwp8E5WRgIAEwIJBTkvzYMKdpnyzXFyPp+ScpK3C2utczT1dXEEQPtMP3X3nZBiUG
	8LheUGktxq38m7Cg==
Date: Tue, 11 Nov 2025 11:49:50 +0100
Subject: [PATCH 04/10] selftests: vDSO: vdso_test_abi: Provide
 compatibility with 32-bit musl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=959;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xj97LjnkpZXwOaVKrKnQFjnvVZvSP4GS9N09KI7Aj8M=;
 b=OmnufXbuYmp5o3tfhBXSGrlafXB0/gJmN60StxsJ5P++2JW41ILa5gEzsJ5GkQgy0OBGd7iA1
 0Daha48GDwvDPFF+Tf9NF3SyCJveqIGViFPjC42ZvCE1Jl6H6vje8aF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The 32-bit time variants on musl have different names, provide a fallback.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index bb5a5534ae7e8a46d7e68a561684c29a752b866d..0a6b16a21369642384d43b0efd1bca227a2a4298 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -166,7 +166,11 @@ static void vdso_test_clock_getres(__kernel_clockid_t clk_id)
 		clock_getres_fail++;
 	}
 
+#ifdef SYS_clock_getres
 	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
+#else
+	ret = syscall(SYS_clock_getres_time32, clk_id, &sys_ts);
+#endif
 
 	ksft_print_msg("The syscall resolution is %lld %lld\n",
 			(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);

-- 
2.51.0


