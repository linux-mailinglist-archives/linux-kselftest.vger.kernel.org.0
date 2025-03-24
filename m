Return-Path: <linux-kselftest+bounces-29643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABAA6DC7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 15:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC02188E85C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F525F982;
	Mon, 24 Mar 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KjME5Vzt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KddMDaGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCB19C569;
	Mon, 24 Mar 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825008; cv=none; b=cx54sbb8ophJMHYJTeflWQgnUHX8HN/Hi9zvio5a2wW7c4Eu7rsOFR9UlyvChxDdSUJwxOleE6o/VOVxQucaytw5BdliN9vMQ3u+qh83yaGveg89gAPIstj0bPPE1Sw0RqrrzDa48KffJRri+ARW+4hVvkO7wn1+n6WCPoJVi8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825008; c=relaxed/simple;
	bh=AV16hwPQKl+CSfzRvFHoenJEQJcXjUzffLuSmOe1gmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmeDAKxwOnWzSPS9t8PW0CFQ2sgxngaOXXaNZjVSzpPVfW4JrU8qoVoE17BohL1XFwNgQhlKwIQe/CZQOb39h4mzTyWmbhtVMcehXyOX9FO1SUJghk99JWAcbhyMZHqAyupxBmjPo9+2mw0i935pEFJyPi4RquXog4gHybqgeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KjME5Vzt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KddMDaGa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742825004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vy/QI8gjPC2C7/T4R6qzuHLJYY475S+lLnFmzkVsNQ4=;
	b=KjME5VztaJQ3eE5DWN+DpKo452vBorX4W/fyAb2ohDGhBNuv47LQpxI+/NMU6xp1rP9FXv
	O8BohdwieUsxsgcmQM5m5vOt+pNh9xdZIZ4zsTh7LVDPyh3vZjjlLQE3IFyW18NAoxNhBy
	WHhuDIeBdwedIyIThMNGSX2ybBQDYXoBS4j50ZWR5zVoB6cVimGRGYRXqEB+M+EJmXFecQ
	eD6Tf+FNZOkSRFc+PnMFDSPzKigFChxKIJLctFVxqvoDFSlbjVWrIZf5Wll4Ip5QgBj137
	BYitudshT2oPFdFoNdshjdU5DPoD3LcjshcoUPq6WR1XdWVrZQByS2Bq01RvuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742825004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vy/QI8gjPC2C7/T4R6qzuHLJYY475S+lLnFmzkVsNQ4=;
	b=KddMDaGa5jb01AdHGhy7Jj92SKhZW8Aj7GsTQPe2jL9GvvUQeumkNcNWQecw3XT5x+p8wL
	DUQzGEIS6BxdCSBQ==
Date: Mon, 24 Mar 2025 15:03:15 +0100
Subject: [PATCH 1/3] selftests: vDSO: chacha: Correctly skip test if
 necessary
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250324-s390-vdso-hwcap-v1-1-cb9ad001ceba@linutronix.de>
References: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
In-Reply-To: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742825002; l=1633;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AV16hwPQKl+CSfzRvFHoenJEQJcXjUzffLuSmOe1gmc=;
 b=0xAtEuSQU3A8XP39oNocbm/9ZD42xb/JP0FotpP7k6ZZh3MP7maG0rX/WuWUe9qHyrqB6K6Kq
 5w29qaY9EAwD90W/G6uKi9Ijx8iLXdaB/qXGlnvssFJDp4kRx91z3KS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

According to kselftest.h ksft_exit_skip() is not meant to be called when
a plan has already been printed.

Use the recommended function ksft_test_result_skip().

This fixes a bug, where the TAP output would be invalid when skipping:

	TAP version 13
	1..1
	ok 2 # SKIP Not implemented on architecture

The SKIP line should start with "ok 1" as the plan only contains one test.

Fixes: 3b5992eaf730 ("selftests: vDSO: unconditionally build chacha test")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
I'm not sure if this is not a general bug in ksft_exit_skip().
First ksft_xskip is incremented then read back through ksft_test_num() and
then that result is incremented again.

In any case, using the correct function is better.
---
 tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index 8757f738b0b1a76a48c83c5e5df79925a30c1bc7..0aad682b12c8836efabb49a65a47cf87466891a3 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -76,7 +76,8 @@ static void reference_chacha20_blocks(uint8_t *dst_bytes, const uint32_t *key, u
 
 void __weak __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint32_t *key, uint32_t *counter, size_t nblocks)
 {
-	ksft_exit_skip("Not implemented on architecture\n");
+	ksft_test_result_skip("Not implemented on architecture\n");
+	ksft_finished();
 }
 
 int main(int argc, char *argv[])

-- 
2.48.1


