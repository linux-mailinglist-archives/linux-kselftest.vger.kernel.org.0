Return-Path: <linux-kselftest+bounces-32321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26DFAA8F48
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1926516BA59
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAEC1FCCEB;
	Mon,  5 May 2025 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nvI5Swls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zheezx5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694501FBC8D;
	Mon,  5 May 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436796; cv=none; b=Hnb2tP5ovd7vr7CqbvCbzY5pyzqY6iCyM/F7Rc2md4WkhMc1dCME7HiDnHsuLCczFz1Z10W5DTaKl3jNMYZn5HPFfN1YgPKNd+ZMguTcGujRk8QjSJujp9YcMs5lT3DsiTwJS4itcfxA6vYDt7vIHz+g0LzIeDxgmXP5OUbup0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436796; c=relaxed/simple;
	bh=Jd9bN1x0QUY5vumCRf0DJ1rTzHAMY7u+Dc+/Xk5jW5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjTFxxGPCR/K2DhI+VVm+XLqko6iYsnTeKYN/EOtiY3igL3Bis+hNB6aK5go0ArEVh7f/jUmoXKrA6qshkbs+P3yfqSBpz3JlwdomXo7Skyj5r7SyQvqp81BfebrPbMwUkwO8M6CebM0uEGqJ2pgsjdU5EErKYOnw9Mz2vtuiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nvI5Swls; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zheezx5I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Qg6NrTIlROWiZjlcUgHvA4YqAO2DpE5nyR3C7rQFQ=;
	b=nvI5SwlsAPhTuvqFPTB3GuL/B+QCa+zPUsWLeMWX7YpY11iAh3MFL30SU/+V3bwdxwh8e+
	ZyYhToq6zIzYvBzx5rlhY73fAVS1iQwkFUg1UGhw+7q6NGZXDVO212aAG738Ei5jtLmxLO
	ypONspm1wUXYvVcUMZdGxckO/Njn/li4NPqJIaUlTJo9oHGXkyJoU9pR5hCTnq1OKvhoRe
	RkFge5qcAbjLfQz+6wGKLv6Z0CKsSMkY0MCdbP/RXaErWOYNrt1aHE/v3XnEVM+9tAwkKG
	PGpd4fUtQ6+67CRU4lKYcgNtgnAQG8nZ0Y0nDPF9l46G+6GnLXu6CoRAQxY6zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Qg6NrTIlROWiZjlcUgHvA4YqAO2DpE5nyR3C7rQFQ=;
	b=zheezx5IlnBjMiIDjMWFHfAOZrPQThdRZ9OW1imtBKxIG6xMhn/nibThjb6FXu0D23q3fZ
	M9Hyk4+xnPKtTsCQ==
Date: Mon, 05 May 2025 11:19:39 +0200
Subject: [PATCH v2 5/8] selftests: vDSO: vdso_config: Avoid
 -Wunused-variables
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-selftests-vdso-fixes-v2-5-3bc86e42f242@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=1265;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Jd9bN1x0QUY5vumCRf0DJ1rTzHAMY7u+Dc+/Xk5jW5Y=;
 b=5YiU/yIHq3zqWKEq6iVG30zLHPOf3nSun7uvoGK9aY/mBy7XD9w1u+DFYCudIFG219jf0y0/k
 fMn60mUbAN8DNw2USJkDK4qeU/J5wHrWdJ9SlgjTpsa6BSffj33+EkF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Not all users of this header make use of all its variables.
For example vdso_test_correctness.c does not use "versions":

In file included from vdso_test_correctness.c:22:
vdso_config.h:61:20: warning: ‘versions’ defined but not used [-Wunused-variable]
   61 | static const char *versions[7] = {
      |                    ^~~~~~~~

Avoid those warnings through attribute((unused)).

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/vDSO/vdso_config.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 722260f9756198956f0dfccced907284b6851e76..5fdd0f36233742bc47ae79f23d2cfae5a0f56dee 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -58,6 +58,7 @@
 #define VDSO_NAMES		1
 #endif
 
+__attribute__((unused))
 static const char *versions[7] = {
 	"LINUX_2.6",
 	"LINUX_2.6.15",
@@ -68,6 +69,7 @@ static const char *versions[7] = {
 	"LINUX_5.10"
 };
 
+__attribute__((unused))
 static const char *names[2][7] = {
 	{
 		"__kernel_gettimeofday",

-- 
2.49.0


