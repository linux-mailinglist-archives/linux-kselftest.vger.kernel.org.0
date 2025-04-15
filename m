Return-Path: <linux-kselftest+bounces-30835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E853A897CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754573A74B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5027F741;
	Tue, 15 Apr 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jln5hEwH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G3BlMPrD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67821A3031;
	Tue, 15 Apr 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708994; cv=none; b=QTbHxIQg2U5yidvb7XBVDlXVbA32uTyUm/MyrZ24M68kZLcrmwC8b+/C/nBQqKiZGAySVQxFp0+6I6xVaIzDW7xmJO1VcFwkts4jNVyGKwpONm/34N0gPs9yvGondJgWJdWvlTmm4eMiasKMLpQLCAinrtJAWKj7DBYTodi6INM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708994; c=relaxed/simple;
	bh=3Eb4GAGwL/ZChCY5P5NR9ncafKBzFvPc72SuCpY6pwQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iP2wzz5i2VKFdknq6dZDyjCGdUEj5YrEIIwXIun4iDr35C+H8X0QtKvuJF45MqwnquRF/W3L7SrDU9DuawaimBmQtqnrxKlE1boqJMKFI71F67x1Li3TgIRkwUo8/6tVulY5Mo7yOeYMytCrgXAZP1IYI7ITc5Gstdg1NuUNJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jln5hEwH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G3BlMPrD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744708990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QRBrM/80v+smOzTTO0xgZrENn61/dOM7SxrtDW9E54s=;
	b=Jln5hEwHz6K8G+tq0se/Nak6yPmXzB6FKARx0ueK3U62bgbJYP6RP2dPayT5q+i7fCnR1V
	tsVeJmHoUKyXPOEXAj5+k7JTolVluOskK5lSi1LCP3slsMOVNwUUqy/JqJFtjqHO2Vlp1f
	0acHnL4touxfLeL6ygP+zyPEZ9epu6s+DdaKLlieCxgNroPYxIeHmpY6uxWvGJ2lTOtWS/
	zE0GfwHe98GbwGEYU03xX/zDBc99Lm2CzyTZ+SYzxxiMyL+jCjx+d3nH0IO0xdU+d+V6t9
	MnTFVk0ONWhfx9/tTlRvMcFW03FGAcJSbv5O2mRHImiCsow1YBFWyUrNCOQCJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744708990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QRBrM/80v+smOzTTO0xgZrENn61/dOM7SxrtDW9E54s=;
	b=G3BlMPrDHxiE/0PGTtvzntJxZOyr7zKPGHHgQa+FR41jSCM1zBlUTNcQM2F+vxQpfMX1xM
	E4dTi+hmNoVtpODQ==
Subject: [PATCH 0/2] kunit: qemu_configs: Add PowerPC 32-bit BE and 64-bit
 LE
Date: Tue, 15 Apr 2025 11:23:04 +0200
Message-Id: <20250415-kunit-ppc-v1-0-f5a170264147@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHgl/mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3ezSvMwS3YKCZF1jcxOTVGNzQ0NDozQloPqCotS0zAqwWdGxtbU
 AyVsJrFsAAAA=
X-Change-ID: 20250220-kunit-ppc-3744e371112f
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744708989; l=722;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3Eb4GAGwL/ZChCY5P5NR9ncafKBzFvPc72SuCpY6pwQ=;
 b=Psm4BU5jOdHPYjD1YogOp8Iz+vpBLQ2J+N416u/DksxCicWeL/H+KmYI2agafKIB3bDGp4P9x
 bvEReXJkUnvClEeVs15+bQFPYnxhEaqVF+SDbhOpXUcIZARLd9ERoco
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic configs to run kunit tests on some more PowerPC variants.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      kunit: qemu_configs: powerpc: Explicitly enable CONFIG_CPU_BIG_ENDIAN=y
      kunit: qemu_configs: Add PowerPC 32-bit BE and 64-bit LE

 tools/testing/kunit/qemu_configs/powerpc.py   |  1 +
 tools/testing/kunit/qemu_configs/powerpc32.py | 17 +++++++++++++++++
 tools/testing/kunit/qemu_configs/powerpcle.py | 14 ++++++++++++++
 3 files changed, 32 insertions(+)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250220-kunit-ppc-3744e371112f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


