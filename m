Return-Path: <linux-kselftest+bounces-34680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FBAD5204
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB823A8361
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9173327145D;
	Wed, 11 Jun 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3Cc3nxj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJkrAz4n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E716263F5E;
	Wed, 11 Jun 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638043; cv=none; b=CnvflimFPneXhQmVKPl6B02wkV9QA6hvUmewg6G5fbkj5UnC7DLioSif0EhBAw7Ziaedx+e3X/TIBG7oFWAdc2ZFj/4komZYCgIZOwUvExxebeBorXpQvk3copilGOzW72G+1jpOzP+Q3EZYdhtPh8gtnCL4e5mTUQreXpxS2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638043; c=relaxed/simple;
	bh=L0qtb8FJX1isKiB/PbWpoGiF8bcQshhPPSDSunRZq94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EXVfzUtQi3qD0Kc5jvl8JDeLTQWrg4JCkfNKfZsVbhG4LIF/Npu0uOyx9KSqpNZvl8+X77KFe+qh7DLnd/qZzKnL04/L3ChiHUQl++MyKheo3Hw7XMv9gjsKI22JstdjyROy08zl5mfqSrZ786232OkmOqA6iOpemrN4a2e696w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3Cc3nxj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJkrAz4n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgzEmy6Q/OWuk6h5GBXCorQ/DWv5dXNm4qfWcJTsUEM=;
	b=q3Cc3nxj5u7u6U3M0PcbdtkEdq74PeaAH1oxUIUiFfUMl2AjqvUnmK8UKaGQiFRZWWsXvT
	carCwZVK/HUpHhJTsnIhGkecnt4JdcGot4NZ6N0mTio9a6Gvl3sHvpAFuxO9m/FTjUdGc6
	ZM9JVxPwcHvz0q4rzKuW2gVGtCHwQySAYdqd+rZiQgR6O/009F51/Yw3sZD8stikaPMCDm
	g3glYr2qgtFOKD9PsO0QHjEacapz+924Ibzv7Md7bdA/kT/rxgkOMaq8xAQYtS05yubwST
	Xy2e5A2hqLT/8LzNymw9+Jjtg6FzL1WCFz5k70NbBWeT6BLpBRDkMThC/okzFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgzEmy6Q/OWuk6h5GBXCorQ/DWv5dXNm4qfWcJTsUEM=;
	b=aJkrAz4nkCFJ7+IylA826gp5jWp/7zaI1aluJYvLevikYv4O/bUj6JAY9A0bPG7qGNdubt
	vioVeQzr2o/Vc/Ag==
Date: Wed, 11 Jun 2025 12:33:51 +0200
Subject: [PATCH v3 1/9] selftests: vDSO: chacha: Correctly skip test if
 necessary
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-selftests-vdso-fixes-v3-1-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
In-Reply-To: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=1694;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L0qtb8FJX1isKiB/PbWpoGiF8bcQshhPPSDSunRZq94=;
 b=sk38Q59JAJgowvu3C3xg6KwtDmmJnOLXih4uMXCKBJb81SSOrk5zp1kwqrW6PvcMHUpoK1KCM
 0G94ScVmH33BUXSi94mo+XEvZWFAbKCXAPQ3f6Brg7FWP4vFK+EOZz1
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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
2.49.0


