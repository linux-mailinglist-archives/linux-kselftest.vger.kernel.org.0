Return-Path: <linux-kselftest+bounces-48011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C07CE9B66
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 13:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CDEC300A864
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02A1C1F02;
	Tue, 30 Dec 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3wnYeceQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UM+xIc5z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373A1AAE28;
	Tue, 30 Dec 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099408; cv=none; b=ViJC2iYSql/x9jVpoInpNk8hedLAbifCUzvWbdPNREqT+F6j/7krIt9YYgeymXGyWOcZ1kNE0UI9lW31nAa1mQpxPO/1O/jrnNuZiW/oHING7yd49K67taF19zX9MTcz7nAeP5JbJivP76xCgqgP5zF7AQ79r4sPGo6ZD6bIRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099408; c=relaxed/simple;
	bh=LWg74/0hOx9JOV7tzEkr44kxmU95zPD51h88xTm0Ls0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s71mItCLgPUgzyNL+4yBVWoNN9nMu9XTkqEC29A8jDHtmvbruMYnNhjVS4x1AVHI2hE8EWRBWZbeuQ2SaxLfHAfzbbbHjl/bAWAON7E31AX7bAZlCRrGLkr6VHS6PjaVyUtkbjnZLXKsKi7FUk3hhMpUhPOP6UO+KZ3VPpK05tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3wnYeceQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UM+xIc5z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767099404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/DqRODIPg8sD2YgjYU3acxkGuKIemzJeFDXDkj8860c=;
	b=3wnYeceQcE4BHsUzWTBEEI5R/Khsj7UjQDhCaMQxe9rOoUpsihYguPm2KJwunnWvZADsRX
	k/SE8ZCoe7sMCQWkiXG3Tj25sBdGv/I+jMZAgX30shoMT8DnitEMaHBY62j886KFl+m10A
	hguZ2FAWSb0nEPD2zLsVuac1d2qGThl73mRT1FAOoxebqaXbGBDipgcEEmB6dDKrMuxtfW
	IAWrsvdq7GLwe6havJ6oSjxrKS9Ox/FMPmRS8TpbzcuiUzjNMU7wWj65S18giKFDY9wJKp
	pwaPcyHm2c8Jse+xvCqODf0RpIrarqVz1WNewe8zf2Cqx0b5+7hYO/nV7gHc5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767099404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/DqRODIPg8sD2YgjYU3acxkGuKIemzJeFDXDkj8860c=;
	b=UM+xIc5zCf/VBrkYWsu/fC/5AbrJztuSYC0YyXk7lyMl1SgqjHUx/gahMPjNuZxBDSLylS
	NBLLN2gg56rg9eAg==
Subject: [PATCH 0/2] kunit: tool: test: Allow running with pytest
Date: Tue, 30 Dec 2025 13:56:41 +0100
Message-Id: <20251230-kunit-pytest-v1-0-e2dae0dae200@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAnMU2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI2MD3ezSvMwS3YLKktTiEl0jU8tEw9QkY7NEEyMloJaCotS0zAqwcdG
 xtbUAP5dG7V4AAAA=
X-Change-ID: 20251230-kunit-pytest-259a1eb36a42
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767099404; l=779;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LWg74/0hOx9JOV7tzEkr44kxmU95zPD51h88xTm0Ls0=;
 b=6wM9IZLE5/aSr4uI2d3RotrzQp7sHl7uEDQ8MPB3ju2hIAEA/BZe1lOVEOFHxpvusyJSWa5PX
 FhBPgeaizHJDLeaKatNM58f2F9mHeY9Nj6YhyDb1nGETAsqG4XujXEB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

pytest can run unittest-based testsuites, like kunit_tool_test.py.
It has a more features than the standard runner.
Unfortunately a few minor issues currently break this.

Adapt the testsuite to work with pytest.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      kunit: tool: test: Rename test_data_path() to _test_data_path()
      kunit: tool: test: Don't rely on implicit working directory change

 tools/testing/kunit/kunit_tool_test.py | 59 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 29 deletions(-)
---
base-commit: a77b19b747c8a53ac16289685b0f77085a2ad553
change-id: 20251230-kunit-pytest-259a1eb36a42

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


