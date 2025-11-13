Return-Path: <linux-kselftest+bounces-45557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA7C58913
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AD304FCE69
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D8D3570B2;
	Thu, 13 Nov 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31a87OVp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACeknWZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747983563C2;
	Thu, 13 Nov 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047876; cv=none; b=gdYQWmwzln5XwdqI2RvSvMpQgzXZC2KhvbujHSXmJEdIt8XYzPeG5EjUHymedMGq8ycVWpaLH1A+wOVoTBg44rhk3PZPNp/OcNFmGPMfLmdH4kEwx/CI19BMALD+mRR9n6+guGop1LuuEMV1CUxDZGUxImrrPL/JHZOUtAwJoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047876; c=relaxed/simple;
	bh=tHkazwfRRe5zIBfq6xHhZxxbf5hd0Fjqdu6I4Nax/zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oM1vN7yIDerS4S4cNzWkyxTPiRbtOCaCA7815f1pa/a2+Y1Ukw4z4e7T+h0CFU8zDvW/9/Fi6eXuJGQq5B455Gy8MwvLsNIk3um3Kmj59kbz8SKYqrztfp6pSZz7Os8jJCRFqcmc8x12U8txp7IYG3dieA47H4uVZme+2lX99bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31a87OVp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACeknWZd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSpmbETV/gJ3846lTSx3RdqjnTc/TTgAtrO1oHs0U2E=;
	b=31a87OVpxYkVH7FUAd3iRvGJlbx2TYJAFBU+VnJWELet4dhwXNu9079PbBnQNC3anvxzuo
	0iqXkWP5penBCTMEze46TRNtlPqNBAZyQYrKGr9L2C12AvPqCbuVnOaw8+4EaKsoSoTj4l
	e4hyuEkTW5/+WYhSN+15NIjWevoJujfmA7lJ/Qz+T7qN5ljJ3xs54rWCGyD2WxNayl5hSq
	wUwIdSrVc/VkQV/OOqBFVBPVFZURd7o0yE4BMwNUwmgotwItBpkG8I6+KpHRTzBD2+/iDI
	SE7GbVw572EUAaXwX9ExrvxqkuhETnFszoyBqeUWN/FCfcSX7hy3KpJYwIgsEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSpmbETV/gJ3846lTSx3RdqjnTc/TTgAtrO1oHs0U2E=;
	b=ACeknWZdBpARbYkLpA4s7edcDaOJ0/gxSLXyCpBBkae5YUYaDBfSINfMsdKwpCTwTrKEZd
	OspL6xJj8OOWQ5AA==
Date: Thu, 13 Nov 2025 16:30:24 +0100
Subject: [PATCH v2 08/14] selftests: vDSO: vdso_test_abi: Use system call
 wrappers from vdso_syscalls.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-8-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=1454;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tHkazwfRRe5zIBfq6xHhZxxbf5hd0Fjqdu6I4Nax/zY=;
 b=jumne8xKPJ/aEXwg+sJ1tb9tl5hApwOBFOe1PIx5t1b4K6mY7hEw6kVLgv7A3i9odqN81aQbi
 Eo0s3LK5boVCWdBxEHJBIlh0lEe7Hf8gvuKbsM5CK4kCLJdSWNWzCP1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Using syscall(SYS_getcpu) is problematic for the reasons outlined in
vdso_syscalls.h.

Use the wrappers from the utility header instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index ff142b3b9075b18e60a46b77492d285e9937fa71..5a1bd0c2742ae14053d826c8d9f3bdc1018d91f3 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -19,6 +19,7 @@
 #include "../kselftest.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
+#include "vdso_syscalls.h"
 #include "vdso_types.h"
 #include "parse_vdso.h"
 
@@ -157,7 +158,7 @@ static void vdso_test_clock_getres(__kernel_clockid_t clk_id)
 	}
 
 	struct __kernel_old_timespec ts;
-	struct timespec sys_ts;
+	struct __kernel_timespec sys_ts;
 	long ret = VDSO_CALL(vdso_clock_getres, 2, clk_id, &ts);
 
 	if (ret == 0) {
@@ -167,7 +168,7 @@ static void vdso_test_clock_getres(__kernel_clockid_t clk_id)
 		clock_getres_fail++;
 	}
 
-	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
+	ret = sys_clock_getres(clk_id, &sys_ts);
 	if (ret == 0) {
 		ksft_print_msg("The syscall resolution is %lld %lld\n",
 				(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);

-- 
2.51.0


