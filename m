Return-Path: <linux-kselftest+bounces-34683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C966AD5215
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E7818945DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D61E27605A;
	Wed, 11 Jun 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l5IUbJiA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sg6uhSKU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFB2741CE;
	Wed, 11 Jun 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638046; cv=none; b=BX25N/MAmQazGc2T3y+izKGOI0D0cfyf50BGMXD/Mb0SaqSG4eolWdudKh1ajRee69ooLs4QgaSagrW9SQbyfaFZCQ2A3FO/lEesTyrvig/KKaRPbqhzr4epfYA6ujCT2PChPeymcmxj3/fzKwANbInqRA1e45wyH1PRgge1N/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638046; c=relaxed/simple;
	bh=mymoHJoPVcVVD7mF7fKJHem0KY9hzc8ODkofDW2o3fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6QeXh5MLzkPysc5n5JMd9DMi/LwX8DFteiyDfm9W5pQHkI3iY4Xz54qiIJfzrFnjLEsc4qGKNqVa/JWaQFVfNpHNY+nwLj0PX9W4VYSs01X5rwQTh+b1hBBmwPCZUHeN8YetkXHnsoLIWV+P6zDKrHaFUeLLsuDA4QvnGwOYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l5IUbJiA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sg6uhSKU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7K0TRuxWCvqV8xoGYF1N8FkYV8JeM7Cdh0VjhuPvMM=;
	b=l5IUbJiAsGDQD4Gidf5LL7MBLVLj0VaBNGCEj98dc95sjg6vM0gd8JuER39+pCnJ5++l4p
	oIZNfRzTtmd0WPlZ5LeTh8sA4pBeR5aHBqsWlcVCjQKFg715q9da/W4b7aD7u81N3tvjUI
	fQ3Isu0MswiYjw/HaWLx7LKHSycvqq9w9a3nLOYtaZyQrlan+NWY5XgM++PCz7Dm/eDjt+
	PHNzqgezAEQLChf7kFhLSiQGICUO90axT49YxeCy9U4xTnobsTX9n1JbJO/Vz0upHIBOh5
	ISmvt3zUx4HGv+TF6NNPx93vJiVUjOzwd/yWGl+fEg8xBP+kfZzKQSZrUVoa7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7K0TRuxWCvqV8xoGYF1N8FkYV8JeM7Cdh0VjhuPvMM=;
	b=Sg6uhSKUWTjadFiX+0rxKk/cSjsUfyJM1lQJd2E1y6KDdZO3O05t3UNKfDL5c84Ewm7bDc
	2PhIU5+Zh/vaYcDA==
Date: Wed, 11 Jun 2025 12:33:54 +0200
Subject: [PATCH v3 4/9] selftests: vDSO: vdso_test_getrandom: Avoid
 -Wunused
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-selftests-vdso-fixes-v3-4-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
In-Reply-To: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=1224;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mymoHJoPVcVVD7mF7fKJHem0KY9hzc8ODkofDW2o3fY=;
 b=4pU5CEDlm04PDDqodE8L+KfccbsJ8GIhWrmHxhC55mUsfkLmPpXP2On9D6CvM5IBk9h5oY5tM
 G1V1FxlB4z+C/POCKrwHp7voku0OLD0FsSLhEaxm5Hjo/SXuZvDthtY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vgetrandom_put_state() and the variable "ret" in kselftest() are unused.

Drop the variable "ret". Suppress the warning for  vgetrandom_put_state()
as it is meant as an example for libc implementors.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index f36e50f372f935e6d4da3175c81e210653bdce1d..389ead4e1fe3761f265f7b589b417b6d9f25c565 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -100,6 +100,7 @@ static void *vgetrandom_get_state(void)
 	return state;
 }
 
+__attribute__((unused)) /* Example for libc implementors */
 static void vgetrandom_put_state(void *state)
 {
 	if (!state)
@@ -264,7 +265,7 @@ static void kselftest(void)
 	}
 	for (;;) {
 		struct ptrace_syscall_info info = { 0 };
-		int status, ret;
+		int status;
 		ksft_assert(waitpid(child, &status, 0) >= 0);
 		if (WIFEXITED(status)) {
 			ksft_assert(WEXITSTATUS(status) == 0);

-- 
2.49.0


