Return-Path: <linux-kselftest+bounces-48008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E09FCCE9A6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C1973002D1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031EF2EB845;
	Tue, 30 Dec 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7W+0ifT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5PVhEEsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52E2E9EAC;
	Tue, 30 Dec 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767097606; cv=none; b=saBcHhmbFqbn+deS/umZyxQrHLpEIwcClUU6tabxR/GSg8T2OtjumAmsLfKpD9S0izzSVRRB5FJUiHuSZnmBbKmtjQUEBB1A+GbpJZ2Ys7x2rqLZuXOUAi7w7WGjKymSXN+0bD0kQSQD3o1VkSlnt8Ay7bV4ym444BewFNiGY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767097606; c=relaxed/simple;
	bh=x1OYC0UQWem/Q9E2HJ1iixtzaaiBHsl6UQcDHG/dzUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=atiSft1oa7gNdKlMangmccafVF6vY0b0TRsUqjkh47cXLV5B4ioIE36rMQ3d90hZOtrPniVVDeV/AtPAeB4PdDuSiFO9FWrznsBtKB40U4ziUjVMSdcWsSiZ/1URETmOsB3nXA+r7NR35w+g70sASbGn89ebuwA2z8L+PPEeHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7W+0ifT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5PVhEEsq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767097603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bbenhJQDYJ+nBxrFFj/0WTfV81aM1RlkQ/pqwQLkauE=;
	b=O7W+0ifTrP/BjDBRwdV1x3nULkGpzf+iZmUdyx+jQNtD8Eo8msbJb2OL7pa7mVJKKv9Gk+
	Vfv+tu7k5QdsFZGx4Gst1jrAdjdKlsEII8VcF05P8ORk2vz064+gALORq5ICw3UiLc02uU
	ZZlWyMTOSxAFwPIa+gMGxALDKJeGQ1EP9xviusPQKhmKTBaoID1INZ8/oyB1tyVHLpY6Hh
	I2pYoPzl15v0m8MYF7F/cW4un+l3TkgdrogIWLhjUWZ2KGwETK4glLi5yeB7qTi7IfDCS1
	/EFNp76XQC0VganV8nsYYaSwUEo1W2jlUBU8Q+1j7IO5CsTN2ZPKOk0ANzRmow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767097603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bbenhJQDYJ+nBxrFFj/0WTfV81aM1RlkQ/pqwQLkauE=;
	b=5PVhEEsqjlt/UyGn47eYJh8iyrM8W/8MjZ6nsiE4WNGnIH/VNuuafKUo432YmfXdov24cH
	RyxkGtYXmn7wgvAQ==
Subject: [PATCH 0/2] kunit: tool: Don't overwrite test status based on
 subtest counts
Date: Tue, 30 Dec 2025 13:26:34 +0100
Message-Id: <20251230-kunit-nested-failure-v1-0-98cfbeb87823@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPrEU2kC/x3MwQpAQBRG4VfRXbvFiBqvIouLHzcamkFK3t1k+
 S3OeSjAKwLVyUMelwbdXESeJtTP4iawDtFkMlPmpsh4OZ0e7BAODDyKrqcHSyFlhd5a2wnFdPc
 Y9f63Tfu+H079Ev1mAAAA
X-Change-ID: 20251230-kunit-nested-failure-a3a56ec999ba
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Rae Moar <raemoar63@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767097602; l=1287;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=x1OYC0UQWem/Q9E2HJ1iixtzaaiBHsl6UQcDHG/dzUE=;
 b=C8a81b9oygE9KiGJ51arc1yc9nUD9+90eQVp5wpgcE5lNLX/KpR2Z5KMFP1wwtP/SABcUPEqY
 ieQIhwo+JmyDIOHf7xR8fZG/bxJeRGCAVP7Cgi0LVLiuVtl9oWbocHk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If a subtest itself reports success, but the outer testcase fails,
the whole testcase should be reported as a failure. However the status
is recalculated based on the test counts, overwriting the outer test
result. Synthesize a failed test in this case to make sure the failure
is not swallowed.

These patches where previously part of my KUnit UAPI series [0].
I split them out, as they are useful on their own and the KUnit UAPI
series does not actually have a hard dependency on them.

[0] https://lore.kernel.org/lkml/20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      kunit: tool: Add test for nested test result reporting
      kunit: tool: Don't overwrite test status based on subtest counts

 tools/testing/kunit/kunit_parser.py                           |  3 +++
 tools/testing/kunit/kunit_tool_test.py                        | 11 +++++++++++
 .../kunit/test_data/test_is_test_passed-failure-nested.log    | 10 ++++++++++
 3 files changed, 24 insertions(+)
---
base-commit: a77b19b747c8a53ac16289685b0f77085a2ad553
change-id: 20251230-kunit-nested-failure-a3a56ec999ba

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


