Return-Path: <linux-kselftest+bounces-34685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D5AD5217
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0301896F57
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D263127781D;
	Wed, 11 Jun 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Epb0xT0t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NVWttba6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39521277006;
	Wed, 11 Jun 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638047; cv=none; b=LoSFh1cS7zWozCnEt/1yfS+v0SZ2Mmy85ThGiLT9hG21qztbUTRra3EsUFdz50UORJGled7QS8XpJzSGNk5zZlH6/Zk1fbFZbK7cj0z86i/pTIkuUaik4Mo7C6RwcA3rGYwXHBVYMax13mWJfaZ/RzCNND7A7Rrs7VPnW63KCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638047; c=relaxed/simple;
	bh=uD04YrH6eP+MSUFpj7sOWp6lkwXWk2qR0mSs3ZdsWmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxejXN7yXxzMN/+41VyerDy8qT7c7jg9vWqZeVQ3/8AH//VV4/JJK290ke2sezjlUOTbqRd1G3DuBSentbKwlZj6Kqvdt25iZY8t9Xf76laksef5Nwt5V6sH0QYKq17KHN5aY2eOtJGji1sPr85R/UzYUZnixuDxtYZhDCkYxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Epb0xT0t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NVWttba6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWSNBEL32B/DJ88mUkY5bg1Q8T/PlsPV4zRBXnQvYTs=;
	b=Epb0xT0tPtaETdC9eMxVJB5cABRNGKgz6lw2N7LppqPStENos9Uh1fAz/4vW6OAuFA4brh
	aN0ayyvnRd0qFyU6ibjzYZgpQon66BLXDw4aHnYym6bSXst1RpjUeFjV9ZOVWlnQMPQDPr
	+gBeaqsTgSY0sVQRimLQGdR/pur7HCdMwSY7cmPcuHXU8zRb5AEAR1SmWIBvoZa1/eXmla
	TyBjNnKKAXIlK2FmdaEvcvPoahhUo4FPbZpp/IV5xy2WjgdXhpWlsLcG1gK9Zil7cMAFD9
	guL4pkxggywhzpkHsl3KZNmoiLh5VrIOt/25g9eR/b+iW2RQaGTEIwkdtMogmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWSNBEL32B/DJ88mUkY5bg1Q8T/PlsPV4zRBXnQvYTs=;
	b=NVWttba6MkLiSM2Xtp/ANJOQBaZPSiFw8lXpeqGz6smDLC08pgHODdnQOIAZBpb1BqwDPi
	O44wqlfyP99IevBQ==
Date: Wed, 11 Jun 2025 12:33:56 +0200
Subject: [PATCH v3 6/9] selftests: vDSO: enable -Wall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-selftests-vdso-fixes-v3-6-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
In-Reply-To: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=839;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uD04YrH6eP+MSUFpj7sOWp6lkwXWk2qR0mSs3ZdsWmk=;
 b=+GNCkzBmGt55OMSAf1x8ERgKaHuT/bdKsthP8vleBB3dsanRw9nMycxVMXO9jWWy+6nipXVPj
 k0Z4m0dKwDBA+hnnWDb2p9CG1/bEozddZiwSGRbSj9jvbMXRvemFkro
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Protect against common programming errors through compiler warnings.
These warnings are also used for the kernel itself.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 12a0614b9fd4983deffe5d6a7cfa06ba8d92a516..06d72254ec75dbdcc2b20935534199fabc40a9de 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,7 +12,7 @@ TEST_GEN_PROGS += vdso_test_correctness
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 
-CFLAGS := -std=gnu99 -O2
+CFLAGS := -std=gnu99 -O2 -Wall
 
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s

-- 
2.49.0


