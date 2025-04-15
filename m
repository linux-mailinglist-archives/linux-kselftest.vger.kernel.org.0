Return-Path: <linux-kselftest+bounces-30836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C9A897C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7407A27F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104112820C4;
	Tue, 15 Apr 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2WjtdN2N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUf7dC5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F865205AA3;
	Tue, 15 Apr 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708995; cv=none; b=JpMmwvqyNTgQVSjoO+yekSadFTfOPF4wB8h7VyUoQpDhPR0bK5Ct+UnyzcgiwRw2wcbuHpM0buIW+s+/58C0r0aHjB1FNtn3LCezqvrgo3j72HE440DsiOpgFkVgGlEcW33iiXQR6n0flsh/v/NHFPzWs7LaybEST1z2wrB4WOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708995; c=relaxed/simple;
	bh=TJqN96xHlwWpHAj40+f8ubD0jRlrEZSQiEvLSgLnRnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajd7b85QmMO9NAGir8fd7OJWjbxtdGdEzx/W3V/rMtGzkBPOJ+kWsoBex/F4EMMaANyO4IZt7B0gibphVGDfoKQIdxjqfIN28H318upuaay2m9doj8QAzknW6GXwirgeWXXeBODRxmX9UYi6yitlsr84C7mAnbMuSKZONJK8F3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2WjtdN2N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUf7dC5S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744708991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7fZw+BOYIpet5ZyYUxU9h0YO1rlpEBBryBTuc3bchE=;
	b=2WjtdN2NWSgz9NymkGLMddVlYRVcdgmvsfxA9DAqN4r2T2+PjfnS5kmqdaZS5l2gnE0xCI
	REm7dC3aodP8AXVkoxd0lmj45Px1YMqwt6p0XcbuOzsQ5wVWPCPhtjthD3z2hLaPEfepFj
	bwmwhhOV8A3nQuuI3iWTK9uGfDiA5iZ/nK17+L5Q6iYOQ+ThMpsb+U7Ruhww4ClYMgatCK
	rek5DcBHJnovrjd+FK1hOtP649LsFurvu6cfzfPpMUK4qgOOygNNCC/dLv0AXVocTm0p9p
	hEbjtN4rN5/vs4GnGy/HuvhnFFEPDJv+U6SuoVNilZsMsjENSRgHvj1LezhGNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744708991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7fZw+BOYIpet5ZyYUxU9h0YO1rlpEBBryBTuc3bchE=;
	b=rUf7dC5SLnYcoFvGNbgjp0MNbF6T7pfCIedmPRLdiuJr+FCRQ85hNTbhyAuqqWdJAutrFu
	gWpEiSS1Fd3sphBQ==
Date: Tue, 15 Apr 2025 11:23:05 +0200
Subject: [PATCH 1/2] kunit: qemu_configs: powerpc: Explicitly enable
 CONFIG_CPU_BIG_ENDIAN=y
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-kunit-ppc-v1-1-f5a170264147@linutronix.de>
References: <20250415-kunit-ppc-v1-0-f5a170264147@linutronix.de>
In-Reply-To: <20250415-kunit-ppc-v1-0-f5a170264147@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744708989; l=946;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TJqN96xHlwWpHAj40+f8ubD0jRlrEZSQiEvLSgLnRnI=;
 b=G4/w2TyQMkx8cbiZU3DyKODCRaOvQ0NuwvxLtDu4Bduxs7wcUV58gEeomESQdLmRKtLltjShn
 h6BiyO9QPGnD8eMds9MlMx8w+C7uyMyvcEb6cQrzq7YoxITmO0N48M+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The configuration generated by kunit ends up with big endian.
A new kunit configuration for little endian is to be added.
To make the difference clearer spell out the endianness in the kunit
reference config.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/powerpc.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
index 7ec38d4131f7ec3b95d1ec6e49c60a6945be47c8..5b4c895d5d5a2cbcf7e2b987017cbb9f124dd089 100644
--- a/tools/testing/kunit/qemu_configs/powerpc.py
+++ b/tools/testing/kunit/qemu_configs/powerpc.py
@@ -3,6 +3,7 @@ from ..qemu_config import QemuArchParams
 QEMU_ARCH = QemuArchParams(linux_arch='powerpc',
 			   kconfig='''
 CONFIG_PPC64=y
+CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HVC_CONSOLE=y''',

-- 
2.49.0


