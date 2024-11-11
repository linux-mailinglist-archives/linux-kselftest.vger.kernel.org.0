Return-Path: <linux-kselftest+bounces-21756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3809C37C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 06:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8140E1F21B32
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 05:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D9150990;
	Mon, 11 Nov 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LU80uqT7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QNCkvie/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818137F48C;
	Mon, 11 Nov 2024 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731302975; cv=none; b=O6lYQg4chZPZ6+j6Fq2QfgCP9BxIxY1nyAMHvA7B0kaDjBtG0aggP+Yn+KRlKmtC5bBT0rORXlTl9ic3cE0CT+vzooP+YSZWTmt4e2S8qnss2IQrrvO5WLir0toHEzMf+anEEOqN2BJYBOGFLTQFhH59IZ3pw9sC84c+S0cwapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731302975; c=relaxed/simple;
	bh=0EkOHW/GJxxmU6q0KeBRuqftyEYNIOEqhS9QoTPwRp0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lJXk2wb07fVLTIX687ZnMor0ksPwC7xwxAkDKLmslYqduy7dBhlDOwPCobFawvFIB71oNcjRccSqe8KqMeGIZfzMZCFiSFT5xT9j0Ncw/Afux51ca//i5GbS1PCgDe/yXJhaim2IP7cyO1r5ObB4EfwUE5PwL7MkyS1vw2+Tl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LU80uqT7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QNCkvie/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731302966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cogWb+w2daVn5OZHdS5AyR304srh7kVKobKMakof5IE=;
	b=LU80uqT7GWN755odMcZYEWGJ+BZIKwDyx2b7/ikTSrWeKIcZQOCaBgvu6w0j2yj+MvBklG
	qxZU6gjTH4i+fs1wKKoJ8g6gU6VGtdBnStFHvMbSAnKEKQVlQ5fzpOM4vk2dtiQ41ItJ/c
	76RG8FQw/ZpgjsVi86V8CuVmLObUkCVmovUhO5Hvfck9YbPKdQg9H3QNQVLP68QWLmmLhn
	yeeMRUxJreDwasYEFZFHMxnIiECE0UZ6OGYek6qe4FIR45LrhX7pcj2dpXnt8hW2Y5QuqY
	XRAJbcEkZWqEpLUS7dI9d/9RV79+Ap5Y6wbgZDjdZvkrk1tQani/O0tleZCrCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731302966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cogWb+w2daVn5OZHdS5AyR304srh7kVKobKMakof5IE=;
	b=QNCkvie/wz3p6eRKRYYFxz8gPrLWTLGFYWnwWMBcmeKsEGDgMh3K1NNqQNyqop9Eky0LBt
	hq0YClN/sUnWD/Aw==
Subject: [PATCH v2 0/3] kunit: Add support for LoongArch
Date: Mon, 11 Nov 2024 06:29:17 +0100
Message-Id: <20241111-kunit-loongarch-v2-0-7676eb5f2da3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC2WMWcC/3WNQQ6CMBBFr0JmbU3bAFJX3sOwKDDCRNKSaSEY0
 rtb2bt8L/nvHxCQCQPciwMYNwrkXQZ9KaCfrBtR0JAZtNSlkqoU79VRFLP3brTcT8I0tupuVY2
 NaiCvFsYX7Wfx2WaeKETPn/NgUz/7v7UpIYWqjem0HWppzGMmt0b2jvbrgNCmlL6W/oGIsgAAA
 A==
X-Change-ID: 20241014-kunit-loongarch-98a5b756e818
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: Bibo Mao <maobibo@loongson.cn>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731302965; l=1949;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0EkOHW/GJxxmU6q0KeBRuqftyEYNIOEqhS9QoTPwRp0=;
 b=EiVA11RVs0mMF5skCcPmy2ETQ1buIaeIrT4i7PvB3uldPozkU5Eol+g2+FLZ+QZSGu+0kaJYv
 FyXGpcOWAxyD4qmrj7IbCeCQ71W2NZ4Ol+VEHPNeSXfIG54brf7wAMP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Enable LoongArch support in kunit.

Example:

	$ ./tools/testing/kunit/kunit.py run --arch=loongarch --cross_compile=$CROSS_COMPILE
	[13:32:45] Configuring KUnit Kernel ...
	[13:32:45] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=loongarch olddefconfig CROSS_COMPILE=$CROSS_COMPILE
	Building with:
	$ make all compile_commands.json ARCH=loongarch --jobs=8 CROSS_COMPILE=$CROSS_COMPILE
	[13:32:48] Starting KUnit Kernel (1/1)...
	[13:32:48] ============================================================
	Running tests with:
	$ qemu-system-loongarch64 -nodefaults -m 1024 -kernel .kunit/arch/loongarch/boot/vmlinux.elf -append 'kunit.enable=1 console=ttyS0 kunit_shutdown=poweroff' -no-reboot -nographic -serial stdio -machine virt -device pvpanic-pci -cpu max

	...

	[13:33:14] ============================================================
	[13:33:14] Testing complete. Ran 493 tests: passed: 453, skipped: 40
	[13:33:14] Elapsed time: 28.862s total, 0.002s configuring, 2.526s building, 26.302s running

This series is meant to be merged through the kselftest tree.
	

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Drop already applied patch
- Pick up review tags
- Add SPDX header
- Link to v1: https://lore.kernel.org/r/20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de

---
Thomas Weißschuh (3):
      kunit: qemu_configs: Add LoongArch config
      kunit: tool: Allow overriding the shutdown mode from qemu config
      kunit: qemu_configs: loongarch: Enable shutdown

 tools/testing/kunit/kunit_kernel.py           |  4 +++-
 tools/testing/kunit/qemu_configs/loongarch.py | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241014-kunit-loongarch-98a5b756e818

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


