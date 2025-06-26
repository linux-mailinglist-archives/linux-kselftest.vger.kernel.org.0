Return-Path: <linux-kselftest+bounces-35817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882CAE95C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EE25A8488
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE46238C1E;
	Thu, 26 Jun 2025 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dPJ7WoDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YVeu/r7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F422A1D5;
	Thu, 26 Jun 2025 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918222; cv=none; b=iPagxAqjW/zLRCYSL4kbz/IMpHxZ9t4a3/A89I+bP2mZLR08XFxT219p5IELkB1bWNe4znDB55y5+PKxaNE1COs5WRMxY3OZRTMNv9apw8stDxwV1gBGKHLJkthEyu5FV7H0J7r/sHGQ8sZrIu9WtEZkLqPmQHOB6m+JdTwOUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918222; c=relaxed/simple;
	bh=a+7kBsO/6ZH8nc37PZdREer0Ot+5+WoWMqnBLoalgfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsXzobAsry2CFCFNrXz9vcMhkn4C2URgmdRkA5cibOqS4nRDRjXsQLi9KgBkx4K08SRKILRP+zCCxMCsEo3PKxN4CBNaGXeRWDqJABC7xoYnZDTdkl8Sr4IrFCTKylT8bd5hHrtm3wN4mdKZ2rTgArNB2rIRm76iGkQ47fAZOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dPJ7WoDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YVeu/r7m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1P/cigZmbp0eEaYiCMikiXLu/FLueV3OD0pJokIijk=;
	b=dPJ7WoDUJTsvVpEPKQozFiU2R3hUW7mf06fKPQE84oiH061KN39V2bThDkIN0aTlQNqXHq
	N0n6sLh7sg5JUBCBowVeKgy3KH36lMAXtNm8nmI3MIHvS2gF0U5yyIwYJuf0tsPkBJYUtp
	qwA5B/m/2t/TtUpUMzNo916FlE/+crTl1JomUYZMPXs04TRNxxNANP4Hu42PILJVJmlhox
	rxchWjaLFPSD8yflKUYFBw9KGvdOpwAenGCgh89gr19H68MRCCq62tHAh1BX6BbUzI/DDF
	/xd0AMov9OSmxKnsopK47Du9+MOkDqLRRdOEyxDprHtCzeUgT4xmaXc+8DFxdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1P/cigZmbp0eEaYiCMikiXLu/FLueV3OD0pJokIijk=;
	b=YVeu/r7mUMmk9XxjlZ1ZCx8GHrd9FM/of0QLJahaTZdxkfLMYSHvIzpH/P6/y1svd4lZaf
	iuOcedoMmFnHmXAg==
Date: Thu, 26 Jun 2025 08:10:10 +0200
Subject: [PATCH v4 02/15] kbuild: userprogs: also inherit byte order and
 ABI from kernel
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-2-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=1177;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=a+7kBsO/6ZH8nc37PZdREer0Ot+5+WoWMqnBLoalgfI=;
 b=13VojceL40ISXBegrEipheICPgswj4vbH+4wycxWWZf1MrEguMSldecKHDktTIA2XogViCz6e
 6w669MXsofgAXL7cb3G0VD+4etyheLp7ONrAyKYoR5hmbADgChKXM5H
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make sure the byte order and ABI of the userprogs matches the one of the
kernel, similar to how the bit size is handled.
Otherwise the userprogs may not be executable.
This happens for example on powerpc little endian, or riscv32.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c4293cf91e968ca8ee64452841fb266e24df63f6..b9aa1058321dabd3b3dd5610e45a2807dfa257f4 100644
--- a/Makefile
+++ b/Makefile
@@ -1129,8 +1129,8 @@ ifneq ($(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS),)
 LDFLAGS_vmlinux	+= --emit-relocs --discard-none
 endif
 
-# Align the bit size of userspace programs with the kernel
-USERFLAGS_FROM_KERNEL := -m32 -m64 --target=%
+# Align the bit size, byte order and architecture of userspace programs with the kernel
+USERFLAGS_FROM_KERNEL := -m32 -m64 -mlittle-endian -mbig-endian --target=% -march=% -mabi=%
 KBUILD_USERCFLAGS  += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 KBUILD_USERLDFLAGS += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 

-- 
2.50.0


