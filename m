Return-Path: <linux-kselftest+bounces-21758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 780A69C37CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 06:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E497B21535
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 05:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41EE154456;
	Mon, 11 Nov 2024 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XXlnRAkY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1ceS6cF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB014F10E;
	Mon, 11 Nov 2024 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731302976; cv=none; b=FrCMrGY1ZHoyINeeQ36Ha2c8bqMEk21Bxmp7lCoGz1p5/iIdv/9xvmRK5rK+NDjMv7ohSIaLyEJxPrhGQskE7TVjPUu7Tp+EKpEv6KCcI6u44O12pTCYCmOAZcUFTljgwyXA2PfLPJmCwWU3Jx5JIYNTINJUih7PMYV98Za50ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731302976; c=relaxed/simple;
	bh=P6D6l9tIzaDkoKCediE0RXRcJsoDvk5isylU++idoSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJaXkJ5/NP9URDyqDygOT35143EjmcAT+4KCmwtoQr4NSAB2gAdqs25hcrkt8dijWpcCJVu4iTBVofcE3fru31FEjCVaws6QL4mt96YNSL9jvtQheou0QST0X1sSixBN95B/SrSgCeHD8AY4JJHHpXmYkPJOQd+7BPCvcNwSmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XXlnRAkY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H1ceS6cF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731302967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grb9aOUGCsu6mcDNoSN/gkNhsRCas0ib6KwPI7nk4FA=;
	b=XXlnRAkYlPVACNRguJXIrDposY+MUeXt57gYG5tRio6dBV9h3kR2PP7lYUS/qu+qxe4nB/
	X+Nfr5Ra/uE0/XFnjl4zF7dDioPOq3Uj7my47VNK3bJaEeVSE5xXbyQbaMTA00y4BlahUm
	vUakXmHNgx+ahTYNs9N7DaiUguOaW5Yx69zou8QPG25U+g/v80T4CVwSyAMJRathlJ2Vkd
	sAM1TA683J2iUg9JxSOM2cGDZMgYwbvHXFsxuEL/9o5/cSPFkUcTutcUHxsOw74Fp2V1Zh
	/lSwwCw7uNbte3/AtMektuMcgErLi1L8ggDpihwyseaANAZSC1YLP6r9JPQlmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731302967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grb9aOUGCsu6mcDNoSN/gkNhsRCas0ib6KwPI7nk4FA=;
	b=H1ceS6cFUa2x7L3fHUk/lLHshC+1BVHKx0RazVaKKne4pDnAwrW2jhoyM0K3QQuwt+n9us
	bUVWmu6IljPRUHAQ==
Date: Mon, 11 Nov 2024 06:29:19 +0100
Subject: [PATCH v2 2/3] kunit: tool: Allow overriding the shutdown mode
 from qemu config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-kunit-loongarch-v2-2-7676eb5f2da3@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731302965; l=1344;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=P6D6l9tIzaDkoKCediE0RXRcJsoDvk5isylU++idoSs=;
 b=mMfwECAWvFLsyIK0n/CuzsOkuGleKWWsbqJHUisaJBxE3SWokzepWr2yzi3JrQo+EV8NYgHSQ
 iViiiHs5K9ODu3usSykpKakqb/hXcAjLds3C4VuLiyOk9MQLEqXYnBh
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Not all platforms support machine reboot.
If it a proper reboot is not supported the machine will hang.
Allow the QEMU configuration to override the necessary shutdown mode for
the specific system under test.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 61931c4926fd6645f2c62dd13f9842a432ec4167..e76d7894b6c5195ece49f0d8c7ac35130df428a9 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -105,7 +105,9 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._kconfig = qemu_arch_params.kconfig
 		self._qemu_arch = qemu_arch_params.qemu_arch
 		self._kernel_path = qemu_arch_params.kernel_path
-		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
+		self._kernel_command_line = qemu_arch_params.kernel_command_line
+		if 'kunit_shutdown=' not in self._kernel_command_line:
+			self._kernel_command_line += ' kunit_shutdown=reboot'
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
 		self._serial = qemu_arch_params.serial
 

-- 
2.47.0


