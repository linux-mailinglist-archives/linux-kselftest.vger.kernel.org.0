Return-Path: <linux-kselftest+bounces-38756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EE0B21CFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22224662D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD82E2F19;
	Tue, 12 Aug 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2Kuz0Qb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/S7HZknm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A872D47E5;
	Tue, 12 Aug 2025 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977160; cv=none; b=ELpuzqTZdL1yhd7QnekmlkJBJpC6MYoN1r26Kpi3/ynOqCUeT+IC7syHFrERuAQ3SVBEdrarL7yvyvhqQyF5Ak9r5NSyfRbZ4tfQVGfodGV6tmJ0YkO9ePqRTYa4unXu/wXCks1NnuxHf+RBKMPhFvPl5KBE/A82znniDcHr5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977160; c=relaxed/simple;
	bh=K56opDZHFYSNalGoHUaS1vVkhdYzFI8w3ybfyYaVbnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3GPW1UiYjPFJ2rh82CjANMxQJwCQ60T0di+aWdrKqDPVTqB71vGQVpBQ9n9ZSIHT0FZ3slWeGBEj1/5dtiSCeP9CwXxp1hXCFPtvil95JrMLw9m1VqfFZco3gtRlYYgDQHklT5WdNGevVU7FMrbd4s3Z074gkpB6FH+rYBjDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2Kuz0Qb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/S7HZknm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qr3YJTIIHkQldQtaaXfRCHhn5q0x5oDQoZfMKXfyLg=;
	b=R2Kuz0QbEP7xQ+Y+A7oE8zG/Z3JXMYLiezPd8ueabSeTDmDtldGyhhlQUV9is2G71G3EKF
	RuPNCRbwynhRgRhQzyv4kNj+EKiB3SzBVAKWY3YUvVYNe1GhIldBuZOqpQ8kXOToQgICPE
	9l2EA1hAW5FCuPSfQp8pUMNdCtsFx0HphimfCMIVyXaUULiFQNKvGaEthpQ/1SxDTrkHLa
	tB5kDOcunSNlEpmwXiUusXK3CJlmhv0GosFmaeq17BX5u8qpwQpEEcMOzYys02duKMEnXl
	N4PtiwEWDgEK9WIkGs91le/Bagyn+rcqdN40EcxIIC03d0cmGqGVqDJAoTL5UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qr3YJTIIHkQldQtaaXfRCHhn5q0x5oDQoZfMKXfyLg=;
	b=/S7HZknmW+r0UJlmIA+ixcYXOSFzxaAeA7l+uTT+gl6ZmiBaRUDC+XEEWd1jkdm36eN0Fy
	Xf56ab+IF68Rc6AQ==
Date: Tue, 12 Aug 2025 07:39:07 +0200
Subject: [PATCH v2 6/8] selftests: vDSO: vdso_test_abi: Test CPUTIME clocks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-tests-fixes-v2-6-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
In-Reply-To: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=1088;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=K56opDZHFYSNalGoHUaS1vVkhdYzFI8w3ybfyYaVbnM=;
 b=1yZnd6TcHqnA2KlV/7VcSuMkTs940bRUJhjzbqmcYyDq+J4QEmrOVbmadcbykOypxabwtHyWP
 dcE+W+aSS4PAdvAgPTbQKip+19QtLy6N8gHIikkeu8JgLda9ZkSWpCt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The structure is already there anyways, so test the CPUTIME clocks, too.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index a9a65f0deef3c32a96d7907620184ca541a3637d..c25f09998b82d797d690228e6ff026150b28934b 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -175,7 +175,7 @@ static inline void vdso_test_clock(clockid_t clock_id)
 	vdso_test_clock_getres(clock_id);
 }
 
-#define VDSO_TEST_PLAN	16
+#define VDSO_TEST_PLAN	20
 
 int main(int argc, char **argv)
 {
@@ -204,6 +204,8 @@ int main(int argc, char **argv)
 	vdso_test_clock(CLOCK_MONOTONIC);
 	vdso_test_clock(CLOCK_MONOTONIC_RAW);
 	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+	vdso_test_clock(CLOCK_PROCESS_CPUTIME_ID);
+	vdso_test_clock(CLOCK_THREAD_CPUTIME_ID);
 
 	vdso_test_time();
 

-- 
2.50.1


