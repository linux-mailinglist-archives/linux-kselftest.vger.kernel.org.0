Return-Path: <linux-kselftest+bounces-32318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6806AA8F40
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3AE1897982
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B11F6679;
	Mon,  5 May 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ga3PX421";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKuxbvK0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F51F5433;
	Mon,  5 May 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436793; cv=none; b=kH8pyc7x1/P+Nxt+WRQBVBmbQ5e3NAwxNSjem32RH9cbukYHsAGLLW/om6JaoRtpEBRZMSPu8I/RBYKCOpxMWx8luVWx9lyCFGn0yuOt80wNU9E2ut5V8PvOH4Y71I4MNhVV/RgNV6lSiFW3+xlF1k1/9Ag9YSee1wKaomCDbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436793; c=relaxed/simple;
	bh=L0qtb8FJX1isKiB/PbWpoGiF8bcQshhPPSDSunRZq94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pQQBbvEkzl2ysiGPqxZ8OyWsP/GuDbZMl/hw+sEoAfk2VbH2eCZ52qJaZzqCnZr/RMpunfc78ZbSsD4aHmrLvx3nh8bKIRoNs4qew7uRFuwWtpAlD8ig1Ze3JejvQ+RexL2ASr0soUd/g/qtI655v6b8Ej7fqMwEaDwaMmeddPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ga3PX421; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKuxbvK0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgzEmy6Q/OWuk6h5GBXCorQ/DWv5dXNm4qfWcJTsUEM=;
	b=ga3PX4214yJOjA1oE6cadQRo9roRPQ1dQsX4Temp9hdiAw3w+FyYNAiSeuvwHI6V2twFlQ
	+Zq7WMzhCspfdBmuEJxxn3x0WZ/g3KxFIm6HgMzXNcoE3hzmsnGYaauPR/iG1ON9CZXSTd
	R5vdBBHpj0Dw5fiL5Jh308Y/w6q+JDjblkyt+B6z1MsrZ40ra9m7L6pveQywmF0y7Iv4hB
	SU3f22coWecuItvhBVITu6NsfjLBni2SX1l46iI9L71PGMs9LEIeD9TprDXZQz9baOHQWM
	8DsQph8mwhmyOs+Rw5rTbbHPKalVYpS/R54l7diHd5TM0vj8acqYIN6dpOJSDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgzEmy6Q/OWuk6h5GBXCorQ/DWv5dXNm4qfWcJTsUEM=;
	b=NKuxbvK0qchEJJAfzHnhr23oXmSpWAC30kXYC6AsRiewqw7A3JY5Ar7MKqaDnG0L6QMGyC
	rzN773bRgEzSbtBg==
Date: Mon, 05 May 2025 11:19:35 +0200
Subject: [PATCH v2 1/8] selftests: vDSO: chacha: Correctly skip test if
 necessary
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-selftests-vdso-fixes-v2-1-3bc86e42f242@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=1694;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L0qtb8FJX1isKiB/PbWpoGiF8bcQshhPPSDSunRZq94=;
 b=VqBVuEdHNX+xVFE37iyRluGy6vP1s5OQjCVbfmN3k+lsEW38M50WMFYO9T/K7z75uCSIEwjs2
 LZBNCmlJsiKAff6LmqwRfyKTCQcGmELOpaNxRzKOfrQsLgIjfPNRKLH
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


