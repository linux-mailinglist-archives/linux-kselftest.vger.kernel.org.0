Return-Path: <linux-kselftest+bounces-34679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF7AD520E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25611188C6EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA54D26C3B0;
	Wed, 11 Jun 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yy9j+ddc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNHNrFrx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084F26A0FD;
	Wed, 11 Jun 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638042; cv=none; b=KU0FYT2O3giX8IOflcCkQ/pvYsLycXAsTNkPBrMbJ6EUCR6AbYdpn9kLe6p7/YSDZkS0kVJRPQbiMZEqtHtGVNAh04SIAs5ZuzYz8e3L39tn36T/L7HP4IuYsI3pmfnloes+Ibq1KCMq2TBHpSGXKU1QPL41VM1s2L/e30CfP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638042; c=relaxed/simple;
	bh=b40vuRC0ZKHQP+3+nBp63zbQEsDgeHzXjChcP3KmMgM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V3BpzOwfw18UsZESe1Bmc5gUoVJuvFWSLINsDsmEviB9fixYxF0PEa6xuPt7EzlF1hF2vh3iWA+/vd2jHHGwI1I/iNXHPVxIb+5kXD2qaavBmxlYpUTsxCelHVQOvwfnZuLlI/Zl2LON9/EXD3z1uLnQ1O77z2VpvOngcb5I6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yy9j+ddc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNHNrFrx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y34Rw4ZOIkmvjmnVFwPlQK34qoeceEXUYNAy1F0ORtA=;
	b=Yy9j+ddc/TEU020gzhxEdfE7deTyfFgip0OdTvPQoes+EZJKUX0/+LHA1lBgsVr96X1TpW
	C9UeIFoyjzSE9G5LMhqXKOF+KRRfWzGLg9MYTh3GBmLnGVR5nvyeSdyNsUpAi/ERuOXmuZ
	IB3hOSGq8gkWXWNnSby7Mc+bL+Y9I3dTMsXvidLF0KlSKkl1FpE3F+SzEE+Q9sF6e7u5AW
	Ru9I0htXqC+/ScLhfFTGTVAeBoxLrMwvLQ/0dZcKSWJbJE4UlRCm0pbQ71OY1VP0POUl0b
	IWyOI+34MVprYBXECd+kvs1SAlhC9URB/JCZPkG0r9uS9WAZsAgFENltggNjMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y34Rw4ZOIkmvjmnVFwPlQK34qoeceEXUYNAy1F0ORtA=;
	b=fNHNrFrxhEIaYaTfRxZKL13+ZY2byRHDwP8oWO99S/fEyYYl06X3Son/1YwxLbZ/8GZvxd
	5XBNZ1vDUds0+gCg==
Subject: [PATCH v3 0/9] selftests: vDSO: Some cleanups and (warning) fixes
Date: Wed, 11 Jun 2025 12:33:50 +0200
Message-Id: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI5bSWgC/3XNQQ6CMBAF0KuYrq0pQwvoynsYF0Cn0oS0plMbD
 OHuFtwYo8s/P//NzAiDRWKn3cwCJkvWuxzK/Y71Q+tuyK3OmYEAJSSUnHA0ESkST5o8N3ZC4hp
 6rGWRe3VkeXoPuBV5ebnmPFiKPjy3L6lYr29QCfgNpoILbjqlKylaaermPFr3iME7Ox00shVN8
 AmpPxBkqOz6pkIJBiR8Q8uyvAAs2FRnBQEAAA==
X-Change-ID: 20250423-selftests-vdso-fixes-d2ce74142359
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=1923;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=b40vuRC0ZKHQP+3+nBp63zbQEsDgeHzXjChcP3KmMgM=;
 b=1B24Wc+rM0d+gZ3mTqNYKCS01j2hiFzCF6lx4+TfA+Lft11i341NBziS0WCXdt2fVzC1isSx8
 ukF0oPPdqOIDHR5Vymo7A6Zc39s+m+nAqGKoWpWYw1nfosmFJHg30+o
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Fixes and cleanups for various issues in the vDSO selftests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Rebase on v6.16-rc1
- Preserve vgetrandom_put_state()
- Pick up vdso_standalone_test_x86 into this series
- Link to v2: https://lore.kernel.org/r/20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de

Changes in v2:
- Refer to -Wstrict-prototypes over -Wold-style-prototypes
- Pick up Acks
- Enable fixed warnings in Makefile
- Link to v1: https://lore.kernel.org/r/20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de

---
Thomas Weißschuh (9):
      selftests: vDSO: chacha: Correctly skip test if necessary
      selftests: vDSO: clock_getres: Drop unused include of err.h
      selftests: vDSO: vdso_test_getrandom: Drop unused include of linux/compiler.h
      selftests: vDSO: vdso_test_getrandom: Avoid -Wunused
      selftests: vDSO: vdso_config: Avoid -Wunused-variables
      selftests: vDSO: enable -Wall
      selftests: vDSO: vdso_test_correctness: Fix -Wstrict-prototypes
      selftests: vDSO: vdso_test_getrandom: Always print TAP header
      selftests: vDSO: vdso_standalone_test_x86: Replace source file with symlink

 tools/testing/selftests/vDSO/Makefile              |  2 +-
 tools/testing/selftests/vDSO/vdso_config.h         |  2 +
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 59 +---------------------
 tools/testing/selftests/vDSO/vdso_test_chacha.c    |  3 +-
 .../selftests/vDSO/vdso_test_clock_getres.c        |  1 -
 .../testing/selftests/vDSO/vdso_test_correctness.c |  2 +-
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 10 ++--
 7 files changed, 13 insertions(+), 66 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250423-selftests-vdso-fixes-d2ce74142359

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


