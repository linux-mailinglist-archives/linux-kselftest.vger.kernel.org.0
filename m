Return-Path: <linux-kselftest+bounces-48994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A9D232D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08BD311178C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7156B331209;
	Thu, 15 Jan 2026 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWiN9yBM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJ9B2fCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD98336ECB;
	Thu, 15 Jan 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465811; cv=none; b=GgNcBayn7fYD6OoCpO25TX15bTMQ8QIuxDY1u8Uc1Ll9ttTSXpkPHCsfKUgrpCNGvxjMZm3dHqnmwNURRZ18y6y1P17VriSOx+sRIs9x9VgkzgGKgsWOFQmTKSq43fOYy/kiuD8C5Sqah/GFnMYzstvcjp/AM6aCwtkEaTt6Q8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465811; c=relaxed/simple;
	bh=D2InvSLttbmw+3mRVayW7XQcRWC8MVYcV5tgdm+yDY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pAlkKqkkvN4K1kDpuG9UwFn3Hm3StPx0HsNaqUAOADmcBjL421x5zb1xiZZGNbVDsriX202VNEyFM8Oq/0nrh6UTr4ZqMetXVQ2jLtmMOTIM+pDPmurgUs7/oh39GNUeKGIbNXzPjV6Y/KhBSfUcarSZFvRtk/SYRG2Z5V3MJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWiN9yBM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJ9B2fCf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768465799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uIOkM67DRvjKkhcb7FESrBVq6BnyBbc83MvNMASq5Og=;
	b=fWiN9yBMkptABbA2sWp7728iuwu/LrBKTaR/UAB/0P4J5Rk8XDr5vkwMVIA87EDYJAiv4V
	fam9l7N7QBwXG6YVo+qrqpKdy2C1CHAbmmFkRzpCoJmhnXZ7n1USIUb1B03Bs3Eov1vayc
	kYr/7UwggenujPTvaaHyCBPR369CLrT69i3sUyiz5D2Ab216xo62yic5KF9MWGlv7NtQn6
	kjOyJw165F2HFgMQEjMsP4TAFd0WU80XzeFNxtLFKf0fyheGlc4c4WY+JrN7kwyZibAMmw
	qCRk1duZ9fZ6CGaXzSedr7h7CgrtcHhqk7kSDguttu1qqopXDGouaaxaWEyYtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768465799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uIOkM67DRvjKkhcb7FESrBVq6BnyBbc83MvNMASq5Og=;
	b=FJ9B2fCfQjgbNhq7a5pEPc81RxxcySSv3ZdJnsrQo3qZEc1pBvRUyPHmSzS4tZVRkFZDL6
	V/q5X48y7gB/NsDw==
Subject: [PATCH 0/6] selftests: vDSO: Assorted cleanups and improvements
Date: Thu, 15 Jan 2026 09:29:52 +0100
Message-Id: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIClaGkC/x3MQQqAIBBA0avErBvIiKSuEi1ExxoQC6ciEO+et
 HyL/zMIJSaBucmQ6GHhI1aotgG7m7gRsquGvuvHTqkBHycHCgV/kVxoA5l4n4JaT147OzpvBqj
 xmcjz+4+XtZQPSEYF3GgAAAA=
X-Change-ID: 20260114-vdso-selftest-cleanups-779f7dc6dfa4
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Andreas Larsson <andreas@gaisler.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465799; l=1127;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=D2InvSLttbmw+3mRVayW7XQcRWC8MVYcV5tgdm+yDY8=;
 b=AdjZ4golxbLv0RZPwVDbbzhyhyL7JPSF8lg46qUZ2/QwHQLfdWsK+ExZmixnDsnbbgteaQwwl
 o3O1A+H+uHLDBKZ/sHv4XhIU6CPyxz39h5UHCx+CWwYjvXDEHUPhWiZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

I had these lying around in different, unrelated serieses.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (6):
      Revert "selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers"
      selftests: vDSO: vdso_test_gettimeofday: Remove nolibc checks
      selftests: vDSO: vdso_test_correctness: Drop SYS_getcpu fallbacks
      selftests: vDSO: vdso_test_correctness: Handle different tv_usec types
      selftests: vDSO: vdso_test_correctness: Use facilities from parse_vdso.c
      selftests: vDSO: vdso_test_correctness: Add a test for time()

 tools/testing/selftests/vDSO/Makefile              |   6 +-
 tools/testing/selftests/vDSO/parse_vdso.c          |   3 +-
 .../testing/selftests/vDSO/vdso_test_correctness.c | 103 +++++++++++++++------
 .../selftests/vDSO/vdso_test_gettimeofday.c        |   2 -
 4 files changed, 76 insertions(+), 38 deletions(-)
---
base-commit: 759a1f97373f25770cf438d9fb5f2bddf4d77a54
change-id: 20260114-vdso-selftest-cleanups-779f7dc6dfa4

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


