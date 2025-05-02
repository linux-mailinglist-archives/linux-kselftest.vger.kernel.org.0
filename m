Return-Path: <linux-kselftest+bounces-32187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE0AA724C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA211BC3621
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8112550D5;
	Fri,  2 May 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0J83EK1j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oxmf8MQ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D48253321;
	Fri,  2 May 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189627; cv=none; b=PMbzqzu+rETKyOWck1Tc54Y3Zde5EHBFbWXj7rUVuJOJVLs5MxL6yXlyFbVrc/jTScfBFyp8dQ4IQ09Rg3XTZ8qft9Mm1js7KKRIwj55Nuq7pF5n3y0MCX6hCC2fFX8icmY0NecA5xbBgiDGTfG4CyU28gwAOeBCXrzQpfyS4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189627; c=relaxed/simple;
	bh=F1VPin51/c8tL+RwBatuzhSjXpfpBBx8e3tlIFAFFH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSXn2NOz7b+5uzp8jXD7MVzbPLWDBQ8K9T/EVN0P4d3iH/4AOelp473dCUaR/hbdJOKebTv9atxXrOt10zRtFfegV2tBR8BRpOjRX9/6mo9kpXRR/uCJOiyHBPY1TNKE0G3+J3Pg42agFEi3t36xzXtutE9nRK8upyEROhWS/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0J83EK1j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oxmf8MQ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746189623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpAOEyrW1tKfRUyC63KD8h1yHXc0GXf/eXA3VoTp8e8=;
	b=0J83EK1j85pIzjnIHCE/yuW2GACeehn8CxBcyOFBCZ+kDOpxfabJhyrbVRjBi+ucbk3+OD
	IdvYUp4wzlhuj3A6okSmYKElRgeY/zFnbPF5sxwy2PAdggoowYlAKHUceAibz/2sRU72s1
	OEFd7roM2Osp8sjTPt6ETmeXaN/4tne4z1TM6K/3FL4oDDo/pwsxl2rL3U91JJnjfEuvtK
	w/O1sWYh+sjMmlqzzrXAJr+ImMWm6M0v6EDgukvdQNSIYCxdBl7RTr2btGt6gaygaagNih
	YLGrIsB0Nx7CGql218Hfq15B04g5/tUJqFoK/Yf7TAo1gzc4cCkeuJJd5ddVXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746189623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpAOEyrW1tKfRUyC63KD8h1yHXc0GXf/eXA3VoTp8e8=;
	b=Oxmf8MQ0tqKWsURKIHZqy8pjHVes+Fjoycd6ij2bnqwF6PQE1uvWVOhuSj7CTqJW89Kmce
	rDbBkAdPpSn+dWCA==
Date: Fri, 02 May 2025 14:40:15 +0200
Subject: [PATCH 3/7] selftests: vDSO: vdso_test_correctness: Fix
 -Wold-style-definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-vdso-fixes-v1-3-fb5d640a4f78@linutronix.de>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746189620; l=1111;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=F1VPin51/c8tL+RwBatuzhSjXpfpBBx8e3tlIFAFFH4=;
 b=bcupxLcTxSsNEv/4tF7aIzFh9GLR2+jD1+h4GayVdebJpCCti6ZDJRH9iv9yuvhbvYXBC89Rh
 drfC6zRIfohDBFKLMYbUmx5dgMREDJxLFMLf1r6J+DqukuA+851zfIA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Functions definitions without any argument list produce a warning with
-Wold-style-definition:

vdso_test_correctness.c:111:13: warning: old-style function definition [-Wold-style-definition]
  111 | static void fill_function_pointers()
      |             ^~~~~~~~~~~~~~~~~~~~~~

Explicitly use an empty argument list.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 5fb97ad67eeaf17b6cfa4f82783c57894f03e5c5..da651cf53c6ca4242085de109c7fc57bd807297c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -108,7 +108,7 @@ static void *vsyscall_getcpu(void)
 }
 
 
-static void fill_function_pointers()
+static void fill_function_pointers(void)
 {
 	void *vdso = dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);

-- 
2.49.0


