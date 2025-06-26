Return-Path: <linux-kselftest+bounces-35815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FBFAE95B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426BC5A7F65
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F2230BEE;
	Thu, 26 Jun 2025 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BZPfXKem";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbHAUoSn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7B2264B8;
	Thu, 26 Jun 2025 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918221; cv=none; b=I+M7sq6qZP1+AYDIN+mRapTbeaDH6r5sp0ftNad1Nbr2esUBrFmC03J3skHCPgvntUzw5jGwDohFMT2AvvhQosZVlnPD2IOiCQCRyecmEGCt2mtwLA80D8HSp2jFLmnQEu6cGkSIEAKS6VYgfgntAK3pKDaRcLjE0T1SZRNVh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918221; c=relaxed/simple;
	bh=VQxsVor9ejvNkW+zMsNv6ylbSNC6UWshMp7dNSJXIGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCBZbfoir/sdPfje+jpfusPScJQm5kwGay+6vSkxg+5EkenNrn16mFdqfuD0CkUC1L+gv2y5PZlfPAdntCUAHMQzRIKwj2CQj5gY+jukFAMc4fbgDVz5FdFS8eEbfZplU7fzNy0OuCFWFppwGuXQlLlLwd52FjJQjM8Xo6ILXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BZPfXKem; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbHAUoSn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Glf9QqUKGXuoDH6daia/H7DqVosWzcrmQsY661kVE2s=;
	b=BZPfXKem4GMLd72sR9kF+JfCnKidqQpdIZIUmKXtGteC8kRiCYgxWo9OT6C4wyVL6swhDd
	km3AmxdnPFTVG+jYbNGhxbnUQJqMRUjVBW+idNjfvaaV0VMn51IJQpnOO3zDM7lItiztaP
	iLk8xK4Kh4h3Rbu+WjMJio2lWcdQF84jKrzkWyZ+YXf6hOQfkIa8akJgSLLs7+oPDy1utE
	V/3BnkQGKYl6vK7XntcFaHTI6tbos2nXJKGxgtxaKLzl32GclaR+rhvhxkbaTzgaAv6Lxe
	KNXIs9RRgPnXna2m8xLi1KtbWENQS9X+k4pp6eFKj6fm9uN9/93gAEnazzyN9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Glf9QqUKGXuoDH6daia/H7DqVosWzcrmQsY661kVE2s=;
	b=kbHAUoSnrWMlRUChL9teVwyAdMmhNZzrCNBCGLIK9guS53cfwvYkdFmGZDU+jv2DD6L55U
	ZH/ovbQx2o/MbCBw==
Date: Thu, 26 Jun 2025 08:10:09 +0200
Subject: [PATCH v4 01/15] kbuild: userprogs: avoid duplication of flags
 inherited from kernel
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-1-48760534fef5@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=1184;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VQxsVor9ejvNkW+zMsNv6ylbSNC6UWshMp7dNSJXIGU=;
 b=DiOoPDI4CefA9sIOkV5GE9zeB3R/ajtwPY4A++qOT427a7uO6gy/mj89YznvhGL79N/TRjUch
 CFGD0XKTgSrDmhjgjLwjeuT4KIwMLcEHCa8/IPDjXul4bISUop78vnc
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
2.50.0


