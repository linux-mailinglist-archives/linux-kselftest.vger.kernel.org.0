Return-Path: <linux-kselftest+bounces-48999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD0D232AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9ED91304B0B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9F338912;
	Thu, 15 Jan 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwL+TqqR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d++IX76t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E333858B;
	Thu, 15 Jan 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465818; cv=none; b=cQHb1FVZx1hBs9DJIqPXnWxEF2PMfvsj3kHM2SQhzxgE1xLGbj1uxamfKhYitKMjh6fbxXHv0JD4BBv25ZKQwfHn5aH5xgRpszPd5rtkFgc5nOFZo+lOlh8E0RAXIEaD5DPw74h2uBN70oL2S0+Em0KBSbPLW8OGzQx5NwavT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465818; c=relaxed/simple;
	bh=1vfmJYOF+/h97T7z8tbP5bbEonLwn9Sl6fDSyIbp+3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRGt//hBDom7/nFN/pFiUsHvRMhjs4TGvoyyFKzBrtqGaFf63CrQPXcz33FU4s2TZPKeioVMSrgFFtct9bvFvw0+UniYUEX8HwIixwx1zOy6wYgBl0mf+hFVBvIplyRhrar3nDhtlmPRbq/2JR0G3VYEROwGGAcZK2BHv88LsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwL+TqqR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d++IX76t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768465803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8vFGubMmHpsAUBxSyQHD6nAoCn+Yk5zsMuHawTiTPY=;
	b=AwL+TqqRKe4sR2hZ/zGyph8D8WVOW3oYrH4AV0sKbg7C0yUfG4gExrBrIcDMuLteFcM20a
	cbQOfk7IIieO2xuDVXIVvPDMkXMqKPtnS7399RnJXMrUWNVCqcU2q1kK3YYqCXnPISSJCX
	AQHSEbQTJQNpWThw89kpu8GRJJKVqweYCkgPno+Iiq+BA9x3aD/OvmpuH1ecqv7eosUM9Z
	b+kOkFfHZekVdWNywT7r7pjgunN2j3jJCJapI0RF95gkziWKEr/bB/d8SM6+zagiMYEw5r
	MDpDjI7mPBLbJjkA+xlSXZ82OGzKxEwc7KJs7eYzpTF9v8BIkJrFt9QhXtUcVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768465803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8vFGubMmHpsAUBxSyQHD6nAoCn+Yk5zsMuHawTiTPY=;
	b=d++IX76teODmsJKozTj4V4dLNe6mzk1p3xxb0HUP0bjXd7Bf0zI9zxIn8ori247ZBmBYZB
	piOGeHKX0I0KOlAg==
Date: Thu, 15 Jan 2026 09:29:58 +0100
Subject: [PATCH 6/6] selftests: vDSO: vdso_test_correctness: Add a test for
 time()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-vdso-selftest-cleanups-v1-6-103e1ccbfdc3@linutronix.de>
References: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
In-Reply-To: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465799; l=2884;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1vfmJYOF+/h97T7z8tbP5bbEonLwn9Sl6fDSyIbp+3U=;
 b=LrIzYiP0ItNrBdNFpvvdrMnMxRllRVnAy0h8Rgbux83h/IjA/JTc0uAIsY/m3n1vrTDdXZmhT
 v2Xk+WT+UoaBrHmhI4100lguLUnyg6UQz/p1utZ6t2KkFad/GqUpYHt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the test to also cover the time() function.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 .../testing/selftests/vDSO/vdso_test_correctness.c | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index a94ab4d597b1..a3634e4980b5 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -55,6 +55,10 @@ typedef long (*vgtod_t)(struct timeval *tv, struct timezone *tz);
 
 vgtod_t vdso_gettimeofday;
 
+typedef time_t (*vtime_t)(__kernel_time_t *tloc);
+
+vtime_t vdso_time;
+
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
 
 getcpu_t vgetcpu;
@@ -133,6 +137,10 @@ static void fill_function_pointers(void)
 	if (!vdso_gettimeofday)
 		printf("Warning: failed to find gettimeofday in vDSO\n");
 
+	vdso_time = (vtime_t)vdso_sym(version, name[2]);
+	if (!vdso_time)
+		printf("Warning: failed to find time in vDSO\n");
+
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
@@ -156,6 +164,11 @@ static inline int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 	return syscall(__NR_gettimeofday, tv, tz);
 }
 
+static inline time_t sys_time(__kernel_time_t *tloc)
+{
+	return syscall(__NR_time, tloc);
+}
+
 static void test_getcpu(void)
 {
 	printf("[RUN]\tTesting getcpu...\n");
@@ -422,6 +435,49 @@ static void test_gettimeofday(void)
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
@@ -432,6 +488,7 @@ int main(int argc, char **argv)
 	test_clock_gettime();
 	test_clock_gettime64();
 	test_gettimeofday();
+	test_time();
 
 	/*
 	 * Test getcpu() last so that, if something goes wrong setting affinity,

-- 
2.52.0


