Return-Path: <linux-kselftest+bounces-32323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5BAA8F4C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7E3B8B40
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FDE1FE474;
	Mon,  5 May 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fzPVyl4H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XhrnIBYf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB901FCCF7;
	Mon,  5 May 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436798; cv=none; b=pmWLjysSj1ImghPk6OJWCVlyreS0QCQZk8yOZmycXHFy2iIi7pw9kzdQTU+g0ZfuUaTpV2OkOIEeqK3v1p+7ZExsp2lydlMC9iVntMWoWbI5hE7CH2GRNwJ9CSGx2mTdyzlcp008AWufvUWO7vmLoJiNn+H+ctFFcQagw6PL3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436798; c=relaxed/simple;
	bh=uD04YrH6eP+MSUFpj7sOWp6lkwXWk2qR0mSs3ZdsWmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHwkntHlkiwBdjRnm2VTJCwdcBn8eDdSe7BUgnwjPOnADA8ilwkftLhJTUOnFaOQUDJx66WkOa029PBpJDsHZXoCStxnPj2DOIU50k87OqWRnboELzHMevOfuLBE1fmVlSmg3VVum03MFreBXBtFCCK6DHQObLDhF79koTTWyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fzPVyl4H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XhrnIBYf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWSNBEL32B/DJ88mUkY5bg1Q8T/PlsPV4zRBXnQvYTs=;
	b=fzPVyl4HzwPLCEAA1hwLtIjxUSceIpW8hrAGSiPXBS4nX0bz8tSAMgauD0zzWvd/u/gOMh
	TR57IxFQ3TwF8zo+NRd5Yy/M9zYMCRLZyv1GDUzPelXk6oXSaDv/DHuGPr9kP7bCiRDjgo
	06aIUnVYaySzbyjhrak6ICACujIz3YVDZVrZOz/FlLUWVw6A1ByUKLEi20Vupf9O3ZFnq/
	7mkv0RBb2EBor9CMbvlDakR28AwB08RxTTad5+XlA1Nq9JWtk8cTOTqkjOGI78+obnmmdK
	19ricZ76PdetYWPQ9YfGjuZikRAsnHyK+M+Qe58Ishp+52+j6RrCJiwqN8PxWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWSNBEL32B/DJ88mUkY5bg1Q8T/PlsPV4zRBXnQvYTs=;
	b=XhrnIBYfIK3Dy7RGFsm1QFHcAcTjPt5AHdYQlbjqyepoq6dzn4HqadXUgUMUKhUh2X5ZxL
	WrEaqWymVMsNgsDw==
Date: Mon, 05 May 2025 11:19:40 +0200
Subject: [PATCH v2 6/8] selftests: vDSO: enable -Wall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-selftests-vdso-fixes-v2-6-3bc86e42f242@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=839;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uD04YrH6eP+MSUFpj7sOWp6lkwXWk2qR0mSs3ZdsWmk=;
 b=h9nt5RE2n6qHouwO8zWTZEkF94KoIouAWEsduey5lvviw5AFCv6pofmRR/ZOktNXb+ZCQC8JI
 Uz1XMaVEkXBAAo9J/IQQ8x1wnRKc3abm7Cppc4GIIXsWtNvhjAf/B/q
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


