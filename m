Return-Path: <linux-kselftest+bounces-30223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16436A7D6AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCF7422E6C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE2226CEE;
	Mon,  7 Apr 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5Yx9uzH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S3nDxtOX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925D22425C;
	Mon,  7 Apr 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011782; cv=none; b=suR2tGCCCIHLR8qrnFXTBMedvyMipRLAOD36yXMsn9Wjl//nP+aksw7j6AbqlMYbnAqG/yisbPjII+n9DUcQ7ujuxQ4lr/3V59rZeHIhiaicBk9yeKRdYoi2b1gaSz2tjme9uhCOQaagEvGGIV+FbA/qheaSAPEp9R4m9ekjwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011782; c=relaxed/simple;
	bh=jxO3E6fY/cRCojmRh56m84xcozUfNDAYCPH6toOUjVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qokXdZfelpOuqUfaMpFDIlvDJLp78K+0WV8+uq3opDnl1U5y+7vzxzJ8jHvY4I7e9OrjyMO54+5YLUD1K4wCEgFjjolqLFm0GeuCl4OvmlETsBa8MXgl3WvupCnTkFKIYnDZLTCsS6XliLoPoisI5ar9sq6WucLSRlr7nEVO06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z5Yx9uzH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S3nDxtOX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71yX+dxuZgcMiLhYB0nVTc9ZvKb7jxerOTVN6LgpvkU=;
	b=z5Yx9uzHqdbvEg81aFKO0Z2AKopLGyzT6tN5p6C+YuVw8+yh4aMeBMjFq8F24hH/4V1ndT
	jmztDArKwytIE1m9+7vaD9+eKF5HBWuZ8xEg5YzM9BLJ+pgkudHY4i7JLfcJEfMVMu8jDY
	g5wiL5xFq65+tKMg1ydHaTHFD34i41YKxGgYwzrwGZW2qsPm7xnwgbRKILzWDvJbz/bp3U
	STiUvBRitKNWnfUxDLag0RPKZ6D+XFUOdmXc/pBiduN3BBr4ucDNaIWbJOMizWnTxwwF5A
	ra7fVhaiYhxB7GuOHW+b70eq2s5jklZyqMoKcUIQHFi/tZRacWTaJkv1PN+k3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71yX+dxuZgcMiLhYB0nVTc9ZvKb7jxerOTVN6LgpvkU=;
	b=S3nDxtOXUie7rH30tDNH1w7jDgiKUn44PWhU5pzVN1QgRlD3plAb9rB43+pGbRiXuTSBWc
	0+6pGiMyJ+C9sNAg==
Date: Mon, 07 Apr 2025 09:42:38 +0200
Subject: [PATCH v2 01/11] kbuild: userprogs: add nolibc support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-1-454114e287fd@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
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
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=3510;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jxO3E6fY/cRCojmRh56m84xcozUfNDAYCPH6toOUjVU=;
 b=2YBONPJ+hWofM0Hneh5fSQgoKjbNUqWD/nQZU1IP/AdEfOq4UA6LhG176h1joDjTNVuSLSZLy
 IYK7pKi5tkIDiVvpeC/ZayKFGgupPDPzH4f1EyMQdwLl44oBDF0zWl0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Userprogs are built with the regular kernel compiler $CC.
A kernel compiler does not necessarily contain a libc which is required
for a normal userspace application.
However the kernel tree does contain a minimal libc implementation
"nolibc" which can be used to build userspace applications.

Introduce support to build userprogs against nolibc instead of the
default libc of the compiler, which may not exist.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
This could probably be moved out of the generic kbuild makefiles.
I think the ergonimics would suffer and this functionality could be
used by other users of userprogs.

Also this does currently not support out-of-tree builds.
For that tools/include/nolibc/*.h and usr/include/*.h would need to be
installed into the build directory.
---
 Documentation/kbuild/makefiles.rst | 12 ++++++++++++
 scripts/Makefile.userprogs         | 16 +++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 3b9a8bc671e2e92126857059e985d6e5b2c43fd4..f905a6f77c965311c491cfd7ab3103185af7e82e 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -970,6 +970,18 @@ When linking bpfilter_umh, it will be passed the extra option -static.
 
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
index f3a7e1ef3753b54303718fae97f4b3c9d4eac07c..a1447c02b948901631098b585f5cf4d3ea383a57 100644
--- a/scripts/Makefile.userprogs
+++ b/scripts/Makefile.userprogs
@@ -16,10 +16,20 @@ user-csingle	:= $(addprefix $(obj)/, $(user-csingle))
 user-cmulti	:= $(addprefix $(obj)/, $(user-cmulti))
 user-cobjs	:= $(addprefix $(obj)/, $(user-cobjs))
 
+user-libgcc     := $(call try-run,$(CC) -Werror $(KBUILD_USERCFLAGS) -lgcc -x c -shared /dev/null -o "$$TMP",-lgcc)
+
+user_nolibc_ccflags := -nostdlib -nostdinc -static -fno-ident -fno-asynchronous-unwind-tables \
+		      -ffreestanding -fno-stack-protector \
+		      -isystem $(objtree)/usr/include -include $(srctree)/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc/
+user_nolibc_ldflags := -nostdlib -nostdinc -static
+user_nolibc_ldlibs  := $(user-libgcc)
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
 
 # Create an executable from a single .c file
 quiet_cmd_user_cc_c = CC [U]  $@

-- 
2.49.0


