Return-Path: <linux-kselftest+bounces-38755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AAEB21D04
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE341881502
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E672DECD2;
	Tue, 12 Aug 2025 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ph8giS6Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="91VBUxP7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046DF29BDB7;
	Tue, 12 Aug 2025 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977159; cv=none; b=VXGEU3qSpBh/wUy3gGtUuAS3+Pg3yQ09UPugEbFGzVJIIuQzr3Butu3hwx+wNSI4U3+y98hPGCCnIRg+6wQzwcAu2wl1m/kwJvLHFLNSqL4b2h6PZLwZginLl+Kq1xk80ikYV2VlNpzQjA45KvJQYFBZ3OOnhOTwxnrs0FYuRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977159; c=relaxed/simple;
	bh=J0bffmDqkEMGTX9pKwA5xnPdITGXNbAONclySIKDmVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYEYIsgWaq4QU7tylduM5tD5w808dWYJJJ+2MgjTW8mdqfXGLskiY3SCZn0qL7Y8xp64RKc9aDNMNbZwITfRh4h/Pfny84H2K+cBcIgtxYV9gDMv2ykA5S1bgwEV6QsmqIGjJeiEYYDd5ZLwLfLggfdYj+qhecaqpe/p9rSh0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ph8giS6Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=91VBUxP7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Bi/0fC1PsBoK0Krj0u4UUoMe1fRJ0GRKCtDeXVM6jo=;
	b=ph8giS6QiZ/g1Jc2pJgEb1J88lEnlFofe26W1IqKH/yRWeJ7Dct9F1wDBeWslH7lnhlLgq
	ycGsHIEZsnzbREHb3EK6s53dUV670sFW2Uzkthl93V92QH09eEk8Yrqihq0cvZ3WyaR4qP
	NFlJekL8WI38L6gBpqtD279Lzc0raH+yTPmH5c0lrzj6o1ZjHGpEe2hv4yqyeSsjREUWme
	usvWnXL/akkNJUCJwu3FChdT5LypE17IuyA4zYC/qUE//MpquH1pBpA08jhGMXXpH7dF5O
	WGYlw5qCKh/jcZIHyQtnEuQI2UmX8Akp4EJ0gHL7iCVDViUiLQZwtLfq0sJ59Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Bi/0fC1PsBoK0Krj0u4UUoMe1fRJ0GRKCtDeXVM6jo=;
	b=91VBUxP7kOS8yQar6MM1BVHCFItfA9c4g+27p7cMzCL0hZhKvOj7rEEzRBLFoek07Eh3pT
	8FzchbV3UyBzIcBw==
Date: Tue, 12 Aug 2025 07:39:05 +0200
Subject: [PATCH v2 4/8] selftests: vDSO: vdso_test_abi: Drop clock
 availability tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-tests-fixes-v2-4-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
In-Reply-To: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=1518;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=J0bffmDqkEMGTX9pKwA5xnPdITGXNbAONclySIKDmVQ=;
 b=x8Z9x79c65WSj2apRZpCIMt6A48hc7Z6bjzPYMu5AfTiLXLVgF7KRyzHTUH3105eGaX4v/14J
 BQtnXwnTp+lAVBfgeM7vwqeDMaNBFswNeW2NZwOzeqDZupPiKkAXA7J
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The test uses the kselftest.h framework and declares in its testplan to
always execute 16 testcases. If any of the clockids were not available,
the testplan would not be satisfied anymore and the test would fail.
Apparently that never happened, so the clockids are always available.

Remove the pointless checks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index b989167ec2472d1f8369e61f13e535b15545a6bb..d236dd8305e1e3f41df07e0b7ffd5cfe8aebf826 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -197,37 +197,13 @@ int main(int argc, char **argv)
 
 	vdso_test_gettimeofday();
 
-#if _POSIX_TIMERS > 0
-
-#ifdef CLOCK_REALTIME
 	vdso_test_clock(CLOCK_REALTIME);
-#endif
-
-#ifdef CLOCK_BOOTTIME
 	vdso_test_clock(CLOCK_BOOTTIME);
-#endif
-
-#ifdef CLOCK_TAI
 	vdso_test_clock(CLOCK_TAI);
-#endif
-
-#ifdef CLOCK_REALTIME_COARSE
 	vdso_test_clock(CLOCK_REALTIME_COARSE);
-#endif
-
-#ifdef CLOCK_MONOTONIC
 	vdso_test_clock(CLOCK_MONOTONIC);
-#endif
-
-#ifdef CLOCK_MONOTONIC_RAW
 	vdso_test_clock(CLOCK_MONOTONIC_RAW);
-#endif
-
-#ifdef CLOCK_MONOTONIC_COARSE
 	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
-#endif
-
-#endif
 
 	vdso_test_time();
 

-- 
2.50.1


