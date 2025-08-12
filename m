Return-Path: <linux-kselftest+bounces-38751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C078CB21CF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C994C163ABA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8429BD92;
	Tue, 12 Aug 2025 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zK0jbmF4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRE1txom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89026D4C1;
	Tue, 12 Aug 2025 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977157; cv=none; b=tEPAOAHhw/Jvz27DjRYNL6yNK4YUvBG7vb8PN7VHd4895Gq2c0A75yjNk7GrCUv9VanwBzRw3eZeRPxveqOjhPBEygWEm0zXUGvYVzWZA46KtVuSWMm3AkcwXKErOco47qGrcj87uyHCBWjb5sDSF/MREv5UHfVqOiBnhC75Onk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977157; c=relaxed/simple;
	bh=5YF8tU5jhoTmSCHca7iKbZ9R4dj3qes+SM80WlvKHW8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PURibP1LfROJf6CKRkMja+3oZo68icFT3i7dTZiSYoWJjbbxjj7V9b4bobcT6B2q08lDSzcq7w8u3H6MkSJZ7cxx/n/tX/dpGmgswy79LFtTFT52fLoFRy+MxicqjYUsBNWrGHBbXgFkxO0yn16EmBxD1i8qPaJ+LomyxFV3tGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zK0jbmF4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rRE1txom; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iB6yQVDpZT+VKxszrEf7M8yrM56s7lC6qeXM7Pu7PZM=;
	b=zK0jbmF4XvO6ByZA1u8n5vxq8j4C7DdUJdDLISKvSS52x/szyYObZyZuDexC62CBPQqdJT
	2VGwmm5Kufsg1TazeZRIM6ULNsgDaSMqgm27ZBdXSBhz7tNlOWxEGA+XU/bn2k5/lAaVVp
	jEPfakHxtx0w/4Gi5ozk1QDUKNdcAuC7dxAeMoH7A4Mz+JILjsvBy8i6705wEqIQiVrUbJ
	HVRvDCm06y5/CQ54BpidSPks3m5e4dQ6TcwwLOsmBxIkks7lZtr3/RqhbayJuPGVcsvoJX
	UKft/U6kFz6FwVJAXqV/CmBtLsH3TR8g+qFl5zjF8ZJMRR7/MBFaJEDzx0Wynw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iB6yQVDpZT+VKxszrEf7M8yrM56s7lC6qeXM7Pu7PZM=;
	b=rRE1txomhWNCjZr49ksPxZRHPwxyIdnG4W37TILRIjxSbAyDErayH4KYKW23/8VVG2I9TM
	jReNLiD8B7F6paCA==
Subject: [PATCH v2 0/8] selftests: vDSO: Clean up vdso_test_abi and drop
 vdso_test_clock_getres
Date: Tue, 12 Aug 2025 07:39:01 +0200
Message-Id: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHXTmmgC/32NQQrCMBBFr1Jm7UgaGqKuvId0YZuJHZBEMjFUS
 u5u7AFcvv95/28glJgELt0GiQoLx9BAHzqYl3t4ELJrDFppo6yyWJxEzCRZ0PNKgpYG57x31ms
 LTXsl2otm3cbGC0uO6bM/lP6X/hkrPSo0g5nobE/9pObrk8M7pxh4PTqCsdb6BZZUFiW0AAAA
X-Change-ID: 20250707-vdso-tests-fixes-7e4ddffd7f27
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <lkp@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=1569;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5YF8tU5jhoTmSCHca7iKbZ9R4dj3qes+SM80WlvKHW8=;
 b=LceymYLXe3xEn9DJBwP3degyfpLOoWD2ATr62EbWg/Hl/wM9cpNdkMSxkfjXLwb67TArI1Xgj
 fb2D57IX9L/AdHa/MSqRL1g5YDe3geh3QOG2nR2wyRdGMM/1d5kspHh
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some cleanups for the vDSO selftests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Also drop vdso_test_clock_getres from .gitignore
- Move patch to fix -Wunitialized in powerpc VDSO_CALL() into this series
- Rebase on v6.17-rc1
- Add test for clock_gettime64()
- Link to v1: https://lore.kernel.org/r/20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de

---
Thomas Weißschuh (8):
      selftests: vDSO: fix -Wunitialized in powerpc VDSO_CALL() wrapper
      selftests: vDSO: vdso_test_abi: Correctly skip whole test with missing vDSO
      selftests: vDSO: vdso_test_abi: Use ksft_finished()
      selftests: vDSO: vdso_test_abi: Drop clock availability tests
      selftests: vDSO: vdso_test_abi: Use explicit indices for name array
      selftests: vDSO: vdso_test_abi: Test CPUTIME clocks
      selftests: vDSO: vdso_test_abi: Add tests for clock_gettime64()
      selftests: vDSO: Drop vdso_test_clock_getres

 tools/testing/selftests/vDSO/.gitignore            |   1 -
 tools/testing/selftests/vDSO/Makefile              |   2 -
 tools/testing/selftests/vDSO/vdso_call.h           |   7 +-
 tools/testing/selftests/vDSO/vdso_test_abi.c       | 101 +++++++++--------
 .../selftests/vDSO/vdso_test_clock_getres.c        | 123 ---------------------
 5 files changed, 59 insertions(+), 175 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250707-vdso-tests-fixes-7e4ddffd7f27

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


