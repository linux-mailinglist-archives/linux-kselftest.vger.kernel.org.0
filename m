Return-Path: <linux-kselftest+bounces-25432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C02A234DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 20:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B397A1A05
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC571F03F5;
	Thu, 30 Jan 2025 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pFKAKTrn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD953143888;
	Thu, 30 Jan 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266856; cv=none; b=RREji9N7TcZloh6iXafoGmmKkCqHhTOJsZ8tcta+F2YZCMzkK3BENaQtomq6S2s/o6wtAUiaHH340LliHTjgN+s7P3RF/1TutskpjCm/HFshRovAyTiB1hoDH2UsI7sXgOgpe4JlrxoYIilzZKAUstMXyhHYzZKlKvptnk8op0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266856; c=relaxed/simple;
	bh=0OHcSoNVdcTZ44UjO4GEV4vBLp4Ktrgzs+1GCrpe5JU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oTnVU8NCysb9UZNvfqVUi3tIIl5t3HcsMrGHB7gkzNEUbhxcK+OC7cdsKqUztsNTSGoe9gxiTFK5sVAzGHNOzJGnkv12HvaA7N9Ke1nSDN0Xx3HAWhK7DuUnYsGOdu4jc7/o2Mqcar8osBBQYT6R7bEp0mfFy5Ax4ZyPUg4NtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pFKAKTrn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738266852;
	bh=0OHcSoNVdcTZ44UjO4GEV4vBLp4Ktrgzs+1GCrpe5JU=;
	h=From:Subject:Date:To:Cc:From;
	b=pFKAKTrn//gRlVVLJ37+LY83/6AP7HI2baj+XCD+QF+i7Wro2Bp25j8k/Jd0cl1GQ
	 h2u6/m6ejxYCbG1HEp3DG+XviEKnuNTY90StMZBYlP4wotMe+ClPulIPWYXqjN+Vgs
	 N6d5bsSfMsx0WtGePVKZNC/Utv0uXhWmJV2iPvdE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] tools/nolibc: add support for directory access
Date: Thu, 30 Jan 2025 20:54:01 +0100
Message-Id: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANnYm2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ2MD3bz8nMykZN2UzCJdSwuDZKNUoyQzM8NEJaCGgqLUtMwKsGHRsbW
 1ACqFvNBcAAAA
X-Change-ID: 20250130-nolibc-dir-980c2e2b661a
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738266851; l=741;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0OHcSoNVdcTZ44UjO4GEV4vBLp4Ktrgzs+1GCrpe5JU=;
 b=wp2t0rV27tbrBzr7Y1+XgY/WtZqONju4sAa4LWkyl/YKWtgLVD7Azo0sFpCIrA6ZnLczvYt6/
 4Yujy149fRMAjp++Zup8uUiSyJtNlBeWg6u7Z9kDHWf0N73bhEJZNzi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support opendir(), readdir(), closedir() and friends.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      tools/nolibc: add support for sys_llseek()
      tools/nolibc: add support for directory access

 tools/include/nolibc/stdio.h                 | 76 ++++++++++++++++++++++++++++
 tools/include/nolibc/sys.h                   | 29 ++++++++++-
 tools/include/nolibc/types.h                 |  5 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 37 ++++++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)
---
base-commit: d3d90cc2891c9cf4ecba7b85c0af716ab755c7e5
change-id: 20250130-nolibc-dir-980c2e2b661a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


