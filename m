Return-Path: <linux-kselftest+bounces-32166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87084AA711B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F14A18977A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B0246775;
	Fri,  2 May 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vipsZ/w1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lA7Stc0J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9722A4F8;
	Fri,  2 May 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187439; cv=none; b=kWl35hr6i18uhqY1+Auo+u/WIgiutIrsdIoJBP3paPz8VOg//SshruVtqexCyoW2lrGRAA7qXzAdljpPWAVCcLvF9ej3OR3h4RgoVeqXnF/WeKqOVKDw1OZG/6PSeh0Ou68yHydGSWaLcExvcBlVQbgGkVf2sKK5Xnyaw5njRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187439; c=relaxed/simple;
	bh=5Ag0g/RLF5Q7QDST6KETyqNaT0OSveiFZuf9alCQMkQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qYACo8bUnNO6ti+t4fKact9BdwKvbiOXXdvwruUFDEVNKeoBqy/M9iM6Xl164fvjMqbuz8Xgbp9T3qfn8U7q6jS860ZX6e+ZQEgd2gaAkJefp6xhW8ZcGgraDk3UgOMHGg5yxRx3RO0Y5lOwbHHHX6x9ImGQwVe237cNxLMmhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vipsZ/w1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lA7Stc0J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746187435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=odbjbNyc6jPO2FN3hvy79zLt+v4CPXXQOdxoSAL8Ugw=;
	b=vipsZ/w1AzeZ4qHYmkN29ITBr9WgJ4I2dIfqYXoGZfexFmLvNbH1/iWNrCaIVAfvQOV+Zx
	4yS/m9FRZI14ZWK9SiHUujZd8r71jAKlD23+QlP/UCK/GCNiTqwtb2qrIkro6gP9LKYlrL
	b4JlwbXqtDQV462H2gci8/xRzdCqk7wufT+6ZxmJcKw/QrhVUHdEFv7r7lwH240htAhlyj
	5ir0tH8XUp2EPqDzjjN4Q+QtBNEFGwTyPJoArtGTikBV8s7mzjd17Ymr1GuazjSbrkYgMY
	SyStR2jMAHb6uvNxjIFff4gv/TPSXk0pAwqwhgFxhL8/TCvUFVQBgHmYT7iQ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746187435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=odbjbNyc6jPO2FN3hvy79zLt+v4CPXXQOdxoSAL8Ugw=;
	b=lA7Stc0J/pqjTMu7hj3Q+7bD1kCI+hTdq2X35RMYgOXLHV4y9Q3tYu2C5iplApBduTEPrb
	2hviFIpOO3GqnVBQ==
Subject: [PATCH 0/3] selftests/timens: Various small fixes
Date: Fri, 02 May 2025 14:03:49 +0200
Message-Id: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKW0FGgC/x3L3QoCIRCG4VuROW5AjbWfW4k9yPWzBsrCkQgW7
 31lDx9e3pUUVaB0NStV/ETlUwbcwdDyvJcHWNIweesne/SBFa/coE25yRtFOcsfypdTCD6m6M4
 x0Ji/FXsY723ufQMpZngLaAAAAA==
X-Change-ID: 20250326-selftests-timens-fixes-97662bdb18b6
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746187432; l=1107;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5Ag0g/RLF5Q7QDST6KETyqNaT0OSveiFZuf9alCQMkQ=;
 b=SrO1GTLlEHjUWxP0+19apYd6AVo7B6T41TFS9MeI2sSPa6pRvvxyV6wRMJQOEg3IrsjZdLmEZ
 BHogp9gFCL9AwBF/zDKXGRzD70IUZ0WlijNFsD0YnCF77Xqb0O27NaW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Fixes for various issues in the timens selftests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      selftests/timens: Print TAP headers
      selftests/timens: Make run_tests() functions static
      selftests/timens: timerfd: Use correct clockid type in tclock_gettime()

 tools/testing/selftests/timens/clock_nanosleep.c | 4 +++-
 tools/testing/selftests/timens/exec.c            | 2 ++
 tools/testing/selftests/timens/futex.c           | 2 ++
 tools/testing/selftests/timens/gettime_perf.c    | 2 ++
 tools/testing/selftests/timens/procfs.c          | 2 ++
 tools/testing/selftests/timens/timens.c          | 2 ++
 tools/testing/selftests/timens/timer.c           | 4 +++-
 tools/testing/selftests/timens/timerfd.c         | 6 ++++--
 tools/testing/selftests/timens/vfork_exec.c      | 2 ++
 9 files changed, 22 insertions(+), 4 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250326-selftests-timens-fixes-97662bdb18b6

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


