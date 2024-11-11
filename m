Return-Path: <linux-kselftest+bounces-21759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD26C9C37CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 06:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8131F21E5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 05:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62E1547F2;
	Mon, 11 Nov 2024 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJm3nnOh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUmQRpeg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949114C5AE;
	Mon, 11 Nov 2024 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731302976; cv=none; b=h7H/QWvJ8vv58RjaSDRwxSKoMoo45Eo2ruo/cB8mKAETPqJfyoPeysbCZb3q2GwWfuHb6QbyDhN5IX6/x/y9cPDZu3TUkf+FCbdYkANkK0zhTUY7q/i6HKMxvQRSesGBNcietty9EvgWyBQO+FOkqDgQM0zdVQu6uxJ9mcCDE2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731302976; c=relaxed/simple;
	bh=xb/b9qP6dTRXf6zeQaXgJn4vP0VJdWkzyw3GAXgH4QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxE+vHfsBI782emGni98K32m5lJyX4It5tJiCoam240VhHY7OfkTuIrFzSkU5tHZEPaaKGv2E1Y6f1VQf/UYgVylPx5IeQs9HSZVN+vhA1FeqItYyRsU02EfosFibcXCS4Hbu2qqqbab+xajgWCgBEfXP7QsKiKMqz6bf5ngBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJm3nnOh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUmQRpeg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731302968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPz5pTfSW1fYMOgeGzoArsFrU6Qcr3GhQ9X63RdirUU=;
	b=rJm3nnOhYpqZnpZ6/hjpd/tJL1PKgKQ70M7flz+MmgtfEzqfYyJwcUaixP+19xCHwCK/A2
	SwchUfAUdiN/bW8k6ltrMNxumEulS60/6UEouHCk6bIHWW8GobWeprZ1T/+8iLhJSmH8UO
	FlZkLU3GDXtNZYRPUfVMeT2yeHvMcwTtpDF48qY3rKVJJ6FURQ0mL27W6w3+1JFDzpVCxW
	XIo+sK4FtExyCF2UIc93tiOap0/QEOleLkyWJc5izO6p68gWpCjwBZFSeoRDjIjNGa6RZS
	XKxhZiBFYzz/KC48KfFopWlBq9PVu8X5qLkla9JqE49FDtQxS7SWE8x0nm7AgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731302968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPz5pTfSW1fYMOgeGzoArsFrU6Qcr3GhQ9X63RdirUU=;
	b=GUmQRpeg53bnBKeSTixSJURfMo86Zl4NVE8wQ1h6DgoSE1/6vxGZNQ95W2oWpElnjrhdIQ
	niCv+bnUfBZTx2AQ==
Date: Mon, 11 Nov 2024 06:29:20 +0100
Subject: [PATCH v2 3/3] kunit: qemu_configs: loongarch: Enable shutdown
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-kunit-loongarch-v2-3-7676eb5f2da3@linutronix.de>
References: <20241111-kunit-loongarch-v2-0-7676eb5f2da3@linutronix.de>
In-Reply-To: <20241111-kunit-loongarch-v2-0-7676eb5f2da3@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: Bibo Mao <maobibo@loongson.cn>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731302965; l=1426;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xb/b9qP6dTRXf6zeQaXgJn4vP0VJdWkzyw3GAXgH4QM=;
 b=1sEhBxvK/yiUrPv2sjKx7s8UKUT3mFs5DeJdsfW23gI5UkUVFnaAHZrRcfg6uqx2gxL2lEeCV
 KZUtE1lAwhgB4DTV5kdMI86MXmEYb+3Bkreo0jGqTGuntF6ec18292r
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

QEMU for LoongArch does not yet support shutdown/restart through ACPI.
Use the pvpanic driver to enable shutdowns.
This requires 9.1.0 for shutdown support in pvpanic, but that is the
requirement of kunit on LoongArch anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/qemu_configs/loongarch.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
index a874a2156e0f791caaaf30e5f7b17fc175bb55ee..a92422967d1da9f1658ef1e80d0d7365ddbae307 100644
--- a/tools/testing/kunit/qemu_configs/loongarch.py
+++ b/tools/testing/kunit/qemu_configs/loongarch.py
@@ -6,13 +6,16 @@ QEMU_ARCH = QemuArchParams(linux_arch='loongarch',
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


