Return-Path: <linux-kselftest+bounces-21757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB39C37CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 06:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF8D281161
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E861537C3;
	Mon, 11 Nov 2024 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uzqfr+Hl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d3JIuFLw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52B14B95A;
	Mon, 11 Nov 2024 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731302976; cv=none; b=Eh47aCfk/bg2bFu4uRi7E1brP2jnnPFYz9M797PeA7X+ndmay37R9AIdRtT9oPlhTku6yR0pf0H5hAJT4BZ6mw4BUl+6+PBYGfbNrfG7aoa6Xx6XSkIMtQ99+WZereJurcVbMA0H3csZgs0v3XMb90MMnsn4vZke2iyA7vs2rKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731302976; c=relaxed/simple;
	bh=1H0lsA1melbP7Mkd+oLrxFN3y7nwa8EVtGO8EFXhi/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pd5fNP2KyKBZs3qW/JGno24z2WvdVRO08WHTTo0783y2cWKxMA5lNpWGjsoJVYilDmdUiRd7e3qDY9DhIxTklxLJB/CcOiz2pyuEbeDz3KyyGzg1hvuro53yeXS8BmXqKFd+pm2K0sHqI9FdcJjzvhN9HyOPWt8C4vyKt4m+oJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uzqfr+Hl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d3JIuFLw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731302967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifoGJMBHZ1DqZx2Obrxr/X5prXUNx0tqWRzJjSaO6kQ=;
	b=uzqfr+HlV4tT1qhLmCHVKuDJwDUkgECQzV0KEwbpKjqOL5hQSRsODdzI77K1XP+vlvRBjd
	XIsyuBW2tsdl96XDDkG8rP2AcjZ4dR5hYUz/gJlD4koPvds4PYRYxTzbFqAo7+ryVS7F0L
	SwFp3k/wk7efTCrgialIo+06i5LdrQTSf+uJfYWnzC+JhcSgZOI6ZTVTzGUAe0Xw/qlJxl
	m5bmWTY5LSU3nI2mwmoVl0xDOqExZ3ppspE39bMUkWppxYsNLfgnmhWgseX33I0iKfpUUX
	FwV4iV1jrq9VTwiTOSPbt0CrJDOxxRVva57ZdSREPPOM5ChKAk+gt481OQrMWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731302967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifoGJMBHZ1DqZx2Obrxr/X5prXUNx0tqWRzJjSaO6kQ=;
	b=d3JIuFLw53tTVosNz6RG79DYTdEndoP8rAy6VJUQOY6vHEBypbCWAx3MDFlr0KN2PTet2r
	3ZgP7LuWVEvPPxBA==
Date: Mon, 11 Nov 2024 06:29:18 +0100
Subject: [PATCH v2 1/3] kunit: qemu_configs: Add LoongArch config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-kunit-loongarch-v2-1-7676eb5f2da3@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731302965; l=1247;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1H0lsA1melbP7Mkd+oLrxFN3y7nwa8EVtGO8EFXhi/A=;
 b=5qrvr/riA2uB3GHVeHZnLAJB3A6LUapyCXEA+OrrgBheolSZfBFWT/g2Mu2BhB781zEK5t2S8
 LcmfxtQkNXXCdUDk91TIbTFmOfz8zKZqRjdiwveLekIdux27rmgh5UU
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a basic config to run kunit tests on LoongArch.
This requires QEMU 9.1.0 or later for the necessary direct kernel boot
support.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/qemu_configs/loongarch.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
new file mode 100644
index 0000000000000000000000000000000000000000..a874a2156e0f791caaaf30e5f7b17fc175bb55ee
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/loongarch.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='loongarch',
+			   kconfig='''
+CONFIG_EFI_STUB=n
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+''',
+			   qemu_arch='loongarch64',
+			   kernel_path='arch/loongarch/boot/vmlinux.elf',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=[
+					   '-machine', 'virt',
+					   '-cpu', 'max',])

-- 
2.47.0


