Return-Path: <linux-kselftest+bounces-32317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C5AA8F3E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F824168798
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6BF1F582E;
	Mon,  5 May 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y3gyk0bn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K0nn7vf3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66BB1F470E;
	Mon,  5 May 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436792; cv=none; b=rtd4T8tjwcA2MhVxLsVPtFUhOc8fi2ivykHU05+fWm6WDfVP/+l/aYEgtwKROqG5E3wPUO5FYxF2f7MCFplyQwZksd4m+A4HpcUiuMRqBdXzdEa+0+wl/pQYbMar6PYY9PgMYTrGgnxImlsum/RV4NXW6QFZFI6dvsIEkZnBtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436792; c=relaxed/simple;
	bh=H0gdIlnmVpbmDjxj6FH9kQsdpTNlGrLsacYC1fdYZdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BMYXiXJQIm0B+2G2tblpfrFOkLM7da6tf34J0Mea/EdpkVOFWjoYc+ftsfTyArnYdzZobs/31+7TfrrUd1IHqtaSiaAide942S3Ao+8o5NEYn6h7WBi3d273RahBphMK0fB+co7OYUP02kaS39fefoet9+ii9RdCeWPizRooWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y3gyk0bn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K0nn7vf3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YCd/2xWZ2L5+sqDVJsylRC+os0cxUIA02VRNftTL/os=;
	b=y3gyk0bn/PfoPO7uG73tPTRXrfFzXr1MLzmmVYG8TPKGnHlEyq/h6uc5STI0HRBTzilTZi
	ahWafrmSYVjhwYr2H3QWwnug2kVff4CabvzIFrRoIdv3h7dgPC6TdDfc7ma7e3CngF0/2z
	K1yAA3h9y0X5n2tNr4UbWcIqwDjUPrJUMSVRNSwuQnCMl/8Pc8CnqPjraBGpH3tdo02XAK
	Ochm/2277QePARfuYIrpXkhzm5D8viyfIEH4mRUOM8hmitNNgwiE8gEqYMoauBWxMs3HTK
	Gt0yfOkYpoSvCGlIwkfFwfLJ8zDKQfe0WVnfLsh9sXAcag0yYFJVNQroGALh0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YCd/2xWZ2L5+sqDVJsylRC+os0cxUIA02VRNftTL/os=;
	b=K0nn7vf3WFlXD6r95tvfpeFrJbYH/OMNC4pBERebj+Zr0Gw0zJByd2T6nX4bLsyjIWoT+v
	w/FnzzRMI+DauLAg==
Subject: [PATCH v2 0/8] selftests: vDSO: Some cleanups and (warning) fixes
Date: Mon, 05 May 2025 11:19:34 +0200
Message-Id: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKaCGGgC/22NwQ7CIBBEf6XZsxhAsOrJ/zA91LLYTRowLJKap
 v8u1qvHN5M3swBjImS4NAskLMQUQwW9a2AY+/BAQa4yaKmtNPogGCefkTOL4jgKTzOycHrA1qj
 a2zNU9ZlwK6p56yqPxDmm9/ZS1Df9DVqp/w8WJaTwd+uORvbGt6frROGVUww07x1Ct67rB72Oo
 2+8AAAA
X-Change-ID: 20250423-selftests-vdso-fixes-d2ce74142359
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=1566;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=H0gdIlnmVpbmDjxj6FH9kQsdpTNlGrLsacYC1fdYZdc=;
 b=0PtOp+HxkdGcOGqFA8cIASGwGNXqWx5NYwTZfXhv9KOlM0o4nW/3QQ0GdSBQ3YLa2zVgUWD9Y
 T2eDtbG+42LCueR+r2fGDqkOAKTAXJFBsauAj+HCIhNkuMPK1vA94Ye
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Fixes and cleanups for various issues in the vDSO selftests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Refer to -Wstrict-prototypes over -Wold-style-prototypes
- Pick up Acks
- Enable fixed warnings in Makefile
- Link to v1: https://lore.kernel.org/r/20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de

---
Thomas Weißschuh (8):
      selftests: vDSO: chacha: Correctly skip test if necessary
      selftests: vDSO: clock_getres: Drop unused include of err.h
      selftests: vDSO: vdso_test_getrandom: Drop unused include of linux/compiler.h
      selftests: vDSO: vdso_test_getrandom: Drop some dead code
      selftests: vDSO: vdso_config: Avoid -Wunused-variables
      selftests: vDSO: enable -Wall
      selftests: vDSO: vdso_test_correctness: Fix -Wstrict-prototypes
      selftests: vDSO: vdso_test_getrandom: Always print TAP header

 tools/testing/selftests/vDSO/Makefile                 |  2 +-
 tools/testing/selftests/vDSO/vdso_config.h            |  2 ++
 tools/testing/selftests/vDSO/vdso_test_chacha.c       |  3 ++-
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c |  1 -
 tools/testing/selftests/vDSO/vdso_test_correctness.c  |  2 +-
 tools/testing/selftests/vDSO/vdso_test_getrandom.c    | 18 +++++-------------
 6 files changed, 11 insertions(+), 17 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250423-selftests-vdso-fixes-d2ce74142359

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


