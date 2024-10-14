Return-Path: <linux-kselftest+bounces-19643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAA99C915
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 13:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFF51C2310F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8CE19D889;
	Mon, 14 Oct 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vW50XccO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+BPADPfk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E31922CA;
	Mon, 14 Oct 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905819; cv=none; b=CUZHAsvM4/51Vd2hThtdh7jTV8vIp9/1ZlspJOcZB+2ui4YgoOkWB448GKYauwItlkBKowbJwrmHrZZc9RFdq6guuNmTRhSfC5k3IsbiCcfquQOentce1u32c86VrlPygZUO6WjNpLtX02Twi6vSbPcqt55cjfreXoqdmCbUdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905819; c=relaxed/simple;
	bh=HfaIZkVQ2Ehy5PgvdYYtum//iKrrszeXOAZiOvTB5c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cviDl73JKIfNCeKltYdD7TLzhNOicE6fYJ78vEFKriyHhSPmQ56XHSXB90Ko31K1mP32oBX1yMENdrDGIfcYjK6ONUQEhPuLJBXt1WUsNNMq7A8RyJBjgbQcpnkz+/cuBgH97VtDPGe9TI2di7rK/lAhDNXCKWj66Lq0wGk5gI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vW50XccO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+BPADPfk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728905816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7VYLGYLqzSV2mxL+JEBIPWdWkYJ6W05nNMBLA96WmY=;
	b=vW50XccOacAGwWxJdiJSoe2FjAw9RWy4kinILGRMgSGdM+afpCHel7nru7lGbZvc4hXQ9H
	J3dZud04h+uaOtvsXs4fmVS192Mx/ar1euUb6y71X/PlKgIyGToOalJUkpkdIEqN1pS9gm
	Hwxsja82TbhUTGbWt06hmZcBq+sSZAvwW9Y+nwm6W4ojr+2fZJS54yGWGpcUi0N1tOqut1
	pQUcXZeKyNCxAahT0tVn/6I81ugsWLzTZflpR7JmVBCWiLscTd4tZooyLsJLhedJQz6IAY
	bi3rUfFn1c8H50zvweuNjFU5sB8XnSuP6CW6jFCLV8z5gB1VdV2RTUnUbpgr+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728905816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7VYLGYLqzSV2mxL+JEBIPWdWkYJ6W05nNMBLA96WmY=;
	b=+BPADPfk/1iiT6ynHAOiftp7EtBWB1xYmSL8J9i93rgBMy9BPhAHDdhPQDZNfin52s6YEC
	gHwsbHg9qtGnJ1Cg==
Date: Mon, 14 Oct 2024 13:36:43 +0200
Subject: [PATCH 2/4] kunit: qemu_configs: add LoongArch config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241014-kunit-loongarch-v1-2-1699b2ad6099@linutronix.de>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
In-Reply-To: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728905811; l=1114;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HfaIZkVQ2Ehy5PgvdYYtum//iKrrszeXOAZiOvTB5c8=;
 b=xnkirkC7lH0ga6Y65QuSgoJhMiIyIOrl3EC8JduOKELXHJHS4XnciTxIr0tZH7rvDbMPBzF0v
 VdcfqHMO94SBHncVKDJ8aliGciYjEKmU6KKFeRmruHz1gC5+/gjaR1i
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a basic config to run kunit tests on LoongArch.
This requires QEMU 9.1.0 or later for the necessary direct kernel boot
support.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/loongarch.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
new file mode 100644
index 0000000000000000000000000000000000000000..e7bb7c07819677dfdefac012821a732555813cae
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/loongarch.py
@@ -0,0 +1,16 @@
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


