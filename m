Return-Path: <linux-kselftest+bounces-30823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB6AA89471
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEBC173821
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B165A2750EC;
	Tue, 15 Apr 2025 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="so5RafZ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgO45HH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8031A5BAC;
	Tue, 15 Apr 2025 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701022; cv=none; b=AeCUinJbSN0c1CdOXIA9EyR17rOQiowNo5zcRK/mEimtcIjKPR2enaFr4ezELcL8kYmQMoJCBnTkVWOFf1WTsTwUoeQ2FFLpyJhlK8aZaW3lVa+w2JUl7TihduvaPdcjo438jLAYKsQYI0CaKkFFIObSdPJ1niWCAJHhkp1ZLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701022; c=relaxed/simple;
	bh=g+n/cQDOvV4c3mhDjjih/izI+0j9s6YEbBzWfnR8W9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EJJqzeP2iSw8RFnG4gT6LK+4SismW93CN2rD19MHZ8LqOgOduF+xuEHbNC3+l2pWDblPaq/vewNq1umvjOmaLJ3RBRev4abXP3QodlG69LMlWor0lkTzcmeLyhqHS0yspfqZmVFS/Du47IyLVvho4Qo6i1jfNfJQMZ2WJf4KdAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=so5RafZ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgO45HH+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744701019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7mfS66XpVMpOKzCX8o5hR3aialgtpc8tOlgQWcN14aE=;
	b=so5RafZ3AfHhpz03D2uKMptphcsQR6Hcu5fwUan6gYp9KRqxEgHR51r9JcBnqJDR0dwyzE
	/ZJcIgCroaFG4O6hx0qgTW2I5tzRTcikLOI7arFMAWKA12VjTFAeoPsrhs+3Yr/mXhBvzx
	onjKmQJ9djsDKR3iQyXz39cLUwZmzyk/Edq9Z+SiEyplCNGG5qf3V6rTOJyaS6HHyGjhnX
	q8ostnuyoyUx7Pv+q/B6ATUExPvimwm8slJkPxFq6bDr6LFBSvxNwIHOK6XirrztSPD1Pe
	7E4OXIOQUhxvDi5/rezFOoqFwEWRtebtu9mcORlVrtKksrmwhCYnxOxXuqVfIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744701019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7mfS66XpVMpOKzCX8o5hR3aialgtpc8tOlgQWcN14aE=;
	b=cgO45HH+CtW2J9LQeJGz5ls9ABAz4PCt+wbR+q8bnWAApG9Q8B0FjUXJ8j51XxkEXSku5i
	fTCgqnfoHga09hCA==
Subject: [PATCH v3 0/2] kunit: qemu_configs: Add MIPS configurations
Date: Tue, 15 Apr 2025 09:10:05 +0200
Message-Id: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE0G/mcC/12Oyw6CMBBFf4V0bU1nLBBc+R/GBbaDTNRCWmgwh
 H+3sPGxPDc5J3cWgTxTEMdsFp4iB+5cgsMuE6at3Y0k28QCFWpQoOV9dDzIJ/dBkm4IDBY52VI
 koffU8LTFzpfELYeh86+tHWFd10yuEPA7E0EqSVddmcqWRQH56cFuHHzneNpbEmsq4kfXvy8iJ
 l2bRgFBjRUV//qyLG8sgsyw5wAAAA==
X-Change-ID: 20241014-kunit-mips-e4fe1c265ed7
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744701019; l=1595;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=g+n/cQDOvV4c3mhDjjih/izI+0j9s6YEbBzWfnR8W9A=;
 b=KBBHHlgj3AA/9ih/IClGEffHAlwAaIKLNufvOriDkFrnepSMit8uptFnk/QK22tPkNbqW9UgN
 Z4tTeVKxvtaCL3Bsg9CZZ8hWGUIQNveaLgkCA1qr6DTNGqcg3K7/irI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic support to run various MIPS variants via kunit_tool using the
virtualized malta platform.

Some of the cs_dsp unittests are broken. They are being disabled by default in
the series "Fix up building KUnit tests for Cirrus Logic modules" [0].

[0] https://lore.kernel.org/lkml/20250411123608.1676462-1-rf@opensource.cirrus.com/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Also skip VDSO_RANDOMIZE_SIZE adjustment for kthreads
- Link to v2: https://lore.kernel.org/r/20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de

Changes in v2:
- Fix usercopy kunit test by handling ABI-less tasks in stack_top()
- Drop change to mm initialization.
  The broken test is not built by default anymore.
- Link to v1: https://lore.kernel.org/r/20250212-kunit-mips-v1-0-eb49c9d76615@linutronix.de

---
Thomas Weißschuh (2):
      MIPS: Don't crash in stack_top() for tasks without ABI or vDSO
      kunit: qemu_configs: Add MIPS configurations

 arch/mips/kernel/process.c                   | 16 +++++++++-------
 tools/testing/kunit/qemu_configs/mips.py     | 18 ++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64.py   | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64el.py | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mipsel.py   | 18 ++++++++++++++++++
 5 files changed, 83 insertions(+), 7 deletions(-)
---
base-commit: 0466dc03fa779373afb807ce7496c404d98ace4b
change-id: 20241014-kunit-mips-e4fe1c265ed7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


