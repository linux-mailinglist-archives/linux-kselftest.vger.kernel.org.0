Return-Path: <linux-kselftest+bounces-26765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C3A38117
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597453A8FDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDA9219A6E;
	Mon, 17 Feb 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSkADrC5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6gweMfS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93F21858A;
	Mon, 17 Feb 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790041; cv=none; b=aYNd2HWG1C4CMviRgpSjPrJR3XVVabGj4hxOO+7wLe48bkNbr1pQDo3T5jGOaDf0u2RhsvQviQvtbNKtmysZuRv6q3aVVLWzBs0RkNN7qMt7PtVVtZbtDL70PQK/tzSuaQDT9zWxsrgAKssCOG1RZwQU1VDXqNQF5kdgz5dU9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790041; c=relaxed/simple;
	bh=HWe5DWDc72q/BUdcqdWY+r3rAD8bWdOAs1/PuV4Pfm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UZN8NHPfV5ArzrBKwmoHlKjMJkf8y1pIhuH5vS2tilnqkD7EEzUfbzQ/R2daBYs5A9oWlfce6hYHwrwWil7yglH8H0dqfBTB49hTd2cX0UmQjZcqCE2uh7/BVcWkOD3d/DdORJcarRvHiujS1Se11DcVW/TPfCVJQDsWbFVUjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSkADrC5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6gweMfS6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3mOz7h/METJtenXacdJtpoIbaKepOmdU2Mg3BGzeKc=;
	b=zSkADrC5IegnOX7SsPv69/QD6W6GOarq3AZlGer2Qv1/IxrTtAGj2tHYBeO6AoL8R52hwu
	v1pKuK4TXPwDc6b42hUCnztyomq1HFMCAXvRO5bVhyHSvETW7JOwi8SDSyyYmuPiXmKiI8
	vVY6BbZbTxpCAGg1cIdbRoDkRtYwjmqFilm+V3q73t1MfY3l0VIpmkaOW8ysxR4ks17WuB
	Ix37y36ExVBWoHFAL3K6SDPMVtAuemIM5NrZw6X1WMQssSByCBtLqbbXoOudIc9Uwq3GFx
	MwZcY1FiIP8RBc1bfmCtdOY96UjDvQ+T9pxTR8at6qj3jrEUZIxgd+A2/Jtseg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3mOz7h/METJtenXacdJtpoIbaKepOmdU2Mg3BGzeKc=;
	b=6gweMfS6ZDrqvYxW6P8kn4DX8lRS85SUqJxdBpaUapk4rbYjuI/Wlm1NY3BR05bAsJEHZZ
	xziR9bz1jt/IYNCA==
Date: Mon, 17 Feb 2025 11:59:24 +0100
Subject: [PATCH 04/12] kbuild: userprogs: add nolibc support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-4-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=3223;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HWe5DWDc72q/BUdcqdWY+r3rAD8bWdOAs1/PuV4Pfm0=;
 b=j5buKJ4rrEz2ldxRKjQ4EpttQPLf4EfeYRomTllmD/oqWMo/iVu0yTAc2Tf5lDPH8vBmMsjnS
 qzB/K2tGoJbA6hjQS2M1Crs3OrfPQM77o1deNu9AecBT5pNvHEKXahl
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Userprogs are built with the regular kernel compiler $CC.
A kernel compiler does not necessarily contain a libc which is required
for a normal userspace application.
However the kernel tree does contain a minimal libc implementation
"nolibc" which can be used to build userspace applications.

Introduce support to build userprogs against nolibc instead of the
default C of the compiler, which may not exist.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
This could probably be moved out of the generic kbuild makefiles.
I think the ergonimics would suffer and this functionality could be
used by other users of userprogs.
---
 Documentation/kbuild/makefiles.rst | 12 ++++++++++++
 scripts/Makefile.userprogs         | 14 +++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index d36519f194dc0d18b72a6f3ce7f3649f7c1b5637..cb859dc58b579def4995a5aa2efb45ab4ba3c93f 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -959,6 +959,18 @@ When linking bpfilter_umh, it will be passed the extra option -static.
 
 From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
 
+Bulding userprogs against nolibc
+--------------------------------
+
+Not all kernel toolchains provide a libc.
+Simple userprogs can be built against a very simple libc call "nolibc" provided
+by the kernel source tree.
+
+Example::
+
+  # lib/kunit/Makefile
+  uapi-preinit-nolibc := $(CONFIG_ARCH_HAS_NOLIBC)
+
 When userspace programs are actually built
 ------------------------------------------
 
diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
index debbf083bcfa01c89c204a322a1b17e2bdbe95a1..e94f3f2250f531dadbe00f5f5ee6f780bee22487 100644
--- a/scripts/Makefile.userprogs
+++ b/scripts/Makefile.userprogs
@@ -16,10 +16,18 @@ user-csingle	:= $(addprefix $(obj)/, $(user-csingle))
 user-cmulti	:= $(addprefix $(obj)/, $(user-cmulti))
 user-cobjs	:= $(addprefix $(obj)/, $(user-cobjs))
 
+user_nolibc_ccflags := -nostdlib -nostdinc -static -fno-ident -fno-asynchronous-unwind-tables \
+		      -ffreestanding $(call cc-option,-mstack-protector-guard=global) \
+		      -isystem $(objtree)/usr/include -include $(srctree)/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc/
+user_nolibc_ldflags := -nostdlib -nostdinc -static
+user_nolibc_ldlibs  := $(call cc-option,-lgcc)
+
 user_ccflags	= -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
-			$($(target-stem)-userccflags)
-user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags)
-user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs)
+			$($(target-stem)-userccflags) $(if $($(target-stem)-nolibc),$(user_nolibc_ccflags))
+user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags) \
+			$(if $($(target-stem)-nolibc),$(user_nolibc_ldflags))
+user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs) \
+			$(if $($(target-stem)-nolibc),$(user_nolibc_ldlibs))
 
 ifdef CONFIG_WERROR
 KBUILD_USERCFLAGS += -Werror

-- 
2.48.1


