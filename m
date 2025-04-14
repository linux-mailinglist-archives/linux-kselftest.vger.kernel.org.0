Return-Path: <linux-kselftest+bounces-30657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD420A87A61
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9E5188BCC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6705925A32E;
	Mon, 14 Apr 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3r8PQgr6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JGfa2HYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC191258CE9;
	Mon, 14 Apr 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619197; cv=none; b=neGDrvC7oceGXJNLR7yVzcUMvJmyGZwMBZovvj03ZUziM1SZqmPoY/ksxiC7dshnG5FujJrta6Pf2Ck+4zuGTWMGIxXIYQJocIud5aqjBR7eqmc9qENs37ePLZHw5/k0UXxWPecA5NgOzqlByWP0kY5bPX8U9lpJ0CnwfebYvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619197; c=relaxed/simple;
	bh=VxE5F99R+SrLxML4apwdbCFuWE1oJfmeWXeD/51Sql4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G4xBKO4YOtRIbBqUy0A6NmergXP0sBRDghzKqvhhkC+SPHZUZtk9RrDSgBr5OTlNox0k+OE7aEvo6/lWn+Txnbn7syPQUBgMzo25jzFQrxEDlouAYO38SmaT6HxQuL3GUVN/klks2xo1GJraQztXyFrY9O/LvSnbgVOT4YmE9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3r8PQgr6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JGfa2HYB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vR/KB4thQQifwibuCre+EV1u9if5PAU4bZEmpqmHzg4=;
	b=3r8PQgr6IvuDHruxYoj/eCK3F7GeZ2GqEUIFZkCqJXgWr4IPer9uIYukdIZ83ZF53y4qIw
	D/NKmcEqXthSnZ2dr2fFvYE0qnvgAVKIJPgbfx4wBSIJcBS6FHjZ3aHbG6qqkaGkOfLnui
	UmjeoAN6H+/FuMur6iO4z1/HZqzs4oXHqSDXz+ybXFM3C55ScoKrsokiOUJbJt8gDKM0vc
	SEeiMSxEpr9MmQzL60mZsqq9b4+hpmXgaSr2F258hQZvA5kUr0zZl92L0GWTXsFn5TvmFA
	IdybxH6zlfw0wMhO9THN28ucAtyLOroGVav/ZNoj98XYwDFj3ohCTmuDXqrUrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vR/KB4thQQifwibuCre+EV1u9if5PAU4bZEmpqmHzg4=;
	b=JGfa2HYB1QTbowHoiyLz1iNe+yZrbRbwObAlv8Hvh7uH2Jpe/9podSftYM4M64NuzAqttz
	ThoKiSPXDGE1tDAg==
Subject: [PATCH v2 0/2] kunit: qemu_configs: Add MIPS configurations
Date: Mon, 14 Apr 2025 10:26:20 +0200
Message-Id: <20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKzG/GcC/03MQQ6CMBCF4auQWTum0xQIrryHYaF0kIlaSFsIh
 vTuFlYu/5e8b4PAXjjApdjA8yJBRpdDnwrohrt7MorNDVppQ4oMvmYnET8yBWTTM3W6KtnWkA+
 T517WA7u1uQcJcfTfw15oX3emVJr0P7MQKuSHabrG1lVF5fUtbo5+dLKeLUObUvoBfJhMkqgAA
 AA=
X-Change-ID: 20241014-kunit-mips-e4fe1c265ed7
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619194; l=1419;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VxE5F99R+SrLxML4apwdbCFuWE1oJfmeWXeD/51Sql4=;
 b=DvySt0XsPNdR+vDCNqtOutMdFf3WpogWkT9QL2BkjImhmguTlIm4eGdph7Ncvo+fcxJdjVUz0
 1hTiKZK3627DUMUVoaDwq8BCnOOe7ISAu5GnGpN/zGPNtPR7HnkPXzw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic support to run various MIPS variants via kunit_tool using the
virtualized malta platform.

Some of the cs_dsp unittests are broken. They are being disabled by default in
the series "Fix up building KUnit tests for Cirrus Logic modules" [0].

[0] https://lore.kernel.org/lkml/20250411123608.1676462-1-rf@opensource.cirrus.com/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Fix usercopy kunit test by handling ABI-less tasks in stack_top()
- Drop change to mm initialization.
  The broken test is not built by default anymore.
- Link to v1: https://lore.kernel.org/r/20250212-kunit-mips-v1-0-eb49c9d76615@linutronix.de

---
Thomas Weißschuh (2):
      MIPS: Don't crash in stack_top() for tasks without ABI or vDSO
      kunit: qemu_configs: Add MIPS configurations

 arch/mips/kernel/process.c                   |  8 +++++---
 tools/testing/kunit/qemu_configs/mips.py     | 18 ++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64.py   | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64el.py | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mipsel.py   | 18 ++++++++++++++++++
 5 files changed, 79 insertions(+), 3 deletions(-)
---
base-commit: 0466dc03fa779373afb807ce7496c404d98ace4b
change-id: 20241014-kunit-mips-e4fe1c265ed7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


