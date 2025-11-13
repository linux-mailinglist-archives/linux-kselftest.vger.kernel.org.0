Return-Path: <linux-kselftest+bounces-45564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA7C588C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0285B4A64B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B967A358D0B;
	Thu, 13 Nov 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fFGJkT48";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R42RNpsE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A15357730;
	Thu, 13 Nov 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047879; cv=none; b=gNolb+jOIONy5rezLIusGTl7DrxepB0F2Z4nLnic1nlKCeVvXMRWtO7a9lvJh9JW8DjaCqJacDoAQa6kGFY3N1Z0RRCj/jv01tOpvkHZDYW6eyjzaM6TI4MpLtiFWxsNBPOW4bqC3m4LT4C3HY46dLiBNwvPcZ6K0jGzsManLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047879; c=relaxed/simple;
	bh=yQtaOuCaIsMQjQ4M8xqRBfW+q2rzwXjGt2L7OEAlzhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkvT1QH7rlG8LLjFGD20ZQyY027JGuSlh9TBInbYpkz+BA8cnEMHiEf+0aordM8xb0ztMNKrUQ+8sr7Eh2tVMwthB0G1r5JJkvgQlnGnRx65tn602IDUWvPOmzV/qfb1VguS/tvTYKhG1b676zzClKREUcLTnU16NT4tLDPvAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fFGJkT48; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R42RNpsE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCFV5muUruf97pIQlSOFXaHRzeiwsPbZEMNS88UrLoQ=;
	b=fFGJkT48z1X8w71KEcNIuu/ctUBU41g7kUZymnzWi2GQlX4ScSbRIX1oe8nNZNFbxAxK6n
	IDcjC/uEqOIvFOZ02u8On3mMdM9iRIz+C2A24gh6NPqSYNzw7KCsocW8NHbVgUlE8JNCJD
	57FmL9PcrV9Fgp8MgpCY7Aq8z5kXYT52PukRTHL019hZPhIt7QEihHZtGd00QXxY7HLJlA
	WdZJVzulAp8eApNQk9R1TTrKwzdU7wrP0uLHoL48RvXjCZ2HvePTIelGYbzI3iHsSx6FI3
	WndyfY63EGt+mb1oiVcN+7mB892zjIVVUUSge+bfmQYrIAllBVNK+CuyzCEyZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCFV5muUruf97pIQlSOFXaHRzeiwsPbZEMNS88UrLoQ=;
	b=R42RNpsER2k3yPKpUQ5Y8fhPbHLlHpHhn04X3lOOgiY6le6eb2wb5jE3mOcnubLHBNOJGu
	iafC0tMTqoL79/Bw==
Date: Thu, 13 Nov 2025 16:30:30 +0100
Subject: [PATCH v2 14/14] selftests: vDSO: vdso_test_correctness: Add a
 test for time()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-14-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=2587;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yQtaOuCaIsMQjQ4M8xqRBfW+q2rzwXjGt2L7OEAlzhg=;
 b=IX5QJJU8/3fdsnRR4S2afWqk1eN7EAfAr2jkgkgtSB5Msd3k2rFB5yECTk1EqVPCVseRM5EzD
 tri/VPHKQHqAwi1o/BCMvqtru+qC2sdkgMaBZa+qjmCn6ZazWt6QPkJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the test to also cover the time() function.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 .../testing/selftests/vDSO/vdso_test_correctness.c | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 310688e1379511e2c564b460c6379cc00b7a5f9a..67cb8f11aa3c6977616def286b9a7d35fa6579e7 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -40,6 +40,7 @@ int nerrs = 0;
 vdso_clock_gettime_t vdso_clock_gettime;
 vdso_clock_gettime64_t vdso_clock_gettime64;
 vdso_gettimeofday_t vdso_gettimeofday;
+vdso_time_t vdso_time;
 
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
 
@@ -119,6 +120,10 @@ static void fill_function_pointers(void)
 	if (!vdso_gettimeofday)
 		printf("Warning: failed to find gettimeofday in vDSO\n");
 
+	vdso_time = (vdso_time_t)vdso_sym(version, name[2]);
+	if (!vdso_time)
+		printf("Warning: failed to find time in vDSO\n");
+
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
@@ -391,6 +396,49 @@ static void test_gettimeofday(void)
 	VDSO_CALL(vdso_gettimeofday, 2, &vdso, NULL);
 }
 
+static void test_time(void)
+{
+	__kernel_old_time_t start, end, vdso_ret, vdso_param;
+
+	if (!vdso_time)
+		return;
+
+	printf("[RUN]\tTesting time...\n");
+
+	if (sys_time(&start) < 0) {
+		printf("[FAIL]\tsys_time failed (%d)\n", errno);
+		nerrs++;
+		return;
+	}
+
+	vdso_ret = VDSO_CALL(vdso_time, 1, &vdso_param);
+	end = sys_time(NULL);
+
+	if (vdso_ret < 0 || end < 0) {
+		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
+		       (int)vdso_ret, errno);
+		nerrs++;
+		return;
+	}
+
+	printf("\t%lld %lld %lld\n",
+	       (long long)start,
+	       (long long)vdso_ret,
+	       (long long)end);
+
+	if (vdso_ret != vdso_param) {
+		printf("[FAIL]\tinconsistent return values: %lld %lld\n",
+		       (long long)vdso_ret, (long long)vdso_param);
+		nerrs++;
+		return;
+	}
+
+	if (!(start <= vdso_ret) || !(vdso_ret <= end)) {
+		printf("[FAIL]\tTimes are out of sequence\n");
+		nerrs++;
+	}
+}
+
 int main(int argc, char **argv)
 {
 	version = versions[VDSO_VERSION];
@@ -401,6 +449,7 @@ int main(int argc, char **argv)
 	test_clock_gettime();
 	test_clock_gettime64();
 	test_gettimeofday();
+	test_time();
 
 	/*
 	 * Test getcpu() last so that, if something goes wrong setting affinity,

-- 
2.51.0


