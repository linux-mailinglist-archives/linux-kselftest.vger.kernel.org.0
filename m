Return-Path: <linux-kselftest+bounces-34646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD4AD4D21
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9FA189594F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64CC235347;
	Wed, 11 Jun 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UR9NDson";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPpp0yDP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B221231839;
	Wed, 11 Jun 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627515; cv=none; b=OuFx3kjNG3EI/VnJU8x1e565AXGdRJ/9bEGhAGEKpOizhNggJtx+YqRYRW0xm7NHZq7Z+nT2rCQknrmuReH1uA0cEXYXmCDP7kw4B8bzT9ebDW+0QCpoI3UwCircY2nSwv/V7Ow7hfIEkHRefeqqyZFsuJ1e1dIVAgsZ87X4MR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627515; c=relaxed/simple;
	bh=Ig7VKamiq+jWT99/vdaegByHHqWOv/1lyFWjxVw9lxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbZfax0mjZMki3AF1GFyfZO7mN5/uSzptGTyqxESa9HFCik56Fudt0QIbAfMKJw6tYgwEj7fDTKQ4VAyitC8Id8hHhcCHhoBqUuH6a1rnzIr6sGt4pKJibV0S1jS7O3BXLPjf7xl3/4ML0R8DBZCNTw/MWJs0sN0o/fRFrL5aPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UR9NDson; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lPpp0yDP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcFlZXIPovISI3A0GF02Ptjj0W/JPNuTnnrkTLv4Ues=;
	b=UR9NDson0GcUp9w/XqKsBHuKAcL28/I2N/FmV0wSvcAQlfgDX0kAP5e2Y8bXDsSJBCOX3/
	hAdR9Bp1v+B6HqdzL5DFGwtBV5Fkj9sDGCauNoFzr6CRO4Lr7xUYqsFsqVpZReu6wHiMd0
	T+9FXetbBwxakxr1W3bGJ3lTRW1Zpg2moNCF3zkKgHvmhR4V5c6e041ERx3EWjqXY88cG8
	XIKOwDtiGz0v9BxDWIdQL4O/pSqDk+smRuEqwqU6zl+b1yQFUM3m+AHdFX4Q5uiVN+hZC+
	YpjtOOkqJpX0kUFylEla+mygxgQs+6MWmUjpb2PNUxxFJLRu0jsVwT5QigyhIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcFlZXIPovISI3A0GF02Ptjj0W/JPNuTnnrkTLv4Ues=;
	b=lPpp0yDPR/ocLggWrZd9PXrFmK0KcWsQfHggDzf1NnD9xoU+99dENQNApPI5E6ZJqyrmVM
	AAxin48bL8+sv/Cg==
Date: Wed, 11 Jun 2025 09:38:09 +0200
Subject: [PATCH v3 03/16] init: re-add CONFIG_CC_CAN_LINK_STATIC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-3-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=1194;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Ig7VKamiq+jWT99/vdaegByHHqWOv/1lyFWjxVw9lxo=;
 b=AYcuC+jTyGyu/gvw30+W29owm0QbmOqI2QX2qDN5aSROokvjbuctKzldX5zq8F8/qfXOSlkAB
 uvYR7vYCLITCZZ/j7GNVi1mHnUKBop13J7YE/s9VxXI2p5wq0UHRRFn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For the kunit UAPI functionality this feature is needed.

This reverts commit d1b99cdf22e0 ("init: remove unused CONFIG_CC_CAN_LINK_STATIC")

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 init/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f0854554bbcdf193852cf5c1d2c2accc64f..26cafbad4f1560fb56b4bef31ae29baf54175661 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -87,6 +87,11 @@ config CC_CAN_LINK
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
 
+config CC_CAN_LINK_STATIC
+	bool
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
+
 # Fixed in GCC 14, 13.3, 12.4 and 11.5
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
 config GCC_ASM_GOTO_OUTPUT_BROKEN

-- 
2.49.0


