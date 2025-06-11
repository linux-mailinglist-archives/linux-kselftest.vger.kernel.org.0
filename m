Return-Path: <linux-kselftest+bounces-34655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C47AD4D48
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2791898744
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9C244677;
	Wed, 11 Jun 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqfWria4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RwA/RNJj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F023ABB3;
	Wed, 11 Jun 2025 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627520; cv=none; b=XiLsl2SsQc/OYOs+bqWMJYoLiIQo2oCa0jFD/d7NPfebVSIdhrGdgVGW0vsQ7H/T2FaucBUWf7rcrJJUohv5yFp30qLNmJxk4xJmKm1DSBt4ZkYGQDKDzahjjjFrBZlQtYw57S8yltsZEp30WI3b7nk/lir2ksYrYOpKax0Pfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627520; c=relaxed/simple;
	bh=GN2rs7xDDVc7vTzexjV169ensgRHmJNe+Aa1g92I+yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5OhpbQQSuGe+sXNdGhLT05HMaUsc2U7NQwiNeensqqheWli4nKRQDyG06dTBhZ233yjJnAIDsXgUEnsxpuOMjKagD7IbJgluGxPq5H8TERIxEeElTEQjYj8lfcMv5THciECOdkD108iUrjsI5TVDsD2pWhlz4ejvqQXxqFnyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sqfWria4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RwA/RNJj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw4RctE+kQHvgi29VkPu93qy1QWd5JKnsQyp7snGObQ=;
	b=sqfWria4kP4SOQlx1s0jeMGRs860S4UMdUyhSuujik88VHEcuMnxIlIzeiMySEFDo8/epW
	zWE7I4w886hrw9IKV74YQICqYDtk4ZljmNT/3k3hZX5EHJRW8x/MRK8b6Pv0D6yqkk0Lnk
	RzZVc0SuQnyBP0O82sAcl7gImdhtMDf9QmBbtoVcBuZqSZwaoyDWICKSBvAnRfC+gKvslq
	j00F6hpjjcCYg79YCcUhI6i+BB3qjnt4I+HLuAdIi6WWKTuO3bE0Mt5yYRoCIk5bulU5LR
	MNIlWDJP2qjZUMBYnLlWfU8KC31qUcY2jDWuclMq3kFmGC4lsYRMJp64jpu1DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw4RctE+kQHvgi29VkPu93qy1QWd5JKnsQyp7snGObQ=;
	b=RwA/RNJjm6lnqAE+lJMU9c2ShEsZEVzHJ/yZEjQdiKvsS/DNrm2odS9qKdRlhkpVMy7ERE
	MzGpaaEV28jg1FAg==
Date: Wed, 11 Jun 2025 09:38:18 +0200
Subject: [PATCH v3 12/16] kunit: qemu_configs: loongarch: Enable LSX/LSAX
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-12-55e3d148cbc6@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=948;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=GN2rs7xDDVc7vTzexjV169ensgRHmJNe+Aa1g92I+yw=;
 b=ng06gPoY8CuYRAkcYG8/q+yKDYB+VZpGZMcx5yDl1uLNf1fCDkWV7YBZf521G7jCF0zPnjHlX
 9OeH5xEqNjZBWFVvYKUb/B7Ra3JxbP98FF2DZVmzfzvgdNwwTVDCIF0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The upcoming kunit UAPI framework will run userspace executables as part of
kunit. These may use the LSX or LASX instructions.

Make sure the kunit kernel can handle these instructions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/loongarch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
index a92422967d1da9f1658ef1e80d0d7365ddbae307..1dba755284f11ffc94d8946105b0cfa49cb6f604 100644
--- a/tools/testing/kunit/qemu_configs/loongarch.py
+++ b/tools/testing/kunit/qemu_configs/loongarch.py
@@ -11,6 +11,8 @@ CONFIG_PVPANIC_PCI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_CPU_HAS_LSX=y
+CONFIG_CPU_HAS_LASX=y
 ''',
 			   qemu_arch='loongarch64',
 			   kernel_path='arch/loongarch/boot/vmlinux.elf',

-- 
2.49.0


