Return-Path: <linux-kselftest+bounces-48396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C41DCFDCB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 14:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98D130F8918
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615C2320A20;
	Wed,  7 Jan 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydlarwpE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BnpvtDRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7031ED7B;
	Wed,  7 Jan 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790322; cv=none; b=go0OjkED8H0kDmYtrb/w9XxrVK3sQDmCo91gGqXEZvjS5pszEX6X6Yk8htL+D6JA7OxHhsgUwxE3qZCtxqModQ6nFQALnL54nbw7FPBcmNikK5Udc6SnKbl2Y9q/wauVwn8PnlA68MxBdENfxNe5l/0cph6cIFg22NuzxMo61ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790322; c=relaxed/simple;
	bh=cNjt5hBaidC77Kz3AqWf+7T0QMUvEFFWbSKQw1KAvj0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZdbYVzFXeNP8CBgNrP0wt+B87rQY4Kk5S2ptI6vGWuY/23OEX7GK1eeTbvNBhLleUKhMJXc/p5ITi4j1gx3bgw9S7WqFVsz5pegTSw49b98YKOHb5Rrlghupoz/g572yvDOynGEV8d+KardtO4wo//QQSr5aTeS7i6KsaEWt95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydlarwpE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BnpvtDRR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767790318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L8ip3wl5dqdNhxulffY73BmUHyTCNZaPz63K9bzw8eQ=;
	b=ydlarwpEkd6ogq9XO/DYRrLIc3JWUQ5QPttGVAE7qy1sIFqmzSOmF33YGj8El6ZCb9Ih7h
	S4tYsX25GoL/cDU8Q3O4FhLYiZALwcTrnrhGyIFyPpAgwI7uno/YO0JE+35WgRkz0wDcsW
	3ctJpBC01leTEnn1NsLkjKdY+4+49OxochIsDsUkb6JH2UVH3EfVTJGkKEM5EJq/O7jOxv
	leDKUYD1d+eT5bgOVXF2gKSIy7Gg/Wwa4JEF0jFSlwhiXT/7k4y4IXyj8nre4BC+8gOq1Q
	L0WID6FU2ukn4f1t/EX38ATWATUesCY0ZBFLR9nk7YqSxT72Zi00VXNWf+Hy5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767790318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L8ip3wl5dqdNhxulffY73BmUHyTCNZaPz63K9bzw8eQ=;
	b=BnpvtDRRAxVt7ZAYMega4nxVnOLFs52oWdF0R9t0370W6NHe84r0dHy+GCF9Bq7vfOH9x4
	kbW3qhFsyrcPeCBw==
Subject: [PATCH v2 0/2] kunit: tool: test: Allow running with pytest
Date: Wed, 07 Jan 2026 13:51:50 +0100
Message-Id: <20260107-kunit-pytest-v2-0-7d1f8d9a5ffa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOZWXmkC/3WMQQrCMBBFr1Jm7UgytYKuvEfpIprRDkpSkjS0l
 Nzd2L2Lv3gf3tsgchCOcG02CJwlincV6NDAYzTuxSi2MpCiTlOr8D07STitiWNC6i5G8709mxN
 BVabAT1n2XD9UHiUmH9a9nvXv/RPKGhUyWcOqjpS6fcTNKXgny9EyDKWUL7o8CMmsAAAA
X-Change-ID: 20251230-kunit-pytest-259a1eb36a42
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767790313; l=976;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cNjt5hBaidC77Kz3AqWf+7T0QMUvEFFWbSKQw1KAvj0=;
 b=aJaS3NUUICNC2seTXm7UuMWHvLgv8W9Hl1tX8nXiBeWxLP2J9KCOzpvTNWMbxjOB1GDIyLJdT
 LMysQbKoKCmDvH00rAphRszK9PK/ei0er2tqHX2kYRlzBQWXRk/LXil
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

pytest can run unittest-based testsuites, like kunit_tool_test.py.
It has a more features than the standard runner.
Unfortunately a few minor issues currently break this.

Adapt the testsuite to work with pytest.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase onto current kselftest/kunit branch
- Pick up review tags from LKML
- Link to v1: https://lore.kernel.org/r/20251230-kunit-pytest-v1-0-e2dae0dae200@linutronix.de

---
Thomas Weißschuh (2):
      kunit: tool: test: Rename test_data_path() to _test_data_path()
      kunit: tool: test: Don't rely on implicit working directory change

 tools/testing/kunit/kunit_tool_test.py | 61 +++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 30 deletions(-)
---
base-commit: ab150c2bbafe9425759eca1e45e08d4ad1456818
change-id: 20251230-kunit-pytest-259a1eb36a42

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


