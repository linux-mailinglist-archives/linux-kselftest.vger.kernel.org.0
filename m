Return-Path: <linux-kselftest+bounces-32320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7BCAA8F44
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEB73B645A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6991F9F61;
	Mon,  5 May 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJ+LVbf7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SmyHCK4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAC1F7586;
	Mon,  5 May 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436794; cv=none; b=r02j0bruDKlfql/rTVr/1x3ep0funN1ZFuaoA/1xj4KO92BuF9YnXwbL4rPXkCqOpaUM1ZHZiPBzj67dclmzJ8Ce5Pz2OPHNE60SVyQf7p1SgFGlfTLI6mBhcd5djtayvfAr+sRwhwrE2UOrDhD+heAtv7U4kH0uIDEjyH3MgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436794; c=relaxed/simple;
	bh=Rqf9Ybql9mWv2FDqbi7vecIXl64pB64/atVfT6XP3fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GiX7pQAwtnUf/VI7W+/JNSE9QC29n5PoNDa57pjArfBcdNbviNUqvFRn/jfIaBqNHJrtLl/cK9YlIc06bhD3iDHzgz7nAeNG+QwTfznzScZ1QS65NRFVKdhaFysHxsWzPBjGTY4/jkDHpJWh5mbr0/TFQK+r9btMBeSUDtV5Zek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJ+LVbf7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SmyHCK4J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQzNOCNFp/mc7w++e/8s7o1Kxroe/aW5+25iJWwhE3E=;
	b=gJ+LVbf7oVjqVIxN28UguKYRZy5gsN4PTBaLfqiZLNghjqTs6rUJrSGz4cAi0AmFhCmj8I
	q8FdiCil6GTQUc8UibjlMxPbxklH5qKBiDDBOtC76qk5f17zwytBMWHi796Ak+UWhDgBAY
	5z4dIz1IGiCGh/wpK8b0sXSiB01UUH0/wJVyqJWuhVKkvd/CfxYJ1+ryEJUJBgHA63w3QK
	X38Gkgz9fXTRbQMODhGSVtIuQ/p/r+pGvEiypd6zeYQr6sRkLWLMW57I+SYaShd2gPmoJs
	kz4o1F3nTb/omLUwYI2Bwi8ypGNNa6q6K8kRbol/gNhremOCIONJzo3tJt2LlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQzNOCNFp/mc7w++e/8s7o1Kxroe/aW5+25iJWwhE3E=;
	b=SmyHCK4JS8nU6Qk8L/EHxW5WO2KklEtUpf4p0EQYcutP/MTxAaa/75KpZVldEx+kq43ZhU
	94Pl2h9pvFdQ6/Aw==
Date: Mon, 05 May 2025 11:19:37 +0200
Subject: [PATCH v2 3/8] selftests: vDSO: vdso_test_getrandom: Drop unused
 include of linux/compiler.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-selftests-vdso-fixes-v2-3-3bc86e42f242@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=887;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Rqf9Ybql9mWv2FDqbi7vecIXl64pB64/atVfT6XP3fg=;
 b=Qt6gFL+jVwGqSxaUpQH0havWzM6CTtwT2AGxxO/ZVHmGuuVi9DYu8gEGMnTGGER9YxD7kWDU9
 Ywd+42vYh8/A3Fbodv7vswQpkS1jMYlxu1KESeoMOUmmIygDU2LJwDO
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The header is unused. Furthermore this is not a real UAPI header,
but only exists in tools/include/.
This prevents building the selftest against real UAPI headers.

Drop the include.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 95057f7567db22226d9cb09a667a56e387a33a46..f36e50f372f935e6d4da3175c81e210653bdce1d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -21,7 +21,6 @@
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <linux/random.h>
-#include <linux/compiler.h>
 #include <linux/ptrace.h>
 
 #include "../kselftest.h"

-- 
2.49.0


