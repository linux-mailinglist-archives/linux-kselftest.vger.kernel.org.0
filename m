Return-Path: <linux-kselftest+bounces-34644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7973BAD4D13
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87BB17BB0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F099233721;
	Wed, 11 Jun 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JG84CNXx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9cqj5Qwe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B3231821;
	Wed, 11 Jun 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627515; cv=none; b=GfXCIzYcgw8/xfpuV04oWN+UY4Kd5lwD3uZPE0BqfTC93JP8UnPi03CaBVaVm8V76ugV7sb3ABsw6HjElXXZYCBaTuVopLU/pb6BgKinM4cxTjINCrULbxiMeIOOGxSLxDOxCtL1wJyVgRPxQ6v60oxY5AVi6rUjvVY+UlwXG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627515; c=relaxed/simple;
	bh=XUXHouC/V1vE5vzsV6IGUS5rVrpbLkz4GlNe4NCYMuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrDLCuVBdC1x2VpRM3p8h+8phZVXeHtikZC7i1Xmn6ZOO0r0aVaJPCTLJFalzEJdMAEzr1GEM+WGYHUp1UP6VjPQspoG3WSlBc38xJA78W9+jhV4AwGkJdQApnT5cGPqMxYz8UUXwPJrvkgpEyeSYdFZiPVvQ++1aIl/gJcTob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JG84CNXx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9cqj5Qwe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2u/MNcTEWtPCOXtSTAERzN55pAfd3jSntXhox37eg4=;
	b=JG84CNXxEHRsSVKOmQLNgCzjoI5gPN/8X4LtxSRWz3wzUwmcJLzGZJStGsPQG9JoKW0qbk
	Ffd+9bePN/Odd5wxn6E5vpBfyokFPXWf0Logy/p673kxTR3gDdnt1yXHazdyqR+0f+nUVf
	w2GZ7MFSAiOkK/uR6yArp3vkwuHfgoo1dLi88mOQg0f3bf0/1WkSUtprgMpUJbpWx5ozUo
	DNRUmJgKwhyPdsiGijhKdKMKTs5Lr7UAVGuFx+FzgcE5egEBNZBN6EbayqHnWIJpEOSBo3
	jWBXOmQ7j2CxtNa7ETDM/Wm65yY7cQFfDTshlB2reC65a2+R/7M1kYFEb6p1QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2u/MNcTEWtPCOXtSTAERzN55pAfd3jSntXhox37eg4=;
	b=9cqj5QweBA3hvlLfbrd+D5Gn5vEdLhgkeGKdtunUukTdZCP9+qdhoXdKFZ2zHMMqAwopDR
	D0SRYDm7X0/5kcBg==
Date: Wed, 11 Jun 2025 09:38:07 +0200
Subject: [PATCH v3 01/16] kbuild: userprogs: avoid duplicating of flags
 inherited from kernel
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-1-55e3d148cbc6@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=1184;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XUXHouC/V1vE5vzsV6IGUS5rVrpbLkz4GlNe4NCYMuc=;
 b=4WFKI9mAgKXVxy5ZlX5DrLBu5OxdhJcH3eywwL778enAQRfUaFirPc8B2cBuy7NfaZ9PJ4xRC
 0N8Px9pM2xPCWzNhf0I2stFC0evHCo46puDQ1Twoqy3FkNtzwFCMXM/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The duplication makes maintenance harder. Changes need to be done in two
places and the lines will grow overly long.

Use an intermediary variable instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 35e6e5240c61a8a329011929fcd0352b881dccdc..c4293cf91e968ca8ee64452841fb266e24df63f6 100644
--- a/Makefile
+++ b/Makefile
@@ -1130,8 +1130,9 @@ LDFLAGS_vmlinux	+= --emit-relocs --discard-none
 endif
 
 # Align the bit size of userspace programs with the kernel
-KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
-KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+USERFLAGS_FROM_KERNEL := -m32 -m64 --target=%
+KBUILD_USERCFLAGS  += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+KBUILD_USERLDFLAGS += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)

-- 
2.49.0


