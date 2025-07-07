Return-Path: <linux-kselftest+bounces-36692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D18AFB5FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94ACA3A25BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2352D97AA;
	Mon,  7 Jul 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="292lFkKv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5nSlQy6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356912D94A3;
	Mon,  7 Jul 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898228; cv=none; b=c6E9zqBCp0lAgqtJ/gIgPWIjAjpy6Y4PfZ4cTmM0hJAKYeb3leC0doffoMryoRcHWZ0vauECpOtxK/3vFnvKKqa8fTa7Kan0Ux8u0upSypMfDVlnMtYnSjAyS2oEkUX+lHjKt3pcl1pl2lhmumiUO9lqQ8lyP/m1z8oAodJZ6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898228; c=relaxed/simple;
	bh=JcmvL25bXQfaLkY11Owes9dUKbSJPxPQqJEIshQR/o0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ETNjPs7SUnlFeL6d6nBOIYCT/sV2g8mrapDC2wTzGAVWpoMwChAmq9hKF9DRVpoQ9nVaiedRvS1ut8QOpUfClOVePpdRLckZNVfpoQm4rsBDgGgEPQS5TyqACLnHLNdC6oAEHE11aguci/RJTosmmhRCfs3ncf63pLaR3MwZQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=292lFkKv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5nSlQy6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751898223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KoxGtcBc84Qj+eZza6DcHhhNFnBejxE85d5gTKWJM3g=;
	b=292lFkKviW4VDspmiXGr9X6zd7pTzi4gdEhYNczjE4HhdB2pSQzat7Y+QLqNkLr+dVtiyJ
	utea+SUY4FDRFLLNjciL3ms4/L/Ch+WjxVXCvN6wmtM5tdBmPtnIZ3WDfkTa6amGyMF4XG
	C8bbyVAxKJshn94Mjs03MP1DMMXX1Ib4U5ANmtCSyHlDTfhDCaTNNCgvTDqvBpe0LMmvap
	a2Pv5aStyum80Ynng857tb5ah4ws0KJXSpHdh+DdJ8qlqmSD4PuQv1iT1jX6XoOFRR8xzB
	mwOLXgP1IRDHmP/T2Iv0b1Ck54UXk5nVIOxwobzWMVEpEzcmNne6zglrP1FuDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751898223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KoxGtcBc84Qj+eZza6DcHhhNFnBejxE85d5gTKWJM3g=;
	b=f5nSlQy6z6zb+klFWCyhuFMBgrjf95Ao9lR4qqiqC5tuyJbeQtfu5Vve26+NSDuNSIGzLr
	9uuxs5d3ZZpxW2DQ==
Subject: [PATCH 0/5] selftests: vDSO: Clean up vdso_test_abi and drop
 vdso_test_clock_getres
Date: Mon, 07 Jul 2025 16:23:38 +0200
Message-Id: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGrYa2gC/x3LMQqAMAxA0atIZgO1KAGvIg5iUs3SSlOKIN7d4
 vj4/AdMsorB3D2Qpappig1D38F+bvEQVG4G7/zkyBFWtoRFrBgGvcWQZGQOgSl4grZdWf7QrmV
 93w/7B2edYgAAAA==
X-Change-ID: 20250707-vdso-tests-fixes-7e4ddffd7f27
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751898221; l=906;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JcmvL25bXQfaLkY11Owes9dUKbSJPxPQqJEIshQR/o0=;
 b=BVHHojJOW4YuJCthlaAtxpdUoAlDID+JzAbAEIb8pXQ5lHvJEFB2Xfau8tcKMg9G8wDhNFj93
 zw47VkaBth5A/tsRXnzsulxwSsvdseS7DK9HVaquRn+IZg2E7Mp1oki
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some cleanups for the vDSO selftests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (5):
      selftests: vDSO: vdso_test_abi: Use ksft_finished()
      selftests: vDSO: vdso_test_abi: Drop clock availability tests
      selftests: vDSO: vdso_test_abi: Use explicit indices for name array
      selftests: vDSO: vdso_test_abi: Test CPUTIME clocks
      selftests: vDSO: Drop vdso_test_clock_getres

 tools/testing/selftests/vDSO/Makefile              |   2 -
 tools/testing/selftests/vDSO/vdso_test_abi.c       |  57 +++-------
 .../selftests/vDSO/vdso_test_clock_getres.c        | 123 ---------------------
 3 files changed, 17 insertions(+), 165 deletions(-)
---
base-commit: 437079605c26dc7c98586580a8c01b5f7f746a79
change-id: 20250707-vdso-tests-fixes-7e4ddffd7f27

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


