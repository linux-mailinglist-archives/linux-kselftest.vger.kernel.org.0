Return-Path: <linux-kselftest+bounces-19645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFA99C966
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF0CB26A6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B8E19F434;
	Mon, 14 Oct 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ffpxrkea";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ky4KtFHP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2617625C;
	Mon, 14 Oct 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905820; cv=none; b=Gc06AUYidRxFE/3iUXuY4ZnAmWXhgb5bBPhOJvQs3qXkdQsFIu0YWTyialxvuZLdFClDwoF85WHXqiwzAdDf06SSfbP4PphnsATfxYvIm3dFF/v6/OMyQwkLqzrspV4unNcaY+zyHlFszWa24rGACK5yvzq97zdxOpFu2JJu0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905820; c=relaxed/simple;
	bh=7Nms4lbsG1RIG8SZCNhD6F8zd6Nt+1g5CiHRVpPSbW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O/u00De/Qos+sCogA2pxjUQooUeK3PwHDt/HC6tUZaIqmKE2KJkeD/BfM2eTDSZ97URpHQN1DqTqC8SMtkydNYRYvjp4yk2OXM7u6hSS0mKdGrot0G25MxSYZPP48Mufn81Yss7tA/VoNOrtL2/GxUxY2x8xs5eAYw27EvEbkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ffpxrkea; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ky4KtFHP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728905814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LoMnRrbVjbkfV1Eo64m7st7itWx/XgeEhQAuuphZYG4=;
	b=Ffpxrkeafpt6ceJ4AmgJ1sco1OBzP6ZREKcgrSOZcp1vPBgILBN/RzKzShMUwDvuW6QP6j
	kNh1vKG9IrQNaknojpt8ZYmHUos0MilzSizUnJ0XNcUqtbIvkgN4zWzAke6J3QHLuCX32s
	/eBOTn8urIMgg/eKDDgcR5o//6+vniIz6V+evgIAVyVuIZnXj3u9xNxvZFtwjhYYNYiVVA
	IUKa2vbSwgxY+sCrUY7Ek9010FtQyHfT5l7eiOhWW8NsiT3qeBHUKydIgkJyweKiE4q98W
	R/8ztdQdrLr5/4jyJNAvIq7OOsUXEgV15qy9P7HHH73YDr2YFt2/VuwnMwvmoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728905814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LoMnRrbVjbkfV1Eo64m7st7itWx/XgeEhQAuuphZYG4=;
	b=Ky4KtFHPc1Y0/5HFsWN2pSgYMuEpV0tf5nHiTAvSkGcCCp6GzcwmcvrXNqeQ3m4OkpAgNG
	9dpTn3JGfVG7HrBA==
Subject: [PATCH 0/4] kunit: Add support for LoongArch
Date: Mon, 14 Oct 2024 13:36:41 +0200
Message-Id: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEkCDWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MT3ezSvMwS3Zz8/Lz0xKLkDF1Li0TTJHNTs1QLQwsloK6CotS0zAq
 widGxtbUACAH64mEAAAA=
X-Change-ID: 20241014-kunit-loongarch-98a5b756e818
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728905811; l=1828;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=7Nms4lbsG1RIG8SZCNhD6F8zd6Nt+1g5CiHRVpPSbW0=;
 b=/rg0fQwXJ1NxfQwt/3KNv/yBl5ajYq6g+gynF3n92s7siw03GrxQ/mCSPAO+l6Keg51p/3Ip6
 KJIdbg6s8lMCLksS+XEJXVYVZqkcOCilAyAEMvPKfk7Q+oaLaMUfSbG
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
	

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (4):
      LoongArch: Don't crash in stack_top() for tasks without vDSO
      kunit: qemu_configs: add LoongArch config
      kunit: tool: Allow overriding the shutdown mode from qemu config
      kunit: qemu_configs: loongarch: Enable shutdown

 arch/loongarch/kernel/process.c               | 16 +++++++++-------
 tools/testing/kunit/kunit_kernel.py           |  4 +++-
 tools/testing/kunit/qemu_configs/loongarch.py | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+), 8 deletions(-)
---
base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
change-id: 20241014-kunit-loongarch-98a5b756e818

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


