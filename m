Return-Path: <linux-kselftest+bounces-19644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF299C917
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 13:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15B11F2303A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E92719E980;
	Mon, 14 Oct 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2xo15mJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w5lO+OBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6D19C557;
	Mon, 14 Oct 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905820; cv=none; b=qxbvINrrBRHYyK4HYzvH/lElM78+bnuAXS3Y3ZYZxnpoDIZF2vGH02dRE7YAGsuDSWGu1hXDRFyiYTm4FDLWlFzB31RGTUFTTee1IRHsv1NYKVOPeoVeH4yIX1ZOozqMCkyzJvH9LGLOMIRzN8Fnd++vNDiduDYN0798qZ+JFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905820; c=relaxed/simple;
	bh=L2g9um9oivjoyxdDxHIjYJE+3H3VkzceTni0Q/yD3cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKp16Y298S4bJ2XZ8Y75yQeYA+b0uFw6rPcyR/YGec5Y91Bxq0o9OzeG1ECO8m56UPrB4rVsWzX+Cp2Ovkl9KrFfD1hFrMFKkw3ZOZ5rTcvKgZjobSQViHdHhrv0ULXFFuzaKPxhxupaEShdHuPyB5PBB+zTO1mN7ugZi5n8/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j2xo15mJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w5lO+OBI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728905817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZWjQkkdi8HSm2h1+TS/T+pWxvqm9LlF9rGfeZByhFs=;
	b=j2xo15mJirgy1wRhLsvcZBiHaaoUN/Z9ZLITThaskd1RNdFiZUSdA/kY7q28m2KQrXRlMR
	ZbwV+7O26CjKGKR49JTtsSihLIWzA5gtTawjLAyZtHMKxn736gyTHIPE6E9ZwTsNjdPyRt
	nHKEzxh7b7nZc8cE8PgrGjk5RXfm4fvoDBCkfpreN9Mil2VPsq00VZr3RlbLwQAyfcttl/
	D/XKObNBLKRvKJ/GjdjrYcS0xr76lsa2Z8vsam27IBhc1i3KT21dRTgyag3eyMtSkmmPMp
	7nzM3bncXNFQq9BuNPOjeyZFzxO45Ayk1NWF3cj3V6QUz2eVpQyfjRw8vLCNEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728905817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZWjQkkdi8HSm2h1+TS/T+pWxvqm9LlF9rGfeZByhFs=;
	b=w5lO+OBIralzMDIkhgE0hCSQRWJXYi4hIozL22ikZ0V5EuOCc/VV97LiYFQVvorAbZ2/aV
	CiVF8skM+UWiEnBQ==
Date: Mon, 14 Oct 2024 13:36:45 +0200
Subject: [PATCH 4/4] kunit: qemu_configs: loongarch: Enable shutdown
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241014-kunit-loongarch-v1-4-1699b2ad6099@linutronix.de>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
In-Reply-To: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728905811; l=1335;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L2g9um9oivjoyxdDxHIjYJE+3H3VkzceTni0Q/yD3cw=;
 b=G11ZFpQbnm6r+Vm9sYeV6cF810ymPsjl0nNNeRoZEJKTfYsIqaOmVHK+KjOAyctIcSN/hgjsA
 QKD2fT9tArUDWYiF8IUca3hB0N89AoStT5ObkrUnJu2Yv822Z74Pt4X
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

QEMU for LoongArch does not yet support shutdown/restart through ACPI.
Use the pvpanic driver to enable shutdowns.
This requires 9.1.0 for shutdown support in pvpanic, but that is the
requirement of kunit on LoongArch anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/loongarch.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
index e7bb7c07819677dfdefac012821a732555813cae..1d2b780fbd5c0bde20aa6a5cd1217d0b3b443a93 100644
--- a/tools/testing/kunit/qemu_configs/loongarch.py
+++ b/tools/testing/kunit/qemu_configs/loongarch.py
@@ -4,13 +4,16 @@ QEMU_ARCH = QemuArchParams(linux_arch='loongarch',
 			   kconfig='''
 CONFIG_EFI_STUB=n
 CONFIG_PCI_HOST_GENERIC=y
+CONFIG_PVPANIC=y
+CONFIG_PVPANIC_PCI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 ''',
 			   qemu_arch='loongarch64',
 			   kernel_path='arch/loongarch/boot/vmlinux.elf',
-			   kernel_command_line='console=ttyS0',
+			   kernel_command_line='console=ttyS0 kunit_shutdown=poweroff',
 			   extra_qemu_params=[
 					   '-machine', 'virt',
+					   '-device', 'pvpanic-pci',
 					   '-cpu', 'max',])

-- 
2.47.0


